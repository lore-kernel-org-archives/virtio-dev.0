Return-Path: <virtio-dev-return-11385-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D02C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:39:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A98804256E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:39:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0FDC98678D
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:39:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9592398669C; Thu,  2 Mar 2023 18:39:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79A119866B0;
	Thu,  2 Mar 2023 18:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyGrPw58l+AkerKL+UV/A+KrsxyTAkKEYwijNFKXuBtgWNS8wJVZciNLuSTrx/G9FyLdjwDyFtXwwrPWpRHpdHhwNUcA6bxW4F8WI2VR3Nv21ESS0xd0eAiQhq2KqGJP90SddXXK6T9I6jLiR8yVBLJ2Q1Iipp8hz34aNHAROpbJ14Sk3Phy+pWchiBxmUBaTM+d6gImTWKSu5ppf2RTD7Bl6cxkziFJxrzd+WsYmA8hVDkyZxRItpNSpQEMez9a5BwxfwJcCvdujNcWjBcUdvKxm3oqkusW595jmlcyf0O7tHzsAip1OOhc6uTNOQc2uHDRJLmuAdwvrAvjIA3Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk/YtRAMrzMhNfCd8ZApXsynfiFSeNlbKdqUiFYhdEQ=;
 b=WUPTDp6T9+FZ6KqxYEp4nby40auOjVNvaw9hLew04V83nHLtb6yWYsRlifNh+7y3E6nj96hzBAz+o/U8g5BgaOnXyNOkyS+NcdzT+yzIyetvkFRz252q4iqcZapXaDGNlqHO1rfZ4FlHvcIz1MT4tbzdcxh0LLi4qREu4fOGJSeWJRs7gjfDYCPvzs3viCjIewrjhWX9oO1VNVJdW4aqD+IygogqOroBUmaCmFdJ7iT43hWLAOye020AQ0bVH3yrRCoLBWXMNKPz218H3zhNFYK/bWDNyjBhnAM+q6dxIr3dIezZVpmyQWjHM1SF23fVjrR2gu3XwIQfiWVaBeBRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 01/10] virtio: document forward compatibility
 guarantees
Thread-Index: AQHZTQeZ7RYmE44ij0iQN7fg/jWFs67nxBbQ
Date: Thu, 2 Mar 2023 18:39:29 +0000
Message-ID:
 <PH0PR12MB54810807C3FB1E12BC5BF970DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
