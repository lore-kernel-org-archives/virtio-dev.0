Return-Path: <virtio-dev-return-14243-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB3C3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 13:21:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1C3D321695
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 13:21:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10DCE9866CF
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 13:21:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F2B239863A8; Mon, 15 Jan 2024 13:21:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD98398636D;
	Mon, 15 Jan 2024 13:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTgiHywTdyr6Q4uefJr0NvawAo1P1yo7cGUjGA7W1VeWGsg4ySZIfAg/ZTvPYd/ed6q/E4KfiycpuNHL0oaiPWfRbZtehQP8H/McYWLyNxTgR4VsfPR2MRkWgNcPtHP2N/8E9NI+8Zl10x4BZg5TQy+I4DpfIovVS2lvtFXvTfqvClxUaAeTreeV01fxxxZQxpeGbt04eoAqJxqGAm3+VvH9lrSuRXaYjQW75Oe+rGyZmLkI50NlpngiV9ISBaTEObfep6e2h+cOWfUbNB6/M7v4SuWDrOcxLACy90E/6qH4Q6WUNt/gUvkC5Xa3GIsT1dPF20DK33A7vDo9NhFZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yElgxPL5EYiqXKp+iZ/Jzr4R1giNm1Apr3Nmh5MMZqQ=;
 b=Z04vb5ggEPyCzEbQBQsHdmxZWOk4bgD9mg61QsBfKTEvr4q71u6PZIYnDepYXb4fDg9Foh2eB/l2seLE85lZLLq7mY7avwEYUaNdK1vow6M//t5IvAKGC8xBNkQfUa/vrphNTLx+Iiy/o+fGNEHlom5HPLveDe3xFd5t3pKpD74ynNHCEuQ2PMVFncrI88K9N/f8rGCKvFaZIoKdUGKBXqz2GzCIWBdvDCyW8cJErGAa4vCXRTU3H5rHWpnp/szTDKWi3YGXmFIGwac+EbN9hK0nC6wsN/xGkZM4JZ4TlPSSuDPokiNWR5wyKhJdZFYo5r7sFL2R/qXnyRd7iK8eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] [PATCH v2] virtio-net: support setting
 coalescing params for multiple vqs
