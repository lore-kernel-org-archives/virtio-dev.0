Return-Path: <virtio-dev-return-8720-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFD1298644C
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Sep 2021 03:02:59 +0000 (UTC)
MIME-Version: 1.0
References: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
 <20210927123153.20242-3-xuanzhuo@linux.alibaba.com> <87sfxqcbr4.fsf@redhat.com>
In-Reply-To: <87sfxqcbr4.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Sep 2021 11:02:44 +0800
Message-ID: <CACGkMEvSa6Q=BpMsOKR7Ax+tRGikm=hxGCb3rxDAFzOCN1OPhA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio: pci support virtqueue reset
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 27, 2021 at 10:51 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Sep 27 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > PCI support virtqueue reset.
> >
> > virtio_pci_common_cfg add "queue_reset" to support virtqueue reset.
> > The driver uses this to selectively reset the queue.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  content.tex | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 603b1f1..35228dc 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -896,6 +896,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> >          le16 queue_notify_data;         /* read-only for driver */
> > +        le16 queue_reset;               /* read-write */
> >  };
> >  \end{lstlisting}
> >
> > @@ -975,6 +976,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          may benefit from providing another value, for example an internal virtqueue
> >          identifier, or an internal offset related to the virtqueue number.
> >          \end{note}
> > +
> > +\item[\field{queue_reset}]
> > +        The driver uses this to selectively reset the queue.
> > +        This field exists only if VIRTIO_F_RING_RESET has been
> > +        negotiated. (see \ref{sec:Virtqueues / Virtqueue Reset}).
> > +
> >  \end{description}
> >
> >  \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > @@ -1016,6 +1023,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >
> >  The device MUST present a 0 in \field{queue_enable} on reset.
> >
> > +The device MUST present a 0 in \field{queue_reset} after the virtqueue is
> > +enabled with \field{queue_enable}. The device MUST reset the queue when 1 is
> > +written to \field{queue_reset}, and present a 1 in \field{queue_reset} until the
> > +queue is enabled with \field{queue_enable}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
>
> "present a 1 in \field{queue_reset} after the queue has been reset,
> until the driver re-enables the queue via \field{queue_enable}"
>
> ?
>
> I suppose queue_reset is reset to 0 when the whole device is reset?
>
> > +
> > +The device MUST present a 0 in \field{queue_enable} after the virtqueue is reset
> > +with \field{queue_reset}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
>
> "after the driver has reset the virtqueue via \field{queue_reset}" ?
>
> This section should probably also refer to the feature bit at least once?
>
> > +
> >  The device MUST present a 0 in \field{queue_size} if the virtqueue
> >  corresponding to the current \field{queue_select} is unavailable.
> >
> > @@ -1040,6 +1055,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >
> >  The driver MUST NOT write a 0 to \field{queue_enable}.
> >
> > +If the VIRTIO_F_RING_RESET feature bit is negotiated, the driver can stop using
> > +the queue by writing a 1 to \field{queue_reset} and MUST read the value back to
> > +ensure synchronization. Then optionally re-enable the queue by writing a 1 to
> > +\field{queue_enable} after configuring the other virtqueue fields. (see
> > +\ref{sec:Virtqueues / Virtqueue Reset}).
>
> "If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> \field{queue_reset} to reset the queue, it MUST verify that the queue
> has been reset by reading back \field{queue_reset} and ensuring that it
> is 1. The driver MAY re-enable the queue by writing a 1 to
> \field{queue_enable} after ensuring that the other virtqueue fields have
> been set up correctly."
>
> ?
>
> > +
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
>
> MMIO can probably use a similar mechanism.
>
> For CCW, maybe we can add a payload to the existing RESET command if the
> feature has been negotiated;

I wonder if it's better for a new dedicated command. Consider device
reset is different from virtqueue reset.

Thanks

> the queue can be re-enabled by the normal
> READ_VQ_CONF/SET_VQ procedure. I have not yet thought that through.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

