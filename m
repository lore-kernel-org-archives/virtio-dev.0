Return-Path: virtio-dev-return-7754-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC26D985ED3
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:51 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:47 -0700
Message-Id: <20200902210847.2689-24-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 23/23] drm/virtio: advertise features to userspace
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

New api changes are now available to userspace. Also, the
comparison to true is redundant, so remove it.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 442cbca59c8a5..e4c0c1f34d5c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -211,11 +211,20 @@ static int virtio_gpu_getparam_ioctl(struct drm_devic=
e *dev, void *data,
=20
 =09switch (param->param) {
 =09case VIRTGPU_PARAM_3D_FEATURES:
-=09=09value =3D vgdev->has_virgl_3d =3D=3D true ? 1 : 0;
+=09=09value =3D vgdev->has_virgl_3d ? 1 : 0;
 =09=09break;
 =09case VIRTGPU_PARAM_CAPSET_QUERY_FIX:
 =09=09value =3D 1;
 =09=09break;
+=09case VIRTGPU_PARAM_RESOURCE_BLOB:
+=09=09value =3D vgdev->has_resource_blob ? 1 : 0;
+=09=09break;
+=09case VIRTGPU_PARAM_HOST_VISIBLE:
+=09=09value =3D vgdev->has_host_visible ? 1 : 0;
+=09=09break;
+=09case VIRTGPU_PARAM_CROSS_DEVICE:
+=09=09value =3D vgdev->has_resource_assign_uuid ? 1 : 0;
+=09=09break;
 =09default:
 =09=09return -EINVAL;
 =09}
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

