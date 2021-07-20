Return-Path: <mgurtovoy@nvidia.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <d4e7afdd-943d-73bd-3c31-c07543392819@nvidia.com>
Date: Tue, 20 Jul 2021 15:27:00 +0300
MIME-Version: 1.0
In-Reply-To: <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren
 Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 7/20/2021 6:02 AM, Jason Wang wrote:
>
> =E5=9C=A8 2021/7/19 =E4=B8=8B=E5=8D=888:43, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
>> On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
>>> =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
>>>> On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
>>>>> =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
>>>>>> On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
>>>>>>> =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
>>>>>>>> On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>>>>>>>>> =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
>>>>>>>>>> On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>>>>>>>>>>> =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
>>>>>>>>>>>> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>>>>>>>>>>>>> =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Michael S. Tsirki=
n =E5=86=99=E9=81=93:
>>>>>>>>>>>>>> On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez=20
>>>>>>>>>>>>>> Martin wrote:
>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If I und=
erstand correctly, this is all
>>>>>>>>>>>>>>>>> driven from the driver inside the guest, so for this=20
>>>>>>>>>>>>>>>>> to work
>>>>>>>>>>>>>>>>> the guest must be running and already have initialised=20
>>>>>>>>>>>>>>>>> the driver.
>>>>>>>>>>>>>>>> Yes.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> As I see it, the feature can be driven entirely by the=20
>>>>>>>>>>>>>>> VMM as long as
>>>>>>>>>>>>>>> it intercept the relevant configuration space (PCI,=20
>>>>>>>>>>>>>>> MMIO, etc) from
>>>>>>>>>>>>>>> guest's reads and writes, and present it as coherent and=20
>>>>>>>>>>>>>>> transparent
>>>>>>>>>>>>>>> for the guest. Some use cases I can imagine with a=20
>>>>>>>>>>>>>>> physical device (or
>>>>>>>>>>>>>>> vp_vpda device) with VIRTIO_F_STOP:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 1) The VMM chooses not to pass the feature flag. The=20
>>>>>>>>>>>>>>> guest cannot stop
>>>>>>>>>>>>>>> the device, so any write to this flag is an=20
>>>>>>>>>>>>>>> error/undefined.
>>>>>>>>>>>>>>> 2) The VMM passes the flag to the guest. The guest can=20
>>>>>>>>>>>>>>> stop the device.
>>>>>>>>>>>>>>> 2.1) The VMM stops the device to perform a live=20
>>>>>>>>>>>>>>> migration, and the
>>>>>>>>>>>>>>> guest does not write to STOP in any moment of the LM. It=20
>>>>>>>>>>>>>>> resets the
>>>>>>>>>>>>>>> destination device with the state, and then initializes=20
>>>>>>>>>>>>>>> the device.
>>>>>>>>>>>>>>> 2.2) The guest stops the device and, when STOP(32) is=20
>>>>>>>>>>>>>>> set, the source
>>>>>>>>>>>>>>> VMM migrates the device status. The destination VMM=20
>>>>>>>>>>>>>>> realizes the bit,
>>>>>>>>>>>>>>> so it sets the bit in the destination too after device=20
>>>>>>>>>>>>>>> initialization.
>>>>>>>>>>>>>>> 2.3) The device is not initialized by the guest so it=20
>>>>>>>>>>>>>>> doesn't matter
>>>>>>>>>>>>>>> what bit has the HW, but the VM can be migrated.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Am I missing something?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>> It's doable like this. It's all a lot of hoops to jump=20
>>>>>>>>>>>>>> through though.
>>>>>>>>>>>>>> It's also not easy for devices to implement.
>>>>>>>>>>>>> It just requires a new status bit. Anything that makes you=20
>>>>>>>>>>>>> think it's hard
>>>>>>>>>>>>> to implement?
>>>>>>>>>>>>>
>>>>>>>>>>>>> E.g for networking device, it should be sufficient to use=20
>>>>>>>>>>>>> this bit + the
>>>>>>>>>>>>> virtqueue state.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Why don't we design the feature in a way that is useable=20
>>>>>>>>>>>>>> by VMMs
>>>>>>>>>>>>>> and implementable by devices in a simple way?
>>>>>>>>>>>>> It use the common technology like register shadowing=20
>>>>>>>>>>>>> without any further
>>>>>>>>>>>>> stuffs.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Or do you have any other ideas?
>>>>>>>>>>>>>
>>>>>>>>>>>>> (I think we all know migration will be very hard if we=20
>>>>>>>>>>>>> simply pass through
>>>>>>>>>>>>> those state registers).
>>>>>>>>>>>> If an admin virtqueue is used instead of the STOP Device=20
>>>>>>>>>>>> Status field
>>>>>>>>>>>> bit then there's no need to re-read the Device Status field=20
>>>>>>>>>>>> in a loop
>>>>>>>>>>>> until the device has stopped.
>>>>>>>>>>> Probably not. Let me to clarify several points:
>>>>>>>>>>>
>>>>>>>>>>> - This proposal has nothing to do with admin virtqueue.=20
>>>>>>>>>>> Actually, admin
>>>>>>>>>>> virtqueue could be used for carrying any basic device=20
>>>>>>>>>>> facility like status
>>>>>>>>>>> bit. E.g I'm going to post patches that use admin virtqueue=20
>>>>>>>>>>> as a "transport"
>>>>>>>>>>> for device slicing at virtio level.
>>>>>>>>>>> - Even if we had introduced admin virtqueue, we still need a=20
>>>>>>>>>>> per function
>>>>>>>>>>> interface for this. This is a must for nested=20
>>>>>>>>>>> virtualization, we can't
>>>>>>>>>>> always expect things like PF can be assigned to L1 guest.
>>>>>>>>>>> - According to the proposal, there's no need for the device=20
>>>>>>>>>>> to complete all
>>>>>>>>>>> the consumed buffers, device can choose to expose those=20
>>>>>>>>>>> inflight descriptors
>>>>>>>>>>> in a device specific way and set the STOP bit. This means,=20
>>>>>>>>>>> if we have the
>>>>>>>>>>> device specific in-flight descriptor reporting facility, the=20
>>>>>>>>>>> device can
>>>>>>>>>>> almost set the STOP bit immediately.
>>>>>>>>>>> - If we don't go with the basic device facility but using=20
>>>>>>>>>>> the admin
>>>>>>>>>>> virtqueue specific method, we still need to clarify how it=20
>>>>>>>>>>> works with the
>>>>>>>>>>> device status state machine, it will be some kind of=20
>>>>>>>>>>> sub-states which looks
>>>>>>>>>>> much more complicated than the current proposal.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> When migrating a guest with many VIRTIO devices a busy=20
>>>>>>>>>>>> waiting approach
>>>>>>>>>>>> extends downtime if implemented sequentially (stopping one=20
>>>>>>>>>>>> device at a
>>>>>>>>>>>> time).
>>>>>>>>>>> Well. You need some kinds of waiting for sure, the=20
>>>>>>>>>>> device/DMA needs sometime
>>>>>>>>>>> to be stopped. The downtime is determined by a specific virtio
>>>>>>>>>>> implementation which is hard to be restricted at the spec=20
>>>>>>>>>>> level. We can
>>>>>>>>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It can be implemented con=
currently (setting the STOP=20
>>>>>>>>>>>> bit on all
>>>>>>>>>>>> devices and then looping until all their Device Status=20
>>>>>>>>>>>> fields have the
>>>>>>>>>>>> bit set), but this becomes more complex to implement.
>>>>>>>>>>> I still don't get what kind of complexity did you worry here.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> I'm a little worried about adding a new bit that requires busy
>>>>>>>>>>>> waiting...
>>>>>>>>>>> Busy wait is not something that is introduced in this patch:
>>>>>>>>>>>
>>>>>>>>>>> 4.1.4.3.2 Driver Requirements: Common configuration=20
>>>>>>>>>>> structure layout
>>>>>>>>>>>
>>>>>>>>>>> After writing 0 to device_status, the driver MUST wait for a=20
>>>>>>>>>>> read of
>>>>>>>>>>> device_status to return 0 before reinitializing the device.
>>>>>>>>>>>
>>>>>>>>>>> Since it was required for at least one transport. We need do=20
>>>>>>>>>>> something
>>>>>>>>>>> similar to when introducing basic facility.
>>>>>>>>>> Adding the STOP but as a Device Status bit is a small and=20
>>>>>>>>>> clean VIRTIO
>>>>>>>>>> spec change. I like that.
>>>>>>>>>>
>>>>>>>>>> On the other hand, devices need time to stop and that time=20
>>>>>>>>>> can be
>>>>>>>>>> unbounded. For example, software virtio-blk/scsi=20
>>>>>>>>>> implementations since
>>>>>>>>>> cannot immediately cancel in-flight I/O requests on Linux hosts.
>>>>>>>>>>
>>>>>>>>>> The natural interface for long-running operations is=20
>>>>>>>>>> virtqueue requests.
>>>>>>>>>> That's why I mentioned the alternative of using an admin=20
>>>>>>>>>> virtqueue
>>>>>>>>>> instead of a Device Status bit.
>>>>>>>>> So I'm not against the admin virtqueue. As said before, admin=20
>>>>>>>>> virtqueue
>>>>>>>>> could be used for carrying the device status bit.
>>>>>>>>>
>>>>>>>>> Send a command to set STOP status bit to admin virtqueue.=20
>>>>>>>>> Device will make
>>>>>>>>> the command buffer used after it has successfully stopped the=20
>>>>>>>>> device.
>>>>>>>>>
>>>>>>>>> AFAIK, they are not mutually exclusive, since they are trying=20
>>>>>>>>> to solve
>>>>>>>>> different problems.
>>>>>>>>>
>>>>>>>>> Device status - basic device facility
>>>>>>>>>
>>>>>>>>> Admin virtqueue - transport/device specific way to implement=20
>>>>>>>>> (part of) the
>>>>>>>>> device facility
>>>>>>>>>
>>>>>>>>>> Although you mentioned that the stopped state needs to be=20
>>>>>>>>>> reflected in
>>>>>>>>>> the Device Status field somehow, I'm not sure about that=20
>>>>>>>>>> since the
>>>>>>>>>> driver typically doesn't need to know whether the device is=20
>>>>>>>>>> being
>>>>>>>>>> migrated.
>>>>>>>>> The guest won't see the real device status bit. VMM will=20
>>>>>>>>> shadow the device
>>>>>>>>> status bit in this case.
>>>>>>>>>
>>>>>>>>> E.g with the current vhost-vDPA, vDPA behave like a vhost=20
>>>>>>>>> device, guest is
>>>>>>>>> unaware of the migration.
>>>>>>>>>
>>>>>>>>> STOP status bit is set by Qemu to real virtio hardware. But=20
>>>>>>>>> guest will only
>>>>>>>>> see the DRIVER_OK without STOP.
>>>>>>>>>
>>>>>>>>> It's not hard to implement the nested on top, see the=20
>>>>>>>>> discussion initiated
>>>>>>>>> by Eugenio about how expose VIRTIO_F_STOP to guest for nested=20
>>>>>>>>> live
>>>>>>>>> migration.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In fact, the VMM would need to hi=
de this bit and it's=20
>>>>>>>>>> safer to
>>>>>>>>>> keep it out-of-band instead of risking exposing it by accident.
>>>>>>>>> See above, VMM may choose to hide or expose the capability.=20
>>>>>>>>> It's useful for
>>>>>>>>> migrating a nested guest.
>>>>>>>>>
>>>>>>>>> If we design an interface that can be used in the nested=20
>>>>>>>>> environment, it's
>>>>>>>>> not an ideal interface.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> In addition, stateful devices need to load/save non-trivial=20
>>>>>>>>>> amounts of
>>>>>>>>>> data. They need DMA to do this efficiently, so an admin=20
>>>>>>>>>> virtqueue is a
>>>>>>>>>> good fit again.
>>>>>>>>> I don't get the point here. You still need to address the=20
>>>>>>>>> exact the similar
>>>>>>>>> issues for admin virtqueue: the unbound time in freezing the=20
>>>>>>>>> device, the
>>>>>>>>> interaction with the virtio device status state machine.
>>>>>>>> Device state state can be large so a register interface would be a
>>>>>>>> bottleneck. DMA is needed. I think a virtqueue is a good fit for
>>>>>>>> saving/loading device state.
>>>>>>> So this patch doesn't mandate a register interface, isn't it?
>>>>>> You're right, not this patch. I mentioned it because your other=20
>>>>>> patch
>>>>>> series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE")=20
>>>>>> implements
>>>>>> it a register interface.
>>>>>>
>>>>>>> And DMA
>>>>>>> doesn't means a virtqueue, it could be a transport specific method.
>>>>>> Yes, although virtqueues are a pretty good interface that works=20
>>>>>> across
>>>>>> transports (PCI/MMIO/etc) thanks to the standard vring memory=20
>>>>>> layout.
>>>>>>
>>>>>>> I think we need to start from defining the state of one specific=20
>>>>>>> device and
>>>>>>> see what is the best interface.
>>>>>> virtio-blk might be the simplest. I think virtio-net has more device
>>>>>> state and virtio-scsi is definitely more complext than virtio-blk.
>>>>>>
>>>>>> First we need agreement on whether "device state" encompasses the=20
>>>>>> full
>>>>>> state of the device or just state that is unknown to the VMM.
>>>>> I think we've discussed this in the past. It can't work since:
>>>>>
>>>>> 1) The state and its format must be clearly defined in the spec
>>>>> 2) We need to maintain migration compatibility and debug-ability
>>>> Some devices need implementation-specific state. They should still be
>>>> able to live migrate even if it means cross-implementation=20
>>>> migration and
>>>> debug-ability is not possible.
>>>
>>> I think we need to re-visit this conclusion. Migration compatibility is
>>> pretty important, especially consider the software stack has spent a=20
>>> huge
>>> mount of effort in maintaining them.
>>>
>>> Say a virtio hardware would break this, this mean we will lose all the
>>> advantages of being a standard device.
>>>
>>> If we can't do live migration among:
>>>
>>> 1) different backends, e.g migrate from virtio hardware to migrate=20
>>> software
>>> 2) different vendors
>>>
>>> We failed to say as a standard device and the customer is in fact=20
>>> locked by
>>> the vendor implicitly.
>> My virtiofs device implementation is backed by an in-memory file system.
>> The device state includes the contents of each file.
>>
>> Your virtiofs device implementation uses Linux file handles to keep
>> track of open files. The device state includes Linux file handles (but
>> not the contents of each file) so the destination host can access the
>> same files on shared storage.
>>
>> Cornelia's virtiofs device implementation is backed by an object storage
>> HTTP API. The device state includes API object IDs.
>>
>> The device state is implementation-dependent. There is no standard
>> representation and it's not possible to migrate between device
>> implementations. How are they supposed to migrate?
>
>
> So if I understand correclty, virtio-fs is not desigined to be=20
> migrate-able?
>
> (Having a check on the current virtio-fs support in qemu, it looks to=20
> me it has a migration blocker).
>
>
>>
>> This is why I think it's necessarily to allow implementation-specific
>> device state representations.
>
>
> Or you probably mean you don't support cross backend migration. This=20
> sounds like a drawback and it's actually not a standard device but a=20
> vendor/implementation specific device.
>
> It would bring a lot of troubles, not only for the implementation but=20
> for the management. Maybe we can start from adding the support of=20
> migration for some specific backend and start from there.
>
>
>>
>>>>> 3) Not a proper uAPI desgin
>>>> I never understood this argument. The Linux uAPI passes through=20
>>>> lots of
>>>> opaque data from devices to userspace. Allowing an
>>>> implementation-specific device state representation is nothing new.=20
>>>> VFIO
>>>> already does it.
>>>
>>> I think we've already had a lots of discussion for VFIO but without a
>>> conclusion. Maybe we need the verdict from Linus or Greg (not sure=20
>>> if it's
>>> too late). But that's not related to virito and this thread.
>>>
>>> What you propose here is kind of conflict with the efforts of virtio. I
>>> think we all aggree that we should define the state in the spec.=20
>>> Assuming
>>> this is correct:
>>>
>>> 1) why do we still offer opaque migration state to userspace?
>> See above. Stateful devices may require an implementation-defined device
>> state representation.
>
>
> So my point stand still, it's not a standard device if we do this.
>
>
>>
>>> 2) how can it be integrated into the current VMM (Qemu) virtio devices'
>>> migration bytes stream?
>> Opaque data like D-Bus VMState:
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fqemu=
.readthedocs.io%2Fen%2Flatest%2Finterop%2Fdbus-vmstate.html&amp;data=3D04%7=
C01%7Cmgurtovoy%40nvidia.com%7C73950d2060194ce2a43e08d94b2ae003%7C43083d157=
27340c1b7db39efd9ccc17a%7C0%7C0%7C637623469808033640%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;sdata=3D6smKOLikySbPdeQa1sbNSRdTB13p3ma09BH%2BeknXAS4%3D&amp;reserved=
=3D0=20
>>
>
>
> Actually, I meant how to keep the opaque state which is compatible=20
> with all the existing device that can do migration.
>
> E.g we want to live migration virtio-blk among any backends (from a=20
> hardware device to a software backend).

