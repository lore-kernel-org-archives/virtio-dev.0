Return-Path: virtio-dev-return-7928-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB471986059
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jan 2021 00:37:24 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Wed, 20 Jan 2021 01:36:34 +0100
Message-ID: <20210120003638.3339987-7-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 6/7] ALSA: virtio: introduce jack support
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Enumerate all available jacks and create ALSA controls.

At the moment jacks have a simple implementation and can only be used
to receive notifications about a plugged in/out device.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile       |   2 +
 sound/virtio/virtio_card.c  |  33 +++++
 sound/virtio/virtio_card.h  |  20 +++
 sound/virtio/virtio_chmap.c | 237 +++++++++++++++++++++++++++++++++
 sound/virtio/virtio_jack.c  | 255 ++++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h   |   4 +
 6 files changed, 551 insertions(+)
 create mode 100644 sound/virtio/virtio_chmap.c
 create mode 100644 sound/virtio/virtio_jack.c

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 34493226793f..2742bddb8874 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -4,7 +4,9 @@ obj-$(CONFIG_SND_VIRTIO) +=3D virtio_snd.o
=20
 virtio_snd-objs :=3D \
 =09virtio_card.o \
+=09virtio_chmap.o \
 =09virtio_ctl_msg.o \
+=09virtio_jack.o \
 =09virtio_pcm.o \
 =09virtio_pcm_msg.o \
 =09virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index dc703fc662f5..02814c3932ab 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -94,6 +94,11 @@ static void virtsnd_event_notify_cb(struct virtqueue *vq=
ueue)
 =09=09=09=09break;
