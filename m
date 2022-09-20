Return-Path: <virtio-dev-return-9956-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B1BD9863EA
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Sep 2022 01:59:33 +0000 (UTC)
Message-ID: <3c3cc916-c605-1ed2-d3ff-d8d8ce668f17@redhat.com>
Date: Tue, 20 Sep 2022 09:59:22 +0800
MIME-Version: 1.0
References: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport
 header
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: hengqi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/9/16 10:56, hengqi =E5=86=99=E9=81=93:
> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> The purpose of this feature is to split the transport header and the payl=
oad
> of the packet.
>
> |                     receive buffer1(page)            | receive buffer2(=
page) |
> |<- offset ->| virtnet hdr | mac | ip | tcp |<- hold ->|        payload  =
      |
>               |<------------------------------->|
>                                ^
>                                |
>                             max_len
>
> We can use one page for every receive buffer. In this way, we can ensure =
that
> all payloads can be independently in a page, which is very beneficial for
> the zerocopy implemented by the upper layer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> ---
> v8:
> =091. Do not depend on descriptor chain. @Michael S. Tsirkin
> =092. Add \field{offset} and \field{max_len}.
> =093. Fix some presentation issues. @Jason Wang
> =094. Clarify some paragraphs.
>
> v7:
> =091. Fix some presentation issues.
> =092. Use "split transport header". @Jason Wang
> =093. Clarify some paragraphs. @Cornelia Huck
> =094. determine the device what to do if it does not perform header split=
 on a packet.
>
> v6:
> =091. Fix some syntax issues. @Cornelia Huck
> =092. Clarify some paragraphs. @Cornelia Huck
> =093. Determine the device what to do if it does not perform header split=
 on a packet.
>
> v5:
> =091. Determine when hdr_len is credible in the process of rx
> =092. Clean up the use of buffers and descriptors
> =093. Clarify the meaning of used lenght if the first descriptor is skipp=
ed in the case of merge
>
> v4:
> =091. fix typo @Cornelia Huck @Jason Wang
> =092. do not split header for IP fragmentation packet. @Jason Wang
>
>   conformance.tex |  2 ++
>   content.tex     | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 93 insertions(+)
>
> diff --git a/conformance.tex b/conformance.tex
> index 2b86fc6..4e2b82e 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Offloads State Configuration / Setting Offloads =
State}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Receive-side scaling (RSS) }
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Notifications Coalescing}
> +\item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Split Transport Header}
>   \end{itemize}
>  =20
>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conforman=
ce / Driver Conformance / Block Driver Conformance}
> @@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Automatic receive steering in multiqueue mode}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Notifications Coalescing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Split Transport Header}
>   \end{itemize}
>  =20
>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conforman=
ce / Device Conformance / Block Device Conformance}
> diff --git a/content.tex b/content.tex
> index e863709..fad9dea 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / =
Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>  =20
> +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports splittin=
g
> +    the transport header and the payload.
> +
>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalesc=
ing.
>  =20
>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_N=
ET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ=
 and VIRTIO_NET_F_MRG_RXBUF.
