Return-Path: virtio-dev-return-5946-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1165D985DDE
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Aug 2019 20:05:28 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ca362045-9668-18ff-39b0-de91fa72e73c@redhat.com>
Date: Mon, 12 Aug 2019 22:05:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Alexander Duyck <alexander.duyck@gmail.com>, Nitesh Narayan Lal <nitesh@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

>> ---
>>  include/linux/mmzone.h         |  11 ++
>>  include/linux/page_reporting.h |  63 +++++++
>>  mm/Kconfig                     |   6 +
>>  mm/Makefile                    |   1 +
>>  mm/page_alloc.c                |  42 ++++-
>>  mm/page_reporting.c            | 332 +++++++++++++++++++++++++++++++++
>>  6 files changed, 448 insertions(+), 7 deletions(-)
>>  create mode 100644 include/linux/page_reporting.h
>>  create mode 100644 mm/page_reporting.c
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index d77d717c620c..ba5f5b508f25 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -559,6 +559,17 @@ struct zone {
>>         /* Zone statistics */
>>         atomic_long_t           vm_stat[NR_VM_ZONE_STAT_ITEMS];
>>         atomic_long_t           vm_numa_stat[NR_VM_NUMA_STAT_ITEMS];
>> +#ifdef CONFIG_PAGE_REPORTING
>> +       /* Pointer to the bitmap in PAGE_REPORTING_MIN_ORDER granularity */
>> +       unsigned long *bitmap;
>> +       /* Preserve start and end PFN in case they change due to hotplug */
>> +       unsigned long base_pfn;
>> +       unsigned long end_pfn;
>> +       /* Free pages of granularity PAGE_REPORTING_MIN_ORDER */
>> +       atomic_t free_pages;
>> +       /* Number of bits required in the bitmap */
>> +       unsigned long nbits;
>> +#endif
>>  } ____cacheline_internodealigned_in_smp;
> 
> Okay, so the original thing this patch set had going for it was that
> it was non-invasive. However, now you are adding a bunch of stuff to
> the zone. That kind of loses the non-invasive argument for this patch
> set compared to mine.
> 

Adding something to "struct zone" is certainly less invasive than core
buddy modifications, just saying (I agree that this is suboptimal. I
would have guessed that all that's needed is a pointer to some private
structure here). However, the migratetype thingy below looks fishy to me.

> If we are going to continue further with this patch set then it might
> be worth looking into dynamically allocating the space you need for
> this block. At a minimum you could probably look at making the bitmap
> an RCU based setup so you could define the base and end along with the
> bitmap. It would probably help to resolve the hotplug issues you still
> need to address.

Yeah, I guess that makes sense.

[...]
>> +
>> +static int process_free_page(struct page *page,
>> +                            struct page_reporting_config *phconf, int count)
>> +{
>> +       int mt, order, ret = 0;
>> +
>> +       mt = get_pageblock_migratetype(page);
>> +       order = page_private(page);
>> +       ret = __isolate_free_page(page, order);
>> +

I just started looking into the wonderful world of
isolation/compaction/migration.

I don't think saving/restoring the migratetype is correct here. AFAIK,
MOVABLE/UNMOVABLE/RECLAIMABLE is just a hint, doesn't mean that e.g.,
movable pages and up in UNMOVABLE or ordinary kernel allocations on
MOVABLE. So that shouldn't be an issue - I guess.

1. You should never allocate something that is no
MOVABLE/UNMOVABLE/RECLAIMABLE. Especially not, if you have ISOLATE or
CMA here. There should at least be a !is_migrate_isolate_page() check
somewhere

2. set_migratetype_isolate() takes the zone lock, so to avoid racing
with isolation code, you have to hold the zone lock. Your code seems to
do that, so at least you cannot race against isolation.

3. You could end up temporarily allocating something in the
ZONE_MOVABLE. The pages you allocate are, however, not movable. There
would have to be a way to make alloc_contig_range()/offlining code
properly wait until the pages have been processed. Not sure about the
real implications, though - too many details in the code (I wonder if
Alex' series has a way of dealing with that)

When you restore the migratetype, you could suddenly overwrite e.g.,
ISOLATE, which feels wrong.

[...]
> So as per your comments in the cover page, the two functions above
> should also probably be plugged into the zone resizing logic somewhere
> so if a zone is resized the bitmap is adjusted.
> 
>> +/**
>> + * zone_reporting_init - For each zone initializes the page reporting fields
>> + * and allocates the respective bitmap.
>> + *
>> + * This function returns 0 on successful initialization, -ENOMEM otherwise.
>> + */
>> +static int zone_reporting_init(void)
>> +{
>> +       struct zone *zone;
>> +       int ret;
>> +
>> +       for_each_populated_zone(zone) {
>> +#ifdef CONFIG_ZONE_DEVICE
>> +               /* we can not report pages which are not in the buddy */
>> +               if (zone_idx(zone) == ZONE_DEVICE)
>> +                       continue;
>> +#endif
> 
> I'm pretty sure this isn't needed since I don't think the ZONE_DEVICE
> zone will be considered "populated".
> 
I think you are right (although it's confusing, we will have present
sections part of a zone but the zone has no present_pages - screams like
a re factoring - leftover from ZONE_DEVICE introduction).

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

