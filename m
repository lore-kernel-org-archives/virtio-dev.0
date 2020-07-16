Return-Path: virtio-dev-return-7561-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25E4798607C
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 02:42:43 +0000 (UTC)
From: Hui Zhu <teawater@gmail.com>
Date: Thu, 16 Jul 2020 10:41:54 +0800
Message-Id: <1594867315-8626-5-git-send-email-teawater@gmail.com>
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] [RFC for qemu v4 1/2] virtio_balloon: Add cont-pages and icvq
Content-Type: text/plain; charset=US-ASCII
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This commit adds cont-pages option to virtio_balloon.  virtio_balloon
will open flags VIRTIO_BALLOON_F_CONT_PAGES with this option.
And it add a vq icvq to inflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
from icvq and use madvise MADV_DONTNEED release the pages.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c                      | 80 ++++++++++++++++---------
 include/hw/virtio/virtio-balloon.h              |  2 +-
 include/standard-headers/linux/virtio_balloon.h |  1 +
 3 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..d36a5c8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -65,23 +65,26 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
+                                 size_t size,
                                  PartiallyBalloonedPage *pbp)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
     RAMBlock *rb;
     size_t rb_page_size;
-    int subpages;
+    int subpages, pages_num;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
     rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
 
+    size &= ~(rb_page_size - 1);
+
     if (rb_page_size == BALLOON_PAGE_SIZE) {
         /* Easy case */
 
-        ram_block_discard_range(rb, rb_offset, rb_page_size);
+        ram_block_discard_range(rb, rb_offset, size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -99,32 +102,38 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 
     rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
-    base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
-               (rb_offset - rb_aligned_offset);
 
-    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
-        /* We've partially ballooned part of a host page, but now
-         * we're trying to balloon part of a different one.  Too hard,
-         * give up on the old partial page */
-        virtio_balloon_pbp_free(pbp);
-    }
+    for (pages_num = size / BALLOON_PAGE_SIZE;
+         pages_num > 0; pages_num--) {
+        base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
+                   (rb_offset - rb_aligned_offset);
 
-    if (!pbp->bitmap) {
-        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
-    }
+        if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
+            /* We've partially ballooned part of a host page, but now
+            * we're trying to balloon part of a different one.  Too hard,
+            * give up on the old partial page */
+            virtio_balloon_pbp_free(pbp);
+        }
 
-    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
-            pbp->bitmap);
+        if (!pbp->bitmap) {
+            virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
+        }
 
-    if (bitmap_full(pbp->bitmap, subpages)) {
-        /* We've accumulated a full host page, we can actually discard
-         * it now */
+        set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+                pbp->bitmap);
 
-        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
-        /* We ignore errors from ram_block_discard_range(), because it
-         * has already reported them, and failing to discard a balloon
-         * page is not fatal */
-        virtio_balloon_pbp_free(pbp);
+        if (bitmap_full(pbp->bitmap, subpages)) {
+            /* We've accumulated a full host page, we can actually discard
+            * it now */
+
+            ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
+            /* We ignore errors from ram_block_discard_range(), because it
+            * has already reported them, and failing to discard a balloon
+            * page is not fatal */
+            virtio_balloon_pbp_free(pbp);
+        }
+
+        mr_offset += BALLOON_PAGE_SIZE;
     }
 }
 
@@ -340,12 +349,21 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
             unsigned int p = virtio_ldl_p(vdev, &pfn);
             hwaddr pa;
+            unsigned int psize = BALLOON_PAGE_SIZE;
 
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
 
-            section = memory_region_find(get_system_memory(), pa,
-                                         BALLOON_PAGE_SIZE);
+            if (vq == s->icvq) {
+                uint32_t psize_ptr;
+                if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
+                    break;
+                }
+                psize = virtio_ldl_p(vdev, &psize_ptr);
+                offset += 4;
+            }
+
+            section = memory_region_find(get_system_memory(), pa, psize);
             if (!section.mr) {
                 trace_virtio_balloon_bad_addr(pa);
                 continue;
@@ -361,9 +379,10 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                                pa);
             if (!qemu_balloon_is_inhibited()) {
-                if (vq == s->ivq) {
+                if (vq == s->ivq || vq == s->icvq) {
                     balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region, &pbp);
+                                         section.offset_within_region,
+                                         psize, &pbp);
                 } else if (vq == s->dvq) {
                     balloon_deflate_page(s, section.mr, section.offset_within_region);
                 } else {
@@ -816,6 +835,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
             virtio_error(vdev, "iothread is missing");
         }
     }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
+    }
+
     reset_stats(s);
 }
 
@@ -916,6 +940,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_CONT_PAGES, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d..6a2514d 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2..033926c 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

