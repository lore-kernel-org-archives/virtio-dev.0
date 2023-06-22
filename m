Return-Path: <virtio-dev-return-13064-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32956EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 20:27:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 76820339BE
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 20:27:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61C2498660F
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 20:27:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 54D62983E47; Thu, 22 Jun 2023 20:27:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EF269865D4;
	Thu, 22 Jun 2023 20:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqfZDJz4srX4TPqXayKXvoGViZAz6r23TYGOY0L4UejervVz9rcdFpVdzMFSElvShxDSXfmCnlbeZ8BdKfYlaIllEgliymIfxcu/x5OVcGAmbdmodBocTboUGhPsb5oBKJPQbM6tZYqgQxbZbTqWj7wUsiv/qPZcn7fTrmb4sNMdjEFvdQRaotSa8dO0VXORZ4lM3V17tuN8/54KzKb2iPIsdyox3RfpHsSRInl14dv00wxwCDRLvNtVaCVyJskM7mr1cAOIC4M+INbvu+dGAPGQ98wURJ0MgC063m7Us3N7vFjQi14QlLfwDbA31kojzc3wyFA8iiC9b8z79pel6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMJ55PHB0Gq500UvrTTlX8MTBBkKbIz4ItVNhDGRWDQ=;
 b=f5cuR7yp0CL/5mMuPe7V7cm2fIokEowB8qBcjTk0rfjeJHC3PoDBJHSpCVrc/oTG5lutaTNmX1lmRuJRdvvFtj4BO8/YDnsStaUChEql1Wm5iV6YSPHA55i6sYRT92ofluyyhUhEqiO0FiU7diS0QduB0pTSsEqtcwgmp8/xfwB4ckpWv3ZdnyKxyZaL8k5SPIsG3gy5nTSkRq6UrFJya8H5tIgKNJpgrWj3Og+DhXnEMAiAFIdg2vapQRrvHebUiQLVCYUbMr1Y2otvrQvjFeKjCtB3R0J1Cf7BR17sMR/fVJCW/Nsb20pyiAyqNzlAEnOSMySmgoMOPrMafsEn9Q==
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
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v18] virtio-net: support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABRroCAAAA20IAABzoAgAACfmCAAAb+gIAAAMtggAAHJQCAAAHV4IAABGkAgAAWBSA=
Date: Thu, 22 Jun 2023 20:27:48 +0000
Message-ID:
 <PH0PR12MB5481532370A0525D0B4AB30EDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622132837-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B65F624B16200B91B0AADC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622140412-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BE907C0BBACC00389091DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622143626-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812621EAFA660735B3A8F0DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622145052-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622145052-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6921:EE_
