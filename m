Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <1632883462.8908377-1-xuanzhuo@linux.alibaba.com>
 <87tui349zu.fsf@redhat.com> <CACGkMEt4ohctFGKvi5Z95C_YSrHDmSRq0D+9BGsrXx-yspoy9w@mail.gmail.com>
 <87lf3e48yl.fsf@redhat.com>
In-Reply-To: <87lf3e48yl.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Oct 2021 10:42:27 +0800
Message-ID: <CACGkMEv5xKcLs7JBd6p1qRHgtRYmMx7CFev5r3r7258fRxG23g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] virtio: pci support virtqueue reset
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 30, 2021 at 7:08 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Sep 30 2021, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Thu, Sep 30, 2021 at 12:33 AM Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> On Wed, Sep 29 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >>
> >> > On Tue, 28 Sep 2021 12:20:46 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
> >> >> On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >> >> > +The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> >> >> > +present a 1 in \field{queue_reset} after the queue has been reset, until the
> >> >> > +driver re-enables the queue via \field{queue_enable}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
> >> >>
> >> >> "...or the device is reset." ?
> >> >>
> >> >
> >> >     The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> >> >     present a 1 in \field{queue_reset} after the queue has been reset, until the
> >> >     driver re-enables the queue via \field{queue_enable} or the device is reset. (see \ref{sec:Virtqueues / Virtqueue Reset}).
> >> >
> >> > Is that so? Doesn't it feel necessary?
> >>
> >> Is queue_reset supposed to persist across device reset? That feels a bit
> >> odd to me.
> >
> > I think it's better to follow e.g the pci "status".
> >
> > Driver writes 1 to queue_reset. And the device notified the completion
> > by presenting 0. This looks easier to be dealt with during device
> > reset.
>
> Indeed, that might be more clear, let's go with that (same with MMIO.)
>
> >
> >
> >>
> >> >
> >> >
> >> >> Maybe also
> >> >>
> >> >> "The device MAY change the value of \field{queue_size} if the queue has
> >> >> been reset." ?
> >> >>
> >> >> Should it always set that field to the currently maximum supported queue
> >> >> size (assuming that can change dynamically)? Do we need some kind of
> >> >> synchronization for those changes?
> >> >
> >> > When the queue is reset, all states of this queue MUST be modified to the
> >> > initial value. For example, queue_size MUST be reset to the maximum value
> >> > supported by the device. Because in the last reset queue or the entire device
> >> > reset process, the driver will modify the queue_size of the device so that its
> >> > value may be less than the maximum value.
> >>
> >> I think the question is whether the device may choose a different
> >> initial maximum value once the queue has been reset. If it does change
> >> the value, there may be a race where the driver has reset the queue,
> >> read queue_reset back, read the max queue size, and the device only then
> >> changing the max queue size. Maybe I'm overthinking this.
> >
> > I think the driver should do the exact same steps as the device initialization.
> >
> > Not sure it's worth mentioning here.
>
> Hm, we might have similar problems there... but they are probably not
> really problems in practice. So just a note that the device may fill in
> the fields with different values might be enough. Like
>
> "The device MAY present different default values after queue reset."
>
> ?
>

That's fine.

Thanks

