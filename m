Return-Path: <stefanha@redhat.com>
Date: Wed, 6 Oct 2021 10:17:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v5] virtio-pmem: PMEM device spec
Message-ID: <YV1ptxs8Ydb0lgv4@stefanha-x1.localdomain>
References: <20211006062157.21768-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TUMNVJgqQq+FFVMB"
Content-Disposition: inline
In-Reply-To: <20211006062157.21768-1-pankaj.gupta.linux@gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com
List-ID: <virtio-dev.lists.oasis-open.org>


--TUMNVJgqQq+FFVMB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 06, 2021 at 08:21:57AM +0200, Pankaj Gupta wrote:
> Posting virtio specification for virtio pmem device. Virtio pmem is a
> paravirtualized device which allows the guest to bypass page cache.
> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> device is merged in Qemu 4.1.
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>=20
> Incorporated all the suggestions during the review. Request for
> merging the spec.=20
>=20
> v3 -> v4
>   Text format changes in security implication section - Stefan
>   Minor text/while space change - Cornelia
>=20
>  conformance.tex |  16 +++++-
>  content.tex     |   1 +
>  virtio-pmem.tex | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TUMNVJgqQq+FFVMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFdabcACgkQnKSrs4Gr
c8iIfAf/QHDPkzCCaN7A6h+eSCGVhmBUnknRO2lZeK+PP5L59j0UA33LVc2XXIq/
lAcgVZ0n9bLpssQaJnVKR/UyLz8L5qkRRfOtj63WCxldA9CVF60l0uWHasTrGT4W
BdY+D0zpydzJtUI8W+CgRijC8arl8iywx+kbjOgH9n4PpU7NztYQGjVmNgQOvqBD
6l8z7oXeeXAJBGp4w5WTLRMq/oUuMaIwjiG0Bvh/z/tHktp5CdXgNFl6KLfyvYd2
LZJhvnpPGq5lsdRy7qxrtjMAjJIZDghXCiE1rJ2/0njWjYZt4IK7Sa0sd1MgILMi
hyfhbzYUDGu5wjQ8WMgddEDFftYRwQ==
=td1i
-----END PGP SIGNATURE-----

--TUMNVJgqQq+FFVMB--

