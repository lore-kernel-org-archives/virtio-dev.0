Return-Path: <virtio-dev-return-11298-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFC3C64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 02:50:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E62252A8FD
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 02:50:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FCC19867A6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 02:50:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3F6F9863ED; Mon, 27 Feb 2023 02:50:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 789029863DD;
	Mon, 27 Feb 2023 02:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izia555VTjJXtpyRvAZe4jK7B9B1tecdNhSePjK0bab3D7t2Q0IJIBItJ/nUx3WcmpamIpltqMk+Q4O6Mj/J1o6sMdIc3LE2T9NEFtKW48SgTut5GI9FAor02IASl5I4EAiOeskGHMRN+V+t9kLcrQkYBH95l5VZJ3lrxqbmRU9WEvBWAO+h+K6O87XZyYGe1GR1jAgYmjeTOXSHoSddRU9QOONSoO9bNDBaG9TfVPnENmt5Te5D73rVnO5kRrwTx7M+lBIVVHOTHR6Fj9O7ejjNFsl/xRh0cfHPQFL2Daih8VfFXlY2b/hk++k2GWTu7GTmEbpJnBS73Lv0kc6CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZmqkP+X1xAjlb1fgRCDGuYAqlLhrAO9THiSj1E4J/k=;
 b=dj7lDpK8qWqvPCAUBInkS2AChosn1PQWQekZit7OuzebCCZU97/S0TPOLY1+VD6qGNw7oZFR7AUKFfvyhmrQ+wyyIxscpuGQ54b9nG7M3onapmLRnspC08OWro4NZVqVyoB8blDElcb+0SosoxYd9jVivonqBwj7uncwwBKHlq+bntiCBlkLkExRRT/7czQZzC4l4GRorKtT+bXldPpA9GxUiJiEOCEAyf2cxs7QTiCzbDXmoPaAown+Qc2zKBo86yRs3b3c/Fb2LbaysDzO6RrkHwW7DaTP5EscrXUSBYitME1ee0MRqJbUg2UHaPZ1TqKv1aTq4+0r2OVDnGzyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Thread-Index: AQHZSKWLZtovU46h0Eyc/FiMVdpv0a7f61+AgABDQKCAABlhgIAB0RuQ
Date: Mon, 27 Feb 2023 02:48:50 +0000
Message-ID: <PH0PR12MB5481D5D69A3123EEE65BA0C2DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-3-parav@nvidia.com>
 <20230225121237-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481088CBC9B4C99D2527A92DCA99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230225174948-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225174948-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6290:EE_
