Return-Path: <virtio-dev-return-9728-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8D4298633A
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 21:34:11 +0000 (UTC)
Date: Tue, 9 Aug 2022 17:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220809173305-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
MIME-Version: 1.0
In-Reply-To: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, loseweigh@gmail.com, Parav Pandit <parav@nvidia.com>, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 09, 2022 at 11:38:52AM -0700, Si-Wei Liu wrote:
> 
> 
> On 8/9/2022 12:44 AM, Jason Wang wrote:
> > On Tue, Aug 9, 2022 at 3:07 PM Gavin Li <gavinl@nvidia.com> wrote:
> > > 
> > > On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
> > > 
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 8/8/2022 12:31 AM, Gavin Li wrote:
> > > 
> > > 
> > > On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
> > > 
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 8/1/2022 9:45 PM, Gavin Li wrote:
> > > 
> > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> > > packets even when GUEST_* offloads are not present on the device.
> > > However, if GSO is not supported,
> > > 
> > > GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
> > > been be called.
> > > 
> > > ACK
> > > 
> > > 
> > >    it would be sufficient to allocate
> > > segments to cover just up the MTU size and no further. Allocating the
> > > maximum amount of segments results in a large waste of buffer space in
> > > the queue, which limits the number of packets that can be buffered and
> > > can result in reduced performance.
> > > 
> > > Therefore, if GSO is not supported,
> > > 
> > > Ditto.
> > > 
> > > ACK
> > > 
> > > 
> > > use the MTU to calculate the
> > > optimal amount of segments required.
> > > 
> > > Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> > > 1 VQ, queue size 1024, before and after the change, with the iperf
> > > server running over the virtio-net interface.
> > > 
> > > MTU(Bytes)/Bandwidth (Gbit/s)
> > >                Before   After
> > >     1500        22.5     22.4
> > >     9000        12.8     25.9
> > > 
> > > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > > Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >    drivers/net/virtio_net.c | 20 ++++++++++++++++----
> > >    1 file changed, 16 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index ec8e1b3108c3..d36918c1809d 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -222,6 +222,9 @@ struct virtnet_info {
> > >        /* I like... big packets and I cannot lie! */
> > >        bool big_packets;
> > > 
> > > +     /* Indicates GSO support */
> > > +     bool gso_is_supported;
> > > +
> > >        /* Host will merge rx buffers for big packets (shake it! shake
> > > it!) */
> > >        bool mergeable_rx_bufs;
> > > 
> > > @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
> > > virtnet_info *vi, struct receive_queue *rq,
> > >    static int add_recvbuf_big(struct virtnet_info *vi, struct
> > > receive_queue *rq,
> > >                           gfp_t gfp)
> > >    {
> > > +     unsigned int sg_num = MAX_SKB_FRAGS;
> > >        struct page *first, *list = NULL;
> > >        char *p;
> > >        int i, err, offset;
> > > 
> > > -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> > > +     if (!vi->gso_is_supported) {
> > > +             unsigned int mtu = vi->dev->mtu;
> > > +
> > > +             sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
> > > / PAGE_SIZE;
> > > 
> > > DIV_ROUND_UP() can be used?
> > > 
> > > ACK
> > > 
> > > 
> > > Since this branch slightly adds up cost to the datapath, I wonder if
> > > this sg_num can be saved and set only once (generally in virtnet_probe
> > > time) in struct virtnet_info?
> > > 
> > > Not sure how to do it and align it with align with new mtu during
> > > .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
> > > ndo_change_mtu might be in vendor specific code and unmanageable. In
> > > my case, the mtu can only be changed in the xml of the guest vm.
> > > 
> > > Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest on
> > > a virtio-net device with 9000 MTU (as defined in guest xml). Basically
> > > guest user can set MTU to any valid value lower than the original
> > > HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
> > > should have validated the MTU value before coming down to it. And I
> > > suspect you might want to do virtnet_close() and virtnet_open()
> > > before/after changing the buffer size on the fly (the netif_running()
> > > case), implementing .ndo_change_mtu() will be needed anyway.
> > > 
> > > a guest VM driver changing mtu to smaller one is valid use case. However, current optimization suggested in the patch doesn't degrade any performance. Performing close() and open() sequence is good idea, that I would like to take up next after this patch as its going to be more than one patch to achieve it.
> > Right, it could be done on top.
> > 
> > But another note is that, it would still be better to support GUEST GSO feature:
> > 
> > 1) can work for the case for path MTU
> > 2) (migration)compatibility with software backends
> > 
> > > 
> > > +     }
> > > +
> > > +     sg_init_table(rq->sg, sg_num + 2);
> > > 
> > >        /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> > > 
> > > Comment doesn't match code.
> > > 
> > > ACK
> > > 
> > > -     for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> > > +     for (i = sg_num + 1; i > 1; --i) {
> > >                first = get_a_page(rq, gfp);
> > >                if (!first) {
> > >                        if (list)
> > > @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
> > > *vi, struct receive_queue *rq,
> > > 
> > >        /* chain first in list head */
> > >        first->private = (unsigned long)list;
> > > -     err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> > > +     err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
> > >                                  first, gfp);
> > >        if (err < 0)
> > >                give_pages(rq, first);
> > > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
> > > *vdev)
> > >        if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >            virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > >            virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > > +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> > >                vi->big_packets = true;
> > > +             vi->gso_is_supported = true;
> > > 
> > > Please do the same for virtnet_clear_guest_offloads(), and
> > > correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> > > virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> > > successful return, seems like a bug to me.
> > It is fine as long as
> > 
> > 1) we don't implement ethtool API for changing guest offloads
> Not sure if I missed something, but it looks the current
> virtnet_set_features() already supports toggling on/off GRO HW through
> commit a02e8964eaf9271a8a5fcc0c55bd13f933bafc56 (formerly misnamed as LRO).
> Sorry, I realized I had a typo in email: "virtnet_set_guest_offloads() or
> the caller doesn't unset big_packet ...".

"we" here is the device, not the driver.

> > 2) big mode XDP is not enabled
> Currently it is not. Not a single patch nor this patch, but the context for
> the eventual goal is to allow XDP on a MTU=9000 link when guest users
> intentionally lower down MTU to 1500.
> 
> Regards,
> -Siwei
> > 
> > So that code works only for XDP but we forbid big packets in the case
> > of XDP right now.
> > 
> > Thanks
> > 
> > > ACK. The two calls virtnet_set_guest_offloads and
> > > virtnet_set_guest_offloads is also called by virtnet_set_features. Do
> > > you think if I can do this in virtnet_set_guest_offloads?
> > > 
> > > I think that it should be fine, though you may want to deal with the XDP
> > > path not to regress it.
> > > 
> > > -Siwei
> > > 
> > > 
> > > 
> > > Thanks,
> > > -Siwei
> > > 
> > > +     }
> > > 
> > >        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > >                vi->mergeable_rx_bufs = true;
> > > 
> > > 
> > > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

