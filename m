Return-Path: virtio-dev-return-5691-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E81E2985F54
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Apr 2019 14:54:57 +0000 (UTC)
Date: Thu, 25 Apr 2019 15:54:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190425145449.GF17806@stefanha-x1.localdomain>
References: <20190423105235.5749-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20190423105235.5749-1-sf@sfritsch.de>
Subject: Re: [virtio-dev] [PATCH 1/2] Rename msix_config to config_msix_vector
To: Stefan Fritsch <sf@sfritsch.de>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 12:52:35PM +0200, Stefan Fritsch wrote:
> The text talks about config_msix_vector. Only struct
> virtio_pci_common_cfg has the name msix_config.
>=20
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwco5AAoJEJykq7OBq3PIeysIAISwiQU/xc2qZ+RoC6QYbNRI
Iibr362CUxHc1MRYm+0f/0BrmsurmZI4ldsAJgcrqEV0VUfNS2FgdcJbJbZLxq7D
p9xd0l9a0wV1d4PkA22jCR4eqKmwGOhJ6Pwz/G7EscKdbxePZff6N7YQoKRfYaVn
fxJB33g71s7fortxPC5bUwprttkbZoNLlZDMA9ommPf276uKX3y5EfTZWEmmaVKr
8tBHwr3MnjrVy5cqBsZLR3v/0+4IBtD9HmM0wFtK9Kzcy9VzpysrVwVwRq6ezUfI
cg22y0qbJQpjUDGBUO2s53oBL2Gn8cZ8UtA00LDPGkDYIi2dCsZp7eyU/auYfvE=
=tvhi
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
