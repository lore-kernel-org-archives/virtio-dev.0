Return-Path: <jasowang@redhat.com>
Message-ID: <f7e5a6c8-ad4c-c60c-2d9e-cd64f6fdd90e@redhat.com>
Date: Mon, 16 Jan 2023 16:42:11 +0800
MIME-Version: 1.0
Subject: Re: [virtio-comment] Re: [PATCH v7] virtio-net: support inner header
 hash
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230111042905-mutt-send-email-mst@kernel.org>
 <20230116080106.GA114763@h68b04307.sqa.eu95>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230116080106.GA114763@h68b04307.sqa.eu95>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2023/1/16 16:01, Heng Qi 写道:
> On Wed, Jan 11, 2023 at 04:45:12AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Jan 04, 2023 at 03:14:01PM +0800, Heng Qi wrote:
>>> If the tunnel is used to encapsulate the packets, the hash calculated
>>> using the outer header of the receive packets is always fixed for the
>>> same flow packets, i.e. they will be steered to the same receive queue.
>>>
>>> We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
>>> in \field{hash_types}, which instructs the device to calculate the
>>> hash using the inner headers of tunnel-encapsulated packets. Besides,
>>> values in \field{hash_report_tunnel} are added to report tunnel types.
>>>
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/151
>>>
>>> Reviewed-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>> v6:
>>> 	1. Modify the wording of some sentences for clarity. @Michael S. Tsirkin
>>> 	2. Fix some syntax issues. @Michael S. Tsirkin
>>>
>>> v5:
>>> 	1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
>>> 	2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
>>> 	3. Move the links to introduction section. @Michael S. Tsirkin
>>> 	4. Clarify some sentences. @Michael S. Tsirkin
>>>
>>> v4:
>>> 	1. Clarify some paragraphs. @Cornelia Huck
>>> 	2. Fix the u8 type. @Cornelia Huck
>>>
>>> v3:
>>> 	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
>>> 	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
>>> 	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
>>> 	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
>>>
>>> v2:
>>> 	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
>>> 	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
>>>
>>> v1:
>>> 	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>>> 	2. Clarify some paragraphs. @Jason Wang
>>> 	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
>>>
>>>   content.tex      | 191 +++++++++++++++++++++++++++++++++++++++++++++--
>>>   introduction.tex |  19 +++++
>>>   2 files changed, 203 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index e863709..7845f6c 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>>       channel.
>>>   
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
>>> +    header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packets.
>>> +
>>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>>>   
>>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>>> @@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>>    to several segments when each of these smaller packets has UDP header.
>>>   
>>>   \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
>>> -    value and a type of calculated hash.
>>> +    value, a type of calculated hash, and, if VIRTIO_NET_F_HASH_TUNNEL
>>> +    is negotiated, an encapsulation packet type.
>>>   
>>>   \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
>>>       value. Device benefits from knowing the exact header length.
>>> @@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \end{description}
>>>   
>>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>>>           le16 num_buffers;
>>>           le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>           le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>> +        u8 hash_report_tunnel;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated, only valid of VIRTIO_NET_F_HASH_TUNNEL negotiated)
>> of -> if?
> Sorry for the late reply.
> It's Cornelia's suggestion, and 'of' seems to work fine.
>
>> also let's add: otherwise reserved?
> Sure.
>
>>
>>> +        u8 padding_reserved;    (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>   };
>>>   \end{lstlisting}
>>>   
>>> @@ -3837,7 +3843,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   A device attempts to calculate a per-packet hash in the following cases:
>>>   \begin{itemize}
>>>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
>>> -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
>>> +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type. If additionally
>>> +VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device reports the encapsulation type as well.
>>>   \end{itemize}
>>>   
>>>   If the feature VIRTIO_NET_F_RSS was negotiated:
>>> @@ -3863,8 +3870,36 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>    \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
>>>   \end{itemize}
>>>   
>>> +\subparagraph{Tunnel/Encapsulated packet}
>>> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
>>> +A tunnel packet is encapsulated from the original packet based on the tunneling
>>> +protocol (only a single level of encapsulation is currently supported). The
>>> +encapsulated packet contains an outer header and an inner header, and the device
>>> +calculates the hash over either the inner header or the outer header.
>>> +
>>> +When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
>>> +encapsulation type is set in \field{hash_types}, the hash for a specific type of
>>> +encapsulated packet is calculated over the inner as opposed to outer header.
>>
>>> +Supported encapsulation types are listed in \ref{sec:Device Types / Network Device /
>>> +Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets /
>>> +Supported/enabled hash types}.
>>> +
>>> +If both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated,
>>> +the device can support inner hash calculation for \hyperref[intro:GRE]{[GRE]},
>>> +\hyperref[intro:VXLAN]{[VXLAN]} and \hyperref[intro:GENEVE]{[GENEVE]}
>>> +encapsulated packets, and the corresponding encapsulation type in \field{hash_types}
>>> +is VIRTIO_NET_HASH_TYPE_{GRE, VXLAN, GENEVE}_INNER respectively. The value in
>>> +\field{hash_report_tunnel} is VIRTIO_NET_HASH_REPORT_{NONE, GRE, VXLAN, GENEVE} respectively.
>>> +
>>> +If VIRTIO_NET_F_HASH_REPORT is negotiated but VIRTIO_NET_F_HASH_TUNNEL is not
>>> +negotiated, the device calculates the hash over the outer header, and
>>> +\field{hash_report} reports the hash type. \field{hash_report_tunnel}
>>> +is no longer valid.
>> Does this mean that VIRTIO_NET_HASH_TYPE_{GRE, VXLAN, GENEVE}_INNER
>> must not be set without VIRTIO_NET_F_HASH_TUNNEL?
>>
> Yes.
>
>> If yes then we can add conformance statements to this end and then
>> drop the
>> "If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated"
>> all over the place just relying on hash type being set instead.
> Please see the response below.
>
>> Also, note that it has to be ok for device to expose hash types without
>> negotiating VIRTIO_NET_F_HASH_TUNNEL since they are in config space.
>> Idea: do we want to decouple these completely? have VIRTIO_NET_F_HASH_TUNNEL
>> just add hash_report_tunnel and have hash types speak for themselves?
>> It makes things nicely orthogonal in that if one does not care
>> about knowing encapsulation type (e.g. for RSS) one can disable
>> VIRTIO_NET_F_HASH_TUNNEL.
> This seems to have the following 3 problems:
>
> 1. This will break the specification. As described in the specification, any field
>     in the configuration space only exists when there is a corresponding feature bit:
>     "Device configuration space is generally used for rarely-changing or initialization-time parameters.
>     Where configuration fields are optional, their existence is indicated by feature bits: ",
>     which also applies to supported_hash_types.
>
> 2. If I'm not wrong, this seems to make the encapsulation hash types dependent on
>     VIRTIO_NET_F_RSS, can the driver read supported_hash_types (including encapsulation
>     hash types) if VIRTIO_NET_F_RSS is not negotiated? But that shouldn't be the case,
>     we only use encapsulation hash types to provide guidance for hash calculation, but not
>     necessarily use hash values to select receive queues (unless VIRTIO_NET_F_RSS is negotiated).
>
> 3. If all supported_hash_types speak for themselves, why do we need the VIRTIO_NET_F_HASH_TUNNEL
>     feature, because as long as the encapsulation hash types exist and VIRTIO_NET_F_HASH_REPORT is
>     negotiated, hash_report_tunnel exists correspondingly. "have VIRTIO_NET_F_HASH_TUNNEL just add
>     hash_report_tunnel"? It seems like hash_report_tunnel will only work if the encapsulation hash
>     types are present.
>
> So, if I'm not wrong, the reasonable logic should be that VIRTIO_NET_F_HASH_TUNNEL is only used
> to declare that the device supports inner header hash and let the corresponding encapsulation
> hash type exist, when VIRTIO_NET_F_RSS is negotiated, we can use this hash value to select the
> receive queue. Considering the migration at the same time, if the dst device does not negotiate
> VIRTIO_NET_F_HASH_TUNNEL, the migration will fail; otherwise, use encapsulation hash types to
> determine whether the migration can succeed.


