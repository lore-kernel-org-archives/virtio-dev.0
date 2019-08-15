Return-Path: virtio-dev-return-5985-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27510985B23
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Aug 2019 19:23:08 +0000 (UTC)
From: Nitesh Narayan Lal <nitesh@redhat.com>
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <6d5b57ca-41ff-5c54-ab20-2b1631a6ce29@redhat.com>
 <CAKgT0UfavuUT4ZvfxVdm3h25qc86ksxPO=GFpFkf8zbGAjHPvg@mail.gmail.com>
 <09c6fbef-fa53-3a25-d3d6-460b9b6b2020@redhat.com>
Message-ID: <6241ef40-9403-1cb0-4e91-a1b86fcf1388@redhat.com>
Date: Thu, 15 Aug 2019 15:22:54 -0400
MIME-Version: 1.0
In-Reply-To: <09c6fbef-fa53-3a25-d3d6-460b9b6b2020@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Pankaj Gupta <pagupta@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/15/19 9:15 AM, Nitesh Narayan Lal wrote:
> On 8/14/19 12:11 PM, Alexander Duyck wrote:
>> On Wed, Aug 14, 2019 at 8:49 AM Nitesh Narayan Lal <nitesh@redhat.com>=
 wrote:
>>> On 8/12/19 2:47 PM, Alexander Duyck wrote:
>>>> On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.co=
m> wrote:
>>>>> This patch introduces the core infrastructure for free page reporti=
ng in
>>>>> virtual environments. It enables the kernel to track the free pages=
 which
>>>>> can be reported to its hypervisor so that the hypervisor could
>>>>> free and reuse that memory as per its requirement.
>>>>>
>>>>> While the pages are getting processed in the hypervisor (e.g.,
>>>>> via MADV_DONTNEED), the guest must not use them, otherwise, data lo=
ss
>>>>> would be possible. To avoid such a situation, these pages are
>>>>> temporarily removed from the buddy. The amount of pages removed
>>>>> temporarily from the buddy is governed by the backend(virtio-balloo=
n
>>>>> in our case).
>>>>>
>>>>> To efficiently identify free pages that can to be reported to the
>>>>> hypervisor, bitmaps in a coarse granularity are used. Only fairly b=
ig
>>>>> chunks are reported to the hypervisor - especially, to not break up=
 THP
>>>>> in the hypervisor - "MAX_ORDER - 2" on x86, and to save space. The =
bits
>>>>> in the bitmap are an indication whether a page *might* be free, not=
 a
>>>>> guarantee. A new hook after buddy merging sets the bits.
>>>>>
>>>>> Bitmaps are stored per zone, protected by the zone lock. A workqueu=
e
>>>>> asynchronously processes the bitmaps, trying to isolate and report =
pages
>>>>> that are still free. The backend (virtio-balloon) is responsible fo=
r
>>>>> reporting these batched pages to the host synchronously. Once repor=
ting/
>>>>> freeing is complete, isolated pages are returned back to the buddy.=

>>>>>
>>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>> [...]
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * __page_reporting_enqueue - tracks the freed page in the respect=
ive zone's
>>>>> + * bitmap and enqueues a new page reporting job to the workqueue i=
f possible.
>>>>> + */
>>>>> +void __page_reporting_enqueue(struct page *page)
>>>>> +{
>>>>> +       struct page_reporting_config *phconf;
>>>>> +       struct zone *zone;
>>>>> +
>>>>> +       rcu_read_lock();
>>>>> +       /*
>>>>> +        * We should not process this page if either page reporting=
 is not
>>>>> +        * yet completely enabled or it has been disabled by the ba=
ckend.
>>>>> +        */
>>>>> +       phconf =3D rcu_dereference(page_reporting_conf);
>>>>> +       if (!phconf)
>>>>> +               return;
>>>>> +
>>>>> +       zone =3D page_zone(page);
>>>>> +       bitmap_set_bit(page, zone);
>>>>> +
>>>>> +       /*
>>>>> +        * We should not enqueue a job if a previously enqueued rep=
orting work
>>>>> +        * is in progress or we don't have enough free pages in the=
 zone.
>>>>> +        */
>>>>> +       if (atomic_read(&zone->free_pages) >=3D phconf->max_pages &=
&
>>>>> +           !atomic_cmpxchg(&phconf->refcnt, 0, 1))
>>>> This doesn't make any sense to me. Why are you only incrementing the=

>>>> refcount if it is zero? Combining this with the assignment above, th=
is
>>>> isn't really a refcnt. It is just an oversized bitflag.
>>> The intent for having an extra variable was to ensure that at a time =
only one
>>> reporting job is enqueued. I do agree that for that purpose I really =
don't need
>>> a reference counter and I should have used something like bool
>>> 'page_hinting_active'. But with bool, I think there could be a possib=
le chance
>>> of race. Maybe I should rename this variable and keep it as atomic.
>>> Any thoughts?
>> You could just use a bitflag to achieve what you are doing here. That
>> is the primary use case for many of the test_and_set_bit type
>> operations. However one issue with doing it as a bitflag is that you
>> have no way of telling that you took care of all requesters.
> I think you are right, I might end up missing on certain reporting
> opportunities in some special cases. Specifically when the pages which =
are
> part of this new reporting request belongs to a section of the bitmap w=
hich
> has already been scanned. Although, I have failed to reproduce this kin=
d of
> situation in an actual setup.
>
>>  That is
>> where having an actual reference count comes in handy as you know
>> exactly how many zones are requesting to be reported on.
>
> True.
>
>>>> Also I am pretty sure this results in the opportunity to miss pages
>>>> because there is nothing to prevent you from possibly missing a ton =
of
>>>> pages you could hint on if a large number of pages are pushed out al=
l
>>>> at once and then the system goes idle in terms of memory allocation
>>>> and freeing.
>>> I was looking at how you are enqueuing/processing reporting jobs for =
each zone.
>>> I am wondering if I should also consider something on similar lines a=
s having
>>> that I might be able to address the concern which you have raised abo=
ve. But it
>>> would also mean that I have to add an additional flag in the zone_fla=
gs. :)
>> You could do it either in the zone or outside the zone as yet another
>> bitmap. I decided to put the flags inside the zone because there was a=

>> number of free bits there and it should be faster since we were
>> already using the zone structure.
> There are two possibilities which could happen while I am reporting:
> 1. Another request might come in for a different zone.
> 2. Another request could come in for the same zone and the pages belong=
 to a
> =C2=A0=C2=A0=C2=A0 section of the bitmap which has already been scanned=
=2E
>
> Having a per zone flag to indicate reporting status will solve the firs=
t
> issue and to an extent the second as well. Having refcnt will possibly =
solve
> both of them. What I am wondering about is that in my case I could easi=
ly
> impact the performance negatively by performing more bitmap scanning.
>
>

I realized that it may not be possible for me to directly adopt either re=
fcnt
or zone flags just because of the way I have page reporting setup right n=
ow.

For now, I will just replace the refcnt with a bitflag as that should wor=
k
for most of the cases.=C2=A0 Nevertheless, I will also keep looking for a=
 better way.

--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

