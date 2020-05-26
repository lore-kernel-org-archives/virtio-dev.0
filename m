Return-Path: virtio-dev-return-7398-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1643F985B46
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 May 2020 10:59:39 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Tue, 26 May 2020 19:58:10 +0900
Message-Id: <20200526105811.30784-3-stevensd@chromium.org>
In-Reply-To: <20200526105811.30784-1-stevensd@chromium.org>
References: <20200526105811.30784-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 2/3] virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This feature allows the guest to request a UUID from the host for a
particular virtio_gpu resource. The UUID can then be shared with other
virtio devices, to allow the other host devices to access the
virtio_gpu's corresponding host resource.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 include/uapi/linux/virtio_gpu.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gp=
u.h
index 0c85914d9369..9721d58b4d58 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -50,6 +50,10 @@
  * VIRTIO_GPU_CMD_GET_EDID
  */
 #define VIRTIO_GPU_F_EDID                1
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
+ */
+#define VIRTIO_GPU_F_RESOURCE_UUID       2
=20
 enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_UNDEFINED =3D 0,
@@ -66,6 +70,7 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 =09VIRTIO_GPU_CMD_GET_CAPSET,
 =09VIRTIO_GPU_CMD_GET_EDID,
+=09VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
=20
 =09/* 3d commands */
 =09VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
@@ -87,6 +92,7 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 =09VIRTIO_GPU_RESP_OK_CAPSET,
 =09VIRTIO_GPU_RESP_OK_EDID,
+=09VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
=20
 =09/* error responses */
 =09VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
@@ -340,4 +346,17 @@ enum virtio_gpu_formats {
 =09VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  =3D 134,
 };
=20
+/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
+struct virtio_gpu_resource_assign_uuid {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__le32 resource_id;
+=09__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_UUID */
+struct virtio_gpu_resp_resource_uuid {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__u8 uuid[16];
+};
+
 #endif
--=20
2.27.0.rc0.183.gde8f92d652-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

