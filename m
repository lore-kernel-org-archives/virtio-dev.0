Return-Path: virtio-dev-return-4898-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74E92985E79
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Oct 2018 06:40:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 18 Oct 2018 08:39:46 +0200
Message-Id: <20181018063946.22919-2-kraxel@redhat.com>
In-Reply-To: <20181018063946.22919-1-kraxel@redhat.com>
References: <20181018063946.22919-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH v3] virtio-gpu: add VIRTIO_GPU_F_EDID feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

The feature allows the guest request an EDID blob (describing monitor
capabilities) for a given scanout (aka virtual monitor connector).

It brings a new command message, which has just a scanout field (beside
the standard virtio-gpu header) and a response message which carries the
EDID data.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index f43c3c6171..68198691a6 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -41,6 +41,7 @@
 #include <linux/types.h>
 
 #define VIRTIO_GPU_F_VIRGL 0
+#define VIRTIO_GPU_F_EDID  1
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
+	VIRTIO_GPU_CMD_GET_EDID,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
+	VIRTIO_GPU_RESP_OK_EDID,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -291,6 +294,19 @@ struct virtio_gpu_resp_capset {
 	__u8 capset_data[];
 };
 
+/* VIRTIO_GPU_CMD_GET_EDID */
+struct virtio_gpu_cmd_get_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 scanout;
+};
+
+/* VIRTIO_GPU_RESP_OK_EDID */
+struct virtio_gpu_resp_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 size;
+	__u8 edid[1024];
+};
+
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

