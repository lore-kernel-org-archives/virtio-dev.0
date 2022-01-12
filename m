Return-Path: <virtio-dev-return-9017-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0189983E07
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jan 2022 05:58:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 13:57:54 +0800
Message-Id: <20220112055755.41011-2-jasowang@redhat.com>
In-Reply-To: <20220112055755.41011-1-jasowang@redhat.com>
References: <20220112055755.41011-1-jasowang@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH V2 1/2] virtio-pci: introduce virtio structure PCI Extended Capability
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, eperezma@redhat.com, lulu@redhat.com, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

We're already out of the configuration space if there's a device that
supports all kinds of the virtio structure via PCI capability. This
prevents us from adding new capabilities in the future.

So the patch adds the support for virtio structure via PCI Extended
Capability via the vendor specific extended capability.

Only MMIO bar is allowed now.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 content.tex | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/content.tex b/content.tex
index cf20570..00a75f2 100644
--- a/content.tex
+++ b/content.tex
@@ -1476,6 +1476,129 @@ \subsubsection{Non-transitional Device With Legacy =
Driver: A Note
    of BAR0 by presenting zeroes on every BAR and ignoring writes.
 \end{enumerate}
=20
+\subsection{Virtio Structure PCI Extended Capabilities}\label{sec:Virtio T=
ransport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended Capa=
bilities}
+
+The location of the virtio structures that depend on the PCI Express
+capability are specified using a vendor-specific extended capabilities
+on the extended capabilities list in PCI Express extended
+configuration space of the device. The virtio structure extended
+capability uses little-endian format: all fields are read-only for the
+driver unless stated otherwise:
+
+\begin{lstlisting}
+struct virtio_pci_ecap {
+        le16 cap_vndr;      /* Generic PCI field: PCI_EXT_CAP_ID_VNDR */
+        le16 cap_rev:4;     /* Generic PCI field: capability version: 0x1 =
*/
+        le16 cap_next:12;   /* Generic PCI field: next ptr */
+        le16 cfg_type;      /* Identifies the structure */
+        le16 cfg_rev:4;     /* Identifies the version of the structure: 0x=
1 */
+        le16 cap_len:12;    /* The bytes of the entire capability */
+        u8 bar;             /* Where to find it. */
+        u8 id;              /* Multiple capabilities of the same type */
+        u8 padding[2];      /* Pad to full dword. */
+        le32 offset;        /* Offset within bar. */
+        le32 length;        /* Length of the structure, in bytes. */
+};
+\end{lstlisting}
+
+This structure can be followed by extra data, depending on the
+\field{cfg_type}.
+
+\begin{description}
+\item[\field{cap_vndr}]
+        0x0B; Identifies a vendor-specific extended capability.
+
+\item[\field{cap_rev}]
+        0x01; Identifies the version of the capability structure.
+
+\item[\field{cap_next}]
+        Link to next extended capability in the capability list in the
+        PCI Express extended configuration space.
+
+\item[\field{cfg_type}]
+        Identifies the structure. All values are reserved for future
+        use.
+
+        The device MAY offer more than one structure of any type - this ma=
kes it
+        possible for the device to expose multiple interfaces to drivers. =
 The order of
+        the capabilities in the capability list specifies the order of pre=
ference
+        suggested by the device. A device MAY specify that this ordering m=
echanism be
+        overridden by the use of the \field{id} field.
+
+\item[\field{cfg_rev}]
+        0x01; Identifies the version of virtio structure PCI extended
+        capability.
+
+\item[\field{cap_len}]
+        The length of the entire vendor specific extended capability,
+        including the virtio_pci_ecap structure and vendor specific
+        registers.
+
+\item[\field{bar}]
+        Values 0x0 to 0x5 specify a Base Address register (BAR) belonging =
to
+        the function located beginning at 10h in PCI Configuration Space
+        and used to map the structure into Memory. The BAR is
+        permitted to be either 32-bit or 64-bit.
+
+        Any other value is reserved for future use.
+
+\item[\field{offset}]
+        Indicates where the structure begins relative to the base address =
associated
+        with the BAR. The alignment requirements of \field{offset} are ind=
icated
+        in each structure-specific section.
+
+\item[\field{length}]
+        Indicates the length of the structure.
+        \field{length} MAY include padding, or fields unused by the driver=
, or
+        future extensions.
+\end{description}
+
+A variant of this type, struct virtio_pci_ecap64, is defined for
+those extended capabilities that require offsets or lengths larger
+than 4GiB:
+
+\begin{lstlisting}
+struct virtio_pci_ecap64 {
+        struct virtio_pci_ecap ecap;
+        u32 offset_hi;
+        u32 length_hi;
+};
+\end{lstlisting}
+
+Given that the \field{ecap.length} and \field{ecap.offset} fields
+are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
+fields provide the most significant 32 bits of a total 64 bit offset and
+length within the BAR specified by \field{ecap.bar}.
+
+\drivernormative{\subsubsection}{Virtio Structure PCI Extended Capabilitie=
s}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Ex=
tended Capabilities}
+
+The driver MUST ignore any vendor-specific capability structure which has
+a reserved \field{cfg_type} value.
+
+The driver SHOULD use the first instance of each virtio structure type
+they can support.
+
+The driver MUST accept a \field{cap_len} value which is larger than
+specified here.
+
+The driver MUST ignore any vendor-specific capability structure which has
+a reserved \field{bar} value.
+
+        The drivers SHOULD only map part of configuration structure
+        large enough for device operation.  The drivers MUST handle
+        an unexpectedly large \field{length}, but MAY check that \field{le=
ngth}
+        is large enough for device operation.
+
+\devicenormative{\subsubsection}{Virtio Structure PCI Extended Capabilitie=
s}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Ex=
tended Capabilities}
+
+The device MUST include any extra data (from the beginning of the
+\field{cap_vndr} field through end of the extra data fields if any) in
+\field{cap_len}. The device MAY append extra data or padding to any
+structure beyond that.
+
+If the device presents multiple structures of the same type, it SHOULD ord=
er
+them from optimal (first) to least-optimal (last).
+
 \subsection{PCI-specific Initialization And Device Operation}\label{sec:Vi=
rtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization =
And Device Operation}
=20
 \subsubsection{Device Initialization}\label{sec:Virtio Transport Options /=
 Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / D=
evice Initialization}
@@ -1488,6 +1611,10 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti
 PCI capability list, detecting virtio configuration layout using Virtio
 Structure PCI capabilities as detailed in \ref{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
=20
+Optionally, if the device is a PCIe device, the driver scans the PCI
+Extended capability list, detecting virtio configuration layout using
+Virtio Struct PCI Extended capabilities as detailed in \ref{sec:Virtio Tra=
nsport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended Capabi=
lities}
+
 \subparagraph{Legacy Interface: A Note on Device Layout Detection}\label{s=
ec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializa=
tion And Device Operation / Device Initialization / Virtio Device Configura=
tion Layout Detection / Legacy Interface: A Note on Device Layout Detection=
}
=20
 Legacy drivers skipped the Device Layout Detection step, assuming legacy
--=20
2.32.0 (Apple Git-132)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

