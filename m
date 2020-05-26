Return-Path: virtio-dev-return-7397-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E534C985B46
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 May 2020 10:59:32 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Tue, 26 May 2020 19:58:09 +0900
Message-Id: <20200526105811.30784-2-stevensd@chromium.org>
In-Reply-To: <20200526105811.30784-1-stevensd@chromium.org>
References: <20200526105811.30784-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 1/3] virtio: add dma-buf support for exported objects
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This change adds a new flavor of dma-bufs that can be used by virtio
drivers to share exported objects. A virtio dma-buf can be queried by
virtio drivers to obtain the UUID which identifies the underlying
exported object.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/Makefile         |  2 +-
 drivers/virtio/virtio.c         |  6 +++
 drivers/virtio/virtio_dma_buf.c | 89 +++++++++++++++++++++++++++++++++
 include/linux/virtio.h          |  1 +
 include/linux/virtio_dma_buf.h  | 58 +++++++++++++++++++++
 5 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 29a1386ecc03..ecdae5b596de 100644
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
index 000000000000..23e3399b11ed
--- /dev/null
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -0,0 +1,89 @@
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
+ *
+ * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
+ * for an virtio exported object that can be queried by other virtio drive=
rs
+ * for the object's UUID.
+ */
+struct dma_buf *virtio_dma_buf_export(
+=09=09const struct virtio_dma_buf_export_info *virtio_exp_info)
+{
+=09struct dma_buf_export_info exp_info;
+
+=09if (!virtio_exp_info->ops
+=09=09|| virtio_exp_info->ops->ops.attach !=3D &virtio_dma_buf_attach
+=09=09|| !virtio_exp_info->ops->get_uuid) {
+=09=09return ERR_PTR(-EINVAL);
+=09}
+
+=09exp_info.exp_name =3D virtio_exp_info->exp_name;
+=09exp_info.owner =3D virtio_exp_info->owner;
+=09exp_info.ops =3D &virtio_exp_info->ops->ops;
+=09exp_info.size =3D virtio_exp_info->size;
+=09exp_info.flags =3D virtio_exp_info->flags;
+=09exp_info.resv =3D virtio_exp_info->resv;
+=09exp_info.priv =3D virtio_exp_info->priv;
+=09BUILD_BUG_ON(sizeof(struct virtio_dma_buf_export_info)
+=09=09     !=3D sizeof(struct dma_buf_export_info));
+
+=09return dma_buf_export(&exp_info);
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
index 15f906e4a748..9397e25616c4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -128,6 +128,7 @@ static inline struct virtio_device *dev_to_virtio(struc=
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
index 000000000000..29fee167afbd
--- /dev/null
+++ b/include/linux/virtio_dma_buf.h
@@ -0,0 +1,58 @@
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
+/**
+ * struct virtio_dma_buf_export_info - see struct dma_buf_export_info
+ */
+struct virtio_dma_buf_export_info {
+=09const char *exp_name;
+=09struct module *owner;
+=09const struct virtio_dma_buf_ops *ops;
+=09size_t size;
+=09int flags;
+=09struct dma_resv *resv;
+=09void *priv;
+};
+
+/**
+ * DEFINE_VIRTIO_DMA_BUF_EXPORT_INFO - helper macro for exporters
+ */
+#define DEFINE_VIRTIO_DMA_BUF_EXPORT_INFO(name)=09\
+=09struct virtio_dma_buf_export_info name =3D { \
+=09=09.exp_name =3D KBUILD_MODNAME, \
+=09=09.owner =3D THIS_MODULE }
+
+int virtio_dma_buf_attach(struct dma_buf *dma_buf,
+=09=09=09  struct dma_buf_attachment *attach);
+
+struct dma_buf *virtio_dma_buf_export(
+=09=09const struct virtio_dma_buf_export_info *virtio_exp_info);
+bool is_virtio_dma_buf(struct dma_buf *dma_buf);
+int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf, uuid_t *uuid);
+
+#endif /* _LINUX_VIRTIO_DMA_BUF_H */
--=20
2.27.0.rc0.183.gde8f92d652-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

