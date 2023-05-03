Return-Path: <virtio-dev-return-12525-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE950C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:56:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12D01370E9
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:56:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C9909866B7
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:56:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 01D20986594; Wed,  3 May 2023 19:56:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0DAF9865A1;
	Wed,  3 May 2023 19:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/03Jx9+nXHiBJIIgNAc6qeQ5/jq0eAlYV8w8kXn6ijntqaJjerz2FH9us56fxMtyF6PhBov35I1x6DCZzzo0o6ukhsJYC5er+vJrF2q5UrqEL3gwrF8DiwTQSo6BUayMIvY0snRvR5ZLly7ymHs/2wA77w3lMLQ7wlxjnz4QqRkCPuEG0runtl6O2x5WkpnpUFRdYsC4MwOOhBAcozxDptzJ1rpv40Hc+Ww/gNBQYt4rMDD2q/0F1k8YFtPDDiG/0NyeeDS8ZHUdqt7IazMxpIbgv2KdZdyWsy40q1QM2oDCHx9gnFQHxIBG9fc7M5ocTQUNE361nP/Y1zTK5KRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8dHflEsNOa3PZDkXJbc7kgijLiHMMGct3bY6k383I4=;
 b=SNJ9vgmsO8dQeXXjCqghB6GaXK2BGYoKqEc3qwQTUfXg6nLKSx4TrJOSAmC2I/cekv4VDSzH1KyH88mvrAcKVCizRA/C3v2AdG7WasjyGZ2g1gA6aOjwqPx5gMjeSuHStBFcLSpf5/FPMbrNhVpuU0CIazyDDKP5LXSuiEjCoQMtUmk9I2EBUDLyTxw1Z0W/CCgkVlj1Em2KNBmIFnDRoanjkv9dVqJTifUrQA7xMHHtSbc/s8NTCFyFfeFApQbYrlo7MdSTFPI9hP91zkbChiZ8TRRvYJopk3n0bIIuIzHoMdXx2X42iKsRaa1Z8vtbpteNDJCxLZTvLtHLxMx+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH v1 2/2] transport-pci: Add legacy
 register access conformance section
Thread-Index: AQHZfW825y8wGqzqMUGxmeQ4IGQvHq9ICumAgACYYwCAAEoGAIAACBQw
Date: Wed, 3 May 2023 19:56:11 +0000
Message-ID:
 <PH0PR12MB548176FB21FEFA6BF93061C9DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-3-parav@nvidia.com>
 <20230503014259-mutt-send-email-mst@kernel.org>
 <f9ecf8f5-1be7-179c-4d96-1c44d4601710@nvidia.com>
 <20230503151509-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230503151509-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CO6PR12MB5410:EE_
