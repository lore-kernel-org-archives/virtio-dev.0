Return-Path: virtio-dev-return-6825-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D85ED984325
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Mar 2020 14:33:16 +0000 (UTC)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun,  1 Mar 2020 16:33:02 +0200
Message-Id: <20200301143302.8556-4-yuri.benditovich@daynix.com>
In-Reply-To: <20200301143302.8556-1-yuri.benditovich@daynix.com>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
Subject: [virtio-dev] [PATCH v3 3/3] virtio-net: Introduce hash report feature
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The feature VIRTIO_NET_F_HASH_REPORT extends the
layout of the packet and requests the device to
calculate hash on incoming packets and report it
in the packet header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h
index 188ad3eecdc8..4bd940501ba6 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 =09=09=09=09=09 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
=20
+#define VIRTIO_NET_F_HASH_REPORT  57=09/* Supports hash report */
 #define VIRTIO_NET_F_RSS=09  60=09/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT=09  61=09/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another device
@@ -154,6 +155,23 @@ struct virtio_net_hdr_v1 {
 =09__virtio16 num_buffers;=09/* Number of merged rx buffers */
 };
=20
+struct virtio_net_hdr_v1_hash {
+=09struct virtio_net_hdr_v1 hdr;
+=09__le32 hash_value;
+#define VIRTIO_NET_HASH_REPORT_NONE            0
+#define VIRTIO_NET_HASH_REPORT_IPv4            1
+#define VIRTIO_NET_HASH_REPORT_TCPv4           2
+#define VIRTIO_NET_HASH_REPORT_UDPv4           3
+#define VIRTIO_NET_HASH_REPORT_IPv6            4
+#define VIRTIO_NET_HASH_REPORT_TCPv6           5
+#define VIRTIO_NET_HASH_REPORT_UDPv6           6
+#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
+#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
+#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+=09__le16 hash_report;
+=09__le16 padding;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
@@ -302,6 +320,24 @@ struct virtio_net_rss_config {
=20
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
=20
+/*
+ * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the device
+ * to include in the virtio header of the packet the value of the
+ * calculated hash and the report type of hash. It also provides
+ * parameters for hash calculation. The command requires feature
+ * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
+ * layout of virtio header as defined in virtio_net_hdr_v1_hash.
+ */
+struct virtio_net_hash_config {
+=09__le32 hash_types;
+=09/* for compatibility with virtio_net_rss_config */
+=09__le16 reserved[4];
+=09__u8 hash_key_length;
+=09__u8 hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
 /*
  * Control network offloads
  *
--=20
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

