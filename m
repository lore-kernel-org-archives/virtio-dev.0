Return-Path: virtio-dev-return-7662-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CD169860C7
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:14 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:59 -0700
Message-Id: <20200814024000.2485-24-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 23/24] drm/virtio: implement blob resources: resource create blob ioctl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Implement resource create blob as specified.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Co-developed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |   4 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 136 ++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_object.c |   5 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c   |   2 +
 4 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 444b65c8d4ee..3e9ec5b1fb63 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -255,8 +255,8 @@ struct virtio_gpu_fpriv {
 =09struct mutex context_lock;
 };
=20
-/* virtgpu_ioctl.c */
-#define DRM_VIRTIO_NUM_IOCTLS 10
+/* virtio_ioctl.c */
+#define DRM_VIRTIO_NUM_IOCTLS 11
 extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
 void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *fi=
le);
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 7dbe24248a20..47ac32b7031a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -34,6 +34,10 @@
=20
 #include "virtgpu_drv.h"
=20
+#define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
+=09=09=09=09    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
+=09=09=09=09    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+
 void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *fi=
le)
 {
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
@@ -520,6 +524,134 @@ static int virtio_gpu_get_caps_ioctl(struct drm_devic=
e *dev,
 =09return 0;
 }
=20
+static int verify_blob(struct virtio_gpu_device *vgdev,
+=09=09       struct virtio_gpu_fpriv *vfpriv,
+=09=09       struct virtio_gpu_object_params *params,
+=09=09       struct drm_virtgpu_resource_create_blob *rc_blob,
+=09=09       bool *guest_blob, bool *host3d_blob)
+{
+=09if (!vgdev->has_resource_blob)
+=09=09return -EINVAL;
+
+=09if ((rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK) ||
+=09    !rc_blob->blob_flags)
+=09=09return -EINVAL;
+
+=09if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
+=09=09if (!vgdev->has_resource_assign_uuid)
+=09=09=09return -EINVAL;
+=09}
+
+=09switch (rc_blob->blob_mem) {
+=09case VIRTGPU_BLOB_MEM_GUEST:
+=09=09*guest_blob =3D true;
+=09=09break;
+=09case VIRTGPU_BLOB_MEM_HOST3D_GUEST:
+=09=09*guest_blob =3D true;
+=09=09fallthrough;
+=09case VIRTGPU_BLOB_MEM_HOST3D:
+=09=09*host3d_blob =3D true;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09if (*host3d_blob) {
+=09=09if (!vgdev->has_virgl_3d)
+=09=09=09return -EINVAL;
+
+=09=09/* Must be dword aligned. */
+=09=09if ((rc_blob->cmd_size) % 4 !=3D 0)
+=09=09=09return -EINVAL;
+
+=09=09params->ctx_id =3D vfpriv->ctx_id;
+=09=09params->blob_id =3D rc_blob->blob_id;
+=09} else {
+=09=09if (rc_blob->blob_id !=3D 0)
+=09=09=09return -EINVAL;
+
+=09=09if (rc_blob->cmd_size !=3D 0)
+=09=09=09return -EINVAL;
+=09}
+
+=09params->blob_mem =3D rc_blob->blob_mem;
+=09params->size =3D rc_blob->size;
+=09params->blob =3D true;
+=09params->blob_flags =3D rc_blob->blob_flags;
+=09return 0;
+}
+
+static int virtio_gpu_resource_create_blob(struct drm_device *dev,
+=09=09=09=09=09   void *data, struct drm_file *file)
+{
+=09int ret =3D 0;
+=09uint32_t handle =3D 0;
+=09struct drm_gem_object *obj;
+=09struct virtio_gpu_object *bo;
+=09bool host3d_blob, guest_blob;
+=09struct virtio_gpu_object_params params =3D { 0 };
+=09struct virtio_gpu_device *vgdev =3D dev->dev_private;
+=09struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
+=09struct drm_virtgpu_resource_create_blob *rc_blob =3D data;
+
+=09guest_blob =3D host3d_blob =3D false;
+=09if (verify_blob(vgdev, vfpriv, &params, rc_blob,
+=09=09=09&guest_blob, &host3d_blob))
+=09=09return -EINVAL;
+
+=09if (vgdev->has_virgl_3d)
+=09=09virtio_gpu_create_context(dev, file);
+
+=09if (rc_blob->cmd_size) {
+=09=09void *buf;
+
+=09=09buf =3D memdup_user(u64_to_user_ptr(rc_blob->cmd),
+=09=09=09=09  rc_blob->cmd_size);
+
+=09=09if (IS_ERR(buf))
+=09=09=09return PTR_ERR(buf);
+
+=09=09virtio_gpu_cmd_submit(vgdev, buf, rc_blob->cmd_size,
+=09=09=09=09      vfpriv->ctx_id, NULL, NULL);
+=09}
+
+=09if (guest_blob)
+=09=09ret =3D virtio_gpu_object_create(vgdev, &params, &bo, NULL);
+=09else if (!guest_blob && host3d_blob)
+=09=09ret =3D virtio_gpu_vram_create(vgdev, &params, &bo);
+=09else
+=09=09return -EINVAL;
+
+=09if (ret < 0)
+=09=09return ret;
+
+=09bo->guest_blob =3D guest_blob;
+=09bo->host3d_blob =3D host3d_blob;
+=09bo->blob_mem =3D rc_blob->blob_mem;
+=09bo->blob_flags =3D rc_blob->blob_flags;
+
+=09obj =3D &bo->base.base;
+=09if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
+=09=09ret =3D virtio_gpu_resource_assign_uuid(vgdev, bo);
+=09=09if (ret) {
+=09=09=09drm_gem_object_release(obj);
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09ret =3D drm_gem_handle_create(file, obj, &handle);
+=09if (ret) {
+=09=09drm_gem_object_release(obj);
+=09=09return ret;
+=09}
+=09drm_gem_object_put(obj);
+
+=09rc_blob->res_handle =3D bo->hw_res_handle;
+=09rc_blob->bo_handle =3D handle;
+
+=09return 0;
+}
+
 struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] =3D {
 =09DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
 =09=09=09  DRM_RENDER_ALLOW),
@@ -552,4 +684,8 @@ struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_=
IOCTLS] =3D {
=20
 =09DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
 =09=09=09  DRM_RENDER_ALLOW),
+
+=09DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE_BLOB,
+=09=09=09  virtio_gpu_resource_create_blob,
+=09=09=09  DRM_RENDER_ALLOW),
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index 432b9985ef2e..43f383946a7d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -244,7 +244,10 @@ int virtio_gpu_object_create(struct virtio_gpu_device =
*vgdev,
 =09=09return ret;
 =09}
=20
-=09if (params->virgl) {
+=09if (params->blob) {
+=09=09virtio_gpu_cmd_resource_create_blob(vgdev, bo, params,
+=09=09=09=09=09=09    ents, nents);
+=09} else if (params->virgl) {
 =09=09virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
 =09=09=09=09=09=09  objs, fence);
 =09=09virtio_gpu_object_attach(vgdev, bo, ents, nents);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio=
/virtgpu_vram.c
index 3e7e29e56781..d8ea11bd07fe 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -149,6 +149,8 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vg=
dev,
 =09=09return ret;
 =09}
=20
+=09virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
+=09=09=09=09=09    0);
 =09if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
 =09=09ret =3D virtio_gpu_vram_map(&vram->base);
 =09=09if (ret) {
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

