Return-Path: virtio-return-2997-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 23:23:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520629942-36324-13-git-send-email-mst@redhat.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520629942-36324-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v10 12/13] packed-ring: add in order support
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
index ebdba09..4b3d9d9 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -272,6 +272,30 @@ Buffer ID is also reserved and is ignored by the device.
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
 \label{sec:Packed Virtqueues / Multi-buffer requests}
 Some devices combine multiple buffers as part of processing of a
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

