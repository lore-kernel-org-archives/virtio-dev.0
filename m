Return-Path: <virtio-dev-return-12636-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3262BC7EE22
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 21:08:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4835E1CA252
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 21:08:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FE5E9865E3
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 21:08:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 253979865B0; Wed, 10 May 2023 21:08:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DED09865AB;
	Wed, 10 May 2023 21:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMxSj8u1d1iKZAAcjfDt4tkSXqoNbBovHxB4Iln6Fu0fxD2hbyL6sf0r/6UOzD4SxpqNFaiyj4QluQsiFwuHp6Md3Qxz0rg1wvt7Qhg0r9WdSKLg3mR9T19q+eCKpZwNlNM4poehbv9UCYrLqbn7PqMu7kdOa9g3E5FNs+iJDAipFS+QCnJFmhwTPPGtjvcsLAxoO+EdlPkLSrzADGE8MDtfabHEw5hfUQNxM59dRtzRcW/35iqibtliN9sC0peWiKr8uJwCjXHAvFJkRnC5O2JpRtu6VMJapM0QGHUoBtjApvqGte1GQwf6JX8qkh2oTPnqRSJvGWkUkf+RWACb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAJ1pDsGArGRAnlLIOU2xJeJ0owV9cQi1yAso55l2Bk=;
 b=K5a4mNhZWMjpUjVfieKsy2z2MYvVLpWSot7ZH+vNybN7ubNPJWzcHaHtL2WnZRzdLQ2fPDflnVyKfaPrq689beQGW6hZkovBTIe9ujNNqoYWVVtoR4CgGk3HZ3+EHyUKPTbzq7LjUw+9cnACaHk2fu/VK1G5jLpMCavGEdquGqgPOBFthUI+OZBiP0x0NRpOSRCCvxzyl3BHp2zkviBKW8bvKntRfiyzDfzpjSMt0gcnwgd3BzSeAFwvCt2QAOqEauTV7PgcnJZE1+kbRsN8reZE+0udLa6Y0QkX1H5nJYy6pwZARib4tFW5Q7G7R+jgsPDW+akxRHs58wYKFtE3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311A=