x-ms-office365-filtering-correlation-id: 132dbef8-df6b-4e6d-c7fb-08db4c1071f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eleC6hx7WPzhTbqUpN20uS/hjJSjFCoz7AGP1t8ukl3GYBPXLM5i8jnDjqokt70TLx+bHL9XlnN4+4gxxTKGptfAmPoyAr6+ks9G+qh6Rk6IMZZdsXoHuQXF07jDWxGkLZJ7pL9y7HO0oM4tvTDRzbMcOHlq14AM8jiBw3YHx/HsoDXfBinuwCAH9ex25zW5x4YlPgkjIVur2QWNzqL4QCUtNJBb/EqzBZGibIjEiOgEG5uqtYqAJR/mMtstd8iGDdwpY3x0r1GwXwRAG/e+o3aThnqPO6R2uQKcuA7OfTqFpSNYvRFk5JfpXcusL4n151uVj2l9rLTDpvhdOdvRrpuTCWDP5PQ7qpMO5nqv4M4yNDxzug9NF8OeeW6JgovlSULG7QfilcmMG/96YGXNZ1IKPyJoOb85ujDY871tCdfDkgsW3svWwF2Gel3E7ME/9EGkNUQTG9bzRmEA+GgVkvnQzoWLKt2ozBTjipqKU/XkJeK4g52rs4h7GYyNwbFYChieRx7YlXkjobDBW5AXtG/4E0nl339ax+njY5oDrmd1iD/7hCQDcPyg1g1HLDFNLWkyaLotdiDxQAI2Bbpvi0b/M8wjAmyevdv16KLdwgn1W7Ai2kfIZys/a/ulmepV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(54906003)(83380400001)(478600001)(71200400001)(7696005)(55016003)(107886003)(26005)(66556008)(4326008)(66446008)(316002)(6916009)(76116006)(66946007)(66476007)(64756008)(9686003)(6506007)(186003)(52536014)(41300700001)(2906002)(8676002)(8936002)(122000001)(5660300002)(38070700005)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EXsBZIbASi6sDzjDy0RQmkdmtjy100W1LnGOmrXHdxIKi59LRPKnzGT1KaJR?=
 =?us-ascii?Q?SerpnCvC3H4KKw9dDxdsn5vPpIdAuQg7gWxx/xUj0Kjd6VAOzywrOnhDVu9R?=
 =?us-ascii?Q?Zpd5SgWD5sO3Zzx30FP3YNdxaepQaDwibt450N8Az70E9q1wc9fRb9hFchdd?=
 =?us-ascii?Q?pNVPQiwFba3aJSxAuGpTyO9sHpniqyHQO6yhXhCWx/21p5KYHrPKWRY20TzY?=
 =?us-ascii?Q?BS3b2hlBMONEiwp1g3WznK73AJZn08/znPKXPwPliYOqbMGFTcFRPhiIFOK3?=
 =?us-ascii?Q?2Snl8L0aEKDieNU58wGuzAtoesEcM3u/kvNhTkybMDGQMcADYDuh4feWF4ZB?=
 =?us-ascii?Q?9tPI/bkupLPRhK83V/fu8Xu5MAhdQZXRJjxySvbeU7uAqlQ7nQBJ865UUt46?=
 =?us-ascii?Q?BS3WRvt1LePJeACzABwK3o40wJfMDx9UMknrDTzSSX4LSW/GyFyoACy4BQjM?=
 =?us-ascii?Q?/ELHbOKjEF+anaqCyww6Plz2CsqilW+qIPfuIwx3yWGriVKho3/xqRD82e7/?=
 =?us-ascii?Q?4BNm+QPax5hl8ACwPsipGJ06Dxf03KqGY7nW/Fvs5nGjM1uNV6PbEwEnu5ET?=
 =?us-ascii?Q?R5/uIzTNryLR5EingMHhT/4rO95bKGpu37erSi8Ia34133coUKi4KZb1YLLY?=
 =?us-ascii?Q?t5OH3itoXStyMeO4HHPOo5Wlykdns4a+g4rxvaO5Dz7N3txKusaGTy1sU4AD?=
 =?us-ascii?Q?5c3ejDD+wacNQ4Vwst3tBUw1kjKBd4pIvjWlF9pUoeB5FA/5TDi59FGR+PaC?=
 =?us-ascii?Q?UbNcYINAJtbt+qIPkSnf0g6dTQm3NwPn3mTo3xtzLGyQ/Dql77NUpt8NVsZo?=
 =?us-ascii?Q?aZg3BgF2Z6zHj18907c98AcXJ7S9uzH9o7pSWoM16cyJj/fIf6u7hDXxzPtS?=
 =?us-ascii?Q?yPF+y4Sdv2qgzaMjaUSdsrazWNsNA4Ip5ajs37KUY8AnmQ30L3p/rXXIlU2F?=
 =?us-ascii?Q?3R6+gPZg1UAsdvbDrN0a6nGRd+58WkYv3T/7b5r0J3Ux3yjJJ/QaSG8kir86?=
 =?us-ascii?Q?E90sEkwzODwoRxi/9O1Hb2RHam51eEcSlWX3BD0oswTGabEykTcKsuqX6HWK?=
 =?us-ascii?Q?H0KCGnUPZs9nvAkbLUHmKFnZk6s36Z/gBd25WtpmToWVYZn6Nl/9JtE+8ziO?=
 =?us-ascii?Q?8nXyrvJpi2xDTEbxfnoDuNu4dCVPC0o+t7YPahlUunc2KNYXDCT6MtZSLWVM?=
 =?us-ascii?Q?hXALfPWg7oxofNiGo/tb12Gkud9o6oO6DZ2xZhX6tXBBnCPeLfl96MBoGw6Y?=
 =?us-ascii?Q?tc85CsUKBEMdLLeOlbgpiFsvJAJ8v/yFcxt20p4pCaeFI+bgfev5eyXopdes?=
 =?us-ascii?Q?RUBdQkFW8HogKwX3xH7LPc5mTaY3Y2/B3c99HQ/li+KGc/siiBOruo6RZSY2?=
 =?us-ascii?Q?gNDi0Zao70VMApM84l20XrGwA4UwrRO/+gR9VubLAAJSntaV+7l4+0SC09Sl?=
 =?us-ascii?Q?fwE45gyHCqvVN89yZApOypkB5HOw9uTJCkshDJ9iXKhdaaD97hbWGaTVEH4z?=
 =?us-ascii?Q?G3VQHIzynvNqXLvGQDQ29QapihaHlRY9wXmf9R8Y5+7cjbKgK5k/J4eH5PP0?=
 =?us-ascii?Q?tsHEnztnoost7/RjaGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132dbef8-df6b-4e6d-c7fb-08db4c1071f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 19:56:11.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEb/lqfPQJWQI+Oi3LnU93gWvqF1J2lmOFzidffyBSP3pUOcG640halbkQ7Y0UJCWyXkUphLDIqWM29NqNxTKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v1 2/2] transport-pci: Add legacy
 register access conformance section


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 3, 2023 3:19 PM

