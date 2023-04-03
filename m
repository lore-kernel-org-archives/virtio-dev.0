Return-Path: <virtio-dev-return-11906-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80DBC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:17:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 58BB82AC4C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:17:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B938986596
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:17:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3F1059863DF; Mon,  3 Apr 2023 15:17:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25F7E9863DD;
	Mon,  3 Apr 2023 15:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3CtXvKLTjLKU67HjpLh/FJ+OQuSKW5qSnq+wakOYNHwY5iW0zAF79SkxuxjzOgB8L5Yr8SCeogmQfLQo49A4N09VHsp1rFowdLyfZ1GuvPOC7u67w06y/w2RhlHq/tk4X2rENIDhYapqbCitEI30v7a0n65MrDYQwtPui4M1Du1fdHNc5GYjQrWNmnafGBZAJ1h7RDqJt+xOwigNic6skxJPIo95jq+uqh3IULYAIKSeRSJQr+TiopL9UaGOE4rbrRMUUH5UIzSRrCGHxo3exuFOpkmf+S+sj2J6eBldhd4bcCCLY3xCVTA+h65IjiGQOfH+E8nxxbNGESxD7D2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUwgvHOAQ1pK+ri5qZb8cpsALejm7oBQXYzdgl/pYOc=;
 b=EmQkgCOftGCfv77rZSPhX7vh8/jsmEzsBbAQVRRlh1KHSzAaqLGUYcPsjsLO5jNW8UOtH72xrFDW2KI+w92S9GR28yJq5SY3sx47/RpaFy+E6S9PQ8cvae4R5/xPepBCuYhpO6O/Wq1VWy3LJULI2abR53qZg89b9kLfgw5UFW4wGKUr5XvjM1eVoQApplT4Z4J4xmt2YTw/FKoZLVwem1u+sCnJyp9ubKkntmdwDf8wDlOtcttgDbyFkP1Q0RXg4kI+Ssmk1+Nq34t9v/FJyhr2uXgo4o7HveSmijYuuH9FOn2G4o3QF0eOP13LeeHn8sq92e8qOoPsFOguLND++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 00/11] Introduce transitional mmr pci device
Thread-Index:
 AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8UdveAgAD15oCABER6gIAAAE0wgAADeYCAAAA9cA==
