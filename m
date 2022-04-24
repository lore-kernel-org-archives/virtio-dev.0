Return-Path: <virtio-dev-return-9437-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E1F6983F05
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Apr 2022 06:53:54 +0000 (UTC)
Date: Sun, 24 Apr 2022 02:53:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220424024747-mutt-send-email-mst@kernel.org>
References: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v4] virtio-net: support reset queue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 22, 2022 at 02:52:41PM +0800, Xuan Zhuo wrote:
> This patch defines some requirements for virtio-net to support reset
> queues.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Suggest creating a github issue documenting that it is not defined
what the behaviour is, so we rememeber to list this as a known issue
in 1.2.


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

Should this be "a reset state"? Also, I do not see any definition of "reset state" in
the linked chapter. That chapter should really be cleaned up btw.

> +the device SHOULD re-select a different random queue.

different from what?

I suspect we want to move this:

When multiqueue is enabled by VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command, the device MUST use automatic receive steering
based on packet flow. Programming of the receive steering
classificator is implicit. After the driver transmitted a packet of a
flow on transmitqX, the device SHOULD cause incoming packets for that flow to
be steered to receiveqX. For uni-directional protocols, or where
no packets have been transmitted yet, the device MAY steer a packet
to a random queue out of the specified receiveq1\ldots receiveqn.



to a conformance chapter, and be replaced with a general description
avoiding conformance keyworkds like MUST and SHOULD.


Generally, whenever we have conformance keywords out of conformance
clauses it's a bug and source of confusion at some point.


> If all receive queues are
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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

