Return-Path: virtio-dev-return-7641-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81AD8985DF5
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:08 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:38 -0700
Message-Id: <20200814024000.2485-3-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 02/24] virtio: add dma-buf support for exported objects
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: David Stevens <stevensd@chromium.org>

This change adds a new flavor of dma-bufs that can be used by virtio
drivers to share exported objects. A virtio dma-buf can be queried by
virtio drivers to obtain the UUID which identifies the underlying
exported object.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/Makefile         |  2 +-
 drivers/virtio/virtio.c         |  6 +++
 drivers/virtio/virtio_dma_buf.c | 82 +++++++++++++++++++++++++++++++++
 include/linux/virtio.h          |  1 +
 include/linux/virtio_dma_buf.h  | 37 +++++++++++++++
 5 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4d993791f2d7..49da768ee7fd 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) +=3D virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) +=3D virtio.o virtio_ring.o virtio_dma_buf.o
 obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) +=3D virtio_pci.o
 virtio_pci-y :=3D virtio_pci_modern.o virtio_pci_common.o
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32a88f2..5d46f0ded92d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -357,6 +357,12 @@ int register_virtio_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(register_virtio_device);
=20
+bool is_virtio_device(struct device *dev)
+{
+=09return dev->bus =3D=3D &virtio_bus;
+}
+EXPORT_SYMBOL_GPL(is_virtio_device);
+
 void unregister_virtio_device(struct virtio_device *dev)
 {
 =09int index =3D dev->index; /* save for after device release */
diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_bu=
f.c
new file mode 100644
index 000000000000..fa0d3a668f53
--- /dev/null
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * dma-bufs for virtio exported objects
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#include <linux/virtio_dma_buf.h>
+
+/**
+ * virtio_dma_buf_export - Creates a new dma-buf for a virtio exported obj=
ect
+ * @exp_info: [in] see dma_buf_export(). ops MUST refer to a dma_buf_ops
+ *=09struct embedded in a virtio_dma_buf_ops.
+ *
+ * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
+ * for an virtio exported object that can be queried by other virtio drive=
rs
+ * for the object's UUID.
+ */
+struct dma_buf *virtio_dma_buf_export(
+=09=09const struct dma_buf_export_info *exp_info)
+{
+=09const struct virtio_dma_buf_ops *virtio_ops =3D container_of(
+=09=09=09exp_info->ops, const struct virtio_dma_buf_ops, ops);
+
+=09if (!exp_info->ops
+=09=09|| exp_info->ops->attach !=3D &virtio_dma_buf_attach
+=09=09|| !virtio_ops->get_uuid) {
+=09=09return ERR_PTR(-EINVAL);
+=09}
+
+=09return dma_buf_export(exp_info);
+}
+EXPORT_SYMBOL(virtio_dma_buf_export);
+
+/**
+ * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
+ */
+int virtio_dma_buf_attach(struct dma_buf *dma_buf,
+=09=09=09  struct dma_buf_attachment *attach)
+{
+=09int ret;
+=09const struct virtio_dma_buf_ops *ops =3D container_of(
+=09=09=09dma_buf->ops, const struct virtio_dma_buf_ops, ops);
+
+=09if (ops->device_attach) {
+=09=09ret =3D ops->device_attach(dma_buf, attach);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+=09return 0;
+}
+EXPORT_SYMBOL(virtio_dma_buf_attach);
+
+/**
+ * is_virtio_dma_buf - returns true if the given dma-buf is a virtio dma-b=
uf
+ * @dma_buf: buffer to query
+ */
+bool is_virtio_dma_buf(struct dma_buf *dma_buf)
+{
+=09return dma_buf->ops->attach =3D=3D &virtio_dma_buf_attach;
+}
+EXPORT_SYMBOL(is_virtio_dma_buf);
+
+/**
+ * virtio_dma_buf_get_uuid - gets the uuid of the virtio dma-buf's exporte=
d object
+ * @dma_buf: [in] buffer to query
+ * @uuid: [out] the uuid
+ *
+ * Returns: 0 on success, negative on failure.
+ */
+int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
+=09=09=09    uuid_t *uuid)
+{
+=09const struct virtio_dma_buf_ops *ops =3D container_of(
+=09=09=09dma_buf->ops, const struct virtio_dma_buf_ops, ops);
+
+=09if (!is_virtio_dma_buf(dma_buf))
+=09=09return -EINVAL;
+
+=09return ops->get_uuid(dma_buf, uuid);
+}
+EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a493eac08393..55ea329fe72a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -127,6 +127,7 @@ static inline struct virtio_device *dev_to_virtio(struc=
t device *_dev)
 void virtio_add_status(struct virtio_device *dev, unsigned int status);
 int register_virtio_device(struct virtio_device *dev);
 void unregister_virtio_device(struct virtio_device *dev);
+bool is_virtio_device(struct device *dev);
=20
 void virtio_break_device(struct virtio_device *dev);
=20
diff --git a/include/linux/virtio_dma_buf.h b/include/linux/virtio_dma_buf.=
h
new file mode 100644
index 000000000000..394bf04362d7
--- /dev/null
+++ b/include/linux/virtio_dma_buf.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * dma-bufs for virtio exported objects
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#ifndef _LINUX_VIRTIO_DMA_BUF_H
+#define _LINUX_VIRTIO_DMA_BUF_H
+
+#include <linux/dma-buf.h>
+#include <linux/uuid.h>
+#include <linux/virtio.h>
+
+/**
+ * struct virtio_dma_buf_ops - operations possible on exported object dma-=
buf
+ * @ops: the base dma_buf_ops. ops.attach MUST be virtio_dma_buf_attach.
+ * @device_attach: [optional] callback invoked by virtio_dma_buf_attach du=
ring
+ *=09=09   all attach operations.
+ * @get_uid: [required] callback to get the uuid of the exported object.
+ */
+struct virtio_dma_buf_ops {
+=09struct dma_buf_ops ops;
+=09int (*device_attach)(struct dma_buf *dma_buf,
+=09=09=09     struct dma_buf_attachment *attach);
+=09int (*get_uuid)(struct dma_buf *dma_buf, uuid_t *uuid);
+};
+
+int virtio_dma_buf_attach(struct dma_buf *dma_buf,
+=09=09=09  struct dma_buf_attachment *attach);
+
+struct dma_buf *virtio_dma_buf_export(
+=09=09const struct dma_buf_export_info *exp_info);
+bool is_virtio_dma_buf(struct dma_buf *dma_buf);
+int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf, uuid_t *uuid);
+
+#endif /* _LINUX_VIRTIO_DMA_BUF_H */
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

