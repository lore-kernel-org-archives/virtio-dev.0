Return-Path: <virtio-dev-return-12850-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216FCC77B73
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:50:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6C33D1CA245
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:50:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F9A5986332
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:50:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 33D169862CE; Sun,  4 Jun 2023 14:50:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48E3E9862D0;
	Sun,  4 Jun 2023 14:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKNiqskxM1TkESjw3z2P6V/zvJRzifUQTbVBE8T6wmN17S0OTSr2kkKg4FRn4MJfEFSwzFQJwEf4z45o4AdAKZkkku4HxyGx3DN9zsqrtLctEPz0fI5ALPFecScYurraEfptURvm3PGxOF4H63j/P+SJfhvg0RU4AQeoOgXbzxPVtT14C6oTBIHPxAvWRrDx6wUYy4TKX5YKQy1obMGwOK8+bFbR1hLLftrNFtkTvNEbc4gzCx71nR7i3E2DqNlH1pH6qQtejAuGGWFmitby/cxIjH+NQ4M3Cyn2owcmhq2UADU3wOkgBzQrNDk3GJ/RZiuuvE4MguMWV4oyvMGjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7910Jt/+TlXTwhClGMbXGm3+DE9ibanl9lylld6slvc=;
 b=SWqOM25LUrRq+nInNQauK1qM6hsrd56m2RaupSOzNYwybd9Nh3UI+qA7ur67P2bP7ME5h2sJw4ZIWL8uTVrdYjcOftLPygnEEFYx2bmgNdiQqsd72Jpg/yDXMgIQMALtmabdhYgTR7no9zKgtRS3MBWrupPySGaP4MTEUm6hsh1BODSHzBOMpvjRlwbwVnSHLzIRgh30pZG36HIVR7nwo3xv2n7EnUVJP8wb7ihe1Z617GMi80s2W1Wtd0ZnbFsszbrtsfFsGPKMXGli860XFpLrQK0nekLvByUUc5yh/+fmZyDJy77gcYO8S44lJees7pkg3Om7DjIXqx1hr6s9RA==
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
Thread-Topic: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYA==
Date: Sun, 4 Jun 2023 14:48:59 +0000
Message-ID:
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604101351-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5046:EE_
x-ms-office365-filtering-correlation-id: db7e0fbd-937d-4e2e-163a-08db650ad491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yPmzHHkfwH1u2g85ByrMCnSAu7MmBKn3IFelA2nIjxMCeSfM1nLV9GoC3QAAsW/vUE/O+gHASasFv309CZD9mtJ8aEEkqWiEl4Nm8xuVB4zGxuuRT/m6P2+i6sOeoo62ZvN+exr08Z09/9WIUyBPQ3LcOLahcOlz2Z+8KLrtYF9BCEeVTd0A/YvPUterHDfA9upZAMUWfKNCLCnVYL3MZuMvNsIfc4urkfKh363LFEqra2UO10IVyEwTlqqziMzLA1FkyDITA2yuxPSauJKpMuI9RjNirlP1SdxX0tG3yjnYbUciZt7evZjVbu41lj5txO8DF/MGACuvAo6wtZ2ggPwOV+ergc0xU4ny/WK5OzKPEn6nhFb+Tgo7XpCn8zf/R5/qZExAvYQghssed2R3SGAg7uruHW6gLAjfUunJQ6kAOVMI7VGQ79Xy85eyj2Uz6uXSVio5iPEJQ+NROWeo7eNvG82WA1OnJgF/nCowx3/4jCYbanIYuSCawppJFtnolp2DIozfTYke7SEa2AW3/qImDZgA4Z8A2ybJ2ldp+jcWojXmRfUTu5Yc6upjxOk6Rbo7NbDO8JfnYRbxlJTywnzltjggNSxR1apHTCT17ouYZ959G0Y9F67zxDzXQ9sO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(9686003)(26005)(6506007)(316002)(83380400001)(4326008)(6916009)(66556008)(66946007)(66476007)(64756008)(122000001)(76116006)(66446008)(7696005)(107886003)(186003)(38070700005)(478600001)(33656002)(71200400001)(54906003)(2906002)(5660300002)(8936002)(8676002)(55016003)(86362001)(52536014)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oq5XUYdKFpxKYPSDZxQ0/03fBV0mfYcfmjzjuDgxij2SaOutpXZRW8tYAHX7?=
 =?us-ascii?Q?l7ahFRJcb1eRiV4RRhAcEs1JpE6V3MFXMjEbk2b2nbB+i/VVt8SNnpuwBjbm?=
 =?us-ascii?Q?7dx39/aXH9FOXyE9Z1TkS4+vo0hYud9gkjM15aG7cWM+5a4cH0JkRPXL/ijx?=
 =?us-ascii?Q?kT0OFJ5g9Jsv4yI3Aos8ghdr7rA5NUbifahNrU50u4zd9mpZhU4HkLuPW6md?=
 =?us-ascii?Q?nppD97M1OWOkKPny+Lw8SGPAcD3LOnU/MbEUbJB0tjU+ykOMKbag02M+WR4h?=
 =?us-ascii?Q?NMuHIYTcrwrzV7sgAMQufL7bJ13KBRKdPX6QKUBy68xgdYNwC0FAHF9UeJC+?=
 =?us-ascii?Q?gQIGHcx4K6Kf2479l8s6RJW8DFGt3PFE5phD/1odiXqMibMyXeO8VS7BNtUo?=
 =?us-ascii?Q?TQ8TPX0DBqsd2q5vpekpVZQOAySYN64OoZ7ZBtDFRfzrMSa5bxPtwMlMGGOo?=
 =?us-ascii?Q?rCIpuouzjm1xatt+wvZEVERcMkbuKHiRS+dmA4sINgRKxeecHsVVCPK6WdAT?=
 =?us-ascii?Q?X6KA3L/YgK+L8MDEdD6dAGKP4bdySFGMeFBwI/OyW1+OKTFRTKHer4XEBus2?=
 =?us-ascii?Q?fjEFkS7JyjYMT5KT5Zd0zaijtyjCCY82J504h8TmvlanhOM6sNa1wj7+26zb?=
 =?us-ascii?Q?OLXNx5+EwfcoCe7yIazoBBMPZIXCqmqRIp28zDWAiw9CyJPowCXt654DdFi8?=
 =?us-ascii?Q?bwonj5n7P+39pHSI74OB9/kUDY6krvY6lggR437rF/4mTdjm7JMl9P985p2k?=
 =?us-ascii?Q?+kWWBbN7n2ZrcGngoPaoSGA73JXEwz1nUv7aTS1v0sw/g8ER4Qg2tTNvSVfS?=
 =?us-ascii?Q?M+UHDod9VNEyMXfrtFlq3JHyu7E9DqTZlnCMsi4RLzenSpb2NxtCvBwmJsmi?=
 =?us-ascii?Q?wdPzR3hZJE/HFlG+hN5O+MbdU5NsM4iI10VdrPAnYFfx3tmc0qbfZdbl3XEv?=
 =?us-ascii?Q?epVnl8IPzBB25/Mok/YeItuvMjllpaEH1TmBiFfZlhSyTFiZOZtykjeIlOmp?=
 =?us-ascii?Q?7uzOaiLofEWzzg2umNtI+ECUa1BZtMwL/D5o53+gniywswFUESCYAWJ4rhrG?=
 =?us-ascii?Q?LdcahCEd4RL1S6uyz7sTyI3Cw0Zc1i+dXUOMIZ0xgcNtaWHjx29UroOVfqi6?=
 =?us-ascii?Q?1uIfN0T1YPdtju+j36JS+WqGJk01a9ASb+xH5qo+wkD4VgoWisfRLLTCYyx0?=
 =?us-ascii?Q?oVgpVcGC+90sV9poCimC4ptbH7RyFPdKboiDLSxZGNVhrqoujhpatlzcbXFc?=
 =?us-ascii?Q?qGRCVls9i8yloRAzqzN6ijQYNqWobyA7KKTnTuE3PbkbsiESflQ+IAOxt/UX?=
 =?us-ascii?Q?M5EiNQR80/+rvc62/VrB1ATKPQPtw6J8RhcBZ8oVbTdTIRsYIhzZ/w7uI14k?=
 =?us-ascii?Q?XK1ZkgScb3lif6ex9IWIkTY4x3wvWvf8WV+hYCJhofU4Kg4hNtlME9C49vHm?=
 =?us-ascii?Q?//hJsLUGBkFtZoKd33+6xEwzVR8IRtjlL+mNl1NV2Gnt0n3Cy+yux7pviI5B?=
 =?us-ascii?Q?+amHXtrITH3BnxRPi4PoNHlO20mVQ8sPLd2Q0NLNb7VxaEiwDmMOYUNKzvAa?=
 =?us-ascii?Q?Sso/X363AxPLH6N/V2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7e0fbd-937d-4e2e-163a-08db650ad491
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 14:48:59.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYMs9t9jYpYnZNMOa+XJ5n9LDXvbDh2Gr4ZbaxmG2PH8ILyZgn6b4Br56F3RmrHU6EC7opRtFQCniSwost58Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 10:23 AM

