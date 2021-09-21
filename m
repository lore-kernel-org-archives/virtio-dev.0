Return-Path: <virtio-dev-return-8695-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2FA8986369
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Sep 2021 23:20:37 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 21 Sep 2021 16:20:17 -0700
Message-Id: <20210921232024.817-6-gurchetansingh@chromium.org>
In-Reply-To: <20210921232024.817-1-gurchetansingh@chromium.org>
References: <20210921232024.817-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 05/12] drm/virtio: implement context init: support init ioctl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

This implements the context initialization ioctl.  A list of params
is passed in by userspace, and kernel driver validates them.  The
only currently supported param is VIRTGPU_CONTEXT_PARAM_CAPSET_ID.

If the context has already been initialized, -EEXIST is returned.
This happens after Linux userspace does dumb_create + followed by
opening the Mesa virgl driver with the same virtgpu instance.

However, for most applications, 3D contexts will be explicitly
initialized when the feature is available.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 96 ++++++++++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  4 +-
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 5e1958a522ff..9996abf60e3a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -259,12 +259,13 @@ struct virtio_gpu_device {
=20
 struct virtio_gpu_fpriv {
 =09uint32_t ctx_id;
+=09uint32_t context_init;
 =09bool context_created;
 =09struct mutex context_lock;
 };
=20
 /* virtgpu_ioctl.c */
-#define DRM_VIRTIO_NUM_IOCTLS 11
+#define DRM_VIRTIO_NUM_IOCTLS 12
 extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
 void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *fi=
le);
=20
@@ -342,7 +343,8 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device =
*vgdev,
 =09=09=09      struct virtio_gpu_drv_cap_cache **cache_p);
 int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32=
_t id,
-=09=09=09=09   uint32_t nlen, const char *name);
+=09=09=09=09   uint32_t context_init, uint32_t nlen,
+=09=09=09=09   const char *name);
 void virtio_gpu_cmd_context_destroy(struct virtio_gpu_device *vgdev,
 =09=09=09=09    uint32_t id);
 void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device *vgde=
v,
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 5c1ad1596889..f5281d1e30e1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -38,20 +38,30 @@
 =09=09=09=09    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
 =09=09=09=09    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
