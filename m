Return-Path: <stefanha@redhat.com>
Date: Wed, 4 Aug 2021 09:36:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YQpRq2u3vyeFqX08@stefanha-x1.localdomain>
References: <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
 <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ihxnX5RDysvlvgyv"
Content-Disposition: inline
In-Reply-To: <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--ihxnX5RDysvlvgyv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 07:42:31PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=886:37, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/26 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > I guess this is just a summary of what we've already discussed and =
not
> > > > new information. I think an implementation today would use DBus VMS=
tate
> > > > to transfer implementation-specific device state (an opaque blob).
> > >=20
> > > Instead of trying to migrate those opaque stuffs which is kind of tri=
cky, I
> > > wonder if we can avoid them by recording the mapping in the shared
> > > filesystem itself.
> > The problem is that virtiofsd has no way of reopening the exact same
> > files without Linux file handles.
>=20
>=20
> I believe if we want to support live migration of the passthrough
> filesystem. The filesystem itself must be shared? (like NFS)

The virtiofs device is not tied to any particular file system backend.
The file system could be shared (available from both the source and
destination) or local. It might be a passthrough file system or
something else (an in-memory file system similar to Linux tmpfs, a
non-POSIX network storage like a REST object storage API, etc).

Stefan

--ihxnX5RDysvlvgyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEKUasACgkQnKSrs4Gr
c8ixvQgAhbwnvT0M4hgzZkRJ7WJFOt+SzEwAp+GuEI+/m/kcVszig89XDUtCH/TW
dina9HyBm/hFlaK+0gUlKqTDIAy4NJjicgvkeND/+BRbrK4zjv90Sdymhpg898oo
MU/Zpvj8PPt4lAUT6ahrUpYpWM8upJu2lTU1QIc6ieqxIszyz7olBXBujYIKJOTT
8nQcUXbxXJ0VunM6+Cdre2v4x1pynY/mca+k/dQ2q1yEensPeVmSSqJonFrMQcuQ
QXeb8wmKdASkhTCNjkPp2fnsy8JneGL8jZNMpaViCelIQJYGnspycgQpj76Sq4tP
8z3jVdAsXqEEx+6v0VCR6u0XaXUyhA==
=cwf9
-----END PGP SIGNATURE-----

--ihxnX5RDysvlvgyv--

