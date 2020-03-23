Return-Path: virtio-dev-return-6970-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62A7098432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Mar 2020 14:09:38 +0000 (UTC)
Date: Mon, 23 Mar 2020 15:09:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200323150926.18b438de.cohuck@redhat.com>
In-Reply-To: <20200323132021.2108049-1-jean-philippe@linaro.org>
References: <20200323132021.2108049-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] virtio-iommu: Remove invalid requirement about padding
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 23 Mar 2020 14:20:22 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> This reference to 'padding' is a leftover from a previous draft of the
> virtio-iommu device. The field doesn't exist anymore, remove the
> requirement.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> I just noticed this was still here, sorry for the delay. Previous
> discussion:
> https://lists.oasis-open.org/archives/virtio-dev/201911/msg00084.html
> ---
>  virtio-iommu.tex | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> index 28c562b..08b358a 100644
> --- a/virtio-iommu.tex
> +++ b/virtio-iommu.tex
> @@ -106,8 +106,6 @@ \subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device /
>  
>  \devicenormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}
>  
> -The device SHOULD set \field{padding} to zero.
> -
>  The device MUST set at least one bit in \field{page_size_mask}, describing
>  the page granularity. The device MAY set more than one bit in
>  \field{page_size_mask}.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

