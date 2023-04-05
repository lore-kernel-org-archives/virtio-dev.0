Return-Path: <virtio-dev-return-12022-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F97C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:16:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 371F32CADF
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:16:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A24D9865BA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:16:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0C8379865AA; Wed,  5 Apr 2023 13:16:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED45A9865A8;
	Wed,  5 Apr 2023 13:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbnzfmDIoI4YMoW2KNwo46sSFhT1lkt0SfQ/09JT8lVoHBfck++l1sf4Jb7N8ArT0pnzdCCwPIed3X0n70GSYAdtHj5TOnDIzUNO1FYmDL60v1mGcvANh0flWGCV2dpW9j+MAdzjhw+UdsSwPXTlFG/hG4DVgit0KWaQqfsJYnoeNo6E3gKEo5aR2Bp8I5OGsMbBYv4w6U9S5wCGSJNS6ttuQW9F0ouCU/qq8hNxDaoGNaX02qaEAUr1Lpx2WS+jk4pBKEKPUrJ4xnILbIkAFd0275RbLrvf3CynD0aU7uJ/PVEwNwpZmFNRJ+EsuOk4r6x4XhFBoj5jSjJJzHJcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVkHkCobLAhlp9+msFIYu0VciNhSBfo0GSVDiHTyZow=;
 b=KgJXViNLtnfvLf+pb5C6++jxVItGEihSX3r7HCgT6iwYc+n40HQzjAvuHshin9JpLHwT6K/WQt9GCtxfEF2yuMsuHwl1ycvc38Ufuyt1I1JJJFwbSWedyqTttV+aC1nKkd3uggj/5mX87pocrd1CcnHBnrq4CQBRS7MCbA3To6iSg4aMYxus7UmfH4uupTeox7H4HAlEBxPFemlEIlDpU0eh8L4vuyQPYAI7jWZxiXPTjvfY8c9zTWqNK8s0tjJzLYL6LSuPLUCL5CZ+9tX/WeOchFaQhkDnTryYFehu3nwkx3Opf7VsjJe0G7Yf9O+oFvM2nr4lGTwfuexXu66AZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 08/11] transport-pci: Introduce virtio extended
 capability
Thread-Index: AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8ayT6AgADjhmCAAIZnAIAAhwjA
Date: Wed, 5 Apr 2023 13:16:31 +0000
Message-ID:
 <PH0PR12MB5481B5F4F8797F0F795E7794DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548157060FCDB5B38CA63C8ADC939@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405010807-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405010807-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6815:EE_
