Return-Path: <virtio-dev-return-13130-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7EAEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:06:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 31D251318CA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:06:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 299629865E1
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:06:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1D65D986585; Wed, 28 Jun 2023 17:06:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09DCB986587;
	Wed, 28 Jun 2023 17:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXrRNj5iimVBeWXyhC2hfG+Bgmq0Iy76Tcr3Rpx8//STaEGPewErd7DShEG62j//fQnOi6Cx3keM6/zWiw/IzCiBT3WmE5W40p4dj5Qzn0TwLyBSH34jQ1tudRDZz53dl6rNBOqJfNAKBImC+LF5XciImTdeWlbLq8sTDqGrRq7u6ozov/qVacbPGvm4LNpbm55jwAxfMh+cysSGElQQXwhglsqSTzg6J/ecY+eNz7lGM56iQoACSBYWC8kiy2ldhhgWUq8m2+D9IdSEJoVhRYuwf8nJSeEcsJiZ7G5mAR+/UH2sBrSLkpbjoZFNBPWCMWp2T0LVi1C7V3sRJXfhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3298EvMT5n7UYTUO36mwkf8d5pYaPm5SgdSXVBv+FU=;
 b=BxP0lWlXjZXgZdS0/DD/Lk7aJ6Sx7lUJAqdQg83hyyTU5bj+zSjq6DJXwOUzIgbWgvFlfifQWHLp/LCq9+NhBaVIYaM1FXXMxkAGmRLS0BCHB0UGUyZjce3PdyMZvJUKkoDt+hh6jOJXwA//I3xsrKPgAshfVxqOuXWD60ysWhUQSCVn6gPfuWIm6PucoX/YGy7PyRGCUmcKud+GUdKCMlPIuK/9M/1hncn8YV05ok45qzDJfeisa95sisMmK9XPZNmdms1+fwOJrqdCzDoabdaL8iG0wnjKt1h4g6OcJNG3fxYOFmBuJU2Cb88GwvpPZNY0kAC4fXq6a2rgMEaESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEA==
