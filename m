Return-Path: virtio-dev-return-4039-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 78BCA58191A2
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 May 2018 21:58:46 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri,  4 May 2018 12:59:15 +0800
Message-Id: <20180504045915.17693-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
To: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces the support for VIRTIO_F_IO_BARRIER.
When this feature is negotiated, driver will use the barriers
suitable for hardware devices.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
This patch depends on below proposal for virtio-spec:
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00019.html

This patch also depends on below patch:
https://lkml.org/lkml/2018/4/19/789

RFC -> v1:
- Address the changes in the proposal;

 drivers/virtio/virtio_ring.c       | 5 +++++
 include/uapi/linux/virtio_config.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 21d464a29cf8..edb565643bf4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -996,6 +996,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	if (virtio_has_feature(vdev, VIRTIO_F_IO_BARRIER))
+		vq->weak_barriers = false;
+
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
@@ -1164,6 +1167,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_IO_BARRIER:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..9fb519a9df28 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		37
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +71,10 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/*
+ * If clear - driver may use barriers suitable for CPU cores.
+ * If set - driver must use barriers suitable for hardware devices.
+ */
+#define VIRTIO_F_IO_BARRIER		36
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.11.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

