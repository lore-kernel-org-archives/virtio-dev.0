Return-Path: <virtio-dev-return-12598-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0D1C77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:21:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 97332330A3
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:21:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C84F9866DB
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 17:21:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7EC8C9866C7; Fri,  5 May 2023 17:21:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 692D69866C5;
	Fri,  5 May 2023 17:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1kV3T41Hh9I4krWuhau5zFDII9IssrjRuTKua8lPR3ciwcM3ly4pJWOLGoYplV0m+MXeqZKxti0SBgSUpUK7sCGhWT4+9a4rPXOFt5CIuzA/ygGSNcvp/T23ebTykPbCghzgu4SgVGnsHBGyep4TbVX+2BmvdrQvJVslICKdXCNU0Pjpnpwqej2eFN21HvGTyGzCfYitsG7MDfrYqak5uzuTDizGbKY5yxdvkgEDnD1oXTePUJnnX15jwiZWRxfsjityaGaul9bSv/B+SVvAOsDza7r3H3+JIXYqA5ET1nvdlDe23xTtUuX8mvfQDx3ILmCYuPbPUSIAbwSl8saxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viqRvodHlZX/zEAuihsQQlQUEj9zJslZ4OFz+fI2dys=;
 b=aMtm5BbwlDUBT5bEGy8bw3URqPeFpycUk+AIaRAJQfoYwiXPHbKDiprCZ+gteRGlERaRubOoEREnZJu9liTq1Apsjbv5FDDZMnHAYlUveVh+5iiyoK+p3eyP74xFiKeJiACZ95G1GE5VBRREO0ZWv1hPvPi9EVKVZ/oMEOnr7roRwcCTGj+wj68ej3DlE4zmIRwkiLVlIdl6Ra8RPuFZKBmqrH9qqowjRSVLnYjxNTPLFDQEl/5qIBuLYggMVkH+tpfS0sFyKlNVDSLwvleFnS/AXKeL2VyhyR5sHTQ3/DvRSXwTUNEYqfsZRFgAE6p/mH5TJxtjaff+Ik3tBQ+uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <e427d06f-afd4-7bb9-64d6-8c69b466f1e7@nvidia.com>