Date: Wed, 28 Jun 2023 17:06:40 +0000
Message-ID:
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628123131-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6797:EE_
x-ms-office365-filtering-correlation-id: 377edb26-34c7-4f1c-893a-08db77fa0ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tEh7oalWT+JUZS3vL+Rw4DI47SCrJIb90H0Z7xcUALxSX/61C+7y9hwOgt/Q+PFB7jtEkuaKGA270cRWc+9OaIzWeBJdGjfOcJvdWNOZaZ1e+00F2QwjinMu61YXMS3ywng72CnIrZJyqtw8O5UszZhupOAwKes49gJuMvfRyrEL5qK61vMYHllszuzyICuAkdOjx7KjqnKcapt/V+JhO8MHgTXVnwiJMy8yBUQZq+UXaCqahfLU4sOegXRy1vbNgJNOG7SZTGqgGfri41N/oYz/u2se/dExsJJRYdlD1pa4Eud2qzLF5vB/oQuJ+5Cv+FGrfwMT8/hUugdDELTmr1FqpQlhxDlB9GhC01Ve4nmwelxQ+efGIA7WazIUUIanJIIUG3lts9VnVJWefIyE7c0uOzQMIQjoSnezW/wb15woT1fF71NkcrXp4uo6sedWVeyQcwwbxURlcQ4weA/aUGqm/NbEUr+8P7ckDwxf9ogI+Y8Unnr5iAQ/puHWZHWs/jNfZZz6UtaA4+JxMi9mGYrCk444jj3vXMZpK3bi/zk/mX/2SLcFXI86BC+Ij9Cc1Amnnp1oL8oiadLsryl/aiuYKPKR8e1bMkON/L2zoYHtlF+11dOAtURUr64lGKCn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(55016003)(83380400001)(2906002)(186003)(7696005)(64756008)(6916009)(4326008)(76116006)(66946007)(316002)(54906003)(71200400001)(66476007)(66556008)(66446008)(478600001)(26005)(9686003)(5660300002)(6506007)(8936002)(41300700001)(8676002)(52536014)(122000001)(38100700002)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aGvEFafKrb/yqie0ElKMTa7FQjYqrIxnRiWfcoCU3RFCYuCs14LzA/LiW1LW?=
 =?us-ascii?Q?KY56EqLAyvzlK85qZ+8hYmYdTFhfF4T6+IbxIx3AFiRSyEvmbz3zHMll+oZy?=
 =?us-ascii?Q?x4AVSd6KdhUjtSXnC5332UK9BLbqBowDII/ZD/oJkN6s//qVcmzwJ/Pa0tuJ?=
 =?us-ascii?Q?4oOp914/+VyZPnowsr33AWX1NOwuBfv6q9Py/BgAcAnq3EGivmV1huKChrJF?=
 =?us-ascii?Q?yUoR/Sige/0Z7c662A3mOPvv2RCmqV5re8vJPs5mM+IqdVCG6+yeDYth3NDQ?=
 =?us-ascii?Q?NXu3ZfVtAVYvQ/ljbG9hgq8wzFlzZzwIsCFROsut9nvPbJHy5KS3I92dxxwS?=
 =?us-ascii?Q?5ElsWOYQpfPDRwIysbo+38ThDporJ+6lNc0JadyQFQCJTlWCrK3bxAwxGXSs?=
 =?us-ascii?Q?NNAVjjvpdbGp8J3VtK1KpYf36ASMKHrs1M941hoeN7JyIMHbUWVv++7ockuM?=
 =?us-ascii?Q?bJ6a237dVESW31GN7CMUH2gKIn2+8SWtk2HIikA65hK/bsxvwcqzD0gccM+V?=
 =?us-ascii?Q?ZOh/rFF1YL9ZzLkWyvULekZzdwKLOggJDCf1uRlNAp5+2z9VaNcLuuo1ru6U?=
 =?us-ascii?Q?1OH4L15VnP3fkFUjd6KCrKRKf/6eeiQpaIgbb80NtyPWuW+MNdV3bpipU8Pb?=
 =?us-ascii?Q?dgDwNJGmTEpCUzW/kPNm7hVj6z+HYm4+Umb5GIWKKzo9CjMNje7+e3w0+dIz?=
 =?us-ascii?Q?aoADvx7Le5lKqEYNBd0V8u9l0WHfA0/WTBjaOlFs1VVwoBJUhIM3c2dil0Bk?=
 =?us-ascii?Q?lY9tlYKfHlSH/hSPYPM96Zei+5umf0hgo8zKYEX5yQZOVYQ5jlnE0fTF2cDw?=
 =?us-ascii?Q?p7+wMuTDydNOEi6Jsxowq0eOAwZOAPSU/m0ww6ESWCRRZPNs0IFk8q66ajcM?=
 =?us-ascii?Q?4fddOhUJ7DWzc8qu0M4myuTaA8jU+w4wb95sy6oERTVb9/9MI3sGy9DxpIKW?=
 =?us-ascii?Q?1C23p0dR9nnCvmoF/2Ji9iEfNhZdeszs9t7Uczu35d5/1/nYqar88sgnh0lm?=
 =?us-ascii?Q?XXApVxGXWBiY9IxZvKHGzq04C8ioS5IqrrZkG8A3HypkawtVGw1wcCHFQBOE?=
 =?us-ascii?Q?NtubsAqyhVSjo29JKAClPg2Bxig+Vc2IeUBVPo3/4k1tbWwdKZZsDOk+e0h4?=
 =?us-ascii?Q?ABxKli07DMCIKPpxfs+DNX8oKBm5XDBHUsB7tIOkYeVKkxHLq5SXhG3/2V3p?=
 =?us-ascii?Q?GXuCUQc0h+eMlNH5EdXgDpeKatfPvJNjaIZ5c/q7VMYPXYxfiG5CJkrwjiTP?=
 =?us-ascii?Q?H7IvsIbw2ej28Rguc+liKg4SZX+U08kJAtXzAPFvz7tvm+xowzg5SCV0Ekce?=
 =?us-ascii?Q?w7K9mKkmefKXMIWvFwEmVfQAMEpDDEDcUUyYPhVMsBrTXvcueNjpRT8DvM19?=
 =?us-ascii?Q?sQ/Y6z2GdqIzmprIpl2MrLH5sUQnthI0SbmV6eJgPPRWg1tY6Oy+JCCXALrK?=
 =?us-ascii?Q?17sccisBFZsHS8QGPI4F4VK9zLv+LZwzQvZtlZMA245ahUfU7MMGan/jTk6U?=
 =?us-ascii?Q?KVU/CcMjCmOuw+KYiyMZCjWQ/KEGcq28LmSl1jcTnhzqZt1VaNOEJOKxIaCu?=
 =?us-ascii?Q?ZsV0zEnmQmMpU9o+h90=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377edb26-34c7-4f1c-893a-08db77fa0ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 17:06:40.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLNZiR4YWru6OJtiU3yKbfSer3zKEOrognwaBxB/ZKW60yPSzs5YXgAkNjju15BQLIXV0JpZyZCpgqJSnRMc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 28, 2023 12:46 PM

