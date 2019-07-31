Return-Path: virtio-dev-return-5905-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8806D985BC1
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 12:18:12 +0000 (UTC)
Date: Wed, 31 Jul 2019 14:18:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190731141806.141ef751.cohuck@redhat.com>
In-Reply-To: <20190731121214.14099-1-ndragazis@arrikto.com>
References: <20190729154841.GH2756@work-vm>
	<20190731121214.14099-1-ndragazis@arrikto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: fix typo
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, dgilbert@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 31 Jul 2019 15:12:14 +0300
Nikos Dragazis <ndragazis@arrikto.com> wrote:

> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index ee0d7c9..f8ebf14 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -749,7 +749,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  \end{description}
>  
>  A variant of this type, struct virtio_pci_cap64, is defined for
> -those capaibilites that require offsets or lengths larger than
> +those capabilities that require offsets or lengths larger than
>  4GiB:
>  
>  \begin{lstlisting}

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

