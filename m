Return-Path: virtio-dev-return-2468-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 68AC85818FA8
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Aug 2017 20:38:23 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 17 Aug 2017 11:26:53 +0800
Message-Id: <1502940416-42944-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v14 2/5] lib/xbitmap: add xb_find_next_bit() and xb_zero()
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

xb_find_next_bit() is used to find the next "1" or "0" bit in the
given range. xb_zero() is used to zero the given range of bits.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/xbitmap.h |  3 +++
 lib/xbitmap.c           | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
index 5edbf84..739d08c 100644
--- a/include/linux/xbitmap.h
+++ b/include/linux/xbitmap.h
@@ -38,6 +38,9 @@ static inline void xb_init(struct xb *xb)
 int xb_set_bit(struct xb *xb, unsigned long bit);
 bool xb_test_bit(const struct xb *xb, unsigned long bit);
 void xb_clear_bit(struct xb *xb, unsigned long bit);
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end);
+unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
+			       unsigned long end, bool set);
 
 /* Check if the xb tree is empty */
 static inline bool xb_is_empty(const struct xb *xb)
diff --git a/lib/xbitmap.c b/lib/xbitmap.c
index cc766d9..2267ac2 100644
--- a/lib/xbitmap.c
+++ b/lib/xbitmap.c
@@ -174,3 +174,42 @@ void xb_preload(gfp_t gfp)
 	}
 }
 EXPORT_SYMBOL(xb_preload);
+
+/**
+ *  xb_zero - zero a range of bits in the xbitmap
+ *  @xb: the xbitmap that the bits reside in
+ *  @start: the start of the range, inclusive
+ *  @end: the end of the range, inclusive
+ */
+void xb_zero(struct xb *xb, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	for (i = start; i <= end; i++)
+		xb_clear_bit(xb, i);
+}
+EXPORT_SYMBOL(xb_zero);
+
+/**
+ * xb_find_next_bit - find next 1 or 0 in the give range of bits
+ * @xb: the xbitmap that the bits reside in
+ * @start: the start of the range, inclusive
+ * @end: the end of the range, inclusive
+ * @set: the polarity (1 or 0) of the next bit to find
+ *
+ * Return the index of the found bit in the xbitmap. If the returned index
+ * exceeds @end, it indicates that no such bit is found in the given range.
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
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

