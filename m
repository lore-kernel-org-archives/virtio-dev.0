Return-Path: virtio-dev-return-5964-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC592985E4A
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 10:45:31 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <ca362045-9668-18ff-39b0-de91fa72e73c@redhat.com>
 <d39504c9-93bd-b8f7-e119-84baac5a42d4@redhat.com>
 <32f61f87-6205-5001-866c-a84e20fc9d85@redhat.com>
 <53fb1343-3b18-a566-aaa5-90a1d99d7333@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8735a3a0-e1aa-e64d-af67-5cca3ae2c529@redhat.com>
Date: Tue, 13 Aug 2019 12:44:35 +0200
MIME-Version: 1.0
In-Reply-To: <53fb1343-3b18-a566-aaa5-90a1d99d7333@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Nitesh Narayan Lal <nitesh@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 13.08.19 12:42, Nitesh Narayan Lal wrote:
> 
> On 8/13/19 6:34 AM, David Hildenbrand wrote:
>>>>>> +static int process_free_page(struct page *page,
>>>>>> +                            struct page_reporting_config *phconf, int count)
>>>>>> +{
>>>>>> +       int mt, order, ret = 0;
> [...]
>>>>>> +/**
>>>>>> + * zone_reporting_init - For each zone initializes the page reporting fields
>>>>>> + * and allocates the respective bitmap.
>>>>>> + *
>>>>>> + * This function returns 0 on successful initialization, -ENOMEM otherwise.
>>>>>> + */
>>>>>> +static int zone_reporting_init(void)
>>>>>> +{
>>>>>> +       struct zone *zone;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       for_each_populated_zone(zone) {
>>>>>> +#ifdef CONFIG_ZONE_DEVICE
>>>>>> +               /* we can not report pages which are not in the buddy */
>>>>>> +               if (zone_idx(zone) == ZONE_DEVICE)
>>>>>> +                       continue;
>>>>>> +#endif
>>>>> I'm pretty sure this isn't needed since I don't think the ZONE_DEVICE
>>>>> zone will be considered "populated".
>>>>>
>>>> I think you are right (although it's confusing, we will have present
>>>> sections part of a zone but the zone has no present_pages - screams like
>>>> a re factoring - leftover from ZONE_DEVICE introduction).
>>>
>>> I think in that case it is safe to have this check here.
>>> What do you guys suggest?
>> If it's not needed, I'd say drop it (eventually add a comment).
> 
> 
> Comment to mention that we do not expect a zone with non-buddy page to be
> initialized here?

Something along these lines, or something like

/* ZONE_DEVICE is never considered populated */

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

