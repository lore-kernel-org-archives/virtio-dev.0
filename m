Return-Path: <virtio-dev-return-10121-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30145986683
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Nov 2022 17:24:39 +0000 (UTC)
From: Harald Mommer <Harald.Mommer@opensynergy.com>
Date: Fri,  4 Nov 2022 18:24:21 +0100
Message-Id: <20221104172421.8271-3-Harald.Mommer@opensynergy.com>
In-Reply-To: <20221104172421.8271-1-Harald.Mommer@opensynergy.com>
References: <20221104172421.8271-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH v2 2/2] can: virtio: Add virtio_can to MAINTAINERS file.
Content-Type: text/plain
To: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>, Harald Mommer <harald.mommer@opensynergy.com>, Harald Mommer <Harald.Mommer@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Harald Mommer <harald.mommer@opensynergy.com>

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
---
 MAINTAINERS                  | 7 +++++++
 drivers/net/can/virtio_can.c | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..01b2738b7c16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21692,6 +21692,13 @@ F:	drivers/vhost/scsi.c
 F:	include/uapi/linux/virtio_blk.h
 F:	include/uapi/linux/virtio_scsi.h
 
+VIRTIO CAN DRIVER
+M:	"Harald Mommer" <harald.mommer@opensynergy.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/virtio_can.c
+F:	include/uapi/linux/virtio_can.h
+
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit@kernel.org>
 L:	virtualization@lists.linux-foundation.org
diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index 43cf1c9e4afd..0e87172bbddf 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * CAN bus driver for the Virtio CAN controller
- * Copyright (C) 2021 OpenSynergy GmbH
+ * Copyright (C) 2021-2022 OpenSynergy GmbH
  */
 
 #include <linux/atomic.h>
@@ -793,8 +793,6 @@ static void virtio_can_populate_vqs(struct virtio_device *vdev)
 	unsigned int idx;
 	int ret;
 
-	// TODO: Think again a moment if here locks already may be needed!
-
 	/* Fill RX queue */
 	vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
 	for (idx = 0u; idx < ARRAY_SIZE(priv->rpkt); idx++) {
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

