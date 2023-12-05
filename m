Return-Path: <virtio-dev-return-14122-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF0FC4167B
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 16:18:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7DF992AC5A
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 16:18:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D89998664A
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 16:18:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B88E986496; Tue,  5 Dec 2023 16:18:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B4CA98649F
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 16:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1701793125.816000
X-TM-MAIL-UUID: 4687b1ad-ce72-4d9b-8d50-520e1dd4850f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioIhPbsi3ALcUJOCcRWj2U19NSVsbsQxXS1yM17UeykKh20pKMOtV6BIVR/BMzPBmqy9+en+dq+HrZ3ztaC+NNpVEv1oVBtWEcGx+v8n8bWBDgGC8i9mS07rUEViCoMDbd2k2LDSznc08KGifmopPxASly1KOb0lLEZSD7S//0+B3z8pni2W6QX3jB9UndtlpznqJE0Fr7ymm4VtJl5Z7Yau2eDdQaIU1jk9g5LuhKLoUOWsC++icSfZX15LydI44xrqFtFo8GD1NRra9NICHEhPKCBkUMkiZiMMTTijKXiJW3xLyI4xsleu3OgP0VUUqV8zjTww9ssN1kI5gZUeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfAwpOGHydwaaW4T130jOTzrx8V/cwluOMQrsVRhIKM=;
 b=LYpnt4Jl3YWYrslp7nF4xETBMHAlHZoQTHOylwS+wz48oQKiteEJgIslq5xkUa+7jOW/SaZiNembT0MiMQXirN4i/c95HelLyfKlEksaa/YdQ34XWHuAPd7rCzvMYWvV41gHzo07lAqbKd4/1R5v9RVS69BvYPm2VHDsbj5Rq9Zgs0SiVBD8PNKUCD7C+hmomVYIT6gAIb1YKZuEIsYXgx2Wy1tx+Ib1X1tQopTbI9BC+Pfhn4t25ztEaWKp9XIm/lB4fFXvuMYg1qFdOm4YCc40RhHZOz/Me3WYFKYQJr0lzZYGKj+lb6X6wTK0ArH1MVnIsdxYIq3RE/fhqiu7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <b9d86f18-3e7b-4a51-a7c3-d9044dc567ba@opensynergy.com>
Date: Tue, 5 Dec 2023 17:18:42 +0100
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com, broonie@kernel.org,
 qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
References: <20231205082401.18111-1-quic_haixcui@quicinc.com>
 <20231205082401.18111-3-quic_haixcui@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20231205082401.18111-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|FR2P281MB2656:EE_
