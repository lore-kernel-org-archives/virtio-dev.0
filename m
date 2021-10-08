Return-Path: <mst@redhat.com>
Date: Fri, 8 Oct 2021 08:57:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Add device reset timeout field
Message-ID: <20211008085134-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org>
 <87lf33ybz7.fsf@redhat.com>
 <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 08, 2021 at 12:12:35PM +0000, Parav Pandit wrote:
> 
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Friday, October 8, 2021 5:18 PM
> > 
> > On Fri, Oct 08 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Fri, Oct 08, 2021 at 10:59:02AM +0000, Parav Pandit wrote:
> > >> It may be even a pre-boot environment where 100msec or 10msec may be
> > too short interval as other extreme of VM boot time example.
> > >
> > > I don't really know what this means. We are talking about how long it
> > > takes device to calm down and stop poking at the host after it's told
> > > to reset. 10ms worst case not enough for this?
> > 
> > To me, that sounded more like a physical device that needs to do something
> > like boot its firmware before it can perform an actual virtio operation (and
> > reset simply happens to be the first one.)
> > 
> > So, I'm getting more confused about the scope of this timeout. If it's more a
> > "device might not be ready yet" issue, I don't think we need a timeout for reset
> > specifically. Same for races with hotplugging. If it's about "reset may take some
> > time, because it will take some time before all operations have quiesced", I
> > don't see how the device can come up with a value that isn't anything other
> > than a wild guess, and the driver could do wild guessing equally well.
> 
> Device implementation has good knowledge of how a given virtio device is implemented to not do wild guess.
> I will take real world examples.
> 1. A physical virtio device backed by a firmware will take more than 10msec of boot time to respond to the reset operation.
> 
> 2. A sriov VF virtio device for our case takes a lot lesser than this, but may take anywhere between 10 msec to 250msec.
> This can happen on a firmware where user enabled 500 SR-IOV VFs.
> Pci spec indicates that all VFs to initialize within 100msec. This translates to 0.2msec for one VF.
> In some scenario this can be a hard to initialize a VF in 0.2 msec depending on what else a firmware is doing at that time.

That's separate from virtio reset though. virtio reset is
much lighter weight than a VF reset, all it needs to do is
return config space to original values and stop DMA.

> 3. A system has one or more virtio boot devices.
> One of them happens to be faulty after a firmware upgrade.
> Pre-boot env is infinitely waiting. Michael suggest to do disable such PCI slot by means of abstract Ctrl+C.
> If PCI slot is disabled, that device must be physically taken out for recovery.
> In an alternative, if device advertised a finite timeout, that device didn't boot, system gave up after finite timeout and server picked second boot option, and booted.
> Now a system admin can repair the faulty device without physically taking it out.
> Will infinite timeout help here? Or a device advertising finite timeout and recovering the system more useful?
> 
> 4. device was hotplug in system and before it is fully probed, a hot unplug is triggered.


I don't get this one. Are you talking about surprise removal here?
The way to handle that is surely not a timeout, we should be able to
test for device presence.

> Device cannot respond to reset, because its hot unplugged.
> OS waits infinitely for reset to complete.
> And system component is stuck just because of one device.
> Would a finite timeout help to abort this operation? Yes.

Except if it takes minutes it is not agile enough for many workloads.

> 
> So is wild guess of 10msec for all devices or an infinite time most efficient way to handle above scenarios?

Donnu, but as I hope you begin to see, as we start digging into
actual requirements, neither does a huge reset promise by the device.
How about some "keepalive" signal then? E.g. a register where each read
needs to respond with a different value, if it's the same then
device is stuck ...

-- 
MST

