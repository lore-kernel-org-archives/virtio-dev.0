Return-Path: <virtio-dev-return-9688-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B5BD98658D
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Aug 2022 05:01:02 +0000 (UTC)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
In-Reply-To: <20220802044548.9031-1-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 13:00:46 +0800
Message-ID: <CACGkMEvKVHNxMuU6ksZ7Apbbi0-cnHpY5DDwCenXXmbN_mEDPA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset="UTF-8"
To: Gavin Li <gavinl@nvidia.com>
Cc: mst <mst@redhat.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, loseweigh@gmail.com, Parav Pandit <parav@nvidia.com>, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 2, 2022 at 12:47 PM Gavin Li <gavinl@nvidia.com> wrote:
>
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if GSO is not supported, it would be sufficient to allocate
> segments to cover just up the MTU size and no further. Allocating the
> maximum amount of segments results in a large waste of buffer space in
> the queue, which limits the number of packets that can be buffered and
> can result in reduced performance.
>
> Therefore, if GSO is not supported, use the MTU to calculate the
> optimal amount of segments required.
>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>              Before   After
>   1500        22.5     22.4
>   9000        12.8     25.9
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec8e1b3108c3..d36918c1809d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -222,6 +222,9 @@ struct virtnet_info {
>         /* I like... big packets and I cannot lie! */
>         bool big_packets;
>
> +       /* Indicates GSO support */
> +       bool gso_is_supported;
> +
>         /* Host will merge rx buffers for big packets (shake it! shake it!) */
>         bool mergeable_rx_bufs;
>
> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>                            gfp_t gfp)
>  {
> +       unsigned int sg_num = MAX_SKB_FRAGS;
>         struct page *first, *list = NULL;
>         char *p;
>         int i, err, offset;
>
> -       sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +       if (!vi->gso_is_supported) {
> +               unsigned int mtu = vi->dev->mtu;
> +
> +               sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
> +       }
> +
> +       sg_init_table(rq->sg, sg_num + 2);
>
>         /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> -       for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +       for (i = sg_num + 1; i > 1; --i) {
>                 first = get_a_page(rq, gfp);
>                 if (!first) {
>                         if (list)
> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>
>         /* chain first in list head */
>         first->private = (unsigned long)list;
> -       err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +       err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>                                   first, gfp);
>         if (err < 0)
>                 give_pages(rq, first);
> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>                 vi->big_packets = true;
> +               vi->gso_is_supported = true;

Why not simply re-use big_packets here?

Thanks

> +       }
>
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>                 vi->mergeable_rx_bufs = true;
> --
> 2.31.1
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

