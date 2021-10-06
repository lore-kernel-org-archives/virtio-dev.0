Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Wed, 6 Oct 2021 16:11:19 +0000
Message-ID: <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211006111143-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, October 6, 2021 8:52 PM
>=20
> On Wed, Oct 06, 2021 at 05:10:33PM +0300, Parav Pandit wrote:
> > Motivation:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Currently when driver initiates a device reset operation, a device may
> > not be able finish the reset operation immediately. In such case
> > driver waits for an arbitrary amount of time in a hope that device
> > will finish the reset.
>=20
> Hmm does it? Where does spec say that it does? Does not linux really wait
> forever?
This proposal doesn't claim that spec says so.
Linux pci transport waits infinitely.
Infinite is a valid arbitrary amount. Isn't it ?:-)

>=20
> > Depending on the device type and its backend implementation a device
> > timeout can be different. Trying to wait for all device type in same
> > value may not be efficient or adequate.
>=20
> Right but do we really want a timeout at all?
Yes, so that instead of waiting infinitely, it can be time bounded. More be=
low.
> Why not wait until device is ready or until ctrl-c?
Device may not be ready at all if its hotunplug is already initiated.
A device may not come back at all from reset.
Hence, device providing an upper bound is good hint to driver.

[..]

> >
> > +Once the driver initiates a reset, the device may not be able to
> > +finish the reset immediately. To accommodate that situation, the
> > +device can provide a hint to the driver about how long it might take
> > +the device to complete the reset. The driver should wait at least for
> > +the time specified by the device to let device finish the reset or if =
the device
> status field to become 0 within the specified time interval.
> > +
> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities
> > of a Virtio Device / Device Status Field}
> >
> >  The device MUST NOT consume buffers or send any used buffer
>=20
> First, do not use should outside normative sections. e.g. you can say "is
> expected".
>=20
should is used in same section which has used _must_ in it.
Can you please help me understand what makes a section normative?

> second, I don't see a story around compatibility here.
Device reset timeout is supported only when device offers the new VIRTIO_DE=
V_RESET_TIMEOUT.
When such feature is not offered, driver follows the guidance provided in t=
his proposal.
Compatibility is covered with the feature bit.

> previously pci drivers did wait, other drivers didn't.
>
The newer driver that implements updated spec, will adhere to newer content=
 of the spec.
=20
> I think drivers that actually do wait should somehow let the device know =
it's
> ready to wait.
>
Why should driver tell device that it is waiting?
Driver initiated a reset, device may take its time for reset and eventually=
 comes out.
What can device do differently by knowing that driver is waiting for reset =
to finish?
Device usually follow its standard steps to complete the reset action.
I do not anticipate that device will do reset differently if it knows that =
no one is waiting for reset to finish.

> Third how about making e.g. 0 a special value meaning no limit wait forev=
er?
The whole idea is to have some finite/deterministic behavior, and hence the=
 reasonable finite value.
When value is not specified, driver is expected to choose reasonable value =
terminate the reset operation.
Do you propose 0 as no limit to follow current driver behavior?

