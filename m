Return-Path: virtio-return-3439-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 29 Oct 2020 03:50:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201029075047.119209-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] VIRTIO_F_RING_PACKED_USED: packing used descriptors
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Sometimes the device needs to only write out a single used descriptor
after processing a batch of multiple available descriptors.
This can happen when using
descriptor chaining or with in-order
use of descriptors.  In this case, the device writes out a single used
descriptor with the buffer id of the last descriptor in the batch.

When this happens, used descriptors stop being
contiguous in memory. As a result each used descriptor
needs a separate memory write. For devices on the pci express bus,
this incurs overhead of a separate write trasaction
(e.g. pci express headers etc).

This patch proposes a new feature: VIRTIO_F_RING_PACKED_USED.
The idea is that both device and driver count all of the
descriptors in a batch as if all of them are being written out
when used.  The resulting batch counter controls
wrap around to beginning of the ring, which then serves
as a synchronization point.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex     |  3 +++
 packed-ring.tex | 27 +++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index 47a4c6a..5b3121e 100644
--- a/content.tex
+++ b/content.tex
@@ -6247,6 +6247,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   \item[VIRTIO_F_ORDER_PLATFORM(36)] This feature indicates
   that memory accesses by the driver and the device are ordered
   in a way described by the platform.
+  \item[VIRTIO_F_RING_PACKED_USED(37)] This feature indicates
+  support for packed write out of used descriptors. Requires
+  VIRTIO_F_RING_PACKED.
 
   If this feature bit is negotiated, the ordering in effect for any
   memory accesses by the driver that need to be ordered in a specific way
diff --git a/packed-ring.tex b/packed-ring.tex
index ea92543..f8a2676 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -131,17 +131,36 @@ \subsection{Polling of available and used descriptors}
 poll (or test) a single location in memory: the next device descriptor after
 the one they processed previously, in circular order.
 
+\subsection{Skipping Used Descriptors}
+\label{sec:Packed Virtqueues / Skipping Used Descriptors}
 Sometimes the device needs to only write out a single used descriptor
 after processing a batch of multiple available descriptors.  As
 described in more detail below, this can happen when using
 descriptor chaining or with in-order
-use of descriptors.  In this case, the device writes out a used
-descriptor with the buffer id of the last descriptor in the group.
-After processing the used descriptor, both device and driver then
+use of descriptors.  In this case, the device writes out a single used
+descriptor with the buffer id of the last descriptor in the batch.
+
+If VIRTIO_F_RING_PACKED_USED has not been negotiated,
+after processing the used descriptor, both device and driver then
 skip forward in the ring the number of the remaining descriptors
-in the group until processing (reading for the driver and writing
+in the batch until processing (reading for the driver and writing
 for the device) the next used descriptor.
 
+If VIRTIO_F_RING_PACKED_USED has been negotiated,
+both the device and the driver are expected to maintain,
+internally, a 16-bit used batch counter initialized to 0.
+Each time a batch of descriptors is used, the batch counter
+is incremented by the number of descriptors in the batch.
+If after processing the used descriptor, the batch counter
+does not exceed the ring size, the next used descriptor
+is written immediately adjacent to the current one, in ring
+order.
+When after processing the used descriptor, the batch counter
+exceeds the ring size, the batch counter is decremented by the
+ring size; both device and driver then skip to the
+beginning (offset 0) of the ring until processing (reading for
+the driver and writing for the device) the next used descriptor.
+
 \subsection{Write Flag}
 \label{sec:Packed Virtqueues / Write Flag}
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

