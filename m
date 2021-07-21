Return-Path: <stefanha@redhat.com>
Date: Wed, 21 Jul 2021 11:48:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPf7mwXMG5tbyQx8@stefanha-x1.localdomain>
References: <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
 <d4e7afdd-943d-73bd-3c31-c07543392819@nvidia.com>
 <YPbIHXPd1I13/K1U@stefanha-x1.localdomain>
 <2d24c89b-9a6f-921b-55f2-50b522e1eb91@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IDk9dp4ovLYsWkKS"
Content-Disposition: inline
In-Reply-To: <2d24c89b-9a6f-921b-55f2-50b522e1eb91@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--IDk9dp4ovLYsWkKS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 04:09:27PM +0300, Max Gurtovoy wrote:
>=20
> On 7/20/2021 3:57 PM, Stefan Hajnoczi wrote:
> > On Tue, Jul 20, 2021 at 03:27:00PM +0300, Max Gurtovoy wrote:
> > > On 7/20/2021 6:02 AM, Jason Wang wrote:
> > > > =E5=9C=A8 2021/7/19 =E4=B8=8B=E5=8D=888:43, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > > On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
> > > > > > =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > > > > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnocz=
i =E5=86=99=E9=81=93:
> > > > > > > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajn=
oczi =E5=86=99=E9=81=93:
> > > > > > > > > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang =
wrote:
> > > > > > > > > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan =
Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason W=
ang wrote:
> > > > > > > > > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Ste=
fan Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jas=
on Wang wrote:
> > > > > > > > > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36,=
 Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > > > On Fri, Jul 09, 2021
> > > > > > > > > > > > > > > > > at 07:23:33PM +0200,
> > > > > > > > > > > > > > > > > Eugenio Perez Martin
> > > > > > > > > > > > > > > > > wrote:
> > > > > > > > > That's
> > > > > > > > > basically the difference between the vhost/vDPA's
> > > > > > > > > selective passthrough
> > > > > > > > > approach and VFIO's full passthrough approach.
> > > > > > > > We can't do VFIO full pasthrough for migration anyway,
> > > > > > > > some kind of mdev is
> > > > > > > > required but it's duplicated with the current vp_vdpa drive=
r.
> > > > > > > I'm not sure that's true. Generic VFIO PCI migration can prob=
ably be
> > > > > > > achieved without mdev:
> > > > > > > 1. Define a migration PCI Capability that indicates support f=
or
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0 VFIO_REGION_TYPE_MIGRATION. This al=
lows the PCI device
> > > > > > > to implement
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0 the migration interface in hardware=
 instead of an mdev driver.
> > > > > > So I think it still depend on the driver to implement migrate
> > > > > > state which is
> > > > > > vendor specific.
> > > > > The current VFIO migration interface depends on a device-specific
> > > > > software mdev driver but here I'm showing that the physical devic=
e can
> > > > > implement the migration interface so that no device-specific driv=
er code
> > > > > is needed.
> > > >=20
> > > > This is not what I read from the patch:
> > > >=20
> > > >  =C2=A0* device_state: (read/write)
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The user application write=
s to this field to inform the vendor
> > > > driver
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 about the device=
 state to be transitioned to.
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The vendor driver should t=
ake the necessary actions to change
> > > > the
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device state. Af=
ter successful transition to a given state, the
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vendor driver sh=
ould return success on write(device_state,
> > > > state)
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system call. If =
the device state transition fails, the vendor
> > > > driver
> > > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 should return an=
 appropriate -errno for the fault condition.
> > > >=20
> > > > Vendor driver need to mediate between the uAPI and the actual devic=
e.
> > > We're building an infrastructure for VFIO PCI devices in the last few
> > > months.
> > >=20
> > > It should be merged hopefully to kernel 5.15.
> > Do you have links to patch series or a brief description of the VFIO API
> > features that are on the roadmap?
>=20
> we devided it to few patchsets .
>=20
> The entire series can be found at:
>=20
> https://github.com/jgunthorpe/linux/commits/mlx5_vfio_pci
>=20
> We'll first add support for mlx5 devices suspend/resume (ConnectX-6 and
> above).
>=20
> The driver is ready in the series above.

I looked briefly and it seems to implement the existing
VFIO_REGION_TYPE_MIGRATION API for mlx5 devices? I thought
"infrastructure for VFIO PCI devices" meant you were adding new
VFIO/mdev migration APIs.

Stefan

--IDk9dp4ovLYsWkKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD3+5sACgkQnKSrs4Gr
c8jc9wf/RmqlChY2zXupM4eEloYScfpvawMTaMHZT+784KHVSNF1Q03UObC4l6Av
sgklOavnRc1FC9R78oYK82I+cypZBf7DN33lq5dED1kCrL+4SKDgWmAP9xkRSW8j
2DCcpz1JcCLuea/nIemz5opB+QgxK9+QdTTm0X6vQoIruPmuP4dR/qCMdaMq/03e
XW1zF1CHVEtWRzEsqo5G2ZQU4IzHVY08nBZpC+SivkafFFXQo1AdrPKEG6s0bclh
ZHgYRlzcIuV1LDrCphEovif//RADzwl92s/OsDMOWKk8NYj/2mqGO5jMiu27D20D
Hxc1XAcAb2c907LggKRZ8NhAx4rMkw==
=Pr8D
-----END PGP SIGNATURE-----

--IDk9dp4ovLYsWkKS--

