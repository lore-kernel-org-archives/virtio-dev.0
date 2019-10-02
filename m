Return-Path: virtio-dev-return-6197-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7FB8985FDA
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Oct 2019 14:41:36 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <d21e6fce694f286ecaf227697a1ec5555734520b.camel@linux.intel.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <9296994f-38b3-5add-c90e-06b8b6751b9e@redhat.com>
Date: Wed, 2 Oct 2019 10:41:13 -0400
MIME-Version: 1.0
In-Reply-To: <d21e6fce694f286ecaf227697a1ec5555734520b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for
 unused page reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/1/19 4:25 PM, Alexander Duyck wrote:
> On Tue, 2019-10-01 at 15:16 -0400, Nitesh Narayan Lal wrote:
>> On 10/1/19 12:21 PM, Alexander Duyck wrote:
>>> On Tue, 2019-10-01 at 17:35 +0200, David Hildenbrand wrote:
>>>> On 01.10.19 17:29, Alexander Duyck wrote:
> <snip>
>
>>>>> As far as possible regressions I have focused on cases where performing
>>>>> the hinting would be non-optimal, such as cases where the code isn't
>>>>> needed as memory is not over-committed, or the functionality is not in
>>>>> use. I have been using the will-it-scale/page_fault1 test running with 16
>>>>> vcpus and have modified it to use Transparent Huge Pages. With this I see
>>>>> almost no difference with the patches applied and the feature disabled.
>>>>> Likewise I see almost no difference with the feature enabled, but the
>>>>> madvise disabled in the hypervisor due to a device being assigned. With
>>>>> the feature fully enabled in both guest and hypervisor I see a regression
>>>>> between -1.86% and -8.84% versus the baseline. I found that most of the
>>>>> overhead was due to the page faulting/zeroing that comes as a result of
>>>>> the pages having been evicted from the guest.
>>>> I think Michal asked for a performance comparison against Nitesh's
>>>> approach, to evaluate if keeping the reported state + tracking inside
>>>> the buddy is really worth it. Do you have any such numbers already? (or
>>>> did my tired eyes miss them in this cover letter? :/)
>>>>
>>> I thought what Michal was asking for was what was the benefit of using the
>>> boundary pointer. I added a bit up above and to the description for patch
>>> 3 as on a 32G VM it adds up to about a 18% difference without factoring in
>>> the page faulting and zeroing logic that occurs when we actually do the
>>> madvise.
>>>
>>> Do we have a working patch set for Nitesh's code? The last time I tried
>>> running his patch set I ran into issues with kernel panics. If we have a
>>> known working/stable patch set I can give it a try.
>> Did you try the v12 patch-set [1]?
>> I remember that you reported the CPU stall issue, which I fixed in the v12.
>>
>> [1] https://lkml.org/lkml/2019/8/12/593
>>
>>> - Alex
>>>
> I haven't tested it. I will pull the patches and give it a try. It works
> with the same QEMU changes that mine does right? If so we should be able
> to get an apples-to-apples comparison.

Yes.

>
> Also, instead of providing lkml.org links to your patches in the future it
> might be better to provide a link to the lore.kernel.org version of the
> thread. So for example the v12 set would be:
> https://lore.kernel.org/lkml/20190812131235.27244-1-nitesh@redhat.com/

I see, I will keep that in mind. Thanks for pointing this out.

>
> The advantage is you can just look up the message ID in your own inbox to
> figure out the link, and it provides raw access to the email if needed.
>
> Thanks.
>
> - Alex
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
-- 
Thanks
Nitesh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

