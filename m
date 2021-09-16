Return-Path: <virtio-dev-return-8673-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 448F09863D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Sep 2021 10:34:26 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 16 Sep 2021 11:33:35 +0100
Message-Id: <20210916103336.7243-2-cristian.marussi@arm.com>
In-Reply-To: <20210916103336.7243-1-cristian.marussi@arm.com>
References: <20210916103336.7243-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH 2/3] firmware: arm_scmi: Simplify spinlocks in virtio transport
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Tryshnivskyy@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Remove unneeded nested irqsave/irqrestore spinlocks.
Add also a few descriptive comments to explain better the system behaviour
at shutdown time.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 9a758d294693..633b5bc379a4 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -110,18 +110,16 @@ static void scmi_finalize_message(struct scmi_vio_channel *vioch,
 	if (vioch->is_rx) {
 		scmi_vio_feed_vq_rx(vioch, msg);
 	} else {
-		unsigned long flags;
-
-		spin_lock_irqsave(&vioch->lock, flags);
+		/* Here IRQs are assumed to be already disabled by the caller */
+		spin_lock(&vioch->lock);
 		list_add(&msg->list, &vioch->free_list);
-		spin_unlock_irqrestore(&vioch->lock, flags);
+		spin_unlock(&vioch->lock);
 	}
 }
 
 static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 {
 	unsigned long ready_flags;
-	unsigned long flags;
 	unsigned int length;
 	struct scmi_vio_channel *vioch;
 	struct scmi_vio_msg *msg;
@@ -140,7 +138,8 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 			goto unlock_ready_out;
 		}
 
-		spin_lock_irqsave(&vioch->lock, flags);
+		/* IRQs already disabled here no need to irqsave */
+		spin_lock(&vioch->lock);
 		if (cb_enabled) {
 			virtqueue_disable_cb(vqueue);
 			cb_enabled = false;
@@ -151,7 +150,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 				goto unlock_out;
 			cb_enabled = true;
 		}
-		spin_unlock_irqrestore(&vioch->lock, flags);
+		spin_unlock(&vioch->lock);
 
 		if (msg) {
 			msg->rx_len = length;
@@ -161,11 +160,18 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 			scmi_finalize_message(vioch, msg);
 		}
 
+		/*
+		 * Release ready_lock and re-enable IRQs between loop iterations
+		 * to allow virtio_chan_free() to possibly kick in and set the
+		 * flag vioch->ready to false even in between processing of
+		 * messages, so as to force outstanding messages to be ignored
+		 * when system is shutting down.
+		 */
 		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
 	}
 
 unlock_out:
-	spin_unlock_irqrestore(&vioch->lock, flags);
+	spin_unlock(&vioch->lock);
 unlock_ready_out:
 	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
 }
@@ -434,6 +440,13 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 
 static void scmi_vio_remove(struct virtio_device *vdev)
 {
+	/*
+	 * Once we get here, virtio_chan_free() will have already been called by
+	 * the SCMI core for any existing channel and, as a consequence, all the
+	 * virtio channels will have been already marked NOT ready, causing any
+	 * outstanding message on any vqueue to be ignored by complete_cb: now
+	 * we can just stop processing buffers and destroy the vqueues.
+	 */
 	vdev->config->reset(vdev);
 	vdev->config->del_vqs(vdev);
 	scmi_vdev = NULL;
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

