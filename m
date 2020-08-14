Return-Path: virtio-dev-return-7657-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB593985FFD
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:08 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:52 -0700
Message-Id: <20200814024000.2485-17-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 16/24] drm/virtio: implement blob resources: add new fields to internal structs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Useful for upcoming blob resources.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 71743916300d..34636cb5a93c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -54,13 +54,16 @@
 #define STATE_ERR 2
=20
 struct virtio_gpu_object_params {
-=09uint32_t format;
-=09uint32_t width;
-=09uint32_t height;
 =09unsigned long size;
 =09bool dumb;
 =09/* 3d */
 =09bool virgl;
+=09bool blob;
+
+=09/* classic resources only */
+=09uint32_t format;
+=09uint32_t width;
+=09uint32_t height;
 =09uint32_t target;
 =09uint32_t bind;
 =09uint32_t depth;
@@ -68,6 +71,12 @@ struct virtio_gpu_object_params {
 =09uint32_t last_level;
 =09uint32_t nr_samples;
 =09uint32_t flags;
+
+=09/* blob resources only */
+=09uint32_t ctx_id;
+=09uint32_t blob_mem;
+=09uint32_t blob_flags;
+=09uint64_t blob_id;
 };
=20
 struct virtio_gpu_object {
@@ -75,6 +84,8 @@ struct virtio_gpu_object {
 =09uint32_t hw_res_handle;
 =09bool dumb;
 =09bool created;
+=09bool host3d_blob, guest_blob;
+=09uint32_t blob_mem, blob_flags;
=20
 =09int uuid_state;
 =09uuid_t uuid;
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

