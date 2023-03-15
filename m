Return-Path: <virtio-dev-return-11614-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48362C6FD1D
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 03:24:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7F39D676EC
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 03:24:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7262698642A
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 03:24:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 674409863EA; Wed, 15 Mar 2023 03:24:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 485359863D9;
	Wed, 15 Mar 2023 03:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcpe74AYaz7IZcnFycrvFfg4mVKB6Ck1vP3P//eJs7nbb8S7NB9mlZft3hj+M79EqNZVh6VocTBPeaUR4qKimOLRsiBkiM2AqPQs5i0njmUyvKzOUivzrpr4TA8V8NWpAzwDt/ynHBP0Rw1yxP56CryANkThKJ9KLFGfvXkeylOGr8hkJc8C6mdFHtToKC12TJOxqhBqcibyvY9vnxMYvyGVD2RLJu/XixV0PhkkAoUxsFLup6nB5vcbjQgei2nHpN+dMQH+PhyIgf15+0Biambdij3ZcRwEWBj091V6IkVkbYOezQRPKQrHBnvGPtwm3eFiIAzyunZ717ydv3d+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e457qVJLXDxb6VGRkfEW+csQmPFt/fCfL7INGFz3Odg=;
 b=Hn0/oM6x0IB4QZcZz3NX1wxOpUJL4KnN3VEt5G4Br5sjHHY/DhS6h/lnosYEMWoGU5jrfIP35H4+/X2+y8x/CX11G4ts8Ub6E1//OOhX1KjCVlYg0uG+CBNzQFw3BjhBd7mzQpjMR64b+W5TXZ9ZJ6h9xRO9wqsIlJRf0hLQg1HHh9u0A5G+v2/+0E1DmteLC0RWGCTeX88zKG7T6+/6DrfxZEkrPHKMlO0bhA4oSF5pxwIVXTfKT0FD3+crTLeGRwOVFfGrmRjylGQfXwiCj41aS+vVhnggcIxkz0SdMib6rD4FKyxaIDrCYx7MGVcoa3W8JEJOc/2vllVhgqFvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
