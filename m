Return-Path: <virtio-dev-return-14046-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CBC4332F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Nov 2023 18:37:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC7CB2A835
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Nov 2023 18:37:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 806AE986CB0
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Nov 2023 18:37:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59DBB986CAB; Wed,  8 Nov 2023 18:37:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49508986CAC
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Nov 2023 18:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1699468641.053000
X-TM-MAIL-UUID: ec4e90c5-ec92-4d13-84d5-53fd1c03a333
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTofLBVAiT4jiKaS2NMxWTf4PF7HFx6159lXD3kf1HTWAdUFlxihgcfxkhxMZIWJ1Px8gKMSENEnRQS8G3mv86lDeAGVrDRJRspohN4WL1ce3Mifb89h6M8JQ69sin4J8wS5d9gN8qGS8SdxV/DFG2Ad//nQ1TCtp7m7d9PFlYtf/7qQifKYS03GlFmv79wkd5tmg0N4Oh5zNQf/dA2lTf+oO84jfbPrnUNtelRinP4uIrAr7915C0EFnhay7VWoGTYmsSfMG2N9ikSI9MDMBJADckjbqYUVHZxkh/JQvcLLPul+bH8X9hok1u4rC/8u/1/jqhGMFxGw3OLp7bGwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seybNV6AgblQmR5oLT4HC2gMbS5YOQ9EO7EkbEFKce0=;
 b=OPJeC/a1P+3c7dT+6Xii2aqMSMVV/FEqbYh0eX+EMZEy5GUU8UgFAmj8cMbtg/bDvn9fsO3lQ9+eokd5hIVFrM2GnIzXxAsvyysXYsbIHM32Cot4fQBQrXD4BZ/0FSSMxbWix/8+2ikVD3EeO4G9cHstqGcknj9pha7VO6Wmsf/zERYyWE2GHGOA0yTw+legWfxVURiPM/IBf/pVhCdTXvIiDvWoa5FJW1w54S3zO7YVaD7Uma/hCD7CuJdtrBADBB428Bu/KAdaYaTckO+Y1mQ/0Yh0nXpYiS9nP7vkWS5mPfqWhJCG7gaOOVYcuIqByvtfq1czfJ1YO/QN8eyaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <59a014d3-5027-4a5c-836c-3a433dfad994@opensynergy.com>
Date: Wed, 8 Nov 2023 19:37:18 +0100
To: Mark Brown <broonie@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 cohuck@redhat.com, quic_ztu@quicinc.com
References: <20231024125346.23546-1-quic_haixcui@quicinc.com>
 <ZUjrDjHpFVReDSgk@finisterre.sirena.org.uk>
 <c08f1b37-51e8-4126-9e1c-40530f468df4@quicinc.com>
 <ZUuxfbkSboAFQIQF@finisterre.sirena.org.uk>
