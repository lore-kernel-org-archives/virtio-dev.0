Return-Path: virtio-dev-return-7796-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E7E598602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Sep 2020 16:57:19 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
Date: Fri, 18 Sep 2020 18:56:33 +0200
Message-ID: <20200918165634.257150-1-peter.hilber@opensynergy.com>
In-Reply-To: <20200918162311.254564-1-peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 7/7] firmware: arm_scmi: Add virtio transport
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, souvik.chakravarty@arm.com, alex.bennee@linaro.org, jean-philippe@linaro.org, igor.skalkin@opensynergy.com, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Peter Hilber <peter.hilber@opensynergy.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

This transport enables accessing an SCMI platform as a virtio device.

Implement an SCMI virtio driver according to the virtio SCMI device spec
patch v5 [1]. Virtio device id 32 has been reserved for the SCMI device
[2].

The virtio transport has one tx channel (virtio cmdq, A2P channel) and
at most one rx channel (virtio eventq, P2A channel).

The following feature bit defined in [1] is not implemented:
VIRTIO_SCMI_F_SHARED_MEMORY.

After the preparatory patches, implement the virtio transport as
paraphrased:

Call scmi-virtio init from arm-scmi to probe for the virtio device before
arm-scmi will call any transport ops.

Use the scmi_xfer tx/rx buffers for data exchange with the virtio device
in order to avoid redundant maintenance of additional buffers. Allocate
the buffers in the SCMI transport, and prepend room for a small header
used by the virtio transport to the tx/rx buffers.

For simplicity, restrict the number of messages which can be pending
simultaneously according to the virtqueue capacity. (The virtqueue sizes
are negotiated with the virtio device.)

As soon as rx channel message buffers are allocated or have been read
out by the arm-scmi driver, feed them to the virtio device.

Since some virtio devices may not have the short response time exhibited
by SCMI platforms using other transports, set a generous response
timeout.

Limitations:

Do not adjust the other SCMI timeouts for delayed response and polling
for now, since these timeouts are only relevant in special cases which
are not yet deemed relevant for this transport.

To do (as discussed in the cover letter):

- Avoid re-use of buffers still being used by the virtio device on
  timeouts.

- Avoid race conditions on receiving messages during/after channel free
  on driver probe failure or remove.

[1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.ht=
ml
[2] https://www.oasis-open.org/committees/ballot.php?id=3D3496

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 MAINTAINERS                        |   1 +
 drivers/firmware/Kconfig           |  12 +-
 drivers/firmware/arm_scmi/Makefile |   1 +
 drivers/firmware/arm_scmi/common.h |  14 +
 drivers/firmware/arm_scmi/driver.c |  11 +
 drivers/firmware/arm_scmi/virtio.c | 470 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h    |   1 +
 include/uapi/linux/virtio_scmi.h   |  41 +++
 8 files changed, 550 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..8df73d6ddfc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16772,6 +16772,7 @@ F:=09drivers/firmware/arm_scpi.c
 F:=09drivers/reset/reset-scmi.c
 F:=09include/linux/sc[mp]i_protocol.h
 F:=09include/trace/events/scmi.h
+F:=09include/uapi/linux/virtio_scmi.h
=20
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:=09Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bdde51adb267..c4bdd84f7405 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 =09tristate "ARM System Control and Management Interface (SCMI) Message Pr=
otocol"
 =09depends on ARM || ARM64 || COMPILE_TEST
-=09depends on ARM_SCMI_HAVE_SHMEM
+=09depends on ARM_SCMI_HAVE_SHMEM || VIRTIO_SCMI
 =09help
 =09  ARM System Control and Management Interface (SCMI) protocol is a
 =09  set of operating system-independent software interfaces that are
@@ -34,6 +34,16 @@ config ARM_SCMI_HAVE_SHMEM
 =09  This declares whether a shared memory based transport for SCMI is
 =09  available.
=20
+config VIRTIO_SCMI
+=09bool "Virtio transport for SCMI"
+=09default n
+=09depends on VIRTIO
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
index 3cc7fa40a464..25caea5e1969 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,6 +4,7 @@ scmi-driver-y =3D driver.o notify.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
 scmi-transport-$(CONFIG_MAILBOX) +=3D mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) +=3D smc.o
