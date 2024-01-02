Return-Path: <virtio-dev-return-14208-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A19C47074
	for <virtio-dev@archiver.kernel.org>; Tue,  2 Jan 2024 14:10:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 66EB6157EE1
	for <virtio-dev@archiver.kernel.org>; Tue,  2 Jan 2024 14:10:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A9C79864A4
	for <virtio-dev@archiver.kernel.org>; Tue,  2 Jan 2024 14:10:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 48C479863E0; Tue,  2 Jan 2024 14:10:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36ED79863DF
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Jan 2024 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1704204617.133000
X-TM-MAIL-UUID: 704db785-6dae-4dab-aa74-244970c7f4ff
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQZTwxKqajKaF0AX4/lYQUqd/GEi7jT67FDJ/tP1KYHGM/ut2Tu+bCkg6efzQKyypqUYiyA/X7Cbp2VU0u6aJZ52wPp/Axwj6AxIeYujLQE0OJajXL3nJIhTlJ5VEPfhZ/VSf6dkO5szI3GVJjJYP7kcDG2uSOEzrEQqMm8nUUXPuOuQwhQQF2UPWZ/LjkoQOYBT9Ap7d+osdiwb/GsmrnMM+iz5l9ABiEEyTbvoSaHXIVCZpCZo7qmwe3WDddku2tQt5dHOwFKDwWuFpaT479EDY+u2JFv3/I9OPG25aJzysqFQRzs+xMwerJwuY5g8MdC/CFKqbOLToug9/6XtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMzauhOOcHq4c7xZgOJttX7b1RquMyLZOK5XT63pz1w=;
 b=JKQ6TcMacRLN5lVGcMUnWwJPeTK79Ge4oDOhHY+dVfqCUdb4Uw8eD0mzklplfywl1eFAIwiJDGK9w6U45LwGm6RdP4nyKOmQSgFys2V861gN44ZkRcbIEoXTaqoUkWELfEFI/IqjARgL71HIPSX6B5QyVKEaNx/nF5bPAHNcDXSxQNmZ4VjkkWd2Thvs4uZcPjIT/rtFoIKWLCGfOTb5jxL13ZTciuoG7/oBE9+kPCbsth7L7xnPXWYlmIdvRwx3Po1VDrFJDss14JktfwRO4KICKbSlWUGQbg3LzKheCEZ7vOywMHPIViELe/qO9KB3bb7C3wi+Juj+5nEja6nboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <47c07655-ac98-449f-b284-851f8393d980@opensynergy.com>
