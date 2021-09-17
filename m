Return-Path: <virtio-dev-return-8688-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C72A09862A2
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Sep 2021 01:09:23 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 16 Sep 2021 18:08:42 -0700
Message-Id: <20210917010842.503-13-gurchetansingh@chromium.org>
In-Reply-To: <20210917010842.503-1-gurchetansingh@chromium.org>
References: <20210917010842.503-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 12/12] drm/virtio: implement context init: advertise feature to userspace
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This advertises the context init feature to userspace, along with
a mask of supported capabilities.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index fdaa7f3d9eeb..5618a1d5879c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -286,6 +286,12 @@ static int virtio_gpu_getparam_ioctl(struct drm_device=
 *dev, void *data,
 =09case VIRTGPU_PARAM_CROSS_DEVICE:
 =09=09value =3D vgdev->has_resource_assign_uuid ? 1 : 0;
 =09=09break;
+=09case VIRTGPU_PARAM_CONTEXT_INIT:
+=09=09value =3D vgdev->has_context_init ? 1 : 0;
+=09=09break;
+=09case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:
+=09=09value =3D vgdev->capset_id_mask;
+=09=09break;
 =09default:
 =09=09return -EINVAL;
 =09}
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

