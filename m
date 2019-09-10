Return-Path: virtio-dev-return-6102-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7F8A985AFA
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Sep 2019 14:48:53 +0000 (UTC)
MIME-Version: 1.0
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190907172520.10910.83100.stgit@localhost.localdomain> <20190910122030.GV2063@dhcp22.suse.cz>
In-Reply-To: <20190910122030.GV2063@dhcp22.suse.cz>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 10 Sep 2019 07:48:41 -0700
Message-ID: <CAKgT0Ufw1h45q9H5jraOJkRwvnrxfVNe99bVF1VWCLrzxCrMmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v9 2/8] mm: Adjust shuffle code to allow for future coalescing
To: Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 10, 2019 at 5:20 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 07-09-19 10:25:20, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Move the head/tail adding logic out of the shuffle code and into the
> > __free_one_page function since ultimately that is where it is really
> > needed anyway. By doing this we should be able to reduce the overhead
> > and can consolidate all of the list addition bits in one spot.
>
> This changelog doesn't really explain why we want this. You are
> reshuffling the code, allright, but why do we want to reshuffle? Is the
> result readability a better code reuse or something else? Where
> does the claimed reduced overhead coming from?
>
> From a quick look buddy_merge_likely looks nicer than the code splat
> we have. Good.
>
> But then
>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> [...]
>
> > -     if (is_shuffle_order(order))
> > -             add_to_free_area_random(page, &zone->free_area[order],
> > -                             migratetype);
> > +     area = &zone->free_area[order];
> > +     if (is_shuffle_order(order) ? shuffle_pick_tail() :
> > +         buddy_merge_likely(pfn, buddy_pfn, page, order))
>
> Ouch this is just awful don't you think?

Yeah. I am going to go with Kirill's suggestion and probably do
something more along the lines of:
       bool to_tail;
        ...
        if (is_shuffle_order(order))
                to_tail = shuffle_pick_tail();
       else
                to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);

        if (to_tail)
                add_to_free_area_tail(page, area, migratetype);
        else
                add_to_free_area(page, area, migratetype);

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

