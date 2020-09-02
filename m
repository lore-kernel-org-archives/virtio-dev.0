Return-Path: virtio-dev-return-7746-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B674985F52
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:25 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:37 -0700
Message-Id: <20200902210847.2689-14-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 13/23] drm/virtio: implement blob resources: probe for host visible region
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The availability of the host visible region means host 3D
allocations can be directly mapped in the guest.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Co-developed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  5 +++++
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  2 ++
 drivers/gpu/drm/virtio/virtgpu_kms.c     | 27 ++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/vir=
tio/virtgpu_debugfs.c
index 6b9b8376613f0..a2cdd267914ac 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -52,6 +52,11 @@ static int virtio_gpu_features(struct seq_file *m, void =
*data)
 =09virtio_add_bool(m, "blob resources", vgdev->has_resource_blob);
 =09virtio_add_int(m, "cap sets", vgdev->num_capsets);
 =09virtio_add_int(m, "scanouts", vgdev->num_scanouts);
+=09if (vgdev->host_visible_region.len) {
+=09=09seq_printf(m, "%-16s : 0x%lx +0x%lx\n", "host visible region",
+=09=09=09   (unsigned long)vgdev->host_visible_region.addr,
+=09=09=09   (unsigned long)vgdev->host_visible_region.len);
+=09}
 =09return 0;
 }
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index f73e184f79e1a..72abeaa3c4872 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -209,6 +209,8 @@ struct virtio_gpu_device {
 =09bool has_indirect;
 =09bool has_resource_assign_uuid;
 =09bool has_resource_blob;
+=09bool has_host_visible;
+=09struct virtio_shm_region host_visible_region;
=20
 =09struct work_struct config_changed_work;
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 6cc08f234ad5e..97b6e4fb945a7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -155,11 +155,27 @@ int virtio_gpu_init(struct drm_device *dev)
 =09if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
 =09=09vgdev->has_resource_blob =3D true;
 =09}
+=09if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
+=09=09=09=09  VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
+=09=09if (!devm_request_mem_region(&vgdev->vdev->dev,
+=09=09=09=09=09     vgdev->host_visible_region.addr,
+=09=09=09=09=09     vgdev->host_visible_region.len,
+=09=09=09=09=09     dev_name(&vgdev->vdev->dev))) {
+=09=09=09DRM_ERROR("Could not reserve host visible region\n");
+=09=09=09goto err_vqs;
+=09=09}
+
+=09=09DRM_INFO("Host memory window: 0x%lx +0x%lx\n",
+=09=09=09 (unsigned long)vgdev->host_visible_region.addr,
+=09=09=09 (unsigned long)vgdev->host_visible_region.len);
+=09=09vgdev->has_host_visible =3D true;
+=09}
=20
-=09DRM_INFO("features: %cvirgl %cedid %cresource_blob\n",
+=09DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible\n",
 =09=09 vgdev->has_virgl_3d    ? '+' : '-',
 =09=09 vgdev->has_edid        ? '+' : '-',
-=09=09 vgdev->has_resource_blob ? '+' : '-');
+=09=09 vgdev->has_resource_blob ? '+' : '-',
+=09=09 vgdev->has_host_visible ? '+' : '-');
=20
 =09ret =3D virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 =09if (ret) {
@@ -243,6 +259,13 @@ void virtio_gpu_release(struct drm_device *dev)
 =09virtio_gpu_free_vbufs(vgdev);
 =09virtio_gpu_cleanup_cap_cache(vgdev);
 =09kfree(vgdev->capsets);
+
+=09if (vgdev->has_host_visible) {
+=09=09devm_release_mem_region(&vgdev->vdev->dev,
+=09=09=09=09=09vgdev->host_visible_region.addr,
+=09=09=09=09=09vgdev->host_visible_region.len);
+=09}
+
 =09kfree(vgdev);
 }
=20
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

