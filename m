Return-Path: <virtio-dev-return-12212-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF16C77B71
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 19:39:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44C742A83F
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 19:39:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36344986635
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 19:39:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B43298662B; Thu, 13 Apr 2023 19:39:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 163659865FF;
	Thu, 13 Apr 2023 19:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSRMHwKxFfNp2ezLkoyJCwXoNpNrx8e/SWunKuMY/kQIBL6rI0UrqFyQH7Z6nidjn1cLF6ei6v+CgHaOq0ESSqonyK7AKEvI+kHdXvDEA/+vPWmRT00+kR/izLc0/nU28yME6FQvk7LYPxcYGK0gQ9VZ21/o5s4vuWBMhI06DScyFnSiT1UeKTqBbWuncrPSOXFK6OGIiWWY252RQsV/Xrz+sbmh0YCf38jjK8/EQRvLH8uuf3QJfkn+ke+XsfZ87SbVzqJinotoaIbnk7yYmDhaty3Ar0xoLnU8SPa1X2QG+FEifpKegcHyW4oR/rOlCACscN+bVe0MAQF13l92UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBYqo0mqTCProvSNIRnYZlphSzhpAul99mozoG6BqNg=;
 b=LjFExJRnZqEQTkdH0KHd2z9Wf2uD+jmbOJ/ZPaKZzdeRduDNIaEJFzyfmgxkGxV49DIGkcYPsU5hMd0NIKRqy3IgVvGlm0OwcWaGb022gWfN4Px1y7ljXpSN4ToqFgP4BpHPiplkORPvZ+TLBtW9ei3zcuzI9yXrG6LLv/j/g1yvtZdPXiDJyhuCjbwuBCKdiqEW0P+8kvm79e8MyJZyky1eFzIgZzjwlxz0WQjQIq7aAxa7q6k47DxYE3DHPnQ20Ow0ZiqSjvUcuZbJdl7v2aMTTy2E5QoYwXzxd/J3oISDDTVGtbK6OO/h+Mz2ZwWgjezHTQH3JpIR4Dze4cdM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfA=
Date: Thu, 13 Apr 2023 19:39:15 +0000
Message-ID:
 <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230413130326-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB8571:EE_
