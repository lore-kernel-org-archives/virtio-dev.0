Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-3-jasowang@redhat.com>
 <YOQhW9MUlv5ohe05@work-vm> <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
Date: Wed, 14 Jul 2021 18:29:28 +0800
MIME-Version: 1.0
In-Reply-To: <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/14 下午5:53, Stefan Hajnoczi 写道:
> On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>> 在 2021/7/13 下午6:00, Stefan Hajnoczi 写道:
>>> On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>>>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>>>> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/11 上午4:36, Michael S. Tsirkin 写道:
>>>>>>> On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin wrote:
>>>>>>>>>>       If I understand correctly, this is all
>>>>>>>>>> driven from the driver inside the guest, so for this to work
>>>>>>>>>> the guest must be running and already have initialised the driver.
>>>>>>>>> Yes.
>>>>>>>>>
>>>>>>>> As I see it, the feature can be driven entirely by the VMM as long as
>>>>>>>> it intercept the relevant configuration space (PCI, MMIO, etc) from
>>>>>>>> guest's reads and writes, and present it as coherent and transparent
>>>>>>>> for the guest. Some use cases I can imagine with a physical device (or
>>>>>>>> vp_vpda device) with VIRTIO_F_STOP:
>>>>>>>>
>>>>>>>> 1) The VMM chooses not to pass the feature flag. The guest cannot stop
>>>>>>>> the device, so any write to this flag is an error/undefined.
>>>>>>>> 2) The VMM passes the flag to the guest. The guest can stop the device.
>>>>>>>> 2.1) The VMM stops the device to perform a live migration, and the
>>>>>>>> guest does not write to STOP in any moment of the LM. It resets the
>>>>>>>> destination device with the state, and then initializes the device.
>>>>>>>> 2.2) The guest stops the device and, when STOP(32) is set, the source
>>>>>>>> VMM migrates the device status. The destination VMM realizes the bit,
>>>>>>>> so it sets the bit in the destination too after device initialization.
>>>>>>>> 2.3) The device is not initialized by the guest so it doesn't matter
>>>>>>>> what bit has the HW, but the VM can be migrated.
>>>>>>>>
>>>>>>>> Am I missing something?
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>> It's doable like this. It's all a lot of hoops to jump through though.
>>>>>>> It's also not easy for devices to implement.
>>>>>> It just requires a new status bit. Anything that makes you think it's hard
>>>>>> to implement?
>>>>>>
>>>>>> E.g for networking device, it should be sufficient to use this bit + the
>>>>>> virtqueue state.
>>>>>>
>>>>>>
>>>>>>> Why don't we design the feature in a way that is useable by VMMs
>>>>>>> and implementable by devices in a simple way?
>>>>>> It use the common technology like register shadowing without any further
>>>>>> stuffs.
>>>>>>
>>>>>> Or do you have any other ideas?
>>>>>>
>>>>>> (I think we all know migration will be very hard if we simply pass through
>>>>>> those state registers).
>>>>> If an admin virtqueue is used instead of the STOP Device Status field
>>>>> bit then there's no need to re-read the Device Status field in a loop
>>>>> until the device has stopped.
>>>> Probably not. Let me to clarify several points:
>>>>
>>>> - This proposal has nothing to do with admin virtqueue. Actually, admin
>>>> virtqueue could be used for carrying any basic device facility like status
>>>> bit. E.g I'm going to post patches that use admin virtqueue as a "transport"
>>>> for device slicing at virtio level.
>>>> - Even if we had introduced admin virtqueue, we still need a per function
>>>> interface for this. This is a must for nested virtualization, we can't
>>>> always expect things like PF can be assigned to L1 guest.
>>>> - According to the proposal, there's no need for the device to complete all
>>>> the consumed buffers, device can choose to expose those inflight descriptors
>>>> in a device specific way and set the STOP bit. This means, if we have the
>>>> device specific in-flight descriptor reporting facility, the device can
>>>> almost set the STOP bit immediately.
>>>> - If we don't go with the basic device facility but using the admin
>>>> virtqueue specific method, we still need to clarify how it works with the
>>>> device status state machine, it will be some kind of sub-states which looks
>>>> much more complicated than the current proposal.
>>>>
>>>>
>>>>> When migrating a guest with many VIRTIO devices a busy waiting approach
>>>>> extends downtime if implemented sequentially (stopping one device at a
>>>>> time).
>>>> Well. You need some kinds of waiting for sure, the device/DMA needs sometime
>>>> to be stopped. The downtime is determined by a specific virtio
>>>> implementation which is hard to be restricted at the spec level. We can
>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>>>
>>>>
>>>>>     It can be implemented concurrently (setting the STOP bit on all
>>>>> devices and then looping until all their Device Status fields have the
>>>>> bit set), but this becomes more complex to implement.
>>>> I still don't get what kind of complexity did you worry here.
>>>>
>>>>
>>>>> I'm a little worried about adding a new bit that requires busy
>>>>> waiting...
>>>> Busy wait is not something that is introduced in this patch:
>>>>
>>>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>>>>
>>>> After writing 0 to device_status, the driver MUST wait for a read of
>>>> device_status to return 0 before reinitializing the device.
>>>>
>>>> Since it was required for at least one transport. We need do something
>>>> similar to when introducing basic facility.
>>> Adding the STOP but as a Device Status bit is a small and clean VIRTIO
>>> spec change. I like that.
>>>
>>> On the other hand, devices need time to stop and that time can be
>>> unbounded. For example, software virtio-blk/scsi implementations since
>>> cannot immediately cancel in-flight I/O requests on Linux hosts.
>>>
>>> The natural interface for long-running operations is virtqueue requests.
>>> That's why I mentioned the alternative of using an admin virtqueue
>>> instead of a Device Status bit.
>>
>> So I'm not against the admin virtqueue. As said before, admin virtqueue
>> could be used for carrying the device status bit.
>>
>> Send a command to set STOP status bit to admin virtqueue. Device will make
>> the command buffer used after it has successfully stopped the device.
>>
>> AFAIK, they are not mutually exclusive, since they are trying to solve
>> different problems.
>>
>> Device status - basic device facility
>>
>> Admin virtqueue - transport/device specific way to implement (part of) the
>> device facility
>>
>>> Although you mentioned that the stopped state needs to be reflected in
>>> the Device Status field somehow, I'm not sure about that since the
>>> driver typically doesn't need to know whether the device is being
>>> migrated.
>>
>> The guest won't see the real device status bit. VMM will shadow the device
>> status bit in this case.
>>
>> E.g with the current vhost-vDPA, vDPA behave like a vhost device, guest is
>> unaware of the migration.
>>
>> STOP status bit is set by Qemu to real virtio hardware. But guest will only
>> see the DRIVER_OK without STOP.
>>
>> It's not hard to implement the nested on top, see the discussion initiated
>> by Eugenio about how expose VIRTIO_F_STOP to guest for nested live
>> migration.
>>
>>
>>>    In fact, the VMM would need to hide this bit and it's safer to
>>> keep it out-of-band instead of risking exposing it by accident.
>>
>> See above, VMM may choose to hide or expose the capability. It's useful for
>> migrating a nested guest.
>>
>> If we design an interface that can be used in the nested environment, it's
>> not an ideal interface.
>>
>>
>>> In addition, stateful devices need to load/save non-trivial amounts of
>>> data. They need DMA to do this efficiently, so an admin virtqueue is a
>>> good fit again.
>>
>> I don't get the point here. You still need to address the exact the similar
>> issues for admin virtqueue: the unbound time in freezing the device, the
>> interaction with the virtio device status state machine.
> Device state state can be large so a register interface would be a
> bottleneck. DMA is needed. I think a virtqueue is a good fit for
> saving/loading device state.


