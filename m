Return-Path: <virtio-dev-return-12396-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E569FC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 05:03:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4F6D229FCB
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 05:03:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 437F9986647
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 05:03:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 37E3098643F; Tue, 25 Apr 2023 05:03:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 217EA9863D7;
	Tue, 25 Apr 2023 05:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg0qY/W+23f02UJSzPwF8v5nhV9qqi/4AuW0Aee0c0hQgAZTut0AArGzadRrzf64mLrrRSAnx7v5mnbpzPp1sJ2L8Ncn2RKq4SlN+nyw32+O4g/pBNpa0DVEQsXlgLJPIV1crCcgmcOf4h2ZBEdbTiw0E85aEaOuFfsfYpfXls4hhvT8T1o4I9LnHvKJudQ49m8hbv0GlvijHRJuntPdM0or+M3a1g4W/AG2CNOlEozkNMzlokJwn3nnImeZeL5XaXWWGNyKVe0R5xvqgRFCZmNdwGhMrkSTYoWhUcPZK4I19F/NZCMr4GWmvmU2s2daJAcoX8mgKZNEAdlFKIq0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD4Mw1SK0Lk+brgBql3ymmX0aPJiAru74lPq/8+r76g=;
 b=Gue8D4XjZqKLiFJuu1EhfIfQDL73zEvrZzp39gtPD4BBTjvHjXSGfN42+ZEtdZyDYeJYdEWGLGttwPWrrdxfZ0KSETY7fVQB7sTMWr0DDvPHBTgJSWWVDb7BgAveZLtR46FRQiA+QLddRUMfH9T5HupRd2HzBjTEHZoRn4Pedkg7Lu5U8iWjLavXOwYaQF+ExTaa5S34zzdXWpW+eZ0LmYee92t6MYT8/4FQ2tA76A+g3ULtu8q/snVAQX0f7Y8aRLW5mB902eIjIkdeBpE64PIjSjFiid0w/e4hBCYRBwrMP3VRW3mTHNzgrPGl2zXAB5Cf5/+DMnxyCXSHasvEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
