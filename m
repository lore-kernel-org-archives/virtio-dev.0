Return-Path: <virtio-dev-return-12893-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E695DC7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:16:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 423336A78C
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:16:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A083986699
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:16:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E84F986655; Thu,  8 Jun 2023 15:16:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A1E998666B;
	Thu,  8 Jun 2023 15:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZf0Gv1szf0/AiMghuZQoppIf3QpM4jr2EOgnAMhrpnsEkL0qAam/w5bG3fAo/OORkjlclibe9m8xINI8ZFwIWdZzUCwM5CH9GENx2223sFne4ReQXXjqIXGJRMeo4BDHixBn9Qgpq97VvCPxkWruymPj7wu6yQUKCtLO1DiMjkA0UePiia/GG91s8IdaJg1X1gRsrpu5mTDCRpq0Fy0KQ+v8zYazIuCBlPHiqZ1UNAYuM+dTeucA0d4C6qiQti8GOkbalWuRMAK+dAQWalNKrfhFSeDJXp4kJ6r6Eab+WepNJMZPQn6SyLC4v7J3vzkg5uQ9MJdMWOTgEXJMLQWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFgU47TxJ3h+XQ5/Uu6lFjNz6bDqvYgiX4K9NgHJoZQ=;
 b=B6hOxwkQi/4ShEB4b38gEaEmHZrLUlWQ8UcWzHthsUm6Q/yIa505NDHsN3Nuvy4kVNI4yatN6urOe7QhyLgPpCfTr6tVNiiScGygfZ4Gqc5KNSu8SrneefIU1WqdiBOcR8TI2Rb6tyLMlSPfoptZasdLIUrWhI7UgueA9vAg9WvqJOgdZWItuXTdcaY4pUB9j6BSZWVY8vqz/KZ6eLl0xIeGr/xNNCqlN5AFHhyIEVbXzdjiIyugUrS7VeFLLXGQdmFlXLzVYdQHaVUXY3VYNmqx0zqcp6dSE0Po0CizQ4EosavBcPuZ73he3r2iF+3KatPSX/K22qkQXQpSIH3Xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAAwqAgAAAcVCAAAT9gIAAAt+Q
Date: Thu, 8 Jun 2023 15:16:02 +0000
Message-ID:
 <PH0PR12MB5481E16441FE87FFF87A8650DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608105640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608105640-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4559:EE_
