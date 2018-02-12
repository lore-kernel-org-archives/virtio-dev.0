Return-Path: virtio-return-2882-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 12 Feb 2018 13:59:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212135922.58d74542.cohuck@redhat.com>
In-Reply-To: <1518206354-29610-2-git-send-email-pasic@linux.vnet.ibm.com>
References: <1518206354-29610-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1518206354-29610-2-git-send-email-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH 1/2] ccw: be more precise the semantic of revision 1
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri,  9 Feb 2018 20:59:13 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

s/precise/precise about/

> Revision 1 of the CCW transport is currently defined as virtio 1.0. This
> could become confusing when we bump the version of the virtio
> specification to 1.1, in a sense that it could be interpreted like one
> can not use any features not part of the 1.0 specification.
> 
> So let us try to avoid confusion regarding the semantic of virtio-ccw
> revision 1.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  content.tex |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index c7ef7fd..86044dd 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2572,7 +2572,7 @@ The following values are supported:
>  \hline \hline
>  0        & 0      & <empty>   & legacy interface; transitional devices only \\
>  \hline
> -1        & 0      & <empty>   & Virtio 1.0 \\
> +1        & 0      & <empty>   & Virtio 1 \\
>  \hline
>  2        & 0      & <empty>   & CCW_CMD_READ_STATUS support \\
>  \hline

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