x-ms-office365-filtering-correlation-id: 44575cf6-b82c-4093-50b2-08db735f253d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F6u2NdM/IOOY6C1HFz1kdJiYMxZGO5EsJx7hWD0/CWmpywb9iEH6IDXkx/4eEQwzy4HOEhypWeTINGPU0eK8wzWYECWnqCqRY3UGPPPPIdvRSU3Y2kLdNfv9+Wm9AtGU8zmKqpK8vIEml4R6waIncfktyMNPnQbH1naATZYj5udx3NwORZTH4QVPx5KTn5mrs0ruGmIwPZBVBSEuy/pjzZjQOeP3lCHb0SXNVht7WfVThrJGoAWTmXDYxcr8k9H+C+Re26FdrmHnfqoRxdQWKDcxcKvwLugY4CJxU4/oTd89+DS5JBano/PPxB+orqlqZ8QkAwGQkYFwU4RSpOOGlLDKmpLI8RJYtyyLS8mY2ZOghiOSfySCOYK5gAYcv8tCleRv06RLmxAjqbAsgxwiUXYGSYCg1EeFY4egJxqshvSuT3IK72olXhk9eX6xEtkEg4PmBDNKBs6jVBPnCJqWNCdhIGVEEhXxFvkSs8Id8jsjCOsSY+3F0MfTizjcJnnMOL6hO/VuuSkjMQ8AIUbPZs9e9lJ9m28PNuOYWU8hvnut1WG2qK0KYXsbKqyILNShXuhqWBTQrr3vAYL6allqe4EVVJ207RLPqPDIy4irYHoUpdp4bkp/2OcfyrNn+g+Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(66446008)(64756008)(66556008)(4326008)(66946007)(6916009)(76116006)(41300700001)(66476007)(316002)(54906003)(52536014)(8936002)(8676002)(2906002)(5660300002)(66899021)(7696005)(71200400001)(478600001)(55016003)(6506007)(122000001)(26005)(83380400001)(33656002)(186003)(9686003)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ou97lNDWoYe2DjT4g5ghErBI8SS5g6IaLmE+RCTV3W52btZHElEEG3mEBsor?=
 =?us-ascii?Q?FlmrTNTBoR5OgWM66qoMa9Cn0oOqKwFewF35f8aMu+KViFtUYHtwU4gDj2qx?=
 =?us-ascii?Q?ldHGCq6Yq36Tzpw9IKQUf303Dn4OoL4D7VHvKtnuud4eAQXkd3FYYnm9mcL7?=
 =?us-ascii?Q?TY7Ff2lp7ieouEE0eDDCDzEEpYEzKnm0HHT1q2c/D0oJ2y5SPjJjGSdTS9gR?=
 =?us-ascii?Q?H3Z86k3FT1bYi9vpod1oN5RIU6j3KzP+BYJuoiBsMZ/vrgS32ZMfyLpnEq/h?=
 =?us-ascii?Q?BaW0ILDzpCtUSOliGcES48HMZLgf23YdtnPCGw2BW8RlgoX6KQfrSp/IXYVG?=
 =?us-ascii?Q?dv2phgu/x6/yo62HUgTLZmKn03ceYKU+++kuh6a1w58gMi3AFKtwGG8sjHWZ?=
 =?us-ascii?Q?JpqMjg/FpDKLJZma71YNVl3tSqHz0fWkt5EeHj3BQQQaTLVDML38/+pGYoDJ?=
 =?us-ascii?Q?yW7lkjoYV1Rsr3M9hx9YVPyquh8SaNcuu42aGdfMhVXy526VClSjG+0kRX6Q?=
 =?us-ascii?Q?KCy4xFmIy7XJpCBmTtwMZVZp1Q5jVifURgHlj7dt59Dp4ZYb3B25TPunS8Od?=
 =?us-ascii?Q?XOJ4eJFTFN2Gc3oefTkznv+Ys6oZZdEcbCys2we2V8dbL4/UzoF4ou4tthYf?=
 =?us-ascii?Q?/fJCg9ptyfELnI/o71scxwe7IWGRSwasRp4t2NJpZ/U73zqK/H8nZcQo01oH?=
 =?us-ascii?Q?qjrTG2I/jMdAfBgBSBgx/ND5V2qDgE6lgwhBjTntXdQLYXPi75ruWS7xnjyz?=
 =?us-ascii?Q?dlDJ+W+xBRyy30362OVUjIzrDtj6rN3MbNyyLJ6c3JRRBV5UuMjturFdS/Kd?=
 =?us-ascii?Q?QuzJ0jLScAKuZT1wrAUp0wS4vioxAXsY9YKcRwgxNIiklvSn8EqwTEWxDRss?=
 =?us-ascii?Q?eZZkNy/RC5P5YrDyNRIiHtAjYlomM21HC8YZo3+XFK/ojwwNVXXX0bmTn9zB?=
 =?us-ascii?Q?g4n69/uDJkbTr+lN0e7VATLjIcwjm0cb9uEpBUPtpFL8z+FhGQ0cL6lX4pQ7?=
 =?us-ascii?Q?pMcbG83YpcaZCkmxHy/Tfb5wmuBqtcIUIcWmpqlvsphHOBw2fbNWEih0844z?=
 =?us-ascii?Q?PFntL5Fez/+62W4uT9D92hd2OwiF7LzQql6aJK9wqnJLikT/rCEFduoG2VTq?=
 =?us-ascii?Q?K7wrEe8KcjclS+kD/J7H50yrtie7hAfwP2bt+RWRuIZvdCxn4mK6HiAh7Yeb?=
 =?us-ascii?Q?j70wODu8C46px2XMTV577pU+BMKtm6mA63NMSgyEpIzhbtnG3CV0j8T791cr?=
 =?us-ascii?Q?rcoBC7LFazoO5iWNeoELjtlVfHS5PLipFNbR28q3fzuWl7ETMtbq9QhVVhHj?=
 =?us-ascii?Q?Bt1spp9lc4i5WpN/odF/ZIIE1jiFezufNkEfa/IS4FSjdwdgTYmEwlrAdW5S?=
 =?us-ascii?Q?i3V2afcnoy2S7zx5M/j5IZyb6EdnDZ7bB+BvkeyhBSXMIpVyjuZ4bapIuasT?=
 =?us-ascii?Q?ac1IymN1yv7fNSabnqqugB/PFXFrRFae0Qe9+cXsd347BlPk4rcdhdF8pnHG?=
 =?us-ascii?Q?Fnvnk3Vrod5IugpQ1Lkyhh75nfi3z4B8CkhDNliKcEGGxdQ814DgRlyxY0PX?=
 =?us-ascii?Q?n90St6PZUx8qe6IhGwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44575cf6-b82c-4093-50b2-08db735f253d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 20:27:48.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqzH3xPNCxOddbxQD7ijwX3BRvBpd11TQrxHMejDV49hmI+X6pRF3tHIJ4W14rVO58+e+tZT/046UHA2djVcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v18] virtio-net: support inner header hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 3:02 PM


