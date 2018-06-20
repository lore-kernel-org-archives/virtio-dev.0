Return-Path: virtio-dev-return-4449-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E83058191A1
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Jun 2018 20:31:34 -0700 (PDT)
Date: Wed, 20 Jun 2018 06:31:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620062813-mutt-send-email-mst@kernel.org>
References: <20180510154126.4062-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510154126.4062-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH v3] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: pbonzini@redhat.com, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 10, 2018 at 11:41:26PM +0800, Tiwei Bie wrote:
> There will be hardware virtio devices in the future, which
> require drivers to use the barriers suitable for I/O devices,
> compared with software virtio devices which just require
> drivers to use the barriers suitable for CPU cores.
> 
> To fix the ordering issue for hardware virtio devices, add
> a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> will use the barriers suitable for I/O devices.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

So some people noticed that some systems also
require a cache flush around DMA to real devices.

Shouldn't we add that as part of VIRTIO_F_IO_BARRIER?

Also rename it?



Others also noticed that there are systems where accesses
include some kind of translation e.g. some high bits
in the address are set to signal access properties.
Should that be included in VIRTIO_F_IOMMU_PLATFORM?




> ---
> v2 -> v3:
> - Update the feature bits allocation (Stefan);
> 
> v1 -> v2:
> - Rebase to the latest spec (MST);
> - Use a smaller textwidth (according to _vimrc);
> 
> RFC -> v1:
> - Use plural (Stefan);
> - Add more details (Stefan);
> 
>  content.tex | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 7a92cb1..95c243f 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
>  \begin{description}
>  \item[0 to 23] Feature bits for the specific device type
>  
> -\item[24 to 33] Feature bits reserved for extensions to the queue and
> +\item[24 to 36] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[34 and above] Feature bits reserved for future extensions.
> +\item[37 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -5348,6 +5348,15 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
>    that all buffers are used by the device in the same
>    order in which they have been made available.
> +  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
> +  that the device needs the driver to use the barriers
> +  suitable for hardware devices.  Some transports require
> +  barriers to ensure devices have a consistent view of
> +  memory.  When devices are implemented in software a
> +  weaker form of barrier may be sufficient and yield
> +  better performance.  This feature indicates whether
> +  a stronger form of barrier suitable for hardware
> +  devices is necessary.
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> @@ -5363,6 +5372,10 @@ addresses to the device.
>  
>  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
>  
> +A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> +If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> +the barriers suitable for hardware devices.
> +
>  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>  
>  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> @@ -5376,6 +5389,9 @@ accepted.
>  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
>  buffers in the same order in which they have been available.
>  
> +A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> +is not accepted.
> +
>  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
>  
>  Transitional devices MAY offer the following:
> -- 
> 2.11.0
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

