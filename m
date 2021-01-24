Return-Path: virtio-dev-return-7948-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDB07985DFF
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Jan 2021 16:54:39 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sun, 24 Jan 2021 17:54:03 +0100
Message-ID: <20210124165408.1122868-5-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 4/9] ALSA: virtio: build PCM devices and substream hardware descriptors
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Like the HDA specification, the virtio sound device specification links
PCM substreams, jacks and PCM channel maps into functional groups. For
each discovered group, a PCM device is created, the number of which
coincides with the group number.

Introduce the module parameters for setting the hardware buffer
parameters:
  pcm_buffer_ms [=3D160]
  pcm_periods_min [=3D2]
  pcm_periods_max [=3D16]
  pcm_period_ms_min [=3D10]
  pcm_period_ms_max [=3D80]

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile      |   3 +-
 sound/virtio/virtio_card.c |  45 ++++
 sound/virtio/virtio_card.h |   9 +
 sound/virtio/virtio_pcm.c  | 536 +++++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h  |  89 ++++++
 5 files changed, 681 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/virtio_pcm.c
 create mode 100644 sound/virtio/virtio_pcm.h

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index dc551e637441..69162a545a41 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_SND_VIRTIO) +=3D virtio_snd.o
=20
 virtio_snd-objs :=3D \
 =09virtio_card.o \
-=09virtio_ctl_msg.o
+=09virtio_ctl_msg.o \
+=09virtio_pcm.o
=20
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 955eadc2d858..39fe13b43dd1 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -92,6 +92,17 @@ static void virtsnd_event_notify_cb(struct virtqueue *vq=
ueue)
 =09=09=09if (!event)
 =09=09=09=09break;
=20
+=09=09=09switch (le32_to_cpu(event->hdr.code)) {
+=09=09=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
+=09=09=09case VIRTIO_SND_EVT_PCM_XRUN: {
+=09=09=09=09virtsnd_pcm_event(snd, event);
+=09=09=09=09break;
+=09=09=09}
+=09=09=09default: {
+=09=09=09=09break;
+=09=09=09}
+=09=09=09}
+
 =09=09=09virtsnd_event_send(queue->vqueue, event, true,
 =09=09=09=09=09   GFP_ATOMIC);
 =09=09}
@@ -274,6 +285,16 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 =09strscpy(snd->card->longname, "VirtIO Sound Card",
 =09=09sizeof(snd->card->longname));
=20
+=09rc =3D virtsnd_pcm_parse_cfg(snd);
+=09if (rc)
+=09=09return rc;
+
+=09if (snd->nsubstreams) {
+=09=09rc =3D virtsnd_pcm_build_devs(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
 =09return snd_card_register(snd->card);
 }
=20
@@ -302,6 +323,9 @@ static int virtsnd_validate(struct virtio_device *vdev)
 =09=09return -EINVAL;
 =09}
=20
+=09if (virtsnd_pcm_validate(vdev))
+=09=09return -EINVAL;
+
 =09return 0;
 }
=20
@@ -325,6 +349,7 @@ static int virtsnd_probe(struct virtio_device *vdev)
 =09snd->vdev =3D vdev;
 =09INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
 =09INIT_LIST_HEAD(&snd->ctl_msgs);
+=09INIT_LIST_HEAD(&snd->pcm_list);
=20
 =09vdev->priv =3D snd;
=20
@@ -359,6 +384,8 @@ static int virtsnd_probe(struct virtio_device *vdev)
 static void virtsnd_remove(struct virtio_device *vdev)
 {
 =09struct virtio_snd *snd =3D vdev->priv;
+=09struct virtio_pcm *pcm;
+=09struct virtio_pcm *pcm_next;
=20
 =09if (!snd)
 =09=09return;
@@ -376,6 +403,24 @@ static void virtsnd_remove(struct virtio_device *vdev)
 =09vdev->config->reset(vdev);
 =09vdev->config->del_vqs(vdev);
=20
+=09list_for_each_entry_safe(pcm, pcm_next, &snd->pcm_list, list) {
+=09=09unsigned int i;
+
+=09=09list_del(&pcm->list);
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &pcm->streams[i];
+
+=09=09=09if (stream->substreams)
+=09=09=09=09devm_kfree(&vdev->dev, stream->substreams);
+=09=09}
+
+=09=09devm_kfree(&vdev->dev, pcm);
+=09}
+
+=09if (snd->substreams)
+=09=09devm_kfree(&vdev->dev, snd->substreams);
+
 =09devm_kfree(&vdev->dev, snd);
