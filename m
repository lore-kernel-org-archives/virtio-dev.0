Return-Path: virtio-dev-return-3073-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B5DB55819139
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 18:09:13 -0800 (PST)
Message-ID: <5A6A8E56.90408@intel.com>
Date: Fri, 26 Jan 2018 10:11:34 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516873107-34950-1-git-send-email-wei.w.wang@intel.com> <20180125144124.7e9f6e2156b1b940b07aecfc@linux-foundation.org>
In-Reply-To: <20180125144124.7e9f6e2156b1b940b07aecfc@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v25 1/2 RESEND] mm: support reporting free page blocks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/26/2018 06:41 AM, Andrew Morton wrote:
> On Thu, 25 Jan 2018 17:38:27 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
>
>> This patch adds support to walk through the free page blocks in the
>> system and report them via a callback function. Some page blocks may
>> leave the free list after zone->lock is released, so it is the caller's
>> responsibility to either detect or prevent the use of such pages.
>>
>> One use example of this patch is to accelerate live migration by skipping
>> the transfer of free pages reported from the guest. A popular method used
>> by the hypervisor to track which part of memory is written during live
>> migration is to write-protect all the guest memory. So, those pages that
>> are reported as free pages but are written after the report function
>> returns will be captured by the hypervisor, and they will be added to the
>> next round of memory transfer.
> It would be useful if we had some quantitative testing results, so we
> can see the real-world benefits from this change?
>

Sure. Thanks for the reminder, I think I'll also attach this to the 
cover letter:

Without this feature, locally live migrating an 8G idle guest takes 
~2286 ms. With this featrue, it takes ~260 ms, which reduces the 
migration time to ~11%.

Idle guest means a guest which doesn't run any specific workloads after 
boots. The improvement depends on how much free memory the guest has, 
idle guest is a good case to show the improvement. From the optimization 
point of view, having something is better than nothing, IMHO. If the 
guest has less free memory, the improvement will be less, but still 
better than no improvement.

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

