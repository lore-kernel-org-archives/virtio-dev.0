Return-Path: virtio-dev-return-7559-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE187986079
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 02:42:36 +0000 (UTC)
From: Hui Zhu <teawater@gmail.com>
Date: Thu, 16 Jul 2020 10:41:51 +0800
Message-Id: <1594867315-8626-2-git-send-email-teawater@gmail.com>
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] [RFC for Linux v4 1/2] virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
Content-Type: text/plain; charset=US-ASCII
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This commit adds a new flag VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon.
Add it adds a vq inflate_cont_vq to inflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, try to allocate continuous pages
and report them use inflate_cont_vq.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c     | 119 ++++++++++++++++++++++++++++++------
 include/linux/balloon_compaction.h  |   9 ++-
 include/uapi/linux/virtio_balloon.h |   1 +
 mm/balloon_compaction.c             |  41 ++++++++++---
 4 files changed, 142 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f157d2..b89f566 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -42,6 +42,9 @@
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
 #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
 
+#define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * BITS_PER_BYTE - \
+						    1 - PAGE_SHIFT), (MAX_ORDER-1))
+
 #ifdef CONFIG_BALLOON_COMPACTION
 static struct vfsmount *balloon_mnt;
 #endif
@@ -52,6 +55,7 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_STATS,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
+	VIRTIO_BALLOON_VQ_INFLATE_CONT,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -61,7 +65,7 @@ enum virtio_balloon_config_read {
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq, *inflate_cont_vq;
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -126,6 +130,9 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* Current order of inflate continuous pages - VIRTIO_BALLOON_F_CONT_PAGES */
+	__u32 current_pages_order;
 };
 
 static struct virtio_device_id id_table[] = {
@@ -208,19 +215,59 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
+static void set_page_pfns_order(struct virtio_balloon *vb,
+				__virtio32 pfns[], struct page *page,
+				unsigned int order)
+{
+	if (order == 0)
+		return set_page_pfns(vb, pfns, page);
+
+	/* Set the first pfn of the continuous pages.  */
+	pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
+	/* Set the size of the continuous pages.  */
+	pfns[1] = PAGE_SIZE << order;
+}
+
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned num_allocated_pages;
-	unsigned num_pfns;
+	unsigned int num_pfns, pfn_per_alloc;
 	struct page *page;
 	LIST_HEAD(pages);
+	bool is_cont = vb->current_pages_order != 0;
 
-	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
-
-	for (num_pfns = 0; num_pfns < num;
-	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+	if (is_cont)
+		pfn_per_alloc = 2;
+	else
+		pfn_per_alloc = VIRTIO_BALLOON_PAGES_PER_PAGE;
+
+	for (num_pfns = 0, num_allocated_pages = 0;
+	     num_pfns < ARRAY_SIZE(vb->pfns) && num_allocated_pages < num;
+	     num_pfns += pfn_per_alloc,
+	     num_allocated_pages += VIRTIO_BALLOON_PAGES_PER_PAGE << vb->current_pages_order) {
+		struct page *page;
+
+		for (; vb->current_pages_order >= 0; vb->current_pages_order--) {
+			if (vb->current_pages_order &&
+			    num - num_allocated_pages <
+				VIRTIO_BALLOON_PAGES_PER_PAGE << vb->current_pages_order)
+				continue;
+			page = balloon_pages_alloc(vb->current_pages_order);
+			if (page) {
+				/* If the first allocated page is not continuous pages,
+				 * go back to transport page as signle page.
+				 */
+				if (is_cont && num_pfns == 0 && !vb->current_pages_order) {
+					is_cont = false;
+					pfn_per_alloc = VIRTIO_BALLOON_PAGES_PER_PAGE;
+				}
+				set_page_private(page, vb->current_pages_order);
+				balloon_page_push(&pages, page);
+				break;
+			}
+			if (!vb->current_pages_order)
+				break;
+		}
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
@@ -230,8 +277,6 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 			msleep(200);
 			break;
 		}
-
-		balloon_page_push(&pages, page);
 	}
 
 	mutex_lock(&vb->balloon_lock);
@@ -239,20 +284,34 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 	vb->num_pfns = 0;
 
 	while ((page = balloon_page_pop(&pages))) {
-		balloon_page_enqueue(&vb->vb_dev_info, page);
+		unsigned int order = page_private(page);
+
+		set_page_private(page, 0);
+
+		/* Split the continuous pages because they will be freed
+		 * by release_pages_balloon respectively.
+		 */
+		if (order)
+			split_page(page, order);
+
+		balloon_pages_enqueue(&vb->vb_dev_info, page, order);
+
+		set_page_pfns_order(vb, vb->pfns + vb->num_pfns, page, order);
 
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
-		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+			adjust_managed_page_count(page, -(1 << order));
+		vb->num_pfns += pfn_per_alloc;
 	}
+	vb->num_pages += num_allocated_pages;
 
-	num_allocated_pages = vb->num_pfns;
 	/* Did we get any? */
-	if (vb->num_pfns != 0)
-		tell_host(vb, vb->inflate_vq);
+	if (vb->num_pfns != 0) {
+		if (is_cont)
+			tell_host(vb, vb->inflate_cont_vq);
+		else
+			tell_host(vb, vb->inflate_vq);
+	}
 	mutex_unlock(&vb->balloon_lock);
 
 	return num_allocated_pages;
@@ -488,7 +547,7 @@ static void update_balloon_size_func(struct work_struct *work)
 	diff = towards_target(vb);
 
 	if (!diff)
-		return;
+		goto stop_out;
 
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
@@ -498,6 +557,11 @@ static void update_balloon_size_func(struct work_struct *work)
 
 	if (diff)
 		queue_work(system_freezable_wq, work);
+	else {
+stop_out:
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+			vb->current_pages_order = VIRTIO_BALLOON_INFLATE_MAX_ORDER;
+	}
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -521,6 +585,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -537,6 +603,11 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
+		names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = "inflate_cont";
+		callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = balloon_ack;
+	}
+
 	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
 					 vqs, callbacks, names, NULL, NULL);
 	if (err)
