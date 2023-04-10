Return-Path: <virtio-dev-return-12102-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4977BC76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:17:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A38E3D56E8
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:17:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D833986549
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:17:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 937CB986353; Mon, 10 Apr 2023 20:17:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79EA798632A;
	Mon, 10 Apr 2023 20:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0taKq2N/p7r9/E1TQ33ImE6bFR5rbVEeCJzCX9Q+gOeKPXPssIv+B9L2oAdmNViooUZfUEyFLpEw0l0oR/cvXcph3D1luYaqe/mvST+UjCeZ3z5x3y1I8X69qczG/1x72jSQ668hZnOLUXhkJ+Zxfx8CDxafYw7Y1yjFJMsSt736qb4qNT1PquHy0X7+40w1naFyp+Vplk4jD6WH4U0m+YVquVu0FAymmXol+zdobT32x39GY42cDFDoZ5BwZeOQcJtGasTHYLSxgy9Ebqmgty0SEqhoMvdBUWbXsfTVv74FfhZ+D30L42wc65ziEEXjoR2ne5swcmkzLU3bxeHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2UrMpJ3LkcQpcNpdId9F5Typ2nA/4p9Dxukvkxjyrs=;
 b=cEf/UpI2QcbIkjCVAh5z1biD0TdQ8im1/pRnKyXhaR4cyp/xnzPHpwQNryse29H6/yl1O+8WPdIdowd+G+gtjJIu1u1usvjtHiXAD5z79g/8q5sA1jTqdjnFnZouTr10GcBnwarxiPPWbUg6nL4q62ilbwTPLQyCSbjhkKlwBYG0LRFGpZNKMKkjmyalRzcALObaquGwUp5tb0W9gM5ECNoc6p6d6hCCFjgZbw56XAMjl/e1r39V1aKnGyhmHhUo8JnNXmVXNqmzAOceqXfiF+YaiRdwfXjbH9sRdDEpjMhZ6ES4h8klJNIAP56BIjX8dS12Vt+Yh24a6UCe0iFvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <3a8d1edd-8534-293b-d558-3e36ed2bdbe6@nvidia.com>
