Return-Path: virtio-dev-return-4132-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 21AC85818FAD
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 May 2018 03:04:02 -0700 (PDT)
Date: Wed, 23 May 2018 11:03:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180523100356.GA3898@stefanha-x1.localdomain>
References: <20180522191105.14400-1-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20180522191105.14400-1-christoffer.dall@arm.com>
Subject: [virtio-dev] Re: [PATCH] split-ring: Fix typo in used ring description
To: Christoffer Dall <christoffer.dall@arm.com>
Cc: virtio-dev@lists.oasis-open.org, felipe@nutanix.com, pbonzini@redhat.com, mst@redhat.com, lersek@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 09:11:05PM +0200, Christoffer Dall wrote:
> Only the device updates the used ring.
>=20
> This looks like a typo as a result of copy-paste from the description of
> the Available Ring.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/12
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  split-ring.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBTyMAAoJEJykq7OBq3PIDIAH/iUbYaQwu062NQK5ojnjRgtK
m2jfRr64mX/J/FlysUuI6a76UWL1vFEyvuNdzD/6fWAyLmiudgdEmMA6C0jyIM9y
rNFqvXui8JLCryU9u4aR82Pc851UJL8DExrNsdwqaoteUgSmW4xl+YdZOtgFrAIQ
lHX80HSVWY1nDYQED66DhbxymbzXqI7IgaeXx/SljF19pLsJNdK0QlVqkElTfYwt
CIEz/ob+qXTQiRdgBZaroX3odghr4JOJYcFTmG+hsgIW4iYAhiinPaWf5twrPPEE
oLkPyxpuuHydnVsow1Ia5UexJVjDXNTwjvBYGv1eECI1t9P/Ye1WC7rLFDKlaxg=
=r6FN
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
