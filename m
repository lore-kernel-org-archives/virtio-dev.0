Return-Path: <mst@redhat.com>
Date: Fri, 28 Jan 2022 07:47:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220128074613-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <87wnikys4p.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87wnikys4p.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia Huck wrote:
> On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> 
> > In one of the many use cases a user wants to manipulate features and
> > configuration of the virtio devices regardless of the device type
> > (net/block/console). Some of this configuration is generic enough. i.e
> > Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
> > such features query and manipulation by its parent PCI PF.
> >
> > Currently virtio specification defines control virtqueue to manipulate
> > features and configuration of the device it operates on. However,
> > control virtqueue commands are device type specific, which makes it very
> > difficult to extend for device agnostic commands.
> >
> > To support this requirement in elegant way, this patch introduces a new
> > admin virtqueue. Admin virtqueue will use the same command format for all
> > types of virtio devices.
> >
> > Manipulate features via admin virtqueue is asynchronous, scalable, easy
> > to extend and doesn't require additional and expensive on-die resources
> > to be allocated for every new feature that will be added in the future.
> >
> > Subsequent patches make use of this admin virtqueue.
> >
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> >  admin-virtq.tex | 89 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  content.tex     |  9 +++--
> >  2 files changed, 96 insertions(+), 2 deletions(-)
> >  create mode 100644 admin-virtq.tex
> >
> > diff --git a/admin-virtq.tex b/admin-virtq.tex
> > new file mode 100644
> > index 0000000..1a41c22
> > --- /dev/null
> > +++ b/admin-virtq.tex
> > @@ -0,0 +1,89 @@
> > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > +
> > +Admin virtqueue is used to send administrative commands to manipulate
> > +various features of the device and/or to manipulate various features,
> > +if possible, of another device within the same group (e.g. PCI VFs of
> > +a parent PCI PF device are grouped together. These devices can be
> > +optionally managed by its parent PCI PF using its admin virtqueue.).
> > +
> > +Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
> > +feature bit.
> > +
> > +Admin virtqueue index may vary among different device types.
> 
> So, my understanding is:
> - any device type may or may not support the admin vq
> - if the device type wants to be able to accommodate the admin vq, it
>   also needs to specify where it shows up when the feature is negotiated
> 
> Do we expect that eventually all device types will need to support the
> admin vq (if some use case comes along that will require all devices to
> participate, for example?)

I suspect yes. And that's one of the reasons why I'd rather we had a
device independent way to locate the admin queue. There are less
transports than device types.

> Anyway, I'd reword the two sentences above:
> 
> "An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ is
> negotiated. The index of the admin virtqueue is device type specific."
> 
> (...)
> 
> > @@ -6847,6 +6849,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >    that the driver can reset a queue individually.
> >    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> >  
> > +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that
> > +  the device supports administration virtqueue negotiation.
> 
> Maybe
> 
> "This feature indicates that an administration virtqueue is supported." ?
> 
> > +
> >  \end{description}
> >  
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

