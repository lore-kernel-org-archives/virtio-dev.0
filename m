Return-Path: <virtio-dev-return-13048-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC324EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:11:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D05588E07
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:11:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 158A79866ED
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:11:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 077DB9866DF; Thu, 22 Jun 2023 17:11:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E981A9865D6;
	Thu, 22 Jun 2023 17:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMR1mlB6i5dKcMRBxNpAYHBxFxAogICPdVJegFEbjoJts6eKgC8dUHuQYb6t5aYS6uuvFEF4tyV/eVfi/LzV3D5ydU39cex9QniVKHQ/M38rf2MRy4ErvZ+FwUGE21HvXEQgfzlWyZPsu8SIch/l3n1EVgewbflUT38s55LnUwPvdHDKbpjHtMq9Rp2kxNY+LNuJ7/n6pRU7C9DKOOx/wKKsdkE5fkMMVP1yVYPk5SNmnG4VSXMfGW5DHqT3w9tko4DtGSqgo8vtE9kJlzJfFY9NcHpWXWy7ljSx2BHJAi8jkCQaMI+qrJOHlvxIu0P2jZ61NK9qhDgWcE4ZmzmwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXe143ANVu51XUqkbp+cqVrrMTKB2r8IZxWUJoKvxRo=;
 b=mxMz5xSVlNaSJBaYVkZdlRSRjDMjq7jmK98VThgLV0YKnVInKtmwAQVL8Fl7YapdpwnaFwy+08Hcuu/BPcHPFVZObD0v6D/A1ORU+ANDnmiHgH6GiiYvAsP34tRtyA7hDzryuW/P7YaCHS2kfUNARxcu/dNFl02cMvkm32wX954AKFq6jetNkktAcZsrvjNpyiHa/wkaCzMWODIb0cgfoG5enAMUIbnyRDd7lEiSItMev6Q1jfI58/+cVeDZ2FSqTsj8tgQ/g0/bo0WPxeGcoOMNhZRHNk83ap1f9bjj8xSGC7uhBAmr299PC4tNH4eKdC9le2ArjQhhNF/3y4q9Qg==
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
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggAAXcACAAAvqkIAAJ4CAgAAA4ICAAAPngIAAAI9w
Date: Thu, 22 Jun 2023 17:11:24 +0000
Message-ID:
 <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622125601-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622125601-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4562:EE_
