Return-Path: virtio-dev-return-4680-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0975C985B2F
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 02:27:45 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 11 Jul 2018 10:27:11 +0800
Message-Id: <20180711022711.7090-6-tiwei.bie@intel.com>
In-Reply-To: <20180711022711.7090-1-tiwei.bie@intel.com>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v2 5/5] virtio_ring: enable packed ring
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/s390/virtio/virtio_ccw.c | 14 ++++++++++++++
 drivers/virtio/virtio_ring.c     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 8f5c1d7f751a..8654f3a94635 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -765,6 +765,17 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	return rc;
 }
 
+static void ccw_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on virtio_ccw for now,
+	 * because virtio_ccw uses some legacy accessors,
+	 * e.g. virtqueue_get_avail() and virtqueue_get_used()
+	 * which aren't available in packed ring currently.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -791,6 +802,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_ccw a chance to accept features. */
+	ccw_transport_features(vdev);
+
 	features->index = 0;
 	features->features = cpu_to_le32((u32)vdev->features);
 	/* Write the first half of the feature bits to the host. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f79a1e17f7d1..807ed4b362c5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1968,6 +1968,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_RING_PACKED:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.18.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

