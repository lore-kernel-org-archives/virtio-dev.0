Return-Path: <stefanha@redhat.com>
Date: Mon, 4 Oct 2021 10:11:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: Remove duplicate paragraph
Message-ID: <YVrFUb+A5CkT1V25@stefanha-x1.localdomain>
References: <20210930125847.28823-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EZDlFG5xH+tcPX5F"
Content-Disposition: inline
In-Reply-To: <20210930125847.28823-1-jean-philippe@linaro.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--EZDlFG5xH+tcPX5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2021 at 01:58:48PM +0100, Jean-Philippe Brucker wrote:
> It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
> type") had a merge issue. It includes the device normative paragraph for
> Shared memory capability, which was already added right above it by
> commit 855ad7af2bd6 ("shared memory: Define PCI capability"). Remove the
> duplicate paragraph.
>=20
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> This applies onto "Fix copy/paste bug in PCI transport paragraph", that
> fixes both paragraph titles.
> https://lists.oasis-open.org/archives/virtio-comment/202108/msg00097.html
> ---
>  content.tex | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EZDlFG5xH+tcPX5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFaxVEACgkQnKSrs4Gr
c8g6mAf+LZfysBAoM0ilowaO+I5AY0bEtZnYPRl8tmeJHVarTdNCJU1lY5c7L+QZ
9CJt+nLKpYwwxtCMISCECJNPIBIWTM+2mnA/Qy7MZ/eD0zLA204fOva3UWp2pUpN
Cks1AMoGxIrn7lBdStxNKd6nsmO9I+b9vXW+QWknDKx/XouaHVyUPkVJeTGTOMEN
0m/0XLUy4vvhX8N/KRTd5hCwU/+R8+HiOUB5xFYE84JjR8vCIiKi/v9FWa5sIys7
eiICXzQrlqFAsxx/1VFqJIHx3kThOdvMJ/y1wtTutm23WQOjEy6mIW+WY6XlPCyL
Dry1gwMbCy3pvujI/esihtjB+Ttwng==
=/rpw
-----END PGP SIGNATURE-----

--EZDlFG5xH+tcPX5F--