> > Existing fields used by existing drivers must be in MMIO.
> > Device does not have a choice.
>=20
> They can if they like mask some less important features reducing the foot=
print.
How do to that? How would device know to not have existing fields on MMIO?

> This will be the cost/benefit analysis each vendor does separately.
>=20
> Case in point, if inner hash support is in 1.3, and linux drivers don't r=
eally use
> that at all for a year or two because it's only used by alibaba in their =
stack, and
> by the time linux starts using them it also supports the new commands, th=
en
> practically devices do not care and can just mask the feature bit in MMIO=
.
>=20
Once it lands to config space, it becomes existing fields.
More below.
>=20

> > > If they want to cut at 1.3 time, they can, but they also can cut it
> > > at 1.2 time, this means some features will not be accessible through
> > > MMIO only through the new commands.
> > >
> > New commands services new fields by newer driver.
> > Newer driver can call new command to get new and old fields both.
>=20
> yes.
>=20
> > So 1.3 and 1.4 devices cannot optimize for older drivers.
>=20
>=20
> I don't know what this means.
>=20
I guess next below question answers it.
=20
> >
> > > > Once cfgvq is present for new fields, from the day 1, device does
> > > > not need to
> > > store any newly defined fields on MMIO.
> > >
> > > Exactly.
> > >
> > > > And 10 to 20 years, it can stop for existing fields..
> > > >
> > > > The clear benefit is fields defined in 1.4 no longer needs to be
> > > > stored starting
> > > from 2023-24.
> > >
> > > And why is it a problem that someone can also build a 1.4 device with
> MMIO?
> > >
> > Why to build device using large MMIO when those fields are accessible v=
ia vq.
>=20
> If you don't want to - don't. But it's simple and handy for software.
> Not all devices are complex beasts like net.

Every single device has a VQ to my knowledge.
So VQ is already simple for communication even without cvq.

>=20
> Apropos, I am not yet sure the best way is simply adding admin vq to vfs,=
 in that
> this only works for fields not needed before DRIVER_OK.
> Ideally I think we should fix all of config space, including device and c=
ommon
> config. I have some ideas but let's not get ahead of ourselves.
>=20
> > VQ construct exists so it is already simple.
> >
> > If the spec is defined in a way, that new fields must be accessible via=
 vq, and
> optionally via MMIO, than it is ok.
> > One can choose to build via MMIO.
> > So MMIO for new fields must not be mandatory.
>=20
> For devices, yes. I am suggesting mandating it for drivers.
It must be mandatory for the driver to support VQ, only than it works.
If driver does not implement, and device only offers via VQ, it does not wo=
rk.

> Or maybe it's enough to make it a SHOULD.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

