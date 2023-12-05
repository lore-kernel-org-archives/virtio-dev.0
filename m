Return-Path: <virtio-dev-return-14121-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED3C10F04
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 15:14:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 622653358D
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 15:14:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 193F798657E
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 15:14:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E95F4986556; Tue,  5 Dec 2023 15:14:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D27B5986497;
	Tue,  5 Dec 2023 15:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1701789275.696000
X-TM-MAIL-UUID: 38f27a76-5e2c-40af-a5b3-bd5f3f0413ad
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct2eQacfAEk2dGCJy/io6UzBnwniGlW2FydyvBm998zcO136b9+u0ftZBHwRcj1/mskBpz5lP9NrE2ZuPisf3iSKqhXOWPfzLJ1hnQz/0zya827pmZFCodOPPiYrEM/R9X8fWQZcp5UppPTByAjwh96IcBTdr4M86T/WLT1pg+wV8wcHZBTsT0AG+wVHoycE57UvJnDXiYudxi/kHlUhG64pXV/BR8fouP5vikSC68WK0XHa7ld9/cBs4FbyfbSwL6PlMT3Lodwbrm3Te8JsFwmik7H+1rTGjAw39vGLP05/XSbrx3qtWR7+BrvolIo8yqaYNO2EOAXuEmKlerR/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utQpSH89SAYVZIvcCg8VPaCTG5ak/nel3lkJ+MCRVDk=;
 b=G/NIDfCo/bnO57/1pxkJSZZ9xh50khfitDjlRqPXPrOrGeOLrWnvrS6seJkE7hZWeC7AGXv1lnPNt/h5U86gpWQi/5eH691REqXxm+mygtwtzTHCclu5FDrhziegIaSOrX7Srn9ONjEJaSYcOEgseuqhjbEiAXoHN6qlcsu/KU3gNoStR8ziOlD++8uq9jXV/ZKOJKnUkNsmVfD07eJitmiH/DvXPegq/w4mcUcZsIAHbE7d2LT27t6P1BmD1HIjTsxuyJeFjbiCMd9VfYglXJRP7tvGPXULhmDSqJyY0b3QTSNgH5DPrHN7tDpM0X0OsaKsi5c+vNgMT5q6La4cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <725bdcfe-9678-448d-8f8e-dc7fe1f19289@opensynergy.com>
Date: Tue, 5 Dec 2023 16:14:32 +0100
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com, broonie@kernel.org,
 qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
