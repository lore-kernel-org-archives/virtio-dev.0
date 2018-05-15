Return-Path: virtio-return-3103-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 15 May 2018 09:58:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515085855.GV5182@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-6-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BlkQeOBdElZ1aiuH"
Content-Disposition: inline
In-Reply-To: <1524740402-18934-6-git-send-email-pasic@linux.ibm.com>
Subject: Re: [virtio] [PATCH 5/6] mmio: map common notifications terminology
 to MMIO
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--BlkQeOBdElZ1aiuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 01:00:01PM +0200, Halil Pasic wrote:
> @@ -1716,26 +1716,28 @@ The driver will typically initialize the virtual =
queue in the following way:
>  \item Write 0x1 to \field{QueueReady}.
>  \end{enumerate}
> =20
> -\subsubsection{Notifying The Device}\label{sec:Virtio Transport Options =
/ Virtio Over MMIO / MMIO-specific Initialization And Device Operation / No=
tifying The Device}
> +\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transpor=
t Options / Virtio Over MMIO / MMIO-specific Initialization And Device Oper=
ation / Available Buffer Notifications}
> =20
> -The driver notifies the device about new buffers being available in
> -a queue by writing the index of the updated queue to \field{QueueNotify}.
> +The driver sends an available buffer notification to the device a by

s/device a by/device by/

> +writing the index of the queue to \field{QueueNotify} to be notified.
> =20
>  \subsubsection{Notifications From The Device}\label{sec:Virtio Transport=
 Options / Virtio Over MMIO / MMIO-specific Initialization And Device Opera=
tion / Notifications From The Device}
> =20
>  The memory mapped virtio device is using a single, dedicated
>  interrupt signal, which is asserted when at least one of the
>  bits described in the description of \field{InterruptStatus}
> -is set. This is how the device notifies the
> -driver about a new used buffer being available in the queue
> -or about a change in the device configuration.
> +is set. This is how the device sends an used buffer notification
> +or a configuration change notifaciton to the device.

s/notifaciton/notification/

Please run a spell checker over the patches in case I missed other
typos.

> =20
>  \drivernormative{\paragraph}{Notifications From The Device}{Virtio Trans=
port Options / Virtio Over MMIO / MMIO-specific Initialization And Device O=
peration / Notifications From The Device}
>  After receiving an interrupt, the driver MUST read
> -\field{InterruptStatus} to check what caused the interrupt
> -(see the register description). After the interrupt is handled,
> -the driver MUST acknowledge it by writing a bit mask
> -corresponding to the handled events to the InterruptACK register.
> +
> +\field{InterruptStatus} to check what caused the interrupt (see the
> +register description).  The used buffer notification bit being set,

The comma is unnecessary here.  The "SHOULD ..." clause is not
independent and needs something directly before it.

--BlkQeOBdElZ1aiuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+qFPAAoJEJykq7OBq3PI7E8IAIJJEJQACd8d2axd6rAcahsT
kLGAko3+NP/T5WKz+m0oYPrV9DXqXoqQLODzvHnG/F3tsFVdM02Iq8y7vgaPjNA8
o7iTo1yZ+QpZrq41YbpJR2I4LfZZ8ktC2tXr9U4OKf7+KJwHvB5qeZPpwRTE5dtm
AblqOfc54XLb37XxOYb8aVMkeCAOUXRi+ZRV+J/9w9PFa1us+vEQlysDF+ykUgaO
A4+ULsKUQu/1wskqsaussVcuhUApRaTfmi2Lbk8O5+KjNPp1fNt3rrSmvl1qda0e
hyXeGw00iXgZFETSEFFeGjzGKUhnm83ZXxpidzJITZuUVspWwkQcO4AL1az7Lto=
=tGad
-----END PGP SIGNATURE-----

--BlkQeOBdElZ1aiuH--
