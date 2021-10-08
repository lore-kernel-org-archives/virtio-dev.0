Return-Path: <virtio-dev-return-8823-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95547986560
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Oct 2021 11:18:22 +0000 (UTC)
Date: Fri, 8 Oct 2021 07:18:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20211008070712-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
 <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008060329-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E5C53991AE2A98AA7D9FDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E5C53991AE2A98AA7D9FDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH v2] Add device reset timeout field
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 08, 2021 at 10:51:02AM +0000, Parav Pandit wrote:
> > That's why I ask: why do we bother? What's wrong with just waiting forever or
> > until user gets tired of this and cancels with CTRL-C?
> 
> Today, device removal of the device gets stuck for the device which didn't finish the reset, because its waiting for ever.
> 
> modprobe to my knowledge cannot be Ctrl-C. In another scenario, device probing of hot plug device occurs by hotplug driver in a workqueue context.

Frankly I'm not sure we need to worry about esoterica like
hotplug working when device can't get out of reset. If guest is
more or less alive that's already an achievement.

> It doesn't sound right to pass the burden to the user to invent some kind of ctrl-C cancel operation in hotplug drivers.

Oh interesting. Thanks for providing the motivation.

So if it's device removal you are after to fix,
then the proposed spec won't be enough I suspect, since
there's no specific time when we can be sure DMA won't
happen anymore. Just giving up on device isn't possible,
if you do you risk corrupting guest memory which seems scarier
than just blocking hotplug.

I guess with this in mind, what would be needed is a more fine-grained
approach. E.g. driver writes 0 to reset, device returns 1 to indicate
reset in progress, at that point it can promise that DMA/interrupts
won't happen any longer, so driver can go away.




> > Is there a use-case where that's not good enough?
> A guest has got one good and another device that encountered a fault.
> Due to this faulty device which is unable to reset, is blocking other operations in the system.

It's pretty uncommon for guests to actually have devices
they don't really need to function normally.

> > 
> > 
> > > And this is probably yet another good reason to define migratable bits
> > > of a virtio device in the live migration spec extension.
> > 
> > "migratable bits" being what? non-guest visible device state? Sure, would be
> > great to have.  Don't think it will help in this instance.
> > 
> > --
> > MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

