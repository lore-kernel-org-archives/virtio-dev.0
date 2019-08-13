Return-Path: virtio-dev-return-5962-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C8F9985E4A
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 10:34:25 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <ca362045-9668-18ff-39b0-de91fa72e73c@redhat.com>
 <d39504c9-93bd-b8f7-e119-84baac5a42d4@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <32f61f87-6205-5001-866c-a84e20fc9d85@redhat.com>
Date: Tue, 13 Aug 2019 12:34:04 +0200
MIME-Version: 1.0
In-Reply-To: <d39504c9-93bd-b8f7-e119-84baac5a42d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Nitesh Narayan Lal <nitesh@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

>>>> +static int process_free_page(struct page *page,
>>>> +                            struct page_reporting_config *phconf, int count)
>>>> +{
>>>> +       int mt, order, ret = 0;
>>>> +
>>>> +       mt = get_pageblock_migratetype(page);
>>>> +       order = page_private(page);
>>>> +       ret = __isolate_free_page(page, order);
>>>> +
>> I just started looking into the wonderful world of
>> isolation/compaction/migration.
>>
>> I don't think saving/restoring the migratetype is correct here. AFAIK,
>> MOVABLE/UNMOVABLE/RECLAIMABLE is just a hint, doesn't mean that e.g.,
>> movable pages and up in UNMOVABLE or ordinary kernel allocations on
>> MOVABLE. So that shouldn't be an issue - I guess.
>>
>> 1. You should never allocate something that is no
>> MOVABLE/UNMOVABLE/RECLAIMABLE. Especially not, if you have ISOLATE or
>> CMA here. There should at least be a !is_migrate_isolate_page() check
>> somewhere
>>
>> 2. set_migratetype_isolate() takes the zone lock, so to avoid racing
>> with isolation code, you have to hold the zone lock. Your code seems to
>> do that, so at least you cannot race against isolation.
>>
>> 3. You could end up temporarily allocating something in the
>> ZONE_MOVABLE. The pages you allocate are, however, not movable. There
>> would have to be a way to make alloc_contig_range()/offlining code
>> properly wait until the pages have been processed. Not sure about the
>> real implications, though - too many details in the code (I wonder if
>> Alex' series has a way of dealing with that)
>>
>> When you restore the migratetype, you could suddenly overwrite e.g.,
>> ISOLATE, which feels wrong.
> 
> 
> I was triggering an occasional CPU stall bug earlier, with saving and restoring
> the migratetype I was able to fix it.
> But I will further look into this to figure out if it is really required.
> 

You should especially look into handling isolated/cma pages. Maybe that
was the original issue. Alex seems to have added that in his latest
series (skipping isolated/cma pageblocks completely) as well.

>> [...]
>>> So as per your comments in the cover page, the two functions above
>>> should also probably be plugged into the zone resizing logic somewhere
>>> so if a zone is resized the bitmap is adjusted.
>>>
>>>> +/**
>>>> + * zone_reporting_init - For each zone initializes the page reporting fields
>>>> + * and allocates the respective bitmap.
>>>> + *
>>>> + * This function returns 0 on successful initialization, -ENOMEM otherwise.
>>>> + */
>>>> +static int zone_reporting_init(void)
>>>> +{
>>>> +       struct zone *zone;
>>>> +       int ret;
>>>> +
>>>> +       for_each_populated_zone(zone) {
>>>> +#ifdef CONFIG_ZONE_DEVICE
>>>> +               /* we can not report pages which are not in the buddy */
>>>> +               if (zone_idx(zone) == ZONE_DEVICE)
>>>> +                       continue;
>>>> +#endif
>>> I'm pretty sure this isn't needed since I don't think the ZONE_DEVICE
>>> zone will be considered "populated".
>>>
>> I think you are right (although it's confusing, we will have present
>> sections part of a zone but the zone has no present_pages - screams like
>> a re factoring - leftover from ZONE_DEVICE introduction).
> 
> 
> I think in that case it is safe to have this check here.
> What do you guys suggest?

If it's not needed, I'd say drop it (eventually add a comment).


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

