Return-Path: <virtio-dev-return-13090-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BC0EB64D7
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 13:01:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71F7116DFC1
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 13:01:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60E79986413
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 13:01:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5296A986393; Mon, 26 Jun 2023 13:01:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B460986394;
	Mon, 26 Jun 2023 13:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpzQnsnESbEgn/3ffdHavauMFgM3fO2MtpMZ94CAhH9z+b/fhISezbXYFhrAqvYv0BjNz2QJbX/DOSiaHML1qjXWIXgqUhBD15BBlLOxs6N7q4JABNRe6KG+rV40RhseBBqpNH2Z/3HGLhWRGLS+8zpyCg9HG/0dz+zNWVdO269VfWxz7Wkarq3ecgdGI5LYFfmbxxup7X5XPzz3PUw6IUHkEhwz1hu+xN2CuqMRBJQeV/ldh34elwNGLEYUbEDfdBtUwwmHutLzFmsF39Yz1M2eaufxvOzsUY5H6mqwQQNWHd+iLLJmPReX4q7X6YuiAeRXlDP2M/qUufUoHgu1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5bkoGfgygImPHp54ZUwfB6r/0gmk8JvqDCprvxZilA=;
 b=hlv4DEFDesLc2lilj0+GTizQina1xsJL5EDRqp/Ql5qK52dzS7VPJQp6MW0gbPFMAcM8a3NZGvv/cvZMrnuQOOfcNvdfT12Gdn5eRQ/OI0nSPP/4snS4m6YnK04LlOmWKbB9oOzzHU8n6Av/QGphmlW3+8kVTIX7nZWxSyA2grGeuRZaMPYcFynY4KvZ+AldpmGAv9NoUx3KxRD5IP0yJ0ZkYA217gdP5weW/FJxJoTkvHpMmRoOWa4WFB5sThbEK79tS14Y/ioIaOlXGs0jH8iJsrvAUp9Wyx0q1F34jcmBqyLC9AVqDL5zU3TrbcnMS5Z1/N8mwRI3tpz3fS2EOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"mst@redhat.com" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>
Thread-Topic: RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [RFC
 PATCH] admin-queue: bind the group member to the device
Thread-Index:
 AQHZp/aO4VG7c5VX5U2HGCV+HZ1m26+cowyAgAAHC4CAAA21gIAAA3QAgAAN8QCAAAS2AIAACv+AgAAPS4CAABdjkIAABQ6AgAAG3VA=
