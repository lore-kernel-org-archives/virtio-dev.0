Return-Path: virtio-dev-return-6151-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EE86985A54
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Sep 2019 15:46:03 +0000 (UTC)
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190918175249.23474.51171.stgit@localhost.localdomain>
 <20190923041330-mutt-send-email-mst@kernel.org>
 <CAKgT0UfFBO9h3heGSo+AaZgUNpy5uuOm3yh62bYwYJ5dq+t1gQ@mail.gmail.com>
 <20190923105746-mutt-send-email-mst@kernel.org>
 <CAKgT0Ufp0bdz3YkbAoKWd5DALFjAkHaSUn_UywW1+3hk4tjPSQ@mail.gmail.com>
 <20190923113722-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <baf3dd5c-9368-d621-a83a-114bb5ae8291@redhat.com>
Date: Mon, 23 Sep 2019 17:45:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190923113722-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v10 3/6] mm: Introduce Reported pages
To: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 23.09.19 17:37, Michael S. Tsirkin wrote:
> On Mon, Sep 23, 2019 at 08:28:00AM -0700, Alexander Duyck wrote:
>> On Mon, Sep 23, 2019 at 8:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Mon, Sep 23, 2019 at 07:50:15AM -0700, Alexander Duyck wrote:
>>>>>> +static inline void
>>>>>> +page_reporting_reset_boundary(struct zone *zone, unsigned int order, int mt)
>>>>>> +{
>>>>>> +     int index;
>>>>>> +
>>>>>> +     if (order < PAGE_REPORTING_MIN_ORDER)
>>>>>> +             return;
>>>>>> +     if (!test_bit(ZONE_PAGE_REPORTING_ACTIVE, &zone->flags))
>>>>>> +             return;
>>>>>> +
>>>>>> +     index = get_reporting_index(order, mt);
>>>>>> +     reported_boundary[index] = &zone->free_area[order].free_list[mt];
>>>>>> +}
>>>>>
>>>>> So this seems to be costly.
>>>>> I'm guessing it's the access to flags:
>>>>>
>>>>>
>>>>>         /* zone flags, see below */
>>>>>         unsigned long           flags;
>>>>>
>>>>>         /* Primarily protects free_area */
>>>>>         spinlock_t              lock;
>>>>>
>>>>>
>>>>>
>>>>> which is in the same cache line as the lock.
>>>>
>>>> I'm not sure what you mean by this being costly?
>>>
>>> I've just been wondering why does will it scale report a 1.5% regression
>>> with this patch.
>>
>> Are you talking about data you have collected from a test you have
>> run, or the data I have run?
> 
> About the kernel test robot auto report that was sent recently.

https://lkml.org/lkml/2019/9/21/112

And if I'm correct, that regression is observable in case reporting is
not enabled. (so with this patch applied only, e.g., on a bare-metal system)


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

