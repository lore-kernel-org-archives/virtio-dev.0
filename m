Return-Path: virtio-dev-return-7585-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BD69986097
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 09:39:17 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:39:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717093908.GG128195@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-8-ndragazis@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <20200518203721.7625-8-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 07/10] vhost-user: minor fix on status
 register
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 11:37:18PM +0300, Nikos Dragazis wrote:
> Change the definitions of VIRTIO_VHOST_USER_STATUS_MASTER_UP and
> VIRTIO_VHOST_USER_STATUS_SLAVE_UP so that they refer to different bits.
> This is necessary because these two flags are orthogonal, i.e., they are
> unrelated and so they must be set/cleared individually.
>=20
> Mention explicitly who sets the VIRTIO_VHOST_USER_STATUS_MASTER_UP
> status bit.
>=20
> Fix typo:
>=20
> VIRTIO_VHOST_USER_SLAVE_UP -> VIRTIO_VHOST_USER_STATUS_SLAVE_UP
>=20
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RcbwACgkQnKSrs4Gr
c8hIXAgAvU1ezACrx0SUVID8AlCyG/nTopCKC8xc51o3IIcNn6E+xfAykjC7NZ01
RNKIlqLQgh6NiKun2EhGnoAdh0dknSTcH7UrvFGkr0EV9Yqbw0qP/YBVfduZUz5w
XOogeh9ZsEx885hTpEPliui5zDAajOwsMv5k+fX21A20npDeKvcVjAPCOW7rgOYM
lkvv/LLVuB2eCFa9buWzZzcoWppPjyQxldtvhEd2T0U+6dz3LbpEFwhRR5+xBIm4
DtzbdLUBCYZgXHHqZdwo805Nu/Rc2j75Kkhw68F2eYz3qrRNWiGfs9xYtzVZ1Zw0
NQp74xx6vActJFY3dI53S+G7EAc+Cw==
=AKfo
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--

