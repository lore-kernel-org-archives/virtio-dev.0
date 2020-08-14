Return-Path: virtio-dev-return-7642-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D94F2985DC2
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:16 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:39 -0700
Message-Id: <20200814024000.2485-4-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 03/24] virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: David Stevens <stevensd@chromium.org>

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
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

