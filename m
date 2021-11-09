Return-Path: <virtio-dev-return-8932-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE8429863C9
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Nov 2021 14:47:49 +0000 (UTC)
MIME-Version: 1.0
message-id: <1636469056.2616277-1-xuanzhuo@linux.alibaba.com>
date: Tue, 09 Nov 2021 22:44:16 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <20211109083303-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v7 2/3] virtio: pci support virtqueue reset
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 9 Nov 2021 08:33:39 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Nov 08, 2021 at 02:22:42PM +0800, Xuan Zhuo wrote:
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
> > index fb373a5..219ad2f 100644
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
> > +The device MUST present consistent default values after queue reset.
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
>
>
> When does the field get a value distinct from 1? If never how does
> driver know reset has completed?


"If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
\field{queue_reset} after the virtqueue is enabled with \field{queue_enable}."

queue_reset is 0 under normal circumstances. When the user writes 1, the device
present 1 after completing the reset operation, indicating that the reset has
been completed.

Thanks.

>
>
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > --
> > 2.31.0
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

