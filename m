Return-Path: <virtio-dev-return-8471-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47A269864F6
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:12 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:11 +0100
Message-Id: <20210803131024.40280-3-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 02/15] firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Being a while that we have SCMI trace events in the SCMI stack, remove
this debug helper and its call sites.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a7a789c5d101..bd7f81b2b46b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -172,19 +172,6 @@ static inline int scmi_to_linux_errno(int errno)
 	return -EIO;
 }
 
-/**
- * scmi_dump_header_dbg() - Helper to dump a message header.
- *
- * @dev: Device pointer corresponding to the SCMI entity
- * @hdr: pointer to header.
- */
-static inline void scmi_dump_header_dbg(struct device *dev,
-					struct scmi_msg_hdr *hdr)
-{
-	dev_dbg(dev, "Message ID: %x Sequence ID: %x Protocol: %x\n",
-		hdr->id, hdr->seq, hdr->protocol_id);
-}
-
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv)
 {
@@ -288,7 +275,6 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
-	scmi_dump_header_dbg(dev, &xfer->hdr);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -339,8 +325,6 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (msg_type == MSG_TYPE_DELAYED_RESP)
 		xfer->rx.len = info->desc->max_msg_size;
 
-	scmi_dump_header_dbg(dev, &xfer->hdr);
-
 	info->desc->ops->fetch_response(cinfo, xfer);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

