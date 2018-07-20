Return-Path: virtio-dev-return-4717-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD86B985C73
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Jul 2018 09:00:44 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 20 Jul 2018 16:33:04 +0800
Message-Id: <1532075585-39067-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v36 4/5] mm/page_poison: expose page_poisoning_enabled to kernel modules
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

In some usages, e.g. virtio-balloon, a kernel module needs to know if
page poisoning is in use. This patch exposes the page_poisoning_enabled
function to kernel modules.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_poison.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index aa2b3d3..830f604 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -17,6 +17,11 @@ static int __init early_page_poison_param(char *buf)
 }
 early_param("page_poison", early_page_poison_param);
 
+/**
+ * page_poisoning_enabled - check if page poisoning is enabled
+ *
+ * Return true if page poisoning is enabled, or false if not.
+ */
 bool page_poisoning_enabled(void)
 {
 	/*
@@ -29,6 +34,7 @@ bool page_poisoning_enabled(void)
 		(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
 		debug_pagealloc_enabled()));
 }
+EXPORT_SYMBOL_GPL(page_poisoning_enabled);
 
 static void poison_page(struct page *page)
 {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

