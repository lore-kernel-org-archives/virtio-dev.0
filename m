Return-Path: virtio-dev-return-5880-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 422E0985D57
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jul 2019 08:33:20 +0000 (UTC)
Date: Wed, 24 Jul 2019 09:33:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190724083314.GA11957@stefanha-x1.localdomain>
References: <20190618213147-mutt-send-email-mst@kernel.org>
 <20190624135808.GC3833@stefanha-x1.localdomain>
 <20190624100448-mutt-send-email-mst@kernel.org>
 <20190625095515.GG3226@work-vm>
 <20190627100346-mutt-send-email-mst@kernel.org>
 <20190717124258.GA13761@redhat.com>
 <20190723133227.GG5445@stefanha-x1.localdomain>
 <20190723140855.GA11628@redhat.com>
 <20190723145250.GA8124@stefanha-x1.localdomain>
 <20190723155623.GA19189@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20190723155623.GA19189@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 11:56:23AM -0400, Vivek Goyal wrote:
> On Tue, Jul 23, 2019 at 03:52:50PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jul 23, 2019 at 10:08:55AM -0400, Vivek Goyal wrote:
> > > On Tue, Jul 23, 2019 at 02:32:27PM +0100, Stefan Hajnoczi wrote:
> > > > On Wed, Jul 17, 2019 at 08:42:58AM -0400, Vivek Goyal wrote:
> > > > > On Thu, Jun 27, 2019 at 10:09:16AM -0400, Michael S. Tsirkin wrot=
e:
> > > > >=20
> > > > > [..]
> > > > > > Well it allocates resources on the host. If you don't
> > > > > > contain qemu then even just allocating virtual memory
> > > > > > can make host swap, right? If you contain it then
> > > > > > qemu will get killed instead but then you need to tell
> > > > > > guest what not to do so as not to get qemu killed.
> > > > >=20
> > > > > How is it different than running a malicious unpriviliged process=
 on host?
> > > > >=20
> > > > > Denial of service should be mitigated by per process resource lim=
its which
> > > > > will be true in this case as well.
> > > > >=20
> > > > > I am not sure I understand the concern here.
> > > >=20
> > > > There is a practical problem that the QEMU process may hit the mmap
> > > > limit and be unable to perform its own mmaps due to the DAX Window.=
  A
> > > > limit must be enforced on the host so that QEMU's internal mmaps
> > > > succeed.
> > >=20
> > > But number of mmaps are already limited by dax window size which is
> > > controlled by virtiofsd. So all user has to do is start with smaller
> > > dax window size if this ever becomes a concern.
> >=20
> > Yes, the DAX Window size sets a hard limit on the number of mappings
> > (window_size / page_size).  I think we should still communicate a
> > maximum number of mappings to provide more control for cases where the
> > page size and DAX Window size don't produce a desirable number.
> >=20
> > Consider that window_size =3D 8 GB and page_size =3D 4 KB already yields
> > 2,097,152 maximum mappings.  Oops, that number is too large!
>=20
> Ok, so that's something which will be in virtiofsd where maximum number
> of outstanding can be configured by user and if we cross that limit,
> FUSE_SETUPMAPPING will be returned with some error?

Yes, virtiofsd will enforce the limit.

The guest driver will also be aware of the limit via VIRTIO
configuration space.

Stefan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl04F6gACgkQnKSrs4Gr
c8gJTAf/aNuYZOklxWCFB+0p726vVqFKjn/NVR85hc2smqhTxJYd1LI5+S5OZtnD
sow6pj8DXMVWnskdvR0Rr2usCq9wzG6SLdrEL5u6WirBzISS/Q8uG5uOeasMDGaH
TPr7kGwjUrQU++q8hscIgLeu1clbIbHGt70u1HWF2mjLLWhne4oWofdXcPbnD5x1
UthVqxO3xpCJo2Uc7z4C4gEi9dAXkply0DjC17HNdyBkMD5NgsSHRiIP86hAOHA0
W1uQOgZIqgpqo37T2zFKxcHWKEpoBvfO3MFn8y8GAGhf5z0LUyfs9vW9BVKRFoKJ
tkVG3bcWsmLUC/9lU/RC/VUQXu5dDA==
=lF2H
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
