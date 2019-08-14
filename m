Return-Path: virtio-dev-return-5979-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5518D985D18
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 12:57:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
References: <20190812213158.22097.30576.stgit@localhost.localdomain>
 <20190812213344.22097.86213.stgit@localhost.localdomain>
 <222cbe8f-90c5-5437-4a77-9926cacc398f@redhat.com>
 <712cc03ea69fcd59080291b5832adddf39d20cd3.camel@linux.intel.com>
Message-ID: <d607508d-5b04-cef8-1ab7-7e4bed7fa54f@redhat.com>
Date: Wed, 14 Aug 2019 14:57:14 +0200
MIME-Version: 1.0
In-Reply-To: <712cc03ea69fcd59080291b5832adddf39d20cd3.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v5 4/6] mm: Introduce Reported pages
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, nitesh@redhat.com, kvm@vger.kernel.org, mst@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, virtio-dev@lists.oasis-open.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com, konrad.wilk@oracle.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

>>> +struct page *get_unreported_page(struct zone *zone, unsigned int order, int mt)
>>> +{
>>> +	struct list_head *tail = get_unreported_tail(zone, order, mt);
>>> +	struct free_area *area = &(zone->free_area[order]);
>>> +	struct list_head *list = &area->free_list[mt];
>>> +	struct page *page;
>>> +
>>> +	/* zone lock should be held when this function is called */
>>> +	lockdep_assert_held(&zone->lock);
>>> +
>>> +	/* Find a page of the appropriate size in the preferred list */
>>> +	page = list_last_entry(tail, struct page, lru);
>>> +	list_for_each_entry_from_reverse(page, list, lru) {
>>> +		/* If we entered this loop then the "raw" list isn't empty */
>>> +
>>> +		/* If the page is reported try the head of the list */
>>> +		if (PageReported(page)) {
>>> +			page = list_first_entry(list, struct page, lru);
>>> +
>>> +			/*
>>> +			 * If both the head and tail are reported then reset
>>> +			 * the boundary so that we read as an empty list
>>> +			 * next time and bail out.
>>> +			 */
>>> +			if (PageReported(page)) {
>>> +				page_reporting_add_to_boundary(page, zone, mt);
>>> +				break;
>>> +			}
>>> +		}
>>> +
>>> +		del_page_from_free_list(page, zone, order);
>>> +
>>> +		/* record migratetype and order within page */
>>> +		set_pcppage_migratetype(page, mt);
>>> +		set_page_private(page, order);
>>
>> Can you elaborate why you (similar to Nitesh) have to save/restore the
>> migratetype? I can't yet follow why that is necessary. You could simply
>> set it to MOVABLE (like e.g., undo_isolate_page_range() would do via
>> alloc_contig_range()). If a pageblock is completely free, it might even
>> make sense to set it to MOVABLE.
>>
>> (mainly wondering if this is required here and what the rational is)
> 
> It was mostly a "put it back where I found it" type of logic. I suppose I
> could probably just come back and read the migratetype out of the pfnblock
> and return it there. Is that what you are thinking? If so I can probably
> look at doing that instead, assuming there are no issues with that.

"read the migratetype out of the pfnblock" - that's what I would have
done. Who could change it in the meanwhile (besides isolation)? (besides
the buddy converting migratetypes on demand). I haven't yet understood
if this saving/restring is really needed or beneficial.


> 
>> Now a theoretical issue:
>>
>> You are allocating pages from all zones, including the MOVABLE zone. The
>> pages are currently unmovable (however, only temporarily allocated).
> 
> In my mind they aren't in too different of a state from pages that have
> had their reference count dropped to 0 by something like __free_pages, but
> haven't yet reached the function __free_pages_ok.

Good point, however that code sequence is fairly small. If you have a
hypervisor call in between (+ taking the BQL, + mmap_sem in the
hypervisor), things might look different (-> more latency). However, the
hypervisor might also reschedule while in that critical section.

But I am not sure yet it there is a subtle difference between

1. Some page just got freed (and maybe we are lucky that this happened)
and we run into this corner case.

2. We are actively pulling out pages and putting them back, making this
trigger more frequently.

I guess I could try to test how alloc_contig_range() play together with
free page reporting to see if there is now a notable difference.

> 
> The general idea is that they should be in this state for a very short-
> lived period of time. They are essentially free pages that just haven't
> made it back into the buddy allocator.
> 
>> del_page_from_free_area() will clear PG_buddy, and leave the refcount of
>> the page set to zero (!). has_unmovable_pages() will skip any pages
>> either on the MOVABLE zone or with a refcount of zero. So all pages that
>> are being reported are detected as movable. The isolation of allocated
>> pages will work - which is not bad, but I wonder what the implications are.
> 
> So as per my comment above I am fairly certain this isn't a new state that
> my code has introduced. In fact isolate_movable_page() calls out the case
> in the comments at the start of the function. Specifically it states:
>         /*
>          * Avoid burning cycles with pages that are yet under __free_pages(),
>          * or just got freed under us.
>          *
>          * In case we 'win' a race for a movable page being freed under us and
>          * raise its refcount preventing __free_pages() from doing its job
>          * the put_page() at the end of this block will take care of
>          * release this page, thus avoiding a nasty leakage.
>          */
>         if (unlikely(!get_page_unless_zero(page)))
>                 goto out;
> 

Please note that this is only valid for movable pages, but not for
random pages with a refcount of zero (e.g., isolate_movable_page() is
only called when __PageMovable()).

> So it would seem like this case is already handled. I am assuming the fact
> that the migrate type for the pfnblock was set to isolate before we got
> here would mean that when I call put_reported_page the final result will
> be that the page is placed into the freelist for the isolate migratetype.
> 
>> As far as I can follow, alloc_contig_range() ->
>> __alloc_contig_migrate_range() -> isolate_migratepages_range() ->
>> isolate_migratepages_block() will choke on these pages ((!PageLRU(page)
>> -> !__PageMovable(page) -> fail), essentially making
>> alloc_contig_range() range fail. Same could apply to offline_pages().
>>
>> I would have thought that there has to be something like a
>> reported_pages_drain_all(), that waits until all reports are over (or
>> even signals to the hypervisor to abort reporting). As the pages are
>> isolated, they won't be allocated for reporting again.
> 
> The thing is I only have 16 pages at most sitting in the scatterlist. In
> most cases the response should be quick enough that by the time I could
> make a request to abort reporting it would have likely already completed.

The "in most cases" is what's bugging me. It's not deterministic. E.g.,
try to allocate a gigantic page -> fails. Try again -> works. And that
would happen even on MOVABLE memory that is supposed to be somewhat
reliable.

Yes, it's not a lot of pages, but if it can happen it will happen :)

> 
> Also, unless there is already a ton of memory churn then we probably
> wouldn't need to worry about page reporting really causing too much of an
> issue. Specifically the way I structured the logic was that we only pull
> out up to 16 pages at a time. What should happen is that we will continue
> to build a list of "reported" pages in the free_list until we start
> bumping up against the allocator, in that case the allocator should start
> pulling reported pages and we will stop reporting with hopefully enough
> "reported" pages built up that it can allocate out of those until the last
> 16 or fewer reported pages are returned to the free_list.
> 
>> I have not yet understood completely the way all the details work. I am
>> currently looking into using alloc_contig_range() in a different
>> context, which would co-exist with free-page-reporting.
> 
> I am pretty sure the two can "play well" together, even in their current
> form. One thing I could look at doing would be to skip a page if the
> migratetype of the pfnblock indicates that it is an isolate block. I would
> essentially have to pull it out of the free_list I am working with and
> drop it into the MIGRATE_ISOLATE freelist.

Yeah, there could just be more some false negatives (meaning,
alloc_contig_range() would fail more frequently).

Complicated stuff :)

-- 

Thanks,

David / dhildenb



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