Date: Mon, 26 Jun 2023 13:01:27 +0000
Message-ID:
 <PH0PR12MB5481E690B550FEFA47560205DC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1ddd572b-a1d0-74eb-1e31-abb6dafdef3d@intel.com>
 <1687763309.2985258-1-xuanzhuo@linux.alibaba.com>
 <0a3cc0d7-638b-a49c-d846-8a4ba6e5501f@intel.com>
 <1687766994.5635917-1-xuanzhuo@linux.alibaba.com>
 <0d536952-bc05-460c-a116-3ec26c25b017@intel.com>
 <1687771000.8174524-1-xuanzhuo@linux.alibaba.com>
 <5809781c-1688-478e-d1db-39067fb45d80@intel.com>
 <1687776645.3360302-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54818E9B1BEE45EFC0E3E78CDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1687782753.9811661-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687782753.9811661-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: bd39cd5d-620c-493c-531e-08db76457433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZeHsNxXqIvwya2J1HajQWy69tx/arnqkINO90tkGE693QlBQg8Ic3mWifbJK/wzBeG4lfDL64nF+eMADUgbNf8pgSokx6d3n3nyd4wDOlCap3uHXcjOEKJcpVv4NGzpOMsebim/xcRKBis/MhI0zIGFt7lDiSbKj/RYl3+BMbYnBZv1WADhcmMHyiXDIMvoPkwdMlDHc8/FDfp7LBYZfIeuxtWNppGbUEO+Q+72rrVgYpzBINZqTrXWwu1pEwIM1wrLp0CMWyZZaFOhmXVqignxJVM/mAnwqks0w7voyY5OGmtEltsvfxzz78ACKcyVzfPWRu7bFmO4KuKQZIKgCJXng2WNag97DDl5x57KOl5MDTL8sMpskAy6s1mYBmQKhJv40c17bgBfCW0p++kMdX+pEigXPfC1D/8TM2hurmx1uoB6SRsiNFxCIho4D4PIXGdO0vuT44DjGG++JRMoY3smNd10MKtytYYAO4WkcA/jcNbqOVgLI79kms4cKyH5SVQEjNYrA3OFkdJgK3ALCryuAIX/K8NgfsUEkFk8Cs1ipwohzVLck3wxeNv4eLnsOFamo/Dlk7JLYzoTYZ711e8YPonZuUAuwLuU2kiByICMfmJxMSTx99DePHik0+8H2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(6506007)(5660300002)(26005)(9686003)(186003)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(2906002)(54906003)(4326008)(8676002)(52536014)(8936002)(316002)(71200400001)(7696005)(41300700001)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y3o4AMDrnYOy44Ih+Q+HK1chD3ZGFpODAE1OizSi66ncGi2QRKXKRHyxCZld?=
 =?us-ascii?Q?SBKreGEsOt7ajDWTChq/S7grW+rhkncwWGsP3a4MEcm/lEDYQ/WacnAVNJCT?=
 =?us-ascii?Q?vx+OKgbDMqHkpWRqabmH1X72R9xYIRYmZKxEB5ZHMuP0tg4oPrsRdibNHHBw?=
 =?us-ascii?Q?5zX+Oz2ZWwNWumt2nMdq1rk1N+Wk3U9AD6qeg7BsPRJY7c/jmaa1kIYkSj3z?=
 =?us-ascii?Q?EE0Plwp4E6pPvqDHGrl40OLhDDF1datuHi4CmJ67dJQYpjyJXiMX7bX1in9e?=
 =?us-ascii?Q?uK5F1ZppIKLSSqTSEcttRWrUAJsS3I/UM9tersca9iRnQLu0dw0njOek3TmB?=
 =?us-ascii?Q?UIWdbAM4CrNS4nSZDgezeoDVKKUjwayBy36L2BBBdrYjr8LQfMzAJQTyjWsq?=
 =?us-ascii?Q?QNgqfm1d0FfXeYAljfnu4n2L3skR4lKiqK9eTaSpWGT0FWFPpTUBU7KJe4vl?=
 =?us-ascii?Q?WouSaRUnHoMmB8fmYVQ9FWSg5Q9pVxqTaX7tNhCGpI1LknCZbeqQ5MqczN+R?=
 =?us-ascii?Q?EXaiTg6h0n5RUzd6czq7xXg/71ImcX5Uj9zVOrXda9SZ5G/+7eLjyWS90DH7?=
 =?us-ascii?Q?bLO7IvvATtKKCvinxDmgjwW24VPBD9UzjtukAMoUV6cmtwJxElWtIZMLGeIN?=
 =?us-ascii?Q?3AsEpsySvTehxr7HcKA6KsA7kh1wJcEZModPtHNa2E9X8w9vCYy0I27tLi73?=
 =?us-ascii?Q?SblZUtdHUX2Zj3H3i1UiWCPcSipRLkvjIkrdo7Ftw2PCiOY0QvEELPEtC+GL?=
 =?us-ascii?Q?Bma3TsweGBkcUhyWvGPJncQ0qiaPps4BysOIMe6QfDOTchrz6aNPgdsvaiCw?=
 =?us-ascii?Q?WyttsYeqEtVaVVvtrN1uVcP6KCK1IwSMqNfW5dff2wmKD29ovaOrBr+By63o?=
 =?us-ascii?Q?zJqUV/o2CUymO1dUXhMxmwDdRKvIT+zIJlZhJXBQUjMDM5i7Uo/rg13c0vOB?=
 =?us-ascii?Q?nqYVnKiMZLNTEPH211LXeEPVluTWfAo4rOABwSxXyz4iiJbLyvdIF61/qQP2?=
 =?us-ascii?Q?IQ5GpP42IHhe52hiQD2RPF4iwr5xYa8vl3oFbXmOM7RmtTy4eJCX6X9+Nmas?=
 =?us-ascii?Q?KED6jwIwsIfGH+FppoQd9p9RS4cg12Ygr9xjTEXuIydPhm9yFN7G6nwvJmJE?=
 =?us-ascii?Q?1HU89o6PJI/CJHxEX8SKuEeublDQTj/zS4vkgpIQpePqks4nPNOZOnVKISR8?=
 =?us-ascii?Q?FKsjEkvxEP51wBzItwIIu6QcyuPQtZXrf38Je6EMYCB+Z7ALd1F3Sx40Zm4D?=
 =?us-ascii?Q?5DhLQSGFGhgBzml/Wj2PRIA/VB/LkWvvBybSnzWbCeEW0xl+oEx9YG7ZUXv3?=
 =?us-ascii?Q?dSzu5avn60VfYV2aNhZHSBGO3/EXeAKYGg526TMNOgAr+joQyulsQ3cOb1dN?=
 =?us-ascii?Q?qil09p+5tEwkVO9LnYMF9YhyG01pF7PwPN6hVb9CYkA1cttmG+/CDbKuJAYf?=
 =?us-ascii?Q?PfX3XT09AOdE/afs7Q0RRh4fFlevtdlYNjk5faBHraYY5H+l/zi3zyXvJlvB?=
 =?us-ascii?Q?iYYLJ0T6fSq+vG6xA0akm9AMdsDH4zOznuPfJzUl6MSVoOo0+H9TlUf5ZRAo?=
 =?us-ascii?Q?tkXhSk9Ba8fZRS/kUPo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd39cd5d-620c-493c-531e-08db76457433
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 13:01:27.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYw5JeH7lmau3a+H4Lr/5Keq4ePb7bfsnzL4SMJMEJMpvwSO6RQLf8mMIOV6cJIy3RbXK+M315mOR0qhcsQ6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
Subject: [virtio-dev] RE: RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [RFC
 PATCH] admin-queue: bind the group member to the device



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, June 26, 2023 8:33 AM

