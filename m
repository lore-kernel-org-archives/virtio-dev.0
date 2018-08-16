Return-Path: virtio-dev-return-4787-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64EAD985C61
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Aug 2018 08:19:18 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 16 Aug 2018 15:50:57 +0800
Message-Id: <1534405858-27085-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1534405858-27085-1-git-send-email-wei.w.wang@intel.com>
References: <1534405858-27085-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v4 2/3] virtio-balloon: kzalloc the vb struct
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp
Cc: wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Zero all the vb fields at alloaction, so that we don't need to
zero-initialize each field one by one later.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/virtio/virtio_balloon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8100e77..d97d73c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -561,7 +561,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vdev->priv = vb = kmalloc(sizeof(*vb), GFP_KERNEL);
+	vdev->priv = vb = kzalloc(sizeof(*vb), GFP_KERNEL);
 	if (!vb) {
 		err = -ENOMEM;
 		goto out;
@@ -570,8 +570,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
 	spin_lock_init(&vb->stop_update_lock);
-	vb->stop_update = false;
-	vb->num_pages = 0;
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
 	vb->vdev = vdev;
@@ -602,7 +600,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		err = PTR_ERR(vb->vb_dev_info.inode);
 		kern_unmount(balloon_mnt);
 		unregister_oom_notifier(&vb->nb);
-		vb->vb_dev_info.inode = NULL;
 		goto out_del_vqs;
 	}
 	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

