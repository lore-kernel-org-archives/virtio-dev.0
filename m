Return-Path: <jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] virtio-pci: implement VIRTIO_F_RING_STATE
Date: Wed,  7 Jul 2021 12:34:41 +0800
Message-Id: <20210707043441.42361-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: mst@redhat.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch is a follow up for the virtqueue state synchronization
series to implement VIRTIO_F_RING_STATE via a dedicated capability for
PCI transport.

With the help of the STOP status bit, the virtqueue state
synchronization for PCI should be self contained.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 content.tex | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/content.tex b/content.tex
index 284ead0..f1848f7 100644
--- a/content.tex
+++ b/content.tex
@@ -878,6 +878,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 /* Vendor-specific data */
 #define VIRTIO_PCI_CAP_VENDOR_CFG        9
+/* General Virtqueue State */
+#define VIRTIO_PCI_CAP_RING_STATE        10
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -1434,6 +1436,36 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
+\subsubsection{General Virtqueue State}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / General Virtqueue State}
+
+The VITIO_PCI_CAP_RING_STATE capability is for the driver to configure
+the virtqueue state(see \ref{sec:Virtqueues / Virtqueue State}):
+
+The capability is immediately followed by an additional field like so:
+
+\begin{lstlisting}
+struct virtio_pci_cfg_cap {
+        struct virtio_pci_cap cap;
+        le16 queue_select; /* read-write */
+        le16 avail_state;  /* read-write */
+        le16 used_state;   /* read-write */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{queue_select}]
+        Queue Select. The driver selects which virtqueue the following
+        fields refer to.
+\item[\field{avail_state}]
+        The driver writes and reads available state here.
+\item[\field{used_state}]
+        The driver writes and reads used state here.
+\end{description}
+
+\devicenormative{\paragraph}{General Virtqueue State}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / General Virtqueue State}
+
+The device MUST present at least one VIRTIO_PCI_CAP_RING_STATE capability if VITIO_F_RING_STATE is negotiated.
+
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 
 Transitional devices MUST present part of configuration
-- 
2.25.1

