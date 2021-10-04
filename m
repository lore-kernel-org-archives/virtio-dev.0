Return-Path: <virtio-dev-return-8766-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 174759862CE
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Oct 2021 10:57:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210930125847.28823-1-jean-philippe@linaro.org>
References: <20210930125847.28823-1-jean-philippe@linaro.org>
Date: Mon, 04 Oct 2021 12:56:48 +0200
Message-ID: <87k0it2h3j.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] content: Remove duplicate paragraph
Content-Type: text/plain
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 30 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
> type") had a merge issue. It includes the device normative paragraph for
> Shared memory capability, which was already added right above it by
> commit 855ad7af2bd6 ("shared memory: Define PCI capability"). Remove the
> duplicate paragraph.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

Hm. This statement is indeed included twice, but the two are not exactly
the same. For the first paragraph, do we want to use a combination of
the two? IOW, something like

"The region defined by the combination of the \field {cap.offset},
\field {cap.offset_hi}, and \field {cap.length}, \field
{cap.length_hi} fields MUST be contained within the BAR specified by
\field{cap.bar}."


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

