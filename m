Return-Path: virtio-dev-return-8033-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD70B9860B2
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Feb 2021 15:58:56 +0000 (UTC)
Date: Wed, 24 Feb 2021 15:57:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YDZ3hSj6c7NQ9kz2@stefanha-x1.localdomain>
References: <CAPR809srddYRtoPue9aROJbdeFVxRRSMxzGmP5NnaoxGmJhqoA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPR809srddYRtoPue9aROJbdeFVxRRSMxzGmP5NnaoxGmJhqoA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add lifetime metrics to virtio-blk
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xrgkOLuopaiuY5yv"
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--xrgkOLuopaiuY5yv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2021 at 10:59:26AM -0700, Enrico Granata wrote:

Thanks! Minor comments below:

> @@ -4648,6 +4653,20 @@ \subsection{Device Operation}\label{sec:Device
> Types / Block Device / Device Ope
>  \field{data}.  The device ID string is a NUL-padded ASCII string up to 2=
0 bytes
>  long.  If the string is 20 bytes long then there is no NUL terminator.
>=20
> +The \field{data} used for VIRTIO_BLK_T_GET_LIFETIME requests consists of=
 one
> +segment which is populated by the device, and is of the form:

"consists of one segment" should probably be removed. The framing
(layout) of requests is up to the driver (see 2.6.4 Message Framing).
struct virtio_blk_lifetime could be a single descriptor, it could be
split across multiple descriptors, or it could be combined in a
larger descriptor with the virtio-blk request status byte.

> +
> +\begin{lstlisting}
> +struct virtio_blk_lifetime {
> +    le16 eol;
> +    le16 lifetimeA;
> +    le16 lifetimeB;
> +};
> +\end{lstlisting}
> +
> +The device lifetime metrics \field{eol}, \field{lifetimeA} and
> \field{lifetimeB}
> +have the semantics described by the JEDEC standard No.84-B50.

Is there a more specific way of referencing this? For example, the
section of the spec that describes these fields. Are the called "eol",
"lifetimeA", "lifetimeB" in the eMMC spec?

--xrgkOLuopaiuY5yv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA2d4UACgkQnKSrs4Gr
c8jwYwf+M409A4n2DxAKR5Maon3n4wUWl99Yl1gtz+gU8VGFRAEio+vlqd2yWutd
COQZiC71Oqo9ZnS/6OrxJKbfJuDpJXvy53Mkkfw2gGZkGp8ZPnSgLxNg6iokuuvV
O7suWlBgoSrqefMx9yQT7bxNtQb6L7E9gw0OZaMEUAe65fk659df3sq2g1ZlwfAx
y9aCfKzjw+cwtkoi6wgHIa3jtp1tOxO2vcRd4pUZ1dplLqF92fs9Ut+N9Sdf2DtH
rqhR3J90Yik/OejODtPVsTrjaU8sZmbfA8FQEQRDjtRPu24v2dj7x4sSzRcikdCm
OQuo+dEj3+f+MHMjNgp9t0s+6TRgsw==
=rlXx
-----END PGP SIGNATURE-----

--xrgkOLuopaiuY5yv--

