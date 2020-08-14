Return-Path: virtio-dev-return-7658-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51809985FE5
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:14 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:55 -0700
Message-Id: <20200814024000.2485-20-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 19/24] drm/virtio: implement blob resources: blob display integration
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
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
index 52d24179bcec..1e0754e77723 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -172,12 +172,23 @@ static void virtio_gpu_primary_plane_update(struct dr=
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
+=09=09=09virtio_gpu_cmd_set_scanout_blob(
+=09=09=09=09=09=09vgdev, output->index, bo,
+=09=09=09=09=09=09plane->state->fb,
+=09=09=09=09=09=09plane->state->src_w >> 16,
+=09=09=09=09=09=09plane->state->src_h >> 16,
+=09=09=09=09=09=09plane->state->src_x >> 16,
+=09=09=09=09=09=09plane->state->src_y >> 16);
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
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

