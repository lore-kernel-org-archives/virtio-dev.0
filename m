Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 8 Oct 2021 10:19:07 +0000
Message-ID: <PH0PR12MB5481F2D59677E69A9123F683DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
 <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87r1cvygx6.fsf@redhat.com>
In-Reply-To: <87r1cvygx6.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, October 8, 2021 3:31 PM
>=20
> On Thu, Oct 07 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Thursday, October 7, 2021 9:41 PM On Thu, Oct 07 2021, Parav
> >> Pandit <parav@nvidia.com> wrote:
> >>
> >> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> >> Sent: Thursday, October 7, 2021 2:23 AM On Wed, Oct 06, 2021 at
> >> >> 04:11:19PM +0000, Parav Pandit wrote:
> >> >> >
> >> >> > > From: Michael S. Tsirkin <mst@redhat.com>
> >> >> > > Sent: Wednesday, October 6, 2021 8:52 PM
> >>
> >> >> > > second, I don't see a story around compatibility here.
> >> >> > Device reset timeout is supported only when device offers the
> >> >> > new
> >> >> VIRTIO_DEV_RESET_TIMEOUT.
> >> >> > When such feature is not offered, driver follows the guidance
> >> >> > provided in
> >> >> this proposal.
> >> >> > Compatibility is covered with the feature bit.
> >> >>
> >> >> Well hmm. Problem is, devices need to be reset before feature bits =
are
> read.
> >> >>
> >> > Yeah, this means that we should remove the feature bit and instead
> >> > follow your suggestion that if the register value is zero, the
> >> > feature is not
> >> offered, If it is non zero, driver should follow the timeout.
> >>
> >> What about old devices -- they don't provide the timeout value at
> >> all, obviously; how can they stay compliant?
> >>
> > If the old device which doesn't provide a timeout, the newer version of=
 the
> spec suggests that driver chooses a reasonable value.
>=20
> If we don't guard the new field via a feature bit, the driver will try to=
 access
> something that does not exist for older devices. If we say that the field=
 exists,
> older devices are simply not compliant.
Lets take base line that for reset timeout we cannot add the feature bit be=
cause device may not be ready when reset is started.
With that baseline,=20
If the field exists, driver should honor it.
If the field doesn't exists, it is old device. So driver chooses a reasonab=
le value of timeout.

>=20
> Now, the interaction with the feature bit is obviously a problem... it wo=
uld
> mean that the driver can only find out what the device offers too late in=
 the
> initial startup sequence. We could specify that the field may or may not =
exist,
> but that might lead to other problems down the road.
>=20
Yes, newer spec will have the field. Value can be zero or non-zero.
Zero =3D device doesn't support reset timeout
Non_zero =3D device suggested the timeout

> >
> >> >
> >> >> > > previously pci drivers did wait, other drivers didn't.
> >> >> > >
> >> >> > The newer driver that implements updated spec, will adhere to
> >> >> > newer
> >> >> content of the spec.
> >> >>
> >> >> right but we can't just unconditionally say driver must wait, this
> >> >> would declare old driver non-compliant and we promised not to do th=
at.
> >> >>
> >> > It is not said unconditionally. It comes with spec version, isn't it=
?
> >> > This change should increment the spec version so old driver are
> >> > compliant to
> >> some older version of the spec.
> >> > Hence, there is no breakage with some old driver.
> >>
> >> We do not really say that a driver or a device is conforming to a
> >> certain version of the spec, though. If it has been written to an
> >> older version of the spec, I still expect it to be compliant, it's jus=
t not
> implementing some newer things.
> >>
> > The only way a older driver following older spec can be compliant to
> > newer spec, if the new spec remains same as old spec. :-)
>=20
> Eh, no. We just need to make new features optional. A driver written to a=
n
> older version of the spec that does not implement e.g. packed ring is sti=
ll
> compliant, since packed ring is guarded by a feature bit.
Ok. older driver will just simply ignore the existence of device reset time=
out field.
Newer driver will honor the value if the field is non zero.
If its zero, spec suggested newer driver to choose its reasonable value.
Since it is not a must/conformance statement, older driver continue to igno=
re the field that it doesn't know about.

