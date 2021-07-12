Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cde5799f-2226-9454-e982-c038594b30fa@redhat.com>
Date: Mon, 12 Jul 2021 11:53:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Michael Tsirkin <mst@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/10 上午1:23, Eugenio Perez Martin 写道:
>>>    If I understand correctly, this is all
>>> driven from the driver inside the guest, so for this to work
>>> the guest must be running and already have initialised the driver.
>>
>> Yes.
>>
> As I see it, the feature can be driven entirely by the VMM as long as
> it intercept the relevant configuration space (PCI, MMIO, etc) from
> guest's reads and writes, and present it as coherent and transparent
> for the guest. Some use cases I can imagine with a physical device (or
> vp_vpda device) with VIRTIO_F_STOP:


It's basically for nested live migration. (E.g present a VIRTIO_F_STOP 
to L1 guest and above)


>
> 1) The VMM chooses not to pass the feature flag. The guest cannot stop
> the device, so any write to this flag is an error/undefined.
> 2) The VMM passes the flag to the guest. The guest can stop the device.
> 2.1) The VMM stops the device to perform a live migration, and the
> guest does not write to STOP in any moment of the LM. It resets the
> destination device with the state, and then initializes the device.
> 2.2) The guest stops the device and, when STOP(32) is set, the source
> VMM migrates the device status. The destination VMM realizes the bit,
> so it sets the bit in the destination too after device initialization.
> 2.3) The device is not initialized by the guest so it doesn't matter
> what bit has the HW, but the VM can be migrated.
>
> Am I missing something?


Something like this, note that in any cases we should not let the L(x) 
guest to access the device status bit of L(x-1) directly. The VMM in 
L(x-1) is in charge of shadowing the device status (DRIVER_OK and STOP) 
correctly. If we want to migrate L(x) guest, VMM in L(x-1) needs to 
migrate the device status correctly and restore them in the destination:

1) The device status bit in L1 is implemented by L0 VMM

2) The device status bit in L2 is implemented by L1 VMM

3) If we need to migrate L1, we just migrate the L1 device status and 
restore it

4) If we need to migrate L2, we just migrate the L2 device status and 
restore it

E.g the logic of L0 VMM (source) is:

if L1_status | DRIVER_OK && !(L1_status | STOP):
     set STOP to L0_status;
     wait until STOP is set for L0_status;
save L1 state(status) and send it to destination

The logic of L0 VMM(dest) is:

get L1 state(status)
if L1_status | DRIVER_OK:
     perform the L0 device initialization (e.g features based of L1 state)
     propagate L1_status(DRIVER_OK|DRIVER_STOP) to the L0 device

So:

For 2.1,  STOP is set by source VMM by not recovered by source since 
it's not a state of L1 device

For 2.2,  STOP is 'set' by L1 and shadowed by VMM, and it was recovered 
by the destination since it's a state of L1 device

For 2.3, STOP is not set by source and not recovered by destination 
since it's not a state of L1 device

Thanks



>
> Thanks!
>

