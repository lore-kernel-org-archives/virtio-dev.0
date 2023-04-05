Return-Path: <virtio-dev-return-12029-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E657C76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 15:59:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 74BBB26A36
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 15:59:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FF119865EF
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 15:59:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55A989865AA; Wed,  5 Apr 2023 15:59:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F5A69865A8;
	Wed,  5 Apr 2023 15:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5fX4KAmCqEoHXvGiP42oI3Wd5PygJhFbDYU+iT/ZBttNczZY9iXcfWohhCIW4s+/ewdQzm4PbX1XjxGTLlJA5KAYy8N15mKODeU4CxKVUsYRqEiOE3xO8JV0QwhYhEwVicjdupbqN+B1SPtJq28Uq6dhbIdaKX19lZqhXN02Wt3EzQCtdOvzeg3g97kRkUEDnDKjB/quZTkssG/5/IxlOSlq9xPPFGjt85SorpZrmLiiN3JJ1qsM7NspnX2JSlm72+zerfcnEfus36ehzkiUCPmnr63Bcp6txsNWWPa8zdUhB+EG26bIOn0pt3rmFiwZrRRcyZFZ3JPdoBe2295NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rAjqYbRBz/rUjiji48nBa19peK8VYT5Hqg1MrZpDLA=;
 b=GRe1MUjRIP7KQV/nijOLKOPWS4hevz8Qo5UaVC2+0Ac3Lck6oc3Iu/pF5QpsPVBRJBT7Fde17DbKwE3cALDD6O0ECh8EvK2/MA52zoh014ve4DlJbtIPpQ/aMuXl0zIC18XOslHhjzd1YU5hMbh+S1Pzd+nMxheeUiFpdhHK/p98go1FgbzSJV4BdiwQGUqZls56/CxyovQ4btQKAeFtf2d0/f3yI6Zow4SwEgNRlwrwwW5LxJXgsERtJiZN8opna5XJi8NFzEc5qWHJ6BXrDjofZOesWEHbEaOtgDSNOrBGUrXUyFIvXeDFLxUJXJIUmub0XI+XcfEfz5Co3nSl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] RE: [PATCH v12 03/10] content: Rename confusing
 queue_notify_data and vqn names
Thread-Index: AQHZZ1r8zVHaZ0BrZEO8XVrJh+aoSq8cMK8AgACDgmCAACNfgIAAAQJw
Date: Wed, 5 Apr 2023 15:58:55 +0000
Message-ID:
 <PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
	<20230405010657.612529-4-parav@nvidia.com>
	<20230405012723-mutt-send-email-mst@kernel.org>
	<PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405172731.561890b1.pasic@linux.ibm.com>
