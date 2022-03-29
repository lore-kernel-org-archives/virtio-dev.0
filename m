Return-Path: <virtio-dev-return-9368-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA010986485
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 Mar 2022 08:33:53 +0000 (UTC)
Date: Tue, 29 Mar 2022 09:33:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YkLEYx6JbiJh7HL0@stefanha-x1.localdomain>
References: <20200810161501.1572834-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LegstNX5Q89rxQ/"
Content-Disposition: inline
In-Reply-To: <20200810161501.1572834-1-mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH RFC] VIRTIO_F_PARTIAL_ORDER for page fault
 handling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, i.maximets@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--5LegstNX5Q89rxQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 12:15:15PM -0400, Michael S. Tsirkin wrote:
> Devices that normally use buffers in order can
> benefit from ability to temporarily switch to handle
> some buffers out of order.
>=20
> As a case in point, a networking device might handle
> RX buffers in order normally. However, should
> an access to an RX buffer cause a page fault
> (e.g. when using PRI), the device could benefit from
> ability to temporarily keep using following
> buffers in the ring (possibly with higher overhead)
> until the fault has been resolved.
>=20
> Page faults allow more features such as THP, auto-NUMA,
> live migration.
>=20
> Out of order is of course already possible, however,
> IN_ORDER is currently required for descriptor batching where
> device marks a whole batch of buffers used in one go.
>=20
> The idea behind this proposal is to relax that requirement,
> allowing batching without asking device to be in orde rat all times,
> as follows:
>=20
> Device uses buffers in any order. Eventually when device detects that it
> has used all previously outstanding buffers, it sets a FLUSH flag on the
> last buffer used. If it set this flag on the last buffer used
> previously, and now uses a batch of descriptors in-order, it can now
> signal the last buffer used again setting the FLUSH flag.
>=20
> Driver can detect in-order when it sees two FLUSH flags one after
> another. In other respects the feature is similar to IN_ORDER
> from the driver implementation POV.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex     |  9 ++++++++-
>  packed-ring.tex | 23 +++++++++++++++++++++++
>  split-ring.tex  | 26 ++++++++++++++++++++++++--
>  3 files changed, 55 insertions(+), 3 deletions(-)

Hi Michael,
What is the status of this feature?

There is a Google Summer of Code project to implement VIRTIO_F_IN_ORDER
in QEMU and Linux
(https://wiki.qemu.org/Google_Summer_of_Code_2022#VIRTIO_F_IN_ORDER_support=
_for_virtio_devices).

I wanted to check if you still want to pursue PARTIAL_ORDER. Maybe
Stefano and Eugenio (the mentors) will find a way to connect it to the
GSoC project.

Thanks to Ilya Maximets for mentioning PARTIAL_ORDER!

Stefan

>=20
> diff --git a/content.tex b/content.tex
> index 91735e3..8494eb6 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -296,7 +296,11 @@ \section{Virtqueues}\label{sec:Basic Facilities of a=
 Virtio Device / Virtqueues}
