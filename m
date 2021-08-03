Return-Path: <virtio-dev-return-8475-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF8999864F6
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:21 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:14 +0100
Message-Id: <20210803131024.40280-6-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 05/15] firmware: arm_scmi: Handle concurrent and out-of-order messages
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Even though in case of asynchronous commands an SCMI platform is
constrained to emit the delayed response message only after the related
message response has been sent, the configured underlying transport could
still deliver such messages together or in inverted order, causing races
due to the concurrent or out-of-order access to the underlying xfer.

Introduce a mechanism to grant exclusive access to an xfer in order to
properly serialize concurrent accesses to the same xfer originating from
multiple correlated messages.

Add additional state information to xfer descriptors so as to be able to
identify out-of-order message deliveries and act accordingly:

 - when a delayed response is expected but delivered before the related
   response, the synchronous response is considered as successfully
   received and the delayed response processing is carried on as usual.

 - when/if the missing synchronous response is subsequently received, it
   is discarded as not congruent with the current state of the xfer, or
   simply, because the xfer has been already released and so, now, the
   monotonically increasing sequence number carried by the late response
   is stale.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- re-added xfer refcounting moved out of previous 'monotonic' patch
- removed un-needed 2-way switch in scmi_xfer_state_update()
- renamed scmi_xfer_is_free to scmi_xfer_acquired
- moved scmi_xfer_state_update() call inside scmi_xfer_command_acquire
  to avoid races between msg validation and xfer state update
- added smp_mb() after xfer->state init before .send_message
v5 --> v6
- added spinlock comment
---
 drivers/firmware/arm_scmi/common.h |  30 +++-
 drivers/firmware/arm_scmi/driver.c | 257 ++++++++++++++++++++++++-----
 2 files changed, 246 insertions(+), 41 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 651af0c7bed9..dd19ec2e0105 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -17,7 +17,9 @@
 #include <linux/hashtable.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/refcount.h>
 #include <linux/scmi_protocol.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/unaligned.h>
