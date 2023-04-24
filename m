Return-Path: <virtio-dev-return-12392-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06793C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:30:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6190C42BCC
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:30:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56D8A986635
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:30:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 48F69983F7A; Mon, 24 Apr 2023 22:30:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C6539863A5;
	Mon, 24 Apr 2023 22:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDXUtbkMjYNT4u2t1bAVxW5b2JH9u9vJvYm0AlGtMtd84uNqDBSx33gEOK1FJf5KEMST7lLyXeffesBlfPBzNb3pLWB7C+2b5tYq0Lz542m4tM80p6xfzl2pblWh9pM0x1sh/byCGZ2GJELzuzkYi42o5AsVAnqfNbwt7Cl08OjLPy8aW9mxE2ckyp9FsDou/9O8hHvkBXakE6HmOYIvWaWgzbOFHc4l5uRaZOGtY8ezK8Nly6/i/KAfMKf8FvdtspGTNQDF4+eAuFX9VDLOcbB2gkwMcuaSWzjLnLZ9wr+OaC4L8VzckiNzekpqHQuPtBE2vBROYvxduiK0is36Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY1BAc/zmDI52LV+j6ToTSCY8CzMtAh7C9aDJhoK81M=;
 b=lb7uzL/Jz2r+7+1LRn1EYPcejkCUTj7fcVUsasnhO8JOBJ9aKZDWnZqRN0llGsQmis5P29JRyb9idy7fD3kyGRPHYXCL1/dlBESYVbTc5ZFUIvJdlCIrBgUx9oLsbeDoin1+wntDv6Ead5t2bXeRY8Umi6cLAT0Jb6gFRoyI9liyHU+9jvowSb2bS6y/E00wgHIrkLZZBgEcx57IGo6I3liVz6E2/jLPSPBFWjGPrKUUUDxvgodT1MvyYwYjcm3U/6stl3/SGmFBczhxTCItOAdCR6qpJ0wcN83js6GvoCtQLTzZxJDXgZxvRBJEGAvdUHP00NtdG4Gja5wtAR7oKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <328b41ac-f378-f7f0-a576-ba2011ee66e2@nvidia.com>
