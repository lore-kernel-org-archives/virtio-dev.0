Return-Path: virtio-dev-return-6393-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E24B6985CAF
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 07:36:36 +0000 (UTC)
Date: Mon, 25 Nov 2019 02:36:32 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <928289982.36200800.1574667392106.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191124124344.262655-1-mst@redhat.com>
References: <20191124124344.262655-1-mst@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-rng: fix device/driver confusion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


> 
> The point of rng is to give data to driver so of course
> all buffers are driver readable. What shouldn't be there
> is device readable buffers - this matches our terminology
> elsewhere too (read/write-ability is from POV of device).
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/55
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index 678afbe..72e832e 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4721,7 +4721,7 @@ \subsection{Device Operation}\label{sec:Device Types /
> Entropy Device / Device O
>  
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy
>  Device / Device Operation}
>  
> -The driver MUST NOT place driver-readable buffers into the queue.
> +The driver MUST NOT place device-readable buffers into the queue.
>  
>  The driver MUST examine the length written by the device to determine
>  how many random bytes were received.
> --
> MST
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

