Return-Path: virtio-return-3098-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 14 May 2018 17:36:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180514163659.GR5182@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-2-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EguBBKnZWdUQS9Kz"
Content-Disposition: inline
In-Reply-To: <1524740402-18934-2-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH 1/6] notifications: unify notifications
 wording in core
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--EguBBKnZWdUQS9Kz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 12:59:57PM +0200, Halil Pasic wrote:
> @@ -235,12 +236,13 @@ transmit and one for receive.}.
>  Driver makes requests available to device by adding
>  an available buffer to the queue - i.e. adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -a driver event - i.e. sending a notification to the device.
> +a driver event - i.e. sending an available buffer notification
> +to the device.
> =20
>  Device executes the requests and - when complete - adds
>  a used buffer to the queue - i.e. lets the driver
>  know by marking the buffer as used. Device can then trigger
> -a device event - i.e. send an interrupt to the driver.
> +a device event - i.e. send an used buffer notification to the driver.

I would say "a used buffer notification".  "A" vs "an" depends on the
sound of the initial syllable, not the spelling.  So "a used car" vs "an
upper body".

There are several instances of this in this patch.

> =20
>  Device reports the number of bytes it has written to memory for
>  each buffer it uses. This is referred to as ``used length''.
> @@ -330,7 +332,8 @@ set the FAILED status bit to indicate that it has giv=
en up on the
>  device (it can reset the device later to restart if desired).  The
>  driver MUST NOT continue initialization in that case.
> =20
> -The driver MUST NOT notify the device before setting DRIVER_OK.
> +The driver MUST NOT send any buffer available notifications to
> +the device before setting DRIVER_OK.
> =20
>  \subsection{Legacy Interface: Device Initialization}\label{sec:General I=
nitialization And Device Operation / Device Initialization / Legacy Interfa=
ce: Device Initialization}
>  Legacy devices did not support the FEATURES_OK status bit, and thus did
> @@ -388,10 +391,11 @@ reads unless notified.
> =20
>  \subsection{Notification of Device Configuration Changes}\label{sec:Gene=
ral Initialization And Device Operation / Device Operation / Notification o=
f Device Configuration Changes}
> =20
> -For devices where the device-specific configuration information can be c=
hanged, an
> -interrupt is delivered when a device-specific configuration change occur=
s.
> +For devices where the device-specific configuration information can be
> +changed, a notification is delivered when a device-specific configuration
> +change occurs.

Unlike used/available buffer notifications, the text here just says
"notification" without explicitly saying "configuration change
notification".  I think it makes the spec slightly clearer (and easier
to search) to name the exact type of notification.

> @@ -309,22 +310,20 @@ in the ring.
> =20
>  \subsection{Driver and Device Event Suppression}
>  \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
> -In many systems driver and device notifications involve
> +In many systems used and available buffer  notifications involve

s/  / /

> @@ -352,9 +351,9 @@ matches this value and a descriptor is
>  made available/used respectively.
>  \end{description}
> =20
> -After writing out some descriptors, both the device and the driver
> +After writing out some descriptors,the device/driver

s/,/, /

> @@ -562,8 +570,8 @@ The driver offers buffers to one of the device's virt=
queues as follows:
>  \item The driver performs a suitable memory barrier to ensure that it up=
dates
>    the \field{idx} field before checking for notification suppression.
> =20
> -\item If notifications are not suppressed, the driver notifies the device
> -    of the new available buffers.
> +\item The driver sends an available buffers notification to the device if

s/available buffers notification/available buffer notification/

--EguBBKnZWdUQS9Kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+bsrAAoJEJykq7OBq3PIoaEH/RR0g/X6Bcvmh3gWZoig67Ni
pGmoFbTw94bn1lx5YxSJwMuz56l8sOJTWJoaKPCSuUymRPFoHulFd0i7L+EdC0Jd
UP8J1gIsPf8D0VHxvC8Fu2MDM5IykDD6f06PFXZvYzf+BjLn24e6tvrpmq2aDkfj
ZKZypoMK+JDwzyDrcPaGf2FAEZQDgiUYxS/oUWgzC71Erb3/9OPO/XUj2wk77a5D
BJuRt0T23s8AZxrSl1z81ghH9wK5igss/Dy80vVhQcaoUW/Qb2ZSvNNRHtcxRzZn
GFJ/ELQMgpOrYhU2/2xNoTLUFGZDT6wYDwPTT+qRlAqYLiyfWzCAFtm3rrPUs5o=
=AviQ
-----END PGP SIGNATURE-----

--EguBBKnZWdUQS9Kz--
