Return-Path: <virtio-dev-return-13534-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4152C001DE
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 04:16:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B596C335C1
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 04:16:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2A9D98638A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 04:16:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8FC75983E53; Tue, 15 Aug 2023 04:16:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7938D98633F;
	Tue, 15 Aug 2023 04:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjWwZzN2OFTrfk+EemkIl3yg835lP8/lwDYYiw+U3eWptEA3MNkLDQgOQT3nF27ezWEKPWjAT/8rICT7nkWNJd+yy+tOSb0NjV+FTc7zcCAdNXq40C2kMm43NVwBjH0Ef9TWJm1nzo4kVSDJGpQ9c0yhc+EutMgSQHFUQyYKGQQnJyGzmpRxwTGwfZYIts+DxDcCd9MAyc3opw5Cz+55Tcxf0CxbDUsiEBiFAGrGeHi8bd1WERAxcRcsUnfjxrpre+Ub1VifPHem0ZzjYnrDBizkE4WaevPAsnBYVIZpGjYXedwcVg0eEyN5Frc0bak6kuSsHL/76Ey9fjWhCJCHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWNQdjZilTFcGwRbAAPDuG30CZ7FZsPA+ZsitEjfx6E=;
 b=T8Yh9ktGQk1r/g7EKP3GHwCSLttP8dUljL7INPVDSjF8l9Ekdpc90NbP7QexY79Iec+IpeZhebcMj/hXeAxL9UxlA7cmAOh91nKndo7RVchyFj8sKeU9FkudptnCyB7IVXLyZP4e3xwXeP0ndeAwlr+J3PpgnerMtXlIXW4t67rhaw5S4L/6EngI9RjT7vpAVV9dKTWatSLJWyPEhkbgTPNNaLVoNhSDi0of+ahuD4X3qE76q+CkAIYp9FXhLSaoeAK0/d0YjzvSak4S0H7oIOuXDVQcUZ8UfH3z5ebaqaXdcxYCQVaCkFVcNbod/6yn4XJIiCUBjdGHDwco5KqOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: Satananda Burla <sburla@marvell.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: virtio-net ip restriction.
Thread-Index: AQHZyc+nILPxO9tD+EKehXYOD067TK/pypjQgADtyACAAA7cwA==
Date: Tue, 15 Aug 2023 04:16:29 +0000
Message-ID:
 <PH0PR12MB5481A7CCC1D6438DC6AE78C2DC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1691481880.8297818-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481425BD4582648FDD1B127DC17A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1692069010.1946628-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692069010.1946628-2-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5241:EE_
