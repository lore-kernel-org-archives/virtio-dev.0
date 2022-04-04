Return-Path: <mst@redhat.com>
Date: Mon, 4 Apr 2022 12:16:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 5/5] Add miscellaneous configuration structure for PCI
Message-ID: <20220404121401-mutt-send-email-mst@kernel.org>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-6-mgurtovoy@nvidia.com>
 <20220404090330-mutt-send-email-mst@kernel.org>
 <b1cae24a-ee0e-a08d-25dd-90e045a95790@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <b1cae24a-ee0e-a08d-25dd-90e045a95790@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Apr 04, 2022 at 06:52:27PM +0300, Max Gurtovoy wrote:
> 
> On 4/4/2022 4:04 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 05:56:08PM +0200, Max Gurtovoy wrote:
> > > This new structure will be used for adding new miscellaneous registers
> > > for a virtio device configuration layout.
> > > 
> > > For now, only admin_queue_index register is added. Admin virtqueue index
> > > does not depend on the device type. Hence, add a PCI capability to read
> > > the admin virtqueue index.
> > > 
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   conformance.tex |  2 ++
> > >   content.tex     | 25 +++++++++++++++++++++++++
> > >   2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/conformance.tex b/conformance.tex
> > > index 129831c..e31645e 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -102,6 +102,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
> > >   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
> > >   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
> > > +\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
> > >   \end{itemize}
> > >   \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
> > > @@ -363,6 +364,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
> > >   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
> > >   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
> > > +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
> > >   \end{itemize}
> > >   \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
> > > diff --git a/content.tex b/content.tex
> > > index 163cb34..bf46192 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -712,6 +712,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
> > >   \item ISR Status
> > >   \item Device-specific configuration (optional)
> > >   \item PCI configuration access
> > > +\item Miscellaneous configuration
> > >   \end{itemize}
> > >   Each structure can be mapped by a Base Address register (BAR) belonging to
> > > @@ -771,6 +772,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
> > >   #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> > >   /* Vendor-specific data */
> > >   #define VIRTIO_PCI_CAP_VENDOR_CFG        9
> > > +/* Miscellaneous configuration */
> > > +#define VIRTIO_PCI_CAP_MISC_CFG          10
> > >   \end{lstlisting}
> > >           Any other value is reserved for future use.
> > > @@ -1352,6 +1355,28 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
> > >   specified by some other Virtio Structure PCI Capability
> > >   of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
> > > +\subsubsection{Miscellaneous configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
> > > +
> > > +The miscellaneous configuration structure is found at the bar and offset within the VIRTIO_PCI_CAP_MISC_CFG capability.
> > > +Its layout is below.
> > > +\begin{lstlisting}
> > > +struct virtio_pci_misc_cfg {
> > > +        le16 admin_queue_index;         /* read-only for driver */
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\begin{description}
> > > +\item[\field{admin_queue_index}]
> > > +        The device uses this to report the index of the admin virtqueue.
> > > +        This field is valid only if VIRTIO_F_ADMIN_VQ is set.
> > > +\end{description}
> > > +
> > > +\devicenormative{\paragraph}{Miscellaneous configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
> > > +The device MUST present a valid \field{admin_queue_index} when VIRTIO_F_ADMIN_VQ is set.

besides, is must have a misc config capability if it has
VIRTIO_F_ADMIN_VQ.


> > > +
> > > +\drivernormative{\paragraph}{Miscellaneous configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Miscellaneous configuration structure layout}
> > > +The driver MUST use the value of \field{admin_queue_index} to configure the admin virtqueue. For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
> > > +
> > >   \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> > >   Transitional devices MUST present part of configuration
> > This is useful, but I think we'll want this for all transports then.
> 
> I think that adding more transports can be incremental and should be a no-go
> for merging this patch set.
> 
> We discussed this in the previous version and nobody had a conclusion on the
> right approach for other transports.

I think this referred to the msi-x thing not the the
misc config capability - this is the first version where
that appeared, right?  Cornelia what do you think?

In any case, in that case maybe besides saying it's transport-specific
also mention that it is currently only defined for the PCI transport.

> > 
> > 
> > > -- 
> > > 2.21.0

