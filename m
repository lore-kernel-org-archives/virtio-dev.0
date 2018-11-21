Return-Path: virtio-dev-return-4999-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B5EC985CB4
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 10:05:43 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 21 Nov 2018 18:03:25 +0800
Message-Id: <20181121100330.24846-9-tiwei.bie@intel.com>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v3 08/13] virtio_ring: extract split ring handling from ring creation
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce a specific function to create the split ring.
And also move the DMA allocation and size information to
the .split sub-structure.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 220 ++++++++++++++++++++++++-------------------
 1 file changed, 121 insertions(+), 99 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index acd851f3105c..d00a87909a7e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -118,6 +118,10 @@ struct vring_virtqueue {
 
 		/* Per-descriptor state. */
 		struct vring_desc_state_split *desc_state;
+
+		/* DMA, allocation, and size information */
+		size_t queue_size_in_bytes;
+		dma_addr_t queue_dma_addr;
 	} split;
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
@@ -125,8 +129,6 @@ struct vring_virtqueue {
 
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
-	size_t queue_size_in_bytes;
-	dma_addr_t queue_dma_addr;
 
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
@@ -203,6 +205,48 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	return false;
 }
 
+static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
+			      dma_addr_t *dma_handle, gfp_t flag)
+{
+	if (vring_use_dma_api(vdev)) {
+		return dma_alloc_coherent(vdev->dev.parent, size,
+					  dma_handle, flag);
+	} else {
+		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
+
+		if (queue) {
+			phys_addr_t phys_addr = virt_to_phys(queue);
+			*dma_handle = (dma_addr_t)phys_addr;
+
+			/*
+			 * Sanity check: make sure we dind't truncate
+			 * the address.  The only arches I can find that
+			 * have 64-bit phys_addr_t but 32-bit dma_addr_t
+			 * are certain non-highmem MIPS and x86
+			 * configurations, but these configurations
+			 * should never allocate physical pages above 32
+			 * bits, so this is fine.  Just in case, throw a
+			 * warning and abort if we end up with an
+			 * unrepresentable address.
+			 */
+			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+				free_pages_exact(queue, PAGE_ALIGN(size));
+				return NULL;
+			}
+		}
+		return queue;
+	}
+}
+
+static void vring_free_queue(struct virtio_device *vdev, size_t size,
+			     void *queue, dma_addr_t dma_handle)
+{
+	if (vring_use_dma_api(vdev))
+		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
+	else
+		free_pages_exact(queue, PAGE_ALIGN(size));
+}
+
 /*
  * The DMA ops on various arches are rather gnarly right now, and
  * making all of the arch DMA ops work on the vring device itself
@@ -730,6 +774,68 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static struct virtqueue *vring_create_virtqueue_split(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool context,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name)
+{
+	struct virtqueue *vq;
+	void *queue = NULL;
+	dma_addr_t dma_addr;
+	size_t queue_size_in_bytes;
+	struct vring vring;
+
+	/* We assume num is a power of 2. */
+	if (num & (num - 1)) {
+		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
+		return NULL;
+	}
+
+	/* TODO: allocate each queue chunk individually */
+	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
+		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+					  &dma_addr,
+					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
+		if (queue)
+			break;
+	}
+
+	if (!num)
+		return NULL;
+
+	if (!queue) {
+		/* Try to get a single page. You are my only hope! */
+		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
+	}
+	if (!queue)
+		return NULL;
+
+	queue_size_in_bytes = vring_size(num, vring_align);
+	vring_init(&vring, num, queue, vring_align);
+
+	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
+				   notify, callback, name);
+	if (!vq) {
+		vring_free_queue(vdev, queue_size_in_bytes, queue,
+				 dma_addr);
+		return NULL;
+	}
+
+	to_vvq(vq)->split.queue_dma_addr = dma_addr;
+	to_vvq(vq)->split.queue_size_in_bytes = queue_size_in_bytes;
+	to_vvq(vq)->we_own_ring = true;
+
+	return vq;
+}
+
 
 /*
  * Generic functions and exported symbols.
@@ -1091,8 +1197,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
 	vq->we_own_ring = false;
-	vq->queue_dma_addr = 0;
-	vq->queue_size_in_bytes = 0;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
@@ -1108,6 +1212,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	vq->split.queue_dma_addr = 0;
+	vq->split.queue_size_in_bytes = 0;
+
 	vq->split.vring = vring;
 	vq->split.avail_flags_shadow = 0;
 	vq->split.avail_idx_shadow = 0;
@@ -1138,48 +1245,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
-static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-			      dma_addr_t *dma_handle, gfp_t flag)
-{
-	if (vring_use_dma_api(vdev)) {
-		return dma_alloc_coherent(vdev->dev.parent, size,
-					  dma_handle, flag);
-	} else {
-		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
-		if (queue) {
-			phys_addr_t phys_addr = virt_to_phys(queue);
-			*dma_handle = (dma_addr_t)phys_addr;
-
-			/*
-			 * Sanity check: make sure we dind't truncate
-			 * the address.  The only arches I can find that
-			 * have 64-bit phys_addr_t but 32-bit dma_addr_t
-			 * are certain non-highmem MIPS and x86
-			 * configurations, but these configurations
-			 * should never allocate physical pages above 32
-			 * bits, so this is fine.  Just in case, throw a
-			 * warning and abort if we end up with an
-			 * unrepresentable address.
-			 */
-			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
-				free_pages_exact(queue, PAGE_ALIGN(size));
-				return NULL;
-			}
-		}
-		return queue;
-	}
-}
-
-static void vring_free_queue(struct virtio_device *vdev, size_t size,
-			     void *queue, dma_addr_t dma_handle)
-{
-	if (vring_use_dma_api(vdev)) {
-		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
-	} else {
-		free_pages_exact(queue, PAGE_ALIGN(size));
-	}
-}
-
 struct virtqueue *vring_create_virtqueue(
 	unsigned int index,
 	unsigned int num,
@@ -1192,54 +1257,9 @@ struct virtqueue *vring_create_virtqueue(
 	void (*callback)(struct virtqueue *),
 	const char *name)
 {
-	struct virtqueue *vq;
-	void *queue = NULL;
-	dma_addr_t dma_addr;
-	size_t queue_size_in_bytes;
-	struct vring vring;
-
-	/* We assume num is a power of 2. */
-	if (num & (num - 1)) {
-		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
-		return NULL;
-	}
-
-	/* TODO: allocate each queue chunk individually */
-	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr,
-					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
-		if (queue)
-			break;
-	}
-
-	if (!num)
-		return NULL;
-
-	if (!queue) {
-		/* Try to get a single page. You are my only hope! */
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
-	}
-	if (!queue)
-		return NULL;
-
-	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
-
-	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
-				   notify, callback, name);
-	if (!vq) {
-		vring_free_queue(vdev, queue_size_in_bytes, queue,
-				 dma_addr);
-		return NULL;
-	}
-
-	to_vvq(vq)->queue_dma_addr = dma_addr;
-	to_vvq(vq)->queue_size_in_bytes = queue_size_in_bytes;
-	to_vvq(vq)->we_own_ring = true;
-
-	return vq;
+	return vring_create_virtqueue_split(index, num, vring_align,
+			vdev, weak_barriers, may_reduce_num,
+			context, notify, callback, name);
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
@@ -1266,8 +1286,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->we_own_ring) {
-		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
-				 vq->split.vring.desc, vq->queue_dma_addr);
+		vring_free_queue(vq->vq.vdev,
+				 vq->split.queue_size_in_bytes,
+				 vq->split.vring.desc,
+				 vq->split.queue_dma_addr);
 		kfree(vq->split.desc_state);
 	}
 	list_del(&_vq->list);
@@ -1343,7 +1365,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 
 	BUG_ON(!vq->we_own_ring);
 
-	return vq->queue_dma_addr;
+	return vq->split.queue_dma_addr;
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
 
@@ -1353,7 +1375,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
 
 	BUG_ON(!vq->we_own_ring);
 
-	return vq->queue_dma_addr +
+	return vq->split.queue_dma_addr +
 		((char *)vq->split.vring.avail - (char *)vq->split.vring.desc);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
@@ -1364,7 +1386,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 
 	BUG_ON(!vq->we_own_ring);
 
-	return vq->queue_dma_addr +
+	return vq->split.queue_dma_addr +
 		((char *)vq->split.vring.used - (char *)vq->split.vring.desc);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