> =20
>  Some devices always use descriptors in the same order in which
>  they have been made available. These devices can offer the
> -VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
> +VIRTIO_F_IN_ORDER feature.  Other devices sometimes use
> +descriptors in the same order in which they have been made
> +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> +feature. If one of the features VIRTIO_F_IN_ORDER or
> +VIRTIO_F_PARTIAL_ORDER is negotiated, this knowledge
>  might allow optimizations or simplify driver and/or device code.
> =20
>  Each virtqueue can consist of up to 3 parts:
> @@ -6132,6 +6136,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved =
Feature Bits}
>    that the driver passes extra data (besides identifying the virtqueue)
>    in its device notifications.
>    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}.
> +  \item[VIRTIO_F_PARTIAL_ORDER(39)] This feature indicates
> +  that device has ability to indicate use of (some of) buffers by the de=
vice in the same
> +  order in which they have been made available.
>  \end{description}
> =20
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> diff --git a/packed-ring.tex b/packed-ring.tex
> index ea92543..a120a19 100644
> --- a/packed-ring.tex
> +++ b/packed-ring.tex
> @@ -284,6 +284,29 @@ \subsection{In-order use of descriptors}
>  only writing out a single used descriptor with the Buffer ID
>  corresponding to the last descriptor in the batch.
> =20
> +Other devices sometimes use
> +descriptors in the same order in which they have been made
> +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> +feature. If negotiated, whenever device has used all buffers
> +since the previous used buffer in the same order
> +in which they have been made available, device can set the
> +VIRTQ_DESC_F_FLUSH flag in the used descriptor.
> +\begin{lstlisting}
> +#define VIRTQ_DESC_F_FLUSH      8
> +\end{lstlisting}
> +
> +This knowledge allows
> +devices to notify the use of a batch of buffers to the driver by
> +only writing out a single used descriptor with the Buffer ID
> +corresponding to the last descriptor in the batch,
> +and VIRTQ_DESC_F_FLUSH set.
> +
> +Note that device is only allowed to batch buffers in this way
> +if the previous used descriptor also has the VIRTQ_DESC_F_FLUSH
> +flag set, as a result, considering the group of buffers
> +used between two buffers with VIRTQ_DESC_F_FLUSH set,
> +either all of them constitute a batch, or none at all.
> +
>  The device then skips forward in the ring according to the size of
>  the batch. The driver needs to look up the used Buffer ID and
>  calculate the batch size to be able to advance to where the next
> diff --git a/split-ring.tex b/split-ring.tex
> index 123ac9f..cf197f8 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -398,10 +398,11 @@ \subsection{The Virtqueue Used Ring}\label{sec:Basi=
c Facilities of a Virtio Devi
>          le16 avail_event; /* Only if VIRTIO_F_EVENT_IDX */
>  };
> =20
> -/* le32 is used here for ids for padding reasons. */
>  struct virtq_used_elem {
>          /* Index of start of used descriptor chain. */
> -        le32 id;
> +        le16 id;
> +#define VIRTQ_USED_ELEM_F_FLUSH  0x8000
> +        le16 flags;
>          /* Total length of the descriptor chain which was used (written =
to) */
>          le32 len;
>  };
> @@ -481,6 +482,27 @@ \subsection{In-order use of descriptors}
>  corresponding to the head entry of the
>  descriptor chain describing the last buffer in the batch.
> =20
> +Other devices sometimes use
> +descriptors in the same order in which they have been made
> +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> +feature. If negotiated, whenever device has used all buffers
> +since the previous used buffer in the same order
> +in which they have been made available, device can set the
> +VIRTQ_USED_ELEM_F_FLUSH flag in the used ring entry.
> +
> +This knowledge allows
> +devices to notify the use of a batch of buffers to the driver by
> +only writing out single used ring entry with the \field{id}
> +corresponding to the head entry of the
> +descriptor chain describing the last buffer in the batch,
> +and VIRTQ_USED_ELEM_F_FLUSH set.
> +
> +Note that device is only allowed to batch buffers in this way
> +if the previous used ring entry also has the VIRTQ_USED_ELEM_F_FLUSH
> +flag set, as a result, considering the group of buffers
> +used between two buffers with VIRTQ_USED_ELEM_F_FLUSH set,
> +either all of them constitute a batch, or none at all.
> +
>  The device then skips forward in the ring according to the size of
>  the batch. Accordingly, it increments the used \field{idx} by the
>  size of the batch.
> --=20
> MST
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--5LegstNX5Q89rxQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJCxGMACgkQnKSrs4Gr
c8hKhAf+IxdsCGnWtm/OznJQ1UqN6k+94BTS0rPnwIEgVnuSxlgzrnZw06z+B5ow
Dmy6HR7AE55SHLh6N6EiP3GC/hqJjqPyX1m4Y3VnepL1lnKlS3QcFVHQXJ1M2g5k
+NUYwlP3YBwLxwAilIq+BE43aHu3pwwWdDOn4VrBK1c40XnFgU/tr8XWZn+sD4oy
TUcwqvgM3uCbbMd6YvRZIojs8FIUFk2qLzuLy381bW77KqRctaLnmVTZDC4lkSdj
EXEUn2irEoea2CEjvQiNybKppFLGo14T1wKNJF9hXW+BsYQt78tBVoFRACVjQhA5
bGxKoEnnjUh1C+JH8xdqNd7GhVUbIA==
=lqwV
-----END PGP SIGNATURE-----

--5LegstNX5Q89rxQ/--

