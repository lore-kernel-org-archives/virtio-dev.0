Return-Path: <virtio-dev-return-9350-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3305198651D
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Mar 2022 19:47:59 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Mon,  7 Mar 2022 20:47:15 +0100
Message-Id: <20220307194716.1517565-2-anton.yakovlev@opensynergy.com>
In-Reply-To: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>
References: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 1/1] ALSA: virtio: add support for audio controls
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Implementation of support for audio controls in accordance with the
proposed extension of the virtio sound device specification [1].

The device can announce the VIRTIO_SND_F_CTLS feature. If the feature is
negotiated, then an additional field appears in the configuration space:

  struct virtio_snd_config {
    ...
    /* number of available control elements */
    __le32 controls;
  };

The driver can send the following requests to manage audio controls:

  enum {
    ...
    /* control element request types */
    VIRTIO_SND_R_CTL_INFO =3D 0x0300,
    VIRTIO_SND_R_CTL_ENUM_ITEMS,
    VIRTIO_SND_R_CTL_READ,
    VIRTIO_SND_R_CTL_WRITE,
    VIRTIO_SND_R_CTL_TLV_READ,
    VIRTIO_SND_R_CTL_TLV_WRITE,
    VIRTIO_SND_R_CTL_TLV_COMMAND,
    ...
  };

And the device can send the following audio control event notification:

  enum {
    ...
    /* control element event types */
    VIRTIO_SND_EVT_CTL_NOTIFY =3D 0x1200,
    ...
  };

