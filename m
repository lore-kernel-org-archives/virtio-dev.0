Return-Path: <virtio-dev-return-12153-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D3AC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A6BC22AC69
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4269C986697
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D34C986509; Tue, 11 Apr 2023 21:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE1819864B3;
	Tue, 11 Apr 2023 21:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS3RAKpVyyZaQ1OBf+c8i7bx/6eOUbCB9iUfB57R7UaPLuzh0hOiCp0lRSDeXF1aSw510WrxqK7fVoRncDSLEGLfWtMqDgjeGxqlGMb7szlh98ThQw4i1YGbfM0/2Gz1y31LabbYV3LL6MiIVWvrHSu5qnJzUE5LJTgj8i+lGpH2DZsXSdJ+dCulqYh9Wub5HKbOHj7OvNuu9Kp52rWtbcAtp7IWJseKvyZkfL8ygUIXuRirg8bDukB9Nouz2wW4cd3LmEINg1LPYo8h+bKbUHo3VU7cMpnqViy3PyffgXWm9BIafbsHgMWyGN+8ocD8ceyV2EMgH/FB3WQ3oxFn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJkQCiUlakD6ZUKbEDPJadkvpmXWZXTCy68j1CYIC+M=;
 b=RarJ6WQvGqZAq/H6ETckihCM7R3gHO8ywksWk8n4LIO0A1atFoQPMyoWXYWUMR/kscaukCGop+HrUppr3AuvXB7l8dE6FCdaqT6f1TXfX+0MoVgwq0CTzWlUvO0e15E0N8vAEEJd9UHAaBnt1GuAZmLPVl0TRqqTCY0nTbSjfDCsWblRcK9npD/yynL4d7st3fD9UsTFTz+GqWNwB88lIk0D+vvorAA2XmGVHL1TGhe51sHwnmO1Szh9yjleqSAUvvbrAadSQtsrjAbcJs+m/Z8W4G8KSeuePHQR06XMpfPBa0Wh8BXMtH8oIBCbWqNY8Xh/+nb78/xFUTUK9xBh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com>
