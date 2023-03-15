Return-Path: <virtio-dev-return-11622-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36718C76195
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 13:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8D72C1922E3
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 13:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EBF1986742
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 13:20:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 737A8986406; Wed, 15 Mar 2023 13:20:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16CE4986402;
	Wed, 15 Mar 2023 13:19:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdwTLnp_1678886385;
Message-ID: <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
Date: Wed, 15 Mar 2023 21:19:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support inner header hash



在 2023/3/15 上午11:23, Parav Pandit 写道:
>
>
> On 3/6/2023 10:48 AM, Heng Qi wrote:
>
>>   +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash
> May be to say inner packet header hash..
> This make its little more clear about "which header" that you 
> explained in the commit log.
>

Sure, I'll add this.

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
>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
> I think this should also say that HASH_TUNNEL requires either of the 
> F_RSS or F_HASH_REPORT.
> Because without it HASH_TUNNEL is not useful.

F_HASH_TUNNEL indicates that the hash should be calculated using the 
inner packet header, even without F_RSS or F_HASH_REPORT,
we can continue to use the hash value in scenarios such as RPS or ebpf 
programs.

> Right?
> if no, than my below comments are meaningless.

I think it's fine to let F_HASH_TUNNEL rely on F_RSS or _F_HASH_REPORT 
as those are probably important scenarios where inner packet header hash 
is used.

>
>
>>   \end{description}
>>     \subsubsection{Legacy Interface: Feature bits}\label{sec:Device 
>> Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -198,20 +202,27 @@ \subsection{Device configuration 
>> layout}\label{sec:Device Types / Network Device
>>           u8 rss_max_key_size;
>>           le16 rss_max_indirection_table_length;
>>           le32 supported_hash_types;
>> +        le32 supported_tunnel_hash_types;
>>   };
>>   \end{lstlisting}
>> -The following field, \field{rss_max_key_size} only exists if 
>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>> +The following field, \field{rss_max_key_size} only exists if 
>> VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or 
>> VIRTIO_NET_F_HASH_TUNNEL is set.
>>   It specifies the maximum supported length of RSS key in bytes.
>>
> I think rss_max_key_size field dependency should be only of the 
> existing feature bits F_RSS and F_HASH_REPORT.
> This is because those are the bits really deciding to consider 
> rss_max_key_size.
>
>>   The following field, \field{rss_max_indirection_table_length} only 
>> exists if VIRTIO_NET_F_RSS is set.
>>   It specifies the maximum number of 16-bit entries in RSS 
>> indirection table.
>>     The next field, \field{supported_hash_types} only exists if the 
>> device supports hash calculation,
>> -i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>> +i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or 
>> VIRTIO_NET_F_HASH_TUNNEL is set.
>>
> Same as above.
>
>>   Field \field{supported_hash_types} contains the bitmask of 
>> supported hash types.
>>   See \ref{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash types} for details of supported hash 
>> types.
>>   +The next field, \field{supported_tunnel_hash_types} only exists if 
>> the device
>> +supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is 
>> set.
>> +
> Above line "the next field .." can be just same as "Device supports 
> inner packet header hash calculation, i.e..."
> This is because here, the term "header" is missed, which is present in 
> the definition of feature bit 52.

I'll rephrase the description to make the whole text more consistent.

>
>>     The device MUST set \field{rss_max_key_size} to at least 40, if 
>> it offers
>> -VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
>> +VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL.
> This needs change if the above first comment about rss_max_key_size is 
> right.
>
>>   The device MUST set \field{rss_max_indirection_table_length} to at 
>> least 128, if it offers
>>   VIRTIO_NET_F_RSS.
>> @@ -843,11 +854,13 @@ \subsubsection{Processing of Incoming 
>> Packets}\label{sec:Device Types / Network
>>   \begin{itemize}
>>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses 
>> the hash to determine the receive virtqueue to place incoming packets.
>>   \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The 
>> device reports the hash value and the hash type with the packet.
>> +\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The 
>> device supports inner hash calculation.
>>   \end{itemize}
>>
> inner packet header hash ..

Ok.

>
>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the 
>> encapsulation
>> +hash type below indicates that the hash is calculated over the inner 
>> header of
>> +the encapsulated packet:
>> +Hash type applicable for inner payload of the gre-encapsulated packet
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 1)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the vxlan-encapsulated packet
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 2)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the geneve-encapsulated 
>> packet
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 3)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the ip-encapsulated packet
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 4)
>> +\end{lstlisting}
>> +Hash type applicable for inner payload of the nvgre-encapsulated packet
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 5)
>> +\end{lstlisting}
>> +
> Any encapsulation technology that includes UDP/L4 header likely do not 
> prefer based on the inner header. This is because the outer header src 
> port entropy is added based on the inner header.
>
> I was not able to follow the discussion in v9 that you had with Michael.
> Did you conclude if this is needed for vxlan too?
>
> If not, for now it may be better to skip vxlan and nvegre as they 
> inherently have unique outer header UDP src port based on the inner 
> header.

