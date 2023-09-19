Return-Path: <virtio-dev-return-13830-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEDCCD54AB
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 10:03:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3981F759CC
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 10:03:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2601B986555
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 10:03:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 196F0983E25; Tue, 19 Sep 2023 10:03:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C61A9864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 10:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378796049"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="378796049"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="695853463"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="695853463"
Message-ID: <2e3bca3b-5292-cc89-80c8-225919717eb2@intel.com>
Date: Tue, 19 Sep 2023 18:03:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c1361497-4c46-d00d-58e7-520d5f81b90a@intel.com>
 <PH0PR12MB54810692ACC61C50A911ADE8DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54810692ACC61C50A911ADE8DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/19/2023 5:06 PM, Parav Pandit wrote:
>
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 19, 2023 1:32 PM
>>
>> On 9/19/2023 2:41 AM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Monday, September 18, 2023 3:05 PM
>>>>
>>>> On 9/18/2023 2:54 PM, Parav Pandit wrote:
>>>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>>>> Sent: Monday, September 18, 2023 12:19 PM so admin vq based LM
>>>>>> solution can be a side channel attacking surface
>>>>> It will be part of the DSM whenever it will be used in future.
>>>>> Hence, it is not attack surface.
>>>> I am not sure, why we have to trust the PF?
>>>> This is out of virtio scope anyway.
>>>>
>>>> I have explained many times how it can be a attack surface, and examples.
>>>>
>>> And none of that make any sense as fundamentally, hypervisor is trusted
>> regardless of the approach.
>> this is not about hypervisors, I am saying admin vq based LM solution can be a
>> side channel attacking surface Please refer to my previously listed examples
>> and the TDISP spec is FYI.
> In previous email you wrote " As I said before, CC and TDISP is out of spec, that means we should ignore them for now."
> So I am ignoring it now and hence, I am ignoring above comment.
> Lets reach to a common ground for simplified case and than consider more complex cases.
ok
>
>>>> What happen if malicious SW dump guest memory by admin vq dirty page
>>>> tracking feature?
>>> What??
>>> Where is this malicious SW is located, in guest VM?
>> host, in this attacking model.
>>>>>>>>>> For untrusted hypervisor, same set of attack surface is present
>>>>>>>>>> with
>>>>>>>>>> trap+emulation.
>>>>>>>>>> So both method score same. Hence its not relevant point for
>> discussion.
>>>>>>>>> this is not hypervisor, Do you see any modern hypervisor have
>>>>>>>>> these issues?
>>>>>>>>>
>>>>>>>>> This is admin vq for LM can be a side channel attacking surface.
>>>>>>> It is not.
>>>>>>> Hypervisor is trusted entity.
>>>>>>> For untrusted hypervisor the TDISP is unified solution build by
>>>>>>> the various
>>>>>> industry bodies including DMTF, PCI for last few years.
>>>>>>> We want to utilize that.
>>>>>> first, TDISP is out of virtio spec.
>>>>> Sure, hence, untrusted hypervisor are out of scope.
>>>>> Otherwise, trap+emulation is equally dead which relies on the
>>>>> hypervisor to
>>>> do things.
>>>> so lets focus on LM topic, other than confidential computing.
>>> ok.
>>>
>>>>> Just because data transfer is not done, it does not mean that
>>>>> thousands of
>>>> polling register writes complete in stipulated time.
>>>> 1) again, they are per-device facilities
>>> That does not satisfy that it can somehow do work in < x usec time.
>> why? Do you mind take examples of basic PCI virtio common config space
>> registers?
>>>> 2) we use very few registers, even status byte does not require
>>>> polling, just re- read with delay.
>>>>
>>>> Please refer to the code for setting FEATURES_OK.
>>> It wont work when one needs to suspend the device.
>>> There is no point of doing such work over registers as fundamental framework
>> is over the AQ.
>> why it doesn't work?
> For two following reasons.
> 1. All the things needed cannot be communicated over registers efficiently, such as (a) device context, (b) dirty pages.
for a) please read QEMU live migration code.
for b) the registers in config space are control path, we don't store 
dirty pages by the registers.
You can review the next version.
> 2. synchronous registers on the VF cannot inter operate with FLR and device reset flow.
Why FLR is a concern to this series? Have you read QEMU live migration 
code? Does it handle FLR explicitly?
Does it need to handle all PCI attributes?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

