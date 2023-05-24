Return-Path: <virtio-dev-return-12815-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66369C7EE2E
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 19:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C46842C59
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 19:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F796986782
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 19:20:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 77D1F9864CD; Wed, 24 May 2023 19:20:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47F7B9864BF;
	Wed, 24 May 2023 19:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxDR2aDBPchrsp+bQ7DyR/lmvT1EJaYZjlB4HERi9RyBlAUFDtyOg/l8Y7nM6FGlAnjwb/qypBYekmgv6cJQ9eubxK4z/vCygBpABV/E22ZkVXF47ElFrREyciYYdQNtNCTgh26cMTNPj1DfIQfmOmfyMpeqD1H/N7O3RwLOpY1ZbQ/U4oVbYa7xPVzmjhenA0EfTY4aDKP165FHm18HkVGs2hQDsOlPOBcDm59+mzce8NC/lBie4V9sUgRo7nqWzMwTL4O1Xx5c2qBP0xo9BIJ9P/zHuAbp5MkOvjr4EZDTSQCpKoOjJyySNc5x6wdqNfyapp7ZCxirTYeYkXTCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd+8G+b1OxfX1L7+Px9SR+F/rQc4JaI7SHS2nE2Di+I=;
 b=YPQ7Tjjojg4ads0GLkOCbI3aQwE9SvAUrLWWq4lo42EU542mapk8JANaBpgua2npGsTzxhlfc9jGssWMIYqk9EjrFaFy09264e1Buvdb2EEsK3oQI73Te/1DKzhUyorZGEjyvtaKr40zxmb2qwQypzR2Pe11usEoYCAbrRlXGVGG1CJU4Jj7ibMncPBNoxesqMnq72YFAbLFRK/Ru7mJQ2GMYGdoT4vQ0H29qFgOLLMHIieKRwpa+oXdTGRBI2fT+0MfeXi4r8RkMwCToePZuM1g7NJqN5iCxf+zqxSkTy7LvyMzNCoGkgtjW0LQgukjB1uNviq80sUk9JjQ/MNUjg==
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
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index:
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAACz8IAB7w8AgAABbZCAABb6AIABJ5CwgAA8YwCAAC3WEIAA0t4AgACUwwA=
Date: Wed, 24 May 2023 19:18:56 +0000
Message-ID:
 <PH0PR12MB5481C5C2A080FC9BD6296AE5DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141718-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524054225-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524054225-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB7845:EE_
