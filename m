Return-Path: <virtio-dev-return-14198-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F86C41535
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Dec 2023 14:33:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5B6B92AEF6
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Dec 2023 14:33:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39B0E98660D
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Dec 2023 14:33:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 214C698427C; Fri, 22 Dec 2023 14:33:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FD639865E0
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Dec 2023 14:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1703255557.364000
X-TM-MAIL-UUID: 92845b7a-f7b0-4df3-bf73-9fafe87e27a1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY/Imfetgo/qAiu/gU9yL+E1NIN3nNYbVdc0+V9Ez3szZ6+8CXjNWBRqNar2cjXIcE8wRI+bSUImmyOKyfxXd9clSPe282Atbkn1MMKE0K3nKsqOA8CvYyYxa66JdKAeGBoDXUgoczwnc3YcTgH33NgypPAzMgBzMAJD2BrteSMu61wqpe72GrQBK49eey9FBgMoWEn3HP8vRt2SKEXEpCfUl4k+iXH6Z9r/iGUn4SnzriBXr1Z4wFXGzKIfLnVAbxCiUe9CY20kjqCrOyRRAf/RdWOYZw/edv84/b3MKNOY1xJSd6Yj3hIErB+0zDUXv+tj6vY7AgywRoGgbB9EEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWiiUGcj/N5i3NFWmXYSJ0YP/RJzCDsYybGOlb1BHKw=;
 b=kOKcn7KtxMbdXvM9GDewLPOwnGuM0ZtP2zaNyjBJGSxfSmlogun3TBEOxkBdzjLROcYurff3IH9c1jwf6Vv6hh1PRXSIKSE8ydLcH77S+xa9BNqG5J/6vp8//nRqfQ7+XSOEfiGwufJcsxF8Co3Y1Wu9hoIkP1rKQBMcZEPH8jMnWfqaGok7alCY1hi2LJ1ou5LpXHI2vJ1oUZQBZ8kJfdYhW9GiieCLoE3ECx4eGD9wBbz4oTfjjsh/Vpl6c8mpdbA50uUOt0OKOJA8SeRlt0L9UqNhO1Ln+eByunHai/xOlgngA6KvKGjpiwivZLy9vrF/06bvRwZ7ZzYqmWSKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <47dd69ea-ca84-4a17-8cd4-0260e6f117a1@opensynergy.com>
Date: Fri, 22 Dec 2023 15:32:33 +0100
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com, broonie@kernel.org,
 qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
 <95dcd2c7-4b5b-4b04-8748-e9e65374d356@opensynergy.com>
 <d1f7cb96-c95f-4458-9b58-ea1e6335df55@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <d1f7cb96-c95f-4458-9b58-ea1e6335df55@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEUP281MB3414:EE_|BEXP281MB0278:EE_
