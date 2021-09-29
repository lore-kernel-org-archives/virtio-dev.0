Return-Path: <xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
message-id: <1632883462.8908377-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v4 2/3] virtio: pci support virtqueue reset
date: Wed, 29 Sep 2021 10:44:22 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <877df157cx.fsf@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 28 Sep 2021 12:20:46 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > PCI support virtqueue reset.
> >
> > virtio_pci_common_cfg add "queue_reset" to support virtqueue reset.
> > The driver uses this to selectively reset the queue.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  content.tex | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
>
> (...)
>
> > @@ -1020,6 +1027,20 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >
> >  The device MUST present a 0 in \field{queue_enable} on reset.
> >
> > +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> > +\field{queue_enable} after the driver has reset the virtqueue via
> > +\field{queue_reset}.
> > +
> > +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> > +\field{queue_reset} on reset.
> > +
> > +If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in
>
> s/The/the/
>
> > +\field{queue_reset} after the virtqueue is enabled with \field{queue_enable}.
> > +
> > +The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> > +present a 1 in \field{queue_reset} after the queue has been reset, until the
> > +driver re-enables the queue via \field{queue_enable}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
>
> "...or the device is reset." ?
>

    The device MUST reset the queue when 1 is written to \field{queue_reset}, and
    present a 1 in \field{queue_reset} after the queue has been reset, until the
    driver re-enables the queue via \field{queue_enable} or the device is reset. (see \ref{sec:Virtqueues / Virtqueue Reset}).

Is that so? Doesn't it feel necessary?


> Maybe also
>
> "The device MAY change the value of \field{queue_size} if the queue has
> been reset." ?
>
> Should it always set that field to the currently maximum supported queue
> size (assuming that can change dynamically)? Do we need some kind of
> synchronization for those changes?

When the queue is reset, all states of this queue MUST be modified to the
initial value. For example, queue_size MUST be reset to the maximum value
supported by the device. Because in the last reset queue or the entire device
reset process, the driver will modify the queue_size of the device so that its
value may be less than the maximum value.

Thanks.

>
> > +
> >  The device MUST present a 0 in \field{queue_size} if the virtqueue
> >  corresponding to the current \field{queue_select} is unavailable.
> >
> > @@ -1044,6 +1065,13 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >
> >  The driver MUST NOT write a 0 to \field{queue_enable}.
> >
> > +If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> > +\field{queue_reset} to reset the queue, it MUST verify that the queue
> > +has been reset by reading back \field{queue_reset} and ensuring that it
> > +is 1. The driver MAY re-enable the queue by writing a 1 to
> > +\field{queue_enable} after ensuring that the other virtqueue fields have
> > +been set up correctly. (see \ref{sec:Virtqueues / Virtqueue Reset}).
>
> Maybe also something like
>
> "The driver MAY set driver-writeable queue configuration values to
> different values than those that were used before the queue reset."
>
> ?
>
> > +
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
>

