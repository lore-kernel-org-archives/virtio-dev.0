Return-Path: virtio-dev-return-2943-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D3261CB8078
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Jan 2018 02:24:42 -0800 (PST)
Message-ID: <5A55EA71.6020309@intel.com>
Date: Wed, 10 Jan 2018 18:26:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1515501687-7874-1-git-send-email-wei.w.wang@intel.com> <201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
In-Reply-To: <201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v21 2/5 RESEND] virtio-balloon: VIRTIO_BALLOON_F_SG
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/09/2018 10:42 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> - enable OOM to free inflated pages maintained in the local temporary
>>    list.
> I do want to see it before applying this patch.


Fine, then what do you think of the method I shared in your post here: 
https://patchwork.kernel.org/patch/10140731/

Michael, could we merge patch 3-5 first?


>
> Please carefully check how the xbitmap implementation works, and you will
> find that you are adding a lot of redundant operations with a bug.

This version mainly added some test cases, and it passes the test run 
without any issue. Appreciate it if your comments could be more 
specific, that would make the discussion more effective, for example, I 
deliberately added "xb_find_set(xb1, 2, ULONG_MAX - 3)" for the overflow 
test, not sure if this is the "bug" you referred to, but I'm glad to 
hear your different thought.

I agree that some tests may be repeated in some degree, since we test 
the implementation from different aspects, for example, 
xbitmap_check_bit_range() may have already performed xb_zero() while we 
specifically have another xbitmap_check_zero_bits() which may test 
something that has already been tested when checking bit range. But I 
think testing twice is better than omission.
Also, I left the "Regualr test1: node=NULL" case though the new 
implementation doesn't explicitly use "node" as before, but that 
node=NULL is still a radix tree implementation internally and that case 
looks special to me, so maybe not bad to cover in the test.

You are also welcome to send a patch to remove the redundant one if you 
think that's an issue. Thanks.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