Content-Language: en-US
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <ZUuxfbkSboAFQIQF@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|FR2P281MB3375:EE_
X-MS-Office365-Filtering-Correlation-Id: b912f233-cf8a-439d-d063-08dbe089bd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CqS3ojD3VgzWe10TMeT3AoiIaHu9jgNjg8mHgCUqclvBlBjzOf3wuLr+ZmIxRAR/RwF949v49wlveijV5P0YYeuwx/ME9t4M3oC1mLSVLyPeP5v0MHu8OHQ9PaPQtXHoT/KdlHJlyQTMD8nmvoi0mmm8SdMMhMC73ZBTjMKcx5CjFvPIHI55D1ZzxcVBrvdTmELGGQTvsVjH2oxZ6iTiRVK4GHQWwVi+9I057G2mZ5pwQoHn3VPjiKRljsRxBAPUp5zvkHTGQ4cCZEBpYBGwkrB6sW34ykc8eOa9ErGN0sVGFUW7V2XERVGhqopOrRnS36zBl7vzBCUdq1LMQLUe4ZWTgiGAXYvKc6Ewgq6bxQkgoUoRyu6P+/KTyohXsvo3aK0rfRjcQLYe9gHL3eTOAi4+hyOFR9d2ummv6sMJ8Xfqz50ojsae3KHEIlOMRL4zUbtiATNzlanPpM8U71P8GN+P/4ymZuMZbed27GXqDHMClYngmbo6GSCtEkoALOxYVZzR8J5ukaaBu8JAlfcJOOaoXngmfhe+ohPquhz13aY/ghnGDMQXrviTf2b9hoZnV2eSazg+m7vVpQFoXhhe4VXlrLXVReztPNcyZ4iCqmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39830400003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(44832011)(41300700001)(86362001)(31696002)(5660300002)(66946007)(2906002)(66476007)(66556008)(316002)(110136005)(8676002)(8936002)(4326008)(36756003)(42186006)(478600001)(2616005)(53546011)(38100700002)(83380400001)(31686004)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RitVS0djYVJTR2llWHNGVmlCMkt1SkpkeVlIUTBzb2R3ZmVSR3J3V09kUzdF?=
 =?utf-8?B?dlQwbzNQU1ZSWEpHdStKSDYwVldhamVKT1dBK1JqeC9kcVltSUQwNmdYWERj?=
 =?utf-8?B?ZnprR1JmK2lWclA0SWtCaUFxT0R1QlZuOXBsMWZmMTBkMjR5UFl6cCtkNFp1?=
 =?utf-8?B?dzRPL2R4bVp2ZU1IUWdHckhrY0pnRnJqUHFqdzU1WWd1d04rbmd0Mi9CbHMy?=
 =?utf-8?B?K0tDUnhWc0JpYjNpNGdXUG81QWo3T05WREJIYTd2MlZLSFZXeTZLeWo2UjdM?=
 =?utf-8?B?TzQ2MUpqVEpCRmoxVHQvUnd1RnJuMDJRNmVib25BU2hoU3ZNdk53anJVeEJ6?=
 =?utf-8?B?eUtjUHorTElRYmVId0pmWTlzMU1jNlFuTjFBaG4yMU0xL2VhZ0tQaC92eFRQ?=
 =?utf-8?B?aExXUi8rOHFiTHdraTlQbDhQN0Q1U05IZ1VhY042RTV5eGNoREhBWTFvUXlX?=
 =?utf-8?B?SkkrRk1HMGllL1YyZlVjK0JTb0JBVXhmYzBiVnNheEhKV21yOEtSOWl6Qmpo?=
 =?utf-8?B?QzIzeWJ2TCt1ZzBXVHpWNXpQcEVyckdMb2ZYUE9KTjZESDhJU01QeERaeGRQ?=
 =?utf-8?B?Znh2VFl3V1FQdjNtbFZwU3FaZ2laaUpFd3RIT1NHQ1RQYnU1Zzdmd2xhNUc1?=
 =?utf-8?B?ckh6OTk2ak1ZS2ROelZyTit5c0cvTk90T1VMZ0FCZUU2VEswMk8yaThFd0VS?=
 =?utf-8?B?cGJhK1BqemdsVmp0ZDZKRmVydkplKzVZbmdlc01ndDZaemNYNEtEZGxoWlpi?=
 =?utf-8?B?NWtjU2szVDVYY21GNW1aNlhsZ2ZocmlPUVF2OFF5eFN2cG91WTZmN3hDU2tV?=
 =?utf-8?B?TDZNZDlyRE9hRkEyMHVwTGVpZzZ0SEdJUTJMemJHYlZyMzJnczFTbWdaN0la?=
 =?utf-8?B?TFIvSVhvVnVEMTRFSHNOZnBNVjdja1h4VnZWVFNuRVd3aTUrYVhkY0g5ejRX?=
 =?utf-8?B?bFdaSXRleVgveENYQzdYZE1iamMySVNBVDVzaUNSd1BOVDZSUmZaUnJVYXdz?=
 =?utf-8?B?SjJGczBUalo4blNuUGhtMFo5a2NNSzA4c09TV05FVjQ4allvcFJZS1RscG1x?=
 =?utf-8?B?bU1UcGg3VlhDVWJ5QkdwZVhtWmVuUHdETEpBNWhMR01LWktLSmZuQlo2ZzdZ?=
 =?utf-8?B?anhtUkhMM0llUEs2djFSdVJ1THVqWkxReURPR2FsNW1tbW1JSWZnUmw5RTNI?=
 =?utf-8?B?UjZ0V2laMHoyL0FNRzc0QTRwWHhUS0RySDJCQkkxeVUzUFFaV25RWlJwbTIv?=
 =?utf-8?B?cE84cnZvV1JvT1JhM3phZXBpWU1xdStRMmFPNDJmQjNTajRiWndkendNYXlT?=
 =?utf-8?B?anU4cE5tcTl0MlNTTThTYmRVbWRzemVQRHZpM25tUTJGdHNnTkhheitrTFFu?=
 =?utf-8?B?djB5T1RxSkUxL1J6UGRnTHBCVmNrNEZLM1dQRWEvRE8rcWNyV1JLMmhEbTcy?=
 =?utf-8?B?K2w1UHI1MWRSZFhEUFpJUWMxSlY2dm1GSGdqd1F1NGNsSVR2TjJCOVVRTE45?=
 =?utf-8?B?REVHOTE2SGNZL0V2a2hZUTlBRUF3cW5IOHpPRm5lWTAvdmhzVG9CSThJMkFR?=
 =?utf-8?B?ejhkenl1OFhtYTliMmUveUR1Y3ZUbTZzNzlJOXUvTDZjbi8xWUx5eEdNT0lx?=
 =?utf-8?B?cHlMcHE3MTdvN1JpRzVWQXZraTM5VGVTWFRFU0xOZFN6TWNXcW1OWE14S2xQ?=
 =?utf-8?B?WkM1cFJnTDF5ckV5dGVVVUtyQmtyS0xpQVdjZ0J5am00Q0tOZkVvUGN0TmYz?=
 =?utf-8?B?d1Fnc1JJcTZ2ZDdZWmZLVXNrZWQ3enRKUCswOXRzT1hwZmMvaW8rV2pCdVJk?=
 =?utf-8?B?VjlZVVlkZVk2V1lRQ3hNcFE0T0xJMng2RjdCUk4zeVRXaEV5MC85WlVFQ05V?=
 =?utf-8?B?eVkxTjhCU01oSFlLZVJqbTZhdytVd25FU2hSTDRCZzRnOXZaRmhLOUhjZUs2?=
 =?utf-8?B?YU1aNitjUEIzaTdvOEpTQ0RoZmNQbjg2VFVNcXVsaEsyNDIwM0ZZcForUEhp?=
 =?utf-8?B?WXNScDlNZ2w5N2JZTzZKSmkwY2QvVThmNmlydFdGTEQ4TnNhOVRMdTZPV29n?=
 =?utf-8?B?OExFUmRuS1RLNy91NHpuaTVjMW5LOS9HUExBZVY5Ty9aQVdMcDM3dkxsR0t3?=
 =?utf-8?Q?zlrAODWKc7cu0k7DF9kvld5EY?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b912f233-cf8a-439d-d063-08dbe089bd87
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 18:37:19.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWr5vdn91FEjPzSpWTZzdONV4fxO5mzXY3KTmFyWPOr+AbRrUogXux03wkk0wMPiFAlaIL3qrrIXU1EFYpNG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB3375
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27986.001
X-TMASE-Result: 10--1.838400-4.000000
X-TMASE-MatchedRID: L8tZF6zWW2r5ETspAEX/non73EnA6dC3lR7tN56aWVW0sdSrJZyyxuEj
	oSIzkyAfmFXyOSJV59cJKnveCf4VKUUYpGrxdWcJRYNhzuZZjRDyQ6dAmPdzEid215hBfPs441j
	+2o0U8UFlO3VzrWrwQBqLh06qdvlxNlZlVlqsTSQKKqGMl1rHbDdF+uIxstnWYll6E/wPyC/jEt
	1EiGuYH1znfwhOc7kT3JNhpEek5UX/vMMOhcmhDTvQG0xdFpDCcnxszfxH2Ckmx8kl1Wnd+q+eC
	SMeOiOkrlXFGRYMxXC59u66wM4v4jTMjv56Jlnw98LoxdSuPzOUbZ46ZsZ1f4rKwnKf3vNUGQE3
	kpRzZ/ShZyGOQxGUMw==
