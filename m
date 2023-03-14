Return-Path: <virtio-dev-return-11613-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE58C74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 14 Mar 2023 13:59:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 491E3190925
	for <virtio-dev@archiver.kernel.org>; Tue, 14 Mar 2023 13:59:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30983986398
	for <virtio-dev@archiver.kernel.org>; Tue, 14 Mar 2023 13:59:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1FD76985FF0; Tue, 14 Mar 2023 13:59:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A13398635A;
	Tue, 14 Mar 2023 13:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdsVXUJ_1678802358;
Message-ID: <45039ab0-e703-7fce-b2cd-328fb2e7303c@linux.alibaba.com>
Date: Tue, 14 Mar 2023 21:59:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230306154817.14115-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support inner header hash

Hi, Parav, do you have any comments on this? :)

Thanks!

在 2023/3/6 下午11:48, Heng Qi 写道:
> Currently, a received encapsulated packet has an outer and an inner header, but
> the virtio device is unable to calculate the hash for the inner header. Multiple
> flows with the same outer header but different inner headers are steered to the
> same receive queue. This results in poor receive performance.
>
> To address this limitation, a new feature VIRTIO_NET_F_HASH_TUNNEL has been
> introduced, which enables the device to advertise the capability to calculate the
> hash for the inner packet header. Compared with the out header hash, it regains
> better receive performance.
>
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v9->v10:
> 	1. Removed hash_report_tunnel related information. @Parav Pandit
> 	2. Re-describe the limitations of QoS for tunneling.
> 	3. Some clarification.
>
> v8->v9:
> 	1. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
> 	2. Add tunnel security section. @Michael S . Tsirkin
> 	3. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
> 	4. Fix some typos.
> 	5. Add more tunnel types. @Michael S . Tsirkin
>
> v7->v8:
> 	1. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
> 	2. Change hash_report_tunnel to hash_report_tunnel_types. @Parav Pandit
> 	3. Removed re-definition for inner packet hashing. @Parav Pandit
> 	4. Fix some typos. @Michael S . Tsirkin
> 	5. Clarify some sentences. @Michael S . Tsirkin
>
> v6->v7:
> 	1. Modify the wording of some sentences for clarity. @Michael S. Tsirkin
> 	2. Fix some syntax issues. @Michael S. Tsirkin
>
> v5->v6:
> 	1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
> 	2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
> 	3. Move the links to introduction section. @Michael S. Tsirkin
> 	4. Clarify some sentences. @Michael S. Tsirkin
>
> v4->v5:
> 	1. Clarify some paragraphs. @Cornelia Huck
> 	2. Fix the u8 type. @Cornelia Huck
>
> v3->v4:
> 	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
> 	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
> 	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
> 	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
>
> v2->v3:
> 	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
> 	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
>
> v1->v2:
> 	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> 	2. Clarify some paragraphs. @Jason Wang
> 	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
>
>   device-types/net/description.tex | 120 +++++++++++++++++++++++++++++--
>   introduction.tex                 |  24 +++++++
>   2 files changed, 140 insertions(+), 4 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 0500bb6..e53d625 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -83,6 +83,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>   
> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash
> +    for tunnel-encapsulated packets.
> +
>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>   
>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -139,6 +142,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \end{description}
>   
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -198,20 +202,27 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>           u8 rss_max_key_size;
>           le16 rss_max_indirection_table_length;
>           le32 supported_hash_types;
> +        le32 supported_tunnel_hash_types;
>   };
>   \end{lstlisting}
> -The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
> +The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
>   It specifies the maximum supported length of RSS key in bytes.
>   
>   The following field, \field{rss_max_indirection_table_length} only exists if VIRTIO_NET_F_RSS is set.
>   It specifies the maximum number of 16-bit entries in RSS indirection table.
>   
>   The next field, \field{supported_hash_types} only exists if the device supports hash calculation,
> -i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
> +i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
>   
>   Field \field{supported_hash_types} contains the bitmask of supported hash types.
>   See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types} for details of supported hash types.
>   
> +The next field, \field{supported_tunnel_hash_types} only exists if the device
> +supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
> +
> +Field \field{supported_tunnel_hash_types} contains the bitmask of supported tunnel hash types.
> +See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled tunnel hash types} for details of supported tunnel hash types.
> +
>   \devicenormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>   
>   The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000 inclusive,
> @@ -235,7 +246,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>   negotiated.
>   
>   The device MUST set \field{rss_max_key_size} to at least 40, if it offers
> -VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> +VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL.
>   
>   The device MUST set \field{rss_max_indirection_table_length} to at least 128, if it offers
>   VIRTIO_NET_F_RSS.
> @@ -843,11 +854,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   \begin{itemize}
>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
>   \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
> +\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The device supports inner hash calculation.
>   \end{itemize}
>   
>   If the feature VIRTIO_NET_F_RSS was negotiated:
>   \begin{itemize}
>   \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
> +\item The device uses \field{hash_tunnel_types} of the virtio_net_rss_config structure as 'Enabled hash tunnel types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>   \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
>   \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
>   \end{itemize}
> @@ -855,6 +868,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   If the feature VIRTIO_NET_F_RSS was not negotiated:
>   \begin{itemize}
>   \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
> +\item The device uses \field{hash_tunnel_types} of the virtio_net_hash_config structure as 'Enabled hash tunnel types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>   \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
>   \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
>   \end{itemize}
> @@ -868,8 +882,26 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>    \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
>   \end{itemize}
>   
> +\subparagraph{Tunnel/Encapsulated packet}
> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
> +A tunnel packet is encapsulated from the original packet based on the tunneling
> +protocol (only a single level of encapsulation is currently supported). The
> +encapsulated packet contains an outer header and an inner header, and the device
> +calculates the hash over either the inner header or the outer header.
> +
> +When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated
> +packet's outer header matches one of the supported \field{hash_tunnel_types},
> +the hash of the inner header is calculated. Supported encapsulation types are listed
> +in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming
> +Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
> +
> +Some encapsulated packet types: \hyperref[intro:GRE]{[GRE]}, \hyperref[intro:VXLAN]{[VXLAN]},
> +\hyperref[intro:GENEVE]{[GENEVE]}, \hyperref[intro:IPIP]{[IPIP]} and \hyperref[intro:NVGRE]{[NVGRE]}.
> +
>   \subparagraph{Supported/enabled hash types}
>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
> +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>   Hash types applicable for IPv4 packets:
>   \begin{lstlisting}
>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> @@ -889,6 +921,39 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>   \end{lstlisting}
>   
> +\subparagraph{Supported/enabled tunnel hash types}
> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled tunnel hash types}
> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the value of
> +\field{hash_tunnel_types} is set to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE,
> +the device calculates the hash using the outer header of the encapsulated packet.
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE         (1 << 0)
> +\end{lstlisting}
> +
> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the encapsulation
> +hash type below indicates that the hash is calculated over the inner header of
> +the encapsulated packet:
> +Hash type applicable for inner payload of the gre-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 1)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the vxlan-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 2)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the geneve-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 3)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the ip-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 4)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the nvgre-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 5)
> +\end{lstlisting}
> +
>   \subparagraph{IPv4 packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
>   The device calculates the hash on IPv4 packets according to 'Enabled hash types' bitmask as follows:
> @@ -980,6 +1045,44 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
>   \end{itemize}
>   
> +\subparagraph{Inner hash calculation of an encapsulated packet}
> +If the driver negotiates the VIRTIO_NET_F_HASH_TUNNEL feature, it can configure the
> +hash parameters (including \field{hash_tunnel_types}) for inner hash calculation by
> +sending the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command. Additionally, if the VIRTIO_NET_F_RSS
> +feature is also negotiated, the driver can use the VIRTIO_NET_CTRL_RSS_CONFIG command to
> +configure the hash parameters. If multiple commands are sent, the device configuration
> +will be defined by the last command received.
> +
> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
> +encapsulation hash type is set in \field{hash_tunnel_types}, the device calculates the
> +hash on the inner header of an encapsulated packet (See \ref{sec:Device Types
> +/ Network Device / Device Operation / Processing of Incoming Packets /
> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}). If the encapsulation
> +type of an encapsulated packet is not included in \field{hash_tunnel_types} or the value
> +of \field{hash_tunnel_types} is VIRTIO_NET_HASH_TUNNEL_TYPE_NONE, the device calculates
> +the hash on the outer header.
> +
> +\field{hash_tunnel_types} is set to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE by the device for the
> +unencapsulated packets.
> +
> +\subparagraph{Tunnel QoS limitation}
> +Note that the limitation mentioned below is not only introduced by inner hash calculation,
> +and the limitation of the tunnel itself, and even the driver may have only one receive queue.
> +
> +When a specific receive queue is shared by multiple tunnels to receive encapsulating packets,
> +there is no quality of service (QoS) for these packets of multiple tunnels. For example, when the
> +flooded packets of a certain tunnel are hashed to the queue, it may cause the traffic of this
> +queue to be unbalanced, resulting in potential packet loss and data delay.
> +
> +Possible mitigations:
> +\begin{itemize}
> +\item Use a tool with good forwarding performance such as DPDK to keep the queue from filling up.
> +\item If the quality of service is unavailable, the driver can set \field{hash_tunnel_types} to
> +      VIRTIO_NET_HASH_TUNNEL_TYPE_NONE to disable inner hash calculation for encapsulated packets.
> +\item Choose a hash key that can avoid queue collisions.
> +\item Outside the device, prevent abnormal traffic from entering or switch the traffic to attack clusters.
> +\end{itemize}
> +
>   \paragraph{Hash reporting for incoming packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
>   
> @@ -1392,12 +1495,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>       le16 reserved[4];
>       u8 hash_key_length;
>       u8 hash_key_data[hash_key_length];
> +    le32 hash_tunnel_types;
>   };
>   \end{lstlisting}
>   Field \field{hash_types} contains a bitmask of allowed hash types as
>   defined in
>   \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
> -Initially the device has all hash types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
> +
> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunnel types as
> +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
> +
> +Initially the device has all hash types and hash tunnel types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
>   
>   Field \field{reserved} MUST contain zeroes. It is defined to make the structure to match the layout of virtio_net_rss_config structure,
>   defined in \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS)}.
> @@ -1421,6 +1529,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>       le16 max_tx_vq;
>       u8 hash_key_length;
>       u8 hash_key_data[hash_key_length];
> +    le32 hash_tunnel_types;
>   };
>   \end{lstlisting}
>   Field \field{hash_types} contains a bitmask of allowed hash types as
> @@ -1441,6 +1550,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   
>   Fields \field{hash_key_length} and \field{hash_key_data} define the key to be used in hash calculation.
>   
> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunnel types as
> +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
> +
>   \drivernormative{\subparagraph}{Setting RSS parameters}{Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>   
>   A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
> diff --git a/introduction.tex b/introduction.tex
> index 287c5fc..25c9d48 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -99,6 +99,30 @@ \section{Normative References}\label{sec:Normative References}
>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>   	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>   
> +	\phantomsection\label{intro:GRE}\textbf{[GRE]} &
> +    Generic Routing Encapsulation
> +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> +	\phantomsection\label{intro:VXLAN}\textbf{[VXLAN]} &
> +    Virtual eXtensible Local Area Network
> +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> +	\phantomsection\label{intro:GENEVE}\textbf{[GENEVE]} &
> +    Generic Network Virtualization Encapsulation
> +	\phantomsection\label{intro:IPIP}\textbf{[IPIP]} &
> +    IP Encapsulation within IP
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> +	\phantomsection\label{intro:IPIP}\textbf{[NVGRE]} &
> +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> +	\phantomsection\label{intro:IP}\textbf{[IP]} &
> +    INTERNET PROTOCOL
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
> +    User Datagram Protocol
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
> +    TRANSMISSION CONTROL PROTOCOL
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>   \end{longtable}
>   
>   \section{Non-Normative References}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

