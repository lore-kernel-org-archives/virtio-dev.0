Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Thu, 7 Oct 2021 03:42:24 +0000
Message-ID: <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211006163309-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, October 7, 2021 2:23 AM
> On Wed, Oct 06, 2021 at 04:11:19PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, October 6, 2021 8:52 PM
> > >
> > > On Wed, Oct 06, 2021 at 05:10:33PM +0300, Parav Pandit wrote:
> > > > Motivation:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Currently when driver initiates a device reset operation, a device
> > > > may not be able finish the reset operation immediately. In such
> > > > case driver waits for an arbitrary amount of time in a hope that
> > > > device will finish the reset.
> > >
> > > Hmm does it? Where does spec say that it does? Does not linux really
> > > wait forever?
> > This proposal doesn't claim that spec says so.
> > Linux pci transport waits infinitely.
> > Infinite is a valid arbitrary amount. Isn't it ?:-)

[..]
> > > First, do not use should outside normative sections. e.g. you can
> > > say "is expected".
> > >
So this proposal used the SHOULD in the section 2.1.1 which is the normativ=
e section as per the driver conformance clause 1.
Or I misunderstood?

> > should is used in same section which has used _must_ in it.
>=20
> yea, some of these things slip through.
>=20
> > Can you please help me understand what makes a section normative?
>=20
> It starts with
> \devicenormative
> or
> \drivernormative
>=20
> and is linked from the conformance section.
>
Ok. I understand better now.

> >
> > > second, I don't see a story around compatibility here.
> > Device reset timeout is supported only when device offers the new
> VIRTIO_DEV_RESET_TIMEOUT.
> > When such feature is not offered, driver follows the guidance provided =
in
> this proposal.
> > Compatibility is covered with the feature bit.
>=20
> Well hmm. Problem is, devices need to be reset before feature bits are re=
ad.
>
Yeah, this means that we should remove the feature bit and instead follow y=
our suggestion that if the register value is zero, the feature is not offer=
ed,
If it is non zero, driver should follow the timeout.
=20
> > > previously pci drivers did wait, other drivers didn't.
> > >
> > The newer driver that implements updated spec, will adhere to newer
> content of the spec.
>=20
> right but we can't just unconditionally say driver must wait, this would =
declare
> old driver non-compliant and we promised not to do that.
>=20
It is not said unconditionally. It comes with spec version, isn't it?
This change should increment the spec version so old driver are compliant t=
o some older version of the spec.
Hence, there is no breakage with some old driver.

> > > I think drivers that actually do wait should somehow let the device
> > > know it's ready to wait.
> > >
> > Why should driver tell device that it is waiting?
> > Driver initiated a reset, device may take its time for reset and eventu=
ally
> comes out.
> > What can device do differently by knowing that driver is waiting for re=
set to
> finish?
> > Device usually follow its standard steps to complete the reset action.
> > I do not anticipate that device will do reset differently if it knows t=
hat no one
> is waiting for reset to finish.
>=20
> I think it might matter for hypervisors, these can thinkably block the wr=
ite until
> reset completes if driver is not going to wait.  For the hardware - if dr=
iver is not
> waiting then hardware has to block the response to the following non post=
ed
> transaction whatever that is.
Hardware will continue to follow reset semantics regardless of advertising =
the timeout. (and hence=20

> Doing that blocks the cpu and generally breaks the whole timeout idea. Wh=
ich
> you seem to want for some reason ...
No. advertising the reset timeout value doesn't change the reset flow of de=
vice or driver.
So it doesn't break anything.
It only means that linux driver code doing vp_reset() infinitely, will inst=
ead do it for the timeout given by device.

>=20
>=20
> >
> > > Third how about making e.g. 0 a special value meaning no limit wait
> forever?
> > The whole idea is to have some finite/deterministic behavior,
>=20
> I guess I'm being dense, I just don't yet understand the motivation.
> The cost is difficulty in migration since each and every piece of hardwar=
e will
> have a different timeout.
>
Such timeout is already there. Advertising timeout doesn't change the LM fl=
ow.
A migrating device at the destination is anyway out of the reset when migra=
tion occurs.
=20
> The idea is to have finite behaviour, I got that, but I don't really know=
 where
> does the requirement come from, in what sense it's deterministic and why =
do
> we worry about reset specifically.
>=20
> Recovering from failure when hardware is broken?
>
I provided few examples in previous email.
Terminating a probe sequence of the device which is already on its path of =
hotunplug.
=20
> Can we even trust timeout values hardware gives us then?
>=20
Sure, why not. Device usually going to provide the reset timeout value base=
d on its backend implementation.
If its completely broken device (driver can always do min() of timeout valu=
e given by device and its own).

> What about a ton of other stuff like command vq commands timing out?
>
VQ commands timeout handling is indeed needed but it is a separate enhancem=
ent in itself.
This one is self-contained enough that doesn't need to combined with comman=
d timeout.
=20
> > and hence the reasonable finite value.
> > When value is not specified, driver is expected to choose reasonable va=
lue
> terminate the reset operation.
>=20
> No one has any idea what's reasonable.
I am sure a finite timeout in driver is reasonable than current infinite on=
e.
This is because it is making system more resilient to occasional device err=
ors.

> There's no reason for a driver to choose any value - it has nothing else =
to do.
>
At least for the devices that we are seeing, driver choosing a default valu=
e of 2 to 3 minutes is good enough and of course useful.

> > Do you propose 0 as no limit to follow current driver behavior?
>=20
> Or maybe 0 will make driver poll.
Poll infinitely? Didn't follow the suggestion of 0.

>=20
> --
> MST