[..]

> > The flow is for one OS (Linux) is:
> > 1. user enable SR-IOV on the PF device in a host, which creates SR-IOV =
VFs in
> the device.
> > (num_vfs and vf enable bit in the PCI capability)
> >
> > 2. VFs are created at the PCI level in the host system and also inside
> > the device
> >
> > 3. A user on the host may bind these VFs to the VF driver
> > (virtionet/blk or vfio or vp_vdpa or some other)
> >
> > Between step #2 and #3, a user may configure one or multiple attributes=
 of
> the VF.
> > This includes feature bits, config space fields, vf msix vectors and mo=
re.
> > This is to be using admin command.
> > These admin commands definition is due.
>=20
>=20
> YES
>=20
> My problem is that the nic is created by user on the management platform.=
  Or
> the device is migrated from other host.
>
Do you mean the management platform !=3D the owner PF device?

=20
> So we need to bind the device(created by user) to the vf between step #2 =
and
> #3.
>
We likely have some terminology issues.
Bind the device to the vf?

At OS level, there are
a. virtio PCI PF owner device
b. virtio PCI VF member device

c. some OS level device (such as net/blk, vfio, vdpa created by attaching #=
b to the driver)

d. An optional representor device on the DPU side (defined and managed by t=
he vendor, outside the virtio spec as device implemtion).
Is this #d you call management platform?
If so, yes, orchestration may need to consult management platform, but this=
 is optional.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

