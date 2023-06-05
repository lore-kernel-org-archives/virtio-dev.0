Return-Path: <virtio-dev-return-12868-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC5C7EE23
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 22:13:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0184715AA2D
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 22:13:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E835D98658C
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 22:13:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DCADE986486; Mon,  5 Jun 2023 22:13:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8428986488;
	Mon,  5 Jun 2023 22:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhQQlnXaV/81+j5xxExGNlAgQGddO7IOMQuME3jIsnD6ITegg4XWzpsw03EpzNRbkB+8AdsDWeN3SKzvlCnLu/GQPASHMnmDwzWyukiHQzFIx4NxpBspBif2RvKORE1DTRwalVV+fmY5Maoss1s2K4PMCKPI2xn4CV2z/7tWEZmhA9OHGJIH8Hg9Ig4gjEtWsP91XPEAyKExFZUfPJfjyQcYdNuOAXKZQoZ6NNT6plx3Yi6EWjkvdR9NZLJDiiKiYq6oawcs4IzF4Io9KcfmY+9my4vJcK5A/k9MR69H99t12Gy5INO5Uju+lntK9t1O8HvrN3Vu2QcMv8tLoHqiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UksuLVE5j6TrBqH5qr37/90IDei1T9Y8MZfg8uN435c=;
 b=iSvoknzDS8QQ8rABoxi5oKce9A+97INwRk/7+kOICL+SFZjwZsZlv1l37KysPlfYchacfJIrvtMxZWUaQFRQTi5UBFpXknfEvnslQnfz/uCBQwTkftsPWcyqLi16wLXNeNdKtrxo56U3J0++gcJqUzTokdUQUAwQd1grHV7ZGKE++CBxD+wMa/tplavgZ9+AFbnyYFJBYaffOgKPgQUWnHLRC2LOVwi25wWyzV3D6lAlMUuK9fAVkVFx6/yyxiJIRBBvBEwK0+kw41GgJA7riKKhAHi+YLnhQxKTwYlKGy75CPf3Q9K5hQjRokgpj7PAOIfqAJn0i+UtzhhVYBrTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIg
Date: Mon, 5 Jun 2023 22:12:59 +0000
Message-ID:
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230605174755-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB8310:EE_
x-ms-office365-filtering-correlation-id: d855fb32-6678-4346-289a-08db66120609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ch8dIecG15zMq1oE9tyS3F80Aw7CUTVva8eqXmAgjw+UKpKqriW2bT5rbOIJQAbWVkMEzM9Nitj1MhBOWDtdbVW+VHhbgdMh39fvvxer9dc/XyIJI0F36ZSKYYsOKEEDwICOCT2jwOzNP26iWkVcK9kFgPe8V+1F5HjRY7pXx3m6MJruSu1UhyyGrMUEs0/rnVpYi31PoarB2dtTHZPVu5SlKTKlQRtgaHmu4uEbSTx6SBWk40HLb/Wgm/6UZzOo6KU2njF7wraZFJkApjCF8bkYIGt9cPIyl7V+aSx0G+pNH4tkkjqsKVqO4qdNI8I9SFMDeT5kVJROtKW/OFyzyYGMsM7j+yfAGXtKErQIZ7pX08dO/yLbjsWR+8eBZ5QGw7/JxDTIo/RvDP8KNh/mc004/usGJ64gQnlp48TZm9eAu8925WLsHqiLLwy2ngelUEE2q/ffn90RN/Y0Cci62c7X3ukp7iNu8gGXHDy91foc/+209gXQoUnEYAb9dwK54WJrd9gGVRipDE5O+qGP6VeU3IsHCC8aM1IgUcHU4Y11gbRfyRq5gQe0SMXvapJBEqUYXHunSF/QtjLP/ysIkGntdpuh1CDRAOMW8Vc9Ri290DwazvLrwYCz2c4esLjX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(9686003)(107886003)(6506007)(83380400001)(33656002)(122000001)(38070700005)(86362001)(38100700002)(186003)(55016003)(41300700001)(54906003)(2906002)(66446008)(478600001)(66946007)(76116006)(66476007)(4326008)(8676002)(6916009)(8936002)(64756008)(316002)(52536014)(5660300002)(7696005)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8pxGcxazQF0HwP/qLhYzyvCeVhaAMjeBRyNyan8ACn9rkoCIV7n9OmLHn+6N?=
 =?us-ascii?Q?f//Re7RFA4QlZgAqxm4vlYjWYiDX4nUujFmovO/BakuE4t5JgQdJXl/djkkw?=
 =?us-ascii?Q?Wm9LDERsjTl8iFOp//3mTMyHSoRbdieg4Sxdx/rhEyQ+Q/Q1wt//bjMzVQDP?=
 =?us-ascii?Q?IJ3Mv1KQdVEBZ8O+jwXzxF+gBYsVKhLmOpMg3VNrjJlx+hH7uEnA7jYcrZSR?=
 =?us-ascii?Q?DEAhIVehkQ0jWxSLhEysPtNmn73UHEyRjfQMgbCyx2bgdt06jmD7M+fvDJDq?=
 =?us-ascii?Q?GbbzsHEcbzS2JSz7DSn5NHmxF7Dc2oof4Z71ksnr43rlcxEGIhtGiTv/IaXA?=
 =?us-ascii?Q?F2tTnpcnnvHOlUUkzNW2H0zgiAHu3f/2mcYkshqWVjHt5cZ9Ws9tC9chSxEq?=
 =?us-ascii?Q?OG+FAd7/uAXSgavCM1hw707qeJcqVJ/qppQzGkF99H4E3AsQluXrI4WbrV1o?=
 =?us-ascii?Q?5ZfUWIN/uMARGS7o149zxumXbenh1JCNoJCV5xa3s+3Edz3JtCQcRmCIMJmt?=
 =?us-ascii?Q?5LeroboRYbE89/fwzTmCLdUE3Xfe5QSJLli/0V7jRaxbn1ApQWfT0c67rywk?=
 =?us-ascii?Q?PLcBUNWyJpOveWuih2z6vV7oVQbMiDQZhnmrILGRq6n6uiJhMtj23Gq5V1rM?=
 =?us-ascii?Q?1/nEJu2p+BbqnnKhBOkE8in43BRcy+qItHW/Hz7jEC7QvW6TBY44JDKcsEMC?=
 =?us-ascii?Q?Ix1rP9rAWaJ4pq1JynmbpTDQgEhbQSkJBgf5AydkeTwlIe0Jr60Elf3jxytf?=
 =?us-ascii?Q?APyx3S9QmJbvKXxmTiKpAevv+ChzszUM8uXay1HJsHWl9T5Xkmm9UFsUDWb1?=
 =?us-ascii?Q?7wGj1GNrrXpB0i39jr5Gcfm9nd22KIf4y4O7E+U5I/6FK8iuzVVud+3dcseH?=
 =?us-ascii?Q?e4T03mCEVce9vrTMRd6OAiQWyeQAE8Id5ARWFIgK/eOUVtnu7EK3FjmmySmI?=
 =?us-ascii?Q?I/1IHpLedi4FQLvk4s2/qYOkiMjdj4cfFmR2VLqXftBFOyaesWkTAiBwJDBW?=
 =?us-ascii?Q?F1P6Ixs49Xoh+AJ2NXCnn2PcqxEbFXG2B9y0ZvkWaU8dWjoqMozJRW6VIfl3?=
 =?us-ascii?Q?7kz0gpdmMAPah7ZCNqQ/Zg4H+JJ62p7lfaauVA4nuNly36PQaanrezpb5ahv?=
 =?us-ascii?Q?3acusX8e9yiEqr/kpKYg4pDb3JzcP2wGMoO8Ui16OJ8uqNi3PoLjA4JzgC4T?=
 =?us-ascii?Q?cZxuc0KpFja9Wblmbfye95mrY8M5kcUhiCNrpMFCmz0ZZHxI8TZThk/kHHs+?=
 =?us-ascii?Q?aQUKFNIIbq+pQ0J4SX11nReVp+rDdu7BFX8zaBNAoUyFsHkTt9ai9bXAdSRw?=
 =?us-ascii?Q?xiRBoxFoRjFDqARM2osv0O8AXOqj/cZPxMBn5ROy4mc87fyT55TIX6H1dm7H?=
 =?us-ascii?Q?sSXygk4qBsfaaX9XaxdYjlrGoT4e5fDNaJiW4cEqiCzA8bJDurRwamey18jg?=
 =?us-ascii?Q?1G//4MZmT7ENLZvZoGcRVFQxUu0A5l0wIDBBRrOOtyGEzPDueqTfcfSvXnA9?=
 =?us-ascii?Q?R6WALRAA7PT9gmf/eeCV8rn7AMKccRviVRG/XowgkPZVT+ZyaczISZDFsG4H?=
 =?us-ascii?Q?syWp7MrdTcDqQsrK/IobS/u0BS0ISuOQvIpttLOTqZ39nrafrewRJe2LFeeR?=
 =?us-ascii?Q?yy+Vo2xFTU+h1fV8DZOjPug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d855fb32-6678-4346-289a-08db66120609
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 22:12:59.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KJ1Yx6uqvBJ61t+SQWH1wHdgB9fLI0KR5RwHQ2i2x2ZrKzl9iUQjHbwbnG2F4dbhw4DeXfq2xTzHu7mAR2v3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Monday, June 5, 2023 5:57 PM

> > I would surely do that for all future devices which will be self-contai=
ned.
> > The cost of doing that for legacy is not worth the efforts.
> > And since we agree that read/write 4 commands are OK on the AQ, the 5th
> command is no exception to it.
> >
> > We are not at the point of questioning the existence of 4 commands itse=
lf on
> AQ.
>=20
> Yes I think these 4 are fine.
>
Ok. so we at least converge on it. :)
=20
> No. The VMM talks to either PF for config space or VF for data path.
>
Ok. than offset 0 for notification.

> > So a AQ notify query command services both VF and PF.
> > It always returns the BAR number for the own.
>=20
> For the owner? owner of SRIOV group is PF, not VF.
>=20
> > A PF would have delegated the window in the PF BAR to the SF/SIOV.
> > And hence, this command is just fine like rest of the 4 commands.
>=20
> It would be fine if it could return PF BAR, but in your proposal it can't=
.
>=20
> > (Linux already has SF accessing the PF dedicated BAR for more than 2 ye=
ars for
> non virtio device).
>=20
>=20
> What's the point of this discussion even? You ask some questions apparent=
ly to
> clarify what issue I'm trying to address.  I try to clarify. You then tur=
n around and
> say we agree, there's no issue, all of this does not matter, case closed.=
  Whom
> do you expect to convince with this line of reasoning?

I really don't understand what you want to say.
What I explained above is for SF (not VF), you asked things for VF...

You suggested that tiny stub vfio driver to perform discovery of notificati=
on must be done only through the VF without explaining "why such rationale"=
 when there is anyway VF-PF driver interaction for the AQ.

But anyway, we need to progress; since the notify offset of 0 is acceptable=
 for legacy VF notifications as you suggest,=20

I will drop the 5th notify query command for now.
And add description to use the existing notify capability of VF with notify=
 offset of 0 for legacy q notifications.=20

Rolling v4 now.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

