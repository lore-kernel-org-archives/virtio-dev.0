Return-Path: virtio-dev-return-4989-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FB439841EC
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 10:05:31 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 21 Nov 2018 18:03:18 +0800
Message-Id: <20181121100330.24846-2-tiwei.bie@intel.com>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH net-next v3 01/13] virtio: add packed ring types and macros
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add types and macros for packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/uapi/linux/virtio_config.h |  3 +++
 include/uapi/linux/virtio_ring.h   | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 449132c76b1c..1196e1c1d4f6 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -75,6 +75,9 @@
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
 
+/* This feature indicates support for the packed virtqueue layout. */
+#define VIRTIO_F_RING_PACKED		34
+
 /*
  * Does the device support Single Root I/O Virtualization?
  */
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 6d5d5faa989b..2414f8af26b3 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -44,6 +44,13 @@
 /* This means the buffer contains a list of buffer descriptors. */
 #define VRING_DESC_F_INDIRECT	4
 
+/*
+ * Mark a descriptor as available or used in packed ring.
+ * Notice: they are defined as shifts instead of shifted values.
+ */
+#define VRING_PACKED_DESC_F_AVAIL	7
+#define VRING_PACKED_DESC_F_USED	15
+
 /* The Host uses this in used->flags to advise the Guest: don't kick me when
  * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
  * will still kick if it's out of buffers. */
@@ -53,6 +60,23 @@
  * optimization.  */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
 
+/* Enable events in packed ring. */
+#define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
+/* Disable events in packed ring. */
+#define VRING_PACKED_EVENT_FLAG_DISABLE	0x1
+/*
+ * Enable events for a specific descriptor in packed ring.
+ * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
+ * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
+ */
+#define VRING_PACKED_EVENT_FLAG_DESC	0x2
+
+/*
+ * Wrap counter bit shift in event suppression structure
+ * of packed ring.
+ */
+#define VRING_PACKED_EVENT_F_WRAP_CTR	15
+
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC	28
 
@@ -171,4 +195,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
 	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
 }
 
+struct vring_packed_desc_event {
+	/* Descriptor Ring Change Event Offset/Wrap Counter. */
+	__le16 off_wrap;
+	/* Descriptor Ring Change Event Flags. */
+	__le16 flags;
+};
+
+struct vring_packed_desc {
+	/* Buffer Address. */
+	__le64 addr;
+	/* Buffer Length. */
+	__le32 len;
+	/* Buffer ID. */
+	__le16 id;
+	/* The flags depending on descriptor type. */
+	__le16 flags;
+};
+
+struct vring_packed {
+	unsigned int num;
+
+	struct vring_packed_desc *desc;
+
+	struct vring_packed_desc_event *driver;
+
+	struct vring_packed_desc_event *device;
+};
+
 #endif /* _UAPI_LINUX_VIRTIO_RING_H */
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