X-MS-Office365-Filtering-Correlation-Id: 448044e8-93c0-4a50-cf9c-08dbf5add9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hLWREFZiRFBqQBlu1jOFmly9rJBzPGgjcle9moFAfHbWz+mXjudYE25ZqENxBLS4d36zQJp1o5qgHbB4tPaGI0n9kLETYHB4rwAl2B1V8mwKIHec1wwh5qNdxkoKflOFHIvwn8GxRh4Plu48N1/C7xRUbi5wXAW+IXM3jU7Z6GdzsZFRlhdCtq8zo7B6J21rL6xw+erf2gjBjJfSjNeA83mwRZ4uwSeyTLR7VAKC0+h3bUHi7tD+JLVKNdVXh40ej3g0eiiDngK0z/lfK0CqZmDMMJ2UZgaAE2nspJNaOmxxmQM1OIEdPy1qqhsDzz6bNQPB3v5BSbChEr0zkXVAVNZQvrdz1kRxMPim+WK0uc5NDUY+GKUGl8sizv1EEVwnaAOM1W9huEEfYXfvTNUWx7CSRYEwZmI2SY+PDIB+aKepi5dBmS1Y+AtbcxvnsICG87YXHsew23dBGKE8pUiXxQx9Hay9k742YDTrXjT5PniIrZN/wB1ZZISoHRWgoyDhDIeY4a/2B9VTpijJIS3UPJJaWSO3OKt8uSFXG1jndvZTCl2J+ADJ144vZQgmj7jLvfUz5g1RwEFgq5O01sgzkmnSrr8fpQfo8rXRDO6P/m8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39830400003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(53546011)(478600001)(42186006)(66946007)(66476007)(66556008)(316002)(26005)(2616005)(83380400001)(4326008)(8676002)(8936002)(31686004)(44832011)(5660300002)(2906002)(31696002)(41300700001)(86362001)(30864003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWttVUpDWk9WVTIrZEZJVFp2ci9Sb3VQN0J2WWxJdndZdWx1Si9mM2ZucS9P?=
 =?utf-8?B?SDNLdi9rZkJaSlZlWndkL09hUzR0U0JYKytMUHlNbVZLaW5SUDFmdm9DSXc1?=
 =?utf-8?B?TUVoT2wxZGRNMDF5Y1dSdUpPc3FmQnhuWGo5NGZGSE12bHltcURTbi9lalV4?=
 =?utf-8?B?UWFxc3YvbGZPU3cxNnh1Qm1tMFgwNWVhQ1owZWVoTUowcmZ1cFZhZDVSam1V?=
 =?utf-8?B?cm1Yd2QzNzhMM0x0QTF6U1RtUExFeERmNUcvbkV1UkJYZll2NmJUdEd4bFpO?=
 =?utf-8?B?WFg3V0pFUkRoVTk0YUE0dTFpZGJZRXgwVTFsdHcyZ29XR3ZyMFBPUEZYM0Y3?=
 =?utf-8?B?QnlwUm5OMFJaOFY3Z0pRSzhaRVZtQXFsRm9iSW9IdlpLcUl2OHJtbEUvV1ZR?=
 =?utf-8?B?U3ZGV1FURWQ5Y3dtMFI5OHB5ZGJTZlRVaGlIYjdDK29PeG03YjB1UzhLa2pD?=
 =?utf-8?B?QUFCTjZrUG93OUNCZDhjc3QxUFdCZW5BU1JQMUM0L1RQT1ZBNk84K1V5MVNN?=
 =?utf-8?B?L3RERlJQU0h2MEdkeUpwbWdQU3NCTjlycCtpMnd6ZitnOGhMY1k5RENzVThu?=
 =?utf-8?B?Z0xJWGN5ZDBQUmE4M21TRkE3ckhmdDJKVDhLYmJ2SkI4c2RPOExSeDYwaVJ5?=
 =?utf-8?B?d29QUkdyYjhOTDZWTEh2UG5nc1JaZGhuSk1YTnFnU0MxaGxSOU13N0xEMjdZ?=
 =?utf-8?B?QlhkSDcvWTNMNnkvVnluc3AzekRHMCtHOTZRcENTbDJiQUxoNk40V1cyZ1hN?=
 =?utf-8?B?TVZuWDg3K1l4QldsR1B5VmlIRGdFVWtWenEzdjAyNlpmRmREQ2xudUxaRVg5?=
 =?utf-8?B?L3UvUWwydGhCWTdubjNNSldqZ0gzdzcwZ1JSdUhNeVVhQy9JUXlyeUVEMTA3?=
 =?utf-8?B?bjNpYXBRYUs0dThKMUJoSFBGck8yVmVQaWJiTWw0WFM2Zks0elZINVZxV0Rt?=
 =?utf-8?B?SFgzNytmTVV5cGk0N2RxMjkwVVJhWlQyRC9pTkMxZDk3NHoxMWo5UVFTSW8y?=
 =?utf-8?B?VDBaK1FMQkU2YWkxM3lyL1VlLzBBT1Q1b2xWNVpnY2luQUlEdUlBdWtwOWM3?=
 =?utf-8?B?U1NqZFRrd29CR1RacERjVlh1aFpsSW5DcGZtaTh2QWV2MHJoSjhjRW5zRzFR?=
 =?utf-8?B?RVQxYlptMGF1TGdKK0Vzd1dyQzExd2haNWw2Ukd5VVpoT2xkZzJYNU1tUnVZ?=
 =?utf-8?B?dzFVZU1GbmxVRjlmSk1jUmlHRVV2ZXM4OTVBa3dZbDErWHR4cnhBMHBKZ2Rr?=
 =?utf-8?B?V21sZGg4MURtY2dtZjhFZllSVjdGT002cWdCZ1FCc05CbVEzeGd6cFhLamsr?=
 =?utf-8?B?dFZzY2VTQjh3OGtLRys0ODlTOEwvcVZadDVxQjRsWkhPcXg3Mm5xUW1BU1Rv?=
 =?utf-8?B?OGpWTWt2YjgyaWF3TTNlWUREYnFEWHFtNjEyRklyVmR6SEZoYzdpcWl6Sm9u?=
 =?utf-8?B?a3lhbTZKSFFZOHNSUFh5SC96QTEyNXNDTndQVVAxSDhZL2E1YURuYXlpa095?=
 =?utf-8?B?Qi9SRFMzb3VCZHg0ZHBnNWx2MGVYWm5KUjNTaVBwbFNPUGZjS2x2bHlxa0JD?=
 =?utf-8?B?YlAwdVdTNlRERExZS0F1R2Z0Y0dBbmdXKzFxOGp4Vmp5SEp1YXJWZGwyRXpE?=
 =?utf-8?B?UlQyRklKMThZNHh3QUZhT1NTSldTdDVaR1ZoTkZiMDAzVUdHdTJqYjNTUXZW?=
 =?utf-8?B?ZDNlOFVFdC9GOFNyVGw1K2ZUZWFMeE1hOTVIUjdCVXhUYlhCRzlKU0lLcWZD?=
 =?utf-8?B?RTlsOU5QQjl4eTZJUzhsQnJLSzl5ZFhOOTlKdXNxUEVrMklUNjF3U0xOSDRT?=
 =?utf-8?B?ZzdnMUY1MFdTaDFmS1p4bVhYSzkxTEg4TTU3VlVUSlJSa0x5OUZTUjJOZmFC?=
 =?utf-8?B?VUFWNWhHVXV1MlgrVkFJTExyOUd5bEhRTXlTYWVEdDFFNGxqWk95dWc4ck5L?=
 =?utf-8?B?T0Y5NE9TdG1IK3o4VUwwSmt5ZTM0c3dBMURsK05haGVXMFF2OHR6Q2dtdTU4?=
 =?utf-8?B?VnVNY1NWYUw4L1M1Y0grd0dTUnRWRkV0NFA0dlJjVjJHMHlvU1pPbkNoM1k1?=
 =?utf-8?B?a0hJTkJzakZ1WGN1NXN3d3B6czd5ekNYaFd0WmN2LzkrK3Y0RHFnZkM4cjJX?=
 =?utf-8?Q?FOWAGa5e7J50IUo88a9qP+gjN?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448044e8-93c0-4a50-cf9c-08dbf5add9b2
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 16:18:43.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RUwBieRfCnKZif1Nqt08avvKfB/vOzDXu6RXgwZWVkEINZGLaOGnpPelvRUcELfr1GgEaByX4B9GnXI20by7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2656
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28040.000
X-TMASE-Result: 10--26.190400-4.000000
X-TMASE-MatchedRID: Ync95tbzDRn5ETspAEX/non73EnA6dC3aBHayMtRjI5BMJQB/z5XnviS
	3FmB7WTRHe/Upp/4ecTzrZbd4uWwzAfuLUsylynJeJchdZcr1K1krVIXZHd52BC/UY707QgL+3D
	GARmE5RAeFzrg+xNuermAt1c2rBY8LQtXgJFvDBJSU7TOghylToHV87ajhAZwPtCfWUwJAdj+f0
	UR6Rq9Awk+LqXaPtYtZEZtw6fG8MAcO1grrVCKJLMb4AyK1KgG10/soz7yB7F83mXuKlGTiBM44
	daeb8KVGiooGHoMwPm4xCRtosKaTivIZIWBHYop8kxNDHin3Z/nuvpGqNXb3baCwfIyfiVYYqxr
	07Qezp0zLPwpzGtDMbny9EstI/qqVm/X0zsJiCjgR8l2Qhmx6p7EkV3V/yv7mqLXenBHW9T7IVe
	MCWP7eesuAJPUzoyqizXsTKRW7EkDudvmHJQigzakEkBtr136ROTm3TA/XmnGWwYDp5NIUq4HXg
	ANsgPqUTPJ9weytSaLAMgC2hcZzfYfOj0kpvaiMg1lA9Dhv4pJnvfeG6RJLADa5fS9bX3qZS+gJ
	IfRN838nGTrlqsbT+5GV5k7e6SoBSQvAg/m+QkxnH4RfI1qpYiz1d9zaZ/x/WuKNaEPVCoPHou+
	uv3A1t0puICvwfIxizXsTKRW7EkEQCPuZXAZ9taLqSTdbkijDEwLWfflMUKwBZ5RVTkWhTt5yG5
	DhcrCjIctVAbw20nWO3EaRuaNrmWw3HPybv5QufcxzGRS4NtyfGzN/EfYKSbHySXVad36r54JIx
	46I6QD+Uf8y92iJiaSuBfcJyImkGUtrowrXLg=
X-TMASE-XGENCLOUD: 1a11e1ea-c221-4db6-94cf-1bc7489e5866-0-0-200-0
X-TM-Deliver-Signature: 4148B97AEB3229BF646B0FB023F5437A
X-TM-Addin-Auth: c3BivSQYRhF2AvxUaJH3HUwWlqxhx8g6Jop6E8/2WDlJBmjUqcYtWh2oXPr
	oUFhBenfprwd2f0excZY67G1U2Nbu4+Eu4oapDhBFTTpY21C0JdXiQC9MRxf5qAZPeug5pkZx88
	tz/Ohjt0pe4gmj/NGVHpiTjM4FPXu4j+wt8k4hUlA9CouONMGiqOV6kfi5vKS0fG5vEdGfDVkIp
	RNT7qMa8SBiRbIZG0Jbev1i5a3QnFkKiEuPoiAuHTA5SIkxTa4wyDqNGnFlTAUrk3vkUZkTQMx/
	F5F67aoJtZAK/kc=.gls/1dV9SC8BC2I6KRCR1Z/AiLy9vAH0I6IBhxGocYCtLkrRwGyIUBn6cZ
	m0NMGY/a++vV1Q4ErT8ZLIzmGLxndTRjcxOwS2lZAWTDkE972qVGlleo3PkWn+vyBdcpzsUs6im
	2HDuVnj9c8T8Rc4nhsOtOlHrrgGvhnFjx9E0TWputJVJafelIzi9aHL3tKwImMPjsFdJ6v6r1xl
	qqTsJK1cCl4c1wg+4hZcB2ewSRbmnmDagoFYypFQaYejqfNzY+FKcB/oCw6ZmT/Co8edFdj5yHE
	s0CsqO12oDIvXzTxn82vpwn5P+N8VapISnFTE/ZKxAzTZlAl+1IffvM8LxQ==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev][PATCH V8 2/2] virtio-spi: add the device
 specification

