Return-Path: virtio-dev-return-6091-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0855D98436F
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Sep 2019 15:48:58 +0000 (UTC)
Date: Mon, 9 Sep 2019 11:48:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190909114844-mutt-send-email-mst@kernel.org>
References: <20190829135206.24231-1-stefanha@redhat.com>
 <20190909152734.GB20875@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909152734.GB20875@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH v8 0/2] virtio-fs: add virtio file system device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 09, 2019 at 05:27:34PM +0200, Stefan Hajnoczi wrote:
> On Thu, Aug 29, 2019 at 02:52:04PM +0100, Stefan Hajnoczi wrote:
> > v8:
> >  * Make language about using both FUSE_READ/FUSE_WRITE and the DAX
> >    Window clearer [Cornelia]
> > 
> > v7:
> >  * Rename num_queues to num_request_queues [Cornelia]
> >  * Clarify that endianness is chosen by the guest driver in the
> >    FUSE_INIT message [Cornelia]
> >  * Clarify that the DAX Window is optional and can be used together with
> >    FUSE_READ/FUSE_WRITE requests [Cornelia]
> > 
> > v6:
> >  * Clarify that num_queues only counts request queues [Cornelia]
> >  * State that only high priority requests go on the hiprio queue [Cornelia]
> >  * Expand on how endianness works [Cornelia]
> >  * Use "driver" and "device" instead of "guest" and "host" [Michael]
> >  * Explain how setuid files and device nodes can be a security issue [Michael]
> >  * Clarify that security issues with shared file systems involve multiple machines [Michael]
> >  * Document timing side-channel attacks [Michael]
> > 
> > v5:
> >  * Explain multiqueue semantics: no ordering, identical functionality on each queue, one FUSE session state shared between all queues
> >  * Explain how the FUSE session is started with a FUSE_INIT request
> >  * Consistently use "submit" vs "made available" and "complete" vs "used" terminology [Michael]
> >  * Explain endianness [Michael]
> >  * Clarify hiprio vs normal queue usage [Michael]
> >  * Move SHOULD, MUST, etc wording into normative sections [Michael]
> >  * Mention that FUSE_INIT negotiated state needs to be transferred during live migration [Michael]
> >  * State that the DAX window is mapped with writeback caching like RAM [Michael]
> >  * Mention DAX window mapping alignment constraints (they are communicated via the FUSE protocol) [Michael]
> >  * Explain that FUSE_SETUPMAPPING fails when device resources are exhausted and that splitting mappings consumes resources too [Michael]
> >  * Clarify access rules to DAX window - only touch memory that has a mapping establised
> >  * Document that DAX data persistence is achieved via FUSE_FSYNC
> > 
> > v4:
> >  * Clarify that there are no request ordering guarantees between requests in a
> >    single queue [vgoyal]
> >  * Add explanation of FUSE session endianness detection [dgilbert]
> > 
> > v3:
> >  * Remove notifications virtqueue, it's unimplemented and can be added when
> >    needed [Miklos]
> >  * Add Security Considerations and Live Migration Considerations sections
> >    [Michael]
> > v2:
> >  * Clean up core virtio file system device spec
> >  * Add DAX window
> > 
> > These patches add the virtio file system device, which is based on Linux FUSE
> > but includes the DAX window extension.  Similar to virtio-scsi, which
> > transports SCSI commands, virtio-fs transports FUSE requests and the protocol
> > documentation is not duplicated here.
> > 
> > The DAX window allows file contents to be accessed directly from shared memory.
> > This eliminates copying of data, reduces the number of vmexits, and reduces the
> > guest's memory footprint.  It also allows coherent mmap MAP_SHARED semantics
> > between guests on the same host.
> > 
> > Stefan Hajnoczi (2):
> >   content: add virtio file system device
> >   virtio-fs: add DAX window
> > 
> >  content.tex      |   1 +
> >  introduction.tex |   3 +
> >  virtio-fs.tex    | 291 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 295 insertions(+)
> >  create mode 100644 virtio-fs.tex
> 
> Fixes: #49
> (https://github.com/oasis-tcs/virtio-spec/issues/49)
> 
> I propose a vote.
> 
> Stefan

vote started.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

