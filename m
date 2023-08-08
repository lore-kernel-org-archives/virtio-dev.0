Return-Path: <virtio-dev-return-13502-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF6DC04A94
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 06:57:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B971BCB122
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 06:57:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A97249864C1
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 06:57:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8F1FD98403A; Tue,  8 Aug 2023 06:57:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A298986460;
	Tue,  8 Aug 2023 06:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNhxgflB7pgBAoTc44sRa3/r7H9eF/cMFfy5F0zVQpxha5Xy+eM9am15A3Sx4TG8c61/9kceQAcDSCyq1SUmTdjAZCgWKTbPFhspXNrPwtZR8EZ7in0lxLh4/e8/dPZPmWnqTuA4GBTzZAi19yWgf2oxeclCILHPlM0cVnSxcL//xAb6kJjzFWReYO4emG5YmvhvI0stOs0jbOsZ77kB1u4OmGrV8V002G/5yv1i+y14kF7cbQGswu+FERwQObCOGbb4eoJr+ECQSSpe+CJiEu44A6r1GNzj0J5nXaVebJpl8Uf9IFu8fobyBODJ/Lh1jEEpOHW8U4qhJb/67NBXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXOpqfmuPLhxYhrrfBcLVBL9Hj+7f4VHElp80fHy8oM=;
 b=A28sTA1H5CxN4lE+q93vlybOQZXLTTf02UlcbTLv9BV7Fum+DKyaW14SrGsdJttp2H5W3mWsSavVSyQK2WgWqTUUc7krpRt9AVDSKbfqd98AFg8sl+cuQvg242iFtjypX8jxMCt6m/azcakp9sa6TeTAhwGw2vMWZvpETz2K6aIAfDGXgFTmZkNbxEU1plmUIdadcxvNM7D8j0oRvzhR0eFIqqNOgq6Yf2fV/H5PiBySyiFHXymZL9tC2wWwLqX2Kk3CsAJlXgpizPe2MyXCdMR0X82RpXFvfwkFxHSTKqwmOW4STQNs2FwKNGBdeFPIBxU65iQxskhP/pwQRN5eAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAESeeAgAFTlICAAAUXAIAACRuAgAABk3CAAAoJAIAABc7ggAAqyYCAAAFIkA==
Date: Tue, 8 Aug 2023 06:56:59 +0000
Message-ID:
 <PH0PR12MB5481E384B9D13E1B0B37D335DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
 <PH0PR12MB5481D3BDFB943D7856D846A9DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvzU4SE8wBoTE6A56S9bGM_rtv=nU113WhEUL2EBEBaug@mail.gmail.com>
 <PH0PR12MB5481C7090E20AF17A9B2C437DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691477071.6894073-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691477071.6894073-9-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4226:EE_
