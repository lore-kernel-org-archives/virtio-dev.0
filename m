Return-Path: virtio-dev-return-5971-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2E6A985E55
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 15:21:38 +0000 (UTC)
Date: Tue, 13 Aug 2019 16:21:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190813152131.GC32090@stefanha-x1.localdomain>
References: <20190813125133.19754-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20190813125133.19754-1-pagupta@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: document console vq detach buffer
To: Pankaj Gupta <pagupta@redhat.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, amit@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 06:21:33PM +0530, Pankaj Gupta wrote:
> This patch documents console special case where vq buffers
> are deleted at port hotunplug time. This behavior is different in
> other devices where vq buffers are deleted at device unplug time.
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index ee0d7c9..33e8ccc 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -497,6 +497,8 @@ \section{Device Cleanup}\label{sec:General Initializa=
tion And Device Operation /
>  of a live virtqueue.
> =20
>  Thus a driver MUST ensure a virtqueue isn't live (by device reset) befor=
e removing exposed buffers.
> +Console has a special property that when port is detached virtqueue is c=
onsidered stopped, device
> +must not use any buffers, and it is legal to take buffers out of the dev=
ice.

The word "detach" is not defined or used in the spec, so it's unclear
what this is supposed to mean.  Is this related to a control message
(VIRTIO_CONSOLE_PORT_OPEN)?

How about:

  The device MUST NOT use buffers after it has sent
  VIRTIO_CONSOLE_PORT_OPEN with value=3D0 for a port.

I'm not sure what you mean by "take buffers out of the device"?  I guess
you mean the driver can modify the vring because the device isn't
looking.

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1S1XsACgkQnKSrs4Gr
c8iaJwf+PoRMrNd7dSL++mEd2zvapD7GBT87YEDBqrf5kmmPRUMcNNyz/EmRmTLk
uHmzw89O3VUYz8a9u67On8AAtGWS8QU6Z0a1atEKA1QkllyLLB/5n4JUMdxqLRYU
PVYEgy6hftiVDETn/eRtezq0FtX0XQbT80udAkyZs9GxG++aMjpajweY9f8Ie1Pd
nlxI3eYqI918rxr9vb8Mw+peisgfswvnA8TmONKDTCGcG0HU1ALVVVFME6okpd+h
Xmhz134Il6rSFI9keFS1zIaWJ/20zqxWHdoNMGA7hFAI8JjE57upyhg96A2hQpCe
eyuYdrH7L9i4jnBrYOVq1/VsUCMMyA==
=3gLi
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
