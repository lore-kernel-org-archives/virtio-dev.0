Return-Path: virtio-return-3099-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 14 May 2018 18:24:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180514172449.GS5182@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-3-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MT9SxUWSsctiw0kG"
Content-Disposition: inline
In-Reply-To: <1524740402-18934-3-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH 2/6] notifications: notifications as basic
 virtio facility
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--MT9SxUWSsctiw0kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 12:59:58PM +0200, Halil Pasic wrote:
> Let's introduce notifications as basic virtio facility early on. This
> shall not only increase the cohesion between core and transport
> description by having a well-defined  place where notifications are
> introduced, but also give us the opportunity to explain some
> discrepancies.
>=20
> Namely notifications sent by the device to the driver were often called
> interrupts prior to v1.1. Getting completely rid of that terminology is
> however not viable in case of some names.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> Changelog:
> RFC -> v1:
> * implemented Connies suggestions (thanks Connie)
> ---
>  content.tex |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index 2e103cf..d7e2b18 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -8,6 +8,7 @@ device consists of the following parts:
>  \begin{itemize}
>  \item Device status field
>  \item Feature bits
> +\item Notifications
>  \item Device Configuration space
>  \item One or more virtqueues
>  \end{itemize}
> @@ -150,6 +151,41 @@ requirements documented within these legacy interfac=
e sections.
>  Specification text within these sections generally does not apply
>  to non-transitional devices.
> =20
> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
> +/ Notifications}
> +
> +The notion of sending a notification (driver to device or device
> +to driver) plays an important role in this specification. The
> +modus operandi of the notifications is transport specific.
> +
> +There are three types of notifications:=20
> +\begin{itemize}
> +\item device configuration space notification
> +\item available buffers notification
> +\item used buffer notifications.=20
> +\end{itemize}

"buffers" vs "buffer"; singular vs plural is likely to be used
inconsistently.  Please choose one (either works).

The previous patch said "the term configuration change notification in
kept where called so and consolidated where it's called configuration
change interrupt or similar", but here you say "device configuration
space notification".  Please choose one name and use it consistently.

> +
> +Device configuration space notifications and used buffer notifications
> +are sent by the device, the recipient is the driver. A device
> +configuration space notification indicates that a configuration space
> +has changed; a used buffer notification indicates that a buffer may
> +have been made used on the virtqueue designated by the notification.
> +
> +Available buffer notifications are sent by the driver, the recipient is
> +the device. This type of notification indicates that a buffer may have
> +been made available on the virtqueue designated by the notification.
> +
> +The semantic, the transport-specific implementations and other
> +important aspects of the different notifications are specified in detail
> +in the following chapters

Missing period.

> +
> +Most transports implement notifications sent by the device to the
> +driver using interrupts. Therefore, in previous versions of this
> +specification, these notifications were often called interrupts.
> +Some names defined in this specification still retain this interrupt
> +terminology. Occasionally, the term event is used to refer to
> +a notification or a receipt of a notification.
> +
>  \section{Device Configuration Space}\label{sec:Basic Facilities of a Vir=
tio Device / Device Configuration Space}
> =20
>  Device configuration space is generally used for rarely-changing or
> --=20
> 1.7.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--MT9SxUWSsctiw0kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+cZhAAoJEJykq7OBq3PIumQIAI0sNMpVVn89KZPu7xNTvtzo
hmmmFryFEJS7uA4mqI3jJOxFRcleTPO0yeUsRudfCPxjtzIltXplKJM6v4CnUCuV
tFSS7NDHU8glvw8cWFLUjSwZjCTT4+R4xBABPMPahUTQnczFcKQCWXKPAeT/IH0S
9MK/8Fn/RjXujgLKoaw/6KVyYx8PDxeHk1atwdFmYdxo3tyIfyahmPhGwRf2hH+4
Sof0ObOEaaLELThN05CWHvwFsu7yVw5coaIjJiWEAUHJFDRnR1/L5QsX85tTf2Bz
Kv6jwa1UI82cMu69hRAkOKKj7auvvcCxDOub/jxCH/WQcaurCXN+6a0y136z72w=
=MytM
-----END PGP SIGNATURE-----

--MT9SxUWSsctiw0kG--
