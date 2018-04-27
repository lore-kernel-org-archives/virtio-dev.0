Return-Path: virtio-dev-return-3983-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AFF3C5818E8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 06:49:34 -0700 (PDT)
Date: Fri, 27 Apr 2018 14:49:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427134918.GC11150@stefanha-x1.localdomain>
References: <20180427113624.15020-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20180427113624.15020-1-david@redhat.com>
Subject: Re: [virtio-dev] [PATCH v1] content: reserve virtio device ID for
 memory devices
To: David Hildenbrand <david@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 01:36:24PM +0200, David Hildenbrand wrote:
> Reserve device ID 24 for virtio-mem devices.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4ypeAAoJEJykq7OBq3PIPzMIALjnXyo5RKNv6hZDY+sy3mKC
cob32A9L3zXY/PF9a0boVIdZEeGe8W6o8gC+ZSkWiMTycrGKXt26tXDYkk9o9nTc
nsN747Cimd71H1ZIoxOg0W6eScNn//rnyRHaqaN2UWm7lzwKfuNon0K3UtW6fDUL
n2oShWHZ3MtgpB/NkQvCBrwEX0btxrqlS+nL+XWUNYZUs34xvftNCcYRxRGfleOq
tWnorQtUqxLUFrLYBRzlf+/c14ariLPWGlR/G56bNIpOZGUy/eKq/nD0R+LNfFm4
J+MiSKpXqRytV7lihhcaVA8dr4axYVzkg+wlZ6oRtacSpFDZHZjkQpEpMCoBO00=
=WNMY
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
