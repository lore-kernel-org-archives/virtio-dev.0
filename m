Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
 <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
Date: Thu, 22 Jul 2021 21:08:58 +0800
MIME-Version: 1.0
In-Reply-To: <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/22 下午6:24, Stefan Hajnoczi 写道:
> On Thu, Jul 22, 2021 at 03:33:10PM +0800, Jason Wang wrote:
>> 在 2021/7/21 下午6:20, Stefan Hajnoczi 写道:
>>> On Wed, Jul 21, 2021 at 10:29:17AM +0800, Jason Wang wrote:
>>>> 在 2021/7/20 下午4:50, Stefan Hajnoczi 写道:
>>>>> On Tue, Jul 20, 2021 at 11:04:55AM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/19 下午8:45, Stefan Hajnoczi 写道:
>>>>>>> On Fri, Jul 16, 2021 at 11:53:13AM +0800, Jason Wang wrote:
>>>>>>>> 在 2021/7/16 上午10:03, Jason Wang 写道:
>>>>>>>>> 在 2021/7/15 下午6:01, Stefan Hajnoczi 写道:
>>>>>>>>>> On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
>>>>>>>>>>> 在 2021/7/14 下午11:07, Stefan Hajnoczi 写道:
>>>>>>>>>>>> On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
>>>>>>>>>>>>> 在 2021/7/14 下午5:53, Stefan Hajnoczi 写道:
>>>>>>>>>>>>>> On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>>>>>>>>>>>>>>> 在 2021/7/13 下午6:00, Stefan Hajnoczi 写道:
>>>>>>>>>>>>>>>> On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>>>>>>>>>>>>>>>>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>>>>>>>>>>>>>>>>> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>>>>>>>>>>>>>>>>>>> 在 2021/7/11 上午4:36, Michael S. Tsirkin 写道:
>>>>>>>>>>>>>>>>>>>> On Fri, Jul 09, 2021 at
>>>>>>>>>>>>>>>>>>>> 07:23:33PM +0200, Eugenio
>>>>>>>>>>>>>>>>>>>> Perez Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>             If I understand correctly, this is all
>>>>>>>>>>>>>>>>>>>>>>> driven from the
>>>>>>>>>>>>>>>>>>>>>>> driver inside
>>>>>>>>>>>>>>>>>>>>>>> the guest, so
>>>>>>>>>>>>>>>>>>>>>>> for this to work
>>>>>>>>>>>>>>>>>>>>>>> the guest must
>>>>>>>>>>>>>>>>>>>>>>> be running and
>>>>>>>>>>>>>>>>>>>>>>> already have
>>>>>>>>>>>>>>>>>>>>>>> initialised the
>>>>>>>>>>>>>>>>>>>>>>> driver.
>>>>>>>>>>>>>>>>>>>>>> Yes.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> As I see it, the feature
>>>>>>>>>>>>>>>>>>>>> can be driven entirely
>>>>>>>>>>>>>>>>>>>>> by the VMM as long as
>>>>>>>>>>>>>>>>>>>>> it intercept the
>>>>>>>>>>>>>>>>>>>>> relevant configuration
>>>>>>>>>>>>>>>>>>>>> space (PCI, MMIO, etc)
>>>>>>>>>>>>>>>>>>>>> from
>>>>>>>>>>>>>>>>>>>>> guest's reads and
>>>>>>>>>>>>>>>>>>>>> writes, and present it
>>>>>>>>>>>>>>>>>>>>> as coherent and
>>>>>>>>>>>>>>>>>>>>> transparent
>>>>>>>>>>>>>>>>>>>>> for the guest. Some use
>>>>>>>>>>>>>>>>>>>>> cases I can imagine with
>>>>>>>>>>>>>>>>>>>>> a physical device (or
>>>>>>>>>>>>>>>>>>>>> vp_vpda device) with VIRTIO_F_STOP:
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> 1) The VMM chooses not
>>>>>>>>>>>>>>>>>>>>> to pass the feature
>>>>>>>>>>>>>>>>>>>>> flag. The guest cannot
>>>>>>>>>>>>>>>>>>>>> stop
>>>>>>>>>>>>>>>>>>>>> the device, so any write to this flag is an error/undefined.
>>>>>>>>>>>>>>>>>>>>> 2) The VMM passes the
>>>>>>>>>>>>>>>>>>>>> flag to the guest. The
>>>>>>>>>>>>>>>>>>>>> guest can stop the
>>>>>>>>>>>>>>>>>>>>> device.
>>>>>>>>>>>>>>>>>>>>> 2.1) The VMM stops the
>>>>>>>>>>>>>>>>>>>>> device to perform a live
>>>>>>>>>>>>>>>>>>>>> migration, and the
>>>>>>>>>>>>>>>>>>>>> guest does not write to
>>>>>>>>>>>>>>>>>>>>> STOP in any moment of
>>>>>>>>>>>>>>>>>>>>> the LM. It resets the
>>>>>>>>>>>>>>>>>>>>> destination device with
>>>>>>>>>>>>>>>>>>>>> the state, and then
>>>>>>>>>>>>>>>>>>>>> initializes the device.
>>>>>>>>>>>>>>>>>>>>> 2.2) The guest stops the
>>>>>>>>>>>>>>>>>>>>> device and, when
>>>>>>>>>>>>>>>>>>>>> STOP(32) is set, the
>>>>>>>>>>>>>>>>>>>>> source
>>>>>>>>>>>>>>>>>>>>> VMM migrates the device
>>>>>>>>>>>>>>>>>>>>> status. The destination
>>>>>>>>>>>>>>>>>>>>> VMM realizes the bit,
>>>>>>>>>>>>>>>>>>>>> so it sets the bit in
>>>>>>>>>>>>>>>>>>>>> the destination too
>>>>>>>>>>>>>>>>>>>>> after device
>>>>>>>>>>>>>>>>>>>>> initialization.
>>>>>>>>>>>>>>>>>>>>> 2.3) The device is not
>>>>>>>>>>>>>>>>>>>>> initialized by the guest
>>>>>>>>>>>>>>>>>>>>> so it doesn't matter
>>>>>>>>>>>>>>>>>>>>> what bit has the HW, but the VM can be migrated.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Am I missing something?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>>>>>> It's doable like this. It's
>>>>>>>>>>>>>>>>>>>> all a lot of hoops to jump
>>>>>>>>>>>>>>>>>>>> through though.
>>>>>>>>>>>>>>>>>>>> It's also not easy for devices to implement.
>>>>>>>>>>>>>>>>>>> It just requires a new status
>>>>>>>>>>>>>>>>>>> bit. Anything that makes you
>>>>>>>>>>>>>>>>>>> think it's hard
>>>>>>>>>>>>>>>>>>> to implement?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> E.g for networking device, it
>>>>>>>>>>>>>>>>>>> should be sufficient to use this
>>>>>>>>>>>>>>>>>>> bit + the
>>>>>>>>>>>>>>>>>>> virtqueue state.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Why don't we design the
>>>>>>>>>>>>>>>>>>>> feature in a way that is
>>>>>>>>>>>>>>>>>>>> useable by VMMs
>>>>>>>>>>>>>>>>>>>> and implementable by devices in a simple way?
>>>>>>>>>>>>>>>>>>> It use the common technology
>>>>>>>>>>>>>>>>>>> like register shadowing without
>>>>>>>>>>>>>>>>>>> any further
>>>>>>>>>>>>>>>>>>> stuffs.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Or do you have any other ideas?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> (I think we all know migration
>>>>>>>>>>>>>>>>>>> will be very hard if we simply
>>>>>>>>>>>>>>>>>>> pass through
>>>>>>>>>>>>>>>>>>> those state registers).
>>>>>>>>>>>>>>>>>> If an admin virtqueue is used
>>>>>>>>>>>>>>>>>> instead of the STOP Device Status
>>>>>>>>>>>>>>>>>> field
>>>>>>>>>>>>>>>>>> bit then there's no need to re-read
>>>>>>>>>>>>>>>>>> the Device Status field in a loop
>>>>>>>>>>>>>>>>>> until the device has stopped.
>>>>>>>>>>>>>>>>> Probably not. Let me to clarify several points:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> - This proposal has nothing to do with
>>>>>>>>>>>>>>>>> admin virtqueue. Actually, admin
>>>>>>>>>>>>>>>>> virtqueue could be used for carrying any
>>>>>>>>>>>>>>>>> basic device facility like status
>>>>>>>>>>>>>>>>> bit. E.g I'm going to post patches that
>>>>>>>>>>>>>>>>> use admin virtqueue as a "transport"
>>>>>>>>>>>>>>>>> for device slicing at virtio level.
>>>>>>>>>>>>>>>>> - Even if we had introduced admin
>>>>>>>>>>>>>>>>> virtqueue, we still need a per function
>>>>>>>>>>>>>>>>> interface for this. This is a must for
>>>>>>>>>>>>>>>>> nested virtualization, we can't
>>>>>>>>>>>>>>>>> always expect things like PF can be assigned to L1 guest.
>>>>>>>>>>>>>>>>> - According to the proposal, there's no
>>>>>>>>>>>>>>>>> need for the device to complete all
>>>>>>>>>>>>>>>>> the consumed buffers, device can choose
>>>>>>>>>>>>>>>>> to expose those inflight descriptors
>>>>>>>>>>>>>>>>> in a device specific way and set the
>>>>>>>>>>>>>>>>> STOP bit. This means, if we have the
>>>>>>>>>>>>>>>>> device specific in-flight descriptor
>>>>>>>>>>>>>>>>> reporting facility, the device can
>>>>>>>>>>>>>>>>> almost set the STOP bit immediately.
>>>>>>>>>>>>>>>>> - If we don't go with the basic device
>>>>>>>>>>>>>>>>> facility but using the admin
>>>>>>>>>>>>>>>>> virtqueue specific method, we still need
>>>>>>>>>>>>>>>>> to clarify how it works with the
>>>>>>>>>>>>>>>>> device status state machine, it will be
>>>>>>>>>>>>>>>>> some kind of sub-states which looks
>>>>>>>>>>>>>>>>> much more complicated than the current proposal.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> When migrating a guest with many
>>>>>>>>>>>>>>>>>> VIRTIO devices a busy waiting
>>>>>>>>>>>>>>>>>> approach
>>>>>>>>>>>>>>>>>> extends downtime if implemented
>>>>>>>>>>>>>>>>>> sequentially (stopping one device at
>>>>>>>>>>>>>>>>>> a
>>>>>>>>>>>>>>>>>> time).
>>>>>>>>>>>>>>>>> Well. You need some kinds of waiting for
>>>>>>>>>>>>>>>>> sure, the device/DMA needs sometime
>>>>>>>>>>>>>>>>> to be stopped. The downtime is determined by a specific virtio
>>>>>>>>>>>>>>>>> implementation which is hard to be
>>>>>>>>>>>>>>>>> restricted at the spec level. We can
>>>>>>>>>>>>>>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>           It can be implemented
>>>>>>>>>>>>>>>>>> concurrently (setting the STOP bit
>>>>>>>>>>>>>>>>>> on all
>>>>>>>>>>>>>>>>>> devices and then looping until all
>>>>>>>>>>>>>>>>>> their Device Status fields have the
>>>>>>>>>>>>>>>>>> bit set), but this becomes more complex to implement.
>>>>>>>>>>>>>>>>> I still don't get what kind of complexity did you worry here.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I'm a little worried about adding a new bit that requires busy
>>>>>>>>>>>>>>>>>> waiting...
>>>>>>>>>>>>>>>>> Busy wait is not something that is introduced in this patch:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> 4.1.4.3.2 Driver Requirements: Common
>>>>>>>>>>>>>>>>> configuration structure layout
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> After writing 0 to device_status, the
>>>>>>>>>>>>>>>>> driver MUST wait for a read of
>>>>>>>>>>>>>>>>> device_status to return 0 before reinitializing the device.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Since it was required for at least one
>>>>>>>>>>>>>>>>> transport. We need do something
>>>>>>>>>>>>>>>>> similar to when introducing basic facility.
>>>>>>>>>>>>>>>> Adding the STOP but as a Device Status bit
>>>>>>>>>>>>>>>> is a small and clean VIRTIO
>>>>>>>>>>>>>>>> spec change. I like that.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On the other hand, devices need time to stop and that time can be
>>>>>>>>>>>>>>>> unbounded. For example, software
>>>>>>>>>>>>>>>> virtio-blk/scsi implementations since
>>>>>>>>>>>>>>>> cannot immediately cancel in-flight I/O requests on Linux hosts.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The natural interface for long-running
>>>>>>>>>>>>>>>> operations is virtqueue requests.
>>>>>>>>>>>>>>>> That's why I mentioned the alternative of using an admin virtqueue
>>>>>>>>>>>>>>>> instead of a Device Status bit.
>>>>>>>>>>>>>>> So I'm not against the admin virtqueue. As said
>>>>>>>>>>>>>>> before, admin virtqueue
>>>>>>>>>>>>>>> could be used for carrying the device status bit.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Send a command to set STOP status bit to admin
>>>>>>>>>>>>>>> virtqueue. Device will make
>>>>>>>>>>>>>>> the command buffer used after it has
>>>>>>>>>>>>>>> successfully stopped the device.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> AFAIK, they are not mutually exclusive, since
>>>>>>>>>>>>>>> they are trying to solve
>>>>>>>>>>>>>>> different problems.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Device status - basic device facility
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Admin virtqueue - transport/device specific way
>>>>>>>>>>>>>>> to implement (part of) the
>>>>>>>>>>>>>>> device facility
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Although you mentioned that the stopped
>>>>>>>>>>>>>>>> state needs to be reflected in
>>>>>>>>>>>>>>>> the Device Status field somehow, I'm not sure about that since the
>>>>>>>>>>>>>>>> driver typically doesn't need to know whether the device is being
>>>>>>>>>>>>>>>> migrated.
>>>>>>>>>>>>>>> The guest won't see the real device status bit.
>>>>>>>>>>>>>>> VMM will shadow the device
>>>>>>>>>>>>>>> status bit in this case.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> E.g with the current vhost-vDPA, vDPA behave
>>>>>>>>>>>>>>> like a vhost device, guest is
>>>>>>>>>>>>>>> unaware of the migration.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> STOP status bit is set by Qemu to real virtio
>>>>>>>>>>>>>>> hardware. But guest will only
>>>>>>>>>>>>>>> see the DRIVER_OK without STOP.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> It's not hard to implement the nested on top,
>>>>>>>>>>>>>>> see the discussion initiated
>>>>>>>>>>>>>>> by Eugenio about how expose VIRTIO_F_STOP to guest for nested live
>>>>>>>>>>>>>>> migration.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>          In fact, the VMM would need to hide
>>>>>>>>>>>>>>>> this bit and it's safer to
>>>>>>>>>>>>>>>> keep it out-of-band instead of risking exposing it by accident.
>>>>>>>>>>>>>>> See above, VMM may choose to hide or expose the
>>>>>>>>>>>>>>> capability. It's useful for
>>>>>>>>>>>>>>> migrating a nested guest.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If we design an interface that can be used in
>>>>>>>>>>>>>>> the nested environment, it's
>>>>>>>>>>>>>>> not an ideal interface.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> In addition, stateful devices need to
>>>>>>>>>>>>>>>> load/save non-trivial amounts of
>>>>>>>>>>>>>>>> data. They need DMA to do this efficiently,
>>>>>>>>>>>>>>>> so an admin virtqueue is a
>>>>>>>>>>>>>>>> good fit again.
>>>>>>>>>>>>>>> I don't get the point here. You still need to
>>>>>>>>>>>>>>> address the exact the similar
>>>>>>>>>>>>>>> issues for admin virtqueue: the unbound time in
>>>>>>>>>>>>>>> freezing the device, the
>>>>>>>>>>>>>>> interaction with the virtio device status state machine.
>>>>>>>>>>>>>> Device state state can be large so a register interface would be a
>>>>>>>>>>>>>> bottleneck. DMA is needed. I think a virtqueue is a good fit for
>>>>>>>>>>>>>> saving/loading device state.
>>>>>>>>>>>>> So this patch doesn't mandate a register interface, isn't it?
>>>>>>>>>>>> You're right, not this patch. I mentioned it because your other patch
>>>>>>>>>>>> series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE")
>>>>>>>>>>>> implements
>>>>>>>>>>>> it a register interface.
>>>>>>>>>>>>
>>>>>>>>>>>>> And DMA
>>>>>>>>>>>>> doesn't means a virtqueue, it could be a transport specific method.
>>>>>>>>>>>> Yes, although virtqueues are a pretty good interface that works across
>>>>>>>>>>>> transports (PCI/MMIO/etc) thanks to the standard vring memory layout.
>>>>>>>>>>>>
>>>>>>>>>>>>> I think we need to start from defining the state of one
>>>>>>>>>>>>> specific device and
>>>>>>>>>>>>> see what is the best interface.
>>>>>>>>>>>> virtio-blk might be the simplest. I think virtio-net has more device
>>>>>>>>>>>> state and virtio-scsi is definitely more complext than virtio-blk.
>>>>>>>>>>>>
>>>>>>>>>>>> First we need agreement on whether "device state" encompasses the full
>>>>>>>>>>>> state of the device or just state that is unknown to the VMM.
>>>>>>>>>>> I think we've discussed this in the past. It can't work since:
>>>>>>>>>>>
>>>>>>>>>>> 1) The state and its format must be clearly defined in the spec
>>>>>>>>>>> 2) We need to maintain migration compatibility and debug-ability
>>>>>>>>>> Some devices need implementation-specific state. They should still be
>>>>>>>>>> able to live migrate even if it means cross-implementation migration and
>>>>>>>>>> debug-ability is not possible.
>>>>>>>>> I think we need to re-visit this conclusion. Migration compatibility is
>>>>>>>>> pretty important, especially consider the software stack has spent a
>>>>>>>>> huge mount of effort in maintaining them.
>>>>>>>>>
>>>>>>>>> Say a virtio hardware would break this, this mean we will lose all the
>>>>>>>>> advantages of being a standard device.
>>>>>>>>>
>>>>>>>>> If we can't do live migration among:
>>>>>>>>>
>>>>>>>>> 1) different backends, e.g migrate from virtio hardware to migrate
>>>>>>>>> software
>>>>>>>>> 2) different vendors
>>>>>>>>>
>>>>>>>>> We failed to say as a standard device and the customer is in fact locked
>>>>>>>>> by the vendor implicitly.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> 3) Not a proper uAPI desgin
>>>>>>>>>> I never understood this argument. The Linux uAPI passes through lots of
>>>>>>>>>> opaque data from devices to userspace. Allowing an
>>>>>>>>>> implementation-specific device state representation is nothing new. VFIO
>>>>>>>>>> already does it.
>>>>>>>>> I think we've already had a lots of discussion for VFIO but without a
>>>>>>>>> conclusion. Maybe we need the verdict from Linus or Greg (not sure if
>>>>>>>>> it's too late). But that's not related to virito and this thread.
>>>>>>>>>
>>>>>>>>> What you propose here is kind of conflict with the efforts of virtio. I
>>>>>>>>> think we all aggree that we should define the state in the spec.
>>>>>>>>> Assuming this is correct:
>>>>>>>>>
>>>>>>>>> 1) why do we still offer opaque migration state to userspace?
>>>>>>>>> 2) how can it be integrated into the current VMM (Qemu) virtio devices'
>>>>>>>>> migration bytes stream?
>>>>>>>>>
>>>>>>>>> We should standardize everything that is visible by the driver to be a
>>>>>>>>> standard device. That's the power of virtio.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>> That's
>>>>>>>>>>>> basically the difference between the vhost/vDPA's selective
>>>>>>>>>>>> passthrough
>>>>>>>>>>>> approach and VFIO's full passthrough approach.
>>>>>>>>>>> We can't do VFIO full pasthrough for migration anyway, some kind
>>>>>>>>>>> of mdev is
>>>>>>>>>>> required but it's duplicated with the current vp_vdpa driver.
>>>>>>>>>> I'm not sure that's true. Generic VFIO PCI migration can probably be
>>>>>>>>>> achieved without mdev:
>>>>>>>>>> 1. Define a migration PCI Capability that indicates support for
>>>>>>>>>>         VFIO_REGION_TYPE_MIGRATION. This allows the PCI device to implement
>>>>>>>>>>         the migration interface in hardware instead of an mdev driver.
>>>>>>>>> So I think it still depend on the driver to implement migrate state
>>>>>>>>> which is vendor specific.
>>>>>>>>>
>>>>>>>>> Note that it's just an uAPI definition not something defined in the PCI
>>>>>>>>> spec.
>>>>>>>>>
>>>>>>>>> Out of curiosity, the patch is merged without any real users in the
>>>>>>>>> Linux. This is very bad since we lose the change to audit the whole
>>>>>>>>> design.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> 2. The VMM either uses the migration PCI Capability directly from
>>>>>>>>>>         userspace or core VFIO PCI code advertises
>>>>>>>>>> VFIO_REGION_TYPE_MIGRATION
>>>>>>>>>>         to userspace so migration can proceed in the same way as with
>>>>>>>>>>         VFIO/mdev drivers.
>>>>>>>>>> 3. The PCI Capability is not passed through to the guest.
>>>>>>>>> This brings troubles in the nested environment.
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Changpeng Liu originally mentioned the idea of defining a migration PCI
>>>>>>>>>> Capability.
>>>>>>>>>>
>>>>>>>>>>>>        For example, some of the
>>>>>>>>>>>> virtio-net state is available to the VMM with vhost/vDPA because it
>>>>>>>>>>>> intercepts the virtio-net control virtqueue.
>>>>>>>>>>>>
>>>>>>>>>>>> Also, we need to decide to what degree the device state representation
>>>>>>>>>>>> is standardized in the VIRTIO specification.
>>>>>>>>>>> I think all the states must be defined in the spec otherwise the device
>>>>>>>>>>> can't claim it supports migration at virtio level.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>        I think it makes sense to
>>>>>>>>>>>> standardize it if it's possible to convey all necessary
>>>>>>>>>>>> state and device
>>>>>>>>>>>> implementors can easily implement this device state representation.
>>>>>>>>>>> I doubt it's high device specific. E.g can we standardize device(GPU)
>>>>>>>>>>> memory?
>>>>>>>>>> For devices that have little internal state it's possible to define a
>>>>>>>>>> standard device state representation.
>>>>>>>>>>
>>>>>>>>>> For other devices, like virtio-crypto, virtio-fs, etc it becomes
>>>>>>>>>> difficult because the device implementation contains state that will be
>>>>>>>>>> needed but is very specific to the implementation. These devices *are*
>>>>>>>>>> migratable but they don't have standard state. Even here there is a
>>>>>>>>>> spectrum:
>>>>>>>>>> - Host OS-specific state (e.g. Linux struct file_handles)
>>>>>>>>>> - Library-specific state (e.g. crypto library state)
>>>>>>>>>> - Implementation-specific state (e.g. sshfs inode state for virtio-fs)
>>>>>>>>>>
>>>>>>>>>> This is why I think it's necessary to support both standard device state
>>>>>>>>>> representations and implementation-specific device state
>>>>>>>>>> representations.
>>>>>>>> Having two ways will bring extra complexity. That why I suggest:
>>>>>>>>
>>>>>>>> - to have general facility for the virtuqueue to be migrated
>>>>>>>> - leave the device specific state to be device specific. so device can
>>>>>>>> choose what is convenient way or interface.
>>>>>>> I don't think we have a choice. For stateful devices it can be
>>>>>>> impossible to define a standard device state representation.
>>>>>> Let me clarify, I agree we can't have a standard device state for all kinds
>>>>>> of device.
>>>>>>
>>>>>> That's way I tend to leave them to be device specific. (but not
>>>>>> implementation specific)
>>>>> Unfortunately device state is sometimes implementation-specific. Not
>>>>> because the device is proprietary, but because the actual state is
>>>>> meaningless to other implementations.
>>>>>
>>>>> I mentioned virtiofs as an example where file system backends can be
>>>>> implemented in completely different ways so the device state cannot be
>>>>> migrated between implementations.
>>>> So let me clarify my understanding, we had two kinds of states:
>>>>
>>>> 1) implementation specific state that is not noticeable by the driver
>>>> 2) device specific state that is noticeable by the driver
>>>>
>>>> We don't have the interest in 1).
>>>>
>>>> For 2) it's what needs to be defined in the spec. If we fail to generalize
>>>> the device specific state, it can't be used by a standard virtio driver. Or
>>>> maybe you can give a concrete example on how vitio-fs fail in doing this?
>>> 2) is what I mean when I say a "stateful" device. I agree, 1) is not
>>> relevant to this discussion because we don't need to migrate internal
>>> device state that the driver cannot interact with.
>>>
>>> The virtiofs device has an OPEN request for opening a file. Live
>>> migration must transfer the list of open files from the source to the
>>> destination device so the driver can continue accessing files it
>>> previously had open.
>>>
>>> However, the result of the OPEN request is a number similar to a POSIX
>>> fd, not the full device-internal state associated with an open file.
>>> After migration the driver expects to continue using the number to
>>> operate on the file. We must transfer the open file state to the
>>> destination device.
>>>
>>> Different device implementations may have completely different concepts
>>> of open file state:
>>>
>>> - An in-memory file system. The list of open files is a list of
>>>     in-memory inodes. We'll also need to transfer the entire contents of
>>>     the files/directories since it's in-memory and not shared with the
>>>     destination device.
>>>
>>> - A passthrough Linux file system. We need to transfer the Linux file
>>>     handles (see open_by_handle_at(2)) so the destination device can open
>>>     the inodes on the underlying shared host file system.
>>>
>>> - A distributed object storage API. We need to transfer the list of
>>>     open object IDs so the destination device can perform I/O to the same
>>>     objects.
>>>
>>> - Anyone can create a custom virtiofs device implementation and it will
>>>     rely on different open file state.
>>
>> So it looks to me you want to propose migration drivers for different
>> implementation. It looks to me we it's better to go with something more
>> easier:
>>
>> 1) Having a common driver visible state defined in the spec, and use them
>> for migration
>> 2) It's the charge of the device or backend to "map" the driver visible
>> state to its implementation specific state.
>>
>> If 1) is in-sufficient, we should extend it until the it satisfies 2)
>>
>> For virtio-fs, it looks like the issue is that the implementation needs to
>> associate objects in different namespaces (guest vs host).
>>
>> For the above cases:
>>
>> 1) For the in-memory file system, if I understand correctly, it can be
>> accessed directly by guest via a transport specific way (e.g BAR). In this
>> case, it's driver noticeable state so all the memory must be migrated to the
>> destination.
> The virtiofs DAX Window feature is optional. Also, the DAX Window BAR
> only exposes file contents, not file system metadata. The guest driver
> or the BAR contents are not enough to migrate the state of the device.