@@ -153,6 +155,23 @@ struct scmi_msg {
  * @pending: True for xfers added to @pending_xfers hashtable
  * @node: An hlist_node reference used to store this xfer, alternatively, on
  *	  the free list @free_xfers or in the @pending_xfers hashtable
+ * @users: A refcount to track the active users for this xfer.
+ *	   This is meant to protect against the possibility that, when a command
+ *	   transaction times out concurrently with the reception of a valid
+ *	   response message, the xfer could be finally put on the TX path, and
+ *	   so vanish, while on the RX path scmi_rx_callback() is still
+ *	   processing it: in such a case this refcounting will ensure that, even
+ *	   though the timed-out transaction will anyway cause the command
+ *	   request to be reported as failed by time-out, the underlying xfer
+ *	   cannot be discarded and possibly reused until the last one user on
+ *	   the RX path has released it.
+ * @busy: An atomic flag to ensure exclusive write access to this xfer
+ * @state: The current state of this transfer, with states transitions deemed
+ *	   valid being:
+ *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_OK ]
+ *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
+ *	      (Missing synchronous response is assumed OK and ignored)
+ * @lock: A spinlock to protect state and busy fields.
  */
 struct scmi_xfer {
 	int transfer_id;
@@ -163,6 +182,16 @@ struct scmi_xfer {
 	struct completion *async_done;
 	bool pending;
 	struct hlist_node node;
+	refcount_t users;
+#define SCMI_XFER_FREE		0
+#define SCMI_XFER_BUSY		1
+	atomic_t busy;
+#define SCMI_XFER_SENT_OK	0
+#define SCMI_XFER_RESP_OK	1
+#define SCMI_XFER_DRESP_OK	2
+	int state;
+	/* A lock to protect state and busy fields */
+	spinlock_t lock;
 };
 
 /*
@@ -399,5 +428,4 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
-
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3c99390f9415..bfc35d7c7dbd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -374,6 +374,11 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 			xfer = ERR_PTR(ret);
 		}
 	}
+
+	if (!IS_ERR(xfer)) {
+		refcount_set(&xfer->users, 1);
+		atomic_set(&xfer->busy, SCMI_XFER_FREE);
+	}
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 	return xfer;
@@ -396,12 +401,14 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 	unsigned long flags;
 
 	spin_lock_irqsave(&minfo->xfer_lock, flags);
-	if (xfer->pending) {
-		scmi_xfer_token_clear(minfo, xfer);
-		hash_del(&xfer->node);
-		xfer->pending = false;
+	if (refcount_dec_and_test(&xfer->users)) {
+		if (xfer->pending) {
+			scmi_xfer_token_clear(minfo, xfer);
+			hash_del(&xfer->node);
+			xfer->pending = false;
+		}
+		hlist_add_head(&xfer->node, &minfo->free_xfers);
 	}
-	hlist_add_head(&xfer->node, &minfo->free_xfers);
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
@@ -428,6 +435,171 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
 	return xfer ?: ERR_PTR(-EINVAL);
 }
 
+/**
+ * scmi_msg_response_validate  - Validate message type against state of related
+ * xfer
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @msg_type: Message type to check
+ * @xfer: A reference to the xfer to validate against @msg_type
+ *
+ * This function checks if @msg_type is congruent with the current state of
+ * a pending @xfer; if an asynchronous delayed response is received before the
+ * related synchronous response (Out-of-Order Delayed Response) the missing
+ * synchronous response is assumed to be OK and completed, carrying on with the
+ * Delayed Response: this is done to address the case in which the underlying
+ * SCMI transport can deliver such out-of-order responses.
+ *
+ * Context: Assumes to be called with xfer->lock already acquired.
+ *
+ * Return: 0 on Success, error otherwise
+ */
+static inline int scmi_msg_response_validate(struct scmi_chan_info *cinfo,
+					     u8 msg_type,
+					     struct scmi_xfer *xfer)
+{
+	/*
+	 * Even if a response was indeed expected on this slot at this point,
+	 * a buggy platform could wrongly reply feeding us an unexpected
+	 * delayed response we're not prepared to handle: bail-out safely
+	 * blaming firmware.
+	 */
+	if (msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done) {
+		dev_err(cinfo->dev,
+			"Delayed Response for %d not expected! Buggy F/W ?\n",
+			xfer->hdr.seq);
+		return -EINVAL;
+	}
+
+	switch (xfer->state) {
+	case SCMI_XFER_SENT_OK:
+		if (msg_type == MSG_TYPE_DELAYED_RESP) {
+			/*
+			 * Delayed Response expected but delivered earlier.
+			 * Assume message RESPONSE was OK and skip state.
+			 */
+			xfer->hdr.status = SCMI_SUCCESS;
+			xfer->state = SCMI_XFER_RESP_OK;
+			complete(&xfer->done);
+			dev_warn(cinfo->dev,
+				 "Received valid OoO Delayed Response for %d\n",
+				 xfer->hdr.seq);
+		}
+		break;
+	case SCMI_XFER_RESP_OK:
+		if (msg_type != MSG_TYPE_DELAYED_RESP)
+			return -EINVAL;
+		break;
+	case SCMI_XFER_DRESP_OK:
+		/* No further message expected once in SCMI_XFER_DRESP_OK */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * scmi_xfer_state_update  - Update xfer state
+ *
+ * @xfer: A reference to the xfer to update
+ * @msg_type: Type of message being processed.
+ *
+ * Note that this message is assumed to have been already successfully validated
+ * by @scmi_msg_response_validate(), so here we just update the state.
+ *
+ * Context: Assumes to be called on an xfer exclusively acquired using the
+ *	    busy flag.
+ */
+static inline void scmi_xfer_state_update(struct scmi_xfer *xfer, u8 msg_type)
+{
+	xfer->hdr.type = msg_type;
+
+	/* Unknown command types were already discarded earlier */
+	if (xfer->hdr.type == MSG_TYPE_COMMAND)
+		xfer->state = SCMI_XFER_RESP_OK;
+	else
+		xfer->state = SCMI_XFER_DRESP_OK;
+}
+
+static bool scmi_xfer_acquired(struct scmi_xfer *xfer)
+{
+	int ret;
+
+	ret = atomic_cmpxchg(&xfer->busy, SCMI_XFER_FREE, SCMI_XFER_BUSY);
+
+	return ret == SCMI_XFER_FREE;
+}
+
+/**
+ * scmi_xfer_command_acquire  -  Helper to lookup and acquire a command xfer
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @msg_hdr: A message header to use as lookup key
+ *
+ * When a valid xfer is found for the sequence number embedded in the provided
+ * msg_hdr, reference counting is properly updated and exclusive access to this
+ * xfer is granted till released with @scmi_xfer_command_release.
+ *
+ * Return: A valid @xfer on Success or error otherwise.
+ */
+static inline struct scmi_xfer *
+scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
+{
+	int ret;
+	unsigned long flags;
+	struct scmi_xfer *xfer;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct scmi_xfers_info *minfo = &info->tx_minfo;
+	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
+	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
+
+	/* Are we even expecting this? */
+	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
+	if (IS_ERR(xfer)) {
+		dev_err(cinfo->dev,
+			"Message for %d type %d is not expected!\n",
+			xfer_id, msg_type);
+		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+		return xfer;
+	}
+	refcount_inc(&xfer->users);
+	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+	spin_lock_irqsave(&xfer->lock, flags);
+	ret = scmi_msg_response_validate(cinfo, msg_type, xfer);
+	/*
+	 * If a pending xfer was found which was also in a congruent state with
+	 * the received message, acquire exclusive access to it setting the busy
+	 * flag.
+	 * Spins only on the rare limit condition of concurrent reception of
+	 * RESP and DRESP for the same xfer.
+	 */
+	if (!ret) {
+		spin_until_cond(scmi_xfer_acquired(xfer));
+		scmi_xfer_state_update(xfer, msg_type);
+	}
+	spin_unlock_irqrestore(&xfer->lock, flags);
+
+	if (ret) {
+		dev_err(cinfo->dev,
+			"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
+			msg_type, xfer_id, msg_hdr, xfer->state);
+		/* On error the refcount incremented above has to be dropped */
+		__scmi_xfer_put(minfo, xfer);
+		xfer = ERR_PTR(-EINVAL);
+	}
+
+	return xfer;
+}
+
+static inline void scmi_xfer_command_release(struct scmi_info *info,
+					     struct scmi_xfer *xfer)
+{
+	atomic_set(&xfer->busy, SCMI_XFER_FREE);
+	__scmi_xfer_put(&info->tx_minfo, xfer);
+}
+
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
 	struct scmi_xfer *xfer;
@@ -460,57 +632,35 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	info->desc->ops->clear_channel(cinfo);
 }
 
-static void scmi_handle_response(struct scmi_chan_info *cinfo,
-				 u16 xfer_id, u8 msg_type)
+static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
-	unsigned long flags;
 	struct scmi_xfer *xfer;
-	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
-	struct scmi_xfers_info *minfo = &info->tx_minfo;
 
-	/* Are we even expecting this? */
-	spin_lock_irqsave(&minfo->xfer_lock, flags);
-	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
-	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
-		dev_err(dev, "message for %d is not expected!\n", xfer_id);
 		info->desc->ops->clear_channel(cinfo);
 		return;
 	}
 
-	/*
-	 * Even if a response was indeed expected on this slot at this point,
-	 * a buggy platform could wrongly reply feeding us an unexpected
-	 * delayed response we're not prepared to handle: bail-out safely
-	 * blaming firmware.
-	 */
-	if (unlikely(msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done)) {
-		dev_err(dev,
-			"Delayed Response for %d not expected! Buggy F/W ?\n",
-			xfer_id);
-		info->desc->ops->clear_channel(cinfo);
-		/* It was unexpected, so nobody will clear the xfer if not us */
-		__scmi_xfer_put(minfo, xfer);
-		return;
-	}
-
 	/* rx.len could be shrunk in the sync do_xfer, so reset to maxsz */
-	if (msg_type == MSG_TYPE_DELAYED_RESP)
+	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
 		xfer->rx.len = info->desc->max_msg_size;
 
 	info->desc->ops->fetch_response(cinfo, xfer);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
-			   msg_type);
+			   xfer->hdr.type);
 
