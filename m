Return-Path: virtio-dev-return-6112-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB0E3985C72
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 09:51:09 +0000 (UTC)
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190910124209.GY2063@dhcp22.suse.cz>
 <CAKgT0Udr6nYQFTRzxLbXk41SiJ-pcT_bmN1j1YR4deCwdTOaUQ@mail.gmail.com>
 <20190910144713.GF2063@dhcp22.suse.cz>
 <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910161818.GF2797@work-vm>
 <f74117db-225d-92cb-9476-22c0f752659d@redhat.com>
 <20190911051819-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8923b919-af67-367f-9588-7f0c26a16831@redhat.com>
Date: Wed, 11 Sep 2019 11:50:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190911051819-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.09.19 11:23, Michael S. Tsirkin wrote:
> On Tue, Sep 10, 2019 at 06:22:37PM +0200, David Hildenbrand wrote:
>> On 10.09.19 18:18, Dr. David Alan Gilbert wrote:
>>> * Alexander Duyck (alexander.duyck@gmail.com) wrote:
>>>> On Tue, Sep 10, 2019 at 7:47 AM Michal Hocko <mhocko@kernel.org> wrote:
>>>>>
>>>>> On Tue 10-09-19 07:42:43, Alexander Duyck wrote:
>>>>>> On Tue, Sep 10, 2019 at 5:42 AM Michal Hocko <mhocko@kernel.org> wrote:
>>>>>>>
>>>>>>> I wanted to review "mm: Introduce Reported pages" just realize that I
>>>>>>> have no clue on what is going on so returned to the cover and it didn't
>>>>>>> really help much. I am completely unfamiliar with virtio so please bear
>>>>>>> with me.
>>>>>>>
>>>>>>> On Sat 07-09-19 10:25:03, Alexander Duyck wrote:
>>>>>>> [...]
>>>>>>>> This series provides an asynchronous means of reporting to a hypervisor
>>>>>>>> that a guest page is no longer in use and can have the data associated
>>>>>>>> with it dropped. To do this I have implemented functionality that allows
>>>>>>>> for what I am referring to as unused page reporting
>>>>>>>>
>>>>>>>> The functionality for this is fairly simple. When enabled it will allocate
>>>>>>>> statistics to track the number of reported pages in a given free area.
>>>>>>>> When the number of free pages exceeds this value plus a high water value,
>>>>>>>> currently 32, it will begin performing page reporting which consists of
>>>>>>>> pulling pages off of free list and placing them into a scatter list. The
>>>>>>>> scatterlist is then given to the page reporting device and it will perform
>>>>>>>> the required action to make the pages "reported", in the case of
>>>>>>>> virtio-balloon this results in the pages being madvised as MADV_DONTNEED
>>>>>>>> and as such they are forced out of the guest. After this they are placed
>>>>>>>> back on the free list,
>>>>>>>
>>>>>>> And here I am reallly lost because "forced out of the guest" makes me
>>>>>>> feel that those pages are no longer usable by the guest. So how come you
>>>>>>> can add them back to the free list. I suspect understanding this part
>>>>>>> will allow me to understand why we have to mark those pages and prevent
>>>>>>> merging.
>>>>>>
>>>>>> Basically as the paragraph above mentions "forced out of the guest"
>>>>>> really is just the hypervisor calling MADV_DONTNEED on the page in
>>>>>> question. So the behavior is the same as any userspace application
>>>>>> that calls MADV_DONTNEED where the contents are no longer accessible
>>>>>> from userspace and attempting to access them will result in a fault
>>>>>> and the page being populated with a zero fill on-demand page, or a
>>>>>> copy of the file contents if the memory is file backed.
>>>>>
>>>>> As I've said I have no idea about virt so this doesn't really tell me
>>>>> much. Does that mean that if somebody allocates such a page and tries to
>>>>> access it then virt will handle a fault and bring it back?
>>>>
>>>> Actually I am probably describing too much as the MADV_DONTNEED is the
>>>> hypervisor behavior in response to the virtio-balloon notification. A
>>>> more thorough explanation of it can be found by just running "man
>>>> madvise", probably best just to leave it at that since I am probably
>>>> confusing things by describing hypervisor behavior in a kernel patch
>>>> set.
>>>>
>>>> For the most part all the page reporting really does is provide a way
>>>> to incrementally identify unused regions of memory in the buddy
>>>> allocator. That in turn is used by virtio-balloon in a polling thread
>>>> to report to the hypervisor what pages are not in use so that it can
>>>> make a decision on what to do with the pages now that it knows they
>>>> are unused.
>>>>
>>>> All this is providing is just a report and it is optional if the
>>>> hypervisor will act on it or not. If the hypervisor takes some sort of
>>>> action on the page, then the expectation is that the hypervisor will
>>>> use some sort of mechanism such as a page fault to discover when the
>>>> page is used again.
>>>
>>> OK, that's interestingly different (but OK) from some other schemes that
>>> hav ebeen described which *require* the guest to somehow indicate the
>>> page is in use before starting to use the page again.
>>>
>>
>> virtio-balloon also has a mode where the guest would not have to
>> indicate to the host before re-using a page. Only
>> VIRTIO_BALLOON_F_MUST_TELL_HOST enforces this. So it's not completely new.
> 
> VIRTIO_BALLOON_F_MUST_TELL_HOST is a bit different.
> When it's not set, guest still must tell host about
> pages in use, it just can batch these notifications
> sending them possibly after page has been used.
> So even with VIRTIO_BALLOON_F_MUST_TELL_HOST off you don't
> skip the notification.
> 

I don't think so

VIRTIO_BALLOON_F_MUST_TELL_HOST     0 /* Tell before reclaiming pages */

commit bf50e69f63d21091e525185c3ae761412be0ba72
Author: Dave Hansen <dave@linux.vnet.ibm.com>
Date:   Thu Apr 7 10:43:25 2011 -0700

    virtio balloon: kill tell-host-first logic

[...]

    But, if the bit is _not_ set, we are under no obligation to
    reverse the order; we're under no obligation to do _anything_.
    As of now, qemu-kvm defines the bit, but doesn't set it.


Old code simply told the hypervisor afterwards, but only for little
performance gain. It is not strictly necessary.

> From hypervisor point of view, this feature is very much like adding
> page to the balloon and immediately taking it out of the balloon again,
> just doing it in one operation.
> 
> The main difference is the contents of the page, which matters
> with poisoning: in that case hypervisor is expected to hand
> back page with the poisoning content. Not so with regular
> deflate where page contents is undefined.
> 
> Well and also the new interface is optimized for large chunks
> of memory since we'll likely be dealing with such.
> 
>>> Dave
>>
>>
>> -- 
>>
>> Thanks,
>>
>> David / dhildenb


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

