Return-Path: <stefanha@redhat.com>
Date: Mon, 26 Jul 2021 16:07:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
References: <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
 <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8QjdWK6WjEE+UY9g"
Content-Disposition: inline
In-Reply-To: <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--8QjdWK6WjEE+UY9g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2021 at 09:08:58PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/22 =E4=B8=8B=E5=8D=886:24, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Thu, Jul 22, 2021 at 03:33:10PM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/21 =E4=B8=8B=E5=8D=886:20, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > > On Wed, Jul 21, 2021 at 10:29:17AM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/20 =E4=B8=8B=E5=8D=884:50, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > I recognize that opaque device state poses a risk to migration
> > > > compatibility, because device implementors may arbitrarily use opaq=
ue
> > > > state when a standard is available.
> > > >=20
> > > > However, the way to avoid this scenario is by:
> > > >=20
> > > > 1. Making the standard migration approach the easiest to implement
> > > >      because everything has been taken care of. It will save implem=
entors
> > > >      the headache of defining and coding their own device state
> > > >      representations and versioning.
> > > >=20
> > > > 2. Educate users about migration compatibility so they can identify
> > > >      implementors are locking in their users.
> > >=20
> > > For vendor specific device, this may work. But for standard devices l=
ike
> > > virtio, we should go further.
> > >=20
> > > The device states should be defined in the spec clearly. We should re=
-visit
> > > the design if those states contains anything that is implementation
> > > specific.
> > Can you describe how migrating virtiofs devices should work?
>=20
>=20
> I need to learn more virtio-fs before answering this question.
>=20
> Actually, it would be faster if I can see a prototype of the migration
> support for virtio-fs and start from there (as I've suggested this in
> another thread).
>=20
>=20
> >   I think
> > that might be quicker than if I reply to each of your points because our
> > views are still quite far apart.
>=20
>=20
> Yes, it would be quicker if we can start from a prototype.

I have CCed Max Reitz to check whether a prototype of virtiofs migration
might be available soon?

But I can describe the key state that needs to be migrated:

- FUSE nodeid -> host inode mappings. The driver uses nodeid numbers in
  the FUSE protocol and the device maps them to actual inodes on the
  passthrough file system.
- FUSE fh -> open fd mappings. The driver uses fh numbers in the FUSE
  protocol and the device maps them to actual file descriptors on the
  host.
- FUSE fh -> open dir fd mappings. The driver uses fh numbers in the
  FUSE protocol and the device maps them to actual O_DIRECTORY file
  descriptors on the host.

The driver expects to be able to continue using nodeid and fh numbers
across migration. Let's look at just the open fds for a moment:

The OPEN command opens the file for a given nodeid and returns its fh.
Due to POSIX file system semantics there is no reliable way to reopen
the same file from just the filename. The problem is that a file can be
renamed or deleted (but still accessible until the last fd is closed).

Linux file handles (open_by_handle_at(2) and name_to_handle_at(2)) make
it possible to reopen the exact same file using a struct file_handle
instead of a filename. So the virtiofs device could transfer the Linux
file handles to the destination where the fd -> open fd mappings can be
restored.

The problem is that Linux file handles are an implementation-specific
solution to this problem. On non-Linux hosts there may be other
solutions that userspace file systems use to solve this problem. Or a
virtiofs device may not implement a passthrough host file system and
have a completely different concept of what an inode is.

This means only a subset of virtiofs implementations can use Linux file
handles as part of their device state. There is no way for the driver or
device to recreate or restore the necessary information without
implementation-specific device state like Linux file handles, though.

I guess this is just a summary of what we've already discussed and not
new information. I think an implementation today would use DBus VMState
to transfer implementation-specific device state (an opaque blob).

Stefan

--8QjdWK6WjEE+UY9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD+z68ACgkQnKSrs4Gr
c8j5cAgAjgXZBIzES6sljDnWqT5khlBrnhI2YapTkKpAaxxHZFRBfN1jEGU6Flee
5ePw2Q4G2EPC7TlGTdk0QOC6oxDvvbWGNmML/ab42sm1peX5ITrP6/zhpbnGsR+4
Ub1c4LE6VyadCWnBh2Gn5ui/TAoc3ObkBzcL49QDLivDlR1AvOWM1WXlaLe4tE7X
DsAR/8i2mW6d2LZguGDPKTdg+23to07wPm6q/5JvOIYt+xkt4CPXSfCC7gO9adEZ
i9Aap1fUd0KlTWIRZ46A7ffROUe0LFuDddgQOeq85e1dtjqRGKtOAv6gAQ1gdO60
aD2msnGJrE6ne1dIrWewFQEbgpC6cg==
=3m9T
-----END PGP SIGNATURE-----

--8QjdWK6WjEE+UY9g--

