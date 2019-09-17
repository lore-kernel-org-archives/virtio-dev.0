Return-Path: virtio-dev-return-6128-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C5079985C25
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Sep 2019 20:07:38 +0000 (UTC)
MIME-Version: 1.0
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190907172545.10910.88045.stgit@localhost.localdomain> <20190917174853.5csycb5pb5zalsxd@willie-the-truck>
In-Reply-To: <20190917174853.5csycb5pb5zalsxd@willie-the-truck>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Sep 2019 13:07:26 -0700
Message-ID: <CAKgT0Ufoq5BsOwW11SYHDBcy8-U91FgFCxK9XFf5twPWXzpO7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v9 5/8] arm64: Move hugetlb related definitions out of
 pgtable.h to page-defs.h
To: Will Deacon <will@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 17, 2019 at 10:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Sat, Sep 07, 2019 at 10:25:45AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Move the static definition for things such as HUGETLB_PAGE_ORDER out of
> > asm/pgtable.h and place it in page-defs.h. By doing this the includes
> > become much easier to deal with as currently arm64 is the only architecture
> > that didn't include this definition in the asm/page.h file or a file
> > included by it.
> >
> > It also makes logical sense as PAGE_SHIFT was already defined in
> > page-defs.h so now we also have HPAGE_SHIFT defined there as well.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  arch/arm64/include/asm/page-def.h |    9 +++++++++
> >  arch/arm64/include/asm/pgtable.h  |    9 ---------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
> > index f99d48ecbeef..1c5b079e2482 100644
> > --- a/arch/arm64/include/asm/page-def.h
> > +++ b/arch/arm64/include/asm/page-def.h
> > @@ -20,4 +20,13 @@
> >  #define CONT_SIZE            (_AC(1, UL) << (CONT_SHIFT + PAGE_SHIFT))
> >  #define CONT_MASK            (~(CONT_SIZE-1))
> >
> > +/*
> > + * Hugetlb definitions.
> > + */
> > +#define HUGE_MAX_HSTATE              4
> > +#define HPAGE_SHIFT          PMD_SHIFT
> > +#define HPAGE_SIZE           (_AC(1, UL) << HPAGE_SHIFT)
> > +#define HPAGE_MASK           (~(HPAGE_SIZE - 1))
> > +#define HUGETLB_PAGE_ORDER   (HPAGE_SHIFT - PAGE_SHIFT)
> > +
> >  #endif /* __ASM_PAGE_DEF_H */
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 7576df00eb50..06a376de9bd6 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -305,15 +305,6 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
> >   */
> >  #define pte_mkhuge(pte)              (__pte(pte_val(pte) & ~PTE_TABLE_BIT))
> >
> > -/*
> > - * Hugetlb definitions.
> > - */
> > -#define HUGE_MAX_HSTATE              4
> > -#define HPAGE_SHIFT          PMD_SHIFT
> > -#define HPAGE_SIZE           (_AC(1, UL) << HPAGE_SHIFT)
> > -#define HPAGE_MASK           (~(HPAGE_SIZE - 1))
> > -#define HUGETLB_PAGE_ORDER   (HPAGE_SHIFT - PAGE_SHIFT)
> > -
>
> Acked-by: Will Deacon <will@kernel.org>
>
> I'm assuming you're taking this along with the other patches, but please
> shout if you'd rather it went via the arm64 tree.
>
> Will

As it turns out I am close to submitting a v10 that doesn't need this
patch. I basically just needed to move the list manipulators out of
mmzone.h and then moved my header file out of there so I no longer
needed the code.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

