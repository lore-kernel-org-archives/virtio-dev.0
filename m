Return-Path: <virtio-dev-return-11937-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9BFC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:08:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 029922A8DE
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:08:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF98B986400
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:08:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E241A9843C6; Mon,  3 Apr 2023 22:08:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CED759863E4;
	Mon,  3 Apr 2023 22:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdfQ5xVTVoeisUfnm+4dNxPTrFtNLzJE4HUJPyLlOQ06wM9Olju3I3RxH0uuZuwb5Sb+/7dFZJM1Duejg+POu4rJgii2tt5L2tIupsb4BKn3C4LqG99BOQjQHbn+ianpxDOuBBEYKoN3RZ76O+o4Gqr6uSihoX1fPacJkl5GUWYMNgFObFYiJfHPl9h/3K5mBnbOT6aVIqlZa0KqUqZPcg49RBHQWlAAuDJsdwKTTOgZdha8Mgoi9UWqIItK03VrlV6vZfJ38rEDVtsPF2EVPmx1NfCenUoB84qQ1HjWx/wX44KD57H2PgYt6QtFF5q0I6bEkTJVI+HmfZDGhDi8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OcvN7GHUmnWSDLUBmx30xE8BGgosujVok/FOe8mvJo=;
 b=nNXyAjMLj6TEhnAlc5SLGwGrTlR6A6BqO0IS+6p6kiI4c3gfqtQlBUJeKx7KZRCO4uxzHVgQWte7h+Q+qAhuUTibKR2TDiOYYluuEbPocHsL4ZfOAki7mGOGaQSY9kwRttB8Mx/IghCSNI08TTO5An1qMVsiDck3LC7Dbjy1DWdFyr3HyPot+uMqM5j2kFBaNqYM9el0la1G3rarC0geEvjZcPYsUpkQX6NiNKsFDEHxBEl2tt1Fd/B68Dk13KvoDj8Ab8K6DIBKZvqUi7ni0mdWQKU+SlLZYMy+HFDyz2F1TnguQwuUmCL7gPIJuwEvyi2JoF7w9os4TTwJfKdAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <f5736275-d974-5cda-31a0-62a7f7f67711@nvidia.com>