Date: Tue, 2 Jan 2024 15:10:14 +0100
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com, broonie@kernel.org,
 qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
 <95dcd2c7-4b5b-4b04-8748-e9e65374d356@opensynergy.com>
 <d1f7cb96-c95f-4458-9b58-ea1e6335df55@quicinc.com>
 <47dd69ea-ca84-4a17-8cd4-0260e6f117a1@opensynergy.com>
 <0e8c5a22-ba7e-47db-9f72-f385d8f6d8bb@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <0e8c5a22-ba7e-47db-9f72-f385d8f6d8bb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEUP281MB3414:EE_|FR3P281MB2541:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a9019c-4f3b-4de2-6c36-08dc0b9c8b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vH5u2JBRDYQd1RZSVhZ2lUjNVOp/EU9yJXEuwhx/w7oDsptGXkH+8QfNpaXdvFdHWKJ1cDsXJMLlYb5P3jfLQXy/3S4toK6Ff3HxqQc5+jOSasMwwWEwOkHUjEf0G8FKWpy7P51fdlDojRgQaWhMkvPXCPBcpNAKzxZWoEkpvdBkMLVkqB/T7E6wKhmSwwQaWYKQXmadfUWfSNw0iI7OvLIZwtkp2HdMd216Jwitfh2SHqOs10Kk1Bxr69pq53T3eFqhOl28gWE5NPcZGV3FFDAuDkaSeaEy68o2nGDwU7xdQEQuDE35UxsdzX/cJPapjeJLm+CmaXnlpuSKTh5TePQMn17y29LjpkOeFSKVsCYVWw1J09K78uIfONoev4COW4ZaxTqqbSb5goZNuY8YrgrNiTj4cbuf1DWxG4mjrYcv1dq1oDOD8+b6iLO7iYCvfz53kH1b0mUtheyDDCAK6hhhDMLU8uVo4XefMrLGkThg7AOxm3rwUZxoxA5yj0LOuH5fFx0EBOjbd8BZxl1q6LqS9wCqR51XahYezhxPMkd6lVGykdNIs6UgRctO5VF8qYEqzMq4xdtBZLWNwVdhkKcLJSt4AOae5Z2TrC/AzS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(41300700001)(2616005)(83380400001)(38100700002)(8676002)(8936002)(316002)(42186006)(5660300002)(4326008)(2906002)(478600001)(44832011)(66556008)(66476007)(66946007)(31696002)(86362001)(36756003)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2xsQktocVFSNHBzeFVISm9aUnFrQ0NaMEJqYUpzZkpGelJVUEYyN1k5YXo2?=
 =?utf-8?B?SHFHakNnYjhPejYxMG5XRDVkRzVVaHF2VDJGRE9QaDBQeHRLOFU2UWYzeWJQ?=
 =?utf-8?B?ZlZrait1ZzNZYk9ZRjYvb3RMcUNzeTA3TER6NWVQV1JkMUVhVU5KYmNxSi9v?=
 =?utf-8?B?aTk4czlqc0JsNXNsZUd2djM4UEU5VjFKTlRMRndtNjB0a3ZJNnc5QXo1WDZm?=
 =?utf-8?B?dnBOK0xGLzlGT0dpM1Z0REpyNnhXZVZ0MmhUS3k1SW9hd3FINnIrL3dGTzEz?=
 =?utf-8?B?aEV0eGdnQVNYSkpnY20vQ0NPZG5NSjJ3Nktyb05RT1Q3SjFwSWxIbXN0WGwz?=
 =?utf-8?B?KzNweVduQ2V3T1lzY1Ayd0QvQW1ZU20vK0lNV0FkNmZnR0haT0dZL0YvRzNE?=
 =?utf-8?B?VktJRHhEUE1uMnd5Wm9idzN2UWU4Qm1Nb1JPdUIwRkt5am5TYklHMWtIUXVF?=
 =?utf-8?B?VEk3VmVkMG03aUZ0Rncwb250TDMwa2V0OGFSazdFOEtjUy8xQ0UwdGZuMEp3?=
 =?utf-8?B?OGZLc3g3ZVZ5QkNGNUN4Y3pzQW9iNHVlQTkxcmNCOU9QRHYwbmlvelJkWExw?=
 =?utf-8?B?QkZISER4Tm9GUzIrTE1WKy9iU1BYS0pYNkFKdk9IeUt5bHVTRmlkQ2FYOGNB?=
 =?utf-8?B?WHh5VjBDYldVM2lYMDdUVVA4aDVVb1lucDgwUmdRcElHWVY5MTJrK0pudUx3?=
 =?utf-8?B?aVBMMXR1R2tNZHEySDhOK2xmZ05ucEZjUGVVR3pWendmQTJIUE90eldDL3pI?=
 =?utf-8?B?NXBwZTJiK2ZHOXV3Z0J1MTN2d1VQd08wWFBuV2dLSEwxalRSKytMWTgzUmp3?=
 =?utf-8?B?Q2pMZVZWUlFBZ2hhQktISGlTYVQvYnNkOTBRenBGekpoN2NvSlZEbnkrbTVq?=
 =?utf-8?B?dUdOTFh3SjRVRFA4bVByR3hCbXlFL29ZSmt1RVZPMldjSFl5YXloSEtEbGdv?=
 =?utf-8?B?NFp4b2J5bWdLTUcxamVtWTZJRGRRaVVtZHFKeTZkbk5OMTFOOHpVN081YWJE?=
 =?utf-8?B?NHBMd3M5TzVzUjh0UUpZVkdVZ3NwektRa2oxcDBaRFQrbFNGWjRXc2tkM0Er?=
 =?utf-8?B?Q3BOSzNYWTVFeXZUaHFVemdLNzJ1ZVlCTUFlTUxxUGZjZkFVUlRhOUNGamI0?=
 =?utf-8?B?eG5TRnlMb3NhNXpTUnRhWDFIb2hSTVNUUjN5NzAvL3BYSTJwOHVPQXE4eWVz?=
 =?utf-8?B?ZlZPcWNRQzY0aEdwRzdlY2xQWjV4WDN4UC9SUUZoOFgwTmRoVUpIWkNjdC9I?=
 =?utf-8?B?UTNFWDNrUW9ycU11YzRJS2RIL1BXa1Z5c2RVS3hBK2VzbmFHM3R6WHRHRXBP?=
 =?utf-8?B?Nkl6M2tpTldSZ3d5VWMvVGwwZE1aWG1QYjkzQS9LTDQ3aTFMWnNaMFlET0w4?=
 =?utf-8?B?OG1pcmRnWHBtWW5UMjJYallYZEpjNkk2MVdhd0N5TzFmZktpVzM0amREUjZ1?=
 =?utf-8?B?N3l6WWFVLzE1Nmw2eGhudGZQb3ZncEZWWU1QOGF3WXVENTRBUDNaZjgrMmdm?=
 =?utf-8?B?dU1RVk8zZ2FHNTZTRkZOeENybFNGVGNuaFBhVjBZMkhMNmZDMG04bzR2Z1Fv?=
 =?utf-8?B?bGpGa2FoQmRNVFdBY3R1K0hEbXh0STIzejVDL0F5bklJaDVXOXZYWkFFc0Ja?=
 =?utf-8?B?clpzTUN2a3V4SituVis5VENiaFVVcVdWMCs1SWRoRzRVSkhGTm04d2VNNEwv?=
 =?utf-8?B?SHV6Y09icE16RUFoUFNmUzl3MXlwOFlWampsakNFNXQ5cm13RXRkYUgreG9t?=
 =?utf-8?B?UDZvd2xvWHZUU1B3K1JVSGlkTHBETXdZSG9zNzVYdXRoelNmUmNIdHpxWEgz?=
 =?utf-8?B?SUdjVDF5YzU2bFBKMVlpYnE3UXdRRWgyN25pRzEyVkszdlMrUms1NnIwLzd4?=
 =?utf-8?B?RG5vQkloTG53VGlJZUNua0FFd0ZYNllXd1RpeFBaRGptbnNWNVJKMjdHVHpK?=
 =?utf-8?B?dVRZMWtpRlVjRkgzd0drK2JpZTlCcVQ1RjdHZGJxSzlOVVV4VDdHWXNGcXVG?=
 =?utf-8?B?MzR4aWdVL2VHakpWeVFJMU1KOWVHWUtaOEs5bTdnSU5UWHZiWnQ5M0NCMVR2?=
 =?utf-8?B?VmU5ekZRQ1p3T0VoSWJlRkZvUDZyMU9CeWUyS21pWlBtNk9nVkRGNE5LNlh5?=
 =?utf-8?Q?dMpa4bcIXbJSlLghpHvSzEtpE?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a9019c-4f3b-4de2-6c36-08dc0b9c8b4c
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:10:16.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXSW39o4di7trCHBM/WyryMyWVaTreMhrFE1OTArkPMbSvO/KxPaMcwImlvjZKqwkpQpgTXNvVhEyN6ScssZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2541
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28094.006
X-TMASE-Result: 10--3.280900-4.000000
X-TMASE-MatchedRID: 9zTThWtzImv5ETspAEX/non73EnA6dC3bU+XbFYs1xL1Rudqy9AHLXPe
	H807NzYLa6aN6AApqWh3ctDbGLJrCePXzq8/z8gYWucEZobOeTTuB3lKociGMnh+ftTmtv26E46
	NqJbAqp6ctWrv2Sn1qdd5Oj9bqlfx4H9G9Zea4+HFTQGAKRxj5No+48giqZwnEgg3cwDHl/1qdl
	V1LmbEfGwZG2qI2OBsmuMpo5XKw2858Sarp97J825FeHtsUoHutc1p9a2+u3Gy7vqsA4HX9Bs7t
	GQzoy2lLFhgA+Dt0hJLhb8xGEnVfg==
