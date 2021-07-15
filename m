Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
Date: Thu, 15 Jul 2021 09:35:13 +0800
MIME-Version: 1.0
In-Reply-To: <YO79tuI72kTEWURN@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/14 下午11:07, Stefan Hajnoczi 写道:
> On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
>> 在 2021/7/14 下午5:53, Stefan Hajnoczi 写道:
>>> On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>>>> 在 2021/7/13 下午6:00, Stefan Hajnoczi 写道:
>>>>> On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>>>>>> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>>>>>>>> 在 2021/7/11 上午4:36, Michael S. Tsirkin 写道:
>>>>>>>>> On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin wrote:
>>>>>>>>>>>>        If I understand correctly, this is all
>>>>>>>>>>>> driven from the driver inside the guest, so for this to work
>>>>>>>>>>>> the guest must be running and already have initialised the driver.
>>>>>>>>>>> Yes.
>>>>>>>>>>>
>>>>>>>>>> As I see it, the feature can be driven entirely by the VMM as long as
>>>>>>>>>> it intercept the relevant configuration space (PCI, MMIO, etc) from
>>>>>>>>>> guest's reads and writes, and present it as coherent and transparent
>>>>>>>>>> for the guest. Some use cases I can imagine with a physical device (or
>>>>>>>>>> vp_vpda device) with VIRTIO_F_STOP:
>>>>>>>>>>
>>>>>>>>>> 1) The VMM chooses not to pass the feature flag. The guest cannot stop
>>>>>>>>>> the device, so any write to this flag is an error/undefined.
>>>>>>>>>> 2) The VMM passes the flag to the guest. The guest can stop the device.
>>>>>>>>>> 2.1) The VMM stops the device to perform a live migration, and the
>>>>>>>>>> guest does not write to STOP in any moment of the LM. It resets the
>>>>>>>>>> destination device with the state, and then initializes the device.
>>>>>>>>>> 2.2) The guest stops the device and, when STOP(32) is set, the source
>>>>>>>>>> VMM migrates the device status. The destination VMM realizes the bit,
>>>>>>>>>> so it sets the bit in the destination too after device initialization.
>>>>>>>>>> 2.3) The device is not initialized by the guest so it doesn't matter
>>>>>>>>>> what bit has the HW, but the VM can be migrated.
>>>>>>>>>>
>>>>>>>>>> Am I missing something?
>>>>>>>>>>
>>>>>>>>>> Thanks!
>>>>>>>>> It's doable like this. It's all a lot of hoops to jump through though.
>>>>>>>>> It's also not easy for devices to implement.
>>>>>>>> It just requires a new status bit. Anything that makes you think it's hard
>>>>>>>> to implement?
>>>>>>>>
>>>>>>>> E.g for networking device, it should be sufficient to use this bit + the
>>>>>>>> virtqueue state.
>>>>>>>>
>>>>>>>>
>>>>>>>>> Why don't we design the feature in a way that is useable by VMMs
>>>>>>>>> and implementable by devices in a simple way?
>>>>>>>> It use the common technology like register shadowing without any further
>>>>>>>> stuffs.
>>>>>>>>
>>>>>>>> Or do you have any other ideas?
>>>>>>>>
>>>>>>>> (I think we all know migration will be very hard if we simply pass through
>>>>>>>> those state registers).
>>>>>>> If an admin virtqueue is used instead of the STOP Device Status field
>>>>>>> bit then there's no need to re-read the Device Status field in a loop
>>>>>>> until the device has stopped.
>>>>>> Probably not. Let me to clarify several points:
>>>>>>
>>>>>> - This proposal has nothing to do with admin virtqueue. Actually, admin
>>>>>> virtqueue could be used for carrying any basic device facility like status
>>>>>> bit. E.g I'm going to post patches that use admin virtqueue as a "transport"
>>>>>> for device slicing at virtio level.
>>>>>> - Even if we had introduced admin virtqueue, we still need a per function
>>>>>> interface for this. This is a must for nested virtualization, we can't
>>>>>> always expect things like PF can be assigned to L1 guest.
>>>>>> - According to the proposal, there's no need for the device to complete all
>>>>>> the consumed buffers, device can choose to expose those inflight descriptors
>>>>>> in a device specific way and set the STOP bit. This means, if we have the
>>>>>> device specific in-flight descriptor reporting facility, the device can
>>>>>> almost set the STOP bit immediately.
>>>>>> - If we don't go with the basic device facility but using the admin
>>>>>> virtqueue specific method, we still need to clarify how it works with the
>>>>>> device status state machine, it will be some kind of sub-states which looks
>>>>>> much more complicated than the current proposal.
>>>>>>
>>>>>>
>>>>>>> When migrating a guest with many VIRTIO devices a busy waiting approach
>>>>>>> extends downtime if implemented sequentially (stopping one device at a
>>>>>>> time).
>>>>>> Well. You need some kinds of waiting for sure, the device/DMA needs sometime
>>>>>> to be stopped. The downtime is determined by a specific virtio
>>>>>> implementation which is hard to be restricted at the spec level. We can
>>>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>>>>>
>>>>>>
>>>>>>>      It can be implemented concurrently (setting the STOP bit on all
>>>>>>> devices and then looping until all their Device Status fields have the
>>>>>>> bit set), but this becomes more complex to implement.
>>>>>> I still don't get what kind of complexity did you worry here.
>>>>>>
>>>>>>
>>>>>>> I'm a little worried about adding a new bit that requires busy
>>>>>>> waiting...
>>>>>> Busy wait is not something that is introduced in this patch:
>>>>>>
>>>>>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>>>>>>
>>>>>> After writing 0 to device_status, the driver MUST wait for a read of
>>>>>> device_status to return 0 before reinitializing the device.
>>>>>>
>>>>>> Since it was required for at least one transport. We need do something
>>>>>> similar to when introducing basic facility.
>>>>> Adding the STOP but as a Device Status bit is a small and clean VIRTIO
>>>>> spec change. I like that.
>>>>>
>>>>> On the other hand, devices need time to stop and that time can be
>>>>> unbounded. For example, software virtio-blk/scsi implementations since
>>>>> cannot immediately cancel in-flight I/O requests on Linux hosts.
>>>>>
>>>>> The natural interface for long-running operations is virtqueue requests.
>>>>> That's why I mentioned the alternative of using an admin virtqueue
>>>>> instead of a Device Status bit.
>>>> So I'm not against the admin virtqueue. As said before, admin virtqueue
>>>> could be used for carrying the device status bit.
>>>>
>>>> Send a command to set STOP status bit to admin virtqueue. Device will make
>>>> the command buffer used after it has successfully stopped the device.
>>>>
>>>> AFAIK, they are not mutually exclusive, since they are trying to solve
>>>> different problems.
>>>>
>>>> Device status - basic device facility
>>>>
>>>> Admin virtqueue - transport/device specific way to implement (part of) the
>>>> device facility
>>>>
>>>>> Although you mentioned that the stopped state needs to be reflected in
>>>>> the Device Status field somehow, I'm not sure about that since the
>>>>> driver typically doesn't need to know whether the device is being
>>>>> migrated.
>>>> The guest won't see the real device status bit. VMM will shadow the device
>>>> status bit in this case.
>>>>
>>>> E.g with the current vhost-vDPA, vDPA behave like a vhost device, guest is
>>>> unaware of the migration.
>>>>
>>>> STOP status bit is set by Qemu to real virtio hardware. But guest will only
>>>> see the DRIVER_OK without STOP.
>>>>
>>>> It's not hard to implement the nested on top, see the discussion initiated
>>>> by Eugenio about how expose VIRTIO_F_STOP to guest for nested live
>>>> migration.
>>>>
>>>>
>>>>>     In fact, the VMM would need to hide this bit and it's safer to
>>>>> keep it out-of-band instead of risking exposing it by accident.
>>>> See above, VMM may choose to hide or expose the capability. It's useful for
>>>> migrating a nested guest.
>>>>
>>>> If we design an interface that can be used in the nested environment, it's
>>>> not an ideal interface.
>>>>
>>>>
>>>>> In addition, stateful devices need to load/save non-trivial amounts of
>>>>> data. They need DMA to do this efficiently, so an admin virtqueue is a
>>>>> good fit again.
>>>> I don't get the point here. You still need to address the exact the similar
>>>> issues for admin virtqueue: the unbound time in freezing the device, the
>>>> interaction with the virtio device status state machine.
>>> Device state state can be large so a register interface would be a
>>> bottleneck. DMA is needed. I think a virtqueue is a good fit for
>>> saving/loading device state.
>>
>> So this patch doesn't mandate a register interface, isn't it?
> You're right, not this patch. I mentioned it because your other patch
> series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE") implements
> it a register interface.
>
>> And DMA
>> doesn't means a virtqueue, it could be a transport specific method.
> Yes, although virtqueues are a pretty good interface that works across
> transports (PCI/MMIO/etc) thanks to the standard vring memory layout.
>
>> I think we need to start from defining the state of one specific device and
>> see what is the best interface.
> virtio-blk might be the simplest. I think virtio-net has more device
> state and virtio-scsi is definitely more complext than virtio-blk.
>
> First we need agreement on whether "device state" encompasses the full
> state of the device or just state that is unknown to the VMM.