=20
+/* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
+static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgd=
ev,
+=09=09=09=09=09     struct virtio_gpu_fpriv *vfpriv)
+{
+=09char dbgname[TASK_COMM_LEN];
+
+=09get_task_comm(dbgname, current);
+=09virtio_gpu_cmd_context_create(vgdev, vfpriv->ctx_id,
+=09=09=09=09      vfpriv->context_init, strlen(dbgname),
+=09=09=09=09      dbgname);
+
+=09vfpriv->context_created =3D true;
+}
+
 void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *fi=
le)
 {
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
 =09struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
-=09char dbgname[TASK_COMM_LEN];
=20
 =09mutex_lock(&vfpriv->context_lock);
 =09if (vfpriv->context_created)
 =09=09goto out_unlock;
=20
-=09get_task_comm(dbgname, current);
-=09virtio_gpu_cmd_context_create(vgdev, vfpriv->ctx_id,
-=09=09=09=09      strlen(dbgname), dbgname);
-=09vfpriv->context_created =3D true;
+=09virtio_gpu_create_context_locked(vgdev, vfpriv);
=20
 out_unlock:
 =09mutex_unlock(&vfpriv->context_lock);
@@ -662,6 +672,79 @@ static int virtio_gpu_resource_create_blob_ioctl(struc=
t drm_device *dev,
 =09return 0;
 }
=20
+static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
+=09=09=09=09=09 void *data, struct drm_file *file)
+{
+=09int ret =3D 0;
+=09uint32_t num_params, i, param, value;
+=09size_t len;
+=09struct drm_virtgpu_context_set_param *ctx_set_params =3D NULL;
+=09struct virtio_gpu_device *vgdev =3D dev->dev_private;
+=09struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
+=09struct drm_virtgpu_context_init *args =3D data;
+
+=09num_params =3D args->num_params;
+=09len =3D num_params * sizeof(struct drm_virtgpu_context_set_param);
+
+=09if (!vgdev->has_context_init || !vgdev->has_virgl_3d)
+=09=09return -EINVAL;
+
+=09/* Number of unique parameters supported at this time. */
+=09if (num_params > 1)
+=09=09return -EINVAL;
+
+=09ctx_set_params =3D memdup_user(u64_to_user_ptr(args->ctx_set_params),
+=09=09=09=09     len);
+
+=09if (IS_ERR(ctx_set_params))
+=09=09return PTR_ERR(ctx_set_params);
+
+=09mutex_lock(&vfpriv->context_lock);
+=09if (vfpriv->context_created) {
+=09=09ret =3D -EEXIST;
+=09=09goto out_unlock;
+=09}
+
+=09for (i =3D 0; i < num_params; i++) {
+=09=09param =3D ctx_set_params[i].param;
+=09=09value =3D ctx_set_params[i].value;
+
+=09=09switch (param) {
+=09=09case VIRTGPU_CONTEXT_PARAM_CAPSET_ID:
+=09=09=09if (value > MAX_CAPSET_ID) {
+=09=09=09=09ret =3D -EINVAL;
+=09=09=09=09goto out_unlock;
+=09=09=09}
+
+=09=09=09if ((vgdev->capset_id_mask & (1 << value)) =3D=3D 0) {
+=09=09=09=09ret =3D -EINVAL;
+=09=09=09=09goto out_unlock;
+=09=09=09}
+
+=09=09=09/* Context capset ID already set */
+=09=09=09if (vfpriv->context_init &
+=09=09=09    VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) {
+=09=09=09=09ret =3D -EINVAL;
+=09=09=09=09goto out_unlock;
+=09=09=09}
+
+=09=09=09vfpriv->context_init |=3D value;
+=09=09=09break;
+=09=09default:
+=09=09=09ret =3D -EINVAL;
+=09=09=09goto out_unlock;
+=09=09}
+=09}
+
+=09virtio_gpu_create_context_locked(vgdev, vfpriv);
+=09virtio_gpu_notify(vgdev);
+
+out_unlock:
+=09mutex_unlock(&vfpriv->context_lock);
+=09kfree(ctx_set_params);
+=09return ret;
+}
+
 struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] =3D {
 =09DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
 =09=09=09  DRM_RENDER_ALLOW),
@@ -698,4 +781,7 @@ struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_=
IOCTLS] =3D {
 =09DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE_BLOB,
 =09=09=09  virtio_gpu_resource_create_blob_ioctl,
 =09=09=09  DRM_RENDER_ALLOW),
+
+=09DRM_IOCTL_DEF_DRV(VIRTGPU_CONTEXT_INIT, virtio_gpu_context_init_ioctl,
+=09=09=09  DRM_RENDER_ALLOW),
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 93a41d018dca..db7741549ab0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -911,7 +911,8 @@ int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *=
vgdev)
 }
=20
 void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32=
_t id,
-=09=09=09=09   uint32_t nlen, const char *name)
+=09=09=09=09   uint32_t context_init, uint32_t nlen,
+=09=09=09=09   const char *name)
 {
 =09struct virtio_gpu_ctx_create *cmd_p;
 =09struct virtio_gpu_vbuffer *vbuf;
@@ -922,6 +923,7 @@ void virtio_gpu_cmd_context_create(struct virtio_gpu_de=
vice *vgdev, uint32_t id,
 =09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_CTX_CREATE);
 =09cmd_p->hdr.ctx_id =3D cpu_to_le32(id);
 =09cmd_p->nlen =3D cpu_to_le32(nlen);
+=09cmd_p->context_init =3D cpu_to_le32(context_init);
 =09strncpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name) - 1);
 =09cmd_p->debug_name[sizeof(cmd_p->debug_name) - 1] =3D 0;
 =09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

