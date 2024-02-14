Return-Path: <virtio-dev-return-14310-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3984C4829F
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 06:11:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 255F73357C
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 06:11:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15063986642
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 06:11:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F009A986651; Wed, 14 Feb 2024 06:11:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB5AD98658F
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 06:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1707891061.386000
X-TM-MAIL-UUID: 2577d5f7-a037-48f0-a756-71cf24fa9115
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj0J0c699diyzlPkbCx7t1VKv3xllWA5LFg4JLzIl4oRac4fqokKNOojRaTONZ/yRiQ/e+1lB88lLuJ/tz55jhVL9wCDzzH/hSv6Lo+JYZ6Y134FpWR3LwomhMXcdEdThl8Rmu+yqlEdf7XSJEY5GUQJ7/KWMLTTsQpS2rMgi/DbcYavMHNgHowf77Xey2E91mnivanybh8sLC501MoTMef46/WWapdO7z1RYuciLfuJAuJYiioi6WYM8r7t9mLrVQW0/xLi3DWrtBe4wl0AMPD0QPb85XiNdHN81srOv8ZEeMIejnuyPMJhJwtBqIiO2G+ntzAhtdVx/KcrITgpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3u9IcG1cbzdsWfsfAqu6W/QJdbZhVtTBdVx0Woj3TM=;
 b=aJm2rQnvjUDqzhRkByCSuM27JdnhDARTFf4N6K9v8nEZoB2gZl8oKvMQhLUoa1JbsPXg+Z7s1AdbOvCW5h/5enZ8NyDiVR/bmx/PgRnxgXw4Aax6sYkNhvbM/c5CJMbE0WFzrrqmkxPQn1ApQMM7Vdy+QoG8UqV5o6AWBpMwpVdIGLwz518mhQJsEnw+HUVmVnrUn33KLYxXP1AB5qGDyWLCg+mvQGZGsHoFqYptaUchRTBqveHjZzPOr3U8tStgsNxR7ULg+QzEGTzMU+ONzxp2Qk9HSWXjObqgSL47Hpul21u6hznUE5qILoihpGe9k+5HYBMuAGaW2S9deU96Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <719bcf1b-c9f8-41e9-9ee0-4f8b63148c2e@opensynergy.com>
