Return-Path: virtio-dev-return-3874-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BB465818F80
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 02:24:48 -0700 (PDT)
Date: Thu, 19 Apr 2018 17:24:33 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180419092433.GA4327@stefanha-x1.localdomain>
References: <1524071419-32187-1-git-send-email-jonathan.helman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1524071419-32187-1-git-send-email-jonathan.helman@oracle.com>
Subject: Re: [virtio-dev] [PATCH] content: document hugetlb page allocation
 counts
To: Jonathan Helman <jonathan.helman@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, mihai.carabas@oracle.com, mst@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 10:10:19AM -0700, Jonathan Helman wrote:
> The Linux kernel exports the number of successful and failed
> hugetlb page allocations via the virtio balloon driver. These
> two counts need to be documented in this specification.
>=20
> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> ---
>  content.tex | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2GBRAAoJEJykq7OBq3PIA+kH/iQybkNq4PppyryVJJsXTcrz
EkolADkmew6pQYJnXfTqWzVNn64TffZNVxJtHwadlSMz3BQF3xzVuxCK0a/yf/mh
tHxwKYTGmUqjy3Sb68GPCDJkpsd2RNGkGRsc/yMPknY3yxJsTKv8tvPCAxOSGi7P
Hy+jLSL+j6owebqewphP5Egh7vtl3J8Rie0/lZazCbJX0NGuWhf+iuQI0FDw9pB1
VhJ3dmiCy4azt3eMP0fSCjS6QTOPtsFEKspPrMp+C7vKW9aMys2fYQH6k4SPwUHc
dckt33M84CVl4vC3iR2eSQGzy5Dgeati03hhixL/650D32jI2m5D3BPcALEuu9s=
=e/R5
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
