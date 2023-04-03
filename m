Return-Path: <virtio-dev-return-11890-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3760C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:53:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 45EDF7C2E7
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:53:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A6A998658D
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:53:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3045E9863DE; Mon,  3 Apr 2023 14:53:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FBB49863ED;
	Mon,  3 Apr 2023 14:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnw18dWRz0F+jSIAeJP36fombgsHuDWZW26O/DaEIkRG0Vx2Rp+hjKUfHC/9V7lMU0lpcH+hjNWRkcUvrbWaK2ELQrnpqYC5hib5Xg+p3qgJVsy8zSC2YH9iFkUteOEOs8awFWTWGs+yNqod23Sd9TWiSUqc3/n6f6VQNsDxs60bysTiO7VHUe/qp23Znq0PxLBHeLvHYcx5mILf6a01eDiSPDcfYNkQuffrkW4ka0x02oFe/qygHfJeTPu/yFx+QlqcUJaC+X3BRGpboV4heX7XlxkXN/hxY3keXtZltJfg4i9e9AnX8MweTQGL8s6o5zbVp+tpIAf0NPvJBXOH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRGdISCqvYcgUlCkne80CXujU4wayKF9WnH50znyYk4=;
 b=jJL/JDynbQZjdp9gBI5g67QDZTYc+wuGiKnYtWzQwK8QE8zhhixjZI1MBnNEMB6Njj16fBlTdGA9lMGDXc3WYS03O4vuf5424p1AmU2JiwxGvYK/TP4L2t6fYx+jznaShTukrP+WJp7M63pfnuJzkyn573SVyFAGFSQwQLlOVpCiSogP4PIJTrc/mcA5DtH93JxSwYs2G3U8+fh8soA7v3SPwbT+v60MklkU6/LZKlZOYbTrVgEbvF0Qk2NO8rsfI2Yy/IeT95r2NQt0pZpBcvKoZANICnNWUVZHHftCdwPm2lwM6mZsvn7Kf/I4CsicNM1Knhc9VZOkBQP0AwCdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
