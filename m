Return-Path: <virtio-dev-return-12158-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE0C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6FD692AEFF
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D9B1986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 52CE598650E; Wed, 12 Apr 2023 03:05:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 394579864B3;
	Wed, 12 Apr 2023 03:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfuWLcJ_1681268712;
Message-ID: <3638791a-bf64-7130-9c7f-6cb3597228bd@linux.alibaba.com>
Date: Wed, 12 Apr 2023 11:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v12] virtio-net: support inner header hash



在 2023/4/12 上午5:03, Parav Pandit 写道:
>
>
> On 4/3/2023 12:58 AM, Heng Qi wrote:
>
>> To achieve this, the device can calculate a suitable hash based on 
>> the inner headers
>> of this flow, for example using the Toeplitz combined with a 
>> symmetric hash key.
>>
> I am not sure you need symmetric hash key. Toeplitz with symmetric 
> hashing without the symmetric key is possible too.
>
> So just mentioning it as a 'combined with symmetric hashing' is enough.

Yes, as discussed with Michael, we will also support XOR hashing or 
Toeplitz symmetric hashing or even both, I'm thinking of starting a 
draft in a separate thread to let us have initial discussions.

The statement here I will modify.

>
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device 
>> Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -198,6 +202,7 @@ \subsection{Device configuration 
>> layout}\label{sec:Device Types / Network Device
>>           u8 rss_max_key_size;
>>           le16 rss_max_indirection_table_length;
>>           le32 supported_hash_types;
>> +        le32 supported_tunnel_hash_types;
>>   };
> Given that a set command is added via cvq, it make sense to also do 
> symetrric work to get it via a cvq.
> This is also similar to the latest work for notification coalescing 
> for VQ where get and set done using single channel = cvq.

Only set is given to match the existing RSS/HASH configuration methods. 
But we should really look ahead as you suggest.

>
> Granted that RSS and other fields are done differently, but it was bit 
> in the past.

Yes.

>
> With that no need to define two fields at two different places in 
> config area and also in cvq.
>
> Just the new opcode is needed for GET and things will be fine.

Right.

>
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
> VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG_SET
> and
> VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG_GET

Will do.

>
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
> s/one of the supported/one of the configured/
> Because support comes from GET or config space area; out of which a 
> smaller or equal subset of tunnel types are configured.

Yes, configured is obviously more accurate than supported.

>
>> +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / 
>> Network Device / Device Operation / Control Virtqueue / Inner Header 
>> Hash}
>> +
>> +The device MUST calculate the outer header hash if the received 
>> encapsulated packet has an encapsulation type not in 
>> \field{supported_tunnel_hash_types}.
>> +
> Since the configured set can be smaller, a better reword is:
> The device MUST calculate the hash from the outer header if the 
> received encapsulated packet type is not matching from hash_tunnel_types.

Will modify.

>
>> +The device MUST respond to the VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG 
>> command with VIRTIO_NET_ERR if the device
>> +received an unrecognized or unsupported VIRTIO_NET_HASH_TUNNEL_TYPE_ 
>> flag.
>> +
>> +Upon reset, the device MUST initialize \field{hash_tunnel_type} to 0.
>> +
>> +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / 
>> Network Device / Device Operation / Control Virtqueue / Inner Header 
>> Hash}
>> +
>> +The driver MUST have negotiated the feature VIRTIO_NET_F_HASH_TUNNEL 
>> when issuing the command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG.
>> +
>> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags that 
>> are not supported by the device.
>> +
>>   \paragraph{Hash reporting for incoming packets}
>>   \label{sec:Device Types / Network Device / Device Operation / 
>> Processing of Incoming Packets / Hash reporting for incoming packets}
>>   @@ -1308,6 +1450,7 @@ \subsubsection{Control 
>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>    #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0 (for automatic 
>> receive steering)
>>    #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configurable 
>> receive steering)
>>    #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configurable 
>> hash calculation)
>> + #define VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG       3 (for configurable 
>> inner header hash)
> MQ_TUNNEL_CONFIG is not mutually exclusive with HASH or RSS config.
> Hence adding it here is incorrect.
>
> See the text below.
> "If more than one multiqueue mode is negotiated, the resulting device 
> configuration is defined by the last command
> sent by the driver."
>

NOTE: We only have two modes now. The mode is not equal to the command. 
We can add VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG for commands, but there are 
still only two modes:
"
This specification defines the following modes that a device MAY 
implement for operation with multiple transmit/receive virtqueues:
\begin{itemize}
\item Automatic receive steering as defined in \ref{sec:Device Types / 
Network Device / Device Operation / Control Virtqueue / Automatic 
receive steering in multiqueue mode}.
   If a device supports this mode, it offers the VIRTIO_NET_F_MQ feature 
bit.
\item Receive-side scaling as defined in \ref{devicenormative:Device 
Types / Network Device / Device Operation / Control Virtqueue / 
Receive-side scaling (RSS) / RSS processing}.
   If a device supports this mode, it offers the VIRTIO_NET_F_RSS 
feature bit.
\end{itemize}
"


We also say:
“
\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with 
VIRTIO_NET_F_RSS and/or VIRTIO_NET_F_HASH_REPORT.
”
Now,
when VIRTIO_NET_F_RSS is negotiated, we have Receive-side scaling mode.
When VIRTIO_NET_F_HASH_REPORT is negotiated, we also have the mode 
according to:
"
Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it 
supports only one pair of virtqueues, it MUST support
at least one of commands of VIRTIO_NET_CTRL_MQ class to configure 
reported hash parameters:
\begin{itemize}
\item If the device offers VIRTIO_NET_F_RSS, it MUST support 
VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per
   \ref{sec:Device Types / Network Device / Device Operation / Control 
Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}.
\item Otherwise the device MUST support VIRTIO_NET_CTRL_MQ_HASH_CONFIG 
command per
   \ref{sec:Device Types / Network Device / Device Operation / Control 
Virtqueue / Automatic receive steering in multiqueue mode / Hash 
calculation}.
\end{itemize}”

So, it is not incorrect that we put VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG here.


> So MQ_TUNNEL config without RSS or HASH will be an undefined behavior, 
> as it doesn't what kind of hashing to be done.
>
> So please tunnel GET and SET commands outside of VIRTIO_NET_CTRL_MQ.
> This way it can work side by side with rss, hash and auto modes.

Yes, if we will also provide GET commands, it will be clearer to put 
VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG outside of VIRTIO_NET_CTRL_MQ.

Thanks!




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

