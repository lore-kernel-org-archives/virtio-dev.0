Return-Path: <virtio-dev-return-10201-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B560D986435
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 Nov 2022 14:46:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-6-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-6-mst@redhat.com>
Date: Tue, 22 Nov 2022 15:46:38 +0100
Message-ID: <87zgcjdp2p.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v8 5/9] pci: add admin vq registers to virtio over pci
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Add new registers to the PCI common configuration structure.
>
> These registers will be used for querying the indices of the admin
> virtqueues of the owner device. To configure, reset or enable the admin
> virtqueues, the driver should follow existing queue configuration/setup
> sequence.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

(...)

> @@ -1112,6 +1129,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>  
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> +configures any administration virtqueues, the driver MUST
> +configure the administration virtqueues using the index
> +in the range \field{admin_queue_index} to
> +\field{admin_queue_index} + \field{admin_queue_num} inclusive.
> +The driver MAY configure less administration virtqueues than
> +supported by the device.

Is the driver allowed to pick any admin queue from within the range,
e.g. queues 2 and 5, and leave the rest?

> +
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>  
>  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -6986,6 +7011,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>  
>    \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +	  as the transport and is reserved for future use for
> +	  devices using other transports (see
> +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
> +	and
> +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
> +	handling features reserved for future use.
>  
>  \end{description}
>  

We don't say for any other feature which transports support it; do we
really need to state it here explicitly if we have the rules for
reserved feature bits in place? It simply will be neither offered nor
accepted if the device and driver use an unsupported transport.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