[..]
> > > just say all these must be supported.
> > > In fact what are you saying here? That all 3 are supported or none
> > > at all? What about just
> > > VIRTIO_ADMIN_CMD_LREG_READ/VIRTIO_ADMIN_CMD_LREG_WRITE?
> > > Looks like a slower but working way to do notifications is through a
> > > common config write, no?
> > Notifications to be done using the notification region exposed and
> > queried using the 3rd QUERY command.
> > >
> > > > +
> > > > +The device MUST support legacy configuration registers to its defi=
ned
> width.
> > >
> > > what is this?
> > >
> > Each register has its defined width as 8-bit, 16-bit, 32-bit etc.
> > So device support the access to its defined width.
> > May be to rewrite it differently?
>=20
> Again you are duplicating the existing text, no?
> And in this case, contradicting it?
>=20
Yes, to both the questions.
I started with slightly sane version that contradicts below, but since belo=
w is written it what is written so it is the current version.
I will drop above normative.

> 	When using the legacy interface the driver MAY access
> 	the device-specific configuration region using any width accesses, and
> 	a transitional device MUST present driver with the same results as
> 	when accessed using the ``natural'' access method (i.e.
> 	32-bit accesses for 32-bit fields, etc).
>=20
>=20
> > > > +
> > > > +The device MAY fail legacy configuration registers access when
> > > > +either the access is for an incorrct register width or if the regi=
ster offset
> is incorrect.
> > >
> > Spell checkers didnt capture the error of incorrct. Need to find
> > better tool.
> >
> > > with which error code?
> > EINVAL
> > but should we repeat the general section here?
>=20
> this is a command specific case, isn't it?
>=20
In this case the generic define error codes are covering it for command.
In this specific example, if the register offset provided is outside the re=
gister range,=20
it returns VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD.
This is already defined in general section.

>=20
> > >
> > > > +
> > > > +The device MUST allow access of one or multiple bytes of the
> > > > +registers when such register is defined as byte array, for
> > > > +example \field{mac} of \field{struct virtio_net_config} of the Net=
work
> Device.
> > >
> > > so which accesses need to be supported then?
> > >
> > Not sure I follow the question.
> > Can you please explain?
>=20
> Consider mac, do you allow access to any length at all, from 1 to 6 bytes=
?

Yes, maybe you missed the text.
I wrote it as " The device MUST allow access of one or multiple bytes of th=
e registers when its byte array".

The other paragraph you wrote above about " When using the legacy interface=
, the driver", it eliminates most of the normative here.

I tried to keep it little sane, but its fine to keep it relaxed too. Sw wil=
l be able to make it strict as it finds it suitable.

So I will drop these normatives.






---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

