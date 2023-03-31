Return-Path: <virtio-dev-return-11882-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD219C761A6
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 21:43:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EC2A32ACAD
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 21:43:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DED72986587
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 21:43:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D1457984282; Fri, 31 Mar 2023 21:43:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD8AA98657F;
	Fri, 31 Mar 2023 21:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIvEDQV488ehLf4OB/e2FyF1hBpajAdkpa6y6TAUZgMZxjeBt7diIwD/R/mprUoeEXG3v4ce10XGsJ8HUmhiaKmvef2j6He0cNJK7t7b24/8dzj035p/XW+P3cjc0g7StG+auMxLjK1lObPlTwONnO/3P5iKQQaKsZ3JS13HoSUehXMwIF1sIhsFYXtCaJ1fxMuCLAeP5xQJYNL8h5GcYvgeHGXkQRtW28ZFrF+CF2p0u7s4R3oBfNAiUb/Wh6Kv+TxVORz9wQhrfWR8PGZzvej0002L86ux4J/0W2NMrjKED0q6b8CdibIYkKgN4NqqImGfYUB2kn90gG9iwkOWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HGwKnd2Pc6f7qrPOojucy3OfxiGqguyIk5kLbRRrT4=;
 b=m8s23dJaqj3l2On+3Ah59SKlwH0EDSyy6r6oqBXzV5KCXa4QT9EYNVIxaGTHrc/VP6392Ou2mZkOr+fWi17i/LTg8yOl8omxG2AGhK2wjib/UY0zhYaOyev4C35uTUS1DK/xKmiFERNnE2iqbGjilh9qt/8fYKnp8+AWmKtt86j+NY7AgdOd3RzUX4KGn2JDTAEUhy/+9gHrgB0vTEJisFH2RJ0rNRXEQK8FqKClH4RmcocVpSzshubSzL5A2v7/Y9R7rmqRbKwBH5Ewm+p9jiYgU9vIQaBtcbY6nLR0wuqJXMdfQz2cftfBTxSXFTY1+gKV9i5CfnaRmpdeKEJNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