> > > > > E.g. the notification can include VF# + VQ#?
> > > > > At least as an option?
> > > > No. we discussed this before to have each device on its own BAR.
> > > > Hence no
> > > VF# in the doorbell.
>=20
> doorbell =3D=3D available notification? yes in fact it's not strictly nee=
ded since PF can
> use a different address for each VF.
>=20
Sorry for doorbell terminology.
Yes, available buffer notification.

>=20
> I am talking about the idea of exposing legacy VQ notifications in the PF=
 BAR. To
> me it looks nicely symmetrical, all legacy emulation goes through PF, and=
 I think
> it simplifies a bunch of driver code moving some complexity into hardware
> which is what you seem to be intent on?
>=20
Symmetrical only looks fine in emails.
In real device, it doesn't. We also discussed this before.
I will capture this in alternatives section of v4.

Each VF has its own available buffer notification in hardware like 1.x.
We do not want to duplicate (and add) such functionality on the PF BAR hard=
ware when it already exists on the VF.

> > > Will it help if I get some feedback from windows driver team on the
> > > design?
> > >
> > May be. I am not sure, given that these drivers are not inbox, they are=
 not in
> purview of the OS vendor.
>=20
> Exactly a reason we might not see new APIs?
>=20
I don't know.

> > And OS vendor improves the OS APIs in the future for new use cases.
> >
> > Even the SR-IOV model in Windows is not elaborate as Linux AFAIK.
> > So I am not sure how much value add we will have.
> > But sure, better to have their view.
> > Will you please add them to the discussion here or I should check?
>=20
> I don't think they are subscribed to the list, so I can't.
> Will talk to them.
>=20
Ok.

