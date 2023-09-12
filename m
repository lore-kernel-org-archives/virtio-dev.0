Return-Path: <virtio-dev-return-13721-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A0CA0ECF
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:03:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7D287EEA26
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:03:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 778A0986633
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:03:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6AE439864A8; Tue, 12 Sep 2023 13:03:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5912C9864A4;
	Tue, 12 Sep 2023 13:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357796910"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="357796910"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693484794"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="693484794"
Message-ID: <30bed94a-e99e-1561-def3-719e25a0dd26@intel.com>
Date: Tue, 12 Sep 2023 21:03:05 +0800
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
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481678840AE3B1B2D97D512DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 5:21 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 12, 2023 2:33 PM
>> admin vq require fixed and dedicated resource to serve the VMs, the question
>> still remains, does is scale to server big amount of devices migration? how many
>> admin vqs do you need to serve 10 VMs, how many for 100? and so on? How to
>> scale?
>>
> Yes, it scales within the AQ and across multiple AQs.
> Please consult your board designers to know such limits for your device.
scales require multiple AQs, then how many should a vendor provide for the
worst case?

I am boring for the same repeating questions.
>   
>> If one admin vq can serve 100 VMs, can it migrate 1000VMs in reasonable time?
>> If not, how many exactly.
>>
> Yes, it can serve both 100 and 1000 VMs in reasonable time.
I am not sure, the aq is limitless? Can serve thousands of VMs
in a reasonable time? Like in 300ms?

If you say, that require multiple AQ, then how many should a vendor provide?

Don't say the board designer own the risks.
>
>> And register does not need to scale, it resides on the VF and only serve
>> the VF.
>>
> Since its per VF, by nature it is linearly growing entity that the board design needs to support read and write with guaranteed timing.
> It clearly scaled poor than queue.
Please read my series. For example, we introduce a new bit SUSPEND in 
the \field{device status}, any scalability issues here?
>   
>> It does not reside on the PF to migrate the VFs.
> Hence it does not scale and cannot do parallel operation within the VF, unless each register is replicated.
Why its not scale? It is a per device facility.
Why do you need parallel operation against the LM facility?
That doesn't make a lot of sense.
>
> Using register of a queue for bulk data transfer is solved question when the virtio spec was born.
> I don’t see a point to discuss it.
> Snippet from spec: " As a device can have zero or more virtqueues for bulk data transport"
Where do you see the series intends to transfer bulk data through registers?
>
>> VFs config space can use the device dedicated resource like the bandwidth.
>>
>> for AQ, still you need to reserve resource and how much?
> It depends on your board, please consult your board designer to know depending on the implementation.
>  From spec point of view, it should not be same as any other virtqueue.
so the vendor own the risk to implement AQ LM? Why they have to?
>>> No. I do not agree. It can fail and very hard for board designers.
>>> AQs are more reliable way to transport bulk data in scalable manner for tens
>> of member devices.
>> Really? How often do you observe virtio config space fail?
> On Intel Icelake server we have seen it failing with 128 VFs.
> And device needs to do very weird things to support 1000+ VFs forever expanding config space, which is not the topic of this discussion anyway.
That is your setup problem.
>
>
>>>> Please allow me to provide an extreme example, is one single admin vq
>>>> limitless, that can serve hundreds to thousands of VMs migration?
>>> It is left to the device implementation. Just like RSS and multi queue support?
>>> Is one Q enough for 800Gbps to 10Mbps link?
>>> Answer is: Not the scope of specification, spec provide the framework to scale
>> this way, but not impose on the device.
>> Even if not support RSS or MQ, the device still can work with
>> performance overhead, not fail.
>>
> _work_ is subjective.
> The financial transaction (application) failed. Packeted worked.
> LM commands were successful, but it was not timely.
>
> Same same..
>   
>> Insufficient bandwidth & resource caused live migration fail is totally
>> different.
> Very abstract point and unrelated to administration commands.
It is your design facing the problem.
>
>>>> If not, two or
>>>> three or what number?
>>> It really does not matter. Its wrong point to discuss here.
>>> Number of queues and command execution depends on the device
>> implementation.
>>> A financial transaction application can timeout when a device queuing delay
>> for virtio net rx queue is long.
>>> And we don’t put details about such things in specification.
>>> Spec takes the requirements and provides driver device interface to
>> implement and scale.
>>> I still don’t follow the motivation behind the question.
>>> Is your question: How many admin queues are needed to migrate N member
>> devices? If so, it is implementation specific.
>>> It is similar to how such things depend on implementation for 30 virtio device
>> types.
>>> And if are implying that because it is implementation specific, that is why
>> administration queue should not be used, but some configuration register
>> should be used.
>>> Than you should propose a config register interface to post virtqueue
>> descriptors that way for 30 device types!
>> if so, leave it as undefined? A potential risk for device implantation?
>
>> Then why must the admin vq?
> Because administration commands and admin vq does not impose devices to implement thousands of registers which must have time bound completion guarantee.
> The large part of industry including SIOV devices led by Intel and others are moving away from register access mode.
>
> To summarize, administration commands and queue offer following benefits.
>
> 1. Ability to do bulk data transfer between driver and device
>
> 2. Ability to parallelize the work within driver and within device within single or multiple virtqueues
>
> 3. Eliminates implementing PCI read/write MMIO registers which demand low latency response interval
>
> 4. Better utilize host cpu as no one needs to poll on the device register for completion
>
> 5. Ability to handle variability in command completion by device and ability to notify the driver
>
> If this does not satisfy you, please refer to some of the past email discussions during administration virtuqueue time.
I think you mixed up the facility and the implementation in my series, 
please read.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

