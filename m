Return-Path: virtio-return-2767-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 12 Jul 2017 10:35:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712093520.GB6923@stefanha-x1.localdomain>
References: <20170711115129.18828-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20170711115129.18828-1-cohuck@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH] virtio-net: fix virtqueue numbering error
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 01:51:29PM +0200, Cornelia Huck wrote:
> receiveq(n) is at position 2(n-1)+1. Same error for transmitq(n)
> and controlq.
>=20
> VIRTIO-161
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  content.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index d8bde3a..2319729 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3064,9 +3064,9 @@ features.
>  \item[0] receiveq1
>  \item[1] transmitq1
>  \item[\ldots]
> -\item[2N] receiveqN
> -\item[2N+1] transmitqN
> -\item[2N+2] controlq
> +\item[2(N-1)] receiveqN
> +\item[2(N-1)+1] transmitqN
> +\item[2(N-1)+2] controlq

There is still only one controlq overall.  Therefore I suggest:

  \item[2N] controlq

This seems clearer to me since "\item[2(N-1)+2] controlq" makes it look
like the controlq is repeated along with rx and tx queues.

Stefan

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZe1YAAoJEJykq7OBq3PIVfkH/3l1293Em8TAytNmy3AWHJMc
GuhYlmj3+wK2zaaGTklH0G6JwlHuoBYpnVFHctm2nNwNriBNNs9hMcjZpEJorUUG
CanBGmPkx5AUV5rPR48QWSVE7QmmAUBAH2qQfePQmTPQmnWUfL97dNH4C8xjiik6
pG0bW5bDY3wPQS0oSkpEoKRU98Dg8sCMFnnNKJJdcEgQ8Shb43rGXUL0BaOLRLzW
a4gZTT+arsARgu2j6lRFVI240pvsX6neroZ7tEvts95f5qvQZfEkTyOJ1NAGYGm9
miPD/+vkFgMFmbT9wUzDHBwaBN65ktroZ6Ot0AEsL1vmiI2Mf1hjKkOT5uVSNo0=
=kCfo
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
