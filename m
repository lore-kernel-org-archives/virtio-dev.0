Return-Path: <virtio-dev-return-9902-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EBD59864A6
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 02:17:36 +0000 (UTC)
Message-ID: <a5e1eae0-d977-a625-afa7-69582bf49cb8@redhat.com>
Date: Wed, 7 Sep 2022 10:17:22 +0800
MIME-Version: 1.0
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901021038.84751-3-gavinl@nvidia.com>
Subject: Re: [virtio-dev] [PATCH v5 2/2] virtio-net: use mtu size as buffer
 length for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gavin Li <gavinl@nvidia.com>, stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com
Cc: gavi@nvidia.com, parav@nvidia.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/9/1 10:10, Gavin Li =E5=86=99=E9=81=93:
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if guest GSO is not supported, it would be sufficient to
> allocate segments to cover just up the MTU size and no further.
> Allocating the maximum amount of segments results in a large waste of
> buffer space in the queue, which limits the number of packets that can
> be buffered and can result in reduced performance.
>
> Therefore, if guest GSO is not supported, use the MTU to calculate the
> optimal amount of segments required.
>
> When guest offload is enabled at runtime, RQ already has packets of bytes
> less than 64K. So when packet of 64KB arrives, all the packets of such
> size will be dropped. and RQ is now not usable.
>
> So this means that during set_guest_offloads() phase, RQs have to be
> destroyed and recreated, which requires almost driver reload.
>
> If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
> always treat them as GSO enabled.
>
> Accordingly, for now the assumption is that if guest GSO has been
> negotiated then it has been enabled, even if it's actually been disabled
> at runtime through VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.


Nit: Actually, it's not the assumption but the behavior of the codes=20
itself. Since we don't try to change guest offloading in probe so it's=20
ok to check GSO via negotiated features?

Thanks


>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>               Before   After
>    1500        22.5     22.4
>    9000        12.8     25.9
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> changelog:
> v4->v5
> - Addressed comments from Michael S. Tsirkin
> - Improve commit message
> v3->v4
> - Addressed comments from Si-Wei
> - Rename big_packets_sg_num with big_packets_num_skbfrags
> v2->v3
> - Addressed comments from Si-Wei
> - Simplify the condition check to enable the optimization
> v1->v2
> - Addressed comments from Jason, Michael, Si-Wei.
> - Remove the flag of guest GSO support, set sg_num for big packets and
>    use it directly
> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> - Replace the round up algorithm with DIV_ROUND_UP
> ---
>   drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f831a0290998..dbffd5f56fb8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -225,6 +225,9 @@ struct virtnet_info {
>   =09/* I like... big packets and I cannot lie! */
>   =09bool big_packets;
>  =20
> +=09/* number of sg entries allocated for big packets */
> +=09unsigned int big_packets_num_skbfrags;
> +
>   =09/* Host will merge rx buffers for big packets (shake it! shake it!) =
*/
>   =09bool mergeable_rx_bufs;
>  =20
> @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *v=
i, struct receive_queue *rq,
>   =09char *p;
>   =09int i, err, offset;
>  =20
> -=09sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +=09sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
>  =20
> -=09/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> -=09for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
> +=09/* page in rq->sg[vi->big_packets_num_skbfrags + 1] is list tail */
> +=09for (i =3D vi->big_packets_num_skbfrags + 1; i > 1; --i) {
>   =09=09first =3D get_a_page(rq, gfp);
>   =09=09if (!first) {
>   =09=09=09if (list)
> @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi,=
 struct receive_queue *rq,
>  =20
>   =09/* chain first in list head */
>   =09first->private =3D (unsigned long)list;
> -=09err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +=09err =3D virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_skbfr=
ags + 2,
>   =09=09=09=09  first, gfp);
>   =09if (err < 0)
>   =09=09give_pages(rq, first);
> @@ -3690,13 +3693,27 @@ static bool virtnet_check_guest_gso(const struct =
virtnet_info *vi)
>   =09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);
>   }
>  =20
> +static void virtnet_set_big_packets_fields(struct virtnet_info *vi, cons=
t int mtu)
> +{
> +=09bool guest_gso =3D virtnet_check_guest_gso(vi);
> +
> +=09/* If device can receive ANY guest GSO packets, regardless of mtu,
> +=09 * allocate packets of maximum size, otherwise limit it to only
> +=09 * mtu size worth only.
> +=09 */
> +=09if (mtu > ETH_DATA_LEN || guest_gso) {
> +=09=09vi->big_packets =3D true;
> +=09=09vi->big_packets_num_skbfrags =3D guest_gso ? MAX_SKB_FRAGS : DIV_R=
OUND_UP(mtu, PAGE_SIZE);
> +=09}
> +}
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   =09int i, err =3D -ENOMEM;
>   =09struct net_device *dev;
>   =09struct virtnet_info *vi;
>   =09u16 max_queue_pairs;
> -=09int mtu;
> +=09int mtu =3D 0;
>  =20
>   =09/* Find if host supports multiqueue/rss virtio_net device */
>   =09max_queue_pairs =3D 1;
> @@ -3784,10 +3801,6 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>   =09INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>   =09spin_lock_init(&vi->refill_lock);
>  =20
> -=09/* If we can receive ANY GSO packets, we must allocate large ones. */
> -=09if (virtnet_check_guest_gso(vi))
> -=09=09vi->big_packets =3D true;
> -
>   =09if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>   =09=09vi->mergeable_rx_bufs =3D true;
>  =20
> @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
>  =20
>   =09=09dev->mtu =3D mtu;
>   =09=09dev->max_mtu =3D mtu;
> -
> -=09=09/* TODO: size buffers correctly in this case. */
> -=09=09if (dev->mtu > ETH_DATA_LEN)
> -=09=09=09vi->big_packets =3D true;
>   =09}
>  =20
> +=09virtnet_set_big_packets_fields(vi, mtu);
> +
>   =09if (vi->any_header_sg)
>   =09=09dev->needed_headroom =3D vi->hdr_len;
>  =20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

