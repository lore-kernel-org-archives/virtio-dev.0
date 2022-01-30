Return-Path: <mst@redhat.com>
Date: Sun, 30 Jan 2022 04:39:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220130043801-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <87wnikys4p.fsf@redhat.com>
 <20220128074613-mutt-send-email-mst@kernel.org>
 <87tudnzwq9.fsf@redhat.com>
 <20220128105012-mutt-send-email-mst@kernel.org>
 <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Jan 29, 2022 at 11:53:06AM +0800, Jason Wang wrote:
> On Fri, Jan 28, 2022 at 11:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 04:49:34PM +0100, Cornelia Huck wrote:
> > > On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia Huck wrote:
> > > >> On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> > > >> > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > >> > +
> > > >> > +Admin virtqueue is used to send administrative commands to manipulate
> > > >> > +various features of the device and/or to manipulate various features,
> > > >> > +if possible, of another device within the same group (e.g. PCI VFs of
> > > >> > +a parent PCI PF device are grouped together. These devices can be
> > > >> > +optionally managed by its parent PCI PF using its admin virtqueue.).
> > > >> > +
> > > >> > +Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
> > > >> > +feature bit.
> > > >> > +
> > > >> > +Admin virtqueue index may vary among different device types.
> > > >>
> > > >> So, my understanding is:
> > > >> - any device type may or may not support the admin vq
> > > >> - if the device type wants to be able to accommodate the admin vq, it
> > > >>   also needs to specify where it shows up when the feature is negotiated
> > > >>
> > > >> Do we expect that eventually all device types will need to support the
> > > >> admin vq (if some use case comes along that will require all devices to
> > > >> participate, for example?)
> > > >
> > > > I suspect yes. And that's one of the reasons why I'd rather we had a
> > > > device independent way to locate the admin queue. There are less
> > > > transports than device types.
> > >
> > > So, do we want to bite the bullet now and simply say that every device
> > > type has the admin vq as the last vq if the feature is negotiated?
> > > Should be straightforward for the device types that have a fixed number
> > > of vqs, and doable for those that have a variable amount (two device
> > > types are covered by this series anyway.) I think we need to put it with
> > > the device types, as otherwise the numbering of virtqueues could change
> > > in unpredictable ways with the admin vq off/on.
> >
> > Well that only works once. The next thing we'll need we won't be able to
> > make the last one ;) So I am inclined to add a per-transport field that
> > gives the admin queue number.
> 
> Technically, there's no need to use the same namespace for admin
> virtqueue if it has a dedicated notification area. If we go this way,
> we can simply use 0 as queue index for admin virtqueue.
> 
> Thanks

Problem is 0 and 1 use the same page for notification unless
there's a page per vq (which is possible but expensive in memory space
usage term).

> > Another advantage to this approach is that
> > we can make sure admin queue gets a page by itself (which can be good if
> > we want to allow access to regular vqs but not to the admin queue to
> > guest) even if regular vqs share a page. Will help devices use less
> > memory space.
> >
> > --
> > MST
> >