Date: Mon, 3 Apr 2023 10:53:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230403144523.GC302168@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:408:80::41) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 367e9c91-f970-452d-e826-08db3453315e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IjZDuCn6qrTLRd/Dlw34bEg7dc7yLS/dwjAZwTD72Un60b+4xte7q/JR0hYhVojO5aVdk8JCOx2njwB0u74Ciz9lUvM23f4/Zwu59BUkRel1aSff/VV1rQi2/VEhsfXy6sW/ZtfP/UrRnSIXOnezykQK1TLZ/nVsWx9cvfvMiWpRQnkjtP+J8ewuXKSN7BaEFfPoEBy863x/Nk7DW9n8JT90m3Idtol0ZFpI5MYOtzkoC8n+ucg/nGgRljSCOH2GBnpM1+2B7hCoWBZtmDylhExdJs4ybEgHq4ipYEBbaKxvWSf39n8W0Yf4Cgysbv+JqYgQs1vXgHw0+XyjAUotG6GjY45Y2/aQfsNajd48l8bgwhbRb9FNecU1YB49I6Ip9OcBFI3gS1pxBA6LZeLfuzOPwZO0tBWE55wGarM+tZJW0T2aAee9bFMqiyunASO7TsDJFb6bMGhHf9R/UaLJVcAOyg4QzdG6LhW2NI4ojXQ+6hkHSXJdTIse8lke+N+91qP8LPs31Yg4v/Gn9uiW7MHPETlIDMoTruLLblWv5Fzwzuk3CX6uu7OJPuZ9R9MpWS/bOpQJJctmzGIyQSwFTLlTBLN/67b1SYkKVJPtzGxMfbWIRozVdyyZnPOWpQI/BjHOQT87p2AbVDpLFKvxyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(86362001)(31696002)(36756003)(2906002)(31686004)(2616005)(53546011)(83380400001)(186003)(6506007)(6666004)(6486002)(107886003)(6512007)(6916009)(66556008)(66476007)(478600001)(66946007)(4326008)(41300700001)(5660300002)(8676002)(38100700002)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2dqRjVJc1hVbnNEZ2dtVDdqM0V1MXAxNExwbTBtNkUyelJNeGpGN1pxSTRq?=
 =?utf-8?B?SHZqUlVQOUNtQjRVWVpFTm1JQk51d1VubG4wa3ZnMndkQUtIMlRrSGZsVEgz?=
 =?utf-8?B?RWt6UEczbmtSVTN1RG5xRCtoN0RxcTVoMlBqYTZ5cWhkeVV6UmUvK01vVk5n?=
 =?utf-8?B?WUJpMUVqaksyTFBtZ0Roc0FzL05waXV5cmpVc0R4aVZ0Ymc1dXRBWG0rcG92?=
 =?utf-8?B?b3FKMGtZaEtPaVl0YUhWd0N1Q2pVbjFBNXluVlFZczh5anFNOWFyODc1QXJS?=
 =?utf-8?B?N0dqTTFXM29kS056UHhZL3lYOEx6ZVBZVjVVU3hJcXZSMHFCbFVHaVB5bGpk?=
 =?utf-8?B?bFQ3cDB2YnF5Qkp3aEtrWFdVUEFmTUpNYVFRbDI1QmlmMWNtWnI4TkxYOEhC?=
 =?utf-8?B?V2ZQaWtJMEEyYUtnOVhRcnFOUzlVeVJnMzFpaWdUVnQ3WGVFbndiOE8veGpW?=
 =?utf-8?B?T3hiaEFGaXFJZExST1NZblRXNFBaWExERHhoUWN5d0l4Ujg3Tit4NDB0dzdo?=
 =?utf-8?B?Z293OCtWZEpSamI3b1RaZDBJRG9rWWpMOGEwRFE5emh6UkxJU0lwVzIwWGFt?=
 =?utf-8?B?M2hCN0JSL1k3bmN2T0ZiUi9aSkZkUWp0ZHI2d3V2eFpXREFkTkdOMmNJUzZL?=
 =?utf-8?B?bFgzNHhzM0pqZHlPWFBBdVhUNE8rTldINnhaeFFKb0tRN2dKZ2pSYUdGdTQ2?=
 =?utf-8?B?cTJ6RFIvdUt0V2QvVm95MUhldmZnWkZWT0h2VHZha3F5MVRsS2NyZEp5bDFq?=
 =?utf-8?B?ZGFiN2dkTDJtbklQUnRwR29xOVBHTTNyd2F1eG9uNEJ5dXhKV2N1blRHeHRw?=
 =?utf-8?B?Vzh4M0tzTUdDN1E2b1ljMGRHTFUyNFlwVmFuVC9pSGxjejFtSWFJNTF5eWhP?=
 =?utf-8?B?ei9Jb0VuRjdkM0M4QU9XS3VOaFF3RHFXZkpKNEEzbEY2MExiL0tqOXFmeElL?=
 =?utf-8?B?clBXb3ZtQWVjZWhZbmo0ZnoxZjdGU2dSdk5oWFY0eW85NXppVThySFVmMXkr?=
 =?utf-8?B?QUNVbFViaEhtN2RNbVBRL3NtSEpvamtsSXUvN0hKTWh3VVhGMWZ3Rkh2UHEv?=
 =?utf-8?B?Zmh2OTN4eURLY1M2VFhOUGdmUVdkSVpiMC9lV2d4ZVd1MXB4RXlTYkN0WUVa?=
 =?utf-8?B?QlUxeHJaSHlmRThjNDFmU2FheFpoelhRdHJwR1ZkeTNPSStwOGRHQlcrd3Zi?=
 =?utf-8?B?eThzMGdVTEg4ZGR4KzdRTWhjZ21mUk5OdFRpbkZlZWF4UmFRSlAreWJ4OXdI?=
 =?utf-8?B?djVTV25Ja2FEK0NEVzQ2QngzYmNXdEFrTUJ2a3FhTEh6emYvSU85dlBOcEdR?=
 =?utf-8?B?WEtRbWsySmNYUkJnNzRJb1N0b3piYlFnODJpZmFnNXU1ZlVVUFdpZTBLbUJI?=
 =?utf-8?B?OEVOMzZJRlc4SkJjT0lSa0VRSzlvZXY0ZlkzYStVOVQ4c3cyOWZ1UUMwcWF5?=
 =?utf-8?B?OSttblVxSEZvOU5vVXdwMFdOeS9NUmoxKzhZUklocGduem1mc0xQaGRnLy8r?=
 =?utf-8?B?SlAyK2lLcGFuN0F6b2JKcUI3L01GTHJ1MEdzVWxNaVRTdlFQQ0dQMjYyYzI1?=
 =?utf-8?B?ZnFGT25JM3BHRm5WQjcxR05UTzJFTmRGbE5iK0VNUW80OVJxeFFBMzlUVitM?=
 =?utf-8?B?MDhQY3ZkMXdkTDF0ODRIVlI2MHhJTW4xYlF3ajdUQ3N1OWlpbVNaNXlTQXpq?=
 =?utf-8?B?cjEvaWRwdzJkRkhERTFibHNjUDZBcUI3ZDdDcC9hb0NtYWRkVVV6V0VMaEsw?=
 =?utf-8?B?Z0VrVWxTVTlCUGdlMHpJSDl1VEhmTmU1MjBYYUpwOWRtcU43MzRuZXVvcjdj?=
 =?utf-8?B?YWdJclpCUGFCVFJrcVAwRlkwWjlCTnRGUzBpTC9hZ1Jtd2lYU3NmZ1graWdQ?=
 =?utf-8?B?dnZucFhkWHVFNHM3UmZ2eUhaUWZkN09ZdFUyR1R6UzRmSWxYSzdDeHNtdmxL?=
 =?utf-8?B?eVpNeTNXUW96ejBaa2ZVK1Q5aEJlN2tOMU9pbHVhQ2dHSDNuR2VtWTd4S09z?=
 =?utf-8?B?eVI4S2hjT3Z1WkJqcXlKWklsY0g1UTc5dStiNmFzN1hXVGFMa0hFdDkvVXRP?=
 =?utf-8?B?d21DTm03d1czQWJCQkR2bkxuTnFpK2xzdlUwUmxXQmdxVHJPWWpHNllQYlJx?=
 =?utf-8?B?dzR5V09GM0d4Qi9QV21EUVpUakZrT2FYVDY2eER4N0ljQ1A2VENFYzEwMDZq?=
 =?utf-8?Q?tuKf6lc4M6e9UMtlz82kOXFtzwvk9HS10qV7AQX9goJp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367e9c91-f970-452d-e826-08db3453315e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:53:32.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE0j4nx4fA9lAsqaduPqSXsG8mF3rLva3Qr4aS70n6xwFVvkPBwnovRfU8RhH+4jYhQW6Jsnnhz9VwtAULSRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device



