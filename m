Return-Path: virtio-dev-return-2874-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 754175819162
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2017 08:31:27 -0800 (PST)
Date: Thu, 21 Dec 2017 16:31:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171221163112.GA8327@stefanha-x1.localdomain>
References: <20171221144504.12747-1-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20171221144504.12747-1-sameeh@daynix.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: Add missing flag define to
 struct
To: Sameeh Jubran <sameeh@daynix.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 04:45:04PM +0200, Sameeh Jubran wrote:
> From: sameehj <sameeh.j@gmail.com>
>=20
> The flag VIRTIO_NET_HDR_F_DATA_VALID is aleady  mentioned in the virtio-n=
et
> spec however it is not defined in the struct. This flag is already defined
> and used in virtio-net device in Qemu as well as some of it's drivers.
> ---
>  content.tex | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaO+HQAAoJEJykq7OBq3PI4lEH/iyTqWNHCzSawAvm7z6LHoa9
CB4r335S5WWjVlTC8qBIshN8ru6uDMqR1hCBUiampKLlVetjT0f/BJN+m7Bg5lo2
YMMDx68nE1nvTYgK+6FyiMMNYg0fVKRyY+lsbsbwYnbqfpDtu46/YWlh+fyWNdm2
Jz6nKgsuT7Njhxy6lbha43oioxX7J/EEg9ov9xOqF2ybBjuje5q80XR0qCVLZVbW
F5XE8Bje/j0PSZW7tEPLnGZdwqHaFMEf8B6Cdf9WTXhHq4xs+fp/b0UPDLIasPO4
N23q3Ef1TEnqR63O7iuTPA4oj0dRN/Ltt/264TBo4i6UER4pItr/ARWhCDrxAA0=
=S2gb
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
