Return-Path: <virtio-dev-return-13642-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA18EB8FD4
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:50:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 62A552AC6E
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:50:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DB4D9866FC
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:50:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 79C7A9867B6; Wed,  6 Sep 2023 13:50:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F34BB9865E1;
	Wed,  6 Sep 2023 13:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1694008211.771000
X-TM-MAIL-UUID: 011cf70c-ce01-4cd8-8ad5-750414629c75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsyKSSK97/nA2hxPcXtLy7vsyLtdFpQBMvWfw0MpCAAxwkaQVJ9GudCS7GRSwihHd5KdUdLChwX5f+ft089stMt71JEFOLOhGcho2Tt5xeJy2Fl05uIyZw7ImRivSbJw3+lagQ3JBm2s5VRi3E57KCHRHpM7ZhsM5V3hft0n7uWIsQ9JyOMNL8nZU7gljFPJtOTcGOWtJrqlSeUcUGTyh1xBIaZU59jV7ToryHMcQsvsf6rN5Ub4g6bTCtpYjsFIIw7Ayl15NSVpLJdQAmOVT28tkvc8AzcGlEiHpP2Vx1q7vLrNLKjrFSs8ByIkFTBhRvVKaHxEL/eD3QXWfk0mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uim1WBSVJgzmQmRWAPGD11iLVNdiKr8G4Y1dv15EU7M=;
 b=g80MAyn/IrlvFprPjpnKfqjhADOA2MdUSd26Z66fhbNWaq3GhP4Tfn300ULuHD5m1Ir4hNA/eAej3XjRX4XUwS1lHfiUfeMT5iUkQEa2xqcZ/QAeYa+nLp1jxFJAjLWt4eARnkj1W3zP8uC0ULo/gK/0MS+AToYPRUTJCZAYrEtYf0X7H3/RSppA76qjVmjtjGCpIkZah2thSFrZbp/2TCC1hm5BRUxwobCDnsiYq+aUMDvApR8TOLl4OsKhuZZby2OIEoSnhDbLUOf60Zyps5TtxRLDUOuLrEZLMIR/CnHFAt+1FD3x+VsxcqFCf3IJFbjsDv+0zFf6rroWiIEMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <cb119016-decc-51dd-aabe-0326b339212e@opensynergy.com>
