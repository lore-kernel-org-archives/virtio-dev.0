Return-Path: <virtio-dev-return-8733-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72CD598645B
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Sep 2021 10:20:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210928075535.100384-3-xuanzhuo@linux.alibaba.com>
References: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
 <20210928075535.100384-3-xuanzhuo@linux.alibaba.com>
Date: Tue, 28 Sep 2021 12:20:46 +0200
Message-ID: <877df157cx.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 2/3] virtio: pci support virtqueue reset
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> PCI support virtqueue reset.
>
> virtio_pci_common_cfg add "queue_reset" to support virtqueue reset.
> The driver uses this to selectively reset the queue.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

(...)

> @@ -1020,6 +1027,20 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  
>  The device MUST present a 0 in \field{queue_enable} on reset.
>  
> +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> +\field{queue_enable} after the driver has reset the virtqueue via
> +\field{queue_reset}.
> +
> +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> +\field{queue_reset} on reset.
> +
> +If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in

s/The/the/

> +\field{queue_reset} after the virtqueue is enabled with \field{queue_enable}.
> +
> +The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> +present a 1 in \field{queue_reset} after the queue has been reset, until the
> +driver re-enables the queue via \field{queue_enable}. (see \ref{sec:Virtqueues / Virtqueue Reset}).

"...or the device is reset." ?

Maybe also

"The device MAY change the value of \field{queue_size} if the queue has
been reset." ?

Should it always set that field to the currently maximum supported queue
size (assuming that can change dynamically)? Do we need some kind of
synchronization for those changes?

> +
>  The device MUST present a 0 in \field{queue_size} if the virtqueue
>  corresponding to the current \field{queue_select} is unavailable.
>  
> @@ -1044,6 +1065,13 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  
>  The driver MUST NOT write a 0 to \field{queue_enable}.
>  
> +If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> +\field{queue_reset} to reset the queue, it MUST verify that the queue
> +has been reset by reading back \field{queue_reset} and ensuring that it
> +is 1. The driver MAY re-enable the queue by writing a 1 to
> +\field{queue_enable} after ensuring that the other virtqueue fields have
> +been set up correctly. (see \ref{sec:Virtqueues / Virtqueue Reset}).

Maybe also something like

"The driver MAY set driver-writeable queue configuration values to
different values than those that were used before the queue reset."

?

> +
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>  
>  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

