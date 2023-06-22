Return-Path: <virtio-dev-return-13037-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B48EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 12:32:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA7C32AEE1
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 12:32:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFA44986654
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 12:32:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3AFF9865D4; Thu, 22 Jun 2023 12:32:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC5FA9865D0;
	Thu, 22 Jun 2023 12:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFDi2xVSy8ok8HTa7+HUAIegdw23fpoxeLthawu/46i/ZTroBoG86plIDhwh+mv1Bt4xqm/ykgGkIZB8mq9k0SUU1c44WjjhlB3KaKgNBLX2bHN0BQbbSQ2iRZZCOwVySOEdGYJhm2AN1IN/rnWqqrGqXrA8mbEsj6ujQqQwbHc/J0Q0wvNSGOAx7LXzqLwvN5C6QhW2UDOTxHlxqbtgW7KpB7dW6GiSMCBeByXmrDOW9W3fIiKkFxCmvzyrppch8UQo/6UnDC6XElGG9PwbroOGxWhcrpAXFipO6P0SQQnSY0BjsQVNjisEnpRj1X/at2CXabhQy5CWgJePVjHjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKFYrDmGzOTIzOZ7UTzo/SEVx+OGZF79YJasawiSKGo=;
 b=bLHS66zphZasO324XQ61sA0iZIRx8Gl4OsPSx9kccFEClHXbQY8M1siTlPt7X/S3hL5bO44TiBlSHLN5pIRXLvP4RPQsb2mZJhv8LBM+thWjH94NsjZEv1zVKHQlbwDJSJK338Ne53SufTXB4ttvjczsA6EVU+W4kT3f0nUiTqCzM6nk0TZf2Ca/s37fSo6n7zL3Yfvd1Qb580MNUvkWl7pImvEOMPtY3Nh5DTs7yemHnTw94HalKis1nzw7WtRHngZhjHEGUK8iBMLDmxFYBgyv5/yYbigu7V13EBPaCNYk604Fz7fpWow1EbEsiHL1wMjvvwUWJvvE5CbXXc4YMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0Pg
