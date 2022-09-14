Return-Path: <virtio-dev-return-9947-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC82D9866CF
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Sep 2022 14:50:23 +0000 (UTC)
From: Gavin Li <gavinl@nvidia.com>
Date: Wed, 14 Sep 2022 17:49:11 +0300
Message-ID: <20220914144911.56422-3-gavinl@nvidia.com>
In-Reply-To: <20220914144911.56422-1-gavinl@nvidia.com>
References: <20220914144911.56422-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v6 2/2] virtio-net: use mtu size as buffer length for big packets
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
packets even when GUEST_* offloads are not present on the device.
However, if guest GSO is not supported, it would be sufficient to
allocate segments to cover just up the MTU size and no further.
Allocating the maximum amount of segments results in a large waste of
buffer space in the queue, which limits the number of packets that can
be buffered and can result in reduced performance.

Therefore, if guest GSO is not supported, use the MTU to calculate the
optimal amount of segments required.

Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
1 VQ, queue size 1024, before and after the change, with the iperf
server running over the virtio-net interface.

MTU(Bytes)/Bandwidth (Gbit/s)
             Before   After
  1500        22.5     22.4
  9000        12.8     25.9

And result of queue size 256.
MTU(Bytes)/Bandwidth (Gbit/s)
             Before   After
  9000        2.15     11.9

With this patch no degradation is observed with multiple below tests and
feature bit combinations. Results are summarized below for q depth of
1024. Interface MTU is 1500 if MTU feature is disabled. MTU is set to 9000
in other tests.

Features/              Bandwidth (Gbit/s)
                         Before   After
mtu off                   20.1     20.2
mtu/indirect on           17.4     17.3
mtu/indirect/packed on    17.2     17.2

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Gavi Teitz <gavi@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
changelog:
v5->v6
- Addressed comments from Jason and Michael S. Tsirkin
- Remove wrong commit log description
- Rename virtnet_set_big_packets_fields with virtnet_set_big_packets
- Add more test results for different feature combinations
v4->v5
- Addressed comments from Michael S. Tsirkin
- Improve commit message
v3->v4
- Addressed comments from Si-Wei
- Rename big_packets_sg_num with big_packets_num_skbfrags
v2->v3
- Addressed comments from Si-Wei
- Simplify the condition check to enable the optimization
v1->v2
- Addressed comments from Jason, Michael, Si-Wei.
- Remove the flag of guest GSO support, set sg_num for big packets and
  use it directly
- Recalculate sg_num for big packets in virtnet_set_guest_offloads
- Replace the round up algorithm with DIV_ROUND_UP
---
 drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f54c7182758f..7106932c6f88 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -225,6 +225,9 @@ struct virtnet_info {
 =09/* I like... big packets and I cannot lie! */
 =09bool big_packets;
=20
+=09/* number of sg entries allocated for big packets */
+=09unsigned int big_packets_num_skbfrags;
+
 =09/* Host will merge rx buffers for big packets (shake it! shake it!) */
 =09bool mergeable_rx_bufs;
=20
@@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *vi,=
 struct receive_queue *rq,
 =09char *p;
 =09int i, err, offset;
=20
-=09sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
+=09sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
=20
-=09/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
-=09for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
+=09/* page in rq->sg[vi->big_packets_num_skbfrags + 1] is list tail */
+=09for (i =3D vi->big_packets_num_skbfrags + 1; i > 1; --i) {
 =09=09first =3D get_a_page(rq, gfp);
 =09=09if (!first) {
 =09=09=09if (list)
@@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, s=
truct receive_queue *rq,
=20
 =09/* chain first in list head */
 =09first->private =3D (unsigned long)list;
-=09err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
+=09err =3D virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_skbfrag=
s + 2,
 =09=09=09=09  first, gfp);
 =09if (err < 0)
 =09=09give_pages(rq, first);
@@ -3690,13 +3693,27 @@ static bool virtnet_check_guest_gso(const struct vi=
rtnet_info *vi)
 =09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);
 }
=20
+static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu=
)
+{
+=09bool guest_gso =3D virtnet_check_guest_gso(vi);
+
+=09/* If device can receive ANY guest GSO packets, regardless of mtu,
+=09 * allocate packets of maximum size, otherwise limit it to only
+=09 * mtu size worth only.
+=09 */
+=09if (mtu > ETH_DATA_LEN || guest_gso) {
+=09=09vi->big_packets =3D true;
+=09=09vi->big_packets_num_skbfrags =3D guest_gso ? MAX_SKB_FRAGS : DIV_ROU=
ND_UP(mtu, PAGE_SIZE);
+=09}
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 =09int i, err =3D -ENOMEM;
 =09struct net_device *dev;
 =09struct virtnet_info *vi;
 =09u16 max_queue_pairs;
-=09int mtu;
+=09int mtu =3D 0;
=20
 =09/* Find if host supports multiqueue/rss virtio_net device */
 =09max_queue_pairs =3D 1;
@@ -3784,10 +3801,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 =09INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 =09spin_lock_init(&vi->refill_lock);
=20
-=09/* If we can receive ANY GSO packets, we must allocate large ones. */
-=09if (virtnet_check_guest_gso(vi))
-=09=09vi->big_packets =3D true;
-
 =09if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 =09=09vi->mergeable_rx_bufs =3D true;
=20
@@ -3853,12 +3866,10 @@ static int virtnet_probe(struct virtio_device *vdev=
)
=20
 =09=09dev->mtu =3D mtu;
 =09=09dev->max_mtu =3D mtu;
-
-=09=09/* TODO: size buffers correctly in this case. */
-=09=09if (dev->mtu > ETH_DATA_LEN)
-=09=09=09vi->big_packets =3D true;
 =09}
=20
+=09virtnet_set_big_packets(vi, mtu);
+
 =09if (vi->any_header_sg)
 =09=09dev->needed_headroom =3D vi->hdr_len;
=20
--=20
2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

