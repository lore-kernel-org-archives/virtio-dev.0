Return-Path: virtio-dev-return-8013-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57B0D985E70
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Feb 2021 15:36:07 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Mon, 22 Feb 2021 16:34:39 +0100
Message-ID: <20210222153444.348390-5-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5 4/9] ALSA: virtio: build PCM devices and substream hardware descriptors
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
 sound/virtio/virtio_card.c |  14 ++
 sound/virtio/virtio_card.h |  10 +
 sound/virtio/virtio_pcm.c  | 463 +++++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h  |  70 ++++++
 5 files changed, 559 insertions(+), 1 deletion(-)
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
index c62b3a2da148..235afc25fce7 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -200,6 +200,16 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 =09=09=09 VIRTIO_SND_CARD_NAME " at %s/%s",
 =09=09=09 dev_name(dev->parent), dev_name(dev));
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
@@ -228,6 +238,9 @@ static int virtsnd_validate(struct virtio_device *vdev)
 =09=09return -EINVAL;
 =09}
=20
+=09if (virtsnd_pcm_validate(vdev))
+=09=09return -EINVAL;
+
 =09return 0;
 }
=20
@@ -251,6 +264,7 @@ static int virtsnd_probe(struct virtio_device *vdev)
 =09snd->vdev =3D vdev;
 =09INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
 =09INIT_LIST_HEAD(&snd->ctl_msgs);
+=09INIT_LIST_HEAD(&snd->pcm_list);
=20
 =09vdev->priv =3D snd;
=20
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index c51a71a79388..f5e06a1ec033 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -12,9 +12,13 @@
 #include <uapi/linux/virtio_snd.h>
=20
 #include "virtio_ctl_msg.h"
+#include "virtio_pcm.h"
=20
 #define VIRTIO_SND_CARD_DRIVER=09"virtio-snd"
 #define VIRTIO_SND_CARD_NAME=09"VirtIO SoundCard"