Date: Tue, 11 Apr 2023 17:03:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230403045833.21853-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 659fc2ef-67a4-4966-19bc-08db3ad0428a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zuyENwezguc/7AMLb+X/FRm5tJQzUG/gBDX0oekCvhaFadkswGQWTwt9th+LERW6Pp7hN6Toeng9MTHpxcez8H632M5k0xxn9+34zKaGPHxUFDjcwFupvQG7LuXaBpITMpQubxCOqULyAk1D1pX3msFI/XDL4PTFeUnbwUvm/b5yFNKps/QKeQOBx0qfqMYu3ZWZcO2KxOEVWYQILoblez/jxWtNQ35+jkX/Mg3js1T5jlamyOk0GsJUWkb69eKjS65QhVnpIDXoRyKiCaTYJWCCuMvQAmgPRGbQNbYzdbrfqY+Ff1M2ESUXNrjcr0T1HgWyM28fVyz1TfiMrTWWD7pye5k+j0fIvqsCrdGn3M8gN5HiJ+oXLH3useoiPXrUZnzhs6ZD0KQ/9pd6O+jbuJe5Y1i8ny8lFMDMCmtot2KCVYke+/iK8nxc2eSyXj2aS0IfsHUUguEyCpLBowd0HPr+krsrEQOok/m09ET8q+AMaJqWOG1ntjxyOQVzoJRuZ7ZvJAgHnmbC5axIAPbKBHZUvJc8B+WPoAyiCrZlH1dmn5rhNkpt8967Yigl3cbPM8C0KHNg1Lo4aBmuqbKkTs17c90ru29ksyUKm8hFGeWgzWfZRlCODBrcEfS0togXx3dTCEbUmXpSGv0F81WSKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(478600001)(53546011)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6666004)(66476007)(6486002)(41300700001)(8936002)(66556008)(31696002)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRONTVoYWg1Z0ZHbUJIYThBTGFlQ3NPNlVtdVV4UnQ0N253ZGtZU0I2d2ZM?=
 =?utf-8?B?T1JPWC9RaWxwRlJoK2hJUUQ4QTRVVStXcHdMZmdYOE1CUXJ4TjdONmczTU1Y?=
 =?utf-8?B?ZjdTbTBVZUVTKy9wSDF6ZHJuTlNPZmVqQnNSdmM3Z2JtNzhsT29KYktlcDZy?=
 =?utf-8?B?b2VxaHp5d2RmaDA0dkI2djRkdzJiaW9oWE95VkNuaHlzQm8yQzFhOUxxRjNN?=
 =?utf-8?B?WFBUZ0hwMlpNbG00UVkxbTFPTjZPckN5eDk2a0xyTHovT3c0ZVZMdnFkQ1E5?=
 =?utf-8?B?ME9teFUraTFHQmpqRko4ejRDZkJyR0ZxUHphL1VkSlF5Qm1CUlNWUXMreTNx?=
 =?utf-8?B?MFlMOFFnb0k5ZFNCMFJrMkRYQ2xnVkRUSWp2dStxODNEWmFGRCtITlRoTUlp?=
 =?utf-8?B?anA1OUttelQ4Q3JaVlVncTkrOEM5bWZWa1B6dWRlMjU0akZtMkhGVDdNalBr?=
 =?utf-8?B?dGxRS1RKT1N0QnByN2kzWUFWSk1uUm1NYVo3K0RZdWptelptVk9IZ3NSbnJu?=
 =?utf-8?B?S2VQTTZNYTJta0JBUVV5LzFHay9QdFJuOUo4NEoyNzQvejVFcEVCb0xlWFRP?=
 =?utf-8?B?Q3hXYU5IUVJkMGo0dzJHZjBQWXVteFYxOGlBREFqYWRyMU9UU0NucmtiQWlP?=
 =?utf-8?B?NjQzLzArL2czY05kaitYL3RWalBGR2R4SkR1Y1pMWk5lcjBjUEJibms2bEZ2?=
 =?utf-8?B?d3NQUGtxK3QrMnVJRHRTdHprTndEa1MxRkJ4ZGN2dk5pQWlWWDVOY1RmU1ZG?=
 =?utf-8?B?OXU5MWhiRitJbFIyRTVTVmpsMFEzL0lWUFdTekFnelYzWWRuNlgrUU9PVEFF?=
 =?utf-8?B?NVNkcUJyMWY3YVR6aWd0bmZMZmsxamFPVVpuVnhhYVQyeHh2VTRPVjFvOHMx?=
 =?utf-8?B?b2duWDFoZTBVN3FyeldRbmJLNDVZMytLVm4rRUExSjB1WXQ3Y1BvTVRtYito?=
 =?utf-8?B?U2V2b3BUamE4NDhGZHREQ3NtZUNMSlc4bmx5OUVHU3B5aldXYkJsOWxsY0U4?=
 =?utf-8?B?VzdxbE5jc1pSNm5hN2NMQjVnc1k0Tm9hRDJRalhXSGt6Rm5tUGVjR2ttQ3ZL?=
 =?utf-8?B?L0ppeHBmaGMra2Fab1hDNm95K2dzRGpHeWVNRGo4UnQ1NTlWbmcycXVLK1l5?=
 =?utf-8?B?eDZKTkdKNlBtT2JCTTFDejRJSnlSRXFxVmh3N3Nqb3J2QnpUWXdydzYvUXpa?=
 =?utf-8?B?TVBLTyszdWszNWtXd1JGaGlGYkN5V0JmM1p3bG9kbGJyWkVHamxyNS9zem1i?=
 =?utf-8?B?aFFYWFcxcUtjZ0UvakVHZ0htRWk2SXYrMy9JVFNkazdoakxOMWdnUlpjY2Rr?=
 =?utf-8?B?dmxsTzBOVW90STZwcWtodmwrZUxvV2VkejY2WjY0MDN4dmZ4cXhiMXRHV1pZ?=
 =?utf-8?B?Zm40Y1VyZUUzclZTZGxzRGIzWHJBdlpCSDYvMjVnR1FpYmk3cTAvZ1NQemJs?=
 =?utf-8?B?cWtUaDRPMEtvWW4rdXpZaGNXZ3pNK1h2WUZ1S0lEelNCbTlMemhUTmFhb0NV?=
 =?utf-8?B?MVhBN0ZNb0xhQ1NvOHJmWGt1L2dqN1pRb05mUWxCRG5LeTNMMFJsNTZITk1K?=
 =?utf-8?B?YzJ2YmFUc3RNSlEzTTRTbURvN2tGdWpGc2p3T3BTRHNqZlhDSGJwYkIyVFNr?=
 =?utf-8?B?OVVKRVc3eEZreEdvcHdjdWF6V3N3ejFTaFdLNUJhSzd6clo1V0g5M2JySW13?=
 =?utf-8?B?QzI2bFJYM3dmNDZYM2psb09udDJLN0VyZW9PUllZMEY2WVdGMVFzdXp1OGdF?=
 =?utf-8?B?VnI3TkRpSFJWZjRoUTZRbUpabjYwckp5eGU4SGhyVXdlNnlqNHNMbnhjaGJO?=
 =?utf-8?B?SUhTakdKYld2T3dQN2tMTGdSamQ1anBDWXVLZ1dOOGJiUit2eU00N3kydFlo?=
 =?utf-8?B?TFU3SFgyRDR6SlkxRHRNcGt3MjJhMUQ4UzhoUGZ6TitBVjZvd2I5TGsyWmVw?=
 =?utf-8?B?WlZUQVdiSm41V1pBUnRjRkV3ejF2QSs5UldhZ09sVVF2SWtaaUtQamJNL0RS?=
 =?utf-8?B?eDRPTkl5V1FKOW1HYkdXbnF2N21DVkNVeUNnejBFeDdmVVpvVDJmejRPcFlz?=
 =?utf-8?B?Z2FtRWpjTWhWMC8rMGZzeVViYzVPTVRLWkpIOWtTZ095bkRkUXVjUk1BT1Rm?=
 =?utf-8?Q?pg6Xac/afg1Tom8E7r+QMJWcN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659fc2ef-67a4-4966-19bc-08db3ad0428a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:03:54.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdXj5JW84xlyhU5efv6rqLJHOWAeXx230HS6iHc9REdvLcUEAotq1lHDmTE66CeF8KtdQJviny7egI1pohUJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939
