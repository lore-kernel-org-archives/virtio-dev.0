Return-Path: <virtio-dev-return-10688-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C24F98671B
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Feb 2023 10:17:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230123171136.1142000-1-parav@nvidia.com>
References: <20230123171136.1142000-1-parav@nvidia.com>
Date: Wed, 01 Feb 2023 11:17:52 +0100
Message-ID: <87357phepb.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] virtio-net: Improve introductory description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 23 2023, Parav Pandit <parav@nvidia.com> wrote:

> The control VQ of the virtio network device is used beyond advance
> steering control. The control VQ dynamically changes multiple features
> of the initialized device.
>
> Hence, update this area of control VQ introductory description at few
> places and also place the link to its description.
>
> Also update the introduction section to better describe receive and
> transmit virtqueues.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156

Can you maybe also tweak the description in the github issue, as it is
not only about the controlq anymore?

> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> This patch is on top of [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00280.html
> ---
> changelog:
> v0->v1:
> - replaced command queue to control virtqueue to reflect current state
> - added link of control vq to its detailed section
> - removed reference of cvq from more places that limits it to steering
> - Addressed Cornelia's review comments:
> - updated introduction section to better describe rq, sq, cvq.
> - explicitly wrote that cvq is optional along with its feature bit
>   related description
> - dropped few items from Cornelia's review as they do not exactly
>   fit with latest 1.2 specification as below.
>   - avoided listing number of queues in introduction as its linked to q
>     reset which can disable all queues
>   - avoid mentioning cvq as optional as there is better section for it
>   - avoid talking about queue pairs as spec and use cases allows not
>     operate in pairs mode
> ---
>  device-types/net/description.tex | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index e1341e6..e32780b 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -2,13 +2,13 @@ \section{Network Device}\label{sec:Device Types / Network Device}
>  
>  The virtio network device is a virtual network interface controller.
>  It consists of a virtual Ethernet link which connects the device
> -to the Ethernet network. It is the most complex of the devices
> -supported so far by virtio. It has enhanced rapidly and demonstrates
> -clearly how support for new features are added to an existing
> -device. Empty buffers are placed in one virtqueue for receiving
> -packets, and outgoing packets are enqueued into another for
> -transmission in that order. A third command queue is used to
> -control advanced filtering features.
> +to the Ethernet network. The driver posts empty buffers in a
> +receive virtqueue. The device receives the incoming packets from the link;
> +the device places these incoming packets in a receive virtqueue buffers.

"and places these incoming packets into receive virtqueue buffers." ?

> +The driver enqueues outgoing packets to a transmit virtqueue. The device
> +dequeues packets from the transmit virtqueue and sends packets to
> +the link.

"and sends these packets to the link." ?

> A control virtqueue is used to dynamically manipulate various
> +features of the initialized device.
>  
>  \subsection{Device ID}\label{sec:Device Types / Network Device / Device ID}
>  
> @@ -28,7 +28,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
>   N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, otherwise N is set by
>   \field{max_virtqueue_pairs}.
>  
> - controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
> +controlq is optional; it only exists if VIRTIO_NET_F_CTRL_VQ set.

"it only exists if VIRTIO_NET_F_CTRL_VQ is set" ?

>  
>  \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits}
>  
> @@ -389,8 +389,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>  };
>  \end{lstlisting}
>  
> -The controlq is used to control device features such as
> -filtering.
> +The controlq is used to control many device features listed further in

s/listed/described/ ?

> +section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue}.
>  
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Network Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

