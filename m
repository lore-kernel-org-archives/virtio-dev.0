Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <87eecbhai7.fsf@redhat.com>
 <9cf51717-9627-ce3e-07fe-85c80b8d0004@redhat.com> <8735srh5zu.fsf@redhat.com>
 <9e20bfca-2302-1cd4-d839-0a68aa1a1a31@redhat.com> <877di2f4xl.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <361b7676-64e0-21c3-af4e-53e229e3ca75@redhat.com>
Date: Thu, 8 Jul 2021 12:06:37 +0800
MIME-Version: 1.0
In-Reply-To: <877di2f4xl.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/8 上午12:45, Cornelia Huck 写道:
> On Wed, Jul 07 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/6 下午10:27, Cornelia Huck 写道:
>>> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> 在 2021/7/6 下午8:50, Cornelia Huck 写道:
>>>>> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>>>> +If VIRTIO_F_STOP has been negotiated, to stop a device, after setting
>>>>>> +STOP, the driver MUST re-read the device status to ensure the STOP bit
>>>>>> +is set to synchronize with the device.
>>>>> Is this more that the driver needs to re-read the status until STOP is
>>>>> set to make sure that the stop process has finished?
>>>> Yes.
>>>>
>>>>
>>>>>     If the device has
>>>>> offered the feature and the driver accepted it, I'd assume that the
>>>>> device will eventually finish with the procedure, or sets NEEDS_RESET if
>>>>> something goes wrong?
>>>> As stated below, the device must either:
>>>>
>>>> 1) finish all pending requests
>>>>
>>>> or
>>>>
>>>> 2) provide a device specific way for the driver to save and restore
>>>> pending requests
>>>>
>>>> before setting STOP.
>>>>
>>>> Otherwise the device can't offer this feature.
>>>>
>>>> Using NEEDS_RESET seems more complicated than this.
>>> Hm, what happens on an internal error?
>>
>> A question, can reset fail? If yes, do we need to define how to proceed
>> in the driver side?
>>
>> If not, I don't need the reason we need to deal with that in the STOP.
> When you put it that way, it makes sense. Let's just keep it simple,
> then.


I agree and according to the spec, reset should succeed, since it was 
used to recover from NEEDS_RESET:

"""

The driver SHOULD NOT rely on completion of operations of a device if 
DEVICE_NEEDS_RESET is set. Note: For example, the driver can’t assume 
requests in flight will be completed if DEVICE_NEEDS_RESET is set, nor 
can it assume that they have not been completed. A good implementation 
will try to recover by issuing a reset.

"""

Thanks


>

