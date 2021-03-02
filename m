Return-Path: virtio-dev-return-8086-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFFB598639D
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Mar 2021 16:47:32 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Tue, 2 Mar 2021 17:47:02 +0100
Message-ID: <20210302164709.3142702-3-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
References: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v7 2/9] ALSA: virtio: add virtio sound driver
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce skeleton of the virtio sound driver. The driver implements
the virtio sound device specification, which has become part of the
virtio standard.

Initial initialization of the device, virtqueues and creation of an
empty ALSA sound device.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 MAINTAINERS                     |   9 +
 include/uapi/linux/virtio_snd.h | 334 ++++++++++++++++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |   7 +
 sound/virtio/virtio_card.c      | 324 +++++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      |  65 +++++++
 8 files changed, 753 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_snd.h
 create mode 100644 sound/virtio/Kconfig
 create mode 100644 sound/virtio/Makefile
 create mode 100644 sound/virtio/virtio_card.c
 create mode 100644 sound/virtio/virtio_card.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c71664ca8bfd..4369946434ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19049,6 +19049,15 @@ W:=09https://virtio-mem.gitlab.io/
 F:=09drivers/virtio/virtio_mem.c
 F:=09include/uapi/linux/virtio_mem.h
=20
+VIRTIO SOUND DRIVER
+M:=09Anton Yakovlev <anton.yakovlev@opensynergy.com>
+M:=09"Michael S. Tsirkin" <mst@redhat.com>
+L:=09virtualization@lists.linux-foundation.org
+L:=09alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:=09Maintained
+F:=09include/uapi/linux/virtio_snd.h
+F:=09sound/virtio/*
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:=09Hans de Goede <hdegoede@redhat.com>
 M:=09Arnd Bergmann <arnd@arndb.de>
diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_sn=
d.h
new file mode 100644
index 000000000000..dfe49547a7b0
--- /dev/null
+++ b/include/uapi/linux/virtio_snd.h
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#ifndef VIRTIO_SND_IF_H
+#define VIRTIO_SND_IF_H
+
+#include <linux/virtio_types.h>
+
+/*************************************************************************=
******
+ * CONFIGURATION SPACE
+ */
+struct virtio_snd_config {
+=09/* # of available physical jacks */
+=09__le32 jacks;
+=09/* # of available PCM streams */
+=09__le32 streams;
+=09/* # of available channel maps */
+=09__le32 chmaps;
+};
+
+enum {
+=09/* device virtqueue indexes */
+=09VIRTIO_SND_VQ_CONTROL =3D 0,
+=09VIRTIO_SND_VQ_EVENT,
+=09VIRTIO_SND_VQ_TX,
+=09VIRTIO_SND_VQ_RX,
+=09/* # of device virtqueues */
+=09VIRTIO_SND_VQ_MAX
+};
+
+/*************************************************************************=
******
+ * COMMON DEFINITIONS
+ */
+
+/* supported dataflow directions */
+enum {
+=09VIRTIO_SND_D_OUTPUT =3D 0,
+=09VIRTIO_SND_D_INPUT
+};
+
+enum {
+=09/* jack control request types */
+=09VIRTIO_SND_R_JACK_INFO =3D 1,
+=09VIRTIO_SND_R_JACK_REMAP,
+
+=09/* PCM control request types */
+=09VIRTIO_SND_R_PCM_INFO =3D 0x0100,
+=09VIRTIO_SND_R_PCM_SET_PARAMS,
+=09VIRTIO_SND_R_PCM_PREPARE,
+=09VIRTIO_SND_R_PCM_RELEASE,
+=09VIRTIO_SND_R_PCM_START,
+=09VIRTIO_SND_R_PCM_STOP,
+
+=09/* channel map control request types */
+=09VIRTIO_SND_R_CHMAP_INFO =3D 0x0200,
+
+=09/* jack event types */
+=09VIRTIO_SND_EVT_JACK_CONNECTED =3D 0x1000,
+=09VIRTIO_SND_EVT_JACK_DISCONNECTED,
+
+=09/* PCM event types */
+=09VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED =3D 0x1100,
+=09VIRTIO_SND_EVT_PCM_XRUN,
+
+=09/* common status codes */
+=09VIRTIO_SND_S_OK =3D 0x8000,
+=09VIRTIO_SND_S_BAD_MSG,
+=09VIRTIO_SND_S_NOT_SUPP,
+=09VIRTIO_SND_S_IO_ERR
+};
+
+/* common header */
+struct virtio_snd_hdr {
+=09__le32 code;
+};
+
+/* event notification */
+struct virtio_snd_event {
+=09/* VIRTIO_SND_EVT_XXX */
+=09struct virtio_snd_hdr hdr;
+=09/* optional event data */
+=09__le32 data;
+};
+
+/* common control request to query an item information */
+struct virtio_snd_query_info {
+=09/* VIRTIO_SND_R_XXX_INFO */
+=09struct virtio_snd_hdr hdr;
+=09/* item start identifier */
+=09__le32 start_id;
+=09/* item count to query */
+=09__le32 count;
+=09/* item information size in bytes */
+=09__le32 size;
+};
+
+/* common item information header */
+struct virtio_snd_info {
+=09/* function group node id (High Definition Audio Specification 7.1.2) *=
/
+=09__le32 hda_fn_nid;
+};
+
+/*************************************************************************=
******
+ * JACK CONTROL MESSAGES
+ */
+struct virtio_snd_jack_hdr {
+=09/* VIRTIO_SND_R_JACK_XXX */
+=09struct virtio_snd_hdr hdr;
+=09/* 0 ... virtio_snd_config::jacks - 1 */
+=09__le32 jack_id;
+};
+
+/* supported jack features */
+enum {
+=09VIRTIO_SND_JACK_F_REMAP =3D 0
+};
+
+struct virtio_snd_jack_info {
+=09/* common header */
+=09struct virtio_snd_info hdr;
+=09/* supported feature bit map (1 << VIRTIO_SND_JACK_F_XXX) */
+=09__le32 features;
+=09/* pin configuration (High Definition Audio Specification 7.3.3.31) */
+=09__le32 hda_reg_defconf;
+=09/* pin capabilities (High Definition Audio Specification 7.3.4.9) */
+=09__le32 hda_reg_caps;
+=09/* current jack connection status (0: disconnected, 1: connected) */
+=09__u8 connected;
+
+=09__u8 padding[7];
+};
+
+/* jack remapping control request */
+struct virtio_snd_jack_remap {
+=09/* .code =3D VIRTIO_SND_R_JACK_REMAP */
+=09struct virtio_snd_jack_hdr hdr;
+=09/* selected association number */
+=09__le32 association;
+=09/* selected sequence number */
+=09__le32 sequence;
+};
+
+/*************************************************************************=
******
+ * PCM CONTROL MESSAGES
+ */
+struct virtio_snd_pcm_hdr {
+=09/* VIRTIO_SND_R_PCM_XXX */
+=09struct virtio_snd_hdr hdr;
+=09/* 0 ... virtio_snd_config::streams - 1 */
+=09__le32 stream_id;
+};
+
+/* supported PCM stream features */
+enum {
+=09VIRTIO_SND_PCM_F_SHMEM_HOST =3D 0,
+=09VIRTIO_SND_PCM_F_SHMEM_GUEST,
+=09VIRTIO_SND_PCM_F_MSG_POLLING,
+=09VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS,
+=09VIRTIO_SND_PCM_F_EVT_XRUNS
+};
+
+/* supported PCM sample formats */
+enum {
+=09/* analog formats (width / physical width) */
+=09VIRTIO_SND_PCM_FMT_IMA_ADPCM =3D 0,=09/*  4 /  4 bits */
+=09VIRTIO_SND_PCM_FMT_MU_LAW,=09=09/*  8 /  8 bits */
+=09VIRTIO_SND_PCM_FMT_A_LAW,=09=09/*  8 /  8 bits */
+=09VIRTIO_SND_PCM_FMT_S8,=09=09=09/*  8 /  8 bits */
+=09VIRTIO_SND_PCM_FMT_U8,=09=09=09/*  8 /  8 bits */
+=09VIRTIO_SND_PCM_FMT_S16,=09=09=09/* 16 / 16 bits */
+=09VIRTIO_SND_PCM_FMT_U16,=09=09=09/* 16 / 16 bits */
+=09VIRTIO_SND_PCM_FMT_S18_3,=09=09/* 18 / 24 bits */
+=09VIRTIO_SND_PCM_FMT_U18_3,=09=09/* 18 / 24 bits */
+=09VIRTIO_SND_PCM_FMT_S20_3,=09=09/* 20 / 24 bits */
+=09VIRTIO_SND_PCM_FMT_U20_3,=09=09/* 20 / 24 bits */
+=09VIRTIO_SND_PCM_FMT_S24_3,=09=09/* 24 / 24 bits */
+=09VIRTIO_SND_PCM_FMT_U24_3,=09=09/* 24 / 24 bits */
+=09VIRTIO_SND_PCM_FMT_S20,=09=09=09/* 20 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_U20,=09=09=09/* 20 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_S24,=09=09=09/* 24 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_U24,=09=09=09/* 24 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_S32,=09=09=09/* 32 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_U32,=09=09=09/* 32 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_FLOAT,=09=09/* 32 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_FLOAT64,=09=09/* 64 / 64 bits */
+=09/* digital formats (width / physical width) */
+=09VIRTIO_SND_PCM_FMT_DSD_U8,=09=09/*  8 /  8 bits */
+=09VIRTIO_SND_PCM_FMT_DSD_U16,=09=09/* 16 / 16 bits */
+=09VIRTIO_SND_PCM_FMT_DSD_U32,=09=09/* 32 / 32 bits */
+=09VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME=09/* 32 / 32 bits */
+};
+
+/* supported PCM frame rates */
+enum {
+=09VIRTIO_SND_PCM_RATE_5512 =3D 0,
+=09VIRTIO_SND_PCM_RATE_8000,
+=09VIRTIO_SND_PCM_RATE_11025,
+=09VIRTIO_SND_PCM_RATE_16000,
+=09VIRTIO_SND_PCM_RATE_22050,
+=09VIRTIO_SND_PCM_RATE_32000,
+=09VIRTIO_SND_PCM_RATE_44100,
+=09VIRTIO_SND_PCM_RATE_48000,
+=09VIRTIO_SND_PCM_RATE_64000,
+=09VIRTIO_SND_PCM_RATE_88200,
+=09VIRTIO_SND_PCM_RATE_96000,
+=09VIRTIO_SND_PCM_RATE_176400,
+=09VIRTIO_SND_PCM_RATE_192000,
+=09VIRTIO_SND_PCM_RATE_384000
+};
+
+struct virtio_snd_pcm_info {
+=09/* common header */
+=09struct virtio_snd_info hdr;
+=09/* supported feature bit map (1 << VIRTIO_SND_PCM_F_XXX) */
+=09__le32 features;
+=09/* supported sample format bit map (1 << VIRTIO_SND_PCM_FMT_XXX) */
+=09__le64 formats;
+=09/* supported frame rate bit map (1 << VIRTIO_SND_PCM_RATE_XXX) */
+=09__le64 rates;
+=09/* dataflow direction (VIRTIO_SND_D_XXX) */
+=09__u8 direction;
+=09/* minimum # of supported channels */
+=09__u8 channels_min;
+=09/* maximum # of supported channels */
+=09__u8 channels_max;
+
+=09__u8 padding[5];
+};
+
+/* set PCM stream format */
+struct virtio_snd_pcm_set_params {
+=09/* .code =3D VIRTIO_SND_R_PCM_SET_PARAMS */
+=09struct virtio_snd_pcm_hdr hdr;
+=09/* size of the hardware buffer */
+=09__le32 buffer_bytes;
+=09/* size of the hardware period */
+=09__le32 period_bytes;
+=09/* selected feature bit map (1 << VIRTIO_SND_PCM_F_XXX) */
+=09__le32 features;
+=09/* selected # of channels */
+=09__u8 channels;
+=09/* selected sample format (VIRTIO_SND_PCM_FMT_XXX) */
+=09__u8 format;
+=09/* selected frame rate (VIRTIO_SND_PCM_RATE_XXX) */
+=09__u8 rate;
+
+=09__u8 padding;
+};
+
+/*************************************************************************=
******
+ * PCM I/O MESSAGES
+ */
+
+/* I/O request header */
+struct virtio_snd_pcm_xfer {
+=09/* 0 ... virtio_snd_config::streams - 1 */
+=09__le32 stream_id;
+};
+
+/* I/O request status */
+struct virtio_snd_pcm_status {
+=09/* VIRTIO_SND_S_XXX */
+=09__le32 status;
+=09/* current device latency */
+=09__le32 latency_bytes;
+};
+
+/*************************************************************************=
******
+ * CHANNEL MAP CONTROL MESSAGES
+ */
+struct virtio_snd_chmap_hdr {
+=09/* VIRTIO_SND_R_CHMAP_XXX */
+=09struct virtio_snd_hdr hdr;
+=09/* 0 ... virtio_snd_config::chmaps - 1 */
+=09__le32 chmap_id;
+};
+
+/* standard channel position definition */
+enum {
+=09VIRTIO_SND_CHMAP_NONE =3D 0,=09/* undefined */
+=09VIRTIO_SND_CHMAP_NA,=09=09/* silent */
+=09VIRTIO_SND_CHMAP_MONO,=09=09/* mono stream */
+=09VIRTIO_SND_CHMAP_FL,=09=09/* front left */
+=09VIRTIO_SND_CHMAP_FR,=09=09/* front right */
+=09VIRTIO_SND_CHMAP_RL,=09=09/* rear left */
+=09VIRTIO_SND_CHMAP_RR,=09=09/* rear right */
+=09VIRTIO_SND_CHMAP_FC,=09=09/* front center */
+=09VIRTIO_SND_CHMAP_LFE,=09=09/* low frequency (LFE) */
+=09VIRTIO_SND_CHMAP_SL,=09=09/* side left */
+=09VIRTIO_SND_CHMAP_SR,=09=09/* side right */
+=09VIRTIO_SND_CHMAP_RC,=09=09/* rear center */
+=09VIRTIO_SND_CHMAP_FLC,=09=09/* front left center */
+=09VIRTIO_SND_CHMAP_FRC,=09=09/* front right center */
+=09VIRTIO_SND_CHMAP_RLC,=09=09/* rear left center */
+=09VIRTIO_SND_CHMAP_RRC,=09=09/* rear right center */
+=09VIRTIO_SND_CHMAP_FLW,=09=09/* front left wide */
+=09VIRTIO_SND_CHMAP_FRW,=09=09/* front right wide */
+=09VIRTIO_SND_CHMAP_FLH,=09=09/* front left high */
+=09VIRTIO_SND_CHMAP_FCH,=09=09/* front center high */
+=09VIRTIO_SND_CHMAP_FRH,=09=09/* front right high */
+=09VIRTIO_SND_CHMAP_TC,=09=09/* top center */
+=09VIRTIO_SND_CHMAP_TFL,=09=09/* top front left */
+=09VIRTIO_SND_CHMAP_TFR,=09=09/* top front right */
+=09VIRTIO_SND_CHMAP_TFC,=09=09/* top front center */
+=09VIRTIO_SND_CHMAP_TRL,=09=09/* top rear left */
+=09VIRTIO_SND_CHMAP_TRR,=09=09/* top rear right */
+=09VIRTIO_SND_CHMAP_TRC,=09=09/* top rear center */
+=09VIRTIO_SND_CHMAP_TFLC,=09=09/* top front left center */
+=09VIRTIO_SND_CHMAP_TFRC,=09=09/* top front right center */
+=09VIRTIO_SND_CHMAP_TSL,=09=09/* top side left */
+=09VIRTIO_SND_CHMAP_TSR,=09=09/* top side right */
+=09VIRTIO_SND_CHMAP_LLFE,=09=09/* left LFE */
+=09VIRTIO_SND_CHMAP_RLFE,=09=09/* right LFE */
+=09VIRTIO_SND_CHMAP_BC,=09=09/* bottom center */
+=09VIRTIO_SND_CHMAP_BLC,=09=09/* bottom left center */
+=09VIRTIO_SND_CHMAP_BRC=09=09/* bottom right center */
+};
+
+/* maximum possible number of channels */
+#define VIRTIO_SND_CHMAP_MAX_SIZE=0918
+
+struct virtio_snd_chmap_info {
+=09/* common header */
+=09struct virtio_snd_info hdr;
+=09/* dataflow direction (VIRTIO_SND_D_XXX) */
+=09__u8 direction;
+=09/* # of valid channel position values */
+=09__u8 channels;
+=09/* channel position values (VIRTIO_SND_CHMAP_XXX) */
+=09__u8 positions[VIRTIO_SND_CHMAP_MAX_SIZE];
+};
+
+#endif /* VIRTIO_SND_IF_H */
diff --git a/sound/Kconfig b/sound/Kconfig
index 36785410fbe1..e56d96d2b11c 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -99,6 +99,8 @@ source "sound/synth/Kconfig"
=20
 source "sound/xen/Kconfig"
=20
+source "sound/virtio/Kconfig"
+
 endif # SND
=20
 endif # !UML
diff --git a/sound/Makefile b/sound/Makefile
index 797ecdcd35e2..04ef04b1168f 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_SOUND) +=3D soundcore.o
 obj-$(CONFIG_DMASOUND) +=3D oss/dmasound/
 obj-$(CONFIG_SND) +=3D core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ =
usb/ \
-=09firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ hda/ x86/ xen/
+=09firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ hda/ x86/ xen/ =
\
+=09virtio/
 obj-$(CONFIG_SND_AOA) +=3D aoa/
=20
 # This one must be compilable even if sound is configured out
diff --git a/sound/virtio/Kconfig b/sound/virtio/Kconfig
new file mode 100644
index 000000000000..094cba24ee5b
--- /dev/null
+++ b/sound/virtio/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Sound card driver for virtio
+
+config SND_VIRTIO
+=09tristate "Virtio sound driver"
+=09depends on VIRTIO
+=09select SND_PCM
+=09select SND_JACK
+=09help
+          This is the virtual sound driver for virtio. Say Y or M.
diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
new file mode 100644
index 000000000000..8c87ebb9982b
--- /dev/null
+++ b/sound/virtio/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_SND_VIRTIO) +=3D virtio_snd.o
+
+virtio_snd-objs :=3D \
+=09virtio_card.o
+
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
new file mode 100644
index 000000000000..5a37056858e9
--- /dev/null
+++ b/sound/virtio/virtio_card.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+#include <sound/initval.h>
+#include <uapi/linux/virtio_ids.h>
+
+#include "virtio_card.h"
+
+static void virtsnd_remove(struct virtio_device *vdev);
+
+/**
+ * virtsnd_event_send() - Add an event to the event queue.
+ * @vqueue: Underlying event virtqueue.
+ * @event: Event.
+ * @notify: Indicates whether or not to send a notification to the device.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_event_send(struct virtqueue *vqueue,
+=09=09=09       struct virtio_snd_event *event, bool notify,
+=09=09=09       gfp_t gfp)
+{
+=09struct scatterlist sg;
+=09struct scatterlist *psgs[1] =3D { &sg };
+
+=09/* reset event content */
+=09memset(event, 0, sizeof(*event));
+
+=09sg_init_one(&sg, event, sizeof(*event));
+
+=09if (virtqueue_add_sgs(vqueue, psgs, 0, 1, event, gfp) || !notify)
+=09=09return;
+
+=09if (virtqueue_kick_prepare(vqueue))
+=09=09virtqueue_notify(vqueue);
+}
+
+/**
+ * virtsnd_event_dispatch() - Dispatch an event from the device side.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_event_dispatch(struct virtio_snd *snd,
+=09=09=09=09   struct virtio_snd_event *event)
+{
+}
+
+/**
+ * virtsnd_event_notify_cb() - Dispatch all reported events from the event=
 queue.
+ * @vqueue: Underlying event virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from th=
e
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
+{
+=09struct virtio_snd *snd =3D vqueue->vdev->priv;
+=09struct virtio_snd_queue *queue =3D virtsnd_event_queue(snd);
+=09struct virtio_snd_event *event;
+=09u32 length;
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09do {
+=09=09virtqueue_disable_cb(vqueue);
+=09=09while ((event =3D virtqueue_get_buf(vqueue, &length))) {
+=09=09=09virtsnd_event_dispatch(snd, event);
+=09=09=09virtsnd_event_send(vqueue, event, true, GFP_ATOMIC);
+=09=09}
+=09=09if (unlikely(virtqueue_is_broken(vqueue)))
+=09=09=09break;
+=09} while (!virtqueue_enable_cb(vqueue));
+=09spin_unlock_irqrestore(&queue->lock, flags);
+}
+
+/**
+ * virtsnd_find_vqs() - Enumerate and initialize all virtqueues.
+ * @snd: VirtIO sound device.
+ *
+ * After calling this function, the event queue is disabled.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_find_vqs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09static vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] =3D {
+=09=09[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb
+=09};
+=09static const char *names[VIRTIO_SND_VQ_MAX] =3D {
+=09=09[VIRTIO_SND_VQ_EVENT] =3D "virtsnd-event"
+=09};
+=09struct virtqueue *vqs[VIRTIO_SND_VQ_MAX] =3D { 0 };
+=09unsigned int i;
+=09unsigned int n;
+=09int rc;
+
+=09rc =3D virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
+=09=09=09     NULL);
+=09if (rc) {
+=09=09dev_err(&vdev->dev, "failed to initialize virtqueues\n");
+=09=09return rc;
+=09}
+
+=09for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i)
+=09=09snd->queues[i].vqueue =3D vqs[i];
+
+=09/* Allocate events and populate the event queue */
+=09virtqueue_disable_cb(vqs[VIRTIO_SND_VQ_EVENT]);
+
+=09n =3D virtqueue_get_vring_size(vqs[VIRTIO_SND_VQ_EVENT]);
+
+=09snd->event_msgs =3D kmalloc_array(n, sizeof(*snd->event_msgs),
+=09=09=09=09=09GFP_KERNEL);
+=09if (!snd->event_msgs)
+=09=09return -ENOMEM;
+
+=09for (i =3D 0; i < n; ++i)
+=09=09virtsnd_event_send(vqs[VIRTIO_SND_VQ_EVENT],
+=09=09=09=09   &snd->event_msgs[i], false, GFP_KERNEL);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_enable_event_vq() - Enable the event virtqueue.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_enable_event_vq(struct virtio_snd *snd)
+{
+=09struct virtio_snd_queue *queue =3D virtsnd_event_queue(snd);
+
+=09if (!virtqueue_enable_cb(queue->vqueue))
+=09=09virtsnd_event_notify_cb(queue->vqueue);
+}
+
+/**
+ * virtsnd_disable_event_vq() - Disable the event virtqueue.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_disable_event_vq(struct virtio_snd *snd)
+{
+=09struct virtio_snd_queue *queue =3D virtsnd_event_queue(snd);
+=09struct virtio_snd_event *event;
+=09u32 length;
+=09unsigned long flags;
+
+=09if (queue->vqueue) {
+=09=09spin_lock_irqsave(&queue->lock, flags);
+=09=09virtqueue_disable_cb(queue->vqueue);
+=09=09while ((event =3D virtqueue_get_buf(queue->vqueue, &length)))
+=09=09=09virtsnd_event_dispatch(snd, event);
+=09=09spin_unlock_irqrestore(&queue->lock, flags);
+=09}
+}
+
+/**
+ * virtsnd_build_devs() - Read configuration and build ALSA devices.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_build_devs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct device *dev =3D &vdev->dev;
+=09int rc;
+
+=09rc =3D snd_card_new(dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+=09=09=09  THIS_MODULE, 0, &snd->card);
+=09if (rc < 0)
+=09=09return rc;
+
+=09snd->card->private_data =3D snd;
+
+=09strscpy(snd->card->driver, VIRTIO_SND_CARD_DRIVER,
+=09=09sizeof(snd->card->driver));
+=09strscpy(snd->card->shortname, VIRTIO_SND_CARD_NAME,
+=09=09sizeof(snd->card->shortname));
+=09if (dev->parent->bus)
+=09=09snprintf(snd->card->longname, sizeof(snd->card->longname),
+=09=09=09 VIRTIO_SND_CARD_NAME " at %s/%s/%s",
+=09=09=09 dev->parent->bus->name, dev_name(dev->parent),
+=09=09=09 dev_name(dev));
+=09else
+=09=09snprintf(snd->card->longname, sizeof(snd->card->longname),
+=09=09=09 VIRTIO_SND_CARD_NAME " at %s/%s",
+=09=09=09 dev_name(dev->parent), dev_name(dev));
+
+=09return snd_card_register(snd->card);
+}
+
+/**
+ * virtsnd_validate() - Validate if the device can be started.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL on failure.
+ */
+static int virtsnd_validate(struct virtio_device *vdev)
+{
+=09if (!vdev->config->get) {
+=09=09dev_err(&vdev->dev, "configuration access disabled\n");
+=09=09return -EINVAL;
+=09}
+
+=09if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"device does not comply with spec version 1.x\n");
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_probe() - Create and initialize the device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_probe(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd;
+=09unsigned int i;
+=09int rc;
+
+=09snd =3D devm_kzalloc(&vdev->dev, sizeof(*snd), GFP_KERNEL);
+=09if (!snd)
+=09=09return -ENOMEM;
+
+=09snd->vdev =3D vdev;
+
+=09vdev->priv =3D snd;
+
+=09for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i)
+=09=09spin_lock_init(&snd->queues[i].lock);
+
+=09rc =3D virtsnd_find_vqs(snd);
+=09if (rc)
+=09=09goto on_exit;
+
+=09virtio_device_ready(vdev);
+
+=09rc =3D virtsnd_build_devs(snd);
+=09if (rc)
+=09=09goto on_exit;
+
+=09virtsnd_enable_event_vq(snd);
+
+on_exit:
+=09if (rc)
+=09=09virtsnd_remove(vdev);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_remove() - Remove VirtIO and ALSA devices.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ */
+static void virtsnd_remove(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd =3D vdev->priv;
+
+=09virtsnd_disable_event_vq(snd);
+
+=09if (snd->card)
+=09=09snd_card_free(snd->card);
+
+=09vdev->config->del_vqs(vdev);
+=09vdev->config->reset(vdev);
+
+=09kfree(snd->event_msgs);
+}
+
+static const struct virtio_device_id id_table[] =3D {
+=09{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
+=09{ 0 },
+};
+
+static struct virtio_driver virtsnd_driver =3D {
+=09.driver.name =3D KBUILD_MODNAME,
+=09.driver.owner =3D THIS_MODULE,
+=09.id_table =3D id_table,
+=09.validate =3D virtsnd_validate,
+=09.probe =3D virtsnd_probe,
+=09.remove =3D virtsnd_remove,
+};
+
+static int __init init(void)
+{
+=09return register_virtio_driver(&virtsnd_driver);
+}
+module_init(init);
+
+static void __exit fini(void)
+{
+=09unregister_virtio_driver(&virtsnd_driver);
+}
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio sound card driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
new file mode 100644
index 000000000000..b903b1b12e90
--- /dev/null
+++ b/sound/virtio/virtio_card.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#ifndef VIRTIO_SND_CARD_H
+#define VIRTIO_SND_CARD_H
+
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <sound/core.h>
+#include <uapi/linux/virtio_snd.h>
+
+#define VIRTIO_SND_CARD_DRIVER=09"virtio-snd"
+#define VIRTIO_SND_CARD_NAME=09"VirtIO SoundCard"
+
+/**
+ * struct virtio_snd_queue - Virtqueue wrapper structure.
+ * @lock: Used to synchronize access to a virtqueue.
+ * @vqueue: Underlying virtqueue.
+ */
+struct virtio_snd_queue {
+=09spinlock_t lock;
+=09struct virtqueue *vqueue;
+};
+
+/**
+ * struct virtio_snd - VirtIO sound card device.
+ * @vdev: Underlying virtio device.
+ * @queues: Virtqueue wrappers.
+ * @card: ALSA sound card.
+ * @event_msgs: Device events.
+ */
+struct virtio_snd {
+=09struct virtio_device *vdev;
+=09struct virtio_snd_queue queues[VIRTIO_SND_VQ_MAX];
+=09struct snd_card *card;
+=09struct virtio_snd_event *event_msgs;
+};
+
+static inline struct virtio_snd_queue *
+virtsnd_control_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_CONTROL];
+}
+
+static inline struct virtio_snd_queue *
+virtsnd_event_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_EVENT];
+}
+
+static inline struct virtio_snd_queue *
+virtsnd_tx_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_TX];
+}
+
+static inline struct virtio_snd_queue *
+virtsnd_rx_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_RX];
+}
+
+#endif /* VIRTIO_SND_CARD_H */
--=20
2.30.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