I think it might be better to have consistency:

1) If VIRTIO_NET_F_HASH_TUNNEL introduces a new field in vnet header, is 
it better to have a new config filed in the config space?

or

2) If VIRTIO_NET_F_HASH_TUNNEL doesn't introduce new config file, should 
we try to reuse hash_report?

1) seems better and cleaner to me.

More below


>
> Thanks.
>
>> Objections? Jason?
>>
>>
>>> +
>>>   \subparagraph{Supported/enabled hash types}
>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
>>> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
>>> +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>>>   Hash types applicable for IPv4 packets:
>>>   \begin{lstlisting}
>>>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
>>> @@ -3884,6 +3919,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>>>   \end{lstlisting}
>>>   
>>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the encapsulation
>>> +hash type below indicates that the hash is calculated over the inner
>>> +header of the encapsulated packet:
>>> +Hash type applicable for inner payload of the gre-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the vxlan-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TYPE_VXLAN_INNER       (1 << 10)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the geneve-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TYPE_GENEVE_INNER      (1 << 11)
>>> +\end{lstlisting}


Just notice that this seems to break the equation:

VIRTIO_NET_HASH_TYPE_XXX = 1 « (VIRTIO_NET_HASH_REPORT_XXX - 1)

?

Thanks


>>> +
>>>   \subparagraph{IPv4 packets}
>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
>>>   The device calculates the hash on IPv4 packets according to 'Enabled hash types' bitmask as follows:
>>> @@ -3975,15 +4026,125 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
>>>   \end{itemize}
>>>   
>>> +\subparagraph{Inner payload of an encapsulated packet}
>>> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Inner payload of the encapsulated packet}
>>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
>>> +encapsulation hash type is set in \field{hash_types}, the device calculates the
>>> +inner header hash on an encapsulated packet (See \ref{sec:Device Types
>>> +/ Network Device / Device Operation / Processing of Incoming Packets /
>>> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}) as follows:
>>> +
>>> +The device calculates the hash on the inner IPv4 packet of an encapsulated packet
>>> +according to 'Enabled hash types' bitmask as follows:
>>> +\begin{itemize}
>>> +  \item If VIRTIO_NET_HASH_TYPE_TCPv4 is set and the encapsulated packet has an inner
>>> +	TCPv4 header, the hash is calculated over the following fields:
>>> +        \begin{itemsize}
>>> +          \item inner Source IP address
>>> +          \item inner Destination IP address
>>> +          \item inner Source TCP port
>>> +          \item inner Destination TCP port
>>> +        \end{itemsize}
>>> +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv4 is set and the encapsulated packet has an
>>> +	inner UDPv4 header, the hash is calculated over the following fields:
>>> +        \begin{itemsize}
>>> +          \item inner Source IP address
>>> +          \item inner Destination IP address
>>> +          \item inner Source UDP port
>>> +          \item inner Destination UDP port
>>> +        \end{itemize}
>>> +  \item Else if VIRTIO_NET_HASH_TYPE_IPv4 is set, the hash is calculated over the
>>> +	following fields:
>>> +        \begin{itemsize}
>>> +          \item inner Source IP address
>>> +          \item inner Destination IP address
>>> +        \end{itemsize}
>>> +  \item Else the device does not calculate the hash
>>> +\end{itemize}
>>> +
>>> +The device calculates the hash on the inner IPv6 packet without an extension header
>>> +of an encapsulated packet according to 'Enabled hash types' bitmask as follows:
>>> +\begin{itemize}
>>> +  \item If VIRTIO_NET_HASH_TYPE_TCPv6 is set and the encapsulated packet has an inner
>>> +	TCPv6 header, the hash is calculated over the following fields:
>>> +        \begin{itemsize}
>>> +          \item inner Source IPv6 address
>>> +          \item inner Destination IPv6 address
>>> +          \item inner Source TCP port
>>> +          \item inner Destination TCP port
>>> +        \end{itemsize}
>>> +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv6 is set and the encapsulated packet has an
>>> +	inner UDPv6 header, the hash is calculated over the following fields:
>>> +        \begin{itemsize}
>>> +          \item inner Source IPv6 address
>>> +          \item inner Destination IPv6 address
>>> +          \item inner Source UDP port
>>> +          \item inner Destination UDP port
>>> +        \end{itemize}
>>> +  \item Else if VIRTIO_NET_HASH_TYPE_IPv6 is set, the hash is calculated over the
>>> +	following fields:
>>> +        \begin{itemsize}
>>> +          \item inner Source IPv6 address
>>> +          \item inner Destination IPv6 address
>>> +        \end{itemsize}
>>> +  \item Else the device does not calculate the hash
>>> +\end{itemize}
>>> +
>>> +The device calculates the hash on the inner IPv6 packet with an extension header
>>> +of an encapsulated packet according to 'Enabled hash types' bitmask as follows:
>>> +\begin{itemsize}
>>> +  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the encapsulated packet has an inner
>>> +	TCPv6 header, the hash is calculated over the following fields:
>>> +        \begin{itemize}
>>> +          \item Home address from the home address option in the inner IPv6 destination
>>> +              options header. If the inner extension header is not present, use the
>>> +              inner Source IPv6 address.
>>> +          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
>>> +              associated inner extension header. If the inner extension header is not
>>> +              present, use the inner Destination IPv6 address.
>>> +          \item inner Source TCP port
>>> +          \item inner Destination TCP port
>>> +        \end{itemize}
>>> +  \item Else if VIRTIO_NET_HASH_TYPE_UDP_EX is set and the encapsulated packet has an inner
>>> +	UDPv6 header, the hash is calculated over the following fields:
>>> +        \begin{itemsize}
>>> +          \item Home address from the home address option in the inner IPv6 destination
>>> +              options header. If the inner extension header is not present, use the
>>> +              inner Source IPv6 address.
>>> +          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
>>> +              associated inner extension header. If the inner extension header is not
>>> +              present, use the inner Destination IPv6 address.
>>> +          \item inner Source UDP port
>>> +          \item inner Destination UDP port
>>> +        \end{itemize}
>>> +  \item Else if VIRTIO_NET_HASH_TYPE_IP_EX is set, the hash is calculated over the
>>> +	following fields:
>>> +        \begin{itemsize}
>>> +          \item Home address from the home address option in the inner IPv6 destination
>>> +              options header. If the inner extension header is not present, use the
>>> +              inner Source IPv6 address.
>>> +          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
>>> +              associated inner extension header. If the inner extension header is not
>>> +              present, use the inner Destination IPv6 address.
>>> +        \end{itemize}
>>> +  \item Else skip the inner IPv6 extension header and calculate the inner header hash as
>>> +	defined for an encapsulated packet whose inner payload is an IPv6 packet without
>>> +	an extension header.
>>> +\end{itemsize}
>>> +
>>>   \paragraph{Hash reporting for incoming packets}
>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
>>>   
>>> -If VIRTIO_NET_F_HASH_REPORT was negotiated and
>>> - the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash
>>> -and \field{hash_value} with the value of calculated hash.
>>> +If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculated the
>>> +hash for the packet, the device fills \field{hash_report} with the report type
>>> +of calculated hash, and \field{hash_value} with the value of calculated hash.
>>> +Also, if VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device needs to fill
>>> +\field{hash_report_tunnel} with the report type of the encapsulated packet, and
>>> +it is set to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE for the unencapsulated packet.
>>>   
>>>   If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
>>> -hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
>>> +hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE,
>>> +and sets \field{hash_report_tunnel} to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE.
>>>   
>>>   Possible values that the device can report in \field{hash_report} are defined below.
>>>   They correspond to supported hash types defined in
>>> @@ -4005,6 +4166,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>   \end{lstlisting}
>>>   
>>> +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
>>> +\field{hash_report_tunnel} can report the type of the encapsulated
>>> +packet to the driver over the inner header hash calculation.
>>> +Possible values that the device can report in \field{hash_report_tunnel}
>>> +are defined below:
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_REPORT_TUNNEL_NONE     0
>>> +#define VIRTIO_NET_HASH_REPORT_GRE             1
>>> +#define VIRTIO_NET_HASH_REPORT_VXLAN           2
>>> +#define VIRTIO_NET_HASH_REPORT_GENEVE          3
>>> +\end{lstlisting}
>>> +
>>> +They correspond to supported hash types defined in
>>> +\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
>>> +
>>>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
>>>   
>>>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
>>> diff --git a/introduction.tex b/introduction.tex
>>> index 287c5fc..ff01a9b 100644
>>> --- a/introduction.tex
>>> +++ b/introduction.tex
>>> @@ -98,6 +98,25 @@ \section{Normative References}\label{sec:Normative References}
>>>   	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>>>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>>>   	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>>> +	\phantomsection\label{intro:GRE}\textbf{[GRE]} &
>>> +	Generic Routing Encapsulation
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
>>> +	\phantomsection\label{intro:VXLAN}\textbf{[VXLAN]} &
>>> +	Virtual eXtensible Local Area Network
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
>>> +	\phantomsection\label{intro:GENEVE}\textbf{[GENEVE]} &
>>> +	Generic Network Virtualization Encapsulation
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
>>> +	\phantomsection\label{intro:IP}\textbf{[IP]} &
>>> +	INTERNET PROTOCOL
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
>>> +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
>>> +	User Datagram Protocol
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
>>> +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
>>> +	TRANSMISSION CONTROL PROTOCOL
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>>> +
>>>   
>>>   \end{longtable}
>>>   
>>> -- 
>>> 2.19.1.6.gb485710b
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/

