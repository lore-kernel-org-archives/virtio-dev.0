Return-Path: virtio-dev-return-4919-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3623A985A5E
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Oct 2018 06:32:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 07:32:06 +0100
Message-Id: <20181030063206.19528-3-kraxel@redhat.com>
In-Reply-To: <20181030063206.19528-1-kraxel@redhat.com>
References: <20181030063206.19528-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH v4 2/2] drm/virtio: add edid support
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  3 ++
 drivers/gpu/drm/virtio/virtgpu_display.c | 12 ++++++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 67 ++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d29f0c7c76..852078419d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -114,6 +114,7 @@ struct virtio_gpu_output {
 	struct drm_encoder enc;
 	struct virtio_gpu_display_one info;
 	struct virtio_gpu_update_cursor cursor;
+	struct edid *edid;
 	int cur_x;
 	int cur_y;
 	bool enabled;
@@ -204,6 +205,7 @@ struct virtio_gpu_device {
 	spinlock_t ctx_id_idr_lock;
 
 	bool has_virgl_3d;
+	bool has_edid;
 
 	struct work_struct config_changed_work;
 
@@ -298,6 +300,7 @@ int virtio_gpu_cmd_get_capset_info(struct virtio_gpu_device *vgdev, int idx);
 int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 			      int idx, int version,
 			      struct virtio_gpu_drv_cap_cache **cache_p);
+int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
 				   uint32_t nlen, const char *name);
 void virtio_gpu_cmd_context_destroy(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 8f8fed471e..b5580b11a0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -169,6 +169,12 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
 	struct drm_display_mode *mode = NULL;
 	int count, width, height;
 
+	if (output->edid) {
+		count = drm_add_edid_modes(connector, output->edid);
+		if (count)
+			return count;
+	}
+
 	width  = le32_to_cpu(output->info.r.width);
 	height = le32_to_cpu(output->info.r.height);
 	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
@@ -287,6 +293,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,
 			   DRM_MODE_CONNECTOR_VIRTUAL);
 	drm_connector_helper_add(connector, &virtio_gpu_conn_helper_funcs);
+	if (vgdev->has_edid)
+		drm_connector_attach_edid_property(connector);
 
 	drm_encoder_init(dev, encoder, &virtio_gpu_enc_funcs,
 			 DRM_MODE_ENCODER_VIRTUAL, NULL);
@@ -378,6 +386,10 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
 {
+	int i;
+
+	for (i = 0 ; i < vgdev->num_scanouts; ++i)
+		kfree(vgdev->outputs[i].edid);
 	virtio_gpu_fbdev_fini(vgdev);
 	drm_mode_config_cleanup(vgdev->ddev);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index d9287c144f..f7f32a885a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -80,6 +80,7 @@ static unsigned int features[] = {
 	 */
 	VIRTIO_GPU_F_VIRGL,
 #endif
+	VIRTIO_GPU_F_EDID,
 };
 static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 65060c0852..f6cbbb27e4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -44,6 +44,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
 		     events_read, &events_read);
 	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
+		if (vgdev->has_edid)
+			virtio_gpu_cmd_get_edids(vgdev);
 		virtio_gpu_cmd_get_display_info(vgdev);
 		drm_helper_hpd_irq_event(vgdev->ddev);
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
@@ -174,6 +176,10 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 #else
 	DRM_INFO("virgl 3d acceleration not supported by guest\n");
 #endif
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
+		vgdev->has_edid = true;
+		DRM_INFO("EDID support available.\n");
+	}
 
 	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 	if (ret) {
@@ -219,6 +225,8 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 
 	if (num_capsets)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
+	if (vgdev->has_edid)
+		virtio_gpu_cmd_get_edids(vgdev);
 	virtio_gpu_cmd_get_display_info(vgdev);
 	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
 			   5 * HZ);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 4e2e037aed..dd149a59c7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -604,6 +604,45 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 	wake_up(&vgdev->resp_wq);
 }
 
+static int virtio_get_edid_block(void *data, u8 *buf,
+				 unsigned int block, size_t len)
+{
+	struct virtio_gpu_resp_edid *resp = data;
+	size_t start = block * EDID_LENGTH;
+
+	if (start + len > le32_to_cpu(resp->size))
+		return -1;
+	memcpy(buf, resp->edid + start, len);
+	return 0;
+}
+
+static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_vbuffer *vbuf)
+{
+	struct virtio_gpu_cmd_get_edid *cmd =
+		(struct virtio_gpu_cmd_get_edid *)vbuf->buf;
+	struct virtio_gpu_resp_edid *resp =
+		(struct virtio_gpu_resp_edid *)vbuf->resp_buf;
+	uint32_t scanout = le32_to_cpu(cmd->scanout);
+	struct virtio_gpu_output *output;
+	struct edid *new_edid, *old_edid;
+
+	if (scanout >= vgdev->num_scanouts)
+		return;
+	output = vgdev->outputs + scanout;
+
+	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
+
+	spin_lock(&vgdev->display_info_lock);
+	old_edid = output->edid;
+	output->edid = new_edid;
+	drm_connector_update_edid_property(&output->conn, output->edid);
+	spin_unlock(&vgdev->display_info_lock);
+
+	kfree(old_edid);
+	wake_up(&vgdev->resp_wq);
+}
+
 int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_ctrl_hdr *cmd_p;
@@ -706,6 +745,34 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
+int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_cmd_get_edid *cmd_p;
+	struct virtio_gpu_vbuffer *vbuf;
+	void *resp_buf;
+	int scanout;
+
+	if (WARN_ON(!vgdev->has_edid))
+		return -EINVAL;
+
+	for (scanout = 0; scanout < vgdev->num_scanouts; scanout++) {
+		resp_buf = kzalloc(sizeof(struct virtio_gpu_resp_edid),
+				   GFP_KERNEL);
+		if (!resp_buf)
+			return -ENOMEM;
+
+		cmd_p = virtio_gpu_alloc_cmd_resp
+			(vgdev, &virtio_gpu_cmd_get_edid_cb, &vbuf,
+			 sizeof(*cmd_p), sizeof(struct virtio_gpu_resp_edid),
+			 resp_buf);
+		cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_GET_EDID);
+		cmd_p->scanout = cpu_to_le32(scanout);
+		virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	}
+
+	return 0;
+}
+
 void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
 				   uint32_t nlen, const char *name)
 {
-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

