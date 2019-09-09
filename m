Return-Path: virtio-dev-return-6086-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5D6998436F
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Sep 2019 15:27:03 +0000 (UTC)
Message-ID: <5cfa877d02b1a6dadbb28f40111726245cf7856f.camel@linux.intel.com>
From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Mon, 09 Sep 2019 08:27:01 -0700
In-Reply-To: <90785d30-cde9-f380-5f4a-8af989b11729@redhat.com>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
	 <20190907172545.10910.88045.stgit@localhost.localdomain>
	 <90785d30-cde9-f380-5f4a-8af989b11729@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 5/8] arm64: Move hugetlb related definitions out of
 pgtable.h to page-defs.h
To: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, catalin.marinas@arm.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, ying.huang@intel.com, pbonzini@redhat.com, dan.j.williams@intel.com, fengguang.wu@intel.com, kirill.shutemov@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 2019-09-09 at 10:52 +0200, David Hildenbrand wrote:
> On 07.09.19 19:25, Alexander Duyck wrote:
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
> >  #define CONT_SIZE		(_AC(1, UL) << (CONT_SHIFT + PAGE_SHIFT))
> >  #define CONT_MASK		(~(CONT_SIZE-1))
> >  
> > +/*
> > + * Hugetlb definitions.
> > + */
> > +#define HUGE_MAX_HSTATE		4
> > +#define HPAGE_SHIFT		PMD_SHIFT
> > +#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
> > +#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
> > +#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> > +
> 
> I wonder if you should initially limit "config PAGE_REPORTING" to x86
> only and unlock it for the other targets once we actually test it there.
> Or did you test PAGE_REPORTING on other architectures as well?
> 

I haven't, but essentially the effects should be the same regardless of
architecture. In addition since this is a feature that can be
enabled/disabled via QEMU I am not sure there is much harm other than
getting additional testing by enabling for all of the architectures at
once.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

