Return-Path: <virtio-dev-return-13923-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB7E7070F
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:39:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 02A352AED9
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:39:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D78F298668A
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:39:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BDE6D98667E; Thu, 21 Sep 2023 10:39:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD85398667F
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 10:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqJMYvFd7AmYi9b9skO3v4pSTZAvJOy7fCHiMviylu15VSbweYQelpKY54WTfPon1WiMEN9vfWF7rB/uM7uWIRWYZlEubms7T7Z6uMH6VjXXblc9STK6j9eEI8V0Iy15zfX+P0tuBWKYxdglCCiKKDRwJWkJQ4qUsafpoOvrKljO99FCxYJVCnCutm0LJXyQ8vMNr16wZ3+QbqObVB7vWhNFSTRkejSYNinLknt5CthSe90gr95UnN5bptaOFPXIUuLpsW2+P09RbNAl+XNOwCG49fDZPho8bkbmWRaiQofoqZKHzwJiYT3fZ11vg72Mc7ylfpyB5YtaBAAXUG0qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSQOcUZmLFYGNXuM+QJe/5PeBpCougsrovxJyqEpL1U=;
 b=kPPz1UEvURmmbbxTT/8sPSTJKCuf3FVsdqZ/3wtj6mVB1r9jET32+8oTNqqo2ZE9AF4zi3dvbVy55tDuLJhmBTWqbX6ZeB3CXSZDwqH5yLE5Il8p6U3kohX01GTB8VSA6GOnAEUxK2X/4w70+SDf4x8jy4y9IIXkGokYGYOO1lXL7WyMnKt7VwXfc0EOiyvj04lVxoa3Q4VZ3r508dMLRRGlXS0JDKtsE4PefUaJ3cvC7oIIBAPCLsIbOQGqTd1SjKktr0fOekX2R0qKZkdSx77ax6j8s+i8wW+4g406y/o1BIzI7WvxeREXlkuO4pPtmAbzQ4ZEBrqb6NYJPrdEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQCAAAZZAIAAAKfwgAAT/YCAAADbUIAADTWAgAAEM0CAABzpgIAABtkg
Date: Thu, 21 Sep 2023 10:39:23 +0000
Message-ID:
 <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921060320-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921060320-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7417:EE_