x-ms-office365-filtering-correlation-id: 48d74c72-805f-4898-85f8-08db7343b55d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ouKbT3Iz7aSigT6EBjSYDWzVC5FkThHwcZnO4tQ137kA1CYwy2o3z8Hd+5nx4MAurjgXmi4P1fHLuo1yb+3gxOJmf2AaAsbkW+vQLrtW4r3zugBwwZNMlPzcae9xfx/0KiuFF6iRmymxd3nySl4jUVaRVuCcDcqKS06gyk2m9nbWPFIvpJrpBGBr3LVITd0mdOOLdpC4Dqy9C4yO6cWSi3d9KMnURlaC6yPHmzcjhqLze3HyPB4q/OJ0bY3TXVhkyMZ++evCLhXqHraORl9Gw7/6ZRjin00Oc6UbjkTWPiDI8jouWJf9ABEo3+zzfU/YVMPfJAC9MVTOZW23tfZcW5srlelAM9Z+443gqXTipNXbAJHmViqrQODZwmQzFrnXUdqI1GtG2wmKaHWUKNoZCZmNnH3sCfJpy+GjCR+kY6fpFotLhOqicZkSPcVFoOiRQ2wWGrd2aLT7WWft8vkz9Sc3uAnjU+fZIcvSBbop/BMZU+Jn6CUHQBdAtb3hpHXiA1iLATC+WiFix8FtTxxOZQm2VMdzW4e84gJvXsHU/wly2MyeheJAS6UITwoa+2PLWZ/shlbkqZOUeIJMbWoKLCZpBsjWGuU9uk65dbHLcDkW6/5K24PcqwGZsl7omYUX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(52536014)(5660300002)(2906002)(6506007)(53546011)(8936002)(8676002)(186003)(41300700001)(26005)(9686003)(38100700002)(122000001)(7696005)(478600001)(71200400001)(55016003)(83380400001)(6916009)(66446008)(76116006)(66946007)(66556008)(4326008)(64756008)(66476007)(86362001)(54906003)(316002)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TaJnNsqEqz6uKDwPWLZvE3x1eL/uAqDXEUqIQsTVpEUd0YUp/1J9dep8oWLU?=
 =?us-ascii?Q?jJxgnY6yGkzUVwPnS+ni1lx3E3gz9h3TH+YsdaYOPgWL0voWOFu9bfY5CoZC?=
 =?us-ascii?Q?QvSMN7FfPDVrRqtZrdAELkVPzzMNNC7IUgd7AUe5QaQ//gUKnGk9yo9guGU0?=
 =?us-ascii?Q?pEmDul4T/e2D48DDacKPPzFqc2Z6YOa4ZtNj/BxepmVHdrZUVrhe2KkT45l2?=
 =?us-ascii?Q?hL4LdJy8RTy4N5Nvpm95AV7zvtG1BdApiYuhTy76hqrl4l2puD3R7AjJD4q9?=
 =?us-ascii?Q?MFpRBtp2QIUHIrxJmmAN6C6yIxztfBOwS1yXVIqqGgG4ghmFr07GfITp+z0t?=
 =?us-ascii?Q?6lGKb/2jHNtQ9G63jNELOBrUvviLturoGb2BSlT5NnxCCeth7rbCPnlqpNLV?=
 =?us-ascii?Q?m7CvCA/XefG0jpRKdEvRwtslWHeMc1I5zVPYZE6SxVmHEyV/ZWSXqH+Fd9NU?=
 =?us-ascii?Q?JzwEwy8Ga91/YFXfMxgZ2kd7W0bmPuTKBEn0J2qtrTSQjR/KcASWiAWx5D/i?=
 =?us-ascii?Q?9nasAvf0PN5aW7IvYrbxUwBJ8F0bwZLP5Iq9tc3FJNRD79qVKTr2AxXH3KP3?=
 =?us-ascii?Q?hQjsyzn03LL/yURUsJQx4LS3pURnAx5mFTSdI/6DWn+M63zgmTAyFfuCslWx?=
 =?us-ascii?Q?3NcDJjJTFZr6qBsjZ10JnZJ2QF/Nnh3OPD3N+Wc5j8FkFX091QiahHDjEpHr?=
 =?us-ascii?Q?91IDvi2uSMzTI78Q19/dpqtJjbK1V9SueLJGn+YzYH1UFJWV4qTupL1ABOOo?=
 =?us-ascii?Q?TvP/qKCun1b1hUTW70E50JhFwFP64m1QoutWZRsNqC2y3TNq3/CnmCizb0IQ?=
 =?us-ascii?Q?G68Sh3tBwmpmSCJ8F/lQHXdNfFTHzP4l7AeQmXJ49AeaSZ/BjptvnUrnv2ry?=
 =?us-ascii?Q?aPthKrX3UC+Et3jYKZGR87PJvOQ//kn6paWKf8VladLETSGnKTk5+y1UYyJT?=
 =?us-ascii?Q?+uguckDohAT94JTJVnKOvR4664VPmsaYC7NJNiECfCif/LF9iH8yeGqtpEnd?=
 =?us-ascii?Q?yLFjkPbf0PI0ZNh9M7QZt1MU1uJ99V4mNIyQIVpffgmsJC7MTqJ8dvipNayK?=
 =?us-ascii?Q?MslzaWdkV5e6058rLXsckfVXGbWsLECimTOqVjpcVQNgGrBnqZZZfjPKl/PQ?=
 =?us-ascii?Q?k50FVLyItksr9pqdHvVjuMLBY52Vhw/329IiwL/sDAbvFwNWKQa5XKRjoMJF?=
 =?us-ascii?Q?RDsnbxwDkxR9LuZNnTH6ePZME7F2z2jpKW+ud+c7eSj5X0VFIWHLWAg5dQbu?=
 =?us-ascii?Q?O7JRDiIt3BzzfmegeCcd9CUbLkRa1cX3P1KZ1LryRfzf7OAFRgFWnvt4S87t?=
 =?us-ascii?Q?kr8FpQgNPkaM2m6M0cKuiUsXmAGIpdtfzsW6rEdrqnZECpvZuXjOjJpx5pgF?=
 =?us-ascii?Q?hYbnaHLi51xc4mPC4zycHFR937O2bhBv6w5yJmkGBN2vhWjsRsrjDc/hiQVx?=
 =?us-ascii?Q?Muofijqxwb6XBXYhwPsYLy3l0mNksPuXaY9K7CuxIzIxkuzo1pVLaXJ4tpkR?=
 =?us-ascii?Q?/qwSAr0UigMgHqPDaimnKsIMqSvwgeQGIJ12zaC2RdeJtarmiJmkN8ZhFVOM?=
 =?us-ascii?Q?BrL6dbKtR/Dqjhw3VY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d74c72-805f-4898-85f8-08db7343b55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:11:24.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Loptn82w63iuIflJ4HcChK1d8IsNKCvYhG1PMdWh/M4FjvNCyMamP8H3KTxnJI1HdvJhON38G74hzmhOCl/67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Thursday, June 22, 2023 1:04 PM
