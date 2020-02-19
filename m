Return-Path: virtio-dev-return-6761-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF454985EA9
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Feb 2020 08:08:33 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 19 Feb 2020 17:06:37 +0900
Message-Id: <20200219080637.61312-3-stevensd@chromium.org>
In-Reply-To: <20200219080637.61312-1-stevensd@chromium.org>
References: <20200219080637.61312-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 2/2] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Add support for exported resources to virtgpu. This includes adding
support for the new virtgpu command as well as well as switching from
regular prime dma-bufs to virtio dma-bufs.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |   3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  21 +++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |   4 +
 drivers/gpu/drm/virtio/virtgpu_prime.c | 109 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  58 +++++++++++++
 include/uapi/linux/virtio_gpu.h        |  19 +++++
 6 files changed, 211 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c
index ab4bed78e656..538ed981fea9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -165,6 +165,7 @@ static unsigned int features[] =3D {
 =09VIRTIO_GPU_F_VIRGL,
 #endif
 =09VIRTIO_GPU_F_EDID,
+=09VIRTIO_GPU_F_CROSS_DEVICE,
 };
 static struct virtio_driver virtio_gpu_driver =3D {
 =09.feature_table =3D features,
@@ -201,6 +202,8 @@ static struct drm_driver driver =3D {
 #endif
 =09.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
 =09.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
+=09.gem_prime_export =3D virtgpu_gem_prime_export,
+=09.gem_prime_import =3D virtgpu_gem_prime_import,
 =09.gem_prime_mmap =3D drm_gem_prime_mmap,
 =09.gem_prime_import_sg_table =3D virtgpu_gem_prime_import_sg_table,
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index af9403e1cf78..0d272fc26bf2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -27,6 +27,7 @@
 #define VIRTIO_DRV_H
=20
 #include <linux/virtio.h>
+#include <linux/virtio_dma_buf.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_gpu.h>
@@ -49,6 +50,11 @@
 #define DRIVER_MINOR 1
 #define DRIVER_PATCHLEVEL 0
=20
+#define UUID_NOT_INITIALIZED 0
+#define UUID_INITIALIZING 1
+#define UUID_INITIALIZED 2
+#define UUID_INITIALIZATION_FAILED 3
+
 struct virtio_gpu_object_params {
 =09uint32_t format;
 =09uint32_t width;
@@ -75,6 +81,9 @@ struct virtio_gpu_object {
=20
 =09bool dumb;
 =09bool created;
+
+=09int uuid_state;
+=09uuid_t uuid;
 };
 #define gem_to_virtio_gpu_obj(gobj) \
 =09container_of((gobj), struct virtio_gpu_object, base.base)
@@ -196,6 +205,7 @@ struct virtio_gpu_device {
 =09bool has_virgl_3d;
 =09bool has_edid;
 =09bool has_indirect;
+=09bool has_resource_assign_uuid;
=20
 =09struct work_struct config_changed_work;
=20
@@ -206,6 +216,8 @@ struct virtio_gpu_device {
 =09struct virtio_gpu_drv_capset *capsets;
 =09uint32_t num_capsets;
 =09struct list_head cap_cache;
+
+=09spinlock_t resource_export_lock;
 };
=20
 struct virtio_gpu_fpriv {
@@ -338,6 +350,10 @@ void virtio_gpu_dequeue_fence_func(struct work_struct =
*work);
 void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev);
 void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev);
=20
+int
+virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object *bo);
+
 /* virtio_gpu_display.c */
 void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
@@ -366,6 +382,11 @@ int virtio_gpu_object_create(struct virtio_gpu_device =
*vgdev,
 =09=09=09     struct virtio_gpu_object **bo_ptr,
 =09=09=09     struct virtio_gpu_fence *fence);
 /* virtgpu_prime.c */
+extern const struct virtio_dma_buf_ops virtgpu_dmabuf_ops;
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+=09=09=09=09=09 int flags);
+struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
+=09=09=09=09=09=09struct dma_buf *buf);
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 =09struct drm_device *dev, struct dma_buf_attachment *attach,
 =09struct sg_table *sgt);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 4009c2f97d08..be9719fb457b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -134,6 +134,7 @@ int virtio_gpu_init(struct drm_device *dev)
 =09vgdev->dev =3D dev->dev;
=20
 =09spin_lock_init(&vgdev->display_info_lock);
+=09spin_lock_init(&vgdev->resource_export_lock);
 =09ida_init(&vgdev->ctx_id_ida);
 =09ida_init(&vgdev->resource_ida);
 =09init_waitqueue_head(&vgdev->resp_wq);
