Return-Path: virtio-dev-return-4091-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E2AD61CB807D
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 May 2018 21:41:21 -0700 (PDT)
From: Pankaj Gupta <pagupta@redhat.com>
Date: Fri, 18 May 2018 10:11:06 +0530
Message-Id: <20180518044106.31357-1-pagupta@redhat.com>
Subject: [virtio-dev] [PATCH] content: reserve device ID for virtio-pmem devices
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

We need a device ID for virtio-pmem devices. As 24 is already 
requested by virtio-mem, so requesting next available(25)

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 7a92cb1..ef75dc5 100644
--- a/content.tex
+++ b/content.tex
@@ -2432,6 +2432,8 @@ Device ID  &  Virtio Device    \\
 \hline
 23         &   IOMMU device \\
 \hline
+25         &   PMEM device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

