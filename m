Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
From: Jason Wang <jasowang@redhat.com>
References: <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
Message-ID: <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
Date: Fri, 16 Jul 2021 11:53:13 +0800
MIME-Version: 1.0
In-Reply-To: <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/16 上午10:03, Jason Wang 写道:
>
> 在 2021/7/15 下午6:01, Stefan Hajnoczi 写道:
>> On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
>>> 在 2021/7/14 下午11:07, Stefan Hajnoczi 写道:
>>>> On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
>>>>> 在 2021/7/14 下午5:53, Stefan Hajnoczi 写道:
>>>>>> On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>>>>>>> 在 2021/7/13 下午6:00, Stefan Hajnoczi 写道:
>>>>>>>> On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>>>>>>>>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>>>>>>>>> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>>>>>>>>>>> 在 2021/7/11 上午4:36, Michael S. Tsirkin 写道:
>>>>>>>>>>>> On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez 
>>>>>>>>>>>> Martin wrote:
>>>>>>>>>>>>>>>         If I understand correctly, this is all
>>>>>>>>>>>>>>> driven from the driver inside the guest, so for this to 
>>>>>>>>>>>>>>> work
>>>>>>>>>>>>>>> the guest must be running and already have initialised 
>>>>>>>>>>>>>>> the driver.
>>>>>>>>>>>>>> Yes.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> As I see it, the feature can be driven entirely by the VMM 
>>>>>>>>>>>>> as long as
>>>>>>>>>>>>> it intercept the relevant configuration space (PCI, MMIO, 
>>>>>>>>>>>>> etc) from
>>>>>>>>>>>>> guest's reads and writes, and present it as coherent and 
>>>>>>>>>>>>> transparent
>>>>>>>>>>>>> for the guest. Some use cases I can imagine with a 
>>>>>>>>>>>>> physical device (or
>>>>>>>>>>>>> vp_vpda device) with VIRTIO_F_STOP:
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1) The VMM chooses not to pass the feature flag. The guest 
>>>>>>>>>>>>> cannot stop
>>>>>>>>>>>>> the device, so any write to this flag is an error/undefined.
>>>>>>>>>>>>> 2) The VMM passes the flag to the guest. The guest can 
>>>>>>>>>>>>> stop the device.
>>>>>>>>>>>>> 2.1) The VMM stops the device to perform a live migration, 
>>>>>>>>>>>>> and the
>>>>>>>>>>>>> guest does not write to STOP in any moment of the LM. It 
>>>>>>>>>>>>> resets the
>>>>>>>>>>>>> destination device with the state, and then initializes 
>>>>>>>>>>>>> the device.
>>>>>>>>>>>>> 2.2) The guest stops the device and, when STOP(32) is set, 
>>>>>>>>>>>>> the source
>>>>>>>>>>>>> VMM migrates the device status. The destination VMM 
>>>>>>>>>>>>> realizes the bit,
>>>>>>>>>>>>> so it sets the bit in the destination too after device 
>>>>>>>>>>>>> initialization.
>>>>>>>>>>>>> 2.3) The device is not initialized by the guest so it 
>>>>>>>>>>>>> doesn't matter
>>>>>>>>>>>>> what bit has the HW, but the VM can be migrated.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Am I missing something?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>> It's doable like this. It's all a lot of hoops to jump 
>>>>>>>>>>>> through though.
>>>>>>>>>>>> It's also not easy for devices to implement.
>>>>>>>>>>> It just requires a new status bit. Anything that makes you 
>>>>>>>>>>> think it's hard
>>>>>>>>>>> to implement?
>>>>>>>>>>>
>>>>>>>>>>> E.g for networking device, it should be sufficient to use 
>>>>>>>>>>> this bit + the
>>>>>>>>>>> virtqueue state.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Why don't we design the feature in a way that is useable by 
>>>>>>>>>>>> VMMs
>>>>>>>>>>>> and implementable by devices in a simple way?
>>>>>>>>>>> It use the common technology like register shadowing without 
>>>>>>>>>>> any further
>>>>>>>>>>> stuffs.
>>>>>>>>>>>
>>>>>>>>>>> Or do you have any other ideas?
>>>>>>>>>>>
>>>>>>>>>>> (I think we all know migration will be very hard if we 
>>>>>>>>>>> simply pass through
>>>>>>>>>>> those state registers).
>>>>>>>>>> If an admin virtqueue is used instead of the STOP Device 
>>>>>>>>>> Status field
>>>>>>>>>> bit then there's no need to re-read the Device Status field 
>>>>>>>>>> in a loop
>>>>>>>>>> until the device has stopped.
>>>>>>>>> Probably not. Let me to clarify several points:
>>>>>>>>>
>>>>>>>>> - This proposal has nothing to do with admin virtqueue. 
>>>>>>>>> Actually, admin
>>>>>>>>> virtqueue could be used for carrying any basic device facility 
>>>>>>>>> like status
>>>>>>>>> bit. E.g I'm going to post patches that use admin virtqueue as 
>>>>>>>>> a "transport"
>>>>>>>>> for device slicing at virtio level.
>>>>>>>>> - Even if we had introduced admin virtqueue, we still need a 
>>>>>>>>> per function
>>>>>>>>> interface for this. This is a must for nested virtualization, 
>>>>>>>>> we can't
>>>>>>>>> always expect things like PF can be assigned to L1 guest.
>>>>>>>>> - According to the proposal, there's no need for the device to 
>>>>>>>>> complete all
>>>>>>>>> the consumed buffers, device can choose to expose those 
>>>>>>>>> inflight descriptors
>>>>>>>>> in a device specific way and set the STOP bit. This means, if 
>>>>>>>>> we have the
>>>>>>>>> device specific in-flight descriptor reporting facility, the 
>>>>>>>>> device can
>>>>>>>>> almost set the STOP bit immediately.
>>>>>>>>> - If we don't go with the basic device facility but using the 
>>>>>>>>> admin
>>>>>>>>> virtqueue specific method, we still need to clarify how it 
>>>>>>>>> works with the
>>>>>>>>> device status state machine, it will be some kind of 
>>>>>>>>> sub-states which looks
>>>>>>>>> much more complicated than the current proposal.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> When migrating a guest with many VIRTIO devices a busy 
>>>>>>>>>> waiting approach
>>>>>>>>>> extends downtime if implemented sequentially (stopping one 
>>>>>>>>>> device at a
>>>>>>>>>> time).
>>>>>>>>> Well. You need some kinds of waiting for sure, the device/DMA 
>>>>>>>>> needs sometime
>>>>>>>>> to be stopped. The downtime is determined by a specific virtio
>>>>>>>>> implementation which is hard to be restricted at the spec 
>>>>>>>>> level. We can
>>>>>>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>       It can be implemented concurrently (setting the STOP 
>>>>>>>>>> bit on all
>>>>>>>>>> devices and then looping until all their Device Status fields 
>>>>>>>>>> have the
>>>>>>>>>> bit set), but this becomes more complex to implement.
>>>>>>>>> I still don't get what kind of complexity did you worry here.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> I'm a little worried about adding a new bit that requires busy
>>>>>>>>>> waiting...
>>>>>>>>> Busy wait is not something that is introduced in this patch:
>>>>>>>>>
>>>>>>>>> 4.1.4.3.2 Driver Requirements: Common configuration structure 
>>>>>>>>> layout
>>>>>>>>>
>>>>>>>>> After writing 0 to device_status, the driver MUST wait for a 
>>>>>>>>> read of
>>>>>>>>> device_status to return 0 before reinitializing the device.
>>>>>>>>>
>>>>>>>>> Since it was required for at least one transport. We need do 
>>>>>>>>> something
>>>>>>>>> similar to when introducing basic facility.
>>>>>>>> Adding the STOP but as a Device Status bit is a small and clean 
>>>>>>>> VIRTIO
>>>>>>>> spec change. I like that.
>>>>>>>>
>>>>>>>> On the other hand, devices need time to stop and that time can be
>>>>>>>> unbounded. For example, software virtio-blk/scsi 
>>>>>>>> implementations since
>>>>>>>> cannot immediately cancel in-flight I/O requests on Linux hosts.
>>>>>>>>
>>>>>>>> The natural interface for long-running operations is virtqueue 
>>>>>>>> requests.
>>>>>>>> That's why I mentioned the alternative of using an admin virtqueue
>>>>>>>> instead of a Device Status bit.
>>>>>>> So I'm not against the admin virtqueue. As said before, admin 
>>>>>>> virtqueue
>>>>>>> could be used for carrying the device status bit.
>>>>>>>
>>>>>>> Send a command to set STOP status bit to admin virtqueue. Device 
>>>>>>> will make
>>>>>>> the command buffer used after it has successfully stopped the 
>>>>>>> device.
>>>>>>>
>>>>>>> AFAIK, they are not mutually exclusive, since they are trying to 
>>>>>>> solve
>>>>>>> different problems.
>>>>>>>
>>>>>>> Device status - basic device facility
>>>>>>>
>>>>>>> Admin virtqueue - transport/device specific way to implement 
>>>>>>> (part of) the
>>>>>>> device facility
>>>>>>>
>>>>>>>> Although you mentioned that the stopped state needs to be 
>>>>>>>> reflected in
>>>>>>>> the Device Status field somehow, I'm not sure about that since the
>>>>>>>> driver typically doesn't need to know whether the device is being
>>>>>>>> migrated.
>>>>>>> The guest won't see the real device status bit. VMM will shadow 
>>>>>>> the device
>>>>>>> status bit in this case.
>>>>>>>
>>>>>>> E.g with the current vhost-vDPA, vDPA behave like a vhost 
>>>>>>> device, guest is
>>>>>>> unaware of the migration.
>>>>>>>
>>>>>>> STOP status bit is set by Qemu to real virtio hardware. But 
>>>>>>> guest will only
>>>>>>> see the DRIVER_OK without STOP.
>>>>>>>
>>>>>>> It's not hard to implement the nested on top, see the discussion 
>>>>>>> initiated
>>>>>>> by Eugenio about how expose VIRTIO_F_STOP to guest for nested live
>>>>>>> migration.
>>>>>>>
>>>>>>>
>>>>>>>>      In fact, the VMM would need to hide this bit and it's 
>>>>>>>> safer to
>>>>>>>> keep it out-of-band instead of risking exposing it by accident.
>>>>>>> See above, VMM may choose to hide or expose the capability. It's 
>>>>>>> useful for
>>>>>>> migrating a nested guest.
>>>>>>>
>>>>>>> If we design an interface that can be used in the nested 
>>>>>>> environment, it's
>>>>>>> not an ideal interface.
>>>>>>>
>>>>>>>
>>>>>>>> In addition, stateful devices need to load/save non-trivial 
>>>>>>>> amounts of
>>>>>>>> data. They need DMA to do this efficiently, so an admin 
>>>>>>>> virtqueue is a
>>>>>>>> good fit again.
>>>>>>> I don't get the point here. You still need to address the exact 
>>>>>>> the similar
>>>>>>> issues for admin virtqueue: the unbound time in freezing the 
>>>>>>> device, the
>>>>>>> interaction with the virtio device status state machine.
>>>>>> Device state state can be large so a register interface would be a
>>>>>> bottleneck. DMA is needed. I think a virtqueue is a good fit for
>>>>>> saving/loading device state.
>>>>> So this patch doesn't mandate a register interface, isn't it?
>>>> You're right, not this patch. I mentioned it because your other patch
>>>> series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE") 
>>>> implements
>>>> it a register interface.
>>>>
>>>>> And DMA
>>>>> doesn't means a virtqueue, it could be a transport specific method.
>>>> Yes, although virtqueues are a pretty good interface that works across
>>>> transports (PCI/MMIO/etc) thanks to the standard vring memory layout.
>>>>
>>>>> I think we need to start from defining the state of one specific 
>>>>> device and
>>>>> see what is the best interface.
>>>> virtio-blk might be the simplest. I think virtio-net has more device
>>>> state and virtio-scsi is definitely more complext than virtio-blk.
>>>>
>>>> First we need agreement on whether "device state" encompasses the full
>>>> state of the device or just state that is unknown to the VMM.
>>>
>>> I think we've discussed this in the past. It can't work since:
>>>
>>> 1) The state and its format must be clearly defined in the spec
>>> 2) We need to maintain migration compatibility and debug-ability
>> Some devices need implementation-specific state. They should still be
>> able to live migrate even if it means cross-implementation migration and
>> debug-ability is not possible.
>
>
> I think we need to re-visit this conclusion. Migration compatibility 
> is pretty important, especially consider the software stack has spent 
> a huge mount of effort in maintaining them.
>
> Say a virtio hardware would break this, this mean we will lose all the 
> advantages of being a standard device.
>
> If we can't do live migration among:
>
> 1) different backends, e.g migrate from virtio hardware to migrate 
> software
> 2) different vendors
>
> We failed to say as a standard device and the customer is in fact 
> locked by the vendor implicitly.
>
>
>>
>>> 3) Not a proper uAPI desgin
>> I never understood this argument. The Linux uAPI passes through lots of
>> opaque data from devices to userspace. Allowing an
>> implementation-specific device state representation is nothing new. VFIO
>> already does it.
>
>
> I think we've already had a lots of discussion for VFIO but without a 
> conclusion. Maybe we need the verdict from Linus or Greg (not sure if 
> it's too late). But that's not related to virito and this thread.
>
> What you propose here is kind of conflict with the efforts of virtio. 
> I think we all aggree that we should define the state in the spec. 
> Assuming this is correct:
>
> 1) why do we still offer opaque migration state to userspace?
> 2) how can it be integrated into the current VMM (Qemu) virtio 
> devices' migration bytes stream?
>
> We should standardize everything that is visible by the driver to be a 
> standard device. That's the power of virtio.
>
>
>>
>>>
>>>> That's
>>>> basically the difference between the vhost/vDPA's selective 
>>>> passthrough
>>>> approach and VFIO's full passthrough approach.
>>>
>>> We can't do VFIO full pasthrough for migration anyway, some kind of 
>>> mdev is
>>> required but it's duplicated with the current vp_vdpa driver.
>> I'm not sure that's true. Generic VFIO PCI migration can probably be
>> achieved without mdev:
>> 1. Define a migration PCI Capability that indicates support for
>>     VFIO_REGION_TYPE_MIGRATION. This allows the PCI device to implement
>>     the migration interface in hardware instead of an mdev driver.
>
>
> So I think it still depend on the driver to implement migrate state 
> which is vendor specific.
>
> Note that it's just an uAPI definition not something defined in the 
> PCI spec.
>
> Out of curiosity, the patch is merged without any real users in the 
> Linux. This is very bad since we lose the change to audit the whole 
> design.
>
>
>> 2. The VMM either uses the migration PCI Capability directly from
>>     userspace or core VFIO PCI code advertises 
>> VFIO_REGION_TYPE_MIGRATION
>>     to userspace so migration can proceed in the same way as with
>>     VFIO/mdev drivers.
>> 3. The PCI Capability is not passed through to the guest.
>
>
> This brings troubles in the nested environment.
>
> Thanks
>
>
>>
>> Changpeng Liu originally mentioned the idea of defining a migration PCI
>> Capability.
>>
>>>>    For example, some of the
>>>> virtio-net state is available to the VMM with vhost/vDPA because it
>>>> intercepts the virtio-net control virtqueue.
>>>>
>>>> Also, we need to decide to what degree the device state representation
>>>> is standardized in the VIRTIO specification.
>>>
>>> I think all the states must be defined in the spec otherwise the device
>>> can't claim it supports migration at virtio level.
>>>
>>>
>>>>    I think it makes sense to
>>>> standardize it if it's possible to convey all necessary state and 
>>>> device
>>>> implementors can easily implement this device state representation.
>>>
>>> I doubt it's high device specific. E.g can we standardize device(GPU)
>>> memory?
>> For devices that have little internal state it's possible to define a
>> standard device state representation.
>>
>> For other devices, like virtio-crypto, virtio-fs, etc it becomes
>> difficult because the device implementation contains state that will be
>> needed but is very specific to the implementation. These devices *are*
>> migratable but they don't have standard state. Even here there is a
>> spectrum:
>> - Host OS-specific state (e.g. Linux struct file_handles)
>> - Library-specific state (e.g. crypto library state)
>> - Implementation-specific state (e.g. sshfs inode state for virtio-fs)
>>
>> This is why I think it's necessary to support both standard device state
>> representations and implementation-specific device state
>> representations.


Having two ways will bring extra complexity. That why I suggest:

- to have general facility for the virtuqueue to be migrated
- leave the device specific state to be device specific. so device can 
choose what is convenient way or interface.

Thanks


>>
>>>> If
>>>> not, then device implementation-specific device state would be needed.
>>>
>>> Yes.
>>>
>>>
>>>> I think that's a larger discussion that deserves its own email thread.
>>>
>>> I agree, but it doesn't prevent us from starting from simple device 
>>> that
>>> virtqueue state is sufficient (e.g virtio-net).
>> Right, stateless devices don't need to save/load device state, at least
>> when virtqueues are passed through selectively instead of full
>> passsthrough.
>>
>> Stefan