Date: Mon, 24 Apr 2023 18:29:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::10) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5bc960-6e1a-49dd-607f-08db45136d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z5Fb1hamWu0bviAkJzutFop+Hmu740Ss7xDUfVviAg4uNRFW5t3sHNJckNkXgEgq/ifX7uS0fTbwqykXSNOVeBy4at6+7zAiTrl/p2hA8OsvIhuwJEZpt/P3mLJ8/W+IcnIj4bHRE+eomAEjXWJJHnUH9jifIrI4UkGUXCHNFvlQlaYyeVG928UC+ur6CRlt8zjnnz33c7+24UkQHY3KsH0corIxtqRNQe3isR6Bq4f3fxMFfGnnrsNfchEwHFouxvb+hPDEMPKIXm8z0gBEEMob8b1Hf9Av0oMQluAp5NZERhzeRF9dCpTk0BfVDY9TG8l31bVkMfZdGHhM803DmNcpn2V8PS7osX2UbarROOYP4p4vwJD4LJ4Y2cPqmemHtCqrr6vJ3lDPzaDNTuLNStIgy/YPKXpI5lWKxJK2aWtKDBTfF2g5kZxGhm8RJ3en7fVA5TcReWIjCAJmV1Q03NMwEe9S6ZkBF4uHDzMwjRJt/ri4SJqxa9jEWe0G34iXeUQMftr9ZH/SPduzrA2ZI7GyISognBF7rjHCOMwwqZ/wuvzZhvHyfp8FgBmWpHWqsOwiTBTLNb8GJXxGjAbaoR5tT49Zz65ZN+Sw/aUOY8kWWmZMnSD1t0J6UyDjHNu0Tc/hjQ4rExjo8DvawIpjpJMOPb6X3jfTs1WophEPQDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(6486002)(66556008)(66476007)(66946007)(2906002)(6666004)(6506007)(53546011)(8936002)(186003)(83380400001)(8676002)(2616005)(41300700001)(6512007)(26005)(5660300002)(316002)(7416002)(107886003)(31696002)(86362001)(31686004)(54906003)(921005)(36756003)(38100700002)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWNSUEt5YjBOQ29qMXRIUFFESHpuQk9TMTJZK2x6THNvWi9ZUllEbGpobi93?=
 =?utf-8?B?dTB5Z2lOWXlVK0FoRUVBUGJvdFFjQWx1RytkMGRkbndER084UXNQRVAvd0xB?=
 =?utf-8?B?aHBCVGYrYTlZb1lMUldQUlF0WTgwZWczQ0k0L1hsR2phQlczdGYreWVJREhG?=
 =?utf-8?B?amM1QVpsdG94NGZxclNyTTcydi9KaWdNV2M2NmIycUhRWEsxN2NFOVlRcUE5?=
 =?utf-8?B?R1hDaDhlNjJNQkExUnBnUkJxNjVGTlNRejhIRmpNQlkxc2MrdExYVytSWmxD?=
 =?utf-8?B?eVQyMkQ3dEpSTU9JWXo2SlRUdk42SGY2aWV2emVPN1ZsZGdQUk5LL1REQzlR?=
 =?utf-8?B?Uys2RlJrMzVvR3RHZ2NhVEpvMWo0TkpKYjdlSzY4elZMK0hQNEtRa0l5M01G?=
 =?utf-8?B?QkV2TW5iakM3T1ovNGRyTDFDYjJBcFdIN250OGhML1hoSzNpbUtFZTNkMUUx?=
 =?utf-8?B?cHJNMTJ0NEErVkpNQTdZclNYMW51N3JueFVlQXJ0aUNxZUdOb0Y3T0QrNUVC?=
 =?utf-8?B?TnVtMWdORE5TNjkzUnREWFdQYXY3MjFtNnF6T20zOHJHbkg4d2x6NVQzZ3U0?=
 =?utf-8?B?T2RZN1RUSE1QcCtSc1NjeHU3bVFSV3B1NFE5Z1pIeU51cURqaHlUTG83c2Ey?=
 =?utf-8?B?RzFENVdaZC90c1k2enlKV0xCek9XWTlXak1VQzh0Q2V3UHN4eFFwdmIvODly?=
 =?utf-8?B?dERMakc2VmRiWlh3QTNOSUQ4ZExqV1d5dFVVcmVxVVp2SjEwdklSbWN0ZU9p?=
 =?utf-8?B?ZVFVL3l0ODk4VFh0cUxSaDgzOStIS1VIQ2F1bFVOcFFIRjVHcVcrK3NFS0p0?=
 =?utf-8?B?aHM5NXJlemVLL0gwbmRGRXlzbFJWV09IYmdBaElZZFZsVDM4dnp1bGRXREYv?=
 =?utf-8?B?TG9NY2U2Uk15Z2lncStpMEJtNHJacExtQ0FSYnZ1SmM1ZzhyeVQ0dm1wK0E0?=
 =?utf-8?B?SlhWSTA0Zk9zbE5pQU81aGx2UThpclhVQjZVaCtIQzl1dFhWL2l2Rnl4U3A3?=
 =?utf-8?B?NVhGdisvWnNValJ2dUxSTjB0aVJPTERRQmNPazNRbnl0Q2ZyMmRjRmdZU05Q?=
 =?utf-8?B?RzRMS3orWlJCU2NlTWRtYkFLZUdQM1U5REIybFVxOXJCZHpIaW03Y1FYeW9C?=
 =?utf-8?B?Zm1qL2JkNWlJUlBRdHBoS3BoRU1wTmt2d1F2MTNNKzVtWWpvOEE2OTBHSlFQ?=
 =?utf-8?B?Ukw5L0tLMmlDSXpiT0JtTFgzaXNydjlETWsydVRaMyt4NWQ1bit3bWFVK0ll?=
 =?utf-8?B?c2N1bmJ4QnI5MG5RL2pJTWZRYmU2UE5YclNiMGovS2lPZXNDcXpra2srNzR3?=
 =?utf-8?B?eTNkRVV0S09wcFFzR3R4dXR0MXJCR3hHc0o1S0F6RE91Z2NYYVV5Sk5GeEdR?=
 =?utf-8?B?MXhSVnBrQldVWDBLSUtuRnQ3Nlp1OXE5bzhVZWdyZjVvU0JqdG9wMlB2WXJS?=
 =?utf-8?B?dHliYUdSZjUxdEQvZFA0aWtib3BkQTRHMnJZbjBPSVNvVE1sSkZFY05NcnNP?=
 =?utf-8?B?cWJvcmZiWFVtQjhnU2tsSmk3NFdMK1VaejB1RlpZa1VlSmRLWlZLMENoamt0?=
 =?utf-8?B?ZTYyaDRacWQxSzVNMllXeVhUc2J6VU4yT0tKSWRNU3ovcmtQRTFlRHY3bDZt?=
 =?utf-8?B?Y0thM29oNVdhZzRtamlPQk9oR0ZkaHFqVHRvTU9FZlRVQXNQRUhVQmczRW5Q?=
 =?utf-8?B?SUJnL1pJUjZEano1ZlJsdTJiKyt0WTZNODl3ME90aTAwRjhFRmdrWlVXZDkx?=
 =?utf-8?B?L1RSMU5tMVpsbXVNM0FCRUxpNFc0SmFiNjlEdWphdE5pNXoyeFd0bXRydmtu?=
 =?utf-8?B?aXVTanFQYUNxNkVVa0s4NEN6SHZMV3BtWG16YUlzY2t6SURreVdjMHpPL0Mr?=
 =?utf-8?B?a2d3cm9mLzFYZ3BDQ1ZoenZhQzBMd21PQTg4RkVCRjJBc2lNTTRkTGV5WjZ1?=
 =?utf-8?B?ZnVmYUFEK0tINnlHbGt5RklXbGxBU2d4U1FvejFOc0c1MDkrUG1xT0wzNjBa?=
 =?utf-8?B?djUxZVRYTE9WcUdoVk9tWjg5djlWSlJBNG9JL3BKRmI5NUg5UFBROXJzU2tv?=
 =?utf-8?B?R0t3VEdpdDZSV29TNWZBL3o5Ym5QSXVmK3dnL1Vld0xJclpnNlRLU2pXTktV?=
 =?utf-8?Q?LJ0huYeUQL1cNgV24EahiqjZz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5bc960-6e1a-49dd-607f-08db45136d17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:29:54.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mwu9ivCh+UECIgpQeQ6emKVRwqyjH8IBCHyHyAlSQqimgf12VY6zczrAHym40K+lXwbCQ78doJH3NdBXdOddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
