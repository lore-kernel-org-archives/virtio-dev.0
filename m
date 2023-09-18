Return-Path: <virtio-dev-return-13798-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02D8C46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 09:35:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E8E7C157EE9
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 09:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9A0D986419
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 09:35:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AC35398638E; Mon, 18 Sep 2023 09:35:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B3E29863A4
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 09:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446070697"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446070697"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835952925"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="835952925"
Message-ID: <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
Date: Mon, 18 Sep 2023 17:34:31 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/18/2023 2:54 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Monday, September 18, 2023 12:19 PM
>
>> so admin vq based LM solution can be a side channel attacking surface
> It will be part of the DSM whenever it will be used in future.
> Hence, it is not attack surface.
I am not sure, why we have to trust the PF?
This is out of virtio scope anyway.

I have explained many times how it can be a attack surface, and examples.

What happen if malicious SW dump guest memory by admin vq dirty page
tracking feature?
>
>>>>>> For untrusted hypervisor, same set of attack surface is present
>>>>>> with
>>>>>> trap+emulation.
>>>>>> So both method score same. Hence its not relevant point for discussion.
>>>>> this is not hypervisor, Do you see any modern hypervisor have these
>>>>> issues?
>>>>>
>>>>> This is admin vq for LM can be a side channel attacking surface.
>>> It is not.
>>> Hypervisor is trusted entity.
>>> For untrusted hypervisor the TDISP is unified solution build by the various
>> industry bodies including DMTF, PCI for last few years.
>>> We want to utilize that.
>> first, TDISP is out of virtio spec.
> Sure, hence, untrusted hypervisor are out of scope.
> Otherwise, trap+emulation is equally dead which relies on the hypervisor to do things.
so lets focus on LM topic, other than confidential computing.
>
>> second, TDISP devices can not be migrated for now third, admin vq can be an
>> side channel attacking surface as explained above.
> When TDISP are not used, hypervisor is trusted entity, period.
> And hence, it cannot be considered attack surface.
> An hypervisor can even disable SR-IOV.
if SRIOV is disabled, so you are migrating PF?
A PF certainly can not migrate itself by its own admin vq.

again, TDISP is out of spec and TDISP devices are not
migratable.
>
>>>>>>>> #3 There is no QoS issue with admin commands and queues. If you
>>>>>>>> claim that
>>>>>>> then whole virtio spec based on the virtqueues is broken.
>>>>>>>> And it is certainly not the case.
>>>>>>> Please do not confuse the concepts and purposes of the data queues
>>>>>>> and admin vq.
>>>>>>>
>>>>>> I am not confused.
>>>>>> There is no guarantee that a register placed on the VF will be
>>>>>> serviced by the device in exact same time regardless of VF count =
>>>>>> 1 or 4000.
>>>>>> Yet again not relevant comparison.
>>>>> please read my previous replies in other threads.
>>> It does not answer.
>>> The claim that somehow a polling register ensures downtime guarantee for
>> scale of thousands of member devices is some specific device implementation
>> without explanation.
>> the registers and the LM facilities are per-device.
>>>>>>> For data-queues, it can be slow without mq or rss, that means
>>>>>>> performance overhead, but can work.
>>>>>> No, it does not work. The application failed because of jitter in
>>>>>> the video and audio due to missing the latency budget.
>>>>>> A financial application is terminated due to timeouts and packet loss.
>>>>>>
>>>>>> Device migration is just another 3rd such applications.
>>>>>>
>>>>>> Its also same.
>>>>>> My last reply on this vague argument.
>>>>> I think the points are clear, and you already understand the points,
>>>>> so no need to argue anymore
>>> Yes, I am clear from long time, nor AQ nor no register, RSS queues, none
>> cannot guarantee any performance characteristics.
>>> It is pretty clear to me.
>>> Any performance guarantees are explicitly requested when desired.
>>>
>>>>>>> For admin vq, if it don't meet QOS requirements, it fails to
>>>>>>> migrate guests.
>>>>>>>
>>>>>>> I have replied to the same question so many times, and this is the
>>>>>>> last time.
>>>>>> I also replied many times that QoS argument is not valid anymore.
>>>>>> Same can happen with registers writes.
>>>>>> Perf characteristics for 30+ devices is not in the virtio spec. It
>>>>>> is implementation details.
>>>>> as replied many times, registers only serve the device itself and
>>>>> registers are not DATA PATH, means the device don't transfer data
>>>>> through registers.
>>> It does not matter data path or control path, the fact is it downtime assurance
>> cannot be guaranteed by register interface design, it is the implementation
>> details.
>>> And so does for admin commands and/or AQ.
>> the registers do not perform any data transitions, e.g., we don't migrate dirty
>> pages through registers.
>> But you do these by admin vq
> So what?
> Just because data transfer is not done, it does not mean that thousands of polling register writes complete in stipulated time.
1) again, they are per-device facilities
2) we use very few registers, even status byte does not require polling, 
just re-read with delay.

Please refer to the code for setting FEATURES_OK.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