Date: Tue, 14 Mar 2023 23:23:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230306154817.14115-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:408:e5::7) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a963763-5622-47d2-83db-08db2504b669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGElO4vOyXBaekVEz3lncK3gnryzLD5Y1CY/oniZOCXJeutgUKs1NpRiVERoXWOKeP5aRVcppCB9Be9yFZtUEtaz/JY2QE66VZqczwMscnCKobQ66vVvamSpmsj8KFt6n9yyunslovTfEh1mpLC6psutQ4mXVxYicVGVQq0UTFmrMwaQ1HpuUzqkdIOxWg5Iq4mVSO9cQBbwpAUG2vYOdt9KtGIH3Vi3Lxk+JuEZkf56VegHxE8AOLnTvLl0XpKRQwpEtCjIqOMs29FRutRZpZi+r6ySNZg9GnU/Iw3jorhUAQHzDb4im+XRoOdts7D4GIgOD3wstEs2kFmOBVo8ixH4AFrU1w+R91ZrqDo0x1f0XlgkwERSu/izNyQO0WVJpaoUHI2eOP2lvlb/TnVfbuSmECobybG/VLu1GukB5qTjSm1yyXxOmdPgfsudcSAV0OH6GJb43J9YEeXgfs8/SslqSV0Mq22v0UGeIVocGvNu7boyGikRA1JJYKQ8rDscBOT3obF5nK8ZONhFUsQ100CCKTOFvWtJhKWuaj0jNQJyCyvoZ4vTNIxcvfgEVSYUbbTKiC7PIat2c2NeuIHtdWB69GRy+KQ2RIJ8PU9sy7Z5zLmTUJLzD2PhmgeEiKRp9U9/Tc9yUaj8chbBJdRkTD21RDwc/yT6F9FNVAYZ2oMmXYri9YRkUa/EUV8urVtcdMms+e8qkjz+rahdHwjHtOdwDAGvOQqDalQ3ByKsE0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(36756003)(5660300002)(30864003)(83380400001)(54906003)(478600001)(2616005)(53546011)(6512007)(6506007)(6486002)(186003)(8676002)(66476007)(66556008)(66946007)(8936002)(4326008)(41300700001)(31696002)(86362001)(316002)(38100700002)(66899018)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNUNHpDYytwV0VacXdMNVd0SWJybWhhQytnTERxMVVKNEMzUUpNZWo2QXBJ?=
 =?utf-8?B?Wit4Y3NoUi9NNmN6MXNXem9WejJ4MnlRNDBTY1g2QUdaaFRueHRkaEhhQmZM?=
 =?utf-8?B?bHI5ejRXVS94TWlJaDRnZi94TkdNb3p2dnlPUTNLTlorMkc0dFg2aElqam1D?=
 =?utf-8?B?L2ZPdUVpZUZxc1JsSnhsUTdKMm5TcStLdXNRRC83NU4walBNUmI1aitEK1BE?=
 =?utf-8?B?YmRmSmZEZ3l0cExQNWdSUFJTakordDFYZzFQREE4N1pRVjdWNlJxemNIbDRO?=
 =?utf-8?B?eU8vMG12L3I2OVNiYTFPZUNJWHNNaHM5R0hnK2J0ZzVKdmJsNHhmQ1oxOHNP?=
 =?utf-8?B?ZFVNc0I4dXBUdXBhOFcvYk9PZlVEQkxUcE13dndFR1JnOEowbFZWaE1haXIx?=
 =?utf-8?B?emVydXl2anVaTWxCTnNUMHZxVUtoUjAyMElkRWxFckFwUitkZWsyWkIxUThI?=
 =?utf-8?B?MjVIT1VQSDEyeE8rdUovOEdXNUxLaGtvYnM4TGdpWGtxamEzQ2dNMlQ1a1Zw?=
 =?utf-8?B?aFdKMGQwUkpRTy9GZGhtNkM4cnB2TWNYeVdLYldsMnBCbkorMWtxL1BiSzMv?=
 =?utf-8?B?UngxZms0UXRpNFFvdm01M3BQa2orcS90cnJaRE5QMm0yNkhyVW5Ua1NKbkJ3?=
 =?utf-8?B?L0ZrZ0VwRFFPS2RjbDBoYWZiU3graFZtR3Z6dHk0OTFEREo5V3pPbERVcjV6?=
 =?utf-8?B?c0lteDZBRFc2ZElYSXJyRzZzMEcvemFpemIxYXdHOTBRb0VOZ0ZTUzRxY3lk?=
 =?utf-8?B?L2U3aXdxUGlhMStlMnNlUUZMZ1NmaG5sYzdIMk5TRGxCQjZDbnc1VEtyQzVK?=
 =?utf-8?B?T0R1enowYUpYN2Q1Tk5vV0xkTXVEcWh1aTVTYi9Ga0pKSWpqeDBrTE9OU09z?=
 =?utf-8?B?WHFaMFFzeGZZdzhvbE1CaXM1SWczRXM0dTREYzNuYTBGa29KSk9FUytZVUhW?=
 =?utf-8?B?VVpvWTNsdFk0bllnT1hvbXN0SlMyVHlkZHpDVnFReWs5a2RQdDdVajVaQVRM?=
 =?utf-8?B?WEhGV2dEaVN1NzZhNTFHZklGMy9aZlNvd21paDlJRXROdHJEMHRsYkNGb2Zo?=
 =?utf-8?B?cUd5RDFiOEsvMmlUWmpMSGtmQ1grRlJJRFhKSUN5Rk1EQThmU2JaMDNZa1NN?=
 =?utf-8?B?dzllZnZOWCtNUjRSZ1BBcktldVNJT2kyUEpTODlRTzJhNnJxRUdSVkVMUjY1?=
 =?utf-8?B?M2hrRFdWWmNTdFpjU1RRWlpOOS82dE8vRk1tTkloYUZhL3o4WXNIdml3UVJu?=
 =?utf-8?B?d0Z6bU5FQXh5U1YxZFBaUmsrSUFaVVE4aGRSa3F6ZHhNajhUdXg2aGVJYjR4?=
 =?utf-8?B?Q05nS29ma29sWnZOV3VQZFZUcWI3cDhPVEpjQVozZ3BRMnA3akI1ZktkZmtm?=
 =?utf-8?B?akVrSTllM3J3RmVjblZKdG5BVVVvUXExSWZkdjUwYTdoejRBMzlUMCtGUm5G?=
 =?utf-8?B?ekhUbzNJaGo2UENhTE56OEdlMlhXM0FGQWZHU1pmQVpZUExTU0t5YmtZQmVa?=
 =?utf-8?B?dU9yNExmdjd6SkJjUE1DYW9vZmJXV0owdjh5RlBOcFZFVDV3aXlHNUxFRFlG?=
 =?utf-8?B?Ykx0czFOR01Ua01BZFkvNGlaSFY1ZTNiMGN6bFEzNWhad09CMXlzTjV3U25X?=
 =?utf-8?B?M0xDZDFkc1lTb1JhNnhmQVl3czRkQzJVR3UvODlDeHJNbnlFajdDRlVKTEJP?=
 =?utf-8?B?TG1xNGsvSVlPWVNMY0EyV1RLREZqSkg4NHp5WkltWDlBeUw3YzNzam55RDQ1?=
 =?utf-8?B?dmM5WU90NkgyY3FTREI4U1FUSWt5T2U5eDlrcFBseWNOSTFnWmh3anEwbUgx?=
 =?utf-8?B?TDRYSTdBU1V0b2YvVi9NVkg1bHQxMmNUNVlSRjhlY2dvTXYwUGp6NWNiU2t1?=
 =?utf-8?B?dDBxbW9qMnMxa3dzQzMwOE5LdVpmVDZNZm5RbU4wY1g2bnhTb3R5cE1QNEs5?=
 =?utf-8?B?TWd3YXpCbnZrM254MFVuVXRTMDJTQlkwbFJzNDRTSXhCWUVZdHNSNmpZZmpt?=
 =?utf-8?B?NkNqM280VHV4c3hyV3pnYm8vOEZ0ZDhlUlhYcEdHWngxWnhxUEkvZHNtY3NL?=
 =?utf-8?B?Z1lyMnJRQkZraHBIV3RLaDZZckQ0YTZMWHdqQ04xVlJRYTZHMHUyRi9Eb2pX?=
 =?utf-8?B?NzZva3VsN1dlNmp3TStCWDVVV3YzcWMvRFFLd2Z4VWxZQmRyT0tKQTZxQTZm?=
 =?utf-8?Q?LhG6YqJonTdq/ziQtiYII5MSpqE6Rog3dHz2s2NM0sI7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a963763-5622-47d2-83db-08db2504b669
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 03:23:57.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCFBozUGr+YpoZGrk9GzEGxOvVHZbTnoVKyyVRrMONpQP7n8Uy2QuY7P1hIhYz0xOFJQpke1/3aKXltmD/OyCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support inner header hash



