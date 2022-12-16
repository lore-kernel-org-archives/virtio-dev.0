Return-Path: <mst@redhat.com>
Date: Fri, 16 Dec 2022 07:49:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio_net: support inner header hash
Message-ID: <20221216074415-mutt-send-email-mst@kernel.org>
References: <20221205063639.127767-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20221205063639.127767-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 05, 2022 at 02:36:39PM +0800, Heng Qi wrote:
> @@ -4005,6 +4159,24 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>  \end{lstlisting}
>  
> +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
> +\field{hash_report_tunnel} can report the type of the tunnel-encapsulated
> +packet to the driver over the inner header hash calculation.
> +Possible values that the device can report in \field{hash_report_tunnel}
> +are defined below:
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_REPORT_GRE             1
> +#define VIRTIO_NET_HASH_REPORT_VXLAN           2
> +#define VIRTIO_NET_HASH_REPORT_GENEVE          3
> +\end{lstlisting}
> +
> +The values VIRTIO_NET_HASH_REPORT_GRE, VIRTIO_NET_HASH_REPORT_VXLAN and
> +VIRTIO_NET_HASH_REPORT_GENEVE correspond to VIRTIO_NET_HASH_TYPE_GRE_INNER,
> +VIRTIO_NET_HASH_TYPE_VXLAN_INNER and VIRTIO_NET_HASH_TYPE_GENEVE_INNER bits
> +of supported hash types defined in respectively
> +\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
> +
>  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
>  
>  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is

If the new feature flag is negotiated, we need to spell out more clearly what are the rules
for packets that are not encapsulated. Is hash_report_tunnel set to 0
then? Another comment is that we keep repeating GRE/VXLAN/GENEVE too
many times. Let's add a paragraph defining a concept e.g. a "tunnel" or
"tunneled packets", explaining how they are handled at a high level,
and then just refer to the tunnel everywhere.
Let's also add external references to specifications documenting the
relevant tunnel types.


> -- 
> 2.19.1.6.gb485710b

