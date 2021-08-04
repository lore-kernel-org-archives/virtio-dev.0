Return-Path: <stefanha@redhat.com>
Date: Wed, 4 Aug 2021 10:20:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YQpb970f5gU6eDIq@stefanha-x1.localdomain>
References: <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
 <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com>
 <YQk08YxioRkHZ2uw@work-vm>
 <b19364de-dcdf-af1a-3f33-c0d814d0dd3b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpbTYXUoUYJzTqrZ"
Content-Disposition: inline
In-Reply-To: <b19364de-dcdf-af1a-3f33-c0d814d0dd3b@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--lpbTYXUoUYJzTqrZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 09:42:34AM +0800, Jason Wang wrote:
> =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=888:22, Dr. David Alan Gilbert =E5=86=
=99=E9=81=93:
> > * Jason Wang (jasowang@redhat.com) wrote:
> > > =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=886:37, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > > On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/26 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > I'd expect how Linux implementations work to be standardised.
>=20
>=20
> Does it mean we need:
>=20
> 1) port virtiofsd to multiple platforms

Correct migration requires a non-POSIX mechanism to reopen files (saving
inode numbers as you've suggested isn't enough). If that's unavailable
then it won't be possible to migrate safely.

> 2) only support live migration among virtiofds

We can standardize the device state representation for Linux passthrough
file systems and implement it in QEMU's virtiofsd and virtiofsd-rs.

However, it's technically possible for other virtiofsd implementations
to migrate too and they shouldn't be second-class citizens. QEMU's
virtiofsd isn't special and Linux passthrough file systems aren't
special.

Some device state representations will apply to one specific virtiofs
implementation, so the value of standardizing it beyond choosing a
unique identifier to prevent collisions is questionable. Does the VIRTIO
TC want to spend time reviewing implementation-specific device state
representations?

What I suggest is to allow in-band implementation-specific device state
with a unique identifier that prevents migration between incompatible
implementations. Standardize device state representations that are
actually worth standardizing (like the Linux passthrough file system
where there are multiple implementations): implementors benefit from
using the standard because it saves them time and ensures migration
compatibility.

Stefan

--lpbTYXUoUYJzTqrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEKW/cACgkQnKSrs4Gr
c8jklwgAnzYjB+vTjwbxLo+ZWqtT8k4K4katBoIKZOzwdFtYYi25MSTsHJksHd4C
BdW0qp4uHCMTudI1hmyi5AovjDkqDdNnSmBmiwvjypJBhfpGFDVgZlZWm+9GrG96
ghBw0oF49RFC3jWSpMvCcO3ZDUh2oxyMncjCAugyAIwnaahFGwhGcdSpvthNQM4h
TeEATgt2tc7vkYZgGq+2JmT0guUNmM+IjK9ksiVL7KHdNxOQ1tz3emhxRuWbeW+U
iUUqETzb9XBoK/8moL8IfzRzCCi8bUkYTfaqFSzTT8OTmmNW+CSHfnhWncOzZ1dm
dLoIhmwlxjPLZNzXe8N34ZDcNflvTw==
=q9jU
-----END PGP SIGNATURE-----

--lpbTYXUoUYJzTqrZ--

