Return-Path: virtio-dev-return-6969-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4719498432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Mar 2020 13:56:35 +0000 (UTC)
References: <20200323132021.2108049-1-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <49986620-9fc3-503d-4976-47a86fe3b467@redhat.com>
Date: Mon, 23 Mar 2020 14:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200323132021.2108049-1-jean-philippe@linaro.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] virtio-iommu: Remove invalid requirement
 about padding
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi jean,
On 3/23/20 2:20 PM, Jean-Philippe Brucker wrote:
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
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