Date: Mon, 10 Apr 2023 16:16:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
 <20230407074605-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407113737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481097A6BE0F55E6F626935DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230410060842-mutt-send-email-mst@kernel.org>
 <460d2724-5c92-da5c-2f8c-cf29ea6d8080@nvidia.com>
 <20230410154959-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230410154959-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:806:125::6) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: b44671c0-e0f4-40ca-ee64-08db3a008735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a+L2TWvktvaWxV/z+lmz1Zw15rujfHcHd7aSIFbYq9wWa4qLeTHpaZxFEhSetlkyRHx1YJd8QZnHE+0wwNGP3fWEK608glsYSvafIP/CJXCjwPcdUVh+LVc4UaAKYRKAH5ZXBh1TRdvhsKik4A1WNxTk1tQy0hTaG7ZlZHmFLI6s+RakzIZPmDJpL4Fkad0axHrraLKBilDXjd3KQFPECMGcdpE109EIulpq0Pf+tpWVKX6hFwVhILPSXpz6Kvuqdu877psymm7aZv4CWB/B/Z5MZ5tt3Q/Xa0J7OgxWhzQTNyQf+Fg0GYE/xM1BYzkzxRtxqlfT9PUO96Loe8TqNami5TTWDg1auXgMivUwWkZDZH1ZCy0zSdMmtx8uz5APD5qE2B+KcoJu1wdN6MUcyiZTm4BuRnwZ63mBF413p0ifiWxu0zRiefhVTON1bDSej0Rzohi81P1yEYNWC0OZhCjtNls6oo8WWsoEPCQkYPhNvgTnskEkrocVPx1esGM0Yycwvqi0prXCbvSZuCNh1d0LR89NC/pV6Bklo59xnVTsSXmhu3SMnkM53NQLPghSPhpa2T/ESq7xx+s9p4AI5XJpZU8BAUGLqlnDEgQJuXkZc9FMb+SFxXnFzpNwAv61EHhnmBKoWDuaxikGcBdALQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(478600001)(316002)(6512007)(53546011)(26005)(6506007)(186003)(54906003)(6666004)(6486002)(2906002)(5660300002)(4326008)(66946007)(6916009)(41300700001)(8676002)(66476007)(8936002)(66556008)(38100700002)(86362001)(31696002)(83380400001)(36756003)(2616005)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FSaDJrb1RmZUVKNXAvd0IrU29INkVlbmVQWm9UakUwMERhdE5XNUpZUDNI?=
 =?utf-8?B?NW1mSlpMa2xHVk9RQWlBM1I1eVlBaXFid1hUSkRtd1FQUXhlYUFZcm82WXRa?=
 =?utf-8?B?Z1NzYmtQMzQ3Y0Y2Ny9BVHdzTnlWQnlLRzhab3FBNFh5NEc4SFVHVXBNNjV2?=
 =?utf-8?B?SExnNmpKM0NySy9nZmYwb2lKdG53SWVkS3Y1b1VLTTBSMUk1MFlFR2dQaDky?=
 =?utf-8?B?ZFhFWmRUTTRVczZ3UW1mVkRON3FJR3BseWVwVmM0blFyNFI5N2pWdFVQbDYx?=
 =?utf-8?B?RDdsQVZMcGlrM0J6eGVscUFlNXRpZVUxTFR3ZmxXelFKQjlCYVJUUWl4U3Vv?=
 =?utf-8?B?czU1SlFLU2M5dSt0KzhJSWxhL1ZEZW1EcWpTM2VYdlZLd0RVNVZteUVtMU1J?=
 =?utf-8?B?NlJ6R051UVB2M2dTRVlsejBEOGRxMGtNWlRYd0lxNmU2YmJraU5BeVNJUXBn?=
 =?utf-8?B?RGY1TWlQNll5TWtGWXVVbzZTQm1CTlBqVktYVWVMaXIrblA4eFhjM0JBYVY5?=
 =?utf-8?B?M3ZVTXhUSmlrU2ZGK2VyOHhOcHFWS1o3dTdReFpWUXora3RxUzVyYjJBL24v?=
 =?utf-8?B?T01uWHY4cXhKWk9zaGo2U0MyMWFQSTltMmdBMmZzanhXS1BEUFlaUHdtZjdG?=
 =?utf-8?B?T0hZMDZHbkhLQis1VWQ4bFJRbERWSnFpVlVrSW9md1BDaU92blMvRHVySjdN?=
 =?utf-8?B?KytSbkpnS0xCQWtRaG5WMCtrZEZaQ2dFbktIT053dVgyaDByK0ZJeTJxYytk?=
 =?utf-8?B?NGNlZzhMbUs1SkFpeWpLU2RCQU1kTGcxLzNuWlk2NDBFVjVtbGpTYVhPL1pm?=
 =?utf-8?B?S3ZNaUJralZmOXI0cXloT1V5QjZaQjExUWx3VzhvdHJpbk1HeUtxdml5ZjZQ?=
 =?utf-8?B?UDh3WTA4QmtldE82U08yOFNqVGFHM1V6Yll5cjRkamFPbks2S0REekdEcmZL?=
 =?utf-8?B?ZVdGQVdIWHBaOXkvN1U0YTFrd1A4Ym15T0RpbjkwUlFSWVhjdTNxdGlSdXNC?=
 =?utf-8?B?dmtrRnpsLzdmUThxMnFBR0g2SUxISXUxZWwyVmU1ZHJCZXVWTnQ4WkdFR1Zt?=
 =?utf-8?B?UEdaNVE5ODJBNTd5OTVEQ1lRSkVVSjlXck1xR084WGlOMm81V3E3MkFwbHkx?=
 =?utf-8?B?UTh0dzRUUkNueTR5VVBEWTh4RzhiNW55aHU3VGxWRjlDQkNOcFlrMENXZEVp?=
 =?utf-8?B?TnlZcnNxbWthdFZ4eENJempPeGZzd3JwRXBiQnhPOHVuemZ3cmRGakp4V2pm?=
 =?utf-8?B?QlhkdTRpRkJNUTNoRUY0QUVrUmY1RVhpaUVDbFlpTUpzUklYbk1KRUhSVWFI?=
 =?utf-8?B?SVc3ZkR5ZjR3NG5RR2xtTU5tVVhWY1d4NGpYTWlkalRrSFVqTVF1S0R0aHg2?=
 =?utf-8?B?QksyL29XbjRKdVVNN1liMFVNQlF0SldGMTdwQ0l5LzdMQk5EZ3pVZERzQjlE?=
 =?utf-8?B?QUNDMmxyZFhjL01PS3NVcE5VZ2phU2dJbUhCbVlxRWREMG1CYjBZbDlPM1hn?=
 =?utf-8?B?NEN5V0FaNE54WHhCcVk5amFIMk83QmxxSEV4U2psQWpycVdUWFJCb3V2ZGw0?=
 =?utf-8?B?ZTNFTm1GajI2T1dXL2VzdzFkVGFlQ2F6TVhPUU0ybnFrbFNKcm0yNzM2TVJq?=
 =?utf-8?B?MHNaWm13dDZWZy9rTVNFc1E1MmwrQWhHRjlLVS9mWExRRWNWRExqU1oweEZT?=
 =?utf-8?B?aUQ3WjdnMnlSZFNkVDcwRUo3TnJPamZOOVAyY2RkdG1hRVRlWU5SUUUzWHRD?=
 =?utf-8?B?bFRzb2JpamNCNE1YMEFac0pMczRXbHBncDhpeDdmYkdlYy9nODZWalFHcm5I?=
 =?utf-8?B?UEpZWEZuSWJQdlpQTjhHUVlVVlRJTStKODRHbXRhMXhmN1VVUEx2Z2xabllM?=
 =?utf-8?B?QVhKMTg3UStORVRLRUlUTndVS1QwRkdXWFVyUW82R2lld0FLenpXTHh1YjlH?=
 =?utf-8?B?SzRjNU5SVU83U3FwbmFWUGFRYXRHT3NXaHFuRkkzN3VxbU9Dbi9WZkJ5OUVD?=
 =?utf-8?B?ODZnTjRaaExsUDNSK0FCcEJMeTBwK0RtNysxZUVQK0ZrQjVSTkRiWkhBZUhT?=
 =?utf-8?B?Uy9hclNKSHZTSFMyNm9NWS9ibFh3NG9xTnZJV2dUait2NUNJbG42aDVqMmht?=
 =?utf-8?Q?Aqk8kjPNiWpoHyRkWTjuyIcIV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44671c0-e0f4-40ca-ee64-08db3a008735
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:16:54.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JQlSBT2FOsGrVsPtkBwqzJZZu5jIUtmBQSbmWwJYZRLn9BRIpnGcnzkH42M5C2a20VaE1N4fIFb6XVbUulb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id