Subject: [virtio-dev] Re: [PATCH v12] virtio-net: support inner header hash



On 4/3/2023 12:58 AM, Heng Qi wrote:

> To achieve this, the device can calculate a suitable hash based on the inner headers
> of this flow, for example using the Toeplitz combined with a symmetric hash key.
> 
I am not sure you need symmetric hash key. Toeplitz with symmetric 
hashing without the symmetric key is possible too.

So just mentioning it as a 'combined with symmetric hashing' is enough.

>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -198,6 +202,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>           u8 rss_max_key_size;
>           le16 rss_max_indirection_table_length;
>           le32 supported_hash_types;
> +        le32 supported_tunnel_hash_types;
>   };
Given that a set command is added via cvq, it make sense to also do 
symetrric work to get it via a cvq.
This is also similar to the latest work for notification coalescing for 
VQ where get and set done using single channel = cvq.

Granted that RSS and other fields are done differently, but it was bit 
in the past.

With that no need to define two fields at two different places in config 
area and also in cvq.

Just the new opcode is needed for GET and things will be fine.

> +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the device supports inner header hash and
> +the driver can configure the inner header hash calculation for encapsulated packets \ref{sec:Device Types / Network Device / Device OperatiHn / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
> +by issuing the command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG from the class VIRTIO_NET_CTRL_MQ.
> +The command sets \field{hash_tunnel_types} in the structure virtio_net_hash_tunnel_config.
> +
> +struct virtio_net_hash_tunnel_config {
> +    le32 hash_tunnel_types;
> +};
> +
VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG_SET
and
VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG_GET

> +Filed \field{hash_tunnel_types} contains a bitmask of supported hash tunnel types as
> +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
> +
> +\subparagraph{Tunnel/Encapsulated packet}
> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
> +
> +A tunnel packet is encapsulated from the original packet based on the tunneling
> +protocol (only a single level of encapsulation is currently supported). The
> +encapsulated packet contains an outer header and an inner header, and the device
> +calculates the hash over either the inner header or the outer header.
> +
> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated packet's
> +outer header matches one of the supported \field{hash_tunnel_types}, the hash
> +of the inner header is calculated.
s/one of the supported/one of the configured/
Because support comes from GET or config space area; out of which a 
smaller or equal subset of tunnel types are configured.

> +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +
> +The device MUST calculate the outer header hash if the received encapsulated packet has an encapsulation type not in \field{supported_tunnel_hash_types}.
> +
Since the configured set can be smaller, a better reword is:
The device MUST calculate the hash from the outer header if the received 
encapsulated packet type is not matching from hash_tunnel_types.

> +The device MUST respond to the VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG command with VIRTIO_NET_ERR if the device
> +received an unrecognized or unsupported VIRTIO_NET_HASH_TUNNEL_TYPE_ flag.
> +
> +Upon reset, the device MUST initialize \field{hash_tunnel_type} to 0.
> +
> +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +
> +The driver MUST have negotiated the feature VIRTIO_NET_F_HASH_TUNNEL when issuing the command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG.
> +
> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags that are not supported by the device.
> +
>   \paragraph{Hash reporting for incoming packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
>   
> @@ -1308,6 +1450,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>    #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0 (for automatic receive steering)
>    #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configurable receive steering)
>    #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configurable hash calculation)
> + #define VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG       3 (for configurable inner header hash)
MQ_TUNNEL_CONFIG is not mutually exclusive with HASH or RSS config.
Hence adding it here is incorrect.

See the text below.
"If more than one multiqueue mode is negotiated, the resulting device 
configuration is defined by the last command
sent by the driver."

So MQ_TUNNEL config without RSS or HASH will be an undefined behavior, 
as it doesn't what kind of hashing to be done.

So please tunnel GET and SET commands outside of VIRTIO_NET_CTRL_MQ.
This way it can work side by side with rss, hash and auto modes.

I am sorry for the late response.
I had a day off last week and other active discussions as you notice.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

