Return-Path: virtio-dev-return-5680-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29C30985C85
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Apr 2019 10:53:42 +0000 (UTC)
From: Stefan Fritsch <sf@sfritsch.de>
Date: Tue, 23 Apr 2019 12:52:35 +0200
Message-Id: <20190423105235.5749-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 1/2] Rename msix_config to config_msix_vector
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The text talks about config_msix_vector. Only struct
virtio_pci_common_cfg has the name msix_config.

Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 193b6e1..3817e4a 100644
--- a/content.tex
+++ b/content.tex
@@ -779,7 +779,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le32 device_feature;            /* read-only for driver */
         le32 driver_feature_select;     /* read-write */
         le32 driver_feature;            /* read-write */
-        le16 msix_config;               /* read-write */
+        le16 config_msix_vector;        /* read-write */
         le16 num_queues;                /* read-only for driver */
         u8 device_status;               /* read-write */
         u8 config_generation;           /* read-only for driver */
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