X-TMASE-XGENCLOUD: dd3e97f4-fc47-44c4-a7d2-8eae0bd5245e-0-0-200-0
X-TM-Deliver-Signature: FECFA441C54C49564EC88A9403468E7C
X-TM-Addin-Auth: 7t101rPpOzlUY47y01tFY2Si9nuHqATtzNeho+gQ1ViJ5yBpSCejQwGvoo5
	iO6i5fZbtw0mXNbeFlig3aFX5xJEdtPJjuNuzEcuSMSAZ+NbPuk1dqpmFBgtDgtp0vMHC6hvc/w
	KcwIbjNWCJSIfJGShK8ZkHQOYbNS3JpWZR5OHtj7f80gXZBS+/NKiA7x3dcGnWw08V6UoeJaZWv
	dwz01bvQj2MTE1M29iUhjRUSKXSIkAt0cex7WWmXmh+WQjwTmRSfSD6i6Zf2SrH/OXpXrI4SXe5
	mqpvnUBQhMnNM2E=.Ru5f22B0kzqNiBq4ZjFAInuORoTJxy7Sc9R0hva/F+3Sk+oNndXnDctpDN
	o9OnM2IRvtfzGKK/m0VKJrdvOWIKnwot2BB+cUvjEX+k25KqGVzGJXfuMxg0QQ9XvHwVODcPcFW
	hMqIq7JMOITfHG40Dr/xv4aGMy9TvzQENYcwhaWSiAJWuRW8IfD2u4IgX6I0ZHAmzSDnb5lRazw
	H/nez06RoDMaekH2GWE47DebdV5ELp3Z9N6+naGVcRdXCPhNhJeBIFsIOdxqRohQWm0d+EP+wyK
	JlwehWbEARON2i76iev7JCAZd0YVRyvXKdjZYQoXDnQ8J37pxF8/Y37OATg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

Hello Haixu,
>
> There are such strange usage scenarios that frame size exceeds 32 
> bits, even 4096 bits. For these strange cases, It's impossible to use 
> only 32 bits bits_per_word_mask to enumerate all the conditions. Seems 
> that a similar situation exists in Linux spi driver also.
>
> Assume a case where the spi controller supports the frame size to be 
> any value from 16 to 64, 32 bits mask can only cover the 16 ~ 32 
> conditions.
>
> Even so, it's not a good idea to expand the bits_per_word_mask, 32 
> bits can cover most of the cases, except for some situations that are 
> not commonly used. Besides, it's hard to determine the bit width to 
> cover all the cases, and expanding will make the logic more 
> complicated. To summarize, I think the following statement is probably 
> proper:
>
> "\field{bits_per_word_mask} is a mask indicating which values of
> bits_per_word are supported. If bit n of \field{bits_per_word_mask} is 
> set, the bits_per_word with value (n+1) is supported. If 
> \field{bits_per_word_mask} is 0, there is no limitation for 
> bits_per_word."
>
> Do you think it is acceptable and appropriate?

Perfect.

Currently in the middle (almost done) of updating my software to draft V10.

Regards
Harald Mommer



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

