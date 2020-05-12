Return-Path: virtio-dev-return-7323-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B68B985E2C
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 May 2020 09:42:11 +0000 (UTC)
From: Hui Zhu <teawater@gmail.com>
Date: Tue, 12 May 2020 17:41:41 +0800
Message-Id: <1589276501-16026-2-git-send-email-teawater@gmail.com>
In-Reply-To: <1589276501-16026-1-git-send-email-teawater@gmail.com>
References: <1589276501-16026-1-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] [RFC v3 for Linux] virtio_balloon: Add VIRTIO_BALLOON_VQ_INFLATE_CONT to handle THP split issue
Content-Type: text/plain; charset=US-ASCII
To: mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, xdeguillard@vmware.com, namit@vmware.com, gregkh@linuxfoundation.org, david@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: wei.guo.simon@linux.alibaba.com, qixuan.wu@linux.alibaba.com, Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The first and second version are in [1] and [2].
According to the comments from Michael, I updated the patch.
1. Removed the separate vq inflate_cont_vq and just use inflate_vq to
   transport inflate pages.
2. Add two max_pages_order and current_pages_order to virtio_balloon_config
   instead of pages_order.
   max_pages_order is set by QEMU.  It is the max order of the inflate
   pages.
   current_pages_order is set by kernel.  It is the current order of
   the inflate pages.
   When balloon inflate begin, current_pages_order is set to
   max_pages_order.
   Kernel tries to allocate current_pages_order page.  If allocation fails,
   current_pages_order will be reduced by 1 until it is 0.
   When QEMU get pfn from inflate_vq, it will release with size in
   current_pages_order.

Following is the introduction of the function.
If the guest kernel has many fragmentation pages, use virtio_balloon
will split THP of QEMU when it calls MADV_DONTNEED madvise to release
the balloon pages.
This is an example in a VM with 1G memory 1CPU:
// This is the THP number before VM execution in the host.
// None use THP.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB

// After VM start, use usemem
// (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
// punch-holes function generates 400m fragmentation pages in the guest
// kernel.
usemem --punch-holes -s -1 800m &

// This is the THP number after this command in the host.
// Some THP is used by VM because usemem will access 800M memory
// in the guest.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    978944 kB

// Connect to the QEMU monitor, setup balloon, and set it size to 600M.
(qemu) device_add virtio-balloon-pci,id=balloon1
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 600
(qemu) info balloon
balloon: actual=600

// This is the THP number after inflate the balloon in the host.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    153600 kB

// Set the size back to 1024M in the QEMU monitor.
(qemu) balloon 1024
(qemu) info balloon
balloon: actual=1024

// Use usemem to increase the memory usage of QEMU.
killall usemem
usemem 800m

// This is the THP number after this operation.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    153600 kB

THP number decreased more than 800M after inflate the balloon in the host.
The reason is usemem with punch-holes option will free every other
page after allocation.  Then 400M free memory inside the guest kernel
is fragmentation pages.
The guest kernel will use them to inflate the balloon.  When these
fragmentation pages are freed, THP will be split.
THP number is not increased after deflate the balloon and increase
memory useage because fragmentation address affect the THP allcation
in the host.

This commit tries to handle this with add a new flag
VIRTIO_BALLOON_VQ_INFLATE_CONT.
When this flag is set, the balloon will try to use continuous pages
inflate the balloon.  And the pages default order is set to THP order.
Then THP pages will be freed together in the host.
This is an example in a VM with 1G memory 1CPU:
// This is the THP number before VM execution in the host.
// None use THP.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB

// After VM start, use usemem punch-holes function generates 400M
// fragmentation pages in the guest kernel.
usemem --punch-holes -s -1 800m &

// This is the THP number after this command in the host.
// Some THP is used by VM because usemem will access 800M memory
// in the guest.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    978944 kB

