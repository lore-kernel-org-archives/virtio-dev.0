Return-Path: virtio-return-2816-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 11:47:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1515577653-9336-6-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515577653-9336-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v6 5/5] packed-ring: add in order request support
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

support in-order requests for packed rings.  more work is needed to use
them efficiently for split rings (e.g. it makes sense to bypass
avail/used rings in this case), forbid that combination for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex     |  7 +++++++
 packed-ring.tex | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/content.tex b/content.tex
index 3059bd3..f478ae2 100644
--- a/content.tex
+++ b/content.tex
@@ -5240,6 +5240,10 @@ and .
   \item[VIRTIO_F_RING_PACKED(34)] This feature indicates
   support for the packed virtqueue layout as described in
 \ref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}.
+  \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
+  that all buffers are used by the device in the same
+  order in which they have been made available.
+  This feature should only be enabled with VIRTIO_F_RING_PACKED.
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -5255,6 +5259,9 @@ addresses to the device.
 
 A driver SHOULD accept VIRTIO_F_PACKED_RING if it is offered.
 
+A driver MUST only accept VIRTIO_F_IN_ORDER if it also accepts
+VIRTIO_F_RING_PACKED.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
diff --git a/packed-ring.tex b/packed-ring.tex
index ffc699c..88d121c 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -260,6 +260,30 @@ Buffer ID is also reserved and is ignored by the device.
 In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
 is reserved and is ignored by the device.
 
+\subsection{In-order use of descriptors}
+\label{sec:Packed Virtqueues / In-order use of descriptors}
+
+Some devices always use descriptors in the same order in which
+they have been made available. These devices can offer the
+VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
+devices to notify the use of a batch of buffers to the driver by
+only writing out a single used descriptor with the Buffer ID
+corresponding to the last descriptor in the batch.
+
+Device then skips forward in the ring according to the size of
+the batch. Driver needs to look up the used Buffer ID and
+calculate the batch size to be able to advance to where the next
+used descriptor will be written by the device.
+
+This will result in the used descriptor overwriting the first
+available descriptor in the batch, the used descriptor for the
+next batch overwriting the first available descriptor in the next
+batch, etc.
+
+The skipped buffers (for which no used descriptor was written)
+are assumed to have been used (read or written) by the
+device completely.
+
 \subsection{Multi-buffer requests}
 \label{sec:Packed Virtqueues / Multi-descriptor batches}
 Some devices combine multiple buffers as part of processing of a
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

