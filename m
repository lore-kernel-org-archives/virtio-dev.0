Return-Path: virtio-dev-return-6282-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 203AB985B20
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Nov 2019 09:47:52 +0000 (UTC)
Date: Mon, 4 Nov 2019 10:47:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20191104094741.GD4682@stefanha-x1.localdomain>
References: <20191101075615.2780-1-sf@sfritsch.de>
MIME-Version: 1.0
In-Reply-To: <20191101075615.2780-1-sf@sfritsch.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH] Fix typo
To: Stefan Fritsch <sf@sfritsch.de>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2019 at 08:56:15AM +0100, Stefan Fritsch wrote:
> It's balloon, not ballon.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Looks good, thanks!  Typo fixes are merged directly by Michael Tsirkin
without the need for a GitHub Issue or committee vote.

Also "hi!", I think I saw you at KVM Forum :).

Stefan

> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/content.tex b/content.tex
> index b1ea9b9..d73182f 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4646,7 +4646,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Me=
mory Balloon Device / Virtque
>  \item[2] statsq.
>  \end{description}
> =20
> -  Virtqueue 2 only exists if VIRTIO_BALLON_F_STATS_VQ set.
> +  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
> =20
>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device=
 / Feature bits}
>  \begin{description}
> --=20
> 2.20.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2/870ACgkQnKSrs4Gr
c8j59Af/ePKN5uIE7sPtB0JgEuB8KpjGgfODeEhEqnsYIQ+S4rdrWfLGjLp4v51C
D3BGbqFOj51hyLGvW9NP5ZZToVUdqKjpGX0ECrq2zm2qcjv/24urI/f7L0++H7Vy
R5TLO5yVkX5vtWOc6lEKYYMsX4kzZScDzWb6aY31mvI3vfqZoOuLQJ6XG5/+0V1P
1kaYc40kuF6rGsBlHiX4KRp+/OBXRzZankpQuAJ7J0WDEHElxQaybuWJqxINBP5y
/FOKtGjZOpxlmqFDB6L8CFWnkYCn70umFd92XiOtJvU7D24rQsem3HGOQq0/86fz
N7iOPfrJ7CBE8Ue4S70FkPRpJWwy5w==
=siK7
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

