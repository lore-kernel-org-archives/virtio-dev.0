Return-Path: <virtio-dev-return-10303-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 721BC9863C7
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 Nov 2022 06:04:03 +0000 (UTC)
Message-ID: <cd7720f5-f13b-643b-3048-bf7ccc67a182@linux.alibaba.com>
Date: Tue, 29 Nov 2022 14:03:51 +0800
MIME-Version: 1.0
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <20221129003420-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20221129003420-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio_net: support inner header hash
 for GRE-encapsulated packets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2022/11/29 =E4=B8=8B=E5=8D=881:35, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> On Tue, Nov 22, 2022 at 05:07:55PM +0800, Heng Qi wrote:
>> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
>> encapsulate the packets, the hash calculated using the outer header
>> of the receive packets is always fixed for the same flow packets,
>> i.e. they will be steered to the same receive queue.
>>
>> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
>> which instructs the device to calculate the hash using the inner
>> headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPORT_GRE
>> value in \field{hash_tunnel} to report packet type when calculating
>> hash over the inner header.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> I just noticed this was sent to virtio-dev.
> Please send next version to virtio-comment@lists.oasis-open.org
> virtio-dev is for implementation discussions not spec comments.
>

Ok, I'll do that in the next version.

Thanks.

>
>> ---
>> v1:
>> =091. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>> =092. Clarify some paragraphs. @Jason Wang
>> =093. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Bend=
itovich
>>
>>   content.tex | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 135 insertions(+), 5 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index e863709..fba0c7d 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3095,7 +3095,7 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits
>>    to several segments when each of these smaller packets has UDP header=
.
>>  =20
>>   \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
>> -    value and a type of calculated hash.
>> +    value, a type of calculated hash and a tunnel packet type.
>>  =20
>>   \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \fie=
ld{hdr_len}
>>       value. Device benefits from knowing the exact header length.
>> @@ -3386,7 +3386,8 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Network Device / Device O
>>           le16 num_buffers;
>>           le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
>>           le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negot=
iated)
>> +        le8 hash_tunnel;        (Only if VIRTIO_NET_F_HASH_REPORT negot=
iated)
>> +        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT negot=
iated)
>>   };
>>   \end{lstlisting}
>>  =20
>> @@ -3837,7 +3838,7 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>>   A device attempts to calculate a per-packet hash in the following case=
s:
>>   \begin{itemize}
>>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the=
 hash to determine the receive virtqueue to place incoming packets.
>> -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device r=
eports the hash value and the hash type with the packet.
>> +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device r=
eports the hash value, the hash type and the tunnel packet type.
>>   \end{itemize}
>>  =20
>>   If the feature VIRTIO_NET_F_RSS was negotiated:
>> @@ -3883,6 +3884,10 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>>   #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
>>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>>   \end{lstlisting}
>> +Hash types applicable to inner payloads of GRE-encapsulated packets
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
>> +\end{lstlisting}
>>  =20
>>   \subparagraph{IPv4 packets}
>>   \label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / IPv4 packe=
ts}
>> @@ -3975,12 +3980,123 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
>>   (see \ref{sec:Device Types / Network Device / Device Operation / Proce=
ssing of Incoming Packets / Hash calculation for incoming packets / IPv6 pa=
ckets without extension header}).
>>   \end{itemize}
>>  =20
>> +\subparagraph{Inner payloads of GRE-encapsulated packets}
>> +\label{sec:Device Types / Network Device / Device Operation / Processin=
g of Incoming Packets / Hash calculation for incoming packets / Inner paylo=
ads of GRE-encapsulated packets}}
>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is set at the same time as one of
>> +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_UDP=
_EX.
>> +
>> +The device calculates the hash on GRE-encapsulated packets whose inner =
payloads
>> +are IPv4 packets according to 'Enabled hash types' bitmasks as follows:
>> +\begin{itemize}
>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE=
_TCPv4 bits
>> +      are set, and the GRE-encapsulated packet has an inner TCPv4 heade=
r in its
>> +      payload, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item inner Source IP address
>> +      \item inner Destination IP address
>> +      \item inner Source TCP port
>> +      \item inner Destination TCP port
>> +    \end{itemsize}
>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH=
_TYPE_UDPv4
>> +      bits are set, and the GRE-encapsulated packet has an inner UDPv4 =
header in
>> +      its payload, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item inner Source IP address
>> +      \item inner Destination IP address
>> +      \item inner Source UDP port
>> +      \item inner Destination UDP port
>> +    \end{itemize}
>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH=
_TYPE_IPv4
>> +      bits are set, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item inner Source IP address
>> +      \item inner Destination IP address
>> +    \end{itemsize}
>> +  \item Else the device does not calculate the hash
>> +\end{itemize}
>> +
>> +The device calculates the hash on GRE-encapsulated packets whose inner =
payloads
>> +are IPv6 packets without extension headers according to 'Enabled hash t=
ypes'
>> +bitmasks as follows:
>> +\begin{itemsize}
>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE=
_TCPv6
>> +      bits are set, and the GRE-encapsulated packet has an inner TCPv6 =
header in
>> +      its payload, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item inner Source IPv6 address
>> +      \item inner Destination IPv6 address
>> +      \item inner Source TCP port
>> +      \item inner Destination TCP port
>> +    \end{itemsize}
>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH=
_TYPE_UDPv6
>> +      bits are set, and the GRE-encapsulated packet has an inner UDPv6 =
header in
>> +      its payload, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item inner Source IPv6 address
>> +      \item inner Destination IPv6 address
>> +      \item inner Source UDP port
>> +      \item inner Destination UDP port
>> +    \end{itemize}
>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH=
_TYPE_IPv6
>> +      bits are set, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item inner Source IPv6 address
>> +      \item inner Destination IPv6 address
>> +    \end{itemsize}
>> +  \item Else the device does not calculate the hash
>> +\end{itemize}
>> +
>> +The device calculates the hash on GRE-encapsulated packets whose inner =
payloads
>> +are IPv6 packets with extension headers according to 'Enabled hash type=
s'
>> +bitmasks as follows:
>> +\begin{itemsize}
>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE=
_TCP_EX
>> +      bits are set, and the GRE-encapsulated packet has an inner TCPv6 =
header in
>> +      its payload, the hash is calculated over the following fields:
>> +    \begin{itemize}
>> +      \item Home address from the home address option in the inner IPv6=
 destination
