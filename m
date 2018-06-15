Return-Path: virtio-dev-return-4388-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 181F9581806A
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Jun 2018 22:08:48 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 15 Jun 2018 12:43:10 +0800
Message-Id: <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v33 1/4] mm: add a function to get free page blocks
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a function to get free pages blocks from a free page
list. The obtained free page blocks are hints about free pages, because
there is no guarantee that they are still on the free page list after
the function returns.

One use example of this patch is to accelerate live migration by skipping
the transfer of free pages reported from the guest. A popular method used
by the hypervisor to track which part of memory is written during live
migration is to write-protect all the guest memory. So, those pages that
are hinted as free pages but are written after this function returns will
be captured by the hypervisor, and they will be added to the next round of
memory transfer.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/mm.h |  1 +
 mm/page_alloc.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e49388..c58b4e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2002,6 +2002,7 @@ extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, unsigned long * zones_size,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
+uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t size);
 
 /*
  * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 07b3c23..7c816d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5043,6 +5043,58 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	show_swap_cache_info();
 }
 
+/**
+ * get_from_free_page_list - get free page blocks from a free page list
+ * @order: the order of the free page list to check
+ * @buf: the array to store the physical addresses of the free page blocks
+ * @size: the array size
+ *
+ * This function offers hints about free pages. There is no guarantee that
+ * the obtained free pages are still on the free page list after the function
+ * returns. pfn_to_page on the obtained free pages is strongly discouraged
+ * and if there is an absolute need for that, make sure to contact MM people
+ * to discuss potential problems.
+ *
+ * The addresses are currently stored to the array in little endian. This
+ * avoids the overhead of converting endianness by the caller who needs data
+ * in the little endian format. Big endian support can be added on demand in
+ * the future.
+ *
+ * Return the number of free page blocks obtained from the free page list.
+ * The maximum number of free page blocks that can be obtained is limited to
+ * the caller's array size.
+ */
+uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t size)
+{
+	struct zone *zone;
+	enum migratetype mt;
+	struct page *page;
+	struct list_head *list;
+	unsigned long addr, flags;
+	uint32_t index = 0;
+
+	for_each_populated_zone(zone) {
+		spin_lock_irqsave(&zone->lock, flags);
+		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
+			list = &zone->free_area[order].free_list[mt];
+			list_for_each_entry(page, list, lru) {
+				addr = page_to_pfn(page) << PAGE_SHIFT;
+				if (likely(index < size)) {
+					buf[index++] = cpu_to_le64(addr);
+				} else {
+					spin_unlock_irqrestore(&zone->lock,
+							       flags);
+					return index;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+	return index;
+}
+EXPORT_SYMBOL_GPL(get_from_free_page_list);
+
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