@@ -159,6 +160,9 @@ int virtio_gpu_init(struct drm_device *dev)
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 =09=09vgdev->has_edid =3D true;
 =09}
+=09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_CROSS_DEVICE)) {
+=09=09vgdev->has_resource_assign_uuid =3D true;
+=09}
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
 =09=09vgdev->has_indirect =3D true;
 =09}
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virti=
o/virtgpu_prime.c
index 050d24c39a8f..667cd4e45bfd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -22,13 +22,116 @@
  * Authors: Andreas Pokorny
  */
=20
+#include <drm/drm_drv.h>
 #include <drm/drm_prime.h>
=20
+#include <linux/dma-buf.h>
+#include <linux/virtio_dma_buf.h>
+
 #include "virtgpu_drv.h"
=20
-/* Empty Implementations as there should not be any other driver for a vir=
tual
- * device that might share buffers with virtgpu
- */
+static int virtgpu_virtio_get_uuid(struct dma_buf *buf,
+=09=09=09=09   uuid_t *uuid)
+{
+=09struct drm_gem_object *obj =3D buf->priv;
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
+=09struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
+
+=09if (bo->uuid_state =3D=3D UUID_NOT_INITIALIZED)
+=09=09return -ENODEV;
+
+=09wait_event(vgdev->resp_wq, bo->uuid_state !=3D UUID_INITIALIZING);
+=09if (bo->uuid_state =3D=3D UUID_INITIALIZATION_FAILED)
+=09=09return -ENODEV;
+
+=09uuid_copy(uuid, &bo->uuid);
+
+=09return 0;
+}
+
+int virtgpu_virtio_attach(struct dma_buf *buf,
+=09=09=09  struct dma_buf_attachment *attach)
+{
+=09struct drm_gem_object *obj =3D buf->priv;
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
+=09struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
+=09bool needs_init =3D false;
+=09int ret =3D 0;
+
+=09if (!vgdev->has_resource_assign_uuid)
+=09=09return 0;
+
+=09spin_lock(&vgdev->resource_export_lock);
+=09if (bo->uuid_state =3D=3D UUID_NOT_INITIALIZED) {
+=09=09bo->uuid_state =3D UUID_INITIALIZING;
+=09=09needs_init =3D true;
+=09}
+=09spin_unlock(&vgdev->resource_export_lock);
+
+=09if (needs_init)
+=09=09ret =3D virtio_gpu_cmd_resource_assign_uuid(vgdev, bo);
+=09return ret;
+}
+
+const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =3D  {
+=09.ops =3D {
+=09=09.cache_sgt_mapping =3D true,
+=09=09.attach =3D virtio_dma_buf_attach,
+=09=09.detach =3D drm_gem_map_detach,
+=09=09.map_dma_buf =3D drm_gem_map_dma_buf,
+=09=09.unmap_dma_buf =3D drm_gem_unmap_dma_buf,
+=09=09.release =3D drm_gem_dmabuf_release,
+=09=09.mmap =3D drm_gem_dmabuf_mmap,
+=09=09.vmap =3D drm_gem_dmabuf_vmap,
+=09=09.vunmap =3D drm_gem_dmabuf_vunmap,
+=09},
+=09.virtio_attach =3D virtgpu_virtio_attach,
+=09.device_attach =3D drm_gem_map_attach,
+=09.get_uuid =3D virtgpu_virtio_get_uuid,
+};
+
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+=09=09=09=09=09 int flags)
+{
+=09struct dma_buf *buf;
+=09struct drm_device *dev =3D obj->dev;
+=09DEFINE_VIRTIO_DMA_BUF_EXPORT_INFO(exp_info);
+
+=09exp_info.ops =3D &virtgpu_dmabuf_ops;
+=09exp_info.size =3D obj->size;
+=09exp_info.flags =3D flags;
+=09exp_info.priv =3D obj;
+=09exp_info.resv =3D obj->resv;
+
+=09buf =3D virtio_dma_buf_export(&exp_info);
+=09if (IS_ERR(buf))
+=09=09return buf;
+
+=09drm_dev_get(dev);
+=09drm_gem_object_get(obj);
+
+=09return buf;
+}
+
+struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
+=09=09=09=09=09=09struct dma_buf *buf)
+{
+=09struct drm_gem_object *obj;
+
+=09if (buf->ops =3D=3D &virtgpu_dmabuf_ops.ops) {
+=09=09obj =3D buf->priv;
+=09=09if (obj->dev =3D=3D dev) {
+=09=09=09/*
+=09=09=09 * Importing dmabuf exported from our own gem increases
+=09=09=09 * refcount on gem itself instead of f_count of dmabuf.
+=09=09=09 */
+=09=09=09drm_gem_object_get(obj);
+=09=09=09return obj;
+=09=09}
+=09}
+
+=09return drm_gem_prime_import(dev, buf);
+}
=20
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 =09struct drm_device *dev, struct dma_buf_attachment *attach,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index cfe9c54f87a3..e9e7b1f885f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1111,3 +1111,61 @@ void virtio_gpu_cursor_ping(struct virtio_gpu_device=
 *vgdev,
 =09memcpy(cur_p, &output->cursor, sizeof(output->cursor));
 =09virtio_gpu_queue_cursor(vgdev, vbuf);
 }
