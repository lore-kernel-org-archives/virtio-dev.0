Return-Path: virtio-dev-return-5317-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B20E4985AE5
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Jan 2019 21:19:30 +0000 (UTC)
Date: Fri, 11 Jan 2019 16:19:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190111161807-mutt-send-email-mst@kernel.org>
References: <20181212152754.12285-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212152754.12285-1-stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: reserve virtio device ID for file
 system devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 12, 2018 at 03:27:54PM +0000, Stefan Hajnoczi wrote:
> Reserve device ID 26 for virtio-fs devices.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/31
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Stefan, could you please comment on
- Is 25 used? No one on this list seems to know ...
- should we start voting on this?

> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index b101d1b..f8d0afb 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2528,6 +2528,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  24         &   Memory device \\
>  \hline
> +26         &   file system device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> -- 
> 2.19.2
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

