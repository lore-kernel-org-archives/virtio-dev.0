Return-Path: virtio-return-2772-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <20170712095016.9926-1-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 17 Jul 2017 17:21:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170712095016.9926-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <af0491c2-6ce1-6775-0f50-67c51ee5d956@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v2] virtio-net: fix virtqueue numbering error
To: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 07/12/2017 11:50 AM, Cornelia Huck wrote:
> receiveq(n) is at position 2(n-1), not 2n. Same error for transmitq(n)
> and controlq.
> 
> VIRTIO-161
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> v1->v2: fix description
>         use 2N for controlq [Stefan]
> ---
>  content.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index d8bde3a..19f84c8 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3064,9 +3064,9 @@ features.
>  \item[0] receiveq1
>  \item[1] transmitq1
>  \item[\ldots]
> -\item[2N] receiveqN
> -\item[2N+1] transmitqN
> -\item[2N+2] controlq
> +\item[2(N-1)] receiveqN
> +\item[2(N-1)+1] transmitqN
> +\item[2N] controlq
>  \end{description}
> 
>   N=1 if VIRTIO_NET_F_MQ is not negotiated, otherwise N is set by
> 

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

I would actually prefer
 +\item[2N-2] receiveqN
 +\item[2N-1] transmitqN
 +\item[2N] controlq
as I don't think we have to spell out  that the n-th tq is
at the index 2n + 1 and the n-th rq is at the index of 2n at all and
especially not in this listing. 

But, I'm fine with this too.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

