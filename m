Return-Path: <virtio-dev-return-9434-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF075983D97
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Apr 2022 03:05:32 +0000 (UTC)
Message-ID: <1650769506.7842305-1-xuanzhuo@linux.alibaba.com>
Date: Sun, 24 Apr 2022 11:05:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v4] virtio-net: support reset queue
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 22 Feb 2022 14:52:41 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> This patch defines some requirements for virtio-net to support reset
> queues.

Is there any problem with this?

Thanks.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index c6f116c..45751f4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4337,6 +4337,10 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \field{virtqueue_pairs} once it has placed the
>  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in a used buffer.
>
> +If the destination receive queue is in reset state(See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}),
> +the device SHOULD re-select a different random queue. If all receive queues are
> +in reset state, the device MUST drop the packet.
> +
>  \subparagraph{Legacy Interface: Automatic receive steering in multiqueue mode}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interface: Automatic receive steering in multiqueue mode}
>  When using the legacy interface, transitional devices and drivers
>  MUST format \field{virtqueue_pairs}
> @@ -4425,6 +4429,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
>  \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
>  \item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
> +\item If the destination receive queue is in reset state(See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
>  \end{itemize}
>
>  \paragraph{Offloads State Configuration}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration}
> --
> 2.31.0
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