x-ms-office365-filtering-correlation-id: 865f37ad-6f57-436e-ee3a-08db9d466661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ndeshz/iBoXxcwb7MW/OKk9akMnpPvTbE5wiIU8dBhhkjHI8xcPEOidAibWdRURFMAuv9Lwx4nvbOdQG4zzSdhesXZQO1L8yuhdAQwb3CWogI3ok5kn4MntGHLDMmu8i80jT6Szu2KxkpomjJG1TBl9E6rw5jEBiivpBwihA0QMx5XLnxdwapA6U+yIe1FHGIy/OJEpT+jHJebEouDZ5OL//GDJeBg6Xmnfej7BXUXD+5in6M23Jll6F9yOry10Z5kjypkI4KQl/GpQiv9Sypcbt2AqKZA0DL9a9ITshAih9JcswQnA/UWR01K2KAf4xiwZqMSDIDjaeisCtR61sizhpwdVBAvtrlXca9xFiJeYKugFgswUPrXPbU9mzQ07Duzz1BQ4wZ0XDa9IhS422gTgg3ezB3kIYOSHwbAtV9jRN9rr53bvSjmVSjCx4B8wC9YRxKhJDLYMUWDPYYbnUc/XbhzMCTvNywl4Qb6+xHE1URH2CPto6k8uq7Fp1mq2fForsRyC7NDpxmuZEQJ8summ8Da8J0Y269xDGOrE6Td9q5ttbzdXluPjmyd5B4G5cd/5VARcosRmxOB6qAf/yfu0LUyejMrARISagfrEAX1qTPYX30/v883sL9DShX7PR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(1800799006)(186006)(451199021)(6506007)(8936002)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(8676002)(9686003)(83380400001)(71200400001)(7696005)(122000001)(478600001)(38100700002)(55016003)(54906003)(33656002)(86362001)(6916009)(4326008)(5660300002)(2906002)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zLaNP1VnaDgu1E7vBnRe3mrmM9L+yhMXzNpkJA+gPRT2CC5zpeVS693UnTCW?=
 =?us-ascii?Q?g63TCeMtmf38eVvD3V+7JWW4xDdQ6DYB54HhZW/4hQwmPIaX29DjsaNzn5kf?=
 =?us-ascii?Q?ZAMe4agysHUio0uA9izhha0Zj5up8IBcjboaUcUprWkRBsVIJNeRh3mEk5t3?=
 =?us-ascii?Q?M95GwV5yGQOxrlwXyPKPhK/RTi3eBiqexKgRbPXYT4rQZl/pdW4SQz+vawyP?=
 =?us-ascii?Q?JuvwoFrZu84m17f28ww/niuWLT5ON3lwONa7t9qTaGin+VD5ucJLcUC4h9Sy?=
 =?us-ascii?Q?a4wsbw4U/MGcZZU9ASeVdG0PRCDJ7CHxxdUJE1DFqWS3wSUgIThaQscz/Xoa?=
 =?us-ascii?Q?uP8qyd5Xq+0PdQepNdZKkyavWgnodXT1TMET9p7btZ6K1vjTWUD4w9oKM1+5?=
 =?us-ascii?Q?tYWpvOverVipq2Gr/3Gr+DLoTiVWYhLkOSMENd+R9DHZyE8mNiduP3NsMPt6?=
 =?us-ascii?Q?7OWQbQo9/I51E+4CFGtC6VeP5LvIGB4U4zgqOqwujZcjHnMvTkiK+twf1n6Y?=
 =?us-ascii?Q?D/yaLoe03X5v+Mm+X5K5dsPEl+QOSaAhuKwD+geV1xT+0s3g+OMd/FdZD+9B?=
 =?us-ascii?Q?8gnh5SERB8HAi+NKyuRIdDYTFtFGqMsOUugTB1DX4NdE5vsMQW2mLzCoOGaR?=
 =?us-ascii?Q?cdMGZFDY7mwLJfPqrzcQRJC/nwNiulr5aWJYoLt1KiZkNkvej6aUD5v/NTto?=
 =?us-ascii?Q?4WHUj16vpnKZllCUCsUlm81yn7E5us3wLQsB+MqKcBuZSWkR7r30rVNmsO96?=
 =?us-ascii?Q?vetHv5+2t1hkdMemlQ0PB8PVzHnCLCqG97pp++wizd2IKN92x5m9bGsHeaZP?=
 =?us-ascii?Q?5VKOg2aUpkmlzk5si/I3AcC3iZfe5WxtMg7lV1Y0c84uPAsATR61NQUkBuNa?=
 =?us-ascii?Q?vCUStlVIjjkGTVMNJny6LYAZUg7fmHBxnMoAGZQ0rDQW8M6JdbpTwmAC26eX?=
 =?us-ascii?Q?UEChHyGIxjD241mQruX7dBVXdhGD4WLbKSUUAvNz2rOVwTUx0bTgdLulv7zu?=
 =?us-ascii?Q?rsRINfhTKBrmfQif4DYGBVhr0d6B2A/3c5UGXYhHdvdxOBVQfTk1+CR+N17C?=
 =?us-ascii?Q?alRoZcYydv6yyPM20yFezKGIyffS4UF78RR0WteHxjIo2TWaadG7ZzCNTGcB?=
 =?us-ascii?Q?uI+sJvwYpr4e6Z7MApR+K26z6jWslkJ9qencRH9gn7G7V8f3vDA1t1Sfza+G?=
 =?us-ascii?Q?KfDJy+AZQnguMsqX1WsG8/0Nlktiq84XM9CfAwltuO5MvZRE0sMGodIS3ktK?=
 =?us-ascii?Q?ro+ShtThgItNaDdLmCEArv2cN3e2lflU3A0rAb3oAUkIRPqNltP/QwnXOSwc?=
 =?us-ascii?Q?MPVcYLf20FTWE9Llmf8cTxjsn6MEo8ESMAJW7M/yN9Uqajaeuug8jij22f0Z?=
 =?us-ascii?Q?MN40oKIxv1y7lWGsAnKowhyUn6fQWNSLmaoSqoclY3VzTN5fjMPPiRmKtkxo?=
 =?us-ascii?Q?E/EYDF+VNDk0uZBbA0ZuITWobW4BOdRNhzN2AWNw943omczoj9GfA5m0heZ/?=
 =?us-ascii?Q?JhXwI2znD+X2Z6vRwNsQDm5/3PIflK9Js4S6hWAQFyIs4MNt7/pc6fe/i8kJ?=
 =?us-ascii?Q?bq6aQ5rHdxwKfOWroPysWPNiEw+2fYs+wmr6rtl2UJOF6hZ+JU1BKo/SOMjC?=
 =?us-ascii?Q?xVRMiVGhDm7LA1YZoLP3IaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865f37ad-6f57-436e-ee3a-08db9d466661
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 04:16:29.3617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2Tr+g9ryCS0vtEBCk0ZhvV8N/EK69deIikwVJ+pHx7dtksFLI1AMpOWCG6l1Vv8IwtrwbiTJ1vUYBmYdc1WUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
Subject: [virtio-dev] RE: RE: virtio-net ip restriction.



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 15, 2023 8:40 AM
>=20
> On Mon, 14 Aug 2023 13:03:53 +0000, Parav Pandit <parav@nvidia.com> wrote=
:
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Tuesday, August 8, 2023 1:35 PM
> > >
> > > ## Background
> > >
> > > For cloud, the ip restriction is important. Because the user of the
> > > vm is untrustworthy. One user may use the ip of another to config
> > > the netdevice to receive and send packets. So we need to restrict
> > > the ip traffic of the device(or port).
> > >
> > A VM can do the same with the mac address too.
> > Why is mac ignored?
>=20
> On the cloud, the mac is not important, the DPU forwards the packets by t=
he ip.
> But you are right, we can introduce the support for mac.
>
For one cloud may be mac is not important.
For others it is.
So one can start with flow filter rules with ip only definition, this is ok=
.
=20
> >
> > > ## Implement
> > > Now we have these choice:
> > >
> > > 1. introduce the switch(as the part of pf or as a separate device und=
er all PF
> > >    and VFs ), the switch support rx/tx filter 2. the virtio-net
> > > device support the ip restriction
> > >
> > #1 is the right approach, it is not either or.
> > Virtio switch object can be part of the virtio-net device or it can be =
indepdent
> device in itself.
> > So the definition we do should be generic enough so that it can be done=
 as
