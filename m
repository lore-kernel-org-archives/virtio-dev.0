Return-Path: virtio-dev-return-6785-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15F4A985DBB
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Feb 2020 22:19:41 +0000 (UTC)
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-7-david@redhat.com>
 <6ec496580ddcb629d22589a1cba8cd61cbd53206.camel@linux.intel.com>
 <267ea186-aba8-1a93-bd55-ac641f78d07e@redhat.com>
 <3d719897039273a2bb8d0fe7d12563498ebd2897.camel@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e0892179-b14c-84c3-1284-fc789f16e1c7@redhat.com>
Date: Tue, 25 Feb 2020 23:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <3d719897039273a2bb8d0fe7d12563498ebd2897.camel@linux.intel.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 06/13] mm: Allow to offline unmovable PageOffline()
 pages via MEM_GOING_OFFLINE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 25.02.20 22:46, Alexander Duyck wrote:
> On Tue, 2020-02-25 at 19:49 +0100, David Hildenbrand wrote:
>>>>  /*
>>>>   * Scan pfn range [start,end) to find movable/migratable pages (LRU p=
ages,
>>>> - * non-lru movable pages and hugepages). We scan pfn because it's muc=
h
>>>> - * easier than scanning over linked list. This function returns the p=
fn
>>>> - * of the first found movable page if it's found, otherwise 0.
>>>> + * non-lru movable pages and hugepages).
>>>> + *
>>>> + * Returns:
>>>> + *=090 in case a movable page is found and movable_pfn was updated.
>>>> + *=09-ENOENT in case no movable page was found.
>>>> + *=09-EBUSY in case a definetly unmovable page was found.
>>>>   */
>>>> -static unsigned long scan_movable_pages(unsigned long start, unsigned=
 long end)
>>>> +static int scan_movable_pages(unsigned long start, unsigned long end,
>>>> +=09=09=09      unsigned long *movable_pfn)
>>>>  {
>>>>  =09unsigned long pfn;
>>>> =20
>>>> @@ -1247,18 +1251,29 @@ static unsigned long scan_movable_pages(unsign=
ed long start, unsigned long end)
>>>>  =09=09=09continue;
>>>>  =09=09page =3D pfn_to_page(pfn);
>>>>  =09=09if (PageLRU(page))
>>>> -=09=09=09return pfn;
>>>> +=09=09=09goto found;
>>>>  =09=09if (__PageMovable(page))
>>>> -=09=09=09return pfn;
>>>> +=09=09=09goto found;
>>>> +
>>>> +=09=09/*
>>>> +=09=09 * Unmovable PageOffline() pages where somebody still holds
>>>> +=09=09 * a reference count (after MEM_GOING_OFFLINE) can definetly
>>>> +=09=09 * not be offlined.
>>>> +=09=09 */
>>>> +=09=09if (PageOffline(page) && page_count(page))
>>>> +=09=09=09return -EBUSY;
>>>
>>> So the comment confused me a bit because technically this function isn'=
t
>>> about offlining memory, it is about finding movable pages. I had to do =
a
>>> bit of digging to find the only consumer is __offline_pages, but if we =
are
>>> going to talk about "offlining" instead of "moving" in this function it
>>> might make sense to rename it.
>>
>> Well, it's contained in memory_hotplug.c, and the only user of moving
>> pages around in there is offlining code :) And it's job is to locate
>> movable pages, skip over some (temporary? unmovable ones) and (now)
>> indicate definitely unmovable ones.
>>
>> Any idea for a better name?
>> scan_movable_pages_and_stop_on_definitely_unmovable() is not so nice :)
>=20
> I dunno. What I was getting at is that the wording here would make it
> clearer if you simply stated that these pages "can definately not be
> moved". Saying you cannot offline a page that is PageOffline seems kind o=
f
> redundant, then again calling it an Unmovable and then saying it cannot b=
e
> moves is also redundant I suppose. In the end you don't move them, but

So, in summary, there are
- PageOffline() pages that are movable (balloon compaction).
- PageOffline() pages that cannot be moved and cannot be offlined (e.g.,
  no balloon compaction enabled, XEN, HyperV, ...) . page_count(page) >=3D
  0
- PageOffline() pages that cannot be moved, but can be offlined.
  page_count(page) =3D=3D 0.


> they can be switched to offline if the page count hits 0. When that
> happens you simply end up skipping over them in the code for
> __test_page_isolated_in_pageblock and __offline_isolated_pages.

Yes. The thing with the wording is that pages with (PageOffline(page) &&
!page_count(page)) can also not really be moved, but they can be skipped
when offlining. If we call that "moving them to /dev/null", then yes,
they can be moved to some degree :)

I can certainly do here e.g.,

/*
 * PageOffline() pages that are not marked __PageMovable() and have a
 * reference count > 0 (after MEM_GOING_OFFLINE) are definitely
 * unmovable. If their reference count would be 0, they could be skipped
 * when offlining memory sections.
 */

And maybe I'll add to the function doc, that unmovable pages that are
skipped in this function can include pages that can be skipped when
offlining (moving them to nirvana).

Other suggestions?

[...]

>>
>> [1] we detect a definite offlining blocker and
>>
>>>> +=09=09} while (!ret);
>>>> +
>>>> +=09=09if (ret !=3D -ENOENT) {
>>>> +=09=09=09reason =3D "unmovable page";
>>
>> [2] we abort offlining
>>
>>>> +=09=09=09goto failed_removal_isolated;
>>>>  =09=09}
>>>> =20
>>>>  =09=09/*
>=20
> Yeah, this is the piece I misread.  I knew the loop this was in previousl=
y
> was looping when returning -ENOENT so for some reason I had it in my head
> that you were still looping on -EBUSY.

Ah okay, I see. Yeah, that wouldn't make sense for the use case I have :)

>=20
> So the one question I would have is if at this point are we guaranteed
> that the balloon drivers have already taken care of the page count for al=
l
> the pages they set to PageOffline? Based on the patch description I was
> thinking that this was going to be looping for a while waiting for the
> driver to clear the pages and then walking through them at the end of the
> loop via check_pages_isolated_cb.

So, e.g., the patch description states

"Let's allow to do that by allowing to isolate any PageOffline() page
when offlining. This way, we can reach the memory hotplug notifier
MEM_GOING_OFFLINE, where the driver can signal that he is fine with
offlining this page by dropping its reference count."

Any balloon driver that does not allow offlining (e.g., XEN, HyperV,
virtio-balloon), will always have a refcount of (at least) 1. Drivers
that want to make use of that (esp. virtio-mem, but eventually also
HyperV), will drop their refcount via the MEM_GOING_OFFLINE call.

So yes, at this point, all applicable users were notified via
MEM_GOING_OFFLINE and had their chance to decrement the refcount. If
they didn't, offlining will be aborted.

Thanks again!

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

