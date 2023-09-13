Return-Path: <virtio-dev-return-13735-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE26EEB58F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:21:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DAC4C1CA24B
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:21:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFEE7986641
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:21:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C2C9D98612D; Wed, 13 Sep 2023 04:21:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2BDF986630;
	Wed, 13 Sep 2023 04:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375887985"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="375887985"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693714621"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693714621"
Message-ID: <dd40c978-3606-594d-f70e-6ce2c120a693@intel.com>
Date: Wed, 13 Sep 2023 12:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
 <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <987f72eb-f82c-da4b-229c-ffc5b60d6fb4@intel.com>
 <PH0PR12MB5481F256CCB58C10DB65A8D1DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0861d9ff-d126-c6e4-0deb-74ca81675eeb@intel.com>
 <PH0PR12MB5481678840AE3B1B2D97D512DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <30bed94a-e99e-1561-def3-719e25a0dd26@intel.com>
 <PH0PR12MB5481687C209231F8C4CE8A1EDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7424d2ae-2366-882f-bd84-04ee5714764b@intel.com>
 <PH0PR12MB5481E322E66419AAC61822ACDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481E322E66419AAC61822ACDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/13/2023 12:12 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 13, 2023 9:31 AM
>>
>> On 9/12/2023 9:43 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Tuesday, September 12, 2023 6:33 PM
>>>>
>>>> On 9/12/2023 5:21 PM, Parav Pandit wrote:
>>>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>>>> Sent: Tuesday, September 12, 2023 2:33 PM admin vq require fixed
>>>>>> and dedicated resource to serve the VMs, the question still
>>>>>> remains, does is scale to server big amount of devices migration?
>>>>>> how many admin vqs do you need to serve 10 VMs, how many for 100?
>>>>>> and so on? How to scale?
>>>>>>
>>>>> Yes, it scales within the AQ and across multiple AQs.
>>>>> Please consult your board designers to know such limits for your device.
>>>> scales require multiple AQs, then how many should a vendor provide
>>>> for the worst case?
>>>>
>>>> I am boring for the same repeating questions.
>>> I said it scales, within the AQ. (and across AQs).
>>> I have answered enough times, so I will stop on same repeated question.
>>> Your repeated question is not helping anyone as it is not in the scope of virtio.
>>>
>>> If you think it is, please get it written first for RSS and MQ in net section and
>> post for review.
>> You missed the point of the question and I agree no need to discuss this
>> anymore.
> Ok. thanks.
>
>>>>>> If one admin vq can serve 100 VMs, can it migrate 1000VMs in
>>>>>> reasonable
>>>> time?
>>>>>> If not, how many exactly.
>>>>>>
>>>>> Yes, it can serve both 100 and 1000 VMs in reasonable time.
>>>> I am not sure, the aq is limitless? Can serve thousands of VMs in a
>>>> reasonable time? Like in 300ms?
>>>>
>>> Yes.
>> really? limitless?
> I answered yes for " Can serve thousands of VMs in reasonable time? Like in 300ms?"?
> VQ depth defines the VQ's limit.
still sounds like limitless and I will stop arguing this as you can see 
if there is REALLY
a queue can be limitless, we even don't need Multi-queue or RSS.
>
>>>> If you say, that require multiple AQ, then how many should a vendor
>> provide?
>>> I didn’t say multiple AQs must be used.
>>> It is same as NIC RQs.
>> don't you agree a single vq has its own performance limitations?
> For LM I don’t see the limitation.
> The finite limit an AQ has, such limitation is no different than some register write poll with one entry at a time per device.
see above, and we are implementing per device facilities.
>
>> In this series, it says:
>> +When setting SUSPEND, the driver MUST re-read \field{device status} to
>> ensure the SUSPEND bit is set.
>>
>> And this is nothing to do with scale.
> Hence, it is bringing same scale QOS limitation on register too that you claim may be present in the AQ.
>
> And hence, I responded earlier that when most things are not done through BAR, so there is no need to do suspend/resume via BAR either.
> And hence the mode setting command of [1] is just fine.
The bar registers are almost "triggers"
>
>>> On top of that once the device is SUSPENDED, it cannot accept some other
>> RESET_VQ command.
>> so as SiWei suggested, there will be a new feature bit introduced in V2
>> for vq reset.
> VQ cannot be RESET after the device reset as you wrote.
It is device SUSPEND, not reset.
>
>>>>>> It does not reside on the PF to migrate the VFs.
>>>>> Hence it does not scale and cannot do parallel operation within the VF,
>> unless
>>>> each register is replicated.
>>>> Why its not scale? It is a per device facility.
>>> Because the device needs to answer per device through some large scale
>> memory to fit in a response time.
>> Again, it is a per-device facility, and it is register based serve the
>> only one device itself.
>> And we do not plan to log the dirty pages in bar.
> Hence, there is no reason to wrap suspend resume on the BAR either.
> The mode setting admin command is just fine.
They are device status bits.
>
>>>> Why do you need parallel operation against the LM facility?
>>> Because your downtime was 300msec for 1000 VMs.
>> the LM facility in this series is per-device, it only severs itself.
> And that single threading and single threading per VQ reset via single register wont scale.
it is per-device facility, for example, on the VF, not the owner PF.
>
>>>> That doesn't make a lot of sense.
>>>>> Using register of a queue for bulk data transfer is solved question when the
>>>> virtio spec was born.
>>>>> I don’t see a point to discuss it.
>>>>> Snippet from spec: " As a device can have zero or more virtqueues for bulk
>>>> data transport"
>>>> Where do you see the series intends to transfer bulk data through registers?
>>>>>> VFs config space can use the device dedicated resource like the
>> bandwidth.
>>>>>> for AQ, still you need to reserve resource and how much?
>>>>> It depends on your board, please consult your board designer to know
>>>> depending on the implementation.
>>>>>    From spec point of view, it should not be same as any other virtqueue.
>>>> so the vendor own the risk to implement AQ LM? Why they have to?
>>>>>>> No. I do not agree. It can fail and very hard for board designers.
>>>>>>> AQs are more reliable way to transport bulk data in scalable manner
>>>>>>> for tens
>>>>>> of member devices.
>>>>>> Really? How often do you observe virtio config space fail?
>>>>> On Intel Icelake server we have seen it failing with 128 VFs.
>>>>> And device needs to do very weird things to support 1000+ VFs forever
>>>> expanding config space, which is not the topic of this discussion anyway.
>>>> That is your setup problem.
>>>>>>>> Please allow me to provide an extreme example, is one single admin
>>>>>>>> vq limitless, that can serve hundreds to thousands of VMs migration?
>>>>>>> It is left to the device implementation. Just like RSS and multi queue
>>>> support?
>>>>>>> Is one Q enough for 800Gbps to 10Mbps link?
>>>>>>> Answer is: Not the scope of specification, spec provide the
>>>>>>> framework to scale
>>>>>> this way, but not impose on the device.
>>>>>> Even if not support RSS or MQ, the device still can work with
>>>>>> performance overhead, not fail.
>>>>>>
>>>>> _work_ is subjective.
>>>>> The financial transaction (application) failed. Packeted worked.
>>>>> LM commands were successful, but it was not timely.
>>>>>
>>>>> Same same..
>>>>>
>>>>>> Insufficient bandwidth & resource caused live migration fail is
>>>>>> totally different.
>>>>> Very abstract point and unrelated to administration commands.
>>>> It is your design facing the problem.
>>>>>>>> If not, two or
>>>>>>>> three or what number?
>>>>>>> It really does not matter. Its wrong point to discuss here.
>>>>>>> Number of queues and command execution depends on the device
>>>>>> implementation.
>>>>>>> A financial transaction application can timeout when a device
>>>>>>> queuing delay
>>>>>> for virtio net rx queue is long.
>>>>>>> And we don’t put details about such things in specification.
>>>>>>> Spec takes the requirements and provides driver device interface to
>>>>>> implement and scale.
>>>>>>> I still don’t follow the motivation behind the question.
>>>>>>> Is your question: How many admin queues are needed to migrate N
>>>>>>> member
>>>>>> devices? If so, it is implementation specific.
>>>>>>> It is similar to how such things depend on implementation for 30
>>>>>>> virtio device
>>>>>> types.
>>>>>>> And if are implying that because it is implementation specific, that
>>>>>>> is why
>>>>>> administration queue should not be used, but some configuration
>>>>>> register should be used.
>>>>>>> Than you should propose a config register interface to post
>>>>>>> virtqueue
>>>>>> descriptors that way for 30 device types!
>>>>>> if so, leave it as undefined? A potential risk for device implantation?
>>>>>> Then why must the admin vq?
>>>>> Because administration commands and admin vq does not impose devices
>> to
>>>> implement thousands of registers which must have time bound completion
>>>> guarantee.
>>>>> The large part of industry including SIOV devices led by Intel and others are
>>>> moving away from register access mode.
>>>>> To summarize, administration commands and queue offer following
>> benefits.
>>>>> 1. Ability to do bulk data transfer between driver and device
>>>>>
>>>>> 2. Ability to parallelize the work within driver and within device
>>>>> within single or multiple virtqueues
>>>>>
>>>>> 3. Eliminates implementing PCI read/write MMIO registers which demand
>>>>> low latency response interval
>>>>>
>>>>> 4. Better utilize host cpu as no one needs to poll on the device
>>>>> register for completion
>>>>>
>>>>> 5. Ability to handle variability in command completion by device and
>>>>> ability to notify the driver
>>>>>
>>>>> If this does not satisfy you, please refer to some of the past email
>> discussions
>>>> during administration virtuqueue time.
>>>> I think you mixed up the facility and the implementation in my series, please
>>>> read.
>>> I don’t know what you refer to. You asked "why AQ is must?" I answered
>> above what AQ has to offer than some synchronous register.
>> Again, we are implementing facilities, V2 will include inflgiht
>> descriptors and dirty page tracking. That works for LM.
> It can be named under anything, what matters is how/where it is used?
> So "facility" and "implementation" in your above comment are just abstract word.
> I answered you "Why AQ is must"?
see above and please feel free to reuse the basic facilities if you like 
in your AQ LM


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

