Return-Path: virtio-dev-return-2794-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 597755818F76
	for <virtio-dev@lists.oasis-open.org>; Sun, 10 Dec 2017 22:36:55 -0800 (PST)
Message-ID: <5A2E27F5.2010703@intel.com>
Date: Mon, 11 Dec 2017 14:38:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com> <1511963726-34070-11-git-send-email-wei.w.wang@intel.com> <20171201173951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171201173951-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v18 10/10] virtio-balloon: don't report free pages when
 page poisoning is enabled
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/01/2017 11:49 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 29, 2017 at 09:55:26PM +0800, Wei Wang wrote:
>> The guest free pages should not be discarded by the live migration thread
>> when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
>> skipping the transfer of such poisoned free pages will trigger false
>> positive when new pages are allocated and checked on the destination.
>> This patch skips the reporting of free pages in the above case.
>>
>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 035bd3a..6ac4cff 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -652,7 +652,9 @@ static void report_free_page(struct work_struct *work)
>>   	/* Start by sending the obtained cmd id to the host with an outbuf */
>>   	send_one_desc(vb, vb->free_page_vq, virt_to_phys(&vb->start_cmd_id),
>>   		      sizeof(uint32_t), false, true, false);
>> -	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>> +	if (!(page_poisoning_enabled() &&
>> +	    !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY)))
>> +		walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>>   	/*
>>   	 * End by sending the stop id to the host with an outbuf. Use the
>>   	 * non-batching mode here to trigger a kick after adding the stop id.
> PAGE_POISONING_ZERO is actually OK.
>
> But I really would prefer it that we still send pages to host,
> otherwise debugging becomes much harder.
>
> And it does not have to be completely useless, even though
> you can not discard them as they would be zero-filled then.
>
> How about a config field telling host what should be there in the free
> pages? This way even though host can not discard them, host can send
> them out without reading them, still a win.
>
>

Since this poison value comes with the free page reporting feature, how 
about sending the poison value via the free_page_vq, along with the cmd 
id in the outbuf? That is, use the following interface:

struct virtio_balloon_free_page_vq_hdr {
     bool page_poisoning;
     __virtio32 poison_value;
     __virtio32 cmd_id;
}

We need "bool page_poisoning" because "poison_value=0" doesn't tell 
whether page poising is in use by the guest. PAGE_POISONING_ZERO sets 
"page_poisoning=true, poisoning_value=0", and the host will send the 
0-filled pages to the destination (if not sending 0-filled pages, the 
destination host would offer non-zero pages to the guest)
The host can discard free pages only when "page_poisoning=false".

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

