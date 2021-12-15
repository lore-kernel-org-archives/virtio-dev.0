Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20211108062243.102360-1-xuanzhuo@linux.alibaba.com>
 <1638759805.4692223-1-xuanzhuo@linux.alibaba.com> <CACGkMEtU_wfBoC8Vk=fSmO0+BRg-8sJrfS4FhZ3-mryVKvLQhA@mail.gmail.com>
 <878rwnrx2j.fsf@redhat.com>
In-Reply-To: <878rwnrx2j.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Dec 2021 10:08:46 +0800
Message-ID: <CACGkMEtV7SomZCZ0r_i_c0OAkBFGh6u8yvxju+ij_hcu--_p2w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v7 0/3] virtio: introduce VIRTIO_F_RING_RESET
 for reset queue
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 15, 2021 at 12:05 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Dec 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Mon, Dec 6, 2021 at 11:06 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >>
> >> On Mon,  8 Nov 2021 14:22:40 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >> > Hi All:
> >> >
> >> > This is a new version to support VIRTIO_F_RING_RESET. The feautre
> >> > extends the basic facility to allow the driver to reset a virtqueue.
> >> > This main motivation is to support the reset function of the queue of the
> >> > network device.
> >> >
> >> > Please review.
> >> >
> >> > v7:
> >> >     grammar correction
> >> >
> >> > v6:
> >> >     The device MUST present consistent default values after queue reset.
> >> >
> >> > v5:
> >> >     It is defined in the transports that the device can modify the default
> >> >     value after reset, and the driver can use a different configuration to
> >> >     re-enable the device.
> >> >
> >> > v4:
> >> >     Cornelia Huck helped me more. Thanks.
> >> >     MMIO support this.
> >> >
> >>
> >> Hi, everybody, is there anything else I need to do with this patch? When will
> >> this patch be merged into, so that I can carry out follow-up work.
> >
> > Reviewed-by: Jason Wang <jasowang@redhat.com>
> >
> > And in order to get it merged, an issue needs to be opened at
> > https://github.com/oasis-tcs/virtio-spec/issues and there will be a
> > voting process.
> >
> > But I see some duplications in the description of the queue reset. I wonder if
> >
> > 1) we can unify the value and meaning of queue_reset into basic
> > facility (e.g using macros instead of the magic number etc)
> > 2) need a chapter in "General Initialization And Device Operation" to
> > describe the operation
> >
> > Note that it's not a must for me.
>
> My suggestion is that we can do any clarifications on top.
>
> We can also add an implementation for ccw on top of this (either via
> extending the existing reset command, or introducing a new command;
> either way, bumping the ccw revision as well.)
>
> But I think starting a vote on this now to get it going is the best way
> forward.
>

I agree.

Thanks

