Return-Path: <virtio-dev-return-13934-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07795E7D0C7
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:39:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 74D3E2AC53
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:39:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59B169866A2
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:39:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 460529864C1; Fri, 22 Sep 2023 03:39:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33E1898669D;
	Fri, 22 Sep 2023 03:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="467032464"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467032464"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782487960"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="782487960"
Message-ID: <0a1006a0-c3b0-62f3-7aae-44a46a5fe843@intel.com>
Date: Fri, 22 Sep 2023 11:39:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/22/2023 11:08 AM, Jason Wang wrote:
> On Thu, Sep 21, 2023 at 12:19 PM Parav Pandit <parav@nvidia.com> wrote:
>>
>>> From: Jason Wang <jasowang@redhat.com>
>>> Sent: Thursday, September 21, 2023 9:39 AM
>>>
>>> On Thu, Sep 21, 2023 at 12:01 PM Parav Pandit <parav@nvidia.com> wrote:
>>>>
>>>>
>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>> Sent: Thursday, September 21, 2023 8:48 AM
>>>>> As replied in another thread, the issues for BAR are:
>>>>>
>>>>> 1) Not sure it can have an efficient interface, it would be
>>>>> something like VIRTIO_PCI_CAP_PCI_CFG which is very slow compared to
>>>>> single register accessing
>>>>> 2) There's no owner/group/member for MMIO, most of the time, we only
>>>>> need a single MMIO device. If we want the owner to manage itself, it
>>>>> seems redundant as is implied in all the existing transports (without admin
>>> commands).
>>>>> Even if we had, it might still suffer from bootstrap issues.
>>>>> 3) For live migration, it means the admin commands needs to start
>>>>> from duplicating every existing transport specific interface it can
>>>>> give us. One example is that we may end up with two interfaces to
>>>>> access virtqueue addresses etc. This results in extra complicity and
>>>>> it is actually a full transport (driver can just use admin commands to drive
>>> the device).
>>>> In [1] there is no duplication. The live migration driver never parses the device
>>> context either while reading or write.
>>>> Hence no code and no complexity in driver and no duplicate work.
>>>> Therefore, those admin commands are not to drive the guest device either.
>>> I'm not sure how this is related to the duplication issue.
>>>
>> You commented that admin virtqueue duplicates somethings.
>> And I explained above that it does not.
>>
>>>>> 4) Admin commands itself may not be capable of doing things like
>>>>> dirty page logging, it requires the assistance from the transport
>>>>>
>>>> Admin command in [1] is capable of dirty page logging.
>>> In your design, the logging is done via DMA not the virtqueue.
>>>
>> No. it is done via admin command, not DMA in [2].
>>
>> [2] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#m17b09acd8c73d374e98ad84764b315afa94f59c9
>>
>>> The only job for virtqueue is to initiate the DMA. But if DMA can be initiated via
>>> virtqueue, it can be done in other ways.
>>>
>> Lets first establish 4 things in alternative way, any motivation to do so with 5th point without giant registers need in device.
>>
>>>>> 1) Parav's proposal does several couplings: couple basic build
>>>>> blocks (suspend, dirty page tracking) with live migration, couple
>>>>> live migration with admin commands.
>>>> In which use case you find dirty page tracking useful without migration for
>>> which you like to see it detached from device migration flow?
>>>
>>> Is it only the dirty page tracking? It's the combinations of
>>>
>>> 1) suspending
>>> 2) device states
>>> 3) dirty page tracking
>>>
>>> Eeah of those will have use cases other than live migration: VM stop, power
>>> management in VM, profiling and monitoring, failover etc.
>>>
>> Suspend/resume with different power state is driven by the guest directly.
> And there's hibernation actually where device states might be useful.
>
>> So it may find some overlap.
>>
>> Device context has no overlap.
> I can give you one example, e.g debugging.
>
>> Dirty page tracking has no overlap. What do you want to profile and monitor? In case if you want to profile, it can be used without migration command anyway?
> It works like a dirty bit of PTE. We all know it has a broader use
> case than logging. For example, tracking working set and do
> optimization on IOMMU/IOTLB or even device IOTLB.
>
> 1) Try to prove your facility can only work for one specific cases
> 2) Try to prove your facility can work for more than one cases
>
> Which one is easier and more beneficial to virtio?
>
>
>> If you describe, may be we I can split "device migration" chapter to two pieces,
>> Device management and device migration.
>>
>> Device migration will use these basic facility.
>> Would that help you?
> Definitely, but it needs to be done by not making it under the
> subsection of admin commands, that's it.
>
> Let me repeat once again here for the possible steps to collaboration:
>
> 1) define virtqueue state, inflight descriptors in the section of
> basic facility but not under the admin commands
> 2) define the dirty page tracking, device context/states in the
> section of basic facility but not under the admin commands
> 3) define transport specific interfaces or admin commands to access them
I totally agree with this proposal.
>
> Does this work? It seems you refused such steps in the past.
>
> Actually, I would like to leave 2) as it's very complicated which
> might not converge easily.
>
> Thanks
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

