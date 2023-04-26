Return-Path: <virtio-dev-return-12424-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87D5C7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 04:27:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E5314256C
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 04:27:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35D73986652
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 04:27:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B907983E93; Wed, 26 Apr 2023 04:27:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 172769864A2;
	Wed, 26 Apr 2023 04:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwIy0oINEm+WJuxgjqEYUlQD/rkM3mPV+Dw+1qjETUzZ8jVhdldpXcm+km5CQRMX6BjwyvgjBQ2r4bnKTFWHtDU5D2kaMThNXcWE7QKFvdStvbMrsgz8XFIZ+/uAc0zPpKz5Nf4a3tIYULwJmaYTDrXPlxIzGmUORwSOZzl/X1mCgL64FVSl4KzmcMgegBOatjQPQzrMYAkdb1lw0hHt4/L1CJOlSqw8lU5I5HegMWalkq6Eq44Q95UD6xbUHSZTx3P7JkS/gxor27LBfwr/8+3vs3QDwCzfsX7us5ngWUvXFV3wW+1EQ4pHv8a8IyB1buFNOhgTBtV5qCTkG1oslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdxMCKTKw6oT7HSFPXYuLD2lxxRRfkR8H5AH35VRYmM=;
 b=Rzvjc97JYrSFDIvsMOdAgl9nslqMsGYsoYzUr4YOxnVkxvnGEQPUnnGrp6z/AURrPFWItPsM5SRLaU+VyBQuLwxB94LZOW9KZZo7uLt+JlzaDRy0ZWJNDXnn1t/amd/0pkw7YoGWB2ib4/nbHca2e13guzp0Le6zLNIL4O5cCu/A6VVG5l+ZMwj5oUPJ2SARD5Q59P0OUgCkXyswAHMpQRJUP2pvagDB9iwoC2M0sYkrTWmT/p6xYUYc86hTNgC1xZQ0En7WtB4h5/8mHxQMZXCcUX77zf/OEE5a2PahqQ1I9OVZR2cbx3WWH0aU2iz8BIuaAXXmN8sqaWeA0+UpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [PATCH v13] virtio-net: support inner
 header hash
Thread-Index: AQHZdbY0vUbPhs5ETkuums+/PkRABq88fZaAgAAKkwCAAABpkIAAdpoAgAAAtgA=
Date: Wed, 26 Apr 2023 04:27:34 +0000
Message-ID:
 <PH0PR12MB5481ABA342C384B29E569287DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <20230425170341-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548148E35F4F0242A71FC5DFDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230426000032-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230426000032-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6337:EE_
