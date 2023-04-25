Return-Path: <virtio-dev-return-12415-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C72C77B71
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:28:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E504120D42
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:28:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83BE3986642
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:28:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 75A44986475; Tue, 25 Apr 2023 20:28:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 614EA986474;
	Tue, 25 Apr 2023 20:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpQjNlmySOTlbRO6JKnXOrOzHWhmi+DKMf+l6ppjZSpQyE8AMsijeIs30NyiOPG/FXoZh9HJrDooQLNErN0DZlww7+CpmyunuSO055Ocm6s0HYCwtMDYab36/YgAs/ZDXRwImssPT67qoPfcT/1CRjim3THZzc4JGTq+kKaYUP+upwXq1Kt1hRQsKQog2Z8S0zHa9oh2t1vp0mSglLJPLGSICqN04nbwhxF23CvZNRq0Ch/z9qBQcLAVnNaY/A0VksM8y8tN9drrA4jsnxZOHZvrNhntUXL5AKkhJ6miHmOG8uIV8aMEeWstp6XMGlcwJU05IbJh41tWFwmlky5xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWMNi5hmgmOjmRBe6plB6CpkryAVdIRC7Uy5ezmUqZE=;
 b=mM1RPeDwupb71m/+6/k+MQ6J10dhOJ5w3IYmmue/05dmfanVt53JMZ9r345i58G6IMOnMpGsz1SeWcfxjW/CMli1Tv6hua98jJ89bI0MqRKdeBk01mP5K3MM40tODRmetlVLkJY7BYu5/MKNT4w836TOtCySwjvowaCD24TOK9cU4BOcuUD8B5sfdnRbVBFSALpjYpgdva3IbgsZ2F3unlgWe3kSjKaFohuvatLwtk/h8Sb6KMs4dcWLtWlQUZy3ZYlSNLmNdLuPUXg3ArBva1AzcXyrKXpwNa+b/NsM+ic1tB66gc6CLssWKkg5NoK828xubvogPHrLCXnb+AEyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
