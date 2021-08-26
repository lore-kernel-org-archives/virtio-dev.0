Return-Path: <virtio-dev-return-8601-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 118D898651B
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Aug 2021 02:05:12 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 25 Aug 2021 19:04:53 -0700
Message-Id: <20210826020455.1081-11-gurchetansingh@chromium.org>
In-Reply-To: <20210826020455.1081-1-gurchetansingh@chromium.org>
References: <20210826020455.1081-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 10/12] drm/virtio: implement context init: handle VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK
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
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 3243d836b9c7..1182d5e5d322 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -266,6 +266,7 @@ struct virtio_gpu_fpriv {
 =09bool context_created;
 =09uint32_t num_rings;
 =09uint64_t base_fence_ctx;
+=09uint32_t ring_idx_mask;
 =09struct mutex context_lock;
 };
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 262f79210283..8523351b523d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -693,7 +693,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_dev=
ice *dev,
 =09=09=09=09=09 void *data, struct drm_file *file)
 {
 =09int ret =3D 0;
-=09uint32_t num_params, i, param, value;
+=09uint32_t num_params, i, param, value, valid_ring_mask;
 =09size_t len;
 =09struct drm_virtgpu_context_set_param *ctx_set_params =3D NULL;
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
@@ -707,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_dev=
ice *dev,
 =09=09return -EINVAL;
=20
 =09/* Number of unique parameters supported at this time. */
-=09if (num_params > 2)
+=09if (num_params > 3)
 =09=09return -EINVAL;
=20
 =09ctx_set_params =3D memdup_user(u64_to_user_ptr(args->ctx_set_params),
@@ -761,12 +761,31 @@ static int virtio_gpu_context_init_ioctl(struct drm_d=
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
2.33.0.259.gc128427fd7-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