Thread-Index: AQHaR7Oe9QgTrn5GM0iGz2gHNb3tkrDa2d1g
Date: Mon, 15 Jan 2024 13:21:48 +0000
Message-ID:
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5302:EE_
x-ms-office365-filtering-correlation-id: 37bfeb0c-6c45-4185-716b-08dc15ccee04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0XfUkX4pjBtLhciXnxt2gGNmZuJP1JoKpQ+QtsE4/d5juA1IhKsgUPywcOZsIMiPyOuOyWTjM7JaHdNvv3zvwaE9puUj66lR2qBmdqu0vQh00O5EeO5g4MjoAJaPg57Ucp1Ji3c8NHf2mTVo6xZWdkc8w+AW2Ad+rYVcEvAssGdLFhtdDNUq6/ON9OTNQsgp5XKyoODEbYsBtI3OjY4eqWTiWDfIAh/9420l8lD+K3AFLx6VxzBkElQsucoGzaBtRkTrKr/qbUyttqHYhPajkm26JyVeZmPBP0FjHAvdn6d4Q47X09AG7z9vylowGYp+gIvURz4UkwRxuvNPteN5pjaCMuVrlxWOXGbaPyy8wCxAKJsomsdLWdLstp7ttxr+yQE6V9TEn+iJScGspPvDWFKThwq5SyMz/sRQvyi8fX+UTff8pSOaftsa6+e//EWcPPLJhsD5KLSLDr+bXIpVrT+RpZWhVexfcGkAzVFqnhJ50xMjtOmXUDiYdkb/TJgKiu7TWVQ6fXrWU4a47oRXEkxiR+6F6ZJlBYO0RnfP1QMW/l+mdGgkzX2Mx8/pwbJdfRiZ09QHzlZXnAYPaZh/xM1eCMS2J+wqOuGOlWPo+jGeTUYvQLQwL6WOpqr3pe/poN5kMMqRhI4CVMrX6W8P/iCRp34zLn61caa0g4cYE7c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38070700009)(66899024)(2906002)(66946007)(76116006)(5660300002)(83380400001)(122000001)(316002)(4326008)(84970400001)(38100700002)(71200400001)(6506007)(110136005)(7696005)(54906003)(8936002)(64756008)(52536014)(55236004)(66556008)(26005)(8676002)(66476007)(9686003)(55016003)(41300700001)(66446008)(86362001)(478600001)(33656002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nWX3fXnlLqocj1++rtcHGp6OTImBTg56AWaeQEHaVDUsPczoGQf2nZAUQphI?=
 =?us-ascii?Q?4jKUgyKkTvqkV920MJ4ZQWNbFB6nZ/YfZkPZIS+D7QGZmjNKHgs2k0gaoB/1?=
 =?us-ascii?Q?SblG6IQdCFxtlj1upuRjN75QLlB31Ww0hduH2RPk/x9HxXKDlUmpkBqz0YgR?=
 =?us-ascii?Q?c4L1QkxrhY2zm9m4MDRRop9442bTc8t3VCsgUta3cRmhPzomfZFC6eZkYymz?=
 =?us-ascii?Q?4P5LjeNAxN2BHdEidjqBcgNYI3FsL3qDw9VJ4sY+K94MosjxfLhOdbnZWOas?=
 =?us-ascii?Q?EZ11ffcSqPfQs5DnhZ5csyLaOTk2tSEGeF0MGVTntB8kdqxj5umR6k6m3d8X?=
 =?us-ascii?Q?5uBPLuWMAwZHavsXt496p7j+sI+Ts8pFUIgtp5nGJl1kN7WQyzu9lxcXb9Bc?=
 =?us-ascii?Q?pKI3ngnZCox811jlYDuh+fJu8+vWex9fR95PR4u5ANJjEqGY2I0QL5/JOupn?=
 =?us-ascii?Q?6APQPtLTxZBYKwXueOGr/xz/vln9OAbz0CbL2NjPOEO4aAVBzpr/rgp3JoPc?=
 =?us-ascii?Q?6nlftWfWhtWCsL2LAZlu+PaOFko4WRvfM6jBZltVAQBdLJp+lEYqR81SYWOa?=
 =?us-ascii?Q?H/ngvtelVHABSULQP+f7VLHDLIae5PmTPBV5yjHGpWizT7PYWpK+cYyXArEV?=
 =?us-ascii?Q?zagSTn+lcXSt0ovJ7nYlsGwtD5bBq9F5YPu14Jdtwbjfxx12sdLGzyxXPv5q?=
 =?us-ascii?Q?BC6eiGuUGosIN86C5RMco3UDoEi3uFn4zf+uI4MHTcnX7VHoAaUqUhCyuIV6?=
 =?us-ascii?Q?UC0uLwnrdxLRvxW9mKKsd1S0/IUPIOblum3OsTHyjFrBscyQTdnQFjaFL+/v?=
 =?us-ascii?Q?pteICdHlAf+z8fZMjeL6PhV/aQKReSaxKLq3T5dD3USSLp8jK6IpbmT+7H9t?=
 =?us-ascii?Q?b9toEFhvznUZtWKizT8t0IIzQpSy81DCPAo+VPMvSPmfQ9BOKHhDSnDfCe3U?=
 =?us-ascii?Q?7uH8PMeIcsU0mr9v9Kdj/hOVaPqcHGKHnPuEOq9oLFMKBRssC+QFsn/QwKKv?=
 =?us-ascii?Q?AIy8B+840N6W0xgIww7uV6TzBa46K7lf9ULNAcMwQjqlMl9FNJvRDuDtWFJC?=
 =?us-ascii?Q?qsLlc5UPi/MY9GJpAmrLwkz34JAEJVKhxvKmBhhfYC8DNl1nrEgbPmQHwCL+?=
 =?us-ascii?Q?hoMBOjFnmyYI3DtbviH+YlbO841xNq6jOTkHwZhBcG+vfsRTLCQcCz/Mfwkd?=
 =?us-ascii?Q?jcGdiQNU5TMbDFnPJ1/A/NymqYwEQ195KFrlj9uWARZrmNeYAjE0I8TRzdo7?=
 =?us-ascii?Q?qNyDDrARqpNHdIwR/g7laAt4TAj9KAKeApGRdzYjcvCASt2/lkt4SD7xytcA?=
 =?us-ascii?Q?fKobHLfNHRTBFf8zY80JZENgy8gLiB6xoKEH3BFHIC9RFWU3OnLClAG4mVSS?=
 =?us-ascii?Q?3NvCLAMIyPz4fSfN9q1cjnsGhAkitsrxen/kaz+UCZGCGbc5gnZHvFCJoXma?=
 =?us-ascii?Q?hIQV9jKwow2UWGI6qKofnGn3tSDjTI4LfzAqNcs97GFE8yPx57bEYiNvOcTJ?=
 =?us-ascii?Q?HHaPk0H3M7SYO3aF0DTWSiGQXVtqKGXTR33rXLTQ1AFYeE9VlhJso0sG3zx2?=
 =?us-ascii?Q?96r3x5jSmNf+2+nFvRo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bfeb0c-6c45-4185-716b-08dc15ccee04
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 13:21:48.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+ndXq9Em3Z0QthttBE4onTt5JKDS+wGPu9txjZlwm+eYecXqfh0SNU3XpKBk8CinHJhj9zN2PY/usX8aVgXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v2] virtio-net: support setting
 coalescing params for multiple vqs



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Heng Qi
> Sent: Monday, January 15, 2024 6:36 PM
>=20
> Currently, when each time the driver attempts to update the coalescing
> parameters for a vq, it needs to kick the device and wait for the ctrlq
> response to return.
It does not need to wait. This is some driver limitation that does not use =
the queue as "queue".
Such driver limitation should be removed in the driver. It does not qualify=
 as limitation.

