Return-Path: <virtio-dev-return-13051-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7ADEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB1E72A825
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43C379866E3
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EC61986813; Thu, 22 Jun 2023 17:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD8989865D1;
	Thu, 22 Jun 2023 17:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYseVmVl2tQLcDM14Sk3uJ0yGZ4JXBaPP035DtVZh1u09tvqtgOjFRuRgyGYRqLblmsKiGM8lIJ1QpeDJXa2S9DF3LfHqF/JPUjH5UmTPwbRoI2/MXm7w61PNfkXWTqpkARrqgwq7b9cuJnyYhY3f1XjtrKOtlc6jMZ0H5r3tRMg7aZfwl+OMmmWQ+Q4hN2NH3N+ByfHWeb1VTuv/aeaMp5S1q6qtM9q3TJoSFC6eG9EM9eO179LPvoT3eQLcqVnuZTJbcGv9zzekTRFAuC38HQZaJwLFv3iUgZgWxD9Wy+CGL8O6lVW4pEIlguNLKh108rv267IMnom7rDrvnB2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf5sYp5OYfMgZt8PS/yGfk/XvWyegN6pPUXliYUYXBc=;
 b=CQtogLjp8I5URjumLZs3epOFMpfrIP3PkFcZAyfhD8kaCQj/5E7Y10DPTOu4eAfZYT4a6xoVQMVrRvdXW5tmyIgn3Nf0ExSOcp6H9XZcal/3M2rDBmote3W3s6G5NeRdqdCHeDAU4vjdf3N3c16hZAmKi+kOZon+A5ei6Oi8rIpl5gCqby/drdHcyRm5xFiaISOt8fhCNfm8A3Rn4HVBFcKjU/6saqM+14XFaKLEE7mcfQHyUUhol9w6YQ3h3jO3aiSVRg7oZGXBhhHkIfFNLUsbWRQGUelK5nY/qFPAFBFiNp0PV2guyg6qVjmOEs8L0MOt4HGd6Jh98znJPEgKgA==
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
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABFu4CAAAII0IAABUeAgAAAscCAAAT1AIAAAI/w
Date: Thu, 22 Jun 2023 17:20:23 +0000
Message-ID:
 <PH0PR12MB5481A92301E4D27AFA43CB0DDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622124701-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131120-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622131120-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5224:EE_
