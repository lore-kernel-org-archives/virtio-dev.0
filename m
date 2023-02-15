Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <570df30a-5fea-d0ce-0b10-550fe14f9bb7@nvidia.com>
Date: Wed, 15 Feb 2023 02:56:17 +0200
Subject: Re: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-7-mst@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230209121221.15118-7-mst@redhat.com>
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
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   content.tex | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 2d9b903..f8bd1ab 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2362,6 +2362,18 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>   
>   Notification mechanisms did not change.
>   
> +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}
> +
> +At this time, devices and drivers utilizing Virtio Over MMIO
> +do not support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ

only ADMIN_VQ is not supported ?
What about SR-IOV :) ?
> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
>   \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
>   
>   S/390 based virtual machines support neither PCI nor MMIO, so a

