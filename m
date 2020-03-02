Return-Path: virtio-dev-return-6838-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55C57984063
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 11:52:00 +0000 (UTC)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon,  2 Mar 2020 13:50:01 +0200
Message-Id: <20200302115003.14877-2-yuri.benditovich@daynix.com>
In-Reply-To: <20200302115003.14877-1-yuri.benditovich@daynix.com>
References: <20200302115003.14877-1-yuri.benditovich@daynix.com>
Subject: [virtio-dev] [PATCH v4 1/3] virtio-net: Introduce extended RSC feature
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
is able to provide extended RSC information. When the feature
is negotiatede and 'gso_type' field in received packet is not
GSO_NONE, the device reports number of coalesced packets in
'csum_start' field and number of duplicated acks in 'csum_offset'
field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h
index a3715a3224c1..6466c5979a93 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 =09=09=09=09=09 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
=20
+#define VIRTIO_NET_F_RSC_EXT=09  61=09/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another device
 =09=09=09=09=09 * with the same MAC.
 =09=09=09=09=09 */
@@ -104,6 +105,7 @@ struct virtio_net_config {
 struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM=091=09/* Use csum_start, csum_offset *=
/
 #define VIRTIO_NET_HDR_F_DATA_VALID=092=09/* Csum is valid */
+#define VIRTIO_NET_HDR_F_RSC_INFO=094=09/* rsc info in csum_ fields */
 =09__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE=09=090=09/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4=091=09/* GSO frame, IPv4 TCP (TSO) */
@@ -113,8 +115,26 @@ struct virtio_net_hdr_v1 {
 =09__u8 gso_type;
 =09__virtio16 hdr_len;=09/* Ethernet + IP + tcp/udp hdrs */
 =09__virtio16 gso_size;=09/* Bytes to append to hdr_len per frame */
-=09__virtio16 csum_start;=09/* Position to start checksumming from */
-=09__virtio16 csum_offset;=09/* Offset after that to place checksum */
+=09union {
+=09=09struct {
+=09=09=09__virtio16 csum_start;
+=09=09=09__virtio16 csum_offset;
+=09=09};
+=09=09/* Checksum calculation */
+=09=09struct {
+=09=09=09/* Position to start checksumming from */
+=09=09=09__virtio16 start;
+=09=09=09/* Offset after that to place checksum */
+=09=09=09__virtio16 offset;
+=09=09} csum;
+=09=09/* Receive Segment Coalescing */
+=09=09struct {
+=09=09=09/* Number of coalesced segments */
+=09=09=09__le16 segments;
+=09=09=09/* Number of duplicated acks */
+=09=09=09__le16 dup_acks;
+=09=09} rsc;
+=09};
 =09__virtio16 num_buffers;=09/* Number of merged rx buffers */
 };
=20
--=20
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

