Return-Path: virtio-dev-return-3980-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C11505818CAD
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 04:36:41 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Date: Fri, 27 Apr 2018 13:36:24 +0200
Message-Id: <20180427113624.15020-1-david@redhat.com>
Subject: [virtio-dev] [PATCH v1] content: reserve virtio device ID for memory devices
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Reserve device ID 24 for virtio-mem devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 7a92cb1..bf63be8 100644
--- a/content.tex
+++ b/content.tex
@@ -2432,6 +2432,8 @@ Device ID  &  Virtio Device    \\
 \hline
 23         &   IOMMU device \\
 \hline
+24         &   Memory device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