Hello,

updating my device and driver to V8 and having some comments now.

On 05.12.23 09:24, Haixu Cui wrote:
> The Virtio SPI (Serial Peripheral Interface) device is a virtual
> SPI controller that allows the driver to operate and use the SPI
> controller under the control of the host.
>
> This patch adds the specification for virtio-spi.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>   device-types/spi/description.tex        | 280 ++++++++++++++++++++++++
>   device-types/spi/device-conformance.tex |   7 +
>   device-types/spi/driver-conformance.tex |   7 +
>   3 files changed, 294 insertions(+)
>   create mode 100644 device-types/spi/description.tex
>   create mode 100644 device-types/spi/device-conformance.tex
>   create mode 100644 device-types/spi/driver-conformance.tex
>
> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
> new file mode 100644
> index 0000000..ef686bd
> --- /dev/null
> +++ b/device-types/spi/description.tex
> @@ -0,0 +1,280 @@
> +\section{SPI Controller Device}\label{sec:Device Types / SPI Controller Device}
> +
> +The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI controller that
> +allows the driver to operate and use the SPI controller under the control of the host,
> +either a physical SPI controller, or an emulated one.
> +
> +The Virtio SPI device has a single virtqueue. SPI transfer requests are placed into
> +the virtqueue by the driver, and are serviced by the device.
> +
> +In a typical host and guest architecture with the Virtio SPI device, the Virtio SPI driver
> +is the front-end running in the guest, and the Virtio SPI device is the back-end
> +in the host.
> +
> +\subsection{Device ID}\label{sec:Device Types / SPI Controller Device / Device ID}
> +45
> +
> +\subsection{Virtqueues}\label{sec:Device Types / SPI Controller Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / SPI Controller Device / Feature bits}
> +
> +None
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / SPI Controller Device / Device configuration layout}
> +
> +All fields of this configuration are mandatory and read-only for the driver.
> +The config space shows the features and settings supported by the device.
> +
> +\begin{lstlisting}
> +struct virtio_spi_config {
> +	u8 cs_max_number;
> +	u8 cs_change_supported;
> +	u8 tx_nbits_supported;
> +	u8 rx_nbits_supported;
> +	le32 bits_per_word_mask;
> +	le32 mode_func_supported;
> +	le32 max_freq_hz;
> +	le32 max_word_delay_ns;
> +	le32 max_cs_setup_ns;
> +	le32 max_cs_hold_ns;
> +	le32 max_cs_inactive_ns;
> +};
> +\end{lstlisting}
> +
> +\field{cs_max_number} is the maximum number of chipselect the device supports.
> +
> +Note: chipselect is an electrical signal, which is used to select the SPI slaves connected
> +to the controller.
> +
> +\field{cs_change_supported} indicates if the device supports to toggle chipselect
> +after each transfer in one message:
> +        0: unsupported, chipselect will be kept in active state throughout the message transaction;
> +        1: supported.
> +
> +Note: Message here contains a sequence of SPI transfers.
> +
> +\field{tx_nbits_supported} and \field{rx_nbits_supported} indicate the different n-bit transfer
> +modes supported by the device, for writing and reading respectively. SINGLE is always supported.
> +A set bit here indicates that the corresponding n-bit transfer is supported, otherwise not:
> +        bit 0: DUAL;
> +        bit 1: QUAD;
> +        bit 2: OCTAL;
> +        other bits are reserved and must be set as 0 by the device.
> +
> +Note: The commonly used SPI n-bit transfer options are:
> +\begin{itemize}
> +\item SINGLE: 1-bit transfer
> +\item DUAL: 2-bit transfer
> +\item QUAD: 4-bit transfer
> +\item OCTAL: 8-bit transfer
> +\end{itemize}
> +
> +\field{bits_per_word_mask} is a mask indicating which values of bits_per_word are supported.
> +If not set, there is no limitation for bits_per_word.

