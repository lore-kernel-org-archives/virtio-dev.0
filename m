Return-Path: <virtio-dev-return-10715-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BFDD9862AE
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Feb 2023 16:39:13 +0000 (UTC)
Date: Sun, 5 Feb 2023 11:39:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230205113759-mutt-send-email-mst@kernel.org>
References: <20230205120801.1419067-1-alvaro.karsz@solid-run.com>
 <20230205151911.19678-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230205151911.19678-1-alvaro.karsz@solid-run.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: Mention VIRTIO_NET_F_HASH_REPORT
 dependency on VIRTIO_NET_F_CTRL_VQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Feb 05, 2023 at 05:19:11PM +0200, Alvaro Karsz wrote:
> If the VIRTIO_NET_F_HASH_REPORT feature is negotiated, the driver may
> send VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands, thus, the control VQ
> feature should be negotiated.
> 
> ---
> v2: Use SHOULD instead of Feature bit requirement, version 1.2 is already
>     out and doesn't include this depencency.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> 
>  device-types/net/description.tex | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 700a1cb..4270481 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -256,6 +256,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  \field{duplex} fields as long as VIRTIO_NET_S_LINK_UP is set in
>  the \field{status}.
>  
> +The device SHOULD offer VIRTIO_NET_F_HASH_REPORT only if it offers
> +VIRTIO_NET_F_CTRL_VQ as well.
> +

That only is confusing. Either say if A then B or if not A then not be.

>  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>  
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> @@ -289,6 +292,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  SHOULD re-read \field{speed} and \field{duplex} after a
>  configuration change notification.
>  
> +The driver SHOULD negotiate VIRTIO_NET_F_HASH_REPORT only if it negotiates VIRTIO_NET_F_CTRL_VQ.
> +

Same.

>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

