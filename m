Return-Path: <virtio-dev-return-9732-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45062986350
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 22:25:59 +0000 (UTC)
Date: Tue, 9 Aug 2022 18:25:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220809182306-mutt-send-email-mst@kernel.org>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, August 9, 2022 5:38 PM
> 
> [..]
> > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > which case the receive buffer will be reduced to fit the 1500B
> > > > payload size when mtu is lowered down to 1500 from 9000.
> > > How? Driver reduced the mXu to 1500, say it is improved to post buffers of
> > 1500 bytes.
> > >
> > > Device doesn't know about it because mtu in config space is RO field.
> > > Device keep dropping 9K packets because buffers posted are 1500 bytes.
> > > This is because device follows the spec " The device MUST NOT pass
> > received packets that exceed mtu".
> > 
> > 
> > The "mtu" here is the device config field, which is
> > 
> >         /* Default maximum transmit unit advice */
> > 
> 
> It is the field from struct virtio_net_config.mtu. right?
> This is RO field for driver.
> 
> > there is no guarantee device will not get a bigger packet.
> Right. That is what I also hinted.
> Hence, allocating buffers worth upto mtu is safer.

yes

> When user overrides it, driver can be further optimized to honor such new value on rx buffer posting.

no, not without a feature bit promising device won't get wedged.

> > And there is no guarantee such a packet will be dropped as opposed to
> > wedging the device if userspace insists on adding smaller buffers.
> >
> If user space insists on small buffers, so be it.

If previously things worked, the "so be it" is a regression and blaming
users won't help us. 

> It only works when user exactly know what user is doing in the whole network.

If you want to claim this you need a new feature bit.

> When user prefers to override the device RO field, device is in the dark and things work on best effort basis.

Dropping packets is best effort. Getting stuck forever isn't, that's
a quality of implementation issue.

> This must be a reasonably advance user who has good knowledge of its network topology etc.
> 
> For such case, may be yes, driver should be further optimized.
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