See additional details in [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.ht=
ml

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_sn=
d.h
index dfe49547a7b0..5f4100c2cf04 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -7,6 +7,14 @@
=20
 #include <linux/virtio_types.h>
=20
+/*************************************************************************=
******
+ * FEATURE BITS
+ */
+enum {
+=09/* device supports control elements */
+=09VIRTIO_SND_F_CTLS =3D 0
+};
+
 /*************************************************************************=
******
  * CONFIGURATION SPACE
  */
@@ -17,6 +25,8 @@ struct virtio_snd_config {
 =09__le32 streams;
 =09/* # of available channel maps */
 =09__le32 chmaps;
+=09/* # of available control elements */
+=09__le32 controls;
 };
=20
 enum {
@@ -55,6 +65,15 @@ enum {
 =09/* channel map control request types */
 =09VIRTIO_SND_R_CHMAP_INFO =3D 0x0200,
=20
+=09/* control element request types */
+=09VIRTIO_SND_R_CTL_INFO =3D 0x0300,
+=09VIRTIO_SND_R_CTL_ENUM_ITEMS,
+=09VIRTIO_SND_R_CTL_READ,
+=09VIRTIO_SND_R_CTL_WRITE,
+=09VIRTIO_SND_R_CTL_TLV_READ,
+=09VIRTIO_SND_R_CTL_TLV_WRITE,
+=09VIRTIO_SND_R_CTL_TLV_COMMAND,
+
 =09/* jack event types */
 =09VIRTIO_SND_EVT_JACK_CONNECTED =3D 0x1000,
 =09VIRTIO_SND_EVT_JACK_DISCONNECTED,
@@ -63,6 +82,9 @@ enum {
 =09VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED =3D 0x1100,
 =09VIRTIO_SND_EVT_PCM_XRUN,
=20
+=09/* control element event types */
+=09VIRTIO_SND_EVT_CTL_NOTIFY =3D 0x1200,
+
 =09/* common status codes */
 =09VIRTIO_SND_S_OK =3D 0x8000,
 =09VIRTIO_SND_S_BAD_MSG,
@@ -331,4 +353,136 @@ struct virtio_snd_chmap_info {
 =09__u8 positions[VIRTIO_SND_CHMAP_MAX_SIZE];
 };
=20
+/*************************************************************************=
******
+ * CONTROL ELEMENTS MESSAGES
+ */
+struct virtio_snd_ctl_hdr {
+=09/* VIRTIO_SND_R_CTL_XXX */
+=09struct virtio_snd_hdr hdr;
+=09/* 0 ... virtio_snd_config::controls - 1 */
+=09__le32 control_id;
+};
+
+/* supported roles for control elements */
+enum {
+=09VIRTIO_SND_CTL_ROLE_UNDEFINED =3D 0,
+=09VIRTIO_SND_CTL_ROLE_VOLUME,
+=09VIRTIO_SND_CTL_ROLE_MUTE,
+=09VIRTIO_SND_CTL_ROLE_GAIN
+};
+
+/* supported value types for control elements */
+enum {
+=09VIRTIO_SND_CTL_TYPE_BOOLEAN =3D 0,
+=09VIRTIO_SND_CTL_TYPE_INTEGER,
+=09VIRTIO_SND_CTL_TYPE_INTEGER64,
+=09VIRTIO_SND_CTL_TYPE_ENUMERATED,
+=09VIRTIO_SND_CTL_TYPE_BYTES,
+=09VIRTIO_SND_CTL_TYPE_IEC958
+};
+
+/* supported access rights for control elements */
+enum {
+=09VIRTIO_SND_CTL_ACCESS_READ =3D 0,
+=09VIRTIO_SND_CTL_ACCESS_WRITE,
+=09VIRTIO_SND_CTL_ACCESS_VOLATILE,
+=09VIRTIO_SND_CTL_ACCESS_INACTIVE,
+=09VIRTIO_SND_CTL_ACCESS_TLV_READ,
+=09VIRTIO_SND_CTL_ACCESS_TLV_WRITE,
+=09VIRTIO_SND_CTL_ACCESS_TLV_COMMAND
+};
+
+struct virtio_snd_ctl_info {
+=09/* common header */
+=09struct virtio_snd_info hdr;
+=09/* element role (VIRTIO_SND_CTL_ROLE_XXX) */
+=09__le32 role;
+=09/* element value type (VIRTIO_SND_CTL_TYPE_XXX) */
+=09__le32 type;
+=09/* element access right bit map (1 << VIRTIO_SND_CTL_ACCESS_XXX) */
+=09__le32 access;
+=09/* # of members in the element value */
+=09__le32 count;
+=09/* index for an element with a non-unique name */
+=09__le32 index;
+=09/* name identifier string for the element */
+=09__u8 name[44];
+=09/* additional information about the element's value */
+=09union {
+=09=09/* VIRTIO_SND_CTL_TYPE_INTEGER */
+=09=09struct {
+=09=09=09/* minimum supported value */
+=09=09=09__le32 min;
+=09=09=09/* maximum supported value */
+=09=09=09__le32 max;
+=09=09=09/* fixed step size for value (0 =3D variable size) */
+=09=09=09__le32 step;
+=09=09} integer;
+=09=09/* VIRTIO_SND_CTL_TYPE_INTEGER64 */
+=09=09struct {
+=09=09=09/* minimum supported value */
+=09=09=09__le64 min;
+=09=09=09/* maximum supported value */
+=09=09=09__le64 max;
+=09=09=09/* fixed step size for value (0 =3D variable size) */
+=09=09=09__le64 step;
+=09=09} integer64;
+=09=09/* VIRTIO_SND_CTL_TYPE_ENUMERATED */
+=09=09struct {
+=09=09=09/* # of options supported for value */
+=09=09=09__le32 items;
+=09=09} enumerated;
+=09} value;
+};
+
+struct virtio_snd_ctl_enum_item {
+=09/* option name */
+=09__u8 item[64];
+};
+
+struct virtio_snd_ctl_iec958 {
+=09/* AES/IEC958 channel status bits */
+=09__u8 status[24];
+=09/* AES/IEC958 subcode bits */
+=09__u8 subcode[147];
+=09/* nothing */
+=09__u8 pad;
+=09/* AES/IEC958 subframe bits */
+=09__u8 dig_subframe[4];
+};
+
+struct virtio_snd_ctl_value {
+=09union {
+=09=09/* VIRTIO_SND_CTL_TYPE_BOOLEAN|INTEGER value */
+=09=09__le32 integer[128];
+=09=09/* VIRTIO_SND_CTL_TYPE_INTEGER64 value */
+=09=09__le64 integer64[64];
+=09=09/* VIRTIO_SND_CTL_TYPE_ENUMERATED value (option indexes) */
+=09=09__le32 enumerated[128];
+=09=09/* VIRTIO_SND_CTL_TYPE_BYTES value */
+=09=09__u8 bytes[512];
+=09=09/* VIRTIO_SND_CTL_TYPE_IEC958 value */
+=09=09struct virtio_snd_ctl_iec958 iec958;
+=09} value;
+};
+
+/* supported event reason types */
+enum {
+=09/* element's value has changed */
+=09VIRTIO_SND_CTL_EVT_MASK_VALUE =3D 0,
+=09/* element's information has changed */
+=09VIRTIO_SND_CTL_EVT_MASK_INFO,
+=09/* element's metadata has changed */
+=09VIRTIO_SND_CTL_EVT_MASK_TLV
+};
+
+struct virtio_snd_ctl_event {
+=09/* VIRTIO_SND_EVT_CTL_NOTIFY */
+=09struct virtio_snd_hdr hdr;
+=09/* 0 ... virtio_snd_config::controls - 1 */
+=09__le16 control_id;
+=09/* event reason bit map (1 << VIRTIO_SND_CTL_EVT_MASK_XXX) */
+=09__le16 mask;
+};
+
 #endif /* VIRTIO_SND_IF_H */
diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 2742bddb8874..a839f8c8b5e6 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -7,6 +7,7 @@ virtio_snd-objs :=3D \
 =09virtio_chmap.o \
 =09virtio_ctl_msg.o \
 =09virtio_jack.o \
+=09virtio_kctl.o \
 =09virtio_pcm.o \
 =09virtio_pcm_msg.o \
 =09virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index e2847c040f75..61df3476cf70 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -64,6 +64,9 @@ static void virtsnd_event_dispatch(struct virtio_snd *snd=
,
 =09case VIRTIO_SND_EVT_PCM_XRUN:
 =09=09virtsnd_pcm_event(snd, event);
 =09=09break;
+=09case VIRTIO_SND_EVT_CTL_NOTIFY:
+=09=09virtsnd_kctl_event(snd, event);
+=09=09break;
 =09}
 }
=20
@@ -235,6 +238,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 =09if (rc)
 =09=09return rc;
=20
+=09if (virtio_has_feature(vdev, VIRTIO_SND_F_CTLS)) {
+=09=09rc =3D virtsnd_kctl_parse_cfg(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
 =09if (snd->njacks) {
 =09=09rc =3D virtsnd_jack_build_devs(snd);
 =09=09if (rc)
@@ -253,6 +262,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 =09=09=09return rc;
 =09}
=20
+=09if (snd->nkctls) {
+=09=09rc =3D virtsnd_kctl_build_devs(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
 =09return snd_card_register(snd->card);
 }
=20
@@ -419,10 +434,16 @@ static const struct virtio_device_id id_table[] =3D {
 =09{ 0 },
 };
=20
+static unsigned int features[] =3D {
+=09VIRTIO_SND_F_CTLS
+};
+
 static struct virtio_driver virtsnd_driver =3D {
 =09.driver.name =3D KBUILD_MODNAME,
 =09.driver.owner =3D THIS_MODULE,
 =09.id_table =3D id_table,
+=09.feature_table =3D features,
+=09.feature_table_size =3D ARRAY_SIZE(features),
 =09.validate =3D virtsnd_validate,
 =09.probe =3D virtsnd_probe,
 =09.remove =3D virtsnd_remove,
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 86ef3941895e..3ceee4e416fc 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -31,6 +31,16 @@ struct virtio_snd_queue {
 =09struct virtqueue *vqueue;
 };
=20
+/**
+ * struct virtio_kctl - VirtIO control element.
+ * @kctl: ALSA control element.
+ * @items: Items for the ENUMERATED element type.
+ */
+struct virtio_kctl {
+=09struct snd_kcontrol *kctl;
+=09struct virtio_snd_ctl_enum_item *items;
+};
+
 /**
  * struct virtio_snd - VirtIO sound card device.
  * @vdev: Underlying virtio device.
@@ -45,6 +55,9 @@ struct virtio_snd_queue {
  * @nsubstreams: Number of PCM substreams.
  * @chmaps: VirtIO channel maps.
  * @nchmaps: Number of channel maps.
+ * @kctl_infos: VirtIO control element information.
+ * @kctls: VirtIO control elements.
+ * @nkctls: Number of control elements.
  */
 struct virtio_snd {
 =09struct virtio_device *vdev;
@@ -59,6 +72,9 @@ struct virtio_snd {
 =09u32 nsubstreams;
 =09struct virtio_snd_chmap_info *chmaps;
 =09u32 nchmaps;
+=09struct virtio_snd_ctl_info *kctl_infos;
+=09struct virtio_kctl *kctls;
+=09u32 nkctls;
 };
=20
 /* Message completion timeout in milliseconds (module parameter). */
@@ -108,4 +124,10 @@ int virtsnd_chmap_parse_cfg(struct virtio_snd *snd);
=20
 int virtsnd_chmap_build_devs(struct virtio_snd *snd);
=20
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_kctl_build_devs(struct virtio_snd *snd);
+
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *e=
vent);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
new file mode 100644
index 000000000000..16c48abe0ca1
--- /dev/null
+++ b/sound/virtio/virtio_kctl.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2022 OpenSynergy GmbH
+ */
+#include <sound/control.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/* Map for converting VirtIO types to ALSA types. */
+static const snd_ctl_elem_type_t g_v2a_type_map[] =3D {
+=09[VIRTIO_SND_CTL_TYPE_BOOLEAN] =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN,
+=09[VIRTIO_SND_CTL_TYPE_INTEGER] =3D SNDRV_CTL_ELEM_TYPE_INTEGER,
+=09[VIRTIO_SND_CTL_TYPE_INTEGER64] =3D SNDRV_CTL_ELEM_TYPE_INTEGER64,
+=09[VIRTIO_SND_CTL_TYPE_ENUMERATED] =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED,
+=09[VIRTIO_SND_CTL_TYPE_BYTES] =3D SNDRV_CTL_ELEM_TYPE_BYTES,
+=09[VIRTIO_SND_CTL_TYPE_IEC958] =3D SNDRV_CTL_ELEM_TYPE_IEC958
+};
+
+/* Map for converting VirtIO access rights to ALSA access rights. */
+static const unsigned int g_v2a_access_map[] =3D {
+=09[VIRTIO_SND_CTL_ACCESS_READ] =3D SNDRV_CTL_ELEM_ACCESS_READ,
+=09[VIRTIO_SND_CTL_ACCESS_WRITE] =3D SNDRV_CTL_ELEM_ACCESS_WRITE,
+=09[VIRTIO_SND_CTL_ACCESS_VOLATILE] =3D SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+=09[VIRTIO_SND_CTL_ACCESS_INACTIVE] =3D SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+=09[VIRTIO_SND_CTL_ACCESS_TLV_READ] =3D SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+=09[VIRTIO_SND_CTL_ACCESS_TLV_WRITE] =3D SNDRV_CTL_ELEM_ACCESS_TLV_WRITE,
+=09[VIRTIO_SND_CTL_ACCESS_TLV_COMMAND] =3D SNDRV_CTL_ELEM_ACCESS_TLV_COMMA=
ND
+};
+
+/* Map for converting VirtIO event masks to ALSA event masks. */
+static const unsigned int g_v2a_mask_map[] =3D {
+=09[VIRTIO_SND_CTL_EVT_MASK_VALUE] =3D SNDRV_CTL_EVENT_MASK_VALUE,
+=09[VIRTIO_SND_CTL_EVT_MASK_INFO] =3D SNDRV_CTL_EVENT_MASK_INFO,
+=09[VIRTIO_SND_CTL_EVT_MASK_TLV] =3D SNDRV_CTL_EVENT_MASK_TLV
+};
+
+/**
+ * virtsnd_kctl_info() - Returns information about the control.
+ * @kcontrol: ALSA control element.
+ * @uinfo: Element information.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_info(struct snd_kcontrol *kcontrol,
+=09=09=09     struct snd_ctl_elem_info *uinfo)
+{
+=09struct virtio_snd *snd =3D kcontrol->private_data;
+=09struct virtio_kctl *kctl =3D &snd->kctls[kcontrol->private_value];
+=09struct virtio_snd_ctl_info *kinfo =3D
+=09=09&snd->kctl_infos[kcontrol->private_value];
+=09unsigned int i;
+
+=09uinfo->type =3D g_v2a_type_map[le32_to_cpu(kinfo->type)];
+=09uinfo->count =3D le32_to_cpu(kinfo->count);
+
+=09switch (uinfo->type) {
+=09case SNDRV_CTL_ELEM_TYPE_INTEGER:
+=09=09uinfo->value.integer.min =3D
+=09=09=09le32_to_cpu(kinfo->value.integer.min);
+=09=09uinfo->value.integer.max =3D
+=09=09=09le32_to_cpu(kinfo->value.integer.max);
+=09=09uinfo->value.integer.step =3D
+=09=09=09le32_to_cpu(kinfo->value.integer.step);
+
+=09=09break;
+=09case SNDRV_CTL_ELEM_TYPE_INTEGER64:
+=09=09uinfo->value.integer64.min =3D
+=09=09=09le64_to_cpu(kinfo->value.integer64.min);
+=09=09uinfo->value.integer64.max =3D
+=09=09=09le64_to_cpu(kinfo->value.integer64.max);
+=09=09uinfo->value.integer64.step =3D
+=09=09=09le64_to_cpu(kinfo->value.integer64.step);
+
+=09=09break;
+=09case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
+=09=09i =3D uinfo->value.enumerated.item;
+=09=09if (i >=3D le32_to_cpu(kinfo->value.enumerated.items))
+=09=09=09return -EINVAL;
+
+=09=09strscpy(uinfo->value.enumerated.name, kctl->items[i].item,
+=09=09=09sizeof(uinfo->value.enumerated.name));
+
+=09=09break;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_kctl_get() - Read the value from the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
+=09=09=09    struct snd_ctl_elem_value *uvalue)
+{
+=09struct virtio_snd *snd =3D kcontrol->private_data;
+=09struct virtio_snd_ctl_info *kinfo =3D
+=09=09&snd->kctl_infos[kcontrol->private_value];
+=09unsigned int type =3D le32_to_cpu(kinfo->type);
+=09unsigned int count =3D le32_to_cpu(kinfo->count);
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_ctl_hdr *hdr;
+=09struct virtio_snd_ctl_value *kvalue;
+=09size_t request_size =3D sizeof(*hdr);
+=09size_t response_size =3D sizeof(struct virtio_snd_hdr) + sizeof(*kvalue=
);
+=09unsigned int i;
+=09int rc;
+
+=09msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09virtsnd_ctl_msg_ref(msg);
+
+=09hdr =3D virtsnd_ctl_msg_request(msg);
+=09hdr->hdr.code =3D cpu_to_le32(VIRTIO_SND_R_CTL_READ);
+=09hdr->control_id =3D cpu_to_le32(kcontrol->private_value);
+
+=09rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
+=09if (rc)
+=09=09goto on_failure;
+
+=09kvalue =3D (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
+=09=09=09  sizeof(struct virtio_snd_hdr));
+
+=09switch (type) {
+=09case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+=09case VIRTIO_SND_CTL_TYPE_INTEGER:
+=09=09for (i =3D 0; i < count; ++i)
+=09=09=09uvalue->value.integer.value[i] =3D
+=09=09=09=09le32_to_cpu(kvalue->value.integer[i]);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_INTEGER64:
+=09=09for (i =3D 0; i < count; ++i)
+=09=09=09uvalue->value.integer64.value[i] =3D
+=09=09=09=09le64_to_cpu(kvalue->value.integer64[i]);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+=09=09for (i =3D 0; i < count; ++i)
+=09=09=09uvalue->value.enumerated.item[i] =3D
+=09=09=09=09le32_to_cpu(kvalue->value.enumerated[i]);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_BYTES:
+=09=09memcpy(uvalue->value.bytes.data, kvalue->value.bytes, count);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_IEC958:
+=09=09memcpy(&uvalue->value.iec958, &kvalue->value.iec958,
+=09=09       sizeof(uvalue->value.iec958));
+=09=09break;
+=09}
+
+on_failure:
+=09virtsnd_ctl_msg_unref(msg);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_kctl_put() - Write the value to the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
+=09=09=09    struct snd_ctl_elem_value *uvalue)
+{
+=09struct virtio_snd *snd =3D kcontrol->private_data;
+=09struct virtio_snd_ctl_info *kinfo =3D
+=09=09&snd->kctl_infos[kcontrol->private_value];
+=09unsigned int type =3D le32_to_cpu(kinfo->type);
+=09unsigned int count =3D le32_to_cpu(kinfo->count);
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_ctl_hdr *hdr;
+=09struct virtio_snd_ctl_value *kvalue;
+=09size_t request_size =3D sizeof(*hdr) + sizeof(*kvalue);
+=09size_t response_size =3D sizeof(struct virtio_snd_hdr);
+=09unsigned int i;
+
+=09msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09hdr =3D virtsnd_ctl_msg_request(msg);
+=09hdr->hdr.code =3D cpu_to_le32(VIRTIO_SND_R_CTL_WRITE);
+=09hdr->control_id =3D cpu_to_le32(kcontrol->private_value);
+
+=09kvalue =3D (void *)((u8 *)hdr + sizeof(*hdr));
+
+=09switch (type) {
+=09case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+=09case VIRTIO_SND_CTL_TYPE_INTEGER:
+=09=09for (i =3D 0; i < count; ++i)
+=09=09=09kvalue->value.integer[i] =3D
+=09=09=09=09cpu_to_le32(uvalue->value.integer.value[i]);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_INTEGER64:
+=09=09for (i =3D 0; i < count; ++i)
+=09=09=09kvalue->value.integer64[i] =3D
+=09=09=09=09cpu_to_le64(uvalue->value.integer64.value[i]);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+=09=09for (i =3D 0; i < count; ++i)
+=09=09=09kvalue->value.enumerated[i] =3D
+=09=09=09=09cpu_to_le32(uvalue->value.enumerated.item[i]);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_BYTES:
+=09=09memcpy(kvalue->value.bytes, uvalue->value.bytes.data, count);
+=09=09break;
+=09case VIRTIO_SND_CTL_TYPE_IEC958:
+=09=09memcpy(&kvalue->value.iec958, &uvalue->value.iec958,
+=09=09       sizeof(kvalue->value.iec958));
+=09=09break;
+=09}
+
+=09return virtsnd_ctl_msg_send_sync(snd, msg);
+}
+
+/**
+ * virtsnd_kctl_tlv_op() - Perform an operation on the control's metadata.
+ * @kcontrol: ALSA control element.
+ * @op_flag: Operation code (SNDRV_CTL_TLV_OP_XXX).
+ * @size: Size of the TLV data in bytes.
+ * @utlv: TLV data.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
+=09=09=09       unsigned int size, unsigned int __user *utlv)
+{
+=09struct virtio_snd *snd =3D kcontrol->private_data;
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_ctl_hdr *hdr;
+=09unsigned int *tlv;
+=09struct scatterlist sg;
+=09int rc;
+
+=09msg =3D virtsnd_ctl_msg_alloc(sizeof(*hdr), sizeof(struct virtio_snd_hd=
r),
+=09=09=09=09    GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09tlv =3D kzalloc(size, GFP_KERNEL);
+=09if (!tlv) {
+=09=09virtsnd_ctl_msg_unref(msg);
+=09=09return -ENOMEM;
+=09}
+
+=09sg_init_one(&sg, tlv, size);
+
+=09hdr =3D virtsnd_ctl_msg_request(msg);
+=09hdr->control_id =3D cpu_to_le32(kcontrol->private_value);
+
+=09switch (op_flag) {
+=09case SNDRV_CTL_TLV_OP_READ:
+=09=09hdr->hdr.code =3D cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
+
+=09=09rc =3D virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+=09=09if (!rc) {
+=09=09=09if (copy_to_user(utlv, tlv, size))
+=09=09=09=09rc =3D -EFAULT;
+=09=09}
+
+=09=09break;
+=09case SNDRV_CTL_TLV_OP_WRITE:
+=09case SNDRV_CTL_TLV_OP_CMD:
+=09=09if (op_flag =3D=3D SNDRV_CTL_TLV_OP_WRITE)
+=09=09=09hdr->hdr.code =3D cpu_to_le32(VIRTIO_SND_R_CTL_TLV_WRITE);
+=09=09else
+=09=09=09hdr->hdr.code =3D
+=09=09=09=09cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
+
+=09=09if (copy_from_user(tlv, utlv, size))
+=09=09=09rc =3D -EFAULT;
+=09=09else
+=09=09=09rc =3D virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+
+=09=09break;
+=09}
+
+=09kfree(tlv);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element =
type.
+ * @snd: VirtIO sound device.
+ * @cid: Control element ID.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get_enum_items(struct virtio_snd *snd, unsigned in=
t cid)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_ctl_info *kinfo =3D &snd->kctl_infos[cid];
+=09struct virtio_kctl *kctl =3D &snd->kctls[cid];
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_ctl_hdr *hdr;
+=09unsigned int n =3D le32_to_cpu(kinfo->value.enumerated.items);
+=09struct scatterlist sg;
+
+=09msg =3D virtsnd_ctl_msg_alloc(sizeof(*hdr),
+=09=09=09=09    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09kctl->items =3D devm_kcalloc(&vdev->dev, n, sizeof(*kctl->items),
+=09=09=09=09   GFP_KERNEL);
+=09if (!kctl->items) {
+=09=09virtsnd_ctl_msg_unref(msg);
+=09=09return -ENOMEM;
+=09}
+
+=09sg_init_one(&sg, kctl->items, n * sizeof(*kctl->items));
+
+=09hdr =3D virtsnd_ctl_msg_request(msg);
+=09hdr->hdr.code =3D cpu_to_le32(VIRTIO_SND_R_CTL_ENUM_ITEMS);
+=09hdr->control_id =3D cpu_to_le32(cid);
+
+=09return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+}
+
+/**
+ * virtsnd_kctl_parse_cfg() - Parse the control element configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09u32 i;
+=09int rc;
+
+=09virtio_cread_le(vdev, struct virtio_snd_config, controls,
+=09=09=09&snd->nkctls);
+=09if (!snd->nkctls)
+=09=09return 0;
+
+=09snd->kctl_infos =3D devm_kcalloc(&vdev->dev, snd->nkctls,
+=09=09=09=09       sizeof(*snd->kctl_infos), GFP_KERNEL);
+=09if (!snd->kctl_infos)
+=09=09return -ENOMEM;
+
+=09snd->kctls =3D devm_kcalloc(&vdev->dev, snd->nkctls, sizeof(*snd->kctls=
),
+=09=09=09=09  GFP_KERNEL);
+=09if (!snd->kctls)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CTL_INFO, 0, snd->nkctl=
s,
+=09=09=09=09    sizeof(*snd->kctl_infos), snd->kctl_infos);
+=09if (rc)
+=09=09return rc;
+
+=09for (i =3D 0; i < snd->nkctls; ++i) {
+=09=09struct virtio_snd_ctl_info *kinfo =3D &snd->kctl_infos[i];
+=09=09unsigned int type =3D le32_to_cpu(kinfo->type);
+
+=09=09if (type =3D=3D VIRTIO_SND_CTL_TYPE_ENUMERATED) {
+=09=09=09rc =3D virtsnd_kctl_get_enum_items(snd, i);
+=09=09=09if (rc)
+=09=09=09=09return rc;
+=09=09}
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_kctl_build_devs() - Build ALSA control elements.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_build_devs(struct virtio_snd *snd)
+{
+=09unsigned int cid;
+
+=09for (cid =3D 0; cid < snd->nkctls; ++cid) {
+=09=09struct virtio_snd_ctl_info *kinfo =3D &snd->kctl_infos[cid];
+=09=09struct virtio_kctl *kctl =3D &snd->kctls[cid];
+=09=09struct snd_kcontrol_new kctl_new;
+=09=09unsigned int i;
+=09=09int rc;
+
+=09=09memset(&kctl_new, 0, sizeof(kctl_new));
+
+=09=09kctl_new.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
+=09=09kctl_new.name =3D kinfo->name;
+=09=09kctl_new.index =3D le32_to_cpu(kinfo->index);
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_access_map); ++i)
+=09=09=09if (le32_to_cpu(kinfo->access) & (1 << i))
+=09=09=09=09kctl_new.access |=3D g_v2a_access_map[i];
+
+=09=09if (kctl_new.access & (SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+=09=09=09=09       SNDRV_CTL_ELEM_ACCESS_TLV_WRITE |
+=09=09=09=09       SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND)) {
+=09=09=09kctl_new.access |=3D SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+=09=09=09kctl_new.tlv.c =3D virtsnd_kctl_tlv_op;
+=09=09}
+
+=09=09kctl_new.info =3D virtsnd_kctl_info;
+=09=09kctl_new.get =3D virtsnd_kctl_get;
+=09=09kctl_new.put =3D virtsnd_kctl_put;
+=09=09kctl_new.private_value =3D cid;
+
+=09=09kctl->kctl =3D snd_ctl_new1(&kctl_new, snd);
+=09=09if (!kctl->kctl)
+=09=09=09return -ENOMEM;
+
+=09=09rc =3D snd_ctl_add(snd->card, kctl->kctl);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_kctl_event() - Handle the control element event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *e=
vent)
+{
+=09struct virtio_snd_ctl_event *kevent =3D
+=09=09(struct virtio_snd_ctl_event *)event;
+=09struct virtio_kctl *kctl;
+=09unsigned int cid =3D le16_to_cpu(kevent->control_id);
+=09unsigned int mask =3D 0;
+=09unsigned int i;
+
+=09if (cid >=3D snd->nkctls)
+=09=09return;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_mask_map); ++i)
+=09=09if (le16_to_cpu(kevent->mask) & (1 << i))
+=09=09=09mask |=3D g_v2a_mask_map[i];
+
+
+=09kctl =3D &snd->kctls[cid];
+
+=09snd_ctl_notify(snd->card, mask, &kctl->kctl->id);
+}
--=20
2.35.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

