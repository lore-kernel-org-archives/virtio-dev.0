Return-Path: virtio-dev-return-6122-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B311E985C72
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 16:03:02 +0000 (UTC)
References: <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910175213.GD4023@dhcp22.suse.cz>
 <1d7de9f9f4074f67c567dbb4cc1497503d739e30.camel@linux.intel.com>
 <20190911113619.GP4023@dhcp22.suse.cz>
 <20190911080804-mutt-send-email-mst@kernel.org>
 <20190911121941.GU4023@dhcp22.suse.cz> <20190911122526.GV4023@dhcp22.suse.cz>
 <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
 <20190911125413.GY4023@dhcp22.suse.cz>
 <736594d6-b9ae-ddb9-2b96-85648728ef33@redhat.com>
 <20190911132002.GA4023@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6b4451e9-7f62-bb84-1604-a4aebc907766@redhat.com>
Date: Wed, 11 Sep 2019 18:02:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190911132002.GA4023@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>> Something slightly similar is being performed by Nitesh's patch set. On
>> every free of a certain granularity, he records it in the bitmap. These
>> bits are "hints of free pages".
>>
>> A thread then walks over the bitmap and tries to allocate the "hints".
>> If the pages were already reused, the bit is silently cleared.
>>
>> Instead of allocating/freeing, we could only try to isolate the
>> pageblock, then test if free. (One of the usual issues to work around is
>> MAX_ORDER-1 crossing pageblocks, that might need special care)
> 
> OK, cool that I have reinvented the wheel ;). Allocation is indeed not
> necessary as long as pages are isolated because nobody will allocate
> them.

It's always good if you come to the same conclusion ;)

>  
>> I think you should have a look at the rough idea of Nitesh's patch set
>> to see if something like that is going into a better direction. The
>> bitmap part is in place to do bulk reporting and avoid duplicate reports.
> 
> Let's see how much time I can find for that in my endless inbox whack a mole.

Can totally understand - it's only a single patch.

>  
>> I think main points we want (and what I am missing from callback idea
>> being discussed) are
>> 1. Do bulk reporting only when a certain threshold is reached
> 
> Is a time based approach too coarse?

Usually that's then another parameter to fine tune, something to avoid
when just reporting continuously. I wouldn't say it's a no go, but at
least I would prefer right now to do it continuously.

> 
>> 2. Report only bigger granularities (especially, avoid THP splits in the
>> hypervisor - >= 2MB proofed to be effective)
> 
> the callback has supported order based scan in some of its iteration.

Missed that. But yeah, the other points are more important :)

> 
>> 3. Avoid reporting what has just been reported.
> 
> Is the overhead of checking a pfn range in a bitmask that much of an
> overhead to really care?

It's all about remembering what has already been reported. Nitesh solved
that via the bitmap. So he does exactly that. If we can optimize the
bitmap out - perfect - but I don't see an easy way to do that :)

> 
>> 4. Continuously report, not the "one time report everything" approach.
> 
> So you mean the allocator reporting this rather than an external code to
> poll right? I do not know, how much this is nice to have than must have?

I guess it is debatable - but I don't consider this one of the
fundamental issues. How to identify what to report and remember what has
already been reported is the main issue. Polling vs. notification is
just the cherry on top - IMHO.

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