Symmetric hashing ignores the order of the five-tuples when calculating 
the hash, that is, using (a1,a2,p1,p2) and (a2,a1,p2,p1) respectively 
can calculate the same hash.
There is a scenario that the two directions client1->client2 and 
client2->client1 of the same flow may pass through different tunnels.
In order to allow the data in two directions to be processed by the same 
CPU, we need to calculate a symmetric hash based on the inner packet header.
Sorry I didn't mention this earlier just to avoid introducing the 
concept of symmetric hashing.

>
>>   \subparagraph{IPv4 packets}
>>   \label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / IPv4 packets}
>>   The device calculates the hash on IPv4 packets according to 
>> 'Enabled hash types' bitmask as follows:
>> @@ -980,6 +1045,44 @@ \subsubsection{Processing of Incoming 
>> Packets}\label{sec:Device Types / Network
>>   (see \ref{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / IPv6 packets without extension header}).
>>   \end{itemize}
>>   +\subparagraph{Inner hash calculation of an encapsulated packet}
>> +If the driver negotiates the VIRTIO_NET_F_HASH_TUNNEL feature, it 
>> can configure the
>> +hash parameters (including \field{hash_tunnel_types}) for inner hash 
>> calculation by
>> +sending the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command. Additionally, if 
>> the VIRTIO_NET_F_RSS
>> +feature is also negotiated, the driver can use the 
>> VIRTIO_NET_CTRL_RSS_CONFIG command to
>> +configure the hash parameters. If multiple commands are sent, the 
>> device configuration
>> +will be defined by the last command received.
>> +
>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the 
>> corresponding
>> +encapsulation hash type is set in \field{hash_tunnel_types}, the 
>> device calculates the
>> +hash on the inner header of an encapsulated packet (See 
>> \ref{sec:Device Types
>> +/ Network Device / Device Operation / Processing of Incoming Packets /
>> +Hash calculation for incoming packets / Tunnel/Encapsulated 
>> packet}). If the encapsulation
>> +type of an encapsulated packet is not included in 
>> \field{hash_tunnel_types} or the value
>> +of \field{hash_tunnel_types} is VIRTIO_NET_HASH_TUNNEL_TYPE_NONE, 
>> the device calculates
>> +the hash on the outer header.
>> +
>> +\field{hash_tunnel_types} is set to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE 
>> by the device for the
>> +unencapsulated packets.
>> +
>> +\subparagraph{Tunnel QoS limitation}
>> +Note that the limitation mentioned below is not only introduced by 
>> inner hash calculation,
>> +and the limitation of the tunnel itself, and even the driver may 
>> have only one receive queue.
>> +
> When there is a single receive queue, there is no tunnel QoS issue. 
> Because the same queue is used one or more tunnels.
> So please remove mentioning single queue text here.
>

Ok.

> Also it is better to first describe the limitation and after the 
> reader understand, it make sense to say that the limitation already 
> exists with/without inner header hash calculation.

I'll update this.

>
>> +When a specific receive queue is shared by multiple tunnels to 
>> receive encapsulating packets,
>> +there is no quality of service (QoS) for these packets of multiple 
>> tunnels. 
> "of multiple tunnels at the tail of sentence is not needed because you 
> already have it at "shared by multiple tunnels".

Ok.

>
>> For example, when the
>> +flooded packets of a certain tunnel are hashed to the queue, it may 
>> cause the traffic of this
>> +queue to be unbalanced, resulting in potential packet loss and data 
>> delay.
>> +
> Your example is only talking about single queue..
>
> You probably wanted to say,
>
> When the packets of certain tunnels results in spreading these packets 
> to multiple receive queues, these receive queues may have unbalanced 
> amount of packets. This can result in a specific receive queue being 
> full resulting in packet loss.

Yes, I didn't describe clearly. Thanks for the example!

>
> Or something similar..
>
>> +Possible mitigations:
>> +\begin{itemize}
>> +\item Use a tool with good forwarding performance such as DPDK to 
>> keep the queue from filling up.
> I dont think it is necessary to talk about specific tools like DPDK in 
> specification.
> Even if you omit "such as DPDK", the line reads fine.
> so I suggest to drop "such as DPDK".

I agree.

>
>> +\item If the quality of service is unavailable, the driver can set 
>> \field{hash_tunnel_types} to
>> +      VIRTIO_NET_HASH_TUNNEL_TYPE_NONE to disable inner hash 
>> calculation for encapsulated packets.
>> +\item Choose a hash key that can avoid queue collisions.
>> +\item Outside the device, prevent abnormal traffic from entering or 
>> switch the traffic to attack clusters.
>> +\end{itemize}
> It can still enter the switch but you want to avoid entering the 
> virtio device.
> Cluster is very broad term and not defined in the spec, better to 
> avoid it.
>
> you can rewrite it something like, Perform appropriate QoS before 
> packets consume the receive buffers..
>
> This is generic solution that can be done in device or egress of 
> switch etc, which keep the spec scope upto the device.

I see. This does add a new concept "cluster" beyond the device, and I'll 
remove it.

>
>> +
>>   \paragraph{Hash reporting for incoming packets}
>>   \label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash reporting for incoming packets}
>>   @@ -1392,12 +1495,17 @@ \subsubsection{Control 
>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>       le16 reserved[4];
>>       u8 hash_key_length;
>>       u8 hash_key_data[hash_key_length];
>> +    le32 hash_tunnel_types;
>>   };
>>   \end{lstlisting}
>>   Field \field{hash_types} contains a bitmask of allowed hash types as
>>   defined in
>>   \ref{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash types}.
>> -Initially the device has all hash types disabled and reports only 
>> VIRTIO_NET_HASH_REPORT_NONE.
>> +
>> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash 
>> tunnel types as
>> +defined in \ref{sec:Device Types / Network Device / Device Operation 
>> / Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash tunnel types}.
>> +
>> +Initially the device has all hash types and hash tunnel types 
>> disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
>>     Field \field{reserved} MUST contain zeroes. It is defined to make 
>> the structure to match the layout of virtio_net_rss_config structure,
>>   defined in \ref{sec:Device Types / Network Device / Device 
>> Operation / Control Virtqueue / Receive-side scaling (RSS)}.
>> @@ -1421,6 +1529,7 @@ \subsubsection{Control 
>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>       le16 max_tx_vq;
>>       u8 hash_key_length;
>>       u8 hash_key_data[hash_key_length];
>> +    le32 hash_tunnel_types;
>>   };
>>   \end{lstlisting}
>>   Field \field{hash_types} contains a bitmask of allowed hash types as
>> @@ -1441,6 +1550,9 @@ \subsubsection{Control 
>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>     Fields \field{hash_key_length} and \field{hash_key_data} define 
>> the key to be used in hash calculation.
>>   +Field \field{hash_tunnel_types} contains a bitmask of allowed hash 
>> tunnel types as
>> +defined in \ref{sec:Device Types / Network Device / Device Operation 
>> / Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash tunnel types}.
>> +
>>   \drivernormative{\subparagraph}{Setting RSS parameters}{Device 
>> Types / Network Device / Device Operation / Control Virtqueue / 
>> Receive-side scaling (RSS) }
> You likely need to add device and driver normative statements derived 
> from above text and add their references into
> device-types/net/*-conformance.tex files.

Sure, thanks for the suggestion! :)




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

