Return-Path: <mst@redhat.com>
Date: Mon, 4 Oct 2021 05:17:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] content: Remove duplicate paragraph
Message-ID: <20211004051656-mutt-send-email-mst@kernel.org>
References: <20210930125847.28823-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210930125847.28823-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 30, 2021 at 01:58:48PM +0100, Jean-Philippe Brucker wrote:
> It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
> type") had a merge issue. It includes the device normative paragraph for
> Shared memory capability, which was already added right above it by
> commit 855ad7af2bd6 ("shared memory: Define PCI capability"). Remove the
> duplicate paragraph.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Cornelia, I think this can go in under the trivial fixes rule.

> ---
> This applies onto "Fix copy/paste bug in PCI transport paragraph", that
> fixes both paragraph titles.
> https://lists.oasis-open.org/archives/virtio-comment/202108/msg00097.html
> ---
>  content.tex | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 4418ac8..54f7441 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1149,14 +1149,6 @@ \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Vi
>  
>  The \field{cap.id} MUST be unique for any one device instance.
>  
> -\devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> -
> -The region defined by the combination of the \field {cap.offset},
> -\field {cap.offset_hi}, and \field {cap.length}, \field
> -{cap.length_hi} fields MUST be contained within the declared bar.
> -
> -The \field{cap.id} MUST be unique for any one device instance.
> -
>  \subsubsection{Vendor data capability}\label{sec:Virtio
>  Transport Options / Virtio Over PCI Bus / PCI Device Layout /
>  Vendor data capability}
> -- 
> 2.33.0

