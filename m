Return-Path: virtio-dev-return-7587-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1BF4986097
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 09:57:43 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:57:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717095720.GI128195@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-10-ndragazis@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <20200518203721.7625-10-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 09/10] vhost-user: intercept slave's
 reply to VHOST_USER_GET_PROTOCOL_FEATURES
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 11:37:20PM +0300, Nikos Dragazis wrote:
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index a673526..328baec 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -142,10 +142,15 @@ \subsubsection{Device Operation: RX/TX Queues}\labe=
l{sec:Device Types / Vhost-us
>  message that is too large for an rxq buffer, then DEVICE_NEEDS_RESET is =
set and
>  the driver must reset the device.
> =20
> -File descriptor passing is handled differently by the vhost-user device
> -backend.  When a message is received that carries one or more file descr=
iptors
> -according to the vhost-user protocol, additional device resources become
> -available to the driver.
> +File descriptor passing is handled differently by the vhost-user device =
backend.
> +When a master-initiated message is received that carries one or more fil=
e
> +descriptors according to the vhost-user protocol, additional device reso=
urces
> +become available to the driver.
> +
> +On the contrary, the slave cannot pass file descriptors to the master. F=
or this
> +reason, the vhost-user device backend MUST be intercepting the slave's r=
eply to
> +the VHOST_USER_GET_PROTOCOL_FEATURES vhost-user message and clearing the=
se
> +feature bits that allow the slave to send messages that pass file descri=
ptors.

Please be specific about which vhost-user protocol bits are not
supported.

Why does the virtio-vhost-user device implementation need to silently
clear those feature bits? Is there a security impact or some other
reason why the VIRTIO spec should specify this behavior?

Stefan

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RdgAACgkQnKSrs4Gr
c8iNqQf9H+gJ7EWXqU5HaffjdCDve7bqlkbHBIGTTxJM6jZDnF2sGC8ee2EdPHeY
+icKXmrvvTk+soPPnEfMxlLW98R2TSAx60qyvkehJolH3PinzF4XQj4m9iBKkoNb
+M2fM7nqxAsGa8Jv6pq4yN6zyMvW2h+wd5+qvVlKsJcd5dc0nps/NR8yaE8yM8xJ
V2bzAWyRRAOQChL5Rc8x8+xMNZ1Fm+vmv15wjwCXBG+sX8D5Q29Qqq2HzmzB2V8Z
86ftZcbi9FKNS2LiRIVtpwkrBeNi3ofVPGBXDiYZBm4XTNBCqGcMmcHgH31x8eLm
f2mPwsB2NPpD202HNw7zoVR5mY5x1Q==
=OwYF
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--

