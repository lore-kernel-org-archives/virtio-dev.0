Return-Path: <virtio-dev-return-8647-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A20E9864E1
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Sep 2021 01:37:25 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  8 Sep 2021 18:37:07 -0700
Message-Id: <20210909013717.861-3-gurchetansingh@chromium.org>
In-Reply-To: <20210909013717.861-1-gurchetansingh@chromium.org>
References: <20210909013717.861-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 02/12] drm/virtgpu api: create context init feature
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This change allows creating contexts of depending on set of
context parameters.  The meaning of each of the parameters
is listed below:

1) VIRTGPU_CONTEXT_PARAM_CAPSET_ID

This determines the type of a context based on the capability set
ID.  For example, the current capsets:

VIRTIO_GPU_CAPSET_VIRGL
VIRTIO_GPU_CAPSET_VIRGL2

define a Gallium, TGSI based "virgl" context.  We only need 1 capset
ID per context type, though virgl has two due a bug that has since
been fixed.

The use case is the "gfxstream" rendering library and "venus"
renderer.

gfxstream doesn't do Gallium/TGSI translation and mostly relies on
auto-generated API streaming.  Certain users prefer gfxstream over
virgl for GLES on GLES emulation.  {gfxstream vk}/{venus} are also
required for Vulkan emulation.  The maximum capset ID is 63.

The goal is for guest userspace to choose the optimal context type
depending on the situation/hardware.

2) VIRTGPU_CONTEXT_PARAM_NUM_RINGS

This tells the number of independent command rings that the context
will use.  This value may be zero and is inferred to be zero if
VIRTGPU_CONTEXT_PARAM_NUM_RINGS is not passed in.  This is for backwards
compatibility for virgl, which has one big giant command ring for all
commands.

The maxiumum number of rings is 64.  In practice, multi-queue or
multi-ring submission is used for powerful dGPUs and virtio-gpu
may not be the best option in that case (see PCI passthrough or
rendernode forwarding).

3) VIRTGPU_CONTEXT_PARAM_POLL_RING_IDX_MASK

This is a mask of ring indices for which the DRM fd is pollable.
For example, if VIRTGPU_CONTEXT_PARAM_NUM_RINGS is 2, then the mask
may be:

[ring idx]  |  [1 << ring_idx] | final mask
-------------------------------------------
    0              1                1
    1              2                3

The "Sommelier" guest Wayland proxy uses this to poll for events
from the host compositor.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
Acked-by: Nicholas Verne <nverne@chromium.org>
---
 include/uapi/drm/virtgpu_drm.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.=
h
index b9ec26e9c646..a13e20cc66b4 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -47,12 +47,15 @@ extern "C" {
 #define DRM_VIRTGPU_WAIT     0x08
 #define DRM_VIRTGPU_GET_CAPS  0x09
 #define DRM_VIRTGPU_RESOURCE_CREATE_BLOB 0x0a
+#define DRM_VIRTGPU_CONTEXT_INIT 0x0b
=20
 #define VIRTGPU_EXECBUF_FENCE_FD_IN=090x01
 #define VIRTGPU_EXECBUF_FENCE_FD_OUT=090x02
+#define VIRTGPU_EXECBUF_RING_IDX=090x04
 #define VIRTGPU_EXECBUF_FLAGS  (\
 =09=09VIRTGPU_EXECBUF_FENCE_FD_IN |\
 =09=09VIRTGPU_EXECBUF_FENCE_FD_OUT |\
+=09=09VIRTGPU_EXECBUF_RING_IDX |\
 =09=090)
=20
 struct drm_virtgpu_map {
@@ -68,6 +71,8 @@ struct drm_virtgpu_execbuffer {
 =09__u64 bo_handles;
 =09__u32 num_bo_handles;
 =09__s32 fence_fd; /* in/out fence fd (see VIRTGPU_EXECBUF_FENCE_FD_IN/OUT=
) */
+=09__u32 ring_idx; /* command ring index (see VIRTGPU_EXECBUF_RING_IDX) */
+=09__u32 pad;
 };
=20
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
@@ -75,6 +80,8 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_RESOURCE_BLOB 3 /* DRM_VIRTGPU_RESOURCE_CREATE_BLOB =
*/
 #define VIRTGPU_PARAM_HOST_VISIBLE 4 /* Host blob resources are mappable *=
/
 #define VIRTGPU_PARAM_CROSS_DEVICE 5 /* Cross virtio-device resource shari=
ng  */
+#define VIRTGPU_PARAM_CONTEXT_INIT 6 /* DRM_VIRTGPU_CONTEXT_INIT */
+#define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capab=
ility set ids */
=20
 struct drm_virtgpu_getparam {
 =09__u64 param;
@@ -173,6 +180,22 @@ struct drm_virtgpu_resource_create_blob {
 =09__u64 blob_id;
 };
=20
+#define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
+#define VIRTGPU_CONTEXT_PARAM_NUM_RINGS       0x0002
+#define VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK 0x0003
+struct drm_virtgpu_context_set_param {
+=09__u64 param;
+=09__u64 value;
+};
+
+struct drm_virtgpu_context_init {
+=09__u32 num_params;
+=09__u32 pad;
+
+=09/* pointer to drm_virtgpu_context_set_param array */
+=09__u64 ctx_set_params;
+};
+
 #define DRM_IOCTL_VIRTGPU_MAP \
 =09DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
=20
@@ -212,6 +235,10 @@ struct drm_virtgpu_resource_create_blob {
 =09DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_RESOURCE_CREATE_BLOB,=09\
 =09=09struct drm_virtgpu_resource_create_blob)
=20
+#define DRM_IOCTL_VIRTGPU_CONTEXT_INIT=09=09=09=09=09\
+=09DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_CONTEXT_INIT,=09=09\
+=09=09struct drm_virtgpu_context_init)
+
 #if defined(__cplusplus)
 }
 #endif
--=20
2.33.0.153.gba50c8fa24-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

