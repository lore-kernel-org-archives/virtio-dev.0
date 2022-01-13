Return-Path: <mst@redhat.com>
Date: Thu, 13 Jan 2022 13:24:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/5] virtio-blk: add support for VIRTIO_F_ADMIN_VQ
Message-ID: <20220113132334-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220113145103.26894-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 13, 2022 at 04:51:01PM +0200, Max Gurtovoy wrote:
> Set the relevant index in case of VIRTIO_F_ADMIN_VQ negotiation.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Igh. Need to update each and every device just so it can get
generic commands seems very annoying.

> ---
>  content.tex | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index cc3e648..0ae4b68 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4518,10 +4518,19 @@ \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID}
>    2
>  
>  \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
> + if VIRTIO_F_ADMIN_VQ is not negotiated, the request queues layout is as follows:
>  \begin{description}
>  \item[0] requestq1
>  \item[\ldots]
>  \item[N-1] requestqN
> +\end{description}
> +
> + If VIRTIO_F_ADMIN_VQ is negotiated, the queues layout is as follows:
> +\begin{description}
> +\item[0] requestq1
> +\item[\ldots]
> +\item[N-1] requestqN
> +\item[N] adminq
>  \end{description}
>  
>   N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
> @@ -4590,7 +4599,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>  bits as indicated above.
>  
>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
> -the number of queues.
> +the number of request queues. This field doesn't account admin virtqueue.
>  
>  The parameters in the configuration space of the device \field{max_discard_sectors}
>  \field{discard_sector_alignment} are expressed in 512-byte units if the
> -- 
> 2.21.0