Date: Wed, 10 May 2023 21:08:44 +0000
Message-ID:
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7316:EE_
x-ms-office365-filtering-correlation-id: 76ed2353-bb24-4f88-e37b-08db519abd6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YjdyRPMyZ6Eroyo5hJ2A5zF0LS6dP7UBMQ2dSK5cgKCH+Akm5V0KWi5tsRX9zY9hCSQcviN9RaULSqR0sL1yCVKMDuWZLgyJkkLb13ZGAuOaLxZ3CVx4mV9bOXeTR+0/m1779u5a8BWcdKB03xXpe3S8QYQHz0BMkR5J+JX70gBXg+5XSHB4mDhSRoWUycfwoIjp7pX4J4y1eOSyCLecAsQOEMkgOlbchDM7iMOvJCW+Fl0UzmrQj3tdbJXLhDMQK8NuNuCTyGALrPnfh+9aPErDeHjKA89hWaaARqohH7553RrrIxShBdHs6N0YWIUGbnyehXtzWmsroswVFWpuCvRuaJWt3nN6v4j9t6wJ6OwLF+x04R2DnAzXiSFjoW7wIAGky/jvVSS9Np4qiRgllNXpV00KHlsiLuUCK/o7ohuaAqGixe+81o0q+r5TbgCW8xs5Es/yLCqNQk6IzpojoLSHz2Hr5SW5ikB4SftWJgVoj45pXlxwKokOTterLoS0jzXjSZ5eGLlysQA6/2PFnR9r25Z8nT5TKJs4StlcJaWXf6VoHwlLKlk6fQ+eEC40Grj5XtBrDcOccfHMFwwxT5PIQfLzoDmO/DCz63E0aRy1VaXJ8AexeGW7eaufNOhayN1vKkp0cXtVKYIxLyBoZBtYzvQwX6J25//CvMcpOHUuTRBOW6JWargiq3F4ZYY/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(8676002)(8936002)(316002)(41300700001)(84970400001)(52536014)(66946007)(64756008)(66556008)(66446008)(5660300002)(76116006)(66476007)(2906002)(54906003)(110136005)(4326008)(71200400001)(478600001)(7696005)(966005)(86362001)(55016003)(107886003)(122000001)(6506007)(2940100002)(33656002)(83380400001)(38070700005)(186003)(9686003)(53546011)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7OuYwgTwV+ynhca+o9gE9yeh8U3N3rnmEN5LwJv3ey6XygzOM3jBvZ8Mvvv9?=
 =?us-ascii?Q?h47pv9ReBmTHySLJzqxDbn9JiW4aKZOfYHWmc0w13002BZH9F8Dhr5FllNMa?=
 =?us-ascii?Q?n1Dowy5Quk70olPhwuMPbtyIu8ORpdD15Y2WAJ2ZCY1KPiTEFp5ACqT1y2tR?=
 =?us-ascii?Q?+cA9hZ6/UYToImhZcuOOmNNKnu1Mfmrzisrk08jiA9UqY43UHKOj2Ng+jQR3?=
 =?us-ascii?Q?5BBfbWpSmfajz9gnlry730U9nLNmpgx7Cn2QcALewlBWIi7ON8j/WlierX5G?=
 =?us-ascii?Q?hPrMDYIgzyrqQjcDwNjhrYdVWwJmtRiisnnImkgPbaJEir8n9MJ8r+JdHftL?=
 =?us-ascii?Q?qDrO5KckGmMcnmY2McMedzhZvdr/97NzkMCVp1Q4Ef6pjnrdrKjgRTDnn8Tn?=
 =?us-ascii?Q?Eg1JpzeDi5/22XxFSGU2uVKF5fPrsBQUJ2b23E4YfoPFp871bNGAa8brOvZ9?=
 =?us-ascii?Q?crICF/5qVbgN7tLhIQwpSzBJYUYaIS8MvsfZXaKCIVeMs9N2PiRw3H+Dm8NP?=
 =?us-ascii?Q?LsNdWfRmI/9suT4VtCMxKCMrvfdsGYCa0oC74862gJYFPW60wvttp0o8Gg+O?=
 =?us-ascii?Q?ZGFTjjtttRUIU4G9Al2+zYtJJnpHP3VI5BU95VgoyhkmBbAAwwGSve9xIGO9?=
 =?us-ascii?Q?0/PF+7lphO85ON/cvMtyB690nv7GEnbFqfYF/pZh4JWbQh1dBjnNj3WVFYyH?=
 =?us-ascii?Q?KlzrB1ca3OR02B6o09732r5ZV5bhQSY71GhweNi2NUGlfU85iGoWRenAIdMv?=
 =?us-ascii?Q?yQWTqQxcBzQpv4zuEbzHeCpGVv+qZ+il7k0mwpeHEYIVtLLq9qSf+o0n7MFn?=
 =?us-ascii?Q?yNANvcru0shTdDgxLHTm9MKtvz4q0dh+cRnVpYR2e++K2SBWmcbh+Xnu6OR0?=
 =?us-ascii?Q?fvmWzRj2KkQdcKb+I7HMNT3mWKyEkfH35QqQFE9GWcXNF//Tnlu4oC385CdP?=
 =?us-ascii?Q?mWB6/WhsxKMwEUpOw+ngl41hz2y5vbuCIbcjvAUBguE3tggi7ulNpzoHtoaM?=
 =?us-ascii?Q?21k8kkoB4i1b5FqsUlaVRFJ8Wtcc+zOgv1zh7lF3UqDR//xEMv01hx0hvnlb?=
 =?us-ascii?Q?a+LodP7TY58WjB45g7Q58MCaWUmERQbi5aFgZpbxS1AneNxh0g9QGa7mcv8I?=
 =?us-ascii?Q?Meqxlaqz6B4u086h4mojwdBmoLUGKSNzFx9cKd8EVLAAwPkCcdVf1xy1XIF7?=
 =?us-ascii?Q?5GzVmSPM6DU+nWkQvRiIpORrDPQNt/7nNofStcGR9jezYOD9wMF+40biyDEU?=
 =?us-ascii?Q?EfbHK1VwXrPeyJcCzZoovLkilcuMB853IwWvNE3n5bec9bvbepu/o5+kKQZF?=
 =?us-ascii?Q?AqSPJLFM8U6vbGDO+OfXIVncG16u8eboRktZWSZIoq1Fe9BHhUm5aI/m4rt3?=
 =?us-ascii?Q?EY6UC4wcxgo0uRNDZag6wMffDtN0D5oKTYgICuD1JhKhBDl3uDOLNkiks4yC?=
 =?us-ascii?Q?pTXQPPnp2nG9Ko/xL656/EpH39T0N0UPaJryWNN1/MDOXfYflKvD6Bjz5sFB?=
 =?us-ascii?Q?qJ6A0okDnJfeIUhSk2Rc+kiM84b+sZQxpm8cFf/2/QJqwUec9HZKWz1OofQL?=
 =?us-ascii?Q?Z72692wZCrAMTlvjf1Bq1A6YNxpmj0bpFj4Q0ez6xZ6YYRXyMlQTnGzP/VwY?=
 =?us-ascii?Q?yZNhsjupS1Ctl/ZYYQXn9HA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ed2353-bb24-4f88-e37b-08db519abd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 21:08:44.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIBXPoECDXLwQdVSoAmWb9VEwDeTZZDrlF3axJA4uzXER7FIQp1ZGUn4wA2DSo7Hjun8Sh30i+5tLbyq+5CmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