Date: Thu, 22 Jun 2023 12:32:33 +0000
Message-ID:
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622021932-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5878:EE_
x-ms-office365-filtering-correlation-id: 4d6e4bf0-d69d-446c-0047-08db731cc0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HGAFykrO9ldlHgFSIa5jbmXBcgKGnaZCIOJzbpvi8TA6f9HoE8gGhCv4GvFeBQOJFodg5iMX4MMOrFmFXjJxJG+MXyA+gvNHyAzTkDjD7xtPngOoufo26UhK2kCyZIpM6h8ttaeL3acxsYRsHDD4mE0i6JYVGvf5JdAqvqx1nHRgpoXnA5dq8UA36TlYWm779UBeIf9inHTVqUZVEja5s/fHj7C0/BniYncCTyxWNLk33/+j3MYrienuI0qoKOXYSgxWtQY4X4RWD7HY/A6ZJB3h1RMDvz+6Z92iheYyzyc9cNQL70E4wPzxLvMZmjO5BZeYNstA2Uqcx1aIZht3kZdi5N2txylLAyg8pYAuEtM3t6JSOtXMhdHPUr7xnWnZB3Qjzx13SCRcpCcysaBVGwM80vWruunTku1a7a3l3XcUy5YY/IG+KSWq1F7cbr4H8LobEOXlTW+CcnH4T6rFk6c76Kl9TQCKtN6lkbYKEQ32y3wDGYV4hOjvNLgKvEM4+vm9ljkEIW+38WttE6wTBlMeEOZvLTpMuitXtyrjIoHx8TVf69/BzmI1YpWAWm6eunUz1/HGhRR3xiId2TImHyr2XhJQGfEnm3LXuOw+6pJlU2+hLBOTKAY97pjT63hj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(8936002)(2906002)(38100700002)(122000001)(38070700005)(54906003)(55016003)(6916009)(66556008)(66946007)(66476007)(66446008)(64756008)(4326008)(76116006)(86362001)(33656002)(83380400001)(316002)(8676002)(41300700001)(71200400001)(5660300002)(186003)(52536014)(6506007)(9686003)(26005)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9QAUHKJDnicLWKaZ2J5mKKFIGBStLrpGKi7uX1uat7AgWV4Vpj6U+QQPu3kK?=
 =?us-ascii?Q?rtIyY9qRd/tMNlC0becLtBf1pR3kQPniUuiEA9P7TvGvwpKsnnr+zjwl0DJk?=
 =?us-ascii?Q?6JccD/u1ShLqshJsD8FsSP2pHruxFF5xygS4IrKrcl/CEoPLdp6MmqwtD1E3?=
 =?us-ascii?Q?2wwXphRQDh9xOeHMPRJMl3yqp9yuPuvQ+GtcjV5M+S7zDMCyAkoQKofp5+oO?=
 =?us-ascii?Q?xQv7TSvdhaVfiv0nhiwre33wbNdozbxZJP3eoi4Qw2f9PFYn8mGCM2tAQC8u?=
 =?us-ascii?Q?Y2KzfM8QRefC3PFt8y/28rmogTLHAcNEy/B5fJJ6C6XUz6GlWEOAjleodw8M?=
 =?us-ascii?Q?u54zApgYhF3+gJmx7JeWpOJAmuFiwXYcpNItcsGnIjqB0F7EGc5fW/tAtyAz?=
 =?us-ascii?Q?sp9LJRoqPa3ae13GGPN3qQPc7QL/FaLXaCBVbSmXMv0I8RR2uEr7ThN3H2o0?=
 =?us-ascii?Q?UFBz4HhT1o620iJcrRJ0h8QoGl6rcUE7YhGjUEhRVw1yDaL1Z9BkOVE437Xv?=
 =?us-ascii?Q?tzemOSDecjFGRrAob75MrT9KSfv+w6tkMl8ZaiG2ou+v3D5HqY+UVVnRCGz5?=
 =?us-ascii?Q?TjRlFMlfok8gDlgspr11IkCpU1Bjarcb4ykO00fcT3zYlUdCXn4E2M9dEowZ?=
 =?us-ascii?Q?scUkpOgMRNbkK8r9T2p5Ujj2ZtU6CiylR4MPNW9gtjhVPwtzI7X1Il6pDXrn?=
 =?us-ascii?Q?X3zMakviIBd336fJJ5swAHCzsOV6vIMLZKp37e2aZZzlKW7fj456Net5/rW9?=
 =?us-ascii?Q?eS4g3mWascCq3hC3b/BaX2CF2Gbj4P4qMCjbq9w7p+qgVwUIE0/LlV3pSYj6?=
 =?us-ascii?Q?xGDdU5zn+LSRI+uyCNHJ2mGxl39e87eGzl6A8gcmzB6ZY2hNxC2hMxWoPS4m?=
 =?us-ascii?Q?6zi5BHwhMle0rDUlmHaMqLH/dG3KuiRcoUT+X4nlN/+FpRJaDbZ87yHGswK/?=
 =?us-ascii?Q?Il/CH//dDb0vANREa8EKoCOB5q4kqJIEp9WCP2yK5w/TqHsbTBZ29OIecNce?=
 =?us-ascii?Q?yplqQfBewxmqOL/aUv4HDYMsISDZCww39j9dNOb8XfroL1Tk4COffGvHY9aq?=
 =?us-ascii?Q?/4k7umMeA2XZnSbvuNaDpEePoMLV+rNB9MFY2UkH0839GHKrKHVn1YkvIz2z?=
 =?us-ascii?Q?AzzY37Es1ahQCoRvtAwEs9nlogPR68FM1K+h5WzKELk7LP1pOJBFkbkepqsj?=
 =?us-ascii?Q?1DO+Yr046fCoXERJkGLfUTbg8FoY2/HOuCQ9DAKuaN0n6vVHtgur6IYKgAfd?=
 =?us-ascii?Q?yhjoVV+McNjb9LQQvk3m8ng5O9lOJ146dvLFo2mQFng/IqAgVv2D7QvOj0xT?=
 =?us-ascii?Q?+c+qU9bJyiT9TMzxm5LaXtb0YJgLcahK8CmHi7TzQ0uB4PrLt8UKtuUWY/50?=
 =?us-ascii?Q?6dcWNnyvfZGyckhhTTUYwvVrA6qB/0AJDkXX45QmI9rrpR/688SBMv3kBZHW?=
 =?us-ascii?Q?wa8+wtbU490D7c1PGN2Gj7SA8PdUpihDyo2ZCEhyDuTgaiP7pzkJ4pSOc4ha?=
 =?us-ascii?Q?CnhMcb4dhY4xxbfDyNCza4CtZ1Q5qvGLg1usre18PfGxV2JDQEaqfsKtVR/U?=
 =?us-ascii?Q?2osP/QuqgQAutFQ4mrU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6e4bf0-d69d-446c-0047-08db731cc0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 12:32:33.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szpk+2qyrHFaT9ILAKSAKmruZhorDc/744JW5v3HbAlq5QWkoib/EfgUixVOnHeL09U8nhvwOl5up48RavQX2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 2:23 AM
