Return-Path: virtio-dev-return-2732-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 578245818FA8
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Dec 2017 00:05:02 -0800 (PST)
Message-ID: <5A210DA2.7030101@intel.com>
Date: Fri, 01 Dec 2017 16:06:58 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>	<1511963726-34070-11-git-send-email-wei.w.wang@intel.com> <201711301945.HJD69236.OSMQtOFHOJLVFF@I-love.SAKURA.ne.jp>
In-Reply-To: <201711301945.HJD69236.OSMQtOFHOJLVFF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v18 10/10] virtio-balloon: don't report free pages when
 page poisoning is enabled
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/30/2017 06:45 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> @@ -652,7 +652,9 @@ static void report_free_page(struct work_struct *work)
>>   	/* Start by sending the obtained cmd id to the host with an outbuf */
>>   	send_one_desc(vb, vb->free_page_vq, virt_to_phys(&vb->start_cmd_id),
>>   		      sizeof(uint32_t), false, true, false);
>> -	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>> +	if (!(page_poisoning_enabled() &&
>> +	    !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY)))
> I think that checking IS_ENABLED() before checking page_poisoning_enabled()
> would generate better code, for IS_ENABLED() is build-time constant while
> page_poisoning_enabled() is a function which the compiler assumes that we
> need to call page_poisoning_enabled() even if IS_ENABLED() is known to be 0.
>
> 	if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
> 	    !page_poisoning_enabled())
>
>

Agree, thanks.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

