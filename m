Return-Path: virtio-return-3100-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 14 May 2018 18:27:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180514172721.GT5182@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-4-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lzfPtAjrR1KYNfg0"
Content-Disposition: inline
In-Reply-To: <1524740402-18934-4-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH 3/6] ccw: map common notifications
 terminology to ccw
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--lzfPtAjrR1KYNfg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 12:59:59PM +0200, Halil Pasic wrote:
> The various notifications are introduced and specified in the common
> (i.e. transport agnostic) portion of this specification. How
> notifications are realised for a given transport is something each
> transport has to specify.
>=20
> Let's make the relationship between the virtio-ccw terms and the common
> terms more obvious.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> Changelog:
> * implemented Connie's suggestions (typos, grammar)
> * avoided 'realized using virtual interrupts'
> ---
>  content.tex |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index d7e2b18..e5b2499 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1943,6 +1943,18 @@ Bytes & Description & Contents \\
>  \hline
>  \end{tabular}
> =20
> +A virtio-ccw proxy device facilitates:
> +\begin{itemize}=20
> +\item Discovery and attachment of  virtio devices (as described above).

s/  / /

> +\item Initialization of virtqueues and transport specific facilities (us=
ing

s/transport specific/transport-specific/

Aside from that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lzfPtAjrR1KYNfg0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+cb5AAoJEJykq7OBq3PI2h4IAI5H2U56tlLE0yuVcMg2Dr1U
7pqMkMK16/m64zwzBCZWTEax8xyQCJS8ggSBOE0vxmAL2Ik/3LcCMcCjv6deS59Q
K3RdFnVu8YIdhQjmxxRtQ2bJXwbG95QHZu475kv2otP7P8PbtHJiArIsVnMPVUyG
waEIS8ZLLgTY/Y5pqHsoEclfhGyWjyjYro3ENwrKESHC8uRqqbQxyPSjEuBl9P7d
arDt8A7U4Jj1Hvv3yburRYb002ywEmyYwDh/wfLTJqwI9v/HAKeNA2rkXQrvvVri
jQT1q8DSjKmlC+EVSYzuyfLFOGDpLKFxbI3KleOB9mwJtMcxJYUlC6hv4JPsUzY=
=e5w5
-----END PGP SIGNATURE-----

--lzfPtAjrR1KYNfg0--
