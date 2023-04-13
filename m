Return-Path: <virtio-dev-return-12206-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E15C77B6C
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 11:03:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D928D3309C
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 11:03:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF5D9986600
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 11:03:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3C97986360; Thu, 13 Apr 2023 11:03:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B35569865F8;
	Thu, 13 Apr 2023 11:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vg.ST4-_1681383807;
Message-ID: <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
Date: Thu, 13 Apr 2023 19:03:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
To: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net: support inner header
 hash



在 2023/4/13 上午11:40, Jason Wang 写道:
>
> 在 2023/4/3 12:58, Heng Qi 写道:
>> 1. Currently, a received encapsulated packet has an outer and an 
>> inner header, but
>> the virtio device is unable to calculate the hash for the inner 
>> header. The same
>> flow can traverse through different tunnels, resulting in the 
>> encapsulated
>> packets being spread across multiple receive queues (refer to the 
>> figure below).
>> However, in certain scenarios, we may need to direct these 
>> encapsulated packets of
>> the same flow to a single receive queue. This facilitates the processing
>> of the flow by the same CPU to improve performance (warm caches, less 
>> locking, etc.).
>>
>>                 client1                    client2
>>                    |        +-------+         |
>>                    +------->|tunnels|<--------+
>>                             +-------+
>>                                |  |
>>                                v  v
>>                        +-----------------+
>>                        | monitoring host |
>>                        +-----------------+
>>
>> To achieve this, the device can calculate a suitable hash based on 
>> the inner headers
>> of this flow, for example using the Toeplitz combined with a 
>> symmetric hash key.
>
>
> Some device allows sorting n tuples before calculating hash, do we 
> need to consider them?

If a device supports inner header hash and it has the ability to sort 
tuples, the device can
choose to continue to sort tuples or continue to do a symmetric hash 
(use a special hash key, symmetric toeplitz hash or xor hash) .
It depends on them, but I think we can document these for readers.