X-MS-Office365-Filtering-Correlation-Id: a184b15a-e57a-4389-632a-08dc02fad712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eP9E4QHfHfWaHYl7m4EVrP0rth17OMrJmfDPmcFNLaQD42JNwnu1qnX9EZ/It9mxqXK3tCBhDjraiZGHQ3myFNZL10yuRb9weYXhUciaSX0b2V0Qw7nojsNFgVwK/4WtXGPTKnYq6VsXVF7iTQqGZtBJoh9ekYdR36/HcSmIjU+S/6GGfwbCTEIn4VG6hdYPr24Zhr6OnjcBsCs3qHxRsmg2VcJv78dmxjdK2jfCloCU5CRX5fXh3fJIhQtIkqaenF9xN09SqT9vVESOBkyWTdY/l0DRfPfXxVDnQ096cJIRQO1Wl3yHULX25ho3aEypoOmdZrl1r7s3czh0SwgNWBhFBSi4riu+7KFRdK3xnKUm6dpRBYND1Mcp70uos40v/k899t9VLNqRi3eCNDI9j2wiPaZVEOsQV8BKpPzFDHwzlesfHxMglw5rP3BU+c1loyehR6RnCGYp3b+jOYAbeAozj1S1IDcHDaQwDf8S0JmSY6vl34YaeYT98wd3bYGBhSZH82p5tHDjDrrUBXFXQUKCnjSaQBSazRGNbhlhQMkQ6EwY3zZAfJSklrwdE2NuvZUBkMDOk3LycRAf4RNqb2/ZMOaYSmbdSJDc1e6RfAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39840400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(66556008)(66476007)(316002)(66946007)(8936002)(44832011)(42186006)(8676002)(83380400001)(66574015)(478600001)(53546011)(966005)(26005)(2616005)(5660300002)(2906002)(41300700001)(36756003)(86362001)(38100700002)(31696002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZQd20wR2IycGFhNnB1bU03Z29zazJodHVBcjRXNUFQSkhNQjdGYVVuSFJv?=
 =?utf-8?B?QlAyaTJtWTF0ckdxSWhvSUc4YnZROUo0M2dQUnR0ZHorMjR1TEFTNkpXZWk5?=
 =?utf-8?B?Y0RPaE0xbGJlQ0lac3JiblkrNkpmWDVIRkdLVW5YTHZ4SlloMk8vcHBMSHl1?=
 =?utf-8?B?SURUZ0VRZkliMGdCSURWanhCQTFONStqWmdIQkRKUEVxbEVDNGo5VVp0S3hR?=
 =?utf-8?B?U2hNdWhkaVhGL3AvK2F5V01nQ2ZwWEw2QXNFUEEyelMyR21vVmRzd211TkdC?=
 =?utf-8?B?ZExVTkRwM24rd0VzUUdmaGFGaEJrRlJUdFFTa2h1MzN0TjFHdVNrTVhDd0c1?=
 =?utf-8?B?TGpoSFJ0eUVvU2ZXVjhWMEs0ZU4yclAwRVpQTTYvRmxUTDVwRHdkRTlueGYr?=
 =?utf-8?B?TzBvR1RRVG9ITXB5cm5ycVpmK1dwNGhJUWo5ZG1HcW9RejFvZjZJVkJpUTB4?=
 =?utf-8?B?N25GNS9xZkl5clRvclZLNkhiNjFPd1hWTDdmekxNYlZtaWdWR0J5NkNHY0x1?=
 =?utf-8?B?WmFrSUtIdEd0OUhBZFAxa0gyQUllcmdBUTB0WjJDeUpCS2JkQ0VmbUZsN0Q4?=
 =?utf-8?B?SW95TGJ3UU41UmNGU0k1VUdLM3VtK012Z2lDQUFubC9OcklGSDN4Y3hrcy9q?=
 =?utf-8?B?STFSbjhmREUvNDYwWnZWYnl0OEl0bFVSNzFxU2Z4bWwxWDZYdTNna1kxTUp3?=
 =?utf-8?B?V3M1Ui9taGJzcWlMMEhYUk5PVTJyU2p3Q0ptNXZNY3pHLzdGdlc3eHpVSTdP?=
 =?utf-8?B?bitPcWxiVzQ0a2pXK3RJZUJtVFR2eVA0T1hvRnZmZW9lRXRjTDJnbGV6ekVV?=
 =?utf-8?B?Zm1PQnZybURxeitmNzFHVEptMGxWTytwTUljTENIZVo2MnRFQXcwRTR3QzBU?=
 =?utf-8?B?Wit3eHpaQ0VqTVU5SEpTb0l5SCtCY1p2emQ4ODBDcHZxSlFBOENlZ0cvUzcv?=
 =?utf-8?B?R1hpWjhzZFkzeGpJUXNTdUFpamE4dVoyMXZjbVNiem1RRDZWVWNjQThhZjZs?=
 =?utf-8?B?YmxXdklNYlA4TWh6R2Zad3N6eTFZSzlGU2RJMi9BQmJhd1NXd3djd1BqMkpi?=
 =?utf-8?B?Z3ViOFgvdHUvV1dWaENuRjI5YW55ekdUaTlGL1lDc0xlTGdBMjEyMTIvVHI3?=
 =?utf-8?B?aEFEQVlnQ2pHY2xYdVYvODM3ajBxN0hyNE5ndDBzZmVqVXE2OXhIQk1RN1lj?=
 =?utf-8?B?TGJZeGdQUkxKem10cXBVSGNndkUvY2tEckg2RXJmMnJGRmJKMloxT0tta29x?=
 =?utf-8?B?eDBtVDROMUhZU2JyZmlIcWdVWHZvYzNkakhweHVQRFpnTElDZS9scUkzNUF0?=
 =?utf-8?B?TWh2ZmtEMnB0RW9RaWxXeUV1bGlpcUJVaGRUdlZUcVZ0anVpRlh2U2Zhb09Z?=
 =?utf-8?B?QnAvYWhIMmlDM2tyUzViVU82MllzWlcxYm11NEo4WjJKT3lXcEU3RHpKNVFh?=
 =?utf-8?B?QzY5UWIrTU1wbVowc05OSnp5Z0JMQlZ2a3dwa1BFZ0haeGFMZXZMM1FsZ2Ns?=
 =?utf-8?B?SkNvUmVhbElZNGRITmZadWFpTVFUUXRyREs3SlNRNG1aamdBWkJGbEQ0NzUz?=
 =?utf-8?B?VWxRUVJOMittaTI1d3RMdlc5VUdaSXhneEhJYllndWNSSGlWWlhaeFpkNEhD?=
 =?utf-8?B?VzdXelBYcEFaR1YvYXpBdHFYQlVZeDl0eHl1eXFSdlFJNnJEQ2ZOZU44VWpL?=
 =?utf-8?B?QTNrMnZKMkcrMDRhMG9xOUlpVkgxZDZSenc4NFowVWc2NHRodDAyU0lia3Y0?=
 =?utf-8?B?bllJa0pSVzh0cGc2VFNYa2JVRnc2dEVNSHM1UDFZb2h5Q2hrMXBMMmZmVDUv?=
 =?utf-8?B?QXY4OHFWMmVQQmZ4MHNJQ3BJcWVlRUZlNjRDbjVBenFHUnBmeFhEOGpZSldI?=
 =?utf-8?B?cVpRM2M1QUpYelVHVFpHNzAvYmJwdnp2U0hIeXEyc1luT2ppR2VQSzVvZ2lO?=
 =?utf-8?B?eEJndnI4akFvVUFSSE10WHhZYVVITHkwdm5aOXpkaW5EUUZnMGtZMTZpZ0xF?=
 =?utf-8?B?cFJXL0NpSGJvOUxrUncydGRpQXlxNloxSFlISDk5MTZMbnZ1dFdpVUQwM0h2?=
 =?utf-8?B?L0kwWWRaYWZ2WFJ1RzA3ZmE2QVNxSi9KaTdaQmJBUkQxK2NWRmo0SVh6THpt?=
 =?utf-8?Q?Oz9UpNgNHX4tw3cNzbDJACJh+?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a184b15a-e57a-4389-632a-08dc02fad712
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:32:35.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbqxPYmwQSMxl6NbvL9XWIsd4fgWGmMncLX1eerJ6V45uK2Vpm4Q9jxOz+MREFqNm/WBz2rXB+dlrCSXS8Bzsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB0278
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28072.007
X-TMASE-Result: 10--7.928900-4.000000
X-TMASE-MatchedRID: 9d2LtCNB3NL5ETspAEX/non73EnA6dC3lR7tN56aWVW0ErHmx4qgLDn8
	i4hypEtzQdxEaHP4Hhb/p37bJC6QmraZwakIWlZPJw66cQh/R5cHgEx+rhLN4t4ekns3Samnrby
	+M3Ff83yAK1neov09lDLuXuIeFqefi0Lxf1aMtgTgR8l2Qhmx6kTk5t0wP15pIZC9IAjIeg6IXS
	4NbHZkC/ghYeUy+/DMunSXNoeZ4xhdf6rzJtWOsIXdX8kwebu7HrCRk3lnNxEc9rEVpV2JbDasl
	HciyNgLoIsWKszqTaK3GRd/WWndxQPiej1Yuw8hsRyPbpLDg/WexJFd1f8r+0kU8FyBiYUiT8fe
	DfO7vqZKksLmAkV2MPcFgbmDHP7b4lUiLjkSKvi5kTI8BpRqctUusl/JVaRNiSZM70t4jOJz3h/
	NOzc2C6RiDxEJeVVUUELxHdB7iR8FoHYd5lrKxjxl1kIwpaZ6cnxszfxH2Ckmx8kl1Wnd+q+eCS
	MeOiOkA/lH/MvdoiYmkrgX3CciJjsAVzN+Ov/sWWiMfjYlbPtdlnTyX7ZfWGBDXAPOFGNOKZipC
	POcI2lXaTtXvQvVlQ==
X-TMASE-XGENCLOUD: ffdeabb7-465b-4139-b513-dc300a0acc72-0-0-200-0
X-TM-Deliver-Signature: 68936E4331A93B493D0A3ED868F087AB
X-TM-Addin-Auth: oqugbYrYUeNYFKjQQ28GEN93vQjkgzsVNlsh/EdRWHhvRopwVU2wFC3xa+X
	SsOAVBgPjugZqwMkUdwx4ZrKO2cegeP3TaOUF0fMChczS8p78ibvaUCaVp+6Ca+6GYeltkeSJEB
	88+bu2zywOkUp0+s/y38SpceJaXfaNhTIBVk7Zn75lEAQ5r4IlRosGAjzw+fX1HaEkXFhV7EZ6p
	24wFOO1F3X48pbGXHKgzSmccnwtjtmcWHLwbX6gHCuxkx9TeQGGmm+jEJ4S4Jy4wzMx8Pxsd7qf
	AIvPgI6L2vfR8RM=.KYbyUVVGixh1cSooYRybyVrmKm2MaFGRtmaKwkMVlKMJGyL9yFXRJVoJ+C
	J/JfyVMYtQZG+EWM+aE1O2GcLxh+XrII23Vg9xrX3yVzRuTD245oPdOoctmXA0t/rsb2K83koMk
	AM73Qexv7/7ymm63j/w2UATrCdoMgNpywIruu3EIKxVEoKo8HRZzCsajDhLmqlj47bNBKRoLxx0
	VBrqZ2kYNqRSOn6noZUF7qi2XpsksbkQ01xpN2wciL8kRvwQlbcy52CZez6wE8ghirhUBC0FGzQ
	EJElo8AJ//4Notlbxq0lEnJKCO6YAuxXT9Lqtxf6iyjRWYVF8vzkoPQcDGA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

Hello Haixu,

On 22.12.23 03:28, Haixu Cui wrote:
> Hello Harald,
>
> On 12/21/2023 7:25 PM, Harald Mommer wrote:
>> Hello,
>>
>> On 12.12.23 04:33, Haixu Cui wrote:
>>> +\field{bits_per_word_mask} is a mask indicating which values of 
>>> bits_per_word are supported.
>>> +If bit n of \field{bits_per_word_mask} is set, the bits_per_word 
>>> with value (n+1) is supported.
>>> +If all bits are not set, bits_per_word can be any value from 1 to 32.
>>
>> "If all bits are not set" is not easy to understand as it means "if 
>> no bit is set".
>>
>> You can of course specify the value 0 this way to make code more 
>> complicated.
>>
>> To make code simple, 0 would be not given this special meaning. To 
>> allow any value between 1 and 32 solely the value 0xFFFFFFFF would be 
>> allowed. Which is already possible now without this additional 
>> sentence for 0. Simply checking whether the respective bit is set in 
>> the mask and done without having to add senseless additional code to 
>> handle the special case that the mask is 0.
>>
>> Giving 0 the same meaning as 0xFFFFFFFF brings nothing except confusion.
>>
> Here I refer to the __spi_validate_bits_per_word in drivers/spi/spi.c, 
> if bits_per_word_mask of spi controller is 0, no check will be done 
> for bits_per_word parameter.
>
> Above is just the Linux mechanism, I agree with you, 0 and 0xFFFFFFFF 
> have the same meaning will cause confusion in this spec. I prefer 
> treating 0 as an invalid value because the backend must support at 
> least one bits_per_word value.
>
> How about updating as:
> For \field{bits_per_word_mask}, 0 is invalid because at least one 
> bits_per_word value should be supported.
>
> Thanks & Regards
> Haixu Cui

Interesting. I know that I had already a comment on this previously. And 
also now. But sometimes I'm wrong. And here probably in both cases but 
at least with my last comment.

  * @bits_per_word_mask: A mask indicating which values of bits_per_word are
  *    supported by the driver. Bit n indicates that a bits_per_word n+1 is
  *    suported. If set, the SPI core will reject any transfer with an
  *    unsupported bits_per_word. If not set, this value is simply ignored,
  *    and it's up to the individual driver to perform any validation.

Tried to find out why this is so in Linux. The function 
__spi_validate_bits_per_word() was introduced by commit 63ab645f4d8b. 
The member variable bits_per_word_mask in struct spi_master was already 
introduced by 543bb255a198. The new variable was introduced in a way so 
that if not set the behavior would not change for existing SPI drivers 
not (yet) setting the field. At least I deduce that looking into the 
commits. Made a lot of sense to introduce bits_per_word_mask in commit 
543bb255a198 in Linux this way to make a change without causing other 
changes everywhere. The virtio SPI specification is new, no need to be 
backwards compatible here so there is no need to have 0 there as "don't 
check" value. So your proposal to make 0 the invalid value is a good 
one. So I thought.

On the other hand: The function __spi_validate_bits_per_word() does not 
check for anything if bits_per_word_mask is 0. With 0 it does not check 
for bits_per_word > 32 and it does not check for bits_per_word being a 
power of 2. It never checks for bits_per_word > 0 but this is a 
different issue.

1.) Now I'm looking into a data sheet from Freescale

