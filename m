Return-Path: <virtio-dev-return-11669-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881A7C74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 05:13:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D930860349
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 05:13:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC79598644E
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 05:13:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD08F983DFC; Tue, 21 Mar 2023 05:13:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A67AC9863AC;
	Tue, 21 Mar 2023 05:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VeLiMzW_1679375572;
Message-ID: <02ccb0b4-93cb-93ab-7d4d-4bcfd72aaf05@linux.alibaba.com>
Date: Tue, 21 Mar 2023 13:12:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230320111840.64039-1-hengqi@linux.alibaba.com>
 <20230320144625-mutt-send-email-mst@kernel.org>
 <CACGkMEtYUURmSV-4t_Tjf7kVz8h+ABYr5Rh-U3xiuOkVMJ9Cnw@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEtYUURmSV-4t_Tjf7kVz8h+ABYr5Rh-U3xiuOkVMJ9Cnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash



在 2023/3/21 上午11:35, Jason Wang 写道:
> On Tue, Mar 21, 2023 at 3:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Mar 20, 2023 at 07:18:40PM +0800, Heng Qi wrote:
>>> 1. Currently, a received encapsulated packet has an outer and an inner header, but
>>> the virtio device is unable to calculate the hash for the inner header. Multiple
>>> flows with the same outer header but different inner headers are steered to the
>>> same receive queue. This results in poor receive performance.
>>>
>>> To address this limitation, a new feature VIRTIO_NET_F_HASH_TUNNEL has been
>>> introduced, which enables the device to advertise the capability to calculate the
>>> hash for the inner packet header. Compared with the out header hash, it regains
>>> better receive performance.
>> So this would be a very good argument however the cost would be it would
>> seem we have to keep extending this indefinitely as new tunneling
>> protocols come to light.
>> But I believe in fact we don't at least for this argument:
>> the standard way to address this is actually by propagating entropy
>> from inner to outer header.
> Things would be more complicated when multiple layers of tunneling are
> being used.
>
>> So I'd maybe reorder the commit log and give the explanation 2 below
>> then say "for some legacy systems
>> including entropy in IP header
>> as done in modern protocols is not practical, resulting in
>> bad performance under RSS".
>>
>>
>>> 2. The same flow can traverse through different tunnels, resulting in the encapsulated
>>> packets being spread across multiple receive queues (refer to the figure below).
>>> However, in certain scenarios, it becomes necessary to direct these encapsulated
>>> packets of the same flow to a single receive queue. This facilitates the processing
>>> of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
>>>
>>>                 client1                    client2
>>>                    |                          |
>>>                    |        +-------+         |
>>>                    +------->|tunnels|<--------+
>>>                             +-------+
>>>                                |  |
>>>                                |  |
>>>                                v  v
>>>                        +-----------------+
>>>                        | processing host |
>>>                        +-----------------+
>> necessary is too strong a word I feel.
>> All this is, is an optimization, we don't really know how strong it is
>> even.
>>
>> Here's how I understand this:
>>
>> Imagine two clients client1 and client2 talking to each other.
>> A copy of all packets is sent to a processing host over a virtio device.
>> Two directions of the same flow between two clients might be
>> encapsulated in two different tunnels, with current RSS
>> strategies they would land on two arbitrary, unrelated queues.
>> As an optimization, some hosts might wish to make sure both directions
>> of the encapsulated flow land on the same queue.
>>
>>
>> Is this a good summary?
>>
>>
>> Now that things begin to be clearer, I kind of begin to agree with
>> Jason's suggestion that this is extremely narrow.  And what if I want
>> one direction on queue1 and another one queue2 e.g. adjacent numbers for
>> the same flow?  If enough people agree this is needed we can accept this
>> but did you at all consider using something programmable like BPF for
>> this?  Considering we are putting not insignificant amount of work into
>> this, making this widely useful would be better than a narrow
>> optimization for a very specific usecase.
> +1
>
>
>>
>>> To achieve this, the device can calculate a symmetric hash based on the inner packet
>>> headers of the flow. The symmetric hash disregards the order of the 5-tuple when
>>> computing the hash.
>> when you say symmetric hash you really mean symmetric key for toeplitz, yes?
>> It's not that it disregards order, it just gives the same result if
>> you reverse source and destination, no?
>>
>>
>>> Reviewed-by: Jason Wang <jasowang@redhat.com>
> I'd like to drop my reviewed-by since the patch differs from the one
> that I reviewed in many places.

Ok, I'll remove your reviewed tag.

Thank you very much!

