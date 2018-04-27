Return-Path: virtio-dev-return-3985-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 290845818E8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 08:06:26 -0700 (PDT)
Date: Fri, 27 Apr 2018 18:06:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180427180541-mutt-send-email-mst@kernel.org>
References: <20180427113624.15020-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427113624.15020-1-david@redhat.com>
Subject: [virtio-dev] Re: [PATCH v1] content: reserve virtio device ID for memory devices
To: David Hildenbrand <david@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 27, 2018 at 01:36:24PM +0200, David Hildenbrand wrote:
> Reserve device ID 24 for virtio-mem devices.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

OK pls open a github issue and send a Fixes: tag here.
Then we can vote this in.

> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 7a92cb1..bf63be8 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2432,6 +2432,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  23         &   IOMMU device \\
>  \hline
> +24         &   Memory device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> -- 
> 2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

