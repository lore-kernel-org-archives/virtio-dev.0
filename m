Return-Path: <virtio-dev-return-13170-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100DEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:03:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 28B5D4290A
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:03:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2116E986709
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:03:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 155EB986677; Thu, 29 Jun 2023 22:03:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00E7D98667F;
	Thu, 29 Jun 2023 22:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra2omVcVMUvSgIN2/OPLpkxLTu7yvsSi+GniysWdUIlV2YEaobbBRenmFxmKueyh5/0kXY4dF5zKeHEzcDlr7JzvKGcV0Oe0HIFMvt33DCp3KxnuJJJMw65pkB0D2NKn+gcs+F2SuYbJ9SajDMdUCSltbtMsH4nNlOkGP6vzsRhRQ4I0GtCASZ3jvrjvVYNx4DkvLmqGVOtUY2DzLbCNS8ZYo+nYW/kpCRQgy9nFZeQoULPb2Z9JljcfAlzI2ST+7XNxGU7iGAxam8BUVPTobsOULL832uJyslJfHOpCwMzvAFJlOHzIaq7Z5eFwrFpybAbAG2EiIFuv2IJc7sCpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mmi6hyXbrnj2Aw8lwgi5QHFK0iiTcBvfBg2iR+eY+k=;
 b=Cw78RzLUKHHoQf+9bJJvrxSZbYaQUfRi6xmTlkjETRQhvSFGhvBPlR+z90rDS4Ya8GVMaGWpwS/Kk4HDAzAJPnhiKY5Jb7zpljhRpUwEsBvwbKhUUl2ojk0HtsHWgSTq2DJDRxgahq0IyYzHtKy2HHlArd8fuJQk+gbkawqGmmaghzSi/Nx5OYyXT08cQy8FUYtkgmPld1qj9jejBfPtl56XG6N3VqTrf1iKevBERzK0e3ez890Yefnu+WoTCx+qtqO8mjoLK7xodlfh26raR5pEjC4DrloT3hGHfqCqAnKL4ruvNOLgx+4kFUpWLFYp55qoTI2WEBALWzSHFIKi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v7 3/4] admin: Add group member legacy register access
 commands
Thread-Index:
 AQHZqTvrGu2WS2SUoUu7prURQx0ADa+iM1gAgAAbrdCAAASiAIAAAHOggAACqICAAAB+wA==
Date: Thu, 29 Jun 2023 22:02:53 +0000
Message-ID:
 <PH0PR12MB5481FAD16EDAE283D0356B4BDC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-4-parav@nvidia.com>
 <20230629154634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629174443-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548102851D796A39FEC61275DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629175234-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629175234-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4919:EE_
