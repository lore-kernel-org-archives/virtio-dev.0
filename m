Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YO/8/LaHihUE1bhN@stefanha-x1.localdomain>
 <db6540cc-55f0-ec66-447a-4d70dcdc97bd@redhat.com> <87r1ft8eeb.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e310931d-c0b5-63a2-ac78-0a97b13fd16e@redhat.com>
Date: Wed, 21 Jul 2021 10:59:09 +0800
MIME-Version: 1.0
In-Reply-To: <87r1ft8eeb.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/20 下午6:31, Cornelia Huck 写道:
> On Fri, Jul 16 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> 在 2021/7/15 下午5:16, Stefan Hajnoczi 写道:
>>> Stopping
>>> devices sequentially increases migration downtime, so I think the
>>> interface should encourage concurrently stopping multiple devices.
>>>
>>> I think you and Cornelia discussed that an interrupt could be added to
>>> solve this problem. That would address my concerns about the STOP bit.
>>
>> The problems are:
>>
>> 1) if we generate an interrupt after STOP, it breaks the STOP semantic
>> where the device should not generate any interrupt
>> 2) if we generate an interrupt before STOP, we may end up with race
>> conditions
> I think not all interrupts are created equal here.
>
> For virtqueue notification interrupts, I agree. If the device is being
> stopped, no notification interrupts will be generated.
>
> For device interrupts in the general sense, banning these would make it
> impossible to implement STOP for CCW, as any channel program (be it
> RESET, READ_STATUS, or any new one) is required to generate a status
> pending/interrupt when it is finished.


So they are working at different levels. STOP is at the virtio level not 
the transport level.

For STOP, it means the device stop working at virtio level, it doesn't 
mean the device doesn't work at transport level. It means CCW can still 
have its interrupt if it's not generated from the virtiqueue or config.

So did RESET: I believe for both CCW and PCI, and virtio RESET doesn't 
meant a transport level reset.


> I also don't see how that would
> create a race condition for CCW.
>
> Why can't we simply have an interrupt indicating completion of the STOP
> request, and no further interrupts after that?


So I think we had some discussion on this. I think STOP should work as 
RESET.

And if we want an indication of STOP, why don't we need it for RESET?

Thanks


>

