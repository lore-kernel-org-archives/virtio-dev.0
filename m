Return-Path: virtio-dev-return-7399-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 657E7985B46
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 May 2020 10:59:43 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Tue, 26 May 2020 19:58:11 +0900
Message-Id: <20200526105811.30784-4-stevensd@chromium.org>
In-Reply-To: <20200526105811.30784-1-stevensd@chromium.org>
References: <20200526105811.30784-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 3/3] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Add support for UUID-based resource sharing mechanism to virtgpu. This
implements the new virtgpu commands and hooks them up to dma-buf's
get_uuid callback.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 20 ++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 96 +++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 +++++++++++++++
 5 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c
index ab4bed78e656..b039f493bda9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -165,6 +165,7 @@ static unsigned int features[] =3D {
 =09VIRTIO_GPU_F_VIRGL,
 #endif
 =09VIRTIO_GPU_F_EDID,
+=09VIRTIO_GPU_F_RESOURCE_UUID,
 };
 static struct virtio_driver virtio_gpu_driver =3D {
 =09.feature_table =3D features,
@@ -202,6 +203,8 @@ static struct drm_driver driver =3D {
 =09.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
 =09.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
 =09.gem_prime_mmap =3D drm_gem_prime_mmap,
+=09.gem_prime_export =3D virtgpu_gem_prime_export,
+=09.gem_prime_import =3D virtgpu_gem_prime_import,
 =09.gem_prime_import_sg_table =3D virtgpu_gem_prime_import_sg_table,
=20
 =09.gem_create_object =3D virtio_gpu_create_object,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 49bebdee6d91..39dc907aa805 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -49,6 +49,10 @@
 #define DRIVER_MINOR 1
 #define DRIVER_PATCHLEVEL 0
=20
+#define UUID_INITIALIZING 0
+#define UUID_INITIALIZED 1
+#define UUID_INITIALIZATION_FAILED 2
+
 struct virtio_gpu_object_params {
 =09uint32_t format;
 =09uint32_t width;
@@ -71,6 +75,9 @@ struct virtio_gpu_object {
 =09uint32_t hw_res_handle;
 =09bool dumb;
 =09bool created;
+
+=09int uuid_state;
+=09uuid_t uuid;
 };
 #define gem_to_virtio_gpu_obj(gobj) \
 =09container_of((gobj), struct virtio_gpu_object, base.base)
@@ -200,6 +207,7 @@ struct virtio_gpu_device {
 =09bool has_virgl_3d;
 =09bool has_edid;
 =09bool has_indirect;
+=09bool has_resource_assign_uuid;
=20
 =09struct work_struct config_changed_work;
=20
@@ -210,6 +218,8 @@ struct virtio_gpu_device {
 =09struct virtio_gpu_drv_capset *capsets;
 =09uint32_t num_capsets;
 =09struct list_head cap_cache;
+
+=09spinlock_t resource_export_lock;
 };
=20
 struct virtio_gpu_fpriv {
@@ -335,6 +345,10 @@ void virtio_gpu_dequeue_fence_func(struct work_struct =
*work);
=20
 void virtio_gpu_notify(struct virtio_gpu_device *vgdev);
=20
+int
+virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object_array *objs);
+
 /* virtgpu_display.c */
 void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
@@ -366,6 +380,12 @@ int virtio_gpu_object_create(struct virtio_gpu_device =
*vgdev,
 bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo);
=20
 /* virtgpu_prime.c */
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+=09=09=09=09=09 int flags);
+struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
+=09=09=09=09=09=09struct dma_buf *buf);
+int virtgpu_gem_prime_get_uuid(struct drm_gem_object *obj,
+=09=09=09       uuid_t *uuid);
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 =09struct drm_device *dev, struct dma_buf_attachment *attach,
 =09struct sg_table *sgt);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 023a030ca7b9..7bcd0c75effa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -125,6 +125,7 @@ int virtio_gpu_init(struct drm_device *dev)
 =09vgdev->dev =3D dev->dev;
=20
 =09spin_lock_init(&vgdev->display_info_lock);
+=09spin_lock_init(&vgdev->resource_export_lock);
 =09ida_init(&vgdev->ctx_id_ida);
 =09ida_init(&vgdev->resource_ida);
 =09init_waitqueue_head(&vgdev->resp_wq);
@@ -153,6 +154,9 @@ int virtio_gpu_init(struct drm_device *dev)
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
 =09=09vgdev->has_indirect =3D true;
 =09}
