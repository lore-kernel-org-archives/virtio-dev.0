Return-Path: virtio-dev-return-8077-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80168986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 18:21:03 +0000 (UTC)
Date: Mon, 1 Mar 2021 18:20:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YD0wg2oFaqqJyID5@stefanha-x1.localdomain>
References: <CAPR809to17OpKuAvoYvdjpZYmVxbTi5umTABc4UZf90iqC0UmA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPR809to17OpKuAvoYvdjpZYmVxbTi5umTABc4UZf90iqC0UmA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3] Add lifetime metrics to virtio-blk
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SaGT430vimzqZxdw"
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--SaGT430vimzqZxdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 10:51:03AM -0700, Enrico Granata wrote:
> In many embedded systems, virtio-blk implementations are
> backed by eMMC or UFS storage devices, which are subject to
> predictable and measurable wear over time due to repeated write
> cycles.
>=20
> For such systems, it can be important to be able to track
> accurately the amount of wear imposed on the storage over
> time and surface it to applications. In a native deployments
> this is generally handled by the physical block device driver
> but no such provision is made in virtio-blk to expose these
> metrics for devices where it makes sense to do so.
>=20
> This patch adds support to virtio-blk for lifetime and wear
> metrics to be exposed to the guest when a deployment of
> virtio-blk is done over compatible eMMC or UFS storage.
>=20
> Signed-off-by: Enrico Granata <egranata@google.com>
> ---
>  content.tex | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

Great, please request a Technical Committee vote:
https://github.com/oasis-tcs/virtio-spec/#use-of-github-issues

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SaGT430vimzqZxdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA9MIMACgkQnKSrs4Gr
c8jo1Qf/Tu6lVggUx7vZYhVX6bzzeJXvQ4jepbfPc52AmK7MX9Iugjx1H5MwNuDW
GA2TmfHdftA5XK2rnHcJjxdABBAaBpcMRv0heuFhe1jdnv5ojav3Anv35oZARhX9
2TbyS9EdelR+QBcBBMSefbbwu1hDi/E2ACS9S+UvF1/0GppEXXLHYd/zxzX/n4pS
JL76sNJEstoNWN0+y4PzeOSN+voVzsFC4ThfnDvtcNH2iD68db9lQV0ea+bmLufq
1debldQnkuCVddcukgiGHQ1gWc92vhehpa7QdLd9sab7rff9h6sn7xUUQcec7IjV
/hsogwlAsS3WSYQ7COiBSG2dtBVuVw==
=Oqzg
-----END PGP SIGNATURE-----

--SaGT430vimzqZxdw--