X-TMASE-XGENCLOUD: 21017da3-bdb8-4c0f-8675-aa60e02ac6d9-0-0-200-0
X-TM-Deliver-Signature: 00421642DD7E36AB63BB37B5B2C524FD
X-TM-Addin-Auth: F39QHoRxIgZpsQGG800XxUQuGpSMwqzQW+9Zicxqbz060xkHWZM+m/v3fLE
	IOjSy2mwjtWor+FusIKorE93O5NIaLUi94giJQgOsKUmnxZ7XBDjWvghwy6S1885jIiVjbzuYqj
	cMcYGsPRt/wb0KLKzRlEicm13UWm64DLfx9M3e1+ThxRvfXRXrs1V7XrAzl/CzjjDeI/vH5MSAg
	O7jTlPvB/SU/+b6fdTh5IFUoSmYbtmo5HC6o/uJ6xxNzQsjEddaB3SQJEtzEsdy6INiPcdoMWRF
	WhKTDIPzgzr/TZ4=.PK/OiTcG+YVI8m55L/WtlYmvqF2WCHqiRYSlPtyfoue1jcW/ZkzJg4y8wt
	ivxteSLnyU1Az1hgthvC9lsr8iASW6koJNjhG6fn/xOUkdoeGyuCdV4HQDg9H0FOJOUStfQ0Vg8
	UIzwmYpbXMYgCQINHazpqTgFO22UXrxncbWJyk9g5SUkjlOE40njtWrX5qkQLLjnaXXzffPtU6O
	DzL0kSKjrrSVim2C5BEa/yjkwWvCOEta/kO0z9faJdwoZkHE+NEDB12h0uKm4bD706t4yuyfKAv
	++TCDohXgnWh5CN7gcaElaS3LqM9XpGknoLbQkPLIDfkt3MyUtK/R2kaSig==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] [PATCH v4] virtio-spi: add the device specification

