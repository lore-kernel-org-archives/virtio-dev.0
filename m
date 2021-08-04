Return-Path: <stefanha@redhat.com>
Date: Wed, 4 Aug 2021 09:38:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YQpSE66ZcInxYyjf@stefanha-x1.localdomain>
References: <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
 <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com>
 <YQk08YxioRkHZ2uw@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/+gKCfqNTZIEDgR0"
Content-Disposition: inline
In-Reply-To: <YQk08YxioRkHZ2uw@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--/+gKCfqNTZIEDgR0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 01:22:09PM +0100, Dr. David Alan Gilbert wrote:
> * Jason Wang (jasowang@redhat.com) wrote:
> >=20
> > =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=886:37, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > > On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
> > > > =E5=9C=A8 2021/7/26 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > > I guess this is just a summary of what we've already discussed an=
d not
> > > > > new information. I think an implementation today would use DBus V=
MState
> > > > > to transfer implementation-specific device state (an opaque blob).
> > > >=20
> > > > Instead of trying to migrate those opaque stuffs which is kind of t=
ricky, I
> > > > wonder if we can avoid them by recording the mapping in the shared
> > > > filesystem itself.
> > > The problem is that virtiofsd has no way of reopening the exact same
> > > files without Linux file handles.
> >=20
> >=20
> > I believe if we want to support live migration of the passthrough
> > filesystem. The filesystem itself must be shared? (like NFS)
> >=20
> > Assuming this is true. Can we store those mapping (e.g fuse inode -> ho=
st
> > inode) in a known path/file in the passthrough filesystem itself and hi=
de
> > that file from the guest?
>=20
> That's pretty dangerous; it assumes that the filesystem is only used
> together with virtiofs; as a *shared* filesystem it's possible that it's
> being used directly by normal NFS clients as well.
> It's also very racy; trying to make sure those mappings reflect the
> *current* meaning of inodes even while they're changing under your feet
> is non-trivial.

Right, it's impossible to guarantee that you will reopen or even be able
to find the same inode for the reasons I've mentioned (deleting and
renaming files) plus more (inode number reuse).

Stefan

--/+gKCfqNTZIEDgR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEKUhMACgkQnKSrs4Gr
c8jKXQf/RSoOGaNS0Q+GGVBNPwXt1jQEG4rVJH0yZ8sK8uQELtHHTlCmkma45G2R
c6mTdVTYc46DBbNbpxVe9us2g+OuwB4GQfUg8lKe7CrpNzN/6RaCF/RjlmAdRH6N
V16Yp813bV4mmIw+NQ4+1hj4/569NAG/5DKrBIe+d75nSzDcQRWERwZAo8/uVbgn
789QIOg1QB7Wv25Ic8gMH/cj+efvnUEb43YEFoQKhNznAfp9n7q5lZLz6j0OyCr/
Y7VqQJi2fBPCMsLQfIWvCBccImYLEx5ZnoNL5DchWnvvqzOwv+RgJ6SpeTl8kQB6
aWzTzjt9jnOJIEr1MRFrOJ8pfHLEgw==
=F84q
-----END PGP SIGNATURE-----

--/+gKCfqNTZIEDgR0--

