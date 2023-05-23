Return-Path: <virtio-dev-return-12791-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168C7C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 17:14:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21FDF673A7
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 17:14:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFE1C986412
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 17:13:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DB7FF986387; Tue, 23 May 2023 17:13:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C637A9863BA;
	Tue, 23 May 2023 17:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8CE3GOxhnAbCAb5gg4XHo/2tmHMgkxIJWHgcHPFdEf+GI716m2J05A5/8I/iwUKM/Wv8MCslQbtFjc3EwlrYK6i5+zuTdD240A8mS3rFR55T1lTEx22P3DHR0QVz5omf4I5Ovge7xXL22llp+xfgZZjwdf5AuUur+5EiSNvQ0mTh3xk+EJHu4N4PfEwdTZQ0jw3z73kR0pmSFWQQ3PMZUUStvFOsrD9F32gU78A2yDCbm96K0aqRtaZgG7gMYrX7PT60cYH7GCHJlGUkgklWLXXyKsavUc4n8enKHHrLzGFg9Suj0VEbfLpojH8CzNHi+S5pBFAGjrLr4BjOQcl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2Gxaahc1hIEqG34C14IOsXTagG3DL+jkyZZRot42tI=;
 b=MBQjxODSrqs+yGXZ3LISQ0E6lANiGueW7k7dqcCt4FBf5dk3w9OKrYbOZNIsxdAeblisoBINya4IycHBYlwicDV9zWBomdo9OTeUpRMcH6kyVaVdXeGETVshyswonM+xeSqpAI5IYOiqZVvQ3jxza12MO6cM3Xh4uIwXPBDLaTdC3iiq7HNjCrD3weH2GTd3V+55s6Y7K2ejRYs76ccHtjZk4kH0k4WC0Q+Ny3GZOn0Zvvm8zDh/jT2JqsiDEt0i3U0A7+ai0DH32u6KKmKQs2bkH5Evz6D1kWL7NTwv402v5x3lx2nV/VsulWOoGkzpvA5Y2vNDl3ga2V7rhByGWg==
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
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAACz8IAB7w8AgAABbZCAABb6AIABJ5Cw
Date: Tue, 23 May 2023 17:13:54 +0000
Message-ID:
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230522170700-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6874:EE_
x-ms-office365-filtering-correlation-id: 3e86cf4d-c0b7-43c4-e8bb-08db5bb11623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iDlMFSyZ0yvH4YEYgBjHohIi6+fAYhZrCKOBNjL/ccEJls7B5g3MOWt8A+Hz+R94ECH0wQ1MXRlHhN878dshIcRWBUFDrzZje7lBVe1k5vlwRrfU8u1zX/n6Oaic7VyVwrvdy5eK8N2eVAvskGGoywJSCPEoNYSHTS/0WtTVGufGOAT0Xw9B7Yy8itXQEADsww0oh9HMnwJA9bEJoMpxS6BjYnD2vMtclOlgXgvChqnEflxzbUwO+tFQCBbLhJSBR+Lu7SmDQK+dvqM8R5ogUrYXgPOEzwt9SIhGGokKJA1yLCrd6t/yvoJe8BKVXUO2Yrwe3Te1pwVOnN6wp1zW4VGSjM1RkIqWVhV2JEIfG5OcrLOoYmOI1reubn0AFrY537qWTeRws2y/0PQyBP/pfS45Vkl6llTOTeJlLj62elXv8bWH5fP/dG/gVEJzSuW2M7ODyzDvMcyx1kr8O6cD1TZkjuJrseCC9Kp9zOanJE90TISOSi2deIb+2kHfxBC/5Dj+CUQ1fY6LVQxSSonhHT+Gpt2F//tyUbg/0p51potOo3EAfV9BlOiHuerDXJnCFfWGromhZ+9sc+V5ZouxdRdErwBDMOYG/dXSWKFohWXgKzZlpsTPnrwYW+qCcZTEgiENJ9FBwMrmoDed3BvgEkKwE0vIZ/mT8ogNoJZ5XQ+mk4C2ERuvnt4NV3/Ovb+3Pfvg8gIyXCVFpqu+C3a6fQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(55016003)(2906002)(966005)(7696005)(66899021)(38100700002)(30864003)(66946007)(8936002)(66556008)(66476007)(66446008)(76116006)(64756008)(8676002)(316002)(5660300002)(41300700001)(38070700005)(6916009)(52536014)(54906003)(478600001)(4326008)(107886003)(33656002)(83380400001)(122000001)(26005)(9686003)(6506007)(86362001)(71200400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XCw3P35OkJ2eO/nvIbM2Jxw1rT5+MzMdwnuti4OvBCF+ZtKleSqmjJ/JEoRz?=
 =?us-ascii?Q?4lY77246uZoiw8i6MQzi8Lp7ArANPdOly7bWQMR5ehdU6C3777uJhw+OECvq?=
 =?us-ascii?Q?UA1BHzvgFFDo8+Ibs1TQMihjaP/76zrWbIMrOsjrEhj+GPcO6QZqPqV2AUUC?=
 =?us-ascii?Q?3m+NN0WOXdfioRr8iUotg7GAoYdoxi4VF+MhJz4evifhhehJlHSW0CBp/PoV?=
 =?us-ascii?Q?OPz7RtBQQSF8Ey36sy/9k6gNDjrqYUOep2h8b9SXJCJVE4HjdIAEvoGv5Qnq?=
 =?us-ascii?Q?d0bfz5nTeG1DpOGiVFrNMB0VG5UakjPdYJEeQB8u15OIi27b1uDpwmSUZ63u?=
 =?us-ascii?Q?6GHKKjo8cf9RXazsKsuLqjXIXFFWq/pHT090GT2IZHhC+KRcieOVoTZ1YxF8?=
 =?us-ascii?Q?OI/B7Ex7aDkYoCL9M9V1ehT/PvMJMPdsfrzqnl5BBbcS5scYrVbGsevVJK+A?=
 =?us-ascii?Q?XJmsZ3wNoy3mRJtr4xxUg7TdWsf/LbqdenGcZ2Mlzl/7pOoJuuXdy0Go5wLU?=
 =?us-ascii?Q?c/RULVPIm75FsbkbLnqwsZYaPzxERLRqu694w/SJhJOiSHFn1hBbOOsg3h6c?=
 =?us-ascii?Q?CkDQKvJ8LOK8tSZhMEacj5ED7c23by20Ak4OCv+S6G0H5vIHdfdDzWLCg6eJ?=
 =?us-ascii?Q?b07m2vohLcSdvWjw+EFevfznhyNt0D+i+fGivg9SpP/Uae8tyI6Fg5r8/k8R?=
 =?us-ascii?Q?AxwBOsVmYnwGPaTbh776uATDL+0xXzmkUCu9q2NpgT/32hp2lZAH4uRml430?=
 =?us-ascii?Q?uT4V9e/HJTLQW8F+Taj2NA6659C2vBXkfqq7CFkuy6/CBWUlLb/AKRKcINnb?=
 =?us-ascii?Q?eMW+a/BXWzkW5KV4l0AcuwOGHMgrbD4/sT+N4Jz4juZH8SoASo+GTsgfF7aA?=
 =?us-ascii?Q?aOTC6g/Uttte0R2XCr3BRnFw5WqQBHK+ZxjrEcPIhc+jGyjy2a8CsWH/5yul?=
 =?us-ascii?Q?8fEfYlsYF3dIGOYOinNor5DLKGPe0Tzx8iqMCQTwQMfnDTBL5qJBo75vnEUN?=
 =?us-ascii?Q?3jI+Nz83hqTmWwaOZBvyNCMQwdci72dnSDm+plNCsEY4roTPaLOOMDILdRQr?=
 =?us-ascii?Q?dI2KWklQ3xhOQ3Laaybye5GeWIA6gACoLepcuUMLrKVSsVZo6njZN+77FAqp?=
 =?us-ascii?Q?Of3O7kQ5jO8Gb44kQlaMkqxpMYXSEMR/xYoGHv+6p1a8n/htWLpLx6QtPbcM?=
 =?us-ascii?Q?MDOSXddj8+TivkSJqqrPFpswJwnSOuZP9QK1EAf+yaSSA1p/P6MCW+JLOVJG?=
 =?us-ascii?Q?QxfV3ZTuRX7W+paxl+OqUDCEJop609vG4uNH0V1Mx95MRheJhKG47tOM8NBS?=
 =?us-ascii?Q?AEYnMidGf0x1PnZ4UI4YuAsZjx76JYmkwDcO5tV1CuqFyOb2bqaVoiYcF+NQ?=
 =?us-ascii?Q?1tKK9mhSL0r+nOQMtzthtuyIDe1z5CKKqc+mCIjsczo+GyAxt00ekidcAys/?=
 =?us-ascii?Q?yTmzZAj9dhq3rIRWsiXQORVu1uSyfSSqf1frw5/30kAc432Ad4mfwPNW2tNi?=
 =?us-ascii?Q?qGJwAt1vDj20N2cUz8bgTQLDfP/EbyyfQdnLjqWpzDr0LFfCo3pUs9hQxkuc?=
 =?us-ascii?Q?1Jw3IP0E1RjH3/bMf2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e86cf4d-c0b7-43c4-e8bb-08db5bb11623
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 17:13:54.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jO/XUtzCeK03yXGNjIkzFqm430uB62XVU1gp6Ykyql+7YWSUWzL+cuR8S8AIL727X4Wb2C57/bJx4zoVGTRjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 22, 2023 5:35 PM