Date: Tue, 25 Apr 2023 01:03:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, houp@yusur.tech
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
 <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0fb2a7-7e62-45f8-3da1-08db454a6455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NNc+lx30wQ14MAi6Xt06I1VD7T8PVL77YJQcCxP0UmIYSDvSFkGXPUgAvaacWcBA94DL2vP8CMikZZfHfRFjCIgg88dW3XSH49CjABTvN3u03GQP1tRENxxKGzPwrWE+bBKTPYFeUM9q4kQ5xUFeI2xHdc9Rwwn/9S0jDDeXHKjYnWYNQ1kZnEOsjj7Ilm3MvrlQGp2vQv0fMX/fmoIf8pZjLWm1VpKxcQlaFZcY0gEJGQ0z1zcr9LAkm7ws6Eka8WKr1vDkY/uSLgv5f9uXzvuQxIuGUNhv6rMMpY/4UDC5GVO0pVjv0KO+APW7U/gbx2+zB1238f+eIX1T8TkS4ni5evTogn/MDbbDr4P+ZjrIHS8K71R26rXShjl5H6huMtUWG/UXwJ8L7IZHpxeKUrVCLeiYAF/gTY98xpf8NG7c2qkCdX16Lcccba1FX1L5Jk4zMF5HQ/HfSc1V+wluYKqebH3V40Y5TZaFKEORlZ3j4RWsu6JieAnNrDWXIpL8LlNDAHLWMhW0cA/i7fOKj58c2Gy/katz078TWSefZi3zISHK2eXRzdBBTgsF8kI6oIFn6//jKgQNuYhg2JzkKeKfmCEvLO8WAFtp5OudelHj2fYQJZw+4/iGG0OZI9OTz79hqSYNCLiMnvMjf2UQLBwELHIlY4nxOwLfkLyGItYTgAMZ5PWw/u6RM9wdk4bW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(186003)(110136005)(31696002)(54906003)(478600001)(86362001)(36756003)(6486002)(6666004)(38100700002)(2906002)(5660300002)(8676002)(8936002)(66946007)(66556008)(66476007)(4326008)(41300700001)(316002)(26005)(6506007)(6512007)(53546011)(2616005)(83380400001)(31686004)(200143007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpnN0cySUJWdVYvMlpndERYc0lJMlE2ZTY2b2liaVNCSHV0YzYxQlBaMTcv?=
 =?utf-8?B?ckNCM0ZGeFJNc2hXM3RRcnRxWUpxY0hoTytJSS9UODRkdFhkbFN1RlZCYVU3?=
 =?utf-8?B?Yzl0cnFBVU5tQ1hCb1JocXhlUHIvOFlrd2ZheXpvZC81QTJUbGN6bi8welJK?=
 =?utf-8?B?RnlmT0JqelRiN3dVQzU3QkhHZUd3RkNOMmhjNm1IbjdmUjU3UmFGT2JMd29j?=
 =?utf-8?B?cjhLU1c2MmplendWdWFMaEJ6SFBFNklFSUhFOEJDZDhpYlk3bXM2MmRDQ2Nl?=
 =?utf-8?B?VDJRbkRValdLOHI2c3QvV0oyc0xMUFJpOHVZQ0JyZldIdjBzSG90ZjRScHB4?=
 =?utf-8?B?WE9ERDhVRkV0ZzJzNFpYeW1EYmdNbTVxRkNnQUV6eHZQZ3Q2U0hsRngrT3lj?=
 =?utf-8?B?MEk4RE9mQmhyeWlnc3BQZlhaOFQrU1ZQaWV5M3dva3h5Q3k1UFoyUkFoYnRo?=
 =?utf-8?B?R1pvczRhTWJJOWhxNERmcUdBblVRVXVaK2xxQkgveDRTWlBuQjl1c2JsNG5y?=
 =?utf-8?B?YXhmWTRyQmt2dlAwK0dhVUYvWmkxWHVYdjh4cjlIbTBKL3p1dVl2NnpySVgy?=
 =?utf-8?B?cWY5TzF0Q0l6UXg3NmttMnJKZ21NajY1aHg2cWpIYndJb1BVQUhHRzY0MC91?=
 =?utf-8?B?Snhoais0eG5zSzNWK1Y4SzRIUm5IWlYzckQxb1NIajFrUXRQRlJtd3VhUk5H?=
 =?utf-8?B?NGUrSlYxM0ZBcEFPOGJtSHg1bHNISXc5TnZDUG81MW5zOEQ2L3dmSXhuZFJo?=
 =?utf-8?B?bE1ZZTE2dUd2WC80WHdGakt3TEo2cjhLdGlkTmdvUm9CYy94N2U4Q0hrRWpM?=
 =?utf-8?B?WS9GS0ZxOUlzTmhTTGpOMDVIRFVUTExpWFJzWm5XOEFINFhzRkR0c0h2N1BX?=
 =?utf-8?B?aXZURkhYa2Z2aERlWEh3T3BMbDhTc1hBM1hyL2hCZlA4TFQ4N0dyZmxZbC9N?=
 =?utf-8?B?RW5KaEJaMTJqMTdTMnFlclJrYVMwQkE4bVlVSmh6WjRjWnJNRE02bUk5T0lW?=
 =?utf-8?B?ZnU2V3dlVWNtNS80V1FkVzNhMFpuaEM1QlQ0bHlDRVB5Q29vNWJ5N3N1UnZI?=
 =?utf-8?B?TFY3UWJnV0pEaUltaVFqNVRjUjV4M1dxRjU3NWZnZ0pBQjBqZnZUcktKNklS?=
 =?utf-8?B?bFcwLzRqZnpEdHJVdXBxazRuZmdnTFJXOEowb25odHhtay92Q0NXcmtCM1JF?=
 =?utf-8?B?Uk1idGxVSE5iK2ptOHlnQnkwZUtBK1hMcFh6WkNSeDNQbXY2NzVabXZQSXMw?=
 =?utf-8?B?YklFb0tEZzk1YUtXTTl5RTVsTVQraVFxUlF3NTVKZGgyeFQ0K3NnVXBBNW8x?=
 =?utf-8?B?WUpVTEd1SkEvOVJLMjU4VXVYZ3hDLzlQWlBHOXdNTFdJT1VIQ3Q4eFFlb3pq?=
 =?utf-8?B?dHVadlFoV1lZUGdrVDhtYmRQNW51MElQY2gxZjZQSldOT0RSQ1NTZUdvME9k?=
 =?utf-8?B?ZksrOFNxU2ZzdGZmc3VRS1QyR1NvdWZ4c29hRHJFaUVZMHNpc0Vrcm1Xc29Y?=
 =?utf-8?B?V2R5aWFqM0dNWGZ0YXo5WWdIaTF4Y2wyQzdnQ3RmVjBtdUpjRnVoY0xBZWRv?=
 =?utf-8?B?NkRDd1VOR2FMN0cxUE9tUGJHZEZIVC9oV0xjUUVTd1M3MWdCUnc3Z2VBZDJY?=
 =?utf-8?B?MytPNDlBNDFLck1yS0UrQUttU0RnMS9jbWlWU3BPbWhDVGdudkxrTzdOaG00?=
 =?utf-8?B?ZWV6ako5d0M0Ym1qL1ppNm12VVBEdnNXS0hCTGRGd1pwaGwxZFFXdUt0TFpH?=
 =?utf-8?B?Y3czTFVDM1NyNDVnV3pEUjdpTFI2dmpaWkg3TnYvbFhGY0EvRjk5cDcyRVlU?=
 =?utf-8?B?QkFBZlFpNGJaem41amxhWDJrU1NtK1ZYYTRlemxrTWFyTWNmTmZtaWZJNVFL?=
 =?utf-8?B?QUFJLytpWkhMQW91azMvYWg3Zllua0hRWkRuRWFKS2I5bjRBZm9hVkhMc3Fs?=
 =?utf-8?B?N0hRNFRQYkF1SklFVWQ1VDJVekFTUkRyK3ZjZTBuTDFBdXFMSzc0cGcyUGFY?=
 =?utf-8?B?NEtXNzFoaUxKWUszdVJoMGFWWlpVM3ZMTEJ4MUpCcWNvbXBMaFROSVVsYXJv?=
 =?utf-8?B?L1JvUUZjY2JDWEVuMUlNanpTNHdFRjhaRXNWeDFFakJDd3NSRGw2RC9xS0Vr?=
 =?utf-8?Q?+U5Kvi1uBSVuCsFIAJ67+Egf5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0fb2a7-7e62-45f8-3da1-08db454a6455
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 05:03:21.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVVIafN7IpOz7CZujMe16J1mLdjdWOMlKbQ0765z/u06leEd7o46dtoCY29tel+Db1WSQcOfHwmludFzViaZNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
Subject: [virtio-dev] Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)