>
> Thanks
>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>> v10->v11:
>>>        1. Revise commit log for clarity for readers.
>>>        2. Some modifications to avoid undefined terms. @Parav Pandit
>>>        3. Change VIRTIO_NET_F_HASH_TUNNEL dependency. @Parav Pandit
>>>        4. Add the normative statements. @Parav Pandit
>>>
>>> v9->v10:
>>>        1. Removed hash_report_tunnel related information. @Parav Pandit
>>>        2. Re-describe the limitations of QoS for tunneling.
>>>        3. Some clarification.
>>>
>>> v8->v9:
>>>        1. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
>>>        2. Add tunnel security section. @Michael S . Tsirkin
>>>        3. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
>>>        4. Fix some typos.
>>>        5. Add more tunnel types. @Michael S . Tsirkin
>>>
>>> v7->v8:
>>>        1. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
>>>        2. Change hash_report_tunnel to hash_report_tunnel_types. @Parav Pandit
>>>        3. Removed re-definition for inner packet hashing. @Parav Pandit
>>>        4. Fix some typos. @Michael S . Tsirkin
>>>        5. Clarify some sentences. @Michael S . Tsirkin
>>>
>>> v6->v7:
>>>        1. Modify the wording of some sentences for clarity. @Michael S. Tsirkin
>>>        2. Fix some syntax issues. @Michael S. Tsirkin
>>>
>>> v5->v6:
>>>        1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
>>>        2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
>>>        3. Move the links to introduction section. @Michael S. Tsirkin
>>>        4. Clarify some sentences. @Michael S. Tsirkin
>>>
>>> v4->v5:
>>>        1. Clarify some paragraphs. @Cornelia Huck
>>>        2. Fix the u8 type. @Cornelia Huck
>>>
>>> v3->v4:
>>>        1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
>>>        2. Make things clearer. @Jason Wang @Michael S. Tsirkin
>>>        3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
>>>        4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
>>>
>>> v2->v3:
>>>        1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
>>>        2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
>>>
>>> v1->v2:
>>>        1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>>>        2. Clarify some paragraphs. @Jason Wang
>>>        3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
>>>
>>>   device-types/net/description.tex        | 119 +++++++++++++++++++++++-
>>>   device-types/net/device-conformance.tex |   1 +
>>>   device-types/net/driver-conformance.tex |   1 +
>>>   introduction.tex                        |  24 +++++
>>>   4 files changed, 144 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
>>> index 0500bb6..49dee2f 100644
>>> --- a/device-types/net/description.tex
>>> +++ b/device-types/net/description.tex
>>> @@ -83,6 +83,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>>       channel.
>>>
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner packet header hash
>>> +    for tunnel-encapsulated packets.
>>> +
>>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>>>
>>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>>> @@ -139,6 +142,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS and/or VIRTIO_NET_F_HASH_REPORT.
>>>   \end{description}
>>>
>>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -198,6 +202,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>>>           u8 rss_max_key_size;
>>>           le16 rss_max_indirection_table_length;
>>>           le32 supported_hash_types;
>>> +        le32 supported_tunnel_hash_types;
>>>   };
>>>   \end{lstlisting}
>>>   The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>>> @@ -212,6 +217,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>>>   Field \field{supported_hash_types} contains the bitmask of supported hash types.
>>>   See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types} for details of supported hash types.
>>>
>>> +The next field, \field{supported_tunnel_hash_types} only exists if the device
>>> +supports inner packet header hash, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
>>> +
>>> +Field \field{supported_tunnel_hash_types} contains the bitmask of supported tunnel hash types.
>>> +See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled tunnel hash types} for details of supported tunnel hash types.
>>> +
>>>   \devicenormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>>>
>>>   The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000 inclusive,
>>> @@ -848,6 +859,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   If the feature VIRTIO_NET_F_RSS was negotiated:
>>>   \begin{itemize}
>>>   \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
>>> +\item The device uses \field{hash_tunnel_types} of the virtio_net_rss_config structure as 'Enabled hash tunnel types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>>>   \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
>>>   \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
>>>   \end{itemize}
>>> @@ -855,6 +867,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   If the feature VIRTIO_NET_F_RSS was not negotiated:
>>>   \begin{itemize}
>>>   \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
>>> +\item The device uses \field{hash_tunnel_types} of the virtio_net_hash_config structure as 'Enabled hash tunnel types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>>>   \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
>>>   \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
>>>   \end{itemize}
>>> @@ -870,6 +883,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>
>>>   \subparagraph{Supported/enabled hash types}
>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
>>> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
>>> +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>>>   Hash types applicable for IPv4 packets:
>>>   \begin{lstlisting}
>>>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
>>> @@ -980,6 +995,99 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>   (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
>>>   \end{itemize}
>>>
>>> +\paragraph{Inner Packet Header Hash}
>>> +If the driver negotiates the VIRTIO_NET_F_HASH_TUNNEL feature, it can configure the
>>> +hash parameters (including \field{hash_tunnel_types}) for inner packet header hash
>>> +through the VIRTIO_NET_CTRL_MQ_HASH_CONFIG or the VIRTIO_NET_CTRL_RSS_CONFIG command.
>>> +If multiple commands are sent, the device configuration will be defined by the last command received.
>>> +
>>> +If a specific encapsulation type is set in \field{hash_tunnel_types}, the device will calculate the
>>> +hash on the inner packet header of the encapsulated packet (See \ref{sec:Device Types
>>> +/ Network Device / Device OperatiHn / Processing of Incoming Packets /
>>> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}). If the encapsulation
>>> +type is not included in \field{hash_tunnel_types} or the value of \field{hash_tunnel_types}
>>> +is VIRTIO_NET_HASH_TUNNEL_TYPE_NONE, the device calculates the hash on the outer header.
>>> +
>>> +\field{hash_tunnel_types} is set to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE by the device for non-encapsulated packets.
>>> +
>>> +\subparagraph{Tunnel/Encapsulated packet}
>>> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
>>> +A tunnel packet is encapsulated from the original packet based on the tunneling
>>> +protocol (only a single level of encapsulation is currently supported). The
>>> +encapsulated packet contains an outer header and an inner header, and the device
>>> +calculates the hash over either the inner header or the outer header.
>>> +
>>> +When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated
>>> +packet's outer header matches one of the supported \field{hash_tunnel_types},
>>> +the hash of the inner header is calculated. Supported encapsulation types are listed
>>> +in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming
>>> +Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
>>> +
>>> +Some encapsulated packet types: \hyperref[intro:GRE]{[GRE]}, \hyperref[intro:VXLAN]{[VXLAN]},
>>> +\hyperref[intro:GENEVE]{[GENEVE]}, \hyperref[intro:IPIP]{[IPIP]} and \hyperref[intro:NVGRE]{[NVGRE]}.
>>> +
>>> +\subparagraph{Supported/enabled tunnel hash types}
>>> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled tunnel hash types}
>>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and \field{hash_tunnel_types}
>>> +is set to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE, the device calculates the hash using the
>>> +outer header of the encapsulated packet.
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE        (1 << 0)
>>> +\end{lstlisting}
>>> +
>>> +The encapsulation hash type below indicates that the hash is calculated over the
>>> +inner packet header:
>>> +Hash type applicable for inner payload of the gre-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 1)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the vxlan-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 2)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the geneve-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 3)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the ip-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 4)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the nvgre-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 5)
>>> +\end{lstlisting}
>>> +
>>> +\subparagraph{Tunnel QoS limitation}
>>> +When a specific receive queue is shared by multiple tunnels to receive encapsulated packets,
>>> +there is no quality of service (QoS) for these packets. For example, when the packets of certain
>>> +tunnels are spread across multiple receive queues, these receive queues may have an unbalanced
>>> +amount of packets. This can cause a specific receive queue to become full, resulting in packet loss.
>>> +
>>> +Possible mitigations:
>>> +\begin{itemize}
>>> +\item Use a tool with good forwarding performance to keep the receive queue from filling up.
>>> +\item If the QoS is unavailable, the driver can set \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
>>> +      to disable inner packet hash for encapsulated packets.
>>> +\item Choose a hash key that can avoid queue collisions.
>>> +\item Perform appropriate QoS before packets consume the receive buffers of the receive queues.
>>> +\end{itemize}
>>> +
>>> +The limitations mentioned above exist with/without the inner packer header hash.
>>> +
>>> +\devicenormative{\subparagraph}{Inner Packet Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Packet Header Hash}
>>> +
>>> +The device MUST calculate the outer packet hash if the received encapsulated packet has an encapsulation type not in \field{supported_tunnel_hash_types}.
>>> +
>>> +The device MUST drop the encapsulated packet if the destination receive queue is being reset.
>> I'm not sure how this last one got here. It seems to have nothing to do
>> with encapsulation - if we want to we should require this for all
>> packets or none at all.
>>
>>
>>> +\drivernormative{\subparagraph}{Inner Packet Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Packet Header Hash}
>>> +
>>> +If the driver does not negotiate the VIRTIO_NET_F_HASH_TUNNEL feature, it MUST set \field{hash_tunnel_types}
>>> +to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE before issuing the command VIRTIO_NET_CTRL_MQ_HASH_CONFIG or VIRTIO_NET_CTRL_RSS_CONFIG.
>>> +
>>> +The driver MUST set \field{hash_tunnel_types} to the encapsulation types supported by the device.
>> unclear. seems to mean all types must be approved
>> where you really mean "only those types". original for non tunnel is:
>>
>> A driver MUST NOT set any VIRTIO_NET_HASH_TYPE_ flags that are not supported by a device.
>>
>> which is clear though a bit verbose with two negations.
>>
>> Also here it says "supported" but below it says "allowed".
>>
>>
>>
>>>   \paragraph{Hash reporting for incoming packets}
>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
>>>
>>> @@ -1392,12 +1500,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>       le16 reserved[4];
>>>       u8 hash_key_length;
>>>       u8 hash_key_data[hash_key_length];
>>> +    le32 hash_tunnel_types;
>>>   };
>> Hmm this fixed type after variable type is problematic - might
>> become unaligned. We could use some of reserved[4]
>> for this ...
>>
>>
>>
>>>   \end{lstlisting}
>>>   Field \field{hash_types} contains a bitmask of allowed hash types as
>>>   defined in
>>>   \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
>>> -Initially the device has all hash types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
>>> +
>>> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunnel types as
>>> +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
>>> +
>>> +Initially the device has all hash types and hash tunnel types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
>>>
>>>   Field \field{reserved} MUST contain zeroes. It is defined to make the structure to match the layout of virtio_net_rss_config structure,
>>>   defined in \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS)}.
>>> @@ -1421,6 +1534,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>       le16 max_tx_vq;
>>>       u8 hash_key_length;
>>>       u8 hash_key_data[hash_key_length];
>>> +    le32 hash_tunnel_types;
>>
>> Same alignment problem here but I'm not sure how to solve it.
>> Suggestions?
>>
>>>   };
>>>   \end{lstlisting}
>>>   Field \field{hash_types} contains a bitmask of allowed hash types as
>>> @@ -1441,6 +1555,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>
>>>   Fields \field{hash_key_length} and \field{hash_key_data} define the key to be used in hash calculation.
>>>
>>> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunnel types as
>>> +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
>>> +
>>>   \drivernormative{\subparagraph}{Setting RSS parameters}{Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>>>
>>>   A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
>>> diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
>>> index 54f6783..0ff5944 100644
>>> --- a/device-types/net/device-conformance.tex
>>> +++ b/device-types/net/device-conformance.tex
>>> @@ -14,4 +14,5 @@
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Packet Header Hash}
>>>   \end{itemize}
>>> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-conformance.tex
>>> index 97d0cc1..951be89 100644
>>> --- a/device-types/net/driver-conformance.tex
>>> +++ b/device-types/net/driver-conformance.tex
>>> @@ -14,4 +14,5 @@
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Packet Header Hash}
>>>   \end{itemize}
>>> diff --git a/introduction.tex b/introduction.tex
>>> index 287c5fc..25c9d48 100644
>>> --- a/introduction.tex
>>> +++ b/introduction.tex
>>> @@ -99,6 +99,30 @@ \section{Normative References}\label{sec:Normative References}
>>>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>>>        \newline\url{https://www.secg.org/sec1-v2.pdf}\\
>>>
>>> +     \phantomsection\label{intro:GRE}\textbf{[GRE]} &
>>> +    Generic Routing Encapsulation
>>> +     \newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
>> This is GRE over IPv4.
>> So we are not supporting GRE over IPv6?
>>
>> And we do not support optional keys?
>>
>>
>>
>>> +     \phantomsection\label{intro:VXLAN}\textbf{[VXLAN]} &
>>> +    Virtual eXtensible Local Area Network
>>> +     \newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
>>> +     \phantomsection\label{intro:GENEVE}\textbf{[GENEVE]} &
>>> +    Generic Network Virtualization Encapsulation
>>> +     \phantomsection\label{intro:IPIP}\textbf{[IPIP]} &
>>> +    IP Encapsulation within IP
>>> +     \newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
>>> +     \phantomsection\label{intro:IPIP}\textbf{[NVGRE]} &
>>> +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
>>> +     \newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
>>> +     \newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
>>> +     \phantomsection\label{intro:IP}\textbf{[IP]} &
>>> +    INTERNET PROTOCOL
>>> +     \newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
>>> +     \phantomsection\label{intro:UDP}\textbf{[UDP]} &
>>> +    User Datagram Protocol
>>> +     \newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
>>> +     \phantomsection\label{intro:TCP}\textbf{[TCP]} &
>>> +    TRANSMISSION CONTROL PROTOCOL
>>> +     \newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>>>   \end{longtable}
>>>
>>>   \section{Non-Normative References}
>>> --
>>> 2.19.1.6.gb485710b
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

