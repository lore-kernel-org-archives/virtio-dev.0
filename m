Return-Path: virtio-dev-return-4038-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 591F058191A2
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 May 2018 19:44:16 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri,  4 May 2018 10:44:36 +0800
Message-Id: <20180504024436.13903-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

There will be hardware virtio devices in the future, which
require drivers to use the barriers suitable for I/O devices,
compared with software virtio devices which just require
drivers to use the barriers suitable for CPU cores.

To fix the ordering issue for hardware virtio devices, add
a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
will use the barriers suitable for I/O devices.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
v1 -> v2:
- Rebase to the latest spec (MST);
- Use a smaller textwidth (according to _vimrc);

RFC -> v1:
- Use plural (Stefan);
- Add more details (Stefan);

 content.tex | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/content.tex b/content.tex
index 7a92cb1..d1a8b78 100644
--- a/content.tex
+++ b/content.tex
@@ -5348,6 +5348,15 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
   \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
   that all buffers are used by the device in the same
   order in which they have been made available.
+  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
+  that the device needs the driver to use the barriers
+  suitable for hardware devices.  Some transports require
+  barriers to ensure devices have a consistent view of
+  memory.  When devices are implemented in software a
+  weaker form of barrier may be sufficient and yield
+  better performance.  This feature indicates whether
+  a stronger form of barrier suitable for hardware
+  devices is necessary.
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -5363,6 +5372,10 @@ addresses to the device.
 
 A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
 
+A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
+If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
+the barriers suitable for hardware devices.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
@@ -5376,6 +5389,9 @@ accepted.
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

