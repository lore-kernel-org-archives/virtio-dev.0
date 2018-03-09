Return-Path: virtio-return-3002-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 23:23:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520629942-36324-12-git-send-email-mst@redhat.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520629942-36324-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v10 11/13] content: in-order buffer use
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Using descriptors in-order is sometimes beneficial.  Add an option for
that - per-format detail allowing more optimizations will be added by
follow-up patches.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/content.tex b/content.tex
index 73f40b7..c57a918 100644
--- a/content.tex
+++ b/content.tex
@@ -245,6 +245,15 @@ a device event - i.e. send an interrupt to the driver.
 Device reports the number of bytes it has written to memory for
 each buffer it uses. This is referred to as ``used length''.
 
+Device is not generally required to use buffers in
+the same order in which they have been made available
+by the driver.
+
+Some devices always use descriptors in the same order in which
+they have been made available. These devices can offer the
+VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
+might allow optimizations or simplify driver and/or device code.
+
 Each virtqueue can consist of up to 3 parts:
 \begin{itemize}
 \item Descriptor Area - used for describing buffers
@@ -5248,6 +5257,9 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
   \item[VIRTIO_F_RING_PACKED(34)] This feature indicates
   support for the packed virtqueue layout as described in
   \ref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}.
+  \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
+  that all buffers are used by the device in the same
+  order in which they have been made available.
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -5273,6 +5285,9 @@ translates bus addresses from the device into physical addresses in memory.
 A device MAY fail to operate further if VIRTIO_F_IOMMU_PLATFORM is not
 accepted.
 
+If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
+buffers in the same order in which they have been available.
+
 \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
 
 Transitional devices MAY offer the following:
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

