Return-Path: virtio-dev-return-6027-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E9C6985D36
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Aug 2019 15:15:44 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <df82bc99-a212-4f5c-dc2e-28665060acb2@redhat.com>
Date: Fri, 30 Aug 2019 11:15:11 -0400
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/19 2:47 PM, Alexander Duyck wrote:
> On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.com> =
wrote:
>> This patch introduces the core infrastructure for free page reporting =
in
>> virtual environments. It enables the kernel to track the free pages wh=
ich
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
>> chunks are reported to the hypervisor - especially, to not break up TH=
P
>> in the hypervisor - "MAX_ORDER - 2" on x86, and to save space. The bit=
s
>> in the bitmap are an indication whether a page *might* be free, not a
>> guarantee. A new hook after buddy merging sets the bits.
>>
>> Bitmaps are stored per zone, protected by the zone lock. A workqueue
>> asynchronously processes the bitmaps, trying to isolate and report pag=
es
>> that are still free. The backend (virtio-balloon) is responsible for
>> reporting these batched pages to the host synchronously. Once reportin=
g/
>> freeing is complete, isolated pages are returned back to the buddy.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
[...]
>> +static void scan_zone_bitmap(struct page_reporting_config *phconf,
>> +                            struct zone *zone)
>> +{
>> +       unsigned long setbit;
>> +       struct page *page;
>> +       int count =3D 0;
>> +
>> +       sg_init_table(phconf->sg, phconf->max_pages);
>> +
>> +       for_each_set_bit(setbit, zone->bitmap, zone->nbits) {
>> +               /* Process only if the page is still online */
>> +               page =3D pfn_to_online_page((setbit << PAGE_REPORTING_=
MIN_ORDER) +
>> +                                         zone->base_pfn);
>> +               if (!page)
>> +                       continue;
>> +
> Shouldn't you be clearing the bit and dropping the reference to
> free_pages before you move on to the next bit? Otherwise you are going
> to be stuck with those aren't you?
>
>> +               spin_lock(&zone->lock);
>> +
>> +               /* Ensure page is still free and can be processed */
>> +               if (PageBuddy(page) && page_private(page) >=3D
>> +                   PAGE_REPORTING_MIN_ORDER)
>> +                       count =3D process_free_page(page, phconf, coun=
t);
>> +
>> +               spin_unlock(&zone->lock);
> So I kind of wonder just how much overhead you are taking for bouncing
> the zone lock once per page here. Especially since it can result in
> you not actually making any progress since the page may have already
> been reallocated.
>

I am wondering if there is a way to measure this overhead?
After thinking about this, I do understand your point.
One possible way which I can think of to address this is by having a
page_reporting_dequeue() hook somewhere in the allocation path.
=C2=A0=C2=A0=C2=A0=C2=A0
For some reason, I am not seeing this work as I would have expected
but I don't have solid reasoning to share yet. It could be simply
because I am putting my hook at the wrong place. I will continue
investigating this.

In any case, I may be over complicating things here, so please let me
if there is a better way to do this.

If this overhead is not significant we can probably live with it.

--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

