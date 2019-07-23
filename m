Return-Path: virtio-dev-return-5877-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51FF4985D3F
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jul 2019 13:32:32 +0000 (UTC)
Date: Tue, 23 Jul 2019 14:32:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190723133227.GG5445@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-3-stefanha@redhat.com>
 <20190618213147-mutt-send-email-mst@kernel.org>
 <20190624135808.GC3833@stefanha-x1.localdomain>
 <20190624100448-mutt-send-email-mst@kernel.org>
 <20190625095515.GG3226@work-vm>
 <20190627100346-mutt-send-email-mst@kernel.org>
 <20190717124258.GA13761@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <20190717124258.GA13761@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 08:42:58AM -0400, Vivek Goyal wrote:
> On Thu, Jun 27, 2019 at 10:09:16AM -0400, Michael S. Tsirkin wrote:
>=20
> [..]
> > Well it allocates resources on the host. If you don't
> > contain qemu then even just allocating virtual memory
> > can make host swap, right? If you contain it then
> > qemu will get killed instead but then you need to tell
> > guest what not to do so as not to get qemu killed.
>=20
> How is it different than running a malicious unpriviliged process on host?
>=20
> Denial of service should be mitigated by per process resource limits which
> will be true in this case as well.
>=20
> I am not sure I understand the concern here.

There is a practical problem that the QEMU process may hit the mmap
limit and be unable to perform its own mmaps due to the DAX Window.  A
limit must be enforced on the host so that QEMU's internal mmaps
succeed.

Stefan

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03DGoACgkQnKSrs4Gr
c8h2gggAvhIBjzHALGMvka+iGKh+vGTZ78VonJ9VA6SMAh/j3h6JnUVvBvO0jRE0
Pkd6muEfqIuDw4hN/aLz4L8lB0PqG+NDbx6D51SIlqLEiqyk6fHPk3ylirSry2NJ
H7SDTXSBF8Xag2g5Q+A5RvYmxFLW4uw0KYlfr/Cf1BNy5r5R9RjdHIC96USODCnX
JsgEINjLaU7drAxiWKqaf7AgP4ZMf8fiYvJruCLL9wyeTPMlV0NcmUy/ZBWMphhZ
yzIT8ZWjpgkxDTjZNcAONA6iwv/M+hK8cjjWtHdy94vKCuDDKfdc7Y5hw5q8eQem
C6PiE/j+LWXcBOKhrltSe6V1a+Klzg==
=bQ4a
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