x-ms-office365-filtering-correlation-id: 7b629534-b89d-4fc9-937e-08db186d2851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tCdeu2tTdbEwXfVB0ElF4/qhs1PilI95UkO4nzXWF8Adh5o+LIUb85CITxsWRc7NlNDpxSaVKPfwq8JbgNa9rWlxqOpvqBgk6OM3cmGKGXNNR1comU8JFHR+ZK1/wYvEWw8FTPdxhZtjtGFX7y1O/6Lri3mGVDTYelfBk+4A5kCLKwYqjrriLYKeWQ+3wimOHuJ3ZOVHvSLSfR5jZBfhsg0Ae5LIC9aVRSgsxbAKLCd6UJZIjXZ7akqNsouoMUWwdb8CJFxC1JEEXD9tIQIdcBFPaROirwPyo9sd7AdP4+/uXqUaSjLPk2UDKVjSdfB3RXJakyamPt9AjE6C+QV3NDOgtTrSI22JHn8jDZ4j80LNTA+hvAN06L35HcD92wBllilfDiSjSLHBvAbECAys6ex6pBv71PMTw53CiAzxOH+nV7wHxhHwPGMB+mNGKbUusPNO6aSW/ZDhMZA/kaJGFBM33cHexm8ByxGCptM/HDNGd5u6KdsCyJURT8tRoMuhEn4DMk4O6gRFMtX7TstlTsXasuW1vp8K8ihb6XEefwF00GkJKsodvLWxZtSs3DZ4aoti2h8LoeFP+SDCgdJFy8owZ6exHUqWcd6Kj6WuAZP4JrflmZmfHUYPq5vbFvakyounEq58WNMZq/xa3+Aa30JAlB5MNA/4Cb5kQ4D0NALC8CjJBsCoiKuVVJrpMrIyntfTzp+UGvpeI3GXQYbyZg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199018)(4326008)(33656002)(83380400001)(122000001)(38100700002)(38070700005)(8936002)(52536014)(41300700001)(71200400001)(2906002)(5660300002)(186003)(26005)(6506007)(9686003)(107886003)(86362001)(316002)(478600001)(8676002)(66446008)(6916009)(76116006)(66946007)(66476007)(64756008)(66556008)(54906003)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+e31bPNDIPmeJAjK/7SuILdjL1vHPEFWrcEM3B2smkyySkoar7WuKrPQPCO8?=
 =?us-ascii?Q?tcWqc/iNlaQ0a50o2JWuHNtKNoqNg+YWTpPNOklg+2RcErko4Ka/RP44lANw?=
 =?us-ascii?Q?pkKtIRvSWO4A26TnN+Dke5rCUiRCzv4UD05S9pn4hdFpV1xlLpI9UqEF7X8P?=
 =?us-ascii?Q?HU9/8fcOr2HUA6Hd3LdlpskgLES4sltat/IztgvFsyh116xvCrTeFn+zV02p?=
 =?us-ascii?Q?OVWmvQ7H4v13YBtf/6mCRMZO0DCauFOMlqtayYAULaj8LJcMOuXtZ4MY1ZiE?=
 =?us-ascii?Q?5zcY4MvZo5z0SqRa1Pe2KGA+g6hjcjodYuO5NcMwUKglQfb0NF8YYpvaNiq8?=
 =?us-ascii?Q?C5jZF7ImUlOMm7xWtJ0ctzlLIWiiC+a8rK3y4TcmrBLDVMvAAgsH8MBA0qj6?=
 =?us-ascii?Q?gbsF2TMXuEqpc9kTmC3bUbAwXyulWjtAExjksmrPvFpnBz9zOASj3huKk519?=
 =?us-ascii?Q?e4jRkjk25l8b1yDvIP0FhYfAIIACRSArBFe0gRmKQ/SNOPMW9LawVbMqvzQr?=
 =?us-ascii?Q?kFHNb8RFFT3bYlPIM3XRya8ifqf9Vemp67YAde1Nd3CkFbiT47BP2XO0Sj0b?=
 =?us-ascii?Q?67nk0U2lei7RrAyqK39jsmV7BTBckcfZGj4S1GRi2gw+84X/VICsAPY65i/T?=
 =?us-ascii?Q?u42DVp0pNPQgdz6dZG7Y56Sz4eu2HhfeRU4K0XQ1nPwWsCGc0GG6tGeiTXz9?=
 =?us-ascii?Q?rKGufvsg+OfZa8G695PFy/zBJmsfGH4piC9SsVlYaCOhhqiZM7O0shNPEovx?=
 =?us-ascii?Q?a7ht+qeDMl/WzYs9ER173BrMC1D1ATRuC5VQ7jMP3AnnvlZzKmCJTeA9vJtj?=
 =?us-ascii?Q?/3CIa8f5DkMfwQ0DLeBNJSFnvHrms/fQJGWqVSWub/gP5O8NHZhMbyF4LwXv?=
 =?us-ascii?Q?l+PvUwP82Dt3px2ngYyMgehz46XTA5n6/urklSdiyTD1ZvvNd1tgDKFG8Cw1?=
 =?us-ascii?Q?W93Qqjfozx0r9p+VUzmrbHYruhovsm6LtPut/fTlzENOLZKf0GU285a+SNkJ?=
 =?us-ascii?Q?vOmNGdQFhl7SxODg8pumUxU2Rbh28CgNcXIRaUfPbj/w03w83cyr6g01WC9e?=
 =?us-ascii?Q?5QlOIfQyU2p8H1l32VeMyL8/wWbOArYvWCrF5J5ZhXsQ46Eg82KgF1norxMG?=
 =?us-ascii?Q?De5CleVROPjm6zZZq3kDCgxlxtSlz5f6GCZAIdLm4243xL/TpQy8TRx3x9gv?=
 =?us-ascii?Q?sbzNQcQQCqcw1PJ6uWgMEWSGh+GW42AKDo9tF5WBGN00pN3dr7F+9cZk6+CD?=
 =?us-ascii?Q?chIYPew9CMoQAktMysQwFtoEWACtS1x5gtXXCyPLdttdskVtln5IP+ASfoEc?=
 =?us-ascii?Q?r58eYCfKd3GPjiXLAt7wh7R6V5ZvD7WyGq6s4TL6MrvBMMhEGoTZ4kKcZ60a?=
 =?us-ascii?Q?AKXcpms81IMxIb3kwv4qgp4VeXViEEyzjhwdh0TsN9AR8Pw35Bk9TN6qm5wx?=
 =?us-ascii?Q?npa82GlFW58i8JtBBV+MfskFgp04QRxyqLZw3N3H1Z8S4qlvgKnxUqNAeiqZ?=
 =?us-ascii?Q?9Mpsk62ecWm/X2oUbK7uaw/VnCjYGL5A4lVRwVE6nLh28GRAc6Fpd+RkDs9o?=
 =?us-ascii?Q?ml8VhBALtt2eEtx0X4o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b629534-b89d-4fc9-937e-08db186d2851
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 02:48:50.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N63CdUDhptofMM0M3O2uDT+bgjhDfvn8Xfw/YmMiRVtbehezLslibkrk3L0RuI2lpyy/3jVd0PnXHtdrgXUAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
Subject: [virtio-dev] RE: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Message-ID: <20230227024850.fK456JFtYImPfkESuhee3-Rb8TnwD8cI6QKIJllAMuY@z>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 5:58 PM
>=20
> On Sat, Feb 25, 2023 at 09:38:16PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Saturday, February 25, 2023 12:27 PM
> > >
> > > On Sat, Feb 25, 2023 at 01:12:32AM +0200, Parav Pandit wrote:
> > > > Currently PCI device requirements section contains mix of
> > > > normative statements for for regular (non transitional) device and
> > > > transitional device under one section.
> > > >
> > > > Some requirements of the transitional device are also located in
> > > > legacy interface section which is the right section for it.
> > >
> > > > Hence,
> > > > 1. Move transitional device requirements to their designated Legacy
> > > >    interface section
> > > > 2. Describe regular device requirements without quoting it as "non
> > > >    transitional device"
> > >
> > > I do not think this is the way to go.
> > >
> > > Spec covers the functioning of modern devices and the transitional
> > > devices when operated by modern drivers.
> > We do not have a modern driver term in the spec.
> > We have the legacy driver and the transitional driver in spec.
> > The modern driver is the way of Linux implementation as far as I unders=
tand
> that binds to transitional and nontransitional devices.
>=20
> Technically, non-transitional:
>=20
> 	Devices or drivers with no legacy compatibility are referred to as
> 	non-transitional devices and drivers, respectively.
>=20
Right.
So the movement by this patch aligns to what you described above.