x-ms-office365-filtering-correlation-id: b0ba6516-45c6-4f77-8426-08db460e8ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PsH9YnoQWNFuqjUVsiXU8B9LmAnqdJ2yAcFcZCQj6woEbGIXgJ+G9046EqZKme7AHLr8PHoZLVasZOgoQO7T3cLrscPvVQXFtNbp4x1NanQ2rfQ80jvEU0pjx9IzpeQ5HowjQxr2W+vzwkWy7saZ0o9hvYf244c2JmCe52b19v0Y0QoLOVZElvBtK+BgJt5+FoQrD3vVCfm0P+kUsp13qtlcM5U5Yy85I2GOhf1Y5zpkxg/Wm5PN45/09LLwNlH3m5Dmtkx/t+dtE6D3NBLd5E/WgZO6CYgtvmtamMN1hZ1z147Bo5ROR6zOYqH4D8aytJBexLJDFF06oKHuY2XpGFIin5IM22WLSCW4oTgRCt+pMyh1CNBecwSZ026bfodNhuGM6Xius7YbyiGcGmvzXDVCKCzCSlBiMFrZNaqzRzFL2B5DszHzBx9fDpf6S61ouGRq6LQPzMhKeFO7q+WS59OFGlBxweu2Lt+wwU2j6ntSy7qGHtZfHcc3BieVkdvqQxgUfJOftPgR6MvJmplwz4fn2j6bmxeOxAj4+33P82qTHb3txGQBoi1+U8m9HQfpHbWbBNGUsPmzg9UHo5gGkWZYDrfpIX4WIiWGaUc5PQ3awlxj9qb4Ib0TTVSaMDDP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(66899021)(38100700002)(7696005)(4326008)(6916009)(71200400001)(54906003)(478600001)(38070700005)(316002)(66556008)(66946007)(76116006)(41300700001)(66446008)(64756008)(86362001)(66476007)(186003)(8936002)(26005)(55016003)(122000001)(6506007)(9686003)(8676002)(33656002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xkFULAe5kjRgb54CYqErgolac0Z5jESTOvwJvbUfSwCrRVc4whMH5m3KsLuk?=
 =?us-ascii?Q?EU6oV2feTusyPZHePXCWHy8CAJYPG97y8vkIBRm9fVc7xPqvWtonOOnr8dfR?=
 =?us-ascii?Q?obxW0B0yKy3Ev/J09F17PTn/k2676dUnxqlb2o/oGUWhtg+AtGGxYB8WFEzs?=
 =?us-ascii?Q?5zcrvl1r/pIAD7pFi9tXEAXb+lagHyI3OoAG/zYGloPwyY1Uq4nqeq1+rLwi?=
 =?us-ascii?Q?kAoG1oXUO7y1Etk/Zr+oDEqGTTdAdvWkW4aAA7PXqEM0dUdkApaykf8zjpxr?=
 =?us-ascii?Q?rFkCAzWx46tPiYEhMJCCEiaJgTv97NoqDzXk0clqiF4P4H1VeEqbKhbBTENY?=
 =?us-ascii?Q?PV7hUHDjkxxyFNTZV0jRcaQZjazyOupBs12FozMBe3SjjshUG0KZNWT6tqlI?=
 =?us-ascii?Q?YDhZ/sgjv2Sj6WbEvL2F26O8+52IaH8YCuF9WxuGrHyJVoFBnGahozTQHBU9?=
 =?us-ascii?Q?plAs9mglo2LatoSCVwZAiev7Y2bwstS8cP/7zfU+GPJ/ZYEJYDDELXxlEnBE?=
 =?us-ascii?Q?j5+ppWWWUYUTElLu4f87q/4qqPFpWWVjMeVJZG8maXT7OjQzNSVGJ5MxFeOS?=
 =?us-ascii?Q?6+uShONtHWME/0V+BiOud1jty7cqAf+z+JWR+SfdlDZGEgspcB+7qpTSt+RK?=
 =?us-ascii?Q?saIkKW4jfiiIB74HMKMhRitXLyjfNp/dfxeq/gYJK7k9NrhpMi33a1BmiIF0?=
 =?us-ascii?Q?7heeY24rerrBP8Nqt9TGwrk8I3eYHM/6UJgQih6HemwT7XZ0YKJRO6EcbIlP?=
 =?us-ascii?Q?uIrVnO+fG18NB//EKFV3NzIUKRHAz+j39Cg2jJaGg8s0CNWwlyfZrtUZFSZK?=
 =?us-ascii?Q?A9qCKUT+xhVV8/uS/MDRaqd5I2dl7yW43KuB7gujDB/ztuxlfpsdstpmkCFS?=
 =?us-ascii?Q?eckQ87wOLOvK/tB/i5tcLM+ZHgbRWvBYC7T+43+Bmo1bMM0jSETNCQ9MTxPY?=
 =?us-ascii?Q?YyzWTJGqtA9PvO+ZudyIKG/GpvYGPkyc26tmvu2OnkUg/RqpF/GO+JF3n+rx?=
 =?us-ascii?Q?CJw0VdMNOr+dGttmQ/PhCFAzh4OQvQ0ZjmAqINqcWdq3WtmQsNTmMkLY7xKL?=
 =?us-ascii?Q?I0yxo/h9MK2b7oTvgr+BpPR5wwy0Sl56/6K/7YnFK4Jg3mFNcWKw61ghJ2O+?=
 =?us-ascii?Q?/bDLYIdXoyqYykYjcWIRcuHD2oSG1eCJPkSGtdKrpXSlMyAsfPksggxRkhTU?=
 =?us-ascii?Q?qd9FCaro2GIcobitTYJ6Fo0Z77q0KhhgG97szjEFgNGQCtnJjLV6tQLz55l7?=
 =?us-ascii?Q?Mda+houJCA2Id8yQIZUO9/oEXWlPUgSWtgyqSTf42VhNguf+AgN10MMfexyz?=
 =?us-ascii?Q?s530jXZI9fhrk2NZ6WXuvqw/rqV8CbefL0CKwf84Rp/qHlocj/c9nly6zxuc?=
 =?us-ascii?Q?wScf8v66MyFYgjxRQn+TjZTpqF3RglI95FO25OWrc+KD8zjMW+t3bs+M/vuo?=
 =?us-ascii?Q?eT+RKUdRXqpf3R/rA8CSGRG4zqkK3qnB1VXEvZgx2Bs09XgKlCk7KA3AyElF?=
 =?us-ascii?Q?meB4d8LdEgS001T8OHrTDQJ3CBSXesNyFJodC8SOCY6vz+cm5GRY4TjOSIbA?=
 =?us-ascii?Q?ZLD0pGkBi6Ys6fjZQH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ba6516-45c6-4f77-8426-08db460e8ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 04:27:34.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3Hmxh89XHOX4WM4q6Jhv9PB8logIMYy8eISgTgjKZN+LniOTnlPfX33GaQ5YTBNkiss19ZI+i7I+NN6ILrygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v13] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 26, 2023 12:12 AM