x-ms-office365-filtering-correlation-id: da2e437e-5092-45ef-41b9-08db35d7f8c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cyQUECm4/BxoAyTYztay5FFmOkdV3A+LhFKiQ7B2ko84j2A6cNoKIpsuqmLvhOMpVVorTie3nD3IA/yD2SekUjm56supKjfJJLyOlR4cGPbcYJ1BFMMjPn7fBh2x4WAO0hnfQNhdeGIz6sy7rmTYWxE1rK6owVLiTpQnEog/pamOvAvNBfrZRAinJbCEpUyL1nx9L0ANlw0Mj1ODoSw5qrFtBVnjD9wsW2VwFFdwHB/i9OH3h7p8wYakGJp9Fk+LG9lOdXt+EEmOhtXVKohJB46nZ9LKFAnwf8LgIzbzcPZD11iT3dJm4TJUCsyednXLc9IrsNhMNLz9WHLjqdLNEmpzpu7FUCvetHWf9XfmLPNYWpLvieAd5mCXSco6qEfXYC01VVafYw9KXCPxniBg4B/W+GpX8JGcQco/CcgBA14gVE9wc2V0B28poFM48qeonJ0LhhlGE1dgy5nR/orPZIlllMcBcOsdv89vq+sgNKOO4xyViLHEZQerFCFJMa+cxrC9ghLEJ4w9Cny8xp8ziqPC0DBLVSUw2E7Zjkq1rzoJa7oO31tuQhOlIm/cL/7d1UaFmKFL6hA8shnDALK11kYyesxLSK4eAHt1Cbl+HT+EkRzC2biKT0xw3cvHO0rG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(8676002)(186003)(6506007)(9686003)(52536014)(83380400001)(41300700001)(8936002)(5660300002)(66476007)(76116006)(6916009)(66946007)(66446008)(4326008)(2906002)(64756008)(66556008)(478600001)(7696005)(71200400001)(316002)(54906003)(55016003)(86362001)(38070700005)(33656002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8jaklGgZ1s9A6Bpb7PDJ7pSa8ZZrvNiSjE5gVE2RDoM3LIZw9VaSapppMrJf?=
 =?us-ascii?Q?uxiS5L6z4tBYl6/Y69buVQ7TMHtJHkZA+WKWrzYLDSvF2NCUqUk53YjIaewj?=
 =?us-ascii?Q?r0ZNYk6h5KD7tj9X6BQLy47PdLASvkLc1ESxu/9+TminYMqfrbJiTlTYPKB3?=
 =?us-ascii?Q?w+ediVJ5WfJz9evGjOp3odcv1W+5nXkJcHycIMEn3nPjUyzrNuEj8UVVg7bB?=
 =?us-ascii?Q?7HTR8r9M1JJkvoMpwTGCk70bBbpZ8vrj1O6g783yO9NrPFsoj/FjR1ro3U3v?=
 =?us-ascii?Q?eozLF2zYbFs0K+Ht70o0+6f4ehpJBIBgXVZRheWb6lE7Fyrf2Xht61EHuMwa?=
 =?us-ascii?Q?OCrbRK5sVILpky0/XWHZzAB09L2plFoumYFWosT+xQhLGIqMb8txVmiB/oQS?=
 =?us-ascii?Q?6Vr0a5XWzYu9eSfYFo9EBfiORTxyFjSvxgqWFdjipSmEKSOjpi1o44G4JigC?=
 =?us-ascii?Q?vYnrdh9lZN9rq8Hz01tDS8hOFy8sDTkPUAarj1DG4D1vq6YvrVtHOUkpKf37?=
 =?us-ascii?Q?V6LlMMtWkuTDKA1/4loYzUzyVLQbVRT/ZxEfWkFZIYqVAOGUZ4EtGFmgv+CB?=
 =?us-ascii?Q?h7hWF43VkC0MeGeB+oro/q/e3aeX6f2A0fGmBixlRXj6D8cMD5gJntqGY/Hx?=
 =?us-ascii?Q?HL87C/DEXovXKuTCOS0gBH3g+fp/LPPp7TQsSAWKYUt3UQVxmzSJbf8hJ1be?=
 =?us-ascii?Q?4P6oL8tVVqSeKeGk168gS1vyFblD2mpGcfY0HcXyUnwmrbEm/hPqPAFofthM?=
 =?us-ascii?Q?Eq+QGoxF6HUuQfiwKWa7K2axOvne22I/vo4lN7kGTM1DWkGMnYIzgpNWwrSo?=
 =?us-ascii?Q?i8sB45EuqfDUfwVl+iOOBDlwMRfgq+lYO5tP9m+KV85/16Zi2NRg1IhwnJx5?=
 =?us-ascii?Q?1hzNifdUT6yhWPHQYiVgxbyRyZMKJKzZ4O3f3n0hjXnhm85IMKWDdzhUoymW?=
 =?us-ascii?Q?V68nuGmxR0j2cyv9vtbsthMYZp/9DY2qlx1Y52Xo2PnuR3oMHxvaYjYi3mo9?=
 =?us-ascii?Q?T8q3L9O+mVkg/nNopoGcsIIHvNaxrQ7aSnP4+/yzk96UbnuPLv65jBy1dN39?=
 =?us-ascii?Q?la1JUcLJzcEVXblSqh5iszHrDEuZFlRQygSHYSia0Hyo8AfrjSVnJ0tU0BT5?=
 =?us-ascii?Q?Yc+6sydUhzuL4QykVV9p5EehAPIPYaI1PiI87hGp/iWzxvQUNLk1Szhnsm8X?=
 =?us-ascii?Q?ywklNMuVklvNhSYRDPTh/c2OcncXXBC/e9/xn4QVVpsZDLqlk7MYSq0k0OQm?=
 =?us-ascii?Q?inm2Ifi0SyrC8R5l8o9zmm5OhL2SrYKaTDITuRvS+jodskYVXqbzB/D6gzHH?=
 =?us-ascii?Q?YgEhdnQj292Pf7TxOHbbXUN65J3IwNK09qhKXX2IknXiuz53Cw4PoIhk3IZN?=
 =?us-ascii?Q?Gu+7DAON5unzIE72qfhDacJ7ceJsBsq9jTY6fYzWoBnixFAfJS8U77GA8DdM?=
 =?us-ascii?Q?IgJWGUA7/Id/M6nWBFnH7X9ruoZwD4wKQ91EDP1zbv2kiA11MkkXUHeY3fo0?=
 =?us-ascii?Q?bSH390WFGHDy+bp3A89K8HBpS76n4cJYDN4/cNT5dNtZrvsSp9gAGooaaq2T?=
 =?us-ascii?Q?Zqg46cgFiTf2PH2ovnEG5Aap97aMSG29q53Rgt+wGfli+ktTKNmd96y21Y0z?=
 =?us-ascii?Q?Y5bUPkAQ3o2MiwonB3Uk5UE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2e437e-5092-45ef-41b9-08db35d7f8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:16:31.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnQo5pyNVgLASoOwRUwO4AcJ8fz7PbrWFl8bnJmQYi5u2lZDeWUgW0DgKAKdz4FTV/TGOIYEEGyGExgkSDOw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
Subject: [virtio-dev] RE: [PATCH 08/11] transport-pci: Introduce virtio extended capability



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 1:11 AM

> > > > +struct virtio_pcie_ext_cap {
> > > > +        struct pcie_ext_cap pcie_ecap;
> > > > +        u8 cfg_type; /* Identifies the structure. */
> > > > +        u8 bar; /* Index of the BAR where its located */
> > > > +        u8 id; /* Multiple capabilities of the same type */
> > > > +        u8 zero_padding[1];
> > > > +        le64 offset; /* Offset with the bar */
> > > > +        le64 length; /* Length of the structure, in bytes. */
> > > > +        u8 data[]; /* Optional variable length data */
> > >
> > > Maybe le64 data[], for alignment?
> > >
> > It gets harder to decode (typecasting ..) if its string with le64 data =
type.
>=20
> In what language? In C you have to cast anyway, string is char *, often s=
igned,
> not u8.
>=20
> > I will extend the comment,
> >
> > +        u8 data[]; /* Optional variable length data, must be aligned
> > + to 8 bytes */
>=20
> I'd keep it le64 or u64, it is highly unlikely we'll pass strings through=
 this
> interface anyway.

Ok. will change.

What about rest of the patches? If we proceed using MMR interface, rest of =
the patches are fine?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