Date: Wed, 14 Feb 2024 15:10:53 +0900
To: "Pape, Andreas (ADITG/ESS3)" <apape@de.adit-jv.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <10d461c112924dce8f29215359889b7b@de.adit-jv.com>
Content-Language: en-US
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <10d461c112924dce8f29215359889b7b@de.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::9) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|BEZP281MB3314:EE_
X-MS-Office365-Filtering-Correlation-Id: e398e028-348e-4478-767b-08dc2d23b6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u1Bj4OiSlUHPqN1b2WRvTV+PDvz+ichlNMtIwcCeonNeC3GQ5+RoyVJfmrQgbLRRqiuvdsUdx4Jtz+/MhQOMvza/Fz+iiu4/Nh2oHKmWUb8ehcj/h8nBqx8waDGMLR7Oyx7jPk43SWQO4r25rfcVDMrikz7Z24FlHLnmFZPUnRfvQW4grJmeRM26MFJiVWlmLd5GqBbIpVDaDKoEHVI5A6e36N3f3sInfpY6Es+MGUSaanu8X+xVd541DqP9d2BYF1xCqqw82FTyBiUujNERmYeBtXXffOaj8nC9VSejSzxVIES+MQTqhZvz6J/iX4J04lxB7+6Xik9wnwIm3rmX/Hb53NMEeAx6PBMiBn5zwmnwTmPYN7wkQT+Xpj2C7DhbzAqE3DCGmxQG/syUoKBORH4RwzWbJN7tuVJAYSxEUVVXYadayExAEFOEksoHoX7snCnidnxBj+6cvPlnRuxTyUWbeOvAE14/o5c7gCNVqyJ4f9fXmGmprzsgxiSdIa0AWST1cYJ41/BVv6zTt9ecPEuukDnnnpDRPy+CCPZ2lh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(396003)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(44832011)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(83380400001)(26005)(36756003)(31696002)(86362001)(38100700002)(110136005)(42186006)(316002)(2616005)(41300700001)(53546011)(478600001)(966005)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXgvci9vNkw5YkxkODVFOHNPZnRZZFVUeXAzcnV4aUN6M3RLWW1ITDlGOURK?=
 =?utf-8?B?Qm81K2drOGNzUkRIam9RMGpBd2tyZGs3NjV2dm5nVXVYM2F0UTZ2RXp0cVl5?=
 =?utf-8?B?bnZITlkzNGNwc2xDTnYvTlhrZXY0emtrdkM1NzFCNFFCSjlGVmd0by9CSmVz?=
 =?utf-8?B?emcrYldoc1Mxay9lU1I0WmZQRkFxRFk3MDY1YTdNU2tlMm82YnlCekRoaVcv?=
 =?utf-8?B?WFB0MExydm4rMS8vM2ZrZTlOVlErSEc4cFZrR0owK1pCWkR0cy9kTXIzd3Y5?=
 =?utf-8?B?eVE4QkZYa3ZCUWtFOUVLc0ZuODR5WGV1M0hUTGQ3YlVnLzMxVkkva3V6WkQz?=
 =?utf-8?B?S0tLZVdjY2E5akxlYmhJUFpvU2tkVVRhR0tNWENBazljeCtqRzFobXgxdW5Y?=
 =?utf-8?B?Zko2MC9Wb0lyQWtVaklNN0liVW42M0lqbncrbXp5anJrNEZDSlBjMmFNbnIx?=
 =?utf-8?B?YndQYVVmZEVGeEMwcVFpUnFHWUFPVk5EQXZFQ3JlWi9pSDA2QWRZQkdDUFh2?=
 =?utf-8?B?NElqb01pTERQaTgwZ0NQNTNGVHNBbnQ3UlJaMXEycnUvd2d6NExCekdIcHdQ?=
 =?utf-8?B?TzgwcXkwZzZTSCtOS1BhNThRbkhtQXJ4b3dkcmh2NmNacHJIdFRobFdRcHVE?=
 =?utf-8?B?OXlRTEZEKzljN2liWkRVTGdKeVNKOExpVGYzanB4M3hxbk1GQnlyQU9mM0ta?=
 =?utf-8?B?UGpBRmN2SzlSZ3QvZkNibERFZVU0SERBbUFrN1hIWWRiRUNjT2hlMlhSUEJi?=
 =?utf-8?B?K3JlcTZ1RTFMcFVoOUkrMWd2RTMwU291Z2tuKy9hQjI3aEhHcGRiUzlEWVRF?=
 =?utf-8?B?RldxWjFXODFsVm9mVm10RFpUeVBURUdaMU02RE5TNzU5UEVpbk1xSGVwN1Mz?=
 =?utf-8?B?OURFNUtiSDFObDQ3cWFvc1ZVR1orVDhHd1pHZUZEbUtYbjdibW11TG9QclNH?=
 =?utf-8?B?di9RSk85UWxlWDlBWFVwSExXTGFOTzQ2MGgzRUJsR0lSU1ZZTEttV20vNlNP?=
 =?utf-8?B?TytreVVPVm5UYnI3dGNxK3g2amZWWGpKU04zb0NsZFcwUHFSSktsSWRhZ1px?=
 =?utf-8?B?QmV5ZmNOTmRqMGxtVUhUOWFSdVhhOGEwWHJyUGZhWEE4UnEzUkErRGtIOXlG?=
 =?utf-8?B?aHNTV0FaUmhRcmEwZDdIT1dFaU52Y2hMeHZHYWQ3dDNTc0Z0LzVzTmU2M0Vx?=
 =?utf-8?B?N25LbDlvLzFZM2QyWmpDTUJaT2dGdGJVbGV0VVMydzVZTnVZZTVXeFFORDJx?=
 =?utf-8?B?WFpKcTQ0T3hTVVUrREp2MjV4RUIycGtpRHlpa1JzOGJ5Q1JaekZMN25HSldD?=
 =?utf-8?B?S0M0SUxXR0JjQ25YdXdFMURaSTF5SGthQ1ZaNnV5TGt0cllSazkxZFpWUTlQ?=
 =?utf-8?B?UnpNcHEwSldnUTlRbnJIbnVWVEZ1Q2hzanlIMGdwaW0rdkdpcVYwc1JHdlBl?=
 =?utf-8?B?L1JvOENnT2hMWjZlbyt3OTMzMXVTY1NoNWJKM0R1bndHQkw5VXNTUXZXZEpO?=
 =?utf-8?B?dldRd3Z6WnpRVkhXM09BK3M1R21xZ2J2RlJONmtPREhPRUtERlVaV3ZDc3ds?=
 =?utf-8?B?OW5FdmROQmpjajUxOTNhdXQ3Z3l6ZTB1ZEtVZ3lBK2xqdVlWQlRGYkhyN01P?=
 =?utf-8?B?a1VMOHJCbm44dFgrZjdvZnpJa0RvR051V1lHZVpKNFYvQXk5WVpKQWdtbXA2?=
 =?utf-8?B?WGVvSlVzQTJnY0RIYVBmTHkzYS81bXpYMFFEc1hjckNRQ0lRbG56ZXJ1ZjF2?=
 =?utf-8?B?UWQ5ZE5UNEMzQWRzYnRZTlgwTXJRNko5bGFCUS9LK3pOeGNFU2M3a3NhZzJz?=
 =?utf-8?B?OE5DZU9CWm5PWDl5WXl4U2hiZ1BobXRGTW55eWNDb0lKWXJOYUVXN1h3dGdD?=
 =?utf-8?B?T0RtTytmbFZBQXh3dE43MTYySTIvWmk0bG9OREJmVEtobHJmeHVhMm84NjRS?=
 =?utf-8?B?REN0VjRlTk9YZWdUOHJCMDB5aDlWODRrdWRncUF1YTdtT3A0eElBbkViVFZz?=
 =?utf-8?B?bWlEMk9hTUY3R2o1TURjejFQOW5HVytXWnpOUEl5a2c2RkprV3BSbWpMTzhr?=
 =?utf-8?B?NVlRemsvWVR5dUd2cjIxWmRJTjg0MFhFN2FLdXdYejdUb0dzeDlHU1F6WDcr?=
 =?utf-8?Q?1+9w5A5L3Ny+qMV/CiaNomv6z?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e398e028-348e-4478-767b-08dc2d23b6ff
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:10:59.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehb8vlVQkZvL7qw6ql9Io4y3kPZaT60T8HyPNGNffk4vIRHO7e50yUa8Nd/ZtTX8GzAmw7eFlxAeE+eU+JDmhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3314
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.005
X-TMASE-Result: 10-0.943700-4.000000
X-TMASE-MatchedRID: L8tZF6zWW2r5ETspAEX/no1zC1714+2r+HAk4j3F9/QrwvLze83KAtXY
	nKy9ZqbGmI/0/NGaiq4hhkkpcqdLQKjHzroBTUY9EUw76ALZYKnn0oaU6WM++wLbwVZWOSEXi8+
	IGr+Jb3Uyk/Hw4XN9jXssQCGeO/cu9voYj3h+ww0xnH4RfI1qpYMCjAmtzjFdFt1H7vV0s3GdMO
	a2Y9QGjN9cNTZyIRQyldYeoo7G9XguMVb+BG18JBEuOqgkm3/1mVEKSAFs7pe4ssz2NHTRNYjH0
	WPW40cmZM3jbOBadQ058Sarp97J825FeHtsUoHuwxNoImnh6c1sv8872FKJaRsQxDNKnqXJCze0
	ha/pah4fwV6sBPR0lg==