Date: Tue, 25 Apr 2023 16:28:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230423073532.105636-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::8) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: a9808f37-4202-47eb-d2b2-08db45cba5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cK2uXIs/lRSvjGyxPPDJwR2sXeYpRfsR0IjmLx+tZH9dLDQNqJ+9FMbqocepfSJbhpGIR+N2mZcl4XWG1sAEv7sC7HrR5o5YP0GYSguP/STTv5KMLs78+Oi5w7iXi7wn15AXtg7vprK12tfgLLKvCNZoPgLYtLGoxFVn8AWlePP7lOGM82CaVhhCRGnkflHf9id3V08utdzxwazh0MG63fYiuMy4/NyyZGO3TCQJM9JfGWMq/deXJKLaRYytea01433JphcSPzGC18vu60/zsKUjDP788pAbWJZOnYq6fG00teUCFRW57JsEl95CR3EF/goICMuPb+7VhyawJG672RY9LRlP1oq0pmwf9oZiuFlQ7iLwMctzGw7eujpWdZA3q4dvUfc+DvN8zBoZTjj1q2tKvohv1bERhASZnBonUHmpZhasDzaW6935gzuXsQXlYVe59J5pQb+jkqiCJiZC6a960DYf08ePC/ylN/J9N7J70mQmmTteEzGd/m9UMBCDWlM5wICPFOcEh0biG3OzXdG4jk6uMaNhvjkoGsT19HTMmFdHC9MJKkc3tV6Wc5B7+YgYhQ/zCbIrXKi3MojrhS3kc4P1d7fE/N6X6FPPFmIQm3dSSMrP1R5zCnpgJAo2KO4bZenXSw1u9Y//aPbaUCDYFhVyUDE4LSyZl1z2piJIUw89D9NkMSm+5payvHG+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(31686004)(36756003)(5660300002)(2906002)(8676002)(316002)(8936002)(66946007)(38100700002)(66556008)(41300700001)(86362001)(31696002)(4326008)(66476007)(966005)(186003)(6506007)(54906003)(26005)(6512007)(53546011)(6486002)(2616005)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXV0U2NYb3VSR0g1bWd0ZDVNLy9HazB2V0F1RUpsNldqUk9kbE55UmxHcVVx?=
 =?utf-8?B?bEdNVTFsWms3d0FmZjJOZldYYUU4ZisxQ0tOU1hkbnlpNkFuMHBna1k4NWp0?=
 =?utf-8?B?Y3ZSU0ZzbU5aYzZDa29RckRxelo1alRaRU1ldzhEVTZsdDdqN0NzRjhxU1Vy?=
 =?utf-8?B?dnRJZFlTY0Z3c1IyN1dFKzRSdVJhcHRDaEszV0Z4cjZPcnpFQVF4N1BVWm5C?=
 =?utf-8?B?WStVV29UV2Q4NGpCTGJUKzJ6V2s5cG5XMnQvRUpDNVlhbnhFU0U4K1lwQjA4?=
 =?utf-8?B?YTF1ZXVweENoZnlocVlxN09LTFdJMVIrVjdDTXJyWFhOd1NVcGxETFlBdURM?=
 =?utf-8?B?T3BEUExoVVdYU0VxV2QzWXRCNUdSdFoxTU4vUm5xbVloTTVrZWtDUElYMXZN?=
 =?utf-8?B?c3N3SGcvQUF5UVo4ZmVxK2h3blVlanIwMzRBWVNwMFVsUGVYZHhONWRoMHFl?=
 =?utf-8?B?MzJmUEZIZUVSTWhwZzltRHFBaXdLQnBSWTVKZ3NiL0tKUXFGQmhaS3FjZG9R?=
 =?utf-8?B?dVNiRFFHWjhOYkhPVkV2WVcvWjI4OVYyOHM3VHhVV3p2V3JzM2xQMFV4MklP?=
 =?utf-8?B?RHNYMXNObkdwdElLTUgyVWVDWnh4YytzR1BXeFEyVGEvQmlHaWpDQzQwQVJn?=
 =?utf-8?B?eTJPc3J0OE1WOHRSRldhQVVUV05TbTdFWGVvWHhvN244NTlvcUpPS1J2NDBH?=
 =?utf-8?B?VU1HbWhQRHkxTlltdzhZSVYyZ0hFQTYzbVhSN1hxcDlRSnNGZWRDQm5NV1ZC?=
 =?utf-8?B?QW1XQ3lWa2REOW56VXloZWpjZ3I0YU1hekhORmp6a1V0MHNtQ0hIdEJtNjhq?=
 =?utf-8?B?MnpyWVlzY25yZ3d2VHBEVmFKODdHSUUxVmNJeVNrNXM3cXp4REc4Y1VIbWZj?=
 =?utf-8?B?UlBhS3VpMkhpVTQyaWxCclBiRmlvcHdOTzZrNkx0QzZkUEJqVFltTzVSOUdH?=
 =?utf-8?B?dnpVV2IxZ1RpaEVwQVpsNi9rRFhaSEdvOWNwRTB0MlVjR1FnZFRUbHpKME4v?=
 =?utf-8?B?QURFU0ExZjRkZzM1eHFNUFZzbkVFZllMREIxRmNBVUsyYmlqM0RqRXdGKzVH?=
 =?utf-8?B?K1JKMDF4N2NZSHJMUk96UEN5YmNXelMxbWJFanNEVW40d3UzckJzY0dQVmc2?=
 =?utf-8?B?N0NLc25OSmRLbVNKbjdxdkpLalZqR0FYQ0s4cnJBK25mUHVLZGpVMG1ibDZK?=
 =?utf-8?B?KzRURUJLaDlBSE4rVHJRL2xXSXF6YzFUVHpObUwrajcwZ05vRDd6U0RkMVQv?=
 =?utf-8?B?dEhUTTJaV0RiV0NWVVVqRmltaW9RUXNTSnFTZ2xmTUUrcjUyUG9MNjhNRjdL?=
 =?utf-8?B?VDdCT2txTHJ4MS9uQzVVdFFGQmRnSzhlekxxT3U4cFlkcFRZd2doUjFuOFRR?=
 =?utf-8?B?OUZJbWpsaWVHSkUzaFRRVU82OFR5VVFVQ0JEbEluaVBBZDJqOVVlcGFNZUQ0?=
 =?utf-8?B?VkdqeThvaitNOWlyekJ1WTdCKzJZaldRQkZHWlVSdDBWRlBPWlB1d202R2Ix?=
 =?utf-8?B?bndzU2RZVzRaM0U4Z0pnVWQvU1RsQWp5cGF0UDI5RW5abG1DU1JrOTI5Wnk2?=
 =?utf-8?B?MmdPK0poQVVNMXZSQnp4L05wYVFjaTJ5NXJkNkhJeVVxUDFSWmthS3VrYmls?=
 =?utf-8?B?Q1h5b2VubWZYL1BxdmxVSW01K0MyaWZ6R25VZ1QyNFp2ZEdreHREWWQ2aWRx?=
 =?utf-8?B?bGYrS2pwdnFrTDVORWYvZk5oU2lOL2ovNUMvcDVlUHdNVUMyS0ovTjRYUkZp?=
 =?utf-8?B?c1NSNzl4SUtVY2FGZUJJQ1hNcnk5K0xTWHhQcXlrZzhVV0VPV0VhNFo2OFJV?=
 =?utf-8?B?TDdQSEczY1FRaW9nNXBuTEROOWRGMXR4RUJOcDJSS1drck5nMU40OG9YYVd6?=
 =?utf-8?B?eDJCYmpqVVRKQmZDRXNNVEJqcUQzbXBrcHJWbmQrNHdtbVMxQ0lHNVlJWk5X?=
 =?utf-8?B?MEE0L2dHT2lnY012aHo0ckJDa0E5bXFTMTNRMWVhTk9jRUZ3dTBoazZ1Vm0y?=
 =?utf-8?B?R0dwWU5Xa0hKVmxZalZQWEpjWisySWQ1c1VBcGZud09yMS9iZVF6VStkdGFV?=
 =?utf-8?B?VEJiNnBlSXhHNVN3SHlDYVkybWFzWGoxc1o1VW9EUHQ2VG5iODljTzRMNi8v?=
 =?utf-8?Q?5efQJAxuOo9+Mg4kbD0s4qPR1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9808f37-4202-47eb-d2b2-08db45cba5ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 20:28:36.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiC07di8dleM5cSfItxRBcJo9FkpwtPBC4OBU1MnwZ+d5uVEvXroF2lai+lmuvsDbsAx+uxQRQKjI0TdCsucfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