> part of indepdent device in future without replicating all.
> >
> > The concept of switch port etc is needed.
>=20
> For the switch part, I am ok.
>=20
> But I would to know can we have two?
>=20
I didn't follow the question.

>=20
>=20
> >
> > >
> > > Parav wrote:
> > > > I understood that you for some reason do not need restrictions for =
the PF.
> > > > I do not know why you don't need it. :) Most cloud setups that I
> > > > came across so far, needs it, but ok...
> > >
> > > PF is used by the administrator, so the ip restriction for the PF is =
not
> important.
> > > But we can have this feature.
> > >
> > In some cloud a PF is also owned by the tenant.
> > Hence its administration to be done outside of the PF.
> > Therefore the virtio switch object definition to be built for long term=
 and
> apply to a narrow case for now as PF->VF.
>=20
> YES.
>=20
> But I think that the #2 is ok.
>=20
> Your plan of the switching PF is the universal design to implement the ip
> restriction.
>=20
> But the ip restriction is the common requirement in virtio case.
> We can support it in a virtio specific way.
>
There is no two design.
Let me try again.
There is just one design as virtio switch object.
A virtio switch object can be part of the some existing virtio device.
Or in future it can part of the independent virtio device with its unique d=
evice type.

All the plumbing we do to needs to wrap around this virtio switch object so=
 that it is usable for years to come.

