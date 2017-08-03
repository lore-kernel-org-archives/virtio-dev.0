Return-Path: virtio-dev-return-2435-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 328CB1CB8078
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Aug 2017 23:48:40 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu,  3 Aug 2017 14:38:16 +0800
Message-Id: <1501742299-4369-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v13 2/5] xbitmap: add xb_find_next_bit() and xb_zero()
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, mawilcox@microsoft.com, akpm@linux-foundation.org
Cc: virtio-dev@lists.oasis-open.org, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

xb_find_next_bit() supports to find the next "1" or "0" bit in the
given range. xb_zero() supports to zero the given range of bits.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 include/linux/xbitmap.h |  4 ++++
 lib/radix-tree.c        | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index d8c3c18..84842a3 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2272,6 +2272,34 @@ bool xb_test_bit(const struct xb *xb, unsigned long bit)
 	return test_bit(bit, bitmap->bitmap);
 }
 
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++)
+		xb_clear_bit(xb, i);
+}
+EXPORT_SYMBOL(xb_zero);
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
+EXPORT_SYMBOL(xb_find_next_bit);
+
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			struct radix_tree_iter *iter, gfp_t gfp, int end)
 {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