Date: Fri, 31 Mar 2023 17:43:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230331024500-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:408:fd::17) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d91e6a-33f5-46e6-e010-08db3230eeb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6kuIEe9qq6k3QUJzRmYxjrMv3pTFpC97vTgpw+39Bv2UYduG8YMwRpSEttW4c7AaS4o9pyhmk59GBX/ynfMVlj3rVBbun3p16jSWxHYgqylNt2V7yvnu1qMmF0fgNTP1yqt1iuB2x3yRmGMQAmGK6u1QgpNmKYF86Q1c8J4thxInUKsglLWuarB1coUuWILegcNcfZ2v2aF3m3yZnoBIPobnXL7IpZWgEdVQj/VAaMTeF7XtREVT1va0unVck64hGw+JzZxA290OcbYwf+BQifP8K0vVL5NQKOAZx5bFCVJ3Kvw2uWOBIBFsdK8/bEHeo+y1e4XAm4VBHtCEoAQAi5J1BrpE7jLfA4yKxfyEh6md9TIF98Du2nidmJaIp4exRGXdjeSCtlDG25UxfG7CeGFm+JQNNc5eZ6mg5ZtPjf1L01k8EL38IetS+oCVj8OHC9rqcgock4in/hsUOBUrJNSrw/Yo3bZ395r1xGLdJ38TxtKOGrThAG2FvfqJovHTCcvST/1RkqkSBI94/KOghJNkTovpD8wdKoy0sAmUMEfOBuSLGyL9INTGP9CJn3wIUnU1EI8Xn5qc9Gol1XVf0xRA5PkQ5JeY/jUFOWtvCP2wB/zU6EDnokId2aoPgfvXcH60BkEsFtYqxfKw5kTS0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(38100700002)(5660300002)(2906002)(41300700001)(4326008)(86362001)(36756003)(31696002)(8936002)(66476007)(31686004)(6916009)(478600001)(316002)(107886003)(6666004)(6486002)(53546011)(6512007)(6506007)(2616005)(66556008)(66946007)(66899021)(8676002)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTJScU1tRm5VblVDdmJVUG9oQkt0dC8zaE0ycm82WTdtNU9ER0JpdDJrcHlq?=
 =?utf-8?B?SHdIdlptbnNtcHBnV0J1L3A1ZHZrVTdOUytKZkdvRXZxa2FuY3cwdmVVR25P?=
 =?utf-8?B?ZHJjMDFPWEYxTTkzYzdxK05SOFFkVVNyVjZEK0h5WnhwZjFUSGMwV0hnYkZM?=
 =?utf-8?B?VnFNb0k3M1NqMDlRUWwrNTlRcDYzOFI5VFRpcXVMYXg3QW1YZFpsY2tHMXJq?=
 =?utf-8?B?VTh1Q2g3Z1NjK2wrNGtrR2NhR2dkZzdsVFBGdTFFQUtPN1JyQXJ3WlpiblBs?=
 =?utf-8?B?V1RreDFzSkMwUS9uTDNwUk5mZ2RsTjZBS3VxVXFlV3NLb3R3TnJXdE50ZHgy?=
 =?utf-8?B?UWdGeWNzb3EwOUlxOHlGQklMUVBjdGRJckNTek9uMm12aVFzc3VLZWlMSVVt?=
 =?utf-8?B?V1hhQUQ5UEI1VjkrZkV1ODdEckhoUnNadyt1UzJOK2QydThNNXIwcDZ3eWlK?=
 =?utf-8?B?b0RVeTZYRFprMjNpcHZxSjVXUkQrVmNSSm9rbmp2TGhVVit1czhMbThXYlI1?=
 =?utf-8?B?MFV5REd1TFZha2pLVTd2eGlmcU9YMU1ZK3YwRXZFaXk3UlJDYWFIZFJMTURX?=
 =?utf-8?B?cHJReWg2ZS9nUko3UlhBM01Bb254WEJ0QWgvY0FWYWFKdTBCZEMrM0psNWtL?=
 =?utf-8?B?STlGU0M5ekRqUVFLNXc5c1loSmEySmNTSWM1Qnl4REIxTUxMajZXckhCTXBZ?=
 =?utf-8?B?NW0xNU5JMFJVZXIrU3hmSzBZbUNPQ0Jad2c4aytTcGowbmdOQUJGSHZlVVY2?=
 =?utf-8?B?RFJKM21lbG93N3VwTml0Q3FMaE5KcmVwQ2hGVjJRWXBwMGpaTjNxL2dyQTJD?=
 =?utf-8?B?OGdkbmZ3N3lKY0NlaW5IRHRBRWZzVTFFWDZBcnI0b2cydkRWMEZEbzkrQXZs?=
 =?utf-8?B?eE9oKzArL21SWEJmOUNLNGcxTnNsUWkxTktYYW1CaVNkRk0zc3gvTnlIc0Q2?=
 =?utf-8?B?eEs4eDk5TkttL0I0cUl2azA4cCs1SWpJUjFwZVQ3dWh3UG1zS1N6aU5ZWjQ3?=
 =?utf-8?B?UC9jbnMyYTI0VnRFMTliMmYxdEJBaXZjMGtHRXBpYTN3YmVnYmFZa0ZWejh0?=
 =?utf-8?B?VnZmUHM0NUZLVHQ5Z3RxOWYxU2dpR1ZSV0NZSW5xVUIvek9XSkVVdmJManVw?=
 =?utf-8?B?OEVYWVVudm11ZWtKOGU3Y1NpQ0cwTE9sRGNjc0VIMU0xSjNESWNiMVlHQ1dt?=
 =?utf-8?B?Vys1Yys2NUdPWkFaYmlPTURxdTdrbThlNkRWdUZvZEtEU3JWNkI1bFpxZDd1?=
 =?utf-8?B?a3FNbjlhcDhaay9ObWdYMFdkRUdpUlBGUXdyTXhuNmNlcU1KSndORGhNbDR2?=
 =?utf-8?B?Q01FbFBiZUx5bFRNcFd1SEVUU0dZNDZnMnl5SzI2VFcvM3FkSjhydldvbWRR?=
 =?utf-8?B?QWtxbVhpYTZqdGloYXF1OUdUbHFaR0Zpa0tiOU1zTFF0WmYwQXhscmdjZ25T?=
 =?utf-8?B?M1lCVUNyTHRqQ3VEM25MVENoczkwY2huVTR1Qk1lOTljdjZmTU9VdytUMTN6?=
 =?utf-8?B?R3U0NnNVL3hHR292Z3JDQkVBOXlRMnREWkY3L3loc2xnQ1hBYVZrTHVQTzZk?=
 =?utf-8?B?RjdjYU45NHh1SjVZZmtTK2NLcURHL0wvUjBBQVlTSis3RHlsSDNZY3J2Z2NS?=
 =?utf-8?B?V041STdSQ2RmTzlhUnBHczRnUUVNSEl0OTRHVjZQRGhVeGRFaXRHS0dZNUYz?=
 =?utf-8?B?V2ZkaUdNZjRxM2dZUHF3VXFkd05OTHpaeVpLS0MzY0hPdzdjMVlSYWV1aFpw?=
 =?utf-8?B?eHc4VFBLajlxVWFUdlhHWVRVMjlyclE4ZlJqMmZxUlFtdHFtV2RUVGlmc0th?=
 =?utf-8?B?TTVQOU9tZlJsaWNTNnVVeHRWNlJNZFpLVkFyR1E5UlR5cElBcTBHQ3MzWE9C?=
 =?utf-8?B?RGw3Qk5hc05vbzEwS3B0VmJxaHFQdmMwVjZEQ2FsMTRMS0ZlejdQK3BidkZK?=
 =?utf-8?B?K3p2SEhnT0h2V04vcCt2QTlxam5OYVc2VHpSYlI3YmdDT0NVUWMzVHdVajZn?=
 =?utf-8?B?bnZWc2hXT2ZtZ3FNNFB1Zkh2OWpsUEpZTVY4T0owRU0ySDJTWTlYMTBpYktI?=
 =?utf-8?B?Q0pjbUxOOVduZTNJcmoxRzRBTEwyRUZLUCtLNHBSZXlGVithZUpaOXNQenJs?=
 =?utf-8?B?UjNJTm85UG1zVlVyZ0RmN1B2U2drSTh6R2tXUEQ4ZHhyS25PbEpEVkl6ckZM?=
 =?utf-8?Q?keKArakbtlbBULkXFy/YveNzClp55EjIoVriF/qAJoqw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d91e6a-33f5-46e6-e010-08db3230eeb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 21:43:14.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeY5QYgOyMMAtuHpxGTKUbmfz0ey5htocnfRY2luHU9llBAtzCMdEFxbu9M6BIJgsAqnCo6y8Bi32NJD2vM1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device



