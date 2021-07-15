Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com> <875yxeeicr.fsf@redhat.com>
 <c395dbb0-f087-15df-a315-9a8da34f6e55@redhat.com> <8735sie9g1.fsf@redhat.com>
 <52f45a4e-16fb-f8c9-00a4-0a7947dcb1c5@redhat.com> <87y2aacs8o.fsf@redhat.com>
 <03e6d4a4-5e45-9b84-4f5d-955fea164913@redhat.com> <87v95dct7w.fsf@redhat.com>
 <8da2d88c-760f-8ec8-fa47-806bc491f43f@redhat.com> <87sg0hcko5.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dee67583-8590-7092-e21c-96664374dcac@redhat.com>
Date: Thu, 15 Jul 2021 10:01:08 +0800
MIME-Version: 1.0
In-Reply-To: <87sg0hcko5.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/14 下午5:24, Cornelia Huck 写道:
> On Wed, Jul 14 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/14 下午2:20, Cornelia Huck 写道:
>>> On Wed, Jul 14 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>> So I had a look at how reset is described for ccw:
>>>>
>>>> "
>>>>
>>>> In order to reset a device, a driver sends the CCW_CMD_VDEV_RESET command.
>>>>
>>>> "
>>>>
>>>> This implies something similar, that is the success of the command means
>>>> the success of the reset.
>>> Yes, indeed.
>>>
>>>> I wonder maybe I can remove the "re-read" from the basic facility and
>>>> let the transport to decide what to do.
>>>>
>>>> - for PCI, if a registers is used, we need re-read
>>>> - for CCW, follow the current implication, re-read is not needed and we
>>>> can wait/poll for the success of the ccw command
>>> If we are going with a status bit, it would be the same as for pci (we
>>> have WRITE_STATUS and READ_STATUS commands.)
>>
>> So spec is unclear of the implications of the success of a command:
>>
>> E.g for RESET (CCW_CMD_VDEV_RESET), the success of the command implies
>> the success or the reset.
> Yes, sending RESET is basically the ccw equivalent of "write 0 to the
> status", and getting a status/interrupt that the command finished
> successfully is the equivalent of "get 0 when reading the status back".
> [We did not have a "read back status" command originally.]
>
>> But for set_status (CCW_CMD_WRITE_STATUS), the success of the command
>> does not imply the bit is set by the device.
> Yes, the success only indicates that the device has received the command
> successfully. It can still refuse to set some values, or only set them
> later.
>
>> If I understand this correctly, we still need re-read here.
> Yes.
>
> [Let me know if we can make this more clear in the spec!]


We probably need to clarify them, I can only deduce those implications 
by reading the kernel driver codes.

Basically the subtle difference between VDEV_RESET and WRITE_STATUS.


>
>>
>>>    If we are going with a
>>> distinct command, we can skip the re-read.
>>
>> Then it would be better to introduce the STOP as a dedicated device
>> facility (as reset):
>>
>> The device MUST present STOP bit after it has been stopped.
>>
>> And for PCI:
>>
>> - it was set via set the bit in the registers
>>
>> for ccw:
>>
>> - a distinct command (as reset) is introduced, and STOP is forbidden to
>> set via device status?
> I think the situation for reset is different: a zero status is a natural
> way to express that a device is in its initial state. It does not really
> matter whether it is a freshly initialized device, or whether it has
> been reset by the driver, or which mechanism the driver is using.
>
> For STOP, we'd end up indicating a certain status, with one way to
> actually write the status, and the other a dedicated command. I'd expect
> that the driver will still read the status to check whether the STOP bit
> is present, as it may take some time, regardless of the transport used
> (going by the Linux implementation, the various callbacks to interact
> with the device state are assumed to be synchronous, and we have to make
> the asynchronous ccw interactions synchronous beneath the covers; if we
> stick with that model for STOP, the asynchronous nature of ccw commands
> does not buy us anything.)
>
> So, maybe using the same mechanism for every transport is better, if we
> end up reading the status back anyway.


Ok.


>
>>
>>> (I'd probably go with a more
>>> generic 'trigger an action' meta-command, but that would work just the
>>> same.)
>>>
>>>> - for admin virtqueue, it should be something similar to ccw, wait/poll
>>>> for the success of the admin virtqueue command
>>> Or we should maybe standardize on the admin virtqueue?
>>
>> That's one way to go.
>>
>>
>>>    That seems less
>>> confusing to me.
>>
>> But it's just one of the possible interface to carry the commands. We
>> still need to define the semantic or facility of "stop" first.
>>
>> And we still need to clarify the implication for the success of each
>> specific command as ccw. (E.g whether or not a re-read(get after set) is
>> need)
>>
>> The only difference is the transport: ccw command vs virtqqueue.
> Historically, too many differences in how the transports implement
> device/driver interactions have lead to some awkwardness (see e.g. the
> might_sleep annotations, which are surprising to someone working with
> the pci transport.)


Yes but it actually helps for the transport that depends on an extra 
layer to talk with the device. So it's not bad.


> So I think there's benefit in making the
> interactions either very similar, or so different that the transports
> can do their own things. (As said above, having an extra ccw command for
> STOP is probably only useful if generic code isn't polling the status
> for the bit to be set.)


I agree, but it will require the "general api" like admin virtqueue to 
carry not only the STOP stuffs but all the other configurations. 
Otherwise it's still a partial solution.


>
> So, maybe either/or
>
> - write STOP to status, read it back (via already existing methods)
> - use a virtqueue
>
> The extra ccw command would only make sense if other transports
> implemented STOP via e.g. a new register (would that also be an option?)


That's possible, but it's better then to introduce it as a basic 
facility and clarify how it interact with the existing device status.

Thanks


>

