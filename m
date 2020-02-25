Return-Path: virtio-dev-return-6783-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA464985D6A
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Feb 2020 18:49:36 +0000 (UTC)
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-7-david@redhat.com>
 <6ec496580ddcb629d22589a1cba8cd61cbd53206.camel@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <267ea186-aba8-1a93-bd55-ac641f78d07e@redhat.com>
Date: Tue, 25 Feb 2020 19:49:21 +0100
MIME-Version: 1.0
In-Reply-To: <6ec496580ddcb629d22589a1cba8cd61cbd53206.camel@linux.intel.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 06/13] mm: Allow to offline unmovable PageOffline()
 pages via MEM_GOING_OFFLINE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>>  /*
>>   * Scan pfn range [start,end) to find movable/migratable pages (LRU pag=
es,
>> - * non-lru movable pages and hugepages). We scan pfn because it's much
>> - * easier than scanning over linked list. This function returns the pfn
>> - * of the first found movable page if it's found, otherwise 0.
>> + * non-lru movable pages and hugepages).
>> + *
>> + * Returns:
>> + *=090 in case a movable page is found and movable_pfn was updated.
>> + *=09-ENOENT in case no movable page was found.
>> + *=09-EBUSY in case a definetly unmovable page was found.
>>   */
>> -static unsigned long scan_movable_pages(unsigned long start, unsigned l=
ong end)
>> +static int scan_movable_pages(unsigned long start, unsigned long end,
>> +=09=09=09      unsigned long *movable_pfn)
>>  {
>>  =09unsigned long pfn;
>> =20
>> @@ -1247,18 +1251,29 @@ static unsigned long scan_movable_pages(unsigned=
 long start, unsigned long end)
>>  =09=09=09continue;
>>  =09=09page =3D pfn_to_page(pfn);
>>  =09=09if (PageLRU(page))
>> -=09=09=09return pfn;
>> +=09=09=09goto found;
>>  =09=09if (__PageMovable(page))
>> -=09=09=09return pfn;
>> +=09=09=09goto found;
>> +
>> +=09=09/*
>> +=09=09 * Unmovable PageOffline() pages where somebody still holds
>> +=09=09 * a reference count (after MEM_GOING_OFFLINE) can definetly
>> +=09=09 * not be offlined.
>> +=09=09 */
>> +=09=09if (PageOffline(page) && page_count(page))
>> +=09=09=09return -EBUSY;
>=20
> So the comment confused me a bit because technically this function isn't
> about offlining memory, it is about finding movable pages. I had to do a
> bit of digging to find the only consumer is __offline_pages, but if we ar=
e
> going to talk about "offlining" instead of "moving" in this function it
> might make sense to rename it.

Well, it's contained in memory_hotplug.c, and the only user of moving
pages around in there is offlining code :) And it's job is to locate
movable pages, skip over some (temporary? unmovable ones) and (now)
indicate definitely unmovable ones.

Any idea for a better name?
scan_movable_pages_and_stop_on_definitely_unmovable() is not so nice :)


>=20
>> =20
>>  =09=09if (!PageHuge(page))
>>  =09=09=09continue;
>>  =09=09head =3D compound_head(page);
>>  =09=09if (page_huge_active(head))
>> -=09=09=09return pfn;
>> +=09=09=09goto found;
>>  =09=09skip =3D compound_nr(head) - (page - head);
>>  =09=09pfn +=3D skip - 1;
>>  =09}
>> +=09return -ENOENT;
>> +found:
>> +=09*movable_pfn =3D pfn;
>>  =09return 0;
>>  }
>=20
> So I am looking at this function and it seems like your change completely
> changes the behavior. The code before would walk the entire range and if
> at least 1 page was available to move you would return the PFN of that
> page. Now what seems to happen is that you will return -EBUSY as soon as
> you encounter an offline page with a page count. I would think that would
> slow down the offlining process since you have made the Unmovable
> PageOffline() page a head of line blocker that you have to wait to get
> around.

So, the comment says "Unmovable PageOffline() pages where somebody still
holds a reference count (after MEM_GOING_OFFLINE) can definitely not be
offlined". And the doc "-EBUSY in case a definitely unmovable page was
found."

So why would this make offlining slow? Offlining will be aborted,
because offlining is not possible.

Please note that this is the exact old behavior, where isolating the
page range would have failed directly and offlining would have been
aborted early. The old offlining failure in the case in the offlining
path would have been "failure to isolate range".

Also, note that the users of PageOffline() with unmovable pages are very
rare (only balloon drivers for now).

>=20
> Would it perhaps make more sense to add a return value initialized to
> ENOENT, and if you encounter one of these offline pages you change the
> return value to EBUSY, and then if you walk through the entire list
> without finding a movable page you just return the value?

Did you have a look in  which context this function is used, especially
[1] and [2]?

>=20
> Otherwise you might want to add a comment explaining why the function
> should stall instead of skipping over the unmovable section that will
> hopefully become movable later.

So we have "-EBUSY in case a definitely unmovable page was found.". Do
you have a better suggestion?

>=20
>> @@ -1528,7 +1543,8 @@ static int __ref __offline_pages(unsigned long sta=
rt_pfn,
>>  =09}
>> =20
>>  =09do {
>> -=09=09for (pfn =3D start_pfn; pfn;) {
>> +=09=09pfn =3D start_pfn;
>> +=09=09do {
>>  =09=09=09if (signal_pending(current)) {
>>  =09=09=09=09ret =3D -EINTR;
>>  =09=09=09=09reason =3D "signal backoff";
>> @@ -1538,14 +1554,19 @@ static int __ref __offline_pages(unsigned long s=
tart_pfn,
>>  =09=09=09cond_resched();
>>  =09=09=09lru_add_drain_all();
>> =20
>> -=09=09=09pfn =3D scan_movable_pages(pfn, end_pfn);
>> -=09=09=09if (pfn) {
>> +=09=09=09ret =3D scan_movable_pages(pfn, end_pfn, &pfn);
>> +=09=09=09if (!ret) {
>>  =09=09=09=09/*
>>  =09=09=09=09 * TODO: fatal migration failures should bail
>>  =09=09=09=09 * out
>>  =09=09=09=09 */
>>  =09=09=09=09do_migrate_range(pfn, end_pfn);
>>  =09=09=09}

[1] we detect a definite offlining blocker and

>> +=09=09} while (!ret);
>> +
>> +=09=09if (ret !=3D -ENOENT) {
>> +=09=09=09reason =3D "unmovable page";

[2] we abort offlining

>> +=09=09=09goto failed_removal_isolated;
>>  =09=09}
>> =20
>>  =09=09/*
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 5334decc9e06..840c0bbe2d9f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8256,6 +8256,19 @@ bool has_unmovable_pages(struct zone *zone, struc=
t page *page, int count,
>>  =09=09if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
>>  =09=09=09continue;
>> =20
>> +=09=09/*
>> +=09=09 * We treat all PageOffline() pages as movable when offlining
>> +=09=09 * to give drivers a chance to decrement their reference count
>> +=09=09 * in MEM_GOING_OFFLINE in order to signalize that these pages
>=20
> You can probably just use "signal" or "indicate" instead of "signalize".

Makes sense, "indicate" it is!

Thanks!

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