@@ -572,6 +643,10 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+		vb->inflate_cont_vq
+			= vqs[VIRTIO_BALLOON_VQ_INFLATE_CONT];
+
 	return 0;
 }
 
@@ -997,6 +1072,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+		vb->current_pages_order = VIRTIO_BALLOON_INFLATE_MAX_ORDER;
+	else
+		vb->current_pages_order = 0;
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
@@ -1131,6 +1211,7 @@ static unsigned int features[] = {
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
index dc3e656..4d0151a 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020..397d0b9 100644
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
@@ -121,14 +121,19 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  *
  * Return: struct page for the allocated page or NULL on allocation failure.
  */
-struct page *balloon_page_alloc(void)
+struct page *balloon_pages_alloc(unsigned int order)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	gfp_t gfp_mask;
+
+	if (order > 1)
+		gfp_mask = __GFP_RETRY_MAYFAIL;
+	else
+		gfp_mask = __GFP_NORETRY;
+
+	return alloc_pages(balloon_mapping_gfp_mask() |
+			   gfp_mask | __GFP_NOMEMALLOC | __GFP_NOWARN, order);
 }
-EXPORT_SYMBOL_GPL(balloon_page_alloc);
+EXPORT_SYMBOL_GPL(balloon_pages_alloc);
 
 /*
  * balloon_page_enqueue - inserts a new page into the balloon page list.
@@ -155,6 +160,26 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
 /*
+ * balloon_pages_enqueue - inserts continuous pages into the balloon page list.
+ */
+void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
+			   struct page *page, unsigned int order)
+{
+	unsigned long flags, pfn, last_pfn;
+
+	pfn = page_to_pfn(page);
+	last_pfn = pfn + (1 << order) - 1;
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
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

