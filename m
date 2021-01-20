Return-Path: virtio-dev-return-7927-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7786986552
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jan 2021 00:37:10 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Wed, 20 Jan 2021 01:36:30 +0100
Message-ID: <20210120003638.3339987-3-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 2/7] uapi: virtio_snd: add the sound device header file
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

The file contains the definitions for the sound device from the OASIS
virtio spec.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 MAINTAINERS                     |   6 +
 include/uapi/linux/virtio_snd.h | 361 ++++++++++++++++++++++++++++++++
 2 files changed, 367 insertions(+)
 create mode 100644 include/uapi/linux/virtio_snd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..6dfd59eafe82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18936,6 +18936,12 @@ W:=09https://virtio-mem.gitlab.io/
 F:=09drivers/virtio/virtio_mem.c
 F:=09include/uapi/linux/virtio_mem.h
=20
+VIRTIO SOUND DRIVER
+M:=09Anton Yakovlev <anton.yakovlev@opensynergy.com>
+L:=09virtualization@lists.linux-foundation.org
+S:=09Maintained
+F:=09include/uapi/linux/virtio_snd.h
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:=09Hans de Goede <hdegoede@redhat.com>
 M:=09Arnd Bergmann <arnd@arndb.de>
diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_sn=
d.h
new file mode 100644
index 000000000000..1ff6310e54d6
--- /dev/null
+++ b/include/uapi/linux/virtio_snd.h
@@ -0,0 +1,361 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This header is BSD licensed so anyone can use the definitions to
+ * implement compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of OpenSynergy GmbH nor the names of its contributo=
rs
+ *    may be used to endorse or promote products derived from this softwar=
e
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
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
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

