Return-Path: virtio-dev-return-2657-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BA0B85818CA4
	for <virtio-dev@lists.oasis-open.org>; Sat,  4 Nov 2017 04:07:14 -0700 (PDT)
Message-ID: <59FD9FE3.5090409@intel.com>
Date: Sat, 04 Nov 2017 19:09:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com> <201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>
In-Reply-To: <201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/03/2017 07:25 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> @@ -164,6 +284,8 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>>   			break;
>>   		}
>>   
>> +		if (use_sg && xb_set_page(vb, page, &pfn_min, &pfn_max) < 0)
> Isn't this leaking "page" ?


Right, thanks, will add __free_page(page) here.

>> @@ -184,8 +307,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>>   
>>   	num_allocated_pages = vb->num_pfns;
>>   	/* Did we get any? */
>> -	if (vb->num_pfns != 0)
>> -		tell_host(vb, vb->inflate_vq);
>> +	if (vb->num_pfns) {
>> +		if (use_sg)
>> +			tell_host_sgs(vb, vb->inflate_vq, pfn_min, pfn_max);
> Please describe why tell_host_sgs() can work without __GFP_DIRECT_RECLAIM allocation,
> for tell_host_sgs() is called with vb->balloon_lock mutex held.

Essentially, 
tell_host_sgs()-->send_balloon_page_sg()-->add_one_sg()-->virtqueue_add_inbuf( 
, , num=1 ,,GFP_KERNEL)
won't need any memory allocation, because we always add one sg (i.e. 
num=1) each time. That memory
allocation option is only used when multiple sgs are added (i.e. num > 
1) and the implementation inside virtqueue_add_inbuf
need allocation of indirect descriptor table.

We could also add some comments above the function to explain a little 
about this if necessary.

>
>
>> @@ -223,7 +353,13 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>>   		page = balloon_page_dequeue(vb_dev_info);
>>   		if (!page)
>>   			break;
>> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>> +		if (use_sg) {
>> +			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0)
> Isn't this leaking "page" ?

Yes, will make it:

     if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
         balloon_page_enqueue(..., page);
         break;
     }

>
> If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
> use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
> on vb->balloon_lock mutex.

OK. Since the preload() doesn't need too much memory (< 4K in total), 
how about GFP_NOWAIT here?


Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

