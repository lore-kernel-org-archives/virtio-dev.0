Return-Path: <stefanha@redhat.com>
Date: Thu, 18 Nov 2021 15:59:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Message-ID: <YZZ4aXdOAA65v10Y@stefanha-x1.localdomain>
References: <20211111185812.2326093-1-eperezma@redhat.com>
 <20211111185812.2326093-3-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SgnZsW/z3RFG6Wms"
Content-Disposition: inline
In-Reply-To: <20211111185812.2326093-3-eperezma@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, mst@redhat.com, jasowang@redhat.com, amikheev@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, pasic@linux.ibm.com, cohuck@redhat.com, bodong@nvidia.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, parav@nvidia.com, mgurtovoy@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


--SgnZsW/z3RFG6Wms
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2021 at 07:58:12PM +0100, Eugenio P=E9rez wrote:
> From: Jason Wang <jasowang@redhat.com>
>=20
> This patch introduces a new status bit STOP. This can be used by the
> driver to stop the device in order to safely fetch used descriptors
> status, making sure the device will not fetch new available ones.
>=20
> Its main use case is live migration, although it has other orthogonal
> use cases. It can be used to safely discard requests that have not been
> used: in other words, to rewind available descriptors.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  content.tex | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 2aa3006..9ed0d09 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>    drive the device.
> =20
> +\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indicates that the
> +  device has been stopped by the driver.

Who controls the STOP bit? If I understand correctly, the driver writes
STOP to the Status Register but the device will not report the STOP bit
until the device has fully stopped?

> +  This status bit is different
> +  from the reset since the device state is preserved.

"the reset" -> "resetting the device"

> +
> +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicates that=
 the
> +  device could not stop the STOP request.

"could not stop the STOP request" is weird, maybe "could not complete
the STOP request" or just "could not stop".

> +
>  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>    an error from which it can't recover.
>  \end{description}
> @@ -74,11 +81,83 @@ \section{\field{Device Status} Field}\label{sec:Basic=
 Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
> =20
> +If VIRTIO_F_STOP has been negotiated, the driver MUST NOT set or clear S=
TOP if
> +DRIVER_OK is not set.

Small tweak: "if DRIVER_OK is not set" -> "when DRIVER_OK is not set".
That makes the sentence a little easier to read (for me, at least).

> +
> +If VIRTIO_F_STOP has been negotiated the driver MUST re-read the device =
status
> +to ensure the STOP or STOP_FAILED bit is set after the write. The device
> +acknowledges the new paused status setting the first, or the failure set=
ting
> +the last.

This sentence is confusing. "paused status" introduces an alias for the
STOP functionality that is being described. Don't use multiple names for
the same thing. The "first"/"last" is unnecessary indirection, just use
"STOP" and "STOP_FAILED" so the reader doesn't have to figure out what
you meant. I suggest:

  "The device indicates that it has stopped by reporting the STOP bit or
  indicates failure by reporting the STOP_FAILED bit in the device
  status field."

> +Since this change may not be instantaneous, the driver MAY wait for
> +the configuration change notification that the device must send after the

"must" is lowercase. If this is a device normative section then it
should be "MUST". Otherwise I suggest removing the "must": "that the
device sends after ...".

> +change. If the device sets the STOP_FAILED bit, the driver MUST clear it=
 before
> +try new STOP attempts.

s/try/trying/

> +
> +If VIRTIO_F_STOP has been negotiated and the device has confirmed its st=
op,

"its stop" should probably be "it has stopped", but a more explicit way
to explain this is:

"If VIRTIO_F_STOP has been negotiated and the driver reads the STOP bit
=66rom the device status field,"

> +the driver MAY change avail_idx in the case of split virtqueue, but the =
new
> +avail_idx MUST be within used_idx and used_idx plus virtqueue size.

I'm trying to understand how this would work. Available buffers may be
consumed out-of-order unless VIRTIO_F_IN_ORDER was negotiated, so the
avail ring could contain something like:

  avail.ring =3D [Used, Not used, Used, Not used, ...]
                                                ^--- avail.idx

There are num_not_used =3D avail.idx - used.idx requests that are "Not
used" in avail.ring.

Does this mean the driver can rewind avail.idx by counting the number of
"Not used" buffers and skipping "Used" buffers until it reaches
num_not_used "Not used" buffers?

I think there is a known issue with this approach:

Imagine a vring with 4 elements:

  avail.ring =3D [0,        1,    2,    3   ]
                Not used, used, used, used
                                           ^--- avail.idx

Since the device has used 3 buffers the driver now has space to make
more buffers available. avail.idx wraps back to the start of the ring
and the driver overwrites the first element ("Not used"):

  avail.ring =3D [1,        N/A,  N/A,  N/A]
                Not used, N/A,  N/A,  N/A
		         ^--- avail.idx

Since vring descriptor 0 is still in use the driver chose descriptor 1
for the new available buffer.

Now we stop the device, knowing there are two buffers available that
have not been used. But avail.ring[] actually only contains the new
buffer (vring descriptor 1) that we made available because we overwrote
the old avail.ring[] element (vring descriptor 0).

What now? Where does the device reset its internal avail_idx to? Does
the device remember the available buffer with vring descriptor 0 or do
we need to add it again?

I'm not sure if this idea works even with split virtqueues.

> +
> +If VIRTIO_F_STOP has been negotiated and the device has confirmed its st=
op,

"its stop" -> "it has stopped".

> +the driver MAY change any descriptor.

Not just descriptors, but also avail.ring[] and avail.idx?

> +
> +If VIRTIO_F_STOP has been negotiated and the device has confirmed its st=
opped,

"its" -> "it has"

> +the driver can resume it clearing the STOP status bit. It MUST re-read t=
he

"it clearing" -> "it by clearing"

> +device status to ensure the STOP bit is clear after the write. The device
> +acknowledges the new status clearing it. Since this change may not be

"new status clearing" -> "new status by clearing"

> +instantaneous, the driver MAY wait for the configuration change notifica=
tion
> +that the device must send after the change.

"must" -> "MUST" or "that the device sends"

> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a=
 Virtio Device / Device Status Field}
