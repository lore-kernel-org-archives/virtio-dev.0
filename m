Return-Path: <mst@redhat.com>
Date: Wed, 1 Feb 2023 01:47:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH v7] virtio-net: support
 inner header hash
Message-ID: <20230201014511-mutt-send-email-mst@kernel.org>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230131055710.GC34480@h68b04307.sqa.eu95>
 <PH0PR12MB5481A27116866CCE1000113FDCD19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A27116866CCE1000113FDCD19@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 01, 2023 at 01:51:25AM +0000, Parav Pandit wrote:
> 
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Tuesday, January 31, 2023 12:57 AM
> > 
> > On Wed, Jan 18, 2023 at 11:45:39PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: virtio-dev@lists.oasis-open.org
> > > > <virtio-dev@lists.oasis-open.org>
> > > > Sent: Wednesday, January 4, 2023 2:14 AM
> > >
> > > > If the tunnel is used to encapsulate the packets, the hash
> > > > calculated using the outer header of the receive packets is always
> > > > fixed for the same flow packets, i.e. they will be steered to the same
> > receive queue.
> > >
> > > > +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
> > > > +    header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packets.
> > > > +
> > > A device may not support all 3 at the same time.
> > > Please remove mentioning tunneling protocols description from here.
> > > Just say device support inner header hash ...
> > 
> > Sorry for the late reply due to vacation.
> > 
> > Good idea, Michael suggested doing the same. But we also discussed this issue:
> > Early, we used a feature bit to force devices to support GRE and VXLAN 
> ..
> There is no need to force the device.
> LM will work as it will use both he values - the feature bit and the supported/negotiated hash type in the config space.
> 
> > > An additional bit map somewhere else should say supported hash over
> > different tunneling types.
> > >
> > 
> > Yes, we use \field{supported_hash_types} to declare supported hash types.
> Nice. So yes, just remove the description from the feature bits.
> [..]
> > >
> > > With the inclusion of tunnel outer header, it doesn't need to redefine the
> > hashing for inner packets which is exactly same without the tunnel.
> > > hash tunnel capability only indicates that hashing is done on the inner packets
> > as_before.
> > >
> > 
> > This seems like a trade-off, and I can get rid of this if the simple statement
> > "computing the hash for the inner header of the tunnel packet is the same as
> > without tunnel"
> > is also clear to the reader.
> > What do you think? Cc Jason and Michael.
> Not sure I follow your comment.
> Inclusion of outer header has zero change in inner header hash.
> 
> The data structure etc is just fine in the patch you proposed.
> So, there is no need to redefine all over it again.
> Only description need to be simplified as below.
> Please just change the text wording to indicate that when tunnel feature is negotiated, and if the hashing is performed by the device on the inner header, hash_report_tunnel will contain the valid outer tunnel type information.
> 
> Also, this patch is adding two functionalities.
> 1. Inner header hash calculation of existing already defined hash types 
> 2. outer header hash for new type for GRE,VXLAN,GENEVE.
> #1 should be in 1st patch.
> #2 should be in 2nd patch.
> This is better to review.

Oh, that's an interesting take. Do you feel we need more
separate hash type bits then?

> Overall useful features. Thanks for adding.

