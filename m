Return-Path: <mst@redhat.com>
Date: Tue, 21 Feb 2023 12:42:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio-net: Describe dev cfg fields read only
Message-ID: <20230221124013-mutt-send-email-mst@kernel.org>
References: <20230217154529.33508-1-parav@nvidia.com>
 <20230217154529.33508-2-parav@nvidia.com>
 <87wn4byqqb.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87wn4byqqb.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 21, 2023 at 04:37:16PM +0100, Cornelia Huck wrote:
> On Fri, Feb 17 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> > Device configuration fields are read only. Avoid duplicating this
> > description for multiple fields.
> >
> > Instead describe it one time and do it in the driver requirements
> > section.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/161
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v2->v3:
> > - split as new patch
> > ---
> >  device-types/net/description.tex | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index a197e1a..81e1135 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -156,10 +156,10 @@ \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network
> >  \subsection{Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout}
> >  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout}
> >  
> > -Device configuration fields are listed below, they are read-only for a driver. The \field{mac} address field
> > +Device configuration fields are listed below. The \field{mac} address field
> 
> I would not remove this here, as I don't think we should move a simple
> statement into the conformance section (see below.) It does makes sense
> to remove the duplicate read-only annotations from the individual
> fields.
> 
> >  always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
> >  \field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
> > -read-only bits (for the driver) are currently defined for the status field:
> > +bits (for the driver) are currently defined for the status field:
> 
> What does "bits (for the driver)" mean? It made sense together with
> "read-only", but I would drop "(for the driver)" as well.

Ouch Parav are you making search and replace changes without
reading the result? Pls don't.


> >  VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> >  
> >  \begin{lstlisting}
> > @@ -167,14 +167,14 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
> >  #define VIRTIO_NET_S_ANNOUNCE    2
> >  \end{lstlisting}
> >  
> > -The following driver-read-only field, \field{max_virtqueue_pairs} only exists if
> > +The following field, \field{max_virtqueue_pairs} only exists if
> >  VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set. This field specifies the maximum number
> >  of each of transmit and receive virtqueues (receiveq1\ldots receiveqN
> >  and transmitq1\ldots transmitqN respectively) that can be configured once at least one of these features
> >  is negotiated.
> >  
> > -The following driver-read-only field, \field{mtu} only exists if
> > -VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driver to
> > +The following field, \field{mtu} only exists if VIRTIO_NET_F_MTU
> > +is set. This field specifies the maximum MTU for the driver to
> >  use.
> >  
> >  The following two fields, \field{speed} and \field{duplex}, only
> > @@ -261,6 +261,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
> >  
> >  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
> >  
> > +All the device configuration fields are read-only for the driver.
> 
> Not sure if this makes a good normative clause, I would rather give the
> driver something actionable:
> 
> "A driver SHOULD NOT try to write to any of the device configuration
> fields."

Agree it's not a normative statement as is.
MUST NOT actually - they were always read only.
And no need to "try" just don't write period.

> > +
> >  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> >  If the driver negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set
> >  the physical address of the NIC to \field{mac}.  Otherwise, it SHOULD

