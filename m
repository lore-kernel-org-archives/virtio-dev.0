Return-Path: <virtio-dev-return-12092-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83327C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 14:35:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CD58A2B341
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 14:35:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16D909865F5
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 14:35:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 69DEF98631E; Mon, 10 Apr 2023 14:35:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DCBE5986319;
	Mon, 10 Apr 2023 14:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIaU16uoO6ZX3luOanu6ipyvJinYwe+tLiYHXEB/XtIS+A0N5stswdfJdsTYihDRdte0MpVZmxj6VGHJ+p8gF6iH0bK7YDzIrlBbfiWNkUvfQEFbjeOp0yxnfUZ0jJPd2cA7k+FO7x/134yNcBzU87cPtV/+3cUDaViX4Wcyh4NpKaOwghZpSqAfpHi62cBKOcKPjeuP+aNOiYKqBWzJrW5ME/sybBQp1zJeskEtCxO1h1KudytxvDZL2gepELvAT4SYT/zYRqlpfmSUh01tKN7yZm29KUFexvWwohQJsOXjrJLwI0HiIAg7lkLBn1mwxEKIsNOQczJ49xp+p2/q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfMd8Cov5jySpeK7hQ6DWBrssDY5SD/UGiDMKOm3Cfg=;
 b=jwA04NNEKUamge1r0Z2aXvN5GH8/J5s1dqjU2yqN5IhKitR3/krPZ31pIIo/tp2+ir2z3FiigPtrJC5+qCP/yE3JXOPosWhvElmCmRVKmnq0yX3WJwIhMgAZT08NqVgI14zwhe3/1AQil6tVfMltOGEFT1MfHvfc2I8XG0MZWb6GWcBjbeFogkS01T2kdzFBRJEhw8M133MckyQcxQL6EFHDlurVjJnz+Y+kl6kMUENrZHi/aD443f94IQrP5c0eoqo66K8rIKxlgW8l8F9a9l2iCJ9m4nnbASWi3s/6fzHcm7Xj6rLY/R7yOW58GeT0NbjFlC+PjoUUiSqUqugmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <460d2724-5c92-da5c-2f8c-cf29ea6d8080@nvidia.com>
