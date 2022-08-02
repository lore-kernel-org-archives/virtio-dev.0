Return-Path: <virtio-dev-return-9679-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFD0B98649F
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Aug 2022 04:45:57 +0000 (UTC)
From: Gavin Li <gavinl@nvidia.com>
Date: Tue,  2 Aug 2022 07:45:48 +0300
Message-Id: <20220802044548.9031-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for big packets
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: gavinl@nvidia.com, parav@nvidia.com, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
packets even when GUEST_* offloads are not present on the device.
However, if GSO is not supported, it would be sufficient to allocate
segments to cover just up the MTU size and no further. Allocating the
maximum amount of segments results in a large waste of buffer space in
the queue, which limits the number of packets that can be buffered and
can result in reduced performance.

Therefore, if GSO is not supported, use the MTU to calculate the
optimal amount of segments required.

Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
1 VQ, queue size 1024, before and after the change, with the iperf
server running over the virtio-net interface.

MTU(Bytes)/Bandwidth (Gbit/s)
             Before   After
  1500        22.5     22.4
  9000        12.8     25.9

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Gavi Teitz <gavi@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ec8e1b3108c3..d36918c1809d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -222,6 +222,9 @@ struct virtnet_info {
 =09/* I like... big packets and I cannot lie! */
 =09bool big_packets;
=20
+=09/* Indicates GSO support */
+=09bool gso_is_supported;
+
 =09/* Host will merge rx buffers for big packets (shake it! shake it!) */
 =09bool mergeable_rx_bufs;
=20
@@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
 static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *=
rq,
 =09=09=09   gfp_t gfp)
 {
+=09unsigned int sg_num =3D MAX_SKB_FRAGS;
 =09struct page *first, *list =3D NULL;
 =09char *p;
 =09int i, err, offset;
=20
-=09sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
+=09if (!vi->gso_is_supported) {
+=09=09unsigned int mtu =3D vi->dev->mtu;
+
+=09=09sg_num =3D (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE=
;
+=09}
+
+=09sg_init_table(rq->sg, sg_num + 2);
=20
 =09/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
-=09for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
+=09for (i =3D sg_num + 1; i > 1; --i) {
 =09=09first =3D get_a_page(rq, gfp);
 =09=09if (!first) {
 =09=09=09if (list)
@@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, s=
truct receive_queue *rq,
=20
 =09/* chain first in list head */
 =09first->private =3D (unsigned long)list;
-=09err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
+=09err =3D virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
 =09=09=09=09  first, gfp);
 =09if (err < 0)
 =09=09give_pages(rq, first);
@@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 =09if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 =09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 =09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
-=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
+=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
 =09=09vi->big_packets =3D true;
+=09=09vi->gso_is_supported =3D true;
+=09}
=20
 =09if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 =09=09vi->mergeable_rx_bufs =3D true;
--=20
2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

