Return-Path: virtio-dev-return-4998-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53C03985CE0
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 10:05:57 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 21 Nov 2018 18:03:29 +0800
Message-Id: <20181121100330.24846-13-tiwei.bie@intel.com>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v3 12/13] virtio_ring: disable packed ring on unsupported transports
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Currently, ccw, vop and remoteproc need some legacy virtio
APIs to create or access virtio rings, which are not supported
by packed ring. So disable packed ring on these transports
for now.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/misc/mic/vop/vop_main.c        | 13 +++++++++++++
 drivers/remoteproc/remoteproc_virtio.c | 13 +++++++++++++
 drivers/s390/virtio/virtio_ccw.c       | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 3633202e18f4..6b212c8b78e7 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -129,6 +129,16 @@ static u64 vop_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+static void vop_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on virtio_vop for now,
+	 * because virtio_vop uses vring_new_virtqueue() which
+	 * creates virtio rings on preallocated memory.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int vop_finalize_features(struct virtio_device *vdev)
 {
 	unsigned int i, bits;
@@ -141,6 +151,9 @@ static int vop_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_vop a chance to accept features. */
+	vop_transport_features(vdev);
+
 	memset_io(out_features, 0, feature_len);
 	bits = min_t(unsigned, feature_len,
 		     sizeof(vdev->features)) * 8;
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index de21f620b882..183fc42a510a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -214,6 +214,16 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
 	return rsc->dfeatures;
 }
 
+static void rproc_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on remoteproc for now,
+	 * because remoteproc uses vring_new_virtqueue() which
+	 * creates virtio rings on preallocated memory.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int rproc_virtio_finalize_features(struct virtio_device *vdev)
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
@@ -224,6 +234,9 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features */
 	vring_transport_features(vdev);
 
+	/* Give virtio_rproc a chance to accept features. */
+	rproc_transport_features(vdev);
+
 	/* Make sure we don't have any features > 32 bits! */
 	BUG_ON((u32)vdev->features != vdev->features);
 
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 97b6f197f007..406d1f64ad65 100644
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
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