>   \end{description}
>  =20
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Network Device / Device O
>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>   #define VIRTIO_NET_HDR_F_DATA_VALID    2
>   #define VIRTIO_NET_HDR_F_RSC_INFO      4
> +#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
>           u8 flags;
>   #define VIRTIO_NET_HDR_GSO_NONE        0
>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
> @@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   been negotiated, the driver MAY use \field{hdr_len} only as a hint abou=
t the
>   transport header size.
>   The driver MUST NOT rely on \field{hdr_len} to be correct.
> +
> +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is s=
et,
> +the driver SHOULD treat the \field{hdr_len} as the length of the transpo=
rt
> +header inside the first buffer.
> +
>   \begin{note}
>   This is due to various bugs in implementations.
>   \end{note}
> @@ -4483,6 +4493,87 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>   according to the native endian of the guest rather than
>   (necessarily when not using the legacy interface) little-endian.
>  =20
> +\paragraph{Split Transport Header}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Split Transport Header}
> +
> +If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiated,
> +the device supports splitting the transport header and the payload.
> +The transport header and the payload will be separated into different
> +buffers.
> +
> +\subparagraph{Split Transport Header}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Split Transport Header / Set=
ting Split Transport Header}
> +
> +To configure the split transport header, the following layout structure
> +and definitions are used:
> +
> +\begin{lstlisting}
> +struct virtio_net_split_transport_header_config {
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 << 0)
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 << 1)
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 << 2)
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 << 3)
> +    le64 type;
> +    le16 offset;
> +    le16 max_len;
> +};
> +
> +#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
> + #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
> +\end{lstlisting}
> +
> +The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one command:
> +VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new split
> +header configuration.
> +
> +The driver can enable or disable split transport header for different tr=
ansport
> +protocols by setting or clearing corresponding bits in \field{type}.
> +
> +\begin{itemize}
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split after ipv4 =
tcp header
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split after ipv6 =
tcp header
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split after ipv4 =
udp header
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split after ipv6 =
udp header
> +\end{itemize}
> +
> +\devicenormative{\subparagraph}{Setting Split Transport Header}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Split Transp=
ort Header}
> +
> +A device MUST disable transport header splitting upon reset and initiali=
zation.
> +
> +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the device MUST su=
pport
> +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_TRANSPORT_=
HEADER_TYPE_TCP6,
> +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_TRANSPORT_=
HEADER_TYPE_UDP6.
> +
> +A device MUST NOT split the transport header if it encounters any of the=
 following cases:
> +\begin{itemize}
> +    \item The device does not recognize the transport protocol of the pa=
cket.
> +    \item The packet is an IP fragmentation.
> +    \item The splitting of the specific transport protocol is not enable=
d via
> +        VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET.
> +    \item At most one buffer is available.


So this means the feature is disabled for the device without merge-able=20
buffer? Note that, even in the case of mergeable buffer, it doesn't mean=20
a buffer that only contains a single descriptor.


> +    \item The total size of the virtio net header and the transport head=
er exceeds \field{max_len}.


I don't get the reason why we need max_len. Can't it implied in the=20
length of the first descriptor?


> +\end{itemize}
> +
> +If the transport header is split by the device, the VIRTIO_NET_HDR_F_SPL=
IT_TRANSPORT_HEADER
> +bit in \field{flags} MUST be set. The transport header MUST be on the fi=
rst
> +buffer, following the virtio net header. The payload MUST start from the
> +second buffer. The device MUST set \field{hdr_len} of structure
> +virtio_net_hdr to the length of the transport header.
> +The used length still reports the number of bytes it has written to memo=
ry.
> +
> +\field{offset} and \field{max_len} are valid when device uses the first =
buffer.
> +The device MUST reserve space in the first buffer using \filed{offset}.
> +If \field{offset} exceeds the length of the buffer, the device MUST drop
> +the receive packets.


Can the device simply don't split the packet in this case? Anyhow we=20
need synchronize the driver with the device in the case (e.g when driver=20
is try to having a new max_len).

(I wonder if the offset deserves a independent feature (but depends on=20
the merge able) in this case).


>   The maximum available length of the first buffer
> +used by the device is specified by \field{max_len}.


Similarly the max length seems to be implied by length - offset?

Thanks


>   If \field{max_len} is 0 or
> +$ \field{offset} + \field{max_len} $ is greater than the length of the b=
uffer,
> +the device can use the entire buffer starting at \field{offset}.
> +
> +\drivernormative{\subparagraph}{Setting Split Transport Header}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Split Transp=
ort Header}
> +
> +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is s=
et, the driver
> +SHOULD treat the contents of \field{hdr_len} as the length of the transp=
ort header
> +inside the first buffer.
> +
> +If \field{max_len} is not equal to 0, it MUST be greater than the size o=
f the virtio net header.
>  =20
>   \paragraph{Notifications Coalescing}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Notifications Coalescing}
>  =20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