>=20
>=20
> No, this is ROM, not RAM.
>=20
For VFs it is not ROM because one might configure VF with different feature=
 bits.

> > CVQ already exists and provides the SET command. There is no reason to =
do
> GET in some other way.
>=20
> Spoken looking at just hardware cost :)
Not really. The CVQ is already there, no extra overheads.

> The reason is that this is device specific. Maintainance overhead and sys=
tem
> RAM cost for the code to support this should not be ignored.
Sure. As above its not a new and such query occurs only once or extremely r=
are.
>=20
> > Device has single channel to provide a value and hence it doesn't need =
any
> internal synchronization between two paths.
> >
> > So, if we add a new feature bit as VIRTIO_F_CFG_SPACE_OVER_AQ it is an
> improvement.
> > But it still comes with a cost which device cannot mitigate.
> > The cost is,
> > 1. a driver may not negotiate such feature bit, and device ends up burn=
ing
> memory.
> > 1.b Device provisioning becomes a factor of what some guests may use/no=
t
> use/already using on the live system.
> >
> > 2. Every device needs AQ even when the CVQ exists.
> >
> > Hence, better to avoid expanding current structure for any new fields,
> specially which has the SET equivalent.
> >
> > But if we want to with the path of VIRTIO_F_CFG_SPACE_OVER_AQ, it is fi=
ne.
> > More things can evolve for generic things like config space over AQ.
>=20
> I am not sure what does VIRTIO_F_CFG_SPACE_OVER_AQ mean, and what are
> these costs. =20
What I had in mind is all the rarely used and/or one time used config regis=
ters are queries over Q interface.
A device exposes a feature bit indicating that it offers it via a q interfa=
ce instead of MMIO.
A net device already has a CVQ and its almost always there, so utilizing an=
 existing object to query makes perfect sense.
It can be argued other way that, hey other devices cannot benefit for it be=
cause they missed the CVQ.
So may be a AQ can service for all the device types.

> What I had in mind is extending proposed vq transport to support
> sriov. I don't see why we can not have exactly 0 bytes of memory per VF.
>=20
VFs other than legacy purposes do not undergo mediation via PF.
Legacy is the only exception; newer things is direct communication for a PC=
I device PF, SRIOV VFs and SIOV devices.

> And if we care about single bytes of PF memory (do we? there's only one P=
F per
> SRIOV device ...), what we should do is a variant of pci transport that
> aggressively saves memory.
Users already deploy 16 to 30 PFs coming from single physical card today in=
 single system.
Building things uniformly for PF, VF, SIOV devices is coming for free.

It is not only this byte, but we also see that device needs to offer many c=
apabilities more than boolean flag, so putting non latency sensitive item o=
n the MMIO area hurts overall.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

