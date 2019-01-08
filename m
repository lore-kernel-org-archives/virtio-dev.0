Return-Path: virtio-dev-return-5291-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B80959849E9
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Jan 2019 05:25:14 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  8 Jan 2019 12:50:04 +0800
Message-Id: <1546923005-40517-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v4 2/3] virtio-balloon: improve update_balloon_size_func
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

There is no need to update the balloon actual register when there is no
ballooning request. This patch avoids update_balloon_size when diff is 0.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 45d32f5..d48c12c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -457,9 +457,12 @@ static void update_balloon_size_func(struct work_struct *work)
 			  update_balloon_size_work);
 	diff = towards_target(vb);
 
+	if (!diff)
+		return;
+
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
-	else if (diff < 0)
+	else
 		diff += leak_balloon(vb, -diff);
 	update_balloon_size(vb);
 
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

