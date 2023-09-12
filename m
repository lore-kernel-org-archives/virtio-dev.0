Return-Path: <virtio-dev-return-13703-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C9CA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:03:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 51E4B7078A
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:03:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4755298662A
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:03:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 37FBB983E27; Tue, 12 Sep 2023 09:03:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25BB5986485;
	Tue, 12 Sep 2023 09:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464690648"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="464690648"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858720640"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="858720640"
Message-ID: <0861d9ff-d126-c6e4-0deb-74ca81675eeb@intel.com>
Date: Tue, 12 Sep 2023 17:02:48 +0800
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
 <987f72eb-f82c-da4b-229c-ffc5b60d6fb4@intel.com>
 <PH0PR12MB5481F256CCB58C10DB65A8D1DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481F256CCB58C10DB65A8D1DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 3:40 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 12, 2023 12:58 PM
>> To: Parav Pandit <parav@nvidia.com>; Jason Wang <jasowang@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>; eperezma@redhat.com;
>> cohuck@redhat.com; stefanha@redhat.com; virtio-comment@lists.oasis-
>> open.org; virtio-dev@lists.oasis-open.org
>> Subject: Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
>> VIRTIO_F_QUEUE_STATE
>>
>>
>>
>> On 9/12/2023 2:47 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Tuesday, September 12, 2023 12:04 PM
>>>>
>>>>
>>>> On 9/12/2023 1:58 PM, Parav Pandit wrote:
>>>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>>>> Sent: Tuesday, September 12, 2023 9:37 AM
>>>>>>
>>>>>> On 9/11/2023 6:21 PM, Parav Pandit wrote:
>>>>>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>>>>>> Sent: Monday, September 11, 2023 3:03 PM So implement AQ on the
>>>>>>>> "admin" VF? This require the HW reserve dedicated resource for
>>>>>>>> every VF?
>>>>>>>> So expensive, Overkill?
>>>>>>>>
>>>>>>>> And a VF may be managed by the PF and its admin "vf"?
>>>>>>> Yes.
>>>>>> it's a bit chaos, as you can see if the nested(L2 guest) VF can be
>>>>>> managed by both L1 guest VF and the host PF, that means two owners
>>>>>> of the
>>>> L2 VF.
>>>>> This is the nesting.
>>>>> When you do M level nesting, does any cpu in world handle its own
>>>>> page
>>>> tables in isolation of next level and also perform equally well?
>>>> Not exactly, in nesting, L1 guest is the host/infrastructure emulator
>>>> for L2, so L2 is expect to do nothing with the host, or something
>>>> like L2 VF managed by both
>>>> L1 VF and host PF can lead to operational and security issues?
>>>>>>>>> If UDP packets are dropped, even application can fail who do no retry.
>>>>>>>> UDP is not reliable, and performance overhead does not mean fail.
>>>>>>> It largely depends on application.
>>>>>>> I have seen iperf UDP failing on packet drop and never recovered.
>>>>>>> A retransmission over UDP can fail.
>>>>>> That depends on the workload, if it choose UDP, it is aware of the
>>>>>> possibilities of losing packets. But anyway, LM are expected to
>>>>>> perform successfully in the due time
>>>>> And LM also depends on the workload. :)
>>>> Exactly! That's the point, how to meet the requirements!
>>>>> It is pointless to discuss performance characteristics as a point to
>>>>> use AQ or
>>>> not.
>>>> How to meet QOS requirement when LM?
>>> By following [1] where large part of device context and dirty page tracking is
>> done when the VM is running.
>> Still needs to migrate the last round of dirty pages and device states when VM
>> freeze. Still can be large if take big amount of VMs into consideration, and that
>> is where ~300ms due time rules.
>>>>> No. board designer does not need to.
>>>>> As explained already, if board wants to supporting single command of
>>>>> AQ,
>>>> sure.
>>>> Same as above, the QOS question. For example, how to avoid the
>>>> situation that half VMs can be migrated and others timeout?
>>> Why would this happen?
>>> Timeout is not related to AQ in case if that happens.
>> explained above
>>> Timeout can happen to config registers too. And it can be even far more
>> harder for board designers to support PCI reads in a timeout to handle in 384
>> reads in parallel.
>> When the VM freeze, the virtio functionalities, for example virito-net
>> transaction is suspended as well, so no TLPs for networking traffic buffers.
> The config registers mediated operation done by host itself are TLPs flowing for several hundreds of VM example you took.
> In your example you took 1000 VMs freezing simultaneously for which you need to finish the config cycles in some 300 msec.
This is per-device operations, directly access device config space, 
consume the dedicated device resource & bandwidth, like
other standard virito operations.
>
>> The on-device Live Migration facility can use the full PCI device bandwidth for
>> migration.
> So does admin commands also.
> However the big difference is: registers do not scale with large number of VFs.
> Admin commands scale easily.
admin vq require fixed and dedicated resource to serve the VMs, the 
question still
remains, does is scale to server big amount of devices migration? how 
many admin
vqs do you need to serve 10 VMs, how many for 100? and so on? How to scale?

