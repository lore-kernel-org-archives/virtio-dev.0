Return-Path: <virtio-dev-return-12318-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260FBC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 18:24:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 63A7A3309F
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 18:24:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AED298663B
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 18:24:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4FBCC986619; Wed, 19 Apr 2023 18:24:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D1B3986434;
	Wed, 19 Apr 2023 18:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYNJ/JNMkcEgpv3Rq7LlyG1WWQKysn9N/ulX2e3ZH7hX8v+cCfJ9z6zy9e0KlbONf45ZO6DwkMrswGZsel2krFiA2G6ley+1ybIfBuCgmkI2CwSKlhJ+pJU3yiKnLvF+Kh9QAIeMM/9jlzShxql2kkwRUMFlmZDXcyaw20EFCv2Nfyh1cUxh9Mf4HQgCg4h6t6YkLch7OeDWeE/0IWRaLAaL4BG9WJNn0ba3aIyOrqfTKochFYOlw5xTFRj1ocecbn1en9vtiO1ssguDhoHRoSl8fjOfOd4rEhLWg0NOr6d4ALfyTV0XbcYYE3/nmqJVGZAl+8YGN7QuNLsjiBAR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMKwK4PMCaeik60VumJlMxhTGxJJ+LpAmnYZy2XYkOc=;
 b=PnA27QKI5SMMPoCfzDETjsd/taCVrFNMY3D2CukfSEC+S3PZ8x4AQjJDJDkcOggZM2fIogxiliqdwVZMjmrAmaMC2WoU1GUmdaJZP9T/hFZZ6qNfPI8WRPuQRqxttzKJcwYz3jmg7IUAjVg1cdH+EUHoRk4p69AMcuLaci+WAAsGv08c12UvLHNJii/Ezpgu2kXLrIFdRu04SYrO0JLTHLw3G3ONHbl8R+sjA+XoMn/pL7oa2u2b7nKSH9v31vsKS4F8l8raz+YRFmrCdcWbbGwNhuuFwM4IFWG54k2LGQGM9Avxoo1rDWWNvkw2kQj2Cb6Td0dWP+3V+kf5so8rdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH v1] transport-mmio: Replace virtual queue with virtqueue
