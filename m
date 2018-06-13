Return-Path: virtio-return-3131-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jun 2018 14:04:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613130405.GE24528@stefanha-x1.localdomain>
References: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
 <1528733518-24950-2-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <1528733518-24950-2-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [PATCH v2 1/6] notifications: unify notifications wording in core
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 06:11:53PM +0200, Halil Pasic wrote:
> @@ -65,11 +65,12 @@ in which their processing is complete.
> =20
>  The Device Event Suppression data structure is write-only by the
>  device. It includes information for reducing the number of
> -device events - i.e. driver notifications to device.
> +device events - i.e. sending an available buffer notification
> +to the device.
> =20
>  The Driver Event Suppression data structure is read-only by the
>  device. It includes information for reducing the number of
> -driver events - i.e. device interrupts to driver.
> +driver events - i.e. send a used buffer notification to the driver.

This makes the "i.e." more natural:

"sending fewer used buffer notifications to the driver"

because the "send a used buffer notification to the driver" phrase
doesn't directly relate to any preceding subphrase ("driver events",
"number of driver events", or "reducing the number of driver events").

> =20
>  \subsection{Driver and Device Ring Wrap Counters}
>  \label{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}
> @@ -309,22 +310,20 @@ in the ring.
> =20
>  \subsection{Driver and Device Event Suppression}
>  \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
> -In many systems driver and device notifications involve
> +In many systems used and available buffer notifications involve
>  significant overhead. To mitigate this overhead,
>  each virtqueue includes two identical structures used for
>  controlling notifications between the device and the driver.
> =20
>  The Driver Event Suppression structure is read-only by the
> -device and controls the events sent by the device
> -to the driver (e.g. interrupts).
> +device and controls the used buffer notifications (sent by the device
> +to the driver).
> =20
>  The Device Event Suppression structure is read-only by
> -the driver and controls the events sent by the driver
> -to the device (e.g. IO).
> +the driver and controls the available buffer notifications (sent by the
> +driver to the device).
> =20
> -Each of these Event Suppression structures controls
> -both Descriptor Ring events and structure events, and
> -each includes the following fields:
> +Each of these Event Suppression includes the following fields:

Something is missing, "these" is plural but Event Suppression is
singular:

Each of these Event Suppression structures ...

>  Otherwise, if the VIRTIO_F_EVENT_IDX feature bit is negotiated:
>  \begin{itemize}
>  \item The driver MUST set \field{flags} to 0.
> -\item The driver MAY use \field{used_event} to advise the device that in=
terrupts are unnecessary until the device writes entry with an index specif=
ied by \field{used_event} into the used ring (equivalently, until \field{id=
x} in the
> +\item The driver MAY use \field{used_event} to advise the device that
> +notifications are unnecessary until the device writes entry with an inde=
x specified by \field{used_event} into the used ring (equivalently, until \=
field{idx} in the

Pre-existing issue:

  the device writes *an* entry

> @@ -562,8 +570,8 @@ The driver offers buffers to one of the device's virt=
queues as follows:
>  \item The driver performs a suitable memory barrier to ensure that it up=
dates
>    the \field{idx} field before checking for notification suppression.
> =20
> -\item If notifications are not suppressed, the driver notifies the device
> -    of the new available buffers.
> +\item The driver sends an available buffers notification to the device if
> +    such notifications are not suppressed.

For consistency:

s/available buffers notification/available buffer notification/

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIRZFAAoJEJykq7OBq3PIjP8H/1AaEKHzazwstsaJ7Cnx3oBC
x3X4fnV7F+LtifNnzMRN1WzHWzyGUQ4JrNUFZN3w6rsWFLIKRymmgQLj+MpVkGDl
QhWgor85hAXmg3qtnUDHVfR86mtQeI4Hnyjty9xk4s/xMrEJx65csviw3lv7tTJT
eP/7eUiwg7ZIkR2UmG4Bj4j3fC16ZBrT85631Vtu2DL11ewhEYw8tIsxt73rF26S
IiUb+KuBuCfVenTO3hL0W6le+nxf1ScyN/o4n21IXG+gDvSM/Gpk+QLkaCJQ+ycB
13BisxjC3HPFt29aaL6kCmWSZzn8w7vZdcW7vn7kpa+joBZp+TWwcy7C2moRHLI=
=wLHt
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
