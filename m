Return-Path: <virtio-dev-return-8696-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2293B986369
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Sep 2021 23:20:39 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 21 Sep 2021 16:20:18 -0700
Message-Id: <20210921232024.817-7-gurchetansingh@chromium.org>
In-Reply-To: <20210921232024.817-1-gurchetansingh@chromium.org>
References: <20210921232024.817-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 06/12] drm/virtio: implement context init: track {ring_idx, emit_fence_info} in virtio_gpu_fence
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Each fence should be associated with a [fence ID, fence_context,
seqno].  The seqno number is just the fence id.

To get the fence context, we add the ring_idx to the 3D context's
base_fence_ctx.  The ring_idx is between 0 and 31, inclusive.

Each 3D context will have it's own base_fence_ctx. The ring_idx will
be emitted to host userspace, when emit_fence_info is true.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 9996abf60e3a..401aec1a5efb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -139,7 +139,9 @@ struct virtio_gpu_fence_driver {
=20
 struct virtio_gpu_fence {
 =09struct dma_fence f;
+=09uint32_t ring_idx;
 =09uint64_t fence_id;
+=09bool emit_fence_info;
 =09struct virtio_gpu_fence_driver *drv;
 =09struct list_head node;
 };
--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

