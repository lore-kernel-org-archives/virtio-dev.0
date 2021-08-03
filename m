Return-Path: <virtio-dev-return-8484-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61FCE9864F7
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:12:04 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:24 +0100
Message-Id: <20210803131024.40280-16-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 15/15] firmware: arm_scmi: Add virtio transport
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

This transport enables communications with an SCMI platform through virtio;
the SCMI platform will be represented by a virtio device.

Implement an SCMI virtio driver according to the virtio SCMI device spec
[1]. Virtio device id 32 has been reserved for the SCMI device [2].

The virtio transport has one Tx channel (virtio cmdq, A2P channel) and
at most one Rx channel (virtio eventq, P2A channel).

The following feature bit defined in [1] is not implemented:
VIRTIO_SCMI_F_SHARED_MEMORY.

The number of messages which can be pending simultaneously is restricted
according to the virtqueue capacity negotiated at probing time.

As soon as Rx channel message buffers are allocated or have been read
out by the arm-scmi driver, feed them back to the virtio device.

Since some virtio devices may not have the short response time exhibited
by SCMI platforms using other transports, set a generous response
timeout.

SCMI polling mode is not supported by this virtio transport since deemed
meaningless: polling mode operation is offered by the SCMI core to those
transports that could not provide a completion interrupt on the TX path,
which is never the case for virtio whose core callbacks can easily call
into core scmi_rx_callback upon messages reception.

[1] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-scmi.tex
[2] https://www.oasis-open.org/committees/ballot.php?id=3496

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: simplified driver logic, changed link_supplier and channel
	    available/setup logic, removed dummy callbacks ]
Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
NOTE THAT VIRTIO TRANSPORT IS ADDED AS default=n

V6 --> V7
- renamed desc init/exit to transport_init/exit
- reviewed Kconfig option to fit V7 ARM_SCMI Kconfig

V5 --> V6
- removed usage of delegated xfers
- using new scmi_rx_callback with priv argument
- removed .dummy clear_channel/.poll_done callbacks
- added missing spinlock comments
- updated Copyrights

V4 --> V5
- adapted Virtio transport config to new SCMI Kconfig layout
- removed support for polling
- added validate virtio method support
- removed usage of raw_payload helpers
- removed dynamic search of matching devices
- added one single statically configured device

V3 --> V4
- using delegated xfers
- using raw_payload msg helpers
---
 MAINTAINERS                        |   1 +
 drivers/firmware/arm_scmi/Kconfig  |  11 +
 drivers/firmware/arm_scmi/Makefile |   1 +
 drivers/firmware/arm_scmi/common.h |   3 +
 drivers/firmware/arm_scmi/driver.c |   3 +
 drivers/firmware/arm_scmi/virtio.c | 491 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h    |   1 +
 include/uapi/linux/virtio_scmi.h   |  24 ++
 8 files changed, 535 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..db1c7b74642e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17940,6 +17940,7 @@ F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
+F:	include/uapi/linux/virtio_scmi.h
 
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 24fed705b02c..7f4d2435503b 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -66,6 +66,17 @@ config ARM_SCMI_TRANSPORT_SMC
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on SMC, answer Y.
 
