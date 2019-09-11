Return-Path: virtio-dev-return-6117-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFB6F985B47
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 12:55:57 +0000 (UTC)
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190910124209.GY2063@dhcp22.suse.cz>
 <CAKgT0Udr6nYQFTRzxLbXk41SiJ-pcT_bmN1j1YR4deCwdTOaUQ@mail.gmail.com>
 <20190910144713.GF2063@dhcp22.suse.cz>
 <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910175213.GD4023@dhcp22.suse.cz>
 <1d7de9f9f4074f67c567dbb4cc1497503d739e30.camel@linux.intel.com>
 <20190911113619.GP4023@dhcp22.suse.cz>
 <20190911080804-mutt-send-email-mst@kernel.org>
 <20190911121941.GU4023@dhcp22.suse.cz> <20190911122526.GV4023@dhcp22.suse.cz>
 <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <87e0f863-6a49-c07e-49a7-c8a5bdb745ba@redhat.com>
Date: Wed, 11 Sep 2019 08:55:17 -0400
MIME-Version: 1.0
In-Reply-To: <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/11/19 8:42 AM, David Hildenbrand wrote:
> On 11.09.19 14:25, Michal Hocko wrote:
>> On Wed 11-09-19 14:19:41, Michal Hocko wrote:
>>> On Wed 11-09-19 08:08:38, Michael S. Tsirkin wrote:
>>>> On Wed, Sep 11, 2019 at 01:36:19PM +0200, Michal Hocko wrote:
>>>>> On Tue 10-09-19 14:23:40, Alexander Duyck wrote:
>>>>> [...]
>>>>>> We don't put any limitations on the allocator other then that it n=
eeds to
>>>>>> clean up the metadata on allocation, and that it cannot allocate a=
 page
>>>>>> that is in the process of being reported since we pulled it from t=
he
>>>>>> free_list. If the page is a "Reported" page then it decrements the=

>>>>>> reported_pages count for the free_area and makes sure the page doe=
sn't
>>>>>> exist in the "Boundary" array pointer value, if it does it moves t=
he
>>>>>> "Boundary" since it is pulling the page.
>>>>> This is still a non-trivial limitation on the page allocation from =
an
>>>>> external code IMHO. I cannot give any explicit reason why an orderi=
ng on
>>>>> the free list might matter (well except for page shuffling which us=
es it
>>>>> to make physical memory pattern allocation more random) but the
>>>>> architecture seems hacky and dubious to be honest. It shoulds like =
the
>>>>> whole interface has been developed around a very particular and sin=
gle
>>>>> purpose optimization.
>>>>>
>>>>> I remember that there was an attempt to report free memory that pro=
vided
>>>>> a callback mechanism [1], which was much less intrusive to the inte=
rnals
>>>>> of the allocator yet it should provide a similar functionality. Did=
 you
>>>>> see that approach? How does this compares to it? Or am I completely=
 off
>>>>> when comparing them?
>>>>>
>>>>> [1] mostly likely not the latest version of the patchset
>>>>> http://lkml.kernel.org/r/1502940416-42944-5-git-send-email-wei.w.wa=
ng@intel.com
>>>> Linus nacked that one. He thinks invoking callbacks with lots of
>>>> internal mm locks is too fragile.
>>> I would be really curious how much he would be happy about injecting
>>> other restrictions on the allocator like this patch proposes. This is=

>>> more intrusive as it has a higher maintenance cost longterm IMHO.
>> Btw. I do agree that callbacks with internal mm locks are not great
>> either. We do have a model for that in mmu_notifiers and it is somethi=
ng
>> I do consider PITA, on the other hand it is mostly sleepable part of t=
he
>> interface which makes it the real pain. The above callback mechanism w=
as
>> explicitly documented with restrictions and that the context is
>> essentially atomic with no access to particular struct pages and no
>> expensive operations possible. So in the end I've considered it
>> acceptably painful. Not that I want to override Linus' nack but if
>> virtualization usecases really require some form of reporting and no
>> other way to do that push people to invent even more interesting
>> approaches then we should simply give them/you something reasonable
>> and least intrusive to our internals.
>>
> The issue with "[PATCH v14 4/5] mm: support reporting free page blocks"=

>  is that it cannot really handle the use case we have here if I am not
> wrong. While a page is getting processed by the hypervisor (e.g.
> MADV_DONTNEED), it must not get reused.
>
> "Some page blocks may
> leave the free list after zone->lock is released, so it is the caller's=

> responsibility to either detect or prevent the use of such pages."
>
> If I'm not wrong, this only made sense to speed up migration in the
> hypervisor, where you can deal with false positives differently.

Another difference between the two approaches is the origin from where
the reporting request is getting generated. (If I remember correctly)
In Alexander's series or in my series [1], VM is able to report pages
dynamically without any requirement of host intervention.

[1]=C2=A0https://lkml.org/lkml/2019/8/12/593


--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