+#define VIRTIO_SND_PCM_NAME=09"VirtIO PCM"
+
+struct virtio_pcm_substream;
=20
 /**
  * struct virtio_snd_queue - Virtqueue wrapper structure.
@@ -34,6 +38,9 @@ struct virtio_snd_queue {
  * @card: ALSA sound card.
  * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
+ * @pcm_list: VirtIO PCM device list.
+ * @substreams: VirtIO PCM substreams.
+ * @nsubstreams: Number of PCM substreams.
  */
 struct virtio_snd {
 =09struct virtio_device *vdev;
@@ -42,6 +49,9 @@ struct virtio_snd {
 =09struct snd_card *card;
 =09struct list_head ctl_msgs;
 =09struct virtio_snd_event *event_msgs;
+=09struct list_head pcm_list;
+=09struct virtio_pcm_substream *substreams;
+=09u32 nsubstreams;
 };
=20
 /* Message completion timeout in milliseconds (module parameter). */
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
new file mode 100644
index 000000000000..4348ead63c14
--- /dev/null
+++ b/sound/virtio/virtio_pcm.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
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
+static const snd_pcm_format_t g_v2a_format_map[] =3D {
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
+ * @vss: VirtIO substream.
+ * @info: VirtIO substream information entry.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL if configuration is invalid.
+ */
+static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
+=09=09=09=09struct virtio_snd_pcm_info *info)
+{
+=09struct virtio_device *vdev =3D vss->snd->vdev;
+=09unsigned int i;
+=09u64 values;
+=09size_t sample_max =3D 0;
+=09size_t sample_min =3D 0;
+
+=09vss->features =3D le32_to_cpu(info->features);
+
+=09/*
+=09 * TODO: set SNDRV_PCM_INFO_{BATCH,BLOCK_TRANSFER} if device supports
+=09 * only message-based transport.
+=09 */
+=09vss->hw.info =3D
+=09=09SNDRV_PCM_INFO_MMAP |
+=09=09SNDRV_PCM_INFO_MMAP_VALID |
+=09=09SNDRV_PCM_INFO_BATCH |
+=09=09SNDRV_PCM_INFO_BLOCK_TRANSFER |
+=09=09SNDRV_PCM_INFO_INTERLEAVED |
+=09=09SNDRV_PCM_INFO_PAUSE;
+
+=09if (!info->channels_min || info->channels_min > info->channels_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: invalid channel range [%u %u]\n",
+=09=09=09vss->sid, info->channels_min, info->channels_max);
+=09=09return -EINVAL;
+=09}
+
+=09vss->hw.channels_min =3D info->channels_min;
+=09vss->hw.channels_max =3D info->channels_max;
+
+=09values =3D le64_to_cpu(info->formats);
+
+=09vss->hw.formats =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_format_map); ++i)
+=09=09if (values & (1ULL << i)) {
+=09=09=09snd_pcm_format_t alsa_fmt =3D g_v2a_format_map[i];
+=09=09=09int bytes =3D snd_pcm_format_physical_width(alsa_fmt) / 8;
+
+=09=09=09if (!sample_min || sample_min > bytes)
+=09=09=09=09sample_min =3D bytes;
+
+=09=09=09if (sample_max < bytes)
+=09=09=09=09sample_max =3D bytes;
+
+=09=09=09vss->hw.formats |=3D (1ULL << (__force int)alsa_fmt);
+=09=09}
+
+=09if (!vss->hw.formats) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: no supported PCM sample formats found\n",
+=09=09=09vss->sid);
+=09=09return -EINVAL;
+=09}
+
+=09values =3D le64_to_cpu(info->rates);
+
+=09vss->hw.rates =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_rate_map); ++i)
+=09=09if (values & (1ULL << i)) {
+=09=09=09if (!vss->hw.rate_min ||
+=09=09=09    vss->hw.rate_min > g_v2a_rate_map[i].rate)
+=09=09=09=09vss->hw.rate_min =3D g_v2a_rate_map[i].rate;
+
+=09=09=09if (vss->hw.rate_max < g_v2a_rate_map[i].rate)
+=09=09=09=09vss->hw.rate_max =3D g_v2a_rate_map[i].rate;
+
+=09=09=09vss->hw.rates |=3D g_v2a_rate_map[i].alsa_bit;
+=09=09}
+
+=09if (!vss->hw.rates) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: no supported PCM frame rates found\n",
+=09=09=09vss->sid);
+=09=09return -EINVAL;
+=09}
+
+=09vss->hw.periods_min =3D pcm_periods_min;
+=09vss->hw.periods_max =3D pcm_periods_max;
+
+=09/*
+=09 * We must ensure that there is enough space in the buffer to store
+=09 * pcm_buffer_ms ms for the combination (Cmax, Smax, Rmax), where:
+=09 *   Cmax =3D maximum supported number of channels,
+=09 *   Smax =3D maximum supported sample size in bytes,
+=09 *   Rmax =3D maximum supported frame rate.
+=09 */
+=09vss->hw.buffer_bytes_max =3D
+=09=09sample_max * vss->hw.channels_max * pcm_buffer_ms *
+=09=09(vss->hw.rate_max / MSEC_PER_SEC);
+
+=09/* Align the buffer size to the page size */
+=09vss->hw.buffer_bytes_max =3D
+=09=09(vss->hw.buffer_bytes_max + PAGE_SIZE - 1) & -PAGE_SIZE;
+
+=09/*
+=09 * We must ensure that the minimum period size is enough to store
+=09 * pcm_period_ms_min ms for the combination (Cmin, Smin, Rmin), where:
+=09 *   Cmin =3D minimum supported number of channels,
+=09 *   Smin =3D minimum supported sample size in bytes,
+=09 *   Rmin =3D minimum supported frame rate.
+=09 */
+=09vss->hw.period_bytes_min =3D
+=09=09sample_min * vss->hw.channels_min * pcm_period_ms_min *
+=09=09(vss->hw.rate_min / MSEC_PER_SEC);
+
+=09/*
+=09 * We must ensure that the maximum period size is enough to store
+=09 * pcm_period_ms_max ms for the combination (Cmax, Smax, Rmax).
+=09 */
+=09vss->hw.period_bytes_max =3D
+=09=09sample_max * vss->hw.channels_max * pcm_period_ms_max *
+=09=09(vss->hw.rate_max / MSEC_PER_SEC);
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
+struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, u32 nid)
+{
+=09struct virtio_pcm *vpcm;
+
+=09list_for_each_entry(vpcm, &snd->pcm_list, list)
+=09=09if (vpcm->nid =3D=3D nid)
+=09=09=09return vpcm;
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
+struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd, u32 =
nid)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_pcm *vpcm;
+
+=09vpcm =3D virtsnd_pcm_find(snd, nid);
+=09if (!IS_ERR(vpcm))
+=09=09return vpcm;
+
+=09vpcm =3D devm_kzalloc(&vdev->dev, sizeof(*vpcm), GFP_KERNEL);
+=09if (!vpcm)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09vpcm->nid =3D nid;
+=09list_add_tail(&vpcm->list, &snd->pcm_list);
+
+=09return vpcm;
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
+=09u32 i;
+=09int rc;
+
+=09virtio_cread_le(vdev, struct virtio_snd_config, streams,
+=09=09=09&snd->nsubstreams);
+=09if (!snd->nsubstreams)
+=09=09return 0;
+
+=09snd->substreams =3D devm_kcalloc(&vdev->dev, snd->nsubstreams,
+=09=09=09=09       sizeof(*snd->substreams), GFP_KERNEL);
+=09if (!snd->substreams)
+=09=09return -ENOMEM;
+
+=09info =3D kcalloc(snd->nsubstreams, sizeof(*info), GFP_KERNEL);
+=09if (!info)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_query_info(snd, VIRTIO_SND_R_PCM_INFO, 0,
+=09=09=09=09    snd->nsubstreams, sizeof(*info), info);
+=09if (rc)
+=09=09goto on_exit;
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i) {
+=09=09struct virtio_pcm_substream *vss =3D &snd->substreams[i];
+=09=09struct virtio_pcm *vpcm;
+
+=09=09vss->snd =3D snd;
+=09=09vss->sid =3D i;
+
+=09=09rc =3D virtsnd_pcm_build_hw(vss, &info[i]);
+=09=09if (rc)
+=09=09=09goto on_exit;
+
+=09=09vss->nid =3D le32_to_cpu(info[i].hdr.hda_fn_nid);
+
+=09=09vpcm =3D virtsnd_pcm_find_or_create(snd, vss->nid);
+=09=09if (IS_ERR(vpcm)) {
+=09=09=09rc =3D PTR_ERR(vpcm);
+=09=09=09goto on_exit;
+=09=09}
+
+=09=09switch (info[i].direction) {
+=09=09case VIRTIO_SND_D_OUTPUT:
+=09=09=09vss->direction =3D SNDRV_PCM_STREAM_PLAYBACK;
+=09=09=09break;
+=09=09case VIRTIO_SND_D_INPUT:
+=09=09=09vss->direction =3D SNDRV_PCM_STREAM_CAPTURE;
+=09=09=09break;
+=09=09default:
+=09=09=09dev_err(&vdev->dev, "SID %u: unknown direction (%u)\n",
+=09=09=09=09vss->sid, info[i].direction);
+=09=09=09rc =3D -EINVAL;
+=09=09=09goto on_exit;
+=09=09}
+
+=09=09vpcm->streams[vss->direction].nsubstreams++;
+=09}
+
+on_exit:
+=09kfree(info);
+
+=09return rc;
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
+=09struct virtio_pcm *vpcm;
+=09u32 i;
+=09int rc;
+
+=09list_for_each_entry(vpcm, &snd->pcm_list, list) {
+=09=09unsigned int npbs =3D
+=09=09=09vpcm->streams[SNDRV_PCM_STREAM_PLAYBACK].nsubstreams;
+=09=09unsigned int ncps =3D
+=09=09=09vpcm->streams[SNDRV_PCM_STREAM_CAPTURE].nsubstreams;
+
+=09=09if (!npbs && !ncps)
+=09=09=09continue;
+
+=09=09rc =3D snd_pcm_new(snd->card, VIRTIO_SND_CARD_DRIVER, vpcm->nid,
+=09=09=09=09 npbs, ncps, &vpcm->pcm);
+=09=09if (rc) {
+=09=09=09dev_err(&vdev->dev, "snd_pcm_new[%u] failed: %d\n",
+=09=09=09=09vpcm->nid, rc);
+=09=09=09return rc;
+=09=09}
+
+=09=09vpcm->pcm->info_flags =3D 0;
+=09=09vpcm->pcm->dev_class =3D SNDRV_PCM_CLASS_GENERIC;
+=09=09vpcm->pcm->dev_subclass =3D SNDRV_PCM_SUBCLASS_GENERIC_MIX;
+=09=09snprintf(vpcm->pcm->name, sizeof(vpcm->pcm->name),
+=09=09=09 VIRTIO_SND_PCM_NAME " %u", vpcm->pcm->device);
+=09=09vpcm->pcm->private_data =3D vpcm;
+=09=09vpcm->pcm->nonatomic =3D true;
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(vpcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &vpcm->streams[i];
+
+=09=09=09if (!stream->nsubstreams)
+=09=09=09=09continue;
+
+=09=09=09stream->substreams =3D
+=09=09=09=09devm_kcalloc(&vdev->dev, stream->nsubstreams,
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
+=09=09struct virtio_pcm_stream *vs;
+=09=09struct virtio_pcm_substream *vss =3D &snd->substreams[i];
+
+=09=09vpcm =3D virtsnd_pcm_find(snd, vss->nid);
+=09=09if (IS_ERR(vpcm))
+=09=09=09return PTR_ERR(vpcm);
+
+=09=09vs =3D &vpcm->streams[vss->direction];
+=09=09vs->substreams[vs->nsubstreams++] =3D vss;
+=09}
+
+=09list_for_each_entry(vpcm, &snd->pcm_list, list) {
+=09=09for (i =3D 0; i < ARRAY_SIZE(vpcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *vs =3D &vpcm->streams[i];
+=09=09=09struct snd_pcm_str *ks =3D &vpcm->pcm->streams[i];
+=09=09=09struct snd_pcm_substream *kss;
+
+=09=09=09if (!vs->nsubstreams)
+=09=09=09=09continue;
+
+=09=09=09for (kss =3D ks->substream; kss; kss =3D kss->next)
+=09=09=09=09vs->substreams[kss->number]->substream =3D kss;
+=09=09}
+
+=09=09snd_pcm_set_managed_buffer_all(vpcm->pcm,
+=09=09=09=09=09       SNDRV_DMA_TYPE_VMALLOC, NULL,
+=09=09=09=09=09       0, 0);
+=09}
+
+=09return 0;
+}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
new file mode 100644
index 000000000000..a2aadc44dce9
--- /dev/null
+++ b/sound/virtio/virtio_pcm.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#ifndef VIRTIO_SND_PCM_H
+#define VIRTIO_SND_PCM_H
+
+#include <linux/atomic.h>
+#include <linux/virtio_config.h>
+#include <sound/pcm.h>
+
+struct virtio_pcm;
+struct virtio_pcm_msg;
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
+=09u32 nid;
+=09u32 sid;
+=09u32 direction;
+=09u32 features;
+=09struct snd_pcm_substream *substream;
+=09struct snd_pcm_hardware hw;
+};
+
+/**
+ * struct virtio_pcm_stream - VirtIO PCM stream.
+ * @substreams: VirtIO substreams belonging to the stream.
+ * @nsubstreams: Number of substreams.
+ */
+struct virtio_pcm_stream {
+=09struct virtio_pcm_substream **substreams;
+=09u32 nsubstreams;
+};
+
+/**
+ * struct virtio_pcm - VirtIO PCM device.
+ * @list: VirtIO PCM list entry.
+ * @nid: Function group node identifier.
+ * @pcm: Kernel PCM device.
+ * @streams: VirtIO PCM streams (playback and capture).
+ */
+struct virtio_pcm {
+=09struct list_head list;
+=09u32 nid;
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
+struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, u32 nid);
+
+struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd, u32 =
nid);
+
+#endif /* VIRTIO_SND_PCM_H */
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

