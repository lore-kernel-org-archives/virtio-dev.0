Return-Path: virtio-dev-return-5142-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7367985DCD
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Dec 2018 18:08:38 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri,  7 Dec 2018 16:48:41 +0800
Message-Id: <20181207084842.13133-3-tiwei.bie@intel.com>
In-Reply-To: <20181207084842.13133-1-tiwei.bie@intel.com>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [RFC 2/3] virtio_ring: add VIRTIO_RING_NO_LEGACY
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce VIRTIO_RING_NO_LEGACY to support disabling legacy
macros and layout definitions.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
VRING_AVAIL_ALIGN_SIZE, VRING_USED_ALIGN_SIZE and VRING_DESC_ALIGN_SIZE
are not pre-virtio 1.0, but can also be disabled by VIRTIO_RING_NO_LEGACY
in this patch, because their names are not consistent with other names.
Not sure whether this is a good idea. If we want this, we may also want
to define _SPLIT_ version for them.

 include/uapi/linux/virtio_ring.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9b0c0d92ab62..192573827850 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -37,6 +37,7 @@
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 
+#ifndef VIRTIO_RING_NO_LEGACY
 /*
  * Notice: unlike other _F_ flags, below flags are defined as shifted
  * values instead of shifts for compatibility.
@@ -51,6 +52,7 @@
 #define VRING_USED_F_NO_NOTIFY	1
 /* Same as VRING_SPLIT_AVAIL_F_NO_INTERRUPT. */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
+#endif /* VIRTIO_RING_NO_LEGACY */
 
 /* Mark a buffer as continuing via the next field in split ring. */
 #define VRING_SPLIT_DESC_F_NEXT		0
@@ -151,6 +153,7 @@ struct vring {
 	struct vring_used *used;
 };
 
+#ifndef VIRTIO_RING_NO_LEGACY
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -203,6 +206,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
+#endif /* VIRTIO_RING_NO_LEGACY */
 
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
 /* Assuming a given event_idx value from the other side, if
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