You have not given an exact coding here. Without this it's hard to 
understand what is really specified and guesswork is needed.

1.) In Linux in spi.h there is a definition

     /* Bitmask of supported bits_per_word for transfers */
     u32            bits_per_word_mask;
#define SPI_BPW_MASK(bits) BIT((bits) - 1)

which brings us probably on the wrong path. Not sure any more. With this 
coding you can have 1..32 as bits per word. 0 is not allowed for 
bits_per_word_mask, at least it seems not to be used.

What you probably (guessing around) wanted to have is

#define VIRTIO_SPI_BPW_MASK(bits) ((u32)(1UL << (bits)))

without the - 1 as you specified 0 as "unlimited". In this case you can 
define every value from 1 to 31. 32 and above is "unlimited" as for 32 
and above (u32)(1UL << (bits)) == 0u.

I'm lost.

2.) "No limitation" is nonsense on a limited machine. Even the universe 
is limited (at least the observable one), for sure your RAM is. And also 
the definition in Linux is limited to 32.

===

*** What Linux can do with it's coding is to define the mask in a way to 
indicate that 8, 16 and 32 bit transfers are supported. With the other 
coding without the - 1 this cannot be done! ***

=> I STRONGLY recommend to use the coding as done by using 
SPI_BPW_MASK() in Linux and to specify this clearly!