x-ms-office365-filtering-correlation-id: 16852b6b-155f-45e1-2da1-08db78ec96c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Es4qBwSu0f5/AxnlMr6Q3eLfG9Ds+4Bw0GW7apKuhlr2oMdCpmn2OJCCDtWaCD8D+MKkn625ZVS+mFzLxGlZ0uRJVGhcfY9yYqAsFetY+Awvk4yN7LR22gI4qm72qVvdR+S7MS3Zf13Osnm7FhFbr4LnhPm7yJzG7QGFl2Igs5v+yTe7qxLhhONee0b+y1E0n07mBpaaGF0sm1EkAJDubeaU4CtPxMVql3vL5ypZtRAr7BMGtQJqBqCNiNynT5EFGMWj2V4IUtQzilJYA6j7s9NdnGIH5nxInAcZ+1nxouEtz/HLVcBhRJ+zWHqzsKEglgo3yn1DHa4JrUylDqx9DVkZ5WR9CB0ZdEIzJ76TjiG11jixM8cC93aNGugLEMXFRuZfQ2qkqS3vXwnXHaE+so6U7xIuISxqmfjJvTmINxcvxY4Dg6XL6fDGsUD8GLRiLepp+4tUEeAm1r/eTIPVb0biqDJKpiOMEJH2u2zU9GmUlNE6Lh+xmJGyBZPhraMuaVVdfyrYN/bmOofi7d7o1Dxb2WJhv9a0SZnomLpMWDXk0bpZEl5TmB8j3aQTm7vstW9EV4Q7UT+FHI1PmB9m1M/ZqYrxK/7V4EZgkkPNkpVt4DSrq+Pok/fIGFeFeCh+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(54906003)(478600001)(7696005)(83380400001)(55016003)(86362001)(66446008)(66556008)(64756008)(6506007)(66476007)(4744005)(38070700005)(186003)(9686003)(26005)(71200400001)(66946007)(33656002)(2906002)(107886003)(6916009)(8936002)(122000001)(4326008)(76116006)(38100700002)(5660300002)(316002)(41300700001)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6GLhfE71tnW6KjzNoJXuGNt14eG38ym6JVpG9XV+YkIs1fDRY16ZhHIg7is5?=
 =?us-ascii?Q?FL5bQSdvF1c9dffaRSMQyYqv12T6Xo9bsXrbbGxOOyLSQVpYqlPdpKkQ5Nyq?=
 =?us-ascii?Q?IsZugP4hedzHzLjnPiZoO/2fK8fufv4EWWdPihJYHoZKUPOD922wUYsDkRh2?=
 =?us-ascii?Q?mSKCP3b0+tqFJXwP7ysQzx54IENCDULXDXBexK5meZR8AXjaH1yWehhlHUiI?=
 =?us-ascii?Q?06BNqokQ/PJdDsqyplNk87NEXHQInhtOnn2AgR2OkjTkUY5hjLjpfFTGndPK?=
 =?us-ascii?Q?Ulr42OU4G48li8IgGnYJ+lkgRs88Oz/KbGuxz8KT9M6mt2xbyoIH81e10sR/?=
 =?us-ascii?Q?J2qs93kmPZvYE1eOb7dqXHQgyzwRGuJVeBNG2Y7Oo2olpeKnUXigGDrNtJbs?=
 =?us-ascii?Q?B+YWn7+eXQBqhZUB/jSaB1uD2ERWebinCXJjy7VWLHhBShHYfq5Lige5eFBe?=
 =?us-ascii?Q?O9A9WPAv+4jaFoFRg9M+v51m6O4uBVcILMyfh6eGYUAxMjxGOcDvaAWt7JuT?=
 =?us-ascii?Q?zpBj7SJCv8qjzEdViypDp8vxS99vRdPZgzKlcZjR6wyRbE8Q5QyGaPH24LNm?=
 =?us-ascii?Q?Ep9Bj5zgW/9lqK9+V5PTGLFz3rIESuY8fq2yEH2ibDgkiAvLiKXKu9xAakDC?=
 =?us-ascii?Q?ZtgFSC6p8yxaMqIFUjErvcOtEnACcykQ3wWSXTF28628VKo1PIqd639LCBle?=
 =?us-ascii?Q?1FpgM0i8J/HeaWA7Me7cEsNac4yPbyPkhflEve7RmR6r/JtktuoCd+/UHTCC?=
 =?us-ascii?Q?NZbI1Jc3B75ANojRUCP6923TKJJTLXojl5SEtyMVB0oxj70fvTK0zGUAkZpt?=
 =?us-ascii?Q?OMqDoyoPR8dxnGANFl6qwxx1VQ9ivR1ia6/wOqveT/y2fVQq7OohG/5glJtn?=
 =?us-ascii?Q?D0V4W+ePs75CcQax9YkVnxMYCm7DCCWaauLg4cWOp2q81x2pOZL8Tsn4u6KX?=
 =?us-ascii?Q?5nA1DrLoLsjHIoVCKadEJoCAFVWCuTmo0wsS98b6SgelvFTJcLeyxvOgIlzE?=
 =?us-ascii?Q?ml8rsz3NVOqNEe2G9NFau0/kPwNaLg1fbBElMZJqKdvmXDYu8YOpHM4D2pBp?=
 =?us-ascii?Q?Vu6e9JzYIZShX98ETHW1L+e28JWTbCQrXXsDXSMinPWVrQ6Od2O7OgMCDWXC?=
 =?us-ascii?Q?0eLIsxiHjjlTwzrq5YlVl8wv0pHkvB0FBqofXcc9Q/f/Rgg+utjgQKN+xCdz?=
 =?us-ascii?Q?QR71FZgoeGpJ1zUoCYDxg1KRsW97uxg+t2jyHadGzVNn1M5TOm7P3T4TDLAw?=
 =?us-ascii?Q?NnpiNCyKoQW7wC3TKPCn02QiEfBWUd8X0lNTTUTMLWDo/eI8IvwEJznoEAB9?=
 =?us-ascii?Q?FSyzEm2Lms/+Oqx8YKxyfo6AbOsujV3wl5slAIrscmdBuUiggnDgj72kfr8N?=
 =?us-ascii?Q?/Vnob4c/fUxgFrSjyh2LstKiynfY+41ZjX7dU4OT1ikT1srIZyn5hoBv8rhp?=
 =?us-ascii?Q?5tJjwx1OACW/5oABSX/Vo2PDHJAt/2Gpbx68v/qWMUYs4o6vFLroqeBy7EHX?=
 =?us-ascii?Q?byPNszSnKmonlpcukV8bnfKQy8GJXOBdS+eUG5XXSJt1N6n2jK4SaBiXxhlR?=
 =?us-ascii?Q?NMRC4eQQYWpjj3dgvFM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16852b6b-155f-45e1-2da1-08db78ec96c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 22:02:53.9493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JtsJo3ag8pyPjI19DPQqPJTSJKv2WMz+puhztcltJYZ7kRtiJjskNoJMN93lEeJR5m4yFelmKcce9BuNG4JWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Subject: [virtio-dev] RE: [PATCH v7 3/4] admin: Add group member legacy register access
 commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 29, 2023 5:57 PM

> > I have mixed feelings; I think definition in transport and link in gene=
ric section
> is fine.
> > Are you ok with that?
>=20
> I am yet to focus on wording, can't tell you for sure.  My gut feeling is=
 that
> keeping everything in one place would be more readable, will help us conv=
erge
> more quickly, and the next user of admin commands is expected to be SIOV
> which would need the same structure anyway (it's also PCI).
>
Ok. For v8 I will have link and keep in pci transport section. Later I can =
move as union if needed.
SIOV for PCI and CXL will look very different, so SIOV legacy I am not expe=
cting any change for these commands.
=20
> Also look at virtio_pci_notify_cap and check whether any normative statem=
ents
> there should apply here. Alignment I guess?

I will move below normative from pci to generic.

The group member driver SHOULD use the notification region supplied by the =
group owner driver.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

