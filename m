Return-Path: <mst@redhat.com>
Date: Wed, 1 Feb 2023 05:42:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] virtio-net: Improve introductory description
Message-ID: <20230201053838-mutt-send-email-mst@kernel.org>
References: <20230123171136.1142000-1-parav@nvidia.com>
 <87357phepb.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87357phepb.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 01, 2023 at 11:17:52AM +0100, Cornelia Huck wrote:
> On Mon, Jan 23 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> > The control VQ of the virtio network device is used beyond advance
> > steering control. The control VQ dynamically changes multiple features
> > of the initialized device.
> >
> > Hence, update this area of control VQ introductory description at few
> > places and also place the link to its description.
> >
> > Also update the introduction section to better describe receive and
> > transmit virtqueues.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> 
> Can you maybe also tweak the description in the github issue, as it is
> not only about the controlq anymore?
> 
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > This patch is on top of [1].
> >
> > [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00280.html
> > ---
> > changelog:
> > v0->v1:
> > - replaced command queue to control virtqueue to reflect current state
> > - added link of control vq to its detailed section
> > - removed reference of cvq from more places that limits it to steering
> > - Addressed Cornelia's review comments:
> > - updated introduction section to better describe rq, sq, cvq.
> > - explicitly wrote that cvq is optional along with its feature bit
> >   related description
> > - dropped few items from Cornelia's review as they do not exactly
> >   fit with latest 1.2 specification as below.
> >   - avoided listing number of queues in introduction as its linked to q
> >     reset which can disable all queues
> >   - avoid mentioning cvq as optional as there is better section for it
> >   - avoid talking about queue pairs as spec and use cases allows not
> >     operate in pairs mode
> > ---
> >  device-types/net/description.tex | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index e1341e6..e32780b 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -2,13 +2,13 @@ \section{Network Device}\label{sec:Device Types / Network Device}
> >  
> >  The virtio network device is a virtual network interface controller.
> >  It consists of a virtual Ethernet link which connects the device
> > -to the Ethernet network. It is the most complex of the devices
> > -supported so far by virtio. It has enhanced rapidly and demonstrates
> > -clearly how support for new features are added to an existing
> > -device. Empty buffers are placed in one virtqueue for receiving
> > -packets, and outgoing packets are enqueued into another for
> > -transmission in that order. A third command queue is used to
> > -control advanced filtering features.
> > +to the Ethernet network. The driver posts empty buffers in a
> > +receive virtqueue. The device receives the incoming packets from the link;
> > +the device places these incoming packets in a receive virtqueue buffers.
> 
> "and places these incoming packets into receive virtqueue buffers." ?

into the receive virtqueue buffers?

> > +The driver enqueues outgoing packets to a transmit virtqueue. The device
> > +dequeues packets from the transmit virtqueue and sends packets to
> > +the link.
> 
> "and sends these packets to the link." ?


or rather "dequeues these packets from the transmit virtqueue and
sends them to the link".

> > A control virtqueue is used to dynamically manipulate various
> > +features of the initialized device.
> >  
> >  \subsection{Device ID}\label{sec:Device Types / Network Device / Device ID}
> >  
> > @@ -28,7 +28,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
> >   N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, otherwise N is set by
> >   \field{max_virtqueue_pairs}.
> >  
> > - controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
> > +controlq is optional; it only exists if VIRTIO_NET_F_CTRL_VQ set.
> 
> "it only exists if VIRTIO_NET_F_CTRL_VQ is set" ?

Right. And as long as we are changing this: feature negotiation
happens before vq discovery so I feel we can safely
say "negotiated" here.

> >  
> >  \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits}
> >  
> > @@ -389,8 +389,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> >  };
> >  \end{lstlisting}
> >  
> > -The controlq is used to control device features such as
> > -filtering.
> > +The controlq is used to control many device features listed further in
> 
> s/listed/described/ ?
> 
> > +section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue}.
> >  
> >  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Network Device / Device Operation / Legacy Interface: Device Operation}
> >  When using the legacy interface, transitional devices and drivers
> > -- 
> > 2.26.2

