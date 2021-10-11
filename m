Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Mon, 11 Oct 2021 14:29:35 +0000
Message-ID: <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org> <87lf33ybz7.fsf@redhat.com>
 <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008085134-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211008185926-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, October 9, 2021 4:39 AM
>=20
> On Fri, Oct 08, 2021 at 01:23:52PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Friday, October 8, 2021 6:27 PM
> >
> > > > 2. A sriov VF virtio device for our case takes a lot lesser than
> > > > this, but may
> > > take anywhere between 10 msec to 250msec.
> > > > This can happen on a firmware where user enabled 500 SR-IOV VFs.
> > > > Pci spec indicates that all VFs to initialize within 100msec. This
> > > > translates to
> > > 0.2msec for one VF.
> > > > In some scenario this can be a hard to initialize a VF in 0.2 msec
> > > > depending
> > > on what else a firmware is doing at that time.
> > >
> > > That's separate from virtio reset though. virtio reset is much
> > > lighter weight than a VF reset, all it needs to do is return config
> > > space to original values and stop DMA.
> > Again you took the valid example to stop the DMA of already
> > initialized device, while above case is for the first init. :-) virtio =
device is going
> the first reset during initialization. It should be able to tell how long=
 to wait.
> > A device firmware may take more than 0.2msec to finish needed initializ=
ation
> to serve a virtio device.
> > Infinite wait of today works here.
>=20
> Looks like it's as Cornelia said - nothing to do with reset. E.g. it's li=
kely device
> can not even serve pci config before the init is complete.
>=20
Not sure. I replied to Cornelia.
A pci device once placed on the pci bus has to respond to the config reques=
ts.
However virtio pci device virtio config registers can be accessed only afte=
r reset is completed.

More below.

> > Question was for wild guess by driver for 100msec vs 10msec vs 0.2 msec=
.
> > Is that enough?
>=20
> So some guidance in the spec on how long it should take will address this=
 I
> think.
What would be that guidance, what is the finite time that sw driver wait fo=
r the device reset to finish?
I still not understand, what is the problem in device passing this optional=
 hint to sw to indicate it, instead of some guess work.
> > >
> > > > 3. A system has one or more virtio boot devices.
> > > > One of them happens to be faulty after a firmware upgrade.
> > > > Pre-boot env is infinitely waiting. Michael suggest to do disable
> > > > such PCI slot
> > > by means of abstract Ctrl+C.
> > > > If PCI slot is disabled, that device must be physically taken out f=
or
> recovery.
> > > > In an alternative, if device advertised a finite timeout, that
> > > > device didn't boot,
> > > system gave up after finite timeout and server picked second boot
> > > option, and booted.
> > > > Now a system admin can repair the faulty device without physically
> > > > taking it
> > > out.
> > > > Will infinite timeout help here? Or a device advertising finite
> > > > timeout and
> > > recovering the system more useful?
> > > >
> > > > 4. device was hotplug in system and before it is fully probed, a
> > > > hot unplug is
> > > triggered.
> > >
> > >
> > > I don't get this one. Are you talking about surprise removal here?
> > Yes.
> > > The way to handle that is surely not a timeout, we should be able to
> > > test for device presence.
> > Yes, it should be possible to update device presence of device under pr=
obe
> while its surprised removed.
> > I will look into it more.
> > However, this is not the only place timeout is used.
>=20
> As in this example, I'd be worried people will rely on timeout instead of
> addressing things properly.
>=20

> > > How about some "keepalive" signal then? E.g. a register where each
> > > read needs to respond with a different value, if it's the same then d=
evice is
> stuck ...
> >
> > A device should be out of the reset, keep alive feature negotiated to r=
espond
> to a keep alive requests from host driver.
> > Keep alive is useful post the reset+ init stage.
> > (keep alive is also used by nvme devices, similar to device ready TIMEO=
UT
> with granularity of 500msec, similar to virtio device reset timeout).
>=20
> Just to clarify, what I call keepalive here is a counter providing a diff=
erent value
> on each read.
> This can thinkably work even before feature negotiation.
>=20
Feature negotiation is mainly for backward compatibility.
This is unlikely to work the reset is completed. Because a real device impl=
ementing this would prefer to do this in fw for 1000 virtio devices sitting=
 on the physical card.
And it is very much driven by such implementation at device devel.
So it cannot update the counter value if reset is not completed for the dev=
ice.

I think read only device reset timeout is most elegant option during device=
 initialization phase that eliminates infinite loop of today.

