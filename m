Return-Path: <virtio-dev-return-12863-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDC2C7EE24
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 13:27:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7333E1922E8
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 13:27:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CF6D986461
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 13:27:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 614DA9863AC; Mon,  5 Jun 2023 13:27:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C7EB9863AD;
	Mon,  5 Jun 2023 13:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExnWLPvrssYt3eMhpT+b5q6A8f0iVeykOIiJ8yBG8wODUKNDG60ZftICFjTUxzoK9/+G0+LP0nZaH+Ap0o3LmrJwkEKAptV4g+bNIJ/Lku/pHn9fF2U/zEtdvfKnn3i1EP0/OKO7bbPqJAv8cbRGQN5hD7B/xkcSuqx5LFSbuS1gZEpyevZ5b1K/ASL1tbddne2HAaNN5/ODjpuzeJgbu+UwWsOJYMDKYYcJ7tmPRs5IB4krOe6KmJtq0UeDugHlMqzBbYXsXBVU+9xb5joK1zXXwbq1qn8AK1yMIRIdM4rYW4U5ARwKHOd0eOGmEce5PTN6n3CqFsyoE7LPfJd8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZuTCj02BPRrBrCsMnEX3m4t+hDqs1rA+2BlCRRNCHM=;
 b=UUbMtphZ7KF4OUmxESKRzAYSgef54XBmHactXLzzMLwyn7ey90a8uKIffzUadsKLIbApnxNBdaOuepwOLxmqFRLwaRWo4CRIPgPUyYbMaJliotbetsFW5AbUnwdT08tGoSHCDd+5Yqn7v1rVc7ytGZHTprQMGm+I1I0V7e4yRZdro1g0uaIR6rFHP0ccaMYzQEwTFD29vpvdgbN8DF8GKl840LcgXqf4kp73uxtgYlSRdtvsTt4YsnyRTIeASj2pdKkJjVSG582R7+Jgk0LhG1BYR7pGbJzsDLTLJLk0wIjry8+aIj5sugxvmmUe41KCcneJ8iursznLRqhbxkBkww==
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
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4A==
Date: Mon, 5 Jun 2023 13:27:04 +0000
Message-ID:
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230605014539-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB7271:EE_
x-ms-office365-filtering-correlation-id: 57d38080-2967-41f3-45b5-08db65c88d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 05eaSiRNNtNsFj3Qj6i/RG1Gr7zxl4+raytW/b8GUw7bdsnUplkouQVwfEp5cXJiPHnNo0dbhq+DlIyjSCC91QS1OiYFSzAJZlbdw10p4Ac5opq7n3EEmelsADtRqdSMQTVwBFcF/I53fe3SJlsRx9SFOcQ0BgWoMmG0ThUnV6sFIsecB1mioKo1MRNjfb6TUufqfKTcMf0070Fky2UjNPgcD54WKUAcjOouurtvSdKNTTgjVtTuIr1yOgqz1X4TfVjphCzaiD4KJJDj4ZMsxJY9b39aAwB6wsoSl+2UqYMbwNZIDKk7OX/0T7RbIgZNjaQENWxHTAPfzHMNLdUsnvlPBIqKx8ZMFvTtdyjNKJMm4PgZnsbCPcfaWygqX5GheT+OopqQx3OWBSkk/nIkCTDf/3yt1mp7MHzFIfgXItJ+OXtJ33WU19tfKzFGx+Qa16J5MQEEM1NU2tIpvqPZu+X01eoSpmNVq9AFobAzbRU042/Jqrn4UFElPA0VbUwov9puWkY06Ll2ihF334LFHJby35geeab8H8z0n7qLeSHujsyGKI6kRd74HnsXLwWkvB+YvquZln9FZ+4fPHdO44/7WnA7JIh3EJyukviVc09yrvMJW8EyYs/90oW8yN5O
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(107886003)(9686003)(6506007)(38100700002)(41300700001)(7696005)(186003)(83380400001)(71200400001)(478600001)(54906003)(4326008)(66446008)(66476007)(66556008)(64756008)(122000001)(6916009)(55016003)(76116006)(316002)(66946007)(8936002)(8676002)(5660300002)(52536014)(2906002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jUW1hWLsQCS4MpyPxzsTJq5OCndSNb8diVhvc3kIu35QqU4KRcqGN6cH9Cel?=
 =?us-ascii?Q?e+2sknCQZra2swre0CjhXffjlxP4m+s+zoI8wmXdS7U2SJZWpIJcjazpSI8g?=
 =?us-ascii?Q?qc3HKwyBfhIGLMTWyT/4l+w7+TUkWrmkOdq80s38nKuqHWfVlnKBt9yepyfj?=
 =?us-ascii?Q?Zp5sdImC6bIWH9nQn+1DIWmfggtgj1sMPBR2/mmBw3OmZTyB0XlPAzdcUiuI?=
 =?us-ascii?Q?cjiZKx5tGn5e/gczSIN1dc0boaV8Bxbwlgd6NGejj1/QEjGOYU5e+CG5+JPY?=
 =?us-ascii?Q?iOvQHVSswI6Pwf+MVf04x+RpBoZbVumr41P21ES4WXF6pnh9qjfr66qtlfo5?=
 =?us-ascii?Q?GrdhnNG18chpQwvq3vONVeuAbTiMU5RBtHEBiNeW5hCnt7vnMv5wPEKrQb66?=
 =?us-ascii?Q?hbljoahFe9yr/WPnYZ6T01zx3WYOLO7Pkg9wf1lR37U/FDKJ92n49+qIu3R3?=
 =?us-ascii?Q?jO/GIheZYRROcsPTxEmrpdSzyQjpQ2nhlXPe2Z0p6SiX8aImrPYmPvwX0FBE?=
 =?us-ascii?Q?S6xPcvAe46K4i+i53f8WMYEiguELosyzFMn73RpnOvEFqWEYhPBCbkx91V1r?=
 =?us-ascii?Q?Tpiduc5jM9ac9QkD8E4DYq+F1fO/Z2XSwKTge4wV5VtITNP27duvJhwbZtAa?=
 =?us-ascii?Q?zWtF4pq7rA1qDHZu8P3mGG8XUFmzV1K36f9IpJ1VZUQaNWU49x5xQXUYrd7p?=
 =?us-ascii?Q?9ce732nLsFf/c+Bg3qs9/rykzBTZk0hcvNadzcRXOVGY4CA/TOJp7HyqC/ra?=
 =?us-ascii?Q?57eHsFBUsryta0EwYcGqZgD9mZaafYc8ODeFUA74uEJZc7bk22y88Fj87v0b?=
 =?us-ascii?Q?4PyczJM2FNU74xnGhthzcPf0kY7ZBsDduFKK8XTj1EsDh29AFkRAcj1EFxIP?=
 =?us-ascii?Q?u/IIZ3wz1vlV7sy/yXJ5xUjsube9/4krrnhnoFJl0rD4KrgVfOr0fuJ1HPDe?=
 =?us-ascii?Q?yB2wAPaybbCKDqfJgtzPNKSHg6VL0+UCvykdTllcgg/1mziJyIy6oPL3AVWI?=
 =?us-ascii?Q?xtY4k0t9LkujYjgSJPdSCWx8ebdy9IzTdFQ636qGt5ToK3hBRJQs6xfjlJkG?=
 =?us-ascii?Q?60zNW+MscrMIrNVzclTTeT54BonNAk2EJZobDg4KYLZU6N8q2sTAIe95eXom?=
 =?us-ascii?Q?LRNgDry7PK+3GSQeP84TxM6Abouuk1tV9/qSxbvexxNAj59T1KXYnpwT6r6R?=
 =?us-ascii?Q?9N4LneXSuOMEKj5IDlcTR6b/vif07a/NhdMGcr+wgBcWzwiVwN2o008h1MQv?=
 =?us-ascii?Q?GGwehSehsTXDuNECX9CczuW6ODVVnjpqkGNVscUi/gBTc29w3bHtf50vZ8m4?=
 =?us-ascii?Q?sotGWXEqNae3yUgdhV2K9eC4wvQFUMmwuSuG0mNlwc7HKz9HDurztpBcFZKM?=
 =?us-ascii?Q?P7Tl3DImiZnqaSebUEftqd7jsCiTwmcZYktYl6/56hR8VWg24A5czJlz40TS?=
 =?us-ascii?Q?BQq6sEdfmjNgxSAEfxzCO1uI1y/7MLEb2vLgdw/n56owFRbyWD3uffCBbr2V?=
 =?us-ascii?Q?uP7F+by0FuNjWYpTQRtN+eiAQL51KANMSOLDXmjEk7atsboisIu6XUBhHvXj?=
 =?us-ascii?Q?w/ikimE74NoI21tU4Ek4Zl9hrvV/X7ebRzpcYGLNJvmCRDPqDGPcUIZ7kc2e?=
 =?us-ascii?Q?zTlsL7JpikmVeKeejtLKbtQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d38080-2967-41f3-45b5-08db65c88d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 13:27:04.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBfSf7bVDP6I+WFkklOqcV9zra4X1OUyPF5qLn89Jli3XV3OUQlsQUPrCW5e8CKYbEU35W0CrQBOF3yg6WLmIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 5, 2023 1:52 AM

[..]
> > > E.g. with 1.x using VIRTIO_F_NOTIF_CONFIG_DATA - probably not.
> > >
> > Not really because legacy doesn't have that feature.
> > Legacy notifications are subset of 1.x feature.
> > This was also discussed.
>=20
> So for legacy such hardware will likely not want to use the same BAR.
>=20
I don't follow this comment in conjunction with your below comment about of=
fset 0.
If we consider offset 0, legacy will use the same notification area as 1.x,=
 right?
So I am confused on "hardware don't want to use the same "BAR".

>=20
> > > Let's just say, we are not in the position where we dictate these
> > > things to OS vendors yet.  One of motivations of the spec is making
> > > writing drivers easier so let's add an option for that pls.
> > >
> > There is no need to add multiple options at this point when the hw vend=
ors
> are not going to implement.
> > When we find another vendor to implement, we can always add the new
> method.
> > Marvell and Nvidia both are forwarding with AQ at present proposal.
> >
> > > > VF has BAR for driver notifications. This BAR is used for 1.x and l=
egacy.
> > >
> > > But it's the same piece of silicon - be it in PF or in VF.
> > > I really don't see why it matters.
> > >
> > In same piece of silicon one needs to open yet another PCI steering ent=
ry to
> tell that treat this for VF.
> > This double size programming is useless.
> >
> > Yet again we are discussing same point as before.
> >
> > > > There is no need to ask vendors to build new HW to put driver
> > > > notifications
> > > on the PF BAR for VFs, when it already exists on the VF.
> > > I'm talking about giving vendors an option not asking them.
> > >
> > Ok. Understood.
> > When a vendor prefers to implement such cross hw forwarding it can be d=
one.
> > There isn't a desire to burn and program extra hw for functionality tha=
t
> already exists on the VF.
> > Hence, VF's doorbell on PF can be parked for the future option when one
> actually wants to implement it.
>=20
> I reached out to windows team to know how big a problem this is. Let's se=
e.
>=20
>=20
Ok. Linux didn't had multi-function driver support and infra was added.
So even if the facility may not be there, or if the current IPR facility th=
ey may not want to use,

In future OS vendor itself can provide the new APIs.
I certainly don't see being blocked on this.

But good to get feedback on there current state of OS.

> I have another idea meanwhile: VF already has notification capability. Th=
e only
> issue is offset has to be queried through modern BAR.  How about we agree=
 that
> for legacy, we just agree that offset 0 is used?  Does not sound like a b=
ig
> sacrifice of memory to me, and we completely avoid the new command and th=
e
> need to tie PF and VF.

It will not work for the SIOV which shouldn't replicate this capability (an=
d some other cap) so many times, are you ok with it?

Can you explain the motivation of : why querying notification offset via th=
e group member PF is a problem, if there is."
I don't see a problem with AQ that covers VF,SF/SIOV for legacy.

Proposed AQ command is cheap and covers both VF, SF/SIOV.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

