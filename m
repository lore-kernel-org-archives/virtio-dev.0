Return-Path: <virtio-dev-return-8604-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B626B983F8E
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Aug 2021 02:05:09 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 25 Aug 2021 19:04:51 -0700
Message-Id: <20210826020455.1081-9-gurchetansingh@chromium.org>
In-Reply-To: <20210826020455.1081-1-gurchetansingh@chromium.org>
References: <20210826020455.1081-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 08/12] drm/virtio: implement context init: stop using drv->context when creating fence
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The plumbing is all here to do this.  Since we always use the
default fence context when allocating a fence, this makes no
functional difference.

We can't process just the largest fence id anymore, since it's
it's associated with different timelines.  It's fine for fence_id
260 to signal before 259.  As such, process each fence_id
individually.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Lingfeng Yang <lfy@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_fence.c | 16 ++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 15 +++------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virti=
o/virtgpu_fence.c
index 24c728b65d21..dbb29f99ead0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -75,20 +75,25 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct =
virtio_gpu_device *vgdev,
 =09=09=09=09=09=09uint64_t base_fence_ctx,
 =09=09=09=09=09=09uint32_t ring_idx)
 {
+=09uint64_t fence_context =3D base_fence_ctx + ring_idx;
 =09struct virtio_gpu_fence_driver *drv =3D &vgdev->fence_drv;
 =09struct virtio_gpu_fence *fence =3D kzalloc(sizeof(struct virtio_gpu_fen=
ce),
 =09=09=09=09=09=09=09GFP_KERNEL);
+
 =09if (!fence)
 =09=09return fence;
=20
 =09fence->drv =3D drv;
+=09fence->ring_idx =3D ring_idx;
+=09fence->emit_fence_info =3D !(base_fence_ctx =3D=3D drv->context);
=20
 =09/* This only partially initializes the fence because the seqno is
 =09 * unknown yet.  The fence must not be used outside of the driver
 =09 * until virtio_gpu_fence_emit is called.
 =09 */
-=09dma_fence_init(&fence->f, &virtio_gpu_fence_ops, &drv->lock, drv->conte=
xt,
-=09=09       0);
+
+=09dma_fence_init(&fence->f, &virtio_gpu_fence_ops, &drv->lock,
+=09=09       fence_context, 0);
=20
 =09return fence;
 }
@@ -110,6 +115,13 @@ void virtio_gpu_fence_emit(struct virtio_gpu_device *v=
gdev,
=20
 =09cmd_hdr->flags |=3D cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
 =09cmd_hdr->fence_id =3D cpu_to_le64(fence->fence_id);
+
+=09/* Only currently defined fence param. */
+=09if (fence->emit_fence_info) {
+=09=09cmd_hdr->flags |=3D
+=09=09=09cpu_to_le32(VIRTIO_GPU_FLAG_INFO_RING_IDX);
+=09=09cmd_hdr->info =3D cpu_to_le32(fence->ring_idx);
+=09}
 }
=20
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 496f8ce4cd41..938331554632 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -205,7 +205,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *w=
ork)
 =09struct list_head reclaim_list;
 =09struct virtio_gpu_vbuffer *entry, *tmp;
 =09struct virtio_gpu_ctrl_hdr *resp;
-=09u64 fence_id =3D 0;
+=09u64 fence_id;
=20
 =09INIT_LIST_HEAD(&reclaim_list);
 =09spin_lock(&vgdev->ctrlq.qlock);
@@ -232,23 +232,14 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct =
*work)
 =09=09=09=09DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
 =09=09}
 =09=09if (resp->flags & cpu_to_le32(VIRTIO_GPU_FLAG_FENCE)) {
-=09=09=09u64 f =3D le64_to_cpu(resp->fence_id);
-
-=09=09=09if (fence_id > f) {
-=09=09=09=09DRM_ERROR("%s: Oops: fence %llx -> %llx\n",
-=09=09=09=09=09  __func__, fence_id, f);
-=09=09=09} else {
-=09=09=09=09fence_id =3D f;
-=09=09=09}
+=09=09=09fence_id =3D le64_to_cpu(resp->fence_id);
+=09=09=09virtio_gpu_fence_event_process(vgdev, fence_id);
 =09=09}
 =09=09if (entry->resp_cb)
 =09=09=09entry->resp_cb(vgdev, entry);
 =09}
 =09wake_up(&vgdev->ctrlq.ack_queue);
=20
-=09if (fence_id)
-=09=09virtio_gpu_fence_event_process(vgdev, fence_id);
-
 =09list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
 =09=09if (entry->objs)
 =09=09=09virtio_gpu_array_put_free_delayed(vgdev, entry->objs);
--=20
2.33.0.259.gc128427fd7-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

