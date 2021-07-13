Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
Date: Tue, 13 Jul 2021 11:27:03 +0800
MIME-Version: 1.0
In-Reply-To: <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>> 在 2021/7/11 上午4:36, Michael S. Tsirkin 写道:
>>> On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin wrote:
>>>>>>     If I understand correctly, this is all
>>>>>> driven from the driver inside the guest, so for this to work
>>>>>> the guest must be running and already have initialised the driver.
>>>>> Yes.
>>>>>
>>>> As I see it, the feature can be driven entirely by the VMM as long as
>>>> it intercept the relevant configuration space (PCI, MMIO, etc) from
>>>> guest's reads and writes, and present it as coherent and transparent
>>>> for the guest. Some use cases I can imagine with a physical device (or
>>>> vp_vpda device) with VIRTIO_F_STOP:
>>>>
>>>> 1) The VMM chooses not to pass the feature flag. The guest cannot stop
>>>> the device, so any write to this flag is an error/undefined.
>>>> 2) The VMM passes the flag to the guest. The guest can stop the device.
>>>> 2.1) The VMM stops the device to perform a live migration, and the
>>>> guest does not write to STOP in any moment of the LM. It resets the
>>>> destination device with the state, and then initializes the device.
>>>> 2.2) The guest stops the device and, when STOP(32) is set, the source
>>>> VMM migrates the device status. The destination VMM realizes the bit,
>>>> so it sets the bit in the destination too after device initialization.
>>>> 2.3) The device is not initialized by the guest so it doesn't matter
>>>> what bit has the HW, but the VM can be migrated.
>>>>
>>>> Am I missing something?
>>>>
>>>> Thanks!
>>> It's doable like this. It's all a lot of hoops to jump through though.
>>> It's also not easy for devices to implement.
>>
>> It just requires a new status bit. Anything that makes you think it's hard
>> to implement?
>>
>> E.g for networking device, it should be sufficient to use this bit + the
>> virtqueue state.
>>
>>
>>> Why don't we design the feature in a way that is useable by VMMs
>>> and implementable by devices in a simple way?
>>
>> It use the common technology like register shadowing without any further
>> stuffs.
>>
>> Or do you have any other ideas?
>>
>> (I think we all know migration will be very hard if we simply pass through
>> those state registers).
> If an admin virtqueue is used instead of the STOP Device Status field
> bit then there's no need to re-read the Device Status field in a loop
> until the device has stopped.


Probably not. Let me to clarify several points:

- This proposal has nothing to do with admin virtqueue. Actually, admin 
virtqueue could be used for carrying any basic device facility like 
status bit. E.g I'm going to post patches that use admin virtqueue as a 
"transport" for device slicing at virtio level.
- Even if we had introduced admin virtqueue, we still need a per 
function interface for this. This is a must for nested virtualization, 
we can't always expect things like PF can be assigned to L1 guest.
- According to the proposal, there's no need for the device to complete 
all the consumed buffers, device can choose to expose those inflight 
descriptors in a device specific way and set the STOP bit. This means, 
if we have the device specific in-flight descriptor reporting facility, 
the device can almost set the STOP bit immediately.
- If we don't go with the basic device facility but using the admin 
virtqueue specific method, we still need to clarify how it works with 
the device status state machine, it will be some kind of sub-states 
which looks much more complicated than the current proposal.


>
> When migrating a guest with many VIRTIO devices a busy waiting approach
> extends downtime if implemented sequentially (stopping one device at a
> time).


Well. You need some kinds of waiting for sure, the device/DMA needs 
sometime to be stopped. The downtime is determined by a specific virtio 
implementation which is hard to be restricted at the spec level. We can 
clarify that the device must set the STOP bit in e.g 100ms.


>   It can be implemented concurrently (setting the STOP bit on all
> devices and then looping until all their Device Status fields have the
> bit set), but this becomes more complex to implement.


I still don't get what kind of complexity did you worry here.


>
> I'm a little worried about adding a new bit that requires busy
> waiting...


Busy wait is not something that is introduced in this patch:

4.1.4.3.2 Driver Requirements: Common configuration structure layout

After writing 0 to device_status, the driver MUST wait for a read of 
device_status to return 0 before reinitializing the device.

Since it was required for at least one transport. We need do something 
similar to when introducing basic facility.

Thanks


>
> Stefan

