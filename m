Return-Path: virtio-dev-return-2724-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8009E5819127
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Nov 2017 06:11:56 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 29 Nov 2017 21:55:26 +0800
Message-Id: <1511963726-34070-11-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v18 10/10] virtio-balloon: don't report free pages when page poisoning is enabled
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The guest free pages should not be discarded by the live migration thread
when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
skipping the transfer of such poisoned free pages will trigger false
positive when new pages are allocated and checked on the destination.
This patch skips the reporting of free pages in the above case.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
---
 drivers/virtio/virtio_balloon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 035bd3a..6ac4cff 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -652,7 +652,9 @@ static void report_free_page(struct work_struct *work)
 	/* Start by sending the obtained cmd id to the host with an outbuf */
 	send_one_desc(vb, vb->free_page_vq, virt_to_phys(&vb->start_cmd_id),
 		      sizeof(uint32_t), false, true, false);
-	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
+	if (!(page_poisoning_enabled() &&
+	    !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY)))
+		walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
 	/*
 	 * End by sending the stop id to the host with an outbuf. Use the
 	 * non-batching mode here to trigger a kick after adding the stop id.
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

