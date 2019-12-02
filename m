Return-Path: virtio-dev-return-6439-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 699EF985C08
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 16:29:54 +0000 (UTC)
Date: Mon, 2 Dec 2019 16:29:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20191202162946.GC139090@stefanha-x1.localdomain>
References: <20191202100216.133556-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191202100216.133556-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document VIRTIO_BLK_T_GET_ID
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
To: virtio-dev@lists.oasis-open.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 10:02:16AM +0000, Stefan Hajnoczi wrote:
> The VIRTIO_BLK_T_GET_ID request type was implemented in Linux and QEMU
> in 2010.  It does not have a feature bit but devices respond with
> VIRTIO_BLK_S_UNSUPP if a request type is unimplemented.
>=20
> This patch documents the VIRTIO_BLK_T_GET_ID request type as currently
> implemented in Linux and QEMU.
>=20
> Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  content.tex | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/63

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3lO/oACgkQnKSrs4Gr
c8ha/ggAnfZGDFackeSZnUgPnAJ4bKdkgIAUhHGAY3DDy6MxyjRqtwAdaihVOZIH
+94T9LYTReY5MBg3PRYVGarPKYLUZ3fneUOQHjQ5Urwd4WkKm1PGkKgPu+HP4wuD
anj5DL5FcHmEq2fDN3UhhnHxmV6l8heM9pS4pYYXF/2gIBA6UWZt6rQNKsmDXMxb
NfE0efN29p133z8/3N3kJAev+ON+nTw9qbHWPnR95usCtyCKz368J9PmgM08P6/U
A6h8dkOepBOkUm3BtFbMfkFEYA28mL1U0K7qnuu0UBiNLUesKsJRSstokOt0F8Zp
EzfTzNm6v/jDklKiS6JAB5IvxodyFQ==
=fVuv
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

