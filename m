Return-Path: virtio-dev-return-5688-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 007C1985EDB
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Apr 2019 19:35:00 +0000 (UTC)
Date: Wed, 24 Apr 2019 20:34:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190424193457.GC31664@stefanha-x1.localdomain>
References: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
 <1556032699-22135-5-git-send-email-ndragazis@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <1556032699-22135-5-git-send-email-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH 4/4] vhost-user: update shared memory
 capability
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, Vangelis Koukis <vkoukis@arrikto.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 06:18:19PM +0300, Nikos Dragazis wrote:
> The virtio vhost-user device has shared memory resources. Therefore, it
> uses the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability to standardize
> those resources through the PCI Configuration Space. This patch
> synchronizes the virtio vhost-user device spec with the following shared
> memory resources PATCH:
>=20
> https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html
>=20
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

CCing David Gilbert, author of the shared memory resource spec.

> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index 605272f..4a2fee3 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -318,7 +318,22 @@ \subsubsection{Notification structure layout}\label{=
sec:Device Types / Vhost-use
>  \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-=
user Device Backend / Additional Device Resources over PCI / Shared Memory =
capability}
> =20
>  The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMO=
RY_CFG
> -capability.
> +capability. Using the additional \field{offset_hi} and \field{length_hi}
> +fields following the SHARED_MEMORY_CFG capability structure, the shared
> +memory region's 64-bit BAR offset is calculated as follows:
> +
> +\begin{lstlisting}
> +        offset_hi << 32 + cap.offset
> +\end{lstlisting}
> +
> +and the shared memory region's 64-bit length is calculated as follows:
> +
> +\begin{lstlisting}
> +        length_hi << 32 + cap.length
> +\end{lstlisting}
> +
> +The \field{cap.offset} and \field{cap.length} fields are taken from the
> +SHARED_MEMORY_CFG capability structure.
> =20
>  \devicenormative{\paragraph}{Shared Memory capability}{Device Types / Vh=
ost-user Device Backend / Additional Device Resources over PCI / Shared Mem=
ory capability}
>  The device MUST present exactly one shared memory capability.
> --=20
> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwLphAAoJEJykq7OBq3PIMhYIAIJDDgM+MnDI8R6YIwl0ooUt
IBkNT8xvMcDpaOPp20OhW3ZmjhTFqeg36azzD3vy9ki46xQxzqA67nqn9bE2Cm8Q
y9yjMc3/fuDfXiMJ2h4IvH+CeqOszHi7NVAFvb+OGN11hOpfBv5aJe4V9M5XwTLd
Fd0WcZm9C9NHmmQhueIzGqWg4N2iqhqEw07iprDDi5euO1Lkqqprd9mMuaVo+RxK
WIpTHdDLBl4kLCFk99ACCEx8nVktxBsJOW6rmlTBpw+5pQ5gZMv0rmFMaCpPRCWV
Ctza8Hyc3KEyXF9NSRUSajjxdKFoubhDaAirnymE7JaRSsxMKfockz0sRznZDz0=
=gMz9
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
