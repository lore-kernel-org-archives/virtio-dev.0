Return-Path: virtio-dev-return-4295-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 93DD85819123
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Jun 2018 18:50:52 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu,  7 Jun 2018 09:50:50 +0800
Message-Id: <20180607015050.27547-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH] content: document the behaviours for SR-IOV
To: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Document the device and driver behaviours for SR-IOV.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/13
---
 content.tex | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/content.tex b/content.tex
index 73981b7..3b45a6c 100644
--- a/content.tex
+++ b/content.tex
@@ -5387,6 +5387,18 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
 If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
 the barriers suitable for hardware devices.
 
+If VIRTIO_F_SR_IOV has been negotiated, a driver can enable
+virtual functions through the device's PCI SR-IOV capability
+structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
+the device does not have a PCI SR-IOV capability structure
+or is not a PCI device.  A driver MUST negotiate
+VIRTIO_F_SR_IOV and complete the feature negotiation
+(including checking the FEATURES_OK \field{status} bit) before
+the first time to enable virtual functions through the device's
+PCI SR-IOV capability structure, and the driver MAY remember
+the VIRTIO_F_SR_IOV feature bit negotiation result until it
+unbinds from the device.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
@@ -5403,6 +5415,10 @@ buffers in the same order in which they have been available.
 A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
 is not accepted.
 
+A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device
+and presents a PCI SR-IOV capability structure, otherwise
+it MUST NOT offer VIRTIO_F_SR_IOV.
+
 \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
 
 Transitional devices MAY offer the following:
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

