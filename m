Return-Path: virtio-dev-return-4925-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B46E985B7B
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Oct 2018 11:01:34 +0000 (UTC)
Date: Tue, 30 Oct 2018 12:01:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181030120120.0d0fddf6.cohuck@redhat.com>
In-Reply-To: <1540891712-10001-3-git-send-email-danielm@mellanox.com>
References: <1540891712-10001-1-git-send-email-danielm@mellanox.com>
	<1540891712-10001-3-git-send-email-danielm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH 2/2] queue_size: renamed "hypervisor" to
 "device"
To: Daniel Marcovitch <danielm@mellanox.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 30 Oct 2018 11:28:32 +0200
Daniel Marcovitch <danielm@mellanox.com> wrote:

> fixed to be consistent with the device/driver terminology in other surrounding descriptions
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index fb168a0..3ae3eb2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -794,7 +794,7 @@ struct virtio_pci_common_cfg {
>  
>  \item[\field{queue_size}]
>          Queue Size.  On reset, specifies the maximum queue size supported by
> -        the hypervisor. This can be modified by driver to reduce memory requirements.
> +        the device. This can be modified by driver to reduce memory requirements.

Makes sense. But perhaps s/driver/the driver/ as well?

>          A 0 means the queue is unavailable.
>  
>  \item[\field{queue_msix_vector}]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