> =20
>  The device MUST NOT consume buffers or send any used buffer
>  notifications to the driver before DRIVER_OK.
> =20
> +If VIRTIO_F_STOP has not been negotiated the device MUST ignore the writ=
e of
> +STOP. If the DRIVER_OK status bit is not set the device SHOULD ignore th=
e write
> +or clear of STOP.
> +
> +If VIRTIO_F_STOP has been negotiated, the device MUST finish any in flig=
ht
> +operations after the driver writes STOP.  Depending on the device, it ca=
n do it
> +in many ways as long as the driver can recover its normal operation if it
> +resumes the device without the need of resetting it:
> +\begin{itemize}
> +\item Drain and wait for the completion of all pending requests until a
> +convenient avail descriptor. Ignore any other posterior descriptor.
> +\item Return a device-specific failure for these descriptors, so the dri=
ver
> +can choose to retry or to cancel them.

This means each device type in the spec needs to define STOP semantics
so drivers know what to expect. Not sure it's feasible to do this. If
you can drop this point from the patch I would because this is going to
be hard to get right in implementations and a pain to specify properly.

> +\item Mark them as done even if they are not, if the kind of device can
> +assume to lose them.
> +\end{itemize}
> +
> +If VIRTIO_F_STOP has been negotiated and it needs to fail the device sto=
p after
> +a guest's request, the device MUST set the STOP_FAILED bit for the guest=
 to
> +read it. The device MUST ignore new writes to the STOP bit until the gue=
st
> +clears STOP_FAILED.

s/guest/driver/ here and elsewhere in this patch

> +
> +If VIRTIO_F_STOP has been negotiated and the guest has written the STOP =
bit,
> +and the device can pause its operation, the device MUST set the descript=
ors
> +that it has done with them as used before exposing the STOP status bit a=
s set.

This sentence is a bit confusing. What does "can" mean here? Can the
device negotiate VIRTIO_F_STOP but always set STOP_FAILED because it
cannot actually stop?

The second part of the sentence is unclear. Does it mean that the device
must complete an in-flight buffers? When VIRTIO_F_IN_ORDER is not
negotiated the device doesn't have to process available buffers in
order, so that means the device may leave a mix of available and used
buffers rather than a sequence of used buffers followed by available
buffers?

> +
> +If VIRTIO_F_STOP has been negotiated, the device MUST NOT perform these =
actions
> +after exposing the STOP bit set:
> +\begin{itemize}
> +\item Read updates on the descriptor or driver area, or consume more buf=
fers.
> +\item Send any used buffer notifications to the driver.
> +\end{itemize}
> +
> +The device MUST send a configuration space change right after exposing t=
he STOP
> +or STOP_FAILED as set to the driver, and MUST NOT change configuration s=
pace or
> +send another configuration space change notification to the driver after=
wards
> +until the guest clears it.
> +
> +If VIRTIO_F_STOP has been negotiated and STOP device status flag is set,
> +the device MUST resume operation when the driver clears the STOP bit. The
> +device MUST continue reading available descriptors as if an available bu=
ffer
> +notification has reach it, starting from the last descriptor it marked a=
s used,

"has reach it" -> "has been received"?

"starting from the last descriptor it marked as used" sounds wrong. I
guess this assumes VIRTIO_F_IN_ORDER was negotiated?

> +and continue the regular operation after that. The device MUST read again
> +descriptor and driver area beyond the last descriptor it marked as used =
when it
> +stopped, because the driver can change it. Device MUST set DEVICE_NEEDS_=
RESET
> +if for some reason it cannot continue.
> +
>  \label{sec:Basic Facilities of a Virtio Device / Device Status Field / D=
EVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters an =
error state
>  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS=
_RESET, the device
>  MUST send a device configuration change notification to the driver.
> @@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved=
 Feature Bits}
>    transport specific.
>    For more details about driver notifications over PCI see \ref{sec:Virt=
io Transport Options / Virtio Over PCI Bus / PCI-specific Initialization An=
d Device Operation / Available Buffer Notifications}.
> =20
> +\item[VIRTIO_F_STOP(41)] This feature indicates that the driver can
> +  stop the device.
> +  See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field=
}.
> +
>  \end{description}
> =20
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> --=20
> 2.27.0
>=20

--SgnZsW/z3RFG6Wms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGWeGkACgkQnKSrs4Gr
c8h7dgf/ToXLSZ/RDJHl3agPDG7HpxLLaBrTRFX15vbckNc0X/wW0ml3PIdUdTF6
rfcUUcI8R5BACUeu6DSGthzmqQmQC2GgCWXie9iRzRfZSsryclSGcUWE15b4j2zs
2EiR+itaQA2zFs7EZTMj9kY3XPlgE7v9JmOSeE1ZSblAxI6WQ1A6R3SC/00bZWdq
xRCsu75VMTPn4d98HhfDzgsI1vf9cqPSHRm7ozmbtKJD9I+Ej1JhHoCEH2D4nboU
95MEPpxFwo8EMPTVdHV+TcxbNdkdTwIMehcFPLE9SGIXNOTp3heR5EvVZ52QiW2Q
jDM1BG9AfoAQ8VimsSvvh1KTUGPLbA==
=ZYNH
-----END PGP SIGNATURE-----

--SgnZsW/z3RFG6Wms--

