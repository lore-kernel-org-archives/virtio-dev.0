Return-Path: <stefanha@redhat.com>
Date: Tue, 20 Jul 2021 13:57:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPbIHXPd1I13/K1U@stefanha-x1.localdomain>
References: <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
 <d4e7afdd-943d-73bd-3c31-c07543392819@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoiY9UgrljBSnBj3"
Content-Disposition: inline
In-Reply-To: <d4e7afdd-943d-73bd-3c31-c07543392819@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--ZoiY9UgrljBSnBj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 03:27:00PM +0300, Max Gurtovoy wrote:
> On 7/20/2021 6:02 AM, Jason Wang wrote:
> > =E5=9C=A8 2021/7/19 =E4=B8=8B=E5=8D=888:43, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
> > > > =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajnoczi=
 =E5=86=99=E9=81=93:
> > > > > > > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Hajn=
oczi =E5=86=99=E9=81=93:
> > > > > > > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang =
wrote:
> > > > > > > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan =
Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason W=
ang wrote:
> > > > > > > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Mic=
hael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > On Fri, Jul 09, 2021
> > > > > > > > > > > > > > > at 07:23:33PM +0200,
> > > > > > > > > > > > > > > Eugenio Perez Martin
> > > > > > > > > > > > > > > wrote:
> > > > > > > That's
> > > > > > > basically the difference between the vhost/vDPA's
> > > > > > > selective passthrough
> > > > > > > approach and VFIO's full passthrough approach.
> > > > > > We can't do VFIO full pasthrough for migration anyway,
> > > > > > some kind of mdev is
> > > > > > required but it's duplicated with the current vp_vdpa driver.
> > > > > I'm not sure that's true. Generic VFIO PCI migration can probably=
 be
> > > > > achieved without mdev:
> > > > > 1. Define a migration PCI Capability that indicates support for
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 VFIO_REGION_TYPE_MIGRATION. This allows =
the PCI device
> > > > > to implement
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 the migration interface in hardware inst=
ead of an mdev driver.
> > > >=20
> > > > So I think it still depend on the driver to implement migrate
> > > > state which is
> > > > vendor specific.
> > > The current VFIO migration interface depends on a device-specific
> > > software mdev driver but here I'm showing that the physical device can
> > > implement the migration interface so that no device-specific driver c=
ode
> > > is needed.
> >=20
> >=20
> > This is not what I read from the patch:
> >=20
> > =C2=A0* device_state: (read/write)
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The user application writes to =
this field to inform the vendor
> > driver
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 about the device stat=
e to be transitioned to.
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The vendor driver should take t=
he necessary actions to change
> > the
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device state. After s=
uccessful transition to a given state, the
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vendor driver should =
return success on write(device_state,
> > state)
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system call. If the d=
evice state transition fails, the vendor
> > driver
> > =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 should return an appr=
opriate -errno for the fault condition.
> >=20
> > Vendor driver need to mediate between the uAPI and the actual device.
>=20
> We're building an infrastructure for VFIO PCI devices in the last few
> months.
>=20
> It should be merged hopefully to kernel 5.15.

Do you have links to patch series or a brief description of the VFIO API
features that are on the roadmap?

>=20
> >=20
> >=20
> > >=20
> > > > Note that it's just an uAPI definition not something defined in the=
 PCI
> > > > spec.
> > > Yes, that's why I mentioned Changpeng Liu's idea to turn the uAPI int=
o a
> > > standard PCI Capability to eliminate the need for device-specific
> > > drivers.
> >=20
> >=20
> > Ok.
> >=20
> >=20
> > >=20
> > > > Out of curiosity, the patch is merged without any real users in
> > > > the Linux.
> > > > This is very bad since we lose the change to audit the whole design.
> > > I agree. It would have helped to have a complete vision for how live
> > > migration should work along with demos. I don't see any migration code
> > > in samples/vfio-mdev/ :(.
> >=20
> >=20
> > Right.
>=20
> Creating a standard is not related to Linux nor VFIO.
>=20
> With the proposal that I've sent, we can develop a migration driver and
> virtio device that will support it (NVIDIA virtio-blk SNAP device).
>=20
> And you can build live migration support in virtio_vdpa driver (if VDPA
> migration protocol will be implemented).

I guess "VDPA migration protocol" is not referring to Jason's proposal
but instead to a new vDPA interface that adds the migration interface
=66rom you proposal to vDPA?

Stefan

--ZoiY9UgrljBSnBj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD2yB0ACgkQnKSrs4Gr
c8jMWwf/RsoNa+sKNrWELPSOjSicZGv3Bx3Aga/iLes/q1LbCcMWm4z2XCOLIJMZ
VZh8c9nr6wJv9KZ9eCYal4jhpz0gZnqVBJO6/Blqmpcyi6wUAfE6ji9nRpm0ICCj
cj1y7cM81Eh4CWudlZ5nf5ty+pDYUegzOzMgmvfObp8t8YJWmg/9210XT9sUTIrW
5NZLbhNPtsBfvcIX9JdXLupWErDrnQLKhhWbwyq4jv75TI5H5HUMNCndqpqyrdqB
SqAf0tWcDRMifw64QNQm7YE/M2VFMBbYTt8oEyyQVT7qjdnO5k+Feq4E9K41EDES
9XYbz5+Sp2xXo27pQoTi1QcfMhhidQ==
=5Awb
-----END PGP SIGNATURE-----

--ZoiY9UgrljBSnBj3--

