Return-Path: virtio-dev-return-5309-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28CA8985D96
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Jan 2019 10:52:14 +0000 (UTC)
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 10 Jan 2019 11:49:59 +0100
Message-Id: <20190110104959.5809-1-sf@sfritsch.de>
Subject: [virtio-dev] [PATCH] Rename msix_config to config_msix_vector
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The text talks about config_msix_vector. Only struct
virtio_pci_common_cfg has the name msix_config.

Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index b101d1b..d5f3741 100644
--- a/content.tex
+++ b/content.tex
@@ -739,7 +739,7 @@ struct virtio_pci_common_cfg {
         le32 device_feature;            /* read-only for driver */
         le32 driver_feature_select;     /* read-write */
         le32 driver_feature;            /* read-write */
-        le16 msix_config;               /* read-write */
+        le16 config_msix_vector;        /* read-write */
         le16 num_queues;                /* read-only for driver */
         u8 device_status;               /* read-write */
         u8 config_generation;           /* read-only for driver */
-- 
2.11.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