On 08.11.23 17:04, Mark Brown wrote:
> On Wed, Nov 08, 2023 at 11:42:40PM +0800, Haixu Cui wrote:
>> On 11/6/2023 9:33 PM, Mark Brown wrote:
>>> On Tue, Oct 24, 2023 at 08:53:46PM +0800, Haixu Cui wrote:
>>>> +	le16 bus_num;
>>>> +	le16 chip_select_max_number;
>>> That's a *lot* of potential buses and chip selects...
>> Here you mean the types of bus_num and chip_select_max_number are "le16"?
>> Here I use 16 bits because bus_num and num_chipselect in spi_controller
>> structure are both 16 bits.
> Yeah, I think that's more for padding/alignment reasons than anything
> else.  TBH I wondered if just going for a standard int might be better,
> it's the combination of picking a smaller type but one that's relatively
> large for the domain.

We cannot use int at interfaces between device and driver in the virtio 
world:

- "int" is machine dependent, sizeof may be 2, 4 or 8.

- It is signed which would be new for the virtio specification. Not done 
for other devices.

- How are signs represented? 2s complement? Strange machines do not use 
2s complement. Good is that most of those strange machines have still 
tubes and are by now obsolete.

- The endianess is machine dependent and device and driver may use 
internally a different native byte ordering. Strange but this is imaginable.

le16 is a well defined unsigned type with sizeof 2 bytes and endianess 
defined as "little endian".

> What byte ordering are the multi-byte words in - CPU native or a
> particular endianness (eg, wire native)?

Virtio uses little endian. (Some data structures in the RPMB device use 
big endian. But this is an exception and there this was done for a good 
reason.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

