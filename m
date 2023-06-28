Return-Path: <virtio-dev-return-13134-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E083EB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:28:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B6E95755CA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:28:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B06609865D4
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:28:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A4D9698658B; Wed, 28 Jun 2023 17:28:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C0E8986587;
	Wed, 28 Jun 2023 17:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXBHbFgQX4lKRs2zc3yL/jiPuT6AxHfyF9E4Uy5RW2+5D4aWy7pEywIP7TqTnQWzN+A0PHywv21n7LcU8xVZN0SWYATqoHlAL02m2E21F8VudLZG4Mbp9mWcueMxa4a5KhCtMjO8FCY0uPEBGIasJgknNC1dvOMKbAXfreHPEb4AwgHqPUsXzYo5yq/RwxbxdGlZucrZjDgNX1/Qn1SC+sLRsjyf6XJXd4GSf3NErjGPd1nFVGY92q6Q9UU6u50rViMF53EAyuWtuiSKIz8884KXcvo8Mb5Kk43Ba3feRCAIwmaegSIH9ST3t4ua22W1EW/djBiKGZMx7c8WRacqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJHhcCMCelo9liauBz6RlqGYIKk8dDgpf1/OwkaQhX4=;
 b=ZIbvweWlak1DZcOUPVQdiy7kx6svv8M2xtmKu911/yLH0h71mydb7RAmHcZPRpYjl6Cu0I+LAJ/PNQxoqf+MVRnyvDziOOpAQQ0eR1wEAVj16FpPo008+BLhAnIn9Ow9/h6HK4aIgSmjzuO3mmfWUBEsS0kxpXi8NxtlOVoGzzqPyqM+04LOwY7nyMIe3bCxsoM+Gg/sluA+2P1FBzYJ6N9KvIaXkUOohzUuiKAYQluMhmeh/whcS2Zm96F94cXepsbPtI+/bKTf6E6UAAGO15z3bVzChejmFB0xjJDoOffkFXf3vWWY2Od3AguM2j2aY597vFjXHEHbJj1QUFqnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAABzQAgAABTEA=
Date: Wed, 28 Jun 2023 17:28:32 +0000
Message-ID:
 <PH0PR12MB5481520EA9DBC0755DF9BA73DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628130839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628130839-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6657:EE_
