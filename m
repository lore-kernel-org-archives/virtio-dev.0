Return-Path: virtio-dev-return-4511-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B246658191E6
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jun 2018 05:25:02 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 25 Jun 2018 20:24:42 +0800
Message-Id: <20180625122442.22432-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

VIRTIO_F_IO_BARRIER was proposed recently to allow
drivers to do some optimizations when devices are
implemented in software. But it only covers barrier
related optimizations. Later investigations show
that, it could cover more. So this patch tweaks this
feature bit to tell the driver whether it can assume
the device is implemented in software and runs on
host CPU, and also renames this feature bit to
VIRTIO_F_REAL_DEVICE correspondingly.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 content.tex | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/content.tex b/content.tex
index be18234..5d6b977 100644
--- a/content.tex
+++ b/content.tex
@@ -5356,15 +5356,13 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
   \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
   that all buffers are used by the device in the same
   order in which they have been made available.
-  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
-  that the device needs the driver to use the barriers
-  suitable for hardware devices.  Some transports require
-  barriers to ensure devices have a consistent view of
-  memory.  When devices are implemented in software a
-  weaker form of barrier may be sufficient and yield
+  \item[VIRTIO_F_REAL_DEVICE(36)] This feature indicates
+  that the device doesn't allow the driver to assume the
+  device is implemented in software and runs on host CPU.
+  When devices are implemented in software and run on host
+  CPU, some optimizations can be done in drivers and yield
   better performance.  This feature indicates whether
-  a stronger form of barrier suitable for hardware
-  devices is necessary.
+  drivers can make this assumption.
   \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
   the device supports Single Root I/O Virtualization.
   Currently only PCI devices support this feature.
@@ -5383,9 +5381,9 @@ addresses to the device.
 
 A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
 
-A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
-If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
-the barriers suitable for hardware devices.
+A driver SHOULD accept VIRTIO_F_REAL_DEVICE if it is offered.
+If VIRTIO_F_REAL_DEVICE has been negotiated, a driver MUST NOT
+assume the device is implemented in software and runs on host CPU.
 
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
@@ -5400,7 +5398,7 @@ accepted.
 If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
 buffers in the same order in which they have been available.
 
-A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
+A device MAY fail to operate further if VIRTIO_F_REAL_DEVICE
 is not accepted.
 
 A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

