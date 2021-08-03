Return-Path: <virtio-dev-return-8478-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AE319864F9
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:38 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:19 +0100
Message-Id: <20210803131024.40280-11-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 10/15] firmware: arm_scmi: Add method to override max message number
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

The maximum number of simultaneously pending messages is a transport
specific quantity that is usually described statically in struct scmi_desc.

Some transports, though, can calculate such number only at run-time after
some initial transport specific setup and probing is completed; moreover
the resulting max message numbers could also be different between rx and
tx channels.

Add an optional get_max_msg() operation so that a transport can report more
accurate max message numbers for each channel type.

The value in scmi_desc.max_msg is still used as default when transport does
not provide any get_max_msg() method.

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: refactored how get_max_msg() is used to minimize core changes ]
Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- refactored usage of get_max_msg()
---
 drivers/firmware/arm_scmi/common.h |  9 +++++--
 drivers/firmware/arm_scmi/driver.c | 40 +++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 204cde53a9a7..6320345865e8 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -351,6 +351,9 @@ struct scmi_chan_info {
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
+ * @get_max_msg: Optional callback to provide max_msg dynamically
+ *		 Returns the maximum number of messages for the channel type
+ *		 (tx or rx) that can be pending simultaneously in the system
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -363,6 +366,7 @@ struct scmi_transport_ops {
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
+	unsigned int (*get_max_msg)(struct scmi_chan_info *base_cinfo);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
@@ -390,8 +394,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *		    de-initialization, so after SCMI core removal.
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
- * @max_msg: Maximum number of messages that can be pending
- *	simultaneously in the system
+ * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
+ *	be pending simultaneously in the system. May be overridden by the
+ *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d20e6760b488..a907f3fe4c08 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -72,6 +72,7 @@ struct scmi_requested_dev {
  *	Index of this bitmap table is also used for message
  *	sequence identifier.
  * @xfer_lock: Protection for message allocation
+ * @max_msg: Maximum number of messages that can be pending
  * @free_xfers: A free list for available to use xfers. It is initialized with
  *		a number of xfers equal to the maximum allowed in-flight
  *		messages.
@@ -81,6 +82,7 @@ struct scmi_requested_dev {
 struct scmi_xfers_info {
 	unsigned long *xfer_alloc_table;
 	spinlock_t xfer_lock;
+	int max_msg;
 	struct hlist_head free_xfers;
 	DECLARE_HASHTABLE(pending_xfers, SCMI_PENDING_XFERS_HT_ORDER_SZ);
 };
@@ -1373,10 +1375,10 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	const struct scmi_desc *desc = sinfo->desc;
 
 	/* Pre-allocated messages, no more than what hdr.seq can support */
-	if (WARN_ON(!desc->max_msg || desc->max_msg > MSG_TOKEN_MAX)) {
+	if (WARN_ON(!info->max_msg || info->max_msg > MSG_TOKEN_MAX)) {
 		dev_err(dev,
 			"Invalid maximum messages %d, not in range [1 - %lu]\n",
-			desc->max_msg, MSG_TOKEN_MAX);
+			info->max_msg, MSG_TOKEN_MAX);
 		return -EINVAL;
 	}
 
@@ -1394,7 +1396,7 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	 * attach all of them to the free list
 	 */
 	INIT_HLIST_HEAD(&info->free_xfers);
-	for (i = 0; i < desc->max_msg; i++) {
+	for (i = 0; i < info->max_msg; i++) {
 		xfer = devm_kzalloc(dev, sizeof(*xfer), GFP_KERNEL);
 		if (!xfer)
 			return -ENOMEM;
@@ -1417,10 +1419,40 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	return 0;
 }
 
+static int scmi_channels_max_msg_configure(struct scmi_info *sinfo)
+{
+	const struct scmi_desc *desc = sinfo->desc;
+
+	if (!desc->ops->get_max_msg) {
+		sinfo->tx_minfo.max_msg = desc->max_msg;
+		sinfo->rx_minfo.max_msg = desc->max_msg;
+	} else {
+		struct scmi_chan_info *base_cinfo;
+
+		base_cinfo = idr_find(&sinfo->tx_idr, SCMI_PROTOCOL_BASE);
+		if (!base_cinfo)
+			return -EINVAL;
+		sinfo->tx_minfo.max_msg = desc->ops->get_max_msg(base_cinfo);
+
+		/* RX channel is optional so can be skipped */
+		base_cinfo = idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE);
+		if (base_cinfo)
+			sinfo->rx_minfo.max_msg =
+				desc->ops->get_max_msg(base_cinfo);
+	}
+
+	return 0;
+}
+
 static int scmi_xfer_info_init(struct scmi_info *sinfo)
 {
-	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
+	int ret;
+
+	ret = scmi_channels_max_msg_configure(sinfo);
+	if (ret)
+		return ret;
 
+	ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
 	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
 		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