If one admin vq can serve 100 VMs, can it migrate 1000VMs in reasonable 
time?
If not, how many exactly.


And register does not need to scale, it resides on the VF and only serve 
the VF.

It does not reside on the PF to migrate the VFs.
>
> I probably should not repeat what is already captured in the admin commands commit log and cover letter.
>
>> That is the difference with the admin vq.
> I don’t know what difference you are talking about.
> PCI device bandwidth for migration is available with admin commands and some config registers both.
> BW != timeout.
VFs config space can use the device dedicated resource like the bandwidth.

for AQ, still you need to reserve resource and how much?
>
>>> I am still not able to follow your point for asking about unrelated QOS
>> questions.
>> explained above, it has to meet the due time requirement and many VMs can
>> be migrated simultaneously, in that situation, they have to race for the admin
>> vq resource/bandwidth.
>>>>>>> Admin command can even fail with EAGAIN error code when device is
>>>>>>> out of
>>>>>> resource and software can retry the command.
>>>>>> As demonstrated, this series is reliable as the config space
>>>>>> functionalities, so maybe less possibilities to fail?
>>>>> Huh. Config space has far higher failure rate for the PCI transport
>>>>> when due to
>>>> inherent nature of PCI timeouts and reads and polling.
>>>>> For any bulk data transfer virtqueue is spec defined approach.
>>>>> For more than a year this was debated you can check some 2021 emails.
>>>>>
>>>>> You can see the patches that data transfer done in [1] over
>>>>> registers is snail
>>>> slow.
>>>> Do you often observe virtio PCI config space fail? Or does admin vq
>>>> need to transfer data through PCI?
>>> Admin commands needs to transfer bulk data across thousands of VFs in
>> parallel for many VFs without baking registers in PCI.
>> So you agree actually PCI config space are very unlikely to fail? It is reliable.
>>
> No. I do not agree. It can fail and very hard for board designers.
> AQs are more reliable way to transport bulk data in scalable manner for tens of member devices.
Really? How often do you observe virtio config space fail?
>
>> Please allow me to provide an extreme example, is one single admin vq
>> limitless, that can serve hundreds to thousands of VMs migration?
> It is left to the device implementation. Just like RSS and multi queue support?
> Is one Q enough for 800Gbps to 10Mbps link?
> Answer is: Not the scope of specification, spec provide the framework to scale this way, but not impose on the device.
Even if not support RSS or MQ, the device still can work with 
performance overhead, not fail.

Insufficient bandwidth & resource caused live migration fail is totally 
different.
>
>> If not, two or
>> three or what number?
> It really does not matter. Its wrong point to discuss here.
> Number of queues and command execution depends on the device implementation.
> A financial transaction application can timeout when a device queuing delay for virtio net rx queue is long.
> And we don’t put details about such things in specification.
> Spec takes the requirements and provides driver device interface to implement and scale.
>
> I still don’t follow the motivation behind the question.
> Is your question: How many admin queues are needed to migrate N member devices? If so, it is implementation specific.
> It is similar to how such things depend on implementation for 30 virtio device types.
>
> And if are implying that because it is implementation specific, that is why administration queue should not be used, but some configuration register should be used.
> Than you should propose a config register interface to post virtqueue descriptors that way for 30 device types!
if so, leave it as undefined? A potential risk for device implantation?
Then why must the admin vq?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