>=20
> > However, the spec is suggesting to have finite timeout as "SHOULD".
> > Timeout is not part of the conformance _must_ clause.
> > So if old driver not following "SHOULD" suggestion of newer spec, does =
it
> make old driver non-compliant?
> > Your input on this will help me understand the conformance part.
>=20
> This depends upon how we introduce the new feature. If (as had been
> suggested upthread) we ditch the feature bit, we specify that the driver =
needs
> to do something (read the value) which an old driver simply won't do. The=
 only
> way that can work is if we make it optional for the driver to read the ti=
meout
> value. So yes, a driver not following a SHOULD clause is still compliant.=
 We
> need to be careful as to what we actually require; normally, feature bits=
 solve
> this neatly, but it seems problematic here.
>=20
True, feature bit solves this neatly as you suggested but unfortunately fea=
ture bit is not useful here.
So lets proceed without feature bit as optional for driver.


> >> >> The idea is to have finite behaviour, I got that, but I don't
> >> >> really know where does the requirement come from, in what sense
> >> >> it's deterministic and why do we worry about reset specifically.
> >> >>
> >> >> Recovering from failure when hardware is broken?
> >> >>
> >> > I provided few examples in previous email.
> >> > Terminating a probe sequence of the device which is already on its
> >> > path of
> >> hotunplug.
> >>
> >> For that sequence, don't we need a timeout for *any* interaction with
> >> the device?
> > We do need a command timeout that will handle hotunplug scenario while
> under probe.
> > But handling command timeout has wider use, even without non racing
> hotunplug and plug sequences.
> > So it is better to drive it as separate extension in itself, which is s=
elf-
> contained.
>=20
> So, why is reset special in that case? As...
>=20
Normally composing a device takes a longer or more efforts for the backend =
compare to serving a command.
So device reset timeout is likely higher than a command timeout value.
So overloading or defining single field for command timeout and reset timeo=
ut looks incorrect to me.

Hence, command timeout should be a different feature bit. Given that it is =
own feature bit, I propose to keep such proposal self-contained and separat=
e from this one.

> >
> >> I thought this proposal was mainly about devices that take a long
> >> time to "warm up"...
> >>
> > Yes, certainly this proposal covers such device scenario.
> > In general, this proposal covers reset timeout as the register suggests=
.
>=20
> ...I do not really understand this, then. We want reset timeouts, because=
 they
> cover a certain scenario, but we don't want something more general?

A command timeout is a new feature bit and a different field than reset tim=
eout.
Lets not combine both into single proposal and single field.

>=20
> >
> >> > VQ commands timeout handling is indeed needed but it is a separate
> >> enhancement in itself.
> >> > This one is self-contained enough that doesn't need to combined
> >> > with
> >> command timeout.
> >>
> >> What about e.g. config writes; I think they might trigger some actions=
?
> >>
> > A driver can do config writes to the PCI virtio device without reset is
> complete.
> > This is very common practice that driver follows to discover device
> properties.
> > It may trigger some action on the device, but PCI device is obligated t=
o
> respond to it for host driver to function properly.
>=20
> But isn't that in violation of the spec? I understand it needs to do rese=
t -> (wait
> until complete) -> set ACKNOWLEDGE status -> set DRIVER status -> potenti=
ally
> *read* the config space -> set FEATURES_OK and only then *write* to the
> config space?
>=20
I think I misunderstood your point about "config space".
Since I am mostly familiar with pci devices, I took "config space" as "pci =
config space", which must be accessible to the driver before device virtio =
level registers are accessed.

You mentioned virtio level config space, which as you say, has to be access=
ed after reset is completed.

> As an aside, not all transports even allow accessing the config space whi=
le reset
> is still in progress. I would naively have expected that to be the norm.
True. My bad on interpreting virtio config space =3D pci config space.

