Return-Path: <mst@redhat.com>
Date: Sun, 31 Jul 2022 11:38:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
 device management
Message-ID: <20220731112614-mutt-send-email-mst@kernel.org>
References: <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724170744-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481269E252B7DD8EFE2109DDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724191530-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127CD9F333F8F92580531DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220725030303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812685041A59D642227920DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812685041A59D642227920DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Jul 30, 2022 at 01:21:20PM +0000, Parav Pandit wrote:
> > > Not a good reason to introduce something inferior.
> > 
> > Avoiding duplication and focusing on low hanging fruit are all sound
> > engineering principles.
> > 
> It is not a duplication.
> I iterate again. The bits we asked to put in the Aq commands are the one that does not need to be negotiated early.
> Feature bits were mis-used to put all things in there because in past a generic AQ didn't exists.
> And there is no reason for that past decision to influence current proposal.
> 
> Feature bits that are so basic for device bring up stage, stays in feature bits area defined today.
> Hence, its not a duplication.

Let's take a look at a network device for example.


	\item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum.   This 
	  ``checksum offload'' is a common feature on modern network cards.

	\item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial checksum.

	\item[VIRTIO_NET_F_CTRL_GUEST_OFFLOADS (2)] Control channel offloads
		reconfiguration support.

	\item[VIRTIO_NET_F_MTU(3)] Device maximum MTU reporting is supported. If
	    offered by the device, device advises driver about the value of
	    its maximum MTU. If negotiated, the driver uses \field{mtu} as
	    the maximum MTU value.

	\item[VIRTIO_NET_F_MAC (5)] Device has given MAC address.

	\item[VIRTIO_NET_F_GUEST_TSO4 (7)] Driver can receive TSOv4.

	\item[VIRTIO_NET_F_GUEST_TSO6 (8)] Driver can receive TSOv6.

	\item[VIRTIO_NET_F_GUEST_ECN (9)] Driver can receive TSO with ECN.

	\item[VIRTIO_NET_F_GUEST_UFO (10)] Driver can receive UFO.

	\item[VIRTIO_NET_F_HOST_TSO4 (11)] Device can receive TSOv4.

	\item[VIRTIO_NET_F_HOST_TSO6 (12)] Device can receive TSOv6.

	\item[VIRTIO_NET_F_HOST_ECN (13)] Device can receive TSO with ECN.

	\item[VIRTIO_NET_F_HOST_UFO (14)] Device can receive UFO.

	\item[VIRTIO_NET_F_MRG_RXBUF (15)] Driver can merge receive buffers.

	\item[VIRTIO_NET_F_STATUS (16)] Configuration status field is
	    available.

	\item[VIRTIO_NET_F_CTRL_VQ (17)] Control channel is available.

	\item[VIRTIO_NET_F_CTRL_RX (18)] Control channel RX mode support.

	\item[VIRTIO_NET_F_CTRL_VLAN (19)] Control channel VLAN filtering.

	\item[VIRTIO_NET_F_GUEST_ANNOUNCE(21)] Driver can send gratuitous
	    packets.

	\item[VIRTIO_NET_F_MQ(22)] Device supports multiqueue with automatic
	    receive steering.

	\item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
	    channel.

	\item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.

	\item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.

	\item[VIRTIO_NET_F_GUEST_USO6 (55)] Driver can receive USOv6 packets.

	\item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
	 (fragmenting the packet) the USO splits large UDP packet
	 to several segments when each of these smaller packets has UDP header.

	\item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
	    value and a type of calculated hash.

	\item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
	    value. Device benefits from knowing the exact header length.

	\item[VIRTIO_NET_F_RSS(60)] Device supports RSS (receive-side scaling)
	    with Toeplitz hash calculation and configurable hash
	    parameters for receive steering.

	\item[VIRTIO_NET_F_RSC_EXT(61)] Device can process duplicated ACKs
	    and report number of coalesced segments and duplicated ACKs.

	\item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for a primary
	    device with the same MAC address.

	\item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed and duplex.


which of these are basic for bring up stage?



> > 
> > > > Something like transport over AQ (or the transport vq proposal) or
> > > > some other concerted effort to save per device memory would be
> > > > needed for SIOV, and maybe it's useful for SRIOV too.
> > > >
> > > AQ proposal is already doing it.
> > > Some of the things seems to be lately duplicated in transport vq proposal.
> > > We should possibly rename both the queues to mgmt_queue that serves
> > both the purposes.
> > 
> > Quite possibly - transport VQ seems to handle a group of devices from one
> > device which seems similar to what AQ does, and you guys should probably
> > work together.
> >
> Yes.
>  
> > But whether we do or do not unify transport and admin vq, with transport
> Without unification, I don't see how SIOV proposal can ever make to the spec.
> Once AQ is merged SIOV can use AQ.
> I would like to see SIOV to refer to the AQ proposal commands and extend it. Not as separate proposal.


Sounds good. Or maybe the reverse will happen and transport vq will land
first, I don't much care personally. It would be nice if the parts of AQ
proposal necessary for transport vq work were a separate patch.


> > vq existing feature mechanism stops taking up space in the VQ and this
> > opens up possibility to just use that mechanism to discover supported
> > commands without paying memory penalty.
> > 
> This only helps any new SIOV beast which is not even fully defined at various layers of platform.
> 
> > 
> > > Transport VQ proposal is tunneling some SIOV device feature bits.
> > > Here AQ is negotiating its own feature bits. Both are orthogonal.
> > 
> > I thought the discussion was about dropping the get features command and
> > using features instead. 
> 
> > The Transport VQ proposal seems to show how we
> > can do that and still make things scale.  Yes it's orthogonal to using AQ for
> > grouping, and using features is exactly what will keep it orthogonal.
> > 
> > > And suggesting to some newer RFC to discuss current one doesn't make
> > much sense to tangent the discussion at all.
> > 
> > 
> > The reason I bring it up is that it seems like a better solution to saving device
> > memory than adding a get capabilities command. And it let you just use
> > features for now, and assume whatever we spend will be saved back by
> > using vq as transport.
> > 
> Even for non SIOV devices?

Yes.

> > 
> > > Since there is zero technical short comings of negotiating AQ features via
> > AQ command, lets please conclude to proceed with it.
> > 
> > Not 100% sure what you are saing here, so I think you should post a new
> > version, yes. Generally iterating faster is a good idea. If you feel you didn't
> > get enough feedback on a given version and some time passed try pinging
> > people.
> Without closing the discussion, I have seen same topic come up again and again in future version.
> So even though new series is up for posting, we better close the discussion.

That's a mistake, it will be harder for you to make progress like this.
Reviewers have limited attention span and memory, text bitrots, you decide to
make unrelated changes yourself... Sorry I'm repeating myself but
iterate quickly in the open even if there are known issues not addressed
yet, just make very sure to be open and detailed about issues you addressed
and known issues you did not address.

-- 
MST

