Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <46428e55-3241-000f-531c-ef2c6e532345@nvidia.com>
Date: Wed, 15 Feb 2023 02:58:00 +0200
Subject: Re: [PATCH v10 07/10] ccw: document ADMIN_VQ as reserved
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-8-mst@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230209121221.15118-8-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 09/02/2023 14:13, Michael S. Tsirkin wrote:
> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
> 
> Note: there are more features to add to this list.
> Will be done later with a patch on top.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   content.tex | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index f8bd1ab..6a50b39 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2976,6 +2976,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
>   MAY also choose to verify reset completion by reading \field{device status} via
>   CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
>   
> +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
> +
> +At this time, devices and drivers utilizing Virtio over channel I/O
> +do not support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ

same as in previous patch: what about missing support for SR-IOV feature ?
> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
>   \chapter{Device Types}\label{sec:Device Types}
>   
>   On top of the queues, config space and feature negotiation facilities