https://www.manualslib.com/manual/1376296/Freescale-Semiconductor-Mk22fn256vdc12.html?page=1053

and see that the chip can use any frame sizes from 4 to 32. Means also 
frame sizes which are not a power of 2. Nothing I've seen before but it 
exists. So the value 0 is indeed needed to allow for those values.

The chip can only support 4 to 32 bits, so with the 32 bit restriction 
in the V9 draft we would be fine.

2.) 
https://community.nxp.com/t5/S32K/How-to-send-receive-64bit-or-longer-message-using-SPI/m-p/1476343#M15986

There are Bits/frame of 8, 10, 24, 32, 40, 64 mentioned in the example. 
Not only that some of those are no power of 2 and cannot be represented 
in this bit mask not having 0 but we have also 64 bit frame size. Means 
restriction to 32 bits has also to fall to support something like this.

I looked further and found a data sheet from NXP in the internet which 
should not be there. Maximum frame size for this chip is everything 
between 8 bits and 4096-bits with some values in between excluded. As 
bits_per_word is an u8 in Linux and in the draft spec something so 
strange like this could not be supported by virtio spi nor in Linux.

=> The normal case for the majority of people is 8, 16 and maybe also 32 
bit SPI.

=> The strange case is non power of 2 values which cannot be represented 
in the mask not allowing 0. The V9 draft spec is perfect for this.

=> Another strange case is big frame sizes > 32 bit.

The sentence in draft V7 (on which I moaned, sorry for this) was most 
probably the perfect one: "If not set, there is no limitation for 
bits_per_word."

Regards
Harald



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

