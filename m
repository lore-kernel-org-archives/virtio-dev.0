Return-Path: virtio-dev-return-4650-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82400985BEA
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Jul 2018 07:23:07 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon,  9 Jul 2018 15:22:40 +0800
Message-Id: <20180709072241.8886-5-tiwei.bie@intel.com>
In-Reply-To: <20180709072241.8886-1-tiwei.bie@intel.com>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v1 4/5] virtio_ring: add event idx support in packed ring
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This commit introduces the EVENT_IDX support in packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 73 ++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cb833a82054b..4b3f9e1a3cab 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1050,7 +1050,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 flags;
+	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	u32 snapshot;
 
@@ -1059,9 +1059,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	 * suppressions. */
 	virtio_mb(vq->weak_barriers);
 
+	old = vq->next_avail_idx - vq->num_added;
+	new = vq->next_avail_idx;
+	vq->num_added = 0;
+
 	snapshot = *(u32 *)vq->vring_packed.device;
+	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
 	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
 
+	wrap_counter = off_wrap >> 15;
+	event_idx = off_wrap & ~(1 << 15);
+	if (wrap_counter != vq->avail_wrap_counter)
+		event_idx -= vq->vring_packed.num;
+
 #ifdef DEBUG
 	if (vq->last_add_time_valid) {
 		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
@@ -1070,7 +1080,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	vq->last_add_time_valid = false;
 #endif
 
-	needs_kick = (flags != VRING_EVENT_F_DISABLE);
+	if (flags == VRING_EVENT_F_DESC)
+		needs_kick = vring_need_event(event_idx, new, old);
+	else
+		needs_kick = (flags != VRING_EVENT_F_DISABLE);
 	END_USE(vq);
 	return needs_kick;
 }
@@ -1185,6 +1198,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	ret = vq->desc_state_packed[id].data;
 	detach_buf_packed(vq, id, ctx);
 
+	/* If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call. */
+	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->vring_packed.driver->off_wrap,
+				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
+					((u16)vq->used_wrap_counter << 15)));
+
 #ifdef DEBUG
 	vq->last_add_time_valid = false;
 #endif
@@ -1213,8 +1235,18 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
 
+	if (vq->event) {
+		vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
+				vq->last_used_idx |
+				((u16)vq->used_wrap_counter << 15));
+		/* We need to update event offset and event wrap
+		 * counter first before updating event flags. */
+		virtio_wmb(vq->weak_barriers);
+	}
+
 	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
-		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
+						     VRING_EVENT_F_ENABLE;
 		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
 							vq->event_flags_shadow);
 	}
@@ -1238,22 +1270,47 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned off_wrap)
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 bufs, used_idx, wrap_counter;
 
 	START_USE(vq);
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
 
+	if (vq->event) {
+		/* TODO: tune this threshold */
+		bufs = (vq->vring_packed.num - _vq->num_free) * 3 / 4;
+		wrap_counter = vq->used_wrap_counter;
+
+		used_idx = vq->last_used_idx + bufs;
+		if (used_idx >= vq->vring_packed.num) {
+			used_idx -= vq->vring_packed.num;
+			wrap_counter ^= 1;
+		}
+
+		vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
+				used_idx | (wrap_counter << 15));
+
+		/* We need to update event offset and event wrap
+		 * counter first before updating event flags. */
+		virtio_wmb(vq->weak_barriers);
+	} else {
+		used_idx = vq->last_used_idx;
+		wrap_counter = vq->used_wrap_counter;
+	}
+
 	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
-		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
+						     VRING_EVENT_F_ENABLE;
 		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
 							vq->event_flags_shadow);
-		/* We need to enable interrupts first before re-checking
-		 * for more used buffers. */
-		virtio_mb(vq->weak_barriers);
 	}
 
-	if (more_used_packed(vq)) {
+	/* We need to update event suppression structure first
+	 * before re-checking for more used buffers. */
+	virtio_mb(vq->weak_barriers);
+
+	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
 		END_USE(vq);
 		return false;
 	}
-- 
2.18.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