>=20
> On Wed, Jun 21, 2023 at 08:52:04PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, June 21, 2023 4:38 PM
> >
> > > > > And the field is RO so no memory cost to exposing it in all VFs.
> > > > Two structures do not bring the asymmetry.
> > > > Accessing current and enabled fields via two different mechanism
> > > > is bringing
> > > the asymmetry.
> > >
> > > I guess it's a matter of taste, but it is clearly more consistent
> > > with other hash things, to which it's very similar.
> > >
> > This is consistent with new commands we define including notification
> coalescing whose GET is not coming config space.
>=20
> But there GET just reports the current state. Not the read only capabilit=
y. So
> there would be cost per VF to keep it in config space.
> This one is RO no cost per VF. Let's make it convenient?
>
And each VF can have different value hence requires per VF storage in the d=
evice.
=20
> > >
> > > Nah, config space is too convenient when we can live with its
> > > limitations. I don't thin kwe prefer not to keep growing it.
> > > For some things such as this one it's perfect.
> > >
> > Fields are different between different devices.
>=20
> Not sure what's the implication?
Implication is device needs to store this in always available on-chip memor=
y which is not good.

>=20
> > > For example, for migration driver might want to validate that two
> > > devices have same capability. doing it without dma is nicer.
> > >
> > A migration driver for real world scenario, will almost have to use the=
 dma for
> amount of data it needs to exchange.
>=20
> Not migration itself, provisioning.
>
Provisioning driver usually do not attach to the member device directly.
This requires device reset, followed by reaching _DRIVER stage, querying fe=
atures etc and config area.
And unbinding it and second reset by member driver. Ugh.

Provisioning driver also needs to get the state or capabilities even when m=
ember driver is already attached.
So config space is not much a gain either.
=20
> > > Another example, future admin transport will have ability to
> > > provision devices by supplying their config space.
> > > This will include this capability automatically, if instead we hide
> > > it in a command we need to do extra custom work.
> > >
> > > > So we do not prefer to keep growing the config space anymore,
> > > > hence GET is the right approach to me.
> > >
> > > Heh I know you hate config space. Let it go, stop wasting time
> > > arguing about the same thing on every turn and instead help define
> > > admin transport to solve it
> >
> > This was discussed many times, a driver to have a direct (non-intercept=
ed by
> owner device) channel to device.
> > If you mean this non-intercepted channel as admin transport, fine.
>=20
> we can do that, sure.
>=20
> > If you mean this is intercepted and it is going over admin cmd, then it=
 is of no
> use for all future interfaces.
> >
> > We discussed this in thread with you and Jason.
> > I provided concrete example with size and device provisioning math too =
and
> other example of multi-physical address VQ.
> > So transporting register by register over some admin transport is sub-o=
ptimal.
> >
>=20
> Not register by register, we can send all of config space as long as it's=
 RO. This
> field is.
>
It is RO in context of one member device, but every VF can have different v=
alue.
The device will never know if one will use new cmdvq to access or some old =
driver will use without it.
And hence, it always needs to provision it on onchip memory for backward co=
mpatibility.

Instead of decision point being RO vs RW,=20
any new fields via cmdvq and existing fields stays in cfg space, give predi=
ctable behavior to size the member devices in the system.
Once the cmdvq is available, we can get rid of GET command used in this ver=
sion for new future features.
Till that arrives, GET command is the efficient way.
=20
> --
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