Subject: [virtio-dev] Re: [PATCH v13] virtio-net: support inner header hash



On 4/23/2023 3:35 AM, Heng Qi wrote:
>   
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -198,6 +202,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>           u8 rss_max_key_size;
>           le16 rss_max_indirection_table_length;
>           le32 supported_hash_types;
> +        le32 supported_tunnel_hash_types;
>   };
In v12 I was asking this to move to above field from the config area to 
the GET command in comment [1] as,

"With that no need to define two fields at two different places in 
config area and also in cvq."

I am sorry if that was not clear enough.

[1] 
https://lore.kernel.org/virtio-dev/569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com/

>   \subparagraph{Supported/enabled hash types}
>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>   Hash types applicable for IPv4 packets:
>   \begin{lstlisting}
>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> @@ -980,6 +993,152 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
>   \end{itemize}
>   
> +\paragraph{Inner Header Hash}
> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
> +
> +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the device supports inner header hash and the driver can send
> +commands VIRTIO_NET_CTRL_TUNNEL_HASH_SET and VIRTIO_NET_CTRL_TUNNEL_HASH_GET for the inner header hash configuration.
> +
> +struct virtio_net_hash_tunnel_config {
Please move field from the config struct to here. Both are RO fields.

le32 supported_hash_tunnel_types;
> +    le32 hash_tunnel_types;
> +};
> +
> +#define VIRTIO_NET_CTRL_TUNNEL_HASH 7
> + #define VIRTIO_NET_CTRL_TUNNEL_HASH_SET 0
> + #define VIRTIO_NET_CTRL_TUNNEL_HASH_GET 1
> +
> +Filed \field{hash_tunnel_types} contains a bitmask of configured hash tunnel types as
> +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
> +
> +The class VIRTIO_NET_CTRL_TUNNEL_HASH has the following commands:
> +\begin{itemize}
> +\item VIRTIO_NET_CTRL_TUNNEL_HASH_SET: set the \field{hash_tunnel_types} to configure the inner header hash calculation for the device.
> +\item VIRTIO_NET_CTRL_TUNNEL_HASH_GET: get the \field{hash_tunnel_types} from the device.
> +\end{itemize}
> +
> +For the command VIRTIO_NET_CTRL_TUNNEL_HASH_SET, the structure virtio_net_hash_tunnel_config is write-only for the driver.
> +For the command VIRTIO_NET_CTRL_TUNNEL_HASH_GET, the structure virtio_net_hash_tunnel_config is read-only for the driver.
> +
You need to split the structures to two, one for get and one for set in 
above description as get and set contains different fields.
> +
> +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is not included in \field{hash_tunnel_types},
> +the hash of the outer header is calculated for the received encapsulated packet.
> +
> +
> +For scenarios with sufficient external entropy or no internal hashing requirements, inner header hash may not be needed:
> +A tunnel is often expected to isolate the external network from the internal one. By completely ignoring entropy
> +in the external header and replacing it with entropy from the internal header, for hash calculations, this expectation
You wanted to say inner here like rest of the places.

s/internal header/inner header

> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags that are not supported by the device.
Multiple flags so,

s/flags that are/flags which are/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

