Return-Path: virtio-dev-return-6206-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD28998406D
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Oct 2019 16:19:25 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
 <c06b68cb-5e94-ae3e-f84e-48087d675a8f@redhat.com>
 <CAKgT0Ud6TT=XxqFx6ePHzbUYqMp5FHVPozRvnNZK3tKV7j2xjg@mail.gmail.com>
 <0a16b11e-ec3b-7196-5b7f-e7395876cf28@redhat.com>
 <d96f744d2c48f5a96c6962c6a0a89d2429e5cab8.camel@linux.intel.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <7fc13837-546c-9c4a-1456-753df199e171@redhat.com>
Date: Mon, 7 Oct 2019 12:19:13 -0400
MIME-Version: 1.0
In-Reply-To: <d96f744d2c48f5a96c6962c6a0a89d2429e5cab8.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/7/19 11:33 AM, Alexander Duyck wrote:
> On Mon, 2019-10-07 at 08:29 -0400, Nitesh Narayan Lal wrote:
>> On 10/2/19 10:25 AM, Alexander Duyck wrote:
>>
[...]
>> You  don't have to, I can fix the issues in my patch-set. :)
>>> Sounds good. Hopefully the stuff I pointed out above helps you to get=

>>> a reproduction and resolve the issues.
>> So I did observe a significant drop in running my v12 path-set [1] wit=
h the
>> suggested test setup. However, on making certain changes the performan=
ce
>> improved significantly.
>>
>> I used my v12 patch-set which I have posted earlier and made the follo=
wing
>> changes:
>> 1. Started reporting only (MAX_ORDER - 1) pages and increased the numb=
er of
>>     pages that can be reported at a time to 32 from 16. The intent of =
making
>>     these changes was to bring my configuration closer to what Alexand=
er is
>>     using.
> The increase from 16 to 32 is valid. No point in working in too small o=
f
> batches. However tightening the order to only test for MAX_ORDER - 1 se=
ems
> like a step in the wrong direction. The bitmap approach doesn't have mu=
ch
> value if it can only work with the highest order page. I realize it is
> probably necessary in order to make the trick for checking on page_budd=
y
> work, but it seems very limiting.

If using (pageblock_order - 1) is a better way to do this, then I can pro=
bably
switch to that.
I will agree with the fact that we have to make the reporting order
configurable, atleast to an extent.

>
>> 2. I made an additional change in my bitmap scanning logic to prevent =
acquiring
>>     spinlock if the page is already allocated.
> Again, not a fan. It basically means you can only work with MAX_ORDER -=
 1
> and there will be no ability to work with anything smaller.
>
>> Setup:
>> On a 16 vCPU 30 GB single NUMA guest affined to a single host NUMA, I =
ran the
>> modified will-it-scale/page_fault number of times and calculated the a=
verage
>> of the number of process and threads launched on the 16th core to comp=
are the
>> impact of my patch-set against an unmodified kernel.
>>
>>
>> Conclusion:
>> %Drop in number of processes launched on 16th vCPU =3D     1-2%
>> %Drop in number of threads launched on 16th vCPU     =3D     5-6%
> These numbers don't make that much sense to me. Are you talking about a=

> fully functioning setup that is madvsing away the memory in the
> hypervisor?


Without making this change I was observing a significant amount of drop
in the number of processes and specifically in the number of threads.
I did a double-check of the configuration which I have shared.
I was also observing the "AnonHugePages" via meminfo to check the THP usa=
ge.
Any more suggestions about what else I can do to verify?
I will be more than happy to try them out.

>  If so I would have expected a much higher difference versus
> baseline as zeroing/faulting the pages in the host gets expensive fairl=
y
> quick. What is the host kernel you are running your test on? I'm just
> wondering if there is some additional overhead currently limiting your
> setup. My host kernel was just the same kernel I was running in the gue=
st,
> just built without the patches applied.

Right now I have a different host-kernel. I can install the same kernel t=
o the
host as well and see if that changes anything.

>
>> Other observations:
>> - I also tried running Alexander's latest v11 page-reporting patch set=
 and
>>   observe a similar amount of average degradation in the number of pro=
cesses
>>   and threads.
>> - I didn't include the linear component recorded by will-it-scale beca=
use for
>>   some reason it was fluctuating too much even when I was using an unm=
odified
>>   kernel. If required I can investigate this further.
>>
>> Note: If there is a better way to analyze the will-it-scale/page_fault=
 results
>> then please do let me know.
> Honestly I have mostly just focused on the processes performance.

In my observation processes seems to be most consistent in general.

>  There is
> usually a fair bit of variability but a pattern forms after a few runs =
so
> you can generally tell if a configuration is an improvement or not.

Yeah, that's why I thought of taking the average of 5-6 runs.

>
>> Other setup details:
>> Following are the configurations which I enabled to run my tests:
>> - Enabled: CONFIG_SLAB_FREELIST_RANDOM & CONFIG_SHUFFLE_PAGE_ALLOCATOR=

>> - Set host THP to always
>> - Set guest THP to madvise
>> - Added the suggested madvise call in page_fault source code.
>> @Alexander please let me know if I missed something.
> This seems about right.
>
>> The current state of my v13:
>> I still have to look into Michal's suggestion of using page-isolation =
API's
>> instead of isolating the page. However, I believe at this moment our o=
bjective
>> is to decide with which approach we can proceed and that's why I decid=
ed to
>> post the numbers by making small required changes in v12 instead of po=
sting a
>> new series.
>>
>>
>> Following are the changes which I have made on top of my v12:
>>
>> page_reporting.h change:
>> -#define PAGE_REPORTING_MIN_ORDER               (MAX_ORDER - 2)
>> -#define PAGE_REPORTING_MAX_PAGES               16
>> +#define PAGE_REPORTING_MIN_ORDER              (MAX_ORDER - 1)
>> +#define PAGE_REPORTING_MAX_PAGES              32
>>
>> page_reporting.c change:
>> @@ -101,8 +101,12 @@ static void scan_zone_bitmap(struct page_reportin=
g_config
>> *phconf,
>>                 /* Process only if the page is still online */
>>                 page =3D pfn_to_online_page((setbit << PAGE_REPORTING_=
MIN_ORDER) +
>>                                           zone->base_pfn);
>> -               if (!page)
>> +               if (!page || !PageBuddy(page)) {
>> +                       clear_bit(setbit, zone->bitmap);
>> +                       atomic_dec(&zone->free_pages);
>>                         continue;
>> +               }
>>
> I suspect the zone->free_pages is going to be expensive for you to deal=

> with. It is a global atomic value and is going to have the cacheline
> bouncing that it is contained in. As a result thinks like setting the
> bitmap with be more expensive as every tome a CPU increments free_pages=
 it
> will likely have to take the cache line containing the bitmap pointer a=
s
> well.

I see I will have to explore this more. I am wondering if there is a way =
to
measure this If its effect is not visible in will-it-scale/page_fault1. I=
f
there is a noticeable amount of degradation, I will have to address this.=


>
>> @Alexander in case you decide to give it a try and find different resu=
lts,
>> please do let me know.
>>
>> [1] https://lore.kernel.org/lkml/20190812131235.27244-1-nitesh@redhat.=
com/
>>
>>
> If I have some free time I will take a look.

That would be great, thanks.

>  However one thing that
> concerns me about this change is that it will limit things much further=
 in
> terms of how much memory can ultimately be freed since you are now only=

> working with the highest order page and that becomes a hard requirement=

> for your design.

I would assume that should be resolved with (pageblock_order - 1).

>
--=20
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