+scmi-transport-$(CONFIG_VIRTIO_SCMI) +=3D virtio.o
 scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o
 scmi-module-objs :=3D $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 =09=09    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi=
/common.h
index c6071ffe4346..865364dea9ea 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -161,6 +161,17 @@ int scmi_base_protocol_init(struct scmi_handle *h);
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
=20
+#ifdef CONFIG_VIRTIO_SCMI
+int __init virtio_scmi_init(void);
+void __exit virtio_scmi_exit(void);
+#else
+static inline int __init virtio_scmi_init(void)
+{
+=09return 0;
+}
+#define virtio_scmi_exit() do { } while (0)
+#endif
+
 #define DECLARE_SCMI_REGISTER_UNREGISTER(func)=09=09\
 =09int __init scmi_##func##_register(void);=09\
 =09void __exit scmi_##func##_unregister(void)
@@ -257,6 +268,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
 #ifdef CONFIG_HAVE_ARM_SMCCC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
+#ifdef CONFIG_VIRTIO_SCMI
+extern const struct scmi_desc scmi_virtio_desc;
+#endif
=20
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int =
id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index 2e25f6f068f5..326f69f2a45a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -947,6 +947,9 @@ static const struct of_device_id scmi_of_match[] =3D {
 #endif
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 =09{ .compatible =3D "arm,scmi-smc", .data =3D &scmi_smc_desc},
+#endif
+#ifdef CONFIG_VIRTIO_SCMI
+=09{ .compatible =3D "arm,scmi-virtio", .data =3D &scmi_virtio_desc},
 #endif
 =09{ /* Sentinel */ },
 };