In-Reply-To:
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5254:EE_
x-ms-office365-filtering-correlation-id: ae0c46a3-898d-4bc1-fbd5-08db1b4d7521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Chs9txbItOOpxnlUpsuHtyl24zbR41K2dDSUhULyELptUnjkdRsVtK2UbAVBLQlMTwDPStRADUCCtG8FNc/s4YFYA+vHsQs3Mf4YkNPlgoJe3O9vT7jx2E1fZiVd02i1Oq+7q8zCxQ3QXuoE0G9BQwJf7Y2uJrDmxVlmvQ9qOSFYLAClBdNELYoqb7FkZoq1iUNd6PN6e0JIBzyOXV4yIkt06dgRWfG8+GDpvn3DYlW+/xp0jU8DnqIAbQ5SPCPs9NXgL2syGy5jVUaLXMLc9OhT+B/FkeqH0LXiKoU+qG5/5bAJGD8I8G7AMvQbadE24LWb52X3inMeqVVvNvu6HZtF7QbiECvxVWhR2gskK5mrzMKmPvOO2A955wMgprRRu8Yf0zd1HJ2NLnYFKzFeUMocJhny/Hfr+ENDOp5CWFEl32bCjxbC6JJxBkEktMnh83R+wxVr39SqLU2ODU7Rd+vA4EhCZn+ZJwjX88vlPEYCPQAibhivWo41oloKcln3DVfiibpdgbMzQ3pp474OnG691eutUXl1Tqu3RyRRJe+wY4GEEZy6bWAQergfqjc65i6jhOcNNlwBW/YGJmYYHYUqa0LHERpgqjFXUiHX0fChQfRbLWpJQwqJtdOAJ/LQIm7BTLUpGh5cWkAJqokJVm2Pw4yhfNt6GG02K+FSCmm/k2FbopocVb8xId8VXFuZlELOX2XQNmHIaqGnyvi7fnXaUVQPQmq5UJQ48XLXDG9OEF2kjzluZ7A+/h35aI5Y0xVjMkQn/X0+V7Bd8sV50g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199018)(41300700001)(66556008)(316002)(8676002)(66446008)(64756008)(110136005)(54906003)(4326008)(55016003)(66476007)(76116006)(66946007)(2906002)(52536014)(38100700002)(107886003)(122000001)(921005)(38070700005)(6506007)(26005)(83380400001)(33656002)(478600001)(71200400001)(7696005)(966005)(186003)(9686003)(86362001)(66899018)(7416002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A/b0WRrmL9Pn4eW52HivY+JWJEebPO/dVSRzKmNRmbMCtAbOYopgVixv7lUY?=
 =?us-ascii?Q?9Yr6YBD4fcMDQmlQXUJf1sf3DSFDqjPmR17uHGOyo5NKEysylACMm0dGvhYn?=
 =?us-ascii?Q?kOzKxnaokhWNL5AR/18A1Ci/eKWVXkOCrJibD3qbxKuRNh+7qzDyoWQz8/+C?=
 =?us-ascii?Q?81r7dJ+tgtbDYbpW4QRWUTRc+taUPg4BhNHQrlgOKQQdz1QVIcaBv+EGdGDa?=
 =?us-ascii?Q?QyiS1DRLTvqb8UWEoknOtr4y601Fhk6A2xMUyo5lh/Oe2ApeeGCC9CczhNbW?=
 =?us-ascii?Q?muvrb+ntkT+ppgYEcDj26sHJxGXGaOBURQh5FDLTIxUlEJDL6E5ZDas712rR?=
 =?us-ascii?Q?KCdxn+AHtMiPOVnj6dZ44qt1IHImmNLACMkA48dZ+i9R/EzPQftD+D5rDmkT?=
 =?us-ascii?Q?iEbNF0e13hWT6uLsg03akYZQp+v0+dHJottev9lwtylfJDl500pEUqfUO77P?=
 =?us-ascii?Q?pywW826PyBsDZtnWPUJK5k6bHTlJmmgNLLe5AcgEiPWhqemvrAlowrooRcK9?=
 =?us-ascii?Q?qY9SU9ykP0L08ClnWG61Hq9lFk5dMPsnPXbHdpzlRWVTVT4A0NP1BPtw3gNX?=
 =?us-ascii?Q?su5Q5K4DtiX08dft5d9le3AvcUvwEuijAkGZSTm4WFvaIP20bCaaGKPpt9au?=
 =?us-ascii?Q?dPrZdSvtERWh6C+dPs4m9r8caX78JvRlt+RUL498fAlGK5V44mZgNzbuiETF?=
 =?us-ascii?Q?DL6HI6C7Ir672H+JpaBARnRlJ+VuruFxu2JI8rmxjzXfIiiG6LMtLascHHd6?=
 =?us-ascii?Q?dKXKKOlRA5vTQuSCeJ7BJzotn6aU90bfa36iI1hcIGOXgvhYCKiOeeSZOx8M?=
 =?us-ascii?Q?czCklHbLzXAjW/U76ePecBdteZE1Cgbxpbja1Gmu2bnNmlrBYkZP63R/kuWN?=
 =?us-ascii?Q?dQWbMZJF9/jvnjUf6kQC/y/IsRbYMs0WWhtgp8wHWm2hM8fUBA3mUtRvnW/3?=
 =?us-ascii?Q?1Opr0t1S48ByKfU/xKAzdDU0yQDwh6VmPcxp76KzzpAnYX64pzKvJd21zRiQ?=
 =?us-ascii?Q?3VElVD5Qc63B1GbI3rFQtQCGGX3LSHV997xQCqCux1+YqBEkIm8DuOdlPApX?=
 =?us-ascii?Q?F9jHWnhFminreutfgtXv59DSIawM76iZS8do1wjGDMi2qNdtXXZUUnMK69PX?=
 =?us-ascii?Q?KfNd7M/MrO06npHXm/C/flMiXR7Xofr6+7GAE8XyrySTi8UkseYy+41mxmtQ?=
 =?us-ascii?Q?1EGsRJbi6e6xfqQ52laaRriIuy08pxxPIyqmmJ872QXaxSNPVWC9joBHflK+?=
 =?us-ascii?Q?hKzbZ4OmueBo1imGE7l8EkFcmHhBvafmFsi0DsmEbSVLA+ENXOSRrH5za5gI?=
 =?us-ascii?Q?l1d24xLsbJds/2lssDIO44dzVJWg7vIycR55m3I+ytYT0ejr+Uqx9f8zh/zo?=
 =?us-ascii?Q?tk5mvoH0QM5TB4tEwbjkw3qFhoM0It0Cc6FNgwoofjzelLvi/zLEuH87QreP?=
 =?us-ascii?Q?68rKVXaGagVNuiWUhMsDuTYLKIhfeQdwgkm+woAfP0TdoD+FPaDd6gRvSfZI?=
 =?us-ascii?Q?JztHFiR7xaElUZ6AQ9I/QvBRZR3d13mfNr2HaxFZQv5Vo8hgjndawtzdc55j?=
 =?us-ascii?Q?00nJhmRvTFu0ne3gpD4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c46a3-898d-4bc1-fbd5-08db1b4d7521
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:39:29.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmF5AUiYiIlNvuqgZ1ixHsLN6EiGr77ziCOt2k2wc7uiQTdgEsJz5JIYEvq66ws0CplkbmzKyn/j3U/gxLpHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Subject: [virtio-dev] RE: [PATCH v10 01/10] virtio: document forward compatibility
 guarantees


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM
>=20
> Feature negotiation forms the basis of forward compatibility guarantees o=
f
> virtio but has never been properly documented.
> Do it now.
>=20
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

It may be little painful, but in 10 patch series, it is worth having per pa=
tch change log.
Because I do not know my reviewed by tag in [1] was dropped because of a bi=
g change, if so what was it or it was simply missed out.

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00237.html

>  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 0e474dd..0c2d917 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities o=
f a
> Virtio Device / Feature B  In particular, new fields in the device config=
uration
> space are  indicated by offering a new feature bit.
>=20
> +To keep the feature negotiation mechanism extensible, it is important
> +that devices \em{do not} offer any feature bits that they would not be
> +able to handle if the driver accepted them (even though drivers are not
> +supposed to accept them in the first place even if offered, according
> +to this version of the specification.) Likewise, it is important that
> +drivers \em{do not} accept feature bits they do not know how to handle
> +(even though devices are not supposed to offer them in the first place,
> +according to this version of the specification.) The preferred way for
> +handling reserved and unexpected features is that the driver ignores
> +them.
> +
> +In particular, this is
> +especially important for features limited to specific transports, as
> +enabling these for more transports in future versions of the
> +specification is highly likely to require changing the behaviour from
> +drivers and devices.  Drivers and devices supporting multiple
> +transports need to carefully maintain per-transport lists of allowed
> +features.
> +
>  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio=
 Device /
> Feature Bits}  The driver MUST NOT accept a feature which the device did =
not
> offer,  and MUST NOT accept a feature which requires another feature whic=
h
> was  not accepted.
>=20
> +The driver MUST validate the feature bits offered by the device.
> +The driver MUST ignore and MUST NOT accept any feature bit that is
> +\begin{itemize} \item not described in this specification, \item marked
> +as reserved, \item not supported for the specific transport, \item not
> +defined for the device type.
> +\end{itemize}
> +
>  The driver SHOULD go into backwards compatibility mode  if the device do=
es
The grammar tool is suggesting s/backwards/backward.

