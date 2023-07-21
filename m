Return-Path: <virtio-dev-return-13402-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C42EB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 13:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B7364120D56
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 13:50:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9316798684E
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 13:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 732D798683F; Fri, 21 Jul 2023 13:50:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 081FB986840
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jul 2023 13:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1689947424.437000
X-TM-MAIL-UUID: 1acf7c35-8ad4-481e-8761-dfc258991a80
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmsnKPpVSj+N4+bENtNfC1eDnS/XGfYQZ04nEytzSlXIGZTvPqIxdwYKdhnaFfHcmeX71StBwFffHnVtiBSXMAWr3bETcN3j5uSUR1bKtbW2ees0xIHc/HyTgRgvco/Jq+erNbLII7DNjFJ2hRje5Qb0kny1+wTbNWeAauNTAFbB/wEvYE1odPvMFy3lPaIL8w0tLnMQ/tzF8Rzon09XDPQGlDv7SCESICrLyzjmDhe+Mvthby8VTLUkpDC8/VeEGqsdyJUMtc2a9GC2Sfm1ODUjTzsbrItCXtBlk6ZO+Ja/NfVX66sTWVQoZIivvAcJyUt2jm5vnOhcqapoiHd9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxJwxrX/RTuas4fkCeLWxarx3HEKaU0ywxfurKl6/00=;
 b=oZTcg+kd3pW+fMYHHem0Mqs1PY5pwNWt+Uv5ovVGOMIx+2WSPyEtXeVyEdo8U4ZiIThWeWP+jtGb7GP4YjeCFNXYyP/NwftzyMhVxmBXIvaDIeX24fOeGpdguoB/6vkOFGAEo1WVypO8+O/+9U57C2YuOhB8nbfgXIDNZ+Q5oqp8kGdEU1L1oOycB902dpkZTbdlNjYJjew1zhDgmBxd497Pz2AlQ/4C7ZIeMDOqd4MB+HRFQKv2CrYTGG6aErgdyJBXs1l6UXAahGQLDtCWyvMGiNuf/1HkAmQQVAoEYZawE0Ky4fAbCfDtsQkDNpgClBiCqJCUGLN3LXLbFSFaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <98b247c1-b970-72ba-6888-f83144f08116@opensynergy.com>
