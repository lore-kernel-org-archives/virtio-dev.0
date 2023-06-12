Return-Path: <virtio-dev-return-12936-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13449C7EE2E
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 02:29:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4FE717C680
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 02:29:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CDC498653D
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 02:29:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3F324986508; Mon, 12 Jun 2023 02:29:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A1E5986468;
	Mon, 12 Jun 2023 02:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkqOQql_1686536953;
Message-ID: <4d5d44f1-5106-9446-1530-1d295f480e1d@linux.alibaba.com>
Date: Mon, 12 Jun 2023 10:29:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230610041123.6204-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481B4EFCD76E8189929D825DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230611191534-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230611191534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v16] virtio-net: support inner header hash



在 2023/6/12 上午7:18, Michael S. Tsirkin 写道:
> On Sun, Jun 11, 2023 at 08:13:58PM +0000, Parav Pandit wrote:
>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>> Sent: Saturday, June 10, 2023 12:11 AM
>>> +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
>>> +\begin{itemize}
>>> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set \field{hash_tunnel_types}
>>> for the device using the virtnet_hash_tunnel_config_set structure, which is
>>> read-only for the driver.
>> Driver issues set command so its read + write for driver.
>> Read-only for the device.
> This is talking about buffers I think. These are read-only or
> write-only, there is no read+write.
>
>>> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get \field{hash_tunnel_types}
>>> and \field{supported_hash_tunnel_types} from the device using the
>>> virtnet_hash_tunnel_config_get
>>> +      structure, which is write-only for the driver.
>> Device writes it, so
>> s/write-only for the driver/read-only for the driver
>
> Please use terminology consistent with how we describe buffers,
> which is from POV of the device. Thus buffers are
> device read-only or device write-only.

Sure. I'll use this terminology.

Thanks!