Date: Mon, 3 Apr 2023 15:16:53 +0000
Message-ID:
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403110320-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6302:EE_
x-ms-office365-filtering-correlation-id: ea88ac9c-57ae-486a-795f-08db345674e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l9XdnqLxwiOdc38s5RP7IMx8Lt9r6L2NdF+b7VA6GEJl3we+UpO4/O/EMulFnngGdyT0qsM+cYy1NCvOrhCAe0jnkFKfiyCYjtW3iq3v1/TJ9dCWjfMpxi9vOJ65M1Xbd4Rr7l9ugFgtRs7P3d2DYI+8IY6xe+6qumj4KQuTmrdfMfkb22Me//C9vQRUy5toqaH+Hftf37E+USH6HDsjIuhKkV3pBH9K0wWPS7jtf8cuWUqHgGmX0g2ikmNUzkhCSxkHrII5d+prh+ke/K89spnh2c+Jwf5CGOHmfS3RY6Lyt+O1ZoWZmSgunF7KSmmb0J3gOJfNkbb6J7iTeEw6Gf7q7Fwccv2ZbSlu+xhPJC5ZeSGCx/VEDp6UOsOYXG+HzzrlqqgzoJ+PnBsd4m9kx2wz4RcwIvSANB7OMvZiA1gcjWUYO3pgoqoOYHgGBODcfJFIlS+JRr5Tdm/1lBWqVfQoAE6nKXwQBw97H2LwePkGi0JiJxS3VzVOHPjcQhGtHyEEUS4q9NLcbfNodTcDvXWZYsUxC1iJ5kGN7cTd/ZU6HdJSKXKt0u31ovjNUlSD4mGQ2TJE6QT4Yy8SCCyrXUyWvYSFTl8u+2jkiyLxg0G13z/fpaPCH89JC2bWhA+G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(5660300002)(86362001)(186003)(83380400001)(107886003)(9686003)(6506007)(122000001)(38070700005)(8936002)(52536014)(33656002)(478600001)(54906003)(66446008)(7696005)(41300700001)(4326008)(6916009)(64756008)(66556008)(66476007)(66946007)(8676002)(55016003)(71200400001)(76116006)(316002)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bKd5sZN336zsHJ52tasvs2/U6UhCACGYdqrJnKR+onGtG5XTT72QYf8NnpYE?=
 =?us-ascii?Q?nXo4l1DptI8ulS3hd0MYJ38Xc53y58CU4udAuWeKsm5rakh6YU/aX0JyqyKc?=
 =?us-ascii?Q?q+kehFxfSiG8x7hT9shAfLP7hnG2WlTKW3J7kRHue3MGPY6/2P1hcRGEB84x?=
 =?us-ascii?Q?lyzj8bRzZOoYMMuhGDgGbrIGV5LRux3j85Dr71S+IowYu87ME3r7S/hVQkyR?=
 =?us-ascii?Q?66/aOOnlnePxMFI24Dma/qSNqwnZW7XyoA7BDwRQd3qu2oVxe18M+oqDJK3I?=
 =?us-ascii?Q?wN36L0AMEL86DdsHEVtbOsTt2MZ3bR+EF78Q4RZKgpETY5pl+aFjoJIn6ZTA?=
 =?us-ascii?Q?TCHVkvpBiIuNAf5QlLn6rS+o5paulNPVOu7KP2GtUbwWH+iC1i1VZPco0Etg?=
 =?us-ascii?Q?rfp+uXyKWfXhVgpSJKnuhYsGTIbSAtM/M725G1UbkwS7m7v+OIoTNIZso38t?=
 =?us-ascii?Q?yeCHrMfzcAWAT5PPqVsnhyp/+RO+nOnLIhgppqtHaN+uPWIvXzcLktsVnXsr?=
 =?us-ascii?Q?QxXq+sYOuIX+nUiRwRNNnGaypnp2YK891uXvhlVAEtYLpwXgzqIE3W5Bitxa?=
 =?us-ascii?Q?hwqpxu7ItUtoAKk6BA4LQELmKGqiV8ZD6NBYDAuSrOP00JQJbq9iojfL/7nU?=
 =?us-ascii?Q?AugvLe4I5HHl4ZYqv/WsHoXnU0AQRdQPW+ikVKE9BND++5PRNzP8+nGydbvx?=
 =?us-ascii?Q?Xg4G28/uhW8thg/6Ge0+I05CymD08IgoisYm9aO0wm8PmL4ttTyUjUsSWgzE?=
 =?us-ascii?Q?JlJywKblAvwxMl0JvzWHDa9ZwD/REFrs279qphSvv+017W29Hw0XF5kNRdmC?=
 =?us-ascii?Q?dCnqR4ch/GuMhO2Va4BOu7Xg519sCh8tYv9X6ckUfxxnrRI5JqCjMegPBO2x?=
 =?us-ascii?Q?4hvghsW4nDNC1hTGgAWE+2AYFwXMM9dxRc6xCQyZmNjBbiAGCmKVf/LehS8e?=
 =?us-ascii?Q?Y/O/3b5C7WYKCtZpZ4LXLuv+CNw9rFf1S5mS5JdlwIEkIPhkfIYDJKKWqrQz?=
 =?us-ascii?Q?o9D9JAoThkI8emH6NK/ahhEA/U9htxZ1KMxVE70huhw+GfdsDa0tm4Irb3rg?=
 =?us-ascii?Q?A2QSmvZAm5TbWQTsMG430MB/HfUGzQipgya3yRqYN3gkQAFzHz3BZZmZ90Z3?=
 =?us-ascii?Q?E+Cb754pNUsidvJ1bGDQgvIz4GqaxKPkh822oUDhoQ5CvRH8PThOT2GB38l1?=
 =?us-ascii?Q?tdfEhgI/SwB3DrU3YN76eE2rbwc1onqqNEZlONbWoztswoNDdoxzjATBje/5?=
 =?us-ascii?Q?72sbcgTR/KCkJbBL1/r+m9fYJNIdzZIXsyn/nGI6Mu7t8lYIOWW/8/LHJ8YD?=
 =?us-ascii?Q?g0DCa6lzDfAT5CWelMnLBj/HEOjEtfg4TkVZMonKKrrUBv58ty8BSm2/J402?=
 =?us-ascii?Q?Cf7SI0+xnxg5m2TfE5/3cbuHs6j/le1ILpCKQwOtIIez9jxAHBAc2qzN+JH5?=
 =?us-ascii?Q?Lqfs71gi6fNk52ASkHICEHQX52umL9eF3ulHhH8N79RBmDc4fnKwmu2sHudO?=
 =?us-ascii?Q?84U3M5OgjNd4v2UXzX7BFYcBrR6AbHCKnepY/l4OuK1w0FC7kLLkumnueqtn?=
 =?us-ascii?Q?5WWJtkVUgr7xaeQ7UeKyT5/Si+8h+AP9kRgQBtDdNKA8Tk4R08QNLZw685t7?=
 =?us-ascii?Q?wUU9n/2LqSbbAxVXsdl6ulg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea88ac9c-57ae-486a-795f-08db345674e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 15:16:53.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WqUOOOwkUpHXnzGkXqaylFB5haA17ccgE2e8CLCDjMQbwBVdiYVnUlXq2h/bdovaM08nU7LY3fWBzJ4DGQpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
Subject: [virtio-dev] RE: [PATCH 00/11] Introduce transitional mmr pci device



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 11:07 AM

> > > OTOH it is presumably required for scalability anyway, no?
> > No.
> > Most new generation SIOV and SR-IOV devices operate without any para-
> virtualization.
>=20
> Don't see the connection to PV. You need an emulation layer in the host i=
f you
> want to run legacy guests. Looks like it could do transport vq just as we=
ll.
>
Transport vq for legacy MMR purpose seems fine with its latency and DMA ove=
rheads.
Your question was about "scalability".
After your latest response, I am unclear what "scalability" means.
Do you mean saving the register space in the PCI device?
If yes, than, no for legacy guests for scalability it is not required, beca=
use the legacy register is subset of 1.x.

=20
> > > And presumably it can all be done in firmware ...
> > > Is there actual hardware that can't implement transport vq but is
> > > going to implement the mmr spec?
> > >
> > Nvidia and Marvell DPUs implement MMR spec.
>=20
> Hmm implement it in what sense exactly?
>
Do not follow the question.
The proposed series will be implemented as PCI SR-IOV devices using MMR spe=
c.
=20
> > Transport VQ has very high latency and DMA overheads for 2 to 4 bytes
> read/write.
>=20
> How many of these 2 byte accesses trigger from a typical guest?
>=20
Mostly during the VM boot time. 20 to 40 registers read write access.

> > And before discussing "why not that approach", lets finish reviewing "t=
his
> approach" first.
>=20
> That's a weird way to put it. We don't want so many ways to do legacy if =
we can
> help it.
Sure, so lets finish the review of current proposal details.
At the moment=20
a. I don't see any visible gain of transport VQ other than device reset par=
t I explained.
b. it can be a way with high latency, DMA overheads on the virtqueue for re=
ad/writes for small access.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

