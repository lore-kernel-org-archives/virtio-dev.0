Return-Path: <virtio-dev-return-9018-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC8BC98644B
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jan 2022 05:58:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 13:57:55 +0800
Message-Id: <20220112055755.41011-3-jasowang@redhat.com>
In-Reply-To: <20220112055755.41011-1-jasowang@redhat.com>
References: <20220112055755.41011-1-jasowang@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH V2 2/2] virtio-pci: add PASID configuration extended capability
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, eperezma@redhat.com, lulu@redhat.com, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch tries to add PASID configuration structure. It is used for
assigning PASID to virtqueue then the device use PASID TLP prefix for
the PCI transactions like DMA. The goal is to isolate e.g DMA at
subdevice level which could be used for things like:

- direct queue assignment to userspace
- virtqueue virtualization
- presenting multiple vDPA devices within a single PCI device

The virtqueue group is introduced as an intermediate layer for having
better compatibility and flexibility. The virtqueue group is the
minimal set of the virtqueues that can be assigned with a single
PASID. The PASID is then assigned at the level of virtqueue group
instead of the virtqueue itself.

For a full PASID capable hardware, it can simply advertise a model
of 1:1 mapping of the virtqueue and virtqueue group. For the device
with mediated virtqueues, it can choose to place the mediated
virtqueues into dedicated virtqueue group(s).

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 content.tex | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 00a75f2..552c0a8 100644
--- a/content.tex
+++ b/content.tex
@@ -1516,8 +1516,14 @@ \subsection{Virtio Structure PCI Extended Capabiliti=
es}\label{sec:Virtio Transpo
         PCI Express extended configuration space.
=20
 \item[\field{cfg_type}]
-        Identifies the structure. All values are reserved for future
-        use.
+        Identifies the structure. according to the following table:
+
+\begin{lstlisting}
+/* PASID configuration */
+#define VIRTIO_PCI_ECAP_PASID_CFG        1
+\end{lstlisting}
+
+        Any other value is reserved for future use.
=20
         The device MAY offer more than one structure of any type - this ma=
kes it
         possible for the device to expose multiple interfaces to drivers. =
 The order of
@@ -1599,6 +1605,117 @@ \subsection{Virtio Structure PCI Extended Capabilit=
ies}\label{sec:Virtio Transpo
 If the device presents multiple structures of the same type, it SHOULD ord=
er
 them from optimal (first) to least-optimal (last).
=20
+\subsubsection{PASID configuration structure layout}
+
+The PASID configuration structure is found at the \field{bar} and
+\field{offset} within the VIRTIO_PCI_ECAP_PASID_CFG extended
+capability; its layout is below.
+
+\begin{lstlisting}
+struct virtio_pci_common_cfg {
+        /* About the whole device. */
+        le16 groups;                   /* read-only for driver */
+        /* About a specific virtqueue */
+        le16 queue_select;             /* read-write */
+        le16 group_id;                 /* read-only for driver */
+        /* About a specific virtqueue group */
+        le16 group_select;             /* read-write */
+        le32 group_pasid;              /* read-write */
+}
+\end{lstlisting}
+
+\begin{description}
+\item[\field{groups}]
+        The device specifies the number of virtqueue groups here. A
+        virtqueue group is the minimal set of the virtqueues that can
+        be assigned with a single PASID.
+
+\item[\field{queue_select}]
+        Queue Select. The driver selects which virtqueue the
+        \field{group_id} refers to.
+
+\item[\field{group_id}]
+        Virtqueue Group Identifier. The device specify the virtqueue
+        group identifier that the virtqueue belongs to.
+
+\item[\field{group_select}]
+        Virtqueue Group Select. The driver selects which virtqueue
+        group the field{group_pasid} refers to.
+
+\item[\field{group_pasid}]
+        Virtqueue Group PASID. The driver use this field to assign a
+        PASID to a virtqueue group.
+\end{description}
+
+\paragraph{PASID Configuration}
+
+When PASID extended capability is present and enabled in the device
+(through the standard PCI Extended configuration space). To assign a
+PASID to a specific virtqueue group. The driver need to perform the
+following steps:
+
+\begin{enumerate}
+\item Identify the number of groups by reading \field{groups}
+
+\item Identify the virtqueue group for a specific virtqueue by first
+  writing the index of the virtqueue to \field{queue_select} then
+  reading its virtqueue group identifier from \field{group_id}.
+
+\item Determine number of PASIDs and the PASID that will be associated
+  for each virtqueue group.
+
+\item Assign PASID to virtqueue groups by first writing the
+  virtqueue group ID to \field{group_select} then writing the valid
+  PASID number that assigned to the virtqueue group to
+  \field{group_pasid}
+\end{enumerate}
+
+To disable PASID for a virtqueue group, the driver write a special
+NO_PASID value:
+
+\begin{lstlisting}
+/* PASID value used to disable PASID for virtqueue group */
+#define VIRTIO_PASID_NO_ID            0xffffffff
+\end{lstlisting}
+
+\drivernormative{\subsubsection}{PASID configuration structure layout}{Vir=
tio Transport Options / Virtio Over PCI Bus / PASID configuration structure=
 layout}
+
+Except for VIRTIO_PASID_NO_ID, a driver MUST NOT attempt to assign a
+PASID number outside the range that is defined in the \field{Max PASID Wid=
th}
+in the PASID Extended Capability.
+
+After assigning a PASID to a virtqueue group, the driver MUST verify
+the success by reading the Virtqueue Group PASID: on success, the
+previously written value is returned, and on failure
+VIRTIO_PASID_NO_ID is returned. If a mapping failure is detected, the
+driver MAY retry assigning with fewer PASIDs, disable PASID or report
+device failure.
+
+\devicenormative{\subsubsection}{PASID configuration structure layout}{Vir=
tio Transport Options / Virtio Over PCI Bus / PASID configuration structure=
 layout}
+
+The device MUST support at least one virtqueue group if it offers
+PASID configuration structure.
+
+The device MUST supply virtqueue group identifiers continuously from
+number zero up to the number of virtqueue groups minus one. For
+example, if the device has 4 virtqueue groups, the group ids should be
+0, 1, 2, 3.
+
+The device MUST make sure all the previous PCIe transactions for the
+virtqueue group is completed before presenting the new PASID value
+wrote to the drvier in \field{group_pasid}.
+
+The device MUST use PASID TLP prefix for all memory transactions
+belongs to a virtqueue group if a valid PASID is assigned and PASID is
+enabled in the PASID extended capability.
+
+The device MUST NOT use PASID TLP prefix for any memory transaction
+belongs to a virtqueue group if VIRTIO_PASID_NO_ID is assigned or
+PASID is not enabled in the PASID extended capability.
+
+Upon reset, the device MUST present VIRTIO_PASID_NO_ID in
+\field{group_pasid} for each virtqueue group.
+
 \subsection{PCI-specific Initialization And Device Operation}\label{sec:Vi=
rtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization =
And Device Operation}
=20
 \subsubsection{Device Initialization}\label{sec:Virtio Transport Options /=
 Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / D=
evice Initialization}
--=20
2.32.0 (Apple Git-132)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