>
>
>> 2. For legacy systems, they may lack entropy fields which modern 
>> protocols have in
>> the outer header, resulting in multiple flows with the same outer 
>> header but
>> different inner headers being directed to the same receive queue. 
>> This results in
>> poor receive performance.
>>
>> To address this limitation, inner header hash can be used to enable 
>> the device to advertise
>> the capability to calculate the hash for the inner packet, regaining 
>> better receive performance.
>>
>> Signed-off-by: Heng Qi<hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>> ---
>> v11->v12:
>>     1. Add a command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG.
>>     2. Refine the commit log. @Michael S . Tsirkin
>>     3. Add some tunnel types.
>>
>> v10->v11:
>>     1. Revise commit log for clarity for readers.
>>     2. Some modifications to avoid undefined terms. @Parav Pandit
>>     3. Change VIRTIO_NET_F_HASH_TUNNEL dependency. @Parav Pandit
>>     4. Add the normative statements. @Parav Pandit
>>
>> v9->v10:
>>     1. Removed hash_report_tunnel related information. @Parav Pandit
>>     2. Re-describe the limitations of QoS for tunneling.
>>     3. Some clarification.
>>
>> v8->v9:
>>     1. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
>>     2. Add tunnel security section. @Michael S . Tsirkin
>>     3. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
>>     4. Fix some typos.
>>     5. Add more tunnel types. @Michael S . Tsirkin
>>
>> v7->v8:
>>     1. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
>>     2. Change hash_report_tunnel to hash_report_tunnel_types. @Parav 
>> Pandit
>>     3. Removed re-definition for inner packet hashing. @Parav Pandit
>>     4. Fix some typos. @Michael S . Tsirkin
>>     5. Clarify some sentences. @Michael S . Tsirkin
>>
>> v6->v7:
>>     1. Modify the wording of some sentences for clarity. @Michael S. 
>> Tsirkin
>>     2. Fix some syntax issues. @Michael S. Tsirkin
>>
>> v5->v6:
>>     1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
>>     2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
>>     3. Move the links to introduction section. @Michael S. Tsirkin
>>     4. Clarify some sentences. @Michael S. Tsirkin
>>
>> v4->v5:
>>     1. Clarify some paragraphs. @Cornelia Huck
>>     2. Fix the u8 type. @Cornelia Huck
>>
>> v3->v4:
>>     1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to 
>> VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
>>     2. Make things clearer. @Jason Wang @Michael S. Tsirkin
>>     3. Keep the possibility to use inner hash for automatic receive 
>> steering. @Jason Wang
>>     4. Add the "Tunnel packet" paragraph to avoid repeating the GRE 
>> etc. many times. @Michael S. Tsirkin
>>
>> v2->v3:
>>     1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
>>     2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. 
>> @Jason Wang, @Michael S. Tsirkin
>>
>> v1->v2:
>>     1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>>     2. Clarify some paragraphs. @Jason Wang
>>     3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri 
>> Benditovich
>>
>>   device-types/net/description.tex        | 143 ++++++++++++++++++++++++
>>   device-types/net/device-conformance.tex |   1 +
>>   device-types/net/driver-conformance.tex |   1 +
>>   introduction.tex                        |  44 ++++++++
>>   4 files changed, 189 insertions(+)
>>
>> diff --git a/device-types/net/description.tex 
>> b/device-types/net/description.tex
>> index 0500bb6..121585e 100644
>> --- a/device-types/net/description.tex
>> +++ b/device-types/net/description.tex
>> @@ -83,6 +83,9 @@ \subsection{Feature bits}\label{sec:Device Types / 
>> Network Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>   +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash
>> +    for tunnel-encapsulated packets.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications 
>> coalescing.
>>     \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 
>> packets.
>> @@ -139,6 +142,7 @@ \subsubsection{Feature bit 
>> requirements}\label{sec:Device Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or 
>> VIRTIO_NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along 
>> with VIRTIO_NET_F_RSS and/or VIRTIO_NET_F_HASH_REPORT.
>>   \end{description}
>>     \subsubsection{Legacy Interface: Feature bits}\label{sec:Device 
>> Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -198,6 +202,7 @@ \subsection{Device configuration 
>> layout}\label{sec:Device Types / Network Device
>>           u8 rss_max_key_size;
>>           le16 rss_max_indirection_table_length;
>>           le32 supported_hash_types;
>> +        le32 supported_tunnel_hash_types;
>>   };
>>   \end{lstlisting}
>>   The following field, \field{rss_max_key_size} only exists if 
>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>> @@ -212,6 +217,12 @@ \subsection{Device configuration 
>> layout}\label{sec:Device Types / Network Device
>>   Field \field{supported_hash_types} contains the bitmask of 
>> supported hash types.
>>   See \ref{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash types} for details of supported hash 
>> types.
>>   +Field \field{supported_tunnel_hash_types} only exists if the device
>> +supports inner header hash, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
>> +
>> +Filed \field{supported_tunnel_hash_types} contains the bitmask of 
>> supported tunnel hash types.
>> +See \ref{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled encapsulation hash types} for details of 
>> supported tunnel hash types.
>> +
>>   \devicenormative{\subsubsection}{Device configuration 
>> layout}{Device Types / Network Device / Device configuration layout}
>>     The device MUST set \field{max_virtqueue_pairs} to between 1 and 
>> 0x8000 inclusive,
>> @@ -848,6 +859,7 @@ \subsubsection{Processing of Incoming 
>> Packets}\label{sec:Device Types / Network
>>   If the feature VIRTIO_NET_F_RSS was negotiated:
>>   \begin{itemize}
>>   \item The device uses \field{hash_types} of the 
>> virtio_net_rss_config structure as 'Enabled hash types' bitmask.
>> +\item The device uses \field{hash_tunnel_types} of the 
>> virtio_net_hash_tunnel_config structure as 'Enabled hash tunnel 
>> types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>>   \item The device uses a key as defined in \field{hash_key_data} and 
>> \field{hash_key_length} of the virtio_net_rss_config structure (see
>>   \ref{sec:Device Types / Network Device / Device Operation / Control 
>> Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
>>   \end{itemize}
>> @@ -855,6 +867,7 @@ \subsubsection{Processing of Incoming 
>> Packets}\label{sec:Device Types / Network
>>   If the feature VIRTIO_NET_F_RSS was not negotiated:
>>   \begin{itemize}
>>   \item The device uses \field{hash_types} of the 
>> virtio_net_hash_config structure as 'Enabled hash types' bitmask.
>> +\item The device uses \field{hash_tunnel_types} of the 
>> virtio_net_hash_tunnel_config structure as 'Enabled hash tunnel 
>> types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>>   \item The device uses a key as defined in \field{hash_key_data} and 
>> \field{hash_key_length} of the virtio_net_hash_config structure (see
>>   \ref{sec:Device Types / Network Device / Device Operation / Control 
>> Virtqueue / Automatic receive steering in multiqueue mode / Hash 
>> calculation}).
>>   \end{itemize}
>> @@ -870,6 +883,8 @@ \subsubsection{Processing of Incoming 
>> Packets}\label{sec:Device Types / Network
>>     \subparagraph{Supported/enabled hash types}
>>   \label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash types}
>> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
>> +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>>   Hash types applicable for IPv4 packets:
>>   \begin{lstlisting}
>>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
>> @@ -980,6 +995,133 @@ \subsubsection{Processing of Incoming 
>> Packets}\label{sec:Device Types / Network
>>   (see \ref{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / IPv6 packets without extension header}).
>>   \end{itemize}
>>   +\paragraph{Inner Header Hash}
>> +\label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Inner Header Hash}
>> +
>> +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the device supports 
>> inner header hash and
>> +the driver can configure the inner header hash calculation for 
>> encapsulated packets \ref{sec:Device Types / Network Device / Device 
>> OperatiHn / Processing of Incoming Packets / Hash calculation for 
>> incoming packets / Tunnel/Encapsulated packet}
>> +by issuing the command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG from the 
>> class VIRTIO_NET_CTRL_MQ.
>> +The command sets \field{hash_tunnel_types} in the structure 
>> virtio_net_hash_tunnel_config.
>> +
>> +struct virtio_net_hash_tunnel_config {
>> +    le32 hash_tunnel_types;
>> +};
>> +
>> +Filed \field{hash_tunnel_types} contains a bitmask of supported hash 
>> tunnel types as
>> +defined in \ref{sec:Device Types / Network Device / Device Operation 
>> / Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash tunnel types}.
>> +
>> +\subparagraph{Tunnel/Encapsulated packet}
>> +\label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Tunnel/Encapsulated packet}
>> +
>> +A tunnel packet is encapsulated from the original packet based on 
>> the tunneling
>> +protocol (only a single level of encapsulation is currently 
>> supported). The
>> +encapsulated packet contains an outer header and an inner header, 
>> and the device
>> +calculates the hash over either the inner header or the outer header.
>> +
>> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received 
>> encapsulated packet's
>> +outer header matches one of the supported \field{hash_tunnel_types}, 
>> the hash
>> +of the inner header is calculated.
>
>
> GRE allows X over Y, we'd better document what is supported in X and Y 

Yes, I will do.

> (I guess they are implied in the supported_hash_types?)

Yes, but as you suggest we should document these explicitly.

>
>
>> +
>> +Supported encapsulated packet types:
>> +\begin{itemize}
>> +\item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}
>> +\item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}
>> +\item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}
>> +\item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}
>> +\item \hyperref[intro:vxlan]{[VXLAN]}
>> +\item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}
>> +\item \hyperref[intro:geneve]{[GENEVE]}
>> +\item \hyperref[intro:ipip]{[IPIP]}
>> +\item \hyperref[intro:nvgre]{[NVGRE]}
>> +\item \hyperref[intro:sit]{[STT]}
>> +\end{itemize}
>> +
>> +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type 
>> is not included in
>> +\field{hash_tunnel_types}, the hash of the outer header is 
>> calculated for the received encapsulated packet.
>> +
>> +The hash is calculated for the received non-encapsulated packet as 
>> if VIRTIO_NET_F_HASH_TUNNEL was not negotiated.
>> +
>> +\subparagraph{Supported/enabled encapsulation hash types}
>> +\label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled encapsulation hash types}
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE        (1 << 0)
>> +\end{lstlisting}
>> +
>> +Supported encapsulation hash types:
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 1)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 2)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 3)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 4)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:vxlan]{[VXLAN]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 5)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 6)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:geneve]{[GENEVE]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 7)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:ipip]{[IPIP]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 8)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:nvgre]{[NVGRE]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 9)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the 
>> \hyperref[intro:stt]{[STT]} packet:
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_STT         (1 << 10)
>> +\end{lstlisting}
>> +
>> +\subparagraph{Tunnel QoS limitation}
>> +When a specific receive queue is shared by multiple tunnels to 
>> receive encapsulated packets,
>> +there is no quality of service (QoS) for these packets.
>
>
> This is up to the implementation, so I'm not sure it's worthwhile for 
> mentioning things like this and the "limitation".
>