X-TMASE-XGENCLOUD: 8725b267-6848-41cd-a44d-18b7195b8bf3-5-0-200-0
X-TM-Deliver-Signature: 00549780683D57C7A49F61B45B695724
X-TM-Addin-Auth: hvvjzFkzC1NPrXPCYI/tBO16sRpppRWLb80XSl1x6K871PHV7sr9szyL+aO
	ni/ySbb41zHO+ymg8e5O1KIUhVnlg16Px3pkojU1E0E35QhgjnWKPpruvD+/P58WUVlb3Kwhm5k
	d273kpUXCoaUaSJyvSjhl2AUnMJ6NzY5MQ1Iiv9xyX1FtJXxbXXCnFNbvCvyAEYriObuAFCQRoK
	cEJy8Uw1cZpopibl9u92WxoTyMTbER2yS49yxV8XpWmE48WBpgR4z8tf6F8Ln8B02/nM4aR9Tm5
	1C2HI8k3vFBvQsQ=.nt02IcZKPHRT1Unr2Kjp84zIB0IaAe4R8BrqDGOJNkj9S0RVUvxuMu0TV/
	/p5+ukadAV7VWEs4+RIq9I+POvbSPepy+GawBLR3LYHTqhIPw55PPFM0cbcKlsy9Y9QFxLmiyd1
	2gn0bX8CaCDy9sLMb4IPHPzHwcV0tHV1W2m9UWDaSNhz2yBQv0NEvnrZyLfSwMWQG2xz4wXE782
	IwaPbOyU/BABuhpVd5jsZYAmWLUeLEioMN8Dz8IXo/2UH9nyk0ByIyK9+oojLK8FvTGEUG7PB3z
	a8cMIzS6vt9EuW2O9MhZ77jyIBlGsBaV1MuFMlxsTFFgLO6QcewVwp0Jbtg==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] sound: add sampling rates 12000Hz and
 24000Hz

Thanks Pape!


On 05.02.2024 23:41, Pape, Andreas (ADITG/ESS3) wrote:
> 24kHz is used for 'super wideband' voice transmission 12kHz is added 'for completeness'
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/184
> 
> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

> ---
>   device-types/sound/description.tex | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/device-types/sound/description.tex b/device-types/sound/description.tex
> index 54c9c8e..bad4415 100644
> --- a/device-types/sound/description.tex
> +++ b/device-types/sound/description.tex
> @@ -504,7 +504,9 @@ \subsubsection{PCM Control Messages}\label{sec:Device Types / Sound Device / Dev
>       VIRTIO_SND_PCM_RATE_96000,
>       VIRTIO_SND_PCM_RATE_176400,
>       VIRTIO_SND_PCM_RATE_192000,
> -    VIRTIO_SND_PCM_RATE_384000
> +    VIRTIO_SND_PCM_RATE_384000,
> +    VIRTIO_SND_PCM_RATE_12000,
> +    VIRTIO_SND_PCM_RATE_24000
>   };
>   
>   struct virtio_snd_pcm_info {
> --
> 2.7.4

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

