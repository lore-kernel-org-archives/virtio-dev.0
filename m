Return-Path: <virtio-dev-return-8676-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B10659863FE
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Sep 2021 01:08:47 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 16 Sep 2021 18:08:31 -0700
Message-Id: <20210917010842.503-2-gurchetansingh@chromium.org>
In-Reply-To: <20210917010842.503-1-gurchetansingh@chromium.org>
References: <20210917010842.503-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 01/12] virtio-gpu api: multiple context types with explicit initialization
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This feature allows for each virtio-gpu 3D context to be created
with a "context_init" variable.  This variable can specify:

 - the type of protocol used by the context via the capset id.
   This is useful for differentiating virgl, gfxstream, and venus
   protocols by host userspace.

 - other things in the future, such as the version of the context.

In addition, each different context needs one or more timelines, so
for example a virgl context's waiting can be independent on a
gfxstream context's waiting.

VIRTIO_GPU_FLAG_INFO_RING_IDX is introduced to specific to tell the
host which per-context command ring (or "hardware queue", distinct
from the virtio-queue) the fence should be associated with.

The new capability sets (gfxstream, venus etc.) are only defined in
the virtio-gpu spec and not defined in the header.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 include/uapi/linux/virtio_gpu.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gp=
u.h
index 97523a95781d..b0e3d91dfab7 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -59,6 +59,11 @@
  * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
  */
 #define VIRTIO_GPU_F_RESOURCE_BLOB       3
+/*
+ * VIRTIO_GPU_CMD_CREATE_CONTEXT with
+ * context_init and multiple timelines
+ */
+#define VIRTIO_GPU_F_CONTEXT_INIT        4
=20
 enum virtio_gpu_ctrl_type {
 =09VIRTIO_GPU_UNDEFINED =3D 0,
@@ -122,14 +127,20 @@ enum virtio_gpu_shm_id {
 =09VIRTIO_GPU_SHM_ID_HOST_VISIBLE =3D 1
 };
=20
-#define VIRTIO_GPU_FLAG_FENCE (1 << 0)
+#define VIRTIO_GPU_FLAG_FENCE         (1 << 0)
+/*
+ * If the following flag is set, then ring_idx contains the index
+ * of the command ring that needs to used when creating the fence
+ */
+#define VIRTIO_GPU_FLAG_INFO_RING_IDX (1 << 1)
=20
 struct virtio_gpu_ctrl_hdr {
 =09__le32 type;
 =09__le32 flags;
 =09__le64 fence_id;
 =09__le32 ctx_id;
-=09__le32 padding;
+=09u8 ring_idx;
+=09u8 padding[3];
 };
=20
 /* data passed in the cursor vq */
@@ -269,10 +280,11 @@ struct virtio_gpu_resource_create_3d {
 };
=20
 /* VIRTIO_GPU_CMD_CTX_CREATE */
+#define VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK 0x000000ff
 struct virtio_gpu_ctx_create {
 =09struct virtio_gpu_ctrl_hdr hdr;
 =09__le32 nlen;
-=09__le32 padding;
+=09__le32 context_init;
 =09char debug_name[64];
 };
=20
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

