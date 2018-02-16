Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:25:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 10/16] packed-ring: add in order support
Message-ID: <20180216092500-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518765602-8739-1-git-send-email-mst@redhat.com>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Support in-order requests for packed rings.
This allows selective write-out of used descriptors.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/packed-ring.tex b/packed-ring.tex
index 213295b..14e137d 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -264,6 +264,30 @@ Buffer ID is also reserved and is ignored by the device.
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