This will enable driver to enqueue multiple cvq commands without waiting fo=
r previous one.
This will also enable device to find natural coalescing done on multiple co=
mmands.

> The following path is observed: 1. Driver kicks the device; 2. After the =
device
> receives the kick, CPU scheduling occurs and DMA multiple buffers multipl=
e
> times; 3. The device completes processing and replies with a response.
>=20
> When large-queue devices issue multiple requests and kick the device
> frequently, this often interrupt the work of the device-side CPU.=20
When there is large devices and multiple driver notifications by a cpu that=
 is N times faster than the device side cpu,
the device may find natural coalescing on the commands of a given cvq.

For multiple DMAs, we need to way to send 8 bytes of data without 16 bytes =
of indirection via a descriptor.
This is what we discussed a while back to do in txq and Stefan suggested to=
 generalize for more queues, which is also a good idea.

> In addition,
> each vq request is processed separately, causing more delays for the CPU =
to
> wait for the DMA request to complete.
>=20
> These interruptions and overhead will strain the CPU responsible for
> controlling the path of the DPU, especially in multi-device and large-que=
ue
> scenarios.
>=20
> To solve the above problems, we internally tried batch request, which mer=
ges
> requests from multiple queues and sends them at once. We conservatively
> tested
The batching done may end up modifying the given VQ's parameters multiple t=
imes.
The right test on Linux to do without rtnl lock which is anyway ugly and wr=
ong semantic to use blocking the whole netdev stack.
(in case if you used that).

> 8 queue commands and sent them together. The DPU processing efficiency
> can be improved by 8 times, which greatly eases the DPU's support for mul=
ti-
> device and multi-queue DIM.
>
This is good.
=20
> Maintainers may be concerned about whether the batch command method
> can optimize the above problems: accumulate multiple request commands to
> kick the device once, and obtain the processing results of the correspond=
ing
> commands asynchronously.
This is unlikely to improve, rather it will have negative impact as it only=
 means that moderation parameters are just delayed by the driver.

