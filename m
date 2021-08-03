Return-Path: <virtio-dev-return-8470-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 123FF9863C5
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:07 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:10 +0100
Message-Id: <20210803131024.40280-2-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 01/15] firmware: arm_scmi: Add support for type handling in common functions
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add SCMI type handling to pack/unpack_scmi_header common helper functions.
Initialize hdr.type properly when initializing a command xfer.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Needed later in the series to support serialization
---
 drivers/firmware/arm_scmi/common.h | 6 +++++-
 drivers/firmware/arm_scmi/driver.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 8685619d38f9..7c2b9fd7e929 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -70,6 +70,7 @@ struct scmi_msg_resp_prot_version {
  *
  * @id: The identifier of the message being sent
  * @protocol_id: The identifier of the protocol used to send @id message
+ * @type: The SCMI type for this message
  * @seq: The token to identify the message. When a message returns, the
  *	platform returns the whole message header unmodified including the
  *	token
@@ -80,6 +81,7 @@ struct scmi_msg_resp_prot_version {
 struct scmi_msg_hdr {
 	u8 id;
 	u8 protocol_id;
+	u8 type;
 	u16 seq;
 	u32 status;
 	bool poll_completion;
@@ -89,13 +91,14 @@ struct scmi_msg_hdr {
  * pack_scmi_header() - packs and returns 32-bit header
  *
  * @hdr: pointer to header containing all the information on message id,
- *	protocol id and sequence id.
+ *	protocol id, sequence id and type.
  *
  * Return: 32-bit packed message header to be sent to the platform.
  */
 static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 {
 	return FIELD_PREP(MSG_ID_MASK, hdr->id) |
+		FIELD_PREP(MSG_TYPE_MASK, hdr->type) |
 		FIELD_PREP(MSG_TOKEN_ID_MASK, hdr->seq) |
 		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
 }
@@ -110,6 +113,7 @@ static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
 {
 	hdr->id = MSG_XTRACT_ID(msg_hdr);
 	hdr->protocol_id = MSG_XTRACT_PROT_ID(msg_hdr);
+	hdr->type = MSG_XTRACT_TYPE(msg_hdr);
 }
 
 /**
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9b2e8d42a992..a7a789c5d101 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -566,6 +566,7 @@ static int xfer_get_init(const struct scmi_protocol_handle *ph,
 
 	xfer->tx.len = tx_size;
 	xfer->rx.len = rx_size ? : info->desc->max_msg_size;
+	xfer->hdr.type = MSG_TYPE_COMMAND;
 	xfer->hdr.id = msg_id;
 	xfer->hdr.poll_completion = false;
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

