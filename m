Return-Path: virtio-dev-return-6275-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76A60986110
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Nov 2019 07:57:00 +0000 (UTC)
From: Stefan Fritsch <sf@sfritsch.de>
Date: Fri,  1 Nov 2019 08:56:15 +0100
Message-Id: <20191101075615.2780-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] Fix typo
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Fritsch <sf@sfritsch.de>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

It's balloon, not ballon.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index b1ea9b9..d73182f 100644
--- a/content.tex
+++ b/content.tex
@@ -4646,7 +4646,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
 \item[2] statsq.
 \end{description}
 
-  Virtqueue 2 only exists if VIRTIO_BALLON_F_STATS_VQ set.
+  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
 
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