x-ms-office365-filtering-correlation-id: b6e2146c-fc82-4a7b-8545-08db7344f687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +41Kl91KX77ioHnvxvrhTmNuT25o1Vqqjl/9rbQjnEQLcpno8pJxPiMUAruxuJupItSBBtZKdQhRWYYgIMjPpoQFtHQjoUdxW/x3DYNgKfahAjHyolY5dr7ivxLma4dKY8eCVbKQoiI+xX5RcwfR0U2hNW+ewmHzD5tRg4nI5S7z8hQt7oZccjG73NfgPSJVCEX/YZXidtvg6c+un0JQvxE0MuEO5LIOjFFjm/DXwl9ccga2+OyApA4lqwKcz8NI86eHtW00dxj0UexpgGQYNh3JV0IwO7O1DWhPSEpYJrHySnilywwskQFa2TBAx3gktF/5JC/pSKZbkZ7UHHdxQOE3J3wkBfggBDyD/w38581Xpns6byYadCPnwQPn1b3okFJ4+8i+CwBgrBMWBeeQ7xvi/o4hHmkjlV7v35spqu6zP+Ye+5Wmu44gpxZioAvbmG1eASSU9jBiMEorXcCUxgQaXcwVniKRblQu6pzNjOgw861oyK553nwyJE6t0qDdrNhwxDUGNYSJzwZZou3rVP/W0BO5aIJFheqh6QRA+WxMHxuHzY9jWdxGX+Ff8RRxZpt5LQQnk7mpRt5Ione1Xp+jagZ369rnKeMOUJJFfmVNBcou/cvRCC1yxtndEYe8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(38070700005)(122000001)(38100700002)(55016003)(86362001)(316002)(66446008)(64756008)(66556008)(66476007)(6916009)(8676002)(41300700001)(8936002)(66946007)(4326008)(76116006)(33656002)(83380400001)(7696005)(5660300002)(6506007)(52536014)(71200400001)(478600001)(54906003)(9686003)(26005)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a4PsH9zBlEZT5N0owv44s/3VbnVH0EOWY2coNFjYrobeGkW8BoDzZHg+qQD0?=
 =?us-ascii?Q?lCxRAZiMgi32rUEOEbs5B2ddZ9oGjzDjjd2sEL0mjxqUZjFIMGmUaVi7z7+n?=
 =?us-ascii?Q?cFdzpHFXbQy44lQO2sVJdf0qpVqXmNhX/bRo0U3MAhMLGqCT1myRPrE2c8Bb?=
 =?us-ascii?Q?7e216xYdAODgcBFDJx6TB6gw6u7Nr5p2B1Xk+HHxBRtAeOoUiS12r59MzD+7?=
 =?us-ascii?Q?6ol2J/IZ+Wwep55oSPfBRVHkJH+ycXE7/ABfrrxDuDGlt94Acczswt8w+LgI?=
 =?us-ascii?Q?4ZtfCFFqRggT6zxS9H2KHmYzXiuIIREkQyaq4AANkoe7M/f0c0Gj4cHRlmRd?=
 =?us-ascii?Q?/EgA/FIGUVgkkcdAfdQpKBglEmFrsCgswrgDljVeL05WF3Wo309+oNg/wB+7?=
 =?us-ascii?Q?Bej9q3LHulNj62TCbtTE7ZI+KkZYmYT7RUhKklZRq/G6RDFijj+RGoYDXY7k?=
 =?us-ascii?Q?t/D8WUAV+aeQIFtCm0FwyQdmqQ8CFmivy7ocxKHT0B81Djd7pPzozxyKv1z5?=
 =?us-ascii?Q?9O8z8CBr/rnMKjy6GNSLf4H9uY2nl2y7Me2Nt16F0bcbWuaAjF++n2yc9+F2?=
 =?us-ascii?Q?bPwK1j4zd7d7WwMineqRmf1MXqRNF96UkejSaqTgw2i8kpbQlqlR2yPS7St9?=
 =?us-ascii?Q?0DRRe4PRBOFyRzKUxJX9UNJU9lf2YSmQ6r/SQ5s2JZZbfDKlUsTJDyz+M7Is?=
 =?us-ascii?Q?wkPrIlTQB1EGi9n/zJJq9Ql1em7cdG3rB6wBn3+ehiGocM7zOIHjq63r7Shk?=
 =?us-ascii?Q?0wiNkkXbA9uVEexX4GDQmcro6a5En7PXNQlGL2yDvpWTJ4VRqlA6/FGB38PI?=
 =?us-ascii?Q?iFafVZF4oa5fvfnxadfQ7xQSa5vmnJx1r/iczoX+5dAdK1zNEbVCc9ooq/FY?=
 =?us-ascii?Q?rVdhvevvjZyUTijIQeD3ksq+mdmb7AnMKveE/CcWvRRUfH8nadWBWobjX+9o?=
 =?us-ascii?Q?poW/CzwGRt0Fbx434MdLS1iIIGJ5eXF2Na5clzwcHdfi2+KdL5oQxcXBcq9f?=
 =?us-ascii?Q?0r5tnE/YOztjXj3uInG+lXSIfCroF1JzJXM08ZhMIIkcBim3zRnkkQxf5fA5?=
 =?us-ascii?Q?UFtBBUxGLtRZmpJqKdz+ulBan5TSJy0fWjNSjTGr6QPSH0x7wEEYkO2ufBgu?=
 =?us-ascii?Q?1M/AuaApYqWK0QC4PEuvSl11oef9IKs9/oUoC5744to9kpETpX4XzO0BuNMY?=
 =?us-ascii?Q?AcybOo4xDKZCgpHHwwDW4e0Aez675LT8B6F6Ir5ZthWZfshrRTczaFE319U6?=
 =?us-ascii?Q?Meg/A8aO7dR+xnPuAL8M+Q0RL5wyxibUYJAxICqTmLxLWlzCeV4N5inueGR4?=
 =?us-ascii?Q?PF3TORAMiCKsP/YHlGFf8ovDNzSFfUePUku8AtLeRanYOS0vs8VzCy8wySOV?=
 =?us-ascii?Q?sWsveIpMniwX7QZZe4Yk0tRq8OPEFriuVkE7RjEq2qMCTtT4iMqLypSe1mJS?=
 =?us-ascii?Q?ZD2Y22LVd3MueY/1k3k2Ie3I1D2SqFlDIu6hRfQ8kFcFgeZnk159lCWnjUy5?=
 =?us-ascii?Q?JF7hFAUwJ78esrkK2hA0ew5bN0Zl5NGvGqVJ5KgjjVuIzPPppdipWFy0+fjw?=
 =?us-ascii?Q?QfsNp7LbhwJ0cg5Zbz4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e2146c-fc82-4a7b-8545-08db7344f687
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:20:23.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15LZ6pWS6tgp6AzXrFxyoQcx+rcWSZpY3qTASYIYyj8dHwgMK0q3sRvUL9f3QHLzlt9aoS5IPeW/uvYQ4ad2OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 1:15 PM
>=20
> On Thu, Jun 22, 2023 at 05:04:04PM +0000, Parav Pandit wrote:
> >
> >
> > > From: virtio-dev@lists.oasis-open.org
> > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > > Sent: Thursday, June 22, 2023 12:54 PM
> >
> > > > Admin command as I recall are not accessible directly by the
> > > > member driver to
> > > the member device.
> > > > So a cmdq or cfgq is needed.
> > >
> > > Possible, sure. Or we actually discussed a self group. I took it
> > > away until it had a user.
> > >
> > The problematic part of AQ is that its index is placed in the yet anoth=
er onchip
> die register that does not scale as each member device has different queu=
e
> count.
> > When admin queue was discussed, it was only for group owner, (you
> answered to Jiri).
> > Hence the scale is relatively less, so it was acceptable.
> >
> > Now having unique numbers for VFs is not good.
> > Max proposal was the last index after existing defined VQs of num_queue=
s,
> that saves the storage space on device.
>=20
> Surely, you can just have a very large index and be done with it?
>
There is count of AQ too.
For receive flow filters one may want to have multiple flowfilter_vqs as th=
e perf req is high for some vms.

