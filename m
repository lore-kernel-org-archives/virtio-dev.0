Return-Path: virtio-dev-return-7742-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 576BE985ED7
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:17 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:33 -0700
Message-Id: <20200902210847.2689-10-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 09/23] virtio-gpu api: blob resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gerd Hoffmann <kraxel@redhat.com>

A blob resource is a container for:
   - VIRTGPU_BLOB_MEM_GUEST: a guest memory allocation
     (referred to as a "guest-only blob resource")

   - VIRTGPU_BLOB_MEM_HOST3D: a host3d memory allocation
     (referred to as a "host-only blob resource")

   - VIRTGPU_BLOB_MEM_HOST3D_GUEST: a guest + host3d memory allocation
     (referred to as a "default blob resource").

The memory properties of the blob resource must be described by
`blob_mem`.

For default and guest only blob resources set, `nents` guest system
pages are assigned to the resource.  For default blob resources,
these guest pages are used for transfer operations. Attach/detach is
also possible to allow swap-in/swap-out, but isn't required since it
may not be applicable to future blob mem types
(shared guest/guest vram).

Host allocations depend on whether the 3D is supported. If 3D is not
supported, the only valid field for `blob_mem` is
VIRTGPU_BLOB_MEM_GUEST.

If 3D is supported, the virtio-gpu resource is created from the
context local object identified by the `blob_id`. The actual host
allocation done by the EXECBUFFER ioctl or for convenience the
`cmd` field in the RESOURCE_CREATE_BLOB ioctl.

Userspace must specify if the blob resource is intended to be used
for userspace mapping, sharing between virtio-gpu contexts and/or
sharing between virtio devices. This is done via `blob_flags`.

For 3D hosts, both VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D and
VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D may be used to update
the host resource. There is no restriction on the image/buffer
view the guest/host userspace has on the blob resource.

VIRTIO_GPU_CMD_SET_SCANOUT_BLOB / VIRTIO_GPU_CMD_RESOURCE_FLUSH may
be used with blob resources as well.  The modifier is intentionally
left out of SCANOUT_BLOB, and auxilary blobs are also left out
as a simplification.

The use case for blob resources is zero-copy, needed for coherent
memory in virglrenderer. Host only blob resources are not mappable
without the feature described in the next patch, but are shareable.

Future work:
   - Emulated coherent `blob_mem` type for QEMU/vhost-user
   - A `blob_mem` type for guest-only resources imported in
     cache-coherent FOSS GPU/display drivers.
   - Display integration involving the blob model using seamless
     Wayland windows.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Co-developed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Chia-I Wu <olvaffe@gmail.com>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 include/uapi/drm/virtgpu_drm.h  | 37 +++++++++++++++++++++++++++-
 include/uapi/linux/virtio_gpu.h | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.=
