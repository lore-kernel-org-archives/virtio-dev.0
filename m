Return-Path: virtio-return-3388-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 28 Oct 2019 06:55:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191028105508.31769-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio] [PATCH] content: add vendor specific cfg type
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Vendors might want to add their own capability
in the PCI capability list. However, Virtio already
uses the vendor specific capability ID (0x09)
for its own purposes.

Provide a structure for vendor specific extensions.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/content.tex b/content.tex
index b1ea9b9..8a79b03 100644
--- a/content.tex
+++ b/content.tex
@@ -691,6 +691,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{se=
c:Virtio Transport Option
 #define VIRTIO_PCI_CAP_PCI_CFG           5
 /* Shared memory region */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+/* Vendor-specific data */
+#define VIRTIO_PCI_CAP_VENDOR_CFG        9
 \end{lstlisting}
=20
         Any other value is reserved for future use.
@@ -1099,6 +1101,84 @@ \subsubsection{Shared memory capability}\label{sec:V=
irtio Transport Options / Vi
=20
 The \field{cap.id} MUST be unique for any one device instance.
=20
+\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capabi=
lity}
+
+The region defined by the combination of the \field {cap.offset},
+\field {cap.offset_hi}, and \field {cap.length}, \field
+{cap.length_hi} fields MUST be contained within the declared bar.
+
+The \field{cap.id} MUST be unique for any one device instance.
+
+\subsubsection{Vendor data capability}\label{sec:Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout /
+Vendor data capability}
+
+The optional Vendor data capability allows the device to present
+vendor-specific data to the driver, without
+conflicts, for debugging and/or reporting purposes,
+and without conflicting with standard functionality.
+
+This capability augments but does not replace the standard
+subsystem ID and subsystem vendor ID fields
+(offsets 0x2C and 0x2E in the PCI configuration space header)
+as specified by \hyperref[intro:PCI]{[PCI]}.
+
+Vendor data capability is enumerated on the PCI transport
+as a VIRTIO_PCI_CAP_VENDOR_CFG capability.
+
+The capability has the following structure:
+\begin{lstlisting}
+struct virtio_pci_vndr_data {
+        u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
+        u8 cap_next;    /* Generic PCI field: next ptr. */
+        u8 cap_len;     /* Generic PCI field: capability length */
+        u8 cfg_type;    /* Identifies the structure. */
+        u16 vendor_id;  /* Identifies the vendor-specific format. */
+=09/* For Vendor Definition */
+=09/* Pads structure to a multiple of 4 bytes */
+=09/* Reads must not have side effects */
+};
+\end{lstlisting}
+
+Where \field{vendor_id} identifies the PCI-SIG assigned Vendor ID
+as specified by \hyperref[intro:PCI]{[PCI]}.
+
+Note that the capability size is required to be a multiple of 4.
+
+To make it safe for a generic driver to access the capability,
+reads from this capability MUST NOT have any side effects.
+
+\devicenormative{\subsection}{Vendor data capability}{Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout /
+Vendor data capability}
+
+The device SHOULD present the PCI subsystem vendor ID matching
+the device vendor, at offset 0x2C in its PCI configuration space
+header.
+
+Devices CAN present \field{vendor_id} that does not match
+either the PCI Vendor ID or the PCI Subsystem Vendor ID.
+
+Devices CAN present multiple Vendor data capabilities with
+either different or identical \field{vendor_id} values.
+
+The value \field{vendor_id} MUST NOT equal 0x1AF4.
+
+The size of the Vendor data capability MUST be a multiple of 4 bytes.
+
+Reads of the Vendor data capability by the driver MUST NOT have any
+side effects.
+
+\drivernormative{\subsection}{Vendor data capability}{Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout /
+Vendor data capability}
+
+The driver SHOULD NOT use the Vendor data capability except
+for debugging and reporting purposes.
+
+The driver MUST qualify the \field{vendor_id} before
+interpreting or writing into the Vendor data capability.
+
 \subsubsection{PCI configuration access capability}\label{sec:Virtio Trans=
port Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration =
access capability}
=20
 The VIRTIO_PCI_CAP_PCI_CFG capability
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

