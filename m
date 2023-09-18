Return-Path: <virtio-dev-return-13794-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C80C46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A66702AC51
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:50:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ADC49864C2
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:50:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 44E19983DFF; Mon, 18 Sep 2023 06:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C83CD98638E
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 06:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="443656822"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443656822"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="722359672"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="722359672"
Message-ID: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
Date: Mon, 18 Sep 2023 14:49:03 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/18/2023 2:37 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Monday, September 18, 2023 10:55 AM
>> To: Parav Pandit <parav@nvidia.com>; virtio-dev@lists.oasis-open.org; Michael
>> S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>
>> Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
>> state
>>
>> CC MST and Jason
>>
>> On 9/18/2023 1:21 PM, Zhu, Lingshan wrote:
>>>
>>> On 9/18/2023 12:32 PM, Parav Pandit wrote:
>>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>>> Sent: Monday, September 18, 2023 8:40 AM
>>>>>
>>>>> On 9/17/2023 1:32 PM, Parav Pandit wrote:
>>>>>>> From: virtio-dev@lists.oasis-open.org
>>>>>>> <virtio-dev@lists.oasis-open.org> On Behalf Of Zhu, Lingshan
>>>>>>> Sent: Friday, September 15, 2023 9:59 AM
>>>>>>>
>>>>>>> On 9/14/2023 7:14 PM, Michael S. Tsirkin wrote:
>>>>>>>> On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
>>>>>>>>> This series introduces
>>>>>>>>> 1)a new SUSPEND bit in the device status Which is used to
>>>>>>>>> suspend the device, so that the device states and virtqueue
>>>>>>>>> states are stabilized.
>>>>>>>>>
>>>>>>>>> 2)virtqueue state and its accessor, to get and set
>>>>>>>>> last_avail_idx and last_used_idx of virtqueues.
>>>>>>>>>
>>>>>>>>> The main usecase of these new facilities is Live Migration.
>>>>>>>>>
>>>>>>>>> Future work: dirty page tracking and in-flight descriptors.
>>>>>>>>> This series addresses many comments from Jason, Stefan and
>>>>>>>>> Eugenio from RFC series.
>>>>>>>> Compared to Parav's patchset this is much less functional.
>>>>>>> we will add dirty page tracking and in-flight IO tracker in V2,
>>>>>>> then it will be a full featured LM solution.
>>>>>>>
>>>>>>> They are not in this series because we want this series to be
>>>>>>> small and focus.
>>>>>>>> Assuming that one goes in, can't we add ability to submit admin
>>>>>>>> commands through MMIO on the device itself and be done with it?
>>>>>>> I am not sure, IMHO, if we use admin vq as back-ends for MMIO
>>>>>>> based live migration, then the issues in admin vq still exist, for example:
>>>>>>> 1)nested virtualization
>>>>>>> 2)bare-metal live migration
>>>>>>> 3)QOS
>>>>>>> 4)introduce more attacking surfaces.
>>>>>>>
>>>>>> #4 is just random without.
>>>>> I failed to process "random without".
>>>>>
>>>>> If you expect admin vq to perform live migration, it can certainly
>>>>> be a side channel attacking surface, for example:
>>>>> a) a malicious SW can stop the device running
>>>>> b) a malicious SW can sniff guest memory by tracking guest dirty
>>>>> pages, then speculate guest operations and stole secrets.
>>>> This is the mode when hypervisor is trusted.
>>> PF is not always owned by the hypervisor, right?
>>> And you don't pass-through the PF to any guests, right?
>>>> When hypervisor is untrusted, the CC model TDISP enabled device, TSM
>>>> will delegate the tasks to the DSM.
>>> TDISP devices can not be migrated for now.
> That is fine, the infra is build so that it can be migrated one day.
> And at that point the proposed admin command-based model also fits fine.
since you are talking about TDISP, I suggest to read TDISP spec,
it says:
Device Security Architecture - Administrative interfaces (e.g., a PF) 
may be used to influence the
security properties of the TDI used by the TVM. The device’s security 
architecture must provide
isolation and access control for TVM data in the device for protection 
against entities that are not in
the trust boundary of the TVM

so admin vq based LM solution can be a side channel attacking surface
>
>>>> For untrusted hypervisor, same set of attack surface is present with
>>>> trap+emulation.
>>>> So both method score same. Hence its not relevant point for discussion.
>>> this is not hypervisor, Do you see any modern hypervisor have these
>>> issues?
>>>
>>> This is admin vq for LM can be a side channel attacking surface.
> It is not.
> Hypervisor is trusted entity.
> For untrusted hypervisor the TDISP is unified solution build by the various industry bodies including DMTF, PCI for last few years.
> We want to utilize that.
first, TDISP is out of virtio spec.
second, TDISP devices can not be migrated for now
third, admin vq can be an side channel attacking surface as explained above.
>
>>>>>> #3 There is no QoS issue with admin commands and queues. If you
>>>>>> claim that
>>>>> then whole virtio spec based on the virtqueues is broken.
>>>>>> And it is certainly not the case.
>>>>> Please do not confuse the concepts and purposes of the data queues
>>>>> and admin vq.
>>>>>
>>>> I am not confused.
>>>> There is no guarantee that a register placed on the VF will be
>>>> serviced by the device in exact same time regardless of VF count = 1
>>>> or 4000.
>>>> Yet again not relevant comparison.
>>> please read my previous replies in other threads.
> It does not answer.
> The claim that somehow a polling register ensures downtime guarantee for scale of thousands of member devices is some specific device implementation without explanation.
the registers and the LM facilities are per-device.
>
>>>>> For data-queues, it can be slow without mq or rss, that means
>>>>> performance overhead, but can work.
>>>> No, it does not work. The application failed because of jitter in the
>>>> video and audio due to missing the latency budget.
>>>> A financial application is terminated due to timeouts and packet loss.
>>>>
>>>> Device migration is just another 3rd such applications.
>>>>
>>>> Its also same.
>>>> My last reply on this vague argument.
>>> I think the points are clear, and you already understand the points,
>>> so no need to argue anymore
> Yes, I am clear from long time, nor AQ nor no register, RSS queues, none cannot guarantee any performance characteristics.
> It is pretty clear to me.
> Any performance guarantees are explicitly requested when desired.
>
>>>>> For admin vq, if it don't meet QOS requirements, it fails to migrate
>>>>> guests.
>>>>>
>>>>> I have replied to the same question so many times, and this is the
>>>>> last time.
>>>> I also replied many times that QoS argument is not valid anymore.
>>>> Same can happen with registers writes.
>>>> Perf characteristics for 30+ devices is not in the virtio spec. It is
>>>> implementation details.
>>> as replied many times, registers only serve the device itself and
>>> registers are not DATA PATH, means the device don't transfer data
>>> through registers.
> It does not matter data path or control path, the fact is it downtime assurance cannot be guaranteed by register interface design, it is the implementation details.
> And so does for admin commands and/or AQ.
the registers do not perform any data transitions, e.g., we don't 
migrate dirty pages through registers.
But you do these by admin vq


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

