Return-Path: virtio-dev-return-5799-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CA2A984377
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jun 2019 13:57:50 +0000 (UTC)
Date: Mon, 24 Jun 2019 09:57:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190624095100-mutt-send-email-mst@kernel.org>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190618212927-mutt-send-email-mst@kernel.org>
 <20190624122318.GB3833@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624122318.GB3833@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v3 0/2] virtio-fs: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 24, 2019 at 01:23:18PM +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 18, 2019 at 09:30:54PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Feb 20, 2019 at 12:46:11PM +0000, Stefan Hajnoczi wrote:
> > > v3:
> > >  * Remove notifications virtqueue, it's unimplemented and can be added when
> > >    needed [Miklos]
> > >  * Add Security Considerations and Live Migration Considerations sections
> > >    [Michael]
> > > v2:
> > >  * Clean up core virtio file system device spec
> > >  * Add DAX window
> > > 
> > > These patches add the virtio file system device, which is based on Linux FUSE
> > > but includes the DAX window extension.  Similar to virtio-scsi, which
> > > transports SCSI commands, virtio-fs transports FUSE requests and the protocol
> > > documentation is not duplicated here.
> > 
> > I think I prefer virtio-fuse as a name. Let's be a bit more
> > specific: we might want to add more filesystem devices later on.
> 
> virtio-fs is not FUSE.  Existing FUSE file system daemons cannot be
> used.

Right.

> It would be confusing to call it FUSE.  The wire protocol is indeed
> based on FUSE but from a user perspective it's a completely different
> system.

I agree.

> The virtio-fs device extends the FUSE protocol with the
> virtualization-specific DAX window (and the in-development shared
> metadata versioning data structures that will be added to a future
> spec).
> 
> Finally, users are likely to be confused and associate virtio-fuse with
> outdated FUSE issues that have long since been solved.  virtio-fs
> performs really well and that's not something that people associate with
> FUSE :-).
> 
> For these reasons I think we should continue to call it virtio-fs.
> 
> Stefan

I just wish we came up with something more specific than
"a filesystem". Any ideas?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