I prefer we'll handle HW to SW migration in the future.

We're still debating on other basic stuff.

>
>
>>
>>>>>> That's
>>>>>> basically the difference between the vhost/vDPA's selective=20
>>>>>> passthrough
>>>>>> approach and VFIO's full passthrough approach.
>>>>> We can't do VFIO full pasthrough for migration anyway, some kind=20
>>>>> of mdev is
>>>>> required but it's duplicated with the current vp_vdpa driver.
>>>> I'm not sure that's true. Generic VFIO PCI migration can probably be
>>>> achieved without mdev:
>>>> 1. Define a migration PCI Capability that indicates support for
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 VFIO_REGION_TYPE_MIGRATION. This allows the P=
CI device to=20
>>>> implement
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 the migration interface in hardware instead o=
f an mdev driver.
>>>
>>> So I think it still depend on the driver to implement migrate state=20
>>> which is
>>> vendor specific.
>> The current VFIO migration interface depends on a device-specific
>> software mdev driver but here I'm showing that the physical device can
>> implement the migration interface so that no device-specific driver code
>> is needed.
>
>
> This is not what I read from the patch:
>
> =C2=A0* device_state: (read/write)
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The user application writes to th=
is field to inform the=20
> vendor driver
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 about the device state =
to be transitioned to.
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The vendor driver should take the=
 necessary actions to=20