x-ms-office365-filtering-correlation-id: 8aa40ac0-4cec-425c-9553-08db3c56c402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A1VEaYNOY9L2d7lsl2hieK66d9A3q9F0Jywn8vHHwjoMIbTuU8faK2a0ueSms0WOB8qyv0Lw/lNl24ihZNoH7g/JJte3B3jPuFvbG/l3AUu0R2EYf2R1fnXUlnDkkxb1dWoi5YvrcJ1jSQSfNcKEJMcyIjJuoe5i7rb7fX8IODQAw2bWYsOqmcSNGB73V7LcgJKPhaJmWUDCTpGhrYRa4xgcvU4I6ohynwWqcDa3uKbKfrRKQgVuOrni0andmN/HACi42CJNOhL9QU9zv6Cep2qpWgMyOSH4XMY9p3wx1eCpWs7INqu96i19NR9/WsP9aGO+zTEN7qvle6nvoCsjgruh9hHlsNQnKHbJV1TZvi2AJpQ6pqI1liPEUS2KvnN9XJHn6jJCzT5mz88oKb6jjX3YGLwp5FVdvHhh+Bi1wGfOsxlrjPrOhnueasdB3epCBPfiMk7eTdIZG0Oo2Cxoq+O6/s7HOkjvgkjRBcnxBM5Fz70mA21ifVQsqnvhlrwA7g/Ru4OHchNyhxMcb5L7nlPy/rIdTt9CtSLCLY9KDlYa8bJHO8UGlbyhwPxR6wQeKLxlJleh3bmzSDurPSl93lttUcrte3u2i5cLxrt/pia2wYllz7iEyopQhelvR+de
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(71200400001)(33656002)(38070700005)(122000001)(5660300002)(52536014)(2906002)(38100700002)(55016003)(316002)(86362001)(8936002)(4326008)(8676002)(66446008)(66556008)(64756008)(41300700001)(66946007)(66476007)(83380400001)(76116006)(6506007)(478600001)(186003)(110136005)(26005)(9686003)(54906003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RQWVIDpki1ftxq4o10GhZ5NkpA8aWIK8Od0TBkcbmbKeSdVafOdAaAPMnCZU?=
 =?us-ascii?Q?4qA592X3nk9NneD+64qHuovxZGtdJ33gWayYlm2bWLcI1ZW4NONzHFPZ6Y/D?=
 =?us-ascii?Q?yHzlRy/30ny9qZSBvV3uqs8iz7OH8FKf50pf6zWTIP1Xyw8pJf+mT1s2AAYY?=
 =?us-ascii?Q?6ngtHBCcsaUOv7IvdCTO6zHv9y9E9EkDqZNGrwBdpXB9Klzj4+GGWeLzt0EQ?=
 =?us-ascii?Q?9AN45vRqTHtVQROkTjltwwulkKYPqknvRNqlTTfomoEhWk4/I1aEEyWG31d5?=
 =?us-ascii?Q?SUAeB8OBFQVvyt4YxnY9ST/QNJU1FT34bUhVf3RMoR+1NHrIHrBpfofcokIE?=
 =?us-ascii?Q?SCkwD4FepvpCtNCaM4K3jlKllTuc8fbzdY1wT/7FNUt/k7bCcqjCu/4DmIUo?=
 =?us-ascii?Q?bB6J23QX9OEwOlvm+MS4y1bPrZQE8EXHT999zR4cIIM+8bdrYuKLJcFbQg/b?=
 =?us-ascii?Q?vhog2Ovs6NNe/ANFrJkPIv/gJzY0Ul5uzZBrQe9YGaNzrMJEUvyMkEaIzkIW?=
 =?us-ascii?Q?Qt1RllgGTOf8H5jEI8BZ8ArP/QJLZ0+ttSvKm9FFb9CrtBD/BaLO7+fPf3NB?=
 =?us-ascii?Q?+l/GHjFvrhTNQp1O5AGP1VwKF9iPMwQgcjHuO+6En0gV9Yibr3ZT6Eq1RoGT?=
 =?us-ascii?Q?Vfv8mZQx7DbyqCWurF8yvetzrrjl+Hu7ESZJGnVZ94QaWCpBxUULBep6QmSX?=
 =?us-ascii?Q?kX19DGH3wdokCbp3zMCa0DFt+VeDsQuJrKm2kIMNBzSDaxu8DLAJ3s+acIKd?=
 =?us-ascii?Q?0JspCRsOfcPpfaFKt4wcMfZvevmKv5pXCep/eRxOw65H6oMzB1R8+700lVcP?=
 =?us-ascii?Q?+dR1ImMkaHKAuXn4z18s23SDhq0jbf1vUjZLOh1Gi2NP3pzfL7u0fIEk/AKy?=
 =?us-ascii?Q?ev1cfo5/vOhSOyALHFXvaxwRI9FCvrwzPxdi2KGlLd92uySSNhvGkldJ4jCP?=
 =?us-ascii?Q?q2gbfWhrFhLPrNbHCwNgss8hnpQIfiQmOaEyxEOFbmp0qUkxBpwhQk6zpozd?=
 =?us-ascii?Q?kwujQrhrgK0wh6HjATYl0wkYzvzYixUUACiF2CNbTPjTj4T3WoPxa7BEdiKR?=
 =?us-ascii?Q?f3TcpM0qkgLpMYJb+eHe+11NLEq/NGXPmB9rGHTzthF3ef/Yi2U3n6I+ub6M?=
 =?us-ascii?Q?X1yBt+2lMfwD9IsVav3YxDcYiCh5XrLp63+udkKrnxWrwXhpH/2UPE1r2cZn?=
 =?us-ascii?Q?PnysNHS4taAOXTBUU+4jHs9Ros4TuIJ10V73YXmD7OHHnEqCsO5d7yHayGqr?=
 =?us-ascii?Q?mpz17/SDIxilJywNXo1JEr00iSD+X3BqInNg3WrwbbqaH/sjHj42UvDyyu7w?=
 =?us-ascii?Q?vPmhzm4t0WAY/UgNbwvmjABuWzbNwRqeUPz3gjE0Nagn/gt8DBXT/WS96Knu?=
 =?us-ascii?Q?M+I0NarQ31XNOta51+nJlLoLYcrS9KYu7DqGB2I1X0l8YVDvG3JSBOKh2+wH?=
 =?us-ascii?Q?DdBZR4QDXKoMSBhTcye2wwTHGVDrS/r7CL8iuoRulnA4p4Bx2+zXi/cMqOVJ?=
 =?us-ascii?Q?A5NNExk7T7lJKlb72jhH8ckT1TYSgjJWvIsTpjJ+dievo5d7wBHDVQUUZpra?=
 =?us-ascii?Q?EtmG4lSN8X1NwQ3byuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa40ac0-4cec-425c-9553-08db3c56c402
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 19:39:15.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Nq9hVCvYr3TsGJ3kqdYY1a3I9X8ME7QYLFd9OkW7F0t1NeBxgxay7HH5SzDJz7WKZ8EXkaz1CU0LaQl7wURNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, April 13, 2023 1:20 PM
>=20
> On Thu, Apr 13, 2023 at 01:14:15PM +0800, Jason Wang wrote:
> > > >>>> The proposed solution in this series enables it and avoid per
> > > >>>> field sw
> > > >>> interpretation and mediation in parsing values etc.
>=20
> ... except for reset, notifications, and maybe more down the road.
>=20
Your AQ proposal addresses reset too.
Nothing extra for the notifications, as comes for free from the device side=
.
>=20
> > > >>> I don't think it's possible. See the discussion about
> > > >>> ORDER_PLATFORM and ACCESS_PLATFORM in previous threads.
> > > >>>
> > > >> I have read the previous thread.
> > > >> Hypervisor will be limiting to those platforms where ORDER_PLATFOR=
M
> is not needed.
> > > >
> > > > So you introduce a bunch of new facilities that only work on some
> > > > specific archs. This breaks the architecture independence of
> > > > virtio since 1.0.
> > > The defined spec for PCI device does not work today for transitional
> > > device for virtualization. Only works in limited PF case.
> > > Hence this update.
> >
> > I fully understand the motivation. I just want to say
> >
> > 1) compare to the MMIO ar BAR0, this proposal doesn't provide much
> > advantages
> > 2) mediate on top of modern devices allows us to not worry about the
> > device design which is hard for legacy
>=20
> I begin to think so, too. When I proposed this it looked like just a sing=
le
> capability will be enough, without a lot of mess.  But it seems that addr=
essing
> this fully is getting more and more complex.
> The one thing we can't do in software is different header size for virtio=
 net. For
