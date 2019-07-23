Return-Path: virtio-dev-return-5878-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 470DC985D3F
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jul 2019 14:52:56 +0000 (UTC)
Date: Tue, 23 Jul 2019 15:52:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190723145250.GA8124@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-3-stefanha@redhat.com>
 <20190618213147-mutt-send-email-mst@kernel.org>
 <20190624135808.GC3833@stefanha-x1.localdomain>
 <20190624100448-mutt-send-email-mst@kernel.org>
 <20190625095515.GG3226@work-vm>
 <20190627100346-mutt-send-email-mst@kernel.org>
 <20190717124258.GA13761@redhat.com>
 <20190723133227.GG5445@stefanha-x1.localdomain>
 <20190723140855.GA11628@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20190723140855.GA11628@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 10:08:55AM -0400, Vivek Goyal wrote:
> On Tue, Jul 23, 2019 at 02:32:27PM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jul 17, 2019 at 08:42:58AM -0400, Vivek Goyal wrote:
> > > On Thu, Jun 27, 2019 at 10:09:16AM -0400, Michael S. Tsirkin wrote:
> > >=20
> > > [..]
> > > > Well it allocates resources on the host. If you don't
> > > > contain qemu then even just allocating virtual memory
> > > > can make host swap, right? If you contain it then
> > > > qemu will get killed instead but then you need to tell
> > > > guest what not to do so as not to get qemu killed.
> > >=20
> > > How is it different than running a malicious unpriviliged process on =
host?
> > >=20
> > > Denial of service should be mitigated by per process resource limits =
which
> > > will be true in this case as well.
> > >=20
> > > I am not sure I understand the concern here.
> >=20
> > There is a practical problem that the QEMU process may hit the mmap
> > limit and be unable to perform its own mmaps due to the DAX Window.  A
> > limit must be enforced on the host so that QEMU's internal mmaps
> > succeed.
>=20
> But number of mmaps are already limited by dax window size which is
> controlled by virtiofsd. So all user has to do is start with smaller
> dax window size if this ever becomes a concern.

Yes, the DAX Window size sets a hard limit on the number of mappings
(window_size / page_size).  I think we should still communicate a
maximum number of mappings to provide more control for cases where the
page size and DAX Window size don't produce a desirable number.

Consider that window_size =3D 8 GB and page_size =3D 4 KB already yields
2,097,152 maximum mappings.  Oops, that number is too large!

Stefan

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03H0IACgkQnKSrs4Gr
c8hUSAf9Gc+t5gI2fd9hHSWj8aDI73mPfAJSdRHNmSxpF20P7cdPtrPlEFfsKAVb
n+UMycQnyQMgG9ZKndfZn2k86HiAxeq+QL5W9APQiIhRsrnNv55AhWYxqaqZT0s3
697nqmmDRKAt+2rBTIOremG6anx1KJjYoxCQJjCH16TU3sv5JVkkAjZwQlmcT7TH
qmBVG7ojOBxW+ko+SXQh3Q6rSKLmIdDksm6Oh56EgtMSz62zmn1QM4K73o98jkGl
9LaInzVRGTe1qw4Jvg/+fk/FI93O+r1z6vdLrex1YCDZA1UiTu8jXXdTxE6J2jRf
ZW7wZF1EUfhVwCx6nSukzUw3YTu24w==
=nXiO
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
