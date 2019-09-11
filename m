Return-Path: virtio-dev-return-6123-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14488985C72
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 16:09:31 +0000 (UTC)
References: <20190910175213.GD4023@dhcp22.suse.cz>
 <1d7de9f9f4074f67c567dbb4cc1497503d739e30.camel@linux.intel.com>
 <20190911113619.GP4023@dhcp22.suse.cz>
 <20190911080804-mutt-send-email-mst@kernel.org>
 <20190911121941.GU4023@dhcp22.suse.cz> <20190911122526.GV4023@dhcp22.suse.cz>
 <4748a572-57b3-31da-0dde-30138e550c3a@redhat.com>
 <20190911125413.GY4023@dhcp22.suse.cz>
 <736594d6-b9ae-ddb9-2b96-85648728ef33@redhat.com>
 <20190911132002.GA4023@dhcp22.suse.cz> <20190911135100.GC4023@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <abea20a0-463c-68c0-e810-2e341d971b30@redhat.com>
Date: Wed, 11 Sep 2019 18:09:18 +0200
MIME-Version: 1.0
In-Reply-To: <20190911135100.GC4023@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.09.19 15:51, Michal Hocko wrote:
> On Wed 11-09-19 15:20:02, Michal Hocko wrote:
> [...]
>>> 4. Continuously report, not the "one time report everything" approach.
>>
>> So you mean the allocator reporting this rather than an external code to
>> poll right? I do not know, how much this is nice to have than must have?
> 
> Another idea that I haven't really thought through so it might turned
> out to be completely bogus but let's try anyway. Your "report everything"
> just made me look and realize that free_pages_prepare already performs
> stuff that actually does something similar yet unrelated.
> 
> We do report to special page poisoning, zeroying or
> CONFIG_DEBUG_PAGEALLOC to unmap the address from the kernel address
> space. This sounds like something fitting your model no?
> 

AFAIKS, the poisoning/unmapping is done whenever a page is freed. I
don't quite see yet how that would help to remember if a page was
already reported. After reporting the page we would have to switch some
state (Nitesh: bitmap bit, Alexander: page flag) to identify that.

Of course, we could map the page and treat that as "the state" when we
reported it, but I am not sure that's such a good idea :)

As always, I might be very wrong ...

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

