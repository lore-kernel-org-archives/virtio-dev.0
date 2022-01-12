Return-Path: <virtio-dev-return-9019-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF27A983E07
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jan 2022 10:10:38 +0000 (UTC)
Date: Wed, 12 Jan 2022 10:10:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yd6o/rFvyFFhR3+2@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220112055755.41011-2-jasowang@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2 1/2] virtio-pci: introduce virtio structure PCI
 Extended Capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KNg4zd/RsWpjlTED"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, eperezma@redhat.com, lulu@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--KNg4zd/RsWpjlTED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 01:57:54PM +0800, Jason Wang wrote:
> We're already out of the configuration space if there's a device that
> supports all kinds of the virtio structure via PCI capability. This
> prevents us from adding new capabilities in the future.
>=20
> So the patch adds the support for virtio structure via PCI Extended
> Capability via the vendor specific extended capability.
>=20
> Only MMIO bar is allowed now.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  content.tex | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index cf20570..00a75f2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1476,6 +1476,129 @@ \subsubsection{Non-transitional Device With Legac=
y Driver: A Note
>     of BAR0 by presenting zeroes on every BAR and ignoring writes.
>  \end{enumerate}
> =20
> +\subsection{Virtio Structure PCI Extended Capabilities}\label{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended Ca=
pabilities}
> +
> +The location of the virtio structures that depend on the PCI Express
> +capability are specified using a vendor-specific extended capabilities
> +on the extended capabilities list in PCI Express extended
> +configuration space of the device.

I can't parse this sentence. Can you rephrase it and/or split it into
multiple sentences?

> The virtio structure extended
> +capability uses little-endian format: all fields are read-only for the
> +driver unless stated otherwise:
> +
> +\begin{lstlisting}
> +struct virtio_pci_ecap {
> +        le16 cap_vndr;      /* Generic PCI field: PCI_EXT_CAP_ID_VNDR */
> +        le16 cap_rev:4;     /* Generic PCI field: capability version: 0x=
1 */
> +        le16 cap_next:12;   /* Generic PCI field: next ptr */
> +        le16 cfg_type;      /* Identifies the structure */
> +        le16 cfg_rev:4;     /* Identifies the version of the structure: =
0x1 */
> +        le16 cap_len:12;    /* The bytes of the entire capability */
> +        u8 bar;             /* Where to find it. */
> +        u8 id;              /* Multiple capabilities of the same type */
> +        u8 padding[2];      /* Pad to full dword. */
> +        le32 offset;        /* Offset within bar. */
> +        le32 length;        /* Length of the structure, in bytes. */
> +};
> +\end{lstlisting}
> +
> +This structure can be followed by extra data, depending on the
> +\field{cfg_type}.
> +
> +\begin{description}
> +\item[\field{cap_vndr}]
> +        0x0B; Identifies a vendor-specific extended capability.

It's worth clarifying that "vendor-specific" here refers to the PCIe
standard, not to the VIRTIO standard. Please use "PCI Vendor-Specific
Extended Capability" everywhere in this patch instead of just
"vendor-specific extended capability". That helps avoid confusion with
VIRTIO_PCI_CAP_VENDOR_CFG.

> +
> +\item[\field{cap_rev}]
> +        0x01; Identifies the version of the capability structure.
> +
> +\item[\field{cap_next}]
> +        Link to next extended capability in the capability list in the
> +        PCI Express extended configuration space.
> +
> +\item[\field{cfg_type}]
> +        Identifies the structure. All values are reserved for future
> +        use.
> +
> +        The device MAY offer more than one structure of any type - this =
makes it
> +        possible for the device to expose multiple interfaces to drivers=
.  The order of
> +        the capabilities in the capability list specifies the order of p=
reference
> +        suggested by the device. A device MAY specify that this ordering=
 mechanism be
> +        overridden by the use of the \field{id} field.
> +
> +\item[\field{cfg_rev}]
> +        0x01; Identifies the version of virtio structure PCI extended
> +        capability.
> +
> +\item[\field{cap_len}]
> +        The length of the entire vendor specific extended capability,
> +        including the virtio_pci_ecap structure and vendor specific
> +        registers.

I thought the point of this is to place the register in ->bar, so why
would there be extra registers after struct virtio_pci_ecap(64)? Again,
it's unclear who the "vendor" is.

> @@ -1488,6 +1611,10 @@ \subsubsection{Device Initialization}\label{sec:Vi=
rtio Transport Options / Virti
>  PCI capability list, detecting virtio configuration layout using Virtio
>  Structure PCI capabilities as detailed in \ref{sec:Virtio Transport Opti=
ons / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
> =20
> +Optionally, if the device is a PCIe device, the driver scans the PCI
> +Extended capability list, detecting virtio configuration layout using
> +Virtio Struct PCI Extended capabilities as detailed in \ref{sec:Virtio T=
ransport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended Capa=
bilities}

If the same structure is present in both the PCI Capabilities and PCI
Extended Capabilities lists, which one has a higher priority?

--KNg4zd/RsWpjlTED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHeqP4ACgkQnKSrs4Gr
c8i5NQf/bGc8ITKZXVFALHlbZI4tsLbYnPw9idD9GQKHgCAqZ3MuNE2PnEnYAYrE
csWo84VRn4KxKgiAdx14Qm13CppTcBvx3lcZu8dveGzoumZZbyeznBVamm3hMmE5
UWL/H+GPPE9CS7JcER+5q0MErD+MBHsIpB0LZZ/QQPEclW4cYy/ighFtGDiOfEhY
V8VYG4vfy5ctAfAhG7SFFljeH9DaGY1QBeXneo/DnOMmCQCGHIfcE0DwPsaFiRjW
+vrjd0YAYNW8jfEeeeyE8GM8vN2aVz/89vKjCW2LXrc9VFh29S89vWKCqI2A5wlq
x33bcoLPSrnLkyATj3U1bfb/VssIwg==
=kOvQ
-----END PGP SIGNATURE-----

--KNg4zd/RsWpjlTED--