x-ms-office365-filtering-correlation-id: 13473952-9a04-442f-5671-08db5c8bb812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S9ShLStiKw1mf4CoJtF3YKeyTEl4z8ztRev9RDsRP5MtWKHwPpXBAwEBNW6/3L6org9irOKT4wtiwreKJP2pgnVqet8qg4eO2Hg9H8jzOPXftHXnGDeIFCbu59EU+q7aksuIuSjR0CwfArJ77VghgENiZtW8/pQ3UjiGPaqaNHni5fC0HtqR3JL1idsNcPyyVLNTZxGNB6uo4WppCoxIHTkVTm+MXcuFtHjvdzW5dqCePeYUO/fUUqkihnH+tHTIgzc6t8cPPk//YyDj0usDWFgcNOVmo46/vEvWmbb4uw2sd+xK9vKACVDWX3dp+Ljm5N1IGRnpRXZkxGhrwd6hCi/3CijZrE1lXOP0AKcS69FuWMadwQOocF7Zr1ftCiBy/jzJYHO6sx6Q0RijGeMeheklycv5O1HBEsK6gsWqobedTapOlsDAabJC+rkY9+gtrplKO67CDXJvGwNmimG2fHDvV8ZpueTd+9cTEyGfq+XKb8HeSYiWVUY2xt/53Mtb3H9EwYozgFZGGagvBZIsn6+uXPOe/OSAe9kjCtsLJ/TIP3g5mWsZkkDx9jxFcqC1bqhm7AVO9zvPAxfeEklleNoqZKiduhxXjZSSsXHwKHElKL69pJZqiF97yqSncVG0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(83380400001)(122000001)(33656002)(9686003)(26005)(38100700002)(6506007)(107886003)(55016003)(186003)(2906002)(478600001)(71200400001)(316002)(4326008)(6916009)(66946007)(76116006)(66476007)(66446008)(66556008)(64756008)(38070700005)(86362001)(7696005)(41300700001)(52536014)(5660300002)(8676002)(66899021)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OIt3jxt+5krRwI45kykgptQj9UX2HQsRQRY3fHFPTBRznyxU2myHjij77iXU?=
 =?us-ascii?Q?CBv4EmT8yVVgXHpzp0rBf4LJKAPh+RRLNJpq0bpGnnNpk8/kfSjxmEjBtSc8?=
 =?us-ascii?Q?CmdVHMlOVD2l9TcdqQBTddWQ/rcVqFGP14Nz6VF13P79SstM1SHEopMzHDOH?=
 =?us-ascii?Q?nCwjxiLpDWO5uPTF4eNaHAoBBVStC+zkQxIZzcIhFQMYHdqK01/FyJ7RM5HM?=
 =?us-ascii?Q?bhu5Ltly1CwDVHM/CFlP/fM3p4dvU2C+u55nL8Kq8mINz25fJtXtP6pP5Uhg?=
 =?us-ascii?Q?JkoEb0dXdaZwuGTGipohrDvYeDshukZ1fLAmD4kS6PbLZAC5ZJaGhujSjVg4?=
 =?us-ascii?Q?kxy5/MoTP2wlscCdSOEbA6UnKh/RLmtXGXFWkX+6dB9K4nFLYo2aYqUwl3ci?=
 =?us-ascii?Q?ApvzfrhfIrgDxpcHjYAfeGqy3KOfwcSE8S/8L9igIymoT+qKoOFqjYkxmTDE?=
 =?us-ascii?Q?UxcbG8FirkZ0Lz4o5cGKXtuZVYEsaB+s0VmlCXcoUZdHLQK6c2CtKKqIw+7h?=
 =?us-ascii?Q?9AJSbc4ThmfRu9d6CIx6O05fXhmYZc2jsCQ1gxAo2hzuXZqWuWo4bnx/gnWq?=
 =?us-ascii?Q?vGU4ThrOh43W8Rb0IiH4FK6oEQziXs/G3/fedZU4942hTtFBTTP/feIlPCUO?=
 =?us-ascii?Q?kD2YqJAXVGEn+Pbdclmxm/anKdlroqBi4XNwJYax9KuJ7gTgdAC/jYlc3gln?=
 =?us-ascii?Q?sTw17dMKNr9ofCP/D2xvxk8wdWCcJFDFGHDnZE8VdXdsnJ3G1xa/Yw2MaKdH?=
 =?us-ascii?Q?ZAwztAALf/JmlFw3N/snASiKd4uc7xeSs81WBC71RtglRuqN3qAzjfulTnTl?=
 =?us-ascii?Q?VYuT3Uz+mOr2Ix20VtITYJ4yGfSaPX2ORAEcDYMYX6KKKw0GTMPUjSm2rS1h?=
 =?us-ascii?Q?L+SFlFLAVU5SZMd9GlTt3ebgbfU3vCyrCNjcwWiu3EuKOcKObzoO9Xij31MG?=
 =?us-ascii?Q?HEVPj7zKnhhLVNOm8KrDiLL8M5fymmp4/qHehwkURx7NxLDs5NNTxA+ubDQM?=
 =?us-ascii?Q?GDPt7qcT0zUjXE0Hl5yzYCu/wZdHJeIpXOY88rBtUdxgCwQ3/GnMXIJEs10O?=
 =?us-ascii?Q?dvLVcICk4gCBxykFZrRHpIQuWAcP2i8fo89yKLhMBripIESX1bv/HQvZhyui?=
 =?us-ascii?Q?oq7X5nA2fc/Yx7iU5dJxI2PjnoHbXiR/Qk/I/fy6sqW5wPNBMXXMrL3rfHJY?=
 =?us-ascii?Q?ZlROvR5QgMMKRmKKxeZlzKmn1UVAPk1DsiRlp7G0j/uPgJqdY9SFKG/AFGXY?=
 =?us-ascii?Q?yTzMmxgOWpUG0joJ9OIziZ4HzyxYpg1MfepkFvooOD1W6wCdhWJeBwREaUwE?=
 =?us-ascii?Q?H/DesvKSCUJmEjltncy6PgA4zi6V27uM1kqXeaxIyXL+0jfdbO1/59mI0WYP?=
 =?us-ascii?Q?FvBuS/4NeomS1r2M0DAArbTSTNwyh1VINo+IobcTmB7J6qIaEIQN6yNhUfBa?=
 =?us-ascii?Q?5EEut6lwdSYKfbAAQygkEFuCd0KfLmrdSq5dVh3iZoejJngwnCSNKVYvpxll?=
 =?us-ascii?Q?R69JfDh6vAWWKchbjgGSX/e+rD1gpYJYzCMD+xI6Ia+hvyq7dvSjhgjRt1so?=
 =?us-ascii?Q?bW28MqmuFMej90bV5N0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13473952-9a04-442f-5671-08db5c8bb812
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 19:18:56.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xI8z2pitNjpy7SL9YpPlZ3PIPT6rLts7nScmB0Iakz9EhGln8pxwlBMbBIqngYYunAWWUo+/rS9ZNdXtO8AX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 24, 2023 6:08 AM
>=20
> On Tue, May 23, 2023 at 10:22:27PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, May 23, 2023 2:49 PM
> > > > > iokit is from my previous work experience not virtio.
> > > > > For virtio we had a lot of trouble with hacks like this on window=
s.
> > > > I don't know why windows driver need to talk to PF driver until
> > > > now when the
> > > AQ doesn't exists.
> > >
> > > What is it you want to know?
> > >
> > Why a VF driver needs to talk to a PF driver in windows without AQ?
>=20
> I don't know- it doesn't? If it did, it would be hard as we learned when =
trying to
> support pci-bridge-seat. Doable, but annoying.
If it does today, something likely is missing in that OS. Their model for s=
riov has not evolved as much as Linux from what I see.
So not to worry about it, as they may have to implement more things.

