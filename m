Return-Path: virtio-dev-return-2866-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 897F55818043
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Dec 2017 02:32:40 -0800 (PST)
Message-ID: <5A3A3CBC.4030202@intel.com>
Date: Wed, 20 Dec 2017 18:34:36 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com> <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
In-Reply-To: <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v20 0/7] Virtio-balloon Enhancement
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/19/2017 10:05 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> ChangeLog:
>> v19->v20:
>> 1) patch 1: xbitmap
>> 	- add __rcu to "void **slot";
>> 	- remove the exceptional path.
>> 2) patch 3: xbitmap
>> 	- DeveloperNotes: add an item to comment that the current bit range
>> 	  related APIs operating on extremely large ranges (e.g.
>>            [0, ULONG_MAX)) will take too long time. This can be optimized in
>> 	  the future.
>> 	- remove the exceptional path;
>> 	- remove xb_preload_and_set();
>> 	- reimplement xb_clear_bit_range to make its usage close to
>> 	  bitmap_clear;
>> 	- rename xb_find_next_set_bit to xb_find_set, and re-implement it
>> 	  in a style close to find_next_bit;
>> 	- rename xb_find_next_zero_bit to xb_find_clear, and re-implement
>> 	  it in a stytle close to find_next_zero_bit;
>> 	- separate the implementation of xb_find_set and xb_find_clear for
>> 	  the convenience of future updates.
> Removing exceptional path made this patch easier to read.
> But what I meant is
>
>    Can you eliminate exception path and fold all xbitmap patches into one, and
>    post only one xbitmap patch without virtio-balloon changes?
>
> .
>
> I still think we don't need xb_preload()/xb_preload_end().

Why would you think preload is not needed?

The bitmap is allocated via preload "bitmap = 
this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);", this allocated bitmap 
would be used in xb_set_bit().


> I think xb_find_set() has a bug in !node path.

I think we can probably remove the "!node" path for now. It would be 
good to get the fundamental part in first, and leave optimization to 
come as separate patches with corresponding test cases in the future.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

