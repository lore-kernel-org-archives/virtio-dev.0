Return-Path: virtio-dev-return-7751-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30E68985EC1
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:49 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:42 -0700
Message-Id: <20200902210847.2689-19-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 18/23] drm/virtio: implement blob resources: blob display integration
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

SCANOUT_BLOB forwards the DRM framebuffer metadata to the host. The
modifier is intentionally left out -- it may be possible to query
the host for that.

We also assume one blob resource per DRM framebuffer.  That too is
an intentional simplification.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index 6a311cd934403..42ac08ed1442e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -174,12 +174,23 @@ static void virtio_gpu_primary_plane_update(struct dr=
m_plane *plane,
 =09=09=09  plane->state->src_h >> 16,
 =09=09=09  plane->state->src_x >> 16,
 =09=09=09  plane->state->src_y >> 16);
-=09=09virtio_gpu_cmd_set_scanout(vgdev, output->index,
-=09=09=09=09=09   bo->hw_res_handle,
-=09=09=09=09=09   plane->state->src_w >> 16,
-=09=09=09=09=09   plane->state->src_h >> 16,
-=09=09=09=09=09   plane->state->src_x >> 16,
-=09=09=09=09=09   plane->state->src_y >> 16);
+
+=09=09if (bo->host3d_blob || bo->guest_blob) {
+=09=09=09virtio_gpu_cmd_set_scanout_blob
+=09=09=09=09=09=09(vgdev, output->index, bo,
+=09=09=09=09=09=09 plane->state->fb,
+=09=09=09=09=09=09 plane->state->src_w >> 16,
+=09=09=09=09=09=09 plane->state->src_h >> 16,
+=09=09=09=09=09=09 plane->state->src_x >> 16,
+=09=09=09=09=09=09 plane->state->src_y >> 16);
+=09=09} else {
+=09=09=09virtio_gpu_cmd_set_scanout(vgdev, output->index,
+=09=09=09=09=09=09   bo->hw_res_handle,
+=09=09=09=09=09=09   plane->state->src_w >> 16,
+=09=09=09=09=09=09   plane->state->src_h >> 16,
+=09=09=09=09=09=09   plane->state->src_x >> 16,
+=09=09=09=09=09=09   plane->state->src_y >> 16);
+=09=09}
 =09}
=20
 =09virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

