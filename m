Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH V2 0/2] Vitqueue State Synchronization
References: <20210706043334.36359-1-jasowang@redhat.com>
 <YOwVc1V3k6+/xGHa@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7cac6f07-2ea3-1d02-5706-abf93327224a@redhat.com>
Date: Tue, 13 Jul 2021 11:08:28 +0800
MIME-Version: 1.0
In-Reply-To: <YOwVc1V3k6+/xGHa@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/12 下午6:12, Stefan Hajnoczi 写道:
> On Tue, Jul 06, 2021 at 12:33:32PM +0800, Jason Wang wrote:
>> Hi All:
>>
>> This is an updated version to implement virtqueue state
>> synchronization which is a must for the migration support.
>>
>> The first patch introduces virtqueue states as a new basic facility of
>> the virtio device. This is used by the driver to save and restore
>> virtqueue state. The states were split into available state and used
>> state to ease the transport specific implementation. It is also
>> allowed for the device to have its own device specific way to save and
>> resotre extra virtqueue states like in flight request.
>>
>> The second patch introduce a new status bit STOP. This bit is used for
>> the driver to stop the device. The major difference from reset is that
>> STOP must preserve all the virtqueue state plus the device state.
>>
>> A driver can then:
>>
>> - Get the virtqueue state if STOP status bit is set
>> - Set the virtqueue state after FEATURE_OK but before DRIVER_OK
>>
>> Device specific state synchronization could be built on top.
> Will you send a proof-of-concept implementation to demonstrate how it
> works in practice?


Eugenio has implemented a prototype for this. (Note that the codes was 
for previous version of the proposal, but it's sufficient to demonstrate 
how it works).

https://www.mail-archive.com/qemu-devel@nongnu.org/msg809332.html

https://www.mail-archive.com/qemu-devel@nongnu.org/msg809335.html


>
> You mentioned being able to migrate virtio-net devices using this
> interface, but what about state like VIRTIO_NET_S_LINK_UP that is either
> per-device or associated with a non-rx/tx virtqueue?


Note that the config space will be maintained by Qemu. So Qemu can 
choose to emulate link down by simply don't set DRIVER_OK to the device.


>
> Basically I'm not sure if the scope of this is just to migrate state
> associated with offloaded virtqueues (vDPA, VFIO/mdev, etc) or if it's
> really supposed to migrate the entire device?


As the subject, it's the virtqueue state not the device state. The 
series tries to introduce the minimal sets of functions that could be 
used to migrate the network device.


>
> Do you have an approach in mind for saving/loading device-specific
> state? Here are devices and their state:
> - virtio-blk: a list of requests that the destination device can
>    re-submit
> - virtio-scsi: a list of requests that the destination device can
>    re-submit
> - virtio-serial: active ports, including the current buffer being
>    transferred


Actually, we had two types of additional states:

- pending (or inflight) buffers, we can introduce a transport specific 
way to specify the auxiliary page which is used to stored the inflight 
descriptors (as what vhost-user did)
- other device states, this needs to be done via a device specific way, 
and it would be hard to generalize them


> - virtio-net: MAC address, status, etc


So VMM will intercept all the control commands, that means we don't need 
to query any states that is changed via those control commands.

E.g The Qemu is in charge of shadowing control virtqueue, so we don't 
even need to interface to query any of those states that is set via 
control virtqueue.

But all those device state stuffs is out of the scope of this proposal.

I can see one of the possible gap is that people may think the migration 
facility is designed for the simple passthrough that Linux provides, 
that means the device is assigend 'entirely' to the guest. This is not 
case for the case of live migration, some kind of mediation must be done 
in the middle.

And that's the work of VMM through vDPA + Qemu: intercepting control 
command but not datapath.

Thanks


>
> Stefan

