Return-Path: <virtio-dev-return-8697-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1DCB98636B
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Sep 2021 23:20:57 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 21 Sep 2021 16:20:19 -0700
Message-Id: <20210921232024.817-8-gurchetansingh@chromium.org>
In-Reply-To: <20210921232024.817-1-gurchetansingh@chromium.org>
References: <20210921232024.817-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 07/12] drm/virtio: implement context init: plumb {base_fence_ctx, ring_idx} to virtio_gpu_fence_alloc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

These were defined in the previous commit. We'll need these
parameters when allocating a dma_fence.  The use case for this
is multiple synchronizations timelines.

The maximum number of timelines per 3D instance will be 32. Usually,
only 2 are needed -- one for CPU commands, and another for GPU
commands.

As such, we'll need to specify these parameters when allocating a
dma_fence.

vgdev->fence_drv.context is the "default" fence context for 2D mode
and old userspace.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 5 +++--
 drivers/gpu/drm/virtio/virtgpu_fence.c | 4 +++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 +++++----
 drivers/gpu/drm/virtio/virtgpu_plane.c | 3 ++-
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 401aec1a5efb..a5142d60c2fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -426,8 +426,9 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_g=
pu_device *vgdev,
 =09=09=09=09=09int index);
=20
 /* virtgpu_fence.c */
-struct virtio_gpu_fence *virtio_gpu_fence_alloc(
-=09struct virtio_gpu_device *vgdev);
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *=
vgdev,
+=09=09=09=09=09=09uint64_t base_fence_ctx,
+=09=09=09=09=09=09uint32_t ring_idx);
 void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 =09=09=09  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 =09=09=09  struct virtio_gpu_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virti=
o/virtgpu_fence.c
index d28e25e8409b..24c728b65d21 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -71,7 +71,9 @@ static const struct dma_fence_ops virtio_gpu_fence_ops =
=3D {
 =09.timeline_value_str  =3D virtio_gpu_timeline_value_str,
 };
=20
-struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *=
vgdev)
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *=
vgdev,
+=09=09=09=09=09=09uint64_t base_fence_ctx,
+=09=09=09=09=09=09uint32_t ring_idx)
 {
 =09struct virtio_gpu_fence_driver *drv =3D &vgdev->fence_drv;
 =09struct virtio_gpu_fence *fence =3D kzalloc(sizeof(struct virtio_gpu_fen=
ce),
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index f5281d1e30e1..f51f3393a194 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -173,7 +173,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_devic=
e *dev, void *data,
 =09=09=09goto out_memdup;
 =09}
=20
-=09out_fence =3D virtio_gpu_fence_alloc(vgdev);
+=09out_fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0=
);
 =09if(!out_fence) {
 =09=09ret =3D -ENOMEM;
 =09=09goto out_unresv;
@@ -288,7 +288,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_=
device *dev, void *data,
 =09if (params.size =3D=3D 0)
 =09=09params.size =3D PAGE_SIZE;
=20
-=09fence =3D virtio_gpu_fence_alloc(vgdev);
+=09fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
 =09if (!fence)
 =09=09return -ENOMEM;
 =09ret =3D virtio_gpu_object_create(vgdev, &params, &qobj, fence);
@@ -367,7 +367,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct d=
rm_device *dev,
 =09if (ret !=3D 0)
 =09=09goto err_put_free;
=20
-=09fence =3D virtio_gpu_fence_alloc(vgdev);
+=09fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
 =09if (!fence) {
 =09=09ret =3D -ENOMEM;
 =09=09goto err_unlock;
@@ -427,7 +427,8 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm=
_device *dev, void *data,
 =09=09=09goto err_put_free;
=20
 =09=09ret =3D -ENOMEM;
-=09=09fence =3D virtio_gpu_fence_alloc(vgdev);
+=09=09fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
+=09=09=09=09=09       0);
 =09=09if (!fence)
 =09=09=09goto err_unlock;
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index a49fd9480381..6d3cc9e238a4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -256,7 +256,8 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane=
 *plane,
 =09=09return 0;
=20
 =09if (bo->dumb && (plane->state->fb !=3D new_state->fb)) {
-=09=09vgfb->fence =3D virtio_gpu_fence_alloc(vgdev);
+=09=09vgfb->fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.conte=
xt,
+=09=09=09=09=09=09     0);
 =09=09if (!vgfb->fence)
 =09=09=09return -ENOMEM;
 =09}
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

