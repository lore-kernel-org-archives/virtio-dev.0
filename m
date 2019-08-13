Return-Path: virtio-dev-return-5965-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC9D0985E4A
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 11:24:52 +0000 (UTC)
Date: Tue, 13 Aug 2019 07:24:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190813071146-mutt-send-email-mst@kernel.org>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-2-stefanha@redhat.com>
 <20190803170121-mutt-send-email-mst@kernel.org>
 <20190813090711.GN9959@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813090711.GN9959@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v5 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 13, 2019 at 10:07:11AM +0100, Stefan Hajnoczi wrote:
> On Sat, Aug 03, 2019 at 05:12:15PM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 26, 2019 at 10:53:37AM +0100, Stefan Hajnoczi wrote:
> > > +\subsubsection{Live migration considerations}\label{sec:Device Types / File System Device / Live Migration Considerations}
> > > +
> > > +When a guest is migrated to a new host
> > 
> > Please use driver and device here and elsewhere.
> 
> Will fix.
> 
> > > it is necessary to consider the FUSE
> > > +session and its state.  The continuity of FUSE inode numbers (also known as
> > > +nodeids) and fh values is necessary so the driver can continue operation
> > > +without disruption.
> > > +
> > > +It is possible to maintain the FUSE session across live migration either by
> > > +transferring the state or by redirecting requests from the new host to the old
> > > +host where the state resides.  The details of how to achieve this are
> > > +implementation-dependent and are not visible at the device interface level.
> > > +
> > > +Maintaining version and feature information negotiated by FUSE\_INIT is
> > > +necessary so that no FUSE protocol feature changes are visible to the driver
> > > +across live migration.  The FUSE\_INIT information forms part of the FUSE
> > > +session state that needs to be transferred during live migration.
> > 
> > It bothers me that it's implicit, and is not exposed easily at the
> > virtio level, so one has to bind a virtqueue and run buffers over it to
> > even just check whether a given device supports a specific interface and
> > can be migrated to.
> > 
> > How about exposing the version of the device in the config space?
> > Spec can require that it matches the contents of the INIT command.
> 
> FUSE_INIT works like this:
> 
> 1. The client sends FUSE_INIT with the supported highest protocol
>    version.
> 2. If the server supports the client's version, it replies with the same
>    version number and fills in the FUSE_INIT parameters.
> 
>    Otherwise the server lowers the version number and replies to the
>    client, and the client will resend FUSE_INIT with the lower version
>    number to acknowledge that it supports the lower version.  Go to step
>    1.
> 
> With regards to live migration the server's FUSE_INIT reply structure
> needs to be sent to the destination if a FUSE session has been
> established.  If the destination does not support this protocol version
> then live migration fails.
> 
> If management tools want to ensure that migration always succeeds then I
> think the way to do that is not via virtio config space (they would
> still need to start a guest in order to access it!).
> 
> I don't understand the benefit of exposing the device's version in the
> config space?  Do you mean the negotiated version of the current FUSE
> session or the highest FUSE protocol version supported by the device?

The highest version.
The point is to make it crystal clear that for cross version migration
the highest version must be consistent.
Otherwise this is something implementers might easily overlook.

Another option is to add non-normative text explaining what must
be kept consistent to allow migration between devices.

Generally I think that it is unfortunate that pass-through
devices like this one are growing extensions for
feature negotiation outside the spec.
This hurts attempts at generic transport pass-through like vhost-user.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