And device to build non linear PCI steering on the driver notification for =
this very high q count.
It is optimal to have finite and linear q max value.

> > > > The single way for every device to query their capabilities is via
> > > > a cfgvq for all
> > > new fields without extending the existing config space.
> > > > (and optionally old fields).
> > >
> > > Or adminq with self group. I like this somewhat better because we
> > > need exactly same query from owner.
> > >
> > Yes. this is why I proposed to name is cmdvq that can carry admin comma=
nds
> or other.
> > But fine, we had to progress for group owner.
> >
> > > > > Why don't we focus on a work on a full solution? Just don't
> > > > > implement this thing in your devices meanwhile until we do.
> > > > >
> > > > Then Heng needs to wait for cfgvq to be defined to be implemented f=
irst.
> > > > Doesn't look reasonable to me.
> > >
> > > And *everything* has to wait. No, not reasonable. We somehow managed
> > > to release several spec versions and things did not ground to a halt =
without
> cfgvq.
> > > Don't see a reason to do it right now, what's special about now? I
> > > feel we should add to config space and then solve it all.
> > >
> > Things didn't ground at cost of device keep increasing their memory foo=
tprint.
> > The latest addition I remember is the queue_reset register.
> > It was bit but a purely control operation that got in there.
> >
> > > > Current GET is coherent with the new commands defined such as
> > > > notification
> > > coalescing.
> > > >
> > > > As community, we should work on defining the cfgvq, till that time
> > > > have the
> > > optimal way to get the config, i.e. using the cvq.
> > >
> > > cvq doesn't really work for capabilities though.
> >
> > For the device itself, it does which is what is being done here.
>=20
> Yes but not for migration.

For migration a admin command to query capabilities is needed.
This is present in the transport vq proposal already to be rebased on top o=
f admin cmd.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

