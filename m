Return-Path: <virtio-dev-return-9702-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B16B498659A
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Aug 2022 22:12:09 +0000 (UTC)
Message-ID: <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
Date: Fri, 5 Aug 2022 15:11:43 -0700
References: <20220802044548.9031-1-gavinl@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <20220802044548.9031-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: parav@nvidia.com, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 8/1/2022 9:45 PM, Gavin Li wrote:
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if GSO is not supported,
GUEST GSO (virtio term), or GRO HW (netdev core term) it should have 
been be called.

>   it would be sufficient to allocate
> segments to cover just up the MTU size and no further. Allocating the
> maximum amount of segments results in a large waste of buffer space in
> the queue, which limits the number of packets that can be buffered and
> can result in reduced performance.
>
> Therefore, if GSO is not supported,
Ditto.

> use the MTU to calculate the
> optimal amount of segments required.
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
> ---
>   drivers/net/virtio_net.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec8e1b3108c3..d36918c1809d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -222,6 +222,9 @@ struct virtnet_info {
>   	/* I like... big packets and I cannot lie! */
>   	bool big_packets;
>   
> +	/* Indicates GSO support */
> +	bool gso_is_supported;
> +
>   	/* Host will merge rx buffers for big packets (shake it! shake it!) */
>   	bool mergeable_rx_bufs;
>   
> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>   static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   			   gfp_t gfp)
>   {
> +	unsigned int sg_num = MAX_SKB_FRAGS;
>   	struct page *first, *list = NULL;
>   	char *p;
>   	int i, err, offset;
>   
> -	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +	if (!vi->gso_is_supported) {
> +		unsigned int mtu = vi->dev->mtu;
> +
> +		sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
DIV_ROUND_UP() can be used?

Since this branch slightly adds up cost to the datapath, I wonder if 
this sg_num can be saved and set only once (generally in virtnet_probe 
time) in struct virtnet_info?
> +	}
> +
> +	sg_init_table(rq->sg, sg_num + 2);
>   
>   	/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
Comment doesn't match code.
> -	for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +	for (i = sg_num + 1; i > 1; --i) {
>   		first = get_a_page(rq, gfp);
>   		if (!first) {
>   			if (list)
> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   
>   	/* chain first in list head */
>   	first->private = (unsigned long)list;
> -	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +	err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>   				  first, gfp);
>   	if (err < 0)
>   		give_pages(rq, first);
> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>   	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>   	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>   		vi->big_packets = true;
> +		vi->gso_is_supported = true;
Please do the same for virtnet_clear_guest_offloads(), and 
correspondingly virtnet_restore_guest_offloads() as well. Not sure why 
virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on 
successful return, seems like a bug to me.


Thanks,
-Siwei
> +	}
>   
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>   		vi->mergeable_rx_bufs = true;


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

