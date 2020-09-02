Return-Path: virtio-dev-return-7743-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25EAD985ED3
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:21 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:34 -0700
Message-Id: <20200902210847.2689-11-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 10/23] virtio-gpu api: host visible feature
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gerd Hoffmann <kraxel@redhat.com>

This patch adds a new virtgpu feature that allows directly
mapping host allocated resources.

This is based on virtio shared memory regions, which allows
querying for memory regions using PCI transport. Each shared
memory region has an associated "shmid", the meaning of which
is device specific.

For virtio-gpu, we can define the shared memory region with id
VIRTIO_GPU_SHM_ID_HOST_VISIBLE to be the "host visible memory
region".

The presence of the host visible memory region means the following
hypercalls are supported:

1) VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB

This hypercall tells the host to inject the host resource's
mapping in an offset into virtio-gpu's PCI address space.
This is typically done via KVM_SET_USER_MEMORY_REGION on Linux
hosts.

On success, VIRTIO_GPU_RESP_OK_MAP_INFO is returned, which
specifies the host buffer's caching type and possibly in the
future performance hints about the buffer..

2) VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB

This hypercall tells the host to remove the host resource's
mapping from the guest VM.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Co-developed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 include/uapi/drm/virtgpu_drm.h  |  1 +
 include/uapi/linux/virtio_gpu.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.=
h
index bb224f604c9e3..e1b1518f9acc5 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -73,6 +73,7 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
 #define VIRTGPU_PARAM_CAPSET_QUERY_FIX 2 /* do we have the capset fix */
 #define VIRTGPU_PARAM_RESOURCE_BLOB 3 /* DRM_VIRTGPU_RESOURCE_CREATE_BLOB =
*/
+#define VIRTGPU_PARAM_HOST_VISIBLE 4 /* Host blob resources are mappable *=
/
=20
 struct drm_virtgpu_getparam {
 =09__u64 param;
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gp=
u.h
index 4ddf2fe342ed0..fa2ae4a1da5f9 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -88,6 +88,8 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
 =09VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D,
 =09VIRTIO_GPU_CMD_SUBMIT_3D,
+=09VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
+=09VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
=20
 =09/* cursor commands */
 =09VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
@@ -100,6 +102,7 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_RESP_OK_CAPSET,
 =09VIRTIO_GPU_RESP_OK_EDID,
 =09VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
+=09VIRTIO_GPU_RESP_OK_MAP_INFO,
=20
 =09/* error responses */
 =09VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
@@ -110,6 +113,11 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
 };
=20
+enum virtio_gpu_shm_id {
+=09VIRTIO_GPU_SHM_ID_UNDEFINED =3D 0,
+=09VIRTIO_GPU_SHM_ID_HOST_VISIBLE =3D 1
+};
+
 #define VIRTIO_GPU_FLAG_FENCE (1 << 0)
=20
 struct virtio_gpu_ctrl_hdr {
@@ -402,4 +410,31 @@ struct virtio_gpu_set_scanout_blob {
 =09__le32 offsets[4];
 };
=20
+/* VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB */
+struct virtio_gpu_resource_map_blob {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__le32 resource_id;
+=09__le32 padding;
+=09__le64 offset;
+};
+
+/* VIRTIO_GPU_RESP_OK_MAP_INFO */
+#define VIRTIO_GPU_MAP_CACHE_MASK     0x0f
+#define VIRTIO_GPU_MAP_CACHE_NONE     0x00
+#define VIRTIO_GPU_MAP_CACHE_CACHED   0x01
+#define VIRTIO_GPU_MAP_CACHE_UNCACHED 0x02
+#define VIRTIO_GPU_MAP_CACHE_WC       0x03
+struct virtio_gpu_resp_map_info {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__u32 map_info;
+=09__u32 padding;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB */
+struct virtio_gpu_resource_unmap_blob {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__le32 resource_id;
+=09__le32 padding;
+};
+
 #endif
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

