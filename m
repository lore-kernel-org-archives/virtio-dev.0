Return-Path: virtio-dev-return-5982-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 004E0985E69
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 15:49:29 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <6d5b57ca-41ff-5c54-ab20-2b1631a6ce29@redhat.com>
Date: Wed, 14 Aug 2019 11:49:04 -0400
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/19 2:47 PM, Alexander Duyck wrote:
> On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>> This patch introduces the core infrastructure for free page reporting in
>> virtual environments. It enables the kernel to track the free pages which
>> can be reported to its hypervisor so that the hypervisor could
>> free and reuse that memory as per its requirement.
>>
>> While the pages are getting processed in the hypervisor (e.g.,
>> via MADV_DONTNEED), the guest must not use them, otherwise, data loss
>> would be possible. To avoid such a situation, these pages are
>> temporarily removed from the buddy. The amount of pages removed
>> temporarily from the buddy is governed by the backend(virtio-balloon
>> in our case).
>>
>> To efficiently identify free pages that can to be reported to the
>> hypervisor, bitmaps in a coarse granularity are used. Only fairly big
>> chunks are reported to the hypervisor - especially, to not break up THP
>> in the hypervisor - "MAX_ORDER - 2" on x86, and to save space. The bits
>> in the bitmap are an indication whether a page *might* be free, not a
>> guarantee. A new hook after buddy merging sets the bits.
>>
>> Bitmaps are stored per zone, protected by the zone lock. A workqueue
>> asynchronously processes the bitmaps, trying to isolate and report pages
>> that are still free. The backend (virtio-balloon) is responsible for
>> reporting these batched pages to the host synchronously. Once reporting/
>> freeing is complete, isolated pages are returned back to the buddy.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>
[...]
>> +}
>> +
>> +/**
>> + * __page_reporting_enqueue - tracks the freed page in the respective zone's
>> + * bitmap and enqueues a new page reporting job to the workqueue if possible.
>> + */
>> +void __page_reporting_enqueue(struct page *page)
>> +{
>> +       struct page_reporting_config *phconf;
>> +       struct zone *zone;
>> +
>> +       rcu_read_lock();
>> +       /*
>> +        * We should not process this page if either page reporting is not
>> +        * yet completely enabled or it has been disabled by the backend.
>> +        */
>> +       phconf = rcu_dereference(page_reporting_conf);
>> +       if (!phconf)
>> +               return;
>> +
>> +       zone = page_zone(page);
>> +       bitmap_set_bit(page, zone);
>> +
>> +       /*
>> +        * We should not enqueue a job if a previously enqueued reporting work
>> +        * is in progress or we don't have enough free pages in the zone.
>> +        */
>> +       if (atomic_read(&zone->free_pages) >= phconf->max_pages &&
>> +           !atomic_cmpxchg(&phconf->refcnt, 0, 1))
> This doesn't make any sense to me. Why are you only incrementing the
> refcount if it is zero? Combining this with the assignment above, this
> isn't really a refcnt. It is just an oversized bitflag.


The intent for having an extra variable was to ensure that at a time only one
reporting job is enqueued. I do agree that for that purpose I really don't need
a reference counter and I should have used something like bool
'page_hinting_active'. But with bool, I think there could be a possible chance
of race. Maybe I should rename this variable and keep it as atomic.
Any thoughts?


>
> Also I am pretty sure this results in the opportunity to miss pages
> because there is nothing to prevent you from possibly missing a ton of
> pages you could hint on if a large number of pages are pushed out all
> at once and then the system goes idle in terms of memory allocation
> and freeing.


I was looking at how you are enqueuing/processing reporting jobs for each zone.
I am wondering if I should also consider something on similar lines as having
that I might be able to address the concern which you have raised above. But it
would also mean that I have to add an additional flag in the zone_flags. :)

>
[...]
>
>> +EXPORT_SYMBOL_GPL(page_reporting_enable);
>> --
>> 2.21.0
>>
-- 
Thanks
Nitesh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

