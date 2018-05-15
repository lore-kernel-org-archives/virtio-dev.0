Return-Path: virtio-return-3104-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 15 May 2018 10:00:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515090052.GW5182@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-7-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xi8lRpXYeGgNnUjs"
Content-Disposition: inline
In-Reply-To: <1524740402-18934-7-git-send-email-pasic@linux.ibm.com>
Subject: Re: [virtio] [PATCH 6/6] notifications: update notifications
 terminology for devices
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--xi8lRpXYeGgNnUjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 01:00:02PM +0200, Halil Pasic wrote:
> @@ -4178,8 +4178,8 @@ an appropriate log or output method.
>  \begin{enumerate}
>  \item For output, a buffer containing the characters is placed in
>    the port's transmitq\footnote{Because this is high importance and low bandwidth, the current
> -Linux implementation polls for the buffer to be used, rather than
> -waiting for an interrupt, simplifying the implementation
> +Linux implementation polls for the buffer to become used, rather than
> +waiting for an used buffer notifications, simplifying the implementation

s/for an used buffer notifications/for a used buffer notification/

--xi8lRpXYeGgNnUjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+qHEAAoJEJykq7OBq3PIZ8EH/iQ3Cvn9RQk0DHBevlsWd56W
fWJU9gnwrKYTRvsfMM3NrNYxFrgmZNGCm+tv3mIo7QcAVL2mqPIGLWhggjKyE7sA
1KHbydjIoPJP56LStHdMK6aYbd1eBebSB60OWw2hpaZPEspIBGQeN+DAcZsQCwdR
NPU54ZntYZ4jnzSfEdLgiNzQJhLdam2fUPu3l/qs1Fi+En4VzbhUObVHaUaXTtl3
StZ1h8I3Pm3C+tLOCY477VhRZF8zKd3qk50Nb0mCK4B56YoFYrkDY8noJkNWV96g
VGzzeUYXLNrgtvNKrqfm0lMuYjBTGRX7ecsQ1A6ksE7qUrBGZtGYqf0V4groSlg=
=gKAo
-----END PGP SIGNATURE-----

--xi8lRpXYeGgNnUjs--