Date: Mon, 10 Apr 2023 10:34:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230410060842-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:408:70::22) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e37a551-a634-4064-5135-08db39d0abbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5aYpILKEbxfdpxtTs+g8xtHzch/LeMIzMmrhS3cIZXs0iXSsn0lhdCvA0HS6N9083+VmzNhUVqaSanveZldgstTPrimZnq1N11pvLXVkd4M9z93K97/ueGsCqK5NyTe4PTQFoaWQkqGkN+3uwpDK/MZVI0qCSOior2rpC8mud5S6741jsE+woypS9X4KT6O8dtHA+SLKZWMt23bSxsGbsJ1oyFMH50SnVbcOEaU4g0qDxufZgoEAPoM2qfVF+NqNtwltmR50psJN2S+rTZvZbWqsGpgXPISrBEdmVhMq7NRUK5Q7ZdXzsXF70qAigqZ7zGmJp+Xww35+BQwDyoW/bo6BcAqhwHjuKykm2+1kXsHinBuRrkVWqQ2CAsn7S5uZqWeruYDITRY45JbE3KVyqkHPYdrqtpMwBO989IL0vAek99BCSvlwxRy8zX6SH9v0ihwGMDd5K5MsWh7UYRNeuttJERTZ+mb9f3WX00UvjMmt9IGTdtO9G2WO/3gfM2NIXVrftxRoexHuT78p/WQy5sbTD5wPurjJDUo01XdvReMihEuhqjZddiJH2Tnyfr+RVjh6y2DZZ6LPmATbWDb7Tfci2OOlhBfSCOYsDlOT6F3EsMhMZWCK9y3dmrp+Y6gOiWu3T+Vms09xpaxgRZpw5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(478600001)(316002)(54906003)(6512007)(53546011)(6506007)(186003)(6666004)(6486002)(2906002)(5660300002)(4326008)(66946007)(41300700001)(8936002)(8676002)(6916009)(66476007)(66556008)(38100700002)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUlhQWhhL2NHMGd3K0sySnAyQVhtYzcyazRNSi9pSGp0UmVINUhHaC81UjRn?=
 =?utf-8?B?d1ZCNnhiNHl1NUhlNGJjSVJTZlF6SXNFcEtJdHFxa3lxcGFKZHl4WHhYTEY5?=
 =?utf-8?B?RWNqKzQ2WFkyQ0NJMnhWVWx5UjExd1REOHUyMXZqRlVtK0NWZm1qKzIrTlU2?=
 =?utf-8?B?eGRyOWpCaDczSm16TmpNV0xkSDNvKzlLM3ZEV3Z3a2E4Y3BEdlM5VDVxZE1Z?=
 =?utf-8?B?MmZLZ0N5Q3l6Q2RPN2NCSWlkN21LeFRwcGZuaWhISk1iZUU5TS9rV2lXZmtR?=
 =?utf-8?B?d0lCdVhkVVozbEtRVFhFU1lQUGdGVEJJanZvSVRYaHhjNk0yUUdHOGFpeUF2?=
 =?utf-8?B?TmNwTXlUcStlenMyaS94cWlGWTlNWVlRNlJPcVlYSHlmejFvVTQxUXlybFQ5?=
 =?utf-8?B?YmhOdkl1dms4NzhwdDk3Vlc2NjNlUTB0MjIvNmJXeThLc1Y1SkkzbTNBSjdz?=
 =?utf-8?B?Z2ZvWVkrSzVlcVRjQUZQbStPVXRVTXJHbkgvaU00UEt0NkdXRkxKaEZzdUtB?=
 =?utf-8?B?eXpoNUNDQS9PRUJCdzZnTEpYSTZRL1JhN0prKzc2VGkyK3BNOE9HbFk4bjg3?=
 =?utf-8?B?T2trdmZubGQ5clRrRmVyKzlwS1lGZEJCY2VCbC9VUlQybFU0cWl5Qlh6alpl?=
 =?utf-8?B?OXpoMnRrUDg5YlhvaDRXYkhUZ2ppVXRUSytkM3dLaHFOREFXRWdOa2l6MVpx?=
 =?utf-8?B?eW1yZE1rMEc4c3pPY2NJMmovNHVuVkkwWTU3M1c3Rk1WcEtPWkVncFlKby9k?=
 =?utf-8?B?Y21laVVTTU9mbGpUeElHZmIzQm5vMW5hRzRSWUVFNTZVRGFROE1pZVF3bmEv?=
 =?utf-8?B?NzBMaFJYOWFodTJBaVlNaG5IdWswV0tsbzBRM0ZhdEN4QTllWFUrdEE1VUtQ?=
 =?utf-8?B?d1ErNUpXN3BlMk5OenAydlBQOWhqbGkydjV3SmZDMVRRWVVEcDBOKzZqWndF?=
 =?utf-8?B?TC9VZllBNEJjMmJnSDlzbkJiMjFqY245RURWVURzTG40RTRndzFsR2QxZHZK?=
 =?utf-8?B?dUhFMG95eFBHRE1pdE1hTnF5b0wxNUpPQ1MwZ1hxU3dsU2x1OG1vOUovb2FE?=
 =?utf-8?B?aVA0RFdLNUIwN3pUdzJkb3U3OHJOWW9BTFZURlNHSndXNEN5YXNhbWFRRERm?=
 =?utf-8?B?Q3BjdllWTUR6U0ZyTE13aEx4dDFTTjg4M1NBNDliOElZVjBxVUNGanFzYkJL?=
 =?utf-8?B?RTZNTEd6M09BdktJNnVtRXY4bXlRZXovMGEyQWFXWDRsa0MvalVZd2lxdzdU?=
 =?utf-8?B?Tko5bXVBZ1Q2NGNsMkxUK3VOZUN0Mk0wa3ZEU25uV1k0bGhmQmdqbXN3THFP?=
 =?utf-8?B?UG1zc1Zob0xmWkNyQUxQNWZXbis2NmR2S0l1TG1hYm5pTU5IQ0Vja0dHcDJV?=
 =?utf-8?B?RlhpU2VYakNsL2V5WTVxSVFpSHNoQ3dnNVlrWFhvTzFNUHFEd01CWi9BczFB?=
 =?utf-8?B?NGlMcDNEYUs5VXdkaC9mTTJ3a2lSd29JdHFZTnhmczlzUzAzMmx5VkxUVTRM?=
 =?utf-8?B?V1c4eFloRkt5aWVzcjg2bTRYTkNXZ3lUZ1JxQUxFRnMrS0g2ajl0SHZ5M0k2?=
 =?utf-8?B?aDNKOUhVYldpSlBtc1FzcGhYWkg3eThhZ0Yvam0xLzkvejVGQS80WXZJVWxt?=
 =?utf-8?B?SDgzTUFWT1lIWCsrUzlZaVRWeFNCRDByQ0pZWmxYZTdNdTNhWHpVR1VuSlpy?=
 =?utf-8?B?dWRqV2t2Tk1JMUhvZHQrN0ZkR3hRSE0yQStEdEl5bkFqM2lqN2hVM3NIRXhP?=
 =?utf-8?B?L29nUk1rcFBHSmVIYU5qSDFRUS8wSEo1N1VNZGVESzNlZTBaNXl4VVRId0xM?=
 =?utf-8?B?QlZSaGNXR1pkcFo0NnRPanI1ZkJLcmxDRVR2SWlQMXlPZXprMnFBOGJId0pj?=
 =?utf-8?B?TVpnNExOU2ZLSnFKMUdjME92SG1ISnhCczFDcFU2SnZNTXFsd3FGSGZTdkEr?=
 =?utf-8?B?aEFocUREZlZXWHAwckxWdXpxR1dmUG5hdFFFWENIQWJFYzVtMWtESnNUN3B4?=
 =?utf-8?B?SGVGZGhTTUQxVGkvL3U1dUxUSFpOemJoK09nalB0NU45R1ZCZFNFaUFWK0FN?=
 =?utf-8?B?dUpmRGJ2UnQ2blJRelQzNDJGZ21iQWJWSFRnRk5ZVWJQZW9LNjllQ2NoQ04r?=
 =?utf-8?B?MFFkNVdXQk9xT0wxd0phOUxmclBld3Y3dTZMQklzaGt2VFBaRFpZUkxqNkFP?=
 =?utf-8?Q?06IAv07mLbPZ4JrVXDeeCXqZXxxzNgEofa3gdhd0mY8A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e37a551-a634-4064-5135-08db39d0abbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 14:34:20.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbtnRkxiS4+E2zRauH/UjsYmCy/lWprK/UOmfrBLN9asgxikOxOJxXmEX2oajdo+crPG9/3VIkJ/1KCa+x/2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id



