Return-Path: virtio-dev-return-5290-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 705F3985B99
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Jan 2019 05:25:15 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  8 Jan 2019 12:50:05 +0800
Message-Id: <1546923005-40517-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v4 3/3] virtio_balloon: remove the unnecessary 0-initialization
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

We've changed to kzalloc the vb struct, so no need to 0-initialize
this field one more time.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d48c12c..048959a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -925,7 +925,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
 						  VIRTIO_BALLOON_CMD_ID_STOP);
-		vb->num_free_page_blocks = 0;
 		spin_lock_init(&vb->free_page_list_lock);
 		INIT_LIST_HEAD(&vb->free_page_list);
 		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

