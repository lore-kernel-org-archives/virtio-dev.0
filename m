Return-Path: <mgurtovoy@nvidia.com>
Subject: Re: [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <87eecbhai7.fsf@redhat.com>
 <9cf51717-9627-ce3e-07fe-85c80b8d0004@redhat.com> <8735srh5zu.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <0e8cf0cd-26ef-f9cf-aee1-f8ee83c09c9b@nvidia.com>
Date: Wed, 7 Jul 2021 03:05:33 +0300
MIME-Version: 1.0
In-Reply-To: <8735srh5zu.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 7/6/2021 5:27 PM, Cornelia Huck wrote:
> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> =E5=9C=A8 2021/7/6 =E4=B8=8B=E5=8D=888:50, Cornelia Huck =E5=86=99=E9=81=
=93:
>>> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>> +If VIRTIO_F_STOP has been negotiated, to stop a device, after setting
>>>> +STOP, the driver MUST re-read the device status to ensure the STOP bi=
t
>>>> +is set to synchronize with the device.
>>> Is this more that the driver needs to re-read the status until STOP is
>>> set to make sure that the stop process has finished?
>>
>> Yes.
>>
>>
>>>    If the device has
>>> offered the feature and the driver accepted it, I'd assume that the
>>> device will eventually finish with the procedure, or sets NEEDS_RESET i=
f
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
> Hm, what happens on an internal error? I assume that the device would
> need to signal that in some way. Or should it simply set STOP and
> discard any pending requests? The driver would not be able to
> distinguish that from a normal STOP.

Again, this looks like vdpa specific solution where the BAR is managed=20
by vdpa driver on the host.

In SRIOV the flow is different.

Please look on the state machine in my proposal.

You need a way to quiesce a device (internal state can still change, but=20
device will stop dirty guest pages and stop changing other devices=20
states in p2p) and a way to freeze a device (internal state is not=20
allowed to be changed and=C2=A0 state can be queried by the migration softw=
are).

Is it possible to have p2p in vdpa ?

>
>>>> +If VIRTIO_F_STOP has been negotiated, after the driver writes STOP,
>>>> +the device MUST finish any pending operations like in flight requests
>>>> +or have its device specific way for driver to save the pending
>>>> +operations like in flight requests before setting the STOP status bit=
.
>>>> +
>>>> +If VIRTIO_F_STOP has been negotiated, the device MUST NOT consume
>>>> +buffers or send any used buffer notifications to the driver after
>>>> +STOP. The device MUST keep the configuration space unchanged and MUST
>>>> +NOT send configuration space change notification to the driver after
>>>> +STOP.
>>>> +
>>>> +If VIRTIO_F_STOP has been negotiated, after STOP, the device MUST
>>>> +preserve all the necessary state (the virtqueue states with the
>>>> +possible device specific states) that is required for restoring in th=
e
>>>> +future.
>>> What happens if the driver writes STOP in when DRIVER_OK has not been
>>> set?
>>
>> I think we need a device normative like:
>>
>> If VIRTIO_F_STOP has been negotiated, the driver SHOULD ignore the STOP
>> status bit if DRIVER_OK is not set.
> That's the device that needs to do the ignoring, right?
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
>
>>>> +\section{Virtqueue State Saving}
>>>> +
>>>> +If both VIRTIO_F_RING_STATE and VIRTIO_F_STOP have been negotiated. A
>>>> +driver MAY save the internal virtqueue state.
>>> Is that device type specific, or something generic? The last patch
>>> suggests that it may vary by device type.
>>
>> Both virtqueue state (avail/used state) and the STOP status bit is gener=
ic.
>>
>> But the device is free to have its own specific:
>>
>> 1) extra virtqueue states (pending requests)
>> 2) device states
>>
>> And 2) is out of the scope of this series.
> Ok.
>