// Connect to the QEMU monitor, setup balloon, and set it size to 600M.
(qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 600
(qemu) info balloon
balloon: actual=600

// This is the THP number after inflate the balloon in the host.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    612352 kB

// Set the size back to 1024M in the QEMU monitor.
(qemu) balloon 1024
(qemu) info balloon
balloon: actual=1024

// Use usemem to increase the memory usage of QEMU.
killall usemem
usemem 800m

// This is the THP number after this operation.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    944128 kB

The THP number decreases 358M.  This shows that
VIRTIO_BALLOON_VQ_INFLATE_CONT can help handle the THP split issue.
The THP number is increased after deflate the balloon and increase
memory useage.

[1] https://lkml.org/lkml/2020/3/12/144
[2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c     | 98 +++++++++++++++++++++++++++++++------
 include/linux/balloon_compaction.h  |  9 +++-
 include/uapi/linux/virtio_balloon.h |  5 ++
 mm/balloon_compaction.c             | 40 ++++++++++++---
 4 files changed, 129 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 51086a5..19d2439 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -126,6 +126,15 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* Max pages order if VIRTIO_BALLOON_F_CONT_PAGES is set.
+	 * if VIRTIO_BALLOON_F_CONT_PAGES is not set,
+	 * max_pages_order will be set to 0.
+	 */
+	__u32 max_pages_order;
+
+	/* Max pages order if VIRTIO_BALLOON_F_CONT_PAGES is set.  */
+	__u32 current_pages_order;
 };
 
 static struct virtio_device_id id_table[] = {
@@ -208,24 +217,39 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
-static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
+static void set_current_pages_order(struct virtio_balloon *vb,
+				    unsigned int order)
+{
+	if (order == vb->current_pages_order)
+		return;
+
+	vb->current_pages_order = order;
+	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
+		order = (__force u32)cpu_to_le32(order);
+	virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+		      current_pages_order, &order);
+}
+
+static unsigned int fill_balloon_order(struct virtio_balloon *vb, size_t num,
+				       unsigned int order)
 {
-	unsigned num_allocated_pages;
-	unsigned num_pfns;
+	unsigned int num_allocated_pages = 0;
+	unsigned int num_pfns;
 	struct page *page;
 	LIST_HEAD(pages);
 
 	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
+	num = min(num, ARRAY_SIZE(vb->pfns) << order);
+	num = num >> order << order;
 
 	for (num_pfns = 0; num_pfns < num;
-	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE << order) {
+		struct page *page = balloon_pages_alloc(order);
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
-					     "Out of puff! Can't get %u pages\n",
-					     VIRTIO_BALLOON_PAGES_PER_PAGE);
+				"Out of puff! Can't get %u pages\n",
+				VIRTIO_BALLOON_PAGES_PER_PAGE << order);
 			/* Sleep for at least 1/5 of a second before retry. */
 			msleep(200);
 			break;
@@ -233,28 +257,55 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 
 		balloon_page_push(&pages, page);
 	}
+	if (!num_pfns)
+		goto out;
 
 	mutex_lock(&vb->balloon_lock);
 
 	vb->num_pfns = 0;
 
 	while ((page = balloon_page_pop(&pages))) {
-		balloon_page_enqueue(&vb->vb_dev_info, page);
+		/* Split the continuous pages because they will be freed
+		 * by release_pages_balloon respectively.
+		 */
+		if (order)
+			split_page(page, order);
+
+		balloon_pages_enqueue(&vb->vb_dev_info, page, order);
 
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
+		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE << order;
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
+			adjust_managed_page_count(page, -(1 << order));
 		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
-	num_allocated_pages = vb->num_pfns;
+	num_allocated_pages = vb->num_pfns << order;
 	/* Did we get any? */
-	if (vb->num_pfns != 0)
+	if (vb->num_pfns != 0) {
+		set_current_pages_order(vb, order);
 		tell_host(vb, vb->inflate_vq);
+	}
 	mutex_unlock(&vb->balloon_lock);
 
+out:
+	return num_allocated_pages;
+}
+
+static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
+{
+	unsigned int num_allocated_pages = 0;
+	unsigned int order = vb->current_pages_order;
+
+	for (order = vb->current_pages_order; order >= 0; order--) {
+		if (num < VIRTIO_BALLOON_PAGES_PER_PAGE << order)
+			continue;
+		num_allocated_pages = fill_balloon_order(vb, num, order);
+		if (num_allocated_pages > 0)
+			break;
+	}
+
 	return num_allocated_pages;
 }
 
