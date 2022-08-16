Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <4ff5d76d-d5a3-8870-be2b-03eafa5e3d90@nvidia.com>
Date: Wed, 17 Aug 2022 01:31:55 +0300
Subject: Re: [PATCH RFC v7 4/8] Add admin_queue_index register to PCI common
 configuration structure
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-5-mst@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220812171841.12183-5-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/2022 8:19 PM, Michael S. Tsirkin wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> This new register will be used for querying the index of the admin
> virtqueue of a virtio device. To configure, reset or enable the admin
> virtqueue, the driver should follow existing queue configuration/setup
> sequence.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   content.tex | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 6ce1c07..297cb4a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -904,6 +904,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           le64 queue_device;              /* read-write */
>           le16 queue_notify_data;         /* read-only for driver */
>           le16 queue_reset;               /* read-write */
> +
> +        /* About the administration virtqueue. */
> +        le16 admin_queue_index;         /* read-only for driver */
>   };
>   \end{lstlisting}
>   
> @@ -989,6 +992,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           This field exists only if VIRTIO_F_RING_RESET has been
>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +\item[\field{admin_queue_index}]
> +        The device uses this to report the index of the administration virtqueue.
> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> +
>   \end{description}
>   
>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> @@ -1075,6 +1082,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>   were used before the queue reset.
>   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +If VIRTIO_F_ADMIN_VQ has been negotiated, the driver MUST
> +configure the administration virtqueue using the value of \field{admin_queue_index}.
> +
>   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>   
>   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -6947,6 +6957,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>   
>     \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +	  as the transport.
>   
>   \end{description}
>   

Looks good.

