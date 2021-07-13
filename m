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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c395dbb0-f087-15df-a315-9a8da34f6e55@redhat.com>
Date: Tue, 13 Jul 2021 17:13:09 +0800
MIME-Version: 1.0
In-Reply-To: <875yxeeicr.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/13 下午4:19, Cornelia Huck 写道:
> On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>> When migrating a guest with many VIRTIO devices a busy waiting approach
>>> extends downtime if implemented sequentially (stopping one device at a
>>> time).
>>
>> Well. You need some kinds of waiting for sure, the device/DMA needs
>> sometime to be stopped. The downtime is determined by a specific virtio
>> implementation which is hard to be restricted at the spec level. We can
>> clarify that the device must set the STOP bit in e.g 100ms.
> I don't think we can introduce arbitrary upper bounds here. At most, we
> can say that the device SHOULD try to set the STOP bit as early as
> possible (and make use of the mechanism to expose in-flight buffers.)


Yes, that's my understanding.


>
> If we want to avoid polling for the STOP bit, we need some kind of
> notification mechanism, I guess. For ccw, I'd just use a channel
> command to stop the device; completion of that channel program would
> indicate that the device is done with the stop procedure.


A question, is interrupt used for such notification, or the VMM can 
choose to poll for the completion?


> Not sure how
> well that translates to other transports.


Actually, it's not necessarily a busy polling. VMM can schedule other 
process in and recheck the bit periodically.

Or as you mentioned before, we can use some kind of interrupt but it 
would be more complicated than the simple status bit. It's better to 
introduce the interrupt only if the status bit doesn't fit.

Thanks


>

