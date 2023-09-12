Return-Path: <virtio-dev-return-13683-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BAACA0ECE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 04:06:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CD5E41CA24C
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 04:06:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C26BB9865CE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 04:06:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B55D398648C; Tue, 12 Sep 2023 04:06:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4E84986485;
	Tue, 12 Sep 2023 04:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378177385"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="378177385"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917279759"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="917279759"
Message-ID: <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
Date: Tue, 12 Sep 2023 12:06:34 +0800
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
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/11/2023 6:21 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Monday, September 11, 2023 3:03 PM
>> So implement AQ on the "admin" VF? This require the HW reserve dedicated
>> resource for every VF?
>> So expensive, Overkill?
>>
>> And a VF may be managed by the PF and its admin "vf"?
> Yes.
it's a bit chaos, as you can see if the nested(L2 guest) VF can be managed
by both L1 guest VF and the host PF, that means two owners of the L2 VF.
>
>>> If UDP packets are dropped, even application can fail who do no retry.
>> UDP is not reliable, and performance overhead does not mean fail.
> It largely depends on application.
> I have seen iperf UDP failing on packet drop and never recovered.
> A retransmission over UDP can fail.
That depends on the workload, if it choose UDP, it is aware of the 
possibilities
of losing packets. But anyway, LM are expected to perform
successfully in the due time
>
>>>> But too few AQ to serve too high volume of VMs may be a problem.
>>> It is left for the device to implement the needed scale requirement.
>> Yes, so how many HW resource should the HW implementation reserved to
>> serve the worst case? Half of the board resource?
> The board designer can decide how to manage the resource.
> Administration commands are explicit instructions to the device.
> It knows how many members device's dirty tracking is ongoing, which device context is being read/written.
Still, does the board designer need to prepare for the worst case? How 
to meet that challenge?
>
> Admin command can even fail with EAGAIN error code when device is out of resource and software can retry the command.
As demonstrated, this series is reliable as the config space 
functionalities, so maybe less possibilities to fail?
>
> They key part is all of these happens outside of the VM's downtime.
> Majority of the work in proposal [1] is done when the VM is _live_.
> Hence, the resource consumption or reservation is significantly less.
Still depends on the volume of VMs and devices, the orchestration layer
needs to migrate the last round of dirty pages and states even when the VM
has been suspended.
>
>
>>>> Naming a number or an algorithm for the ratio of devices / num_of_AQs
>>>> is beyond this topic, but I made my point clear.
>>> Sure. It is beyond.
>>> And it is not a concern either.
>> It is, the user expect the LM process success than fail.
> I still fail to understand why LM process fails.
> The migration process is slow, but downtime is not in [1].
If I recall it clear, the downtime is around 300ms, so
don't let the bandwidth or num of admin vqs become
a bottle neck which may introduce more possibilities to fail.
>
>>>> can depth = 1K introduce significant latency?
>>> AQ command execution is not done serially. There is enough text on the AQ
>> chapter as I recall.
>> Then require more HW resource, I don't see difference.
> Difference compared to what, multiple AQs?
> If so, sure.
> The device who prefers to do only one AQ command at a time, sure it can work with less resource and do one at a time.
I think we are discussing the same issue as above "resource for the 
worst case" problem
>
>>>> And 1K depths is
>>>> almost identical to 2 X 500 queue depths, so still the same problem,
>>>> how many resource does the HW need to reserve to serve the worst case?
>>>>
>>> You didn’t describe the problem.
>>> Virtqueue is generic infrastructure to execute commands, be it admin
>> command, control command, flow filter command, scsi command.
>>> How many to execute in parallel, how many queues to have are device
>> implementation specific.
>> So the question is how many to serve the worst case? Does the HW vendor need
>> to reserve half of the board resource?
> No. It does not need to.
same as above
>
>>>> Let's forget the numbers, the point is clear.
>>> Ok. I agree with you.
>>> Number of AQs and its depth matter for this discussion, and its performance
>> characterization is outside the spec.
>>> Design wise, key thing to have the queuing interface between driver and
>> device for device migration commands.
>>> This enables both entities to execute things in parallel.
>>>
>>> This is fully covered in [1].
>>> So let's improve [1].
>>>
>>> [1]
>>> https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.h
>>> tml
>> I am not sure, why [1] is a must? There are certain issues discussed in this
>> thread for [1] stay unsolved.
>>
>> By the way, do you see anything we need to improve in this series?
> In [1], device context needs to more rich as we progress in v1/v2 versions.
>
> [..]
>
>>> A nested guest VM is not aware and should not.
>>> The VM hosting the nested VM, is aware on how to execute administrative
>> commands using the owner device.
>> The VM does not talk to admin vq either, the admin vq is a host facility, host
>> owns it.
> Admin VQ is owned by the device whichever has it.
> As I explained before, it is on the owner device.
> If needed one can do on more than owner device.
> A VM_A which is hosting another VM_B, a VM_A can have peer VF with AQ to be the admin device or migration manager device.
so two or more owners own the same device, conflict?
>
>>> At present for PCI transport, owner device is PF.
>>>
>>> In future for nesting, may be another peer VF can be delegated such task and
>> it can perform administration command.
>> Then it may run into the problems explained above.
>>> For bare metal may be some other admin device like DPU can do that role.
>> So [1] is not ready
>>>>>> Why this series can not support nested?
>>>>> I don’t see all the aspects that I covered in series [1] ranging
>>>>> from flr, device
>>>> context migration, virtio level reset, dirty page tracking, p2p support, etc.
>>>> covered in some device, vq suspend resume piece.
>>>>> [1]
>>>>> https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061
>>>>> .h
>>>>> tml
>>>> We have discussed many other issues in this thread.
>>>>>>>> And it does not serve bare-metal live migration either.
>>>>>>> A bare-metal migration seems a distance theory as one need side
>>>>>>> cpu,
>>>>>> memory accessor apart from device accessor.
>>>>>>> But somehow if that exists, there will be similar admin device to
>>>>>>> migrate it
>>>>>> may be TDDISP will own this whole piece one day.
>>>>>> Bare metal live migration require other components like firmware OS
>>>>>> and partitioning, that's why the device live migration should not
>>>>>> be a
>>>> blocker.
>>>>> Device migration is not blocker.
>>>>> In-fact it facilitates for this future in case if that happens where
>>>>> side cpu like
>>>> DPU or similar sideband virtio admin device can migrate over its admin vq.
>>>>> Long ago when admin commands were discussed, this was discussed too
>>>> where a admin device may not be an owner device.
>>>> The admin vq can not migrate it self therefore baremetal can not be
>>>> migrated by admin vq
>>> May be I was not clear. The admin commands are executed by some other
>> device than the PF.
>>   From SW perspective, it should be the admin vq and the device it resides.
>>> In above I call it admin device, which can be a DPU may be some other
>> dedicated admin device or something else.
>>> Large part of non virtio infrastructure at platform, BIOS, cpu, memory level
>> needs to evolve before virtio can utilize it.
>> virito device should be self-contained. Not depend on other components.
>>> We don’t need to cook all now, as long as we have administration commands
>> its good.
>>> The real credit owner for detaching the administration command from
>>> the admin vq is Michael. :) We like to utilize this in future for DPU case where
>> admin device is not the PCI PF.
>>> Eswitch, PF migration etc may utilize it in future when needed.
>> Again, the design should not rely on other host components.
> It does not. It relies on the administration commands.
I remember you have mentioned using DPU infrastructure to
perform bare-metal live migration?
>
>> And it is not about the credit, this is reliable work outcome
> I didn’t follow the comment.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

