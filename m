Return-Path: <mst@redhat.com>
Date: Thu, 8 Sep 2022 17:18:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v7] virtio_net: support split header
Message-ID: <20220908171737-mutt-send-email-mst@kernel.org>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <86eb87af-66f2-0c3e-73d0-a116a8df1bdf@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <86eb87af-66f2-0c3e-73d0-a116a8df1bdf@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 02, 2022 at 12:12:50PM +0800, Heng Qi wrote:
> 
> 在 2022/8/16 下午5:34, Heng Qi 写道:
> 
>     From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
>     The purpose of this feature is to split the header and the payload of
>     the packet.
> 
>     |                    receive buffer                                    |
>     |                       0th descriptor             | 1th descriptor    |
>     | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
> 
>     We can use a buffer plus a separate page when allocating the receive
>     buffer. In this way, we can ensure that all payloads can be
>     independently in a page, which is very beneficial for the zerocopy
>     implemented by the upper layer.
> 
>     Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>     Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>     Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
>     ---
>     v7:
>             1. Fix some presentation issues.
>             2. Use "split transport header". @Jason Wang
>             3. Clarify some paragraphs. @Cornelia Huck
>             4. determine the device what to do if it does not perform header split on a packet.
> 
>     v6:
>             1. Fix some syntax issues. @Cornelia Huck
>             2. Clarify some paragraphs. @Cornelia Huck
>             3. Determine the device what to do if it does not perform header split on a packet.
> 
>     v5:
>             1. Determine when hdr_len is credible in the process of rx
>             2. Clean up the use of buffers and descriptors
>             3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge
> 
>     v4:
>             1. fix typo @Cornelia Huck @Jason Wang
>             2. do not split header for IP fragmentation packet. @Jason Wang
> 
>     v3:
>             1. Fix some syntax issues
>             2. Fix some terminology issues
>             3. It is not unified with ip alignment, so ip alignment is not included
>             4. Make it clear that the device must support four types, in the case of successful negotiation.
> 
>      conformance.tex |   2 ++
>      content.tex     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>      2 files changed, 104 insertions(+)
> 
>     diff --git a/conformance.tex b/conformance.tex
>     index 2b86fc6..4e2b82e 100644
>     --- a/conformance.tex
>     +++ b/conformance.tex
>     @@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>      \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>      \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>      \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>     +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header}
>      \end{itemize}
> 
>      \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
>     @@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>      \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>      \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>      \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>     +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header}
>      \end{itemize}
> 
>      \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
>     diff --git a/content.tex b/content.tex
>     index e863709..5676da9 100644
>     --- a/content.tex
>     +++ b/content.tex
>     @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>      \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>          channel.
> 
>     +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports splitting
>     +    the transport header and the payload.
>     +
>      \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> 
>      \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>     @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>      \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>      \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>      \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>     +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
>      \end{description}
> 
>      \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>     @@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>      #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>      #define VIRTIO_NET_HDR_F_DATA_VALID    2
>      #define VIRTIO_NET_HDR_F_RSC_INFO      4
>     +#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
>              u8 flags;
>      #define VIRTIO_NET_HDR_GSO_NONE        0
>      #define VIRTIO_NET_HDR_GSO_TCPV4       1
>     @@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>      been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
>      transport header size.
>      The driver MUST NOT rely on \field{hdr_len} to be correct.
>     +
>     +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is set,
>     +the driver SHOULD treat the \field{hdr_len} as the length of the transport header
>     +inside the first descriptor.
>     +
>      \begin{note}
>      This is due to various bugs in implementations.
>      \end{note}
>     @@ -4483,6 +4493,98 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>      according to the native endian of the guest rather than
>      (necessarily when not using the legacy interface) little-endian.
> 
>     +\paragraph{Split Transport Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header}
>     +
>     +If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiated,
>     +the device supports splitting the transport header and the payload.
>     +The transport header and the payload will be separated into different
>     +descriptors.
>     +
>     +\subparagraph{Split Transport Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header / Setting Split Transport Header}
>     +
>     +To configure the split transport header, the following layout structure and definitions
>     +are used:
>     +
>     +\begin{lstlisting}
>     +struct virtio_net_split_transport_header_config {
>     +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 << 0)
>     +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 << 1)
>     +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 << 2)
>     +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 << 3)
>     +    le64 type;
>     +};
>     +
>     +#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
>     + #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
>     +\end{lstlisting}
>     +
>     +The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one command:
>     +VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new split transport header configuration.
>     +
>     +The driver can enable or disable split transport header for different protocols by
>     +setting or clearing corresponding bits in \field{type}.
>     +
>     +\begin{itemize}
>     +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split after ipv4 tcp header
>     +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split after ipv6 tcp header
>     +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split after ipv4 udp header
>     +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split after ipv6 udp header
>     +\end{itemize}
>     +
>     +\devicenormative{\subparagraph}{Setting Split Transport Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header}
>     +
>     +A device MUST initialize \field{type} to 0, and MUST set it to 0
>     +upon device reset.
>     +
>     +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the device MUST support
>     +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6,
>     +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6.
>     +
>     +A device MUST NOT split the transport header if it encounters any of the following cases:
>     +\begin{itemize}
>     +    \item the device does not recognize the protocol of the packet.
>     +    \item the packet is an IP fragmentation.
>     +    \item \field{type} does not include the protocol of the packet.
>     +    \item the buffer consists of only one descriptor.
>     +    \item the total size of the virtio net header and the transport header exceeds
>     +        the size of the first descriptor.
>     +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
>     +        payload exceeds the size of the descriptor chain starting from the 2nd
>     +        descriptor.
>     +\end{itemize}
>     +
>     +If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit
>     +in \field{flags} MUST be set. The transport header MUST be on the first
>     +descriptor, following the virtio net header. The payload MUST start from the
>     +second descriptor. The device MUST set \field{hdr_len} of structure
>     +virtio_net_hdr to the length of the transport header.
>     +
>     +If all of the following applies:
>     +\begin{itemize}
>     +    \item the header is split by the device.
>     +    \item VIRTIO_NET_F_MRG_RXBUF has been negotiated.
>     +    \item the received packet is spread over multiple buffers.
>     +\end {itemize}
>     +then if the device uses the buffers after the 1st buffer, and the buffer
>     +consists of multiple descriptors, the device MUST skip the first descriptor,
>     +because the first descriptor is used to carry the transport header.
>     +The used length still reports the number of bytes it has written to memory.
>     +
>     +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, but the device does not split the
>     +virtio net header and the transport header, and the buffer consists of at least two
>     +descriptors, the device MUST start with the first descriptor to store the packet, and
>     +MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}.
>     +
>     +\drivernormative{\subparagraph}{Setting Split Transport Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header}
>     +
>     +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is set, the driver
>     +MUST treat the contents of \field{hdr_len} as the length of the transport header
>     +inside the first descriptor.
>     +
>     +If the split transport header is enabled, the buffers submitted to receiveq by the
>     +driver MUST be composed of at least two descriptors.
>     +When the buffer consists of two descriptors, the length of the first
>     +descriptor MUST be greater than the one of the virtio net header.
> 
>      \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> 
> 
> If the reviewers do not have more comments on "split header v7",
> then I submit an issue in the virtio-spec repository.
> Please vote on whether the new "split header" feature is added
> to the virtio specification.
> 
> 
> The link is https://github.com/oasis-tcs/virtio-spec/issues/144.
> 
> 
> Thanks.


I can do that if you like but I sent a bunch of comments Sept 4th.
Pls take a look.

