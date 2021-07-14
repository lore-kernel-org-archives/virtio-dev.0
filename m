Return-Path: <virtio-dev-return-8279-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AB5A9863E1
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Jul 2021 09:17:29 +0000 (UTC)
Date: Wed, 14 Jul 2021 10:17:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YO6ro345FI0XE8vv@stefanha-x1.localdomain>
References: <20210505193655.2414268-1-egranata@google.com>
 <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tfHaj6t9vUOw3iWt"
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--tfHaj6t9vUOw3iWt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2021 at 12:37:26PM -0700, Enrico Granata wrote:
> ---------- Forwarded message ---------
> From: Enrico Granata <egranata@google.com>
> Date: Wed, May 5, 2021 at 1:37 PM
> Subject: [PATCH v2] Provide detailed specification of virtio-blk
> lifetime metrics
> To: <virtio-dev@lists.oasis-open.org>
> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> <linux-block@vger.kernel.org>,
> <virtualization@lists.linux-foundation.org>
>=20
>=20
> In the course of review, some concerns were surfaced about the
> original virtio-blk lifetime proposal, as it depends on the eMMC
> spec which is not open
>=20
> Add a more detailed description of the meaning of the fields
> added by that proposal to the virtio-blk specification, as to
> make it feasible to understand and implement the new lifetime
> metrics feature without needing to refer to JEDEC's specification
>=20
> This patch does not change the meaning of those fields nor add
> any new fields, but it is intended to provide an open and more
> clear description of the meaning associated with those fields.
>=20
> Signed-off-by: Enrico Granata <egranata@google.com>
> ---
> Changes in v2:
>   - clarified JEDEC references;
>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
>   - clarified reserved block references
>=20
>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)

Ping?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tfHaj6t9vUOw3iWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDuq6MACgkQnKSrs4Gr
c8i1HggAwJQGN50p+awjS6KkIOs5sd3zqyld/3Fbv4HCpJ6HhVRXZzLk69vf8VPB
IfyJx+UGG7Ega47o+4Y2lfcm0DUeMeXWdcnbpUfUO6k7pjFBcNYAjQvryLBkx3fN
CrgbFF/caPkMLABvGicwUqcCwxPvnLpQhQWHbwnKRp9Jf99e6Ccd2V+dBtbOIOTf
ze9dr3whuw8FM+icXTjgy+hqGjMKFLI0fw1I/qcANHbYeqJDHRlfOpjZncCQ4m8/
168u5czbpHHxWj1UJpCRM6cjQ17ESQX6+mCHS+aeacCDtoH6Nz12ZCww5MUXmsuk
YoucVTwe+OesjHKkbDNGY00o5dhiLg==
=UXTI
-----END PGP SIGNATURE-----

--tfHaj6t9vUOw3iWt--

