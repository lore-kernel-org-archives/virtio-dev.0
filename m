Return-Path: virtio-dev-return-4596-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 44EF85818061
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Jun 2018 01:35:31 -0700 (PDT)
Message-ID: <5B349EC2.80207@intel.com>
Date: Thu, 28 Jun 2018 16:39:30 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com> <1529037793-35521-2-git-send-email-wei.w.wang@intel.com> <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com> <20180626045118-mutt-send-email-mst@kernel.org> <CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com> <20180627220402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180627220402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v33 1/4] mm: add a function to get free page blocks
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/28/2018 03:07 AM, Michael S. Tsirkin wrote:
> On Wed, Jun 27, 2018 at 09:05:39AM -0700, Linus Torvalds wrote:
>> [ Sorry for slow reply, my travels have made a mess of my inbox ]
>>
>> On Mon, Jun 25, 2018 at 6:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> Linus, do you think it would be ok to have get_from_free_page_list
>>> actually pop entries from the free list and use them as the buffer
>>> to store PAs?
>> Honestly, what I think the best option would be is to get rid of this
>> interface *entirely*, and just have the balloon code do
>>
>>      #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
>> __GFP_THISNODE | __GFP_NOMEMALLOC)
>>
>>      struct page *page =  alloc_pages(GFP_MINFLAGS, MAX_ORDER-1);
>>
>>   which is not a new interface, and simply removes the max-order page
>> from the list if at all possible.
>>
>> The above has the advantage of "just working", and not having any races.
>>
>> Now, because you don't want to necessarily *entirely* deplete the max
>> order, I'd suggest that the *one* new interface you add is just a "how
>> many max-order pages are there" interface. So then you can query
>> (either before or after getting the max-order page) just how many of
>> them there were and whether you want to give that page back.
>>
>> Notice? No need for any page lists or physical addresses. No races. No
>> complex new functions.
>>
>> The physical address you can just get from the "struct page" you got.
>>
>> And if you run out of memory because of getting a page, you get all
>> the usual "hey, we ran out of memory" responses..
>>
>> Wouldn't the above be sufficient?
>>
>>              Linus


Thanks for the elaboration.

> I think so, thanks!
>
> Wei, to put it in balloon terms, I think there's one thing we missed: if
> you do manage to allocate a page, and you don't have a use for it, then
> hey, you can just give it to the host because you know it's free - you
> are going to return it to the free list.
>

I'm not sure if this would be better than Linus' previous suggestion, 
because live migration is expected to be performed without disturbing 
the guest. If we do allocation to get all the free pages at all 
possible, then the guest applications would be seriously affected. For 
example, the network would become very slow as the allocation of sk_buf 
often triggers OOM during live migration. If live migration happens from 
time to time, and users try memory related tools like "free -h" on the 
guest, the reported statistics (e.g. the fee memory becomes very low 
abruptly due to the balloon allocation) would confuse them.

With the previous suggestion, we only get hints of the free pages (i.e. 
just report the address of free pages to host without taking them off 
the list).

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