@@ -482,6 +533,7 @@ static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
 	s64 diff;
+	bool is_fill = false;
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
@@ -490,14 +542,17 @@ static void update_balloon_size_func(struct work_struct *work)
 	if (!diff)
 		return;
 
-	if (diff > 0)
+	if (diff > 0) {
 		diff -= fill_balloon(vb, diff);
-	else
+		is_fill = true;
+	} else
 		diff += leak_balloon(vb, -diff);
 	update_balloon_size(vb);
 
 	if (diff)
 		queue_work(system_freezable_wq, work);
+	else if (is_fill)
+		set_current_pages_order(vb, vb->max_pages_order);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -997,6 +1052,18 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
+		virtio_cread(vb->vdev, struct virtio_balloon_config,
+			     max_pages_order, &vb->max_pages_order);
+		if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
+			vb->max_pages_order = le32_to_cpu((__force __le32)
+							  vb->max_pages_order);
+		vb->current_pages_order = vb->max_pages_order;
+	} else {
+		vb->max_pages_order = 0;
+		vb->current_pages_order = 0;
+	}
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
@@ -1124,6 +1191,7 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_CONT_PAGES,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 338aa27..8180bbf 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -60,15 +60,22 @@ struct balloon_dev_info {
 	struct inode *inode;
 };
 
-extern struct page *balloon_page_alloc(void);
+extern struct page *balloon_pages_alloc(unsigned int order);
 extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct page *page);
+extern void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
+				  struct page *page, unsigned int order);
 extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
 extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				     struct list_head *pages, size_t n_req_pages);
 
+static inline struct page *balloon_page_alloc(void)
+{
+	return balloon_pages_alloc(0);
+}
+
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
 	balloon->isolated_pages = 0;
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index dc3e656..4e236f6 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -59,6 +60,10 @@ struct virtio_balloon_config {
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
 	__u32 poison_val;
+	/* Max pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
+	__u32 max_pages_order;
+	/* Current pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
+	__u32 current_pages_order;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020..87df4b2 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -112,8 +112,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
 /*
- * balloon_page_alloc - allocates a new page for insertion into the balloon
- *			page list.
+ * balloon_pages_alloc - allocates a new page for insertion into the balloon
+ *			 page list.
  *
  * Driver must call this function to properly allocate a new balloon page.
  * Driver must call balloon_page_enqueue before definitively removing the page
@@ -121,14 +121,21 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
  *
  * Return: struct page for the allocated page or NULL on allocation failure.
  */
-struct page *balloon_page_alloc(void)
+struct page *balloon_pages_alloc(unsigned int order)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
+	gfp_t gfp_mask;
+
+	if (order > 1)
+		gfp_mask = __GFP_RETRY_MAYFAIL;
+	else
+		gfp_mask = __GFP_NORETRY;
+
+	struct page *page = alloc_pages(balloon_mapping_gfp_mask() |
+					gfp_mask | __GFP_NOMEMALLOC |
+					__GFP_NOWARN, order);
 	return page;
 }
-EXPORT_SYMBOL_GPL(balloon_page_alloc);
+EXPORT_SYMBOL_GPL(balloon_pages_alloc);
 
 /*
  * balloon_page_enqueue - inserts a new page into the balloon page list.
@@ -155,6 +162,25 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
 /*
+ * balloon_pages_enqueue - inserts continuous pages into the balloon page list.
+ */
+void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
+			   struct page *page, unsigned int order)
+{
+	unsigned long flags;
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long last_pfn = pfn + (1 << order) - 1;
+
+	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+	for (; pfn <= last_pfn; pfn++) {
+		page = pfn_to_page(pfn);
+		balloon_page_enqueue_one(b_dev_info, page);
+	}
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+}
+EXPORT_SYMBOL_GPL(balloon_pages_enqueue);
+
+/*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device decriptor where we will grab a page from.
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

