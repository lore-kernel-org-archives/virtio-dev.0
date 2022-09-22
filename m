Return-Path: <virtio-dev-return-9971-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C9539865F9
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Sep 2022 10:15:09 +0000 (UTC)
Date: Thu, 22 Sep 2022 06:14:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220922060753-mutt-send-email-mst@kernel.org>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220922052734-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481374E6A14EFC39533F9A8DC4E9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481374E6A14EFC39533F9A8DC4E9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 22, 2022 at 10:04:53AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 22, 2022 5:35 AM
> > 
> > On Thu, Sep 01, 2022 at 05:10:38AM +0300, Gavin Li wrote:
> > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > > packets even when GUEST_* offloads are not present on the device.
> > > However, if guest GSO is not supported, it would be sufficient to
> > > allocate segments to cover just up the MTU size and no further.
> > > Allocating the maximum amount of segments results in a large waste of
> > > buffer space in the queue, which limits the number of packets that can
> > > be buffered and can result in reduced performance.
> > >
> > > Therefore, if guest GSO is not supported, use the MTU to calculate the
> > > optimal amount of segments required.
> > >
> > > When guest offload is enabled at runtime, RQ already has packets of
> > > bytes less than 64K. So when packet of 64KB arrives, all the packets
> > > of such size will be dropped. and RQ is now not usable.
> > >
> > > So this means that during set_guest_offloads() phase, RQs have to be
> > > destroyed and recreated, which requires almost driver reload.
> > >
> > > If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it
> > > should always treat them as GSO enabled.
> > >
> > > Accordingly, for now the assumption is that if guest GSO has been
> > > negotiated then it has been enabled, even if it's actually been
> > > disabled at runtime through VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > >
> > > Below is the iperf TCP test results over a Mellanox NIC, using vDPA
> > > for
> > > 1 VQ, queue size 1024, before and after the change, with the iperf
> > > server running over the virtio-net interface.
> > >
> > > MTU(Bytes)/Bandwidth (Gbit/s)
> > >              Before   After
> > >   1500        22.5     22.4
> > >   9000        12.8     25.9
> > >
> > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > 
> > OK I think the logic is correct, it's just a bit harder to read than necessary.
> > Small improvement suggestions:
> > 
> > 
> > > ---
> > > changelog:
> > > v4->v5
> > > - Addressed comments from Michael S. Tsirkin
> > > - Improve commit message
> > > v3->v4
> > > - Addressed comments from Si-Wei
> > > - Rename big_packets_sg_num with big_packets_num_skbfrags
> > > v2->v3
> > > - Addressed comments from Si-Wei
> > > - Simplify the condition check to enable the optimization
> > > v1->v2
> > > - Addressed comments from Jason, Michael, Si-Wei.
> > > - Remove the flag of guest GSO support, set sg_num for big packets and
> > >   use it directly
> > > - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> > > - Replace the round up algorithm with DIV_ROUND_UP
> > > ---
> > >  drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++-------------
> > >  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > f831a0290998..dbffd5f56fb8 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -225,6 +225,9 @@ struct virtnet_info {
> > >  	/* I like... big packets and I cannot lie! */
> > >  	bool big_packets;
> > >
> > > +	/* number of sg entries allocated for big packets */
> > > +	unsigned int big_packets_num_skbfrags;
> > > +
> > >  	/* Host will merge rx buffers for big packets (shake it! shake it!) */
> > >  	bool mergeable_rx_bufs;
> > >
> > 
> > big_packets_num_skbfrags -> big_packet_num_skbfrags
> > 
> > > @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info
> > *vi, struct receive_queue *rq,
> > >  	char *p;
> > >  	int i, err, offset;
> > >
> > > -	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > > +	sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
> > >
> > > -	/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > > -	for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> > > +	/* page in rq->sg[vi->big_packets_num_skbfrags + 1] is list tail */
> > > +	for (i = vi->big_packets_num_skbfrags + 1; i > 1; --i) {
> > >  		first = get_a_page(rq, gfp);
> > >  		if (!first) {
> > >  			if (list)
> > > @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info
> > > *vi, struct receive_queue *rq,
> > >
> > >  	/* chain first in list head */
> > >  	first->private = (unsigned long)list;
> > > -	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > > +	err = virtqueue_add_inbuf(rq->vq, rq->sg,
> > > +vi->big_packets_num_skbfrags + 2,
> > >  				  first, gfp);
> > >  	if (err < 0)
> > >  		give_pages(rq, first);
> > > @@ -3690,13 +3693,27 @@ static bool virtnet_check_guest_gso(const
> > struct virtnet_info *vi)
> > >  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);  }
> > >
> > > +static void virtnet_set_big_packets_fields(struct virtnet_info *vi,
> > > +const int mtu) {
> > > +	bool guest_gso = virtnet_check_guest_gso(vi);
> > > +
> > > +	/* If device can receive ANY guest GSO packets, regardless of mtu,
> > > +	 * allocate packets of maximum size, otherwise limit it to only
> > > +	 * mtu size worth only.
> > > +	 */
> > > +	if (mtu > ETH_DATA_LEN || guest_gso) {
> > > +		vi->big_packets = true;
> > > +		vi->big_packets_num_skbfrags = guest_gso ?
> > MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);
> > > +	}
> > > +}
> > > +
> > >  static int virtnet_probe(struct virtio_device *vdev)  {
> > >  	int i, err = -ENOMEM;
> > >  	struct net_device *dev;
> > >  	struct virtnet_info *vi;
> > >  	u16 max_queue_pairs;
> > > -	int mtu;
> > > +	int mtu = 0;
> > >
> > 
> > I think it's better to drop this and instead just put the code
> > where we already know the config. So:
> > 
> > >  	/* Find if host supports multiqueue/rss virtio_net device */
> > >  	max_queue_pairs = 1;
> > > @@ -3784,10 +3801,6 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > >  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > >  	spin_lock_init(&vi->refill_lock);
> > >
> > > -	/* If we can receive ANY GSO packets, we must allocate large ones.
> > */
> > > -	if (virtnet_check_guest_gso(vi))
> > > -		vi->big_packets = true;
> > > -
> > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > >  		vi->mergeable_rx_bufs = true;
> > >
> > > @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > >
> > >  		dev->mtu = mtu;
> > >  		dev->max_mtu = mtu;
> > > -
> > > -		/* TODO: size buffers correctly in this case. */
> > > -		if (dev->mtu > ETH_DATA_LEN)
> > > -			vi->big_packets = true;
> > 
> >     /* Size buffers to fit mtu. */
> >     if (mtu > ETH_DATA_LEN) {
> >                     vi->big_packets = true;
> >                     vi->big_packets_num_skbfrags = DIV_ROUND_UP(mtu,
> > PAGE_SIZE);
> >     }
> > 
> How doing things twice is better i.e. when mtu is > ETH_DATA_LEN and gso is offered?
> It calculates big_packets variable twice.
> 
> It also easier to read the code at single place where big_packets decision is taken.

I guess it depends on what you want to keep in one place.
I just wanted to reduce the testing burden on the submitter.
What I proposed makes the functional change minimal.

It's nitpicking to be frank. v6 arrived while I was traveling
and I didn't notice it.  I see Jason acked that so I guess I will
just apply as is. Do you ack v6 too?


> > >  	}
> > >
> > > +	virtnet_set_big_packets_fields(vi, mtu);
> > > +
> > 
> > and here:
> >         /* If device can receive guest GSO packets, allocate buffers for
> >          * packets of maximum size, regardless of mtu.
> > 	 */
> > 
> > 	if (virtnet_check_guest_gso(vi)) {
> > 		vi->big_packets = true;
> > 		vi->big_packets_num_skbfrags = MAX_SKB_FRAGS;
> >         }
> > 
> > 
> > >  	if (vi->any_header_sg)
> > >  		dev->needed_headroom = vi->hdr_len;
> > >
> > > --
> > > 2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