> +
> +Note: bits_per_word corresponds to \field{bits_per_word} in \field{struct virtio_spi_transfer_head}.
> +
> +\field{mode_func_supported} indicates whether the following features are supported or not:
> +        bit 0-1: CPHA feature,
> +            0b00: supports CPHA=0 and CPHA=1;
> +            0b01: supports CPHA=0 only;
> +            0b10: supports CPHA=1 only;
> +            0b11: invalid, must support as least one CPHA setting.
> +
> +        bit 2-3: CPOL feature,
> +            0b00: supports CPOL=0 and CPOL=1;
> +            0b01: supports CPOL=0 only;
> +            0b10: supports CPOL=1 only;
> +            0b11: invalid, must support as least one CPOL setting.

This definition 0b00 = Support all instead of 0b11 = Support all makes 
my code more complicated.

- On the device side as I now query both bits having in the end 0x3 or 
0xC and if both bits are set after querying I've to clear them 
afterwards to get the desired coding

- I can also not check by querying a single bit whether for example 
CPHA=0 is supported. No, I have to check for both bits being 0 or for 
bit 0 set.

=> Getting additional and more complicated code by some unlucky coding 
choice in the specification.

Proposal: Make 0b00 invalid, allow 0b11 for "everything supported" for 
CPHA AND CPOL.

