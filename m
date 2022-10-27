Return-Path: <virtio-dev-return-10091-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FE3D9866F9
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Oct 2022 20:05:41 +0000 (UTC)
Date: Thu, 27 Oct 2022 16:05:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Y1rkiivA9J0KXr3U@fedora>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-2-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h8j/4dgcV5GmLx0l"
Content-Disposition: inline
In-Reply-To: <20221007165643.3920613-2-usama.arif@bytedance.com>
Subject: [virtio-dev] Re: [PATCH v3 1/4] content: Introduce driver/device auxiliary
 notifications
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--h8j/4dgcV5GmLx0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 05:56:40PM +0100, Usama Arif wrote:
> Driver auxiliary notifications allow the device to send notifications
> other than configuration changes and used buffer notifications to the
> driver, these are optional and their meaning is device-specific.
>=20
> Device auxiliary notifications allow the driver to send notifications
> other than available buffer notifications to the device for example
> through a device register, these are optional and their meaning is
> device-specific.
>=20
> These device-specific notifications are needed later when adding support
> for virtio-vhost-user device.
>=20
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  content.tex | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index e863709..49f9f2a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -160,29 +160,38 @@ \subsection{Legacy Interface: A Note on Feature
>  Specification text within these sections generally does not apply
>  to non-transitional devices.
> =20
> -\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
> -/ Notifications}
> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device / =
Notifications}
> =20
>  The notion of sending a notification (driver to device or device
>  to driver) plays an important role in this specification. The
>  modus operandi of the notifications is transport specific.
> =20
> -There are three types of notifications:=20
> +There are five types of notifications:
>  \begin{itemize}
>  \item configuration change notification
>  \item available buffer notification
> -\item used buffer notification.=20
> +\item used buffer notification
> +\item driver auxiliary notification
> +\item device auxiliary notification
>  \end{itemize}
> =20
> -Configuration change notifications and used buffer notifications are sent
> -by the device, the recipient is the driver. A configuration change
> -notification indicates that the device configuration space has changed; a
> -used buffer notification indicates that a buffer may have been made used
> -on the virtqueue designated by the notification.
> -
> -Available buffer notifications are sent by the driver, the recipient is
> -the device. This type of notification indicates that a buffer may have
> -been made available on the virtqueue designated by the notification.
> +Configuration change notifications, used buffer notifications and
> +driver auxiliary notifications are sent by the device,
> +the recipient is the driver. A configuration change notification indicat=
es
> +that the device configuration space has changed; a used buffer notificat=
ion
> +indicates that a buffer may have been made used on the virtqueue designa=
ted
> +by the notification; driver auxiliary notifications allow the
> +device to send notifications other than configuration changes and used
> +buffer notifications to the driver, these are optional and their meaning
> +is device-specific.

The meaning of "optional" is confusing and I suggest dropping it.

Auxiliary notifications are not used by all device types. In that sense
they are "optional".

But a device types that do use them, like virtio-vhost-user, may require
them. You cannot implement a virtio-vhost-user device without auxiliary
notifications, so they are mandatory (not "optional") for that device
type.

Finally, it is also possible for a device type to define a feature bit
that enables auxiliary notifications. Drivers/devices that don't support
auxiliary notifications leave the feature bit cleared and still work
properly. In this case they are truly "optional".

"Optional" is confusing. Just saying "their meaning is device-specific"
is enough.

> +
> +Available buffer notifications and device auxiliary notifications
> +are sent by the driver, the recipient is the device. Available buffer
> +notifications indicate that a buffer may have been made available on the
> +virtqueue designated by the notification; device auxiliary
> +notifications allow the driver to send notifications other than available
> +buffer notifications to the device for example through a device register=
, these
> +are optional and their meaning is device-specific.
> =20
>  The semantics, the transport-specific implementations, and other
>  important aspects of the different notifications are specified in detail
> --=20
> 2.25.1
>=20

--h8j/4dgcV5GmLx0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNa5IoACgkQnKSrs4Gr
c8g5JQf9HwLOOZBfrXdSt1r61V+/g4oH5qQ1Cb9YRZpwZ7JQXdhZuLqJtqrQ9GJT
wExE6A7nq5wbV7k1NP10cYGFX7LxLCFD6f4IJoNP3v52t4Ddl+LpIwn8TMHVw7rJ
erjUnoNYc3E2TeP6iBjLiyhpQPBW8LTotSHAS2m1a7eSpAScF6s9wOgovZ4+H5cf
Jn0Y01rLVLBAHaTRVkPbGHLHfH0krAgkDGLV96u98mndi8X7uN0UQXpi8kV4Pjg5
XLL0Un+di9I2thrnGUHMP0fOgod+w8inYDXka8Oa7otgEweuU4707DkIGRSrL3bN
Gfb+S3rFxy6Wt1go3FlRAN0aUlXeLw==
=ZLv6
-----END PGP SIGNATURE-----

--h8j/4dgcV5GmLx0l--

