Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:25:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 11/16] split-ring: in order feature
Message-ID: <20180216092519-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518765602-8739-1-git-send-email-mst@redhat.com>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

For a split ring, require that drivers use descriptors in order too.
This allows devices to skip reading the available ring.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 split-ring.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/split-ring.tex b/split-ring.tex
index a594d41..5572958 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -203,6 +203,10 @@ struct virtq_desc {
 The number of descriptors in the table is defined by the queue size
 for this virtqueue: this is the maximum possible descriptor chain length.
 
+If VIRTIO_F_IN_ORDER has been negotiated, driver uses
+descriptors in ring order: starting from offset 0 in the table,
+and wrapping around at the end of the table.
+
 \begin{note}
 The legacy \hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]}
 referred to this structure as vring_desc, and the constants as
@@ -218,6 +222,12 @@ purposes).
 Drivers MUST NOT add a descriptor chain over than $2^{32}$ bytes long in total;
 this implies that loops in the descriptor chain are forbidden!
 
+If VIRTIO_F_IN_ORDER has been negotiated, and when making a
+descriptor with VRING_DESC_F_NEXT set in \field{flags} at offset
+$x$ in the table available to the device, driver MUST set
+\field{next} to $0$ for the last descriptor in the table
+(where $x = queue\_size - 1$) and to $x + 1$ for the rest of the descriptors.
+
 \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
 
 Some devices benefit by concurrently dispatching a large number
@@ -247,6 +257,10 @@ chained by \field{next}. An indirect descriptor without a valid \field{next}
 A single indirect descriptor
 table can include both device-readable and device-writable descriptors.
 
+If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors
+use sequential indices, in-order: index 0 followed by index 1
+followed by index 2, etc.
+
 \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
 The driver MUST NOT set the VIRTQ_DESC_F_INDIRECT flag unless the
 VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
@@ -259,6 +273,10 @@ the device.
 A driver MUST NOT set both VIRTQ_DESC_F_INDIRECT and VIRTQ_DESC_F_NEXT
 in \field{flags}.
 
+If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors
+MUST appear sequentially, with \field{next} taking the value
+of 1 for the 1st descriptor, 2 for the 2nd one, etc.
+
 \devicenormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
 The device MUST ignore the write-only flag (\field{flags}\&VIRTQ_DESC_F_WRITE) in the descriptor that refers to an indirect table.
 
-- 
MST

