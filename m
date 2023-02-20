Return-Path: <virtio-dev-return-11130-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
References: <20230217154529.33508-1-parav@nvidia.com>
 <20230217154529.33508-2-parav@nvidia.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 20 Feb 2023 14:46:04 +0000
In-reply-to: <20230217154529.33508-2-parav@nvidia.com>
Message-ID: <m2bkloe6o6.fsf@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 1/2] virtio-net: Describe dev cfg fields
 read only
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On Friday, 2023-02-17 at 17:45:28 +02, Parav Pandit wrote:
> Device configuration fields are read only. Avoid duplicating this
> description for multiple fields.
>
> Instead describe it one time and do it in the driver requirements
> section.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/161
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v2->v3:
> - split as new patch
> ---
>  device-types/net/description.tex | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index a197e1a..81e1135 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -156,10 +156,10 @@ \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network
>  \subsection{Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout}
>  
> -Device configuration fields are listed below, they are read-only for a driver. The \field{mac} address field
> +Device configuration fields are listed below. The \field{mac} address field
>  always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
>  \field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
> -read-only bits (for the driver) are currently defined for the status field:
> +bits (for the driver) are currently defined for the status field:
>  VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
>  
>  \begin{lstlisting}
> @@ -167,14 +167,14 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  #define VIRTIO_NET_S_ANNOUNCE    2
>  \end{lstlisting}
>  
> -The following driver-read-only field, \field{max_virtqueue_pairs} only exists if
> +The following field, \field{max_virtqueue_pairs} only exists if
>  VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set. This field specifies the maximum number
>  of each of transmit and receive virtqueues (receiveq1\ldots receiveqN
>  and transmitq1\ldots transmitqN respectively) that can be configured once at least one of these features
>  is negotiated.
>  
> -The following driver-read-only field, \field{mtu} only exists if
> -VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driver to
> +The following field, \field{mtu} only exists if VIRTIO_NET_F_MTU
> +is set. This field specifies the maximum MTU for the driver to
>  use.
>  
>  The following two fields, \field{speed} and \field{duplex}, only
> @@ -261,6 +261,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  
>  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>  
> +All the device configuration fields are read-only for the driver.
> +
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
>  If the driver negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set
>  the physical address of the NIC to \field{mac}.  Otherwise, it SHOULD
-- 
I'm not the reason you're looking for redemption.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