In-Reply-To: <20230405172731.561890b1.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5968:EE_
x-ms-office365-filtering-correlation-id: c085a627-9cd3-4068-f53a-08db35eea8d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Sh+U7EiescunCWY+Tjw9ZMCpNXxgOR+noHWBIoqhCpvqXCtfzEm0a6dUH8qu7ap88t9pStH0YzmhhkfJ/AxV1KdQmiChkA/MA6Urk+tBpRxnwC1FZQmwZDS9vRcD7lPSTFZdDuJEybM40mZP1gCUSqK1NvxQaJqTc5JD/ghtx7cFzNApa4I/V1nB7hPxddNJsKoWLRZFQgaGleN2c13SpRQ4Oln07815F3O46sx6YQwyxaPLVfKc9B+UCMmP07QBVUblr2mJIBsBNAozVvfjNBX4LO+EYff4CQ91Wzr/jQxPYuubxseqa6rXqw7WtFBFwDhCtukP44JqdNwxoxU++5pQQzv/O5QuFX6zFN8x2ahOVP3EoHBC3a5IfGFRkq76v9CDYWM8094iFMMlsa7+95T1HLECkO9/PPKL6K13ekFycqiAEb9PkqEWtqbrgOPkxU/z4sP37QRYfaf9B7ysKrBN6te2+zSTDGRo3SpLtgNsV5bktOnj12NRxB1fO9XENDa3g578dIiD/wfa+dRWeXTqntWMjgVBVb4W4a3Y9BNjpWbzennIgpTtFk5UibqT86t+XdhNM2SR8drf7WGPxcwybe3xLjAxHCt+WmFrZw0gY4DTBUjLs6zQM86au6E89ywXdQXmmZVQMYdxbFH5qWaOkxcU/zv7RknPeBb0k4o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(107886003)(71200400001)(7696005)(83380400001)(55016003)(38070700005)(86362001)(38100700002)(33656002)(122000001)(6506007)(9686003)(186003)(66556008)(66446008)(66476007)(66946007)(76116006)(6916009)(64756008)(54906003)(52536014)(41300700001)(2906002)(8676002)(316002)(4326008)(5660300002)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oXUX741Fl3HUO2ZvNFJMboytTmnjX8uNai2ZY0wmUvUZs/Y5XjzB8YEeUAzq?=
 =?us-ascii?Q?j8QDk61noZkDSdIF3AkPyPVs2I+rFrN7tAsMfR7XNRxuyH1cmWBewFsCRr96?=
 =?us-ascii?Q?P44w9lNdwfKCr9q9g/jhYrOSxhKmoXLNUE63zhmb4N/wJngqh7IzClYGuxE5?=
 =?us-ascii?Q?jYN8W/peOiyVB+qnZFGs+MWifFtwLs1DXFth6c2P+dI7VnS0sIVgpRS+IWn3?=
 =?us-ascii?Q?BCc+uwzUxX9WJTwDUtbX4+shdl52tKG4725SU04N4bKMaJSRf2bHRYjoLKU2?=
 =?us-ascii?Q?AzH6Ug6ilYXzxVQdl0yUEFaoLM6jlSCd0VMB2ZVs3OT4ZBXiC1svmfKg7qOB?=
 =?us-ascii?Q?KY2W9oM6uI/JHWp2ANJAZCrvjv+ynnk8fAvRrDHKZY65SfMOyv9/7Wxz3oPU?=
 =?us-ascii?Q?YFOIvZaD9o6Jgjiep/HMs1z4P4lNfKrvI8TsbT5l6zDO2gwCremqXcBYhdiz?=
 =?us-ascii?Q?eQSaYW4DpD0zMCCspR0FD6/73lPDW0fioS7VrgjwTZRSK6Im9H9FBL8NAgiZ?=
 =?us-ascii?Q?Nx7AP0x9ndoQvC52gjFpSz5okua6xPjFVm6w8ddtF72aA4Zqw+YF2aTT08yl?=
 =?us-ascii?Q?6Dt3ZceDGTXuE4OdzENXpohVrtQE3INazI8U4z0zUNlKKPRq6uBY5T7VRPZ/?=
 =?us-ascii?Q?GNvQN3xqeaS67WPbXR77nlo+IAfFEH0GRFWOGmaih4iUk+RgA6r96Qmqwl4R?=
 =?us-ascii?Q?JNP9rwBSRFMJXSmcRqxzKq7SB+qdSN3gHTLusR2b6y58p9qV+GsadDDef4XW?=
 =?us-ascii?Q?6rs5Iz5eAfNIAiYuwNNCBaKhsJhvQ6VVkX1GXYHBKBdHrX+Yn4joT5Gv87OS?=
 =?us-ascii?Q?Dw+nkTKzRHUjizxD35S/KPfve/FVACVoFxpFVjYg/5WMiSNyryhqrrC43dkp?=
 =?us-ascii?Q?NzBXY+hF1WwczHxNZ2ue4TQNoAz8XzlmObDLUpBQQzsiJlHVCx1sgNwWp4Yx?=
 =?us-ascii?Q?CYLjTRWGygSZ4hVj08ryHVJl4uWEyVhjIZhtWSHdbKqoNAm6gdoMlZzih/J1?=
 =?us-ascii?Q?LPFtwbkjewVWXK4dXI3ydcyBPNrK2iX7yjeGGPA/r/Y/L83/hJCEUA1NPGZ3?=
 =?us-ascii?Q?0uaD0/dv+GBBEWPl+a5pbQ4LutYz1re50s2H/JivZeJ3ZDsWCAoG3/tcY73l?=
 =?us-ascii?Q?ChuG5WFcWw7ZxXLoWCdWo0hHLJ+WlK5XKVSTc2nXZI2VzQVjwfsjTYMMDeCG?=
 =?us-ascii?Q?Rv/Rf6DVcJq1e3wxtnIO5SqU5JnB0hRgj3IG8DuWZZFZVTbSK/jROFP3P1ce?=
 =?us-ascii?Q?mgJbpFngZaRt/QkHVCm9euxMMjdxDvzEoHdE1Z0/wD0TPCCjuzAbrvRPxK/y?=
 =?us-ascii?Q?yKXRZnocn1IRYJxi3NV4yR47nrggem3zlb/ct10Fi0NVyOgotl/mtjzmvD0Z?=
 =?us-ascii?Q?BzfpZqBRdbL2g6KpzazjLy2uWq8vp1Tn34vm20C5qoVLpqLGsnno/qisCOOH?=
 =?us-ascii?Q?GbIvd59EmFhI2p8yfCi7kgSzuoIgUTuwHdKrXDMbTByZ4mJfyh36k7yQDNeY?=
 =?us-ascii?Q?RnP4ybQZ7PL9X5xA2st7a9hOTnB4OGInq7OkQISfIuDiWurfe371n7ASlimC?=
 =?us-ascii?Q?MAdiD/jIaWQMdokP5CU1NiNP4WV2m2Y4R+oXCkBhwvfq67tXK0XDdG/48Ffe?=
 =?us-ascii?Q?WNQCZFjQKrT7yLwfzBWLioM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c085a627-9cd3-4068-f53a-08db35eea8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 15:58:55.4028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgTgpMAolPN6ErKxay5SCmNESKbdXYN3rbYc4C9ed0maprJYITQADhr258crDuuZUNqUSfubJNUzOTdS5LpjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
