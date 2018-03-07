Return-Path: virtio-return-2970-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 11:56:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307115606.2d7b3368.cohuck@redhat.com>
In-Reply-To: <1519860484-7936-10-git-send-email-mst@redhat.com>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
	<1519860484-7936-10-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v9 09/16] split-ring: typo: aligment
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 1 Mar 2018 01:31:34 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> ---
>  split-ring.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/split-ring.tex b/split-ring.tex
> index a594d41..87ecee2 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -23,7 +23,7 @@ Each virtqueue consists of three parts:
>  where each part is physically-contiguous in guest memory,
>  and has different alignment requirements.
>  
> -The memory aligment and size requirements, in bytes, of each part of the
> +The memory alignment and size requirements, in bytes, of each part of the
>  virtqueue are summarized in the following table:
>  
>  \begin{tabular}{|l|l|l|}

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

