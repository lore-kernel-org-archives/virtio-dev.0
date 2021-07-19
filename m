Return-Path: <virtio-dev-return-8329-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C61098635C
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jul 2021 14:14:12 +0000 (UTC)
Date: Mon, 19 Jul 2021 13:46:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YPV0MCYv751xfNVq@stefanha-x1.localdomain>
References: <9fa7575c80200335ee32c9269ce5efcf0a729be7.1626418413.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <9fa7575c80200335ee32c9269ce5efcf0a729be7.1626418413.git.viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] [PATCH] Add .gitignore file
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KbpC5TXIFgyLk6s1"
Content-Disposition: inline
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--KbpC5TXIFgyLk6s1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 16, 2021 at 12:26:13PM +0530, Viresh Kumar wrote:
> Add .gitignore to not see the unnecessary list of build generated files
> with commands like git status.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .gitignore | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 .gitignore

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Maybe this can be merged without a vote since it doesn't affect the
contents of the VIRTIO specification.

Stefan

--KbpC5TXIFgyLk6s1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD1dC8ACgkQnKSrs4Gr
c8jwcAf/Uzh/+rTv3y0X36nVJMYq8TBY9Jj0A+rfx2N3uqbKeZDfST8giS1ORn+y
Wjyp4DKHj5CMmDoOp3e6iGobSfSKl+zGGAG0AuDC/6vIyZ6aQVnBgOa2TPVtmMEt
px78l6gIK+ens8f//ciSMpYSxdJ/9KRejMMZmTe6mt7ZoXYIdhpkBlRycAFv4Xm0
rZ3Ng2dcKf3BdRBBIRL3MX6yjc1jCzLi0AY9LI09BSam1IRO6wuzwuf43d3L7s49
UCRaPXmqUSp3Y+hGBCRt01L/mqP+FDScfdHUws1ifzbRLKeqiQpOCqsNrJ6n24x9
QUadTkPuWyI9CXTe1OOZ2nDZutWXUw==
=27sG
-----END PGP SIGNATURE-----

--KbpC5TXIFgyLk6s1--

