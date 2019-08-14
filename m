Return-Path: virtio-dev-return-5978-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AA89985D18
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 12:49:42 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <ca362045-9668-18ff-39b0-de91fa72e73c@redhat.com>
 <d39504c9-93bd-b8f7-e119-84baac5a42d4@redhat.com>
 <32f61f87-6205-5001-866c-a84e20fc9d85@redhat.com>
 <CAKgT0UfaaHrEaS2wsbdTuzCdCtSrM4Tx79w=dP8HPEnq+T7rtQ@mail.gmail.com>
 <3409b5cc-59e0-28d2-de5f-aa7cadaf434c@redhat.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <1833c84f-3fdf-759c-aafe-5aba809a6e74@redhat.com>
Date: Wed, 14 Aug 2019 08:49:32 -0400
MIME-Version: 1.0
In-Reply-To: <3409b5cc-59e0-28d2-de5f-aa7cadaf434c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core
 infrastructure
To: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Pankaj Gupta <pagupta@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/14/19 3:07 AM, David Hildenbrand wrote:
> On 14.08.19 01:14, Alexander Duyck wrote:
>> On Tue, Aug 13, 2019 at 3:34 AM David Hildenbrand <david@redhat.com> w=
rote:
>>>>>>> +static int process_free_page(struct page *page,
>>>>>>> +                            struct page_reporting_config *phconf=
, int count)
>>>>>>> +{
>>>>>>> +       int mt, order, ret =3D 0;
>>>>>>> +
>>>>>>> +       mt =3D get_pageblock_migratetype(page);
>>>>>>> +       order =3D page_private(page);
>>>>>>> +       ret =3D __isolate_free_page(page, order);
>>>>>>> +
>>>>> I just started looking into the wonderful world of
>>>>> isolation/compaction/migration.
>>>>>
>>>>> I don't think saving/restoring the migratetype is correct here. AFA=
IK,
>>>>> MOVABLE/UNMOVABLE/RECLAIMABLE is just a hint, doesn't mean that e.g=
=2E,
>>>>> movable pages and up in UNMOVABLE or ordinary kernel allocations on=

>>>>> MOVABLE. So that shouldn't be an issue - I guess.
>>>>>
>>>>> 1. You should never allocate something that is no
>>>>> MOVABLE/UNMOVABLE/RECLAIMABLE. Especially not, if you have ISOLATE =
or
>>>>> CMA here. There should at least be a !is_migrate_isolate_page() che=
ck
>>>>> somewhere
>>>>>
>>>>> 2. set_migratetype_isolate() takes the zone lock, so to avoid racin=
g
>>>>> with isolation code, you have to hold the zone lock. Your code seem=
s to
>>>>> do that, so at least you cannot race against isolation.
>>>>>
>>>>> 3. You could end up temporarily allocating something in the
>>>>> ZONE_MOVABLE. The pages you allocate are, however, not movable. The=
re
>>>>> would have to be a way to make alloc_contig_range()/offlining code
>>>>> properly wait until the pages have been processed. Not sure about t=
he
>>>>> real implications, though - too many details in the code (I wonder =
if
>>>>> Alex' series has a way of dealing with that)
>>>>>
>>>>> When you restore the migratetype, you could suddenly overwrite e.g.=
,
>>>>> ISOLATE, which feels wrong.
>>>>
>>>> I was triggering an occasional CPU stall bug earlier, with saving an=
d restoring
>>>> the migratetype I was able to fix it.
>>>> But I will further look into this to figure out if it is really requ=
ired.
>>>>
>>> You should especially look into handling isolated/cma pages. Maybe th=
at
>>> was the original issue. Alex seems to have added that in his latest
>>> series (skipping isolated/cma pageblocks completely) as well.
>> So as far as skipping isolated pageblocks, I get the reason for
>> skipping isolated, but why would we need to skip CMA? I had made the
>> change I did based on comments you had made earlier. But while working=

>> on some of the changes to address isolation better and looking over
>> several spots in the code it seems like CMA is already being used as
>> an allocation fallback for MIGRATE_MOVABLE. If that is the case
>> wouldn't it make sense to allow pulling pages and reporting them while=

>> they are in the free_list?
> I was assuming that CMA is also to be skipped because "static int
> fallbacks[MIGRATE_TYPES][4]" in mm/page_alloc.c doesn't handle CMA at
> all, meaning we should never fallback to CMA or from CMA to another typ=
e
> - at least when stealing pages from another migratetype. So it smells
> like MIGRATE_CMA is static -> the area is marked once and will never be=

> converted to something else (except MIGRATE_ISOLATE temporarily).
>
> I assume you are talking about gfp_to_alloc_flags()/prepare_alloc_pages=
():


I am also trying to look into this to get more understanding of it.
Another thing which I am looking into right now is the difference between=

get/set_pcppage_migratetype() and ge/set_pageblock_migratetype().
To an extent, I do understand what is the benefit of using
get/set_pcppage_migratetype() by reading the comments. However, I am not =
sure
how it gets along with MIGRATE_CMA.
Hopefully, I will have an understanding of it soon.

> #ifdef CONFIG_CMA
> 	if (gfpflags_to_migratetype(gfp_mask) =3D=3D MIGRATE_MOVABLE)
> 		alloc_flags |=3D ALLOC_CMA;
> #endif
>
> Yeah, this looks like MOVABLE allocations can fallback to CMA
> pageblocks. And from what I read, "CMA may use its own migratetype
> (MIGRATE_CMA) which behaves similarly to ZONE_MOVABLE but can be put in=

> arbitrary places."
>
> So I think you are right, it could be that it is safe to temporarily
> pull out CMA pages (in contrast to isolated pages) - assuming it is fin=
e
> to have temporary unmovable allocations on them (different discussion).=

>
> (I am learning about the details as we discuss :) )
>
> The important part would then be to never allocate from the isolated
> pageblocks and to never overwrite MIGRATE_ISOLATE.


Agreed. I think I should just avoid isolating pages with migratetype
MIGRATE_ISOLATE.
Adding a check with is_migrate_isolate_page() before isolating the page s=
hould
do it.


>
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

