Return-Path: virtio-dev-return-2375-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CC4BF5818C68
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2017 05:47:37 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:17 +0800
Message-Id: <1499863221-16206-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v12 4/8] xbitmap: add xb_find_next_bit() and xb_zero()
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

xb_find_next_bit() is added to support find the next "1" or "0" bit
in the given range. xb_zero() is added to support zero the given range
of bits.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 include/linux/xbitmap.h |  4 ++++
 lib/radix-tree.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
index 0b93a46..88c2045 100644
--- a/include/linux/xbitmap.h
+++ b/include/linux/xbitmap.h
@@ -36,6 +36,10 @@ int xb_set_bit(struct xb *xb, unsigned long bit);
 bool xb_test_bit(const struct xb *xb, unsigned long bit);
 int xb_clear_bit(struct xb *xb, unsigned long bit);
 
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end);
+unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
+			       unsigned long end, bool set);
+
 static inline bool xb_empty(const struct xb *xb)
 {
 	return radix_tree_empty(&xb->xbrt);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index d624914..c45b910 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2271,6 +2271,32 @@ bool xb_test_bit(const struct xb *xb, unsigned long bit)
 	return test_bit(bit, bitmap->bitmap);
 }
 
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++)
+		xb_clear_bit(xb, i);
+}
+
+/*
+ * Find the next one (@set = 1) or zero (@set = 0) bit within the bit range
+ * from @start to @end in @xb. If no such bit is found in the given range,
+ * bit end + 1 will be returned.
+ */
+unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
+			       unsigned long end, bool set)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++) {
+		if (xb_test_bit(xb, i) == set)
+			break;
+	}
+
+	return i;
+}
+
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			struct radix_tree_iter *iter, gfp_t gfp, int end)
 {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

