Return-Path: <virtio-dev-return-13668-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE7AEE57DF
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:58:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9939242C46
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:58:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D1099864B9
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:58:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8175E98635C; Mon, 11 Sep 2023 07:58:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FDE39863B6;
	Mon, 11 Sep 2023 07:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358322372"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358322372"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916939449"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916939449"
Message-ID: <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
Date: Mon, 11 Sep 2023 15:58:11 +0800
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
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/11/2023 3:30 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Monday, September 11, 2023 12:48 PM
>>
>> On 9/11/2023 3:07 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Monday, September 11, 2023 12:28 PM
>>>>> I don’t see in his proposal how all the features and functionality
>>>>> supported is
>>>> achieved.
>>>> I will include in-flight descriptor tracker and diry-page traking in
>>>> V2, anything else missed?
>>>> It can migrate the device itself, why don't you think so, can you
>>>> name some issues we can work on for improvements?
>>> I would like to see a proposal similar to [1] that can work without mediation
>> in case if you want to combine two use cases under one.
>>> Else, I don’t see a need to merge two things.
>>>
>>> Dirty page tracking, peer to peer, downtime, no-mediation, flrs all are covered
>> in [1] for passthrough cases.
>> We are introducing basic facilities, feel free to re-use them in the admin vq
>> solution.
> Basic facilities are added in [1] for passthrough devices.
> You can leverage them in your v2 for supporting p2p devices, dirty page tracking, passthrough support, shorter downtime and more.
Basic facilities should be better not depend on others, but admin vq can 
re-use the basic facilities.

For P2P, what if the devices are placed in different IOMMU group?
>
>>>> If you want to implement LM by admin vq, the facilities in my series
>>>> can be re- used. E.g., forward your suspend to SUSPEND bit.
>>> Just VQ suspend is not enough...
>> In this series, it contains: device SUSPEND, queue state accessor.
>> MST required in-flight descriptor tracking, which will be included in next
>> version.
> For passthrough more than that is needed.
Dirty page tracking will be addressed too, others should we work on?
>>>>>>> Admin queue of the member device is migrated like any other queue
>>>>>>> using
>>>>>> above [1].
>>>>>>>> 2) won't work in the nested environment, or we need complicated
>>>>>>>> SR-IOV emulation in order to work
>>>>>>>>
>>>>>>>>> Poking at the device from the driver to migrate it is not going
>>>>>>>>> to work if the driver lives within guest.
>>>>>>>> This is by design to allow live migration to work in the nested layer.
>>>>>>>> And it's the way we've used for CPU and MMU. Anything may virtio
>>>>>>>> different here?
>>>>>>> Nested and non-nested use cases likely cannot be addressed by
>>>>>>> single
>>>>>> solution/interface.
>>>>>>
>>>>>> I think Ling Shan's proposal addressed them both.
>>>>>>
>>>>> I don’t see how all above points are covered.
>>>> Why?
>>>>
>>>>
>>>> And how do you migrate nested VMs by admin vq?
>>>>
>>> Hypervisor = level 1.
>>> VM = level 2.
>>> Nested VM = level 3.
>>> VM of level 2 to take care of migrating level 3 composed device using its sw
>> composition or may be using some kind of mediation that you proposed.
>> So, nested VM is not aware of the admin vq or does not have access to admin
>> vq, right?
> Right. It is not aware.
>
>>>> How many admin vqs and the bandwidth are reserved for migrate all VMs?
>>>>
>>> It does not matter because number of AQs is configurable that device and
>> driver can decide to use.
>>> I am not sure which BW are talking about.
>>> There are many BW in place that one can regulate, at network level, pci level,
>> VM level etc.
>> It matters because of QOS and the downtime must converge.
> QOS is such a broad term that is hard to debate unless you get to a specific point.
E.g., there can be hundreds or thousands of VMs, how many admin vq are 
required to serve them when
LM? To converge, no timeout.
>> E.g., do you need 100 admin vqs for 1000 VMs? How do you decide the number
>> in HW implementation and how does the driver get informed?
> Usually just one AQ is enough as proposal [1] is built around inherent downtime reduction.
> You can ask similar question for RSS, how does hw device how many RSS queues are needed. 😊
> Device exposes number of supported AQs that driver is free to use.
RSS is not a must for the transition through maybe performance overhead.
But if the host can not finish Live Migration in the due time, then it is
a failed LM.
>
> Most sane sys admins do not migrate 1000 VMs at same time for obvious reasons.
> But when such requirements arise, a device may support it.
> Just like how a net device can support from 1 to 32K txqueues at spec level.
The orchestration layer may do that for host upgrade or power-saving.
And the VMs may be required to migrate together, for example:
a cluster of VMs in the same subnet.

Lets do not introduce new frangibility
>
>>>> Remember CSP migrates all VMs on a host for powersaving or upgrade.
>>> I am not sure why the migration reason has any influence on the design.
>> Because this design is for live migration.
>>> The CSPs that we had discussed, care for performance more and hence
>> prefers passthrough instead or mediation and don’t seem to be doing any
>> nesting.
>>> CPU doesnt have support for 3 level of page table nesting either.
>>> I agree that there could be other users who care for nested functionality.
>>>
>>> Any ways, nesting and non-nesting are two different requirements.
>> The LM facility should server both,
> I don’t see how PCI spec let you do it.
> PCI community already handed over this to SR-PCIM interface outside of the PCI spec domain.
> Hence, its done over admin queue for passthrough devices.
>
> If you can explain, how your proposal addresses passthrough support without mediation and also does DMA, I am very interested to learn that.
Do you mean nested? Why this series can not support nested?
>
>> And it does not serve bare-metal live migration either.
> A bare-metal migration seems a distance theory as one need side cpu, memory accessor apart from device accessor.
> But somehow if that exists, there will be similar admin device to migrate it may be TDDISP will own this whole piece one day.
Bare metal live migration require other components like firmware OS and 
partitioning, that's why the device live migration should not
be a blocker.
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

