Return-Path: <virtio-dev-return-12763-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998CEC7EE2A
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 16:37:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0FCCD2ACB2
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 16:37:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3968986736
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 16:37:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E4CE3983DFF; Fri, 19 May 2023 16:37:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEB8A98641C;
	Fri, 19 May 2023 16:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKW5GecuIqLvFXk8zO28RBihp0CZms2Sxh+4enfbUlQbMufG8kmTV/DEGlgyetUdMjGOQKBiBOVPwj192OOno/3I88ji0Zso7xzo565e8fQWQnRM6ZN2onDU7S/5GEhNW5HYd4+xz6cROm3g4gWioRhsCPQpmI82zeuSzL6EH64upidvfFDkJMAq7lxwrp/2zWMdrFmPJO4lP4TGNf5bgdZ3sasNGqDDaoqJ4kisl/pcb7A7phpvUHle0syQ9w34OtaY7U9xmiTK0YuXNcAbwmZjM6qzh+uq2heWWwHvSauVlt0QEjZDEqgtelBcXfdZ69qCI+t+PFHj6hsNNuU13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0kXqYXSR0yjVwT5xyASccMHZGYZraHZTi/O4ObR91k=;
 b=ULganFP+RTFZrEplHWEuWBzxKlI06OAKOSzRP6ndOQkXU3/LaOUgy/iALHWg20cLaSdYMIb9FhcFaMTbTyR8p809W0cwNkXD/ITMglS8SDvHb9qdLN5aCKK30pGN30Qs0FAEOm9q+kfNk0+w0uIZC0z3Nm4pxgpTCao5tqOpNls24YdS6sGtymzLigFPC4BthWYa8Ohh/Tv1a43XCrX0JVEYQroHs8ignDA4tiGSYCO7CtQWU8ioe8dskb29ZKHULpZ1CuxOwCym/b2bTynOv9yqN5rBAD7JzHiiK2CW7sLQIZFg4FGmj+JQZFTt6/7mlqpVdwVTH/q1iniN7OGchQ==
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
Thread-Index: AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0A=
Date: Fri, 19 May 2023 16:37:16 +0000
Message-ID:
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230519015520-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6902:EE_
x-ms-office365-filtering-correlation-id: d29f1be0-b628-4b90-a11e-08db58874ed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aegZZnoF2XYe2mVnZNGDBvV1sxWCg7hrlnbADfDQr5YYZOdoRNLfdvbrFgOTJZLeBRKTLmyvRiYLbZ0flnsNz6QdKeaL+uNxZXVkRYpE3Ft3uXJFumQcTGUOhmVnNx9Ye4rLhDLpCx8tSci+aio3LGbWydmxsY0CCRDNvUysVQxHbJE9/06lllJYau9ZA23FJNhAq30nc5eJug5wLJu5ozpz3YpbrgucDxyNEkgzFseNvbdsHQX6s8mVSmnFSnFkKYjAlCCEVps7VoSDlyN7NTL3/LvG2QtRHwNWXkppor9V/+l8ZTQ0q2nsMHLn+LCUWv4BzY5bK97DLB+ajoyLlXawWKzt3bTrHV7Una73mexWocIUWptRjJhp8HGgSgq9rW1MActB23EtmoPlJI/9vAxLL0LAvHfILQpArWkfQ9gMJ7dTRemVcI4a0R2m6Trwg+fG2QeVIpocD+IPyYnG0iCgQcbYe34xw/LzbceUVasxOdlU4aK5afpkeZX/cstaF23VosXTqGv99Tt4kxPah0jCmi/pjMlM+fr7YkBoJ7Hlgs3awDvLJb5DSA6RXv8uNKZlNlQNJaVPvf6uELgXqSNUtl9Ha+WcQX+8t7neXPFfB0TDkRWWFApiq87W50r6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(33656002)(478600001)(7696005)(38070700005)(86362001)(64756008)(66556008)(316002)(76116006)(54906003)(66446008)(6916009)(4326008)(66476007)(55016003)(71200400001)(8936002)(2906002)(52536014)(5660300002)(8676002)(38100700002)(41300700001)(122000001)(9686003)(186003)(6506007)(66946007)(107886003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?btjEKMgBlQUq1xSNfIxgyXt5dHL2D7E/O8uPrkgTr+fKsrSTqRRX50k9cyjk?=
 =?us-ascii?Q?Y8t/0b/gOO09Yhn3LhR2XmbRXtop48Gv4Dbj0HwzlkMp3YU6cwhCGWuRNTVq?=
 =?us-ascii?Q?xi2OP1/+81+H0+bTOKaKY+iSe72ga55V434h67LsUJpSUVYnusssCsb4e3b/?=
 =?us-ascii?Q?/sDNTYGAG3UcEsw8ndG3aLXYKjNzu9VXR4Nnll5AI2UI7uPbOHgoMKZhAsKs?=
 =?us-ascii?Q?aUyaUlZfgNI5KVQJapp/rYzygC8apmVNhpR6i+CbdEoutU0+7lZ6eYkEM4mE?=
 =?us-ascii?Q?tqqgBWNil7oKii5+7piHprMWsaYyZtYxNVOvL4JcFNtGyUpgJanbAGc0/qMU?=
 =?us-ascii?Q?Ke4kIrNaEtsYXvNAoWk681ORgRMB8oJBivHGzLFGiGoAciQT94qgz5WKXrGI?=
 =?us-ascii?Q?5Cya85N/JT9gTNSSKylHPrTrDilybNW395DeDV9HVrJiLTlEqauVfRLHJ8MG?=
 =?us-ascii?Q?NU/iVMI8qot6OUXIvXBC2eKj9BHCP1WnUMzy4yUTVYbDDaFQntH/0o4NZnqS?=
 =?us-ascii?Q?zoLShK5jEaZU3W24IE/uaOtWkEu872OJPN310hE0xDeds3zBxjeSIHIme2Ky?=
 =?us-ascii?Q?Y1BssXjP+J31dd2lxtqGdFY6DBFrhuQaI9o8JJOt2Fhq0f1f0k9KNRHyeZO+?=
 =?us-ascii?Q?Cy9ol3rXXI+dJ7X/U0t4Ph8HaoGWFXX42HyitFcSq9l3wHXl77CkMqLVLk8T?=
 =?us-ascii?Q?xjc2mrALqqXQOJRmaWRImVBVBpJGM8M5tjKpV+si3b55QVpQIPMxMFezKaff?=
 =?us-ascii?Q?2F1fmYiFaaAojyWrcIVv4u/K3Ca+03riuYreYlmLT9E/+Y0OZlgg5pQ2Fis3?=
 =?us-ascii?Q?CnflRzjN9yO9KLIkUblRABzMz172aGN2bSeQPrA4UkbrLGDkvXmnBgt94ifk?=
 =?us-ascii?Q?/jn1dq3EItprvqOd6eVuilU6JIlh15cYpOocE5u1bR6JExjs2ivEb0XdDthc?=
 =?us-ascii?Q?eUQRbTn0ejNRoHML1CSF4xLHBGKibgAiZE0r7Tc5u4TCRNl6wha+P9qNYQQl?=
 =?us-ascii?Q?dyvOIvMoxS9exLRGWX4llFjjfP14B6z0dRq+s4t3xI4v8RWP+3aexUaPm/rE?=
 =?us-ascii?Q?KcOirJAEXSQZPNw75ZEoeGxMcoQjMcQBgWUQXPQWP+SPU8Kutf6F+b7+PQDS?=
 =?us-ascii?Q?JUuOZ9lp2axRCfKUK5BQxiOsa+HnEsRJNmDg8CdneFdi/NEWQWTPfzvKZVU0?=
 =?us-ascii?Q?ncjly6EW0mmbgL4Qqz7kDIFAbpaS4VsykjxyIFTowVKmb7j5YvujOGnX7Ekv?=
 =?us-ascii?Q?iVETX3dnztBp74fi4F8vnVrFixtLPQw11sDw68jp0z0ckLI1B7/WcL7r+T/6?=
 =?us-ascii?Q?XkgME5VshcM8C1o+5Jc9AyXU1qgLBykatywofHDWg4fo7x7emtTAg1n5R0sD?=
 =?us-ascii?Q?DOaQiri9PU1EL4hpeebQ+OV1HAHcG0QVj3NnEfToOeG1aQaqfI8WNs0lD9rW?=
 =?us-ascii?Q?uOLXjrY5OhlOXPMJ0uXdKBZcMy+KC6oJlyJhTXNHgBWeXLeP54VYp8XkZsLH?=
 =?us-ascii?Q?a4HPqZn39wQ7jWDp91Jr4UUMX4a1fw8B0cZ3IqqKgit834TLRg2V039d40bv?=
 =?us-ascii?Q?jGnJbkaTkz51VABEb8s7ZIt9cUuB0LB8dAGYbk4tm4+sdaPwZxD8EH2AA0MV?=
 =?us-ascii?Q?h4ul9QWPoC1K7myeN2LM/oo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29f1be0-b628-4b90-a11e-08db58874ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 16:37:16.9160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKknmNWtz0h97RdbVgKRhodMylZ7o/JwM9s41EU0LzA7VbrISpBdGbfV4k+to/8I5gOXmJle9Bt4MLDE7YiVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, May 19, 2023 2:07 AM
>=20
> On Thu, May 18, 2023 at 03:42:19PM -0400, Michael S. Tsirkin wrote:
> > > > Does this sound like a reasonable
> > > > compromize to you?
> > >
> > > Splitting proposed one command to two commands, 1. one for accessing
> > > legacy common config 2. second for accessing legacy device specific
> > > config
> > >
> > > seems fine to me as below.
> > >
> > > So we will have total 5 commands (instead of 3).
> > >
> > > 1. legacy common config read
> > > 2. legacy common config write
> > >
> > > 3. legacy device config read
> > > 4. legacy device config write
> > > 5. query device notification area
> > >
> > > #1 and #3 same cmd signature but different opcode.
> > > #2 and #4 same cmd signature but different opcode.
> > >
> >
> > Sounds reasonable. Jason?
> >
> > notification thing needs more thought I feel though.
> > It feels weirdly bolted on, but I can't put my finger on what's wrong
> > exactly yet. Will think it over.
>=20
>=20
> So with a fresh mind, at least three things:
>=20
> 1. given driver attaches to the PF, it should be possible to forward
>    notifications there, as opposed to individual VFs.  NumVFs is 16 bit s=
o
>    it will fit in a 32 bit write together with VQ index.
>
The Notification of the VFs are on the VF BAR for modern or legacy.
One needs to build additional cross forwarding hardware from PF to VF for t=
he doorbells.
And it cannot utilize what already exists for 1.x VF.

 > 2. It should be possible to send notifications through an admin command =
too,
>    otherwise admin commands are an incomplete set of functionality.
>=20
Yes. it is only for the functionality. As we discussed in past already, thi=
s will not get any performance.

> 3. I feel using a capability to describe legacy notification
>    area would be better just because we already have a
>    structure for this. make it an express capability if you like.
The AQ command interface is far more programable object than PCI capability=
 to return this admin info.
Hence I prefer AQ cmd.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