On 4/10/2023 3:58 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 10:34:16AM -0400, Parav Pandit wrote:

>>> 	A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
>>> 	if VIRTIO_F_VERSION_1 is not accepted.
>>>
>>> it's implied that this does not refer to legacy interface.
>>>
>> But the interface being exposes is not a legacy interface at the PCI device
>> level.
>>
>> A PCI device is exposing a interface that can be used
>> by either
>> a. existing non transitional driver who will negotiate _1, just fine.
>> or
>> b. by legacy driver in the guest VM, which will not negotiate _1.
>>
>> And here device must not fail to operate.
>> Hence spec should say that it should not fail to operate.
> 
> sorry, what? it's exactly the legacy interface that's the whole
> value of this hack, just exposed through another bar.
>
I am aligned with you on this part of exposing legacy interface via 
another bar (or a window within an existing memory bar).

What is translates to is a spec wording something like below:

A non transitional device exposes legacy interface using a memory mapped 
registers in a BAR or its parent PCI device through AQ.

Legacy common configuration registers and device specific registers 
accessed through such interface work as legacy interface defined in rest 
of the specification.

>> And since the guest driver may be 1.x, _1 will be offered by the device.
> 
> _1 is not offered in the legacy interface. And if you negotiate
Right.

> _1 you better not touch legacy with a 10 foot pole.
>
Right.

> Just add a new capability and explain that it exposes
> the legacy interface in a window at an offset inside a memory bar.
> that is mostly it. if there's an adapting layer that forwards
> IO requests from legacy driver to that window, this allows this
> driver to work and use the device through the legacy
> interface.
> 
ok. Something like above?

> 
> There could be a small patch or two on top to tweak wording if there are
> places where it says "non transitional devices have no legacy
> interfaces". And probably an explicit list of devices
> which are allowed to have this capability.
> 
Make sense to me.

effectively we will have,

1. one or two patches, as you describe in above point for tweaking 
wording + device list.
2. new optional capability (in extended area because legacy area is near 
to full).
    a. indicates it supports memory mapped and/or
    b. via aq (when aq is ready)

3. patch to make use of notification region as done in patch-10.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

