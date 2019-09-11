Return-Path: virtio-dev-return-6120-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09AA8985C72
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 14:05:09 +0000 (UTC)
References: <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910175213.GD4023@dhcp22.suse.cz>
 <1d7de9f9f4074f67c567dbb4cc1497503d739e30.camel@linux.intel.com>
 <20190911113619.GP4023@dhcp22.suse.cz>
 <20190911080804-mutt-send-email-mst@kernel.org>
 <20190911121941.GU4023@dhcp22.suse.cz> <20190911122526.GV4023@dhcp22.suse.cz>
 <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
 <20190911125413.GY4023@dhcp22.suse.cz>
 <736594d6-b9ae-ddb9-2b96-85648728ef33@redhat.com>
 <20190911132002.GA4023@dhcp22.suse.cz>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <7a83df34-3d0b-31c9-6b6d-aea62024a7dd@redhat.com>
Date: Wed, 11 Sep 2019 10:03:52 -0400
MIME-Version: 1.0
In-Reply-To: <20190911132002.GA4023@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/11/19 9:20 AM, Michal Hocko wrote:
> On Wed 11-09-19 15:03:39, David Hildenbrand wrote:
>> On 11.09.19 14:54, Michal Hocko wrote:
>>> On Wed 11-09-19 14:42:41, David Hildenbrand wrote:
>>>> On 11.09.19 14:25, Michal Hocko wrote:
>>>>> On Wed 11-09-19 14:19:41, Michal Hocko wrote:
>>>>>> On Wed 11-09-19 08:08:38, Michael S. Tsirkin wrote:
>>>>>>> On Wed, Sep 11, 2019 at 01:36:19PM +0200, Michal Hocko wrote:
>>>>>>>> On Tue 10-09-19 14:23:40, Alexander Duyck wrote:
>>>>>>>> [...]
>>>>>>>>> We don't put any limitations on the allocator other then that i=
t needs to
>>>>>>>>> clean up the metadata on allocation, and that it cannot allocat=
e a page
>>>>>>>>> that is in the process of being reported since we pulled it fro=
m the
>>>>>>>>> free_list. If the page is a "Reported" page then it decrements =
the
>>>>>>>>> reported_pages count for the free_area and makes sure the page =
doesn't
>>>>>>>>> exist in the "Boundary" array pointer value, if it does it move=
s the
>>>>>>>>> "Boundary" since it is pulling the page.
>>>>>>>> This is still a non-trivial limitation on the page allocation fr=
om an
>>>>>>>> external code IMHO. I cannot give any explicit reason why an ord=
ering on
>>>>>>>> the free list might matter (well except for page shuffling which=
 uses it
>>>>>>>> to make physical memory pattern allocation more random) but the
>>>>>>>> architecture seems hacky and dubious to be honest. It shoulds li=
ke the
>>>>>>>> whole interface has been developed around a very particular and =
single
>>>>>>>> purpose optimization.
>>>>>>>>
>>>>>>>> I remember that there was an attempt to report free memory that =
provided
>>>>>>>> a callback mechanism [1], which was much less intrusive to the i=
nternals
>>>>>>>> of the allocator yet it should provide a similar functionality. =
Did you
>>>>>>>> see that approach? How does this compares to it? Or am I complet=
ely off
>>>>>>>> when comparing them?
>>>>>>>>
>>>>>>>> [1] mostly likely not the latest version of the patchset
>>>>>>>> http://lkml.kernel.org/r/1502940416-42944-5-git-send-email-wei.w=
=2Ewang@intel.com
>>>>>>> Linus nacked that one. He thinks invoking callbacks with lots of
>>>>>>> internal mm locks is too fragile.
>>>>>> I would be really curious how much he would be happy about injecti=
ng
>>>>>> other restrictions on the allocator like this patch proposes. This=
 is
>>>>>> more intrusive as it has a higher maintenance cost longterm IMHO.
>>>>> Btw. I do agree that callbacks with internal mm locks are not great=

