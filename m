Return-Path: <virtio-dev-return-12211-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6618BC77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 17:24:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B355829FC6
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 17:24:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B01A8986629
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 17:24:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A2B9698660F; Thu, 13 Apr 2023 17:24:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F8839865FF;
	Thu, 13 Apr 2023 17:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnQsuskJbLSL6u+Zbn0LOsASb+Hl02FU7zViJZ7YW3XyAsH4Jo3VFy9dtkZequsq3U6+LvMNAsBdayRsWwoe8rMhpi/g0TWZtY18DUGlzcjczsQITTABT2FsT5p5VCOEOzje5RqzF5uiL2epc/wXj/agIWM0cvkBEPLvf36P3e5supdtsbedeWtNfwup1z6Uj/jyi7Fzphad56TC+iwx0dlQSEmIwMY5VCiiCs7YTM0uAUyF/pl4nUNd+5QsvEtwh/ysggSRQ9Lu8iJnrLsLcaVuIWtCj3u3a/smRqZzeALHXXpQgViyIlh5a/0JdO1rr9XRHYY8/n+kegKp03qHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvbZur/Ly2e/rz15T6rXt/O9H8L3cYRJzu/PZqewLZU=;
 b=bEvqkZt2m5sRMDmo/AxfCsCe5WJ1BAncDpzFz24OmzMBJUC2mdCdCTgoLzojmxnGJomj+fi9PV1oenB06V/txpYCAzHz12DaRHOXg1JAASxC9sdgZ8J2ojl2jLaEasKLJ8EHPPfIM45ey48/Et8xdvcBP1Qp2pjg9STcQt1BX2rF1bP2lAizAe8Em+W9HEATj932r8P6vvb58Xsm0qNEqkiosvYNcFkWuvE6ub9b7aUV/l9afAJL+ShpK+6bX1Np7++MT+waSlgWW+OtKMl+19KfHNzEkz5iRgU3a4L/5HUzZuxPRV+ijV12ssov7FeekLtvhfyqMUcKh8nFO2J4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
