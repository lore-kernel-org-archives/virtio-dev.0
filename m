Return-Path: virtio-dev-return-7583-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACD3E986096
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 09:37:00 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:36:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717093649.GE128195@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-5-ndragazis@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <20200518203721.7625-5-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 04/10] vhost-user: update shared memory
 capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 11:37:15PM +0300, Nikos Dragazis wrote:
> The virtio vhost-user device has shared memory resources. Therefore, it
> uses the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability to standardize
> those resources through the PCI Configuration Space. This patch
> synchronizes the virtio vhost-user device spec with the following shared
> memory resources PATCH:
>=20
> https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html
>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index 7a8cd9c..d1305dd 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -320,7 +320,22 @@ \subsubsection{Notification structure layout}\label{=
sec:Device Types / Vhost-use
>  \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-=
user Device Backend / Additional Device Resources over PCI / Shared Memory =
capability}
> =20
>  The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMO=
RY_CFG

Now that Shared Memory Resources are part of the VIRTIO device model the
virtio-vhost-user spec should not refer to PCI-specific details anymore.
It should just explain which Shared Memory Resources are available on
the device. The mapping to PCI is already covered in the VIRTIO PCI
transport spec section.

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RcTEACgkQnKSrs4Gr
c8jLRggAofXdg3SLRV1GbShpBlpFwBXmoErlgiZcbE21FAelg3EzC7y0WrmD1HXY
jSIRQy3lWBme2fdscyAzfrRfdzDcUZLyrd6RBR0FC6RdfSJQVbJXWrtpzpe+CCHs
v/iOCxC4jNrnqBTSeIF+n4SoIIny7SgKFpGoRS4RqWHxa0p53tsTHLKtACGLdvsh
1KoNNCE/xpHKRbAJ8/WRZmDh/bcrPFTOA/An48XLd42LSbhiCbQElvG1uwzkdlTL
MSLUUkcGj9tQuzCl4QweK5bt6XIo0Kk/udZUPZ6rZhwxkmwou3N7acy8SRgtDJu+
NyBdVVywOCT5Q+TAWLBG6aWFxPYwBA==
=E44B
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--

