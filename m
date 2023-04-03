Return-Path: <virtio-dev-return-11912-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E8DC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:55:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C16873DF28
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:55:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0ECF9863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:55:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A6E8E9863D6; Mon,  3 Apr 2023 15:55:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 966DB9863DE;
	Mon,  3 Apr 2023 15:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJsTnt+/vfx+ygmNhkXmm+Jrr6CuwlkesWE10bQWWFKCkmPNfOPt9aizewZ/cNtHjhKM9wtltJ/A4dF6bVp6wA0o7D8sgSf9CAR+0/FxynYeUCNkwnxdpRhRAdVnSSRHloZpAMsCCC5t6ytylJqCtNi/OO7w4pzZgpy1s+ihMjciy19daYOoqqqiTziYI8n3WyP4S8UYy0np/3+U9MOPQXtkUJeCnY0nvxRG9f9k8pNpMhZa+41efcnmBLU0jjkqZXj8XGPJZlIBTtCCjxhJTDBX57u1xx5OAGstJ44CcRGUg1nwaGS4EoDpj6qr78fk2oH7r0Mdg5/69Wn+tI8fFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ0+Vs1hUj934t7BrPH5j01bmVRQE4fPcuuMsLruS2Y=;
 b=hLNuyWKK5o1Hv07LaPfdTt0+iMf+MIQ4BfyDO5gD+muoTQHHru1bQ+iPHaBm701DDOa/7MfONSuCZkjgXyXgAwBrjlVgteDenBrTxjD/3qvj5FIbVVkCf31tURT+9HJvYrqO/O7UumJjl9t2SD8H0IR5B6tONBWNPECpR9MNmVoG353RB9xzcuHh27bfHLq1MfuITbu3fs0AHuW/czwZCtVLV1wMQpY+qpUPo37vw3g5CNWAaIkmDU2Byc0LeMMNhyqdU3b18HOVekoPcS9PYHu6Hw+K7ZSfM7zst3RxjWm0RDX/lbgzFmlAncmwi66gGYSSRe3h6JHdavuF+Q3WJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <0fe1e488-a1e7-11a9-d2a2-3b8b7ee6a1c7@nvidia.com>
