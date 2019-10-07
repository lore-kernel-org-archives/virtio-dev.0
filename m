Return-Path: virtio-dev-return-6208-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC37198406D
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Oct 2019 17:07:06 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
 <c06b68cb-5e94-ae3e-f84e-48087d675a8f@redhat.com>
 <CAKgT0Ud6TT=XxqFx6ePHzbUYqMp5FHVPozRvnNZK3tKV7j2xjg@mail.gmail.com>
 <0a16b11e-ec3b-7196-5b7f-e7395876cf28@redhat.com>
 <d96f744d2c48f5a96c6962c6a0a89d2429e5cab8.camel@linux.intel.com>
 <7fc13837-546c-9c4a-1456-753df199e171@redhat.com>
 <5b6e0b6df46c03bfac906313071ac0362d43c432.camel@linux.intel.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <c2fd074b-1c86-cd93-41ea-ae1a6b2ca841@redhat.com>
Date: Mon, 7 Oct 2019 13:06:53 -0400
MIME-Version: 1.0
In-Reply-To: <5b6e0b6df46c03bfac906313071ac0362d43c432.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/7/19 12:27 PM, Alexander Duyck wrote:
> On Mon, 2019-10-07 at 12:19 -0400, Nitesh Narayan Lal wrote:
>> On 10/7/19 11:33 AM, Alexander Duyck wrote:
>>> On Mon, 2019-10-07 at 08:29 -0400, Nitesh Narayan Lal wrote:
>>>> On 10/2/19 10:25 AM, Alexander Duyck wrote:
>>>>
>> [...]
>>>> You  don't have to, I can fix the issues in my patch-set. :)
>>>>> Sounds good. Hopefully the stuff I pointed out above helps you to g=
et
>>>>> a reproduction and resolve the issues.
>>>> So I did observe a significant drop in running my v12 path-set [1] w=
ith the
>>>> suggested test setup. However, on making certain changes the perform=
ance
>>>> improved significantly.
>>>>
>>>> I used my v12 patch-set which I have posted earlier and made the fol=
lowing
>>>> changes:
>>>> 1. Started reporting only (MAX_ORDER - 1) pages and increased the nu=
mber of
>>>>     pages that can be reported at a time to 32 from 16. The intent o=
f making
>>>>     these changes was to bring my configuration closer to what Alexa=
nder is
>>>>     using.
>>> The increase from 16 to 32 is valid. No point in working in too small=
 of
>>> batches. However tightening the order to only test for MAX_ORDER - 1 =
seems
>>> like a step in the wrong direction. The bitmap approach doesn't have =
much
>>> value if it can only work with the highest order page. I realize it i=
s
>>> probably necessary in order to make the trick for checking on page_bu=
ddy
>>> work, but it seems very limiting.
>> If using (pageblock_order - 1) is a better way to do this, then I can =
probably
>> switch to that.
>> I will agree with the fact that we have to make the reporting order
>> configurable, atleast to an extent.
> I think you mean pageblock_order, not pageblock_order - 1. The problem
> with pageblock_order - 1 is that it will have a negative impact on
> performance as it would disable THP.

Ah, I see. Yes my bad.

>
>>>> 2. I made an additional change in my bitmap scanning logic to preven=
t acquiring
>>>>     spinlock if the page is already allocated.
>>> Again, not a fan. It basically means you can only work with MAX_ORDER=
 - 1
>>> and there will be no ability to work with anything smaller.
>>>
>>>> Setup:
>>>> On a 16 vCPU 30 GB single NUMA guest affined to a single host NUMA, =
I ran the
>>>> modified will-it-scale/page_fault number of times and calculated the=
 average
>>>> of the number of process and threads launched on the 16th core to co=
mpare the
>>>> impact of my patch-set against an unmodified kernel.
>>>>
>>>>
>>>> Conclusion:
>>>> %Drop in number of processes launched on 16th vCPU =3D     1-2%
>>>> %Drop in number of threads launched on 16th vCPU     =3D     5-6%
>>> These numbers don't make that much sense to me. Are you talking about=
 a
>>> fully functioning setup that is madvsing away the memory in the
>>> hypervisor?
>> Without making this change I was observing a significant amount of dro=
p
>> in the number of processes and specifically in the number of threads.
>> I did a double-check of the configuration which I have shared.
>> I was also observing the "AnonHugePages" via meminfo to check the THP =
usage.
>> Any more suggestions about what else I can do to verify?
>> I will be more than happy to try them out.
> So what was the size of your guest? One thing that just occurred to me =
is
> that you might be running a much smaller guest than I was.

I am running a 30 GB guest.

>
>>>  If so I would have expected a much higher difference versus
>>> baseline as zeroing/faulting the pages in the host gets expensive fai=
rly
>>> quick. What is the host kernel you are running your test on? I'm just=

>>> wondering if there is some additional overhead currently limiting you=
r
>>> setup. My host kernel was just the same kernel I was running in the g=
uest,
>>> just built without the patches applied.
>> Right now I have a different host-kernel. I can install the same kerne=
l to the
>> host as well and see if that changes anything.
> The host kernel will have a fairly significant impact as I recall. For
> example running a stock CentOS kernel lowered the performance compared =
to
> running a linux-next kernel. As a result the numbers looked better sinc=
e
> the overall baseline was lower to begin with as the host OS was
> introducing additional overhead.

