Return-Path: <stefanha@redhat.com>
Date: Tue, 20 Jul 2021 13:47:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPbF3D3zG5Dsy5ZH@stefanha-x1.localdomain>
References: <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
 <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <87o8ax8dmc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m3yg3qN6+Ja7XLg7"
Content-Disposition: inline
In-Reply-To: <87o8ax8dmc.fsf@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--m3yg3qN6+Ja7XLg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 12:48:43PM +0200, Cornelia Huck wrote:
> On Tue, Jul 20 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Tue, Jul 20, 2021 at 11:04:55AM +0800, Jason Wang wrote:
> >> Let me clarify, I agree we can't have a standard device state for all =
kinds
> >> of device.
> >>=20
> >> That's way I tend to leave them to be device specific. (but not
> >> implementation specific)
> >
> > Unfortunately device state is sometimes implementation-specific. Not
> > because the device is proprietary, but because the actual state is
> > meaningless to other implementations.
> >
> > I mentioned virtiofs as an example where file system backends can be
> > implemented in completely different ways so the device state cannot be
> > migrated between implementations.
> >
> >> But we can generalize the virtqueue state for sure.
> >
> > I agree and also that some device types can standardize their device
> > state representations. But I think it's a technical requirement to
> > support implementation-specific state for device types where
> > cross-implementation migration is not possible.
> >
> > I'm not saying the implementation-specific state representation has to
> > be a binary blob. There could be an identifier registry to ensure live
> > migration compatibility checks can be performed. There could also be a
> > standard binary encoding for migration data. But the contents will be
> > implementation-specific for some devices.
>=20
> Can we at least put those implementation-specific states into some kind
> of structured, standardized form? E.g. something like
>=20
> <type category: file system backend data>
> <type identifier: file system foo>
> <length>
> <data>
>=20
> so that we can at least do compat checks for "I know how to handle foo"?

Yes, that's what I was trying to describe.

Stefan

--m3yg3qN6+Ja7XLg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD2xdwACgkQnKSrs4Gr
c8gHrwf6AwDZth12ypmWBZsCSRMMJ6DJoYAt4FbYGLVQLlVdLSjLGqZiO6mtQuu5
+JszIqHHsEoD3lewCndKqaLF60qrjCrTUiOlkZDnlGDb1fqzx+vPA1cghtiHna/s
dEXrNNg/bW5xgqz5tkYUbGyLxTOeYDRqpK2rDtC4c5k/81A3Bji9lfPcjlikcNS7
vWoxnUVVcSHzCaZ+iA6bVOeUNkFyaVDXRyxwqGY21VoAwPCBwTddPdAojWPdEdTQ
Nk/3VrNoYsx4uQnOXFfUH1aebc4hTYOU0Zeyd3VAKM/FJrdnUdyOZTjU+CJZ7owl
6ivzlfpjikMIPprqaJKlB1y83/MvMg==
=Jf6A
-----END PGP SIGNATURE-----

--m3yg3qN6+Ja7XLg7--

