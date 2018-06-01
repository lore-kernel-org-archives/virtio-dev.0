Return-Path: virtio-dev-return-4232-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0ACCA5818EFB
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Jun 2018 00:18:19 -0700 (PDT)
Message-ID: <5B10F412.8050900@intel.com>
Date: Fri, 01 Jun 2018 15:21:54 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <20180601045824.GH14867@xz-mi>
In-Reply-To: <20180601045824.GH14867@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint reporting
 support
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/01/2018 12:58 PM, Peter Xu wrote:
> On Tue, Apr 24, 2018 at 02:13:43PM +0800, Wei Wang wrote:
>> This is the deivce part implementation to add a new feature,
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
>> receives the guest free page hints from the driver and clears the
>> corresponding bits in the dirty bitmap, so that those free pages are
>> not transferred by the migration thread to the destination.
>>
>> - Test Environment
>>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>>      Guest: 8G RAM, 4 vCPU
>>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>>
>> - Test Results
>>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>>          - Optimization v.s. Legacy = 271ms vs 1769ms --> ~86% reduction
>>      - Guest with Linux Compilation Workload (make bzImage -j4):
>>          - Live Migration Time (average)
>>            Optimization v.s. Legacy = 1265ms v.s. 2634ms --> ~51% reduction
>>          - Linux Compilation Time
>>            Optimization v.s. Legacy = 4min56s v.s. 5min3s
>>            --> no obvious difference
>>
>> - Source Code
>>      - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
>>      - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git
> Hi, Wei,
>
> I have a very high-level question to the series.

Hi Peter,

Thanks for joining the discussion :)

>
> IIUC the core idea for this series is that we can avoid sending some
> of the pages if we know that we don't need to send them.  I think this
> is based on the fact that on the destination side all the pages are by
> default zero after they are malloced.  While before this series, IIUC
> any migration will send every single page to destination, no matter
> whether it's zeroed or not.  So I'm uncertain about whether this will
> affect the received bitmap on the destination side.  Say, before this
> series, the received bitmap will directly cover the whole RAM bitmap
> after migration is finished, now it's won't.  Will there be any side
> effect?  I don't see obvious issue now, but just raise this question
> up.

This feature currently only supports pre-copy (I think the received 
bitmap is something matters to post copy only).
That's why we have
rs->free_page_support = ..&& !migrate_postcopy();

> Meanwhile, this reminds me about a more funny idea: whether we can
> just avoid sending the zero pages directly from QEMU's perspective.
> In other words, can we just do nothing if save_zero_page() detected
> that the page is zero (I guess the is_zero_range() can be fast too,
> but I don't know exactly how fast it is)?  And how that would be
> differed from this page hinting way in either performance and other
> aspects.

I guess you referred to the zero page optimization. I think the major 
overhead comes to the zero page checking - lots of memory accesses, 
which also waste memory bandwidth. Please see the results attached in 
the cover letter. The legacy case already includes the zero page 
optimization.

Best,
Wei




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

