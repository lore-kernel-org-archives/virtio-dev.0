Return-Path: virtio-dev-return-6028-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7942C985D36
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Aug 2019 15:31:51 +0000 (UTC)
MIME-Version: 1.0
References: <20190812131235.27244-1-nitesh@redhat.com> <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com> <df82bc99-a212-4f5c-dc2e-28665060acb2@redhat.com>
In-Reply-To: <df82bc99-a212-4f5c-dc2e-28665060acb2@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 30 Aug 2019 08:31:38 -0700
Message-ID: <CAKgT0Ueqok+bxANVtB1DdYorcEHN7+Grzb8MAxTzSk8uS81pRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Nitesh Narayan Lal <nitesh@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Pankaj Gupta <pagupta@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 30, 2019 at 8:15 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>
> On 8/12/19 2:47 PM, Alexander Duyck wrote:
> > On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >> This patch introduces the core infrastructure for free page reporting in
> >> virtual environments. It enables the kernel to track the free pages which
> >> can be reported to its hypervisor so that the hypervisor could
> >> free and reuse that memory as per its requirement.
> >>
> >> While the pages are getting processed in the hypervisor (e.g.,
> >> via MADV_DONTNEED), the guest must not use them, otherwise, data loss
> >> would be possible. To avoid such a situation, these pages are
> >> temporarily removed from the buddy. The amount of pages removed
> >> temporarily from the buddy is governed by the backend(virtio-balloon
> >> in our case).
> >>
> >> To efficiently identify free pages that can to be reported to the
> >> hypervisor, bitmaps in a coarse granularity are used. Only fairly big
> >> chunks are reported to the hypervisor - especially, to not break up THP
> >> in the hypervisor - "MAX_ORDER - 2" on x86, and to save space. The bits
> >> in the bitmap are an indication whether a page *might* be free, not a
> >> guarantee. A new hook after buddy merging sets the bits.
> >>
> >> Bitmaps are stored per zone, protected by the zone lock. A workqueue
> >> asynchronously processes the bitmaps, trying to isolate and report pages
> >> that are still free. The backend (virtio-balloon) is responsible for
> >> reporting these batched pages to the host synchronously. Once reporting/
> >> freeing is complete, isolated pages are returned back to the buddy.
> >>
> >> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> [...]
> >> +static void scan_zone_bitmap(struct page_reporting_config *phconf,
> >> +                            struct zone *zone)
> >> +{
> >> +       unsigned long setbit;
> >> +       struct page *page;
> >> +       int count = 0;
> >> +
> >> +       sg_init_table(phconf->sg, phconf->max_pages);
> >> +
> >> +       for_each_set_bit(setbit, zone->bitmap, zone->nbits) {
> >> +               /* Process only if the page is still online */
> >> +               page = pfn_to_online_page((setbit << PAGE_REPORTING_MIN_ORDER) +
> >> +                                         zone->base_pfn);
> >> +               if (!page)
> >> +                       continue;
> >> +
> > Shouldn't you be clearing the bit and dropping the reference to
> > free_pages before you move on to the next bit? Otherwise you are going
> > to be stuck with those aren't you?
> >
> >> +               spin_lock(&zone->lock);
> >> +
> >> +               /* Ensure page is still free and can be processed */
> >> +               if (PageBuddy(page) && page_private(page) >=
> >> +                   PAGE_REPORTING_MIN_ORDER)
> >> +                       count = process_free_page(page, phconf, count);
> >> +
> >> +               spin_unlock(&zone->lock);
> > So I kind of wonder just how much overhead you are taking for bouncing
> > the zone lock once per page here. Especially since it can result in
> > you not actually making any progress since the page may have already
> > been reallocated.
> >
>
> I am wondering if there is a way to measure this overhead?
> After thinking about this, I do understand your point.
> One possible way which I can think of to address this is by having a
> page_reporting_dequeue() hook somewhere in the allocation path.

Really in order to stress this you probably need to have a lot of
CPUs, a lot of memory, and something that forces a lot of pages to get
hit such as the memory shuffling feature.

> For some reason, I am not seeing this work as I would have expected
> but I don't have solid reasoning to share yet. It could be simply
> because I am putting my hook at the wrong place. I will continue
> investigating this.
>
> In any case, I may be over complicating things here, so please let me
> if there is a better way to do this.

I have already been demonstrating the "better way" I think there is to
do this. I will push v7 of it early next week unless there is some
other feedback. By putting the bit in the page and controlling what
comes into and out of the lists it makes most of this quite a bit
easier. The only limitation is you have to modify where things get
placed in the lists so you don't create a "vapor lock" that would
stall the feed of pages into the reporting engine.

> If this overhead is not significant we can probably live with it.

You have bigger issues you still have to overcome as I recall. Didn't
you still need to sort out hotplug and a sparse map with a wide span
in a zone? Without those resolved the bitmap approach is still a no-go
regardless of performance.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

