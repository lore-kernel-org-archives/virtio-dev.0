Return-Path: <virtio-dev-return-10154-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95ECD986530
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Nov 2022 02:51:54 +0000 (UTC)
Message-ID: <0cea7d3e-b193-103c-6a14-083cc164fdb8@linux.alibaba.com>
Date: Fri, 11 Nov 2022 10:51:47 +0800
MIME-Version: 1.0
From: Heng Qi <hengqi@linux.alibaba.com>
References: <20221111024402.105024-1-hengqi@linux.alibaba.com>
In-Reply-To: <20221111024402.105024-1-hengqi@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio_net: support inner header hash for
 GRE-encapsulated packets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Heng Qi <henqqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Please ignore this email, thanks.

=E5=9C=A8 2022/11/11 =E4=B8=8A=E5=8D=8810:44, Heng Qi =E5=86=99=E9=81=93:
> From: Heng Qi <henqqi@linux.alibaba.com>
>
> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> encapsulate the packets, the hash calculated using the outer header
> of the receive packets is always fixed for the same flow packets,
> i.e. they will be steered to the same receive queue.
>
> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
> which instructs the device to calculate the hash using the inner
> headers of GRE-encapsulated packets.
>
> Signed-off-by: Heng Qi <henqqi@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v1:
> =091. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> =092. Clarify some paragraphs. @Jason Wang
>
>
>   content.tex | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 119 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index e863709..34e1eb5 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3883,6 +3883,10 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>   \end{lstlisting}
> +Hash types applicable to inner payloads of GRE-encapsulated packets
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> +\end{lstlisting}
>  =20
>   \subparagraph{IPv4 packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processin=
g of Incoming Packets / Hash calculation for incoming packets / IPv4 packet=
s}
> @@ -3975,6 +3979,117 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>   (see \ref{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / IPv6 pac=
kets without extension header}).
>   \end{itemize}
>  =20
> +\subparagraph{Inner payloads of GRE-encapsulated packets}
> +\label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Inner payloa=
ds of GRE-encapsulated packets}}
> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit MUST be set at the same time as one o=
f
> +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_UDP_=
EX.
> +
> +The device calculates the hash on GRE-encapsulated packets whose inner p=
ayloads
> +are IPv4 packets according to 'Enabled hash types' bitmasks as follows:
> +\begin{itemize}
> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_=
TCPv4 bits
> +      are set, and the GRE-encapsulated packet has an inner TCPv4 header=
 in its
> +      payload, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item inner Source IP address
> +      \item inner Destination IP address
> +      \item inner Source TCP port
> +      \item inner Destination TCP port
> +    \end{itemsize}
> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_=
TYPE_UDPv4
> +      bits are set, and the GRE-encapsulated packet has an inner UDPv4 h=
eader in
> +      its payload, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item inner Source IP address
> +      \item inner Destination IP address
> +      \item inner Source UDP port
> +      \item inner Destination UDP port
> +    \end{itemize}
> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_=
TYPE_IPv4
> +      bits are set, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item inner Source IP address
> +      \item inner Destination IP address
> +    \end{itemsize}
> +  \item Else the device does not calculate the hash
> +\end{itemize}
> +
> +The device calculates the hash on GRE-encapsulated packets whose inner p=
ayloads
> +are IPv6 packets without extension headers according to 'Enabled hash ty=
pes'
> +bitmasks as follows:
> +\begin{itemsize}
> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_=
TCPv6
> +      bits are set, and the GRE-encapsulated packet has an inner TCPv6 h=
eader in
> +      its payload, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item inner Source IPv6 address
> +      \item inner Destination IPv6 address
> +      \item inner Source TCP port
> +      \item inner Destination TCP port
> +    \end{itemsize}
> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_=
TYPE_UDPv6
> +      bits are set, and the GRE-encapsulated packet has an inner UDPv6 h=
eader in
> +      its payload, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item inner Source IPv6 address
> +      \item inner Destination IPv6 address
> +      \item inner Source UDP port
> +      \item inner Destination UDP port
> +    \end{itemize}
> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_=
TYPE_IPv6
> +      bits are set, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item inner Source IPv6 address
> +      \item inner Destination IPv6 address
> +    \end{itemsize}
> +  \item Else the device does not calculate the hash
> +\end{itemize}
> +
> +The device calculates the hash on GRE-encapsulated packets whose inner p=
ayloads
> +are IPv6 packets with extension headers according to 'Enabled hash types=
'
> +bitmasks as follows:
> +\begin{itemsize}
> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_=
TCP_EX
> +      bits are set, and the GRE-encapsulated packet has an inner TCPv6 h=
eader in
> +      its payload, the hash is calculated over the following fields:
> +    \begin{itemize}
> +      \item Home address from the home address option in the inner IPv6 =
destination
> +          options header. If the inner extension header is not present, =
use the
> +          inner Source IPv6 address.
> +      \item IPv6 address that is contained in the Routing-Header-Type-2 =
from the
> +          associated inner extension header. If the inner extension head=
er is not
> +          present, use the inner Destination IPv6 address.
> +      \item inner Source TCP port
> +      \item inner Destination TCP port
> +    \end{itemize}
> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_=
TYPE_UDP_EX
> +  bits are set, and the GRE-encapsulated packet has an inner UDPv6 heade=
r in its
> +  payload, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item Home address from the home address option in the inner IPv6 =
destination
> +          options header. If the inner extension header is not present, =
use the
> +          inner Source IPv6 address.
> +      \item IPv6 address that is contained in the Routing-Header-Type-2 =
from the
> +          associated inner extension header. If the inner extension head=
er is not
> +          present, use the inner Destination IPv6 address.
> +      \item inner Source UDP port
> +      \item inner Destination UDP port
> +    \end{itemize}
> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_=
TYPE_IP_EX
> +      bits are set, the hash is calculated over the following fields:
> +    \begin{itemsize}
> +      \item Home address from the home address option in the inner IPv6 =
destination
> +          options header. If the inner extension header is not present, =
use the
> +          inner Source IPv6 address.
> +      \item IPv6 address that is contained in the Routing-Header-Type-2 =
from the
> +          associated inner extension header. If the inner extension head=
er is not
> +          present, use the inner Destination IPv6 address.
> +    \end{itemize}
> +  \item Else skip inner IPv6 extension headers and calculate the hash as=
 defined
> +      for a GRE-encapsulated packet whose inner payload is an IPv6 packe=
t without
> +      extension headers
> +\end{itemsize}
> +
>   \paragraph{Hash reporting for incoming packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processin=
g of Incoming Packets / Hash reporting for incoming packets}
>  =20
> @@ -4005,6 +4120,10 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>   \end{lstlisting}
>  =20
> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is not included in \field{hash_report=
},
> +it just indicates that the hash is calculated using the inner header ins=
ide
> +the GRE-encapsulated packet.
> +
>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue}
>  =20
>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

