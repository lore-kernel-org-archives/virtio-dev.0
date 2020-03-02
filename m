Return-Path: virtio-dev-return-6839-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C839F985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 11:52:05 +0000 (UTC)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon,  2 Mar 2020 13:50:02 +0200
Message-Id: <20200302115003.14877-3-yuri.benditovich@daynix.com>
In-Reply-To: <20200302115003.14877-1-yuri.benditovich@daynix.com>
References: <20200302115003.14877-1-yuri.benditovich@daynix.com>
Subject: [virtio-dev] [PATCH v4 2/3] virtio-net: Introduce RSS receive steering feature
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

RSS (Receive-side scaling) defines hash calculation
rules and decision on receive virtqueue according to
the calculated hash, provided mask to apply and
provided indirection table containing indices of
receive virqueues. The driver sends the control
command to enable multiqueue and provide parameters
for receive steering.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h
index 6466c5979a93..aec6fac3666a 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 =09=09=09=09=09 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
=20
+#define VIRTIO_NET_F_RSS=09  60=09/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT=09  61=09/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another device
 =09=09=09=09=09 * with the same MAC.
@@ -70,6 +71,17 @@
 #define VIRTIO_NET_S_LINK_UP=091=09/* Link is up */
 #define VIRTIO_NET_S_ANNOUNCE=092=09/* Announcement is needed */
=20
+/* supported/enabled hash types */
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
+#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
+
 struct virtio_net_config {
 =09/* The config defining mac address (if VIRTIO_NET_F_MAC) */
 =09__u8 mac[ETH_ALEN];
@@ -93,6 +105,12 @@ struct virtio_net_config {
 =09 * Any other value stands for unknown.
 =09 */
 =09__u8 duplex;
+=09/* maximum size of RSS key */
+=09__u8 rss_max_key_size;
+=09/* maximum number of indirection table entries */
+=09__le16 rss_max_indirection_table_length;
+=09/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+=09__le32 supported_hash_types;
 } __attribute__((packed));
=20
 /*
@@ -248,7 +266,9 @@ struct virtio_net_ctrl_mac {
=20
 /*
  * Control Receive Flow Steering
- *
+ */
+#define VIRTIO_NET_CTRL_MQ   4
+/*
  * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
  * enables Receive Flow Steering, specifying the number of the transmit an=
d
  * receive queues that will be used. After the command is consumed and ack=
ed by
@@ -261,11 +281,29 @@ struct virtio_net_ctrl_mq {
 =09__virtio16 virtqueue_pairs;
 };
=20
-#define VIRTIO_NET_CTRL_MQ   4
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
=20
+/*
+ * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
+ * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
+ * the receive steering to use a hash calculated for incoming packet
+ * to decide on receive virtqueue to place the packet. The command
+ * also provides parameters to calculate a hash and receive virtqueue.
+ */
+struct virtio_net_rss_config {
+=09__le32 hash_types;
+=09__le16 indirection_table_mask;
+=09__le16 unclassified_queue;
+=09__le16 indirection_table[1/* + indirection_table_mask */];
+=09__le16 max_tx_vq;
+=09__u8 hash_key_length;
+=09__u8 hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+
 /*
  * Control network offloads
  *
--=20
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

