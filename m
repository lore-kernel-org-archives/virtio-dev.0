Return-Path: virtio-dev-return-6119-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D21E985B47
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 13:20:44 +0000 (UTC)
References: <CAKgT0Udr6nYQFTRzxLbXk41SiJ-pcT_bmN1j1YR4deCwdTOaUQ@mail.gmail.com>
 <20190910144713.GF2063@dhcp22.suse.cz>
 <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910175213.GD4023@dhcp22.suse.cz>
 <1d7de9f9f4074f67c567dbb4cc1497503d739e30.camel@linux.intel.com>
 <20190911113619.GP4023@dhcp22.suse.cz>
 <20190911080804-mutt-send-email-mst@kernel.org>
 <20190911121941.GU4023@dhcp22.suse.cz> <20190911122526.GV4023@dhcp22.suse.cz>
 <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
 <20190911125413.GY4023@dhcp22.suse.cz>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <bfd4ee39-bca5-e1ff-704c-19439cd17d8b@redhat.com>
Date: Wed, 11 Sep 2019 09:19:40 -0400
MIME-Version: 1.0
In-Reply-To: <20190911125413.GY4023@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/11/19 8:54 AM, Michal Hocko wrote:
> On Wed 11-09-19 14:42:41, David Hildenbrand wrote:
>> On 11.09.19 14:25, Michal Hocko wrote:
>>> On Wed 11-09-19 14:19:41, Michal Hocko wrote:
>>>> On Wed 11-09-19 08:08:38, Michael S. Tsirkin wrote:
>>>>> On Wed, Sep 11, 2019 at 01:36:19PM +0200, Michal Hocko wrote:
>>>>>> On Tue 10-09-19 14:23:40, Alexander Duyck wrote:
>>>>>> [...]
>>>>>>> We don't put any limitations on the allocator other then that it =
needs to
>>>>>>> clean up the metadata on allocation, and that it cannot allocate =
a page
>>>>>>> that is in the process of being reported since we pulled it from =
the
>>>>>>> free_list. If the page is a "Reported" page then it decrements th=
e
>>>>>>> reported_pages count for the free_area and makes sure the page do=
esn't
>>>>>>> exist in the "Boundary" array pointer value, if it does it moves =
the
>>>>>>> "Boundary" since it is pulling the page.
>>>>>> This is still a non-trivial limitation on the page allocation from=
 an
>>>>>> external code IMHO. I cannot give any explicit reason why an order=
ing on
>>>>>> the free list might matter (well except for page shuffling which u=
ses it
>>>>>> to make physical memory pattern allocation more random) but the
>>>>>> architecture seems hacky and dubious to be honest. It shoulds like=
 the
>>>>>> whole interface has been developed around a very particular and si=
ngle
>>>>>> purpose optimization.
>>>>>>
>>>>>> I remember that there was an attempt to report free memory that pr=
ovided
>>>>>> a callback mechanism [1], which was much less intrusive to the int=
ernals
>>>>>> of the allocator yet it should provide a similar functionality. Di=
d you
>>>>>> see that approach? How does this compares to it? Or am I completel=
y off
>>>>>> when comparing them?
>>>>>>
>>>>>> [1] mostly likely not the latest version of the patchset
>>>>>> http://lkml.kernel.org/r/1502940416-42944-5-git-send-email-wei.w.w=
ang@intel.com
>>>>> Linus nacked that one. He thinks invoking callbacks with lots of
>>>>> internal mm locks is too fragile.
>>>> I would be really curious how much he would be happy about injecting=

>>>> other restrictions on the allocator like this patch proposes. This i=
s
>>>> more intrusive as it has a higher maintenance cost longterm IMHO.
>>> Btw. I do agree that callbacks with internal mm locks are not great
>>> either. We do have a model for that in mmu_notifiers and it is someth=
ing
>>> I do consider PITA, on the other hand it is mostly sleepable part of =
the
>>> interface which makes it the real pain. The above callback mechanism =
was
>>> explicitly documented with restrictions and that the context is
>>> essentially atomic with no access to particular struct pages and no
>>> expensive operations possible. So in the end I've considered it
>>> acceptably painful. Not that I want to override Linus' nack but if
>>> virtualization usecases really require some form of reporting and no
>>> other way to do that push people to invent even more interesting
>>> approaches then we should simply give them/you something reasonable
>>> and least intrusive to our internals.
>>>
>> The issue with "[PATCH v14 4/5] mm: support reporting free page blocks=
"
>>  is that it cannot really handle the use case we have here if I am not=

>> wrong. While a page is getting processed by the hypervisor (e.g.
>> MADV_DONTNEED), it must not get reused.
> What prevents to use the callback to get a list of pfn ranges to work o=
n
> and then use something like start_isolate_page_range on the collected
> pfn ranges to make sure nobody steals pages from under your feet, do
> your thing and drop the isolated state afterwards.
>

In my series, I am doing something similar.
- Track (MAX_ORDER - 2) free pages in bitmap maintained on a per-zone
=C2=A0 basis.
- Use __isolate_free_page on the pages marked in the bitmap and are
=C2=A0 still free.
- Report chunks of 16 isolated pages to the hypervisor.
- Return them back to the buddy once the request is processed.

> I am saying somethig like because you wouldn't really want a generic
> has_unmovable_pages but rather
>                 if (!page_ref_count(page)) {
>                         if (PageBuddy(page))
>                                 iter +=3D (1 << page_order(page)) - 1;
>                         continue;
>                 }
> subset of it.
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