+
+static void virtio_gpu_cmd_resource_assign_uuid_cb(struct virtio_gpu_devic=
e *vgdev,
+=09=09=09=09=09=09   struct virtio_gpu_vbuffer *vbuf)
+{
+=09struct virtio_gpu_resp_resource_assign_uuid *resp =3D
+=09=09(struct virtio_gpu_resp_resource_assign_uuid *)vbuf->resp_buf;
+=09struct virtio_gpu_object *obj =3D
+=09=09(struct virtio_gpu_object *)vbuf->data_buf;
+=09uint32_t resp_type =3D le32_to_cpu(resp->hdr.type);
+
+=09/*
+=09 * Keeps the data_buf, which points to this virtio_gpu_object, from
+=09 * getting kfree'd after this cb returns.
+=09 */
+=09vbuf->data_buf =3D NULL;
+
+=09spin_lock(&vgdev->resource_export_lock);
+=09WARN_ON(obj->uuid_state !=3D UUID_INITIALIZING);
+
+=09if (resp_type =3D=3D VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID &&
+=09=09=09obj->uuid_state =3D=3D UUID_INITIALIZING) {
+=09=09memcpy(&obj->uuid.b, resp->uuid, sizeof(obj->uuid.b));
+=09=09obj->uuid_state =3D UUID_INITIALIZED;
+=09} else {
+=09=09obj->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09}
+=09spin_unlock(&vgdev->resource_export_lock);
+
+=09drm_gem_object_put_unlocked(&obj->base.base);
+=09wake_up_all(&vgdev->resp_wq);
+}
+
+int
+virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object *bo)
+{
+=09struct virtio_gpu_resource_assign_uuid *cmd_p;
+=09struct virtio_gpu_vbuffer *vbuf;
+=09struct virtio_gpu_resp_resource_assign_uuid *resp_buf;
+
+=09resp_buf =3D kzalloc(sizeof(*resp_buf), GFP_KERNEL);
+=09if (!resp_buf)
+=09=09return -ENOMEM;
+
+=09cmd_p =3D virtio_gpu_alloc_cmd_resp(vgdev,
+=09=09virtio_gpu_cmd_resource_assign_uuid_cb, &vbuf, sizeof(*cmd_p),
+=09=09sizeof(struct virtio_gpu_resp_resource_assign_uuid), resp_buf);
+=09memset(cmd_p, 0, sizeof(*cmd_p));
+
+=09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID);
+=09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
+
+=09/* Reuse the data_buf pointer for the object pointer. */
+=09vbuf->data_buf =3D bo;
+=09drm_gem_object_get(&bo->base.base);
+=09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+=09return 0;
+}
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gp=
u.h
index 0c85914d9369..9c428ef03060 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -50,6 +50,10 @@
  * VIRTIO_GPU_CMD_GET_EDID
  */
 #define VIRTIO_GPU_F_EDID                1
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
+ */
+#define VIRTIO_GPU_F_CROSS_DEVICE        2
=20
 enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_UNDEFINED =3D 0,
@@ -66,6 +70,7 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 =09VIRTIO_GPU_CMD_GET_CAPSET,
 =09VIRTIO_GPU_CMD_GET_EDID,
+=09VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
=20
 =09/* 3d commands */
 =09VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
@@ -87,6 +92,7 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 =09VIRTIO_GPU_RESP_OK_CAPSET,
 =09VIRTIO_GPU_RESP_OK_EDID,
+=09VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID,
=20
 =09/* error responses */
 =09VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
@@ -340,4 +346,17 @@ enum virtio_gpu_formats {
 =09VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  =3D 134,
 };
=20
+/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
+struct virtio_gpu_resource_assign_uuid {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__le32 resource_id;
+=09__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID */
+struct virtio_gpu_resp_resource_assign_uuid {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__u8 uuid[16];
+};
+
 #endif
--=20
2.25.0.265.gbab2e86ba0-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

