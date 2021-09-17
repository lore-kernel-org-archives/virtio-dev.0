Return-Path: <virtio-dev-return-8679-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E47C29864CD
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Sep 2021 01:08:54 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 16 Sep 2021 18:08:34 -0700
Message-Id: <20210917010842.503-5-gurchetansingh@chromium.org>
In-Reply-To: <20210917010842.503-1-gurchetansingh@chromium.org>
References: <20210917010842.503-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 04/12] drm/virtio: implement context init: probe for feature
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

Let's probe for VIRTIO_GPU_F_CONTEXT_INIT.

Create a new DRM_INFO(..) line since the current one is getting
too long.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     | 1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     | 8 +++++++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/vir=
tio/virtgpu_debugfs.c
index c2b20e0ee030..b6954e2f75e6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -52,6 +52,7 @@ static int virtio_gpu_features(struct seq_file *m, void *=
data)
 =09=09=09    vgdev->has_resource_assign_uuid);
=20
 =09virtio_gpu_add_bool(m, "blob resources", vgdev->has_resource_blob);
+=09virtio_gpu_add_bool(m, "context init", vgdev->has_context_init);
 =09virtio_gpu_add_int(m, "cap sets", vgdev->num_capsets);
 =09virtio_gpu_add_int(m, "scanouts", vgdev->num_scanouts);
 =09if (vgdev->host_visible_region.len) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c
index ed85a7863256..9d963f1fda8f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -172,6 +172,7 @@ static unsigned int features[] =3D {
 =09VIRTIO_GPU_F_EDID,
 =09VIRTIO_GPU_F_RESOURCE_UUID,
 =09VIRTIO_GPU_F_RESOURCE_BLOB,
+=09VIRTIO_GPU_F_CONTEXT_INIT,
 };
 static struct virtio_driver virtio_gpu_driver =3D {
 =09.feature_table =3D features,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 3023e16be0d6..5e1958a522ff 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -236,6 +236,7 @@ struct virtio_gpu_device {
 =09bool has_resource_assign_uuid;
 =09bool has_resource_blob;
 =09bool has_host_visible;
+=09bool has_context_init;
 =09struct virtio_shm_region host_visible_region;
 =09struct drm_mm host_visible_mm;
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 58a65121c200..21f410901694 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -191,13 +191,19 @@ int virtio_gpu_init(struct drm_device *dev)
 =09=09=09    (unsigned long)vgdev->host_visible_region.addr,
 =09=09=09    (unsigned long)vgdev->host_visible_region.len);
 =09}
+=09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_CONTEXT_INIT)) {
+=09=09vgdev->has_context_init =3D true;
+=09}
=20
-=09DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible\n",
+=09DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
 =09=09 vgdev->has_virgl_3d    ? '+' : '-',
 =09=09 vgdev->has_edid        ? '+' : '-',
 =09=09 vgdev->has_resource_blob ? '+' : '-',
 =09=09 vgdev->has_host_visible ? '+' : '-');
=20
+=09DRM_INFO("features: %ccontext_init\n",
+=09=09 vgdev->has_context_init ? '+' : '-');
+
 =09ret =3D virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 =09if (ret) {
 =09=09DRM_ERROR("failed to find virt queues\n");
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