On 4/10/2023 6:18 AM, Michael S. Tsirkin wrote:
> On Sun, Apr 09, 2023 at 03:15:01AM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Friday, April 7, 2023 11:51 AM
>>
>>>> 1. A non-transitional device will expose a capability (not a feature bit, but a
>>> capability at transport level).
>>>
>>> Note that we can allow this capability in transitional devices too.
>>> This is useful since IO bar might not be enabled even if present.
>>>
>> This capability exposure makes a device transitional in some sense.
> 
> not in the sense spec uses it at the moment: transitional devices
> are those that legacy drivers can bind to. transitional drivers
> btw are those that can bind to legacy devices.
> 
> perhaps suprisingly, a transitional driver using a transitional
> device does not rely on any legacy spec at all, they will
> use the standard interfaces.
> 
> 
>>>> This capability indicates that, it supports legacy interface.
>>>> Lets name it legacy_if_emulation for sake of this discussion.
>>>> It is a two-way pci capability.
>>>> Device reports it.
>>>> And driver enables it. (Why two way and why driver needs to enable it,
>>> described later in point #d below).
>>>>
>>>> Hence, such non transitional device does not need to comply to below listed
>>> requirements #a and #b.
>>>>
>>>> a. A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
>>>> (Because hypervisor driver is a passthrough driver; and legacy driver will not
>>> accept this feature bit).
>>>
>>> This is not a device requirement at all.
>>>
>> Those this is written as driver requirement; a device expects this feature bit to be negotiated.
>> What should device implementor do? It should allow driver to not negotiate bit, right?
>>
>> Which means, below line to be change:
>>
>> from:
>> device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.
>>
>> to:
>> Non transitional device that does not have legacy interface capability MAY fail to operate further if V_1 is not accepted.
>> Non transitional device that has legacy interface capability SHOULD operate further even if V_1 is not accepted.
> 
> 
> 
> Look nothing changes with MMR capability at all.
> We currently have:
> 
> 	A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> 	if VIRTIO_F_VERSION_1 is not accepted.
> 
> it's implied that this does not refer to legacy interface.
> 
But the interface being exposes is not a legacy interface at the PCI 
device level.

A PCI device is exposing a interface that can be used
by either
a. existing non transitional driver who will negotiate _1, just fine.
or
b. by legacy driver in the guest VM, which will not negotiate _1.

And here device must not fail to operate.
Hence spec should say that it should not fail to operate.

> 
> You want to clarify this adding to legacy interface section text
> explaining that of course VIRTIO_F_VERSION_1 must not
> be offered through that? 
It will be offered because hypervisor driver is not getting involved in 
the reset flow and in read/write of the feature bits etc.

Hypervisor driver is only providing the transport channel from the guest 
vm to the device.

And since the guest driver may be 1.x, _1 will be offered by the device.

> Sure but it's a separate issue
> from MMR capability. don't try to drink the ocean.
> 
> 
> 
> 
> 
>>>> b. device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.
>>>
>>> This is optional not a requirement.
>>>
>> Please see above wording, if its acceptable.
> 
> 
> you don't need any of that for this effort, generally
> VIRTIO_F_VERSION_1 thing needs a lot of work, if you
> want to invest the time just ask I'll try to list the issues.
> 
> But nothing to do with memory mapped legacy interface
> directly.
> 
I likely dont understand your above point.
The point is, a device with new capability needs to

a. offer VERSION_1 offer, allow negotiation VERSION_1
b. allow not negotiation of VERSION_1

With single virtio device id, how to frame this in the spec?
One way I proposed above that a new transport capability indicates this.

I didnt follow your idea of how above #a and #b can be worded without 
the new capability wording.

> 
> 
>>>> c. A non-transitional device with above legacy_if_supported
>>>> capability, will allow device reset sequence, described in [1] Driver
>>>> Requirements: Device Initialization (3.1.1) [2] Legacy Interface:
>>>> Device Initialization (3.1.2)
>>>>
>>>>>> device reset sequence.
>>>>>
>>>>> what is this one?
>>>>
>>>> I listed above in #c.
>>>> And
>>>>
>>>> d. When legacy_if_emulation capability is offered and hypervisor driver
>>> enabled it, when driver perform device reset, driver will not wait for device
>>> reset to go zero.
>>>> When legacy_if_emulation capability is not enabled by (hypervisor or other
>>> say existing) driver, driver will wait for device reset to turn 0. (Following the
>>> driver requirement 2.4.2).
>>>
>>> It might not be a bad idea to enable it, but I observe that it is possible for
>>> hypervisor to expose a standard transitional device on top of this MMR
>>> capability. Thus it will not be known whether guest driver accesses legacy or
>>> modern BAR until guest runs.
>>> I propose, instead, that device exposes same registers at two addresses and
>>> executes reset correctly depending on which address it was accessed through.
>>> WDYT?
>> Yep, this the exact proposal here.
>> Legacy registers exposes via AQ (aka TVQ) or MMR location, behaves like legacy.
>> And regular registers at their location as-is.
>>
>> With that feature bit negotiation is the only thing to relax like worded above.
> 
> It's not really different from IO port legacy then.
> 
Yes, it is no different, because what is provided is just the transport, 
not a new functional behavior.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

