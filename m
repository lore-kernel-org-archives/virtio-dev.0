Return-Path: <virtio-dev-return-8859-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB07198640D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Oct 2021 06:54:53 +0000 (UTC)
MIME-Version: 1.0
message-id: <1634107770.6897054-1-xuanzhuo@linux.alibaba.com>
date: Wed, 13 Oct 2021 14:49:30 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <CACGkMEvd9qVjXduwJkrQZTEhQ2euJaGmUw+WejuWRhE1Tn3r6A@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v5 2/3] virtio: pci support virtqueue reset
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 13 Oct 2021 14:05:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Oct 1, 2021 at 1:50 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > PCI support virtqueue reset.
> >
> > virtio_pci_common_cfg add "queue_reset" to support virtqueue reset.
> > The driver uses this to selectively reset the queue.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  content.tex | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index dd095f4..d014420 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -901,6 +901,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> >          le16 queue_notify_data;         /* read-only for driver */
> > +        le16 queue_reset;               /* read-write */
> >  };
> >  \end{lstlisting}
> >
> > @@ -980,6 +981,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          may benefit from providing another value, for example an internal virtqueue
> >          identifier, or an internal offset related to the virtqueue number.
> >          \end{note}
> > +
> > +\item[\field{queue_reset}]
> > +        The driver uses this to selectively reset the queue.
> > +        This field exists only if VIRTIO_F_RING_RESET has been
> > +        negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > +
> >  \end{description}
> >
> >  \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > @@ -1021,6 +1028,22 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
> > +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> > +\field{queue_reset} after the virtqueue is enabled with \field{queue_enable}.
> > +
> > +The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> > +present a 1 in \field{queue_reset} after the queue has been reset, until the
> > +driver re-enables the queue via \field{queue_enable} or the device is reset.
> > +The device MAY present different default values after queue reset.
>
> I'm not sure I get the meaning of this. The device should stick to
> consistent default values.

I do consider whether it is possible to allow the device to present different
default values at this time.

I thought about it carefully, it might cause some trouble. My
next version will emphasize that the same default values should be presented.

Thanks.

>
> Thanks
>
> > +(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > +
> >  The device MUST present a 0 in \field{queue_size} if the virtqueue
> >  corresponding to the current \field{queue_select} is unavailable.
> >
> > @@ -1045,6 +1068,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >
> >  The driver MUST NOT write a 0 to \field{queue_enable}.
> >
> > +If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> > +\field{queue_reset} to reset the queue, it MUST verify that the queue
> > +has been reset by reading back \field{queue_reset} and ensuring that it
> > +is 1. The driver MAY re-enable the queue by writing a 1 to
> > +\field{queue_enable} after ensuring that the other virtqueue fields have
> > +been set up correctly. The driver MAY set driver-writeable queue configuration
> > +values to different values than those that were used before the queue reset.
> > +(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > +
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > --
> > 2.31.0
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

