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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8da2d88c-760f-8ec8-fa47-806bc491f43f@redhat.com>
Date: Wed, 14 Jul 2021 16:53:56 +0800
MIME-Version: 1.0
In-Reply-To: <87v95dct7w.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/14 下午2:20, Cornelia Huck 写道:
> On Wed, Jul 14 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/13 下午8:28, Cornelia Huck 写道:
>>> On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> 在 2021/7/13 下午7:31, Cornelia Huck 写道:
>>>>> On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>>> 在 2021/7/13 下午4:19, Cornelia Huck 写道:
>>>>>>> On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>>>>>>>> When migrating a guest with many VIRTIO devices a busy waiting approach
>>>>>>>>> extends downtime if implemented sequentially (stopping one device at a
>>>>>>>>> time).
>>>>>>>> Well. You need some kinds of waiting for sure, the device/DMA needs
>>>>>>>> sometime to be stopped. The downtime is determined by a specific virtio
>>>>>>>> implementation which is hard to be restricted at the spec level. We can
>>>>>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>>>>>> I don't think we can introduce arbitrary upper bounds here. At most, we
>>>>>>> can say that the device SHOULD try to set the STOP bit as early as
>>>>>>> possible (and make use of the mechanism to expose in-flight buffers.)
>>>>>> Yes, that's my understanding.
>>>>>>
>>>>>>
>>>>>>> If we want to avoid polling for the STOP bit, we need some kind of
>>>>>>> notification mechanism, I guess. For ccw, I'd just use a channel
>>>>>>> command to stop the device; completion of that channel program would
>>>>>>> indicate that the device is done with the stop procedure.
>>>>>> A question, is interrupt used for such notification, or the VMM can
>>>>>> choose to poll for the completion?
>>>>> You can poll for the subchannel to become status pending.
>>>>>
>>>>>>> Not sure how
>>>>>>> well that translates to other transports.
>>>>>> Actually, it's not necessarily a busy polling. VMM can schedule other
>>>>>> process in and recheck the bit periodically.
>>>>>>
>>>>>> Or as you mentioned before, we can use some kind of interrupt but it
>>>>>> would be more complicated than the simple status bit. It's better to
>>>>>> introduce the interrupt only if the status bit doesn't fit.
>>>>> At least for ccw, waiting for the status bit to be set also involves an
>>>>> interrupt or polling (we use another channel program to retrieve the
>>>>> status.) A dedicated channel command would actually be better, as the
>>>>> interrupt/status pending would already inform us of success.
>>>> So it looks to me it doesn't conflict with this design: the device must
>>>> wait for the device to be stopped to signal the success of the ccw command?
>>> Yes, the difference is mainly how that information can be extracted.
>>
>> So I had a look at how reset is described for ccw:
>>
>> "
>>
>> In order to reset a device, a driver sends the CCW_CMD_VDEV_RESET command.
>>
>> "
>>
>> This implies something similar, that is the success of the command means
>> the success of the reset.
> Yes, indeed.
>
>> I wonder maybe I can remove the "re-read" from the basic facility and
>> let the transport to decide what to do.
>>
>> - for PCI, if a registers is used, we need re-read
>> - for CCW, follow the current implication, re-read is not needed and we
>> can wait/poll for the success of the ccw command
> If we are going with a status bit, it would be the same as for pci (we
> have WRITE_STATUS and READ_STATUS commands.)


So spec is unclear of the implications of the success of a command:

E.g for RESET (CCW_CMD_VDEV_RESET), the success of the command implies 
the success or the reset.

But for set_status (CCW_CMD_WRITE_STATUS), the success of the command 
does not imply the bit is set by the device.

If I understand this correctly, we still need re-read here.


>   If we are going with a
> distinct command, we can skip the re-read.


Then it would be better to introduce the STOP as a dedicated device 
facility (as reset):

The device MUST present STOP bit after it has been stopped.

And for PCI:

- it was set via set the bit in the registers

for ccw:

- a distinct command (as reset) is introduced, and STOP is forbidden to 
set via device status?


> (I'd probably go with a more
> generic 'trigger an action' meta-command, but that would work just the
> same.)
>
>> - for admin virtqueue, it should be something similar to ccw, wait/poll
>> for the success of the admin virtqueue command
> Or we should maybe standardize on the admin virtqueue?


That's one way to go.


>   That seems less
> confusing to me.


But it's just one of the possible interface to carry the commands. We 
still need to define the semantic or facility of "stop" first.

And we still need to clarify the implication for the success of each 
specific command as ccw. (E.g whether or not a re-read(get after set) is 
need)

The only difference is the transport: ccw command vs virtqqueue.

Thanks


>

