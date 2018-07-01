Return-Path: virtio-dev-return-4621-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D34C581923C
	for <virtio-dev@lists.oasis-open.org>; Sat, 30 Jun 2018 20:23:52 -0700 (PDT)
Date: Sun, 1 Jul 2018 06:23:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180627215801-mutt-send-email-mst@kernel.org>
References: <20180625122442.22432-1-tiwei.bie@intel.com>
 <20180625204233-mutt-send-email-mst@kernel.org>
 <87208c5b-6f51-4a58-6078-5de694d93552@linux.ibm.com>
 <20180626181922.GA28773@debian>
 <20180626212448-mutt-send-email-mst@kernel.org>
 <20180627180803.708b4ed3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627180803.708b4ed3.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, Halil Pasic <pasic@linux.ibm.com>, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 27, 2018 at 06:08:03PM +0200, Cornelia Huck wrote:
> On Tue, 26 Jun 2018 21:39:22 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jun 27, 2018 at 02:19:22AM +0800, Tiwei Bie wrote:
> > > On Tue, Jun 26, 2018 at 03:47:28PM +0200, Halil Pasic wrote:  
> > > > On 06/25/2018 09:19 PM, Michael S. Tsirkin wrote:  
> > > > > On Mon, Jun 25, 2018 at 08:24:42PM +0800, Tiwei Bie wrote:  
> > > > > > VIRTIO_F_IO_BARRIER was proposed recently to allow
> > > > > > drivers to do some optimizations when devices are
> > > > > > implemented in software. But it only covers barrier
> > > > > > related optimizations. Later investigations show
> > > > > > that, it could cover more. So this patch tweaks this
> > > > > > feature bit to tell the driver whether it can assume
> > > > > > the device is implemented in software and runs on
> > > > > > host CPU, and also renames this feature bit to
> > > > > > VIRTIO_F_REAL_DEVICE correspondingly.
> > > > > > 
> > > > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > > ---
> > > > > >   content.tex | 22 ++++++++++------------
> > > > > >   1 file changed, 10 insertions(+), 12 deletions(-)
> > > > > > 
> > > > > > diff --git a/content.tex b/content.tex
> > > > > > index be18234..5d6b977 100644
> > > > > > --- a/content.tex
> > > > > > +++ b/content.tex
> > > > > > @@ -5356,15 +5356,13 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> > > > > >     \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
> > > > > >     that all buffers are used by the device in the same
> > > > > >     order in which they have been made available.
> > > > > > -  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
> > > > > > -  that the device needs the driver to use the barriers
> > > > > > -  suitable for hardware devices.  Some transports require
> > > > > > -  barriers to ensure devices have a consistent view of
> > > > > > -  memory.  When devices are implemented in software a
> > > > > > -  weaker form of barrier may be sufficient and yield
> > > > > > +  \item[VIRTIO_F_REAL_DEVICE(36)] This feature indicates
> > > > > > +  that the device doesn't allow the driver to assume the
> > > > > > +  device is implemented in software and runs on host CPU.
> > > > > > +  When devices are implemented in software and run on host
> > > > > > +  CPU, some optimizations can be done in drivers and yield
> > > > > >     better performance.  This feature indicates whether
> > > > > > -  a stronger form of barrier suitable for hardware
> > > > > > -  devices is necessary.
> > > > > > +  drivers can make this assumption.
> > > > > >     \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
> > > > > >     the device supports Single Root I/O Virtualization.
> > > > > >     Currently only PCI devices support this feature.
> > > > > > @@ -5383,9 +5381,9 @@ addresses to the device.
> > > > > >   A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
> > > > > > -A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> > > > > > -If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> > > > > > -the barriers suitable for hardware devices.
> > > > > > +A driver SHOULD accept VIRTIO_F_REAL_DEVICE if it is offered.
> > > > > > +If VIRTIO_F_REAL_DEVICE has been negotiated, a driver MUST NOT
> > > > > > +assume the device is implemented in software and runs on host CPU.
> > > > > >   \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > > > > @@ -5400,7 +5398,7 @@ accepted.
> > > > > >   If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
> > > > > >   buffers in the same order in which they have been available.
> > > > > > -A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> > > > > > +A device MAY fail to operate further if VIRTIO_F_REAL_DEVICE
> > > > > >   is not accepted.
> > > > > >   A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device  
> > > > > 
> > > > > I kind of dislike the REAL_DEVICE name.
> > > > > 
> > > > > At least part of the actual question, IMHO, is where is the device
> > > > > located wrt memory that the driver shares with it.
> > > > > 
> > > > > This might include, but isn't necessarily limited to, device addressing
> > > > > restrictions and cache synchronization.
> > > > > 
> > > > > As this patch correctly says, when virtio is used for host to hypervisor
> > > > > communication, then I think it's easier to describe what is going on:
> > > > > the device is actually implemented by another CPU just like the one
> > > > > driver runs on that just happens not to be visible to the driver (I
> > > > > don't think we need to try and define what host CPU is).
> > > > > 
> > > > > But what can we say when this isn't the case?  Maybe that a transport
> > > > > and platform specific way should be used to discover the device location
> > > > > and figure out a way to make memory contents visible to the device.
> > > > > 
> > > > > 
> > > > > So - PLATFORM_LOCATION ? PLATFORM_DMA?
> > > > > 
> > > > > 
> > > > > Also, how does all this interact with PLATFORM_IOMMU? Should we extend
> > > > > PLATFORM_IOMMU to cover all addressing restrictions, and
> > > > > PLATFORM_LOCATION (or whatever) to cover cache effects?
> > > > > Then we might name it PLATFORM_CACHE. And where would encrypted
> > > > > memory schemes such as SEV fit? Are they closer to PLATFORM_IOMMU?
> > > > > 
> > > > > Maybe we want to split it like this
> > > > > - PLATFORM_IOMMU - extend to cover all platform addressing limitations
> > > > > 	(which memory is accessible)
> > > > > - IO_BARRIERS - extend to cover all platform cache synchronization effects
> > > > > 	(which memory contents is visible)
> > > > > ?
> > > > > 
> > > > > 
> > > > > All this is based on the assumption that the optimizations do not ATM
> > > > > apply to notifications. It seems that guests already do barriers around
> > > > > these, anyway - even for hypervisor based devices.
> > > > > It might be OK to ignore this in spec for now, but
> > > > > I'd like to have this discussed at least in the commit log.
> > > > >   
> > > > 
> > > > I agree with Michael, VIRTIO_F_REAL_DEVICE does not seem to be a good
> > > > name. And I agree with Michael, there is a lot's of stuff that should
> > > > be clarified (in an ideal world).  
> > > 
> > > Yeah, it's not a good patch (even for a RFC).. :(
> > > I didn't have a good idea at that time, and I wasn't sure
> > > when I could find a good one. So I sent this rough patch out
> > > as a RFC to kick off the discussion after few days delay..
> > > Your and Michael's comments are quite helpful! Thanks!
> > >   
> > > > 
> > > > My understanding of what we currently do if PLATFORM_IOMMU is set,
> > > > is use DMA API and allocate memory for the virtqueues with
> > > > dma_alloc_coherent(). AFAIU the latter has implications on what can
> > > > be assumed about caching. (Quote from Documentation/DMA-API.txt
> > > > "Consistent memory is memory for which a write by either the device or
> > > > the processor can immediately be read by the processor or device
> > > > without having to worry about caching effects.  (You may however need
> > > > to make sure to flush the processor's write buffers before telling
> > > > devices to read that memory.)")  
> > >   
> > > >From my understanding, the problems about the platform's DMA  
> > > limitations (including bounce buffer, cache coherence, ...)
> > > don't exist if the driver uses DMA API (vring_use_dma_api()
> > > return true).  
> > 
> > Bounce buffer isn't a DMA limitation as such. It's a solution.
> > 
> > The limitation is typically in device addressing.  Does this therefore
> > belong in the PLATFORM_IOMMU or in a new bit?
> > 
> > > I'm trying to understand why driver needs vring_use_dma_api()
> > > and why vring_use_dma_api() needs to return false in some
> > > cases. By reading below commit in Linux:
> > > 
> > > 1a937693993f ("virtio: new feature to detect IOMMU device quirk")
> > > 
> > > It seems that vring_use_dma_api() will return false only when
> > > the device has an iommu quirk which tells that the device needs
> > > to bypass the IOMMU.
> > > So:
> > > 
> > > If the device doesn't have the quirk (i.e. the device doesn't
> > > need to bypass the IOMMU), the driver will always use DMA API
> > > (vring_use_dma_api() return true), and the problems about the
> > > platform's DMA limitations don't exist.
> > > 
> > > If the system doesn't have an IOMMU, theoretically driver
> > > can always use DMA API directly. And the problems about the
> > > platform's DMA limitations won't exist.
> > > 
> > > If the system has an IOMMU and the device has the quirk,
> > > (this is the only case that) the driver can't use DMA API
> > > directly. And in this case, the driver shouldn't use the
> > > IOMMU but still need to use DMA API.
> > > 
> > > That is to say, only the hardware virtio devices which have
> > > the IOMMU quirk may not work on the platforms which have DMA
> > > limitations. If we want to solve this problem, we need to
> > > tweak this quirk (e.g. ask driver not to use IOMMU instead
> > > of not to use DMA API).
> > > 
> > > Best regards,
> > > Tiwei Bie  
> > 
> > So the specific reason we came up with PLATFORM_IOMMU is so that people
> > can do fine-grained security within guest, e.g. with userspace drivers.
> > 
> > ATM for linux drivers it has the effect of also enabling some
> > other DMA effects. Not all of them and not for userspace drivers.
> > 
> > But generally this seems to be the wrong forum to discuss linux
> > driver quirks.
> 
> So, do we still consider VIRTIO_F_IO_BARRIER useful with its current
> definition? Do we need to clarify assumptions, start afresh, or add a
> new feature? This is not clear to me from the discussion.

I am inclined to extend the list of assumptions drivers make
in absence of VIRTIO_F_IO_BARRIER.

> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

