Return-Path: virtio-dev-return-4805-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B74A985C6D
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Aug 2018 18:36:52 +0000 (UTC)
Date: Mon, 27 Aug 2018 14:36:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180827133424-mutt-send-email-mst@kernel.org>
References: <20180625122442.22432-1-tiwei.bie@intel.com>
 <20180625204233-mutt-send-email-mst@kernel.org>
 <87208c5b-6f51-4a58-6078-5de694d93552@linux.ibm.com>
 <20180626181922.GA28773@debian>
 <20180626212448-mutt-send-email-mst@kernel.org>
 <20180627180803.708b4ed3.cohuck@redhat.com>
 <20180628085234.GA18042@debian>
 <20180629070426-mutt-send-email-mst@kernel.org>
 <20180716110419.GA27375@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716110419.GA27375@debian>
Subject: Re: [virtio-dev] Re: [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 16, 2018 at 07:04:19PM +0800, Tiwei Bie wrote:
> > > > So, do we still consider VIRTIO_F_IO_BARRIER useful with its current
> > > > definition? Do we need to clarify assumptions, start afresh, or add a
> > > > new feature? This is not clear to me from the discussion.
> > > 
> > > The discussion is to talk about how to fix the potential
> > > problems that currently may happen when the virtio devices
> > > (which need to bypass the IOMMU) work on the platforms
> > > (which have DMA limitations).
> > > 
> > > Currently,
> > > 
> > > - IO_BARRIER is just to tell drivers which type of barriers
> > >   should be used.
> > > 
> > > - IOMMU_PLATFORM (from my understanding) is to tell drivers
> > >   whether the devices need to bypass the IOMMU.
> > > 
> > > Michael is asking whether we should tweak above two bits
> > > or whether we should do something else to solve this problem.
> > > 
> > > If we want to tweak above two bits, they may become
> > > something like:
> > > 
> > > - PLATFORM_CACHE (from IO_BARRIER): about the memory
> > >    operations visibility between driver and device.
> 
> Should the driver always try to determine device's
> DMA-coherence in the platform specific way?

Point is, some systems don't have any PV interfaces
besides virtio. These need a virtio way to discover
coherence as long as we don't emulate the more expensive
platform specific one.

> > > 
> > > - PLATFORM_IOMMU (from IOMMU_PLATFORM):
> > 
> > I'm not sure we necessarily need to swap the name
> > around like that.
> > 
> > > about whether
> > >    the DMA addr passed to the device should be prepared
> > >    (because e.g. the device is behind an IOMMU, or the
> > >    device can only access parts of system memory).
> 
> For the case that device can only access parts of system
> memory, if we need virtio device to support this, it seems
> that we also need to provide a way for virtio driver to
> know the inaccessible memory range?

I guess at this point people seem to be happy with
a platform-specific way to discover this.

> > 
> > Maybe we want to also include the case where device IO
> > addresses don't match physical addresses (e.g. include
> > an offset).
> > 
> >
> 
> It seems that above idea doesn't fix all the problems,
> e.g. the case mentioned by Jason, that virtio driver
> cannot use swiotlb (which is transparent to the device)
> when the IOMMU_PLATFORM bit isn't offered by the device.

Right so is this a real use-case?
Are there platforms where
- it is hard to make virtio appear not behind an iommu
- iommu can not support a passthrough mode
- virtio addressing needs to be limited






-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

