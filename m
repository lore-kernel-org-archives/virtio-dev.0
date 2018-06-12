Return-Path: virtio-dev-return-4348-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 710C358191DF
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Jun 2018 22:18:07 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Tue, 12 Jun 2018 13:18:00 +0800
Message-Id: <20180612051800.21149-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v3] content: document SR-IOV driver requirements
To: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Document the driver requirements for the VIRTIO_F_SR_IOV
feature bit.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/13
---
v2:
- Fix the commit message (MST);
- Improve the wording (MST);
- Drop unnecessary parts (MST);

v3:
- status -> device status (MST);

 content.tex | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/content.tex b/content.tex
index be18234..ab18210 100644
--- a/content.tex
+++ b/content.tex
@@ -5387,6 +5387,21 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
 If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
 the barriers suitable for hardware devices.
 
+If VIRTIO_F_SR_IOV has been negotiated, a driver MAY enable
+virtual functions through the device's PCI SR-IOV capability
+structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
+the device does not have a PCI SR-IOV capability structure
+or is not a PCI device.  A driver MUST negotiate
+VIRTIO_F_SR_IOV and complete the feature negotiation
+(including checking the FEATURES_OK \field{device status}
+bit) before enabling virtual functions through the device's
+PCI SR-IOV capability structure.  After once successfully
+negotiating VIRTIO_F_SR_IOV, the driver MAY enable virtual
+functions through the device's PCI SR-IOV capability
+structure even if the device or the system has been fully
+or partially reset, and even without re-negotiating
+VIRTIO_F_SR_IOV after the reset.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

