Return-Path: virtio-dev-return-5310-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 233C8985DA9
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Jan 2019 16:45:35 +0000 (UTC)
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 10 Jan 2019 17:45:31 +0100
Message-Id: <20190110164531.11049-1-sf@sfritsch.de>
Subject: [virtio-dev] [PATCH] Fix typo
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

It's balloon, not ballon.
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index d5f3741..4c23b7d 100644
--- a/content.tex
+++ b/content.tex
@@ -4381,7 +4381,7 @@ guest memory statistics to the host.
 \item[2] statsq.
 \end{description}
 
-  Virtqueue 2 only exists if VIRTIO_BALLON_F_STATS_VQ set.
+  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
 
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
-- 
2.11.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