Yes, so the point is if the state is noticeable, it need to be migrated.

And another thing that may cause confusing is that, we probably need to 
clarify what DAX is in the spec or avoid using Linux specific 
terminology as virtio can live without it.


>
>> 2) For the passthrough, it's the charge of the implementation to do the map.
>> I think it doesn't differ a lot with the current migration among shared
>> storage of block devices. (Note that open_by_handle_at() requires
>> CAP_DAC_READ_SEARCH which I'm not sure it can used)
> It's different from block devices because the FUSE protocol
> is stateful. Commands like LOOKUP, OPEN, OPENDIR create objects that are
> referred to by a temporary number (similar to POSIX fds). Due to POSIX
> file system semantics there's no way to recreate the mapping correctly
> without Linux file handles (because files can be deleted, renamed, moved
> while they are still open or their inode is known). Shared block devices
> do not have this issue.


See below, I would like to have a look at how Linux file handle is 
expected to work.


>
>> 3) For distributed storage, the implementation should implement the
>> association between driver object and distributed storage object (I think
>> each such API should has something like UUID for a global namespace) and
>> provide a way for reverse lookup.
>> 4) For other implementation, it should be the same as 3)
>>
>> It's the management layer to decide whether we can do cross implementation
>> migration, but qemu should migrate the common driver visible state instead
>> of implementation specific state.
>>
>> We can have a dedicated feature flag for this and block the migration for
>> the devices without this feature.
>>
>> I think we don't want to end up with several migration drivers for
>> virtio-fs.
>>
>>> I imagine virtio-gpu and virtio-crypto might have similar situations
>>> where an object created through a virtqueue request has device-internal
>>> state associated with it that must be migrated.
>>
>> So the point stands still. The device internal state should be restored from
>> the device specific state defined in the spec. Spec would guarantee that the
>> minimal part of the device specific state, implementation should use those
>> to restore implementation specific state.
>>
>>
>>>>>> But we can generalize the virtqueue state for sure.
>>>>> I agree and also that some device types can standardize their device
>>>>> state representations. But I think it's a technical requirement to
>>>>> support implementation-specific state for device types where
>>>>> cross-implementation migration is not possible.
>>>> A question here, if the driver depends on the implementation specific state,
>>>> how can we make sure that driver can work for other implementation. If we're
>>>> sure that a single driver can work for all kinds of implementations, it
>>>> means the we had device specific state not implementation state.
>>> I think this is confusing stateless and stateful devices. You are
>>> describing a stateless device here. I'll try to define a stateful
>>> device:
>>>
>>> A stateful device maintains state that the driver operates on indirectly
>>> via standard requests. For example, the virtio-crypto device has
>>> CREATE_SESSION requests and a session ID is returned to the driver so
>>> further requests can be made on the session object. It may not be
>>> possible to replay, reconnect, or restart the device without losing
>>> state.
>>
>> If it's impossible to do all of these. These state should be noticeable by
>> the driver and they are not implementation specific but device specific
>> which could be defined in the spec.
>>
>>
>>> I hope that this description, together with the virtiofs specifics
>>> above, make the problem clearer.
>>
>> Yes.
>>
>>
>>>>> I'm not saying the implementation-specific state representation has to
>>>>> be a binary blob. There could be an identifier registry to ensure live
>>>>> migration compatibility checks can be performed. There could also be a
>>>>> standard binary encoding for migration data.
>>>> Yes, such requirements has been well studied in the past. There should be
>>>> plenty of protocols to do this.
>>>>
>>>>
>>>>>     But the contents will be
>>>>> implementation-specific for some devices.
>>>> If we allow this, it breaks the spec effort for having a standard devices.
>>>> And it will block the real customers.
>>> If we forbid this then devices for which migration is technically
>>> possible will be unmigratable. Both users and device implementors will
>>> find other solutions, like VFIO, so I don't think we can stop them even
>>> if we tried.
>>
>> The difference is standard device vs vendor specific device. We can't avoid
>> the implementation specific state for vendor specific hardware.
>>
>> But for standard device, we don't want to end up with migration drivers. (Do
>> we want vendor to ship the vendor specific migration drivers for NVM(e)
>> devices?)
>>
>>
>>> I recognize that opaque device state poses a risk to migration
>>> compatibility, because device implementors may arbitrarily use opaque
>>> state when a standard is available.
>>>
>>> However, the way to avoid this scenario is by:
>>>
>>> 1. Making the standard migration approach the easiest to implement
>>>      because everything has been taken care of. It will save implementors
>>>      the headache of defining and coding their own device state
>>>      representations and versioning.
>>>
>>> 2. Educate users about migration compatibility so they can identify
>>>      implementors are locking in their users.
>>
>> For vendor specific device, this may work. But for standard devices like
>> virtio, we should go further.
>>
>> The device states should be defined in the spec clearly. We should re-visit
>> the design if those states contains anything that is implementation
>> specific.
> Can you describe how migrating virtiofs devices should work?


I need to learn more virtio-fs before answering this question.

Actually, it would be faster if I can see a prototype of the migration 
support for virtio-fs and start from there (as I've suggested this in 
another thread).


>   I think
> that might be quicker than if I reply to each of your points because our
> views are still quite far apart.


Yes, it would be quicker if we can start from a prototype.

Thanks


>
> Stefan