I see in that case I will try by installing the same guest kernel
to the host as well.

>
>>>> Other observations:
>>>> - I also tried running Alexander's latest v11 page-reporting patch s=
et and
>>>>   observe a similar amount of average degradation in the number of p=
rocesses
>>>>   and threads.
>>>> - I didn't include the linear component recorded by will-it-scale be=
cause for
>>>>   some reason it was fluctuating too much even when I was using an u=
nmodified
>>>>   kernel. If required I can investigate this further.
>>>>
>>>> Note: If there is a better way to analyze the will-it-scale/page_fau=
lt results
>>>> then please do let me know.
>>> Honestly I have mostly just focused on the processes performance.
>> In my observation processes seems to be most consistent in general.
> Agreed.
>
>>>  There is
>>> usually a fair bit of variability but a pattern forms after a few run=
s so
>>> you can generally tell if a configuration is an improvement or not.
>> Yeah, that's why I thought of taking the average of 5-6 runs.
> Same here. I am usually running about 5 iterations.
>
>>>> Other setup details:
>>>> Following are the configurations which I enabled to run my tests:
>>>> - Enabled: CONFIG_SLAB_FREELIST_RANDOM & CONFIG_SHUFFLE_PAGE_ALLOCAT=
OR
>>>> - Set host THP to always
>>>> - Set guest THP to madvise
>>>> - Added the suggested madvise call in page_fault source code.
>>>> @Alexander please let me know if I missed something.
>>> This seems about right.
>>>
>>>> The current state of my v13:
>>>> I still have to look into Michal's suggestion of using page-isolatio=
n API's
>>>> instead of isolating the page. However, I believe at this moment our=
 objective
>>>> is to decide with which approach we can proceed and that's why I dec=
ided to
>>>> post the numbers by making small required changes in v12 instead of =
posting a
>>>> new series.
>>>>
>>>>
>>>> Following are the changes which I have made on top of my v12:
>>>>
>>>> page_reporting.h change:
>>>> -#define PAGE_REPORTING_MIN_ORDER               (MAX_ORDER - 2)
>>>> -#define PAGE_REPORTING_MAX_PAGES               16
>>>> +#define PAGE_REPORTING_MIN_ORDER              (MAX_ORDER - 1)
>>>> +#define PAGE_REPORTING_MAX_PAGES              32
>>>>
>>>> page_reporting.c change:
>>>> @@ -101,8 +101,12 @@ static void scan_zone_bitmap(struct page_report=
ing_config
>>>> *phconf,
>>>>                 /* Process only if the page is still online */
>>>>                 page =3D pfn_to_online_page((setbit << PAGE_REPORTIN=
G_MIN_ORDER) +
>>>>                                           zone->base_pfn);
>>>> -               if (!page)
>>>> +               if (!page || !PageBuddy(page)) {
>>>> +                       clear_bit(setbit, zone->bitmap);
>>>> +                       atomic_dec(&zone->free_pages);
>>>>                         continue;
>>>> +               }
>>>>
>>> I suspect the zone->free_pages is going to be expensive for you to de=
al
>>> with. It is a global atomic value and is going to have the cacheline
>>> bouncing that it is contained in. As a result thinks like setting the=

>>> bitmap with be more expensive as every tome a CPU increments free_pag=
es it
>>> will likely have to take the cache line containing the bitmap pointer=
 as
>>> well.
>> I see I will have to explore this more. I am wondering if there is a w=
ay to
>> measure this If its effect is not visible in will-it-scale/page_fault1=
=2E If
>> there is a noticeable amount of degradation, I will have to address th=
is.
> If nothing else you might look at seeing if you can split up the
> structures so that the bitmap and nr_bits is in a different region
> somewhere since those are read-mostly values.

ok, I will try to understand the issue and your suggestion.
Thank you for bringing this up.

> Also you are now updating the bitmap and free_pages both inside and
> outside of the zone lock so that will likely have some impact.

So as per your previous suggestion, I have made the bitmap structure
object as a rcu protected pointer. So we are safe from that side.
The other downside which I can think of is a race where one page
trying to increment free_pages and other trying to decrements it.
However, being an atomic variable that should not be a problem.
Did I miss anything? =C2=A0=C2=A0=C2=A0


>
>>>> @Alexander in case you decide to give it a try and find different re=
sults,
>>>> please do let me know.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20190812131235.27244-1-nitesh@redha=
t.com/
>>>>
>>>>
>>> If I have some free time I will take a look.
>> That would be great, thanks.
>>
>>>  However one thing that
>>> concerns me about this change is that it will limit things much furth=
er in
>>> terms of how much memory can ultimately be freed since you are now on=
ly
>>> working with the highest order page and that becomes a hard requireme=
nt
>>> for your design.
>> I would assume that should be resolved with (pageblock_order - 1).
> There is no need for the - 1. The pageblock_order value is the lowest y=
ou
> can go before you start causing THP to be disabled. If you cross that
> threshold the performance will drop significantly.=20


Makes sense.


--
Nitesh



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

