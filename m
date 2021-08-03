Return-Path: <virtio-dev-return-8483-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 042F99864F9
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:12:03 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:23 +0100
Message-Id: <20210803131024.40280-15-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 14/15] firmware: arm_scmi: Add priv parameter to scmi_rx_callback
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add a new opaque void *priv parameter to scmi_rx_callback which can be
optionally provided by the transport layer when invoking scmi_rx_callback
and that will be passed back to the transport layer in xfer->priv.

This can be used by transports that needs to keep track of their specific
data structures together with the valid xfers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- moved this patch later in the series right before virtio support
  that directly needs it.
---
 drivers/firmware/arm_scmi/common.h  |  4 +++-
 drivers/firmware/arm_scmi/driver.c  | 17 ++++++++++++-----
 drivers/firmware/arm_scmi/mailbox.c |  2 +-
 drivers/firmware/arm_scmi/smc.c     |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 024d97fbf97b..7864c21269b0 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -172,6 +172,7 @@ struct scmi_msg {
  *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
  *	      (Missing synchronous response is assumed OK and ignored)
  * @lock: A spinlock to protect state and busy fields.
+ * @priv: A pointer for transport private usage.
  */
 struct scmi_xfer {
 	int transfer_id;
@@ -192,6 +193,7 @@ struct scmi_xfer {
 	int state;
 	/* A lock to protect state and busy fields */
 	spinlock_t lock;
+	void *priv;
 };
 
 /*
@@ -417,7 +419,7 @@ extern const struct scmi_desc scmi_mailbox_desc;
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
 /* shmem related declarations */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7ae4ec8f8d1f..aaca01a4d752 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -609,7 +609,8 @@ static inline void scmi_clear_channel(struct scmi_info *info,
 		info->desc->ops->clear_channel(cinfo);
 }
 
-static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
+static void scmi_handle_notification(struct scmi_chan_info *cinfo,
+				     u32 msg_hdr, void *priv)
 {
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
@@ -627,6 +628,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
+	if (priv)
+		xfer->priv = priv;
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -641,7 +644,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	scmi_clear_channel(info, cinfo);
 }
 
-static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
+static void scmi_handle_response(struct scmi_chan_info *cinfo,
+				 u32 msg_hdr, void *priv)
 {
 	struct scmi_xfer *xfer;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
@@ -656,6 +660,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
 		xfer->rx.len = info->desc->max_msg_size;
 
+	if (priv)
+		xfer->priv = priv;
 	info->desc->ops->fetch_response(cinfo, xfer);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
@@ -677,6 +683,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
  *
  * @cinfo: SCMI channel info
  * @msg_hdr: Message header
+ * @priv: Transport specific private data.
  *
  * Processes one received message to appropriate transfer information and
  * signals completion of the transfer.
@@ -684,17 +691,17 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
  * NOTE: This function will be invoked in IRQ context, hence should be
  * as optimal as possible.
  */
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
 {
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
 
 	switch (msg_type) {
 	case MSG_TYPE_NOTIFICATION:
-		scmi_handle_notification(cinfo, msg_hdr);
+		scmi_handle_notification(cinfo, msg_hdr, priv);
 		break;
 	case MSG_TYPE_COMMAND:
 	case MSG_TYPE_DELAYED_RESP:
-		scmi_handle_response(cinfo, msg_hdr);
+		scmi_handle_response(cinfo, msg_hdr, priv);
 		break;
 	default:
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index e3dcb58314ae..e09eb12bf421 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -43,7 +43,7 @@ static void rx_callback(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem));
+	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
 }
 
 static bool mailbox_chan_available(struct device *dev, int idx)
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index bed5596c7209..4effecc3bb46 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -154,7 +154,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	if (scmi_info->irq)
 		wait_for_completion(&scmi_info->tx_complete);
 
-	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
+	scmi_rx_callback(scmi_info->cinfo,
+			 shmem_read_header(scmi_info->shmem), NULL);
 
 	mutex_unlock(&scmi_info->shmem_lock);
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

