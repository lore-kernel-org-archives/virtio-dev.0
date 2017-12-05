Return-Path: virtio-dev-return-2745-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 839375818F5C
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2017 19:49:53 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:16 +0800
Message-Id: <1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 7/7] virtio/vhost.c: vhost-pci needs remote gpa
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The vhost-pci driver uses the remote guest physical address to send/receive
packets from the remote guest, so when sending the ving info to the vhost-pci
device, send the guest physical adress directly.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dda7b8f..ffbda6c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1057,26 +1057,38 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = vhost_memory_map(dev, a, &l, 0);
-    if (!vq->desc || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_desc;
+    if (vhost_pci_enabled(dev)) {
+        vq->desc = (void *)a;
+    } else {
+        vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
+        vq->desc = vhost_memory_map(dev, a, &l, 0);
+        if (!vq->desc || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_desc;
+        }
     }
     vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, a, &l, 0);
-    if (!vq->avail || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_avail;
+    if (vhost_pci_enabled(dev)) {
+        vq->avail = (void *)a;
+    } else {
+        vq->avail = vhost_memory_map(dev, a, &l, 0);
+        if (!vq->avail || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_avail;
+        }
     }
     vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, a, &l, 1);
-    if (!vq->used || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_used;
+    if (vhost_pci_enabled(dev)) {
+        vq->used = (void *)a;
+    } else {
+        vq->used = vhost_memory_map(dev, a, &l, 1);
+        if (!vq->used || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_used;
+        }
     }
 
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
@@ -1163,13 +1175,17 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 !virtio_is_big_endian(vdev),
                                                 vhost_vq_index);
     }
-
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, virtio_queue_get_desc_size(vdev, idx));
+    if (!vhost_pci_enabled(dev)) {
+        vhost_memory_unmap(dev, vq->used,
+                           virtio_queue_get_used_size(vdev, idx),
+                           1, virtio_queue_get_used_size(vdev, idx));
+        vhost_memory_unmap(dev, vq->avail,
+                           virtio_queue_get_avail_size(vdev, idx),
+                           0, virtio_queue_get_avail_size(vdev, idx));
+        vhost_memory_unmap(dev, vq->desc,
+                           virtio_queue_get_desc_size(vdev, idx),
+                           0, virtio_queue_get_desc_size(vdev, idx));
+    }
 }
 
 static void vhost_eventfd_add(MemoryListener *listener,
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

