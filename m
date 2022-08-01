Return-Path: <mst@redhat.com>
Date: Mon, 1 Aug 2022 02:13:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 4/5] Add admin_queue_index register to PCI common
 configuration structure
Message-ID: <20220801020359-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-5-mgurtovoy@nvidia.com>
 <20220731170049-mutt-send-email-mst@kernel.org>
 <00153057-1332-047a-2ce7-20570cb6fe31@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <00153057-1332-047a-2ce7-20570cb6fe31@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 01, 2022 at 03:11:58AM +0300, Max Gurtovoy wrote:
> 
> On 8/1/2022 12:03 AM, Michael S. Tsirkin wrote:
> > On Sun, Jul 31, 2022 at 06:43:53PM +0300, Max Gurtovoy wrote:
> > > This new register will be used for querying the index of the admin
> > > virtqueue of a virtio device. To configure, reset or enable the admin
> > > virtqueue, the driver should follow existing queue configuration/setup
> > > sequence.
> > > 
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > 
> > Can you please at least add text to MMIO and CCW that drivers and
> > devices must not negotiate the new feature bit? Will help avoid confusion.
> 
> why this is needed ? who will create a device and expose bits that it
> doesn't know how to implement.

Any multi-transport implementation actually.
For example, on a Linux guest the default is to add a feature bit to all
transports. Extra care is needed to actually only add it
to the PCI transport. With qemu, same applies to features in
include/hw/virtio/virtio.h.

> And if I'll add it, we might forget to remove it later on.

When we add the implementation I'm reasonably sure we won't forget to
remove text saying it's not implemented.

> > 
> > > ---
> > >   content.tex | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index c15423e..5fda1a0 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -904,6 +904,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > >           le64 queue_device;              /* read-write */
> > >           le16 queue_notify_data;         /* read-only for driver */
> > >           le16 queue_reset;               /* read-write */
> > > +
> > > +        /* About admin virtqueue. */
> > > +        le16 admin_queue_index;         /* read-only for driver */
> > >   };
> > >   \end{lstlisting}
> > > @@ -989,6 +992,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > >           This field exists only if VIRTIO_F_RING_RESET has been
> > >           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > > +\item[\field{admin_queue_index}]
> > > +        The device uses this to report the index of the admin virtqueue.
> > > +        This field always exists. Its value is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> > > +
> > >   \end{description}
> > >   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > we have a mess with this exists versus valid. I think exists is the same
> 
> the bigest mess that we have is for things like ring_reset that are
> optionally exist according to bit negotiation.

I think this optionally exist does not mean much, just that
it should not be accessed

> about valid - the driver shouldn't even look on registers that it didn't
> negotiated it's feature bits. There is no reason to do so.

> 
> So yes, there is a mess but not in our proposal.

Right. I propose removing "This field always exists." just
say that it's valid with VIRTIO_F_ADMIN_VQ.

> > is valid personally. Do others object if we say same as for reset here?
> > Not a big deal either way, we need to clean this up later.
> > 
> > > @@ -1075,6 +1082,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > >   were used before the queue reset.
> > >   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > > +For configuring the admin virtqueue, the driver MUST use the value of \field{admin_queue_index}.
> > > +For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
> > > +
> > >   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> > >   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > > -- 
> > > 2.21.0

