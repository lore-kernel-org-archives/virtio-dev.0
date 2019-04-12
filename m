Return-Path: virtio-dev-return-5665-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC855985E1A
	for <virtio-dev@lists.oasis-open.org>; Fri, 12 Apr 2019 07:57:53 +0000 (UTC)
Date: Fri, 12 Apr 2019 09:57:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190412095744.28755c76.cohuck@redhat.com>
In-Reply-To: <20190412050306.31874-1-pagupta@redhat.com>
References: <20190412050306.31874-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH] content: reserve device ID for virtio-pmem devices
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 12 Apr 2019 10:33:06 +0530
Pankaj Gupta <pagupta@redhat.com> wrote:

> We need a device ID for virtio-pmem devices. As 25 is  
> requested by audio device, so requesting next available(26).
> Also, updated the previously requested github issue[1] for
> voting.
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/38
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 193b6e1..aef7476 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2634,6 +2634,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  24         &   Memory device \\
>  \hline
> +26         &   PMEM device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

