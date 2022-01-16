Return-Path: <mst@redhat.com>
Date: Sun, 16 Jan 2022 11:45:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/5] virtio-net: add support for VIRTIO_F_ADMIN_VQ
Message-ID: <20220116114425-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-5-mgurtovoy@nvidia.com>
 <20220113125409-mutt-send-email-mst@kernel.org>
 <38c7b7a3-e0d8-d242-8723-11cabbbcb47d@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <38c7b7a3-e0d8-d242-8723-11cabbbcb47d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 16, 2022 at 11:47:30AM +0200, Max Gurtovoy wrote:
> 
> On 1/13/2022 7:56 PM, Michael S. Tsirkin wrote:
> > On Thu, Jan 13, 2022 at 04:51:02PM +0200, Max Gurtovoy wrote:
> > > Set the relevant index in case of VIRTIO_F_ADMIN_VQ negotiation.
> > > 
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > So admin VQ # is only known when all features are negotiated.
> 
> No. The driver should see if VIRTIO_NET_F_CTRL_VQ/VIRTIO_F_ADMIN_VQ are set
> by the device.
> 
> Negotiation is not a must.
> 
> Lets say CTRL_VQ is supported by the device and driver A would like to use
> it and driver B wouldn't like to use it - in both cases the admiq VQ # would
> be 2N + 1.

What's N here though?

> > Which is quite annoying if hypervisor wants to partition
> > things e.g. handling admin q in process and handling vqs
> > by an external process or by hardware.


This part stands.

> > 
> > I think we can allow devices to set the VQ# for the admin queue
> > instead. Would that work?
> > 
> > 
> > > ---
> > >   content.tex | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index 0ae4b68..e9c2383 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3034,6 +3034,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
> > >   \item[2(N-1)] receiveqN
> > >   \item[2(N-1)+1] transmitqN
> > >   \item[2N] controlq
> > > +\item[2N + 1] adminq (or \textbf{2N} in case VIRTIO_NET_F_CTRL_VQ is not set)
> > >   \end{description}
> > >    N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, otherwise N is set by
> > > @@ -3041,6 +3042,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
> > >    controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
> > > + adminq only exists if VIRTIO_F_ADMIN_VQ set.
> > > +
> > >   \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits}
> > >   \begin{description}
> > > -- 
> > > 2.21.0

