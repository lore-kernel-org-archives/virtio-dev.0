Return-Path: <virtio-dev-return-8996-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00D2B98641B
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Dec 2021 16:05:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEtU_wfBoC8Vk=fSmO0+BRg-8sJrfS4FhZ3-mryVKvLQhA@mail.gmail.com>
References: <20211108062243.102360-1-xuanzhuo@linux.alibaba.com>
 <1638759805.4692223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtU_wfBoC8Vk=fSmO0+BRg-8sJrfS4FhZ3-mryVKvLQhA@mail.gmail.com>
Date: Tue, 14 Dec 2021 17:05:40 +0100
Message-ID: <878rwnrx2j.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v7 0/3] virtio: introduce
 VIRTIO_F_RING_RESET for reset queue
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 06 2021, Jason Wang <jasowang@redhat.com> wrote:

> On Mon, Dec 6, 2021 at 11:06 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>
>> On Mon,  8 Nov 2021 14:22:40 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>> > Hi All:
>> >
>> > This is a new version to support VIRTIO_F_RING_RESET. The feautre
>> > extends the basic facility to allow the driver to reset a virtqueue.
>> > This main motivation is to support the reset function of the queue of the
>> > network device.
>> >
>> > Please review.
>> >
>> > v7:
>> >     grammar correction
>> >
>> > v6:
>> >     The device MUST present consistent default values after queue reset.
>> >
>> > v5:
>> >     It is defined in the transports that the device can modify the default
>> >     value after reset, and the driver can use a different configuration to
>> >     re-enable the device.
>> >
>> > v4:
>> >     Cornelia Huck helped me more. Thanks.
>> >     MMIO support this.
>> >
>>
>> Hi, everybody, is there anything else I need to do with this patch? When will
>> this patch be merged into, so that I can carry out follow-up work.
>
> Reviewed-by: Jason Wang <jasowang@redhat.com>
>
> And in order to get it merged, an issue needs to be opened at
> https://github.com/oasis-tcs/virtio-spec/issues and there will be a
> voting process.
>
> But I see some duplications in the description of the queue reset. I wonder if
>
> 1) we can unify the value and meaning of queue_reset into basic
> facility (e.g using macros instead of the magic number etc)
> 2) need a chapter in "General Initialization And Device Operation" to
> describe the operation
>
> Note that it's not a must for me.

My suggestion is that we can do any clarifications on top.

We can also add an implementation for ccw on top of this (either via
extending the existing reset command, or introducing a new command;
either way, bumping the ccw revision as well.)

But I think starting a vote on this now to get it going is the best way
forward.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