=20
 =09=09=09switch (le32_to_cpu(event->hdr.code)) {
+=09=09=09case VIRTIO_SND_EVT_JACK_CONNECTED:
+=09=09=09case VIRTIO_SND_EVT_JACK_DISCONNECTED: {
+=09=09=09=09virtsnd_jack_event(snd, event);
+=09=09=09=09break;
+=09=09=09}
 =09=09=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
 =09=09=09case VIRTIO_SND_EVT_PCM_XRUN: {
 =09=09=09=09virtsnd_pcm_event(snd, event);
@@ -322,16 +327,36 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 =09strscpy(snd->card->longname, "VirtIO Sound Card",
 =09=09sizeof(snd->card->longname));
=20
+=09rc =3D virtsnd_jack_parse_cfg(snd);
+=09if (rc)
+=09=09return rc;
+
 =09rc =3D virtsnd_pcm_parse_cfg(snd);
 =09if (rc)
 =09=09return rc;
=20
+=09rc =3D virtsnd_chmap_parse_cfg(snd);
+=09if (rc)
+=09=09return rc;
+
+=09if (snd->njacks) {
+=09=09rc =3D virtsnd_jack_build_devs(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
 =09if (snd->nsubstreams) {
 =09=09rc =3D virtsnd_pcm_build_devs(snd);
 =09=09if (rc)
 =09=09=09return rc;
 =09}
=20
+=09if (snd->nchmaps) {
+=09=09rc =3D virtsnd_chmap_build_devs(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
 =09return snd_card_register(snd->card);
 }
=20
@@ -439,14 +464,22 @@ static void virtsnd_remove(struct virtio_device *vdev=
)
=20
 =09=09=09if (stream->substreams)
 =09=09=09=09devm_kfree(&vdev->dev, stream->substreams);
+=09=09=09if (stream->chmaps)
+=09=09=09=09devm_kfree(&vdev->dev, stream->chmaps);
 =09=09}
=20
 =09=09devm_kfree(&vdev->dev, pcm);
 =09}
=20
+=09if (snd->jacks)
+=09=09devm_kfree(&vdev->dev, snd->jacks);
+
 =09if (snd->substreams)
 =09=09devm_kfree(&vdev->dev, snd->substreams);
=20
+=09if (snd->chmaps)
+=09=09devm_kfree(&vdev->dev, snd->chmaps);
+
 =09devm_kfree(&vdev->dev, snd);
=20
 =09vdev->priv =3D NULL;
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index b11c09984882..09c6e9ab80ca 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -26,6 +26,7 @@
 #include "virtio_ctl_msg.h"
 #include "virtio_pcm.h"
=20
+struct virtio_jack;
 struct virtio_pcm_substream;
=20
 /**
@@ -47,8 +48,12 @@ struct virtio_snd_queue {
  * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
  * @pcm_list: VirtIO PCM device list.
+ * @jacks: VirtIO jacks.
+ * @njacks: Number of jacks.
  * @substreams: VirtIO PCM substreams.
  * @nsubstreams: Number of PCM substreams.
+ * @chmaps: VirtIO channel maps.
+ * @nchmaps: Number of channel maps.
  */
 struct virtio_snd {
 =09struct virtio_device *vdev;
@@ -58,8 +63,12 @@ struct virtio_snd {
 =09struct list_head ctl_msgs;
 =09struct virtio_snd_event *event_msgs;
 =09struct list_head pcm_list;
+=09struct virtio_jack *jacks;
+=09unsigned int njacks;
 =09struct virtio_pcm_substream *substreams;
 =09unsigned int nsubstreams;
+=09struct virtio_snd_chmap_info *chmaps;
+=09unsigned int nchmaps;
 };
=20
 /* Message completion timeout in milliseconds (module parameter). */
@@ -98,4 +107,15 @@ virtsnd_pcm_queue(struct virtio_pcm_substream *substrea=
m)
 =09=09return virtsnd_rx_queue(substream->snd);
 }
=20
+int virtsnd_jack_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_jack_build_devs(struct virtio_snd *snd);
+
+void virtsnd_jack_event(struct virtio_snd *snd,
+=09=09=09struct virtio_snd_event *event);
+
+int virtsnd_chmap_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_chmap_build_devs(struct virtio_snd *snd);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_chmap.c b/sound/virtio/virtio_chmap.c
new file mode 100644
index 000000000000..8a2ddc4dcffb
--- /dev/null
+++ b/sound/virtio/virtio_chmap.c
@@ -0,0 +1,237 @@
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
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/* VirtIO->ALSA channel position map */
+static const u8 g_v2a_position_map[] =3D {
+=09[VIRTIO_SND_CHMAP_NONE] =3D SNDRV_CHMAP_UNKNOWN,
+=09[VIRTIO_SND_CHMAP_NA] =3D SNDRV_CHMAP_NA,
+=09[VIRTIO_SND_CHMAP_MONO] =3D SNDRV_CHMAP_MONO,
+=09[VIRTIO_SND_CHMAP_FL] =3D SNDRV_CHMAP_FL,
+=09[VIRTIO_SND_CHMAP_FR] =3D SNDRV_CHMAP_FR,
+=09[VIRTIO_SND_CHMAP_RL] =3D SNDRV_CHMAP_RL,
+=09[VIRTIO_SND_CHMAP_RR] =3D SNDRV_CHMAP_RR,
+=09[VIRTIO_SND_CHMAP_FC] =3D SNDRV_CHMAP_FC,
+=09[VIRTIO_SND_CHMAP_LFE] =3D SNDRV_CHMAP_LFE,
+=09[VIRTIO_SND_CHMAP_SL] =3D SNDRV_CHMAP_SL,
+=09[VIRTIO_SND_CHMAP_SR] =3D SNDRV_CHMAP_SR,
+=09[VIRTIO_SND_CHMAP_RC] =3D SNDRV_CHMAP_RC,
+=09[VIRTIO_SND_CHMAP_FLC] =3D SNDRV_CHMAP_FLC,
+=09[VIRTIO_SND_CHMAP_FRC] =3D SNDRV_CHMAP_FRC,
+=09[VIRTIO_SND_CHMAP_RLC] =3D SNDRV_CHMAP_RLC,
+=09[VIRTIO_SND_CHMAP_RRC] =3D SNDRV_CHMAP_RRC,
+=09[VIRTIO_SND_CHMAP_FLW] =3D SNDRV_CHMAP_FLW,
+=09[VIRTIO_SND_CHMAP_FRW] =3D SNDRV_CHMAP_FRW,
+=09[VIRTIO_SND_CHMAP_FLH] =3D SNDRV_CHMAP_FLH,
+=09[VIRTIO_SND_CHMAP_FCH] =3D SNDRV_CHMAP_FCH,
+=09[VIRTIO_SND_CHMAP_FRH] =3D SNDRV_CHMAP_FRH,
+=09[VIRTIO_SND_CHMAP_TC] =3D SNDRV_CHMAP_TC,
+=09[VIRTIO_SND_CHMAP_TFL] =3D SNDRV_CHMAP_TFL,
+=09[VIRTIO_SND_CHMAP_TFR] =3D SNDRV_CHMAP_TFR,
+=09[VIRTIO_SND_CHMAP_TFC] =3D SNDRV_CHMAP_TFC,
+=09[VIRTIO_SND_CHMAP_TRL] =3D SNDRV_CHMAP_TRL,
+=09[VIRTIO_SND_CHMAP_TRR] =3D SNDRV_CHMAP_TRR,
+=09[VIRTIO_SND_CHMAP_TRC] =3D SNDRV_CHMAP_TRC,
+=09[VIRTIO_SND_CHMAP_TFLC] =3D SNDRV_CHMAP_TFLC,
+=09[VIRTIO_SND_CHMAP_TFRC] =3D SNDRV_CHMAP_TFRC,
+=09[VIRTIO_SND_CHMAP_TSL] =3D SNDRV_CHMAP_TSL,
+=09[VIRTIO_SND_CHMAP_TSR] =3D SNDRV_CHMAP_TSR,
+=09[VIRTIO_SND_CHMAP_LLFE] =3D SNDRV_CHMAP_LLFE,
+=09[VIRTIO_SND_CHMAP_RLFE] =3D SNDRV_CHMAP_RLFE,
+=09[VIRTIO_SND_CHMAP_BC] =3D SNDRV_CHMAP_BC,
+=09[VIRTIO_SND_CHMAP_BLC] =3D SNDRV_CHMAP_BLC,
+=09[VIRTIO_SND_CHMAP_BRC] =3D SNDRV_CHMAP_BRC
+};
+
+/**
+ * virtsnd_chmap_parse_cfg() - Parse the channel map configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_chmap_parse_cfg(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09unsigned int i;
+=09int rc;
+
+=09virtio_cread(vdev, struct virtio_snd_config, chmaps, &snd->nchmaps);
+=09if (!snd->nchmaps)
+=09=09return 0;
+
+=09snd->chmaps =3D devm_kcalloc(&vdev->dev, snd->nchmaps,
+=09=09=09=09   sizeof(*snd->chmaps), GFP_KERNEL);
+=09if (!snd->chmaps)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CHMAP_INFO, 0,
+=09=09=09=09    snd->nchmaps, sizeof(*snd->chmaps),
+=09=09=09=09    snd->chmaps);
+=09if (rc)
+=09=09return rc;
+
+=09/* Count the number of channel maps per each PCM device/stream. */
+=09for (i =3D 0; i < snd->nchmaps; ++i) {
+=09=09struct virtio_snd_chmap_info *info =3D &snd->chmaps[i];
+=09=09unsigned int nid =3D le32_to_cpu(info->hdr.hda_fn_nid);
+=09=09struct virtio_pcm *pcm;
+=09=09struct virtio_pcm_stream *stream;
+
+=09=09pcm =3D virtsnd_pcm_find_or_create(snd, nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+
+=09=09switch (info->direction) {
+=09=09case VIRTIO_SND_D_OUTPUT: {
+=09=09=09stream =3D &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
+=09=09=09break;
+=09=09}
+=09=09case VIRTIO_SND_D_INPUT: {
+=09=09=09stream =3D &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
+=09=09=09break;
+=09=09}
+=09=09default: {
+=09=09=09dev_err(&vdev->dev,
+=09=09=09=09"chmap #%u: unknown direction (%u)\n", i,
+=09=09=09=09info->direction);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09}
+
+=09=09stream->nchmaps++;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_chmap_add_ctls() - Create an ALSA control for channel maps.
+ * @pcm: ALSA PCM device.
+ * @direction: PCM stream direction (SNDRV_PCM_STREAM_XXX).
+ * @stream: VirtIO PCM stream.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_chmap_add_ctls(struct snd_pcm *pcm, int direction,
+=09=09=09=09  struct virtio_pcm_stream *stream)
+{
+=09unsigned int i;
+=09int max_channels =3D 0;
+
+=09for (i =3D 0; i < stream->nchmaps; i++)
+=09=09if (max_channels < stream->chmaps[i].channels)
+=09=09=09max_channels =3D stream->chmaps[i].channels;
+
+=09return snd_pcm_add_chmap_ctls(pcm, direction, stream->chmaps,
+=09=09=09=09      max_channels, 0, NULL);
+}
+
+/**
+ * virtsnd_chmap_build_devs() - Build ALSA controls for channel maps.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_chmap_build_devs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_pcm *pcm;
+=09struct virtio_pcm_stream *stream;
+=09unsigned int i;
+=09int rc;
+
+=09/* Allocate channel map elements per each PCM device/stream. */
+=09list_for_each_entry(pcm, &snd->pcm_list, list) {
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09stream =3D &pcm->streams[i];
+
+=09=09=09if (!stream->nchmaps)
+=09=09=09=09continue;
+
+=09=09=09stream->chmaps =3D devm_kcalloc(&vdev->dev,
+=09=09=09=09=09=09      stream->nchmaps + 1,
+=09=09=09=09=09=09      sizeof(*stream->chmaps),
+=09=09=09=09=09=09      GFP_KERNEL);
+=09=09=09if (!stream->chmaps)
+=09=09=09=09return -ENOMEM;
+
+=09=09=09stream->nchmaps =3D 0;
+=09=09}
+=09}
+
+=09/* Initialize channel maps per each PCM device/stream. */
+=09for (i =3D 0; i < snd->nchmaps; ++i) {
+=09=09struct virtio_snd_chmap_info *info =3D &snd->chmaps[i];
+=09=09unsigned int nid =3D le32_to_cpu(info->hdr.hda_fn_nid);
+=09=09unsigned int channels =3D info->channels;
+=09=09unsigned int ch;
+=09=09struct snd_pcm_chmap_elem *chmap;
+
+=09=09pcm =3D virtsnd_pcm_find(snd, nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+
+=09=09if (info->direction =3D=3D VIRTIO_SND_D_OUTPUT)
+=09=09=09stream =3D &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
+=09=09else
+=09=09=09stream =3D &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
+
+=09=09chmap =3D &stream->chmaps[stream->nchmaps++];
+
+=09=09if (channels > ARRAY_SIZE(chmap->map))
+=09=09=09channels =3D ARRAY_SIZE(chmap->map);
+
+=09=09chmap->channels =3D channels;
+
+=09=09for (ch =3D 0; ch < channels; ++ch) {
+=09=09=09u8 position =3D info->positions[ch];
+
+=09=09=09if (position >=3D ARRAY_SIZE(g_v2a_position_map))
+=09=09=09=09return -EINVAL;
+
+=09=09=09chmap->map[ch] =3D g_v2a_position_map[position];
+=09=09}
+=09}
+
+=09/* Create an ALSA control per each PCM device/stream. */
+=09list_for_each_entry(pcm, &snd->pcm_list, list) {
+=09=09if (!pcm->pcm)
+=09=09=09continue;
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09stream =3D &pcm->streams[i];
+
+=09=09=09if (!stream->nchmaps)
+=09=09=09=09continue;
+
+=09=09=09rc =3D virtsnd_chmap_add_ctls(pcm->pcm, i, stream);
+=09=09=09if (rc)
+=09=09=09=09return rc;
+=09=09}
+=09}
+
+=09return 0;
+}
diff --git a/sound/virtio/virtio_jack.c b/sound/virtio/virtio_jack.c
new file mode 100644
index 000000000000..83593c59f6bf
--- /dev/null
+++ b/sound/virtio/virtio_jack.c
@@ -0,0 +1,255 @@
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
+#include <linux/virtio_config.h>
+#include <sound/jack.h>
+#include <sound/hda_verbs.h>
+
+#include "virtio_card.h"
+
+/**
+ * DOC: Implementation Status
+ *
+ * At the moment jacks have a simple implementation and can only be used t=
o
+ * receive notifications about a plugged in/out device.
+ *
+ * VIRTIO_SND_R_JACK_REMAP
+ *   is not supported
+ */
+
+/**
+ * struct virtio_jack - VirtIO jack.
+ * @jack: Kernel jack control.
+ * @nid: Functional group node identifier.
+ * @features: Jack virtio feature bit map (1 << VIRTIO_SND_JACK_F_XXX).
+ * @defconf: Pin default configuration value.
+ * @caps: Pin capabilities value.
+ * @connected: Current jack connection status.
+ * @type: Kernel jack type (SND_JACK_XXX).
+ */
+struct virtio_jack {
+=09struct snd_jack *jack;
+=09unsigned int nid;
+=09unsigned int features;
+=09unsigned int defconf;
+=09unsigned int caps;
+=09bool connected;
+=09int type;
+};
+
+/**
+ * virtsnd_jack_get_label() - Get the name string for the jack.
+ * @jack: VirtIO jack.
+ *
+ * Returns the jack name based on the default pin configuration value (see=
 HDA
+ * specification).
+ *
+ * Context: Any context.
+ * Return: Name string.
+ */
+static const char *virtsnd_jack_get_label(struct virtio_jack *jack)
+{
+=09unsigned int defconf =3D jack->defconf;
+=09unsigned int device =3D
+=09=09(defconf & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT;
+=09unsigned int location =3D
+=09=09(defconf & AC_DEFCFG_LOCATION) >> AC_DEFCFG_LOCATION_SHIFT;
+
+=09switch (device) {
+=09case AC_JACK_LINE_OUT:
+=09=09return "Line Out";
+=09case AC_JACK_SPEAKER:
+=09=09return "Speaker";
+=09case AC_JACK_HP_OUT:
+=09=09return "Headphone";
+=09case AC_JACK_CD:
+=09=09return "CD";
+=09case AC_JACK_SPDIF_OUT:
+=09case AC_JACK_DIG_OTHER_OUT:
+=09=09if (location =3D=3D AC_JACK_LOC_HDMI)
+=09=09=09return "HDMI Out";
+=09=09else
+=09=09=09return "SPDIF Out";
+=09case AC_JACK_LINE_IN:
+=09=09return "Line";
+=09case AC_JACK_AUX:
+=09=09return "Aux";
+=09case AC_JACK_MIC_IN:
+=09=09return "Mic";
+=09case AC_JACK_SPDIF_IN:
+=09=09return "SPDIF In";
+=09case AC_JACK_DIG_OTHER_IN:
+=09=09return "Digital In";
+=09default:
+=09=09return "Misc";
+=09}
+}
+
+/**
+ * virtsnd_jack_get_type() - Get the type for the jack.
+ * @jack: VirtIO jack.
+ *
+ * Returns the jack type based on the default pin configuration value (see=
 HDA
+ * specification).
+ *
+ * Context: Any context.
+ * Return: SND_JACK_XXX value.
+ */
+static int virtsnd_jack_get_type(struct virtio_jack *jack)
+{
+=09unsigned int defconf =3D jack->defconf;
+=09unsigned int device =3D
+=09=09(defconf & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT;
+
+=09switch (device) {
+=09case AC_JACK_LINE_OUT:
+=09case AC_JACK_SPEAKER:
+=09=09return SND_JACK_LINEOUT;
+=09case AC_JACK_HP_OUT:
+=09=09return SND_JACK_HEADPHONE;
+=09case AC_JACK_SPDIF_OUT:
+=09case AC_JACK_DIG_OTHER_OUT:
+=09=09return SND_JACK_AVOUT;
+=09case AC_JACK_MIC_IN:
+=09=09return SND_JACK_MICROPHONE;
+=09default:
+=09=09return SND_JACK_LINEIN;
+=09}
+}
+
+/**
+ * virtsnd_jack_parse_cfg() - Parse the jack configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_jack_parse_cfg(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_jack_info *info;
+=09unsigned int i;
+=09int rc;
+
+=09virtio_cread(vdev, struct virtio_snd_config, jacks, &snd->njacks);
+=09if (!snd->njacks)
+=09=09return 0;
+
+=09snd->jacks =3D devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*snd->jacks=
),
+=09=09=09=09  GFP_KERNEL);
+=09if (!snd->jacks)
+=09=09return -ENOMEM;
+
+=09info =3D devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*info), GFP_KERNE=
L);
+=09if (!info)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_query_info(snd, VIRTIO_SND_R_JACK_INFO, 0, snd->njac=
ks,
+=09=09=09=09    sizeof(*info), info);
+=09if (rc)
+=09=09return rc;
+
+=09for (i =3D 0; i < snd->njacks; ++i) {
+=09=09struct virtio_jack *jack =3D &snd->jacks[i];
+=09=09struct virtio_pcm *pcm;
+
+=09=09jack->nid =3D le32_to_cpu(info[i].hdr.hda_fn_nid);
+=09=09jack->features =3D le32_to_cpu(info[i].features);
+=09=09jack->defconf =3D le32_to_cpu(info[i].hda_reg_defconf);
+=09=09jack->caps =3D le32_to_cpu(info[i].hda_reg_caps);
+=09=09jack->connected =3D info[i].connected;
+
+=09=09pcm =3D virtsnd_pcm_find_or_create(snd, jack->nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+=09}
+
+=09devm_kfree(&vdev->dev, info);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_jack_build_devs() - Build ALSA controls for jacks.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_jack_build_devs(struct virtio_snd *snd)
+{
+=09unsigned int i;
+=09int rc;
+
+=09for (i =3D 0; i < snd->njacks; ++i) {
+=09=09struct virtio_jack *jack =3D &snd->jacks[i];
+
+=09=09jack->type =3D virtsnd_jack_get_type(jack);
+
+=09=09rc =3D snd_jack_new(snd->card, virtsnd_jack_get_label(jack),
+=09=09=09=09  jack->type, &jack->jack, true, true);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09if (!jack->jack)
+=09=09=09continue;
+
+=09=09jack->jack->private_data =3D jack;
+
+=09=09snd_jack_report(jack->jack,
+=09=09=09=09jack->connected ? jack->type : 0);
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_jack_event() - Handle the jack event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_jack_event(struct virtio_snd *snd, struct virtio_snd_event *e=
vent)
+{
+=09unsigned int jack_id =3D le32_to_cpu(event->data);
+=09struct virtio_jack *jack;
+
+=09if (jack_id >=3D snd->njacks)
+=09=09return;
+
+=09jack =3D &snd->jacks[jack_id];
+
+=09switch (le32_to_cpu(event->hdr.code)) {
+=09case VIRTIO_SND_EVT_JACK_CONNECTED: {
+=09=09jack->connected =3D true;
+=09=09break;
+=09}
+=09case VIRTIO_SND_EVT_JACK_DISCONNECTED: {
+=09=09jack->connected =3D false;
+=09=09break;
+=09}
+=09default: {
+=09=09return;
+=09}
+=09}
+
+=09snd_jack_report(jack->jack, jack->connected ? jack->type : 0);
+}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index fe467bc05d8b..a326b921b947 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -70,10 +70,14 @@ struct virtio_pcm_substream {
  * struct virtio_pcm_stream - VirtIO PCM stream.
  * @substreams: Virtio substreams belonging to the stream.
  * @nsubstreams: Number of substreams.
+ * @chmaps: Kernel channel maps belonging to the stream.
+ * @nchmaps: Number of channel maps.
  */
 struct virtio_pcm_stream {
 =09struct virtio_pcm_substream **substreams;
 =09unsigned int nsubstreams;
+=09struct snd_pcm_chmap_elem *chmaps;
+=09unsigned int nchmaps;
 };
=20
 /**
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

