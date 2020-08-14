Return-Path: virtio-dev-return-7659-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81F949860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:14 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:56 -0700
Message-Id: <20200814024000.2485-21-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 20/24] drm/virtio: implement blob resources: refactor UUID code somewhat
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

For upcoming blob resources, userspace can specify that the
resource will be used for cross-device sharing. This is mainly
for exportable blobs that will only shared with the virtgpu
display but not across devices.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 42 ++++++++++++++++++--------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index fe9bb95a408b..71c2ea2e3c83 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -430,6 +430,8 @@ bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo);
 int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 =09=09=09       uint32_t *resid);
 /* virtgpu_prime.c */
+int virtio_gpu_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object *bo);
 struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
 =09=09=09=09=09 int flags);
 struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virti=
o/virtgpu_prime.c
index 3552db128ba3..1ef1e2f22633 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -59,6 +59,24 @@ const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =3D  =
{
 =09.get_uuid =3D virtgpu_virtio_get_uuid,
 };
=20
+int virtio_gpu_resource_assign_uuid(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object *bo)
+{
+=09int ret;
+=09struct virtio_gpu_object_array *objs;
+
+=09objs =3D virtio_gpu_array_alloc(1);
+=09if (!objs)
+=09=09return -ENOMEM;
+
+=09virtio_gpu_array_add_obj(objs, &bo->base.base);
+=09ret =3D virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
+=09if (ret)
+=09=09return ret;
+
+=09return 0;
+}
+
 struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
 =09=09=09=09=09 int flags)
 {
@@ -66,22 +84,20 @@ struct dma_buf *virtgpu_gem_prime_export(struct drm_gem=
_object *obj,
 =09struct drm_device *dev =3D obj->dev;
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
 =09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
-=09struct virtio_gpu_object_array *objs;
 =09int ret =3D 0;
+=09bool blob =3D bo->host3d_blob || bo->guest_blob;
 =09DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
=20
-=09if (vgdev->has_resource_assign_uuid) {
-=09=09objs =3D virtio_gpu_array_alloc(1);
-=09=09if (!objs)
-=09=09=09return ERR_PTR(-ENOMEM);
-=09=09virtio_gpu_array_add_obj(objs, &bo->base.base);
-
-=09=09ret =3D virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
-=09=09if (ret)
-=09=09=09return ERR_PTR(ret);
-=09=09virtio_gpu_notify(vgdev);
-=09} else {
-=09=09bo->uuid_state =3D STATE_ERR;
+=09if (!blob) {
+=09=09if (vgdev->has_resource_assign_uuid) {
+=09=09=09ret =3D virtio_gpu_resource_assign_uuid(vgdev, bo);
+=09=09=09if (ret)
+=09=09=09=09return ERR_PTR(ret);
+
+=09=09=09virtio_gpu_notify(vgdev);
+=09=09} else {
+=09=09=09bo->uuid_state =3D STATE_ERR;
+=09=09}
 =09}
=20
 =09exp_info.ops =3D &virtgpu_dmabuf_ops.ops;
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

