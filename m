Return-Path: <virtio-dev-return-13736-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA07EEB58F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:21:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 36D3C23549
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:21:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25727986640
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:21:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 17FEA98612D; Wed, 13 Sep 2023 04:21:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08B13986630;
	Wed, 13 Sep 2023 04:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375888039"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="375888039"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693714718"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693714718"
Message-ID: <9d9ac82e-8eb9-558e-916a-c327e3c3a996@intel.com>
Date: Wed, 13 Sep 2023 12:21:23 +0800
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
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
 <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com>
 <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/13/2023 12:15 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 13, 2023 9:33 AM
>> To: Parav Pandit <parav@nvidia.com>; Jason Wang <jasowang@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>; eperezma@redhat.com;
>> cohuck@redhat.com; stefanha@redhat.com; virtio-comment@lists.oasis-
>> open.org; virtio-dev@lists.oasis-open.org
>> Subject: Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
>> VIRTIO_F_QUEUE_STATE
>>
>>
>>
>> On 9/13/2023 10:23 AM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Tuesday, September 12, 2023 3:45 PM
>>>>> Do you find the administration commands we proposed in [1] useful
>>>>> for
>>>> nested case?
>>>>> If not, both will likely diverge.
>>>> Not till now.
>>> I don’t think you reviewed [1] enough.
>>> Following functionality that you want to post in v1 is already covered.
>>> Why cannot you use it from [1]?
>>>
>>> a. Dirty page tracking (write recording in [1]), b. device
>>> suspend/resume (mode setting) c. inflight descriptors (device context)
>>>
>>> [1]
>>> https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.h
>>> tml
>> you cut off the message, I don't know which conversation you are replying to.
>>
>> But anyway, as pointed out many times, we are implementing basic facilities.
> I asked you what parts of the series [1] can be used by you for inflight tracking, dirty tracking, suspend/resume.
> You replied, none is useful.
> And after that you said you plan to send v2 that does dirty page tracking, inflight tracking.
>
> So I asked why you cannot use [1] that covers things that you plan to send in future?
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.html
>
> Hope this clarifies.
we plan to implement a self-contain solution


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

