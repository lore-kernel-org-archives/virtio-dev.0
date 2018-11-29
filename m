Return-Path: virtio-return-3200-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 29 Nov 2018 14:49:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181129194930.17637-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] packed-ring: fix queue size for pci
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

PCI is the only transport that has text enforcing
a power of two size for VQs. There's no real reason
for it to do it, so document that it does not apply
with the packed rings.

Accordingly, drop the text "unless enforced by a transport"
from packed ring description.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/28
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex     | 11 +++++++++--
 packed-ring.tex |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index 633471e..abb5623 100644
--- a/content.tex
+++ b/content.tex
@@ -786,7 +786,7 @@ struct virtio_pci_common_cfg {
 
         /* About a specific virtqueue. */
         le16 queue_select;              /* read-write */
-        le16 queue_size;                /* read-write, power of 2, or 0. */
+        le16 queue_size;                /* read-write */
         le16 queue_msix_vector;         /* read-write */
         le16 queue_enable;              /* read-write */
         le16 queue_notify_off;          /* read-only for driver */
@@ -903,11 +903,18 @@ The device MUST present a 0 in \field{queue_enable} on reset.
 The device MUST present a 0 in \field{queue_size} if the virtqueue
 corresponding to the current \field{queue_select} is unavailable.
 
+If VIRTIO_F_RING_PACKED has not been negotiated, the device MUST
+present either a value of 0 or a power of 2 in
+\field{queue_size}.
+
 \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
 
 The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation} or \field{queue_notify_off}.
 
-The driver MUST NOT write a value which is not a power of 2 to \field{queue_size}.
+If VIRTIO_F_RING_PACKED has been negotiated,
+the driver MUST NOT write the value 0 to \field{queue_size}.
+If VIRTIO_F_RING_PACKED has not been negotiated,
+the driver MUST NOT write a value which is not a power of 2 to \field{queue_size}.
 
 The driver MUST configure the other virtqueue fields before enabling the virtqueue
 with \field{queue_enable}.
diff --git a/packed-ring.tex b/packed-ring.tex
index ebbad95..8b6f839 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -386,7 +386,7 @@ part of the virtqueue.
 Queue Size corresponds to the maximum number of descriptors in the
 virtqueue\footnote{For example, if Queue Size is 4 then at most 4 buffers
 can be queued at any given time.}.  The Queue Size value does not
-have to be a power of 2 unless enforced by the transport.
+have to be a power of 2.
 
 \drivernormative{\subsection}{Virtqueues}{Basic Facilities of a
 Virtio Device / Packed Virtqueues}
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

