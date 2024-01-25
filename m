Return-Path: <virtio-dev-return-14276-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CB3C47DDF
	for <virtio-dev@archiver.kernel.org>; Thu, 25 Jan 2024 03:05:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D034D2A8D3
	for <virtio-dev@archiver.kernel.org>; Thu, 25 Jan 2024 03:05:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAE289867ED
	for <virtio-dev@archiver.kernel.org>; Thu, 25 Jan 2024 03:05:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A9D31986360; Thu, 25 Jan 2024 03:05:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 903AD9867E2;
	Thu, 25 Jan 2024 03:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.IdHTy_1706151915;
Message-ID: <52cef8e6-f878-4927-ab77-f3b71d3df85d@linux.alibaba.com>
Date: Thu, 25 Jan 2024 11:05:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
 <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078d541e-fac7-47ef-a69c-139d1e9b04f0@linux.alibaba.com>
 <PH0PR12MB54819844499B9D43865EDC4CDC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54819844499B9D43865EDC4CDC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] RE:
 [virtio-dev] RE: [virtio-comment] [PATCH v2] virtio-net: support setting
 coalescing params for multiple vqs



在 2024/1/24 下午9:18, Parav Pandit 写道:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, January 24, 2024 6:31 PM
>>
>>
>> 在 2024/1/22 下午1:03, Parav Pandit 写道:
>>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>>> Sent: Monday, January 22, 2024 8:27 AM
>>>>
>>>> 在 2024/1/20 下午5:59, Parav Pandit 写道:
>>>>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>>>>> Sent: Wednesday, January 17, 2024 10:22 AM
>>>>>>
>>>>>> 在 2024/1/15 下午9:21, Parav Pandit 写道:
>>>>>>>> From: virtio-comment@lists.oasis-open.org
>>>>>>>> <virtio-comment@lists.oasis- open.org> On Behalf Of Heng Qi
>>>>>>>> Sent: Monday, January 15, 2024 6:36 PM
>>>>>>>>
>>>>>>>> Currently, when each time the driver attempts to update the
>>>>>>>> coalescing parameters for a vq, it needs to kick the device and
>>>>>>>> wait for the ctrlq response to return.
>>>>>>> It does not need to wait. This is some driver limitation that does
>>>>>>> not use
>>>>>> the queue as "queue".
>>>>>>> Such driver limitation should be removed in the driver. It does
>>>>>>> not qualify
>>>>>> as limitation.
>>>>>>
>>>>>> Yes, we don't have to wait.
>>>>>>
>>>>>> But in general, for user commands, it is necessary to obtain the
>>>>>> final results synchronously.
>>>>> Yes. Use initiated command can enqueue the request to cvq. Go to
>>>>> sleep
>>>> for several micro to milliseconds.
>>>>>> The user command cannot return before the final result is obtained.
>>>>>> And wait is not the problem this patch solves.
>>>>>>
>>>>> By not holding the rtnl lock, rest of the context that needs to
>>>>> enqueue the
>>>> request can progress such as that of netdim.
>>>>
>>>> Would like to see the using of rtnl lock changed.
>>>>
>>> Inside the virtnet_rx_dim_work() there should be rtnl lock call.
>>> A virtio_device level lock to be used for cvq. :)
>>>
>>>> In addition, I have made batching and asynchronousization of the
>>>> netdim command, you can refer to this patch:
>>>> https://lore.kernel.org/all/1705410693-118895-4-git-send-email-
>>>> hengqi@linux.alibaba.com/
>>>>
>>> In the listed above driver patch the motivation "to optimize the CPU
>>> overhead of the DIM worker caused by the guest being busy waiting for
>>> the command response result."
>>>
>>> Is not right.
>>> Because guest is still busy waiting.
>> There is no busy wait for guests, see get_cvq_work().
>>
> Ok. not always busy waiting, sometimes it does.

Busy waiting will only occur when the user command or dim command cannot 
find the available buffer for cvq.

