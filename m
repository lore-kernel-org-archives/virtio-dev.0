Return-Path: virtio-dev-return-6233-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DBDE984325
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Oct 2019 08:45:05 +0000 (UTC)
Date: Mon, 14 Oct 2019 09:45:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20191014084502.GG22963@stefanha-x1.localdomain>
References: <e0fb8838-c6c2-4c1e-4a14-d0b2671c524a@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <e0fb8838-c6c2-4c1e-4a14-d0b2671c524a@siemens.com>
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Rename remaining
 QueueAvail/Used references
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2019 at 06:41:32PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> These have been changed in ae98c6bc21bc. Convert the rest.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  content.tex | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Please create a GitHub Issue so that a vote can be started:
https://github.com/oasis-tcs/virtio-spec/issues

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2kNY4ACgkQnKSrs4Gr
c8jqowf/QgPGMkigApi2Fb5XRTyfSUSlznWqrxuhFP9/jvuyeTE+NzqHEgZyqZCz
9DZ52PnQC74rr2YmZbFWkheqcwSRx3OjrhrWXprfKlrpPp+muK5dUd+4+C3m9mgO
H6B1pV9SWoWwtW8fG4N6Tqu+m8rThKUUvwLBbd6OPDlbvxRMpcCSCh7VMPR1HQKR
u2xqZnqgSu7giGBVS6lh1kDjtW6QVvV7OYUEjHhcbVyxug4P+OsXCoygqzhe1nOl
8GDXtZCMK45ajb8GyXZWQB5YQBD4S5QEJJlB8qH7W74/5ak/deLVBpyO7IHy9lLs
lGuvMGW5eEeaPPypn4olDdVOqIydBA==
=otG+
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
