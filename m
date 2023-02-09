Return-Path: <mst@redhat.com>
Date: Thu, 9 Feb 2023 07:18:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio-net: Improve introductory description
Message-ID: <20230209071430-mutt-send-email-mst@kernel.org>
References: <20230209014108.209950-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230209014108.209950-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09, 2023 at 03:41:08AM +0200, Parav Pandit wrote:
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
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> This patch is on top of [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00280.html
> ---
> changelog:
> v2->v3:
> - further improve introduction
> v1->v2:
> - corrected/added article before transmit and receive virtqueue
> - replaced listed with described
> - updated set to negotiated for CTRL_VQ
> - improved introduction wordings
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
>  device-types/net/description.tex | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 88a5770..bdf4810 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -2,13 +2,15 @@ \section{Network Device}\label{sec:Device Types / Network Device}
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
> +to the Ethernet network. The device has transmit and receive
> +queues. The driver posts empty buffers in the receive virtqueue.
> +The device receives the incoming packets

s/the//  - 1st time we mention packets

> from the link; the device
> +places these incoming packets in the receive virtqueue buffers.
> +The driver enqueues outgoing packets to the transmit virtqueue. The device
> +dequeues these packets from the transmit virtqueue and sends them to
> +the link. The device may have a control virtuqueue. The driver
> +uses the control virtqueue to dynamically manipulate various
> +features of the initialized device.
>  
>  \subsection{Device ID}\label{sec:Device Types / Network Device / Device ID}
>  
> @@ -28,7 +30,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
>   N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, otherwise N is set by
>   \field{max_virtqueue_pairs}.
>  
> - controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
> +controlq is optional; it only exists if VIRTIO_NET_F_CTRL_VQ is
> +negotiated.
>  
>  \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits}
>  
> @@ -389,8 +392,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>  };
>  \end{lstlisting}
>  
> -The controlq is used to control device features such as
> -filtering.
> +The controlq is used to control many device features described further in

many seems subjective.

s/many/some of the/ ?

> +section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue}.
>  
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Network Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.26.2

