Return-Path: <mst@redhat.com>
Date: Tue, 21 Feb 2023 12:52:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio-net: Describe dev cfg fields read only
Message-ID: <20230221125057-mutt-send-email-mst@kernel.org>
References: <20230217154529.33508-1-parav@nvidia.com>
 <20230217154529.33508-2-parav@nvidia.com>
 <87wn4byqqb.fsf@redhat.com>
 <20230221124013-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC76D8FDB8E53956EAE4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AC76D8FDB8E53956EAE4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 21, 2023 at 05:50:09PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 21, 2023 12:42 PM
> > >
> > > What does "bits (for the driver)" mean? It made sense together with
> > > "read-only", but I would drop "(for the driver)" as well.
> > 
> > Ouch Parav are you making search and replace changes without reading the
> > result? Pls don't.
> > 
> It was wrong to keep the "for the driver".
> I will fix this.
> 
> > 
> > > >  VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> > > >
> > > >  \begin{lstlisting}
> > > > @@ -167,14 +167,14 @@ \subsection{Device configuration
> > layout}\label{sec:Device Types / Network Device
> > > >  #define VIRTIO_NET_S_ANNOUNCE    2
> > > >  \end{lstlisting}
> > > >
> > > > -The following driver-read-only field, \field{max_virtqueue_pairs}
> > > > only exists if
> > > > +The following field, \field{max_virtqueue_pairs} only exists if
> > > >  VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set. This field specifies
> > > > the maximum number  of each of transmit and receive virtqueues
> > > > (receiveq1\ldots receiveqN  and transmitq1\ldots transmitqN
> > > > respectively) that can be configured once at least one of these features  is
> > negotiated.
> > > >
> > > > -The following driver-read-only field, \field{mtu} only exists if
> > > > -VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for
> > > > the driver to
> > > > +The following field, \field{mtu} only exists if VIRTIO_NET_F_MTU is
> > > > +set. This field specifies the maximum MTU for the driver to
> > > >  use.
> > > >
> > > >  The following two fields, \field{speed} and \field{duplex}, only @@
> > > > -261,6 +261,8 @@ \subsection{Device configuration
> > > > layout}\label{sec:Device Types / Network Device
> > > >
> > > >  \drivernormative{\subsubsection}{Device configuration
> > > > layout}{Device Types / Network Device / Device configuration layout}
> > > >
> > > > +All the device configuration fields are read-only for the driver.
> > >
> > > Not sure if this makes a good normative clause, I would rather give
> > > the driver something actionable:
> > >
> > > "A driver SHOULD NOT try to write to any of the device configuration
> > > fields."
> > 
> > Agree it's not a normative statement as is.
> > MUST NOT actually - they were always read only.
> > And no need to "try" just don't write period.
> > 
> Saying driver must not write it, doesn't make it read only for the device.

no but this is not what your patch said either. It's read only for the
driver.

> Hence, it should be mentioned as read-only fields, so when the driver writes something to read-only fields, it can be considered as undefined behavior on such fields.
> 

In the description not in the normative statements. normative sections
just tell driver what it must and must not do, in the standard RFC
terms.

> > > > +
> > > >  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> > > >  If the driver negotiates the VIRTIO_NET_F_MAC feature, the driver
> > > > MUST set  the physical address of the NIC to \field{mac}.
> > > > Otherwise, it SHOULD

