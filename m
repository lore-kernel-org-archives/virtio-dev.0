Return-Path: virtio-dev-return-5240-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05F93985C35
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 16:08:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  3 Jan 2019 17:08:04 +0100
Message-Id: <20190103160804.21438-3-cohuck@redhat.com>
In-Reply-To: <20190103160804.21438-1-cohuck@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
Subject: [virtio-dev] [PATCH 2/2] virtio: document virtio_config_ops restrictions
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Some transports (e.g. virtio-ccw) implement virtio operations that
seem to be a simple read/write as something more involved that
cannot be done from an atomic context.

Give at least a hint about that.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/linux/virtio_config.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7087ef946ba7..987b6491b946 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -12,6 +12,11 @@ struct irq_affinity;
 
 /**
  * virtio_config_ops - operations for configuring a virtio device
+ * Note: Do not assume that a transport implements all of the operations
+ *       getting/setting a value as a simple read/write! Generally speaking,
+ *       any of @get/@set, @get_status/@set_status, or @get_features/
+ *       @finalize_features are NOT safe to be called from an atomic
+ *       context.
  * @get: read the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
-- 
2.17.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