The user command is still in polling mode for now, I have not tried to 
optimize this. Now it's about improving dim performance.

> virtnet_cvq_response() should not have flag..

The flag is mainly used to identify whether it is a user command. If so, 
the previous polling mode will still be maintained.

>
> Who ever gets the OS global rtnl lock is calling virtnet_cvq_response() and checking and releasing.
> Shouldn’t be done this way with try lock etc.
> Rtnl lock is not supposed to protect low level driver some ctrlvq response flag.

To summarize, we now want to make some improvements to cvq:
1. Reasonable timeout in busy waiting mode or interrupt-based etc.
2. Batch processing (the core problem is how to get results from user 
commands synchronously)
3. Remove rtnl_lock’s protection for ctrlq.

Yes, these improve the processing efficiency of cvq and avoid the 
problem of OS hang.
I think 1, 3 need short term long term work and we need to try.
I don’t see any demand for batching user commands.

So for now, let's move forward with optimizing dim.

>
>
>>> Without batching, due to rtnl lock every VQ command is serialized as one
>> outstanding command at a time in virtnet_rx_dim_work().
>>> Due to this device is unable to take benefit of DMA batching at large scale.
>> Adding dim commands is now asynchronous, and the device will receive
>> batches of commands.
>>
> I am comparing the code where there is no rtnl lock with the code you posted.

Okay, I can post a patch later based on the code without rtnl_lock.

> The reference code of patch [1] needs to begin without OS global rtnl lock as base line.
>
> [1] https://lore.kernel.org/all/1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com/
>
>>>>>>> This will enable driver to enqueue multiple cvq commands without
>>>>>>> waiting
>>>>>> for previous one.
>>>>>>> This will also enable device to find natural coalescing done on
>>>>>>> multiple
>>>>>> commands.
>>>>>>
>>>>>> When batch user commands occur, ensuring synchronization is a
>> concern.
>>>>>>>> The following path is observed: 1. Driver kicks the device; 2.
>>>>>>>> After the device receives the kick, CPU scheduling occurs and DMA
>>>>>>>> multiple buffers multiple times; 3. The device completes
>>>>>>>> processing and replies
>>>>>> with a response.
>>>>>>>> When large-queue devices issue multiple requests and kick the
>>>>>>>> device frequently, this often interrupt the work of the device-side CPU.
>>>>>>> When there is large devices and multiple driver notifications by a
>>>>>>> cpu that is N times faster than the device side cpu, the device
>>>>>>> may find natural
>>>>>> coalescing on the commands of a given cvq.
>>>>>>
>>>>>> First we have to solve the ctrlq batch adding user (ethtool) command.
>>>>>> Even if processed in a batch way on device side, the number of
>>>>>> kicks and the number of backend DMAs has not been reduced.
>>>>> Driver notifications are PCI writes so it should not hamper device
>>>>> side,
>>>> which can ignore them when they do not bother about it.
>>>>
>>>> Driver notifications need to be processed by the DPU, which
>>>> interferes with the CPU on the DPU.
>>>>
>>> I was asking, if there is anyway to disable for your DPU to ignore these
>> notifications while previous one is pending?
>>>   From your above description, it seems there isn’t.
>> While the device is processing the request, additional kicks are ignored.
>>
> Ok. that is good. In that case the kicks are not interfering, right?

YES.

When a VM sends many DIM requests, the requests are serialized and 
processed one at a time, and the number of kicks increases.

Even when we add commands asynchronously (such as this patch 
https://lore.kernel.org/all/1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com/),
the device needs to process each command present in the ctrlq individually.
Each command requires the device CPU to wait for the DMA operation to 
complete before replying.
Although kicks are reduced, the device's DMA operations for batched 
commands are serialized, which affects efficiency.


In addition, I would like to extend the VIRTIO_NET_F_VQ_NOTF_COAL 
feature to support the new VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET command.
I think this is ok.

Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

