Return-Path: virtio-dev-return-7647-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A225F985E2F
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:20 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:45 -0700
Message-Id: <20200814024000.2485-10-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 09/24] drm/virtio: blob prep: make CPU responses more generic
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

RESOURCE_MAP_BLOB / RESOURCE_UNMAP_BLOB can use this.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 +++---
 drivers/gpu/drm/virtio/virtgpu_prime.c |  6 +++---
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index fc84b4b526ff..c74c38123ff6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -49,9 +49,9 @@
 #define DRIVER_MINOR 1
 #define DRIVER_PATCHLEVEL 0
=20
-#define UUID_INITIALIZING 0
-#define UUID_INITIALIZED 1
-#define UUID_INITIALIZATION_FAILED 2
+#define STATE_INITIALIZING 0
+#define STATE_OK 1
+#define STATE_ERR 2
=20
 struct virtio_gpu_object_params {
 =09uint32_t format;
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virti=
o/virtgpu_prime.c
index acd14ef73d56..3552db128ba3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -34,8 +34,8 @@ static int virtgpu_virtio_get_uuid(struct dma_buf *buf,
 =09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
 =09struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
=20
-=09wait_event(vgdev->resp_wq, bo->uuid_state !=3D UUID_INITIALIZING);
-=09if (bo->uuid_state !=3D UUID_INITIALIZED)
+=09wait_event(vgdev->resp_wq, bo->uuid_state !=3D STATE_INITIALIZING);
+=09if (bo->uuid_state !=3D STATE_OK)
 =09=09return -ENODEV;
=20
 =09uuid_copy(uuid, &bo->uuid);
@@ -81,7 +81,7 @@ struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_o=
bject *obj,
 =09=09=09return ERR_PTR(ret);
 =09=09virtio_gpu_notify(vgdev);
 =09} else {
-=09=09bo->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09=09bo->uuid_state =3D STATE_ERR;
 =09}
=20
 =09exp_info.ops =3D &virtgpu_dmabuf_ops.ops;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 55af6fc7bc7c..3f225a08ecf3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1118,14 +1118,14 @@ static void virtio_gpu_cmd_resource_uuid_cb(struct =
virtio_gpu_device *vgdev,
 =09uint32_t resp_type =3D le32_to_cpu(resp->hdr.type);
=20
 =09spin_lock(&vgdev->resource_export_lock);
-=09WARN_ON(obj->uuid_state !=3D UUID_INITIALIZING);
+=09WARN_ON(obj->uuid_state !=3D STATE_INITIALIZING);
=20
 =09if (resp_type =3D=3D VIRTIO_GPU_RESP_OK_RESOURCE_UUID &&
-=09=09=09obj->uuid_state =3D=3D UUID_INITIALIZING) {
+=09    obj->uuid_state =3D=3D STATE_INITIALIZING) {
 =09=09memcpy(&obj->uuid.b, resp->uuid, sizeof(obj->uuid.b));
-=09=09obj->uuid_state =3D UUID_INITIALIZED;
+=09=09obj->uuid_state =3D STATE_OK;
 =09} else {
-=09=09obj->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09=09obj->uuid_state =3D STATE_ERR;
 =09}
 =09spin_unlock(&vgdev->resource_export_lock);
=20
@@ -1144,7 +1144,7 @@ virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu=
_device *vgdev,
 =09resp_buf =3D kzalloc(sizeof(*resp_buf), GFP_KERNEL);
 =09if (!resp_buf) {
 =09=09spin_lock(&vgdev->resource_export_lock);
-=09=09bo->uuid_state =3D UUID_INITIALIZATION_FAILED;
+=09=09bo->uuid_state =3D STATE_ERR;
 =09=09spin_unlock(&vgdev->resource_export_lock);
 =09=09virtio_gpu_array_put_free(objs);
 =09=09return -ENOMEM;
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