There is no point in adding some adhoc ip filter rules for short term.
=20
> >
> >
> > > > The design for the switch object needs to cover the PF as well,
> > > > even though it
> > > may not be done initially.
> > > > (hint: an abstraction of switch port to be done, instead of doing
> > > > things directly
> > > on the group member id).
> > > >
> > > > We are seeing use cases reducing of having switch located on the
> > > > PF for its
> > > VFs.
> > >
> > > So for you, we should introduce a switching PF?
> > >
> > Yes.
>=20
> You said that the use cases for switching PF are dwindling. But you prefe=
r to
> implement ip restriction with switching PF. Am I right?
>
We should implement ip restriction rules using a virtio switch object.
This object can be part of an existing virtio-net device or it can be part =
of virtio switch object.
The definition to be done in a way that covers both.
There is no adhoc short cut and duplication.
=20
> We know that the switch under all(PF, VF) is more complex.
> So we all not plan to implement it.
>=20
> Then how about we do not implement the switching PF for now.
> We support ip restriction by the #2.
>
#2 is just "ip restriction without switch object", does not make much sense=
, as its very short term view.
=20
> Then we can have an independent switch under all in the future.
>
That is fine, the virtio switch object definition to be there, so that one =
can put it in an independent virtio switch device type.
=20
> >
> > > > So please reconsider.
> > > > I remember you mentioned in past in other thread, that mac etc is
> > > > controlled
> > > from the infrastructure side.
> > >
> > > YES.
> > >
> > Hence the administrative PF doing switching and VF configuration is des=
ired.
>=20
> I do not got fully.
>=20
A new virtio switch device that covers PF and VFs.

> >
> > > > So, I repeatedly ask if you _really_ need to have the switch
> > > > object as part of
> > > the owner PF or not.
> > >
> > > For me, that are all ok.
> > > Could you explain the difference between these?
> > > So I would to know which one is better and which one is simper?
> > >
> > > > Which sort of contradicts with locating the administrative switch
> > > > on the
> > > owner PF.
> > >
> > > Why?
> > >
> > > For us, all is on the DPU.
> > >
> > If all is on the DPU, can the ip restriction be applied on the DPU for =
the VFs
> (where there may not be any virtio net device).
> > If so, why do we need to introduce things now?
>=20
> In the past, we provided virtual machines. All virtual machines belong to
> different tenants. DPU has ip restriction function by default(without vir=
tio).
> But more and more complex forms of services began to appear, they work on
> the HOST. But they create virtual machines or Dockers to provide to their
> tenants.
> For performance, each virtual machine or Docker uses a separate NIC provi=
ded
> by the DPU. So they need to configure IP restrictions for these NICs.
>
Hence it should be defined a virtio switch object, that can be used as part=
 of existing virtio device or new device to cover both the use cases.

 > So the form of the cloud is changing, more and more configurations are n=
eed by
> the users from the host.

For may use cases this comes at heavy cost on the compute side where VMs ar=
e running.
But sure, this may be a valid case where its ok to pay it.

Please do not take short cut of some adding random rules via new CVQ comman=
ds for the ip restriction.
We need to define a virtio switch object, that has notion of switch ports, =
ingress,egress direction, re-use the flow filters infrastructure.

Also ip link vf spoof and other ip commands are already deprecated in Linux=
 kernel long ago.
So do not think in that direction.

An established model will be through the switch representors like Satananda=
 also explained.

I believe you are not thinking of ip link vf spoof anyway, because it does =
not allow ip level restrictions.
But making sure that we don't do in ip link direction because there was som=
e question on "how you do spoof check".


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

