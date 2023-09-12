Return-Path: <virtio-dev-return-13697-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BCFCA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:27:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F3F382A8E2
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:27:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE9AC98658F
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:27:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E41EF983E27; Tue, 12 Sep 2023 07:27:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2848986485;
	Tue, 12 Sep 2023 07:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444738312"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="444738312"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="743617305"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="743617305"
Message-ID: <987f72eb-f82c-da4b-229c-ffc5b60d6fb4@intel.com>
Date: Tue, 12 Sep 2023 15:27:41 +0800
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
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
 <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 2:47 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 12, 2023 12:04 PM
>>
>>
>> On 9/12/2023 1:58 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Tuesday, September 12, 2023 9:37 AM
>>>>
>>>> On 9/11/2023 6:21 PM, Parav Pandit wrote:
>>>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>>>> Sent: Monday, September 11, 2023 3:03 PM So implement AQ on the
>>>>>> "admin" VF? This require the HW reserve dedicated resource for
>>>>>> every VF?
>>>>>> So expensive, Overkill?
>>>>>>
>>>>>> And a VF may be managed by the PF and its admin "vf"?
>>>>> Yes.
>>>> it's a bit chaos, as you can see if the nested(L2 guest) VF can be
>>>> managed by both L1 guest VF and the host PF, that means two owners of the
>> L2 VF.
>>> This is the nesting.
>>> When you do M level nesting, does any cpu in world handle its own page
>> tables in isolation of next level and also perform equally well?
>> Not exactly, in nesting, L1 guest is the host/infrastructure emulator for L2, so L2
>> is expect to do nothing with the host, or something like L2 VF managed by both
>> L1 VF and host PF can lead to operational and security issues?
>>>>>>> If UDP packets are dropped, even application can fail who do no retry.
>>>>>> UDP is not reliable, and performance overhead does not mean fail.
>>>>> It largely depends on application.
>>>>> I have seen iperf UDP failing on packet drop and never recovered.
>>>>> A retransmission over UDP can fail.
>>>> That depends on the workload, if it choose UDP, it is aware of the
>>>> possibilities of losing packets. But anyway, LM are expected to
>>>> perform successfully in the due time
>>> And LM also depends on the workload. :)
>> Exactly! That's the point, how to meet the requirements!
>>> It is pointless to discuss performance characteristics as a point to use AQ or
>> not.
>> How to meet QOS requirement when LM?
> By following [1] where large part of device context and dirty page tracking is done when the VM is running.
Still needs to migrate the last round of dirty pages and device states 
when VM freeze. Still can be large if
take big amount of VMs into consideration, and that is where ~300ms due 
time rules.
>
>>> No. board designer does not need to.
>>> As explained already, if board wants to supporting single command of AQ,
>> sure.
>> Same as above, the QOS question. For example, how to avoid the situation that
>> half VMs can be migrated and others timeout?
> Why would this happen?
> Timeout is not related to AQ in case if that happens.
explained above
> Timeout can happen to config registers too. And it can be even far more harder for board designers to support PCI reads in a timeout to handle in 384 reads in parallel.
When the VM freeze, the virtio functionalities, for example virito-net 
transaction is suspended as well,
so no TLPs for networking traffic buffers.

The on-device Live Migration facility can use the full PCI device 
bandwidth for migration.

That is the difference with the admin vq.
>
> I am still not able to follow your point for asking about unrelated QOS questions.
explained above, it has to meet the due time requirement and many VMs 
can be migrated simultaneously,
in that situation, they have to race for the admin vq resource/bandwidth.
>
>>>>> Admin command can even fail with EAGAIN error code when device is
>>>>> out of
>>>> resource and software can retry the command.
>>>> As demonstrated, this series is reliable as the config space
>>>> functionalities, so maybe less possibilities to fail?
>>> Huh. Config space has far higher failure rate for the PCI transport when due to
>> inherent nature of PCI timeouts and reads and polling.
>>> For any bulk data transfer virtqueue is spec defined approach.
>>> For more than a year this was debated you can check some 2021 emails.
>>>
>>> You can see the patches that data transfer done in [1] over registers is snail
>> slow.
>> Do you often observe virtio PCI config space fail? Or does admin vq need to
>> transfer data through PCI?
> Admin commands needs to transfer bulk data across thousands of VFs in parallel for many VFs without baking registers in PCI.
So you agree actually PCI config space are very unlikely to fail? It is 
reliable.

Please allow me to provide an extreme example, is one single admin vq 
limitless, that can
serve hundreds to thousands of VMs migration? If not, two or three or 
what number?
>
>>>>> They key part is all of these happens outside of the VM's downtime.
>>>>> Majority of the work in proposal [1] is done when the VM is _live_.
>>>>> Hence, the resource consumption or reservation is significantly less.
>>>> Still depends on the volume of VMs and devices, the orchestration
>>>> layer needs to migrate the last round of dirty pages and states even
>>>> when the VM has been suspended.
>>> That has nothing do with admin virtqueue.
>>> And migration layer already does it and used by multiple devices.
>> same as above, QOS
>>>>>>>> Naming a number or an algorithm for the ratio of devices /
>>>>>>>> num_of_AQs is beyond this topic, but I made my point clear.
>>>>>>> Sure. It is beyond.
>>>>>>> And it is not a concern either.
>>>>>> It is, the user expect the LM process success than fail.
>>>>> I still fail to understand why LM process fails.
>>>>> The migration process is slow, but downtime is not in [1].
>>>> If I recall it clear, the downtime is around 300ms, so don't let the
>>>> bandwidth or num of admin vqs become a bottle neck which may
>>>> introduce more possibilities to fail.
>>>>>>>> can depth = 1K introduce significant latency?
>>>>>>> AQ command execution is not done serially. There is enough text on
>>>>>>> the AQ
>>>>>> chapter as I recall.
>>>>>> Then require more HW resource, I don't see difference.
>>>>> Difference compared to what, multiple AQs?
>>>>> If so, sure.
>>>>> The device who prefers to do only one AQ command at a time, sure it
>>>>> can
>>>> work with less resource and do one at a time.
>>>> I think we are discussing the same issue as above "resource for the worst
>> case"
>>>> problem
>>> Frankly I am not seeing any issue.
>>> AQ is just another virtqueue as basic construct in the spec used by 30+ device
>> types.
>> explained above, when migrate a VM, the time consuming has to convergence
>> and the total downtime has a due, I remember it is less than 300ms. That is the
>> QOS requirement.
> And admin commands can easily serve that as majority of the work is done when the VM is running and member device is in active state in proposal [1].
explained above, depends on the amount of the migrating VMs.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

