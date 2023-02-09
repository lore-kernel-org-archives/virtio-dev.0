Return-Path: <virtio-comment-return-4093-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20230209014108.209950-1-parav@nvidia.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Thu, 09 Feb 2023 12:02:36 +0000
In-reply-to: <20230209014108.209950-1-parav@nvidia.com>
Message-ID: <m2cz6j2gbz.fsf@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v3] virtio-net: Improve introductory
 description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, shahafs@nvidia.com, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On Thursday, 2023-02-09 at 03:41:08 +02, Parav Pandit wrote:
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
> +The device receives the incoming packets from the link; the device
> +places these incoming packets in the receive virtqueue buffers.
> +The driver enqueues outgoing packets to the transmit virtqueue. The
>  device

We "post" receive buffers, yet "enqueue" transmit buffers. These actions
seem the same.

Maybe "submits" in both cases?

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
> +section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue}.
>  
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Network Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
-- 
Sorry I'm not home right now, I'm walking into spiderwebs.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

