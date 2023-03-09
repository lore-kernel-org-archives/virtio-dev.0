Return-Path: <virtio-dev-return-11585-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15421C6FD19
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 18:53:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 66A373309E
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 18:53:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F6D5986722
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 18:53:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 54C589866FE; Thu,  9 Mar 2023 18:53:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B1A19866FF;
	Thu,  9 Mar 2023 18:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpUnXv+mCj84j0bAjzw0UGVUZnQyfwySBrequAQdVO7If0Fs9wNfxCLjjLpcrRmJLgG8RgQHmeMAMJKuC6P8ur3+s+nac5gmUODA0RBclA+ZFpJizZEzzUUxjO33wtJdgRRSY73emAh8dPMX9FxvKqO7xP7W58xiZ9c7blvG8T6z4BLkLFGrDffwQWwC4HKLIC1aNLQO1TyNLJu2CUEJ+NAXhW6fWBzro/012o15D8T4c2xn6ZVVf5BZhkKwB0g5EoLKpuQX/rSvINNHTh4hFT6Juko13EKPV/Fk2o4dEvDyUb+BQdC7pQSAPdjJ0N0HFZlxnT2cGquu0pvu74n3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAe/IIo3kB99bH+1InySB2939q+WgcJJK9Z8FSa+xYo=;
 b=j5BdW/mLwJ3q/l15qVa3LRg0mxvQVvAQGpZTgEMPvmIgRlHIpFmLW1bOU8LF6v7RTjYbujOkf3gv+/d5icNa4rMPRb9xYjS21ylUcY5xXrHrMYHlQFkEVKmniXeqEpUfuT+0HrguGsj59SEDc0p5B7DPegIjsaj/wrGO9GnJzu9nwMYOvbBtXGjhWwN3LkCZOFBtNyjRzsa2GAvxAtv/7Oam/kns74av/hC6OF+amvQJ8r5bjBpad1RhVY4lG7v3ECiKx63nfHxS0e1vWL9HlbATNyYFRsiouHQKzATlbjjPWk/W92eDpNOs+NyRAvtt4DKSpkXtlVE3Lm++q0XnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <8734c0de-b041-a4ba-9f48-44dc4ceeb513@nvidia.com>