So this patch doesn't mandate a register interface, isn't it? And DMA 
doesn't means a virtqueue, it could be a transport specific method.

I think we need to start from defining the state of one specific device 
and see what is the best interface.

Note that software can choose to intercept all the control commands, and 
shadow them. This means the best interface could be device specific.


>
> If we're going to need it for saving/loading device state anyway, then
> that's another reason to consider using a virtqueue for stopping the
> device, saving/loading virtqueue state, etc.


It requires much more works than the simple virtqueue interface: (the 
main issues is that the function is not self-contained in a single function)

1) how to interact with the existing device status state machine?
2) how to make it work in a nested environment?
3) how to migrate the PF?
4) do we need to allow more control other than just stop/freeze the 
device in the admin virtqueue? If yes, how to handle the concurrent 
access from PF and VF?
5) how it is expected to work with non-PCI virtio device?

And as I've stated several times, virtqueue is the interface or 
transport which carries the commands for implementing specific 
semantics. It doesn't conflict with what is proposed in this patch.


>
>> And with admin virtqueue, it's actually far more complicated e.g you need to
>> define how to synchronize the concurrent access to the basic facilites.
> I'm not sure I understand? Driver complexity? Device implementation
> complexity?


See the above questions.


>
>>>    This isn't addressed in this patch series, but it's the
>>> next step and I think it's worth planning for it.
>>
>> I agree, but for admin virtqueue, it's better to use it as a full transport
>> instead of just use it for carrying part of the device basic facilities.
>> Actually, as I said, I had patches to do that. But the motivation is not for
>> live migration but for device slicing. I will post RFC before the KVM Forum
>> this year (since I'm going to talk device slicing at virtio level). It does
>> not conflict with Max's proposal, since migration part is not there.
> Great, I'm looking forward to your device slicing idea.


Thanks


>
>>> If all devices could stop very quickly and were stateless then I would
>>> agree that the STOP bit is an ideal solution.
>>
>> Note that in Max's proposal it also have something similar the "quiescence"
>> and "freezed" state. It doesn't differ from STOP bit fundamentally. As Max
>> suggested, we could introduce more status bit if necessary or even consider
>> to unify Max's proposal with mine.
>>
>>
>>> I think it will be
>>> necessary to support devices that don't behave like that, so the admin
>>> virtqueue approach seems worth exploring.
>>
>> Yes and as mentioned in another thread. I think the best way is to define
>> the device specific state first and then consider how to implement the
>> interface.
>>
>> Admin virtqueue is worth to explore but should not be the only method.
>> Device/transport are freed to implement it in many ways based on the actual
>> hardware.
> What's the advantage of this proposal compared to an admin virtqueue?


See above. They are not contradict. Admin virtqueue could be used to 
transport the basic facility that is introduced in this patch.


>   I
> see the admin virtqueue as a more general interface than this proposal
> and it can cover this use case.


Actually not, this proposal doesn't limit how it was actually 
implemented in the device or transport. So it is a much general proposal.

If you are talking about the patch of implementing it via PCI 
capability, it's just to demonstrate one of the possible implementation.

Thanks


>
> Stefan

