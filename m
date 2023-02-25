Return-Path: <mst@redhat.com>
Date: Sat, 25 Feb 2023 12:45:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] transport-pci: Use capital alphabets
Message-ID: <20230225124225-mutt-send-email-mst@kernel.org>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230224231232.340814-2-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 25, 2023 at 01:12:31AM +0200, Parav Pandit wrote:
> Use capital alphabets to write PCI device id
> similar to vendor id and existing device id.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 0642107..e271d51 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -61,7 +61,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
>  
>  Non-transitional devices SHOULD have a PCI Device ID in the range
> -0x1040 to 0x107f.
> +0x1040 to 0x107F.
>  Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
>  Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
>  
> @@ -70,7 +70,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  
>  \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
> -the PCI Device ID in the range 0x1040 to 0x107f,
> +the PCI Device ID in the range 0x1040 to 0x107F,
>  calculated by adding 0x1040 to the Virtio Device ID,
>  as indicated in section \ref{sec:Device Types}.
>  Drivers for device types listed in section \ref{sec:Virtio
> @@ -89,7 +89,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virt
>  Transitional devices MUST have the PCI Subsystem Device ID
>  matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
>  Transitional devices MUST have the Transitional PCI Device ID in
> -the range 0x1000 to 0x103f.
> +the range 0x1000 to 0x103F.

I actually think upper case A-F is inconsistent with lower case 0x.  So
I would say if we are going to worry about it, let's make them all lower
case.



>  This is to match legacy drivers.
>  
> -- 
> 2.26.2

