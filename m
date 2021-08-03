Return-Path: <virtio-dev-return-8479-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6875B98650D
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:38 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:20 +0100
Message-Id: <20210803131024.40280-12-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 11/15] firmware: arm_scmi: Add message passing abstractions for transports
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Peter Hilber <peter.hilber@opensynergy.com>

Add abstractions for future transports using message passing, such as
virtio. Derive the abstractions from the shared memory abstractions.

Abstract the transport SDU through the opaque struct scmi_msg_payld.
Also enable the transport to determine all other required information
about the transport SDU.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: Adapted to new SCMI Kconfig layout, updated Copyrights ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- removed uneeded includes
v4 --> v5
- adapted to new SCMI Kconfig
- removed raw_payload msg helpers
v3 --> v4
- added raw_payload msg helpers
---
 drivers/firmware/arm_scmi/Kconfig  |   6 ++
 drivers/firmware/arm_scmi/Makefile |   1 +
 drivers/firmware/arm_scmi/common.h |  15 ++++
 drivers/firmware/arm_scmi/msg.c    | 111 +++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/msg.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index cd84e5f2ee02..24fed705b02c 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -36,6 +36,12 @@ config ARM_SCMI_HAVE_SHMEM
 	  This declares whether a shared memory based transport for SCMI is
 	  available.
 
+config ARM_SCMI_HAVE_MSG
+	bool
+	help
+	  This declares whether a message passing based transport for SCMI is
+	  available.
+
 config ARM_SCMI_TRANSPORT_MAILBOX
 	bool "SCMI transport based on Mailbox"
 	depends on MAILBOX
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index e0e6bd3dba9e..aaad9f6589aa 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,6 +4,7 @@ scmi-driver-y = driver.o notify.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
+scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6320345865e8..4da6cecc0a1c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -432,6 +432,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 
+/* declarations for message passing transports */
+struct scmi_msg_payld;
+
+/* Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
+#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
+
+size_t msg_response_size(struct scmi_xfer *xfer);
+size_t msg_command_size(struct scmi_xfer *xfer);
+void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
+u32 msg_read_header(struct scmi_msg_payld *msg);
+void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
+			struct scmi_xfer *xfer);
+void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
+			    size_t max_len, struct scmi_xfer *xfer);
+
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
new file mode 100644
index 000000000000..d33a704e5814
--- /dev/null
+++ b/drivers/firmware/arm_scmi/msg.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * For transports using message passing.
+ *
+ * Derived from shm.c.
+ *
+ * Copyright (C) 2019-2021 ARM Ltd.
+ * Copyright (C) 2020-2021 OpenSynergy GmbH
+ */
+
+#include <linux/types.h>
+
+#include "common.h"
+
+/*
+ * struct scmi_msg_payld - Transport SDU layout
+ *
+ * The SCMI specification requires all parameters, message headers, return
+ * arguments or any protocol data to be expressed in little endian format only.
+ */
+struct scmi_msg_payld {
+	__le32 msg_header;
+	__le32 msg_payload[];
+};
+
+/**
+ * msg_command_size() - Actual size of transport SDU for command.
+ *
+ * @xfer: message which core has prepared for sending
+ *
+ * Return: transport SDU size.
+ */
+size_t msg_command_size(struct scmi_xfer *xfer)
+{
+	return sizeof(struct scmi_msg_payld) + xfer->tx.len;
+}
+
+/**
+ * msg_response_size() - Maximum size of transport SDU for response.
+ *
+ * @xfer: message which core has prepared for sending
+ *
+ * Return: transport SDU size.
+ */
+size_t msg_response_size(struct scmi_xfer *xfer)
+{
+	return sizeof(struct scmi_msg_payld) + sizeof(__le32) + xfer->rx.len;
+}
+
+/**
+ * msg_tx_prepare() - Set up transport SDU for command.
+ *
+ * @msg: transport SDU for command
+ * @xfer: message which is being sent
+ */
+void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
+{
+	msg->msg_header = cpu_to_le32(pack_scmi_header(&xfer->hdr));
+	if (xfer->tx.buf)
+		memcpy(msg->msg_payload, xfer->tx.buf, xfer->tx.len);
+}
+
+/**
+ * msg_read_header() - Read SCMI header from transport SDU.
+ *
+ * @msg: transport SDU
+ *
+ * Return: SCMI header
+ */
+u32 msg_read_header(struct scmi_msg_payld *msg)
+{
+	return le32_to_cpu(msg->msg_header);
+}
+
+/**
+ * msg_fetch_response() - Fetch response SCMI payload from transport SDU.
+ *
+ * @msg: transport SDU with response
+ * @len: transport SDU size
+ * @xfer: message being responded to
+ */
+void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
+			struct scmi_xfer *xfer)
+{
+	size_t prefix_len = sizeof(*msg) + sizeof(msg->msg_payload[0]);
+
+	xfer->hdr.status = le32_to_cpu(msg->msg_payload[0]);
+	xfer->rx.len = min_t(size_t, xfer->rx.len,
+			     len >= prefix_len ? len - prefix_len : 0);
+
+	/* Take a copy to the rx buffer.. */
+	memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
+}
+
+/**
+ * msg_fetch_notification() - Fetch notification payload from transport SDU.
+ *
+ * @msg: transport SDU with notification
+ * @len: transport SDU size
+ * @max_len: maximum SCMI payload size to fetch
+ * @xfer: notification message
+ */
+void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
+			    size_t max_len, struct scmi_xfer *xfer)
+{
+	xfer->rx.len = min_t(size_t, max_len,
+			     len >= sizeof(*msg) ? len - sizeof(*msg) : 0);
+
+	/* Take a copy to the rx buffer.. */
+	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
+}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

