Return-Path: <virtio-dev-return-13666-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDA2EE57DF
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:18:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 506081318CC
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:18:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BFC8986499
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:18:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2BB58981BDD; Mon, 11 Sep 2023 07:18:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 192C798635C;
	Mon, 11 Sep 2023 07:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="442007804"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="442007804"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858211167"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858211167"
Message-ID: <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
Date: Mon, 11 Sep 2023 15:18:08 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/11/2023 3:07 PM, Parav Pandit wrote:
>
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Monday, September 11, 2023 12:28 PM
>>> I don’t see in his proposal how all the features and functionality supported is
>> achieved.
>> I will include in-flight descriptor tracker and diry-page traking in V2, anything
>> else missed?
>> It can migrate the device itself, why don't you think so, can you name some
>> issues we can work on for improvements?
> I would like to see a proposal similar to [1] that can work without mediation in case if you want to combine two use cases under one.
> Else, I don’t see a need to merge two things.
>
> Dirty page tracking, peer to peer, downtime, no-mediation, flrs all are covered in [1] for passthrough cases.
We are introducing basic facilities, feel free to re-use them in the 
admin vq solution.
>
>> If you want to implement LM by admin vq, the facilities in my series can be re-
>> used. E.g., forward your suspend to SUSPEND bit.
> Just VQ suspend is not enough...
In this series, it contains: device SUSPEND, queue state accessor.
MST required in-flight descriptor tracking, which will be included in 
next version.
>
>>>
>>>>> Admin queue of the member device is migrated like any other queue
>>>>> using
>>>> above [1].
>>>>>> 2) won't work in the nested environment, or we need complicated
>>>>>> SR-IOV emulation in order to work
>>>>>>
>>>>>>> Poking at the device from the driver to migrate it is not going to
>>>>>>> work if the driver lives within guest.
>>>>>> This is by design to allow live migration to work in the nested layer.
>>>>>> And it's the way we've used for CPU and MMU. Anything may virtio
>>>>>> different here?
>>>>> Nested and non-nested use cases likely cannot be addressed by single
>>>> solution/interface.
>>>>
>>>> I think Ling Shan's proposal addressed them both.
>>>>
>>> I don’t see how all above points are covered.
>> Why?
>>
>>
>> And how do you migrate nested VMs by admin vq?
>>
> Hypervisor = level 1.
> VM = level 2.
> Nested VM = level 3.
> VM of level 2 to take care of migrating level 3 composed device using its sw composition or may be using some kind of mediation that you proposed.
So, nested VM is not aware of the admin vq or does not have access to 
admin vq, right?
>
>> How many admin vqs and the bandwidth are reserved for migrate all VMs?
>>
> It does not matter because number of AQs is configurable that device and driver can decide to use.
> I am not sure which BW are talking about.
> There are many BW in place that one can regulate, at network level, pci level, VM level etc.
It matters because of QOS and the downtime must converge.

E.g., do you need 100 admin vqs for 1000 VMs? How do you decide the 
number in HW implementation and how
does the driver get informed?
>
>> Remember CSP migrates all VMs on a host for powersaving or upgrade.
> I am not sure why the migration reason has any influence on the design.
Because this design is for live migration.
>
> The CSPs that we had discussed, care for performance more and hence prefers passthrough instead or mediation and don’t seem to be doing any nesting.
> CPU doesnt have support for 3 level of page table nesting either.
> I agree that there could be other users who care for nested functionality.
>
> Any ways, nesting and non-nesting are two different requirements.
The LM facility should server both, or it is far from ready. And it does 
not serve bare-metal live migration either.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

