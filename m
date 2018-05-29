Return-Path: virtio-dev-return-4195-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 46D3D58191B6
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 May 2018 06:41:08 -0700 (PDT)
Date: Tue, 29 May 2018 21:41:22 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180529134121.GA12322@debian>
References: <20180524164951.3102-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524164951.3102-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH v4] content: support SR-IOV
To: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, May 25, 2018 at 12:49:51AM +0800, Tiwei Bie wrote:
> Allocate a feature bit for virtio devices which support SR-IOV.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/11

Please start the voting for this proposal. Thanks!

Best regards,
Tiwei Bie

> ---
> More details can be found from this thread:
> https://patchwork.kernel.org/patch/10285541/
> 
> v3 -> v4:
> - Limit the feature to PCI devices with SR-IOV cap (MST);
> 
> v2 -> v3:
> - Improve the wording (Cornelia);
> 
> v1 -> v2:
> - s/Reserve/Allocate/ (MST);
> - Add a Fixes tag (MST);
> - Be more explicit in driver requirement (MST);
> - Remove the "device MAY fail" description (MST);
> - Rebase on IO_BARRIER patch;
> 
> RFC -> v1:
> - Mention PCI in the description (Cornelia);
> 
>  content.tex | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index c4b3b5c..beec6c1 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
>  \begin{description}
>  \item[0 to 23] Feature bits for the specific device type
>  
> -\item[24 to 36] Feature bits reserved for extensions to the queue and
> +\item[24 to 37] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[37 and above] Feature bits reserved for future extensions.
> +\item[38 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -5365,6 +5365,9 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>    better performance.  This feature indicates whether
>    a stronger form of barrier suitable for hardware
>    devices is necessary.
> +  \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
> +  the device supports Single Root I/O Virtualization.
> +  Currently only PCI devices support this feature.
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> @@ -5384,6 +5387,16 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
>  If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
>  the barriers suitable for hardware devices.
>  
> +If VIRTIO_F_SR_IOV has been negotiated, a driver can enable
> +virtual functions through the device's PCI SR-IOV capability
> +structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
> +the device does not have a PCI SR-IOV capability structure
> +or is not a PCI device.  A driver MUST negotiate
> +VIRTIO_F_SR_IOV and complete the feature negotiation
> +(including setting the DRIVER_OK \field{status} bit) before
> +enabling virtual functions through the device's PCI SR-IOV
> +capability structure.
> +
>  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>  
>  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> @@ -5400,6 +5413,10 @@ buffers in the same order in which they have been available.
>  A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
>  is not accepted.
>  
> +A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device
> +and presents a PCI SR-IOV capability structure, otherwise
> +it MUST NOT offer VIRTIO_F_SR_IOV.
> +
>  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
>  
>  Transitional devices MAY offer the following:
> -- 
> 2.17.0
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