Date: Wed, 6 Sep 2023 15:50:08 +0200
From: Harald Mommer <harald.mommer@opensynergy.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, cohuck@redhat.com
Cc: quic_ztu@quicinc.com, jrreinhart@google.com,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20230901032933.32434-1-quic_haixcui@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230901032933.32434-1-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::17) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|BEZP281MB3253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a70efe0-9b4e-47f5-870b-08dbaee02fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7XLpAlEtEr9WRgtvjc0zguBwSOXuxDPT0HLMFQcle0IsHhKl/ragtJmhPsTl+rqS6YhxAqxkSBZT5CFChQF476swvgH1fUO8ybpXeULOV9N68JBCoycS4nJGG189goZRCHRlFmixj8XVV64UvabSG54Xn+p8l9kLPclXfZFWGiUv+L1a8ZB2jqVRTmxikfVl3rMVj7UqWmuu46p0CZdCe+qSDULOLRC687teimDUQruV6fNVB1B92v8M5f+84+k1o4SfO4l2bnkac/T2dVWjTBzZla4lCusSebYFTW61UobSk3VZOMZIH4LJNVjrbsGkbVW1NiGuHvBiwJc1rgAp+cMhhfWD5VCyOcpOoQMHu56SXRaCb8J7oIAehGjbYbWKzPKHJg/wvklbeLhg/K0qbkusxVKVDwoLvBk3DmMKt4BD0EykqHF2G3j/lcOW9iASz6rORyXhInwOCPG9ooF5LZziTEMfoZh6XuUVK+2Tk2gYgk3kaP5zTeTBoe3bfohfgkAe2nl+DUi6+OWW1SM8Uuz2iRFfMq+B7bDQwEnMkif2PVpSbegJ38crmo8pGfqcgl4tP5E3r+eEgLFWPLvUjgmFKrANBiVs3nbN+OAAYF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(53546011)(83380400001)(26005)(107886003)(2616005)(44832011)(42186006)(38100700002)(66556008)(66946007)(66476007)(5660300002)(316002)(36756003)(41300700001)(86362001)(31696002)(8676002)(8936002)(4326008)(31686004)(2906002)(30864003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y294QWlacTdsUE9VejlmOTB1MWlueXJ1NHU4US9DcUdYN3hnYU5OK3pxYTNY?=
 =?utf-8?B?d1RqTUlYcU1XaTlmNnNsbHo1R0l6ckh3RzhrZHpVMkZkUTczWTh3TnBwVzNL?=
 =?utf-8?B?RGZGanRid1lnY2taU2tWZ2g2Ti85Y01LbldqN3p5dFFtR2c1clFiK05YeS9z?=
 =?utf-8?B?d3Zpd3JnVkZBekdZY2wrV2lFQ0dhWlBRQksvb05jaWNOV2RFeHJoVENVV1hx?=
 =?utf-8?B?Z1FuOHFXZjVIZzNKaCt6TUFtaE51OXo4by9jME1xanZpR0l0bytOOXBmQkND?=
 =?utf-8?B?U1hIVkVoUG9KOGlZcUo2NU9kMDI5Ty9kUE81VjZSSWxxeXlnKzZKN2gwS3F5?=
 =?utf-8?B?bUxZYTB4aStDWDNYT1huNGY2dlVJb0d2TTZIMUdRV2dUVTl5VGllRnJGemZn?=
 =?utf-8?B?MnNPMy9paHViU3FCODdKZE1mY3RFU2dneWx6V0ZqdituSUoxUkRESmFqeVkx?=
 =?utf-8?B?ZXU2RlhJYjJnSE15OGtUU0NlcXoxbnErcnJNWmVDcktnRWlRcDVjSklvNUJn?=
 =?utf-8?B?RjZ2UVp0UUZqbVNQbnlDUmJIa1MydGdFQjdPU3NnTmlQOFhMZ290NFpwYURw?=
 =?utf-8?B?OXEwdUtQdWx6eDBTR3JtUXRtZUh3SWhqazhibUJtUGZCVWNqa0JZalMwY1ha?=
 =?utf-8?B?ODY5REVNWnczSHpNd0VjMk5zMnlkK2J2UmRrN3prZnhHeFYycjBCdVNwcy83?=
 =?utf-8?B?QithdjZuSUFTTGlkTlYxWVJBZlVFd0daSlpGVHNVdW1sbWdaSzhzeGE3cmhx?=
 =?utf-8?B?czFETjU5M2xJWENKK1p2Q0dGN1E4S21hbVhoNHF3UVByVkpVaklkQzFIZjBw?=
 =?utf-8?B?OHF6clZQd1VNeEFGcXBPVkZSaDI4Y1M1LzFOSTgySVdndFBrNTBPeFBoeGFx?=
 =?utf-8?B?SWNQd0RwU1pLbGRYVHNNalVQdTJTbURZS2gvdTAveEtnTUZQL3FhMUJteDlI?=
 =?utf-8?B?T2VQUHEwUXJCYURpTW9vNEZ0WjhHSlUyNG5ldERVWjQ4Z1lXTS9NOXNPOHkv?=
 =?utf-8?B?YjV0bDZpajQwZVRwMlhCeGpJL0lxQm9RN253cENnZGtoaTk0T0xlZW1SQy9x?=
 =?utf-8?B?cGlzZFNGUmMwcFRxTktVQ0FEV2NpbG5CdHN1S3ozb3p5OVhjL1pWNGhRNWpK?=
 =?utf-8?B?VmhXb1E5MVBweVRqNjBOSGFJUThaYmMzcGhwZks0UGZjMW1SMURiaFhHRTE1?=
 =?utf-8?B?V0Ixalc1OTJQa2VGdGw2ZXIyclNYeDlHdnoyR0FIZTdrTitva3hSQWx1UDNw?=
 =?utf-8?B?cTZ3R3lIL25uZGY2WUdkejdmUUlMbVJNVWxhOVAyZFhXM09INkkxUGNjbzRW?=
 =?utf-8?B?QjdkZUhlcE1kK3RRWDhQUnVpcjRKdnNoWkR4TjIwenBOc3NJcVBHQVIrV2dN?=
 =?utf-8?B?QUlrWkQ4b0tMRGlrTTk1QlBNU3E5Y1dydXRSYXhNMGEwVlpwUnhjQVRhTUc5?=
 =?utf-8?B?d2hYWGlLWGNFZEtWbDgrKzNnYW9ZSEJtYUxrclBSbnJQUTVjaTgyeVAzVXBK?=
 =?utf-8?B?VDUrS2RqV1RScUtvU3VSTUdnR2VFa0lvZ0NzSXNUaHhLQW5VVCs3bWV6ZCtX?=
 =?utf-8?B?TjJuV3dBYUxkSSszb21yTzIvU2V0VC9SUGdQeXpaZkExdUc1U0NTMmFGOC9w?=
 =?utf-8?B?NXZJVUc2eHdyMTU5UGJuZzc3ZU1UeHhBc25xcnBFdG9mS1VOdnl2dEVkMEVO?=
 =?utf-8?B?b3k5MWFkNmN6VHBXNTRxM3JiQ3ZaRmQveTNYRXB5WCtkcEhza2dORVJqOU51?=
 =?utf-8?B?aGMwQXVheGJva056NDZ1cjI0RkZSYVN2eERjTy9XR054aW1INzFsVjdSdzQ3?=
 =?utf-8?B?YjdRNEJCRmphdFpLWk1KR2NjKy9KZnlyS0RNYWhacUNQM21JOHVudjdNTTMr?=
 =?utf-8?B?cDAwZ0svYnN5Nm5mY1pxOWpkNlQxTFhUemJzQ1NUUXczN2pmQzNocHFWbzMw?=
 =?utf-8?B?KzYveklLYjh2OTVnUURnTis3ajhuc2UvV2hxa05zc0JHMzQvRkhCQmo2K1NJ?=
 =?utf-8?B?VzJ6MGFNZXBJSTRHczQ0VW5qNUVwMHBZYmFYRWxEZVhMVFZyOFZWSWsveFJ5?=
 =?utf-8?B?N2ZUUzVFSlZPdVlkRk5Lc2lhdlMyWnJyRHNwZ0k1ZUZwVU5tK1pvSVRZSC9M?=
 =?utf-8?Q?eQSG7FyHUzz8QKIJvh9JZxEgt?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a70efe0-9b4e-47f5-870b-08dbaee02fa9
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:50:09.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7iFGXP8poGmCSVUv0ulgxCD8uGYXQcstEJ7I5vgi96UQPcqcS/WkHC54Xx6Wco4RvW3xJODuNcsIwwATlDqaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3253
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27858.007
X-TMASE-Result: 10--31.959000-4.000000
X-TMASE-MatchedRID: I31hiQfYWUP5ETspAEX/non73EnA6dC3lR7tN56aWVW0sdSrJZyyxh4C
	/DafP/+JRkyeawR9g8mLO9h/kZ7mQnkHMxUIdlxL+DE5zr5ahdzc7b6k5+X695GeN+9dVIq3oMQ
	NBr66IpRxQ+QoUzBMF37U1eUtsS59C5yGwbf+Idj4PV3mEBaU4iXlRzss9+j0s6Qk7sqp6OBvJk
	Mj2EncBX25arBJQSO/fj4tjSAsmX7afkl32dZqcrMb4AyK1KgGWEAVr2HIu3Z4MCaOUDLFfQZz+
	fefjHSkGiooGHoMwPn6jcXP3mUmSCUqUY9Zmo1DnRTJpY7VAKdjihLPH6H5TiIC1tfl70akO7F1
	PDJFn7NLRHCCPSkizZhceIuwNxaG6ai7e+96AuxzoxCmHXb7+r81t3rGD+B+4OwVuURzfhfR0yJ
	hnGbpxz7gpwax08CaMRMm1Jjf8OiBPy2oQ2Zgd/JMTQx4p92fP6U7Yx+tLZaupM/RHblvHMj6JT
	ZX91VU4CcaxcKmN5q83HLvMQ+DQCpQwxvE+GAs2JX0lMyuGeq+iRS5oIqd9VvdNLLeFkc7CL189
	WcN2nuqKkzASVqcTvG6D0XwFSJTpwha+tbe/ZP6a0NEvI0IWhrehe+RogBGcKH1qXad8cIesehg
	E79Mrn+kCdLTfNq+N0+PHW7ICmj7MAU31LHn11jZ1kkTqR6fDEwLWfflMUKwBZ5RVTkWhR70tnY
	ktHI80MnbbJ+XCAaK2c+eLQmqKAni+atYCIyzQj0AQ98QP92jg0lrtKMWymtT/CJNcwXFwlly3e
	MNhMDf7qT3sazIOJRMZUCEHkRt
X-TMASE-XGENCLOUD: 17148019-dd1a-4b75-a826-8b92b570f02d-0-0-200-0
X-TM-Deliver-Signature: 9490A9EC867ECDD2C59965E5E6919F44
X-TM-Addin-Auth: 4kUrBDE31x8TZW+t845QMkfTyilYIh+1aUUjRVjQFNyilDkeNJWCP22kLcl
	BsUt11q+74IaibC8mGmm7QFtTVXBhFEMbDprUAwLZMru45XekxBnJGdpIBiqhFQDMzlGeWSMeIm
	cj7SB5HaMAUBQSU2cCKal5eA5A1y3IMpauYWDiPUpB8SdBaT0CBGWCA6QFigdmJVX2MAvGRuajP
	yP7DFx2769/SozPjucAPUvH9BoK/PdW7SPKmDsM9RKMPV+9jdMrMU07xc9HE5X98NS9x/ldA0yl
	V7Frs5ZF/V4UIs8=.S+lowHj40qRBFs4i7uvXo/Sei9gPXey7g1HVp+DTUAU1lqlOJr/D8S4Q8V
	oLu++lEryqLZC/P4IElS1AzR1zrrF5ZfMaAZTtAw6z+Yk6FtllPG7i9qYvBrR1VL4V/T5ZYqUQ0
	ACeB0Y8AUFO20wunOLRiVY7LdOrLzmnPj1iZEiA/GhgNf0sR2dIgsoKzUtCYJL9ieB9Keqk3bBg
	YS9S0fjmd2J7zccPV/B81SkQJxytXP8tVk84w+qSBBin6E78Hhb5Eo05LaSt6V9LqzWEUe8baku
	UG1XDCdpF6TK9AlVoRlWbfXKgcBuafOihcOm4nJeXQSwOJCFNX0CWH5Yl9A==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] Re: [PATCH v3] virtio-spi: add the device specification