Hi Jason, Michel,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Parav Pandit
> Sent: Wednesday, May 10, 2023 1:34 PM
>=20
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 10, 2023 12:16 PM
> >
> > On Wed, May 10, 2023 at 12:11:50PM -0400, Parav Pandit wrote:
> > >
> > >
> > > On 5/10/2023 2:04 AM, Michael S. Tsirkin wrote:
> > > > On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > > > > I thought so too originally. Unfortunately I now think that
> > > > > > no, legacy is not going to be a byproduct of transport
> > > > > > virtqueue for modern - it is different enough that it needs ded=
icated
> commands.
> > > > >
> > > > > If you mean the transport virtqueue, I think some dedicated
> > > > > commands for legacy are needed. Then it would be a transport
> > > > > that supports transitional devices. It would be much better than
> > > > > having commands for a partial transport like this patch did.
> > > >
> > > > OK I am beginning to get what you are saying.  So your criticism
> > > > is
> > > > this: what if device supports vq transport for modern, and we want
> > > > to build a transitional device on top.  how will that look. yes?
> > > > A reasonable thing to include at least in the commit log. Parav?
> > > >
> > > I am still trying to understand what is "vq transport for modern"?
> > > Do you mean transporting currently defined config space access over v=
q?
> > > If so, is this VQ belong to the guest or hypervisor?
> >
> > https://lore.kernel.org/all/20220826100034.200432-2-
> > lingshan.zhu%40intel.com/t.mbox.gz
>=20
> The gz link is not accessible.
> But I got the right link [1].
>=20
> [1] https://lore.kernel.org/all/20220826100034.200432-2-
> lingshan.zhu@intel.com/
>=20
> 1. Above patch cover letter [1] is missing the basic objective/problem
> statement.
> i.e. why a transport virtqueue is needed?
> But I probably get the idea of [1] as we did the AQ.
>=20
> 2. Commit log says about
> a. querying resource of management device (aka group owner in AQ now) b.
> creating and destroying the managed device  (aka group owner creating gro=
up
> member devices) c. configure the managed device (aka group owner
> configuring/composing group member devices such as VFs, SFs, SIOV).
>=20
> So, all above 2.a to 2.c belongs to the admin group owner and group
> management commands like how it is defined in the AQ proposal.
>=20
> So, 3 out of the 4 motivations are achieved by AQ proposal.
> This AQ belongs to the hypervisor. I am clear on this part.
>=20
> 4th point in cover letter is: "config virtqueues of the managed device".
>=20
> This work belongs to the driver -> device direct communication using a qu=
eue
> from driver to device.
> So, I imagine this work can be done using a queue by the guest driver and
> serviced by the device like how a guest driver configures the queue today
> without any mediation.
> For PCI, MMIO transport, surely this can be done by the PCI device direct=
ly
> being is PF, VF or SIOV.
> (Instead of config register, using a new queue interface). Looks fine to =
me.
>=20
> Can this new cfg queue mediated like CVQ that is done in a sw? May be yes=
.
> Should it be always mediated when it is of VF, SIOV Device? Mostly no bec=
ause
> it is yet another VQ for PF, VF, SIOV.
>=20
> I am yet to parse rest of the 4 patches, please give me some time to revi=
ew it.

I went over the past work of [1], [2].

[1] https://lore.kernel.org/all/20220826100034.200432-2-lingshan.zhu@intel.=
com/
[2] https://lists.oasis-open.org/archives/virtio-comment/202208/msg00141.ht=
ml

The "virtio q as transport" in [2] is bit misleading as its only role is to=
 transport the _registers_ of the SIOV_R1 device through its parent PF.
Rest of the work is the pure management work to manage the life cycle of SI=
OV devices (create/delete/configure/compose).

And the motivation is also clear is to provide composing a virtio device fo=
r the guest VM for the backward compatibility for 1.x part of the specifica=
tion.

It seems fine and indeed orthogonal to me that: it is for backward compatib=
ility for already defined config fields for existing guest VM driver.

It does not conflict with the cfgq/cmdq idea whose main purpose is for the =
new config fields, new use cases that doesn't require any mediation.
Such cfgq works across PF, VF, SF/SIOV devices in uniform way without media=
tion.
It also scales device register memory also very well in predictable way.

The registers and feature bits access described in [2], can certainly be do=
ne using new non_legacy new AQ commands.
Both legacy and non-legacy command have different semantics as Michael ment=
ioned.

The AQ semantics that Michael did as opposed to "virtqueue as transport" fi=
ts well for the use case described in [1].

There are changes on going in MSI-X area and SIOV, so you might want to wai=
t for it.
Or proposed command in [1] should be tagged as siov_r1, then things will be=
 cleaner.

With that I don't see legacy 3 commands anyway conflict with [1].
Some commands functionality is common between [1] and this proposal.
But that's how the legacy is. It is confined to legacy emulation.
So [1] can be done as follow_on to AQ and these series.

A small note about [2].
virtio_transportq_ctrl_dev_attribute should be detached from CREATE call an=
d split to two commands.
So that VF and SF/SIOV can both utilize it.=20
SF/SIOV_R1 can use the creation and config part.
VFs will use only the device features + config space.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

