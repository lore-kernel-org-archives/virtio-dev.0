Return-Path: virtio-dev-return-2809-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 14256581911C
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Dec 2017 04:13:05 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 12 Dec 2017 19:55:59 +0800
Message-Id: <1513079759-14169-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v19 7/7] virtio-balloon: don't report free pages when page poisoning is enabled
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The guest free pages should not be discarded by the live migration thread
when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
skipping the transfer of such poisoned free pages will trigger false
positive when new pages are allocated and checked on the destination.
This patch adds a config field, poison_val. Guest writes to the config
field to tell the host about the poisoning value. The value will be 0 in
the following cases:
1) PAGE_POISONING_NO_SANITY is enabled;
2) page poisoning is disabled; or
3) PAGE_POISONING_ZERO is enabled.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
---
 drivers/virtio/virtio_balloon.c     | 8 ++++++++
 include/uapi/linux/virtio_balloon.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6e4f359..3050c9f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -858,6 +858,7 @@ static struct file_system_type balloon_fs = {
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	__u32 poison_val;
 	int err;
 
 	if (!vdev->config->get) {
@@ -895,6 +896,13 @@ static int virtballoon_probe(struct virtio_device *vdev)
 					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
 		INIT_WORK(&vb->report_free_page_work, report_free_page);
 		vb->stop_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
+		if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
+		    !page_poisoning_enabled())
+			poison_val = 0;
+		else
+			poison_val = PAGE_POISON;
+		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+			      poison_val, &poison_val);
 	}
 
 	vb->nb.notifier_call = virtballoon_oom_notify;
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 58f1274..f270e9e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -48,6 +48,8 @@ struct virtio_balloon_config {
 	__u32 actual;
 	/* Free page report command id, readonly by guest */
 	__u32 free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning with sanity check is in use */
+	__u32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

