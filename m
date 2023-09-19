Return-Path: <virtio-dev-return-13826-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42994CD54A8
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 08:39:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7C1D745B2F
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 08:39:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52F1B98655A
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 08:39:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B7DA983E25; Tue, 19 Sep 2023 08:39:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CD5E9864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 08:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359286028"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359286028"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076902898"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="1076902898"
Message-ID: <d3a707f1-22bc-1886-92d3-4240bc648cff@intel.com>
Date: Tue, 19 Sep 2023 16:39:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
 <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <474be878-333b-7c80-f116-28b90a3eca4d@intel.com>
 <PH0PR12MB5481236F275C1A0314D85FCFDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6b1b7993-08bc-f2a8-4cd9-92301372373a@intel.com>
 <PH0PR12MB5481B11949AFD1415AF4F267DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481B11949AFD1415AF4F267DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/19/2023 4:31 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 19, 2023 1:34 PM
>>> In your previous email you wrote,
>>>
>>> 1. "so lets focus on LM topic, other than confidential computing."
>>> 2. "again, TDISP is out of spec and TDISP devices are not migratable."
>>>
>>>   From above two comments from you I understood it that way, you want to
>> focus now on the LM _other_than_ CC.
>>> How to read it differently?
>> You said:"Lingshan wanted to take this TDISP extension in future."
>>
> Based on above two comments from you this is what I understand.
I am not a native speaker, but do you see I ever mentioned that
I want to take TDISP in future? Any verbs I used?
>> How do you conclude this statement? Did I ever said I want to take TDISP
>> extension in future?
> CC and TDISP goes hand in hand.
>
> So you want to consider TDISP extension now (and not in future)?
As I said before, CC and TDISP is out of spec, that means we should 
ignore them for now.
And I don't plan to take TDISP in future, you should not confuse the 
sentences.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

