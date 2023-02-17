Return-Path: <mst@redhat.com>
Date: Fri, 17 Feb 2023 04:14:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 6/6] transport-channelio: Correct spelling errors
Message-ID: <20230217041419-mutt-send-email-mst@kernel.org>
References: <20230217013008.16062-1-parav@nvidia.com>
 <20230217013008.16062-7-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230217013008.16062-7-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 17, 2023 at 03:30:08AM +0200, Parav Pandit wrote:
> Now that we have individual files, fix reported spelling errors.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Why not transport-ccw? We abbreviated pci and mmio didn't we?

> ---
>  transport-channelio.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/transport-channelio.tex b/transport-channelio.tex
> index 93401a4..e25a7c1 100644
> --- a/transport-channelio.tex
> +++ b/transport-channelio.tex
> @@ -413,7 +413,7 @@ \subsubsection{Setting Up Indicators}\label{sec:Virtio Transport Options / Virti
>  \begin{itemize}
>  \item a summary indicator byte covering the virtqueues for one or more
>    virtio-ccw proxy devices
> -\item a set of contigous indicator bits for the virtqueues for a
> +\item a set of contiguous indicator bits for the virtqueues for a
>    virtio-ccw proxy device
>  \end{itemize}
>  
> @@ -563,7 +563,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
>  
>  \drivernormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
>  
> -For each notification, the driver SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous notication.
> +For each notification, the driver SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous notification.
>  
>  \begin{note}
>  For example:
> -- 
> 2.26.2