> starters, let's add a capability to address that?

Hdr bit doesn't solve it because hypervisor is not involved in any trapping=
 of feature bits, cvq or other vqs.
It is unified code for 1.x and transitional in hypervisor.

We have two options to satisfy the requirements.
(partly taken/repeated from Jason's yday email).

1. AQ (solves reset) + notification for building non transitional device th=
at support perform well and it is both backward and forward compat
Pros:
a. efficient device reset.
b. efficient notifications from OS to device
c. device vendor doesn't need to build transitional configuration space.
d. works without any mediation in hv for 1.x and non 1.x for all non-legacy=
 interfaces (vqs, config space, cvq, and future features).
e. can work with non-Linux guest VMs too

Cons:
a. More AQ commands work in sw
b. Does not work for bare metal PFs

2. Allowing MMIO BAR0 on transitional device as SHOULD requirement with lar=
ger BAR size.
Pros:
a. Can work with Linux bare-metal and Linux guest VMs as one of the wider u=
ses case
b. in-efficient device handling for notifications
c. Works without mediation like 1.d.
d. Also works without HV mediation.

Cons:
a. device reset implementation is very for the hw.
b. requires transitional device to be built.
c. Notification performance may suffer.

For Marvell and us #1 works well.
I am evaluating #2 and get back.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

