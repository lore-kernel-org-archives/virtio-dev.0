Return-Path: virtio-dev-return-4527-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 92EDE581920E
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jun 2018 12:20:00 -0700 (PDT)
Date: Mon, 25 Jun 2018 22:19:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180625204233-mutt-send-email-mst@kernel.org>
References: <20180625122442.22432-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625122442.22432-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 25, 2018 at 08:24:42PM +0800, Tiwei Bie wrote:
> VIRTIO_F_IO_BARRIER was proposed recently to allow
> drivers to do some optimizations when devices are
> implemented in software. But it only covers barrier
> related optimizations. Later investigations show
> that, it could cover more. So this patch tweaks this
> feature bit to tell the driver whether it can assume
> the device is implemented in software and runs on
> host CPU, and also renames this feature bit to
> VIRTIO_F_REAL_DEVICE correspondingly.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  content.tex | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index be18234..5d6b977 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5356,15 +5356,13 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
>    that all buffers are used by the device in the same
>    order in which they have been made available.
> -  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
> -  that the device needs the driver to use the barriers
> -  suitable for hardware devices.  Some transports require
> -  barriers to ensure devices have a consistent view of
> -  memory.  When devices are implemented in software a
> -  weaker form of barrier may be sufficient and yield
> +  \item[VIRTIO_F_REAL_DEVICE(36)] This feature indicates
> +  that the device doesn't allow the driver to assume the
> +  device is implemented in software and runs on host CPU.
> +  When devices are implemented in software and run on host
> +  CPU, some optimizations can be done in drivers and yield
>    better performance.  This feature indicates whether
> -  a stronger form of barrier suitable for hardware
> -  devices is necessary.
> +  drivers can make this assumption.
>    \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
>    the device supports Single Root I/O Virtualization.
>    Currently only PCI devices support this feature.
> @@ -5383,9 +5381,9 @@ addresses to the device.
>  
>  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
>  
> -A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> -If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> -the barriers suitable for hardware devices.
> +A driver SHOULD accept VIRTIO_F_REAL_DEVICE if it is offered.
> +If VIRTIO_F_REAL_DEVICE has been negotiated, a driver MUST NOT
> +assume the device is implemented in software and runs on host CPU.
>  
>  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>  
> @@ -5400,7 +5398,7 @@ accepted.
>  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
>  buffers in the same order in which they have been available.
>  
> -A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> +A device MAY fail to operate further if VIRTIO_F_REAL_DEVICE
>  is not accepted.
>  
>  A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device

I kind of dislike the REAL_DEVICE name.

At least part of the actual question, IMHO, is where is the device
located wrt memory that the driver shares with it.

This might include, but isn't necessarily limited to, device addressing
restrictions and cache synchronization.

As this patch correctly says, when virtio is used for host to hypervisor
communication, then I think it's easier to describe what is going on:
the device is actually implemented by another CPU just like the one
driver runs on that just happens not to be visible to the driver (I
don't think we need to try and define what host CPU is).

But what can we say when this isn't the case?  Maybe that a transport
and platform specific way should be used to discover the device location
and figure out a way to make memory contents visible to the device.


So - PLATFORM_LOCATION ? PLATFORM_DMA?


Also, how does all this interact with PLATFORM_IOMMU? Should we extend
PLATFORM_IOMMU to cover all addressing restrictions, and
PLATFORM_LOCATION (or whatever) to cover cache effects?
Then we might name it PLATFORM_CACHE. And where would encrypted
memory schemes such as SEV fit? Are they closer to PLATFORM_IOMMU?

Maybe we want to split it like this
- PLATFORM_IOMMU - extend to cover all platform addressing limitations
	(which memory is accessible)
- IO_BARRIERS - extend to cover all platform cache synchronization effects
	(which memory contents is visible)
?


All this is based on the assumption that the optimizations do not ATM
apply to notifications. It seems that guests already do barriers around
these, anyway - even for hypervisor based devices.
It might be OK to ignore this in spec for now, but
I'd like to have this discussed at least in the commit log.



> -- 
> 2.17.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

