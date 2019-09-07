Return-Path: virtio-dev-return-6071-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FD53985ED7
	for <virtio-dev@lists.oasis-open.org>; Sat,  7 Sep 2019 17:25:49 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 07 Sep 2019 10:25:45 -0700
Message-ID: <20190907172545.10910.88045.stgit@localhost.localdomain>
In-Reply-To: <20190907172225.10910.34302.stgit@localhost.localdomain>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH v9 5/8] arm64: Move hugetlb related definitions out of
 pgtable.h to page-defs.h
To: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, catalin.marinas@arm.com, david@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, ying.huang@intel.com, pbonzini@redhat.com, dan.j.williams@intel.com, fengguang.wu@intel.com, alexander.h.duyck@linux.intel.com, kirill.shutemov@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Move the static definition for things such as HUGETLB_PAGE_ORDER out of
asm/pgtable.h and place it in page-defs.h. By doing this the includes
become much easier to deal with as currently arm64 is the only architecture
that didn't include this definition in the asm/page.h file or a file
included by it.

It also makes logical sense as PAGE_SHIFT was already defined in
page-defs.h so now we also have HPAGE_SHIFT defined there as well.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 arch/arm64/include/asm/page-def.h |    9 +++++++++
 arch/arm64/include/asm/pgtable.h  |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
index f99d48ecbeef..1c5b079e2482 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -20,4 +20,13 @@
 #define CONT_SIZE		(_AC(1, UL) << (CONT_SHIFT + PAGE_SHIFT))
 #define CONT_MASK		(~(CONT_SIZE-1))
 
+/*
+ * Hugetlb definitions.
+ */
+#define HUGE_MAX_HSTATE		4
+#define HPAGE_SHIFT		PMD_SHIFT
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+
 #endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7576df00eb50..06a376de9bd6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -305,15 +305,6 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  */
 #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
 
-/*
- * Hugetlb definitions.
- */
-#define HUGE_MAX_HSTATE		4
-#define HPAGE_SHIFT		PMD_SHIFT
-#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
-#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
-#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-
 static inline pte_t pgd_pte(pgd_t pgd)
 {
 	return __pte(pgd_val(pgd));


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

