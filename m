Return-Path: virtio-dev-return-8157-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FEAE986227
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 May 2021 00:22:16 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
Date: Tue, 11 May 2021 02:20:39 +0200
Message-ID: <20210511002040.802226-12-peter.hilber@opensynergy.com>
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH v3 11/12] firmware: arm_scmi: Add virtio transport
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>, Peter Hilber <peter.hilber@opensynergy.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, souvik.chakravarty@arm.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>, Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>, Cristian Marussi <cristian.marussi@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

This transport enables accessing an SCMI platform as a virtio device.

Implement an SCMI virtio driver according to the virtio SCMI device spec
[1]. Virtio device id 32 has been reserved for the SCMI device [2].

The virtio transport has one Tx channel (virtio cmdq, A2P channel) and
at most one Rx channel (virtio eventq, P2A channel).

The following feature bit defined in [1] is not implemented:
VIRTIO_SCMI_F_SHARED_MEMORY.

After the preparatory patches, this implements the virtio transport as
paraphrased:

Only support a single arm-scmi device (which is consistent with the SCMI
spec). scmi-virtio init is called from arm-scmi module init. During the
arm-scmi probing, link to the first probed scmi-virtio device. Defer
arm-scmi probing if no scmi-virtio device is bound yet.

For simplicity, restrict the number of messages which can be pending
simultaneously according to the virtqueue capacity. (The virtqueue sizes
are negotiated with the virtio device.)

As soon as Rx channel message buffers are allocated or have been read
out by the arm-scmi driver, feed them to the virtio device.

Since some virtio devices may not have the short response time exhibited
by SCMI platforms using other transports, set a generous response
timeout.

Limitations:

- Polling is not supported.

- The timeout for delayed responses has not been adjusted.

[1] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-scmi.tex
[2] https://www.oasis-open.org/committees/ballot.php?id=3D3496

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 MAINTAINERS                        |   1 +
 drivers/firmware/Kconfig           |  12 +
 drivers/firmware/arm_scmi/Makefile |   1 +
 drivers/firmware/arm_scmi/common.h |   3 +
 drivers/firmware/arm_scmi/driver.c |   3 +
 drivers/firmware/arm_scmi/virtio.c | 523 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h    |   1 +
 include/uapi/linux/virtio_scmi.h   |  25 ++
 8 files changed, 569 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..449c336872f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17705,6 +17705,7 @@ F:=09drivers/regulator/scmi-regulator.c
 F:=09drivers/reset/reset-scmi.c
 F:=09include/linux/sc[mp]i_protocol.h
 F:=09include/trace/events/scmi.h
+F:=09include/uapi/linux/virtio_scmi.h
=20
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:=09Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index e8377b12e4d0..7e9eafdd9b63 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -39,6 +39,18 @@ config ARM_SCMI_HAVE_MSG
 =09  This declares whether a message passing based transport for SCMI is
 =09  available.
=20
+# This config option includes the dependencies of ARM_SCMI_PROTOCOL so tha=
t
+# this config doesn't show up when SCMI wouldn't be available.
+config VIRTIO_SCMI
+=09bool "Virtio transport for SCMI"
+=09select ARM_SCMI_HAVE_MSG
+=09depends on VIRTIO && (ARM || ARM64 || COMPILE_TEST)
+=09help
+=09  This enables the virtio based transport for SCMI.
+
+=09  If you want to use the ARM SCMI protocol between the virtio guest and
+=09  a host providing a virtio SCMI device, answer Y.
+
 config ARM_SCMI_POWER_DOMAIN
 =09tristate "SCMI power domain driver"
 =09depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi=
/Makefile
index f6b4acb8abdb..db1787606fb2 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -5,6 +5,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
 scmi-transport-$(CONFIG_MAILBOX) +=3D mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) +=3D smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
+scmi-transport-$(CONFIG_VIRTIO_SCMI) +=3D virtio.o
 scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o
 scmi-module-objs :=3D $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 =09=09    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi=