Date: Mon, 3 Apr 2023 11:55:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <71c1c5f86e19651585426160fc4cc15dc2da6ee6.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <71c1c5f86e19651585426160fc4cc15dc2da6ee6.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::21) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM6PR12MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fd31b1-c55f-431d-1827-08db345bdbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7PzoEIHoBVw++J8sJbBtOL9ApJPUaXbrbxKDtANxv5MttMHC/Hh9kDPNN2l8U+y886L5tL31XCvCJpU1ZE8KuJBRZcrc0eLbFpTNqQUJ/w8mrABAVXd8R+mQx0tp7f1ketc2zIi5ejWPJ3vTsVVxAwmsJk7I+atMab4PHQ0+ytKiu4TeccpOeb1zfdXX1NKWpQL/b2ffs4gt0jeeV6sgZdHGDI8FZ0PxCpJsXb4M4b/IoQkAOXObPY4oQNPIEE0nnWe5kWqzTBcQqjhqLRaolfOGkwxR+NwFc0HGzOeWK03hmdMjQxWVzxtPdmdqRhggvmsue51+Mnx9XcaGvhL/4DS1hy39Dz2Xw85UIo1UH84dVt3c/FwY2wOskLJKcyBmrBWUAOj026gsDlfFrgZqbKdctYcdfpbr/eq7aOubZ5AKco0I3SikFvDOoNYWsRnRuV6rfvs0DcVDOT4I+ACenGENTLqa206RE4RfvxOUZtelCwd7oq5nlZVdAFiYcY65MGrsfucNpV383fqpMsqDyR/cTBB/IPFeN8P7s4e13aiRM8YlrKrsaotv2a780diLmH86eL7YQp+ukpfGAe67BAqJHWUBgcdH6VgQGARomjIoSTheMxwUFXOxaVzF62qHsku5rjliP5moKOb7o5cI3jlMwWZFV+gnt/SM9yp1IKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(86362001)(31696002)(36756003)(2906002)(31686004)(2616005)(53546011)(83380400001)(186003)(26005)(6666004)(6506007)(6486002)(107886003)(6512007)(4326008)(8676002)(66476007)(478600001)(66556008)(66946007)(7416002)(41300700001)(921005)(38100700002)(5660300002)(54906003)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlNCUm45cEFuMmhpVWRzZTE2WnFIdHY0Q0cvWWNzOWJrZlV2NkY0UXpNRHhM?=
 =?utf-8?B?a1JnSklGSXAxQXp2c1JHMXExdm92SWg3VG4wdE44NFQrWE5rL0twR1JyTGpt?=
 =?utf-8?B?M0gxUHBHcHJQbFZTS2ZLUklmbHZoVkcyWnpFUWNpaUcyYUZTSFRVcnI2a1Bm?=
 =?utf-8?B?VEdMaW1BSVpxaWhFakF4SGlqRlRPamJDS1U4ZDdxelYrT21LemhPSlJzcWU2?=
 =?utf-8?B?ZjRzUVFoTTlYcGV2NEhRcDZ5NE9ObUhRdGNDTko1aFZ2RVlYTENlK1B0U1JI?=
 =?utf-8?B?aXgyS1Zad3NDSmJrQ0w5QmRTbjZnaXgxSzNhSWs3YkxSdTEvNHFLU1gyM0d3?=
 =?utf-8?B?YStOOWNTdGJGUTRSR0Jxd3pwd3JVY0t0SHIyYThxZ0hOWG1oSE82SEJZZDh1?=
 =?utf-8?B?TzdOM2tOa25ucEU4bSsrSE5UdmcvNGNuN09IRVp1R2pvK1Nyd2FVcXVCQ2F1?=
 =?utf-8?B?ckE0aTBneFd5S0VtbzhQOEtjSG9qUitoQm1YdVc1SmE4emhEbURPN2lBRWZG?=
 =?utf-8?B?UFJOT2xBVmQwcFpvUGlPdEVxQ2hkWldVdXNMVHViZmxCZmduc2pIanhQaHA0?=
 =?utf-8?B?WnFFTUN0UkVjVG00ZG9TRkQyR2N5OGRjR1p2aXI0RXFrQVdYTlFyaDFMOVRr?=
 =?utf-8?B?cHdzamxGR1dBZnFiQlgrSy8wK3RZcnppVGVFcitVRGMxTE9yWHljN2JCNFhz?=
 =?utf-8?B?TnR6aHpDYmltaFlNaStrTFZHVEFoK1J0bVlwZzJUY0Q0UWdyRjVmcjFtRlBm?=
 =?utf-8?B?YUNKSkVLeVZ4S2Qrc083NSt0MzdPdFBOWldrZnVCWlYrUlRXMjBIQ3NFQit4?=
 =?utf-8?B?MFJ0UGtUdHJ4R1RpWG85MCtweWlPYkdTbjBQUmEvK1A3Q1J0YnE2Z3M2WVRh?=
 =?utf-8?B?L1VWUUJWUHYzeEJxbjc2RjFEY2RaekFJa2dJekxMT0hrRmthandqZGFJMXgy?=
 =?utf-8?B?NXF4VjFJcmZFc2UvYkY0SHNyQnNEeUx6cVBoYi9WajRNQXRYSDJpb1lERWl0?=
 =?utf-8?B?dlVtZ2taN2s4cFVEa3FzbDdLcGFiaGY5R3EzemtEU2I0M21OcXdyeVp0dzNr?=
 =?utf-8?B?eTMyNE1hUGVreHhqR2lrL0pjeHNLd1FLRkhwcVFibmRDdXRodzNWa1lYeHZB?=
 =?utf-8?B?R0h5WnQyTC9VK2kydUtOazZDZzl6aWgxaDhKWGZWejBJZ2dwc0s5MDZOUUdq?=
 =?utf-8?B?TlgrUm1XUVJleUVCdXZ3ZGhWNW5LczR6b3NKYXBhd2pqWnlqUk1kZWVPSE8r?=
 =?utf-8?B?ZEtWMnNpblZtaURPSjRTZ0FLV01ScUpsRTM1QnlRcGdDOXdsdFkrZFhuUHdl?=
 =?utf-8?B?a0ZCY2MydzVLcVpubDV5YWRnL05naHBjRkVwYkViN3ZDeHpmTEFKOXc3VUth?=
 =?utf-8?B?aUlKZG82ditaNzI0L041M1ROVUNvZWw2aEM1N1JHMTc1RzBRcnBrbDJqNHN3?=
 =?utf-8?B?YkpWbnRKa3huVzFtNFh6SVhaSlBCWmxsVGNrT3JmeHVPV3Bka0t2WlRvc0NL?=
 =?utf-8?B?NTdzYWJwWGNvbG01RmM1cFFYVGFyamtsaVFadGpacTIvandMUTU4aCtWN3BZ?=
 =?utf-8?B?ekdUdWVndXprQk9KcFR6VHREVE5tYXlCanhCTk5yRktLcml2NGtpY2Q4WHJp?=
 =?utf-8?B?dUdkazRJU0k5TWs5VzlkZjhZZDNqVjdhRStnTEp5Q2VkYWh0dWRiaTBaZFZt?=
 =?utf-8?B?TWJSbDBjL2V4TUJ0V1RENXp4TlB5NUdWWTBGSzFkSTBodHdXSDlaY0lIWHYy?=
 =?utf-8?B?TWFUUU52OTBJNkd1U1JXMkZkOFB6ZXlGY1BvL3Q2a1Vlc2tlczVzVHU5YUh0?=
 =?utf-8?B?b1kwR3JwTy9uNXptZUtMQjFxdDkzRzM2dkxMRENxWFhVQVN4MnpKNkxxdTZV?=
 =?utf-8?B?R3Nxb0dOZm1JSmc5ZFJZeGJsenJMdjhNTy9IZFdIenpTN0kzanZOWW5veGVW?=
 =?utf-8?B?b3gwaWtOMmw4RVR2bUQ0dDB2MHN4dlhmRktZbG5GdDdsUm00cnRwU0dIeU5h?=
 =?utf-8?B?S0NWZzhIZXZiS21zakF3QWpncHkxenAvQlY4bUVjQkgzbEhvbDZzcENOcnVp?=
 =?utf-8?B?UTRCUFN4dUZTMkZESlBSY1hFeG04Tm5vMVJwVHR2akZWUG42ajFZR01oWHdh?=
 =?utf-8?Q?5wG/rJsMscQQPVU1DCAOn0YPD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fd31b1-c55f-431d-1827-08db345bdbf7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:55:34.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVhbCjqMYe+640wVNSwiL17JRX/iUcb+5Nto5qZcBEl3wTN6faObp6HmwK9Atue9lZ5ApBm5XNniPe7GF5EBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
Subject: [virtio-dev] Re: [PATCH v11 07/10] ccw: document ADMIN_VQ as reserved



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
> 
s/implementers/implementation

> Note: there are more features to add to this list.
> Will be done later with a patch on top.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   content.tex | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index f7446bf..1213d48 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2978,6 +2978,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
>   MAY also choose to verify reset completion by reading \field{device status} via
>   CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
>   
> +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
> +
> +At this time, devices and drivers utilizing Virtio over channel I/O
> +do not support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ
> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
>   \chapter{Device Types}\label{sec:Device Types}
>   
>   On top of the queues, config space and feature negotiation facilities

Same nit as that of mmio.

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