Yes, I see what you mean. As we discussed before, similar to the RFCs of 
various tunnels, they all briefly mention
security issues. Perhaps we can modify them into some simple suggestions 
here, similar to Tunnel QoS Advices:
(1)Use a tool with good forwarding performance to keep the receive queue 
from filling up;
(2)...

Anyway, I'm ok with these, it's up to you.

>
>>   For example, when the packets of certain
>> +tunnels are spread across multiple receive queues, these receive 
>> queues may have an unbalanced
>> +amount of packets. This can cause a specific receive queue to become 
>> full, resulting in packet loss.
>
>
> We have many places that can lead to packet dropping. For example, the 
> automatic steering is best effort. I tend to avoid mentioning things 
> like this.

Ok. And Michael what do you think about this?

>
>
>> +
>> +Possible mitigations:
>> +\begin{itemize}
>> +\item Use a tool with good forwarding performance to keep the 
>> receive queue from filling up.
>> +\item If the QoS is unavailable, the driver can set 
>> \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
>> +      to disable inner header hash for encapsulated packets.
>> +\item Choose a hash key that can avoid queue collisions.
>> +\item Perform appropriate QoS before packets consume the receive 
>> buffers of the receive queues.
>> +\end{itemize}
>> +
>> +The limitations mentioned above exist with/without the inner header 
>> hash.
>
>
> This conflicts with the tile "Tunnel QoS limitation" which readers may 
> think it happens only for tunnel.

Perhaps a "QoS Advices" is better?

Thanks!

>
> Thanks
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: 
> https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