/common.h
index 4cb6571c7aaf..bada06cfd33d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -349,6 +349,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
 #ifdef CONFIG_HAVE_ARM_SMCCC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
+#ifdef CONFIG_VIRTIO_SCMI
+extern const struct scmi_desc scmi_virtio_desc;
+#endif
=20
 int scmi_set_transport_info(struct device *dev, void *transport_info);
 void *scmi_get_transport_info(struct device *dev);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index e04e7c8e6928..a31187385470 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1637,6 +1637,9 @@ static const struct of_device_id scmi_of_match[] =3D =
{
 #endif
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 =09{ .compatible =3D "arm,scmi-smc", .data =3D &scmi_smc_desc},
+#endif
+#ifdef CONFIG_VIRTIO_SCMI
+=09{ .compatible =3D "arm,scmi-virtio", .data =3D &scmi_virtio_desc},
 #endif
 =09{ /* Sentinel */ },
 };
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi=
/virtio.c
new file mode 100644
index 000000000000..20972adf6dc7
--- /dev/null
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtio Transport driver for Arm System Control and Management Interface
+ * (SCMI).
+ *
+ * Copyright (C) 2020 OpenSynergy.
+ */
+
+/**
+ * DOC: Theory of Operation
+ *
+ * The scmi-virtio transport implements a driver for the virtio SCMI devic=
e.
+ *
+ * There is one Tx channel (virtio cmdq, A2P channel) and at most one Rx
+ * channel (virtio eventq, P2A channel). Each channel is implemented throu=
gh a
+ * virtqueue. Access to each virtqueue is protected by spinlocks.
+ */
+
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <uapi/linux/virtio_ids.h>
+#include <uapi/linux/virtio_scmi.h>
+
+#include "common.h"
+
+#define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
+#define VIRTIO_SCMI_MAX_PDU_SIZE \
+=09(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
+#define DESCRIPTORS_PER_TX_MSG 2
+
+/**
+ * struct scmi_vio_channel - Transport channel information
+ *
+ * @lock: Protects access to all members except ready.
+ * @ready_lock: Protects access to ready. If required, it must be taken be=
fore
+ *              lock.
+ * @vqueue: Associated virtqueue
+ * @cinfo: SCMI Tx or Rx channel
+ * @free_list: List of unused scmi_vio_msg, maintained for Tx channels onl=
y
+ * @is_rx: Whether channel is an Rx channel
+ * @ready: Whether transport user is ready to hear about channel
+ */
+struct scmi_vio_channel {
+=09spinlock_t lock;
+=09spinlock_t ready_lock;
+=09struct virtqueue *vqueue;
+=09struct scmi_chan_info *cinfo;
+=09struct list_head free_list;
+=09u8 is_rx;
+=09u8 ready;
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
+=09struct scmi_msg_payld *request;
+=09struct scmi_msg_payld *input;
+=09struct list_head list;
+=09unsigned int rx_len;
+};
+
+static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
+{
+=09return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
+}
+
+static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
+=09=09=09       struct scmi_vio_msg *msg)
+{
+=09struct scatterlist sg_in;
+=09int rc;
+=09unsigned long flags;
+
+=09sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
+
+=09spin_lock_irqsave(&vioch->lock, flags);
+
+=09rc =3D virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
+=09if (rc)
+=09=09dev_err_once(vioch->cinfo->dev,
+=09=09=09     "%s() failed to add to virtqueue (%d)\n", __func__,
+=09=09=09     rc);
+=09else
+=09=09virtqueue_kick(vioch->vqueue);
+
+=09spin_unlock_irqrestore(&vioch->lock, flags);
+
+=09return rc;
+}
+
+static void scmi_vio_complete_cb(struct virtqueue *vqueue)
+{
+=09unsigned long ready_flags;
+=09unsigned long flags;
+=09unsigned int length;
+=09struct scmi_vio_channel *vioch;
+=09struct scmi_vio_msg *msg;
+=09bool cb_enabled =3D true;
+
+=09if (WARN_ON_ONCE(!vqueue->vdev->priv))
+=09=09return;
+=09vioch =3D &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->inde=
x];
+
+=09for (;;) {
+=09=09spin_lock_irqsave(&vioch->ready_lock, ready_flags);
+
+=09=09if (!vioch->ready) {
+=09=09=09if (!cb_enabled)
+=09=09=09=09(void)virtqueue_enable_cb(vqueue);
+=09=09=09goto unlock_ready_out;
+=09=09}
+
+=09=09spin_lock_irqsave(&vioch->lock, flags);
+=09=09if (cb_enabled) {
+=09=09=09virtqueue_disable_cb(vqueue);
+=09=09=09cb_enabled =3D false;
+=09=09}
+=09=09msg =3D virtqueue_get_buf(vqueue, &length);
+=09=09if (!msg) {
+=09=09=09if (virtqueue_enable_cb(vqueue))
+=09=09=09=09goto unlock_out;
+=09=09=09else
+=09=09=09=09cb_enabled =3D true;
+=09=09}
+=09=09spin_unlock_irqrestore(&vioch->lock, flags);
+
+=09=09if (msg) {
+=09=09=09msg->rx_len =3D length;
+
+=09=09=09/*
+=09=09=09 * Hold the ready_lock during the callback to avoid
+=09=09=09 * races when the arm-scmi driver is unbinding while
+=09=09=09 * the virtio device is not quiesced yet.
+=09=09=09 */
+=09=09=09scmi_rx_callback(vioch->cinfo,
+=09=09=09=09=09 msg_read_header(msg->input), msg);
+=09=09}
+=09=09spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
+=09}
+
+unlock_out:
+=09spin_unlock_irqrestore(&vioch->lock, flags);
+unlock_ready_out:
+=09spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
+}
+
+static const char *const scmi_vio_vqueue_names[] =3D { "tx", "rx" };
+
+static vq_callback_t *scmi_vio_complete_callbacks[] =3D {
+=09scmi_vio_complete_cb,
+=09scmi_vio_complete_cb
+};
+
+static unsigned int virtio_get_max_msg(bool tx,
+=09=09=09=09       struct scmi_chan_info *base_cinfo)
+{
+=09struct scmi_vio_channel *vioch =3D base_cinfo->transport_info;
+=09unsigned int ret;
+
+=09ret =3D virtqueue_get_vring_size(vioch->vqueue);
+
+=09/* Tx messages need multiple descriptors. */
+=09if (tx)
+=09=09ret /=3D DESCRIPTORS_PER_TX_MSG;
+
+=09if (ret > MSG_TOKEN_MAX) {
+=09=09dev_info_once(
+=09=09=09base_cinfo->dev,
+=09=09=09"Only %ld messages can be pending simultaneously, while the %s vi=
rtqueue could hold %d\n",
+=09=09=09MSG_TOKEN_MAX, tx ? "tx" : "rx", ret);
+=09=09ret =3D MSG_TOKEN_MAX;
+=09}
+
+=09return ret;
+}
+
+static int scmi_vio_match_any_dev(struct device *dev, const void *data)
+{
+=09return 1;
+}
+
+static struct virtio_driver virtio_scmi_driver; /* Forward declaration */
+
+static int virtio_link_supplier(struct device *dev)
+{
+=09struct device *vdev =3D driver_find_device(
+=09=09&virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
+
+=09if (!vdev) {
+=09=09dev_notice_once(
+=09=09=09dev,
+=09=09=09"Deferring probe after not finding a bound scmi-virtio device\n")=
;
+=09=09return -EPROBE_DEFER;
+=09}
+
+=09/* Add device link for remove order and sysfs link. */
+=09if (!device_link_add(dev, vdev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+=09=09put_device(vdev);
+=09=09dev_err(dev, "Adding link to supplier virtio device failed\n");
+=09=09return -ECANCELED;
+=09}
+
+=09put_device(vdev);
+=09return scmi_set_transport_info(dev, dev_to_virtio(vdev));
+}
+
+static bool virtio_chan_available(struct device *dev, int idx)
+{
+=09struct virtio_device *vdev;
+
+=09/* scmi-virtio doesn't support per-protocol channels */
+=09if (is_scmi_protocol_device(dev))
+=09=09return false;
+
+=09vdev =3D scmi_get_transport_info(dev);
+=09if (!vdev)
+=09=09return false;
+
+=09switch (idx) {
+=09case VIRTIO_SCMI_VQ_TX:
+=09=09return true;
+=09case VIRTIO_SCMI_VQ_RX:
+=09=09return scmi_vio_have_vq_rx(vdev);
+=09default:
+=09=09return false;
+=09}
+}
+
+static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *=
dev,
+=09=09=09     bool tx)
+{
+=09unsigned long flags;
+=09struct virtio_device *vdev;
+=09struct scmi_vio_channel *vioch;
+=09int index =3D tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
+=09int max_msg;
+=09int i;
+
+=09if (!virtio_chan_available(dev, index))
+=09=09return -ENODEV;
+
+=09vdev =3D scmi_get_transport_info(dev);
+=09vioch =3D &((struct scmi_vio_channel *)vdev->priv)[index];
+
+=09spin_lock_irqsave(&vioch->lock, flags);
+=09cinfo->transport_info =3D vioch;
+=09vioch->cinfo =3D cinfo;
+=09spin_unlock_irqrestore(&vioch->lock, flags);
+
+=09max_msg =3D virtio_get_max_msg(tx, cinfo);
+
+=09for (i =3D 0; i < max_msg; i++) {
+=09=09struct scmi_vio_msg *msg;
+
+=09=09msg =3D devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
+=09=09if (!msg)
+=09=09=09return -ENOMEM;
+
+=09=09if (tx) {
+=09=09=09msg->request =3D devm_kzalloc(cinfo->dev,
+=09=09=09=09=09=09    VIRTIO_SCMI_MAX_PDU_SIZE,
+=09=09=09=09=09=09    GFP_KERNEL);
+=09=09=09if (!msg->request)
+=09=09=09=09return -ENOMEM;
+=09=09}
+
+=09=09msg->input =3D devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
+=09=09=09=09=09  GFP_KERNEL);
+=09=09if (!msg->input)
+=09=09=09return -ENOMEM;
+
+=09=09if (tx) {
+=09=09=09spin_lock_irqsave(&vioch->lock, flags);
+=09=09=09list_add_tail(&msg->list, &vioch->free_list);
+=09=09=09spin_unlock_irqrestore(&vioch->lock, flags);
+=09=09} else {
+=09=09=09scmi_vio_feed_vq_rx(vioch, msg);
+=09=09}
+=09}
+
+=09spin_lock_irqsave(&vioch->ready_lock, flags);
+=09vioch->ready =3D true;
+=09spin_unlock_irqrestore(&vioch->ready_lock, flags);
+
+=09return 0;
+}
+
+static int virtio_chan_free(int id, void *p, void *data)
+{
+=09unsigned long flags;
+=09struct scmi_chan_info *cinfo =3D p;
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+
+=09spin_lock_irqsave(&vioch->ready_lock, flags);
+=09vioch->ready =3D false;
+=09spin_unlock_irqrestore(&vioch->ready_lock, flags);
+
+=09scmi_free_channel(cinfo, data, id);
+=09return 0;
+}
+
+static int virtio_send_message(struct scmi_chan_info *cinfo,
+=09=09=09       struct scmi_xfer *xfer)
+{
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+=09struct scatterlist sg_out;
+=09struct scatterlist sg_in;
+=09struct scatterlist *sgs[DESCRIPTORS_PER_TX_MSG] =3D { &sg_out, &sg_in }=
;
+=09unsigned long flags;
+=09int rc;
+=09struct scmi_vio_msg *msg;
+
+=09/*
+=09 * TODO: For now, we don't support polling. But it should not be
+=09 * difficult to add support.
+=09 */
+=09if (xfer->hdr.poll_completion)
+=09=09return -EINVAL;
+
+=09spin_lock_irqsave(&vioch->lock, flags);
+
+=09if (list_empty(&vioch->free_list)) {
+=09=09spin_unlock_irqrestore(&vioch->lock, flags);
+=09=09return -EBUSY;
+=09}
+
+=09msg =3D list_first_entry(&vioch->free_list, typeof(*msg), list);
+=09list_del(&msg->list);
+
+=09msg_tx_prepare(msg->request, xfer);
+
+=09sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
+=09sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
+
+=09rc =3D virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
+=09if (rc) {
+=09=09list_add(&msg->list, &vioch->free_list);
+=09=09dev_err_once(vioch->cinfo->dev,
+=09=09=09     "%s() failed to add to virtqueue (%d)\n", __func__,
+=09=09=09     rc);
+=09} else {
+=09=09virtqueue_kick(vioch->vqueue);
+=09}
+
+=09spin_unlock_irqrestore(&vioch->lock, flags);
+
+=09return rc;
+}
+
+static void virtio_fetch_response(struct scmi_chan_info *cinfo,
+=09=09=09=09  struct scmi_xfer *xfer, void *msg_handle)
+{
+=09struct scmi_vio_msg *msg =3D msg_handle;
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+
+=09if (!msg) {
+=09=09dev_dbg_once(&vioch->vqueue->vdev->dev,
+=09=09=09     "Ignoring %s() call with NULL msg_handle\n",
+=09=09=09     __func__);
+=09=09return;
+=09}
+
+=09msg_fetch_response(msg->input, msg->rx_len, xfer);
+}
+
+static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
+=09=09=09=09      size_t max_len, struct scmi_xfer *xfer,
+=09=09=09=09      void *msg_handle)
+{
+=09struct scmi_vio_msg *msg =3D msg_handle;
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+
+=09if (!msg) {
+=09=09dev_dbg_once(&vioch->vqueue->vdev->dev,
+=09=09=09     "Ignoring %s() call with NULL msg_handle\n",
+=09=09=09     __func__);
+=09=09return;
+=09}
+
+=09msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
+}
+
+static void dummy_clear_channel(struct scmi_chan_info *cinfo)
+{
+}
+
+static bool dummy_poll_done(struct scmi_chan_info *cinfo,
+=09=09=09    struct scmi_xfer *xfer)
+{
+=09return false;
+}
+
+static void virtio_drop_message(struct scmi_chan_info *cinfo, void *msg_ha=
ndle)
+{
+=09unsigned long flags;
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+=09struct scmi_vio_msg *msg =3D msg_handle;
+
+=09if (!msg) {
+=09=09dev_dbg_once(&vioch->vqueue->vdev->dev,
+=09=09=09     "Ignoring %s() call with NULL msg_handle\n",
+=09=09=09     __func__);
+=09=09return;
+=09}
+
+=09if (vioch->is_rx) {
+=09=09scmi_vio_feed_vq_rx(vioch, msg);
+=09} else {
+=09=09spin_lock_irqsave(&vioch->lock, flags);
+=09=09list_add(&msg->list, &vioch->free_list);
+=09=09spin_unlock_irqrestore(&vioch->lock, flags);
+=09}
+}
+
+static const struct scmi_transport_ops scmi_virtio_ops =3D {
+=09.link_supplier =3D virtio_link_supplier,
+=09.chan_available =3D virtio_chan_available,
+=09.chan_setup =3D virtio_chan_setup,
+=09.chan_free =3D virtio_chan_free,
+=09.get_max_msg =3D virtio_get_max_msg,
+=09.send_message =3D virtio_send_message,
+=09.fetch_response =3D virtio_fetch_response,
+=09.fetch_notification =3D virtio_fetch_notification,
+=09.clear_channel =3D dummy_clear_channel,
+=09.poll_done =3D dummy_poll_done,
+=09.drop_message =3D virtio_drop_message,
+};
+
+static int scmi_vio_probe(struct virtio_device *vdev)
+{
+=09struct device *dev =3D &vdev->dev;
+=09struct scmi_vio_channel *channels;
+=09bool have_vq_rx;
+=09int vq_cnt;
+=09int i;
+=09int ret;
+=09struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
+
+=09have_vq_rx =3D scmi_vio_have_vq_rx(vdev);
+=09vq_cnt =3D have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
+
+=09channels =3D devm_kcalloc(dev, vq_cnt, sizeof(*channels), GFP_KERNEL);
+=09if (!channels)
+=09=09return -ENOMEM;
+
+=09if (have_vq_rx)
+=09=09channels[VIRTIO_SCMI_VQ_RX].is_rx =3D true;
+
+=09ret =3D virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
+=09=09=09      scmi_vio_vqueue_names, NULL);
+=09if (ret) {
+=09=09dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
+=09=09return ret;
+=09}
+=09dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
+
+=09for (i =3D 0; i < vq_cnt; i++) {
+=09=09spin_lock_init(&channels[i].lock);
+=09=09spin_lock_init(&channels[i].ready_lock);
+=09=09INIT_LIST_HEAD(&channels[i].free_list);
+=09=09channels[i].vqueue =3D vqs[i];
+=09}
+
+=09vdev->priv =3D channels;
+
+=09return 0;
+}
+
+static void scmi_vio_remove(struct virtio_device *vdev)
+{
+=09vdev->config->reset(vdev);
+=09vdev->config->del_vqs(vdev);
+}
+
+static unsigned int features[] =3D {
+=09VIRTIO_SCMI_F_P2A_CHANNELS,
+};
+
+static const struct virtio_device_id id_table[] =3D {
+=09{ VIRTIO_ID_SCMI, VIRTIO_DEV_ANY_ID },
+=09{ 0 }
+};
+
+static struct virtio_driver virtio_scmi_driver =3D {
+=09.driver.name =3D "scmi-virtio",
+=09.driver.owner =3D THIS_MODULE,
+=09.feature_table =3D features,
+=09.feature_table_size =3D ARRAY_SIZE(features),
+=09.id_table =3D id_table,
+=09.probe =3D scmi_vio_probe,
+=09.remove =3D scmi_vio_remove,
+};
+
+static int __init virtio_scmi_init(void)
+{
+=09return register_virtio_driver(&virtio_scmi_driver);
+}
+
+static void __exit virtio_scmi_exit(void)
+{
+=09unregister_virtio_driver(&virtio_scmi_driver);
+}
+
+const struct scmi_desc scmi_virtio_desc =3D {
+=09.init =3D virtio_scmi_init,
+=09.exit =3D virtio_scmi_exit,
+=09.ops =3D &scmi_virtio_ops,
+=09.max_rx_timeout_ms =3D 60000, /* for non-realtime virtio devices */
+=09.max_msg =3D 0, /* overridden by virtio_get_max_msg() */
+=09.max_msg_size =3D VIRTIO_SCMI_MAX_MSG_SIZE,
+};
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_id=
s.h
index f0c35ce8628c..c146fe30e589 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -56,5 +56,6 @@
 #define VIRTIO_ID_PMEM=09=09=0927 /* virtio pmem */
 #define VIRTIO_ID_BT=09=09=0928 /* virtio bluetooth */
 #define VIRTIO_ID_MAC80211_HWSIM=0929 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_SCMI=09=09=0932 /* virtio SCMI */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/uapi/linux/virtio_scmi.h b/include/uapi/linux/virtio_s=
cmi.h
new file mode 100644
index 000000000000..732b01504c35
--- /dev/null
+++ b/include/uapi/linux/virtio_scmi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cl=
ause) */
+/*
+ * Copyright (C) 2020 OpenSynergy GmbH
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_SCMI_H
+#define _UAPI_LINUX_VIRTIO_SCMI_H
+
+#include <linux/virtio_types.h>
+
+/* Feature bits */
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
--=20
2.25.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