> Actually, my preblem is exactly if there's no one single interface that c=
an do
> everything.
>
Extended config space reading via single DMA interface is just enough.

>=20
> Two interfaces that do the same might seem redundant but there could be g=
ood
> reasons for this, in this case legacy.
>
But legacy should not force it to newer interface. More below.
=20
> See the difference?
>=20

> > I didn't propose two interfaces. Let me explain again.
> >
> > I proposed,
> > a. all new fields to go via vq (single interface) b. all existing
> > fields to stay in cfg space (single interface) c. if one wants to
> > optimize optionally existing fields can utilize (same flexibility how y=
ou asked
> for PF and VF notification).
> >
> >
> > > We already need config space with provisioning.
> > Provisioning does provision features, config space and control paramete=
rs,
> msix vectors and more.
> > Provisioning does _not_ need config space.
>=20
> I mean it needs to provision it.
>=20
No matter there is config space of dma, a device to be provisioned.

> > > In fact e.g. on Linux we want drivers to keep doing virtio_cread()
> > > and all the DMA tricks should be hidden behind the scenes. You don't
> > > like it that config space is on-chip? Build an interface for it not
> > > to be on chip. There is simply no downside to that.
> > >
> > This is the ask to build software interface between driver and device t=
o not
> demand on-chip config space more importantly _predictably_.
>=20
> Absolutely. So we would say that driver SHOULD use the DMA interface if i=
t is
> present.
>=20
I am asking for driver MUST use the DMA interface for _extended_ config spa=
ce.
Why?
For two reasons.

1. Because than device is 100% sure that it does not fulfill MMIO needs
2. Single interface to access extended config space, which is what you aske=
d for.
3. Single driver code because there is single way to get it.


> > > I came back after a small break and I still see this discussion that
> > > keeps playing out as a big distraction.
> > > In particular where are you doing to store the things that are for DM=
A?
> > > In system RAM? We don't *have* anywhere in system RAM to store this,
> > > we will need an interface to allocate system RAM and pass it to
> > > device for this idea to work. So in 1.3 where we won't have this,
> > > there is much less of an excuse to use a vq.
> > To store what?
> > CVQ is already there to do GET and SET operation.
>=20
> To store whatever value CVQ is requesting. Where is it going to come from=
?
>
It is going to come from the device memory that does not have hard requirem=
ents of MMIO accessibility.
For example slow flash memory.
=20
> Asynchronous is just harder for software.  Look at the hoops virtio net h=
as to
> jump through to do control path over cvq and weep. Compare to single line=
r
> virtio_cread.
>=20
> I happen to maintain Linux drivers too, so I care.
>=20
It is harder for first time if no such construct exists; and it is clearly =
not the case.
This patch is already adding CVQ get and set command.
Async behavior already built into the virtio spec.
Extending it for extended config space just make device more cheaper to bui=
ld.
Software cost is paid only once at device init time just like CVQ, AQ and m=
ore.

> > >
> > > Please let people just focus on fixing config space instead of
> > > temporary cvq hacks.
> >
> > The ask is to have predictable sizing for existing defined config space=
 field and
> not keep infinitely growing by two interfaces.
>=20
> I don't know what "predictable sizing" is or why does it matter.
>=20
Because when device has two ways to access config space, it always have to =
account and build the interface that, hey some driver will not use DMA.
Hence have it always in the MMIO accessible area.

> I get the value of reduced MMIO register map.
> I get that the only way to get that appears to be to pass values around u=
sing
> DMA.
>
Ok. great.
=20
> I don't think we need to throw away config space - just use DMA to access=
 it.
>=20
> And "existing defined" here seems to be at a completely random point in t=
ime.
> If someone wants to have fields in MMIO, I see no reason not to.

This demands two ways of access and that conflicts with your point of desir=
e to do single way.
I proposed single way, extended config space via DMA interface, that is rea=
lly as simple as that.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

