Return-Path: <mst@redhat.com>
Date: Thu, 18 Aug 2022 04:52:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v7 4/8] Add admin_queue_index register to PCI common
 configuration structure
Message-ID: <20220818045148-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-5-mst@redhat.com>
 <CACGkMEsf1JpnTYoJS94R=Yy9Rh3ScFK3sPg6GJSDxgXC2dA1+w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsf1JpnTYoJS94R=Yy9Rh3ScFK3sPg6GJSDxgXC2dA1+w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, nrupal.jani@intel.com, "Uminski, Piotr" <Piotr.Uminski@intel.com>, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, eperezma <eperezma@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 18, 2022 at 04:49:38PM +0800, Jason Wang wrote:
> On Sat, Aug 13, 2022 at 1:19 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> >
> > This new register will be used for querying the index of the admin
> > virtqueue of a virtio device. To configure, reset or enable the admin
> > virtqueue, the driver should follow existing queue configuration/setup
> > sequence.
> >
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 6ce1c07..297cb4a 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -904,6 +904,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          le64 queue_device;              /* read-write */
> >          le16 queue_notify_data;         /* read-only for driver */
> >          le16 queue_reset;               /* read-write */
> > +
> > +        /* About the administration virtqueue. */
> > +        le16 admin_queue_index;         /* read-only for driver */
> 
> Is there a chance that we may have multiple admin virtqueues?
> 
> Thanks

I don't see many reasons but if we ever need that we can always add
another register.


> 
> >  };
> >  \end{lstlisting}
> >
> > @@ -989,6 +992,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >          This field exists only if VIRTIO_F_RING_RESET has been
> >          negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> >
> > +\item[\field{admin_queue_index}]
> > +        The device uses this to report the index of the administration virtqueue.
> > +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> > +
> >  \end{description}
> >
> >  \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > @@ -1075,6 +1082,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >  were used before the queue reset.
> >  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> >
> > +If VIRTIO_F_ADMIN_VQ has been negotiated, the driver MUST
> > +configure the administration virtqueue using the value of \field{admin_queue_index}.
> > +
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > @@ -6947,6 +6957,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> >
> >    \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
> > +  At the moment this feature is only supported for devices using
> > +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> > +         Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> > +         as the transport.
> >
> >  \end{description}
> >
> > --
> > MST
> >

