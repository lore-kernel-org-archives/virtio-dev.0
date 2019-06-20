Return-Path: virtio-comment-return-756-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 20 Jun 2019 01:45:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190620014413-mutt-send-email-mst@kernel.org>
References: <20190320120740.8514-1-dgilbert@redhat.com>
 <20190320120740.8514-3-dgilbert@redhat.com>
 <20190617143100-mutt-send-email-mst@kernel.org>
 <20190617144014-mutt-send-email-mst@kernel.org>
 <20190619171316.GF2844@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619171316.GF2844@work-vm>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH v4 2/3] shared memory:
 Define PCI capability
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redha.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 19, 2019 at 06:13:17PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Mon, Jun 17, 2019 at 02:36:43PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Mar 20, 2019 at 12:07:39PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > 
> > > > Define the PCI capability used for enumerating shared memory regions.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > > > ---
> > > >  content.tex | 37 +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index 8cd1a38..ddbf949 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -688,6 +688,8 @@ The fields are interpreted as follows:
> > > >  #define VIRTIO_PCI_CAP_DEVICE_CFG        4
> > > >  /* PCI configuration access */
> > > >  #define VIRTIO_PCI_CAP_PCI_CFG           5
> > > > +/* Shared memory region */
> > > > +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> > > >  \end{lstlisting}
> > > >  
> > > >          Any other value is reserved for future use.
> > > > @@ -1052,6 +1054,41 @@ any device type which has a device-specific configuration.
> > > >  
> > > >  The \field{offset} for the device-specific configuration MUST be 4-byte aligned.
> > > >  
> > > > +\subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> > > > +
> > > > +Shared memory regions \ref{sec:Basic Facilities of a Virtio
> > > > +Device / Shared Memory Regions} are enumerated on the PCI transport
> > > > +as a sequence of VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities, one per region.
> > > > +
> > > > +The capability is immediately followed by an additional field like so:
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_pci_shm_cap {
> > > > +        struct virtio_pci_cap cap;
> > > > +        u32 offset_hi;
> > > > +        u32 length_hi;
> > > > +        u8  id;
> > > 
> > > Pls pad, pci capabilities must be a multiple of 4 bytes.
> > > BTW virtio_pci_cap has 3 bytes of padding.
> > > We can stick the id there maybe?
> > > 
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +Given that the \field{cap.length} and \field{cap.offset} fields
> > > > +are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
> > > > +fields provide the most significant 32 bits of a total 64 bit offset and
> > > > +length within the bar specified by \field{cap.bar}.  \field{id}
> > > > +uniquely identifies the given shared memory region using a device
> > > > +specific identifier.
> > > 
> > > I didn't realize we will ever need so much space.  I think I prefer
> > > moving offset_hi/length_hi to a general virtio_pci_cap64 that others can
> > > reuse.
> > 
> > And maybe we should set a bit in some other reserved byte
> > so people can generally use 64 bit offsets/lengths?
> 
> Is it actually any cleaner? I don't know - where would you put that bit?
> 
> Dave

We'd put it either in bar or cfg type.

No, I'm not sure it's strictly required.
It saves a bit of config space but increases
complexity for guests ....

> > > 
> > > > +
> > > > +While most capabilities can not be repeated,
> > > 
> > > I'd drop this part.
> > > 
> > > > multiple
> > > > +VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities are allowed as long
> > > > +as the \field{id} is unique.
> > > > +
> > > > +\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> > > > +
> > > > +The region defined by the combination of the offsets and length
> > > > +fields 
> > > 
> > > let's do \field{cap.length} \field{cap.offset} etc.
> > > 
> > > >MUST be contained within the declared bar.
> > > > +
> > > > +The \field{id} MUST be unique for any one device instance.
> > > > +
> > > >  \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
> > > >  
> > > >  The VIRTIO_PCI_CAP_PCI_CFG capability
> > > > -- 
> > > > 2.20.1
> > > > 
> > > > 
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > 
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > 
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > > 
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

