Return-Path: <virtio-return-3711-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 21 Apr 2022 11:29:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220421152938.37438-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] virtio-html.cfg: use variable for spec version
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

this way it gets updated automatically

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virtio-html.cfg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virtio-html.cfg b/virtio-html.cfg
index 80212aa..c80d5eb 100644
--- a/virtio-html.cfg
+++ b/virtio-html.cfg
@@ -17,7 +17,7 @@
 	
 	%%\Configure{HColWidth}{\HCode{ style="min-width:\HColWidth"}}
 
-	\Configure{@TITLE}{Virtual I/O Device (VIRTIO) Version 1.1}
+	\Configure{@TITLE}{Virtual I/O Device (VIRTIO) Version \virtiorev}
 	\Css{body { font-family: Arial, Helvetica, sans-serif; font-size: 10pt; }}     
 	\Css{h1 { color:\#552681; font-size:150\%; }}
 	\Css{h2 { color:\#552681; font-size:140\%; }}
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

