Return-Path: <david.edmondson@oracle.com>
References: <20230223023521.159959-1-parav@nvidia.com>
 <20230223023521.159959-2-parav@nvidia.com>
From: David Edmondson <david.edmondson@oracle.com>
Subject: Re: [PATCH v4 1/2] virtio-net: Describe dev cfg fields read only
Date: Thu, 23 Feb 2023 10:10:20 +0000
In-reply-to: <20230223023521.159959-2-parav@nvidia.com>
Message-ID: <m2o7pkd73p.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


On Thursday, 2023-02-23 at 04:35:20 +02, Parav Pandit wrote:
> Device configuration fields are read only. Avoid duplicating this
> description for multiple fields.
>
> Instead describe it one time and do it in the driver requirements
> section.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/161
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Minor comment below.

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v3->v4:
> - write driver requirement as normative statement
> - add back read only wording in the description
> v2->v3:
> - split as new patch
> ---
>  device-types/net/description.tex | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 73501b6..821f7b0 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -156,25 +156,28 @@ \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network
>  \subsection{Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout}
>  
> -Device configuration fields are listed below, they are read-only for a driver. The \field{mac} address field
> -always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
> -\field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
> -read-only bits (for the driver) are currently defined for the status field:
> -VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> +Device configuration fields are listed below. All the device

"All of the"

> +configuration fields are read-only for the driver.
> +
> +The \field{mac} address field always exists (though is only
> +valid if VIRTIO_NET_F_MAC is set), and \field{status} only
> +exists if VIRTIO_NET_F_STATUS is set. Two bits are currently
> +defined for the status field: VIRTIO_NET_S_LINK_UP and
> +VIRTIO_NET_S_ANNOUNCE.
>  
>  \begin{lstlisting}
>  #define VIRTIO_NET_S_LINK_UP     1
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
> @@ -264,6 +267,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  
>  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>  
> +The driver MUST NOT write to any of the device configuration fields.
> +
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
>  If the driver negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set
>  the physical address of the NIC to \field{mac}.  Otherwise, it SHOULD
-- 
What did you learn today? I learnt nothing.