> change the
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device state. After suc=
cessful transition to a given state, the
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vendor driver should re=
turn success on write(device_state,=20
> state)
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system call. If the dev=
ice state transition fails, the=20
> vendor driver
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 should return an approp=
riate -errno for the fault condition.
>
> Vendor driver need to mediate between the uAPI and the actual device.

We're building an infrastructure for VFIO PCI devices in the last few=20
months.

It should be merged hopefully to kernel 5.15.

>
>
>>
>>> Note that it's just an uAPI definition not something defined in the PCI
>>> spec.
>> Yes, that's why I mentioned Changpeng Liu's idea to turn the uAPI into a
>> standard PCI Capability to eliminate the need for device-specific
>> drivers.
>
>
> Ok.
>
>
>>
>>> Out of curiosity, the patch is merged without any real users in the=20
>>> Linux.
>>> This is very bad since we lose the change to audit the whole design.
>> I agree. It would have helped to have a complete vision for how live
>> migration should work along with demos. I don't see any migration code
>> in samples/vfio-mdev/ :(.
>
>
> Right.

Creating a standard is not related to Linux nor VFIO.

With the proposal that I've sent, we can develop a migration driver and=20
virtio device that will support it (NVIDIA virtio-blk SNAP device).

And you can build live migration support in virtio_vdpa driver (if VDPA=20
migration protocol will be implemented).

>
>
>>>> 2. The VMM either uses the migration PCI Capability directly from
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 userspace or core VFIO PCI code advertises=20
>>>> VFIO_REGION_TYPE_MIGRATION
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 to userspace so migration can proceed in the =
same way as with
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 VFIO/mdev drivers.
>>>> 3. The PCI Capability is not passed through to the guest.
>>>
>>> This brings troubles in the nested environment.
>> It depends on the device splitting/management design. If L0 wishes to
>> let L1 manage the VFs then it would need to expose a management device.
>> Since the migration interface is generic (not device-specific) a generic
>> management device solves this for all devices.
>
>
> Right, but it's a burden to expose the management device or it may=20
> just won't work.
>
> Thanks
>
>
>>
>> Stefan
>

