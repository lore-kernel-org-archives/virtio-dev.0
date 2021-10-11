Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Mon, 11 Oct 2021 15:44:14 +0000
Message-ID: <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
In-Reply-To: <871r4ry5do.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, October 11, 2021 8:29 PM
>=20
> On Mon, Oct 11 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Saturday, October 9, 2021 4:39 AM
> >>
> >> On Fri, Oct 08, 2021 at 01:23:52PM +0000, Parav Pandit wrote:
> >> >
> >> >
> >> > > From: Michael S. Tsirkin <mst@redhat.com>
> >> > > Sent: Friday, October 8, 2021 6:27 PM
> >> >
> >> > > > 2. A sriov VF virtio device for our case takes a lot lesser
> >> > > > than this, but may
> >> > > take anywhere between 10 msec to 250msec.
> >> > > > This can happen on a firmware where user enabled 500 SR-IOV VFs.
> >> > > > Pci spec indicates that all VFs to initialize within 100msec.
> >> > > > This translates to
> >> > > 0.2msec for one VF.
> >> > > > In some scenario this can be a hard to initialize a VF in 0.2
> >> > > > msec depending
> >> > > on what else a firmware is doing at that time.
> >> > >
> >> > > That's separate from virtio reset though. virtio reset is much
> >> > > lighter weight than a VF reset, all it needs to do is return
> >> > > config space to original values and stop DMA.
> >> > Again you took the valid example to stop the DMA of already
> >> > initialized device, while above case is for the first init. :-)
> >> > virtio device is going
> >> the first reset during initialization. It should be able to tell how l=
ong to wait.
> >> > A device firmware may take more than 0.2msec to finish needed
> >> > initialization
> >> to serve a virtio device.
> >> > Infinite wait of today works here.
> >>
> >> Looks like it's as Cornelia said - nothing to do with reset. E.g.
> >> it's likely device can not even serve pci config before the init is co=
mplete.
> >>
> > Not sure. I replied to Cornelia.
> > A pci device once placed on the pci bus has to respond to the config re=
quests.
> > However virtio pci device virtio config registers can be accessed only =
after
> reset is completed.
>=20
> What I don't understand: if a pci device is in such a state that it canno=
t
> complete a reset, how can it be able to serve the pci config? In the case=
s I saw
> mentioned (hotunplug, slow device startup), I'd expect the device simply =
being
> slow/unable to respond to anything.
> >
Not necessarily.
PCI device implementation in hw/fw needs to comply to the PCI spec that def=
ines pci level semantics.
Device implements virtio specification on top of the PCI spec.
Serving virtio functionality is more than just PCI configs, so device imple=
mentation able to service pci requests but may not be ready to serve virtio=
 block and networking IOs.
This provides best tradeoffs in hw implementation of what is done in which =
layer of hw/fw etc for PCI and virtio layer.

Such implementation is very common in multiple PCI device families such as =
mlx5, nvme and more.
For example nvme device has controller ready timeout with granularity of 50=
0msec and has 16-bits of timeout.

> > More below.
> >
> > Feature negotiation is mainly for backward compatibility.
>=20
> Related, I found I had opened this issue some time ago:
> https://github.com/oasis-tcs/virtio-spec/issues/98 Might be relevant when
> considering guarding this via a feature bit.
>=20
If you think above can see day light, we may have feature bit for device re=
set too.
However above github note says "read optional field before FEATURES_OK", an=
d not read optional field _before_ device reset.
Do you plan to modify issues/98 to read optional field before device reset?

> > This is unlikely to work the reset is completed. Because a real device
> implementing this would prefer to do this in fw for 1000 virtio devices s=
itting on
> the physical card.
> > And it is very much driven by such implementation at device devel.
> > So it cannot update the counter value if reset is not completed for the=
 device.
> >
> > I think read only device reset timeout is most elegant option during de=
vice
> initialization phase that eliminates infinite loop of today.
>=20
> Why can't a driver just go ahead and do a timeout regardless?=20
o.k. lets consider this thought exercise. What is the timeout value that dr=
iver will choose if device doesn't specify one?
I explained in previous thread and you acked that actual fw based device ma=
y take longer to initialize than pure sw implementation backend.
In second example a pre-boot device can take even longer initialization tim=
e.
Sriov VF device may initialize lot faster.
Instead of driver having such transport, and device specific checks, (or so=
me very short or very long timeout), we propose, that let device mention su=
ch timeout value.

> This seems
> pretty much to depend on the implementation. Nothing in the virtio spec f=
orces
> the driver to reset all devices serially and wait potentially forever. (I=
f you deal
> with a large amount of subdevices you cannot access concurrently, you lik=
ely
> already have problems.)
Sure, nothing in driver forces serial initialization.
However in reality, PCI device scanning on the bus in hotplug driver, prebo=
ot env, sriov vf initialization is serial.
In preboot case, even the order is defined, so it is sort of serial.

In other uses, concurrent access is fine and host does that today when it d=
isables autoprobe on the PCI Bus and probes them in parallel after enabling=
 sriov.
I hope you understand that there are both use-cases exists which scan paral=
lel and some serial.

