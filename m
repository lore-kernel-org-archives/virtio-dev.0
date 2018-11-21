Return-Path: virtio-dev-return-4994-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C5446984180
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 10:05:44 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 21 Nov 2018 18:03:26 +0800
Message-Id: <20181121100330.24846-10-tiwei.bie@intel.com>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v3 09/13] virtio_ring: cache whether we will use DMA API
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Cache whether we will use DMA API, instead of doing the
check every time. We are going to check whether DMA API
is used more often in packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d00a87909a7e..aafe1969b45e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -86,6 +86,9 @@ struct vring_desc_state_split {
 struct vring_virtqueue {
 	struct virtqueue vq;
 
+	/* Is DMA API used? */
+	bool use_dma_api;
+
 	/* Can we use weak barriers? */
 	bool weak_barriers;
 
@@ -262,7 +265,7 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 				   struct scatterlist *sg,
 				   enum dma_data_direction direction)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return (dma_addr_t)sg_phys(sg);
 
 	/*
@@ -279,7 +282,7 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 				   void *cpu_addr, size_t size,
 				   enum dma_data_direction direction)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return (dma_addr_t)virt_to_phys(cpu_addr);
 
 	return dma_map_single(vring_dma_dev(vq),
@@ -289,7 +292,7 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 static int vring_mapping_error(const struct vring_virtqueue *vq,
 			       dma_addr_t addr)
 {
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return 0;
 
 	return dma_mapping_error(vring_dma_dev(vq), addr);
@@ -305,7 +308,7 @@ static void vring_unmap_one_split(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vring_use_dma_api(vq->vq.vdev))
+	if (!vq->use_dma_api)
 		return;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
@@ -1202,6 +1205,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->broken = false;
 	vq->last_used_idx = 0;
 	vq->num_added = 0;
+	vq->use_dma_api = vring_use_dma_api(vdev);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 #ifdef DEBUG
 	vq->in_use = false;
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

