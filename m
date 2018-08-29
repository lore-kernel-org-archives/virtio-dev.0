Return-Path: virtio-dev-return-4812-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79AFD985EBC
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Aug 2018 12:20:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 29 Aug 2018 14:20:25 +0200
Message-Id: <20180829122026.27012-2-kraxel@redhat.com>
In-Reply-To: <20180829122026.27012-1-kraxel@redhat.com>
References: <20180829122026.27012-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH 1/2] drm/virtio: add virtio_gpu_object_detach() function
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

The new function balances virtio_gpu_object_attach().

Also make virtio_gpu_cmd_resource_inval_backing() static and switch
call sites to the new virtio_gpu_object_attach() function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_fb.c  |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c |  3 +--
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 ++++++++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207b..cbbff01077 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -276,13 +276,13 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     uint32_t resource_id,
 			     struct virtio_gpu_fence **fence);
+void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
+			      struct virtio_gpu_object *obj);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
 int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
 			    struct virtio_gpu_output *output);
 int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev);
-void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
-					   uint32_t resource_id);
 int virtio_gpu_cmd_get_capset_info(struct virtio_gpu_device *vgdev, int idx);
 int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 			      int idx, int version,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index a121b1c795..b5cebc9a17 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -291,7 +291,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	return 0;
 
 err_fb_alloc:
-	virtio_gpu_cmd_resource_inval_backing(vgdev, resid);
+	virtio_gpu_object_detach(vgdev, obj);
 err_obj_attach:
 err_obj_vmap:
 	virtio_gpu_gem_free_object(&obj->gem_base);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 11f8ae5b53..3ea115e026 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -377,8 +377,7 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
 
 	if (!new_mem || (new_mem->placement & TTM_PL_FLAG_SYSTEM)) {
 		if (bo->hw_res_handle)
-			virtio_gpu_cmd_resource_inval_backing(vgdev,
-							   bo->hw_res_handle);
+			virtio_gpu_object_detach(vgdev, bo);
 
 	} else if (new_mem->placement & TTM_PL_FLAG_TT) {
 		if (bo->hw_res_handle) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483..af24e91267 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -423,8 +423,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
-void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
-					   uint32_t resource_id)
+static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
+						  uint32_t resource_id)
 {
 	struct virtio_gpu_resource_detach_backing *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -882,6 +882,12 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
+void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
+			      struct virtio_gpu_object *obj)
+{
+	virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle);
+}
+
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
 			    struct virtio_gpu_output *output)
 {
-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

