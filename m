Return-Path: virtio-dev-return-5600-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 170AA985E40
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Mar 2019 10:11:11 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 12 Mar 2019 17:34:40 +0800
Message-Id: <1552383280-4122-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH] virtio-balloon: fix a use-after-free case
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: peter.maydell@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

The elem could theorically contain both outbuf and inbufs. We move the
free operation to the end of this function to avoid using elem->in_sg
while elem has been freed.

Fixes: c13c4153f7
("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 hw/virtio/virtio-balloon.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e3a6594..b614552 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -391,6 +391,7 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
     VirtQueueElement *elem;
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtQueue *vq = dev->free_page_vq;
+    bool ret = true;
 
     while (dev->block_iothread) {
         qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
@@ -405,13 +406,12 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
         uint32_t id;
         size_t size = iov_to_buf(elem->out_sg, elem->out_num, 0,
                                  &id, sizeof(id));
-        virtqueue_push(vq, elem, size);
-        g_free(elem);
 
         virtio_tswap32s(vdev, &id);
         if (unlikely(size != sizeof(id))) {
             virtio_error(vdev, "received an incorrect cmd id");
-            return false;
+            ret = false;
+            goto out;
         }
         if (id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
@@ -431,11 +431,12 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
                                       elem->in_sg[0].iov_len);
         }
-        virtqueue_push(vq, elem, 1);
-        g_free(elem);
     }
 
-    return true;
+out:
+    virtqueue_push(vq, elem, 1);
+    g_free(elem);
+    return ret;
 }
 
 static void virtio_ballloon_get_free_page_hints(void *opaque)
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