x-ms-office365-filtering-correlation-id: 7b76cf22-21bf-42ce-70ed-08db77fd18d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0nseeekPjqchHD8qB6IswUU1fe3wlTdTulMvv90MnA2t9XPmdjon/XW4j46CKYpMXleqIcnwby0Ewo1JnCWUTty4yUZz8IhL1pXwfGSWTSMANw3Yd0Bi7BYyjkDrFexZxnpNAFAqKuLVCRxV2XlnoClNMBO/RLlq6hLhzSTupTIfXmfOwfufDl6iuUs/QrzOqNwHVzVgKGRawSfG0xJk2YJ5+efBuKlGa8LAcoxPo6Qwbk0dJh2StGJs0tKzGBWouWmJEXHKIC7jdyiLVTPUllO0yugQL5HYHsqsLZGrz8EGhduVCXS/4LhZKHGIR7rPkHu4TIyXJCQjPOTqBOc4KHwBVBGGbyCMi7+1shH1AmeDXqis3zNWFq6dYXdBsBi+ac5JArROYDhVT295KkUXH9fqA3qR9laeggONNmR25Lc0bBIoUc5XYi8KDM6jFTao9Zufb6Lt6xsBy5uONg6nvq6iTVAC4F73Y1dn0EQnbKDj69EXXYMSw/sivSk6ldzyeub5sl/molmYbJCMlSSwcDfi4aRmm6pqvednGv8lsqn0Vo0qJgYr5LwOaCjpp/3ONIRVXSg1E6qBaCim0wJYTcMs7y0m5X7WLrfqmlsr8Wlx5ynjxQav4WpVlCSnUqKT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(52536014)(6916009)(66476007)(64756008)(66556008)(33656002)(76116006)(66446008)(66946007)(316002)(478600001)(2906002)(4326008)(8676002)(8936002)(55016003)(41300700001)(86362001)(38070700005)(54906003)(38100700002)(7696005)(186003)(6506007)(26005)(9686003)(71200400001)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iDYGJJDa/6Py9qZ4f/+o/9jeFPmlWzqHvMzE7XuUPhujGzNvvTWdw0RCHsFL?=
 =?us-ascii?Q?J89TsQWkzsN7msQxyT6/PDyfdGhkkYuPSffKK5sT5hu1dRKIr9e2+jf/ldSB?=
 =?us-ascii?Q?hAF4ZmrVIORk8+3/s43jL0LoAv8SK0PPc9ROrCLCMOldOoaOQjB58i3dbBao?=
 =?us-ascii?Q?vgbE+Hc/4Kcejc3qAhEUnUWdSIqhryR8Dm5h6gJH0BepxqJJFFEV6+aX08ra?=
 =?us-ascii?Q?AL/pVX1vmgWnNYqcD2oiX126vy8bPBsZebMv/LQ/JOYOVYmjBYt4t3wu0u5c?=
 =?us-ascii?Q?MQYCBMVHrncXgjM5mYdPo8AxP5zYRFZSoMSwG4JKp9ROFi45bECLMl3hs0Tb?=
 =?us-ascii?Q?K0biZQ6FNPif2Hd9oDZMulyZ+d51kLk9iGWwKemAu34/F9TaV+PxWQnlocZi?=
 =?us-ascii?Q?YEg8J6rSuX/HhW4RZ7pCyrhwWtjBIn+nPzmrZTv7d0TTchPH/ROCc+DUplBQ?=
 =?us-ascii?Q?hdO1Kz2ZR8qMljuppn0D/ThG6WIveFXVNWIiTKotOqU9o2nRCijXwLsAnIeH?=
 =?us-ascii?Q?WZ4cU9xtMGpr0PDElDpDYvEFHTYdv7+1easPp2+lOKREA6PW2iVA3Gx0xZYe?=
 =?us-ascii?Q?MZjj6sTK04dY2Q/3pXJHl88hls3Y+B4omtMiExE70z0WueEtCk3wfnn+IMtp?=
 =?us-ascii?Q?MHg2sgsIUZDb/6qtseIVPQXMM2oDYTbuw3iFy7grlBEyd99aWNuHOTmOn3MA?=
 =?us-ascii?Q?YW52uSI6eJ5Rsbin4M0UhMC3BlVg34qw+9+ZyxVgSVBMgNHCw/GItn3Ri2UD?=
 =?us-ascii?Q?Ed03UU4yrSLd1lWvfowagfFzTJgQmkm6d8kPQbbFluBpR+dsy2a7BCOr1U15?=
 =?us-ascii?Q?J/wBagYtJ2r0p8+1iTSm1vzqGb0CW1mXUF7jMYqUZlvtZq68U8YV0XXHpeoF?=
 =?us-ascii?Q?yu8B2IiwgNmhvVhI9b0FFvhQ2geu1GXE6p/llyDbJPz52wL4BXxLOAc8+zXw?=
 =?us-ascii?Q?9kVp9cWDWv3b80tP4vBWzd+UZWtj8lFvGhbPqKPxxVmeJ4eex1/S5kau2unV?=
 =?us-ascii?Q?w7JLRyig7gZeIm8ry7YYaxVEzWpY/I4ykeTmcflRdm0i60sByWfbA/i8Uua6?=
 =?us-ascii?Q?0J2EUgW3fUbzkqfgBjbrB0RRmWBUPcMgAv+Bh5p56tJobaie1RMzav/QzLXU?=
 =?us-ascii?Q?WGAVNB16qL9+1dotVwwZd+JqLqTkqEytj932dAry5AyhdS6TdKjGDT1pe7GR?=
 =?us-ascii?Q?CH/sdpQ/ZzMwocq1Hb/NJFkdLQgg/8ketkzHoWxyA5pjtPwRSpUVQ4TomKwY?=
 =?us-ascii?Q?Uy3NZOwH5T+3ThcCtqtWWhfZz9M3Uz2rxH9xyPqHb33VLtSjJa5QtnNNdDjt?=
 =?us-ascii?Q?IxUzEAPzxkdcFIUc7s47fTIXbUWhPU2vMBkTKWcYxl44MBzA1uoQ5neao7Zg?=
 =?us-ascii?Q?dKNtI9CyNeSpH6yEukc/uVsHKipn0eZ/FwYnPk3ybAfJW2IieVJkh9b7EmP9?=
 =?us-ascii?Q?lNGIejFFanukBxVKD6d7De/pK9ABRwFTdCHv87P9/GPzOZback2C+ZY48lLe?=
 =?us-ascii?Q?BBGp/3SX45hp0OZwE1siNQZeo4T2eQEwsSMxTMmW3OiS1M7WgsDmFGYsgqo0?=
 =?us-ascii?Q?nR4mLJJARPNrkdVijrU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b76cf22-21bf-42ce-70ed-08db77fd18d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 17:28:32.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHRuzZUr4mE7pf7xcV1UKg6sZX4qvlC098E+DTzjkzq7Gs8a0qEkawcO1Iv3tE4BsXMtLt48DcnDtFGiozhXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 28, 2023 1:16 PM

> > 1. Because than device is 100% sure that it does not fulfill MMIO
> > needs 2. Single interface to access extended config space, which is wha=
t you
> asked for.
> > 3. Single driver code because there is single way to get it.
> >
>=20
> Right. But I think there's a better way.
> Just say that any feature in MMIO MUST be also in DMA.
> So any modern driver will have no reason at all to use MMIO - DMA is a
> superset.
>
How does that relax the need of MMIO for the device?

> If we say that drivers should use DMA, they will.  If we additionally exp=
lain that
> some features might not be in MMIO no sane driver will use MMIO if it doe=
s not
> have to.
> Or if it does then it has violated the spec and will get less features?
>=20
So than why to have it in MMIO anyway?
Why not say driver must use dma?

> > This demands two ways of access and that conflicts with your point of d=
esire
> to do single way.
> > I proposed single way, extended config space via DMA interface, that is=
 really
> as simple as that.
>=20
>=20
> My desire is to have a single way that works for everything.
> We have legacy so we will have legacy ways too, these might not work for
> everything.
Here is what can work well,

A device tells the offset of the extended config space to the driver.
Any field starting from that offset must be accessed via a DMA interface.
This way, driver must support DMA and all new features come from there.

If device chose to use MMIO, say sw, it can still do it using MMIO.
=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

