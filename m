Return-Path: virtio-dev-return-7661-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F905985F7B
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:14 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:57 -0700
Message-Id: <20200814024000.2485-22-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 21/24] drm/virtio: implement blob resources: fix stride discrepancy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The old transfer ioctls may work on blob resources, and the guest
may have a image view on the blob resources such that the stride is
not equal to width * bytes_per_pixel.

For host-only blobs, we can repurpose the transfer ioctls to synchronize
caches as well.

Also, with seamless Wayland integration between guest/host looking
increasingly attractive, it also makes sense to keep track of
one value for stride.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 35 +++++++++++++++++++++++---
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 14 +++++++++--
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 71c2ea2e3c83..444b65c8d4ee 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -349,12 +349,16 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *=
vgdev,
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09  uint32_t ctx_id,
 =09=09=09=09=09  uint64_t offset, uint32_t level,
+=09=09=09=09=09  uint32_t stride,
+=09=09=09=09=09  uint32_t layer_stride,
 =09=09=09=09=09  struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09  struct virtio_gpu_object_array *objs,
 =09=09=09=09=09  struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09uint32_t ctx_id,
 =09=09=09=09=09uint64_t offset, uint32_t level,
+=09=09=09=09=09uint32_t stride,
+=09=09=09=09=09uint32_t layer_stride,
 =09=09=09=09=09struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09struct virtio_gpu_object_array *objs,
 =09=09=09=09=09struct virtio_gpu_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 7a2430e34e00..0075995a9f5b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -311,6 +311,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct d=
rm_device *dev,
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
 =09struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
 =09struct drm_virtgpu_3d_transfer_from_host *args =3D data;
+=09struct virtio_gpu_object *bo;
 =09struct virtio_gpu_object_array *objs;
 =09struct virtio_gpu_fence *fence;
 =09int ret;