+=09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
+=09=09vgdev->has_resource_assign_uuid =3D true;
+=09}
=20
 =09DRM_INFO("features: %cvirgl %cedid\n",
 =09=09 vgdev->has_virgl_3d ? '+' : '-',
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virti=
o/virtgpu_prime.c
index 050d24c39a8f..a753bb70fcf1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -23,12 +23,102 @@
  */
=20
 #include <drm/drm_prime.h>
+#include <linux/virtio_dma_buf.h>
=20
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
+=09wait_event(vgdev->resp_wq, bo->uuid_state !=3D UUID_INITIALIZING);
+=09if (bo->uuid_state !=3D UUID_INITIALIZED)
+=09=09return -ENODEV;
+
+=09uuid_copy(uuid, &bo->uuid);
+
+=09return 0;
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
+=09.device_attach =3D drm_gem_map_attach,
+=09.get_uuid =3D virtgpu_virtio_get_uuid,
+};
+
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+=09=09=09=09=09 int flags)
+{
+=09struct dma_buf *buf;
+=09struct drm_device *dev =3D obj->dev;
+=09struct virtio_gpu_device *vgdev =3D dev->dev_private;
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
+=09struct virtio_gpu_object_array *objs;
+=09int ret =3D 0;
+=09DEFINE_VIRTIO_DMA_BUF_EXPORT_INFO(exp_info);
+
+=09if (vgdev->has_resource_assign_uuid) {
+=09=09objs =3D virtio_gpu_array_alloc(1);
+=09=09if (!objs)
+=09=09=09return ERR_PTR(-ENOMEM);
+=09=09virtio_gpu_array_add_obj(objs, &bo->base.base);
+
+=09=09ret =3D virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
+=09=09if (ret)
+=09=09=09return ERR_PTR(ret);
+=09=09virtio_gpu_notify(vgdev);
+=09} else {
+=09=09bo->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09}
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
index 9e663a5d9952..55af6fc7bc7c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1107,3 +1107,58 @@ void virtio_gpu_cursor_ping(struct virtio_gpu_device=
 *vgdev,
 =09memcpy(cur_p, &output->cursor, sizeof(output->cursor));
 =09virtio_gpu_queue_cursor(vgdev, vbuf);
 }
+
+static void virtio_gpu_cmd_resource_uuid_cb(struct virtio_gpu_device *vgde=
v,
+=09=09=09=09=09    struct virtio_gpu_vbuffer *vbuf)
+{
+=09struct virtio_gpu_object *obj =3D
+=09=09gem_to_virtio_gpu_obj(vbuf->objs->objs[0]);
+=09struct virtio_gpu_resp_resource_uuid *resp =3D
+=09=09(struct virtio_gpu_resp_resource_uuid *)vbuf->resp_buf;
+=09uint32_t resp_type =3D le32_to_cpu(resp->hdr.type);
+
+=09spin_lock(&vgdev->resource_export_lock);
+=09WARN_ON(obj->uuid_state !=3D UUID_INITIALIZING);
+
+=09if (resp_type =3D=3D VIRTIO_GPU_RESP_OK_RESOURCE_UUID &&
+=09=09=09obj->uuid_state =3D=3D UUID_INITIALIZING) {
+=09=09memcpy(&obj->uuid.b, resp->uuid, sizeof(obj->uuid.b));
+=09=09obj->uuid_state =3D UUID_INITIALIZED;
+=09} else {
+=09=09obj->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09}
+=09spin_unlock(&vgdev->resource_export_lock);
+
+=09wake_up_all(&vgdev->resp_wq);
+}
+
+int
+virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object_array *objs)
+{
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(objs->objs[0]);
+=09struct virtio_gpu_resource_assign_uuid *cmd_p;
+=09struct virtio_gpu_vbuffer *vbuf;
+=09struct virtio_gpu_resp_resource_uuid *resp_buf;
+
+=09resp_buf =3D kzalloc(sizeof(*resp_buf), GFP_KERNEL);
+=09if (!resp_buf) {
+=09=09spin_lock(&vgdev->resource_export_lock);
+=09=09bo->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09=09spin_unlock(&vgdev->resource_export_lock);
+=09=09virtio_gpu_array_put_free(objs);
+=09=09return -ENOMEM;
+=09}
+
+=09cmd_p =3D virtio_gpu_alloc_cmd_resp(vgdev,
+=09=09virtio_gpu_cmd_resource_uuid_cb, &vbuf, sizeof(*cmd_p),
+=09=09sizeof(struct virtio_gpu_resp_resource_uuid), resp_buf);
+=09memset(cmd_p, 0, sizeof(*cmd_p));
+
+=09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID);
+=09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
+
+=09vbuf->objs =3D objs;
+=09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+=09return 0;
+}
--=20
2.27.0.rc0.183.gde8f92d652-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

