Return-Path: virtio-dev-return-7734-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05566985EC8
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:08:55 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:25 -0700
Message-Id: <20200902210847.2689-2-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 01/23] Fix use after free in get_capset_info callback.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Doug Horn <doughorn@google.com>

If a response to virtio_gpu_cmd_get_capset_info takes longer than
five seconds to return, the callback will access freed kernel memory
in vg->capsets.

Signed-off-by: Doug Horn <doughorn@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c |  2 ++
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 75d0dc2f6d285..5ba389e0a02fb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -80,8 +80,10 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_dev=
ice *vgdev,
 =09=09=09=09=09 vgdev->capsets[i].id > 0, 5 * HZ);
 =09=09if (ret =3D=3D 0) {
 =09=09=09DRM_ERROR("timed out waiting for cap set %d\n", i);
+=09=09=09spin_lock(&vgdev->display_info_lock);
 =09=09=09kfree(vgdev->capsets);
 =09=09=09vgdev->capsets =3D NULL;
+=09=09=09spin_unlock(&vgdev->display_info_lock);
 =09=09=09return;
 =09=09}
 =09=09DRM_INFO("cap set %d: id %d, max-version %d, max-size %d\n",
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index c93c2db35aaf3..7436705ba5a22 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -684,9 +684,13 @@ static void virtio_gpu_cmd_get_capset_info_cb(struct v=
irtio_gpu_device *vgdev,
 =09int i =3D le32_to_cpu(cmd->capset_index);
=20
 =09spin_lock(&vgdev->display_info_lock);
-=09vgdev->capsets[i].id =3D le32_to_cpu(resp->capset_id);
-=09vgdev->capsets[i].max_version =3D le32_to_cpu(resp->capset_max_version)=
;
-=09vgdev->capsets[i].max_size =3D le32_to_cpu(resp->capset_max_size);
+=09if (vgdev->capsets) {
+=09=09vgdev->capsets[i].id =3D le32_to_cpu(resp->capset_id);
+=09=09vgdev->capsets[i].max_version =3D le32_to_cpu(resp->capset_max_versi=
on);
+=09=09vgdev->capsets[i].max_size =3D le32_to_cpu(resp->capset_max_size);
+=09} else {
+=09=09DRM_ERROR("invalid capset memory.");
+=09}
 =09spin_unlock(&vgdev->display_info_lock);
 =09wake_up(&vgdev->resp_wq);
 }
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

