Return-Path: virtio-dev-return-4390-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2493B58180C6
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Jun 2018 22:08:56 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 15 Jun 2018 12:43:13 +0800
Message-Id: <1529037793-35521-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v33 4/4] virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
guest is using page poisoning. Guest writes to the poison_val config
field to tell host about the page poisoning value that is in use.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/virtio/virtio_balloon.c     | 10 ++++++++++
 include/uapi/linux/virtio_balloon.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 582a03b..c59bb380 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -634,6 +634,7 @@ static struct file_system_type balloon_fs = {
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	__u32 poison_val;
 	int err;
 
 	if (!vdev->config->get) {
@@ -671,6 +672,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_del_vqs;
 		}
 		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
+		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
+			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+				      poison_val, &poison_val);
+		}
 		vb->hints = kmalloc(FREE_PAGE_HINT_MEM_SIZE, GFP_KERNEL);
 		if (!vb->hints) {
 			err = -ENOMEM;
@@ -796,6 +802,9 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 static int virtballoon_validate(struct virtio_device *vdev)
 {
+	if (!page_poisoning_enabled())
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+
 	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
 	return 0;
 }
@@ -805,6 +814,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_STATS_VQ,
 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
+	VIRTIO_BALLOON_F_PAGE_POISON,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 99b8416..f3b6191 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -35,6 +35,7 @@
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
+#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -47,6 +48,8 @@ struct virtio_balloon_config {
 	__u32 actual;
 	/* Command sent from host */
 	__u32 host_cmd;
+	/* Stores PAGE_POISON if page poisoning is in use */
+	__u32 poison_val;
 };
 
 struct virtio_balloon_free_page_hints {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

