Return-Path: virtio-dev-return-8172-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 552F5986038
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 May 2021 14:38:05 +0000 (UTC)
Date: Mon, 24 May 2021 15:37:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YKu6IZjRlLUun6TJ@stefanha-x1.localdomain>
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
 <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A67i1yzufIOzWPsy"
Content-Disposition: inline
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--A67i1yzufIOzWPsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 12:28:14PM -0700, Hao Chen wrote:
> > Can you share a bit about the reason for defining a new VIRTIO device
> > instead of running an existing key-value store over virtio-vsock or
> > virtio-net?
>=20
> The reason for defining a virtio-parameter-server device is we are intera=
cting
> with some devices in a "key-value store" pattern. For example, we interac=
t with
> "vehicle device" in Android using this pattern.
>=20
> Ad-hoc protocol over vsock to a k-v store works, but we want to
> standardize these
> types of devices so that the VM doesn't need to know the
> vendor-specific key-value
> protocols for a specific device implementation.

Thanks for explaining. Would publishing a k-v store protocol spec for
use with vsock? That way it's a well-known protocol that anyone wishing
to use k-v store functionality can use.

One nice effect of defining a protocol over vsock instead of a new
VIRTIO device is that implementation could be as simple as a
Python/Go/Rust/etc library that's easy to integrate into applications. A
VIRTIO device is more low-level and complex, making it more costly for
others to implement.

Stefan

--A67i1yzufIOzWPsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCruiEACgkQnKSrs4Gr
c8hOVAgAoshFt5u36K2h1uboQm1/vFceAzPouG1zUEkWpA1zAuNo8UIf3Xvkplo0
bKshnwEuCrdyE1210sXGSW7oDyO2aOznme6g/AWoDkwuS+kTPpH/QzOjqISt51GL
86oOIjZK5nzIWjDiBn21kb0TBPeLD1xceWxD3s7RIPxkH0csN++j45QVrmK5l/MW
PXMVsvsAXHrMfvEVe3omhGPRatt99WVGbQ/+KIAcggNR5zC6MORDZhLFJUpJ5vLd
b0HHeeXLYa0UnX57yqck8N0LKCthtLGvuwCYQyHe/hsIlA/YRJTQ/DtpcYnEk0rY
ovAE1fMdCc4Eveqoi9H1/hFEvORa0A==
=G5c5
-----END PGP SIGNATURE-----

--A67i1yzufIOzWPsy--

