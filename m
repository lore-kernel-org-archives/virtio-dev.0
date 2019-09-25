Return-Path: virtio-dev-return-6168-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E899E985E0E
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Sep 2019 10:39:05 +0000 (UTC)
Date: Wed, 25 Sep 2019 06:38:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190925063709-mutt-send-email-mst@kernel.org>
References: <20190829135206.24231-1-stefanha@redhat.com>
 <20190829135206.24231-3-stefanha@redhat.com>
 <20190910140046.57ba86e1.pasic@linux.ibm.com>
 <20190910130920.GB2797@work-vm>
 <20190910162330.30b815c6.pasic@linux.ibm.com>
 <20190910143145.GD2797@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910143145.GD2797@work-vm>
Subject: Re: [virtio-dev] [PATCH v8 2/2] virtio-fs: add DAX window
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Sage Weil <sweil@redhat.com>, Pierre Morel1 <Pierre.Morel1@ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 10, 2019 at 03:31:45PM +0100, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.ibm.com) wrote:
> > On Tue, 10 Sep 2019 14:09:20 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > 
> > > * Halil Pasic (pasic@linux.ibm.com) wrote:
> > > > On Thu, 29 Aug 2019 14:52:06 +0100
> > > > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > 
> > > > > Describe how shared memory region ID 0 is the DAX window and how
> > > > > FUSE_SETUPMAPPING maps file ranges into the window.
> > > > > 
> > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > ---
> > > > > The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> > > > > https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
> > > > > 
> > > > > v8:
> > > > >  * Make language about using both FUSE_READ/FUSE_WRITE and the DAX
> > > > >    Window clearer [Cornelia]
> > > > > v7:
> > > > >  * Clarify that the DAX Window is optional and can be used together with
> > > > >    FUSE_READ/FUSE_WRITE requests [Cornelia]
> > > > > v6:
> > > > >  * Document timing side-channel attacks [Michael]
> > > > > ---
> > > > >  virtio-fs.tex | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 66 insertions(+)
> > > > > 
> > > > > diff --git a/virtio-fs.tex b/virtio-fs.tex
> > > > > index 1ae17f8..158d066 100644
> > > > > --- a/virtio-fs.tex
> > > > > +++ b/virtio-fs.tex
> > > > > @@ -179,6 +179,62 @@ \subsubsection{Device Operation: High Priority Queue}\label{sec:Device Types / F
> > > > >  
> > > > >  The driver MUST anticipate that request queues are processed concurrently with the hiprio queue.
> > > > >  
> > > > > +\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> > > > > +
> > > > > +FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
> > > > > +driver-provided buffer and the device.  In cases where data transfer is
> > > > > +undesirable, the device can map file contents into the DAX window shared memory
> > > > > +region.  The driver then accesses file contents directly in device-owned memory
> > > > > +without a data transfer.
> > > > > +
> > > > > +The DAX Window is an alternative mechanism for accessing file contents.
> > > > > +FUSE\_READ/FUSE\_WRITE requests and DAX Window accesses are possible at the
> > > > > +same time.  Providing the DAX Window is optional for devices.  Using the DAX
> > > > > +Window is optional for drivers.
> > > > > +
> > > > > +Shared memory region ID 0 is called the DAX window.  Drivers map this shared
> > > > > +memory region with writeback caching as if it were regular RAM.  The contents
> > > > > +of the DAX window are undefined unless a mapping exists for that range.
> > > > 
> > > > This last paragraph is a bit concerning form s390x perspective. In case
> > > > of a PCI transport the shared memory region is a chunk of PCI memory (and
> > > > must be contained within the declared bar, as mandated by commit
> > > > 855ad7af2bd6).
> > > > 
> > > > The PCI architecture on s390x is at the moment such, that PCI memory
> > > > *can't be accessed like regular RAM* but specialized instructions have
> > > > to be used. I've tried to rise concern about this multiple times. Thus
> > > > the virtio spec would contradict itself a little (at least on s390x).
> > > > 
> > > > Of course for virtual zPCI devices we can make this work. But including
> > > > this paragraph in the VIRTIO specification would mean if one were to
> > > > implement this in HW it would not work for s390.
> > > > 
> > > > I don't have a anything better to propose, so I intend to vote yes
> > > > for this. I just wanted to make sure, we all are aware of the
> > > > consequences.
> > > 
> > > Thanks.
> > > 
> > > Note this is just specifying the way virtiofs uses the existing
> > > (accepted) shared memory region spec.  You can add a CCW transport of
> > > that spec to make it appropriate for 390 if needed.
> > > 
> > 
> > On s390x we have both CCW and PCI transport. And that makes things even
> > more complicated.
> > 
> > IMHO specifying that virtiofs uses the existing shared memory
> > specification like regular RAM conflicts with what is architecturally
> > possible on s390x when the transport is PCI.
> 
> OK.
> 
> 
> > Because the fact that this is memory exposed by a PCI device and
> > contained within a bar with the current s390 architecture implies that
> > this memory can not be used as regular RAM but needs to be accessed via
> > specialized instructions (PCI LOAD, PCI STORE). @Pierre: please confirm
> > or disprove me.
> > 
> > Of course both simply not doing DAX window on s390 if transport PCI,
> > or conceptually extending the architecture (for virtual systems) and
> > making it work in the non s390 way is an option.
> >
> > And yes for the CCW transport we can do whatever we want. And I think
> > we do want regular RAM for CCW transport, because architecturally there
> > is no way a CCW device can expose memory. So we would/will need to build
> > something virtual. And if we do, we should do it the way it suits us
> > best.
> 
> Yes; I'm assuming you'd do whatever is appropriate on CCW and just not
> use DAX with virtio-fs on a PCI transport.
> 
> Dave

So the TC voted for the current proposal, accordingly I merged
these patches. David, Stefan, Halil, would one of you be willing
to add a patch to clarify the DAX behavior for such systems?


> > 
> > Regards,
> > Halil
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

