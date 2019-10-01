Return-Path: virtio-dev-return-6185-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64ABB985FB4
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Oct 2019 18:41:51 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c1ebaefd-ea60-b0f0-1c45-06ac3c502b5b@redhat.com>
Date: Tue, 1 Oct 2019 20:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

>> I think Michal asked for a performance comparison against Nitesh's
>> approach, to evaluate if keeping the reported state + tracking inside
>> the buddy is really worth it. Do you have any such numbers already? (or
>> did my tired eyes miss them in this cover letter? :/)
>>
> 
> I thought what Michal was asking for was what was the benefit of using the
> boundary pointer. I added a bit up above and to the description for patch
> 3 as on a 32G VM it adds up to about a 18% difference without factoring in
> the page faulting and zeroing logic that occurs when we actually do the
> madvise.

"I would still be happier if the allocator wouldn't really have to
bother about somebody snooping its internal state to do its own thing.
So make sure to describe why and how much this really matters.
[...]
if you gave some rough numbers to quantify how much overhead for
different solutions we are talking about here.
"

Could be that I'm misreading Michals comment, but I'd be interested in
the "how much" as well.

> 
> Do we have a working patch set for Nitesh's code? The last time I tried
> running his patch set I ran into issues with kernel panics. If we have a
> known working/stable patch set I can give it a try.

@Nitesh, is there a working branch?


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

