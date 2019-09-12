Return-Path: virtio-dev-return-6125-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 983B0985D34
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Sep 2019 12:00:52 +0000 (UTC)
References: <20190911113619.GP4023@dhcp22.suse.cz>
 <20190911080804-mutt-send-email-mst@kernel.org>
 <20190911121941.GU4023@dhcp22.suse.cz> <20190911122526.GV4023@dhcp22.suse.cz>
 <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
 <20190911125413.GY4023@dhcp22.suse.cz>
 <736594d6-b9ae-ddb9-2b96-85648728ef33@redhat.com>
 <20190911132002.GA4023@dhcp22.suse.cz> <20190911135100.GC4023@dhcp22.suse.cz>
 <abea20a0-463c-68c0-e810-2e341d971b30@redhat.com>
 <20190912071633.GL4023@dhcp22.suse.cz>
 <ef460202-cebd-c6d2-19f3-e8a82a3d3cbd@redhat.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <880cb776-a5c0-026c-6c50-3d8d3c2bb2df@redhat.com>
Date: Thu, 12 Sep 2019 08:00:45 -0400
MIME-Version: 1.0
In-Reply-To: <ef460202-cebd-c6d2-19f3-e8a82a3d3cbd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/12/19 3:47 AM, David Hildenbrand wrote:
> On 12.09.19 09:16, Michal Hocko wrote:
>> On Wed 11-09-19 18:09:18, David Hildenbrand wrote:
>>> On 11.09.19 15:51, Michal Hocko wrote:
>>>> On Wed 11-09-19 15:20:02, Michal Hocko wrote:
>>>> [...]
>>>>>> 4. Continuously report, not the "one time report everything" appro=
ach.
>>>>> So you mean the allocator reporting this rather than an external co=
de to
>>>>> poll right? I do not know, how much this is nice to have than must =
have?
>>>> Another idea that I haven't really thought through so it might turne=
d
>>>> out to be completely bogus but let's try anyway. Your "report everyt=
hing"
>>>> just made me look and realize that free_pages_prepare already perfor=
ms
>>>> stuff that actually does something similar yet unrelated.
>>>>
>>>> We do report to special page poisoning, zeroying or
>>>> CONFIG_DEBUG_PAGEALLOC to unmap the address from the kernel address
>>>> space. This sounds like something fitting your model no?
>>>>
>>> AFAIKS, the poisoning/unmapping is done whenever a page is freed. I
>>> don't quite see yet how that would help to remember if a page was
>>> already reported.
>> Do you still have to differ that state when each page is reported?
> Ah, very good point. I can see that the reason for this was not
> discussed in this thread so far. (Alexander, Nitesh, please correct me
> if I am wrong). It's buried in the long history of free page
> hinting/reporting.
>
> Some early patch sets tried to report during every free synchronously.
> Free a page, report them to the hypervisor. This resulted in some issue=
s
> (especially, locking-related and the virtio + the hypervisor being
> involved, resulting in unpredictable delays, quite some overhead ...).
> It was no good.

+1
If I remember correctly then Alexander had posted a patch-set
prior to this series where he was reporting every page of a fixed
order from __free_one_page(). But as you said it will be costly as
it will involve one hypercall per page of reporting_order.

>
> One design decision then was to not report single pages, but a bunch of=

> pages at once. This made it necessary to "remember" the pages to be
> reported and to temporarily block them from getting allocated while
> reporting.

Until my v7 posting [1] I was doing this. We did not proceed with
this as blocking allocation was not recommended for reporting.

>
> Nitesh implemented (at least) two "capture PFNs of free pages in an
> array when freeing" approaches. One being synchronous from the freeing
> CPU once the list was full (having similar issues as plain synchronous
> reporting) and one being asynchronous by a separate thread (which solve=
d
> many locking issues).

One issue with asynchronous + array approach was that it could have lead
to false OOMs due to several pages being isolated at the same time.

>
> Turned out the a simple array can quickly lead to us having to drop
> "reports" to the hypervisor because the array is full and the reporting=

> thread was not able to keep up. Not good as well. Especially, if some
> process frees a lot of memory this can happen quickly and Nitesh wa
> sable to trigger this scenario frequently.

+1

>
> Finally, Nitesh decided to use the bitmap instead to keep track of page=
s
> to report. I'd like to note that this approach could still be combined
> with an "array of potentially free PFNs". Only when the array/circular
> buffer runs out of entries ("reporting thread cannot keep up"), we woul=
d
> have to go back to scanning the bitmap.

I will have to think about it.

> That was also the point where Alexander decided to look into integratin=
g
> tracking/handling reported/unreported pages directly in the buddy.
>
>>> After reporting the page we would have to switch some
>>> state (Nitesh: bitmap bit, Alexander: page flag) to identify that.
>> Yes, you can either store the state somewhere.
>>
>>> Of course, we could map the page and treat that as "the state" when w=
e
>>> reported it, but I am not sure that's such a good idea :)
>>>
>>> As always, I might be very wrong ...
>> I still do not fully understand the usecase so I might be equally wron=
g.
>> My thinking is along these lines. Why should you scan free pages when
>> you can effectively capture each freed page? If you go one step furthe=
r
>> then post_alloc_hook would be the counterpart to know that your page h=
as
>> been allocated.
> I'd like to note that Nitesh's patch set contains the following hunk,
> which is roughly what you were thinking :)
>
>
> -static inline void __free_one_page(struct page *page,
> +inline void __free_one_page(struct page *page,
>  		unsigned long pfn,
>  		struct zone *zone, unsigned int order,
> -		int migratetype)
> +		int migratetype, bool hint)
>  {
>  	unsigned long combined_pfn;
>  	unsigned long uninitialized_var(buddy_pfn);
> @@ -980,7 +981,8 @@ static inline void __free_one_page(struct page *pag=
e,
>  				migratetype);
>  	else
>  		add_to_free_area(page, &zone->free_area[order], migratetype);
> -
> +	if (hint)
> +		page_hinting_enqueue(page, order);
>  }
>
>
> (ignore the hint parameter, when he would switch to a isolate vs.
> alloc/free, that can go away and all we left is the enqueue part)

Precisely.
Although, there would be a scenario where the allocation will
take place for a page whose order would be < REPORTING_ORDER.
In that case, if I decide to ignore all the remaining pages and clear
the previously head free page bit, I might end
up losing the reporting opportunity.

But I can certainly look into this.

>
>
> Inside that callback we can remember the pages any way we want. Right
> now in a bitmap. Maybe later in a array + bitmap (as discussed above).
> Another idea I had was to simply go over all pages and report them when=

> running into this "array full" condition. But I am not yet sure about
> the performance implications on rather large machines. So the bitmap
> idea might have some other limitations but seems to do its job.

That's correct, I was actually trying to come up with a basic framework.
Which is acceptable in terms of benefits and performance and that can fit=
 into
most of the use-cases (if not all).
After which my plan was to further optimize it.

>
> Hoe that makes things clearer and am not missing something.

Thanks for explaining.

>
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

