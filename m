Return-Path: virtio-dev-return-5941-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DF01984399
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Aug 2019 13:56:52 +0000 (UTC)
Date: Mon, 12 Aug 2019 14:56:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190812135647.GK9959@stefanha-x1.localdomain>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726082553-mutt-send-email-mst@kernel.org>
 <20190726123416.GG2657@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Content-Disposition: inline
In-Reply-To: <20190726123416.GG2657@work-vm>
Subject: [virtio-dev] Re: [PATCH v5 0/2] virtio-fs: add virtio file system device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 01:34:16PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > Didn't look at the spec yet, but I have a question:
> >=20
> > On Fri, Jul 26, 2019 at 10:53:36AM +0100, Stefan Hajnoczi wrote:
> > > v5:
> > >  * Explain multiqueue semantics: no ordering, identical functionality=
 on each queue, one FUSE session state shared between all queues
> > >  * Explain how the FUSE session is started with a FUSE_INIT request
> > >  * Consistently use "submit" vs "made available" and "complete" vs "u=
sed" terminology [Michael]
> > >  * Explain endianness [Michael]
> > >  * Clarify hiprio vs normal queue usage [Michael]
> > >  * Move SHOULD, MUST, etc wording into normative sections [Michael]
> > >  * Mention that FUSE_INIT negotiated state needs to be transferred du=
ring live migration [Michael]
> > >  * State that the DAX window is mapped with writeback caching like RA=
M [Michael]
> > >  * Mention DAX window mapping alignment constraints (they are communi=
cated via the FUSE protocol) [Michael]
> > >  * Explain that FUSE_SETUPMAPPING fails when device resources are exh=
austed and that splitting mappings consumes resources too [Michael]
> > >  * Clarify access rules to DAX window - only touch memory that has a =
mapping establised
> > >  * Document that DAX data persistence is achieved via FUSE_FSYNC
> >=20
> >=20
> > The following was raised during v4 review:
> >=20
> > 	> > > > There is a practical problem that the QEMU process may hit the=
 mmap
> > 	> > > > limit and be unable to perform its own mmaps due to the DAX Wi=
ndow.  A
> > 	> > > > limit must be enforced on the host so that QEMU's internal mma=
ps
> > 	> > > > succeed.
> > 	> > >
> > 	> > > But number of mmaps are already limited by dax window size which=
 is
> > 	> > > controlled by virtiofsd. So all user has to do is start with sma=
ller
> > 	> > > dax window size if this ever becomes a concern.
> > 	> >
> > 	> > Yes, the DAX Window size sets a hard limit on the number of mappin=
gs
> > 	> > (window_size / page_size).  I think we should still communicate a
> > 	> > maximum number of mappings to provide more control for cases where=
 the
> > 	> > page size and DAX Window size don't produce a desirable number.
> > 	> >
> > 	> > Consider that window_size =3D 8 GB and page_size =3D 4 KB already =
yields
> > 	> > 2,097,152 maximum mappings.  Oops, that number is too large!
> > 	>
> > 	> Ok, so that's something which will be in virtiofsd where maximum num=
ber
> > 	> of outstanding can be configured by user and if we cross that limit,
> > 	> FUSE_SETUPMAPPING will be returned with some error?
> >=20
> > 	Yes, virtiofsd will enforce the limit.
> >=20
> > 	The guest driver will also be aware of the limit via VIRTIO
> > 	configuration space.
> >=20
> > was this addressed?
>=20
> In this version Stefan has marked SETUPMAPPING to say it can fail if out
> of resources.
>=20
> The tricky problem with specifying a limit is that the limit is more
> likely to be global than to be per-device, and so specifying it in
> either the virtio config space or (as looked more appropriate) fuse init
> doesn't feel right.
>=20
> IMHO we should never hit the limit in practical use, so it's really just
> a matter of saying that it can fail and setting a large enough limit
> that non-abusive drivers dont cause a problem.

Yep, I updated the spec to mention that FUSE_SETUPMAPPING fails when
there are insufficient resources.  Drivers expect that it can happen and
will have to unmap existing mappings if they wish to make new ones.

Stefan

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1RcB8ACgkQnKSrs4Gr
c8jlgggAsMw/cbPwFq6lv01O1BovTiHAtRyedqNF1wC0Ow++vdQgzzbFmt0Ha11o
PqHrVwL0rAk/gio8leZDcWj2p5WZKs4wWvMmzRC8PeLwdbNZc7NREiOWx9AjUUXq
rNQihZB064H4OqNitjOoM277I7m8XVU4AWcVCSdjMhQf+DJqz9coiriftmFdZERV
ABZYXFf1KyBRGGiECU0ljE0NjuJrJuqOysmF4fdvfRh7Iy8kKKOZIAAD8NzqJlCr
P7GahHUCV7zBPjIdmmOjnHtoQD2+OCtFyzPHX7SGvqRtT8zsBg4IFt8YQZtnb7+H
ux91JuTkebqbyUNh1wFICh0FC4z2Aw==
=Lc98
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--
