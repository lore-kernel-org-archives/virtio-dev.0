Return-Path: virtio-dev-return-2373-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 326CC5818B02
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2017 05:47:30 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:15 +0800
Message-Id: <1499863221-16206-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v12 2/8] virtio-balloon: coding format cleanup
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

Clean up the comment format.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7f38ae6..f0b3a0b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -132,8 +132,10 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
-	/* Set balloon pfns pointing at this page.
-	 * Note that the first pfn points at start of the page. */
+	/*
+	 * Set balloon pfns pointing at this page.
+	 * Note that the first pfn points at start of the page.
+	 */
 	for (i = 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
 		pfns[i] = cpu_to_virtio32(vb->vdev,
 					  page_to_balloon_pfn(page) + i);
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