+config ARM_SCMI_TRANSPORT_VIRTIO
+	bool "SCMI transport based on VirtIO"
+	depends on VIRTIO
+	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_MSG
+	help
+	  This enables the virtio based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on VirtIO, answer Y.
+
 endif #ARM_SCMI_PROTOCOL
 
 config ARM_SCMI_POWER_DOMAIN
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index aaad9f6589aa..1dcf123d64ab 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -5,6 +5,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
+scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7864c21269b0..dea1bfbe1052 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -418,6 +418,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
+extern const struct scmi_desc scmi_virtio_desc;
+#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index aaca01a4d752..00fcacd06562 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1983,6 +1983,9 @@ static const struct of_device_id scmi_of_match[] = {
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
+#endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
+	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
 #endif
 	{ /* Sentinel */ },
 };
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
new file mode 100644
index 000000000000..3dacf794b177
--- /dev/null
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtio Transport driver for Arm System Control and Management Interface
+ * (SCMI).
+ *
+ * Copyright (C) 2020-2021 OpenSynergy.
+ * Copyright (C) 2021 ARM Ltd.
+ */
+
+/**
+ * DOC: Theory of Operation
+ *
+ * The scmi-virtio transport implements a driver for the virtio SCMI device.
+ *
+ * There is one Tx channel (virtio cmdq, A2P channel) and at most one Rx
+ * channel (virtio eventq, P2A channel). Each channel is implemented through a
+ * virtqueue. Access to each virtqueue is protected by spinlocks.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+
+#include <uapi/linux/virtio_ids.h>
+#include <uapi/linux/virtio_scmi.h>
+
+#include "common.h"
+
+#define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
+#define VIRTIO_SCMI_MAX_PDU_SIZE \
+	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
+#define DESCRIPTORS_PER_TX_MSG 2
+
+/**
+ * struct scmi_vio_channel - Transport channel information
+ *
+ * @vqueue: Associated virtqueue
+ * @cinfo: SCMI Tx or Rx channel
+ * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
+ * @is_rx: Whether channel is an Rx channel
+ * @ready: Whether transport user is ready to hear about channel
+ * @max_msg: Maximum number of pending messages for this channel.
+ * @lock: Protects access to all members except ready.
+ * @ready_lock: Protects access to ready. If required, it must be taken before
+ *              lock.
+ */
+struct scmi_vio_channel {
+	struct virtqueue *vqueue;
+	struct scmi_chan_info *cinfo;
+	struct list_head free_list;
+	bool is_rx;
+	bool ready;
+	unsigned int max_msg;
+	/* lock to protect access to all members except ready. */
+	spinlock_t lock;
+	/* lock to rotects access to ready flag. */
+	spinlock_t ready_lock;
+};
+
+/**
+ * struct scmi_vio_msg - Transport PDU information
+ *
+ * @request: SDU used for commands
+ * @input: SDU used for (delayed) responses and notifications
+ * @list: List which scmi_vio_msg may be part of
+ * @rx_len: Input SDU size in bytes, once input has been received
+ */
+struct scmi_vio_msg {
+	struct scmi_msg_payld *request;
+	struct scmi_msg_payld *input;
+	struct list_head list;
+	unsigned int rx_len;
+};
+
+/* Only one SCMI VirtIO device can possibly exist */
+static struct virtio_device *scmi_vdev;
+
+static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
+{
+	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
+}
+
+static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
+			       struct scmi_vio_msg *msg)
+{
+	struct scatterlist sg_in;
+	int rc;
+	unsigned long flags;
+
+	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
+
+	spin_lock_irqsave(&vioch->lock, flags);
+
+	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
+	if (rc)
+		dev_err_once(vioch->cinfo->dev,
+			     "failed to add to virtqueue (%d)\n", rc);
+	else
+		virtqueue_kick(vioch->vqueue);
+
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	return rc;
+}
+
+static void scmi_finalize_message(struct scmi_vio_channel *vioch,
+				  struct scmi_vio_msg *msg)
+{
+	if (vioch->is_rx) {
+		scmi_vio_feed_vq_rx(vioch, msg);
+	} else {
+		unsigned long flags;
+
+		spin_lock_irqsave(&vioch->lock, flags);
+		list_add(&msg->list, &vioch->free_list);
+		spin_unlock_irqrestore(&vioch->lock, flags);
+	}
+}
+
+static void scmi_vio_complete_cb(struct virtqueue *vqueue)
+{
+	unsigned long ready_flags;
+	unsigned long flags;
+	unsigned int length;
+	struct scmi_vio_channel *vioch;
+	struct scmi_vio_msg *msg;
+	bool cb_enabled = true;
+
+	if (WARN_ON_ONCE(!vqueue->vdev->priv))
+		return;
+	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
+
+	for (;;) {
+		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
+
+		if (!vioch->ready) {
+			if (!cb_enabled)
+				(void)virtqueue_enable_cb(vqueue);
+			goto unlock_ready_out;
+		}
+
+		spin_lock_irqsave(&vioch->lock, flags);
+		if (cb_enabled) {
+			virtqueue_disable_cb(vqueue);
+			cb_enabled = false;
+		}
+		msg = virtqueue_get_buf(vqueue, &length);
+		if (!msg) {
+			if (virtqueue_enable_cb(vqueue))
+				goto unlock_out;
+			cb_enabled = true;
+		}
+		spin_unlock_irqrestore(&vioch->lock, flags);
+
+		if (msg) {
+			msg->rx_len = length;
+			scmi_rx_callback(vioch->cinfo,
+					 msg_read_header(msg->input), msg);
+
+			scmi_finalize_message(vioch, msg);
+		}
+
+		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
+	}
+
+unlock_out:
+	spin_unlock_irqrestore(&vioch->lock, flags);
+unlock_ready_out:
+	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
+}
+
+static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
+
+static vq_callback_t *scmi_vio_complete_callbacks[] = {
+	scmi_vio_complete_cb,
+	scmi_vio_complete_cb
+};
+
+static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
+{
+	struct scmi_vio_channel *vioch = base_cinfo->transport_info;
+
+	return vioch->max_msg;
+}
+
+static int virtio_link_supplier(struct device *dev)
+{
+	if (!scmi_vdev) {
+		dev_notice_once(dev,
+				"Deferring probe after not finding a bound scmi-virtio device\n");
+		return -EPROBE_DEFER;
+	}
+
+	if (!device_link_add(dev, &scmi_vdev->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		dev_err(dev, "Adding link to supplier virtio device failed\n");
+		return -ECANCELED;
+	}
+
+	return 0;
+}
+
+static bool virtio_chan_available(struct device *dev, int idx)
+{
+	struct scmi_vio_channel *channels, *vioch = NULL;
+
+	if (WARN_ON_ONCE(!scmi_vdev))
+		return false;
+
+	channels = (struct scmi_vio_channel *)scmi_vdev->priv;
+
+	switch (idx) {
+	case VIRTIO_SCMI_VQ_TX:
+		vioch = &channels[VIRTIO_SCMI_VQ_TX];
+		break;
+	case VIRTIO_SCMI_VQ_RX:
+		if (scmi_vio_have_vq_rx(scmi_vdev))
+			vioch = &channels[VIRTIO_SCMI_VQ_RX];
+		break;
+	default:
+		return false;
+	}
+
+	return vioch && !vioch->cinfo ? true : false;
+}
+
+static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
+			     bool tx)
+{
+	unsigned long flags;
+	struct scmi_vio_channel *vioch;
+	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
+	int i;
+
+	if (!scmi_vdev)
+		return -EPROBE_DEFER;
+
+	vioch = &((struct scmi_vio_channel *)scmi_vdev->priv)[index];
+
+	for (i = 0; i < vioch->max_msg; i++) {
+		struct scmi_vio_msg *msg;
+
+		msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		if (tx) {
+			msg->request = devm_kzalloc(cinfo->dev,
+						    VIRTIO_SCMI_MAX_PDU_SIZE,
+						    GFP_KERNEL);
+			if (!msg->request)
+				return -ENOMEM;
+		}
+
+		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
+					  GFP_KERNEL);
+		if (!msg->input)
+			return -ENOMEM;
+
+		if (tx) {
+			spin_lock_irqsave(&vioch->lock, flags);
+			list_add_tail(&msg->list, &vioch->free_list);
+			spin_unlock_irqrestore(&vioch->lock, flags);
+		} else {
+			scmi_vio_feed_vq_rx(vioch, msg);
+		}
+	}
+
+	spin_lock_irqsave(&vioch->lock, flags);
+	cinfo->transport_info = vioch;
+	/* Indirectly setting channel not available any more */
+	vioch->cinfo = cinfo;
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	spin_lock_irqsave(&vioch->ready_lock, flags);
+	vioch->ready = true;
+	spin_unlock_irqrestore(&vioch->ready_lock, flags);
+
+	return 0;
+}
+
+static int virtio_chan_free(int id, void *p, void *data)
+{
+	unsigned long flags;
+	struct scmi_chan_info *cinfo = p;
+	struct scmi_vio_channel *vioch = cinfo->transport_info;
+
+	spin_lock_irqsave(&vioch->ready_lock, flags);
+	vioch->ready = false;
+	spin_unlock_irqrestore(&vioch->ready_lock, flags);
+
+	scmi_free_channel(cinfo, data, id);
+
+	spin_lock_irqsave(&vioch->lock, flags);
+	vioch->cinfo = NULL;
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	return 0;
+}
+
+static int virtio_send_message(struct scmi_chan_info *cinfo,
+			       struct scmi_xfer *xfer)
+{
+	struct scmi_vio_channel *vioch = cinfo->transport_info;
+	struct scatterlist sg_out;
+	struct scatterlist sg_in;
+	struct scatterlist *sgs[DESCRIPTORS_PER_TX_MSG] = { &sg_out, &sg_in };
+	unsigned long flags;
+	int rc;
+	struct scmi_vio_msg *msg;
+
+	spin_lock_irqsave(&vioch->lock, flags);
+
+	if (list_empty(&vioch->free_list)) {
+		spin_unlock_irqrestore(&vioch->lock, flags);
+		return -EBUSY;
+	}
+
+	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
+	list_del(&msg->list);
+
+	msg_tx_prepare(msg->request, xfer);
+
+	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
+	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
+
+	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
+	if (rc) {
+		list_add(&msg->list, &vioch->free_list);
+		dev_err_once(vioch->cinfo->dev,
+			     "%s() failed to add to virtqueue (%d)\n", __func__,
+			     rc);
+	} else {
+		virtqueue_kick(vioch->vqueue);
+	}
+
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	return rc;
+}
+
+static void virtio_fetch_response(struct scmi_chan_info *cinfo,
+				  struct scmi_xfer *xfer)
+{
+	struct scmi_vio_msg *msg = xfer->priv;
+
+	if (msg) {
+		msg_fetch_response(msg->input, msg->rx_len, xfer);
+		xfer->priv = NULL;
+	}
+}
+
+static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
+				      size_t max_len, struct scmi_xfer *xfer)
+{
+	struct scmi_vio_msg *msg = xfer->priv;
+
+	if (msg) {
+		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
+		xfer->priv = NULL;
+	}
+}
+
+static const struct scmi_transport_ops scmi_virtio_ops = {
+	.link_supplier = virtio_link_supplier,
+	.chan_available = virtio_chan_available,
+	.chan_setup = virtio_chan_setup,
+	.chan_free = virtio_chan_free,
+	.get_max_msg = virtio_get_max_msg,
+	.send_message = virtio_send_message,
+	.fetch_response = virtio_fetch_response,
+	.fetch_notification = virtio_fetch_notification,
+};
+
+static int scmi_vio_probe(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct scmi_vio_channel *channels;
+	bool have_vq_rx;
+	int vq_cnt;
+	int i;
+	int ret;
+	struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
+
+	/* Only one SCMI VirtiO device allowed */
+	if (scmi_vdev)
+		return -EINVAL;
+
+	have_vq_rx = scmi_vio_have_vq_rx(vdev);
+	vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
+
+	channels = devm_kcalloc(dev, vq_cnt, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	if (have_vq_rx)
+		channels[VIRTIO_SCMI_VQ_RX].is_rx = true;
+
+	ret = virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
+			      scmi_vio_vqueue_names, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
+		return ret;
+	}
+
+	for (i = 0; i < vq_cnt; i++) {
+		unsigned int sz;
+
+		spin_lock_init(&channels[i].lock);
+		spin_lock_init(&channels[i].ready_lock);
+		INIT_LIST_HEAD(&channels[i].free_list);
+		channels[i].vqueue = vqs[i];
+
+		sz = virtqueue_get_vring_size(channels[i].vqueue);
+		/* Tx messages need multiple descriptors. */
+		if (!channels[i].is_rx)
+			sz /= DESCRIPTORS_PER_TX_MSG;
+
+		if (sz > MSG_TOKEN_MAX) {
+			dev_info_once(dev,
+				      "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
+				      channels[i].is_rx ? "rx" : "tx",
+				      sz, MSG_TOKEN_MAX);
+			sz = MSG_TOKEN_MAX;
+		}
+		channels[i].max_msg = sz;
+	}
+
+	vdev->priv = channels;
+	scmi_vdev = vdev;
+
+	return 0;
+}
+
+static void scmi_vio_remove(struct virtio_device *vdev)
+{
+	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
+	scmi_vdev = NULL;
+}
+
+static int scmi_vio_validate(struct virtio_device *vdev)
+{
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev,
+			"device does not comply with spec version 1.x\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned int features[] = {
+	VIRTIO_SCMI_F_P2A_CHANNELS,
+};
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_SCMI, VIRTIO_DEV_ANY_ID },
+	{ 0 }
+};
+
+static struct virtio_driver virtio_scmi_driver = {
+	.driver.name = "scmi-virtio",
+	.driver.owner = THIS_MODULE,
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
+	.id_table = id_table,
+	.probe = scmi_vio_probe,
+	.remove = scmi_vio_remove,
+	.validate = scmi_vio_validate,
+};
+
+static int __init virtio_scmi_init(void)
+{
+	return register_virtio_driver(&virtio_scmi_driver);
+}
+
+static void __exit virtio_scmi_exit(void)
+{
+	unregister_virtio_driver(&virtio_scmi_driver);
+}
+
+const struct scmi_desc scmi_virtio_desc = {
+	.transport_init = virtio_scmi_init,
+	.transport_exit = virtio_scmi_exit,
+	.ops = &scmi_virtio_ops,
+	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
+	.max_msg = 0, /* overridden by virtio_get_max_msg() */
+	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+};
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 70a8057ad4bb..f74155f6882d 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -55,6 +55,7 @@
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_SCMI			32 /* virtio SCMI */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 
 /*
diff --git a/include/uapi/linux/virtio_scmi.h b/include/uapi/linux/virtio_scmi.h
new file mode 100644
index 000000000000..f8ddd04a3ace
--- /dev/null
+++ b/include/uapi/linux/virtio_scmi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2020-2021 OpenSynergy GmbH
+ * Copyright (C) 2021 ARM Ltd.
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_SCMI_H
+#define _UAPI_LINUX_VIRTIO_SCMI_H
+
+#include <linux/virtio_types.h>
+
+/* Device implements some SCMI notifications, or delayed responses. */
+#define VIRTIO_SCMI_F_P2A_CHANNELS 0
+
+/* Device implements any SCMI statistics shared memory region */
+#define VIRTIO_SCMI_F_SHARED_MEMORY 1
+
+/* Virtqueues */
+
+#define VIRTIO_SCMI_VQ_TX 0 /* cmdq */
+#define VIRTIO_SCMI_VQ_RX 1 /* eventq */
+#define VIRTIO_SCMI_VQ_MAX_CNT 2
+
+#endif /* _UAPI_LINUX_VIRTIO_SCMI_H */
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

