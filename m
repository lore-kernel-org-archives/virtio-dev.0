Return-Path: <xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
message-id: <1639469618.9911778-1-xuanzhuo@linux.alibaba.com>
subject: Re: [virtio-dev] [PATCH v7 0/3] virtio: introduce VIRTIO_F_RING_RESET
 for reset queue
date: Tue, 14 Dec 2021 16:13:38 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <CACGkMEtU_wfBoC8Vk=fSmO0+BRg-8sJrfS4FhZ3-mryVKvLQhA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 6 Dec 2021 12:00:26 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Dec 6, 2021 at 11:06 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Mon,  8 Nov 2021 14:22:40 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > Hi All:
> > >
> > > This is a new version to support VIRTIO_F_RING_RESET. The feautre
> > > extends the basic facility to allow the driver to reset a virtqueue.
> > > This main motivation is to support the reset function of the queue of the
> > > network device.
> > >
> > > Please review.
> > >
> > > v7:
> > >     grammar correction
> > >
> > > v6:
> > >     The device MUST present consistent default values after queue reset.
> > >
> > > v5:
> > >     It is defined in the transports that the device can modify the default
> > >     value after reset, and the driver can use a different configuration to
> > >     re-enable the device.
> > >
> > > v4:
> > >     Cornelia Huck helped me more. Thanks.
> > >     MMIO support this.
> > >
> >
> > Hi, everybody, is there anything else I need to do with this patch? When will
> > this patch be merged into, so that I can carry out follow-up work.
>
> Reviewed-by: Jason Wang <jasowang@redhat.com>
>
> And in order to get it merged, an issue needs to be opened at
> https://github.com/oasis-tcs/virtio-spec/issues and there will be a
> voting process.
>

https://github.com/oasis-tcs/virtio-spec/issues/124

Thanks.

> But I see some duplications in the description of the queue reset. I wonder if
>
> 1) we can unify the value and meaning of queue_reset into basic
> facility (e.g using macros instead of the magic number etc)
> 2) need a chapter in "General Initialization And Device Operation" to
> describe the operation
>
> Note that it's not a must for me.
>
> Thanks
>
>
> >
> > Thanks.
> >
> > >
> > > Xuan Zhuo (3):
> > >   virtio: introduce virtqueue reset as basic facility
> > >   virtio: pci support virtqueue reset
> > >   virtio: mmio support virtqueue reset
> > >
> > >  content.tex | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 110 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.31.0
> > >
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
> >
>

