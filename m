Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Thu, 7 Oct 2021 17:58:09 +0000
Message-ID: <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
In-Reply-To: <87zgrkyfwn.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, October 7, 2021 9:41 PM
> On Thu, Oct 07 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Thursday, October 7, 2021 2:23 AM On Wed, Oct 06, 2021 at
> >> 04:11:19PM +0000, Parav Pandit wrote:
> >> >
> >> > > From: Michael S. Tsirkin <mst@redhat.com>
> >> > > Sent: Wednesday, October 6, 2021 8:52 PM
>=20
> >> > > second, I don't see a story around compatibility here.
> >> > Device reset timeout is supported only when device offers the new
> >> VIRTIO_DEV_RESET_TIMEOUT.
> >> > When such feature is not offered, driver follows the guidance
> >> > provided in
> >> this proposal.
> >> > Compatibility is covered with the feature bit.
> >>
> >> Well hmm. Problem is, devices need to be reset before feature bits are=
 read.
> >>
> > Yeah, this means that we should remove the feature bit and instead
> > follow your suggestion that if the register value is zero, the feature =
is not
> offered, If it is non zero, driver should follow the timeout.
>=20
> What about old devices -- they don't provide the timeout value at all,
> obviously; how can they stay compliant?
>
If the old device which doesn't provide a timeout, the newer version of the=
 spec suggests that driver chooses a reasonable value.
=20
> >
> >> > > previously pci drivers did wait, other drivers didn't.
> >> > >
> >> > The newer driver that implements updated spec, will adhere to newer
> >> content of the spec.
> >>
> >> right but we can't just unconditionally say driver must wait, this
> >> would declare old driver non-compliant and we promised not to do that.
> >>
> > It is not said unconditionally. It comes with spec version, isn't it?
> > This change should increment the spec version so old driver are complia=
nt to
> some older version of the spec.
> > Hence, there is no breakage with some old driver.
>=20
> We do not really say that a driver or a device is conforming to a certain=
 version
> of the spec, though. If it has been written to an older version of the sp=
ec, I still
> expect it to be compliant, it's just not implementing some newer things.
>
The only way a older driver following older spec can be compliant to newer =
spec, if the new spec remains same as old spec. :-)
However, the spec is suggesting to have finite timeout as "SHOULD".
Timeout is not part of the conformance _must_ clause.
So if old driver not following "SHOULD" suggestion of newer spec, does it m=
ake old driver non-compliant?
Your input on this will help me understand the conformance part.

> (...)
>=20
> >> > > Third how about making e.g. 0 a special value meaning no limit
> >> > > wait
> >> forever?
> >> > The whole idea is to have some finite/deterministic behavior,
> >>
> >> I guess I'm being dense, I just don't yet understand the motivation.
> >> The cost is difficulty in migration since each and every piece of
> >> hardware will have a different timeout.
> >>
> > Such timeout is already there. Advertising timeout doesn't change the L=
M
> flow.
> > A migrating device at the destination is anyway out of the reset when
> migration occurs.
>=20
> But it introduces values that may be different between different devices =
of the
> same type, no? I guess the destination would need to re-read the value to=
 get
> the current one. Not an insurmountable problem, but still needs some care=
.
>
When a device migrates to destination, it starts from where the device left=
 off on the source side.
So yes, destination side, device must be usable (out of reset), and after t=
hat its current state will be overwritten by the migrating device.
If you ask, does migration overwrite the reset timeout register value? I wo=
uld say no, because how long device would take to reset is decided by the d=
estination side implementation.

And this is probably yet another good reason to define migratable bits of a=
 virtio device in the live migration spec extension.

> >
> >> The idea is to have finite behaviour, I got that, but I don't really
> >> know where does the requirement come from, in what sense it's
> >> deterministic and why do we worry about reset specifically.
> >>
> >> Recovering from failure when hardware is broken?
> >>
> > I provided few examples in previous email.
> > Terminating a probe sequence of the device which is already on its path=
 of
> hotunplug.
>=20
> For that sequence, don't we need a timeout for *any* interaction with the
> device?=20
We do need a command timeout that will handle hotunplug scenario while unde=
r probe.
But handling command timeout has wider use, even without non racing hotunpl=
ug and plug sequences.
So it is better to drive it as separate extension in itself, which is self-=
contained.

> I thought this proposal was mainly about devices that take a long time
> to "warm up"...
>
Yes, certainly this proposal covers such device scenario.
In general, this proposal covers reset timeout as the register suggests.

> > VQ commands timeout handling is indeed needed but it is a separate
> enhancement in itself.
> > This one is self-contained enough that doesn't need to combined with
> command timeout.
>=20
> What about e.g. config writes; I think they might trigger some actions?
>
A driver can do config writes to the PCI virtio device without reset is com=
plete.
This is very common practice that driver follows to discover device propert=
ies.
It may trigger some action on the device, but PCI device is obligated to re=
spond to it for host driver to function properly.

> >
> >> > and hence the reasonable finite value.
> >> > When value is not specified, driver is expected to choose
> >> > reasonable value
> >> terminate the reset operation.
> >>
> >> No one has any idea what's reasonable.
> > I am sure a finite timeout in driver is reasonable than current infinit=
e one.
> > This is because it is making system more resilient to occasional device=
 errors.
> >
> >> There's no reason for a driver to choose any value - it has nothing el=
se to
> do.
> >>
> > At least for the devices that we are seeing, driver choosing a default =
value of
> 2 to 3 minutes is good enough and of course useful.
> >
> >> > Do you propose 0 as no limit to follow current driver behavior?
> >>
> >> Or maybe 0 will make driver poll.
> > Poll infinitely? Didn't follow the suggestion of 0.
>=20
> Isn't polling vs waiting something that's inherently an implementation ch=
oice
> for the driver? It's not like it can do something different if the operat=
ion just
> does not finish.

Exactly. I read it few times, but I wasn't sure what Michael was suggesting=
.

Timeout hint is to break infinite loop in a deterministic way. It is really=
 that simple.

I will wait to see if you/Michael has more comments before sending v3 that =
removes the feature bit.

