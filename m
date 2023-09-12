Return-Path: <virtio-dev-return-13715-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8326CA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:32:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 209B92ACFE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:32:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AAC89865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:32:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0E5EF986485; Tue, 12 Sep 2023 10:32:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF58898648C;
	Tue, 12 Sep 2023 10:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378246118"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378246118"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917388363"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="917388363"
Message-ID: <b892785d-2850-f5e6-531f-d4934ebc7085@intel.com>
Date: Tue, 12 Sep 2023 18:32:22 +0800
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
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <PH0PR12MB5481036BC22785DC22A394D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c39bfe6-1acf-6ee7-2a0c-1861fa680eb4@intel.com>
 <PH0PR12MB54815CE0845F866CD8125662DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54815CE0845F866CD8125662DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 6:25 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 12, 2023 3:47 PM
>>
>> On 9/12/2023 5:28 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Tuesday, September 12, 2023 2:36 PM If you want AQ used for LM,
>>>> it should support nested anyway, don't break user logic.
>>> You ignored the other part of my question when you asked above.
>>> i.e. a PCI transport do not allow such weird bifurcation.
>> I failed to process your comment.
>> Do you mean the registers don't support nested?
> No. I mean registers access should support device reset flow and FLR flow.
DO you see this is a concern? Or why do you think there are problems?
>
>>>> This (my)series can support nested.
>>> Maybe it does, with hacking the device reset and FLR sequence, without dirty
>> tracking, without P2P support, without passthrough mode.
>>> All these requirements are not addressed.
>>>
>>> If you intent to cover both requirements, lets work towards it to see
>>> if it can converge, if there are technical challenges, then there is no point in
>> pushing to claim that in-band VF with mediation is the only way to move
>> forward.
>> Why do you need P2P?
> I answered this before few hours back.
still, why P2P is a blocker of my series?
>
>> Why FLR and reset are concerned?
> Because they must work.
why FLR and reset are affected? When SUSPEND, the device should stop 
operation.
>> Why do you think dirty page tracking is not supported?
> Because you wrote in cover letter " Future work: dirty page tracking and in-flight descriptors."
> And you repeatedly resisted administration commands. I don’t see how above two can be done efficiently without administration commands.
> And if one is going to use administration command in future for above two, there is no point of doing current series over registers.
> I don’t see how and administration queue can work after device is suspended, and after FLR how dirty page tracking can continue.
>
> All these aspects are covered in [1] that can be extended for nesting if needed with side car VF.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.html
I will post V2 with in-flight descriptors tracking and dirty-page 
tracking. They are not in this series bcasue
I want this series to focus and small


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

