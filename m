Return-Path: virtio-dev-return-7582-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91ED4986096
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 09:36:31 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:34:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717093457.GD128195@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-4-ndragazis@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <20200518203721.7625-4-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 03/10] vhost-user: add requirements for
 the notification capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 11:37:14PM +0300, Nikos Dragazis wrote:
> The configuration structure for the notification capability has certain
> device/driver requirements, similar to those of the MSI-X vector
> configuration. Add these requirements to the device spec.
>=20
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index 13ecd41..7a8cd9c 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -275,6 +275,48 @@ \subsubsection{Notification structure layout}\label{=
sec:Device Types / Vhost-use
>  \field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to chan=
ge the
>  MSI-X vector for that notification.
> =20
> +\devicenormative{\paragraph}{Notification capability}{Device Types / Vho=
st-user Device Backend / Additional Device Resources over PCI / Notificatio=
n capability}
> +
> +If MSI-X is available, device MUST support mapping any master queue
> +event to any valid vector 0 to MSI-X \field{Table Size}. Here

This section combines two things:
1. vhost-user concepts -> VIRTIO notifications
2. VIRTIO notifications -> VIRTIO PCI transport MSI-X implementation of
   notifications

I think this should be split:
1. The virtio-vhost-user device spec should explain that vhost-user queue
   events are mapped to VIRTIO notifications
2. The PCI transport spec should explain how notifications are mapped to
   MSI-X

This way other VIRTIO device types will be able to use notifications too
without everyone explaining MSI-X specifics. Also it won't tie
virtio-vhost-user to VIRTIO PCI.

> +\field{Table Size} is the \field{N-1} encoded Table Size stored in the
> +Message Control register of the MSI-X capability structure according to
> +\hyperref[intro:PCI]{[PCI]}, where \field{N} is the actual MSI-X Table
> +Size.
> +
> +Device MUST support unmapping any master queue event.
> +
> +The device MUST return vector mapped to a given master queue event,
> +(\field{NO_VECTOR} if unmapped) on read of
> +\field{notification_msix_vector}. The device MUST have all master queue
> +events unmapped upon reset.

"The device MUST unmap all master queue events upon reset" is clearer in
indicating that the device must take this action.

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RcMEACgkQnKSrs4Gr
c8g8JggAlKYct9uSMV/koQmyNoZavQfFiL1RsuDwd0QarZ5Ud7HnBx6/esclXZaJ
6km2ot/PcoLkbjRrf++3S5Yha0u4kIR12Sg1tNBn1V10KtsEs2kukCELP9VDrst0
HU6Kjlfie1emBzofVuOFupvFuxksScLvaTrI9pNKhoPDGNEOZX15eZ/ReSEDVhvT
ZfdEssglFqIW2UgF93+2WOxFF+JsP3MULSSqPoXBoJBwoO8dzUDO0PITKq4Op/ho
6yK0KgQuJ2cYGOWYXBxVp/UkWzwsfBegukl3aGzwQ4+MLD6ws4ExNfs2f1m7mlBz
WXwZxFRzv0b6yVnKLWfiBVwqpij/xg==
=1HvF
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--