=20
 =09vdev->priv =3D NULL;
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 37b734a92134..be6651a6aaf8 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -24,6 +24,9 @@
 #include <uapi/linux/virtio_snd.h>
=20
 #include "virtio_ctl_msg.h"
+#include "virtio_pcm.h"
+
+struct virtio_pcm_substream;
=20
 /**
  * struct virtio_snd_queue - Virtqueue wrapper structure.
@@ -43,6 +46,9 @@ struct virtio_snd_queue {
  * @card: ALSA sound card.
  * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
+ * @pcm_list: VirtIO PCM device list.
+ * @substreams: VirtIO PCM substreams.
+ * @nsubstreams: Number of PCM substreams.
  */
 struct virtio_snd {
 =09struct virtio_device *vdev;
@@ -51,6 +57,9 @@ struct virtio_snd {
 =09struct snd_card *card;
 =09struct list_head ctl_msgs;
 =09struct virtio_snd_event *event_msgs;
+=09struct list_head pcm_list;
+=09struct virtio_pcm_substream *substreams;
+=09unsigned int nsubstreams;
 };
=20
 /* Message completion timeout in milliseconds (module parameter). */
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
new file mode 100644
index 000000000000..036990b7b78a
--- /dev/null
+++ b/sound/virtio/virtio_pcm.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+static unsigned int pcm_buffer_ms =3D 160;
+module_param(pcm_buffer_ms, uint, 0644);
+MODULE_PARM_DESC(pcm_buffer_ms, "PCM substream buffer time in milliseconds=
");
+
+static unsigned int pcm_periods_min =3D 2;
+module_param(pcm_periods_min, uint, 0644);
+MODULE_PARM_DESC(pcm_periods_min, "Minimum number of PCM periods");
+
+static unsigned int pcm_periods_max =3D 16;
+module_param(pcm_periods_max, uint, 0644);
+MODULE_PARM_DESC(pcm_periods_max, "Maximum number of PCM periods");
+
+static unsigned int pcm_period_ms_min =3D 10;
+module_param(pcm_period_ms_min, uint, 0644);
+MODULE_PARM_DESC(pcm_period_ms_min, "Minimum PCM period time in millisecon=
ds");
+
+static unsigned int pcm_period_ms_max =3D 80;
+module_param(pcm_period_ms_max, uint, 0644);
+MODULE_PARM_DESC(pcm_period_ms_max, "Maximum PCM period time in millisecon=
ds");
+
+/* Map for converting VirtIO format to ALSA format. */
+static const unsigned int g_v2a_format_map[] =3D {
+=09[VIRTIO_SND_PCM_FMT_IMA_ADPCM] =3D SNDRV_PCM_FORMAT_IMA_ADPCM,
+=09[VIRTIO_SND_PCM_FMT_MU_LAW] =3D SNDRV_PCM_FORMAT_MU_LAW,
+=09[VIRTIO_SND_PCM_FMT_A_LAW] =3D SNDRV_PCM_FORMAT_A_LAW,
+=09[VIRTIO_SND_PCM_FMT_S8] =3D SNDRV_PCM_FORMAT_S8,
+=09[VIRTIO_SND_PCM_FMT_U8] =3D SNDRV_PCM_FORMAT_U8,
+=09[VIRTIO_SND_PCM_FMT_S16] =3D SNDRV_PCM_FORMAT_S16_LE,
+=09[VIRTIO_SND_PCM_FMT_U16] =3D SNDRV_PCM_FORMAT_U16_LE,
+=09[VIRTIO_SND_PCM_FMT_S18_3] =3D SNDRV_PCM_FORMAT_S18_3LE,
+=09[VIRTIO_SND_PCM_FMT_U18_3] =3D SNDRV_PCM_FORMAT_U18_3LE,
+=09[VIRTIO_SND_PCM_FMT_S20_3] =3D SNDRV_PCM_FORMAT_S20_3LE,
+=09[VIRTIO_SND_PCM_FMT_U20_3] =3D SNDRV_PCM_FORMAT_U20_3LE,
+=09[VIRTIO_SND_PCM_FMT_S24_3] =3D SNDRV_PCM_FORMAT_S24_3LE,
+=09[VIRTIO_SND_PCM_FMT_U24_3] =3D SNDRV_PCM_FORMAT_U24_3LE,
+=09[VIRTIO_SND_PCM_FMT_S20] =3D SNDRV_PCM_FORMAT_S20_LE,
+=09[VIRTIO_SND_PCM_FMT_U20] =3D SNDRV_PCM_FORMAT_U20_LE,
+=09[VIRTIO_SND_PCM_FMT_S24] =3D SNDRV_PCM_FORMAT_S24_LE,
+=09[VIRTIO_SND_PCM_FMT_U24] =3D SNDRV_PCM_FORMAT_U24_LE,
+=09[VIRTIO_SND_PCM_FMT_S32] =3D SNDRV_PCM_FORMAT_S32_LE,
+=09[VIRTIO_SND_PCM_FMT_U32] =3D SNDRV_PCM_FORMAT_U32_LE,
+=09[VIRTIO_SND_PCM_FMT_FLOAT] =3D SNDRV_PCM_FORMAT_FLOAT_LE,
+=09[VIRTIO_SND_PCM_FMT_FLOAT64] =3D SNDRV_PCM_FORMAT_FLOAT64_LE,
+=09[VIRTIO_SND_PCM_FMT_DSD_U8] =3D SNDRV_PCM_FORMAT_DSD_U8,
+=09[VIRTIO_SND_PCM_FMT_DSD_U16] =3D SNDRV_PCM_FORMAT_DSD_U16_LE,
+=09[VIRTIO_SND_PCM_FMT_DSD_U32] =3D SNDRV_PCM_FORMAT_DSD_U32_LE,
+=09[VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME] =3D
+=09=09SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+};
+
+/* Map for converting VirtIO frame rate to ALSA frame rate. */
+struct virtsnd_v2a_rate {
+=09unsigned int alsa_bit;
+=09unsigned int rate;
+};
+
+static const struct virtsnd_v2a_rate g_v2a_rate_map[] =3D {
+=09[VIRTIO_SND_PCM_RATE_5512] =3D { SNDRV_PCM_RATE_5512, 5512 },
+=09[VIRTIO_SND_PCM_RATE_8000] =3D { SNDRV_PCM_RATE_8000, 8000 },
+=09[VIRTIO_SND_PCM_RATE_11025] =3D { SNDRV_PCM_RATE_11025, 11025 },
+=09[VIRTIO_SND_PCM_RATE_16000] =3D { SNDRV_PCM_RATE_16000, 16000 },
+=09[VIRTIO_SND_PCM_RATE_22050] =3D { SNDRV_PCM_RATE_22050, 22050 },
+=09[VIRTIO_SND_PCM_RATE_32000] =3D { SNDRV_PCM_RATE_32000, 32000 },
+=09[VIRTIO_SND_PCM_RATE_44100] =3D { SNDRV_PCM_RATE_44100, 44100 },
+=09[VIRTIO_SND_PCM_RATE_48000] =3D { SNDRV_PCM_RATE_48000, 48000 },
+=09[VIRTIO_SND_PCM_RATE_64000] =3D { SNDRV_PCM_RATE_64000, 64000 },
+=09[VIRTIO_SND_PCM_RATE_88200] =3D { SNDRV_PCM_RATE_88200, 88200 },
+=09[VIRTIO_SND_PCM_RATE_96000] =3D { SNDRV_PCM_RATE_96000, 96000 },
+=09[VIRTIO_SND_PCM_RATE_176400] =3D { SNDRV_PCM_RATE_176400, 176400 },
+=09[VIRTIO_SND_PCM_RATE_192000] =3D { SNDRV_PCM_RATE_192000, 192000 }
+};
+
+/**
+ * virtsnd_pcm_build_hw() - Parse substream config and build HW descriptor=
.
+ * @substream: VirtIO substream.
+ * @info: VirtIO substream information entry.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL if configuration is invalid.
+ */
+static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *substream,
+=09=09=09=09struct virtio_snd_pcm_info *info)
+{
+=09struct virtio_device *vdev =3D substream->snd->vdev;
+=09unsigned int i;
+=09u64 values;
+=09size_t sample_max =3D 0;
+=09size_t sample_min =3D 0;
+
+=09substream->features =3D le32_to_cpu(info->features);
+
+=09/*
+=09 * TODO: set SNDRV_PCM_INFO_{BATCH,BLOCK_TRANSFER} if device supports
+=09 * only message-based transport.
+=09 */
+=09substream->hw.info =3D
+=09=09SNDRV_PCM_INFO_MMAP |
+=09=09SNDRV_PCM_INFO_MMAP_VALID |
+=09=09SNDRV_PCM_INFO_BATCH |
+=09=09SNDRV_PCM_INFO_BLOCK_TRANSFER |
+=09=09SNDRV_PCM_INFO_INTERLEAVED;
+
+=09if (!info->channels_min || info->channels_min > info->channels_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: invalid channel range [%u %u]\n",
+=09=09=09substream->sid, info->channels_min, info->channels_max);
+=09=09return -EINVAL;
+=09}
+
+=09substream->hw.channels_min =3D info->channels_min;
+=09substream->hw.channels_max =3D info->channels_max;
+
+=09values =3D le64_to_cpu(info->formats);
+
+=09substream->hw.formats =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_format_map); ++i)
+=09=09if (values & (1ULL << i)) {
+=09=09=09unsigned int alsa_fmt =3D g_v2a_format_map[i];
+=09=09=09int bytes =3D snd_pcm_format_physical_width(alsa_fmt) / 8;
+
+=09=09=09if (!sample_min || sample_min > bytes)
+=09=09=09=09sample_min =3D bytes;
+
+=09=09=09if (sample_max < bytes)
+=09=09=09=09sample_max =3D bytes;
+
+=09=09=09substream->hw.formats |=3D (1ULL << alsa_fmt);
+=09=09}
+
+=09if (!substream->hw.formats) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: no supported PCM sample formats found\n",
+=09=09=09substream->sid);
+=09=09return -EINVAL;
+=09}
+
+=09values =3D le64_to_cpu(info->rates);
+
+=09substream->hw.rates =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_rate_map); ++i)
+=09=09if (values & (1ULL << i)) {
+=09=09=09if (!substream->hw.rate_min ||
+=09=09=09    substream->hw.rate_min > g_v2a_rate_map[i].rate)
+=09=09=09=09substream->hw.rate_min =3D g_v2a_rate_map[i].rate;
+
+=09=09=09if (substream->hw.rate_max < g_v2a_rate_map[i].rate)
+=09=09=09=09substream->hw.rate_max =3D g_v2a_rate_map[i].rate;
+
+=09=09=09substream->hw.rates |=3D g_v2a_rate_map[i].alsa_bit;
+=09=09}
+
+=09if (!substream->hw.rates) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: no supported PCM frame rates found\n",
+=09=09=09substream->sid);
+=09=09return -EINVAL;
+=09}
+
+=09substream->hw.periods_min =3D pcm_periods_min;
+=09substream->hw.periods_max =3D pcm_periods_max;
+
+=09/*
+=09 * We must ensure that there is enough space in the buffer to store
+=09 * pcm_buffer_ms ms for the combination (Cmax, Smax, Rmax), where:
+=09 *   Cmax =3D maximum supported number of channels,
+=09 *   Smax =3D maximum supported sample size in bytes,
+=09 *   Rmax =3D maximum supported frame rate.
+=09 */
+=09substream->hw.buffer_bytes_max =3D
+=09=09sample_max * substream->hw.channels_max * pcm_buffer_ms *
+=09=09(substream->hw.rate_max / MSEC_PER_SEC);
+
+=09/* Align the buffer size to the page size */
+=09substream->hw.buffer_bytes_max =3D
+=09=09(substream->hw.buffer_bytes_max + PAGE_SIZE - 1) & -PAGE_SIZE;
+
+=09/*
+=09 * We must ensure that the minimum period size is enough to store
+=09 * pcm_period_ms_min ms for the combination (Cmin, Smin, Rmin), where:
+=09 *   Cmin =3D minimum supported number of channels,
+=09 *   Smin =3D minimum supported sample size in bytes,
+=09 *   Rmin =3D minimum supported frame rate.
+=09 */
+=09substream->hw.period_bytes_min =3D
+=09=09sample_min * substream->hw.channels_min * pcm_period_ms_min *
+=09=09(substream->hw.rate_min / MSEC_PER_SEC);
+
+=09/*
+=09 * We must ensure that the maximum period size is enough to store
+=09 * pcm_period_ms_max ms for the combination (Cmax, Smax, Rmax).
+=09 */
+=09substream->hw.period_bytes_max =3D
+=09=09sample_max * substream->hw.channels_max * pcm_period_ms_max *
+=09=09(substream->hw.rate_max / MSEC_PER_SEC);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_prealloc_pages() - Preallocate substream hardware buffer.
+ * @substream: VirtIO substream.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_prealloc_pages(struct virtio_pcm_substream *substre=
am)
+{
+=09struct snd_pcm_substream *ksubstream =3D substream->substream;
+=09size_t size =3D substream->hw.buffer_bytes_max;
+=09struct device *data =3D snd_dma_continuous_data(GFP_KERNEL);
+
+=09/*
+=09 * We just allocate a CONTINUOUS buffer as it should work in any setup.
+=09 *
+=09 * If there is a need to use DEV(_XXX), then add this case here and
+=09 * (probably) update the related source code in other places.
+=09 */
+=09snd_pcm_lib_preallocate_pages(ksubstream, SNDRV_DMA_TYPE_CONTINUOUS,
+=09=09=09=09      data, size, size);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_find() - Find the PCM device for the specified node ID.
+ * @snd: VirtIO sound device.
+ * @nid: Function node ID.
+ *
+ * Context: Any context.
+ * Return: a pointer to the PCM device or ERR_PTR(-ENOENT).
+ */
+struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, unsigned int n=
id)
+{
+=09struct virtio_pcm *pcm;
+
+=09list_for_each_entry(pcm, &snd->pcm_list, list)
+=09=09if (pcm->nid =3D=3D nid)
+=09=09=09return pcm;
+
+=09return ERR_PTR(-ENOENT);
+}
+
+/**
+ * virtsnd_pcm_find_or_create() - Find or create the PCM device for the
+ *                                specified node ID.
+ * @snd: VirtIO sound device.
+ * @nid: Function node ID.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: a pointer to the PCM device or ERR_PTR(-errno).
+ */
+struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd,
+=09=09=09=09=09      unsigned int nid)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_pcm *pcm;
+
+=09pcm =3D virtsnd_pcm_find(snd, nid);
+=09if (!IS_ERR(pcm))
+=09=09return pcm;
+
+=09pcm =3D devm_kzalloc(&vdev->dev, sizeof(*pcm), GFP_KERNEL);
+=09if (!pcm)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09pcm->nid =3D nid;
+=09list_add_tail(&pcm->list, &snd->pcm_list);
+
+=09return pcm;
+}
+
+/**
+ * virtsnd_pcm_validate() - Validate if the device can be started.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL on failure.
+ */
+int virtsnd_pcm_validate(struct virtio_device *vdev)
+{
+=09if (pcm_periods_min < 2 || pcm_periods_min > pcm_periods_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"invalid range [%u %u] of the number of PCM periods\n",
+=09=09=09pcm_periods_min, pcm_periods_max);
+=09=09return -EINVAL;
+=09}
+
+=09if (!pcm_period_ms_min || pcm_period_ms_min > pcm_period_ms_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"invalid range [%u %u] of the size of the PCM period\n",
+=09=09=09pcm_period_ms_min, pcm_period_ms_max);
+=09=09return -EINVAL;
+=09}
+
+=09if (pcm_buffer_ms < pcm_periods_min * pcm_period_ms_min) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"pcm_buffer_ms(=3D%u) value cannot be < %u ms\n",
+=09=09=09pcm_buffer_ms, pcm_periods_min * pcm_period_ms_min);
+=09=09return -EINVAL;
+=09}
+
+=09if (pcm_period_ms_max > pcm_buffer_ms / 2) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"pcm_period_ms_max(=3D%u) value cannot be > %u ms\n",
+=09=09=09pcm_period_ms_max, pcm_buffer_ms / 2);
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_parse_cfg() - Parse the stream configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_pcm_info *info;
+=09unsigned int i;
+=09int rc;
+
+=09virtio_cread(vdev, struct virtio_snd_config, streams,
+=09=09     &snd->nsubstreams);
+=09if (!snd->nsubstreams)
+=09=09return 0;
+
+=09snd->substreams =3D devm_kcalloc(&vdev->dev, snd->nsubstreams,
+=09=09=09=09       sizeof(*snd->substreams), GFP_KERNEL);
+=09if (!snd->substreams)
+=09=09return -ENOMEM;
+
+=09info =3D devm_kcalloc(&vdev->dev, snd->nsubstreams, sizeof(*info),
+=09=09=09    GFP_KERNEL);
+=09if (!info)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_query_info(snd, VIRTIO_SND_R_PCM_INFO, 0,
+=09=09=09=09    snd->nsubstreams, sizeof(*info), info);
+=09if (rc)
+=09=09return rc;
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i) {
+=09=09struct virtio_pcm_substream *substream =3D &snd->substreams[i];
+=09=09struct virtio_pcm *pcm;
+
+=09=09substream->snd =3D snd;
+=09=09substream->sid =3D i;
+
+=09=09rc =3D virtsnd_pcm_build_hw(substream, &info[i]);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09substream->nid =3D le32_to_cpu(info[i].hdr.hda_fn_nid);
+
+=09=09pcm =3D virtsnd_pcm_find_or_create(snd, substream->nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+
+=09=09switch (info[i].direction) {
+=09=09case VIRTIO_SND_D_OUTPUT: {
+=09=09=09substream->direction =3D SNDRV_PCM_STREAM_PLAYBACK;
+=09=09=09break;
+=09=09}
+=09=09case VIRTIO_SND_D_INPUT: {
+=09=09=09substream->direction =3D SNDRV_PCM_STREAM_CAPTURE;
+=09=09=09break;
+=09=09}
+=09=09default: {
+=09=09=09dev_err(&vdev->dev, "SID %u: unknown direction (%u)\n",
+=09=09=09=09substream->sid, info[i].direction);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09}
+
+=09=09pcm->streams[substream->direction].nsubstreams++;
+=09}
+
+=09devm_kfree(&vdev->dev, info);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_build_devs() - Build ALSA PCM devices.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_build_devs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_pcm *pcm;
+=09unsigned int i;
+=09int rc;
+
+=09list_for_each_entry(pcm, &snd->pcm_list, list) {
+=09=09unsigned int npbs =3D
+=09=09=09pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].nsubstreams;
+=09=09unsigned int ncps =3D
+=09=09=09pcm->streams[SNDRV_PCM_STREAM_CAPTURE].nsubstreams;
+
+=09=09if (!npbs && !ncps)
+=09=09=09continue;
+
+=09=09rc =3D snd_pcm_new(snd->card, "virtio_snd", pcm->nid, npbs, ncps,
+=09=09=09=09 &pcm->pcm);
+=09=09if (rc) {
+=09=09=09dev_err(&vdev->dev, "snd_pcm_new[%u] failed: %d\n",
+=09=09=09=09pcm->nid, rc);
+=09=09=09return rc;
+=09=09}
+
+=09=09pcm->pcm->info_flags =3D 0;
+=09=09pcm->pcm->dev_class =3D SNDRV_PCM_CLASS_GENERIC;
+=09=09pcm->pcm->dev_subclass =3D SNDRV_PCM_SUBCLASS_GENERIC_MIX;
+=09=09strscpy(pcm->pcm->name, "VirtIO PCM", sizeof(pcm->pcm->name));
+
+=09=09pcm->pcm->private_data =3D pcm;
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &pcm->streams[i];
+
+=09=09=09if (!stream->nsubstreams)
+=09=09=09=09continue;
+
+=09=09=09stream->substreams =3D
+=09=09=09=09devm_kcalloc(&vdev->dev,
+=09=09=09=09=09     stream->nsubstreams,
+=09=09=09=09=09     sizeof(*stream->substreams),
+=09=09=09=09=09     GFP_KERNEL);
+=09=09=09if (!stream->substreams)
+=09=09=09=09return -ENOMEM;
+
+=09=09=09stream->nsubstreams =3D 0;
+=09=09}
+=09}
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i) {
+=09=09struct virtio_pcm_substream *substream =3D &snd->substreams[i];
+=09=09struct virtio_pcm_stream *stream;
+
+=09=09pcm =3D virtsnd_pcm_find(snd, substream->nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+
+=09=09stream =3D &pcm->streams[substream->direction];
+=09=09stream->substreams[stream->nsubstreams++] =3D substream;
+=09}
+
+=09list_for_each_entry(pcm, &snd->pcm_list, list)
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &pcm->streams[i];
+=09=09=09struct snd_pcm_str *kstream;
+=09=09=09struct snd_pcm_substream *ksubstream;
+
+=09=09=09if (!stream->nsubstreams)
+=09=09=09=09continue;
+
+=09=09=09kstream =3D &pcm->pcm->streams[i];
+=09=09=09ksubstream =3D kstream->substream;
+
+=09=09=09while (ksubstream) {
+=09=09=09=09struct virtio_pcm_substream *substream =3D
+=09=09=09=09=09stream->substreams[ksubstream->number];
+
+=09=09=09=09substream->substream =3D ksubstream;
+=09=09=09=09ksubstream =3D ksubstream->next;
+
+=09=09=09=09rc =3D virtsnd_pcm_prealloc_pages(substream);
+=09=09=09=09if (rc)
+=09=09=09=09=09return rc;
+=09=09=09}
+=09=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_event() - Handle the PCM device event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *ev=
ent)
+{
+=09struct virtio_pcm_substream *substream;
+=09unsigned int sid =3D le32_to_cpu(event->data);
+
+=09if (sid >=3D snd->nsubstreams)
+=09=09return;
+
+=09substream =3D &snd->substreams[sid];
+
+=09switch (le32_to_cpu(event->hdr.code)) {
+=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED: {
+=09=09/* TODO: deal with shmem elapsed period */
+=09=09break;
+=09}
+=09case VIRTIO_SND_EVT_PCM_XRUN: {
+=09=09break;
+=09}
+=09}
+}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
new file mode 100644
index 000000000000..73fb4d9dc524
--- /dev/null
+++ b/sound/virtio/virtio_pcm.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef VIRTIO_SND_PCM_H
+#define VIRTIO_SND_PCM_H
+
+#include <linux/atomic.h>
+#include <linux/virtio_config.h>
+#include <sound/pcm.h>
+
+struct virtio_pcm;
+
+/**
+ * struct virtio_pcm_substream - VirtIO PCM substream.
+ * @snd: VirtIO sound device.
+ * @nid: Function group node identifier.
+ * @sid: Stream identifier.
+ * @direction: Stream data flow direction (SNDRV_PCM_STREAM_XXX).
+ * @features: Stream VirtIO feature bit map (1 << VIRTIO_SND_PCM_F_XXX).
+ * @substream: Kernel ALSA substream.
+ * @hw: Kernel ALSA substream hardware descriptor.
+ */
+struct virtio_pcm_substream {
+=09struct virtio_snd *snd;
+=09unsigned int nid;
+=09unsigned int sid;
+=09u32 direction;
+=09u32 features;
+=09struct snd_pcm_substream *substream;
+=09struct snd_pcm_hardware hw;
+};
+
+/**
+ * struct virtio_pcm_stream - VirtIO PCM stream.
+ * @substreams: Virtio substreams belonging to the stream.
+ * @nsubstreams: Number of substreams.
+ */
+struct virtio_pcm_stream {
+=09struct virtio_pcm_substream **substreams;
+=09unsigned int nsubstreams;
+};
+
+/**
+ * struct virtio_pcm - VirtIO PCM device.
+ * @list: PCM list entry.
+ * @nid: Function group node identifier.
+ * @pcm: Kernel PCM device.
+ * @streams: VirtIO PCM streams (playback and capture).
+ */
+struct virtio_pcm {
+=09struct list_head list;
+=09unsigned int nid;
+=09struct snd_pcm *pcm;
+=09struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
+};
+
+int virtsnd_pcm_validate(struct virtio_device *vdev);
+
+int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_pcm_build_devs(struct virtio_snd *snd);
+
+void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *ev=
ent);
+
+void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue);
+
+void virtsnd_pcm_rx_notify_cb(struct virtqueue *vqueue);
+
+struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, unsigned int n=
id);
+
+struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd,
+=09=09=09=09=09      unsigned int nid);
+
+#endif /* VIRTIO_SND_PCM_H */
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