> not offer a feature it understands, otherwise MUST  set the FAILED \field=
{device
> status} bit and cease initialization.
>=20
> +By contrast, the driver MUST NOT fail solely because a feature it does
> +not understand has been offered by the device.
> +
Above line can be written without introducing "has been" given we have only=
 two entities (driver, dev) to care about.

By contrast, the driver MUST NOT fail solely because it does not understand=
 the feature offered by the device.

>  \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio=
 Device /
> Feature Bits}  The device MUST NOT offer a feature which requires another
> feature  which was not offered.  The device SHOULD accept any valid subse=
t  of
Extra white space between feature and which, subset and of.

> features the driver accepts, otherwise it MUST fail to set the  FEATURES_=
OK
> \field{device status} bit when the driver writes it.
>=20
Extra white space between the FEATURE_OK

> +The device MUST NOT offer feature bits corresponding to features it
> +would not support if accepted by the driver (even if the driver is
> +prohibited from accepting the feature bits by the specification); for
> +the sake of clarity, this refers to feature bits not described in this
> +specification, reserved feature bits and feature bits reserved or not
> +supported for the specific transport or the specific device type, but
> +this does not preclude devices written to a future version of this
> +specification from offering such feature bits should such a
> +specification have a provision for devices to support the corresponding
> +features.
> +
>  If a device has successfully negotiated a set of features  at least once=
 (by
> accepting the FEATURES_OK \field{device  status} bit during device
> initialization), then it SHOULD
> --
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

