Return-Path: <jasowang@redhat.com>
Message-ID: <56a7bf50-509d-f9d5-df78-858cb1b156c1@redhat.com>
Date: Tue, 25 Jan 2022 11:29:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com>
 <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/19 下午12:48, Parav Pandit 写道:
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Wednesday, January 19, 2022 9:33 AM
>>
>>
>> It it means IMS, there's already a proposal[1] that introduce MSI commands
>> via the admin virtqueue. And we had similar requirement for virtio-MMIO[2]
>> and managed device or SF [3], so I would rather to introduce IMS (need a
>> better name though) as a basic facility instead of tie it to any specific
>> transport.
>>
> IMS of [1] is a interrupt configuration by the virtio driver for the device is it driving, which needs a queue.
> So regardless of the device type as PCI PF/VF/SF/ADI, there is desire to have a generic admin queue not attached to device type.
> And AQ in this proposal exactly serves this purpose.
>
> Device configuring its own IMS vector vs PCI PF configuring VF's MSI-X max vector count are two different functionality.
> Both of these commands can ride on a generic queue.
> However the queue is not same, because
> PF owns its own admin queue (for vf msix config),
> VF or SF operates its own admin queue (for IMS config).


So I think in the next version we need to clarify:

1) is there a single admin virtqueue shared by all the VFs and PF

or

2) per VF/PF admin virtqueue, and how does the driver know how to find 
the corresponding admin virtqueue


>
> So a good example is,
> 1. PCI PF configures 8 MSI-X or 16 IMS vectors for the VF using PF_AQ in HV.
> 2. PCI VF when using IMS configures, IMS data, vector, mask etc using VF_AQ in GVM.
> Both the functions will have AQ feature bit set.


Where did the VF_AQ sit? I guess it belongs to the VF. But if this is 
true, don't we need some kind of address isolation like PASID?


>
> Fair enough, so we have more users of admin queue than just MSI-X config.


Well, what I really meant is that we actually have more users of IMS. 
That's is exactly what virito-mmio wants. In this case introducing admin 
queue looks too heavyweight for that.


>
>>> 2. AQ to follows IN_ORDER and INDIRECT_DESC negotiation like rest of
>>> the queues 3. Update commit log to describe why config space is not
>>> chosen (scale, on-die registers, uniform way to handle all aq cmds)
>>
>> I fail to understand the scale/registeres issues. With the one of my previous
>> proposal (device selector), technically we don't even need any config space or
>> BAR for VF or SF by multiplexing the registers for PF.
>>
> Scale issue is: when you want to create, query, manipulate hundreds of objects, having shared MMIO register or configuration register, will be too slow.


Ok, this need to be clarified in the commit log. And we need make sure 
it's not an issue that is only happen for some specific vendor. I was 
told by some DPU vendors that MMIO register is just DRAM for them.


> And additionally such register set doesn't scale to allow sharing large number of bytes as DMA cannot be done.


That's true.


>
>  From physical device perspective, it doesn’t scale because device needs to have those resources ready to answer on MMIO reads and for hundreds to thousand of devices it just cannot do it.
> This is one of the reason for birth of IMS.


IMS allows the table to be stored in the memory and cached by the device 
to have the best scalability. But I had other questions:

1) if we have a single admin virtqueue, there will still be contention 
in the driver side

2) if we have per vf admin virtqueue, it still doesn't scale since it 
occupies more hardware resources


>
>> I do see one advantage is that the admin virtqueue is transport independent
>> (or it could be used as a transport).
>>
> I am yet to read the transport part from [1].


Yes, the main goal is to be compatible with SIOV.

Thanks


>
>>> 4. Improve documentation around msix config to link to sriov section of virtio
>> spec
>>> 5. Describe error that if VF is bound to the device, admin commands
>> targeting VF can fail, describe this error code
>>> Did I miss anything?
>>>
>>> Yet to receive your feedback on group, if/why is it needed and, why/if it must
>> be in this proposal, what pieces prevents it do as follow-on.
>>> Cornelia, Jason,
>>> Can you please review current proposal as well before we revise v2?
>>
>> If I understand correctly, most of the features (except for the admin
>> virtqueue in_order stuffs) are not specific to the admin virtqueue. As
>> discussed in the previous versions, I still think it's better:
>>
>> 1) adding sections in the basic device facility or data structure for
>> provisioning and MSI
>> 2) introduce admin virtqueue on top as an device interface for those
>> features
>>
> I didn't follow your suggestion. Can you please explain?
> Specifically "data structure for provisioning and MSI"..


I meant:

There's a chapter "Basic Facilities of a Virtio Device", we can 
introduce the concepts there like:

1) Managed device and Management device (terminology proposed by 
Michael), and can use PF and VF as a example

2) Managed device provisioning (the data structure to specify the 
attributes of a managed device (VF))

3) MSI

And then we can introduced admin virtqueue in either

1) transport part

or

2) PCI transport

In the admin virtqueue, there will be commands to provision and 
configure MSI.


>   
>> The leaves the chance for future extensions to allow those features to
>> be used by transport specific interface which will benefit for
>>
> AQ allows communication (command, response) between driver and device in transport independent way.
> Sometimes it query/set transport specific fields like MSI-X vectors of VF.
> Sometimes device configure its on IMS interrupt.
> Something else in future.
> So it is really a generic request-response queue.


I agree, but I think we can't mandate new features to a specific transport.

Thanks


>
>> [1]
>> https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.html