> The batch command method is used by us to optimize the CPU overhead of
> the DIM worker caused by the guest being busy waiting for the command
> response result.
In that case fixing the guest driver which is not yet written is the right =
fix.

> This is a different focus than batch request to solve the problem.
>=20
> Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> v1->v2: Updated commit log. Due to sensitivity, sorry that can not give
> v1->the
>     absolute value directly. @Michael
>=20
>  device-types/net/description.tex | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/device-types/net/description.tex b/device-
> types/net/description.tex
> index aff5e08..b3766c4 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1667,8 +1667,8 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi  for notificati=
on
> coalescing.
>=20
>  If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver can -
> send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET -for virtqueue notification
> coalescing.
> +send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> +VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET for virtqueue notification
> coalescing.
>=20
A new feature bit is needed for this extra functionality.

>  \begin{lstlisting}
>  struct virtio_net_ctrl_coal {
> @@ -1682,11 +1682,17 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>      struct virtio_net_ctrl_coal coal;
>  };
>=20
> +struct virtio_net_ctrl_mrg_coal_vq {
> +        le16 num_entries; /* indicates number of valid entries */
> +        struct virtio_net_ctrl_coal_vq entries[]; };
> +
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>   #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>   #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET 4
>  \end{lstlisting}
>=20
>  Coalescing parameters:
> @@ -1706,6 +1712,7 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi  \item For the
> command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure
> virtio_net_ctrl_coal_vq is write-only for the driver.
>  \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET,
> \field{vq_index} and \field{reserved} are write-only
>        for the driver, and the structure virtio_net_ctrl_coal is read-onl=
y for the
> driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET, the
> structure virtio_net_ctrl_mrg_coal_vq is write-only for the driver.
>  \end{itemize}
>=20
>  The class VIRTIO_NET_CTRL_NOTF_COAL has the following commands:
> @@ -1716,6 +1723,9 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>                                          for an enabled transmit/receive =
virtqueue whose
> index is \field{vq_index}.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure
> virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packe=
ts}
> parameters
>                                          for an enabled transmit/receive =
virtqueue whose
> index is \field{vq_index}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET: use the structure
> virtio_net_ctrl_mrg_coal_vq to set the \field{max_usecs} and
> \field{max_packets} parameters
> +                                         for \field{num_entries} enabled=
 transmit/receive
> virtqueues. The corresponding index value
> +                                         of each configured virtqueue is=
 \field{vq_index}.
>  \end{enumerate}
>=20
>  The device may generate notifications more or less frequently than speci=
fied
> by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
> @@ -1782,9 +1792,13 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  The driver MUST set \field{vq_index} to the virtqueue index of an enable=
d
> transmit or receive virtqueue.
>=20
> +The driver MUST set \field{num_entries} to a non-zero value and MUST
> +NOT set \field{num_entries} to a value greater than the number of enable=
d
> transmit and receive virtqueues.
> +
>  The driver MUST have negotiated the VIRTIO_NET_F_NOTF_COAL feature
> when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.
>=20
> -The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> +The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> feature
> +when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>=20
>  The driver MUST ignore the values of coalescing parameters received from
> the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if the device
> responds with VIRTIO_NET_ERR.
>=20
> @@ -1794,10 +1808,10 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if
> it was not able to change the parameters.
>=20
> -The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> command with VIRTIO_NET_ERR if it was not able to change the parameters.
> +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET commands with VIRTIO_NET_ERR
> if it was not able to change the parameters.
>=20
> -The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with -VIRTIO_NET_ERR
> if the designated virtqueue is not an enabled transmit or receive virtque=
ue.
> +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> +VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if
> the designated virtqueue is not an enabled transmit or receive virtqueue.
>=20
>  Upon disabling and re-enabling a transmit virtqueue, the device MUST set
> the coalescing parameters of the virtqueue  to those configured through t=
he
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not
> set any TX coalescing parameters, to 0.
> --
> 1.8.3.1
>=20
>=20
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-
> open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

