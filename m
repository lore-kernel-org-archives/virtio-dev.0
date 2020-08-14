Return-Path: virtio-dev-return-7654-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80573985DAA
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:48 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:51 -0700
Message-Id: <20200814024000.2485-16-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 15/24] drm/virtio: implement blob resources: expose virtio_gpu_resource_id_get
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

VRAM object will need it.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 2 ++
 drivers/gpu/drm/virtio/virtgpu_object.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index c8405449c4a3..71743916300d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -383,6 +383,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *=
vgdev,
=20
 bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo);
=20
+int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
+=09=09=09       uint32_t *resid);
 /* virtgpu_prime.c */
 struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
 =09=09=09=09=09 int flags);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index 9d68f260d998..792a2ae1bf97 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -31,8 +31,7 @@
 static int virtio_gpu_virglrenderer_workaround =3D 1;
 module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 04=
00);
=20
-static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-=09=09=09=09       uint32_t *resid)
+int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *=
resid)
 {
 =09if (virtio_gpu_virglrenderer_workaround) {
 =09=09/*
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