References: <20231205082401.18111-1-quic_haixcui@quicinc.com>
 <20231205082401.18111-2-quic_haixcui@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20231205082401.18111-2-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|FRYP281MB2060:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b92559-3ab6-432f-cd70-08dbf5a4e360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mL3VCxrd1vzj1h1gL5ex6WP5Y55a+1MnBK6MNTmFF93+HtQJt8hPQVPIf9zn47DCr26eO/HUUn3TvDyJAjX1nvvjytokbUJNMNuszX1meLjRMTRWA2ExPdAdmhApE3p5dF45TMdj7IV+RAjHvT18N5txgQn0xhJvpNZxa0KILNf4q7l+yt8RIeVRLZ0809hx/lQ8RRyu99CHI8otLowswlMLTVvXznxbnNkpd0VmVnhnv4Pq0GUHH/ZgsHkuQCxYpblk9hac9ee84aB07ypeMRyoaeDkD6hxNnhsB5BNjenK5pf8xzdTdM4Mt4a3Is3YuzHndP+qNSu545dsvY+2OZvINOPDk6VMac4b5i8nPWWHeRYddbtfE5uXAXHuupLqa5/+3vIwf+uJsQgKwcuEsrVBXxPGHYNjojEwJ2oh+PRaU+u/2sYtzCF+p8FExTHwj9I/HsFFUaZEveXiAFeWMoBo5mcB7O93UFOjpInUuArSte5HhGDLM0LJASW22wfFBMaKH/z0VNV+yE5I38g2/ctFvJGCj+PsddLvfqG7dbO3sLrCetervLA469N17gIcsair19bV6lCMKPxfOl7FyyJRpNIH5/AnWqNcNf6J4iw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(53546011)(478600001)(42186006)(66946007)(66476007)(66556008)(316002)(26005)(2616005)(83380400001)(4326008)(8676002)(8936002)(31686004)(44832011)(5660300002)(2906002)(31696002)(41300700001)(86362001)(4744005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1tNXlMU1QyRkY1Rm9qSllsVUJ1VC9EWkNRRy82L3JKZnBIVWZ5M1F0YkU2?=
 =?utf-8?B?REQ2ak43K3lQN2trWEx2b09FUXRocURMVlNxUmJJVVU0VjdaakZVWmdOdW45?=
 =?utf-8?B?a3gyTGVZWW53WGh2S0d3elozZStrKy92SmpjaTA1LzR3Uk9ZZDlrWmdyTWxp?=
 =?utf-8?B?RmdsNk5yTGUyOEY1MEZHdEpjb1BjSnNZVUtya3RkZnZVTGZncTlRTXNjbm5u?=
 =?utf-8?B?TDB6eDB4cVZaa3dZZXFvY3NQV1R2ZjBtNFB4dWt2TytxdlljNE0waGJiSTQy?=
 =?utf-8?B?Nnd5dm9HQmszNlRFTk02aWZPVFFTNnFNbDl1NFpQcmx3V2pGVlpDQjlwSWJ2?=
 =?utf-8?B?bW8yNi9iVEZjTlRCS2c3Y1ZlOGlsbHJCSkNIK1pCemZVbElhLy9QUFJLTCta?=
 =?utf-8?B?MnNndWlzRWJSWnBsZm5mSXNSdS9pZ2J6TEFTWmZvdGFvb1paQ2RQRW9RSG9T?=
 =?utf-8?B?dnpvRkYvY1o0bmZFN0VobERlS3NMSDBJQm1GeVJVQ2M3akRiNTNaZ3NMOXNM?=
 =?utf-8?B?K2NDWEZ1ZVM5RVF2SlJsempPNFRVejRpWVlTRzFsUStMUzdrS1o1cncyK3dN?=
 =?utf-8?B?ZE10WlpITE4wNFdVVHczMlk4ZC9Ud0FiaWJKUkJ0aUZlY3JaVHZKUks2QlRF?=
 =?utf-8?B?Z0dxZUx3aGc5dzF4cGFOZFRvQUVEODNlaUxCU05yWWhrODBidjl4dXdBK3BX?=
 =?utf-8?B?YmQyUjIxV2lvZVNQNzUwWERsYXlXbmU4VGliRHJOdFlla2pMUTJqeEZ0WnBM?=
 =?utf-8?B?TXp3SjNwQ1lSK204d0lZY3lKNGtXVWhHN0ZWTE1ocjI4YnZZTHZFa3lHOGxl?=
 =?utf-8?B?N3M4V3hhNnVOcC91WG5XT1V4S056TzZ6WnYvelVjS21CQVhLVVNLUGh6bCt4?=
 =?utf-8?B?YVF2dXA2MGJYbTJRN3VJc0pPb0FBRmtEYWdWNDN3MGx6TmZOcFZMWHh3dmF1?=
 =?utf-8?B?amxzbVhjNEhBNjZVZ3dkdWZDVzVJeHJUK1hmeDQvZlRYUHhjU2dNTEo4bTYv?=
 =?utf-8?B?WG5idzVIalZoVE9ZdWJyajZIdXpYOXJ5Z0cyYVIxTHQwN1BUSUFKWlNVYjli?=
 =?utf-8?B?b0FWTllORG93TUM0U3MyeUppUk91NjFiU2xMa0xoMW5PTmoxaFpjQW1jSC9B?=
 =?utf-8?B?SjlxMVpNNXNzRGM1NmNXOXUxdDRCMkVqcmdHaXdhOTNGMStkR1hyM2F5cVFT?=
 =?utf-8?B?WDJtempWSDVFQmhQM1dYOSswYlhoVVNJbmVlV1Zqd2hVNjdQMmVISTRaZ3NR?=
 =?utf-8?B?ajBPa1RFNCtXVml3SDBpZmdmcGVTS0NWdzdHZ2JhMGFYd0tzWXlmekdBaEVv?=
 =?utf-8?B?RkhrTTBrSUpPajBtN21wNHpzNDN3MVhTbmJXNnpsUlB0TEJEcFRCWVpVbWpQ?=
 =?utf-8?B?RWI4K05DNE9DTFFaVTRLOTZ4UUVoYjE0MjE3NkgxOFpFa08vbjRuWms0aEl6?=
 =?utf-8?B?Y0plcUp1RDNvSHIrWXJBd0FhUjlGb1l1ZHNURnFycitYVGZQdVFnMGxWWTdG?=
 =?utf-8?B?dXFNZy9Fa0thM3Nmem9jaU44bmg3VjdHQ0FqekVCcmE1QTBYMG91RHBSOXYy?=
 =?utf-8?B?SjZTV2FkRUxmMVM4eFdMblFVVnpBUnN0OTNxSDJURDdNNkxoUU9GSGVSOWVQ?=
 =?utf-8?B?cXFFMTRIQTNjREJZNU5NYUk1bDBaUVZiNHJCeWJBRjl6ZFNWdXBaa3U1NDdG?=
 =?utf-8?B?TE5LZzI4NUJFcHBWV3NPbS81NGFzcE9LT3JsUVFMU1lZREY1RURYbWlaeGRi?=
 =?utf-8?B?NHNVUmV5NTFheFEyUUVxMEloL2xzVXExVWVyTEVPcCtwOUMzMDd2eW1LbGht?=
 =?utf-8?B?Vkw3ZFFiak5CVEhRZTNVY1NjWTVyYW1hWUFVS0ZJUXUvOXRrTHFjWkxIVUFz?=
 =?utf-8?B?MEdMalFYZEs2OUJnc2xCNEFubHpZTE9TVm51UjFRVFNFTkhmcjkyWkt5Snoy?=
 =?utf-8?B?czZaenU2aHMzbjU0UVBTblhrZmhKbU5PVWVDd1NmNVhmWmdQSTdxeVdDTVU5?=
 =?utf-8?B?VllzN1dCcXdhcW9lMUMxVFg2TjkxQkNlYTQ1RXpNeVl1NFc3YnBQQ1d1NzZ3?=
 =?utf-8?B?aEc2aXpvOUlaT3NES3pUdXpQYUlHSUNENHBwbzFNSVVVbHhkWTViWUZnL1I1?=
 =?utf-8?Q?HOe5klgrnU0YfxfhKq5C2t1bo?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b92559-3ab6-432f-cd70-08dbf5a4e360
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 15:14:34.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g4AJqERXkd8LeMf+MOJK9ktKhNQgiwTnvYaqtv2+0WYUEzJeVmWOsX6ZmQ9Kqx4zkmGqWhFEwU1H+5POJ3ZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2060
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28040.000
X-TMASE-Result: 10--10.339700-4.000000
X-TMASE-MatchedRID: +c13yJDs901TzAVQ78TKJRhvdi92BBAuG6vAF77GsJZrIVA3IGfCC6DE
	DQa+uiKUXPH8g1DMMIhCX9ncE5tRwrzhbBgkH6FOJw66cQh/R5cIyIQE9neGFTB4jJltGVDbLN5
	wGPX3TPXYeXOEzfM22dEoO5p+Ouf5UV8QgFV01kwryenjpiLrrlo7GmCOJYd13+6k97GsyDil3Q
	o8+BrrvZRZn+l3dgxxLpr5d21SHwCano9LAJbc9m0pOFmsTNBM
X-TMASE-XGENCLOUD: 4c75352a-523c-490d-8b65-9726a86c61c4-0-0-200-0
X-TM-Deliver-Signature: 942E928255F8CCD381BAD33FC6DC7FFF
X-TM-Addin-Auth: hOCNBKwUlN+ugop51+iw6c96nwJyg4Xr8sECzmTLXhM5/QKjtI4p+R3l2FK
	0KnDCV0fFRl9oKd42tqHRVyhK2meud3GuXAXwBHcpWLTch+1crZzpfM7rd6RrhcJ22Ual0jnvVp
	mgTTiwygGOasgpneqv28p/WO/qSZp9oezSmIBuIgB4UB58vaWsax7IPRIj00Y0/9g2vAWHI46br
	p+XMN9PE8tNfT4XysMOv3NO0KfQxhjzJGz2FdgPJrxyJoUbq+EPsFaFvsn0o8b9zbJl3p0p7Du6
	1yLHDY5v39HkAw4=.WywnnCBXrDeryfaef/nN5spBJmgKa8sZuPbFqYyWE3On1GHZVg7s6URZqf
	LrCiBzuhdJmMc4au5zlhJvOREGonoYrS8BELDqD+Ik0zAf3IcSRg0cVfOBxfYgb0cMUwC6Eq/YY
	Rm8Ufer6JS8s60MojkZIMUiNhmNm6dS79U8OENuFRUje/DTBnecB4jsn16fsmVT4GRBLd8wg7dy
	Lfdl2wQD+SDgaBxYs0TOEOElXzEPzKVCqjUdr92WhuuNDVgKThL7HVve8UfqdMO58VSy4kVFmo0
	EJMCvaRDNqR3cGR3oJVaa97KHlb9DVniVokn6zKoDg7WbzImKvvbtjKLzmQ==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH V8 1/2] content: Rename SPI master to SPI
 controller

Hello,

On 05.12.23 09:24, Haixu Cui wrote:
> SPI master is an outdated term and should use SPI controller.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   content.tex | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index 0a62dce..1c608eb 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -737,7 +737,7 @@ \chapter{Device Types}\label{sec:Device Types}
>   \hline
>   44         &   ISM device \\
>   \hline
> -45         &   SPI master \\
> +45         &   SPI controller \\
>   \hline
>   \end{tabular}
>   

Please add somewhere behind

\input{device-types/pmem/description.tex}

the line

\input{device-types/spi/description.tex}

so that I get my PDF generated without having to add this line all the 
time manually.

Regards
Harald



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