On 3/31/2023 3:03 AM, Michael S. Tsirkin wrote:
> 
> OK but this does not answer the following question:
> since a legacy driver can not bind to this type of MMR device,
> a new driver is needed anyway so
> why not implement a modern driver?
> 
Not sure I follow "implement a modern driver".
If you mean hypervisor driver over modern driver, than yes, you captured 
those two problems below.

More reply below.

> 
> I think we discussed this at some call and it made some kind of sense.
Yep.
> Unfortunately it has been a while and I am not sure I remember the
> detail, so I can no longer say for sure whether this proposal is fit for
> the purpose.  Here is what I vaguely remember:
> 
> A valid use-case is an emulation layer (e.g. a hypervisor) translating
> a legacy driver I/O accesses to MMIO. 
Yes.

> Ideally layering this emulation
> on top of a modern device would work ok
> but there are several things making this approach problematic.
Right.

> One is a different virtio net header size between legacy and modern
> driver. Another is use of control VQ by modern where legacy used
> IO writes. In both cases the different would require the
> emulation getting involved on the DMA path, in particular
> somehow finding private addresses for communication between
> emulation and modern device.
> 
Both of these issues are resolved by this proposal.

> 
> Does above summarize it reasonably?
> 
> 
> And if yes, would an alternative approach of adding legacy config
> support to transport vq work well?

VF is supplying the legacy config region (subset of 1.x) in memory 
mapped area.

A transport vq on the parent PF is yet another option for legacy 
register emulation. I think latency wise it will be a lot more higher, 
though it is not of lot of importance.

The good part of transport vq is, device reset is better as it can act 
as slow operation.

Given that device already implements part of registers in 1.x memory 
mapped area, it is reasonable for device to provide similar registers 
via memory map. (legacy is subset, no new addition).

> I can not say I thought about this
> deeply so maybe there's some problem, or maybe it's a worse approach -
> could you comment on this? It looks like this could be a smaller change,
> but maybe it isn't? Did you consider this option?

We can possibly let both the options open for device vendors to implement.

Change wise transport VQ is fairly big addition for both hypervisor 
driver and also for the device.

> 
> 
> More review later.
>
ok.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