> +
> +        bit 4: chipselect active high feature, 0 for unsupported and 1 for supported,
> +            chipselect active low must always be supported.
> +
> +        bit 5: LSB first feature, 0 for unsupported and 1 for supported, MSB first must always be
> +            supported.
> +
> +        bit 6: loopback mode feature, 0 for unsupported and 1 for supported, normal mode
> +            must always be supported.
> +
> +Note: CPOL is clock polarity and CPHA is clock phase. If CPOL is 0, the clock idles at the logical
> +low voltage, otherwise it idles at the logical high voltage. CPHA determines how data is outputted
> +and sampled.
> +
> +Note: LSB first indicates that data is transferred least significant bit first, and MSB first
> +indicates that data is transferred most significant bit first.
> +
> +\field{max_freq_hz} is the maximum clock rate supported in Hz unit, 0 means no limitation
> +for transfer speed.
> +
> +\field{max_word_delay_ns} is the maximum word delay supported in ns unit, 0 means word delay
> +feature is unsupported.
> +
> +Note: Just as one message contains a sequence of transfers, one transfer may contain
> +a sequence of words.
> +
> +\field{max_cs_setup_ns} is the maximum delay supported after chipselect is asserted, in ns unit,
> +0 means delay is not supported to introduce after chipselect is asserted.
> +
> +\field{max_cs_hold_ns} is the maximum delay supported before chipselect is deasserted, in ns unit,
> +0 means delay is not supported to introduce before chipselect is deasserted.
> +
> +\field{max_cs_incative_ns} is the maximum delay supported after chipselect is deasserted, in ns unit,
> +0 means delay is not supported to introduce after chipselect is deasserted.
> +
> +\subsection{Device Initialization}\label{sec:Device Types / SPI Controller Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item The Virtio SPI driver configures and initializes the virtqueue.
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / SPI Controller Device / Device Operation}
> +
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Controller Device / Device Operation: Request Queue}
> +
> +The Virtio SPI driver enqueues requests to the virtqueue, and they are used by the Virtio SPI device.
> +Each request represents one SPI transfer and is of the form:
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_head {
> +        u8 chip_select_id;
> +        u8 bits_per_word;
> +        u8 cs_change;
> +        u8 tx_nbits;
> +        u8 rx_nbits;
> +        u8 reserved[3];
> +        le32 mode;
> +        le32 freq;
> +        le32 word_delay_ns;
> +        le32 cs_setup_ns;
> +        le32 cs_delay_hold_ns;
> +        le32 cs_change_delay_inactive_ns;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_result {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_req {
> +        struct virtio_spi_transfer_head head;
> +        u8 tx_buf[];
> +        u8 rx_buf[];
> +        struct virtio_spi_transfer_result result;
> +};
> +\end{lstlisting}
> +
> +\field{chip_select_id} indicates the chipselect index to use for the SPI transfer.
> +
> +\field{bits_per_word} indicates the number of bits in each SPI transfer word.
> +
> +\field{cs_change} indicates whether to deselect device before starting the next SPI transfer,
> +0 means chipselect keep asserted and 1 means chipselect deasserted then asserted again.
> +
> +\field{tx_nbits} and \field{rx_nbits} indicate n-bit transfer mode for writing and reading:
> +        0,1: SINGLE;
> +        2  : DUAL;
> +        4  : QUAD;
> +        8  : OCTAL;
> +        other values are invalid.
> +
> +\field{reserved} is currently unused and might be used for further extensions in the future.
> +
> +\field{mode} indicates some transfer settings. Bit definitions as follows:
> +        bit 0: CPHA, determines the timing (i.e. phase) of the data bits relative to the
> +	       clock pulses.
> +        bit 1: CPOL, determines the polarity of the clock.
> +        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
> +        bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB first, else LSB first.
> +        bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
> +
> +\field{freq} indicates the SPI transfer speed in Hz.
> +
> +\field{word_delay_ns} indicates delay to be inserted between consecutive words of a transfer,
> +in ns unit.
> +
> +\field{cs_setup_ns} indicates delay to be introduced after chipselect is asserted, in ns unit.
> +
> +\field{cs_delay_hold_ns} indicates delay to be introduced before chipselect is deasserted,
> +in ns unit.
> +
> +\field{cs_change_delay_inactive_ns} indicates delay to be introduced after chipselect is
> +deasserted and before next asserted, in ns unit.
> +
> +\field{tx_buf} is the buffer for data sent to the device.
> +
> +\field{rx_buf} is the buffer for data received from the device.
> +
> +\field{result} is the transfer result, it may be one of the following values:
> +
> +\begin{lstlisting}
> +#define VIRTIO_SPI_TRANS_OK     0
> +#define VIRTIO_SPI_PARAM_ERR    1
> +#define VIRTIO_SPI_TRANS_ERR    2
> +\end{lstlisting}
> +
> +VIRTIO_SPI_TRANS_OK indicates successful completion of the transfer.
> +
> +VIRTIO_SPI_PARAM_ERR indicates a parameter error, which means the parameters in
> +\field{struct virtio_spi_transfer_head} are not all valid, or some fields are set as
> +non-zero values but the corresponding features are not supported by device.
> +In particular, for full-duplex transfer, VIRTIO_SPI_PARAM_ERR can also indicate that
> +\field{tx_buf} and \field{rx_buf} are not of the same length.
> +
> +VIRTIO_SPI_TRANS_ERR indicates a transfer error, which means that the parameters are all
> +valid but the trasnfer process failed.
> +
> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Controller Device / Device Operation: Operation Status}
> +
> +Fields in \field{struct virtio_spi_transfer_head} are written by the Virtio SPI driver, while
> +\field{result} in \field{struct virtio_spi_transfer_result} is written by the Virtio SPI device.
> +
> +virtio-spi supports three transfer types:
> +\begin{itemize}
> +\item half-duplex read;
> +\item half-duplex write;
> +\item full-duplex transfer.
> +\end{itemize}
> +
> +For half-duplex read and full-duplex transfer, \field{rx_buf} is filled by the Virtio SPI device
> +and consumed by the Virtio SPI driver. For half-duplex write and full-duplex transfer, \field{tx_buf}
> +is filled by the Virtio SPI driver and consumed by the Virtio SPI device.
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Controller Device / Device Operation}
> +
> +For half-duplex read, the Virtio SPI driver MUST send \field{struct virtio_spi_transfer_head},
> +\field{rx_buf} and \field{struct virtio_spi_transfer_result} to the SPI Virtio Device in that order.
> +
> +For half-duplex write, the Virtio SPI driver MUST send \field{struct virtio_spi_transfer_head},
> +\field{tx_buf} and \field{struct virtio_spi_transfer_result} to the SPI Virtio Device in that order.
> +
> +For full-duplex transfer, the Virtio SPI driver MUST send \field{struct virtio_spi_transfer_head},
> +\field{tx_buf}, \field{rx_buf} and \field{struct virtio_spi_transfer_result} to the SPI Virtio Device
> +in that order.
> +
> +For full-duplex transfer, the Virtio SPI driver MUST guarantee that the buffer size of \field{tx_buf}
> +and \field{rx_buf} is the same.
> +
> +The Virtio SPI driver MUST not use \field{rx_buf} if the \field{result} returned from the Virtio SPI device is
> +not VIRTIO_SPI_TRANS_OK.
> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Controller Device / Device Operation}
> +
> +The Virtio SPI device MUST set all the fields of \field{struct virtio_spi_config} before they are
> +read by the Virtio SPI driver.
> +
> +The Virtio SPI device MUST NOT change the data in \field{tx_buf}.
> +
> +The Virtio SPI device MUST verify the parameters in \field{struct virtio_spi_transfer_head} after receiving
> +the request, and MUST set \field{struct virtio_spi_transfer_result} as VIRTIO_SPI_PARAM_ERR if not all
> +parameters are valid or some device unsupported features are set.
> +
> +For full-duplex transfer, the Virtio SPI device MUST verify that the buffer size of \field{tx_buf} is equal to
> +that of \field{rx_buf}. If not, the Virtio SPI device MUST set \field{struct virtio_spi_transfer_result}
> +as VIRTIO_SPI_PARAM_ERR.
> diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
> new file mode 100644
> index 0000000..4509156
> --- /dev/null
> +++ b/device-types/spi/device-conformance.tex
> @@ -0,0 +1,7 @@
> +\conformance{\subsection}{SPI Controller Device Conformance}\label{sec:Conformance / Device Conformance / SPI Controller Device Conformance}
> +
> +An SPI Controller device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / SPI Controller Device / Device Operation}
> +\end{itemize}
> diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
> new file mode 100644
> index 0000000..bbd1967
> --- /dev/null
> +++ b/device-types/spi/driver-conformance.tex
> @@ -0,0 +1,7 @@
> +\conformance{\subsection}{SPI Controller Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Controller Driver Conformance}
> +
> +An SPI Controller driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / SPI Controller Device / Device Operation}
> +\end{itemize}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