>> +          options header. If the inner extension header is not present,=
 use the
>> +          inner Source IPv6 address.
>> +      \item IPv6 address that is contained in the Routing-Header-Type-2=
 from the
>> +          associated inner extension header. If the inner extension hea=
der is not
>> +          present, use the inner Destination IPv6 address.
>> +      \item inner Source TCP port
>> +      \item inner Destination TCP port
>> +    \end{itemize}
>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH=
_TYPE_UDP_EX
>> +  bits are set, and the GRE-encapsulated packet has an inner UDPv6 head=
er in its
>> +  payload, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item Home address from the home address option in the inner IPv6=
 destination
>> +          options header. If the inner extension header is not present,=
 use the
>> +          inner Source IPv6 address.
>> +      \item IPv6 address that is contained in the Routing-Header-Type-2=
 from the
>> +          associated inner extension header. If the inner extension hea=
der is not
>> +          present, use the inner Destination IPv6 address.
>> +      \item inner Source UDP port
>> +      \item inner Destination UDP port
>> +    \end{itemize}
>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH=
_TYPE_IP_EX
>> +      bits are set, the hash is calculated over the following fields:
>> +    \begin{itemsize}
>> +      \item Home address from the home address option in the inner IPv6=
 destination
>> +          options header. If the inner extension header is not present,=
 use the
>> +          inner Source IPv6 address.
>> +      \item IPv6 address that is contained in the Routing-Header-Type-2=
 from the
>> +          associated inner extension header. If the inner extension hea=
der is not
>> +          present, use the inner Destination IPv6 address.
>> +    \end{itemize}
>> +  \item Else skip inner IPv6 extension headers and calculate the hash a=
s defined
>> +      for a GRE-encapsulated packet whose inner payload is an IPv6 pack=
et without
>> +      extension headers
>> +\end{itemsize}
>> +
>>   \paragraph{Hash reporting for incoming packets}
>>   \label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash reporting for incoming packets}
>>  =20
>>   If VIRTIO_NET_F_HASH_REPORT was negotiated and
>> - the device has calculated the hash for the packet, the device fills \f=
ield{hash_report} with the report type of calculated hash
>> -and \field{hash_value} with the value of calculated hash.
>> + the device has calculated the hash for the packet, the device fills \f=
ield{hash_report} with the report type of calculated hash,
>> +\field{hash_tunnel} with the type of the tunnel packet, and \field{hash=
_value} with the value of calculated hash.
>>  =20
>>   If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
>>   hash was not calculated, the device sets \field{hash_report} to VIRTIO=
_NET_HASH_REPORT_NONE.
>> @@ -4005,6 +4121,20 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>   \end{lstlisting}
>>  =20
>> +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
>> +\field{hash_tunnel} can report the type of the tunnel-encapsulated
>> +packet to the driver over the inner header hash calculation.
>> +Possible values that the device can report in field{hash_tunnel}
>> +are defined below:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_REPORT_GRE             1
>> +\end{lstlisting}
>> +
>> +The value VIRTIO_NET_HASH_REPORT_GRE corresponds to
>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit of supported hash types defined in
>> +\ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}.
>> +
>>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Dev=
ice / Device Operation / Control Virtqueue}
>>  =20
>>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
>> --=20
>> 2.19.1.6.gb485710b
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