>=20
> iokit is from my previous work experience not virtio.
> For virtio we had a lot of trouble with hacks like this on windows.
I don't know why windows driver need to talk to PF driver until now when th=
e AQ doesn't exists.
> That's an important platform.
>=20
I am not sure how important is it.
What I learnt that a decade has passed and even after that virtio drivers a=
re not part of the OS distro.

> > > If you are mapping VF BAR, this has to be done by VF driver, and
> > > please just avoid pain for everyone by exposing the necessary info
> > > through the VF itself.
> > > A capability seems perfect for this.
> > >
> > Why not the MMIO region as proposed in v0?
>=20
> Are you asking what were issues with v0? The issue with v0 was not MMIO a=
s
> such at least for me.  The issue was that it was not giving us any way to=
 work
> around bugs in the legacy interface. AQ was a fix for that.
>=20
It doesn't need to because guest is anyway going to do whatever it does.=20
The clear requirement is: to not fix legacy but to support legacy.
Fixing legacy is role of 1.x. Not the role of legacy interface itself using=
 AQ/MMIO.

And even if one desire to coalesce MMIO writes, it can still do it for mac =
address.
We discussed this.
We also discussed that kernel as old as 2.6.32 uses CVQ for mac address.

And Even device can apply mac address when it reaches the count of byte wri=
tes to 6, if wishes to.
>=20
> > Capability based read/write requires extra redirection, it is less opti=
mal than
> MMIO.
> >
> > > An alternative is not to map VF BAR at all, steal space from PF BAR i=
nstead.
> > Come an iokit will be able to access this PF BAR without binding to it?
>=20
> I don't get what you are saying here.  You have to bind a PF driver.
> Otherwise you can not send AQ command. That driver can map PF BAR into
> applications.
>=20
This is usual model that we follow. When PF driver is serving and emulating=
 it provides the shared platform for other devices for legacy functionality=
