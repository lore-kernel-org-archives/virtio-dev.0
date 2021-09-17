Return-Path: <virtio-dev-return-8678-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5E9C98642F
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Sep 2021 01:08:54 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 16 Sep 2021 18:08:33 -0700
Message-Id: <20210917010842.503-4-gurchetansingh@chromium.org>
In-Reply-To: <20210917010842.503-1-gurchetansingh@chromium.org>
References: <20210917010842.503-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 03/12] drm/virtio: implement context init: track valid capabilities in a mask
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The valid capability IDs are between 1 to 63, and defined in the
virtio gpu spec.  This is used for error checking the subsequent
patches.  We're currently only using 2 capability IDs, so this
should be plenty for the immediate future.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 0c4810982530..3023e16be0d6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -55,6 +55,8 @@
 #define STATE_OK 1
 #define STATE_ERR 2
=20
+#define MAX_CAPSET_ID 63
+
 struct virtio_gpu_object_params {
 =09unsigned long size;
 =09bool dumb;
@@ -245,6 +247,7 @@ struct virtio_gpu_device {
=20
 =09struct virtio_gpu_drv_capset *capsets;
 =09uint32_t num_capsets;
+=09uint64_t capset_id_mask;
 =09struct list_head cap_cache;
=20
 =09/* protects uuid state when exporting */
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index f3379059f324..58a65121c200 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -65,6 +65,7 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_devi=
ce *vgdev,
 =09=09=09=09   int num_capsets)
 {
 =09int i, ret;
+=09bool invalid_capset_id =3D false;
=20
 =09vgdev->capsets =3D kcalloc(num_capsets,
 =09=09=09=09 sizeof(struct virtio_gpu_drv_capset),
@@ -78,19 +79,34 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_de=
vice *vgdev,
 =09=09virtio_gpu_notify(vgdev);
 =09=09ret =3D wait_event_timeout(vgdev->resp_wq,
 =09=09=09=09=09 vgdev->capsets[i].id > 0, 5 * HZ);
-=09=09if (ret =3D=3D 0) {
+=09=09/*
+=09=09 * Capability ids are defined in the virtio-gpu spec and are
+=09=09 * between 1 to 63, inclusive.
+=09=09 */
+=09=09if (!vgdev->capsets[i].id ||
+=09=09    vgdev->capsets[i].id > MAX_CAPSET_ID)
+=09=09=09invalid_capset_id =3D true;
+
+=09=09if (ret =3D=3D 0)
 =09=09=09DRM_ERROR("timed out waiting for cap set %d\n", i);
+=09=09else if (invalid_capset_id)
+=09=09=09DRM_ERROR("invalid capset id %u", vgdev->capsets[i].id);
+
+=09=09if (ret =3D=3D 0 || invalid_capset_id) {
 =09=09=09spin_lock(&vgdev->display_info_lock);
 =09=09=09kfree(vgdev->capsets);
 =09=09=09vgdev->capsets =3D NULL;
 =09=09=09spin_unlock(&vgdev->display_info_lock);
 =09=09=09return;
 =09=09}
+
+=09=09vgdev->capset_id_mask |=3D 1 << vgdev->capsets[i].id;
 =09=09DRM_INFO("cap set %d: id %d, max-version %d, max-size %d\n",
 =09=09=09 i, vgdev->capsets[i].id,
 =09=09=09 vgdev->capsets[i].max_version,
 =09=09=09 vgdev->capsets[i].max_size);
 =09}
+
 =09vgdev->num_capsets =3D num_capsets;
 }
=20
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

