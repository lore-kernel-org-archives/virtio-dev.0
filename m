Return-Path: virtio-dev-return-8043-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5089B986191
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 19:11:29 +0000 (UTC)
Date: Thu, 25 Feb 2021 14:11:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210225140723-mutt-send-email-mst@kernel.org>
References: <20210225175314.1987932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210225175314.1987932-1-jean-philippe@linaro.org>
Subject: [virtio-dev] Re: [PATCH] virtio-iommu: Add VIRTIO_IOMMU_F_BOOT_BYPASS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 25, 2021 at 06:53:15PM +0100, Jean-Philippe Brucker wrote:
> Specify the behavior of the device before feature negotiation.
> Implementations that allow DMA to bypass the IOMMU during boot inform
> the driver by setting the VIRTIO_IOMMU_F_BOOT_BYPASS feature.
> Negotiating the feature doesn't have any effect.

from spec text it kind of looks like it does, after
FEATURES_OK devices are disallowed access?

> Clarify the description for VIRTIO_IOMMU_F_BYPASS while we're at it,
> because "downstream of the IOMMU" is confusing.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

are the two bypass features dependend on each other then?

> ---
>  virtio-iommu.tex | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> index 08b358a..4f34a14 100644
> --- a/virtio-iommu.tex
> +++ b/virtio-iommu.tex
> @@ -59,7 +59,7 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
>    VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
>  
>  \item[VIRTIO_IOMMU_F_BYPASS (3)]
> -  When not attached to a domain, endpoints downstream of the IOMMU
> +  When not attached to a domain, endpoints managed by the IOMMU
>    can access the guest-physical address space.
>  
>  \item[VIRTIO_IOMMU_F_PROBE (4)]
> @@ -67,6 +67,10 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
>  
>  \item[VIRTIO_IOMMU_F_MMIO (5)]
>    The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
> +
> +\item[VIRTIO_IOMMU_F_BOOT_BYPASS (6)]
> +  Before feature negotiation, endpoints managed by the IOMMU
> +  can access the guest-physical address space.
>  \end{description}
>  
>  \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
> @@ -114,12 +118,15 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
>  
>  When the device is reset, endpoints are not attached to any domain.
>  
> -If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
> -unattached endpoints are allowed and translated by the IOMMU using the
> -identity function. If the feature is not negotiated, any memory access
> -from an unattached endpoint fails. Upon attaching an endpoint in
> -bypass mode to a new domain, any memory access from the endpoint fails,
> -since the domain does not contain any mapping.
> +Memory accesses from an endpoint bypass the IOMMU, that is all
> +accesses are allowed and translated using the identity function,
> +in the following cases:
> +\begin{itemize}
> +\item If the VIRTIO_IOMMU_F_BOOT_BYPASS feature is offered and
> +  the FEATURES_OK status bit is not set.

confused. so this feature *only* has effect before FEATURES_OK?


> +\item If the VIRTIO_IOMMU_F_BYPASS feature is negotiated and the
> +  endpoint is not attached to a domain.
> +\end{itemize}
>  
>  Future devices might support more modes of operation besides MAP/UNMAP.
>  Drivers verify that devices set VIRTIO_IOMMU_F_MAP_UNMAP and fail
> @@ -136,8 +143,13 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
>  
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}
>  
> +If the device does not offer the VIRTIO_IOMMU_F_BOOT_BYPASS
> +feature, it SHOULD NOT let endpoints access the guest-physical
> +address space before feature negotiation is complete.
> +
>  If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
> -device SHOULD NOT let endpoints access the guest-physical address space.
> +device SHOULD NOT let endpoints access the guest-physical address space
> +after feature negotiation is complete.


sounds weird as if they are only allowed access before feature
negotiation. likely not what you meant.


>  
>  \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}
>  
> -- 
> 2.30.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

