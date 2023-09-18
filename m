Return-Path: <virtio-dev-return-13795-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFDFC46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:50:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC8F433597
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 330EC98669A
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:50:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4EFFF9863D7; Mon, 18 Sep 2023 06:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 422E39863A4;
	Mon, 18 Sep 2023 06:49:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="443656918"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443656918"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="722359918"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="722359918"
Message-ID: <d51650a7-3408-6c83-1eb3-2cf8e2164d1d@intel.com>
Date: Mon, 18 Sep 2023 14:49:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-3-lingshan.zhu@intel.com>
 <20230914073023-mutt-send-email-mst@kernel.org>
 <258989c9-8c5f-c72e-c03d-aabf11f9823d@intel.com>
 <20230915070504-mutt-send-email-mst@kernel.org>
 <3ff7e79f-8fbb-4e3e-eb12-17ed8943fe6f@intel.com>
 <PH0PR12MB5481E091659FEA931DBC826EDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <90ffd64c-9997-3ebb-6d4b-6fdb8d1bdb4f@intel.com>
 <PH0PR12MB5481309462314E5E17B064A1DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c2fd48e4-0e2f-038a-5b11-85cc7e0ef081@intel.com>
 <PH0PR12MB5481D3E0B9B8EC0F5626F373DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481D3E0B9B8EC0F5626F373DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit in
 device status



On 9/18/2023 2:46 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Monday, September 18, 2023 12:09 PM
>>> There is parent object.
>>> There is VQ which you propose to do SUSPEND_RESET of the parent virtio
>> device which is already SUSPENDED.
>> that is why we plan to implement a new feature bit to control this behavior.
>>
> It does not matter adding a feature bit when the semantics itself is wrong.
>
>> However, in next version, as MST suggested, I will forbid resetting vqs after
>> SUSPEND.
> Ok. That is good.
> I got confused with above proposed bit.
OK, lets at least close this one


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

