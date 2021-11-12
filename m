Return-Path: <virtio-dev-return-8945-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58964986490
	for <virtio-dev@lists.oasis-open.org>; Fri, 12 Nov 2021 18:07:26 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 12 Nov 2021 18:07:05 +0000
Message-Id: <20211112180705.41601-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH] firmware: arm_scmi: Fix null de-reference on error path
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

During channel setup a failure in the call of scmi_vio_feed_vq_rx() leads
to an attempt to access a dev pointer by dereferencing vioch->cinfo at
a time when vioch->cinfo has still to be initialized.

Fix it by providing the device reference directly to scmi_vio_feed_vq_rx.

Fixes: 46abe13b5e3db ("firmware: arm_scmi: Add virtio transport")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index c8cab5652daf..c30f82cc59ac 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -82,7 +82,8 @@ static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
 }
 
 static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
-			       struct scmi_vio_msg *msg)
+			       struct scmi_vio_msg *msg,
+			       struct device *dev)
 {
 	struct scatterlist sg_in;
 	int rc;
@@ -94,8 +95,7 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
 
 	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
 	if (rc)
-		dev_err(vioch->cinfo->dev,
-			"failed to add to RX virtqueue (%d)\n", rc);
+		dev_err(dev, "failed to add to RX virtqueue (%d)\n", rc);
 	else
 		virtqueue_kick(vioch->vqueue);
 
@@ -108,7 +108,7 @@ static void scmi_finalize_message(struct scmi_vio_channel *vioch,
 				  struct scmi_vio_msg *msg)
 {
 	if (vioch->is_rx) {
-		scmi_vio_feed_vq_rx(vioch, msg);
+		scmi_vio_feed_vq_rx(vioch, msg, vioch->cinfo->dev);
 	} else {
 		/* Here IRQs are assumed to be already disabled by the caller */
 		spin_lock(&vioch->lock);
@@ -269,7 +269,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			list_add_tail(&msg->list, &vioch->free_list);
 			spin_unlock_irqrestore(&vioch->lock, flags);
 		} else {
-			scmi_vio_feed_vq_rx(vioch, msg);
+			scmi_vio_feed_vq_rx(vioch, msg, cinfo->dev);
 		}
 	}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

