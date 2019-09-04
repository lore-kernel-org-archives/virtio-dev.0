Return-Path: virtio-dev-return-6032-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11681985E7A
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Sep 2019 08:40:46 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <df82bc99-a212-4f5c-dc2e-28665060acb2@redhat.com>
 <CAKgT0Ueqok+bxANVtB1DdYorcEHN7+Grzb8MAxTzSk8uS81pRA@mail.gmail.com>
 <9a2ffed8-a8a7-a0a6-ec2d-4234b4e11e3e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b298da84-8e73-fcd4-fa93-43537101e30c@redhat.com>
Date: Wed, 4 Sep 2019 10:40:27 +0200
MIME-Version: 1.0
In-Reply-To: <9a2ffed8-a8a7-a0a6-ec2d-4234b4e11e3e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core
 infrastructure
To: Nitesh Narayan Lal <nitesh@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Pankaj Gupta <pagupta@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

>>> For some reason, I am not seeing this work as I would have expected
>>> but I don't have solid reasoning to share yet. It could be simply
>>> because I am putting my hook at the wrong place. I will continue
>>> investigating this.
>>>
>>> In any case, I may be over complicating things here, so please let me
>>> if there is a better way to do this.
>> I have already been demonstrating the "better way" I think there is to
>> do this. I will push v7 of it early next week unless there is some
>> other feedback. By putting the bit in the page and controlling what
>> comes into and out of the lists it makes most of this quite a bit
>> easier. The only limitation is you have to modify where things get
>> placed in the lists so you don't create a "vapor lock" that would
>> stall the feed of pages into the reporting engine.
>>
>>> If this overhead is not significant we can probably live with it.
>> You have bigger issues you still have to overcome as I recall. Didn't
>> you still need to sort out hotplu
> 
> For memory hotplug, my impression is that it should
> not be a blocker for taking the first step (in case we do decide to
> go ahead with this approach). Another reason why I am considering
> this as future work is that memory hot(un)plug is still under
> development and requires fixing. (Specifically, issue such as zone
> shrinking which will directly impact the bitmap approach is still
> under discussion).

Memory hotplug is way more reliable than memory unplug - however, but
both are used in production. E.g. the zone shrinking you mention is
something that is not "optimal", but works in most scenarios. So both
features are rather in a "production/fixing" stage than a pure
"development" stage.

However, I do agree that memory hot(un)plug is not something
high-priority for free page hinting in the first shot. If it works out
of the box (Alexander's approach) - great - if not it is just one
additional scenario where free page hinting might not be optimal yet
(like vfio where we can't use it completely right now). After all, most
virtual environment (under KVM) I am aware of don't use DIMM-base memory
hot(un)plug at all.

The important part is that it will not break when memory is added/removed.

> 
>> g and a sparse map with a wide span
>> in a zone? Without those resolved the bitmap approach is still a no-go
>> regardless of performance.
> 
> For sparsity, the memory wastage should not be significant as I
> am tracking pages on the granularity of (MAX_ORDER - 2) and maintaining
> the bitmaps on a per-zone basis (which was not the case earlier).

To handle sparsity one would have to have separate bitmaps for each
section. Roughly 64 bit per 128MB section. Scanning the scattered bitmap
would get more expensive. Of course, one could have a hierarchical
bitmap to speed up the search etc.

But again, I think we should have a look how much of an issue sparse
zones/nodes actually are in virtual machines (KVM). The setups I am
aware of minimize sparsity (e.g., QEMU will place DIMMs consecutively in
memory, only aligning to e.g, 128MB on x86 if required). Usually all
memory in VMs is onlined to the NORMAL zone (except special cases of
course). The only "issue" would be if you start mixing DIMMs of
different nodes when hotplugging memory. The overhead for 1bit per 2MB
could be almost neglectable in most setups.

But I do agree that for the bitmap-based approach there might be more
scenarios where you'd rather not want to use free page hinting and
instead disable it.

> 
> However, if you do consider this as a block I will think about it and try to fix it.
> In the worst case, if I don't find a solution I will add this as a known limitation
> for this approach in my cover.
> 
>> - Alex


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