Date: Thu, 9 Mar 2023 13:53:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230309130521.109102-1-hengqi@linux.alibaba.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230309130521.109102-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:4:60::44) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b87956e-9928-4ab4-08c6-08db20cf9aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8pDtSYM4qBMa5G8nGU8ncCijE+Hap6NvCN6blcjQfJnufEy4ovK/VRNDH8VS/WBKt2wP3xErr1Yxdw+HJE/2e/JTj0KCfPO+zNLVBflYkUMt2M8zQ4qFY0pX6pv/jvW6ix1p538LH4uZH8LGX0OSFFO5JnId8bRINLh6o5PAmDe9Xnt5OUtqpEe3/5Lb2wUcOhtNeMHUeVuiyMjKUqUjd0aaQlQGR490ekwozx4wvBHuMxn/68zPpLKJUQGif7K9WHFkQNJdX3oLWUFA76QNehBurPywYWD8roWgANMuZ4OuofOA5+j4l805IvTp2KZBHYomyPKn9LQ3et/30KDV/a3q9aadPFqunaPzkwLs1eUiupcNH2p/1Vnqbwatg4nfcfujN5PN51eCKSbbl/zDBCiXfeVZbPVAEZibs/nowI8YOlYRPTJOiP+wCnk6KjMmvTyVb+P1cUGJ9Id2tzJXHgSNmLViO1aFz9G/BcR+N8UPYEb7UCLYMMuaTOTBisNwptXE2N3l2OMyaCe8N7uK4LSYbJTtdC21QMidhPXoseVdeSGLKvex+PtB8KA0uc/I7FOAgpqrbobe/vFkyOBNSKA46u4MefRmOLbzgw54QH663FNczEFfIORf5Kl6Mck1S2fNVZeSjUx65z0Gj2BoLsVg6621aQezSG9PM1v+460BsDjRKu2woAd96f2gN6caI8O+JKfMC2oVvw6uk3r0BXonxVVilYWbJaem50yQAdO6P8tBSjiO5mEijK16nrSgc251fLJyKQvjjG6V2RaRyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199018)(6486002)(966005)(186003)(36756003)(54906003)(31696002)(478600001)(38100700002)(316002)(86362001)(31686004)(6512007)(26005)(6666004)(83380400001)(41300700001)(53546011)(2616005)(30864003)(6506007)(66556008)(8936002)(5660300002)(8676002)(66476007)(2906002)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUtSMWZrc1hBSU9QcEV6UW11THVjNnhYblN1ZitXWGErYjJvaHFyMGhWaU9y?=
 =?utf-8?B?VTcvZW9GeDlBL1gzM1dZRUV0enhrZW9JWGgyd1lpaXBBdnN5cmVSV3cvMkk1?=
 =?utf-8?B?MWkvSm1LZW4vN0QyOWNNQVh3OGM2cDErakRWbDJLR0RNakV4R09XYnFNaFpN?=
 =?utf-8?B?NUNXY0xhR2NBdWtxbzM4dlM4ZTdDY1lVSWxPd2drWSthdGEwUzBJbVNpV09I?=
 =?utf-8?B?dTI2UXpnL2lkdlpjczNNSHJCdElNOVJzUUFiSHN3Q0lPT0c4aHZQeDJDcjIx?=
 =?utf-8?B?UjQ4eGVzT1dVaHhqa0taRFRhM1JBYkREdXZ1THZvZkhLWjhMbGJsd2lzT1c2?=
 =?utf-8?B?TGM3R1RaTmVyZWxCTnoremFDMW9saVk2MEVtNEF0SWx2NWQranVGeEVSd2hx?=
 =?utf-8?B?ZVRRd2pkMFVSK21GTngzSjQ5OXdyOVBpZHMrMTY5UW05MjRkTUduajVzd01N?=
 =?utf-8?B?NHI2Z0pWbUlTektqcVFTbmRzWGI4eFpLNkZ3cmZjVWVaUUJOckYxMXhsYmpo?=
 =?utf-8?B?MWxpU2NCS1IrM21VSnRCN2pEZ2lnY0NsMGR2ZG9WWGxJTE1iVDdFZjVieFhI?=
 =?utf-8?B?UFJpRk1pS2wyaXdOSU5OcnhQQ1ZZMlhJUC8vWlRxSGdYYWVwYW55UDMrQzZV?=
 =?utf-8?B?M29vamwyUGJYUFhJeURTR0p1WDRtQy9TNG5uMDJGdnhxNWhtbU91VUxMUk0x?=
 =?utf-8?B?T2wrZ3kwUXRRc05URWtpOVJYZEVxMWkrcUZaR0FTSHUvQ1R1VDl5SEVSSUJK?=
 =?utf-8?B?eVZGK202VTJVekVmOWZVMTl1SU9VenBUMmxaMzZUb0RMcmMzQ2sxVjdJTmVv?=
 =?utf-8?B?elNGZDFBUEJHNklnbXIyNDBidG5vcmpyZWw3UGRwcFRtM2VNYmFxRjF1Ry8r?=
 =?utf-8?B?MmR0aE1XS2gvbWpyc0JtMlZIM3J3L1hlMlJVUjJxOUFzYUV4aUxmdUMxVXEz?=
 =?utf-8?B?SndoTXAxeHZDYm45Sm1MZU5UQlpRYkFMU2NVVkNLTVFmaVV3WStGNTFkbm1S?=
 =?utf-8?B?RUdYcWZwZWFTQWY2bGZTdmg5RSt1ZENYQ3pna3lTdDArSW5Pdkk3cS9vU0JC?=
 =?utf-8?B?QThmWW5OVHlXL1RmM1V4OVA4Z0dCSW5JYW4vL29DNGNpMTVNOUd3MzJuWWZj?=
 =?utf-8?B?U0NxOXV3MUZId2dGNVA1Mi9nZHFMR1JHcjY4M1UyRnpJMFVmNVplUmQ2U0M4?=
 =?utf-8?B?REJHK3RrZmxyRTdxV2d4Zk9zYzRQb3VyR3ZUYzMyTC9sSHBQWTZsU3ZEMmdR?=
 =?utf-8?B?QVNIU09lWTRaazl6c0NYMEw5bDVJU3FWN25IV216WVp1VUx0cENFbkY5Qk82?=
 =?utf-8?B?dWxSemVCNXdDcFhrN1M0NUp0eEdCMldkamlWSzUrcE1ZZkJUTU9HTVFGdDNC?=
 =?utf-8?B?S0tCc2YzZkxMMlhRTnpRRnpHRVkvL3J2N3AwQ0R4RGQyWUZLOW5GN0pVa0Zt?=
 =?utf-8?B?QTNwZ0JyRVVTYW8xcUh3NzcyQVN4THl1bFdvUzdGVzJMeThzSTI4bmhCTjgv?=
 =?utf-8?B?Z2NkQ2pNWlBtVUdqRWhVVmhONjM1Q1NzaG1PbkVhVVN1My9xZDZqVGI0c1hR?=
 =?utf-8?B?TThYWXgyMVhNRkp2QmU5djlsVURWZWY5N3c0K1JIdDNPd3YzZTBrVXJIUXRh?=
 =?utf-8?B?b0JWeXFvcHpNcWdHSUY1bzkySUdKMUVCcnhJeEdQTGZOR3JoMHROVVVKTmMr?=
 =?utf-8?B?Wjg0Ry81YXdOQ3hZRVk1QW0wMGR0Yk5jc3lha1JMcnRxK1JLd1VTeGwxaFVX?=
 =?utf-8?B?bzVXcS8vM3NBQ2FRVmNmeUNVWjBqdml6T3JhUXp0bjRLQlRsNzU1dFhGQi9X?=
 =?utf-8?B?ZU9MUGp3ZHg3OG81cTcwSE1VbjQvMm1ZNTVhaThBcTh6WFlvQUdnSGZDVDdp?=
 =?utf-8?B?S0hnTmNEdTR6b3VmWjhzVW4zMTBzMzJvRGx3TEdwL1M4YkVrNnpqaWRUY3BZ?=
 =?utf-8?B?ZlVoYVVOZkNUMVJWck1yMGg1SXM0VlBKRUxmUW1NRW94OXdEdkhRZmF3bnR4?=
 =?utf-8?B?a3R4V1AwQUdKUVZDanQ2UmZwdjRVblZKcFphSFRtc3F0bmJIZzZ3N0t1cnFo?=
 =?utf-8?B?ME93Y1hlZysrY1dtaldUYkREWjFNSGl5V2hsTUJBdlJndzVXREhhWm93a3Ev?=
 =?utf-8?Q?ZV50Zvjs0piVgJReYC1C4ti4b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b87956e-9928-4ab4-08c6-08db20cf9aae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 18:53:43.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNFTqkHe8ZfFwZ7VC5E01a+mj8kWwgtuzVlhzawryMcTVQfXBy6k6NIeV81527L118fLErHCHHD40SNwj3KPgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