@@ -965,8 +968,14 @@ static struct platform_driver scmi_driver =3D {
=20
 static int __init scmi_driver_init(void)
 {
+=09int ret;
+
 =09scmi_bus_init();
=20
+=09ret =3D virtio_scmi_init();
+=09if (ret)
+=09=09return ret;
+
 =09scmi_clock_register();
 =09scmi_perf_register();
 =09scmi_power_register();
@@ -989,6 +998,8 @@ static void __exit scmi_driver_exit(void)
 =09scmi_sensors_unregister();
 =09scmi_system_unregister();
=20
+=09virtio_scmi_exit();
+
 =09platform_driver_unregister(&scmi_driver);
 }
 module_exit(scmi_driver_exit);
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi=
/virtio.c
new file mode 100644
index 000000000000..126c964d9f49
--- /dev/null
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -0,0 +1,470 @@
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
e
+ * proposed in virtio spec patch v5[1].
+ *
+ * There is one tx channel (virtio cmdq, A2P channel) and at most one rx
+ * channel (virtio eventq, P2A channel). Each channel is implemented throu=
gh a
+ * virtqueue. Access to each virtqueue is protected by a spinlock.
+ *
+ * This SCMI transport uses the scmi_xfer tx/rx buffers for data exchange =
with
+ * the virtio device to avoid maintenance of additional buffers.
+ *
+ * [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg0009=
6.html
+ */
+
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
+#define DESCR_PER_TX_MSG 2
+
+struct scmi_vio_channel {
+=09spinlock_t lock;
+=09struct virtqueue *vqueue;
+=09struct scmi_chan_info *cinfo;
+=09u8 is_rx;
+};
+
+union virtio_scmi_input {
+=09__virtio32 hdr;
+=09struct virtio_scmi_response response;
+=09struct virtio_scmi_notification notification;
+};
+
+struct scmi_vio_msg {
+=09struct virtio_scmi_request *request;
+=09union virtio_scmi_input *input;
+=09u8 completed;
+};
+
+static int scmi_vio_populate_vq_rx(struct scmi_vio_channel *vioch,
+=09=09=09=09   struct scmi_xfer *xfer)
+{
+=09struct scatterlist sg_in;
+=09struct scmi_vio_msg *msg =3D xfer->extra_data;
+=09int rc;
+
+=09msg->completed =3D false;
+
+=09sg_init_one(&sg_in, msg->input,
+=09=09    sizeof(*msg->input) + VIRTIO_SCMI_MAX_MSG_SIZE);
+
+=09rc =3D virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, xfer, GFP_ATOMIC);
+=09if (rc)
+=09=09dev_err(vioch->cinfo->dev, "%s() rc=3D%d\n", __func__, rc);
+=09else
+=09=09virtqueue_kick(vioch->vqueue);
+
+=09return rc;
+}
+
+static void scmi_vio_complete_cb(struct virtqueue *vqueue)
+{
+=09struct scmi_vio_channel *vioch =3D vqueue->priv;
+=09unsigned long iflags;
+=09unsigned int length;
+
+=09spin_lock_irqsave(&vioch->lock, iflags);
+
+=09do {
+=09=09struct scmi_xfer *xfer;
+
+=09=09virtqueue_disable_cb(vqueue);
+
+=09=09while ((xfer =3D virtqueue_get_buf(vqueue, &length))) {
+=09=09=09struct scmi_vio_msg *msg =3D xfer->extra_data;
+=09=09=09u32 msg_hdr =3D
+=09=09=09=09virtio32_to_cpu(vqueue->vdev, msg->input->hdr);
+=09=09=09u8 msg_type =3D MSG_XTRACT_TYPE(msg_hdr);
+
+=09=09=09if (!vioch->is_rx) { /* tx queue response */
+=09=09=09=09msg->completed =3D true;
+=09=09=09=09xfer->rx.len =3D
+=09=09=09=09=09length - sizeof(msg->input->response);
+=09=09=09=09if (!xfer->hdr.poll_completion)
+=09=09=09=09=09scmi_rx_callback(vioch->cinfo, msg_hdr);
+=09=09=09=09continue;
+=09=09=09}
+
+=09=09=09/* rx queue - notification or delayed response */
+=09=09=09switch (msg_type) {
+=09=09=09case MSG_TYPE_NOTIFICATION:
+=09=09=09=09xfer->rx.len =3D length -
+=09=09=09=09=09       sizeof(msg->input->notification);
+=09=09=09=09xfer->rx.buf =3D msg->input->notification.data;
+=09=09=09=09break;
+=09=09=09case MSG_TYPE_DELAYED_RESP:
+=09=09=09=09xfer->rx.len =3D
+=09=09=09=09=09length - sizeof(msg->input->response);
+=09=09=09=09xfer->rx.buf =3D msg->input->response.data;
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09dev_warn_once(vioch->cinfo->dev,
+=09=09=09=09=09      "rx: unknown message_type %d\n",
+=09=09=09=09=09      msg_type);
+=09=09=09=09scmi_vio_populate_vq_rx(vioch, xfer);
+=09=09=09=09continue;
+=09=09=09}
+
+=09=09=09scmi_rx_callback(vioch->cinfo, msg_hdr);
+=09=09=09scmi_vio_populate_vq_rx(vioch, xfer);
+=09=09}
+
+=09=09if (unlikely(virtqueue_is_broken(vqueue)))
+=09=09=09break;
+=09} while (!virtqueue_enable_cb(vqueue));
+
+=09spin_unlock_irqrestore(&vioch->lock, iflags);
+}
+
+static const char *const scmi_vio_vqueue_names[] =3D { "tx", "rx" };
+
+static vq_callback_t *scmi_vio_complete_callbacks[] =3D {
+=09scmi_vio_complete_cb,
+=09scmi_vio_complete_cb
+};
+
+static bool virtio_chan_available(struct device *dev, int idx)
+{
+=09struct platform_device *pdev;
+=09struct virtio_device *vdev;
+=09struct device_node *vioch_node;
+=09struct scmi_vio_channel **vioch;
+
+=09vioch_node =3D of_parse_phandle(dev->of_node, "virtio_transport", 0);
+=09if (!vioch_node)
+=09=09return false;
+
+=09pdev =3D of_find_device_by_node(vioch_node);
+=09of_node_put(vioch_node);
+=09if (!pdev)
+=09=09return false;
+
+=09vdev =3D (struct virtio_device *)pdev->dev.driver_data;
+=09if (!vdev)
+=09=09return false;
+
+=09vioch =3D vdev->priv;
+=09if (!vioch)
+=09=09return false;
+
+=09return vioch[idx] && vioch[idx]->vqueue;
+}
+
+static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *=
dev,
+=09=09=09     bool tx)
+{
+=09struct platform_device *pdev;
+=09struct virtio_device *vdev;
+=09struct device_node *vioch_node;
+=09struct scmi_vio_channel **vioch;
+=09int vioch_index =3D tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
+
+=09vioch_node =3D
+=09=09of_parse_phandle(cinfo->dev->of_node, "virtio_transport", 0);
+
+=09pdev =3D of_find_device_by_node(vioch_node);
+=09of_node_put(vioch_node);
+=09if (!pdev) {
+=09=09dev_err(dev, "virtio_transport device not found\n");
+=09=09return -1;
+=09}
+
+=09vdev =3D (struct virtio_device *)pdev->dev.driver_data;
+=09if (!vdev)
+=09=09return -1;
+
+=09vioch =3D (struct scmi_vio_channel **)vdev->priv;
+=09if (!vioch) {
+=09=09dev_err(dev, "Data from scmi-virtio probe not found\n");
+=09=09return -1;
+=09}
+=09cinfo->transport_info =3D vioch[vioch_index];
+=09vioch[vioch_index]->cinfo =3D cinfo;
+
+=09return 0;
+}
+
+static int virtio_chan_free(int id, void *p, void *data)
+{
+=09struct scmi_chan_info *cinfo =3D p;
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+
+=09if (vioch) {
+=09=09cinfo->transport_info =3D NULL;
+=09=09kfree(vioch);
+=09}
+
+=09scmi_free_channel(cinfo, data, id);
+=09return 0;
+}
+
+static int virtio_get_max_msg(bool tx, struct scmi_chan_info *base_cinfo,
+=09=09=09      int *max_msg)
+{
+=09struct scmi_vio_channel *vioch =3D base_cinfo->transport_info;
+
+=09*max_msg =3D virtqueue_get_vring_size(vioch->vqueue);
+
+=09/* Tx messages need multiple descriptors. */
+=09if (tx)
+=09=09*max_msg /=3D DESCR_PER_TX_MSG;
+
+=09if (*max_msg > MSG_TOKEN_MAX) {
+=09=09dev_notice(
+=09=09=09base_cinfo->dev,
+=09=09=09"Only %ld messages can be pending simultaneously, while the virtq=
ueue could hold %d\n",
+=09=09=09MSG_TOKEN_MAX, *max_msg);
+=09=09*max_msg =3D MSG_TOKEN_MAX;
+=09}
+
+=09return 0;
+}
+
+static int virtio_xfer_init_buffers(struct scmi_chan_info *cinfo,
+=09=09=09=09    struct scmi_xfer *xfer, int max_msg_size)
+{
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+=09struct scmi_vio_msg *msg;
+
+=09msg =3D devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09xfer->extra_data =3D msg;
+
+=09if (vioch->is_rx) {
+=09=09int rc;
+=09=09unsigned long iflags;
+
+=09=09msg->input =3D devm_kzalloc(cinfo->dev,
+=09=09=09=09=09  sizeof(*msg->input) + max_msg_size,
+=09=09=09=09=09  GFP_KERNEL);
+=09=09if (!msg->input)
+=09=09=09return -ENOMEM;
+
+=09=09/*
+=09=09 * xfer->rx.buf will be set to notification or delayed response
+=09=09 * specific values in the receive callback, according to the
+=09=09 * type of the received message.
+=09=09 */
+
+=09=09spin_lock_irqsave(&vioch->lock, iflags);
+=09=09rc =3D scmi_vio_populate_vq_rx(vioch, xfer);
+=09=09spin_unlock_irqrestore(&vioch->lock, iflags);
+=09=09if (rc)
+=09=09=09return rc;
+=09} else {
+=09=09msg->request =3D
+=09=09=09devm_kzalloc(cinfo->dev,
+=09=09=09=09     sizeof(*msg->request) + max_msg_size,
+=09=09=09=09     GFP_KERNEL);
+=09=09if (!msg->request)
+=09=09=09return -ENOMEM;
+
+=09=09xfer->tx.buf =3D msg->request->data;
+
+=09=09msg->input =3D devm_kzalloc(
+=09=09=09cinfo->dev, sizeof(msg->input->response) + max_msg_size,
+=09=09=09GFP_KERNEL);
+=09=09if (!msg->input)
+=09=09=09return -ENOMEM;
+
+=09=09xfer->rx.buf =3D msg->input->response.data;
+=09}
+
+=09return 0;
+}
+
+static int scmi_vio_send(struct scmi_vio_channel *vioch, struct scmi_xfer =
*xfer)
+{
+=09struct scatterlist sg_out;
+=09struct scatterlist sg_in;
+=09struct scatterlist *sgs[DESCR_PER_TX_MSG] =3D { &sg_out, &sg_in };
+=09struct scmi_vio_msg *msg =3D xfer->extra_data;
+=09unsigned long iflags;
+=09int rc;
+
+=09msg->completed =3D false;
+
+=09sg_init_one(&sg_out, msg->request,
+=09=09    sizeof(*msg->request) + xfer->tx.len);
+=09sg_init_one(&sg_in, &msg->input->response,
+=09=09    sizeof(msg->input->response) + xfer->rx.len);
+
+=09spin_lock_irqsave(&vioch->lock, iflags);
+=09rc =3D virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, xfer, GFP_ATOMIC);
+=09if (rc)
+=09=09dev_err(vioch->cinfo->dev, "%s() rc=3D%d\n", __func__, rc);
+=09else
+=09=09virtqueue_kick(vioch->vqueue);
+=09spin_unlock_irqrestore(&vioch->lock, iflags);
+
+=09return rc;
+}
+
+static int virtio_send_message(struct scmi_chan_info *cinfo,
+=09=09=09       struct scmi_xfer *xfer)
+{
+=09uint32_t hdr;
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+=09struct virtio_device *vdev =3D vioch->vqueue->vdev;
+=09struct scmi_vio_msg *msg =3D xfer->extra_data;
+
+=09hdr =3D pack_scmi_header(&xfer->hdr);
+
+=09msg->request->hdr =3D cpu_to_virtio32(vdev, hdr);
+
+=09return scmi_vio_send(vioch, xfer);
+}
+
+static void virtio_fetch_response(struct scmi_chan_info *cinfo,
+=09=09=09=09  struct scmi_xfer *xfer)
+{
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+=09struct scmi_vio_msg *msg =3D xfer->extra_data;
+
+=09xfer->hdr.status =3D virtio32_to_cpu(vioch->vqueue->vdev,
+=09=09=09=09=09   msg->input->response.status);
+}
+
+static void dummy_fetch_notification(struct scmi_chan_info *cinfo,
+=09=09=09=09     size_t max_len, struct scmi_xfer *xfer)
+{
+=09(void)cinfo;
+=09(void)max_len;
+=09(void)xfer;
+}
+
+static void dummy_clear_channel(struct scmi_chan_info *cinfo)
+{
+=09(void)cinfo;
+}
+
+static bool virtio_poll_done(struct scmi_chan_info *cinfo,
+=09=09=09     struct scmi_xfer *xfer)
+{
+=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
+=09struct scmi_vio_msg *msg =3D xfer->extra_data;
+=09unsigned long iflags;
+=09bool completed;
+
+=09spin_lock_irqsave(&vioch->lock, iflags);
+=09completed =3D msg->completed;
+=09spin_unlock_irqrestore(&vioch->lock, iflags);
+
+=09return completed;
+}
+
+static const struct scmi_transport_ops scmi_virtio_ops =3D {
+=09.chan_available =3D virtio_chan_available,
+=09.chan_setup =3D virtio_chan_setup,
+=09.chan_free =3D virtio_chan_free,
+=09.get_max_msg =3D virtio_get_max_msg,
+=09.send_message =3D virtio_send_message,
+=09.fetch_response =3D virtio_fetch_response,
+=09.fetch_notification =3D dummy_fetch_notification,
+=09.clear_channel =3D dummy_clear_channel,
+=09.poll_done =3D virtio_poll_done,
+=09.xfer_init_buffers =3D virtio_xfer_init_buffers,
+};
+
+const struct scmi_desc scmi_virtio_desc =3D {
+=09.ops =3D &scmi_virtio_ops,
+=09.max_rx_timeout_ms =3D 60000, /* for non-realtime virtio devices */
+=09.max_msg =3D 0, /* overridden by virtio_get_max_msg() */
+=09.max_msg_size =3D VIRTIO_SCMI_MAX_MSG_SIZE,
+};
+
+static int scmi_vio_probe(struct virtio_device *vdev)
+{
+=09struct device *dev =3D &vdev->dev;
+=09struct scmi_vio_channel **vioch;
+=09bool have_vq_rx;
+=09int vq_cnt;
+=09int i;
+=09struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
+
+=09vioch =3D devm_kcalloc(dev, VIRTIO_SCMI_VQ_MAX_CNT, sizeof(*vioch),
+=09=09=09     GFP_KERNEL);
+=09if (!vioch)
+=09=09return -ENOMEM;
+
+=09have_vq_rx =3D virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
+=09vq_cnt =3D have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
+
+=09for (i =3D 0; i < vq_cnt; i++) {
+=09=09vioch[i] =3D devm_kzalloc(dev, sizeof(**vioch), GFP_KERNEL);
+=09=09if (!vioch[i])
+=09=09=09return -ENOMEM;
+=09}
+
+=09if (have_vq_rx)
+=09=09vioch[VIRTIO_SCMI_VQ_RX]->is_rx =3D true;
+
+=09if (virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
+=09=09=09    scmi_vio_vqueue_names, NULL)) {
+=09=09dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
+=09=09return -1;
+=09}
+=09dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
+
+=09for (i =3D 0; i < vq_cnt; i++) {
+=09=09spin_lock_init(&vioch[i]->lock);
+=09=09vioch[i]->vqueue =3D vqs[i];
+=09=09vioch[i]->vqueue->priv =3D vioch[i];
+=09}
+
+=09vdev->priv =3D vioch;
+
+=09virtio_device_ready(vdev);
+
+=09return 0;
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
+};
+
+int __init virtio_scmi_init(void)
+{
+=09return register_virtio_driver(&virtio_scmi_driver);
+}
+
+void __exit virtio_scmi_exit(void)
+{
+=09unregister_virtio_driver(&virtio_scmi_driver);
+}
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_id=
s.h
index b052355ac7a3..57d233c02720 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -48,5 +48,6 @@
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_SCMI         32 /* virtio SCMI */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/uapi/linux/virtio_scmi.h b/include/uapi/linux/virtio_s=
cmi.h
new file mode 100644
index 000000000000..9f21b3dbbfe2
--- /dev/null
+++ b/include/uapi/linux/virtio_scmi.h
@@ -0,0 +1,41 @@
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
+struct virtio_scmi_request {
+=09__virtio32 hdr;
+=09__u8 data[];
+};
+
+struct virtio_scmi_response {
+=09__virtio32 hdr;
+=09__virtio32 status;
+=09__u8 data[];
+};
+
+struct virtio_scmi_notification {
+=09__virtio32 hdr;
+=09__u8 data[];
+};
+
+#endif /* _UAPI_LINUX_VIRTIO_SCMI_H */
--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