.
It is for legacy not for any other newer interface.

And for purpose of BAR mapping, such BAR in the VF can be mapped too.
You didn't answer why VF BAR is a problem and suggest PF BAR.
Such VF BAR already exists and asking for new resource creation doesn't fit=
 in your "simple" scheme suggestion either.

>=20
> > > Guest is not accessing this anyway. So I really do not see why not
> > > from software point of view. There's a hardware reason? Could you
> > > talk to hardware guys about this? You objected to AQ too then
> > > hardware guys told you it is not a big deal.
> > I didn't object to AQ on hw reason.
> > I explained AQ is not the best compared to MMIO because it is slow
> compared to MMIO by law of physics as it needs to move more bits than
> MMIO.
> > And so, the capability based tunneling too is slow to MMIO.
> > >
> > > > > So we have legacy emulation send commands to VF or to PF.  Okay.
> > > > > But let us avoid the need for VF driver to send commands to PF to
> initialize.
> > > > > Just get all information it needs from VF itself.
> > > > >
> > > > >
> > > > > Maybe it's a good idea to reuse existing notification
> > > > > capability, or maybe a new one, but let's avoid making VF driver
> > > > > depend on PF
> > > commands.
> > > > >
> > > > We agreed in v1 on Jason's suggestion to have the AQ command and
> > > > yet you and Jason hinder this in v2 with this exact repeated questi=
on.
> > > > Lets please avoid this and move forward.
> > >
> > > How was I supposed to raise this issue on v1 if it was not there?
> > > Stop arguing in circles and things will move forward.
> > v1 version clearly had AQ commands.
> >
> > Please revisit your comments.
> > v0 -> you suggested:
> >  - "why not AQ, like transport vq, it can coalesce partial mac writes".
> >
> > v1-> over AQ, you suggested:
> >  - to "drop the size"
> > - summarized to split 2 commands to 4 commands to split device and conf=
ig
> area.
> >
> > After that summary, you propose, why not self-contained in VF itself? -=
> circle
> back to v0 method.
> > (Instead of mmio, suggesting capability, but not explaining why mmio is=
 not
> fine. Which is better than cap).
> >
> > Then now you propose "have BAR in the PF which is owned by other PF
> driver", with least reasoning.
> > And it convolutes with your suggestion of PF driver access...
> >
> > So, I am bit lost on your circular proposal, or it was just a probe que=
stion...
> > Not sure.
>=20
> You did move things to AQ however not completely.  You kept notification =
in
> MMIO. If everything was in AQ we would be done as far as I am concerned
> (though Jason still does not like duplication of functionality with trans=
port vq,
> but that is a separate issue).
>=20
It is a wrong design point to ask to "move everything to AQ", because AQ ca=
nnot be the data link layer for everything.
One can ask in the, why don't I put my 1GB of data inside the AQ itself? AQ=
 should do everything...