I think we've discussed this in the past. It can't work since:

1) The state and its format must be clearly defined in the spec
2) We need to maintain migration compatibility and debug-ability
3) Not a proper uAPI desgin


> That's
> basically the difference between the vhost/vDPA's selective passthrough
> approach and VFIO's full passthrough approach.


We can't do VFIO full pasthrough for migration anyway, some kind of mdev 
is required but it's duplicated with the current vp_vdpa driver.


>   For example, some of the
> virtio-net state is available to the VMM with vhost/vDPA because it
> intercepts the virtio-net control virtqueue.
>
> Also, we need to decide to what degree the device state representation
> is standardized in the VIRTIO specification.


I think all the states must be defined in the spec otherwise the device 
can't claim it supports migration at virtio level.


>   I think it makes sense to
> standardize it if it's possible to convey all necessary state and device
> implementors can easily implement this device state representation.


I doubt it's high device specific. E.g can we standardize device(GPU) 
memory?


> If
> not, then device implementation-specific device state would be needed.


Yes.


>
> I think that's a larger discussion that deserves its own email thread.


I agree, but it doesn't prevent us from starting from simple device that 
virtqueue state is sufficient (e.g virtio-net).


>
>> Note that software can choose to intercept all the control commands, and
>> shadow them. This means the best interface could be device specific.
>>
>>
>>> If we're going to need it for saving/loading device state anyway, then
>>> that's another reason to consider using a virtqueue for stopping the
>>> device, saving/loading virtqueue state, etc.
>>
>> It requires much more works than the simple virtqueue interface: (the main
>> issues is that the function is not self-contained in a single function)
>>
>> 1) how to interact with the existing device status state machine?
>> 2) how to make it work in a nested environment?
>> 3) how to migrate the PF?
>> 4) do we need to allow more control other than just stop/freeze the device
>> in the admin virtqueue? If yes, how to handle the concurrent access from PF
>> and VF?
>> 5) how it is expected to work with non-PCI virtio device?
> I guess your device splitting proposal addresses some of these things?


Note that the device facility doesn't limit how it is used. So the 
difference is per-function(VF) interface vs PF interface.

Per-function interface is self contained so it can address all the above 
issues:

1) STOP is the part of the device status state machine
2) it's self contained in the function, so it works in the nested 
environment by simply assign the function without any other dependency
3) for PF, those function is still self-contained, so it can be migrated
4) the problem doesn't exist since we have a single control path
5) non PCI device is freed to implement their own per device interface

And actually, the per function interface has already been done by some 
vendors.


>
> Max probably has the most to say about these points.
>
> If you want more input I can try to answer too, but I personally am not
> developing devices that need this right now, so I might not be the best
> person to propose solutions.


I think for us we should make sure the architecture is good enough to be 
not limited to any specific use cases.


>
>> And as I've stated several times, virtqueue is the interface or transport
>> which carries the commands for implementing specific semantics. It doesn't
>> conflict with what is proposed in this patch.
> The abstract operations for stopping the device and fetching virtqueue
> state sound good to me, but I don't think a Device Status field STOP bit
> should be added. An out-of-band stop operation would support devices
> that take a long time to stop better.


So the long time request is not something that is introduced by the STOP 
bit. Spec already use that for reset.

Thanks


>
> Stefan

