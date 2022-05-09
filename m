Return-Path: <virtio-dev-return-9520-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C85BD9862A8
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 May 2022 08:41:24 +0000 (UTC)
Message-ID: <2a597a0d-29b2-adc9-75e2-cc1c552384f4@redhat.com>
Date: Mon, 9 May 2022 16:41:11 +0800
MIME-Version: 1.0
References: <20220507071533.104000-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220507071533.104000-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio_net: support split header
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/5/7 15:15, Xuan Zhuo =E5=86=99=E9=81=93:
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
>   conformance.tex |  2 ++
>   content.tex     | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
>
> diff --git a/conformance.tex b/conformance.tex
> index 663e7c3..6f561fb 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Automatic receive steering in multiqueue mode}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Offloads State Configuration / Setting Offloads =
State}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Receive-side scaling (RSS) }
> +\item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Split Header}
>   \end{itemize}
>  =20
>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conforman=
ce / Driver Conformance / Block Driver Conformance}
> @@ -411,6 +412,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Gratuitous Packet Sending}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Automatic receive steering in multiqueue mode}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Split Header}
>   \end{itemize}
>  =20
>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conforman=
ce / Device Conformance / Block Device Conformance}
> diff --git a/content.tex b/content.tex
> index 060bdab..3340402 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / =
Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>  =20
> +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports to split the heade=
r and
> +    the payload.
> +
>   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlik=
e UFO
>    (fragmenting the packet) the USO splits large UDP packet
>    to several segments when each of these smaller packets has UDP header.
> @@ -3139,6 +3142,7 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_N=
ET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
>   \end{description}
>  =20
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -3370,6 +3374,7 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Network Device / Device O
>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>   #define VIRTIO_NET_HDR_F_DATA_VALID    2
>   #define VIRTIO_NET_HDR_F_RSC_INFO      4
> +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
>           u8 flags;
>   #define VIRTIO_NET_HDR_GSO_NONE        0
>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
> @@ -4471,6 +4476,73 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>   according to the native endian of the guest rather than
>   (necessarily when not using the legacy interface) little-endian.
>  =20
> +\paragraph{Split Header}\label{sec:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Split Header}
> +
> +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
> +the device supports to split the header and the payload.
> +The header and payload will be separated into different buffers.


I think you meant "descriptors" instead of "buffers".


> +
> +\subparagraph{Split Header}\label{sec:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Split Header / Setting Split Header}
> +
> +To configure the split header, the following layout structure and defini=
tions
> +are used:
> +
> +\begin{lstlisting}
> +struct virtio_net_split_header_config {
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv4     1


I think it's better to capitalize: TCPV4 or TCP4.


> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv6     2
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv4     4
> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv6     8
> +    le64 type;
> +};
> +
> +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> +\end{lstlisting}
> +
> +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configurat=
ion.
> +
> +\field{type} passed as command data is a bitmask, bits set define
> +packet types to split header, bits cleared - split header to be disabled=
.


(Not a native speaker, try my best to help)

This sentence might need some tweaks:

The driver can enable or disable the split by setting or clearing=20
corresponding bits in \field{type}.


> +
> +The header contains the struct virtio_net_hdr and the header of the pack=
age.
> +Such as \field{VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv4} specified header cont=
ains
> +virtio_net_hdr, MAC header, IPv4 header (including IPv4 options), TCP he=
ader
> +(include TCP options). The back part is the payload.


I think it's better to either explain each type one by one instead of=20
only describing the TCPv4. Or we can simply say the head contains all=20
headers before level 4 payload?


> +
> +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Net=
work Device / Device Operation / Control Virtqueue / Split Header}
> +
> +Split header MUST be disabled after device initialization.


I think you actually mean "upon device reset"?


> +
> +A device MUST NOT perform split header in the following cases:
> +\begin{itemize}
> +    \item device does not recognize protocol of the packet.
> +    \item \field{type} does not include the protocol of the packet.
> +    \item the packet is a IP fragmentation.


What's the reason for this limit?


> +    \item the receive buffer consists of only one descriptor.


descriptor actually.


> +    \item the header exceeds the size of the 0th descriptor.


It looks to me the spec count from the first.


> +    \item If VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of th=
e
> +        payload is greater than the total size of the 1th\ldots Nth desc=
riptor.


Maybe something like the following is better:

The size of the payload exceeds the length of the descriptor or buffer=20
chain starting from the 2nd descriptor.


> +\end{itemize}
> +
> +If the split header completed,


If the header is split by the device?


>   then the \field{flags} of virtnet hdr MUST


We can drop "then" here and it's better to use structure virtio_net_hdr


> +contains VIRTIO_NET_HDR_F_SPLIT_HEADER. The header MUST is on the buffer=
 of the
> +0th descriptor,


first and second should be used here.


>   and the payload MUST starts from the buffer of the 1th descriptor.
> +The device MUST set \field{hdr_len} of virtnet hdr.


To what value?


> +
> +If VIRTIO_NET_F_MRG_RXBUF is negotiated and the device is to use multipl=
e
> +receive buffers, each subsequent receive buffer MUST skip the 0th descri=
ptor.


I don't see why we need this.


> +
> +\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Net=
work Device / Device Operation / Control Virtqueue / Split Header}
> +
> +If VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driver=
 MUST
> +believe \field{hdr_len}, the length of the header in the 0th descriptor =
is equal
> +to the length of struct virtio_net_hdr plus \field{hdr_len}.


See above we can reuse the device normative an drop the second part=20
starting from " the length of the header ..."


> +
> +If the split header function is enable, the buffers submitted by the dri=
ver
> +SHOULD at least be composed of two descriptors.


Do we need to mention it's only used for RX? (I think we don't need this=20
for TX).


> The buffer specified by the 0th
> +descriptor SHOULD be able to accommodate the header.


We probably need to clarify that the header here means both the virtio=20
net header and the protocol header.

Thanks


>  =20
>   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>   Types / Network Device / Legacy Interface: Framing Requirements}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