Date: Fri, 21 Jul 2023 15:50:21 +0200
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 cohuck@redhat.com
Cc: quic_ztu@quicinc.com,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-3-quic_haixcui@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20230417140353.870-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::7) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|BE1P281MB2257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9275125e-7349-4d4d-766a-08db89f16e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vd8zwj0zX6owTffr4MU8l1Q3tAm+gcOBcwJur+JhBe5Ns7NOWrLer/wLRLx6Ti3GR7pIM0D21MwrOWcBLl8bLM0vB1qQaev4zVaflf3SBmNt42ocvRot6dPkAtsnuUlwyrlOD9TztZmUlLkWObfDADfUKQ2QzjF7JfxKxjwVkjkz+/LIqtcJyKyJ+M2W/rW2Vh962r9wEe2YYUtoX0irf7bzFBDF4PfuQjlYGMl7EpBKHUUeIj0zVTw5rVltLJ/V6eGH/qjboQ/t6cQ5EHbarMW0zYQm77tYYm3T7CxsuLbLFNLs+LZZC4HAjs35Av2QXdjTDhvxqlMzSIZxNhaNwvr10hlh5zAz5NwTn433pbZ7uPH5yRZJfZU2jWH06dShlmOCUp/m2TA06NHZ+Uk0aM633u6jkTRD8idXAhK4pQIlc5Tnj44g6O2T+LhqAN0WO49JaE031GFFhSbwaTmzJCw7d0E43j/hgVY0HECmHcZ0t9xNdtMN5HdAyZeqepIsaYiTX4f7A17QHlnaNxjE2X0aO1GoufjA2aMuqGpDa6LURuQ4EDwh+Nq0LAver3aXWth0X//Rytw4Eo0ELB+Smy0KS8svXbTZfhnBz1bwqPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(366004)(136003)(396003)(376002)(451199021)(31686004)(478600001)(66476007)(107886003)(36756003)(26005)(42186006)(186003)(316002)(2616005)(4326008)(66946007)(66556008)(31696002)(86362001)(8936002)(8676002)(2906002)(4744005)(53546011)(41300700001)(44832011)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVlxcXJBUGdCcGpKWnBBY3BCQlcwdktUZFBTdVUyNkxQK3RMVHUyUFdQamZI?=
 =?utf-8?B?dmFRUG9wQzI1cFR6RUY2M2c5OGdmZThxbTdEZzU2cGRaSVRmdTVmalJ2ck5n?=
 =?utf-8?B?NVk1V2xwNVMzckV5YVRkbVA0R2dSNGJ5REhuaEQ3bEhVUlYrQnhwbXkwRjdW?=
 =?utf-8?B?WTdHSGlqdFIzRmxFMHQyMW8zdXdHaTgzaVB4elpKdXB6Zjl1R21NUC9wS0JY?=
 =?utf-8?B?Z2dYK09tMW5tdzdQTWpzK1hIK2VuNjJoNUt0RkJXRmozbkFNV1NaY1dRaUhD?=
 =?utf-8?B?U0xuVHpkNWo4VGRwbk9vUTAvQi8yQWdlbzBsRldFYXNJb0daNERsWFRWZUZW?=
 =?utf-8?B?N2kvbDE4UC9jODBjS044cEVYOFNjc0o4dXRwSFFIbkR3RzBrckEzNjMva1RO?=
 =?utf-8?B?WG1TejNsOWdnOGtMeE0weHlUOUkxWnJRcFhqZkVmZjJXcXFMbis3SkhrV3dW?=
 =?utf-8?B?MVhUYk9NbGRNY0VGUTdTcGs5TStNZWw3aDVaTDR1RUdIZU94ektpLzZyTEFS?=
 =?utf-8?B?bWVkcEIxWHl2azhIb2l0a05kTFRISkQxeUNqdXdIV2paRGRWQVRsTnErSnpH?=
 =?utf-8?B?cloreGkwUXRZeGFneWZTQkFxeXp1empmbm53VmkySWlCTTJmb3d5KzIwcUxM?=
 =?utf-8?B?Sm5GR29keXVNbTlXczBWVEdwSmdzb0VmR1BSdVB3WWNnbzR6bzQ5cEV2MkFF?=
 =?utf-8?B?bVVYU1RYUnJmNFl6dTZOZVBzNDh1M1h2WkJxSXJPaFY0N3BteWNEVmFjZ0d6?=
 =?utf-8?B?U0N2U1ZMeDdmb0xMQm1tOG9LMU1EMEt6Q2pDUGlKQkRUT1Z5MXZ2b1plaEQv?=
 =?utf-8?B?MzN5V21CSytxdldTWUJndy9zNEliMWpydU5EYVdRc0hrSEE0OFlNaEYwQUY0?=
 =?utf-8?B?U1VyWXpEMkJzK2l2TllDaW14SmJxY2x3ZW56cjYvWkxVSndPMUl3aFY4R0kv?=
 =?utf-8?B?d0pMcWZKcFhETHF3bDE1N2w5OXM3a0pjcVdsdFFCZllvWG1zNFNOeGpFdGVQ?=
 =?utf-8?B?VnZXbDYrY3Ixb1o4M1ozeTVaV1Q4UWdrVW9uc2VaUUx1WmtlMkxXYnZqK2NR?=
 =?utf-8?B?eWVHaTdQMSs1MFUxVDRVeFkySGpMZ1FZWnlEUVJyd3puTVdEb3ExWkNuM1dy?=
 =?utf-8?B?QXZZSmdrak0wZFlNU3NoekhnL0pla3Y0cWtDRkFWcmpDWnNtSXJReVpQQi9o?=
 =?utf-8?B?STQ1dGhuTVI4OVRjaHhqVDFYbWJrZlRmQlYyVkhiWXovdU9yOXVPM01kV2FT?=
 =?utf-8?B?d3dwaTJuekpueDlGTm04L1lGMFdqdmJYZWFmeGdkN3hZTTZKYzFHVzloK1Vj?=
 =?utf-8?B?WTNYVTJPOXRVc2lBN2phdVFkazFzNzI3NFMybGVlVkxoakFHUS9UaXNLNGxl?=
 =?utf-8?B?dXA5bUJ4R1NoNEMvWmRJYVFIWmd0ei9wZ3paSEZtWTJoSWFVaTg0SVBTKzRJ?=
 =?utf-8?B?cG1vcWM5blZhTHhzVHlYN0F6dC9CN3pLYzd1emJoR1F0ZGtpY0ZYS2NQTW44?=
 =?utf-8?B?anN4aGxBcUZkdjhWRnhsOHRYVzFUQnFpVW1kVUdWZzdTZHVQOXdZRmM3a0pi?=
 =?utf-8?B?R0gvM1MwRHJxWUxuZzROeTg5TzcwWGlPVU5ka1RiekRna0hpQzJtRE5lZkFY?=
 =?utf-8?B?SmtHa0NlaktUeTlkYjJxUFBETEJiVnNSd3Z3NkkvU3lqd3M4NFB0eEY5SDl3?=
 =?utf-8?B?eFV0WlhORWppcEduYTBCQVlrYVMxL2hWQXFJN01JUlVPSW4wNG1XeWZ2UDBK?=
 =?utf-8?B?U2hkekJJWSsycCt5L0Ftc1RpVnBhMGI1OFlMMVNwMy9RWkZYeWFCOC9lVmpx?=
 =?utf-8?B?eEg2azVQc2ZPUHVVMUw4dzc2dThSUmlvVDN3bE1oU0FzVHVVMlRMTkRYRDhm?=
 =?utf-8?B?NDNaa2hWeXNRSHkvVS8yUDdaRm9zYy9uL0FJenZWTjl4b2R3cFg1Vk5lY2hz?=
 =?utf-8?B?bkxSTTRyWE9pT3hyUnYrK1ZZQXZvYmpzS0IwODZ5c2xrc1R2bE9rNUp0WTlQ?=
 =?utf-8?B?U2JuZWowUnhvSGVYL1FxODRObC9tMWhLVzVQdXUzVkpWdENCN00xWTdKcmVF?=
 =?utf-8?B?WFc3VU9iMjlkN2xtb3JIcFpXQnJaMGtHSGdJK3RhRzBwcTgvVVJaSHdpZnNM?=
 =?utf-8?Q?NRV/jfY4DM1f/VvJbjq0KWH1B?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9275125e-7349-4d4d-766a-08db89f16e10
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:50:23.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXtrFChB8F7Kpa/ApHeqUupBu8AX3MJB9ruzrPn6kmpy4QHTTndXpA9y49BgNsAP7N+1raDWMK+QBM1Bw4zIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2257
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27766.000
X-TMASE-Result: 10--0.598200-4.000000
X-TMASE-MatchedRID: 7ySqCuYCpfj5ETspAEX/non73EnA6dC3nsSRXdX/K/tBMJQB/z5Xnp8N
	ywXHz2IKaFYwKhMLAx8nTLpU0SyCEqZEIuJlbRknGG92L3YEEC4IyIQE9neGFchGESF2QtYSF8l
	6IMPHalnR/vC2LNshBesQNAL2u95wD5teccobfJXE70Mejctgq7ueT4Q7MJk1+IXNEO3LsZJxg7
	svMtapLmqnMjmJR+9JNWgzhR3Z6fOdbKPUSVSM13FB0YWGPeM47BNpn1g6x4U=
