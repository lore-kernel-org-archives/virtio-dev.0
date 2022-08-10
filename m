Return-Path: <virtio-dev-return-9756-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8FA99863D4
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Aug 2022 16:59:01 +0000 (UTC)
Date: Wed, 10 Aug 2022 12:58:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220810125749-mutt-send-email-mst@kernel.org>
References: <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810120440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 10, 2022 at 04:22:41PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, August 10, 2022 12:05 PM
> > 
> > On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, August 10, 2022 5:03 AM
> > > > > >
> > > > > > Should we make this depend on the vq reset ability maybe?
> > > > >
> > > > > The advantage of this is to keep TX working. Or we can use device
> > > > > reset as a fallback if there's no vq reset.
> > > > >
> > > > > Thanks
> > > >
> > > > Device reset is really annoying in that it loses all the state:
> > > > rx filters etc etc.
> > >
> > > The elegant solution is let driver tell the new mtu to the device.
> > > One way to do so is by using existing ctrl vq.
> > 
> > That will need a new feature bit.
> > 
> Yes. ctrl vq can tell what all configuration does it allow. :)
> Or you prefer feature bit?

We did feature bits for this in the past.

> > > If merged buffer is done, and new mtu is > minimum posting size, no need
> > to undergo vq reset.
> > > If merged buffer is not done, and buffer posted are smaller than new mtu,
> > undergo vq reset optionally.
> > 
> > This can be done with or without sending mtu to device.
> Yes, telling mtu to device helps device to optimize and adhere to the spec line " The device MUST NOT pass received packets that exceed mtu" in section 5.1.4.1.

Again, that line refers to \field{mtu} which is the max mtu supported,
irrespective to anything driver does.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

