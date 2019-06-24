Return-Path: virtio-dev-return-5801-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DB1D984377
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jun 2019 14:10:39 +0000 (UTC)
Date: Mon, 24 Jun 2019 10:10:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190624100448-mutt-send-email-mst@kernel.org>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-3-stefanha@redhat.com>
 <20190618213147-mutt-send-email-mst@kernel.org>
 <20190624135808.GC3833@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624135808.GC3833@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 24, 2019 at 02:58:08PM +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 18, 2019 at 09:41:25PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Feb 20, 2019 at 12:46:13PM +0000, Stefan Hajnoczi wrote:
> > > Describe how shared memory region ID 0 is the DAX window and how
> > > FUSE_SETUPMAPPING maps file ranges into the window.
> > > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > Note that this depends on the shared memory resource specification
> > > extension that David Gilbert is working on.
> > > https://lists.oasis-open.org/archives/virtio-comment/201901/msg00000.html
> > > 
> > > The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> > > https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
> > > ---
> > >  virtio-fs.tex | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/virtio-fs.tex b/virtio-fs.tex
> > > index 5df5b9c..abb1e48 100644
> > > --- a/virtio-fs.tex
> > > +++ b/virtio-fs.tex
> > > @@ -157,6 +157,31 @@ The driver MUST submit FUSE_INTERRUPT, FUSE_FORGET, and FUSE_BATCH_FORGET reques
> > >  
> > >  The driver MUST anticipate that request queues are processed concurrently with the hiprio queue.
> > >  
> > > +\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> > > +
> > > +FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
> > > +driver-provided buffer and the device.  In cases where data transfer is
> > > +undesirable, the device can map file contents into the DAX window shared memory
> > > +region.  The driver then accesses file contents directly in device-owned memory
> > > +without a data transfer.
> > > +
> > > +Shared memory region ID 0 is called the DAX window.  The driver maps a file
> > > +range into the DAX window using the FUSE\_SETUPMAPPING request.  The mapping is
> > > +removed using the FUSE\_REMOVEMAPPING request.
> > 
> > I don't see FUSE\_SETUPMAPPING or FUSE\_REMOVEMAPPING  under
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h
> > Is it just me?
> 
> They are not upstream yet and can be found here:
> 
> https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h#L384
> 
> There is a chicken-and-egg problem.  Linux should merge this once the
> spec has been accepted.  The spec makes reference to a new FUSE command
> that is being added to Linux.  :D
> 
> I suggest we break it by merging the VIRTIO spec change first.  There
> won't be a spec release so soon anyway and we can revert it in case
> there are issues Linux.  Miklos, the FUSE maintainer, is well aware of
> virtio-fs and contributes to it, so it's unlikely that Linux will reject
> these commands.
> 
> > > +
> > > +After FUSE\_SETUPMAPPING has completed successfully the file range is accessible
> > > +from the DAX window at the offset provided by the driver in the request.
> > 
> > Dgilbert's patches describing shared memory say that
> > the legal ways to set up mappings are all implementation-dependent.
> > How does driver know which attributes to use for the
> > mapping?
> 
> Two different types of mappings:
> 1. The DAX window shared memory region described by DaveG's spec.
> 2. The file mappings established using FUSE_SETUPMAPPING.
> 
> The virtio_fs.ko driver maps the DAX window, e.g. from a PCI BAR in an
> implementation-defined way.  virtio_pci_*.c in Linux will have to help
> out with the implementation-specific details here.
> 
> The only flags currently supported by FUSE_SETUPMAPPING are READ and
> WRITE.  This depends on the file's access mode.  There is nothing
> implementation-specific in FUSE_SETUPMAPPING.

Sorry - I'm being unclear.
The guest driver maps parts of the PCI BAR.
What are the attributes of this mapping?
This is unrelated to FUSE_SETUPMAPPING things -
mapping is created by creatig PTEs and such
within guest, not by virtio things.


> > Also, we recently had a discussion about DAX support on hosts
> > and safety wrt crashes. Do we need to expose this
> > information to guests maybe?
> 
> No.  Although virtio-fs uses the DAX subsystem, it does not use NVDIMM's
> persistence model (e.g. CPU cache flush for persistence).  FUSE_FSYNC is
> sent when persistence is required.  Therefore virtio-fs is still using
> the traditional file/block persistence model.  No changes necessary for
> power failure, etc.
> 
> > Finally, do we want to have a way to express that the filesystem
> > only allows RO mappings?
> 
> Thanks for this idea.  I'm discussing it with the FUSE community because
> mount -o ro with FUSE currently doesn't involve the file system daemon.
> 
> > > +
> > > +\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> > > +
> > > +The device MUST allow mappings that completely or partially overlap existing mappings within the DAX window.
> > 
> > 
> > Any alignment requirements?
> 
> Good point.  There are alignment requirements and the driver has no way
> of knowing what they are.  I'll find a way to communicate them into the
> guest, either via virtio or via FUSE.
> 
> > Also, with no limit on mappings, it looks like guest can use up lots of
> > host VMAs quickly. Shouldn't there be a limit on # of mappings?
> 
> The VM can only deteriorate its own performance, right?

Only if QEMU is put in a container where virtual memory is
limited.
It's generally not a good idea where the only way for
host to make progress is to allocate more memory
without any limit.

If we are in a situation where we need to either kill
the guest or hit swap, none of the choices is good.




> We haven't seen catastrophic problems that bring the system to it's
> knees.

Because you are not running malicious guests?

>  But we're aware that increasing the number VMAs slows down the
> lookup.  There is currently no imposed limit.
> 
> Ideas have been discussed to avoid using (so many) VMAs but it seems
> like that will take some time to develop and get upstream.  This will
> not affect the virtio specification because the device interface doesn't
> need to know about this.
> 
> Stefan


One way to address this is to expose the # of mappings
in the config space.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