Why not device build MB of shared memory for MMIO, queue data ... one share=
d memory should do everything.

And list like that can continue with no end.

We have seen the perf numbers with iobar and memory bar both for PCI device=
s in lab.
For the PCI transport, perf wise, memory bar for notification, second is io=
bar, 3rd is AQ.
They are order of magnitude apart for latency.
So AQ to send DB is only looks good in the PDF like how INTX looks good in =
PDF with SR-IOV but doesn't work well on perf wise.

> As notification is in VF MMIO I am trying to help you by suggesting other=
 ways
> to keep things consistent. If it's in VF I think it follows that where it=
 is has to be
> in VF as well. Not in AQ.
Huh.
If notification for VF is in VF -> hence other config registers also in VF,=
 such blanket statements does not help.

I explained in past that notifications are latency sensitive, and they are =
best served using MMIO.

Can one implement legacy registers as MMIO as proposed in v0?
Yes, comes at high cost to build such hw.
Is there a better optimal option for legacy?
Yes, i.e. use AQ which is what we wrote in cover letter of AQ.

b. Use MMIO registers pair on the VF itself for example,
legacy_register_addr =3D offset + size + operation + completion
legacy_register_data =3D register content

an example sequence is:
hv sw writes=20
legacy_register_addr =3D offset=3D0x2, size=3D0x4, operation=3Dread,
Poll for=20
legacy_register_addr =3D offset=3D0x2, size=3D0x4, operation=3Dread, cmpl=
=3D1
Read the register data from legacy_register_data.

This way a small register footprint on device. Self-contained. Works for th=
e device reset too.
Less memory footprint on the device too.

Does this solve the legacy interface problem? No. Because that is not the o=
bjective.

Is this small enough to carry in spec without disrupting the spec too much =
-> yes.
Is this lighter for sw and device to do? -> yes.
Does it work at scale of VFs? -> yes.
Does it work as_is with legacy sw? -> No.

>=20
> And look if that just serves to annoy I can just point out issues and com=
plain
> without suggestions. Was trying to be helpful here really.
>=20
Your comments and suggestions are helpful.
Some of them follow the loop that doesn't help.
Again, thanks a lot for the inputs and reviews.

The design discussion helped to produce two solutions here than what was st=
arted in v0.

> > >
> > > If we have trouble converging on the notification thing, how about
> > > we make progress without it for now?  Merge a slow version that
> > > sends kicks through aq, then work on the best way to make notificatio=
ns
> faster, separately.
> > >
> > Sure, we can differ, but the VF has the notification BAR to utilize.
> > So why not use it?
>=20
> Are you asking why is merging a smaller partial patch then adding functio=
nality
> a good idea?
>=20
I am asking a 1.x PCI device has the VF notification BAR already, why we do=
n't use it, why to build an additional one in device?

> > > VF(member) driver can't implement AQ commands at all. They are sent
> > > to
> > > PF(owner) thus by PF(owner) driver.  In virt configs, VMM can trap
> > > legacy access and talk to owner driver to send them.  It can also
> > > talk to member driver to send notifications.  You can I guess have
> > > VMM get member BAR offsets from owner and pass them to member for
> > > mapping. This raises all kind of questions of trust.
> > Only the member driver has access to the owner driver via kernel API.
>=20
> Assuming you can predict existance of specific kernel APIs on all OSes is=
 IMO a
