Return-Path: virtio-dev-return-6919-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E6DD985FDD
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 11:20:40 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 11 Mar 2020 20:20:04 +0900
Message-Id: <20200311112004.47138-5-stevensd@chromium.org>
In-Reply-To: <20200311112004.47138-1-stevensd@chromium.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Add support for UUID-based resource sharing mechanism to virtgpu. This
implements the new virtgpu commands and hooks them up to dma-buf's
get_uuid callback.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 ++
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 18 +++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 41 +++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 ++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c
index ab4bed78e656..776e6667042e 100644
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
@@ -202,7 +203,9 @@ static struct drm_driver driver =3D {
 =09.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
 =09.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
 =09.gem_prime_mmap =3D drm_gem_prime_mmap,
+=09.gem_prime_export =3D virtgpu_gem_prime_export,
 =09.gem_prime_import_sg_table =3D virtgpu_gem_prime_import_sg_table,
+=09.gem_prime_get_uuid =3D virtgpu_gem_prime_get_uuid,
=20
 =09.gem_create_object =3D virtio_gpu_create_object,
 =09.fops =3D &virtio_gpu_driver_fops,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index af9403e1cf78..fab65f0f5a4d 100644
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
@@ -75,6 +79,9 @@ struct virtio_gpu_object {
=20
 =09bool dumb;
 =09bool created;
+
+=09int uuid_state;
+=09uuid_t uuid;
 };
 #define gem_to_virtio_gpu_obj(gobj) \
 =09container_of((gobj), struct virtio_gpu_object, base.base)
@@ -196,6 +203,7 @@ struct virtio_gpu_device {
 =09bool has_virgl_3d;
 =09bool has_edid;
 =09bool has_indirect;
+=09bool has_resource_assign_uuid;
=20
 =09struct work_struct config_changed_work;
=20
@@ -206,6 +214,8 @@ struct virtio_gpu_device {
 =09struct virtio_gpu_drv_capset *capsets;
 =09uint32_t num_capsets;
 =09struct list_head cap_cache;
+
+=09spinlock_t resource_export_lock;
 };
=20
 struct virtio_gpu_fpriv {
@@ -338,6 +348,10 @@ void virtio_gpu_dequeue_fence_func(struct work_struct =
*work);
 void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev);
 void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev);
=20
+int
+virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object_array *objs);
+
 /* virtio_gpu_display.c */
 void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
@@ -366,6 +380,10 @@ int virtio_gpu_object_create(struct virtio_gpu_device =
*vgdev,
 =09=09=09     struct virtio_gpu_object **bo_ptr,
 =09=09=09     struct virtio_gpu_fence *fence);
 /* virtgpu_prime.c */
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+=09=09=09=09=09 int flags);
+int virtgpu_gem_prime_get_uuid(struct drm_gem_object *obj,
+=09=09=09       uuid_t *uuid);
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 =09struct drm_device *dev, struct dma_buf_attachment *attach,
 =09struct sg_table *sgt);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 4009c2f97d08..5a2aeb6d2f35 100644
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
@@ -162,6 +163,9 @@ int virtio_gpu_init(struct drm_device *dev)
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
index 050d24c39a8f..7c6357f59877 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -26,9 +26,44 @@
=20
 #include "virtgpu_drv.h"
=20
-/* Empty Implementations as there should not be any other driver for a vir=
tual
- * device that might share buffers with virtgpu
- */
+int virtgpu_gem_prime_get_uuid(struct drm_gem_object *obj,
+=09=09=09       uuid_t *uuid)
+{
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
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+=09=09=09=09=09 int flags)
+{
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
+=09struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
+=09struct virtio_gpu_object_array *objs;
+=09int ret =3D 0;
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
+=09} else {
+=09=09bo->uuid_state =3D UUID_INITIALIZATION_FAILED;
+  }
+
+=09return drm_gem_prime_export(obj, flags);
+}
=20
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 =09struct drm_device *dev, struct dma_buf_attachment *attach,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index cfe9c54f87a3..b968eaa46bb0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1111,3 +1111,58 @@ void virtio_gpu_cursor_ping(struct virtio_gpu_device=
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
2.25.1.481.gfbce0eb801-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