>
>>> +\end{itemize}
>>> +
>>> +\subparagraph{Tunnel/Encapsulated packet} \label{sec:Device Types /
>>> +Network Device / Device Operation / Processing of Incoming Packets /
>>> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}
>>> +
>>> +A tunnel packet is encapsulated from the original packet based on the
>>> +tunneling protocol (only a single level of encapsulation is currently
>>> +supported). The encapsulated packet contains an outer header and an inner
>>> header, and the device calculates the hash over either the inner header or the
>>> outer header.
>>> +
>>> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated
>>> +packet's outer header matches one of the configured
>>> \field{hash_tunnel_types}, the hash of the inner header is calculated.
>>> +
>>> +Supported encapsulated packet types:
>>> +\begin{itemize}
>>> +\item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header is over
>>> IPv4 and the inner header is over IPv4. The outer header does not contain the
>>> transport protocol.
>>> +\item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header is over
>>> IPv4 and the inner header is over IPv4. The outer header does not contain the
>>> transport protocol.
>>> +\item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header is over
>>> IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header does not
>>> contain the transport protocol.
>>> +\item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer header is
>>> over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses
>>> UDP as the transport protocol.
>>> +\item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over IPv4/IPv6 and
>>> the inner header is over IPv4/IPv6. The outer header uses UDP as the transport
>>> protocol.
>>> +\item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is over
>>> IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses UDP as
>>> the transport protocol.
>>> +\item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over IPv4/IPv6
>>> and the inner header is over IPv4/IPv6. The outer header uses UDP as the
>>> transport protocol.
>>> +\item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and the inner
>>> header is over IPv4. The outer header does not contain the transport protocol.
>>> +\item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over IPv4/IPv6 and
>>> the inner header is over IPv4/IPv6. The outer header does not contain the
>>> transport protocol.
>>> +\end{itemize}
>>> +
>> It does not matter much, but it may be good to arrange above list where all entries that does not have transport header first.
>> And than protocols with transport header together (vxlan-gpe, genve, nvgre).
>>
>>> +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is
>>> +not included in the configured \field{hash_tunnel_types}, the hash of the outer
>>> header is calculated for the received encapsulated packet.
>>> +
>>> +The hash is calculated for the received non-encapsulated packet as if
>>> VIRTIO_NET_F_HASH_TUNNEL was not negotiated.
>>> +
>>> +\subparagraph{Supported/enabled encapsulation hash types}
>>> +\label{sec:Device Types / Network Device / Device Operation /
>>> +Processing of Incoming Packets / Hash calculation for incoming packets
>>> +/ Supported/enabled encapsulation hash types}
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE        (1 << 0)
>>> +\end{lstlisting}
>>> +
>>> +Supported encapsulation hash types:
>>> +Hash type applicable for inner payload of the
>>> \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 1)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the
>>> \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 2)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the
>>> \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 3)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the
>>> \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 4)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the \hyperref[intro:vxlan]{[VXLAN]}
>>> packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 5)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the
>>> \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 6)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the
>>> \hyperref[intro:geneve]{[GENEVE]} packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 7)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the \hyperref[intro:ipip]{[IPIP]}
>>> packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 8)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the \hyperref[intro:nvgre]{[NVGRE]}
>>> packet:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 9)
>>> +\end{lstlisting}
>>> +
>>> +\subparagraph{Advice}
>>> +Usage scenarios of inner header hash (but not limited to):
>>> +\begin{itemize}
>>> +\item Legacy tunneling protocols that lack entropy in the outer header use
>>> inner header hash to hash flows
>>> +      with the same outer header but different inner headers to different queues
>>> for better-receiving performance.
>>> +\item In scenarios where the same flow passing through different tunnels is
>>> expected to be received in the same queue,
>>> +      warm caches, lessing locking, etc. are optimized to obtain receiving
>>> performance.
>>> +\end{itemize}
>>> +
>> Small rewrite as,
>> to utilize warm caches, to have less locking etc.
>>
>>> +For scenarios with sufficient outer entropy or no inner header hash
>>> requirements, inner header hash may not be needed:
>>> +A tunnel is often expected to isolate the external network from the
>>> +internal one. By completely ignoring entropy in the outer header and
>>> +replacing it with entropy from the inner header, for hash calculations,
>>> +this expectation might be violated to a certain extent, depending on how the
>>> hash is used. When the hash use is limited to RSS queue selection, inner header
>>> hash may have quality of service (QoS) limitations.
>>> +
>>> +Possible mitigations:
>>> +\begin{itemize}
>>> +\item Use a tool with good forwarding performance to keep the receive queue
>>> from filling up.
>> Generally filling up is fine as long as its emptied also.
>> So a rewrite as,
>>
>> s/from filling up/from dropping packet/
>>
>>> +\item If the QoS is unavailable, the driver can set \field{hash_tunnel_types} to
>>> VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
>>> +      to disable inner header hash for encapsulated packets.
>>> +\item Perform appropriate QoS before packets consume the receive buffers of
>>> the receive queues.
>>> +\end{itemize}
>>> +
>>> +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types /
>>> +Network Device / Device Operation / Control Virtqueue / Inner Header
>>> +Hash}
>>> +
>>> +The device MUST calculate the hash on the outer header if the type of
>>> +the received encapsulated packet does not match any value of the configured
>>> \field{hash_tunnel_types}.
>>> +
>>> +The device MUST respond to the VIRTIO_NET_CTRL_HASH_TUNNEL_SET
>>> command
>>> +with VIRTIO_NET_ERR if the device receives an unsupported or unrecognized
>>> VIRTIO_NET_HASH_TUNNEL_TYPE_ flag.
>>> +
>>> +The device MUST provide the values of \field{supported_hash_tunnel_types} if
>>> it offers the VIRTIO_NET_F_HASH_TUNNEL feature.
>>> +
>>> +Upon reset, the device MUST initialize \field{hash_tunnel_type} to 0.
>>> +
>>> +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types /
>>> +Network Device / Device Operation / Control Virtqueue / Inner Header
>>> +Hash}
>>> +
>>> +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature
>>> when issuing commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and
>>> VIRTIO_NET_CTRL_HASH_TUNNEL_GET.
>>> +
>>> +The driver MUST ignore the values received from the
>>> VIRTIO_NET_CTRL_HASH_TUNNEL_GET command if the device responds with
>>> VIRTIO_NET_ERR.
>>> +
>>> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags which
>>> are not supported by the device.
>>> +
>>>   \paragraph{Hash reporting for incoming packets}  \label{sec:Device Types /
>>> Network Device / Device Operation / Processing of Incoming Packets / Hash
>>> reporting for incoming packets}
>>>
>>> diff --git a/device-types/net/device-conformance.tex b/device-
>>> types/net/device-conformance.tex
>>> index 54f6783..f88f48b 100644
>>> --- a/device-types/net/device-conformance.tex
>>> +++ b/device-types/net/device-conformance.tex
>>> @@ -14,4 +14,5 @@
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation
>>> / Control Virtqueue / Automatic receive steering in multiqueue mode}  \item
>>> \ref{devicenormative:Device Types / Network Device / Device Operation /
>>> Control Virtqueue / Receive-side scaling (RSS) / RSS processing}  \item
>>> \ref{devicenormative:Device Types / Network Device / Device Operation /
>>> Control Virtqueue / Notifications Coalescing}
>>> +\item \ref{devicenormative:Device Types / Network Device / Device
>>> +Operation / Control Virtqueue / Inner Header Hash}
>>>   \end{itemize}
>>> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-
>>> conformance.tex
>>> index 97d0cc1..9d853d9 100644
>>> --- a/device-types/net/driver-conformance.tex
>>> +++ b/device-types/net/driver-conformance.tex
>>> @@ -14,4 +14,5 @@
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation
>>> / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>>> \item \ref{drivernormative:Device Types / Network Device / Device Operation /
>>> Control Virtqueue / Receive-side scaling (RSS) }  \item
>>> \ref{drivernormative:Device Types / Network Device / Device Operation /
>>> Control Virtqueue / Notifications Coalescing}
>>> +\item \ref{drivernormative:Device Types / Network Device / Device
>>> +Operation / Control Virtqueue / Inner Header Hash}
>>>   \end{itemize}
>>> diff --git a/introduction.tex b/introduction.tex index b7155bf..3f34950 100644
>>> --- a/introduction.tex
>>> +++ b/introduction.tex
>>> @@ -102,6 +102,46 @@ \section{Normative References}\label{sec:Normative
>>> References}
>>>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve
>>> Cryptography'', Version 1.0, September 2000.
>>>   	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>>>
>>> +	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
>>> +    Generic Routing Encapsulation. This protocol is only specified for IPv4 and
>>> used as either the payload or delivery protocol.
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
>>> +	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
>>> +    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. This
>>> protocol describes extensions by which two fields, Key and
>>> +    Sequence Number, can be optionally carried in the GRE Header
>>> \ref{intro:gre_rfc2784}.
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
>>> +	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
>>> +    IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is
>>> specified for IPv6 and used as either the payload or
>>> +    delivery protocol. Note that this does not change the GRE header format or
>>> any behaviors specified by RFC 2784 or RFC 2890.
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
>>> +	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]}
>>> &
>>> +    GRE-in-UDP Encapsulation. This specifies a method of encapsulating
>>> network protocol packets within GRE and UDP headers.
>>> +    This GRE-in-UDP encapsulation allows the UDP source port field to be used
>>> as an entropy field. This protocol is specified for IPv4 and IPv6,
>>> +    and used as either the payload or delivery protocol.
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
>>> +	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
>>> +    Virtual eXtensible Local Area Network.
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
>>> +	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
>>> +    Generic Protocol Extension for VXLAN. This protocol describes extending
>>> Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN
>>> header.
>>> +	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-
>>> 12.txt}\\
>>> +	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
>>> +    Generic Network Virtualization Encapsulation.
>>> +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
>>> +	\phantomsection\label{intro:ipip}\textbf{[IPIP]} &
>>> +    IP Encapsulation within IP.
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
>>> +	\phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
>>> +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
>>> +	\phantomsection\label{intro:IP}\textbf{[IP]} &
>>> +    INTERNET PROTOCOL
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
>>> +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
>>> +    User Datagram Protocol
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
>>> +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
>>> +    TRANSMISSION CONTROL PROTOCOL
>>> +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>>>   \end{longtable}
>>>
>>>   \section{Non-Normative References}
>>> --
>>> 2.19.1.6.gb485710b
>> With above small fixes,
>> Reviewed-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