-	if (msg_type == MSG_TYPE_DELAYED_RESP) {
+	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		info->desc->ops->clear_channel(cinfo);
 		complete(xfer->async_done);
 	} else {
 		complete(&xfer->done);
 	}
+
+	scmi_xfer_command_release(info, xfer);
 }
 
 /**
@@ -527,7 +677,6 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
  */
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
-	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
 
 	switch (msg_type) {
@@ -536,7 +685,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		break;
 	case MSG_TYPE_COMMAND:
 	case MSG_TYPE_DELAYED_RESP:
-		scmi_handle_response(cinfo, xfer_id, msg_type);
+		scmi_handle_response(cinfo, msg_hdr);
 		break;
 	default:
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
@@ -548,7 +697,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
  * xfer_put() - Release a transmit message
  *
  * @ph: Pointer to SCMI protocol handle
- * @xfer: message that was reserved by scmi_xfer_get
+ * @xfer: message that was reserved by xfer_get_init
  */
 static void xfer_put(const struct scmi_protocol_handle *ph,
 		     struct scmi_xfer *xfer)
@@ -566,7 +715,12 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 {
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
+	/*
+	 * Poll also on xfer->done so that polling can be forcibly terminated
+	 * in case of out-of-order receptions of delayed responses
+	 */
 	return info->desc->ops->poll_done(cinfo, xfer) ||
+	       try_wait_for_completion(&xfer->done) ||
 	       ktime_after(ktime_get(), stop);
 }
 
@@ -606,6 +760,16 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 			      xfer->hdr.protocol_id, xfer->hdr.seq,
 			      xfer->hdr.poll_completion);
 
