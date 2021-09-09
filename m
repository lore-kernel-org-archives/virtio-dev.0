Return-Path: <virtio-dev-return-8657-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAF029865E6
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Sep 2021 01:37:33 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  8 Sep 2021 18:37:15 -0700
Message-Id: <20210909013717.861-11-gurchetansingh@chromium.org>
In-Reply-To: <20210909013717.861-1-gurchetansingh@chromium.org>
References: <20210909013717.861-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 10/12] drm/virtio: implement context init: handle VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

For the Sommelier guest Wayland proxy, it's desirable for the
DRM fd to be pollable in response to an host compositor event.
This can also be used by the 3D driver to poll events on a CPU
timeline.

This enables the DRM fd associated with a particular 3D context
to be polled independent of KMS events.  The parameter
VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK specifies the pollable
rings.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Nicholas Verne <nverne@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index cca9ab505deb..cb60d52c2bd1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -266,6 +266,7 @@ struct virtio_gpu_fpriv {
 =09bool context_created;
 =09uint32_t num_rings;
 =09uint64_t base_fence_ctx;
+=09uint64_t ring_idx_mask;
 =09struct mutex context_lock;
 };
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 262f79210283..be7b22a03884 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -694,6 +694,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_dev=
ice *dev,
 {
 =09int ret =3D 0;
 =09uint32_t num_params, i, param, value;
+=09uint64_t valid_ring_mask;
 =09size_t len;
 =09struct drm_virtgpu_context_set_param *ctx_set_params =3D NULL;
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
@@ -707,7 +708,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_dev=
ice *dev,
 =09=09return -EINVAL;
=20
 =09/* Number of unique parameters supported at this time. */
-=09if (num_params > 2)
+=09if (num_params > 3)
 =09=09return -EINVAL;
=20
 =09ctx_set_params =3D memdup_user(u64_to_user_ptr(args->ctx_set_params),
@@ -761,12 +762,31 @@ static int virtio_gpu_context_init_ioctl(struct drm_d=
evice *dev,
 =09=09=09vfpriv->base_fence_ctx =3D dma_fence_context_alloc(value);
 =09=09=09vfpriv->num_rings =3D value;
 =09=09=09break;
+=09=09case VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK:
+=09=09=09if (vfpriv->ring_idx_mask) {
+=09=09=09=09ret =3D -EINVAL;
+=09=09=09=09goto out_unlock;
+=09=09=09}
+
+=09=09=09vfpriv->ring_idx_mask =3D value;
+=09=09=09break;
 =09=09default:
 =09=09=09ret =3D -EINVAL;
 =09=09=09goto out_unlock;
 =09=09}
 =09}
=20
+=09if (vfpriv->ring_idx_mask) {
+=09=09valid_ring_mask =3D 0;
+=09=09for (i =3D 0; i < vfpriv->num_rings; i++)
+=09=09=09valid_ring_mask |=3D 1 << i;
+
+=09=09if (~valid_ring_mask & vfpriv->ring_idx_mask) {
+=09=09=09ret =3D -EINVAL;
+=09=09=09goto out_unlock;
+=09=09}
+=09}
+
 =09virtio_gpu_create_context_locked(vgdev, vfpriv);
 =09virtio_gpu_notify(vgdev);
=20
--=20
2.33.0.153.gba50c8fa24-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