Subject: [virtio-dev] Re: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> Add new registers to the PCI common configuration structure.
> 
> These registers will be used for querying the indices of the admin
> virtqueues of the owner device. To configure, reset or enable the admin
> virtqueues, the driver should follow existing queue configuration/setup
> sequence.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> dropped Max's S.O.B
> make queue_num not 0 based
> 
> squash! pci: add admin vq registers to virtio over pci
> 
> since v11:
> 	document that admin vqs are not counted with regular vqs
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   content.tex | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 2eb15fa..bcbc06d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -948,6 +948,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           le64 queue_device;              /* read-write */
>           le16 queue_notify_data;         /* read-only for driver */
>           le16 queue_reset;               /* read-write */
> +
> +        /* About the administration virtqueue. */
> +        le16 admin_queue_index;         /* read-only for driver */
> +        le16 admin_queue_num;         /* read-only for driver */
>   };
>   \end{lstlisting}
>   
> @@ -974,6 +978,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>   
>   \item[\field{num_queues}]
>           The device specifies the maximum number of virtqueues supported here.
> +        This excludes administration virtqueues if any are supported.
>   
>   \item[\field{device_status}]
>           The driver writes the device status here (see \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}). Writing 0 into this
> @@ -1033,6 +1038,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           This field exists only if VIRTIO_F_RING_RESET has been
>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +\item[\field{admin_queue_index}]
> +        The device uses this to report the index of the first administration virtqueue.
> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> +\item[\field{admin_queue_num}]
> +	The device uses this to report the number of the
> +	supported administration virtqueues.
> +	Virtqueues with index
> +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> +	\field{admin_queue_num} - 1) inclusive serve as administration
> +	virtqueues.
> +	The value 0 indicates no supported administration virtqueues.
> +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> +	negotiated.
>   \end{description}
>   
>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> @@ -1119,6 +1137,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>   were used before the queue reset.
>   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> +configures any administration virtqueues, the driver MUST
> +configure the administration virtqueues using the index
> +in the range \field{admin_queue_index} to
> +\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
> +The driver MAY configure less administration virtqueues than
> +supported by the device.
> +
>   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>   
>   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -7686,6 +7712,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>   
>     \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
>     administration virtqueues.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +	  as the transport and is reserved for future use for
> +	  devices using other transports (see
> +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
> +	and
> +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
> +	handling features reserved for future use.
>   
>   \end{description}
>   

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

