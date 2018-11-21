Return-Path: virtio-dev-return-4992-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7D78985CB3
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 10:05:40 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 21 Nov 2018 18:03:22 +0800
Message-Id: <20181121100330.24846-6-tiwei.bie@intel.com>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v3 05/13] virtio_ring: introduce debug helpers
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce debug helpers for last_add_time update, check and
invalid. They will be used by packed ring too.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 49 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0b97e5c79654..10d407910aa2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -44,6 +44,26 @@
 	} while (0)
 #define END_USE(_vq) \
 	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; } while(0)
+#define LAST_ADD_TIME_UPDATE(_vq)				\
+	do {							\
+		ktime_t now = ktime_get();			\
+								\
+		/* No kick or get, with .1 second between?  Warn. */ \
+		if ((_vq)->last_add_time_valid)			\
+			WARN_ON(ktime_to_ms(ktime_sub(now,	\
+				(_vq)->last_add_time)) > 100);	\
+		(_vq)->last_add_time = now;			\
+		(_vq)->last_add_time_valid = true;		\
+	} while (0)
+#define LAST_ADD_TIME_CHECK(_vq)				\
+	do {							\
+		if ((_vq)->last_add_time_valid) {		\
+			WARN_ON(ktime_to_ms(ktime_sub(ktime_get(), \
+				      (_vq)->last_add_time)) > 100); \
+		}						\
+	} while (0)
+#define LAST_ADD_TIME_INVALID(_vq)				\
+	((_vq)->last_add_time_valid = false)
 #else
 #define BAD_RING(_vq, fmt, args...)				\
 	do {							\
@@ -53,6 +73,9 @@
 	} while (0)
 #define START_USE(vq)
 #define END_USE(vq)
+#define LAST_ADD_TIME_UPDATE(vq)
+#define LAST_ADD_TIME_CHECK(vq)
+#define LAST_ADD_TIME_INVALID(vq)
 #endif
 
 struct vring_desc_state {
@@ -295,18 +318,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		return -EIO;
 	}
 
-#ifdef DEBUG
-	{
-		ktime_t now = ktime_get();
-
-		/* No kick or get, with .1 second between?  Warn. */
-		if (vq->last_add_time_valid)
-			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
-					    > 100);
-		vq->last_add_time = now;
-		vq->last_add_time_valid = true;
-	}
-#endif
+	LAST_ADD_TIME_UPDATE(vq);
 
 	BUG_ON(total_sg == 0);
 
@@ -467,13 +479,8 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	new = vq->split.avail_idx_shadow;
 	vq->num_added = 0;
 
-#ifdef DEBUG
-	if (vq->last_add_time_valid) {
-		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
-					      vq->last_add_time)) > 100);
-	}
-	vq->last_add_time_valid = false;
-#endif
+	LAST_ADD_TIME_CHECK(vq);
+	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
 		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
@@ -597,9 +604,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 				&vring_used_event(&vq->split.vring),
 				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
 
-#ifdef DEBUG
-	vq->last_add_time_valid = false;
-#endif
+	LAST_ADD_TIME_INVALID(vq);
 
 	END_USE(vq);
 	return ret;
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

