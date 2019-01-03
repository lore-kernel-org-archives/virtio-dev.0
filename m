Return-Path: virtio-dev-return-5227-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25581985BFC
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 06:06:08 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu,  3 Jan 2019 13:31:01 +0800
Message-Id: <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 1/2] virtio-balloon: tweak config_changed implementation
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-ccw has deadlock issues with reading config registers inside the
interrupt context, so we tweak the virtballoon_changed implementation
by moving the config read operations into the related workqueue contexts.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 728ecd1..9a82a11 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -394,33 +394,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 	unsigned long flags;
-	s64 diff = towards_target(vb);
-
-	if (diff) {
-		spin_lock_irqsave(&vb->stop_update_lock, flags);
-		if (!vb->stop_update)
-			queue_work(system_freezable_wq,
-				   &vb->update_balloon_size_work);
-		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
-	}
 
-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		virtio_cread(vdev, struct virtio_balloon_config,
-			     free_page_report_cmd_id, &vb->cmd_id_received);
-		if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
-			/* Pass ULONG_MAX to give back all the free pages */
-			return_free_pages_to_mm(vb, ULONG_MAX);
-		} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
-			   vb->cmd_id_received !=
-			   virtio32_to_cpu(vdev, vb->cmd_id_active)) {
-			spin_lock_irqsave(&vb->stop_update_lock, flags);
-			if (!vb->stop_update) {
-				queue_work(vb->balloon_wq,
-					   &vb->report_free_page_work);
-			}
-			spin_unlock_irqrestore(&vb->stop_update_lock, flags);
-		}
+	spin_lock_irqsave(&vb->stop_update_lock, flags);
+	if (!vb->stop_update) {
+		queue_work(system_freezable_wq,
+			   &vb->update_balloon_size_work);
+		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+			queue_work(vb->balloon_wq, &vb->report_free_page_work);
 	}
+	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
 }
 
 static void update_balloon_size(struct virtio_balloon *vb)
@@ -637,11 +619,9 @@ static int send_free_pages(struct virtio_balloon *vb)
 	return 0;
 }
 
-static void report_free_page_func(struct work_struct *work)
+static void virtio_balloon_report_free_page(struct virtio_balloon *vb)
 {
 	int err;
-	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
-						 report_free_page_work);
 	struct device *dev = &vb->vdev->dev;
 
 	/* Start by sending the received cmd id to host with an outbuf. */
@@ -659,6 +639,24 @@ static void report_free_page_func(struct work_struct *work)
 		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
 }
 
+static void report_free_page_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
+						 report_free_page_work);
+
+	virtio_cread(vb->vdev, struct virtio_balloon_config,
+		     free_page_report_cmd_id, &vb->cmd_id_received);
+
+	if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
+		/* Pass ULONG_MAX to give back all the free pages */
+		return_free_pages_to_mm(vb, ULONG_MAX);
+	} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
+		   vb->cmd_id_received !=
+		   virtio32_to_cpu(vb->vdev, vb->cmd_id_active)) {
+		virtio_balloon_report_free_page(vb);
+	}
+}
+
 #ifdef CONFIG_BALLOON_COMPACTION
 /*
  * virtballoon_migratepage - perform the balloon page migration on behalf of
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

