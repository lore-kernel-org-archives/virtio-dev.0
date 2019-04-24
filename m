Return-Path: virtio-dev-return-5689-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 069E9985EDA
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Apr 2019 19:36:59 +0000 (UTC)
Date: Wed, 24 Apr 2019 20:36:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190424193655.GD31664@stefanha-x1.localdomain>
References: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
 <1556032699-22135-4-git-send-email-ndragazis@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <1556032699-22135-4-git-send-email-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH 3/4] vhost-user: add requirements for the
 notification capability
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 06:18:18PM +0300, Nikos Dragazis wrote:
> The configuration structure for the notification capability has certain
> device/driver requirements, similar to those of the MSI-X vector
> configuration. Add these requirements to the device spec.
>=20
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index 0bfc48d..605272f 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -275,6 +275,46 @@ \subsubsection{Notification structure layout}\label{=
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
> +event to any valid vector 0 to MSI-X \field{Table Size}. The valid

Do you mean Table Size - 1 since vector numbering is zero-based?

> +vectors are reported in \field{Table Size} in the MSI-X Capability as
> +specified in \hyperref[intro:PCI]{[PCI]}.
> +
> +Device MUST support unmapping any master queue event.
> +
> +The device MUST return vector mapped to a given master queue event,
> +(\field{NO_VECTOR} if unmapped) on read of
> +\field{notification_msix_vector}. The device MUST have all master queue
> +events unmapped upon reset.
> +
> +Devices SHOULD NOT cause mapping an event to vector to fail unless it is
> +impossible for the device to satisfy the mapping request. Devices MUST
> +report mapping failures by returning the \field{NO_VECTOR} value when
> +the relevant \field{notification_msix_vector} field is read.
> +
> +\drivernormative{\paragraph}{Notification capability}{Device Types /
> +Vhost-user Device Backend / Additional Device Resources over PCI /
> +Noification capability}
> +
> +Driver MUST support device with any MSI-X Table Size 0 to 0x7FF. Driver
> +MAY fall back on using INT\#x interrupts for a device which only
> +supports one MSI-X vector (MSI-X Table Size =3D 0).
> +
> +Driver MAY intepret the \field{Table Size} as a hint from the device for
> +the suggested number of MSI-X vectors to use.
> +
> +Driver MUST NOT attempt to map an event to a vector outside the MSI-X
> +Table supported by the device, as reported by \field{Table Size} in the
> +MSI-X Capability.
> +
> +After mapping an event to vector, the driver MUST verify success by
> +reading the Vector field value: on success, the previously written value
> +is returned, and on failure, \field{NO_VECTOR} is returned. If a mapping
> +failure is detected, the driver MAY retry mapping with fewer vectors,
> +disable MSI-X or report device failure.
> +
>  \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-=
user Device Backend / Additional Device Resources over PCI / Shared Memory =
capability}
> =20
>  The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMO=
RY_CFG
> --=20
> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwLrXAAoJEJykq7OBq3PIcx4H/jvjOOU9CDp9/jGLF3VJpKvX
K1fbTW7E1nTrzrjiB6Dpef8jnTE+wdfUsrhyo+Mc+qUMELVl7wpWd146UQL1pTuq
0Lc8mqldX5sKxFMIB91651ycezXO7djRqo4As7+/qPJ7exCj8wxNsrzkoUP5tXIb
lMtSLoSyozXLrIQmtsNF8D3W2KF0EokcAJHaU3QbRwyO50Di+mh7JLYqgJH/ou2T
pOWOqhxzzwNvSZLWHD4cjrK5Xi3UBegMdQnQMrMfVanwhNarPt7hzNmBOBxs7zcX
Re+bgTeoamtB0JM5Cp39sSPVfSUZpgAu3VJ4LYzj5CIy6eJoved4w18Tyrk4kXk=
=MjA6
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
