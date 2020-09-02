Return-Path: virtio-dev-return-7740-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A205985EC1
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:10 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:31 -0700
Message-Id: <20200902210847.2689-8-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 07/23] drm/virtio: blob prep: refactor getting pages and attaching backing
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Useful for upcoming blob resources.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index 729f98ad7c020..32e9eae73fc2c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -227,22 +227,22 @@ int virtio_gpu_object_create(struct virtio_gpu_device=
 *vgdev,
 =09=09=09goto err_put_objs;
 =09}
=20
+=09ret =3D virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
+=09if (ret !=3D 0) {
+=09=09virtio_gpu_free_object(&shmem_obj->base);
+=09=09return ret;
+=09}
+
 =09if (params->virgl) {
 =09=09virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
 =09=09=09=09=09=09  objs, fence);
+=09=09virtio_gpu_object_attach(vgdev, bo, ents, nents);
 =09} else {
 =09=09virtio_gpu_cmd_create_resource(vgdev, bo, params,
 =09=09=09=09=09       objs, fence);
+=09=09virtio_gpu_object_attach(vgdev, bo, ents, nents);
 =09}
=20
-=09ret =3D virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
-=09if (ret !=3D 0) {
-=09=09virtio_gpu_free_object(&shmem_obj->base);
-=09=09return ret;
-=09}
-
-=09virtio_gpu_object_attach(vgdev, bo, ents, nents);
-
 =09*bo_ptr =3D bo;
 =09return 0;
=20
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