x-ms-office365-filtering-correlation-id: 033865b1-187a-4d75-61ff-08dbba8f0505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M6A9OkQtztpT/FiShSPOQlcotDnK9LOyY3mJUslftmJpmMlr+aslTiMC2kPEEHmxpkCvA5e5mStDNMY78zSlMY+fdEWK0cJWP1sCZbpPwFx7hEiNTOaoln1kjJkHwLghhyEYnFcJEufVeedFEZ6sY1+vaNUMOstKxXVm74ESqt30G2eclnv3qzYv9IqG4gsBGOFXYtkkYUjfHVvMprS1Z6jTmJX6kOpxC4j5SfWUcGKLnNbv5TXmD+Q/42uStch0k0HfAy7IcqSSLy+qx10UWhllwKVJJAU1pio8+Xs+xvBwSyamUD5ttyAnO4EnZvoITOwHNF+T95r2xCf1/giXA85QzenPt2frdQAKrwN2FiRagicKjbXrQTc8EpyNPcW4r6bRZKhQb+YEZi9UACFIdAbEn0ldQPTNa7WdiH+IrQjgpNgKZqHRQRuvKjpkz3Vc5/MfACkhVFnh1cxopg8/wdLoIHyrU7HGx4uRfRMSArLKGPFNw/G5eD15p2PTHQoIb40GJTPbfLHA9xUO0E2+zePqWD819Vd9c0DhKg9+zAaXIM5wzMHEk1bK6mOH2ICW7Ijrc9J7Wx3HT+uPSOH5E4eFWnu9ZH0vez8UmazD+1dLn9MW8b470o+/QFnz2xgv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199024)(1800799009)(186009)(55016003)(6506007)(7696005)(55236004)(38070700005)(86362001)(33656002)(38100700002)(122000001)(8936002)(2906002)(316002)(9686003)(71200400001)(478600001)(5660300002)(4326008)(41300700001)(52536014)(8676002)(66946007)(66476007)(76116006)(26005)(66556008)(54906003)(66446008)(64756008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xJayPe5EcBXU4yITKo79J9TVdLJWKf5Bu3X7xSrUsoRGTJNT1XkCn1O3lV/l?=
 =?us-ascii?Q?vY0b8qu8nIDUcHhT7ukrvTlRQwljtOzt+HbWiy5ymaOCRQ5tW03MafE/Wesk?=
 =?us-ascii?Q?Ch07mJyM4wKhBylhE0cmcte/wv6QeHy2lvEUIXG8gScQpFWkD9EmPNNaTKPN?=
 =?us-ascii?Q?YW32kEy6gQOfa1oeX4qYFhBPLn0hT8w80ns/B8CAzCBsY2+CCFPlDUtRjVlv?=
 =?us-ascii?Q?yuSuX6Ocf+0AB3/h5GIenl7yRwTwHpYT9orsadMu8xSM6WA0tF5cN4oXiVKF?=
 =?us-ascii?Q?xPsMTMDRqBgkgKT2ps0yaSc9SqRA0ddDkM8gZJvOEXxnvf+jWrNKnGMfbN6c?=
 =?us-ascii?Q?9L85o7drWhy8he+g7lv5pu+rEUdvLg7vhjVTxGOAlm8g2kooRgEqLe2M3o31?=
 =?us-ascii?Q?h5RbGZKau81DDSj5QHIF/rwt25OTa72rp/TZAazw95UsmrJp3H0IZqLudBnE?=
 =?us-ascii?Q?0IOy5icfdHCfILECly9UqMYz2MN2zbD0dalPaUGQmDD+kGykH1v87/xsl8fR?=
 =?us-ascii?Q?2pqasJoEifDqA4ILovrO3z2FrQutTOTVujRsVF7VgTJj4jp+m2mLwWS8JPv7?=
 =?us-ascii?Q?XBSGOk4TTHSYuwBM+rMKriJP66tqnz1fTWdbfbXLPVhYlLJkFgrP9ZZLlIFX?=
 =?us-ascii?Q?yCTFR03aTcllRWDi8geGE27vgNOpJ9M4Dmh3L3JccQ5bldHRYjwf7PKg2M5A?=
 =?us-ascii?Q?/OyWaKQGFdpwcIhuliqLNAqapncSSXO8270Gko9c4OHe9V2PK1sNzqByPC3c?=
 =?us-ascii?Q?8ojVMpGd5TnmP62hwTTdbyGCIb3sMlJdcL4sPp0QLUEqK7BamXt2rkKNpsFg?=
 =?us-ascii?Q?GbHu9S4IQk/wjfn5aTIZJRyHIRzrWZnPnk1vdh1J26iYWAPSq3dPFbWgv5ef?=
 =?us-ascii?Q?701WC0GstwHID4aasqSrEqoeZUj2on8jWyCYkgXN5DjFTZRr4aA86r+uRE4f?=
 =?us-ascii?Q?+f2sNPoQeuN7uK5aeZVhWKlVNX4o+gNnupRjYmuzqUGSjxuBhVZ94OmWKJH7?=
 =?us-ascii?Q?Z4OeAsEYjB/J5MNfMsVTjVXtAKC8yLKUca3MkIcqvyfTadORRshXggC6RksY?=
 =?us-ascii?Q?4FoIXiQ7j6xFE5i6UtwaLQ+y+HTpjyuhW/GmLFG8j8pORWjOdP94yKmMHWJ2?=
 =?us-ascii?Q?LIxeqgFlo20NJqWaTX5G/X8VXoxdtigauEGF9hqZSHbgkO9wceIiZB6q0IWh?=
 =?us-ascii?Q?b5J6eJ1Bv+3FUdDEyUC1bYcH4e45xLxUv+4EN3cnD8UNyb+AXSmc5amjeGf/?=
 =?us-ascii?Q?NXav/2XNiJkVK2RwkXl729MFDwXDWAk3ka5lHxR5kVfU4nTbYOHVxbgjELw5?=
 =?us-ascii?Q?YelUwA0Mg30mmCRjfOq9oaQbWLuFXeyQ8YZemnKUkYujObaFCWajWTbdM4Yh?=
 =?us-ascii?Q?B1H82ywxDokWRutjk4JWnIjrq8q+iadotxLPxOpW9mXweo3Yah4Vd3nhf3Mp?=
 =?us-ascii?Q?diiKNzD1ZyV5aFvvEeBp05sVaQrxQTgMB3IniXhRBfVdhMZe7RfAXE8sAkSS?=
 =?us-ascii?Q?KCVkH4ibc2sF2w3GBSH/Q9OZ7PCgirXDpXmQWNFUmRA/+FiGNG5HMRL//riI?=
 =?us-ascii?Q?PT9GUDwL3l8/ZCrn8dI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033865b1-187a-4d75-61ff-08dbba8f0505
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 10:39:23.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q10LY9KSUFmsoAeQCDT3iEoehwkxyW02ysoDgAq/f5HMuYoazc2Ud6r7bSGbKtve22Xed+M4T6odAeC4gx+apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 3:40 PM
>=20
> On Thu, Sep 21, 2023 at 09:17:53AM +0000, Parav Pandit wrote:
> > Vdpa stack make total sense when the underlying device is not virtio an=
d
> hence emulation.
>=20
> Which linux framework is used is kind of beside the point but since you b=
ring
> this up - not necessarily.
>=20
> E.g. I personally don't care much about "stack" but clearly we need a vir=
tio
> driver on the host to be involved, teaching vfio about virtio is probably=
 a much
> worse idea than creating a mode in the vdpa driver which mostly sets up t=
he
> IOMMU and otherwise gets out of the way of using the VF and just drives t=
he
> PF.
Well, vdpa has to drive large many things including cvq, config space, msix=
 and more.
It can help to overcome some issues as you listed below.
So that way vdpa over virtio is useful.

In vfio world, there is nothing significant to teach about virtio.
Vfio is already has the model to extend the stack to do only specific work =
and reuse the rest.

>=20
> But for example, to migrate cross-vendor you need the pci config space to=
 look
> the same and for some devices this might mean that pci config space will =
have
> to be mediated.
> Or maybe not. vdpa is a good framework in that it gives us flexibility, i=
t is not
> opinionated.

Sure, as you list, both has its pros and cons.
So both solutions has its space and trade off.

Hence, if both can converge to same set of commands, =3D> good.
When there is different way two stacks operates for those items, we will ha=
ve spec extensions for both model, right?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