x-ms-office365-filtering-correlation-id: 0bf1873e-4003-484a-09f0-08db683345f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kWmxmvUWrr2n5OrSDueT1hDeC64O+VXIKMXNsTkqldVhDJUGBWrhzcTYK1hRr5cOgrGjVfvOfPfOj3LARgYkw4M8OMVGNwxh3iNJQXtDlENbuVxXrcnW1ehJBu3//I3HKtq0knnh/vzca2H3B7/7OVc9PkUNiE7sz1zW4ikZySrcaPhO0CNzg4HvIMb/+nNYMCDEYGsfHhFQwTyFH/DXhSJj6/E/AS0B2UyqG/MMqImsnoFZdZOHUD3/6Hxp0yDdHatmDZfkWDyzgxB+P39djjG/bFJqC9DuStGnHlqIPIAMf89Wh7mcgutI1AHuoT4IPUWnLnab6XigTBus+Nywx/x+0tOvRWRGrX83KPA56HkLV7pB1xrzbN9I8/9NmSCw8nkLmsCllRc4+cGJVsYmvrOmWE50MhtLj84aH4ze9W5TxvW99owxqB7r/4V1FiewLqJ61FjeMPZiSi0ctzffnnwV0JPTKe/mS8eGHnLuiR5kwR3QsRQrgD6SvESIfWuMFViW3udvngSlQNXb/Mp136V9Ske/mbVzPdgoofFTJN0koX4lu12NB9RmQ838ZodaNkkU5uqUjvHyixxSPE3IUWn1pzf64MSDXEoRUFn6aDnR9GjEcomI9Chw/OSlm5RK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(6506007)(66476007)(64756008)(86362001)(186003)(66946007)(66556008)(9686003)(4326008)(66446008)(107886003)(38070700005)(6916009)(5660300002)(76116006)(52536014)(33656002)(8936002)(478600001)(8676002)(2906002)(38100700002)(7696005)(122000001)(54906003)(316002)(41300700001)(71200400001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t4QUjSU9EEiyJYntAe8n0zQz45G4QYHusWssCYXQHWXV1vPKwwvfxDpcLKbq?=
 =?us-ascii?Q?rLrbY2XX0PnSMrtzxuY7tezKw1+0zc8V0eZdSHvJBOlPKFEhg6Ep03dKN2JH?=
 =?us-ascii?Q?SZt0oGvJe/32IR32mjfS5qQ+AH+5NrldG5M7PBzmExGcAec8m0zM8wQTRgxO?=
 =?us-ascii?Q?F+cNvtxpzx2mKHtVn0kUaPtftuqknxyT4Zrza5RlpYpjognxH/5kttVJCM0N?=
 =?us-ascii?Q?btZjMHayqFyI0lxGHuzXIKDHDstmxjlmBO/hjHZPFAlaZcYpa0m/KHe/6HiB?=
 =?us-ascii?Q?s8jjzVqGHBvM1PX4dwGOdjwnJike6deqi/+O2+8qH3cK5CL+Rj0CGzbQxzrd?=
 =?us-ascii?Q?02efRagg1Cbe/rJKr4RlRlDwxD4ch+/mFM9vDD0euYmA9I4tkk4kY4JWMwsA?=
 =?us-ascii?Q?AT9DAXuEp2YsfLIxa5D27nl3SQSIWk91NduTnJ4x1U8tMmAc4ry1EjCZFNOw?=
 =?us-ascii?Q?8KQbu27ypbLMRqpDRbLXA4vjxfCXmnSELBUWZt7h5g5dMBq7QLLe1vDfNSpO?=
 =?us-ascii?Q?fQMK29zRoEoHVk1NBYUDpBN3dWzEjgynAhJDZz4xdcakCaJ1+/o7tMJ95pa0?=
 =?us-ascii?Q?upCYB6H1IUs7funerKJdAnfdX8sXOnNw8PXL9/OtCzQL+H6AtFD9MsDmQkA6?=
 =?us-ascii?Q?ZdvQbbXoOD6fb/hmEAooNGKC1oGzTkq7c9rz1rkjxTNBRMZiB7ml6nw/vzIq?=
 =?us-ascii?Q?O/K30Vyj5Tuvt6x9W9HwkBXy8KmteNRl0DdIp1pDsLEyTsrOZ68J9M5zuXkJ?=
 =?us-ascii?Q?SGAsC7cGE+D6BgLoPgkOEw+TwBiurQCJW8MT8h240UZfGJqMWGkls0AvL7Wz?=
 =?us-ascii?Q?rg7vhBCo1WCb/+69g5nPqSyXKuIaUPWyVGneUR6h8phphhJwwf+bd3QNyYNF?=
 =?us-ascii?Q?2sx5EJUgefQZLN246bF57vJtyXSoYBWod1Hp14IJjGlIKDO0SMJT4AxOhiug?=
 =?us-ascii?Q?fbN/FEGkC+Lvf36fA+AYSrpXA+2P7AwBxCFSams1kZtyosIAsRjBWIM2SamD?=
 =?us-ascii?Q?6IMPSCFuEi/AxTqP7DdgHT5187/Q7q0A/W0wGLdvpqZl3KfvJFdPHu9xiNl7?=
 =?us-ascii?Q?oYufgOhuQaRd+0QiScMdwA6KclrxQ8tbzeMXUM5x3Rott+PpzMjRmdd7/sp+?=
 =?us-ascii?Q?d4K+wM+be3aXC6Rft1Vub0W430ae888iyp9vwNPiTaPvWhXxjgiLAsXlo2iY?=
 =?us-ascii?Q?kf9RJZWFtxbHU8w70Fx6RbopgdsmfcKdS5y98khS5xyJL9A/s8dqTNJk7mYH?=
 =?us-ascii?Q?CVi8Au4nqPJ574HFL+lQ92Op2TgjDNYnYBdwsGyyv74lYSmcS3yydJE/ZvIy?=
 =?us-ascii?Q?UKP/w5FwsM2IG04CDOI8BS5QjEWSk9ti+THbWBqLR8Zw+OrJBAE3Y1ZkrTpo?=
 =?us-ascii?Q?SQMTb/UPNvhPqrH+AHkgOf1eHhwt8RGwBMZK4iK9vzRAs3IaIVT4RjSPLOeY?=
 =?us-ascii?Q?f4IeYCHmGdew05rCILq9wWhPxxPX5+ReWjVFEHH84kRTm74vGRmmGgRr5IO4?=
 =?us-ascii?Q?kAt4kQMfIsivGs0Il8CXRNk+VphtUpteO5L6PHcLB/oB8+89PM5kuN48jbd+?=
 =?us-ascii?Q?WSMRPbeGuIniVUleifs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf1873e-4003-484a-09f0-08db683345f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:16:02.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RobtLnfjEVp8Yby3EAIULV+cjf/dfVLd2Z3txU1H89CMLP/p/FCVFo6YT8DyC4adHJ9IW/lo0QhSxtbSWayzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 11:04 AM
>=20
> On Thu, Jun 08, 2023 at 02:53:28PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 8, 2023 10:44 AM
> > > > Since this ABI reflects what we agree on, I would want to raise
> > > > for vote in coming days to be part of 1.3 in few days as we have
> > > > more than 3
> > > weeks to sort out non-ABI language part.
> > >
> > > I think there's a bunch of work to tighten wording in v4, don't
> > > believe it is ready for vote yet.
> > 3rd patch has the conformance section.
> > Rest of the legacy interface semantics are just same as today.
> > We are not fixing the legacy interface itself, so not sure what to tigh=
ten
> specifically.
>=20
> I'll do a proper review after the forum. Generally lots of small things. =
Went
> looking just to give you a couple of
> examples:
> 	  too many mentions of VFs and PFs.
> 	  text should talk about owner and member. Minimise
> 	  mention of VFs to make it easier to extend to
> 	  different group types.
>=20
True but most additions are in PCI transport chapter.
But will change to member and owner.

> another example:
> 	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to
> support
>=20
> VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capability.
>=20
Yes, it is exposed by PF, the wording of "PCI VF device exposing" is not ri=
ght.
I will reword it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

