Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <87eecbhai7.fsf@redhat.com>
 <9cf51717-9627-ce3e-07fe-85c80b8d0004@redhat.com> <8735srh5zu.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e20bfca-2302-1cd4-d839-0a68aa1a1a31@redhat.com>
Date: Wed, 7 Jul 2021 10:56:35 +0800
MIME-Version: 1.0
In-Reply-To: <8735srh5zu.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/6 下午10:27, Cornelia Huck 写道:
> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/6 下午8:50, Cornelia Huck 写道:
>>> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>> +If VIRTIO_F_STOP has been negotiated, to stop a device, after setting
>>>> +STOP, the driver MUST re-read the device status to ensure the STOP bit
>>>> +is set to synchronize with the device.
>>> Is this more that the driver needs to re-read the status until STOP is
>>> set to make sure that the stop process has finished?
>>
>> Yes.
>>
>>
>>>    If the device has
>>> offered the feature and the driver accepted it, I'd assume that the
>>> device will eventually finish with the procedure, or sets NEEDS_RESET if
>>> something goes wrong?
>>
>> As stated below, the device must either:
>>
>> 1) finish all pending requests
>>
>> or
>>
>> 2) provide a device specific way for the driver to save and restore
>> pending requests
>>
>> before setting STOP.
>>
>> Otherwise the device can't offer this feature.
>>
>> Using NEEDS_RESET seems more complicated than this.
> Hm, what happens on an internal error?


A question, can reset fail? If yes, do we need to define how to proceed 
in the driver side?

If not, I don't need the reason we need to deal with that in the STOP.


> I assume that the device would
> need to signal that in some way. Or should it simply set STOP and
> discard any pending requests?


The current proposal doesn't mandate to complete all the in-flight 
requests. The device can provide a way for the driver to set and get the 
pending requests that could be re-submitted later (or in the destination).


> The driver would not be able to
> distinguish that from a normal STOP.
>
>>>> +If VIRTIO_F_STOP has been negotiated, after the driver writes STOP,
>>>> +the device MUST finish any pending operations like in flight requests
>>>> +or have its device specific way for driver to save the pending
>>>> +operations like in flight requests before setting the STOP status bit.
>>>> +
>>>> +If VIRTIO_F_STOP has been negotiated, the device MUST NOT consume
>>>> +buffers or send any used buffer notifications to the driver after
>>>> +STOP. The device MUST keep the configuration space unchanged and MUST
>>>> +NOT send configuration space change notification to the driver after
>>>> +STOP.
>>>> +
>>>> +If VIRTIO_F_STOP has been negotiated, after STOP, the device MUST
>>>> +preserve all the necessary state (the virtqueue states with the
>>>> +possible device specific states) that is required for restoring in the
>>>> +future.
>>> What happens if the driver writes STOP in when DRIVER_OK has not been
>>> set?
>>
>> I think we need a device normative like:
>>
>> If VIRTIO_F_STOP has been negotiated, the driver SHOULD ignore the STOP
>> status bit if DRIVER_OK is not set.
> That's the device that needs to do the ignoring, right?


Yes, it's a typo.


>
>>
>>>    Should the device set NEEDS_RESET, as suggested above? Same, if
>>> saving the states somehow goes wrong?
>>
>> I try hard to avoid NEEDS_RESET, so the driver is required to only read
>> the state during DRIVER_OK & STOP, and set the state during FEATURES_OK
>> & !DRIVER_OK. This is described in the driver normative in patch 1 and
>> below.
> The device can certainly ignore STOP requests that are out of spec. But
> I think we cannot get around signaling device errors in some way.


See above,

For virtqueue state, it works like the other basic facilities. So write 
and read to those facility itself isn't expected to be fail. But we can 
validate whether it makes any effort by re-read the status.

For STOP bit, if we need error reporting, we probably need that in the 
case of reset as well.

Thanks


>
>>>> +\section{Virtqueue State Saving}
>>>> +
>>>> +If both VIRTIO_F_RING_STATE and VIRTIO_F_STOP have been negotiated. A
>>>> +driver MAY save the internal virtqueue state.
>>> Is that device type specific, or something generic? The last patch
>>> suggests that it may vary by device type.
>>
>> Both virtqueue state (avail/used state) and the STOP status bit is generic.
>>
>> But the device is free to have its own specific:
>>
>> 1) extra virtqueue states (pending requests)
>> 2) device states
>>
>> And 2) is out of the scope of this series.
> Ok.
>

