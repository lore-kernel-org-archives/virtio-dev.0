Return-Path: <virtio-dev-return-9338-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1660986471
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 12:46:30 +0000 (UTC)
Date: Tue, 1 Mar 2022 07:46:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220301074608-mutt-send-email-mst@kernel.org>
References: <20220301120021.147070-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220301120021.147070-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document that the capacity field can change
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 01, 2022 at 12:00:21PM +0000, Stefan Hajnoczi wrote:
> Block devices can change size during operation. A configuration change
> notification is sent by the device and the driver detects that the field
> has changed. Document this behavior that has already been implemented in
> Linux and QEMU since 2011.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

github issue so we can track this?

> ---
>  content.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index c6f116c..96d2aa9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4863,6 +4863,9 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
>  
> +The driver SHOULD check if the content of the \field{capacity} field has
> +changed upon receiving a configuration change notification.
> +
>  A driver MUST NOT submit a request which would cause a read or write
>  beyond \field{capacity}.
>  
> @@ -4909,6 +4912,10 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  
>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
>  
> +The device MAY change the content of the \field{capacity} field during
> +operation of the device. When this happens, the device SHOULD trigger a
> +configuration change notification.
> +
>  A device MUST set the \field{status} byte to VIRTIO_BLK_S_IOERR
>  for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
>  write any data.
> -- 
> 2.35.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