@@ -324,6 +325,17 @@ static int virtio_gpu_transfer_from_host_ioctl(struct =
drm_device *dev,
 =09if (objs =3D=3D NULL)
 =09=09return -ENOENT;
=20
+=09bo =3D gem_to_virtio_gpu_obj(objs->objs[0]);
+=09if (bo->guest_blob && !bo->host3d_blob) {
+=09=09ret =3D -EINVAL;
+=09=09goto err_put_free;
+=09}
+
+=09if (!bo->host3d_blob && (args->stride || args->layer_stride)) {
+=09=09ret =3D -EINVAL;
+=09=09goto err_put_free;
+=09}
+
 =09ret =3D virtio_gpu_array_lock_resv(objs);
 =09if (ret !=3D 0)
 =09=09goto err_put_free;
@@ -333,9 +345,10 @@ static int virtio_gpu_transfer_from_host_ioctl(struct =
drm_device *dev,
 =09=09ret =3D -ENOMEM;
 =09=09goto err_unlock;
 =09}
+
 =09virtio_gpu_cmd_transfer_from_host_3d
-=09=09(vgdev, vfpriv->ctx_id, offset, args->level,
-=09=09 &args->box, objs, fence);
+=09=09(vgdev, vfpriv->ctx_id, offset, args->level, args->stride,
+=09=09 args->layer_stride, &args->box, objs, fence);
 =09dma_fence_put(&fence->f);
 =09virtio_gpu_notify(vgdev);
 =09return 0;
@@ -353,6 +366,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm=
_device *dev, void *data,
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
 =09struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
 =09struct drm_virtgpu_3d_transfer_to_host *args =3D data;
+=09struct virtio_gpu_object *bo;
 =09struct virtio_gpu_object_array *objs;
 =09struct virtio_gpu_fence *fence;
 =09int ret;
@@ -362,6 +376,12 @@ static int virtio_gpu_transfer_to_host_ioctl(struct dr=
m_device *dev, void *data,
 =09if (objs =3D=3D NULL)
 =09=09return -ENOENT;
=20
+=09bo =3D gem_to_virtio_gpu_obj(objs->objs[0]);
+=09if (bo->guest_blob && !bo->host3d_blob) {
+=09=09ret =3D -EINVAL;
+=09=09goto err_put_free;
+=09}
+
 =09if (!vgdev->has_virgl_3d) {
 =09=09virtio_gpu_cmd_transfer_to_host_2d
 =09=09=09(vgdev, offset,
@@ -369,6 +389,12 @@ static int virtio_gpu_transfer_to_host_ioctl(struct dr=
m_device *dev, void *data,
 =09=09=09 objs, NULL);
 =09} else {
 =09=09virtio_gpu_create_context(dev, file);
+
+=09=09if (!bo->host3d_blob && (args->stride || args->layer_stride)) {
+=09=09=09ret =3D -EINVAL;
+=09=09=09goto err_put_free;
+=09=09}
+
 =09=09ret =3D virtio_gpu_array_lock_resv(objs);
 =09=09if (ret !=3D 0)
 =09=09=09goto err_put_free;
@@ -380,8 +406,9 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm=
_device *dev, void *data,
=20
 =09=09virtio_gpu_cmd_transfer_to_host_3d
 =09=09=09(vgdev,
-=09=09=09 vfpriv ? vfpriv->ctx_id : 0, offset,
-=09=09=09 args->level, &args->box, objs, fence);
+=09=09=09 vfpriv ? vfpriv->ctx_id : 0, offset, args->level,
+=09=09=09 args->stride, args->layer_stride, &args->box, objs,
+=09=09=09 fence);
 =09=09dma_fence_put(&fence->f);
 =09}
 =09virtio_gpu_notify(vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index de4356a183d2..78cec150218c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1008,6 +1008,8 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_d=
evice *vgdev,
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09uint32_t ctx_id,
 =09=09=09=09=09uint64_t offset, uint32_t level,
+=09=09=09=09=09uint32_t stride,
+=09=09=09=09=09uint32_t layer_stride,
 =09=09=09=09=09struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09struct virtio_gpu_object_array *objs,
 =09=09=09=09=09struct virtio_gpu_fence *fence)
@@ -1016,12 +1018,14 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virt=
io_gpu_device *vgdev,
 =09struct virtio_gpu_transfer_host_3d *cmd_p;
 =09struct virtio_gpu_vbuffer *vbuf;
 =09bool use_dma_api =3D !virtio_has_iommu_quirk(vgdev->vdev);
-=09struct virtio_gpu_object_shmem *shmem =3D to_virtio_gpu_shmem(bo);
=20
-=09if (use_dma_api)
+=09if (virtio_gpu_is_shmem(bo) && use_dma_api) {
+=09=09struct virtio_gpu_object_shmem *shmem =3D to_virtio_gpu_shmem(bo);
+
 =09=09dma_sync_sg_for_device(vgdev->vdev->dev.parent,
 =09=09=09=09       shmem->pages->sgl, shmem->pages->nents,
 =09=09=09=09       DMA_TO_DEVICE);
+=09}
=20
 =09cmd_p =3D virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 =09memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1034,6 +1038,8 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio=
_gpu_device *vgdev,
 =09convert_to_hw_box(&cmd_p->box, box);
 =09cmd_p->offset =3D cpu_to_le64(offset);
 =09cmd_p->level =3D cpu_to_le32(level);
+=09cmd_p->stride =3D cpu_to_le32(stride);
+=09cmd_p->layer_stride =3D cpu_to_le32(layer_stride);
=20
 =09virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
 }
@@ -1041,6 +1047,8 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio=
_gpu_device *vgdev,
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09  uint32_t ctx_id,
 =09=09=09=09=09  uint64_t offset, uint32_t level,
+=09=09=09=09=09  uint32_t stride,
+=09=09=09=09=09  uint32_t layer_stride,
 =09=09=09=09=09  struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09  struct virtio_gpu_object_array *objs,
 =09=09=09=09=09  struct virtio_gpu_fence *fence)
@@ -1060,6 +1068,8 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virt=
io_gpu_device *vgdev,
 =09convert_to_hw_box(&cmd_p->box, box);
 =09cmd_p->offset =3D cpu_to_le64(offset);
 =09cmd_p->level =3D cpu_to_le32(level);
+=09cmd_p->stride =3D cpu_to_le32(stride);
+=09cmd_p->layer_stride =3D cpu_to_le32(layer_stride);
=20
 =09virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
 }
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

