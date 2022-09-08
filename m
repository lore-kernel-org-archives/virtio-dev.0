Return-Path: <virtio-dev-return-9931-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB3A298653B
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Sep 2022 08:30:52 +0000 (UTC)
Date: Thu, 8 Sep 2022 04:30:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220908083044.95376-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] audio->sound
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Spec calls the device "sound device". Make the name in the
ID section match.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 5c66e6b..279998a 100644
--- a/content.tex
+++ b/content.tex
@@ -3014,7 +3014,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 24         &   Memory device \\
 \hline
-25         &   Audio device \\
+25         &   Sound device \\
 \hline
 26         &   file system device \\
 \hline
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