Date: Thu, 13 Apr 2023 13:24:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 81894453-4bff-4778-4172-08db3c43eecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tMg+2eEdOZe7xt3aOa5LJRZx11GvUlHle7tCG3+Y8I85VBaNFrnDi4f2syaMn4GgU6jH76uYdi2Ce0DkiJ52kJWkr2ZIhLV2HL2wECZlXlKXCiPCq7UqenDrKzO2xn9SRYzORCE8OzUMBRnRFvGGlhlDBKzhJVzHgz4FfRwiY5hC9WOU3rNMCnhDvt/Sfiub6NpL5l6OBrA9npQgfNJ3fwfeazVUD0KDwfdypfD7cg1f9teAnw7yTQOW5M15VIV8aXE2x62UefsOQEwqqeL4V8VU/lb5WgHl/XTX0a7bVh9cv63+MSJs8dIle3LW7p/C1gjb2XLlolBHRCndNN7UH2ETuTHlkg10la+q1Bba3Mbo9B//VgBUtZcaiNtcy+VKoPyhdlSs6jGo5szWmau1GJSPpaqmnIiyaz/FEh2Uy23RfD7sDptutUk805vQ+6BsNGAs+ajAZB0KBBLW5+oNInMRH3CfNZcbAfXf4ScDLJxY/1psfbpO4jkmBdiK9FJMdiTon//c3AvnWwYT8dYA8VLGDLaazX630AyoFo4c/rOpjyfMMPTTje8yB0gckrYqvS7ei9MFfY+vu4YyXnA5QOGTcBhY9yjvKatMp1iW9csAMjaragkRiEj9C+s1ryDlilyUWV0bRQqQ+vbMRsEUrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(478600001)(53546011)(6506007)(26005)(186003)(316002)(6512007)(66476007)(2906002)(66946007)(54906003)(6666004)(41300700001)(6486002)(5660300002)(4326008)(8936002)(66556008)(8676002)(6916009)(38100700002)(31696002)(83380400001)(86362001)(36756003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFmZVBiU0s2b0VKQVNJcjV5TjJFY2kxL2hkRCtmeEpjb0dSb004WGlFV2FK?=
 =?utf-8?B?VE8yTkxpS3U0WXJyMkErbWpsczFocms5SStFWnNhZ2Ixdkl4cTJ1eEg0STRm?=
 =?utf-8?B?bFR3Sy9Ick5WTWQrODJoVnR3ZUVxM2tDRkNyTngzTUlpUDlkR0lOYjUyb1pw?=
 =?utf-8?B?RjVCMlY2YW5OOVRGTER5RlRCQStsZG9nREl0RkQ1Mm9BYTd3OFNYMEpWNDBB?=
 =?utf-8?B?Y2NzTEpxWFpJM1dIdkorbUZ5Y0p6VkliR3gveGl3QnovanFlYVJ6SnRNTC83?=
 =?utf-8?B?NTdnbGgrU1lRRW5QTGhnZ1VJS1hodCtaYk5wK3hDRTJQSjY1WVgrSnNtM1pN?=
 =?utf-8?B?TU5abnlEQmpZM0xrU1RoSVFxNU1neUNmNzRJWlFPeGVyNmo0VmtxNm4xYWpI?=
 =?utf-8?B?czJ1VC8wY213d0VpRjhQc0syT216SUxoZzhzT3RscFhTc3NOZVJCNXRXR05p?=
 =?utf-8?B?YU1TWGF0U0ZDczlsMUVRMWdrK2E2ZkI1VndlZkRwQk1sem9EWk1JZG5zYnBr?=
 =?utf-8?B?Zk5IMlRvVTNPZFJtZEh0MHllUVJLb3B2ajB2cjNod3ZXNWlIbzBpeE9nUDR2?=
 =?utf-8?B?dDBmWTJQRCtWNVhoR0l4NmRRK01YdlJIVUFxWDJRV0dPZ3hFdUFOOFRIK05J?=
 =?utf-8?B?bTJ2eERxZW8wNEVmZkZwdGpZY0ZxNmUxSThNbzZxdWpYckZpOUVibnpkMlZM?=
 =?utf-8?B?TWRUcVlEMHdwNks1VC8wR3plaTR6VFZ1NDREdHBkdFpua1RLSGtpd0duY0dM?=
 =?utf-8?B?bmhnODdubnA5SmZqaTdtT0MxNUlxZCswdXBkTHd5aEtUNnVVNVorTllWNW8w?=
 =?utf-8?B?WGUydGU1NVVnVWxLc3UxY0NzU3gzRWxjM1RROFdCekNiak95cXRCWXlqOHQz?=
 =?utf-8?B?RnB2ay9JS2xncVlYczZMTUJoNDQvSFBwc21WaHdpMWczZ2ZxQUJSMExzaHFu?=
 =?utf-8?B?MU5BWFFoY1RlaDY5NEtNSzRiUEdoQkczSmNZRkcrMEVDZWcxWGRTTVN6NFJW?=
 =?utf-8?B?ZGp3OHhEcWJRYlR4V1MyQnBNVWRHMElCQW5LOGFvdlVSblJjb2FPTEQzaDBx?=
 =?utf-8?B?Yi9UNjZIT1plWWJpeERyRW9IM3RxUDc2K28zcHBrQnc1K2tHZ1kwQVhkcEF0?=
 =?utf-8?B?VmNDMnovcmFjVURmTzlaOUhyVDlkV05QSk1QaDA1QTdsWUMwcjdMdVlUOEJQ?=
 =?utf-8?B?OTI1WUdnWXJYQSt4Q01PUlRHdVJXRWtFN1MvankweDgxbmZXNCtDNlFleGZx?=
 =?utf-8?B?TE1zYU5mTFVBTkpmWWJtVEpYdlBSUnBtRU5mTm5hYTJUOFJ3SnFtQ254TDdJ?=
 =?utf-8?B?ZE5TcEYxM3BLT0xZYlpZM0dncnQ1SzAxdDliQ1dVRHBCa1kyWDVHMW9OWFJV?=
 =?utf-8?B?cTY5dGdaVnBzTVltNks0MkEwTFBUek05aE1MWHJRdUdYOThsZS8xM29ySlRS?=
 =?utf-8?B?WWIrS25obzk3dkZGNnBaQjBlSEJSNmhBRG04TW0rQkRIV3dDWTg2MWNhLzl4?=
 =?utf-8?B?d3l1MmllQ0lXTlBHa0hhV1lvd25VNEd1aXRqd2l3M3NPM0VTM0xFeTRTZ1B3?=
 =?utf-8?B?dGZmckRBU2hyYktRaGN0empwMHoxdzBFNSswV0FYTmE2MmtTZ0Rjek8rNWU3?=
 =?utf-8?B?OVpHcDZVS25ZRisxek5tOUxpdnloUEk4YUx6L3BobSs4UnZGL21PaW5NTmNs?=
 =?utf-8?B?WDg4UzdEYnY4Ryt0aUtLVkNoNUhuNzExU1FFbERlaUhwUmV5WTk4cEo2Rk5x?=
 =?utf-8?B?aXBzb1FyREs0TjE5RHl5dzFIcmFubTlHNVhHY1VGWnZLWEdEWEw3NnV5SFNn?=
 =?utf-8?B?TUMxWEYyakYyVktJbDhPSDh0ZmZuOVJGQXhxMDFFSzZSWXI4TVhuV0Qrem9B?=
 =?utf-8?B?MXdXRWpkaS9xQ084ZFdPa2l1aVV1WGMxeVkrQTU0NXgvbVdoVXVsNVVRcXYr?=
 =?utf-8?B?VlBMUHZlaitmdlNLVVZrSVNCaHFUbVFxU0pCQnp0d2FhSCtSSXZPVmtyUEdO?=
 =?utf-8?B?YmJyQW9CZUlWSmNVZXBMTlpyZXpKZnRuVGZacThFdjBSNC9zcjV5R21OczlZ?=
 =?utf-8?B?U2gyUWpXcXU2TzFoUksxdFh6NGVwNTB0eDdydGdQYm1SclF5SlN5SEczU0NZ?=
 =?utf-8?Q?WjsNtvqig98qmaYs1xoJCyOSR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81894453-4bff-4778-4172-08db3c43eecd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:24:27.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuuBwz55j7ublvE/WRoqQQgOw1xIJpLt0IdAuQhGfqZx0bfSd4IUMs7I2XeGI2sT6xKkqddPgD0PgZHIwXKoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers



On 4/13/2023 1:14 AM, Jason Wang wrote:

>> For LM BAR length and number should be same between two PCI VFs. But its
>> orthogonal to this point. Such checks will be done anyway.
> 
> Quoted the wrong sections, I think it should be:
> 
> "
> length MAY include padding, or fields unused by the driver, or future
> extensions. Note: For example, a future device might present a large
> structure size of several MBytes. As current devices never utilize
> structures larger than 4KBytes in size, driver MAY limit the mapped
> structure size to e.g. 4KBytes (thus ignoring parts of structure after
> the first 4KBytes) to allow forward compatibility with such devices
> without loss of functionality and without wasting resources.
> "
yes. This is the one.

> If it's a transitional device but not placed at BAR0, it might have
> side effects for Linux drivers which assumes BAR0 for legacy.
> 
True. Transitional can be at BAR0.

> I don't see how easy it could be a non transitional device:
> 
> "
> Devices or drivers with no legacy compatibility are referred to as
> non-transitional devices and drivers, respectively.
> "
Michael has suggested rewording of the text.
It is anyway new text so lets park it aside for now.
It is mostly tweaking the text.

> 
>> device can expose this optional capability and its attached MMIO region.
>>
>> Spec changes are similar to #2.
>>> - non trivial spec changes which ends up of the tricky cases that
>>> tries to workaround legacy to fit for a hardware implementation
>>> - work only for the case of virtualization with the help of
>>> meditation, can't work for bare metal
>> For bare-metal PFs usually thin hypervisors are used that does very
>> minimal setup. But I agree that bare-metal is relatively less important.
> 
> This is not what I understand. I know several vendors that are using
> virtio devices for bare metal.
> 
I was saying the case for legacy bare metal is less of a problem because 
PCIe does not limit functionality, perf is still limited due to IOBAR.

