Return-Path: virtio-dev-return-2715-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A4DCB5819127
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Nov 2017 06:11:17 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 29 Nov 2017 21:55:17 +0800
Message-Id: <1511963726-34070-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v18 01/10] idr: add #include <linux/bug.h>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The <linux/bug.h> was removed from radix-tree.h by the following commit:
f5bba9d11a256ad2a1c2f8e7fc6aabe6416b7890.

Since that commit, tools/testing/radix-tree/ couldn't pass compilation
due to: tools/testing/radix-tree/idr.c:17: undefined reference to
WARN_ON_ONCE. This patch adds the bug.h header to idr.h to solve the
issue.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 include/linux/idr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 7c3a365..fa14f83 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -15,6 +15,7 @@
 #include <linux/radix-tree.h>
 #include <linux/gfp.h>
 #include <linux/percpu.h>
+#include <linux/bug.h>
 
 struct idr {
 	struct radix_tree_root	idr_rt;
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