>>>>> either. We do have a model for that in mmu_notifiers and it is some=
thing
>>>>> I do consider PITA, on the other hand it is mostly sleepable part o=
f the
>>>>> interface which makes it the real pain. The above callback mechanis=
m was
>>>>> explicitly documented with restrictions and that the context is
>>>>> essentially atomic with no access to particular struct pages and no=

>>>>> expensive operations possible. So in the end I've considered it
>>>>> acceptably painful. Not that I want to override Linus' nack but if
>>>>> virtualization usecases really require some form of reporting and n=
o
>>>>> other way to do that push people to invent even more interesting
>>>>> approaches then we should simply give them/you something reasonable=

>>>>> and least intrusive to our internals.
>>>>>
>>>> The issue with "[PATCH v14 4/5] mm: support reporting free page bloc=
ks"
>>>>  is that it cannot really handle the use case we have here if I am n=
ot
>>>> wrong. While a page is getting processed by the hypervisor (e.g.
>>>> MADV_DONTNEED), it must not get reused.
>>> What prevents to use the callback to get a list of pfn ranges to work=
 on
>>> and then use something like start_isolate_page_range on the collected=

>>> pfn ranges to make sure nobody steals pages from under your feet, do
>>> your thing and drop the isolated state afterwards.
>>>
>>> I am saying somethig like because you wouldn't really want a generic
>>> has_unmovable_pages but rather
>>>                 if (!page_ref_count(page)) {
>>>                         if (PageBuddy(page))
>>>                                 iter +=3D (1 << page_order(page)) - 1=
;
>>>                         continue;
>>>                 }
>>> subset of it.
>>>
>> Something slightly similar is being performed by Nitesh's patch set. O=
n
>> every free of a certain granularity, he records it in the bitmap. Thes=
e
>> bits are "hints of free pages".
>>
>> A thread then walks over the bitmap and tries to allocate the "hints".=

>> If the pages were already reused, the bit is silently cleared.
>>
>> Instead of allocating/freeing, we could only try to isolate the
>> pageblock, then test if free. (One of the usual issues to work around =
is
>> MAX_ORDER-1 crossing pageblocks, that might need special care)
> OK, cool that I have reinvented the wheel ;). Allocation is indeed not
> necessary as long as pages are isolated because nobody will allocate
> them.
> =20
>> I think you should have a look at the rough idea of Nitesh's patch set=

>> to see if something like that is going into a better direction. The
>> bitmap part is in place to do bulk reporting and avoid duplicate repor=
ts.
> Let's see how much time I can find for that in my endless inbox whack a=
 mole.
> =20
>> I think main points we want (and what I am missing from callback idea
>> being discussed) are
>> 1. Do bulk reporting only when a certain threshold is reached
> Is a time based approach too coarse?

I haven't looked into it yet. One situation which I would definitely
want to avoid is to unnecessary invoke bitmap scans when there are not
sufficient free pages available in the zone.
I can take a look at it if required.


>
>> 2. Report only bigger granularities (especially, avoid THP splits in t=
he
>> hypervisor - >=3D 2MB proofed to be effective)
> the callback has supported order based scan in some of its iteration.
>
>> 3. Avoid reporting what has just been reported.
> Is the overhead of checking a pfn range in a bitmask that much of an
> overhead to really care?

In most of the cases No. Similar to Alexander I was also running will-it-=
scale/
page_fault1 to analyze the performance impact of the patch series and hav=
en't
noticed any significant degradation.
In some specific cases, we may see noticeable degradation due to the scan=
ning
overhead.

>
>> 4. Continuously report, not the "one time report everything" approach.=

> So you mean the allocator reporting this rather than an external code t=
o
> poll right? I do not know, how much this is nice to have than must have=
?

Not sure if I understood the question completely.
But yes in my case any workload which is allocating and freeing pages wil=
l end
up initiating reporting requests based on the number of free pages in the=
 zone.

--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