Thread-Index: AQHZcmI8C/Jy1DARPUKGQE1Rf5qP268yOBcAgAC7K3A=
Date: Wed, 19 Apr 2023 18:24:24 +0000
Message-ID:
 <PH0PR12MB5481C78CC4FA3A1B292564C7DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419015638.919627-1-parav@nvidia.com>
 <20230419031228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230419031228-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: e9b3b152-0651-4fc2-15d3-08db41034dad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /UyTzqAZNbrGcwvdSVpQ3NgQPQSd8rNIRUsTy69JUCbM3kezuQpkCjApURiGxhLNWC5Orrlst+5AIEaMqehaNUKUR0r0xsDoVmVCdVlZSCDqFIhMlopTrCjbgnedQMdYJNYfJfZgw7xPuLRq3noRmR6k9wLWp5DxOUvZS73Z2OJBTH/NP+pFvlnNBVoon4SYNFQ+Q2SuZ1v+rybWQjmE3zQW2YnX/UqNOaoRNbyLbanTz1ujoIuLJq6RaQFxaOtO09eisUrloc5BUz/VfSOsH1IYeKyb12PLRwjt0s3Vje18FfQuJ3neJVI2/G7CEkvI1AUgxQdNI0Fn4LSyGJbyD9MOHuWe/Ld8vGJcgvBg4be4HC0x4yB9u/8migSmv39xCJE/zX2W85K5a3QzwjpFdw6DML+dQIuN8VjZdwfqi1l81Z71QuOCnBzMJe0bT5Xv+HwsP6kLMr3iTc3oab4ybRmVcs5qziqOr7YsXifev65S2cigxeA7S2MmsCsEifCVJDF0WR1RqUc/F1PtYTYRM0cpxYhM30nBrkgVMieC9VHaKmOVuveCfvJDx8mO5IOBhAqG5KtVQkfmiLc2s3KuTebinDmA/F4bfRHBBbhWMjekffGqUppYqR0M8dqDV1iQc7xxXAyx0rDZXF+fD09HmE3nf373hWfperXTJohfuwzFq4l7OTbxTaa2RQHAWeVA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(8676002)(5660300002)(8936002)(41300700001)(4326008)(52536014)(76116006)(66446008)(66946007)(66476007)(66556008)(64756008)(316002)(4744005)(6916009)(2906002)(54906003)(86362001)(478600001)(966005)(7696005)(26005)(38070700005)(38100700002)(186003)(9686003)(6506007)(122000001)(71200400001)(55016003)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YSY+KGSAQmFO4zPQWwaEU1XTtp9w+SS+5xs780/ll3Mc8P0Me1JbNm6pxldf?=
 =?us-ascii?Q?Sys2z+4kChTtF8IQ8VM9hdcXWq37gnEfOc09xr3lHEuelCa9iF0QA3eELGCI?=
 =?us-ascii?Q?Ys4HPbJBya6o5Isg5dYqlruygfcQFwrlBf/oe9AB1U6XIIM4SXJjz8Ixupus?=
 =?us-ascii?Q?xsM14k8O7n6xSubiqSHRCKPKEnpYdQfMXDrOimLdlIzCTTPnih4AiipCtMkZ?=
 =?us-ascii?Q?XVliXI5WNvrWx1XfGMJsc9CcBHWNF5X6b3Wo/l/ueGbRxuhiRgKEi32tZPsf?=
 =?us-ascii?Q?sBAqi+Kd0Nn1YzbQEuL8dqwPxzr81p2hVPr9u3gj8lrW7NAoCpRbmiMAqHW8?=
 =?us-ascii?Q?yUxXfiPlR9rq7kK1BOYrsLYpO8TZ2Lg3mrsvho14esByrVqhyEovEtF72O/N?=
 =?us-ascii?Q?nWjVdcLzdbmRgjCAdlfu0P4PCu6nHPbRwAfZIY3XbzyqPFAmIUxkHKcG0fks?=
 =?us-ascii?Q?tyhyE+nTNEWFlRs2DyMgl6Ewqm5yI0LDpsluCSF7C8DXKqhs6OKnE60WQ2wA?=
 =?us-ascii?Q?m18alXI9Jl6UXNUos3vpZVG9DJ1OYYux3gM2KoNvfFWAp+Ko81GtMq8IXseD?=
 =?us-ascii?Q?CigxNExNYQOV2Tv9/ckap9SXlpfrpE6jw9kNHVTsVID5rrAroSqHa8YJuh4T?=
 =?us-ascii?Q?KnweQVhSg46/Hm2kPR1KnurQQxTMol+12bJea6n4vnvUtPVCVzACGISLxmvx?=
 =?us-ascii?Q?ddJ0IuawkUb75r65KZOrOHYPPfBuz5b6do0/otqBcbbfzAMDhElA+aT/erAh?=
 =?us-ascii?Q?rtteDP41QSLGXPIiXfacMhfncaearPKPvpn68u1CbuayIt+rbJzS+aReO5LB?=
 =?us-ascii?Q?6L+SSoT/ZMi+taNzW17AsX8xAcHIX8xDkHJlPyCvrnQw/kt0GO1yFjiCTPvB?=
 =?us-ascii?Q?VjqKe7nKlTewYoWu5gojukkWMveCzBIDw3DOC05BotDzXP/fJjUKx9P2jajG?=
 =?us-ascii?Q?7HL8Ru9edoCw0+Vp17XGH7FjH/CabvlpEu+Cjn8Fz64t3Y8fcZqyL7ebbqX2?=
 =?us-ascii?Q?yx4VtNEVBDft/s7K/Rp6ri031zGqDkMA099njmklmyJYT3IRAmeOgq+B8dzO?=
 =?us-ascii?Q?D1Li8H5L2XkawDVwPq95SN7UbQR8gWxRXn4LdmhNr7UGR7/RVkAfMwhDwEbB?=
 =?us-ascii?Q?zqjP5FCXSdOA5sCXZqYnGCL33Hra3H9I8GZP4gO8Zk2w59CRmrXYLvEGOlFJ?=
 =?us-ascii?Q?gEYDPX0hcckvzR3hM6wuXdmJ9oNxtlklaL2PCbrAjsLffFhLJt59+L1P43gH?=
 =?us-ascii?Q?fdMG9LV8rMUfeq4ulJqGI+8y49/3ecv3jLJddwe6qt4sWXTtT1JtxAhFZ/SS?=
 =?us-ascii?Q?8nLu4ps/z4+TAgTDr+azfU4sGnntJULfXAhvMBclX2/FXWx4gPblMkrBvw9J?=
 =?us-ascii?Q?I1yu+9TqbrAiZ4hDcHule+YbDOqg8VvNd0JXnaRB9antnd9nFXVFyinYlv12?=
 =?us-ascii?Q?Ub6Dbhig607uf1P88BxDNqLZBTy6Uz1uq6kGO2h498U7HKE4RnPNmSa9/yGa?=
 =?us-ascii?Q?4sOZ6ooeMOhMB4gAL0Aiw84agdSgIwXsf1TfE6Pb2T9JHkLdGjiuhsMT4W1u?=
 =?us-ascii?Q?YYLWADzUz9GeN6N6xgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b3b152-0651-4fc2-15d3-08db41034dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 18:24:24.6580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cB0zsykxUL+v6D990Gdiu2+aLgiBeViaC04z8CVDDe/rQOsqpL/LPMV468T/+qwUnMsXJZen0VADr2tkeeBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
Subject: [virtio-dev] RE: [PATCH v1] transport-mmio: Replace virtual queue with virtqueue


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 19, 2023 3:13 AM
>=20
> On Wed, Apr 19, 2023 at 04:56:38AM +0300, Parav Pandit wrote:
> > Basic facilities define the virtqueue construct for device <-> driver
> > communication.
> >
> > PCI transport and individual devices description also refers to it as
> > virtqueue.
> >
> > MMIO refers to it as 'virtual queue'.
> >
> > Align MMIO transport description to call such object a virtqueue.
> >
> > This patch is on top of [1].
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202304/msg00407.html
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> It's borderline but when in doubt, vote. Fixes tag with a github issue?
>=20
I opened the github issue https://github.com/oasis-tcs/virtio-spec/issues/1=
68

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

