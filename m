Return-Path: virtio-dev-return-5679-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3E57985C93
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Apr 2019 10:53:27 +0000 (UTC)
From: Stefan Fritsch <sf@sfritsch.de>
Date: Tue, 23 Apr 2019 12:53:24 +0200
Message-Id: <20190423105324.5814-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 2/2] Fix typo
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

It's balloon, not ballon.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 3817e4a..80211e1 100644
--- a/content.tex
+++ b/content.tex
@@ -4543,7 +4543,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
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