On 4/24/2023 9:38 AM, zhenwei pi wrote:
> 
> 
>  From the point of my view, there are 3 cases:
> 1, Host/container scenario. For example, host kernel connects a virtio 
> target block service, maps it as a vdx(virtio-blk) device(used by 
> Map-Reduce service which needs a fast/large size disk). The host kernel 
> also connects a virtio target crypto service, maps it as virtio crypto 
> device(used by nginx to accelarate HTTPS). And so on.
> 
>          +----------+    +----------+       +----------+
>          |Map-Reduce|    |   nginx  |  ...  | processes|
>          +----------+    +----------+       +----------+
> ------------------------------------------------------------
> Host         |               |                  |
> Kernel   +-------+       +-------+          +-------+
>           | ext4  |       | LKCF  |          | HWRNG |
>           +-------+       +-------+          +-------+
>               |               |                  |
>           +-------+       +-------+          +-------+
>           |  vdx  |       |vCrypto|          | vRNG  |
>           +-------+       +-------+          +-------+
>               |               |                  |
>               |           +--------+             |
>               +---------->|TCP/RDMA|<------------+
>                           +--------+
>                               |
>                           +------+
>                           |NIC/IB|
>                           +------+
>                               |                      +-------------+
>                               +--------------------->|virtio target|
>                                                      +-------------+
> 
> 2, Typical virtualization environment. The workloads run in a guest, and 
> QEMU handles virtio-pci(or MMIO), and forwards requests to target.
>          +----------+    +----------+       +----------+
>          |Map-Reduce|    |   nginx  |  ...  | processes|
>          +----------+    +----------+       +----------+
> ------------------------------------------------------------
> Guest        |               |                  |
> Kernel   +-------+       +-------+          +-------+
>           | ext4  |       | LKCF  |          | HWRNG |
>           +-------+       +-------+          +-------+
>               |               |                  |
>           +-------+       +-------+          +-------+
>           |  vdx  |       |vCrypto|          | vRNG  |
>           +-------+       +-------+          +-------+
>               |               |                  |
> PCI --------------------------------------------------------
>                               |
> QEMU                 +--------------+
>                       |virtio backend|
>                       +--------------+
>                               |
>                           +------+
>                           |NIC/IB|
>                           +------+
>                               |                      +-------------+
>                               +--------------------->|virtio target|
>                                                      +-------------+
>
Example #3 enables to implement virtio backend over fabrics initiator in 
the user space, which is also a good use case.
It can be also be done in non native virtio backend.
More below.

