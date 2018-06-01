Return-Path: virtio-dev-return-4241-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A947B5818F01
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Jun 2018 04:26:36 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri,  1 Jun 2018 19:26:32 +0800
Message-Id: <20180601112632.12651-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v3] virtio: update the comments for transport features
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com, cohuck@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The existing comments for transport features are outdated.
So update them to address the latest changes in the spec.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
This patch is generated on top of below patch:
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html

v3:
- Fix a typo in the commit message (Cornelia);

v2:
- Improve the comments (Cornelia);
- Improve the commit message;

 include/uapi/linux/virtio_config.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index b7c1f4e7d59e..449132c76b1c 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -45,9 +45,12 @@
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED		0x80
 
-/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
- * transport being used (eg. virtio_ring), the rest are per-device feature
- * bits. */
+/*
+ * Virtio feature bits VIRTIO_TRANSPORT_F_START through
+ * VIRTIO_TRANSPORT_F_END are reserved for the transport
+ * being used (e.g. virtio_ring, virtio_pci etc.), the
+ * rest are per-device feature bits.
+ */
 #define VIRTIO_TRANSPORT_F_START	28
 #define VIRTIO_TRANSPORT_F_END		38
 
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

