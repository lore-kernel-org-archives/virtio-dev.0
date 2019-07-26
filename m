Return-Path: virtio-dev-return-5885-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AA89985E3D
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jul 2019 12:28:05 +0000 (UTC)
Date: Fri, 26 Jul 2019 08:27:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190726082553-mutt-send-email-mst@kernel.org>
References: <20190726095338.24991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726095338.24991-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH v5 0/2] virtio-fs: add virtio file system device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Didn't look at the spec yet, but I have a question:

On Fri, Jul 26, 2019 at 10:53:36AM +0100, Stefan Hajnoczi wrote:
> v5:
>  * Explain multiqueue semantics: no ordering, identical functionality on each queue, one FUSE session state shared between all queues
>  * Explain how the FUSE session is started with a FUSE_INIT request
>  * Consistently use "submit" vs "made available" and "complete" vs "used" terminology [Michael]
>  * Explain endianness [Michael]
>  * Clarify hiprio vs normal queue usage [Michael]
>  * Move SHOULD, MUST, etc wording into normative sections [Michael]
>  * Mention that FUSE_INIT negotiated state needs to be transferred during live migration [Michael]
>  * State that the DAX window is mapped with writeback caching like RAM [Michael]
>  * Mention DAX window mapping alignment constraints (they are communicated via the FUSE protocol) [Michael]
>  * Explain that FUSE_SETUPMAPPING fails when device resources are exhausted and that splitting mappings consumes resources too [Michael]
>  * Clarify access rules to DAX window - only touch memory that has a mapping establised
>  * Document that DAX data persistence is achieved via FUSE_FSYNC


The following was raised during v4 review:

	> > > > There is a practical problem that the QEMU process may hit the mmap
	> > > > limit and be unable to perform its own mmaps due to the DAX Window.  A
	> > > > limit must be enforced on the host so that QEMU's internal mmaps
	> > > > succeed.
	> > >
	> > > But number of mmaps are already limited by dax window size which is
	> > > controlled by virtiofsd. So all user has to do is start with smaller
	> > > dax window size if this ever becomes a concern.
	> >
	> > Yes, the DAX Window size sets a hard limit on the number of mappings
	> > (window_size / page_size).  I think we should still communicate a
	> > maximum number of mappings to provide more control for cases where the
	> > page size and DAX Window size don't produce a desirable number.
	> >
	> > Consider that window_size = 8 GB and page_size = 4 KB already yields
	> > 2,097,152 maximum mappings.  Oops, that number is too large!
	>
	> Ok, so that's something which will be in virtiofsd where maximum number
	> of outstanding can be configured by user and if we cross that limit,
	> FUSE_SETUPMAPPING will be returned with some error?

	Yes, virtiofsd will enforce the limit.

	The guest driver will also be aware of the limit via VIRTIO
	configuration space.

was this addressed?


> v4:
>  * Clarify that there are no request ordering guarantees between requests in a
>    single queue [vgoyal]
>  * Add explanation of FUSE session endianness detection [dgilbert]
> 
> v3:
>  * Remove notifications virtqueue, it's unimplemented and can be added when
>    needed [Miklos]
>  * Add Security Considerations and Live Migration Considerations sections
>    [Michael]
> v2:
>  * Clean up core virtio file system device spec
>  * Add DAX window
> 
> These patches add the virtio file system device, which is based on Linux FUSE
> but includes the DAX window extension.  Similar to virtio-scsi, which
> transports SCSI commands, virtio-fs transports FUSE requests and the protocol
> documentation is not duplicated here.
> 
> The DAX window allows file contents to be accessed directly from shared memory.
> This eliminates copying of data, reduces the number of vmexits, and reduces the
> guest's memory footprint.  It also allows coherent mmap MAP_SHARED semantics
> between guests on the same host.
> 
> Stefan Hajnoczi (2):
>   content: add virtio file system device
>   virtio-fs: add DAX window
> 
>  content.tex      |   1 +
>  introduction.tex |   3 +
>  virtio-fs.tex    | 259 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 virtio-fs.tex
> 
> -- 
> 2.21.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

