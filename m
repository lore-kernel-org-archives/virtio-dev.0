Return-Path: virtio-dev-return-4675-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A2F0985B2A
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 01:24:43 +0000 (UTC)
Message-ID: <5B455D50.90902@intel.com>
Date: Wed, 11 Jul 2018 09:28:48 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
In-Reply-To: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/11/2018 01:33 AM, Linus Torvalds wrote:
> NAK.
>
> On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
>> +
>> +       buf_page = list_first_entry_or_null(pages, struct page, lru);
>> +       if (!buf_page)
>> +               return -EINVAL;
>> +       buf = (__le64 *)page_address(buf_page);
> Stop this garbage.
>
> Why the hell would you pass in some crazy "liost of pages" that uses
> that lru list?
>
> That's just insane shit.
>
> Just pass in a an array to fill in. No idiotic games like this with
> odd list entries (what's the locking?) and crazy casting to
>
> So if you want an array of page addresses, pass that in as such. If
> you want to do it in a page, do it with
>
>      u64 *array = page_address(page);
>      int nr = PAGE_SIZE / sizeof(u64);
>
> and now you pass that array in to the thing. None of this completely
> insane crazy crap interfaces.
>
> Plus, I still haven't heard an explanation for why you want so many
> pages in the first place, and why you want anything but MAX_ORDER-1.

Sorry for missing that explanation.
We only get addresses of the "MAX_ORDER-1" blocks into the array. The 
max size of the array that could be allocated by kmalloc is 
KMALLOC_MAX_SIZE (i.e. 4MB on x86). With that max array, we could load 
"4MB / sizeof(u64)" addresses of "MAX_ORDER-1" blocks, that is, 2TB free 
memory at most. We thought about removing that 2TB limitation by passing 
in multiple such max arrays (a list of them).

But 2TB has been enough for our use cases so far, and agree it would be 
better to have a simpler API in the first place. So I plan to go back to 
the previous version of just passing in one simple array 
(https://lkml.org/lkml/2018/6/15/21) if no objections.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