Date: Mon, 3 Apr 2023 18:08:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403134407-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F46C61C499621DB5563DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403155310-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FCD5F8C57821B14FF360DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403170525-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230403170525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b504278-d34e-4ef2-7911-08db348ffc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZYSl4VFcKclTnSX04f8C8TiVShcBcy+OdlC/X0p11pFD/8KWO9n+yZ1MVWPzOgrAy/B77W/0NL66Dw16ov3q+hhjmQTkV1qsALa1Yyf4byOPXqp6lXulkvA5+v/kvIG1q1BKLB8Ne3aFrJd/GAHC00HMYXuU3n0a2XM8gtR9MW0nS5ijurZYSvhMYt74d2GGT91bQKkoNWo6f2Hrl0eO4wWK09ZkS1MjakXp/L6ER0tx7yIgRddMyd82CnrGKTElZvq32zw4yag65Is2LJvx9S5QFjv4XYx7UK1A48wtk9e+cl/h+QjVKmKcnzJI9bvtX2jYoiSx2/iBYJsE/0rl97qz7RwJlVgvPUoij+n+c4SAPw25g/GG5EhuwEoTHSZxF9emMO5XljYYknLarkdMnSMh1WTXqn6gUEq7NoGYDHtDfh7Q6gzakOPkJOphuSiHu0CvrtQYuh8YvmeffHocWaKqdTQuKckJEt3EyYHSPmtmcYERsXBC/SgPTjSxKSRsAphKhZmhgBC0f9nCT6SeICcE1g0/ygGhz4Ep5Jl3t/mghdLXWqqiIdDYFBZQJfwZfkwD0MjRO2hzNFEX44jJqBvVmdrjqBJZ4xqO3DjC/AoeJyFTXZjUfNRCbFleDMO3pxpCM2TMorj3Q/9HRdTBQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(86362001)(31696002)(36756003)(2906002)(31686004)(2616005)(53546011)(6486002)(186003)(83380400001)(26005)(6506007)(107886003)(6512007)(4326008)(8676002)(66476007)(316002)(478600001)(66556008)(66946007)(6916009)(41300700001)(38100700002)(5660300002)(8936002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9oWExiRm5vdzJUM0R6andpc3p4TFFNMCtmM09mbHYxU2J6OFkzZWxxUzFq?=
 =?utf-8?B?aTF2RnFlcVU2d0J6bnQ4cS9JeXY4UnU0aDdmb21yRUNUSFgyVGZ2ZVNXaXQ2?=
 =?utf-8?B?WlZ0LzFLSlhmenlTb0x3K0orZGw5ekVxNG13dVgvWmpWS1RMYWgwTEdyZWFo?=
 =?utf-8?B?Z0ZpWCtzVTc1Rjc3b1NGWDZ1Y1pGaVFFZGNXdEFJWmNoblZYNGRMYktHYzd3?=
 =?utf-8?B?aGNJMDY1TkNWd0VYMlRkVnVkbVlURCs3MXhOeWhzNFFlTFEvRkJDNzRXZWo3?=
 =?utf-8?B?c2N3Mmxremx2ZDFRbG1Qd25ITjUyd1BlYjVEMks2Szc4RHRvWTcyVkVXdkdm?=
 =?utf-8?B?Y2wxMWY1NVlJZ1htTFFzK092ZlA4ejZNTHI2azR5ejNjcnRvQlFTSmhPbE1C?=
 =?utf-8?B?bWR6UzRYRE51T2kvYkFpdGhXaEtSTnpMZmJ4YWhWSjhWTzVTa2JOOEJxK241?=
 =?utf-8?B?YVR3SFl6NTc2TVBWRmpNSksxdlJmcFlNZU0rNkFRdE5vWXprRzB5amkxaDJ6?=
 =?utf-8?B?Si9qdktXdTFKWUUxZldCMk9Ua0NKM0h6OUU2bkdET29DQjZPSllpMXpZMVc4?=
 =?utf-8?B?ckV3bjVWSGNwTzNmUnBYZHp3TXJPa0p4TVlTbmtVV1p4TzU2UjVvdlFLRVh5?=
 =?utf-8?B?UVRjRFR4dExyNWdxb2JRRWZQcjQ5QitiV2wrdE56K2Vsc2w0eDhLMnF4R2lo?=
 =?utf-8?B?MGlneGRHUlJjY0tEZUJ2OXZZMDR1cnRTZTFac0Z3dTVCcURuY3VUTCtqaXBz?=
 =?utf-8?B?UTYyZERWVUQ1ZFcvS0l6SGxVNmJJTWtpYkZWRXZITUFqNjY2Q3lleXZVNUcr?=
 =?utf-8?B?NjZZVm1rQTVpMmIrUlFFVmR3OFd1RE90eVdzSTBwdzE5UnlhUUVJVlFuUStW?=
 =?utf-8?B?Z3dEN0xuT2pCa01DQlhIbm51Z2RTMWs4QWdSdjFobFBaVStTUnJ4a29GbmZt?=
 =?utf-8?B?T0o4dHVYL0doS1crNitGeFpmNjJheE4yVFRyNW9aalV0Yk9WaVp2N3d1Y05i?=
 =?utf-8?B?STg5SG9Pb0JET2dKcDdDMHdqNlIrckhlWTNqbGtuVjg4SEk3NXF5Tmw4MDha?=
 =?utf-8?B?TDFBME1xeXp4U2JmTE94V0FGeEtidHNHUkFIWlFEN2luT01IanhVc0V5UFJo?=
 =?utf-8?B?QnlUeEpoR3lJZllqRy85NWc0cTRVZ1VjcEVER25hOVI2WXoxam9aMUVrZlVS?=
 =?utf-8?B?b3AvQnI4N2tYbW1hdDVkU0xpWDhVZDE3ZklNOG9BKzdxQklJbUd3ZlZvaUdG?=
 =?utf-8?B?aFhkb0Nwa1JLS3lBbk03YlpqVlJML3ZBT2dhK3RPVHd5UjVjMTZmSk1jdWcx?=
 =?utf-8?B?REsrVGJ5VXB2RWlMY3hiMEF0NTNmU3VSMENHSVJiSTRjMFAyQ3FHSzBtb0JC?=
 =?utf-8?B?cDhwMVRrMGhWbHhuNFhxTlZhbnp1cUM4aFJEV3Q5TnFrSmw5UEI5RjdtSXk0?=
 =?utf-8?B?a0xMWk4xZmxnRENqdWZBSnZMY2tjamhkV25vdTR4SldnY2FiamxPYjVhTXJN?=
 =?utf-8?B?UGh5amRoN1hHOHdTN0h2WVcrUXF2OFByOUxPUzVNRVZnWVY3WThJSXB5ekgy?=
 =?utf-8?B?b095bW1xb3E0NHg1QXhEYUFsMWZZcDZiL3hnSFUvUTY2ZlQwK0RyWEdSWkdX?=
 =?utf-8?B?Y3hpcUpWeE9RVjIvM0pEZGNGZmpDdjZ5Q0pOOWltYnV4SklUQjNTYUc4aXg4?=
 =?utf-8?B?My91Z1NBRUZGZTJTL1Jzai92bkFYYWNqQ0ZCbmsxenlFWHV6b2wzck14bjg1?=
 =?utf-8?B?RTlXUFlacVAxZis1MmtRZS9nZkFiZnlSbFhzYUZOZS9ybktldmJ3bHlXbWNy?=
 =?utf-8?B?WTN4MUFEWjhzS0oyWlBVeXdoVkh1L2hnaFNtNjUwN1p2aWpvOEtUdWViRVNT?=
 =?utf-8?B?UDNWOWY0UzZpb3NRZkR3cXNhcTF3dVQ3NzkvZWlFUmlwVUI1MmNDWWFRWE1a?=
 =?utf-8?B?dHJ4N2J2OEcrWCtQV21HWlJEcm8zWVZvMVlKc1BwSVd2c3Q3MjBSbUhjUm5Q?=
 =?utf-8?B?djJoRVJ6ZGRTMUpPVDlFZ2x0MFVrQzJRM1VYYkN5dzA3L0V5SXdBLzhNQXBr?=
 =?utf-8?B?WXBLZld2ZUNmeCtrZjQ3MzFWbklaMkxVYXIweGFKU0EzamJXSW1PcHA5VFFh?=
 =?utf-8?Q?G3pdtUsWFEVe4UbUd5R0u5odO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b504278-d34e-4ef2-7911-08db348ffc48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:08:42.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7BV5A/RX1Olr774MwGI3Q9WcMDM/+uJJEspOOhO8O4T8HFXZxkQwX4kUkOscyPgWS+ffXCrwKHSgqL+uNx1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device



On 4/3/2023 5:14 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 03, 2023 at 08:42:52PM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, April 3, 2023 4:03 PM
>>>
>>> On Mon, Apr 03, 2023 at 07:48:56PM +0000, Parav Pandit wrote:
>>>>> OK but supporting them with a passthrough driver such as vfio does
>>>>> not seem that important.
>>>> Not sure on what basis you assert it.
>>>> I clarified in the cover letter that these are the user level requirements to
>>> support transitional and non-transitional devices both via single vfio subsystem.
>>>
>>> And what is so wrong with vdpa?  Really I don't see how the virtio spec needs to
>>> accomodate specific partitioning between linux modules, be it vdpa or vfio.
>>> Way beyond the scope of the driver.
>>>
>> vdpa has its own value.
>>
>> Here requirements are different as listed so let's focus on it.
> 
> I'm not sure how convincing that is. Yes simpler software is good,
> it's nice to have, but it's not such a hard requirement to use vfio
> when vdpa is there. And again, the cost is reduced robustness.
> 
It is not hard requirement to use vdpa or vfio one way or either.

vdpa users can use vdpa.
vfio users can use vfio.

>>> But anyway, my main
>>> point is about DMA. On the one hand you are asking for a VQ based
>>> management interface because it saves money. On the other you are saying
>>> DMA operations take extremely long to the point where they are unusable in
>>> the boot sequence.
>>
>> I think you missed the point I described few emails back.
>> The legacy registers are subset of the 1.x registers, so a device that implements existing 1.x registers, they get legacy registers for free.
>> Hence, there is no _real_ saving.
> 
> First not 100%.  E.g. MAC is writeable so that's a R/W register as
> opposed to RO.  But generally, why implement 1.0 registers at all? Do it
> all in transport vq.
> 
1.x non transitional VFs and SIOV devices will use their own 
register_transport_vq once that infrastructure is in place to access its 
registers. Such VQ is directly accessible in the guest VM without 
hypervisor intervention.

It is orthogonal to this use case (and such future VQ still works with 
this design).

In this approach a hypervisor needs to use PF's AQ because the VF device 
(its registers, features etc) is not owned by the hypervisor VF driver.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