Date: Fri, 5 May 2023 13:21:40 -0400
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
References: <cover.1683301091.git.mst@redhat.com>
 <778cbbfc75b5d5c779c539ace5fb04fa5cd0480a.1683301091.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <778cbbfc75b5d5c779c539ace5fb04fa5cd0480a.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:806:125::13) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 99870ed6-dd9b-4ea9-6bc2-08db4d8d327e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	51D8hjLF36bRk80Q8AWZOv79UH/Wt23veDTN2cu8tcsq9eGhIEDZphdTP/0+TroZN8xH/up+WrbES7tTb0j5UBJKz9h021PDYJRy2XkIwGdHa6PGKt18e5UqlaoauJz80Ak3zL2AoqwCVOTjcj3KgJMEI8AndVlH/uWYsDi9oQXxcTJLIXPTV22uLHP/ae3gfd0WSk/l3iyRhWRMrJFeU0XpIXaa7UyeFdiKo9IEa4YlfEk7/yzk+cKSrZG+UlA7omSVSQiOPRE5YS4Vad51/8VSd2GZ+TfwVNnVUmVqERYo6EH3kYq5J6cZmpdlj/Tm3WDa8HhfH2SdNzALxuwU452FLWgSmWWIgGY1yEd5KrghQoJFuup00kplee5G0PLPEKiDgT0mmP795B73awY8KVDMQNk1ztMLwntev/L1+Mdl//GIK+WzdXy3AM13DeT45t27C6h+TshTQN95VVxFNgDDzGbFzNcq5qxjGZXgQPKlwLw6Y/InNDaRQMwjL/JX3/aogp1kuEO6ZNxyM4IUyFvsGDVApaUpGGa9el8ydfMrMR8PCaRP+sK0tDy1cKrfXVAc0uvNuGfbb5+MLiNmNOCLCz8pe2MvvO4iJxFlUi+TcD37mz+Zk2SID2j5T6i9JO6sVkPDpRExn6BHZkWKwHsZmrnRYHDbhxfXsr+tr7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(31686004)(478600001)(66556008)(4326008)(66476007)(6486002)(66946007)(316002)(54906003)(36756003)(86362001)(31696002)(83380400001)(53546011)(26005)(107886003)(2616005)(6512007)(6506007)(5660300002)(8936002)(8676002)(2906002)(7416002)(41300700001)(186003)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tlg2a2xzSTdqdWxqalpra2ZyUHVNampOUEd4TFUvQVlXRTI5em9Qc2V1anFE?=
 =?utf-8?B?TDFqWGNQM0xFVTdLL3dBTGYwMnJSL1BjdlpzbS96eitSdS9rUFhobUU5NkxD?=
 =?utf-8?B?bFdvaUxLL1IrMnhJQktFd1ovZlREcEYwSjJmdkJGbjBFRGFjblF3dVJJMnpt?=
 =?utf-8?B?Ni9TSFFBdndVWXNtM3NkTjMzMWtzbklNcWNEV3ZYbUlrWGxpRzlMM0p2ZnRQ?=
 =?utf-8?B?MWxQcFhKNFFvMGMyekYwbWw3Mjd3V3VvanBnN1dUQUZ4T2tRaitDVlFjZDBr?=
 =?utf-8?B?ODUvblI1Y3Q2OUdvbGZqaS9KMUsyMDlVbG5hVkc3NUJLaTV2NExyM1JqZm8z?=
 =?utf-8?B?RWpqLy9FYjgrYmU1S3VkdVFKVlZQWCtwbzFhS0tjcVZPOU81anlBUUI3b0k0?=
 =?utf-8?B?Q05VUStHdUgxQTlRWGtBVC9ybTdmOE1pWGFnaHBVRXQ1WnZleS9XRENqVjA5?=
 =?utf-8?B?WEZYNFZ5QXoyZ0ZxVStmSi9IMXNkWlMwK2Rna1VyajJraGtBcXlUWEU0ZGZM?=
 =?utf-8?B?RGxJTml6QytRL29wT2xSNE15R1UwZU1hdjVwZmgyMG1HVWhzL2VlMFNNcWtu?=
 =?utf-8?B?RE82S09rSmlWODFRSWlxZzgzSmQ4ZXRxYThPb2svU2JWQ3I3aHpod01ReHFY?=
 =?utf-8?B?cnlZV2liNStOdmt4Y1k0dGdnVmZJQ3dQL3JlNE40RWp4ZTNFM3RvNEZlcld6?=
 =?utf-8?B?QmhPbjFsMS9QVEVsRkk0VFRsenBLOVJHUUo0VTBobkp3YzFnTmFEbTRwRDc2?=
 =?utf-8?B?U0RhVkR0aDJ2eXdnR0NBbGEzdDJZZS9yd0tSaWU5Q29VSjQycjB2VnJmZEov?=
 =?utf-8?B?SGpiQjljelFRa1NzaUFuNENURE56emxwTlVDWVNvMlhUdUx3LzBNeDJJb3Zu?=
 =?utf-8?B?LzFzcFNuNzFydCtMRGxxRlRlbGZlU1VKVSsvMXFBc3lnTURiNlJRVzV0K1JN?=
 =?utf-8?B?bS94TDJpU0YwRUsyTlFoWEpSQ0tqUGsvT0M5MFRBeWpnSU40am9xOEVtc29z?=
 =?utf-8?B?dkc0WjRHdkZObHN0YTFoeVFLR1VrRzczSGc1V0RvZFd6dE8weWlWNTYrZkdm?=
 =?utf-8?B?dWxIMEJlNnFNNWZrc25uWG5yWjR5M01NakVRRHEvUitCVHRwY3V5bGo1WXVU?=
 =?utf-8?B?cWsrcCtFRTllNmRiMEJodjdzTXVXZEttQURlV3JLZFdXTm16bFpPRjliTExp?=
 =?utf-8?B?NWNYRXRyRTlNb21yYmhjbXBxcStrc1FEMy9kV2xnM2kxOFZjTVNyTTlQOFpj?=
 =?utf-8?B?WWExWlBGR0lyY1RFaWJDb2R2dno5M0JBc29mNFVBRkQzZ2VOc21YcDJHenVW?=
 =?utf-8?B?S1ZNR1ZRY2J5MEs1S2Zmd3RsTkdzWGtQNGc1dTM4UmtjeU5YdnJsYi9DazFh?=
 =?utf-8?B?NitDMkpUVTQrdjJkZ0dOOUExd3gwek1sYmVSTXBiSll1MldMajlNODB1UkU5?=
 =?utf-8?B?VmY2czhiNmRrY1J3TkVGUnJCWldWYldDR2RnZmNvbDJqeUY5NjJOTE84MnVB?=
 =?utf-8?B?OUtjUE9PeVhRbHppditMVjR5R3g3N1NVSU5ES0lrTGVaSDlVREJjcDhnclJx?=
 =?utf-8?B?a2hQL3dZODE5ZVNDcC9HdldMK2NWd0FJQmwvVHhaYXFyVkRoNHhCejNPOVRi?=
 =?utf-8?B?SnkvRFVZZ1FRVnBjVWs1a09UNTZXU2hvMU1HME1jNDJnSUMyVGlXb2dPTkE3?=
 =?utf-8?B?UUd4VU5kZmJyUkRyMGdUWDhCczBrYVBVMFNyRm1wNGI0Mmh6Zk9NTnNmUnI0?=
 =?utf-8?B?WDVDc0g0RzliS013MVE3THUzd0hYMmdjaHkxMkhCbFB4bzdqUnNHbkhRazlz?=
 =?utf-8?B?WHVrUzg4eHk2WGdBRnJNUm0vRmFpVkNNKytaeW9XZHVhV2xHQ2hkVndQOW9T?=
 =?utf-8?B?NldINnMwbHRJUjJmMlBpdGszd0Yzc01zWkk5YVc5eWN4U1E0bzZWTmJsYVdu?=
 =?utf-8?B?SFdabGoxWTYvWWtlNTJCKzY5eFdqdFErV014ekY4NUlZV2YvTHFNYytZM21r?=
 =?utf-8?B?d2tNSlBjTXhneVpKUkIxMzJ1RzJaN1JxVWJsdVgwUWllbk95dk1sNEVkYyto?=
 =?utf-8?B?dHcxVHFRd3VzUkVnR0pSTXF4UGlOUUtESW5jV0U5b29HcUZheElIUnpSOG50?=
 =?utf-8?Q?HYPsVSuTGvW9dunes7Ai2J5/I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99870ed6-dd9b-4ea9-6bc2-08db4d8d327e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:21:43.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZlSpEup+/STT6IxDZmS3eSVNMcIFTEE0etMsnOapqW1bF6YL+oJKQXiF1OBtPbmuStvP9sn7XxgKF5TLPSs2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
Subject: [virtio-dev] Re: [PATCH v13 05/10] pci: add admin vq registers to virtio over pci



On 5/5/2023 11:40 AM, Michael S. Tsirkin wrote:
> Add new registers to the PCI common configuration structure.
> 
> These registers will be used for querying the indices of the admin
> virtqueues of the owner device. To configure, reset or enable the admin
> virtqueues, the driver should follow existing queue configuration/setup
> sequence.
> 
> Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

> 
> ---
> 
> since v11:
> 	document that admin vqs are not counted with regular vqs
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> 
> dropped Max's S.O.B
> make queue_num not 0 based
> ---
>   content.tex       |  9 +++++++++
>   transport-pci.tex | 26 ++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 8761795..1986e98 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -851,6 +851,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
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
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 5d98467..ec012b3 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -321,6 +321,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
> @@ -347,6 +351,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>   
>   \item[\field{num_queues}]
>           The device specifies the maximum number of virtqueues supported here.
> +        This excludes administration virtqueues if any are supported.
>   
>   \item[\field{device_status}]
>           The driver writes the device status here (see \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}). Writing 0 into this
> @@ -406,6 +411,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
> @@ -492,6 +510,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