> To: Parav Pandit <parav@nvidia.com>
>=20
> On Thu, Jun 22, 2023 at 04:54:48PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 22, 2023 12:47 PM
> >
> > >
> > > The hardware footprint of keeping this in memory is also fairly
> > > small :) I care about a messy interface because this mess builds up o=
ver time.
> > >
> > It is really a simple GET command.
> > It is actually messy for the device to implement functionality in two p=
laces in
> cfg space and cvq.
> >
> > > And I am worried about capabilities really. My bad that I missed
> > > this change in v13. I only can say in my defence that I already had
> > > to rewrite huge chunks of this proposal to make it readable so one
> > > can't say I'm only delaying things, I also made an effort to help
> > > this progress faster :)
> > >
> > > I feel we need a single place where device capabilities can live. So
> > > far they were in config space.  It's consistent, yes I get this has
> > > hardware costs *if* there's a huge number of VFs and *if* there's a
> > > way to provision each VF with a different configuration.
> > All the ifs are valid today.
> >
> > > And yes querying VFs over MMIO is kind of ugly. But it does at least
> > > work, and works fine while VF is assigned.  So we can build
> > > migration around that *today*.
> > >
> > Other way to say migration can be skipped for this feature bit, and it =
still
> works for rest.
>=20
> If VF is assigned then we can't really control what does guest enable.
>
All parameters set over the CVQ needs to be accessible to the migration ent=
ity.
Including RSS and including this bit.
Either by trapping the CVQ or by having AQ command to query member dev capa=
bilities.

> > > But querying over cvq while VF is assigned clearly *doesn't* work.
> > >
> > That is not the idea at all.
> > Querying VF capabilities is the role of the admin command for which we =
built
> it.
>=20
> This GET is exactly that though.
>=20
Not exactly.
This GET command is needed for the member driver to know what is supported =
for the device it got.

> > > So what is the solution proposed for this?
> > >
> > 1. Query member device capabilities via admin command
>=20
> But that's not 1.3 material.
>=20
> > > Yes the current migration is broken in many ways but that's what we
> > > have. Let's build something better sure but that is not 1.3 material.
> >
> > True, it is not 1.3 material, hence the proposal was to have the GET co=
mmand.
> > Once/if we reach agreement that no new fields to be added to config spa=
ce
> starting 1.4 and should be queried using non intercepted cfgvq, it makes =
sense
> to let this go in cfg space.
> > Else GET command seems the elegant and right approach.
>=20
> I expect no such agreement at all. Instead, I expect that we'll have an a=
lternative
> way to access config space. guest virtio core then needs to learn both wa=
ys, and
> devices can support one or both.
>=20
Yeah, we disagree.
Because alternative way that you propose is not predictable way to build th=
e device efficiently.
It always needs to account for old driver to support.
This is clearly sub-optimal as the capabilities grow.

> A good implementation of virtio_cread can abstract that easily so we don'=
t need
> to change drivers.

There is no backward compat issue for the GET command being new.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

