Return-Path: <virtio-dev-return-8600-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E70D98651A
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Aug 2021 02:05:10 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 25 Aug 2021 19:04:52 -0700
Message-Id: <20210826020455.1081-10-gurchetansingh@chromium.org>
In-Reply-To: <20210826020455.1081-1-gurchetansingh@chromium.org>
References: <20210826020455.1081-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 09/12] drm/virtio: implement context init: allocate an array of fence contexts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

We don't want fences from different 3D contexts (virgl, gfxstream,
venus) to be on the same timeline.  With explicit context creation,
we can specify the number of ring each context wants.

Execbuffer can specify which ring to use.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34 ++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index a5142d60c2fa..3243d836b9c7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -56,6 +56,7 @@
 #define STATE_ERR 2
=20
 #define MAX_CAPSET_ID 63
+#define MAX_RINGS 32
=20
 struct virtio_gpu_object_params {
 =09unsigned long size;
@@ -263,6 +264,8 @@ struct virtio_gpu_fpriv {
 =09uint32_t ctx_id;
 =09uint32_t context_init;
 =09bool context_created;
+=09uint32_t num_rings;
+=09uint64_t base_fence_ctx;
 =09struct mutex context_lock;
 };
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index f51f3393a194..262f79210283 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -99,6 +99,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device=
 *dev, void *data,
 =09int in_fence_fd =3D exbuf->fence_fd;
 =09int out_fence_fd =3D -1;
 =09void *buf;
+=09uint64_t fence_ctx;
+=09uint32_t ring_idx;
+
+=09fence_ctx =3D vgdev->fence_drv.context;
+=09ring_idx =3D 0;
=20
 =09if (vgdev->has_virgl_3d =3D=3D false)
 =09=09return -ENOSYS;
@@ -106,6 +111,17 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_devi=
ce *dev, void *data,
 =09if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
 =09=09return -EINVAL;
=20
+=09if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
+=09=09if (exbuf->ring_idx >=3D vfpriv->num_rings)
+=09=09=09return -EINVAL;
+
+=09=09if (!vfpriv->base_fence_ctx)
+=09=09=09return -EINVAL;
+
+=09=09fence_ctx =3D vfpriv->base_fence_ctx;
+=09=09ring_idx =3D exbuf->ring_idx;
+=09}
+
 =09exbuf->fence_fd =3D -1;
=20
 =09virtio_gpu_create_context(dev, file);
@@ -173,7 +189,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_devic=
e *dev, void *data,
 =09=09=09goto out_memdup;
 =09}
=20
-=09out_fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0=
);
+=09out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
 =09if(!out_fence) {
 =09=09ret =3D -ENOMEM;
 =09=09goto out_unresv;
@@ -691,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_dev=
ice *dev,
 =09=09return -EINVAL;
=20
 =09/* Number of unique parameters supported at this time. */
-=09if (num_params > 1)
+=09if (num_params > 2)
 =09=09return -EINVAL;
=20
 =09ctx_set_params =3D memdup_user(u64_to_user_ptr(args->ctx_set_params),
@@ -731,6 +747,20 @@ static int virtio_gpu_context_init_ioctl(struct drm_de=
vice *dev,
=20
 =09=09=09vfpriv->context_init |=3D value;
 =09=09=09break;
+=09=09case VIRTGPU_CONTEXT_PARAM_NUM_RINGS:
+=09=09=09if (vfpriv->base_fence_ctx) {
+=09=09=09=09ret =3D -EINVAL;
+=09=09=09=09goto out_unlock;
+=09=09=09}
+
+=09=09=09if (value > MAX_RINGS) {
+=09=09=09=09ret =3D -EINVAL;
+=09=09=09=09goto out_unlock;
+=09=09=09}
+
+=09=09=09vfpriv->base_fence_ctx =3D dma_fence_context_alloc(value);
+=09=09=09vfpriv->num_rings =3D value;
+=09=09=09break;
 =09=09default:
 =09=09=09ret =3D -EINVAL;
 =09=09=09goto out_unlock;
--=20
2.33.0.259.gc128427fd7-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

