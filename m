Return-Path: virtio-dev-return-4311-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B9B9F58191AE
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 01:12:57 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri,  8 Jun 2018 16:12:36 +0800
Message-Id: <20180608081236.7789-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2] content: enhance device requirements for feature bits
To: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/14
---
v2:
- Refine the wording (Cornelia);

 content.tex | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/content.tex b/content.tex
index f996fad..41cba41 100644
--- a/content.tex
+++ b/content.tex
@@ -125,6 +125,13 @@ which was not offered.  The device SHOULD accept any valid subset
 of features the driver accepts, otherwise it MUST fail to set the
 FEATURES_OK \field{device status} bit when the driver writes it.
 
+If a device has successfully negotiated a set of features
+at least once (by succeeding to set the FEATURES_OK
+\field{device status} bit when the driver writes it), then
+it SHOULD NOT fail re-negotiation of the same set of features
+after a device or system reset.  Failure to do so would
+interfere with resuming from suspend and error recovery.
+
 \subsection{Legacy Interface: A Note on Feature
 Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
 Bits / Legacy Interface: A Note on Feature Bits}
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