>>
>>> - only work for some specific archs without SVQ
>>>
>> That is the legacy limitation that we don't worry about.
>>
>>> 2) allow BAR0 to be MMIO for transitional device
>>>
>>> Pros:
>>> - very minor change for the spec
>> Spec changes wise they are similar to #1.
> 
> This is different since the changes for this are trivial.
> 
>>> - work for virtualization (and it work even without dedicated
>>> mediation for some setups)
>> I am not aware where can it work without mediation. Do you know any
>> specific kernel version where it actually works?
> 
> E.g current Linux driver did:
> 
> rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> 
> It doesn't differ from I/O with memory. It means if you had a
> "transitional" device with legacy MMIO BAR0, it just works.
> 

Thanks to the abstract PCI API in Linux.

>>> - work for bare metal for some setups (without mediation)
>>> Cons:
>>> - only work for some specific archs without SVQ
>>> - BAR0 is required
>>>
>> Both are not limitation as they are mainly coming from the legacy side
>> of things.
>>
>>> 3) modern device mediation for legacy
>>>
>>> Pros:
>>> - no changes in the spec
>>> Cons:
>>> - require mediation layer in order to work in bare metal
>>> - require datapath mediation like SVQ to work for virtualization
>>>
>> Spec change is still require for net and blk because modern device do
>> not understand legacy, even with mediation layer.
> 
> That's fine and easy since we work on top of modern devices.
> 
>> FEATURE_1, RW cap via CVQ which is not really owned by the hypervisor.
> 
> Hypervisors can trap if they wish.
> 
Trapping non legacy accessing for 1.x doesn't make sense.

>> A guest may be legacy or non legacy, so mediation shouldn't be always done.
> 
> Yes, so mediation can work only if we found it's a legacy driver.
> 
Mediation will be done only for legacy accesses without cvq, rest will 
go as-is without any cvq and other mediation.

>>
>>> Compared to method 2) the only advantages of method 1) is the
>>> flexibility of BAR0 but it has too many disadvantages. If we only care
>>> about virtualization, modern devices are sufficient. Then why bother
>>> for that?
>>
>> So that a single stack which doesn't always have the knowledge of which
>> driver version is running is guest can utilize it. Otherwise 1.x also
>> end up doing mediation when guest driver = 1.x and device = transitional
>> PCI VF.
> 
> I don't see how this can be solved in your proposal.
> 
This proposal only traps the legacy accesses and doesnt require other 
giant framework.

I think we can make the BAR0 work for transitional with spec change and 
with optional notification region.
I am evaluating further.

>>
>> so (1) and (2) both are equivalent, one is more flexible, if you know
>> more valid cases where BAR0 as MMIO can work as_is, such option is open.
> 
> As said in previous threads, this has been used by several vendors for years.
> 
> E.g I have a handy transitional hardware virtio device that has:
> 
>          Region 0: Memory at f5ff0000 (64-bit, prefetchable) [size=8K]
>          Region 2: Memory at f5fe0000 (64-bit, prefetchable) [size=4K]
>          Region 4: Memory at f5800000 (64-bit, prefetchable) [size=4M]
> 
> And:
> 
>          Capabilities: [64] Vendor Specific Information: VirtIO: CommonCfg
>                  BAR=0 offset=00000888 size=00000078
>          Capabilities: [74] Vendor Specific Information: VirtIO: Notify
>                  BAR=0 offset=00001800 size=00000020 multiplier=00000000
>          Capabilities: [88] Vendor Specific Information: VirtIO: ISR
>                  BAR=0 offset=00000820 size=00000020
>          Capabilities: [98] Vendor Specific Information: VirtIO: DeviceCfg
>                  BAR=0 offset=00000840 size=00000020
> 
>>
>> We can draft the spec that MMIO BAR SHOULD be exposes in BAR0.
>>
Yes, above one.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

