Return-Path: <virtio-dev-return-12430-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A480C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 13:42:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 75BE9339BE
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 13:42:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6701E986650
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 13:42:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A8B6986640; Wed, 26 Apr 2023 13:42:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4602198663F;
	Wed, 26 Apr 2023 13:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vh3Y9BA_1682516566;
Message-ID: <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
Date: Wed, 26 Apr 2023 21:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v13] virtio-net: support inner header hash



在 2023/4/26 上午4:28, Parav Pandit 写道:
>
>
> On 4/23/2023 3:35 AM, Heng Qi wrote:
>>     \subsubsection{Legacy Interface: Feature bits}\label{sec:Device 
>> Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -198,6 +202,7 @@ \subsection{Device configuration 
>> layout}\label{sec:Device Types / Network Device
>>           u8 rss_max_key_size;
>>           le16 rss_max_indirection_table_length;
>>           le32 supported_hash_types;
>> +        le32 supported_tunnel_hash_types;
>>   };
> In v12 I was asking this to move to above field from the config area 
> to the GET command in comment [1] as,
>
> "With that no need to define two fields at two different places in 
> config area and also in cvq."

I'm not sure if this is sufficiently motivated, RSS also has 
supports_hash_types in config space.

We don't actually need cvq and config to sync on 
supported_tunnel_hash_types, since it doesn't need to change (meaning 
supported_tunnel_hash_types doesn't send configuration change 
notifications).

>
> I am sorry if that was not clear enough.
>
> [1] 
> https://lore.kernel.org/virtio-dev/569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com/
>
>>   \subparagraph{Supported/enabled hash types}
>>   \label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash types}
>> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]}, 
>> \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>>   Hash types applicable for IPv4 packets:
>>   \begin{lstlisting}
>>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
>> @@ -980,6 +993,152 @@ \subsubsection{Processing of Incoming 
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
>> inner header hash and the driver can send
>> +commands VIRTIO_NET_CTRL_TUNNEL_HASH_SET and 
>> VIRTIO_NET_CTRL_TUNNEL_HASH_GET for the inner header hash configuration.
>> +
>> +struct virtio_net_hash_tunnel_config {
> Please move field from the config struct to here. Both are RO fields.
>
> le32 supported_hash_tunnel_types;
>> +    le32 hash_tunnel_types;
>> +};
>> +
>> +#define VIRTIO_NET_CTRL_TUNNEL_HASH 7
>> + #define VIRTIO_NET_CTRL_TUNNEL_HASH_SET 0
>> + #define VIRTIO_NET_CTRL_TUNNEL_HASH_GET 1
>> +
>> +Filed \field{hash_tunnel_types} contains a bitmask of configured 
>> hash tunnel types as
>> +defined in \ref{sec:Device Types / Network Device / Device Operation 
>> / Processing of Incoming Packets / Hash calculation for incoming 
>> packets / Supported/enabled hash tunnel types}.
>> +
>> +The class VIRTIO_NET_CTRL_TUNNEL_HASH has the following commands:
>> +\begin{itemize}
>> +\item VIRTIO_NET_CTRL_TUNNEL_HASH_SET: set the 
>> \field{hash_tunnel_types} to configure the inner header hash 
>> calculation for the device.
>> +\item VIRTIO_NET_CTRL_TUNNEL_HASH_GET: get the 
>> \field{hash_tunnel_types} from the device.
>> +\end{itemize}
>> +
>> +For the command VIRTIO_NET_CTRL_TUNNEL_HASH_SET, the structure 
>> virtio_net_hash_tunnel_config is write-only for the driver.
>> +For the command VIRTIO_NET_CTRL_TUNNEL_HASH_GET, the structure 
>> virtio_net_hash_tunnel_config is read-only for the driver.
>> +
> You need to split the structures to two, one for get and one for set 
> in above description as get and set contains different fields.
>> +
>> +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type 
>> is not included in \field{hash_tunnel_types},
>> +the hash of the outer header is calculated for the received 
>> encapsulated packet.
>> +
>> +
>> +For scenarios with sufficient external entropy or no internal 
>> hashing requirements, inner header hash may not be needed:
>> +A tunnel is often expected to isolate the external network from the 
>> internal one. By completely ignoring entropy
>> +in the external header and replacing it with entropy from the 
>> internal header, for hash calculations, this expectation
> You wanted to say inner here like rest of the places.
>
> s/internal header/inner header

I want to make the 'external' and 'internal' correspond, but avoid the 
internal header, and use a unified 'inner header' is also reasonable.:)

>
>
>> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags that 
>> are not supported by the device.
> Multiple flags so,
>
> s/flags that are/flags which are/

Will fix.

Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

