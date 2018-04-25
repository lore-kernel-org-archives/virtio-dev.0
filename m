Return-Path: virtio-dev-return-3951-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E2B858191C3
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 01:22:42 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 25 Apr 2018 16:23:12 +0800
Message-Id: <20180425082312.32244-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
Cc: cunming.liang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

There will be hardware virtio devices in the future, which
require drivers to use the barriers suitable for I/O device,
compared with software virtio devices which just require
drivers to use the barriers suitable for CPU core.

To fix the ordering issue for hardware virtio devices, add
a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
will use the barriers suitable for I/O device.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 content.tex | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/content.tex b/content.tex
index ae5fa4c..f24e320 100644
--- a/content.tex
+++ b/content.tex
@@ -5445,6 +5445,8 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
   that drivers pass extra data (besides identifying the Virtqueue)
   in their device notifications.
   See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
+  \item[VIRTIO_F_IO_BARRIER(37)] This feature indicates that the device
+  needs the driver to use the barriers suitable for hardware device.
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -5460,6 +5462,10 @@ addresses to the device.
 
 A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
 
+A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
+If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
+the barriers suitable for hardware device.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
@@ -5473,6 +5479,9 @@ accepted.
 If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
 buffers in the same order in which they have been available.
 
+A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
+is not accepted.
+
 \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
 
 Transitional devices MAY offer the following:
-- 
2.11.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

