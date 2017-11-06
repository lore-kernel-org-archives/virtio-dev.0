Return-Path: virtio-dev-return-2663-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DF1FF5818FA3
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Nov 2017 00:19:01 -0800 (PST)
Message-ID: <5A001B72.1010204@intel.com>
Date: Mon, 06 Nov 2017 16:21:06 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com>	<201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>	<59FD9FE3.5090409@intel.com> <201711042028.EGB64074.FOLMHtFJVQOOFS@I-love.SAKURA.ne.jp>
In-Reply-To: <201711042028.EGB64074.FOLMHtFJVQOOFS@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/04/2017 07:28 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> On 11/03/2017 07:25 PM, Tetsuo Handa wrote:
>>
>> If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
>> use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
>> on vb->balloon_lock mutex.
>> OK. Since the preload() doesn't need too much memory (< 4K in total),
>> how about GFP_NOWAIT here?
> Maybe GFP_NOWAIT | __GFP_NOWARN ?

Sounds good to me. I also plan to move "xb_set_page()" under mutex_lock, 
that is,

     fill_balloon()
     {
         ...
         mutex_lock(&vb->balloon_lock);

         vb->num_pfns = 0;
         while ((page = balloon_page_pop(&pages))) {
==>        xb_set_page(..,page,..);
                 balloon_page_enqueue(&vb->vb_dev_info, page);
         ...
     }

As explained in the xbitmap patch, we need the lock to avoid concurrent 
access to the bitmap.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

