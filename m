Return-Path: virtio-dev-return-7663-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8515E9860F4
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:14 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:40:00 -0700
Message-Id: <20200814024000.2485-25-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 24/24] drm/virtio: advertise features to userspace
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

New api changes are now available to userspace.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 47ac32b7031a..f3737dc0f8ea 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -216,6 +216,15 @@ static int virtio_gpu_getparam_ioctl(struct drm_device=
 *dev, void *data,
 =09case VIRTGPU_PARAM_CAPSET_QUERY_FIX:
 =09=09value =3D 1;
 =09=09break;
+=09case VIRTGPU_PARAM_RESOURCE_BLOB:
+=09=09value =3D vgdev->has_resource_blob =3D=3D true ? 1 : 0;
+=09=09break;
+=09case VIRTGPU_PARAM_HOST_VISIBLE:
+=09=09value =3D vgdev->has_host_visible =3D=3D true ? 1 : 0;
+=09=09break;
+=09case VIRTGPU_PARAM_CROSS_DEVICE:
+=09=09value =3D vgdev->has_resource_assign_uuid =3D=3D true ? 1 : 0;
+=09=09break;
 =09default:
 =09=09return -EINVAL;
 =09}
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