>=20
> > > > > That's an important platform.
> > > > >
> > > > I am not sure how important is it.
> > > > What I learnt that a decade has passed and even after that virtio
> > > > drivers are
> > > not part of the OS distro.
> > >
> > > Because with QEMU they are so easy to side-load. So we never bothered=
.
> > >
> > I don't understand your comment.
> > I was saying to my knowledge a Windows OS do not have a virtio drivers =
in
> their distro which you said is important.
>=20
> It's important for windows to work well with virtio. And it does because =
we
> supply an install disk with virtio drivers through QEMU

Ok. So WDM can use their IPR model or will be able to build infra as/if nee=
ded.

> > I propose:
> > Method-1:
> > 1. VF legacy registers access over AQ of PF 2. VF driver notifications
> > using MMIO of VF
> >
> > Method-2:
> > 1. legacy registers access using two MMIO registers (data and addr) 2.
> > VF driver notifications using MMIO of VF
>=20
> I think I prefer Method-1, I didn't exactly see Method-2 to judge though.
>=20
Ok. so lets step forward in v3 using 4 commands for registers access.
2 RW commands for common config.
2 RW commands for device config.

Notification on below.

>=20
> > > > I am asking a 1.x PCI device has the VF notification BAR already,
> > > > why we don't
> > > use it, why to build an additional one in device?
> > >
> > > Following this logic, a 1.x PCI device also has modern common config.
> > > All you really truly need is a flag to make it behave like legacy,
> > > from POV of device config and VQs.
> > >
> > Dual definition to same area in device is not elegant way to achieve it=
.
> > We already discussed that some area is RW, some is not. It moves locati=
on.
> >
> > And it still doesn't solve the problem of reset.
> > Hence, either doing via AQ or 2 registers method would work fine.
> >
> > It keeps legacy also isolated from mainstream.
> >
> > > So let's try to keep drivers self-contained as much as possible.
> > >
> > You said "AQ is fine" at the end of email.
> > Hard to understand your mixed suggestion in context of sending v3.
>=20
> I am saying a simple thing actually:
> - notifications are through VF
> - rest of config is through PF (AQ)
> seems like a consistent model to me.
>=20
Sounds good to me.
What about discovery the notification place for the VF?
We have two options.
1. discover them via AQ like config registers access
2. discover it via extended PCI capability

#1 is far more programable and does not need to bake in the PCI device layo=
ut.
So this way one day in future we can get rid of it more easily for those PC=
I devices who may prefer everything in the hw.

> > > if you want to re-use the normal notifications for VFs we already
> > > describe them using capabilities.
> > >
> > That capability is intermixed with 1.x register queue_notify_off.
>=20
> Hmm yes annoying I forgot about this.
>=20

