Return-Path: virtio-dev-return-4993-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF995985CB0
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 10:05:41 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 21 Nov 2018 18:03:23 +0800
Message-Id: <20181121100330.24846-7-tiwei.bie@intel.com>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v3 06/13] virtio_ring: introduce helper for indirect feature
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce a helper to check whether we will use indirect
feature. It will be used by packed ring too.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 10d407910aa2..d1076f28c7e9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -145,6 +145,18 @@ struct vring_virtqueue {
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
+					  unsigned int total_sg)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	/*
+	 * If the host supports indirect descriptor tables, and we have multiple
+	 * buffers, then go indirect. FIXME: tune this threshold
+	 */
+	return (vq->indirect && total_sg > 1 && vq->vq.num_free);
+}
+
 /*
  * Modern virtio devices have feature bits to specify whether they need a
  * quirk and bypass the IOMMU. If not there, just use the DMA API.
@@ -324,9 +336,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	/* If the host supports indirect descriptor tables, and we have multiple
-	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
+	if (virtqueue_use_indirect(_vq, total_sg))
 		desc = alloc_indirect_split(_vq, total_sg, gfp);
 	else {
 		desc = NULL;
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