Subject: RE: [virtio-dev] RE: [PATCH v12 03/10] content: Rename confusing
 queue_notify_data and vqn names

> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Wednesday, April 5, 2023 11:28 AM
>=20
> On Wed, 5 Apr 2023 13:21:40 +0000
> Parav Pandit <parav@nvidia.com> wrote:
>=20
> > > VIRTIO_F_NOTIF_CONFIG_DATA is such a narrow usecase, I don't like
> > > burning "vq identifier" on this. How about we just say something alon=
g the
> lines of:
> > >
> > Ok.
> > >
> > > When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, this
> > > notification involves sending either the virtqueue index or the
> > > virtqueue config data to the device (method depending on the transpor=
t).
> > >
> > > And then "the data sent is a device supplied virtqueue config data".
> > >
> > Sounds fine. I will reword it.
>=20
> FYI in an other thread I proposed calling this a "cookie". Sorry for bein=
g late to
> the party. Yet again.

If we spend (waste) more time, we will find many examples where "identifier=
" and "cookie" both are used in things associated with computer science.

That too when same set of people has accepted text " internal virtqueue ide=
ntifier" for same feature of CONFIG_DATA even though somehow it was not "id=
"!
And when this spec refers to an RFC of UUID, session id (not "session cooki=
e", even though session id is opaque and not meaningful to the recipient as=
 per Wikipedia usage desc that you listed).

For sure "cookie" is better than "config_data" and I don't have objection t=
o "cookie".

But I disagree to the claim that "identifier" is less good than "cookie".

It is pointless debate of "identifier" vs "cookie".

The union format is very useful to describe this crisply, I will use it.

Do you prefer to rename F_CONFIG_DATA To F_CONFIG_COOKIE?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