x-ms-office365-filtering-correlation-id: 5867d6d1-d215-405a-08f9-08db97dca9a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3+63AaFIg5INe9+vA7G67okOg1B+VXQYqBE7cRGPFSAJqsiulLtpUf3wQv97AFa3WyXL9QBpSOv0KUA+1LAHYScm+PEZrXuQr9GSEBFHWsIUp9fTn22lEMdBKY/FVF3I/R8W/Nn/MVDiv5XU76KBve03zvukSfCkjAsbtHX9cEIfXZI6dMfbQ/q3eVTwl5chnaLvtcwWdAQwUhq9Okju6aUI/wLa5dzQtZDEu5Bo4f8d/lJFxE33+TdLpKpCzVTqo+rPIG3sq31Eqaz2fF7lcPEqjOpIxx+62dtDaSP8/U/w1mMXY2QZBe+wp9tBzjDt21s/W5/B4b6e8pvy9rhHWvo2WXqnjLcbQLg2c5WblC+E5fjyN/ckfxr/w3iz+hInuCltzELLSBElCi345TIQrJMck2zW0WuePGnM+ytAKV9hD2Au1gfIALUwOO4M3abb9vpj0v72rcCBbo7a2lcDoTKWVmpKF/zdLHUC/cPAuUlwObkYeT90MSZRbYYPgNnH//vKv48K+Am7uAa4jcMCkMtHyyYO3tKSuW0XfrTpkhL83yXoxnMx2ySyFVs9Y9lbdy6UZo5EkeerW4H36sNN8CWvU7OB9QMkHc+ET+6qHpFBGsUfO4vbTQpqyedpPPcjyQnPnHlFr8JB2b0qjghab37ORJ+L+GvEWE5X3+RHTT/B4AQPypQL0116IRIApwjC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(1800799003)(90011799007)(186006)(90021799007)(451199021)(52536014)(38070700005)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(8936002)(55016003)(122000001)(6916009)(86362001)(478600001)(316002)(33656002)(6506007)(7696005)(38100700002)(54906003)(76116006)(66556008)(64756008)(66446008)(66476007)(71200400001)(66946007)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bsQci7N5dFyz1eOppLTibGPrOQZCpBMLsnkow3M1xcqUOJv9Sh1H+Tk+22+T?=
 =?us-ascii?Q?oijgcy1IQ08p+UYpyB+O6YVzNZlBQBKSDRZD0dtuP+KxR42D6QGel2IMGSbq?=
 =?us-ascii?Q?s2ypq2trj2naA0/TVM5aYz92fGXZ0AEA46mf2t31Ag26vPAUuZ+A3+juGjf8?=
 =?us-ascii?Q?9dqVHS/cFo5TGu/GZZ3bhDSiFlmKtcBakNr65gfak4ccUEVE71GB5VcMTtMB?=
 =?us-ascii?Q?En+Moc8dPxZsAJK+sHOD99u9G4pMjk0Vxd/juj9JQ6otRZxn7aQyS5MBFcG0?=
 =?us-ascii?Q?Nb6gCLt9V4ZJFPTbgMBQF5Par/z2QjWRW9x3d97zkrSmkzk2AZmjPPXrL5tm?=
 =?us-ascii?Q?cSy/Wzl0D66aRp0j77tVRUC/C2dHSK6HJUqkaq1UB0c4bLp5/2d1SH1PsnKW?=
 =?us-ascii?Q?tLQ0uMzNogLuavbaSyh7YUP0MYT6WUNstwtR4fujdpjjS/V8YdtWfmbhdDwl?=
 =?us-ascii?Q?edO7SssOIy+wHbOfdVKtfpLRBzS9CvrhjuN6jr4tB9oOKmjyZuZtQ40ljOpH?=
 =?us-ascii?Q?Gxq8An1yNIh/yQmTjDd3+dYqi7NrdSIV0hO15J8L9dWCSfCSPyMnmgmzwetN?=
 =?us-ascii?Q?6jQfmX4YdBkVtYPz8TbBtQ5jj70JgveTIa82u4BOx2VHkZ8bPtpF46teecio?=
 =?us-ascii?Q?0PKXVkCwl/lDq0glAys0p6oHpcPn3uF1UabhJGBoKYIH7rKuMReTotRr79Ik?=
 =?us-ascii?Q?P6aECTpXXpaUq1Rt5eXRdKuH6jMAktVh9xzSGN7EjD7KQv8vzty+5SUm2MGN?=
 =?us-ascii?Q?ofCtECAO78/RlF6p0+cbiEY3iYzgYYBC1+0BeAzclPfgmhM8nlgAZsGgPN0O?=
 =?us-ascii?Q?W5t864hhwQoNh/8XVea02jyZ030OF1dGGtdIVbSU0Py4p6Ho1+2ExI0BUWhQ?=
 =?us-ascii?Q?G/4Wggj7nyBHpfE0f34k4FUuo2w/qhuKgDzyJ1XPOCC9Sd1hohiZZbEup8ES?=
 =?us-ascii?Q?xyRMP0oacJKGV+eCSwGXgzfwiV/1SbQ8YyrXErYMOKbjxM3e5JvuihRnjYsf?=
 =?us-ascii?Q?ou5KwBYiVxdb8JsMEwghOTmBykPAzv8gsg6LsjR8TKi4VNKPiJJ9VbzUSAfX?=
 =?us-ascii?Q?+IMYoBdGA1zG59RtxwH2WelWi21vkZ+WGuf5QHVoon0wUdGtxNt+E9d9ALep?=
 =?us-ascii?Q?mSSjLBsB6WUqZ9+tcQ164MN8l8CoJuUUiYywIxxSR3siIXYydTgyJsxTdCKK?=
 =?us-ascii?Q?qxjcKrScXmTB7Jof6AHhM5pIxmK8yr9TNbYR7GgjkckKB/9PDH3PBUrgtE+y?=
 =?us-ascii?Q?v4fMZSoANOqZxQSIjRkqYsnhGc/H0JX2+3P/9tbuekAs0SPKGYm6yEeoHmks?=
 =?us-ascii?Q?/g7GhOIIV/LliQbjHuZdEGGaXWTbpJJBbTyyBDPyu3O27+yFoCCQkDqxv7tu?=
 =?us-ascii?Q?rfWdUAgHNhE/SjcTAyMHvNyLCz/r710pCoeI4gM7+8lDFWmeIhD7Uwi8SMDk?=
 =?us-ascii?Q?6dT1E5ubsuhKnEdP+yAqZ5FM8PZkzzPVF/9QjwZqOUBrlWNWxAb5V+Jv+YwQ?=
 =?us-ascii?Q?MJKtGYbQRDsMAwSPPXl8dJ9enlIL8exzNk9uWsYMly7/29AV40g0Y2BjMkFm?=
 =?us-ascii?Q?3y0av1RrK6OBkESkDEY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5867d6d1-d215-405a-08f9-08db97dca9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 06:56:59.7305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGw7b1y26pb9x+k1U4n2W0FxCSAAT+ixv91ivEgtltRa6JOxvWxcTURFzG+LwPtOyhhffXM8nPb7B8/KTZeN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
Subject: [virtio-dev] RE: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 8, 2023 12:15 PM

> > At that point, there may be two functions, PF and switching PF, switchi=
ng PF
> filters the traffic of the PF.
> >
> > Anyways, I am just not finding it useful enough at current point in tim=
e for us
> as far mature alternatives exist that users are comfortable with.
> > I would like to listen to Xuan if they really have use case for having =
switching
> PF as virtio object or not.
>=20
> So the switching PF is that there is a switch under all devices?
>=20
Right. Switching PF controls the ports of the PF and VFs.

> If we use the switch rx/tx filter for the ip restriction, the PF with swi=
tch is
> enough,  we do not need the ip restirction for the PF.
I understood that you for some reason do not need restrictions for the PF.
I do not know why you don't need it. :)
Most cloud setups that I came across so far, needs it, but ok...
The design for the switch object needs to cover the PF as well, even though=
 it may not be done initially.
(hint: an abstraction of switch port to be done, instead of doing things di=
rectly on the group member id).

We are seeing use cases reducing of having switch located on the PF for its=
 VFs.
So please reconsider.
I remember you mentioned in past in other thread, that mac etc is controlle=
d from the infrastructure side.
So, I repeatedly ask if you _really_ need to have the switch object as part=
 of the owner PF or not.
Which sort of contradicts with locating the administrative switch on the ow=
ner PF.

If it does, flow filters vq that is being worked with Heng, Satananda, Davi=
d and others seems right direction to implement simple->complex switch obje=
ct progressively.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