> > So, I see following options.
> > a. either to create a new legacy specific extended capability, or b.
> > say queue_notify_off doesn't apply for legacy notifications because
> > this register doesn't exist for legacy c. exchange it via the AQ like a=
bove
> struct.
>=20
> a feels ok to me... maybe test the waters with express capability as well=
, it will
> come handy down the road I think.
Yes, if this is really needed for some OS, this addition will be possible i=
n future in the spec and also of the devices in CC list here.

>=20
> > > However, this creates a weird mix where there's this command that
> > > mostly follows legacy pci config layout except notifications which
> > > are there in the legacy pci config are actually somewhere else.  And
> > > this is just inconsistent and confusing, and the reason for this is
> implementation defined.
> > Depends on how you see it.
> > It is at same level of inconsistency as 1.x for a legit reason which is=
 to split
> config registers from data path register.
> >
> > It is not implementation defined. Notification over AQ cannot reach sam=
e perf
> level as MMIO.
> > I will avoid repeating it.
>=20
> yes, no need to repeat. I think what you are missing is that I am proposi=
ng this
> as an intermediate step while we work on support for notifications, or ev=
en a
> patch in the patchset.
>=20
Like said above, share your thoughts on the two options and I will modify t=
his patch or add new in v3.
>=20
> I think what he meant is that tvq project will be reworked on top of AQ. =
tvq,
> indeed, does expose a full transport on top of AQ and it seems logical to=
 try and
> add legacy guest support to that.
Yes, I also acked that for SIOV devices to have legacy support on top of ba=
se SIOV device interface.

> > > Talking about the two register thing.  We actually have this already:
> > > VIRTIO_PCI_CAP_PCI_CFG.  We could allow access to IO BAR through it.
> > >
> > To which IOBAR? The one that doesn't exist in the VF?
>=20
> exactly. bar value is currently 0-6 other values are reserved.
> we can steal e.g. 7 and say this is legacy IOBAR.
> The advantage is that we can use this IOBAR for anything at all, e.g.
> VIRTIO_PCI_CAP_DEVICE_CFG too.
>=20
> > It is weird to create VIRTIO_PCI_CAP_PCI_CFG and point to non-existing =
area.
> >
> > We can have new extended capability as,
> >
> > VIRTIO_PCI_CAP_PCI_LEGACY_REG, that has slightly better interface and i=
t
> also avoid intermix with 1.x using above two registers.
>=20
> it's not a big deal, if you prefer a new capability fine.
>=20
> > >
> > > But really since apparently you want to focus on how we solve
> > > notifications let's focus on that. I feel the main issue is poking
> > > at 1.x registers and at the same time at legacy registers.
> > No, it is not 1.x registers. Register and bar offset is shared via the =
AQ.
>=20
> That's good then. It's not always clear what you want to do, this is the =
problem
> with high level discussion as opposed to a specific patch.
>=20
> > > The spec was written with a strong assumption that it is either or, n=
ever a
> mix.
> > Transitional device supposed to support both as written in the spec.
> > No different here.
> > Now for real device.
> >
> > > Changing that will be painful.
> > > This is why I was asking about VIRTIO_NET_F_LEGACY_HEADER - legacy
> > > can live in software then and we do not need to worry about it in
> > > the spec. I got it that there's too much software here for your
> > > taste, but the problem with legacy is really that it was always ad ho=
c and
> implementation derived.
> > > So we need to keep it siloed.
> >
> > This is why I am trying to avoid putting in PCI registers of the VF,
> > but if you prefer, we can do using new VIRTIO_PCI_CAP_PCI_LEGACY_REG
> > with two registers.
>=20
> Oh. You are saying access to capability previously indicated modern and n=
ow it
> is also done for legacy? That indeed is a good point.
> Not sure what to do here. I'll ponder a bit.

The new capability in mind is:
VIRTIO_PCI_EXT_CAP_PCI_LEGACY_REG

struct virtio_pci_legacy_cfg_cap {
	struct virtio_pci_cap cap;
	le32 addr; /* register offset, width, op=3DRD/WR, status:0=3Dpending,1=3Dd=
one)
	le32 reg_data;=20
};

This will be hard to do for SIOV in future, so I prefer AQ cmd for config r=
egister access and notification discovery.
WDYT?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

