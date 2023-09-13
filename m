Return-Path: <virtio-dev-return-13732-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC16CA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:14:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 87D1E56DB
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:14:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7476E986639
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:14:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6627B98612D; Wed, 13 Sep 2023 04:14:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56005986630;
	Wed, 13 Sep 2023 04:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378472884"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="378472884"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="779053609"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="779053609"
Message-ID: <7abce4d9-4762-dcad-6fdf-068588ebb3d9@intel.com>
Date: Wed, 13 Sep 2023 12:13:59 +0800
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
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
 <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5449424a-4872-0164-0c3f-caa34ad46388@intel.com>
 <PH0PR12MB5481CBCF7BEE5637D16BC179DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c4c2478-c90b-fb5b-cc06-bc74293862b9@intel.com>
 <PH0PR12MB54817178B8D5799FE74D4331DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85b1670b-5094-cdb8-fde9-1a9c0906f094@intel.com>
 <PH0PR12MB54815711322F1CAC35189CEDDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b0ae1197-f9e9-4596-f9bf-559f6112458f@intel.com>
 <PH0PR12MB5481E0C8D74DD3479331E0ACDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481E0C8D74DD3479331E0ACDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 9:35 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 12, 2023 6:39 PM
>>
>> On 9/12/2023 6:41 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Tuesday, September 12, 2023 4:05 PM I mean, why do you think my
>>>> series can not work with P2P
>>> Because it misses the intermediate mode STOP that we have in series [1].
>>>
>>> [1]
>>> https://lists.oasis-open.org/archives/virtio-comment/202309/msg00071.h
>>> tml
>> Again, when SUSPEND:
>> 1) the device freezes, means stop operation in both data-path and control-path,
>> except the device status
> Exactly, including the RESET_VQ command also cannot be served because device is frozen.
see below
>
>> 2) a new feature bit will be introduced in V2, to allow RESET_VQ after SUSPEND
> RESET_VQ after suspend is simply wrong. Because device is already suspended to not respond to some  extra RESET_VQ command.
No, when the device presents SUSPEND, that means the device config space 
is stabilized at that moment, from the SW perspective
the device will not make changes to config space until !SUSPEND.

However at that moment, the driver can still make modification to the 
config space and the driver handles the synchronization(checks, re-read, 
etc),
so the driver is responsible for what it reads.

As you can see, this is not perfect, so SiWei suggest to implement a new 
feature bit to control this, and it will be implemented in V2.
>
>> 3) if there is a device doing P2P against the device.
>> They should be pass-through-ed to the same guest and should be suspended as
>> well for LM, or it is a security problem.
> There is no security problem. Multiple passthrough devices and P2P is already there in PCI using ACS for probably a decade now.
As you aware of ACS, that means you have to trust them all, for example 
P2P devices has to be placed in one IOMMU group, and all devices
in the group should be pass-through-ed to a guest
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

