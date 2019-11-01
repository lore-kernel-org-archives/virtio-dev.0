Return-Path: virtio-dev-return-6278-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Fri, 1 Nov 2019 10:51:03 +0100
From: Stefan Fritsch <sf@sfritsch.de>
Message-ID: <20191101095103.dzvp33djoupiyrcu@manul.sfritsch.de>
References: <20191101082342.18687-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101082342.18687-1-mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: document speed, dupex
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 19-11-01 04:23, Michael S. Tsirkin wrote:
> Document as used by Linux.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index bff80d0..e89ae44 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2951,12 +2951,29 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driver to
>  use.
>  
> +The following two fields, \field{speed} and \field{duplex} only
> +exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
> +
> +\field{speed} is the device speed, in units of 1MByte, 0 to
> +0x7FFFF. Driver MUST also treat any
> +other value as representing an unknown duplex state.

This should be "an unknown speed"?

> +
> +\field{duplex} has the values of 0x00 for full duplex, 0x01 for
> +half duplex and 0xff for unknown. Driver MUST also treat any
> +other value as representing an unknown duplex state.
> +
> +Neither \field{speed} not \field{duplex} changes as long as
> +VIRTIO_NET_S_LINK_UP is set.
> +

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