>=20
> > > The text that covers using modern interfaces belongs in the regular s=
ection.
> > >
> > What do you mean by modern interfaces in the context of spec?
> >
> > Spec at beginning says "Requirements pertaining to transitional devices=
 and
> drivers is contained in sections named 'Legacy Interface'
> > like this one."
>=20
> yes, but also:
>=20
> 	When device is used through the legacy interface, transitional
> 	devices and transitional drivers MUST operate according to the
> 	requirements documented within these legacy interface sections.
> 	Specification text within these sections generally does not apply
> 	to non-transitional devices.
>=20
o.k. transitional device related description is moved to the legacy interfa=
ces section.


>=20
> > So the content I moved is for the "transitional device" to the Legacy i=
nterface
> section.
> >
> > A Linux implementation is free to implement a modern driver that probes
> transitional and non-transitional devices.
>=20
> Let's not confuse things please. Legacy sections talk about the legacy in=
terface.
Yes, it talks about legacy interface.
But not limited to only legacy interface.
It describes the transitional device interface to like the below revision i=
d example.

> If something applies when device is not used through the legacy interface=
 then
> it does not belong in the legacy section.
>=20
> What you are missing is that a non-transitional driver must work with a
> transitional device. Similarly a non-transitional device must work with a
> transitional driver.
> Things you are trying to move are relevant for this.
>=20
>=20
A description of device id vs revision id for a transitional device in the =
different section is weird.
This patch brings them under same section.

>=20
> > > Legacy devices and drivers are covered in separate legacy sections
> > > which are non-normative (not because they have to, but simply
> > > because writing normative sections for legacy devices would be extra
> effort).
> > >
> > > Take this example. Modern drivers ignore revision, but transitional
> > > ones need to have 0 because this is what legacy drivers expect.
> > > Reporting 0 in revision this belongs in legacy section.
> > >
> > Sure. And that is how the spec is documented as you have described.
> >
> > "Transitional devices MUST have a PCI Revision ID of 0.".
>=20
> And that's in the legacy section.
>=20
Right. And similarly Transitional device id also now with this patch in leg=
acy section.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