Subject: [virtio-dev] Re: [PATCH v11] virtio-net: support the virtqueue coalescing
 moderation



On 3/9/2023 8:05 AM, Heng Qi wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch supports setting or getting the parameters for a
> specified virtqueue, and a typical application of this function is netdim[1].
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.
> 
> [1] https://docs.kernel.org/networking/net_dim.html
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
[..]
>   device-types/net/description.tex | 86 ++++++++++++++++++++++++++++----
>   1 file changed, 75 insertions(+), 11 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index e71e33b..c896485 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>   
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> +
>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>   
>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \end{description}
>   
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -1505,13 +1508,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   
>   \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>   
> -If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
> -send control commands for dynamically changing the coalescing parameters.
> +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, a driver can send
Above text had "the driver".
Better to not change it.

dynamically changing got dropped, better to keep it.

> +commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> +for notification coalescing.

>   

[..]

> +\begin{itemize}
> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for a driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for a driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
> +      for a driver, and, the structure virtio_net_ctrl_coal is read-only for the driver.
for a driver and the structure ..
drop extra ",".

> +\end{itemize}
> +
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>   \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
>   \end{enumerate}
>   
> +The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
> +
> +If coalescing parameters are being set, the device applies the last coalescing parameters set for a
> +virtqueue, regardless of the command used to set the parameters. Use the following command sequence
> +with 2 pairs of virtqueues as an example:
> +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
> +\begin{itemize}
> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain their previous parameter values.
above "and" is confusing. It implies set on vq0,vq2 and vq1, vq3.
Same for below Command2 as well.
It also introduces new terms as virtqueue0 and virtqueueN.
It is better to avoid.

Rewriting it as below avoids creating new terms and avoids confusion 
around "and".

Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters 
for virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and 3 
retain their previous parameters.

> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values from command1.
Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} sets 
coalescing parameters for the virtuqueue having vqn 0. Virtqueue having 
vqn 2 retains the parameters from command1.

> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of virtqueue0 set by command2.
parameters of vqn 0 set by command2.

> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous values.for vqn 1. Virtqueue having vqn 3 retains its previous parameters.
> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueue1 and virtqueue3, and overrides the values set by command4.
> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of virtqueue1 set by command5.
> +\end{itemize}
> +
> +Upon disabling and re-enabling the transmit virtqueue, the device will set the coalescing parameters of the virtqueue
> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the command did not set any TX coalescing parameters.
> +
s/if the command/if the driver/

> +Upon disabling and re-enabling the receive virtqueue, the device will set the coalescing parameters of the virtqueue
> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or to 0 if the command did not set any RX coalescing parameters.
> +
s/if the command/if the driver/
>   \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
>   
>   The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> @@ -1585,14 +1632,31 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   
>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>   
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> +
> +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> +
> +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
>   
>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>   
> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +A device MUST ignore \field{reserved}.
> +
> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +
> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
> +
> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
> +
> +After disabling and re-enabling a transmit/receive virtqueue, the device MUST set coalescing parameters of the virtqueue
> +to those configured using the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the command
s/if the command/if the driver/
> +did not configure TX/RX coalescing parameters, to 0.

Also the sentence structure should be:
set params to value A configured using method1, else to params B if not 
configured.

Instead currently it is,
set params to value A using method1, else not configured to param B.

So to keep if-else pattern:

the device MUST set coalescing parameters of the virtqueue to those 
configured using the 
VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 
command, or to 0 if the driver did not configure TX/RX coalescing 
parameters.

Just like how you wrote it in the non normative places. :)

I still think that disable,re-enable doesnt need to be documented twice.

Keeping it in the conformance section is good enough, specially when the 
text is exact same.

>   
>   A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
>   
> +The behavior of the device in response to set commands of the VIRTIO_NET_CTRL_NOTF_COAL class is best-effort:
> +the device MAY generate notifications more or less frequently than specified.
> +
>   Upon reset, a device MUST initialize all coalescing parameters to 0.
>   
>   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device

Other than above small wordings change, it looks good to me.
Reviewed-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

