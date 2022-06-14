Return-Path: <virtio-dev-return-9595-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 317C19864E2
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Jun 2022 08:52:15 +0000 (UTC)
MIME-Version: 1.0
References: <20220606121046.70163-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220606121046.70163-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Jun 2022 16:51:58 +0800
Message-ID: <CACGkMEsdivKRHb3iQV9fWDDcNvDrv2SjH4fkXFebqZTg_=_rfg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio_net: support split header
Content-Type: text/plain; charset="UTF-8"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>, hengqi@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 6, 2022 at 8:11 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> The purpose of this feature is to split the header and the payload of
> the packet.
>
> |                    receive buffer                                    |
> |                       0th descriptor             | 1th descriptor    |
> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
>
> We can use a buffer plus a separate page when allocating the receive
> buffer. In this way, we can ensure that all payloads can be
> independently in a page, which is very beneficial for the zerocopy
> implemented by the upper layer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> 1. Fix some syntax issues
> 2. Fix some terminology issues
> 3. It is not unified with ip alignment, so ip alignment is not included
> 4. Make it clear that the device must support four types, in the case of
> successful negotiation.
>
>  conformance.tex |  2 ++
>  content.tex     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/conformance.tex b/conformance.tex
> index 663e7c3..6f561fb 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
>  \end{itemize}
>
>  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
> @@ -411,6 +412,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
>  \end{itemize}
>
>  \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
> diff --git a/content.tex b/content.tex
> index 7508dd1..a5a29d2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports to split the protocol
> +    header and the payload.
> +
>  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
>   (fragmenting the packet) the USO splits large UDP packet
>   to several segments when each of these smaller packets has UDP header.
> @@ -3131,6 +3134,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
>
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -3362,6 +3366,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>  #define VIRTIO_NET_HDR_F_DATA_VALID    2
>  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
>          u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE        0
>  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> @@ -4463,6 +4468,83 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  according to the native endian of the guest rather than
>  (necessarily when not using the legacy interface) little-endian.
>
> +\paragraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> +
> +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
> +the device supports to split the protocol header and the payload.
> +The protocol header and the payload will be separated into different
> +descriptors.
> +
> +\subparagraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}
> +
> +To configure the split header, the following layout structure and definitions
> +are used:
> +
> +\begin{lstlisting}
> +struct virtio_net_split_header_config {
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     1
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     2
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     4
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     8
> +    le64 type;
> +};
> +
> +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> +\end{lstlisting}
> +
> +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuration.
> +
> +The driver can enable or disable the split header by setting or clearing
> +corresponding bits in \field{type}.
> +
> +The protocol header contains all headers before level 4 payload.

So if the split header means only for level 4 we need to clarify it in
the above feature definition.

Or is it worthwhile to leave space to split at level 3? (E.g modern
NICs can do splitting at various layer, l2/l3 and inner)

> For ip
> +fragmented packets, except for the first fragment, the protocol header only
> +contains all headers before level 3 payload.

Does it mean the device needs to track the fragment ID and only do
this for the L4 protocol that is set via
VIRTIO_NET_CTRL_SPLIT_HEADER_SET?

This looks complicates the design of the device and it doesn't help
too much since most segmentations are smaller than page size

> +
> +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> +
> +Split header MUST be disabled upon device reset.
> +
> +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
> +VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
> +VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
> +
> +A device MUST NOT perform split header in the following cases:
> +\begin{itemize}
> +    \item device does not recognize the protocol of the packet.
> +    \item \field{type} does not include the protocol of the packet.
> +    \item the buffer consists of only one descriptor.
> +    \item the virtio net header and the protocol header exceeds the size
> +        of the first descriptor.
> +    \item If VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
> +        payload exceeds the size of the buffer chain starting from the 2nd

I think it's a "descriptor chain" instead of a buffer chain, since we
can't use the buffer chain if MRG_RXBUF is not negotiated.

> +        descriptor.
> +\end{itemize}
> +
> +If the header is split by the device, the \field{flags} of structure
> +virtio_net_hdr MUST contains VIRTIO_NET_HDR_F_SPLIT_HEADER. The protocol header

s/contains/contain/

> +MUST be on the buffer specified by the first descriptor, following the virtio
> +net header. The payload MUST starts from the buffer of the second descriptor.

s/starts/start/, I think we can remove "the buffer of" otherwise it
may be confusing.

> +The device MUST set \field{hdr_len} of structure virtio_net_hdr to the length of
> +the protocol header.
> +
> +If the header is split by the device, VIRTIO_NET_F_MRG_RXBUF is negotiated,
> +and the receive packet is spread over multiple buffers, when the device uses a
> +buffer other than the first, if the buffer consists of multiple descriptors, the
> +device MUST skip the buffer of the first descriptor,

skip the first descriptor of the buffer actually?

> because the buffer of the
> +first descriptor is used to carry the protocol header.
> +
> +\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> +
> +If VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driver MUST
> +trust \field{hdr_len}.
> +
> +If the split header is enabled, the buffers submitted to receiveq by the
> +driver SHOULD at least be composed of two descriptors. The buffer specified by
> +the first descriptor SHOULD be able to accommodate the virtio net header and the
> +protocol header.

Thanks

>
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
> --
> 2.31.0
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

