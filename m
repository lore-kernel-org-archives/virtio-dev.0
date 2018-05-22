Return-Path: virtio-dev-return-4126-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FE795818DFE
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 12:11:21 -0700 (PDT)
From: Christoffer Dall <christoffer.dall@arm.com>
Date: Tue, 22 May 2018 21:11:05 +0200
Message-Id: <20180522191105.14400-1-christoffer.dall@arm.com>
Subject: [virtio-dev] [PATCH] split-ring: Fix typo in used ring description
To: virtio-dev@lists.oasis-open.org
Cc: felipe@nutanix.com, stefanha@redhat.com, pbonzini@redhat.com, mst@redhat.com, lersek@redhat.com, Christoffer Dall <christoffer.dall@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Only the device updates the used ring.

This looks like a typo as a result of copy-paste from the description of
the Available Ring.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/12
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 split-ring.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/split-ring.tex b/split-ring.tex
index df278fe..2267863 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -417,7 +417,7 @@ overwritten the bytes which were in that buffer, this could leak the
 contents of freed memory from other processes to the application.
 \end{note}
 
-\field{idx} field indicates where the driver would put the next descriptor
+\field{idx} field indicates where the device would put the next descriptor
 entry in the ring (modulo the queue size). This starts at 0, and increases.
 
 \begin{note}
-- 
2.15.1 (Apple Git-101)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