+	xfer->state = SCMI_XFER_SENT_OK;
+	/*
+	 * Even though spinlocking is not needed here since no race is possible
+	 * on xfer->state due to the monotonically increasing tokens allocation,
+	 * we must anyway ensure xfer->state initialization is not re-ordered
+	 * after the .send_message() to be sure that on the RX path an early
+	 * ISR calling scmi_rx_callback() cannot see an old stale xfer->state.
+	 */
+	smp_mb();
+
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
@@ -617,10 +781,22 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 
 		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
 
-		if (ktime_before(ktime_get(), stop))
-			info->desc->ops->fetch_response(cinfo, xfer);
-		else
+		if (ktime_before(ktime_get(), stop)) {
+			unsigned long flags;
+
+			/*
+			 * Do not fetch_response if an out-of-order delayed
+			 * response is being processed.
+			 */
+			spin_lock_irqsave(&xfer->lock, flags);
+			if (xfer->state == SCMI_XFER_SENT_OK) {
+				info->desc->ops->fetch_response(cinfo, xfer);
+				xfer->state = SCMI_XFER_RESP_OK;
+			}
+			spin_unlock_irqrestore(&xfer->lock, flags);
+		} else {
 			ret = -ETIMEDOUT;
+		}
 	} else {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
@@ -1218,6 +1394,7 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 
 		xfer->tx.buf = xfer->rx.buf;
 		init_completion(&xfer->done);
+		spin_lock_init(&xfer->lock);
 
 		/* Add initialized xfer to the free list */
 		hlist_add_head(&xfer->node, &info->free_xfers);
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

