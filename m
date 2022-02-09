Return-Path: <virtio-dev-return-9288-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC96C9863C3
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Feb 2022 09:23:24 +0000 (UTC)
Date: Wed, 9 Feb 2022 04:23:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220209042121-mutt-send-email-mst@kernel.org>
References: <20220209090158.49162-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220209090158.49162-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH] virtio-net: support reset queue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 09, 2022 at 05:01:58PM +0800, Xuan Zhuo wrote:
> This patch defines some requirements for virtio-net to support reset
> queues.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  conformance.tex |  2 ++
>  content.tex     | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 42f8537..52b4879 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -136,6 +136,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Packet Transmission}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Setting Up Receive Buffers}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Reset Virtqueue}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
> @@ -396,6 +397,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Packet Transmission}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Setting Up Receive Buffers}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Reset Virtqueue}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
> diff --git a/content.tex b/content.tex
> index c6f116c..ce8e37a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4000,6 +4000,25 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>  \end{lstlisting}
>  
> +\subsubsection{Reset Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Reset Virtqueue}
> +
> +The receive and transmission virtqueues can implement reset based on Virtqueue
> +Reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> +
> +\drivernormative{\paragraph}{Gratuitous Packet Sending}{Device Types / Network Device / Device Operation / Reset Virtqueue}
> +
> +The driver MUST NOT reset the control virtqueue.

Why not though? I am guessing if it does and command is in
progress, it won't know if it completed. So it's safest to retry
then? Reset as a way to recover from a VQ error seems useful for CVQ,
I don't like disabling it like this.
Besides, it's probably too late to make this change for 1.2 ...

> +
> +\devicenormative{\paragraph}{Gratuitous Packet Sending}{Device Types / Network Device / Device Operation / Reset Virtqueue}
> +
> +After automatic receive steering or RSS receive steering has completed the
> +selection of the queue, if the destination receive queue is in reset state,
> +the device MUST re-select a different random queue. If all receive queues are in
> +reset state, the device can drop the packet.
> +
> +A virtio-net device MUST support the above requirements in order to support
> +VIRTIO_F_RING_RESET.
> +

This is more a quality of implementation issue, no? So I'd say SHOULD
here.

>  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
>  
>  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> -- 
> 2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