h
index f06a789f34cd9..bb224f604c9e3 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -46,6 +46,7 @@ extern "C" {
 #define DRM_VIRTGPU_TRANSFER_TO_HOST 0x07
 #define DRM_VIRTGPU_WAIT     0x08
 #define DRM_VIRTGPU_GET_CAPS  0x09
+#define DRM_VIRTGPU_RESOURCE_CREATE_BLOB 0x0a
=20
 #define VIRTGPU_EXECBUF_FENCE_FD_IN=090x01
 #define VIRTGPU_EXECBUF_FENCE_FD_OUT=090x02
@@ -71,6 +72,7 @@ struct drm_virtgpu_execbuffer {
=20
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
 #define VIRTGPU_PARAM_CAPSET_QUERY_FIX 2 /* do we have the capset fix */
+#define VIRTGPU_PARAM_RESOURCE_BLOB 3 /* DRM_VIRTGPU_RESOURCE_CREATE_BLOB =
*/
=20
 struct drm_virtgpu_getparam {
 =09__u64 param;
@@ -100,7 +102,7 @@ struct drm_virtgpu_resource_info {
 =09__u32 bo_handle;
 =09__u32 res_handle;
 =09__u32 size;
-=09__u32 stride;
+=09__u32 blob_mem;
 };
=20
 struct drm_virtgpu_3d_box {
@@ -117,6 +119,8 @@ struct drm_virtgpu_3d_transfer_to_host {
 =09struct drm_virtgpu_3d_box box;
 =09__u32 level;
 =09__u32 offset;
+=09__u32 stride;
+=09__u32 layer_stride;
 };
=20
 struct drm_virtgpu_3d_transfer_from_host {
@@ -124,6 +128,8 @@ struct drm_virtgpu_3d_transfer_from_host {
 =09struct drm_virtgpu_3d_box box;
 =09__u32 level;
 =09__u32 offset;
+=09__u32 stride;
+=09__u32 layer_stride;
 };
=20
 #define VIRTGPU_WAIT_NOWAIT 1 /* like it */
@@ -140,6 +146,31 @@ struct drm_virtgpu_get_caps {
 =09__u32 pad;
 };
=20
+struct drm_virtgpu_resource_create_blob {
+#define VIRTGPU_BLOB_MEM_GUEST             0x0001
+#define VIRTGPU_BLOB_MEM_HOST3D            0x0002
+#define VIRTGPU_BLOB_MEM_HOST3D_GUEST      0x0003
+
+#define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
+#define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
+#define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+=09/* zero is invalid blob_mem */
+=09__u32 blob_mem;
+=09__u32 blob_flags;
+=09__u32 bo_handle;
+=09__u32 res_handle;
+=09__u64 size;
+
+=09/*
+=09 * for 3D contexts with VIRTGPU_BLOB_MEM_HOST3D_GUEST and
+=09 * VIRTGPU_BLOB_MEM_HOST3D otherwise, must be zero.
+=09 */
+=09__u32 pad;
+=09__u32 cmd_size;
+=09__u64 cmd;
+=09__u64 blob_id;
+};
+
 #define DRM_IOCTL_VIRTGPU_MAP \
 =09DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
=20
@@ -175,6 +206,10 @@ struct drm_virtgpu_get_caps {
 =09DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_GET_CAPS, \
 =09struct drm_virtgpu_get_caps)
=20
+#define DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB=09=09=09=09\
+=09DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_RESOURCE_CREATE_BLOB,=09\
+=09=09struct drm_virtgpu_resource_create_blob)
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gp=
u.h
index 747a5c5cc4e60..4ddf2fe342ed0 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -55,6 +55,11 @@
  */
 #define VIRTIO_GPU_F_RESOURCE_UUID       2
=20
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
+ */
+#define VIRTIO_GPU_F_RESOURCE_BLOB       3
+
 enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_UNDEFINED =3D 0,
=20
@@ -71,6 +76,8 @@ enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_CMD_GET_CAPSET,
 =09VIRTIO_GPU_CMD_GET_EDID,
 =09VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
+=09VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB,
+=09VIRTIO_GPU_CMD_SET_SCANOUT_BLOB,
=20
 =09/* 3d commands */
 =09VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
@@ -359,4 +366,40 @@ struct virtio_gpu_resp_resource_uuid {
 =09__u8 uuid[16];
 };
=20
+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB */
+struct virtio_gpu_resource_create_blob {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09__le32 resource_id;
+#define VIRTIO_GPU_BLOB_MEM_GUEST             0x0001
+#define VIRTIO_GPU_BLOB_MEM_HOST3D            0x0002
+#define VIRTIO_GPU_BLOB_MEM_HOST3D_GUEST      0x0003
+
+#define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
+#define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
+#define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+=09/* zero is invalid blob mem */
+=09__le32 blob_mem;
+=09__le32 blob_flags;
+=09__le64 blob_id;
+=09__le64 size;
+=09__le32 nr_entries;
+=09/*
+=09 * sizeof(nr_entries * virtio_gpu_mem_entry) bytes follow
+=09 */
+};
+
+/* VIRTIO_GPU_CMD_SET_SCANOUT_BLOB */
+struct virtio_gpu_set_scanout_blob {
+=09struct virtio_gpu_ctrl_hdr hdr;
+=09struct virtio_gpu_rect r;
+=09__le32 scanout_id;
+=09__le32 resource_id;
+=09__le32 width;
+=09__le32 height;
+=09__le32 format;
+=09__le32 padding;
+=09__le32 strides[4];
+=09__le32 offsets[4];
+};
+
 #endif
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

