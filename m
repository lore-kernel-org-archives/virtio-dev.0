Return-Path: virtio-dev-return-5627-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BE83985F80
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Mar 2019 11:00:53 +0000 (UTC)
Date: Fri, 15 Mar 2019 07:00:51 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1473488054.12940616.1552647651571.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180518044106.31357-1-pagupta@redhat.com>
References: <20180518044106.31357-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID for virtio-pmem
 devices
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


ping. 

I have also opened a github issue[1] for the same.

[1] https://github.com/oasis-tcs/virtio-spec/issues/38

Thanks,
Pankaj

> 
> We need a device ID for virtio-pmem devices. As 24 is already
> requested by virtio-mem, so requesting next available(25)
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 7a92cb1..ef75dc5 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2432,6 +2432,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  23         &   IOMMU device \\
>  \hline
> +25         &   PMEM device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> --
> 2.14.3
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