On 4/3/2023 10:45 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 31, 2023 at 01:58:23AM +0300, Parav Pandit wrote:
>> Overview:
>> ---------
>> The Transitional MMR device is a variant of the transitional PCI device.
> 
> What does "MMR" mean?
> 
memory mapped registers.
Explained below in the design section and also in relevant patches 6 to 11.

>> It has its own small Device ID range. It does not have I/O
>> region BAR; instead it exposes legacy configuration and device
>> specific registers at an offset in the memory region BAR.
>>
>> Such transitional MMR devices will be used at the scale of
>> thousands of devices using PCI SR-IOV and/or future scalable
>> virtualization technology to provide backward
>> compatibility (for legacy devices) and also future
>> compatibility with new features.
>>
>> Usecase:
>> --------
>> 1. A hypervisor/system needs to provide transitional
>>     virtio devices to the guest VM at scale of thousands,
>>     typically, one to eight devices per VM.
>>
>> 2. A hypervisor/system needs to provide such devices using a
>>     vendor agnostic driver in the hypervisor system.
> 
> Is the idea that the hypervisor configures the new Transitional MMR
> devices and makes them appear like virtio-pci Transitional devices?
>
Yes, but hypervisor is not involved in any configuration parsing or 
anything of that nature.
It is only a passthrough fowarder from emulated IOBAR to memory mapped 
legacy registers.
In other words, hypervisor do not care for the registers content at all.

> In other words, the guest doesn't know about Transitional MMR and does
> not need any code changes.
> 
>> 3. A hypervisor system prefers to have single stack regardless of
>>     virtio device type (net/blk) and be future compatible with a
>>     single vfio stack using SR-IOV or other scalable device
>>     virtualization technology to map PCI devices to the guest VM.
>>     (as transitional or otherwise)
> 
> What does this paragraph mean?
>
It means regardless of a VF being transitional MMR VF or 1.x VF without 
any MMR extensions, there is single vfio virtio driver handling both 
type of devices to map to the guest VM.

> 
> Modern devices were added to Linux in 2014 and support SR-IOV. 

> Why is it
> important to support Transitional (which really means Legacy devices,
> otherwise Modern devices would be sufficient)?
>
To support guest VMs which only understand legacy devices and 
unfortunately they are still in much wider use by the users.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

