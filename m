Return-Path: <virtio-dev-return-11031-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D117998663F
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Feb 2023 14:16:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230203201620.107744-6-parav@nvidia.com>
References: <20230203201620.107744-1-parav@nvidia.com>
 <20230203201620.107744-6-parav@nvidia.com>
Date: Thu, 16 Feb 2023 15:16:11 +0100
Message-ID: <87fsb5ae6s.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH 5/6] transport-mmio: Correct spelling errors
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:

> Now that we have individual files, fix reported spelling errors.
>
> While at it, remove extra white space at end of line.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-mmio.tex | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 7f2e0c3..7f4cc15 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -18,7 +18,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  
>  MMIO virtio devices provide a set of memory mapped control
>  registers followed by a device-specific configuration space,
> -described in the table~\ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}.
> +described in the table~\ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
>  
>  All register values are organized as Little Endian.
>  
> @@ -32,7 +32,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  
>  \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
>    \caption {MMIO Device Register Layout}
> -  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout} \\
> +  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout} \\
>    \hline
>    \mmioreg{Name}{Function}{Offset from base}{Direction}{Description} 
>    \hline 

More trailing blanks on those two lines (and also several more in the
other register descriptions) -- maybe fix them all in one go?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