X-TMASE-XGENCLOUD: ae59802d-fdb0-4068-a8c7-5580753c851e-0-0-200-0
X-TM-Deliver-Signature: 200445C66A3FB5667627CB7C3D51172E
X-TM-Addin-Auth: JbF1rsMg4fM5UFq9sz8BVfv+ue2k1yuTlGcEt5GHS5Xb/Qb3ensVU7fJDmD
	Ss6wAytFXBmXp9Kz+Ll+FqRw/syWfj126cFa9N/OxriUQwa4drRZNOezxhBGRfJLU/7tLaBoh+9
	tJTnRoYfEiyy7kx5DP0lQViJeasG35G1lA2+GomPATdqpqpqcNRxvGuIxlAAcwD0dy0H1sTrQ0R
	fIw8njuuVM6xYRs8DTJSpyjhqPnxZh9DIBXG01KrdbXbzoqzq3Pw/sQjlivy6KX98+TleAUhd4I
	+/IoR2M7ealiAOE=.kvYGb5IFsRxXLfDpWspstVDGnfZwNMUihIDMN9OwI9pbsxeQPLryESy5Rz
	ah1Ahk4DAupFqqmNej1EXecD5ii/eztcsni8XuWdRYlJyM7EHGeyKZXrE/jUzrhQufR/9/4PiMH
	F8cHV77CB9U01Ih8NU9nshfq7RaUQ42w1LEqrg4R/GK+B2WDPW01kUd2Xt/C+PTO2u2dCxeGIRt
	XPI8H0gZo1uRHckP6QBmg0uxARQ99Ir84ZfKW4wGX6RX2+mApdewPQM99DdpsubexvqN4MiHiWY
	8Cb6uouvujoohQgQuJU6mNb8QCrWYfc0j4pXG+um5EHXpqwzHNccZ0oFRMw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hello,

is there already some virtio SPI Linux driver published to the public to 
have a chance to look at?

Same question for the device side. Is there a qemu device (or something 
for a different virtualization environment like kvmtool) already 
published to the public anywhere?

The spec made the impression that it's in an early stage so I expect 
there is nothing yet but I may be wrong with my assumption.

On 17.04.23 16:03, Haixu Cui wrote:
> virtio-spi is a virtual SPI master and it allows a guset to operate and
> use the physical SPI master controlled by the host.
> ---
>   device-types/spi/description.tex        | 155 ++++++++++++++++++++++++
>   device-types/spi/device-conformance.tex |   7 ++
>   device-types/spi/driver-conformance.tex |   7 ++
>   3 files changed, 169 insertions(+)
>   create mode 100644 device-types/spi/description.tex
>   create mode 100644 device-types/spi/device-conformance.tex
>   create mode 100644 device-types/spi/driver-conformance.tex

Regards
Harald Mommer



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

