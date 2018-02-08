Return-Path: virtio-dev-return-3184-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D67C458191A2
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Feb 2018 02:09:25 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu,  8 Feb 2018 17:50:19 +0800
Message-Id: <1518083420-11108-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com>
References: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v28 3/4] mm/page_poison: add a function to expose page poison val to kernel modules
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

Move the PAGE_POISON value to page_poison.c and add a function to enable
callers from a kernel module to get the poison value if the page poisoning
feature is in use. This also avoids callers directly checking PAGE_POISON
regardless of whether the feature is enabled.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/mm.h     |  2 ++
 include/linux/poison.h |  7 -------
 mm/page_poison.c       | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c77d88..d95e5d3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2469,11 +2469,13 @@ extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
 extern bool page_is_poisoned(struct page *page);
+extern bool page_poison_val_get(u8 *val);
 #else
 static inline bool page_poisoning_enabled(void) { return false; }
 static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
 static inline bool page_is_poisoned(struct page *page) { return false; }
+static inline bool page_poison_val_get(u8 *val) { return false; };
 #endif
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 15927eb..348bf67 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -30,13 +30,6 @@
  */
 #define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
 
-/********** mm/debug-pagealloc.c **********/
-#ifdef CONFIG_PAGE_POISONING_ZERO
-#define PAGE_POISON 0x00
-#else
-#define PAGE_POISON 0xaa
-#endif
-
 /********** mm/page_alloc.c ************/
 
 #define TAIL_MAPPING	((void *) 0x400 + POISON_POINTER_DELTA)
diff --git a/mm/page_poison.c b/mm/page_poison.c
index e83fd44..9a07973 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -7,6 +7,13 @@
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
 
+/********** mm/debug-pagealloc.c **********/
+#ifdef CONFIG_PAGE_POISONING_ZERO
+#define PAGE_POISON 0x00
+#else
+#define PAGE_POISON 0xaa
+#endif
+
 static bool want_page_poisoning __read_mostly;
 
 static int early_page_poison_param(char *buf)
@@ -30,6 +37,23 @@ bool page_poisoning_enabled(void)
 		debug_pagealloc_enabled()));
 }
 
+/**
+ * page_poison_val_get - get the page poison value if page poisoning is enabled
+ * @val: the caller's memory to get the page poison value
+ *
+ * Return true with @val stores the poison value if page poisoning is enabled.
+ * Otherwise, return false with @val unchanged.
+ */
+bool page_poison_val_get(u8 *val)
+{
+	if (!page_poisoning_enabled())
+		return false;
+
+	*val = PAGE_POISON;
+	return true;
+}
+EXPORT_SYMBOL_GPL(page_poison_val_get);
+
 static void poison_page(struct page *page)
 {
 	void *addr = kmap_atomic(page);
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

