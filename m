Return-Path: virtio-dev-return-2378-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 695E75818F80
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2017 05:47:50 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:20 +0800
Message-Id: <1499863221-16206-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v12 7/8] mm: export symbol of next_zone and first_online_pgdat
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch enables for_each_zone()/for_each_populated_zone() to be
invoked by a kernel module.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 mm/mmzone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index a51c0a6..08a2a3a 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -13,6 +13,7 @@ struct pglist_data *first_online_pgdat(void)
 {
 	return NODE_DATA(first_online_node);
 }
+EXPORT_SYMBOL_GPL(first_online_pgdat);
 
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
@@ -41,6 +42,7 @@ struct zone *next_zone(struct zone *zone)
 	}
 	return zone;
 }
+EXPORT_SYMBOL_GPL(next_zone);
 
 static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