Hello Haixu Cui,

On 01.09.23 05:29, Haixu Cui wrote:
> virtio-spi is a virtual SPI master and it allows a guset to operate and
guest
> use the physical SPI master controlled by the host.
>
> This patch adds the specification for virtio-spi.
>
> Signed-off-by: Haixu Cui<quic_haixcui@quicinc.com>
> ---
>   device-types/spi/description.tex        | 191 ++++++++++++++++++++++++
>   device-types/spi/device-conformance.tex |   7 +
>   device-types/spi/driver-conformance.tex |   7 +
>   3 files changed, 205 insertions(+)
>   create mode 100644 device-types/spi/description.tex
>   create mode 100644 device-types/spi/device-conformance.tex
>   create mode 100644 device-types/spi/driver-conformance.tex
>
> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
> new file mode 100644
> index 0000000..c35826b
> --- /dev/null
> +++ b/device-types/spi/description.tex
> @@ -0,0 +1,191 @@
> +\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
> +
> +virtio-spi is a virtual SPI (Serial Peripheral Interface) master and it allows
> +a guest to operate and use the physical SPI master controlled by the host.
> +
> +virtio-spi has a single virtqueue. SPI transfer requests are placed into
> +the virtqueue, and serviced by the physical SPI master.
> +
> +In a typical host and guest architecture with virtio-spi, Virtio SPI driver is
> +the front-end existing in the guest kernel, and Virtio SPI device acts as the
> +back-end in the host platform.
> +
> +\subsection{Device ID}\label{sec:Device Types / SPI Master Device / Device ID}
> +45
> +
> +\subsection{Virtqueues}\label{sec:Device Types / SPI Master Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / SPI Master Device / Feature bits}
> +
> +None
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / SPI Master Device / Device configuration layout}
> +
> +All fields of this configuration are always available and read-only for Virtio SPI driver.
> +
> +\begin{lstlisting}
> +struct virtio_spi_config {
> +	le32 bus_num;

Just a remark: In some environments (Linux) not the complete value range 
of bus_num can be used. For example in Linux 0 <= bus_num <= S16_MAX.

> +	le32 chip_select_max_number;

Just a remark: In some environments (Linux) not the complete value range 
of chip_select_max_number can be used. For example in Linux 0 <= bus_num 
<= U16_MAX.

And subsequently slave_id is an u8 and must be in the range 
0..chip_select_max_number - 1.

If wanted, a le16 for both fields may be considered sufficient. We are 
hopefully not this scarce on bytes, so it does not really matter. I just 
wanted to mention especially for the 2nd field here.

> +};
> +\end{lstlisting}
> +
> +The \field{bus_num} indicates the physical SPI master assigned to guset, and this is SOC-specific.
guest. And why is this SOC-specific? On Linux this is the 1234 in 
/dev/spidev1234.x when bus_num is set to 1234 by the virtio device. So 
it's purpose is to distinguish the different /dev/spidev when more than 
only a single virtio SPI device is provided to the driver guest. But 
SOC-specific?
> +
> +The \field{chip_select_max_number} is the maximum number of chipselect the physical SPI master supports.
Was without "maximum" in the text of the last version. What should 
happen in my Linux driver implementation is that there should be exactly 
this number of /dev/spidev1234.x device files. with x = 
0..chip_select_max_number -1.
> +
> +\subsection{Device Initialization}\label{sec:Device Types / SPI Master Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item The Virtio SPI driver configures and initializes the virtqueue.
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / SPI Master Device / Device Operation}
> +
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Master Device / Device Operation: Request Queue}
> +
> +Virtio SPI driver enqueues requests to the virtqueue, and they are used by
> +Virtio SPI device. Each request represents one SPI tranfer and is of the form:
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_head {
> +        u8 slave_id;
> +        u8 bits_per_word;
> +        u8 cs_change;
> +        u8 tx_nbits;
> +        u8 rx_nbits;
As already mentioned, u8 reserved[3] missing here not necessarily for 
future use but for alignment. Might be a good idea to require that those 
reserved bytes shall be set to 0 by the driver.
> +        le32 mode;
> +        le32 freq;
> +        le32 word_delay_ns;
> +        le32 cs_setup_ns;
> +        le32 cs_delay_hold_ns;
As already said, the last 3 fields may be difficult to support in some 
environments and some hint what to do in this case is appreciated.
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
> +The \field{slave_id} indicates the chipselect index the SPI transfer used.
> +
> +The \field{bits_per_word} indicates the number of bits in each SPI transfer word.
> +
> +The \field{cs_change} indicates whether to deselect device before starting the
> +next SPI transfer, 0 means chipselect keep asserted and 1 means chipselect deasserted
> +then asserted again.
> +
> +The \field{tx_nbits} indicates bus width for write transfer:
> +        0,1: bus width is 1, also known as SINGLE;
> +	2  : bus width is 2, also known as DUAL;
> +	4  : bus width is 4, also known as QUAD;
> +	8  : bus width is 8, also known as OCTAL;
> +	other values are invalid.
> +
> +The \field{rx_nbits} indicates bus width for read transfer:
> +        0,1: bus width is 1, also known as SINGLE;
> +	2  : bus width is 2, also known as DUAL;
> +	4  : bus width is 4, also known as QUAD;
> +	8  : bus width is 8, also known as OCTAL;
> +	other values are invalid.
> +
> +The \field{mode} indicates how data is clocked out and in. Bit definitions as follows:
> +        bit 0: CPHA, determines the timing (i.e. phase) of the data bits
> +	       relative to the clock pulses.
> +        bit 1: CPOL, determines the polarity of the clock.
> +        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
> +	bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> +	       first, else LSB first.
> +	bit 4: LOOP, if 1, device is in loopback mode, else normal mode.

Subset of what Linux has: SPI_3WIRE, SPI_NO_CS and SPI_READY and more 
recently SPI_3WIRE_HIZ, SPI_RX_CPHA_FLIP and SPI_MOSI_IDLE_LOW. What's 
defined in Linux but is not available here seems to be more strange 
stuff not widely in use so most probably nothing important has been 
forgotten. Fine.

Looking into my driver code some things I had to set in the hard coded way

master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
             SPI_LOOP | SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL |
             SPI_RX_QUAD;

"master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);"

without knowing exactly whether all this is supported in the end by the 
virtio SPI device. The driver may announce a superset of what's actually 
really supported by the backend device.

However having more information available in the config space would 
complicate the specification and is probably not being worth to be done. 
User code using the virtio driver should know very well anyway what's 
really supported without having any additional config space information. 
Should be good enough.

> +
> +The \field{freq} indicates the SPI transfer speed in Hz.
> +
> +The \field{word_delay_ns} indicates delay to be inserted between consecutive
> +words of a transfer, in ns unit.
> +
> +The \field{cs_setup_ns} indicates delay to be introduced after chipselect
> +is asserted, in ns unit.
> +
> +The \field{cs_delay_hold_ns} indicates delay to be introduced before chipselect
> +is deasserted, in ns unit.
> +
> +The \field{cs_change_delay_inactive_ns} indicates delay to be introduced after
> +chipselect is deasserted and before next asserted, in ns unit.
> +
> +The \field{tx_buf} is the buffer for data sent to the device.
> +
> +The \field{rx_buf} is the buffer for data received to the device.
> +
> +The final \field{result} is the transfer result, either VIRTIO_SPI_TRANS_OK for success
> +or VIRTIO_SPI_TRANS_ERR for error.
> +
> +\begin{lstlisting}
> +#define VIRTIO_SPI_TRANS_OK     0
> +#define VIRTIO_SPI_TRANS_ERR    1
> +\end{lstlisting}
> +
> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Master Device / Device Operation: Operation Status}
> +
> +Fields in structure \field{virtio_spi_transfer_head} are written by Virtio SPI driver, while
> +\field{result} in structure \field{virtio_spi_transfer_result} is written by Virtio SPI device.
> +
> +virtio-spi supports three transfer types:
> +        1) half-duplex read;
> +        2) half-duplex write;
> +        3) full-duplex read and write.
> +
> +For half-duplex read transfer, \field{rx_buf} is filled by Virtio SPI device and consumed
> +by Virtio SPI driver. For half-duplex write transfer, \field{tx_buf} is filled by Virtio
> +SPI driver and consumed by Virtio SPI device. And for full-duplex read and write transfer,
> +both \field{tx_buf} and \field{rx_buf} are used.
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
> +
> +The Virtio SPI driver MUST send transfer requests on the requestq virtqueue.
> +
> +Fields in structure \field{virtio_spi_transfer_head} MUST be filled by Virtio SPI driver
> +and MUST be readable for Virtio SPI device.
> +
> +Structure \field{virtio_spi_transfer_result} MUST be filled by Virtio SPI device
> +and MUST be writable for Virtio SPI device.
> +
> +For half-duplex read, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
> +\field{rx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
> +
> +For half-duplex write, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
> +\field{tx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
> +
> +For full-duplex read and write, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
> +\field{tx_buf}, \field{rx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
> +
> +For half-duplex write or full-duplex read and write transfer, Virtio SPI driver MUST not use \field{rx_buf}
> +if the \field{result} returned from Virtio SPI device is VIRTIO_SPI_TRANS_ERR.
> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
> +
> +Virtio SPI device MUST set all the fields of the structure \field{virtio_spi_config} before
> +they are read by Virtio SPI driver.
> +
> +Virtio SPI device MUST set the structure \field{virtio_spi_transfer_result} before sending
> +it back to Virtio SPI driver.
> +
> +Virtio SPI device MUST be able to identify the transfer type according to the received
> +virtqueue descriptors.
> +
> +Virtio SPI device MUST NOT change the data in \field{tx_buf} if transfer type is half-duplex write
> +or full-duplex read and write.
> diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
> new file mode 100644
> index 0000000..3e771bc
> --- /dev/null
> +++ b/device-types/spi/device-conformance.tex
> @@ -0,0 +1,7 @@
> +\conformance{\subsection}{SPI Master Device Conformance}\label{sec:Conformance / Device Conformance / SPI Master Device Conformance}
> +
> +An SPI Master device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / SPI Master Device / Device Operation}
> +\end{itemize}
> diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
> new file mode 100644
> index 0000000..3c965ef
> --- /dev/null
> +++ b/device-types/spi/driver-conformance.tex
> @@ -0,0 +1,7 @@
> +\conformance{\subsection}{SPI Master Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Master Driver Conformance}
> +
> +An SPI Master driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / SPI Master Device / Device Operation}
> +\end{itemize}

Regards
Harald Mommer



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