On 3/6/2023 10:48 AM, Heng Qi wrote:

>   
> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash
May be to say inner packet header hash..
This make its little more clear about "which header" that you explained 
in the commit log.

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
I think this should also say that HASH_TUNNEL requires either of the 
F_RSS or F_HASH_REPORT.
Because without it HASH_TUNNEL is not useful.
Right?
if no, than my below comments are meaningless.


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
I think rss_max_key_size field dependency should be only of the existing 
feature bits F_RSS and F_HASH_REPORT.
This is because those are the bits really deciding to consider 
rss_max_key_size.

>   The following field, \field{rss_max_indirection_table_length} only exists if VIRTIO_NET_F_RSS is set.
>   It specifies the maximum number of 16-bit entries in RSS indirection table.
>   
>   The next field, \field{supported_hash_types} only exists if the device supports hash calculation,
> -i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
> +i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
>  
Same as above.

>   Field \field{supported_hash_types} contains the bitmask of supported hash types.
>   See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types} for details of supported hash types.
>   
> +The next field, \field{supported_tunnel_hash_types} only exists if the device
> +supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
> +
Above line "the next field .." can be just same as "Device supports 
inner packet header hash calculation, i.e..."
This is because here, the term "header" is missed, which is present in 
the definition of feature bit 52.

>   
>   The device MUST set \field{rss_max_key_size} to at least 40, if it offers
> -VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> +VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL.
>   
This needs change if the above first comment about rss_max_key_size is 
right.

>   The device MUST set \field{rss_max_indirection_table_length} to at least 128, if it offers
>   VIRTIO_NET_F_RSS.
> @@ -843,11 +854,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   \begin{itemize}
>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
>   \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
> +\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The device supports inner hash calculation.
>   \end{itemize}
>  
inner packet header hash ..

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
Any encapsulation technology that includes UDP/L4 header likely do not 
prefer based on the inner header. This is because the outer header src 
port entropy is added based on the inner header.

I was not able to follow the discussion in v9 that you had with Michael.
Did you conclude if this is needed for vxlan too?

If not, for now it may be better to skip vxlan and nvegre as they 
inherently have unique outer header UDP src port based on the inner header.

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
When there is a single receive queue, there is no tunnel QoS issue. 
Because the same queue is used one or more tunnels.
So please remove mentioning single queue text here.

Also it is better to first describe the limitation and after the reader 
understand, it make sense to say that the limitation already exists 
with/without inner header hash calculation.

> +When a specific receive queue is shared by multiple tunnels to receive encapsulating packets,
> +there is no quality of service (QoS) for these packets of multiple tunnels. 
"of multiple tunnels at the tail of sentence is not needed because you 
already have it at "shared by multiple tunnels".

> For example, when the
> +flooded packets of a certain tunnel are hashed to the queue, it may cause the traffic of this
> +queue to be unbalanced, resulting in potential packet loss and data delay.
> +
Your example is only talking about single queue..

You probably wanted to say,

When the packets of certain tunnels results in spreading these packets 
to multiple receive queues, these receive queues may have unbalanced 
amount of packets. This can result in a specific receive queue being 
full resulting in packet loss.

Or something similar..

> +Possible mitigations:
> +\begin{itemize}
> +\item Use a tool with good forwarding performance such as DPDK to keep the queue from filling up.
I dont think it is necessary to talk about specific tools like DPDK in 
specification.
Even if you omit "such as DPDK", the line reads fine.
so I suggest to drop "such as DPDK".

> +\item If the quality of service is unavailable, the driver can set \field{hash_tunnel_types} to
> +      VIRTIO_NET_HASH_TUNNEL_TYPE_NONE to disable inner hash calculation for encapsulated packets.
> +\item Choose a hash key that can avoid queue collisions.
> +\item Outside the device, prevent abnormal traffic from entering or switch the traffic to attack clusters.
> +\end{itemize}
It can still enter the switch but you want to avoid entering the virtio 
device.
Cluster is very broad term and not defined in the spec, better to avoid it.

you can rewrite it something like, Perform appropriate QoS before 
packets consume the receive buffers..

This is generic solution that can be done in device or egress of switch 
etc, which keep the spec scope upto the device.

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
You likely need to add device and driver normative statements derived 
from above text and add their references into
device-types/net/*-conformance.tex files.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