> 3, SmartNIC/DPU/vDPA environment. It's possible to convert virtio-pci 
> request to virtio-of request by hardware, and forward request to virtio 
> target directly.
>          +----------+    +----------+       +----------+
>          |Map-Reduce|    |   nginx  |  ...  | processes|
>          +----------+    +----------+       +----------+
> ------------------------------------------------------------
> Host         |               |                  |
> Kernel   +-------+       +-------+          +-------+
>           | ext4  |       | LKCF  |          | HWRNG |
>           +-------+       +-------+          +-------+
>               |               |                  |
>           +-------+       +-------+          +-------+
>           |  vdx  |       |vCrypto|          | vRNG  |
>           +-------+       +-------+          +-------+
>               |               |                  |
> PCI --------------------------------------------------------
>                               |
> SmartNIC             +---------------+
>                       |virtio HW queue|
>                       +---------------+
>                               |
>                           +------+
>                           |NIC/IB|
>                           +------+
>                               |                      +-------------+
>                               +--------------------->|virtio target|
>                                                      +-------------+
> 
All 3 seems a valid use cases.

Use case 1 and 2 can be achieved directly without involving any 
mediation layer or any other translation layer (for example virtio to nfs).
Many blk and file protocols outside of the virtio already exists which 
achieve this. I don't see virtio being any different to support this in 
native manner, mainly the blk, fs, crypto device.

use case #3 brings additional a benefits at the same time different 
complexity but sure #3 is also a valid and common use case in our 
experiences.

In my experience working with FC, iSCSI, FCoE, NVMe RDMA fabrics, iSER,
A virito fabrics needs a lot of work to reach the scale, resiliency and 
lastly the security. (step by step...)

My humble suggestion is : pick one transport instead of all at once, 
rdma being most performant probably the first candidate to see the perf 
gain for use case #1 and #2 from remote system.

I briefly see your rdma command descriptor example, which is not aligned 
to 16B. Perf wise it will be poor than nvme rdma fabrics.

For PCI transport for net, we intent to start the work to improve 
descriptors, the transport binding for net device. From our research I 
see that some abstract virtio descriptors are great today, but if you 
want to get best out of the system (sw, hw, cpu), such abstraction is 
not the best. Sharing of "id" all the way to target and bring back is an 
example of such inefficiency in your example.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

