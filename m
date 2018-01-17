Return-Path: virtio-dev-return-2983-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E4541CB807D
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Jan 2018 22:50:31 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 14:32:00 +0800
Message-Id: <1516170720-4948-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 4/4] virtio-balloon: Don't skip free pages if the poison val is non-zero
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

If the guest is using a non-zero poisoning, we don't skip the transfer
of guest free pages.

Todo: As a next step optimization, we can try
1) skip the transfer of guest poisoned free pages;
2) send the poison value to destination; and
3) seek a way to poison the guest free pages before the guest starts to
run on the destination.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c                      | 3 ++-
 include/hw/virtio/virtio-balloon.h              | 1 +
 include/standard-headers/linux/virtio_balloon.h | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index dcc8cb3..0cdc755 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -403,7 +403,7 @@ static void virtio_balloon_handle_free_pages(VirtIODevice *vdev, VirtQueue *vq)
             ram_addr_t offset;
 
             if (atomic_read(&dev->free_page_report_status) ==
-                FREE_PAGE_REPORT_S_IN_PROGRESS) {
+                FREE_PAGE_REPORT_S_IN_PROGRESS && !dev->poison_val) {
                 block = qemu_ram_block_from_host(elem->in_sg[0].iov_base,
                                                  false, &offset);
                 size = elem->in_sg[0].iov_len;
@@ -530,6 +530,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
                         &error_abort);
     }
+    dev->poison_val = le32_to_cpu(config.poison_val);
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 268f7d6..0bb80cd 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -43,6 +43,7 @@ typedef struct VirtIOBalloon {
     uint32_t num_pages;
     uint32_t actual;
     uint32_t free_page_report_cmd_id;
+    uint32_t poison_val;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 596df5d..f6f4ff3 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -47,6 +47,8 @@ struct virtio_balloon_config {
 	uint32_t actual;
         /* The free_page report command id, readonly by guest */
 	uint32_t free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning with sanity check is in use */
+	uint32_t poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