> > Did anyone use vdpa acceleration on Windows?
> > Do you have data points that someone wants VF acceleration on Windows
> hypervisor?
> > If you bring the use case, I would like to see there commitment to deve=
lop the
> code also and it will be great to have virtio there.
>=20
> We are talking about an interface that will be used tens of years from no=
w. If the
> interface is awkward to use on some platforms let's make it easier not hi=
de
> behind excuses of no demand to fix it as of last Friday.
It is not hiding.
The fact that virtio drivers are not inbox. I don't see an actual user by t=
he OS vendor for the decade passed.

And, I do not anticipate use of legacy for tens of years from now.

It is not even a conclusion that it is awkward to use.
You are concluding that one OS may never want to evolve their kernel APIs.
I don't see it that way.
We have seen with two hypervisors evolving their kernel APIs and both have =
large deployments.

I am not pessimistic that 3rd OS vendor will not evolve.

> Device vendors can choose not to support some platforms, that is their
> decision. As a compromise, consider device exposing this both in a PF and=
 in a
> VF and let's allow driver to use what's most convenient?
>
I also said yes, for this and you said "lets do one way".

So, when a 2nd OS vendor cannot use IPR scheme that they have, and they MUS=
T have everything through ONLY VF, to support them, a HW vendor will build =
PCI device with VF legacy access registers stay in the VF.
And spec update will be done.

We really don't see this happening. So better to build a practical spec.

And if this was important, I am still puzzled why you say "Just AQ is fine"=
 in v2 and why you wait for next 2 weeks for v3 to show up to raise the con=
cern now contradicting your ACK.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