> fool's errand.=20
A specific kernel API is not expected.
A framework is expected in OS.
And sw improvise as use case arise.

Driver to driver communication may be possible in WDM using [1].
Outside of virtio, I can imagine for PRI level functionality two drivers in=
teraction would be needed too.

[1] https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/diffe=
rent-ways-of-handling-irps-cheat-sheet#scenario-3-forward-with-a-completion=
-routine

> > Part of the VF BAR information at the PCI level is also on the PF.
> > There is no trust break here. A kernel exposes single self-contained ob=
ject to
> user space VMM.
>=20
> That is ok.  The trust break is if PF driver is in userspace. You then ar=
e trusting
> userspace to pass offsets back to kernel VF driver.
>=20
>=20
I don't see how a MMIO over PF is somehow more secure than AQ over PF regar=
dless of in user or kernel.
I don't see how this a problem is.
Even today when/if IOBAR is trapped by the user space forwarding to kernel =
can modify the offset and value without any AQ etc.

I don't even see how one OS can spawn SR-IOV VFs from the user space driver=
 in the kernel.

Look one can even take the PF from user space to yet another guest VM and a=
dd ten other complexities to put oneself to a dead end.

>=20
> > > If you can map BAR from PF that would be simplest, VMM then only
> > > pokes at PF and not VF. If not then we really should expose this
> > > info n the VF if at all possible.
> > >
> > There is clearly no need to use PF for notification when the notificati=
on
> method already exists on the VF.
>=20
> All this looks backwards with mixed up functionality.  What VF has is mod=
ern
> BAR. If you insist on reusing modern functionality for legacy when it sui=
ts you
> then maybe we should reuse it for everything, that would be extending
> transport vq to support legacy somehow.
>=20
You bring back same point that we already closed in discussion.
It is not about suiting me.
It is what is there in the spec and in device for transitional device. (not=
 specific to 1.x).
The design criteria is:=20
a. use as much as possible from 1.x and transitional device for the legacy =
support so that spec changes, device side, sw side changes are minimal.
AQ fits very well to this criteria.

b. Avoid inventing new interfaces between driver and device, specifically a=
t PCI device level for things that are often implemented in hw.
Here also AQ scores well.
MMIO two register example also works well.

And notification also works well that reuses transitional device's notifica=
tion.

3 out of 4 functionalities are done on AQ of the TVQ.
So, it is time to stop asking to replicate the AQ functionality on some new=
 TVQ.
This was discussed in depth.

>=20
> > In fact, it is yet extra steering entry for the hw to perform such mapp=
ing.
> >
> > To iterate what presented yday in [1] to Jason.
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-comment/202305/msg00298.h
> > tml
> >
> > 1. legacy register access via AQ (v1)
> > Pros:
> > a. Light weight for hypervisor and devices (mainly PCI) to implement.
> > b. Enables sw to coalesce some device specific registers, if needed.
> > Cons:
> > a. Not self-contained, requires PF's AQ which is anyway designed for su=
ch
> purpose.
> >
> > 2. Legacy registers access via new MMIO region (v0 + sane reset)
>=20
> I think I would buy this one if it was actually in BAR0 exactly legacy wi=
th no
> changes, no reset no nothing. a hack like Jason described that at least m=
akes
> legacy linux drivers work with no software glue.  That is horrible, fragi=
le but
> engineering history is full of hacks like this.
> If you need software in the middle then let's please make it robust.
>=20
Your ignorance and inclination to see only from the sw pov is not helpful h=
ere.
Feedback from the PCI device side given here to be considered too.

This approach doesn't work well for device reset at scale which is a one wa=
y signal.

Hence, I proposed the either the AQ over PF or the two-register scheme of a=
bove over MMIO VF.

Does that work for you?

>=20
> > Pros:
> > a. smaller code in slow register access than AQ b. Sw cannot coalesce
> > some device specific registers.
> > c. Self-contained in the VF
> >
> > Cons:
> > a. Relatively burdensome for the device as it requires more RW register=
s at
> scale, but it can be indirect register.
>=20
> what I keep saying
>=20
> b. a ton of legacy bugs which hypervisor can't detect or work around
>    (reset is just one issue)
>=20
>=20
> > 3. legacy registers tunneling with additional indirection via PCI
> > capability
>=20
>=20
> I don't know what's this one.

Above example of legacy_register_addr and legacy register_data on the VF.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

