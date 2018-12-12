Return-Path: virtio-dev-return-5192-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA6C2985D81
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Dec 2018 15:36:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 15:27:54 +0000
Message-Id: <20181212152754.12285-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] content: reserve virtio device ID for file system devices
To: virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Reserve device ID 26 for virtio-fs devices.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/31
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index b101d1b..f8d0afb 100644
--- a/content.tex
+++ b/content.tex
@@ -2528,6 +2528,8 @@ Device ID  &  Virtio Device    \\
 \hline
 24         &   Memory device \\
 \hline
+26         &   file system device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.19.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

