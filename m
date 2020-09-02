Return-Path: virtio-dev-return-7744-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24A6D985EE1
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:25 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:36 -0700
Message-Id: <20200902210847.2689-13-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 12/23] drm/virtio: implement blob resources: probe for the feature.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Let's proble for VIRTIO_GPU_F_RESOURCE_BLOB.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     | 10 +++++++---
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/vir=
tio/virtgpu_debugfs.c
index d5b0c543bd6d7..6b9b8376613f0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -49,6 +49,7 @@ static int virtio_gpu_features(struct seq_file *m, void *=
data)
 =09virtio_add_bool(m, "edid", vgdev->has_edid);
 =09virtio_add_bool(m, "indirect", vgdev->has_indirect);
 =09virtio_add_bool(m, "resource uuid", vgdev->has_resource_assign_uuid);
+=09virtio_add_bool(m, "blob resources", vgdev->has_resource_blob);
 =09virtio_add_int(m, "cap sets", vgdev->num_capsets);
 =09virtio_add_int(m, "scanouts", vgdev->num_scanouts);
 =09return 0;
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c
index b039f493bda99..3d04e428be140 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -166,6 +166,7 @@ static unsigned int features[] =3D {
 #endif
 =09VIRTIO_GPU_F_EDID,
 =09VIRTIO_GPU_F_RESOURCE_UUID,
+=09VIRTIO_GPU_F_RESOURCE_BLOB,
 };
 static struct virtio_driver virtio_gpu_driver =3D {
 =09.feature_table =3D features,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index f88e8902e1d61..f73e184f79e1a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -208,6 +208,7 @@ struct virtio_gpu_device {
 =09bool has_edid;
 =09bool has_indirect;
 =09bool has_resource_assign_uuid;
+=09bool has_resource_blob;
=20
 =09struct work_struct config_changed_work;
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 06af537b0091d..6cc08f234ad5e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -152,10 +152,14 @@ int virtio_gpu_init(struct drm_device *dev)
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
 =09=09vgdev->has_resource_assign_uuid =3D true;
 =09}
+=09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
+=09=09vgdev->has_resource_blob =3D true;
+=09}
=20
-=09DRM_INFO("features: %cvirgl %cedid\n",
-=09=09 vgdev->has_virgl_3d ? '+' : '-',
-=09=09 vgdev->has_edid     ? '+' : '-');
+=09DRM_INFO("features: %cvirgl %cedid %cresource_blob\n",
+=09=09 vgdev->has_virgl_3d    ? '+' : '-',
+=09=09 vgdev->has_edid        ? '+' : '-',
+=09=09 vgdev->has_resource_blob ? '+' : '-');
=20
 =09ret =3D virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 =09if (ret) {
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

