Return-Path: <virtio-dev-return-11299-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF74C64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 02:54:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 36CAB44357
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 02:54:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 302E498640C
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 02:54:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 24303983E8F; Mon, 27 Feb 2023 02:54:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 124189863DD;
	Mon, 27 Feb 2023 02:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afSJa5aoyuCNWiniZUsnyQWZnhdcBIQmzaIng5uHxXomf5uL02vBsMlFsjDtxUa9krG9UHxvAv8u/c2dGElYz69RwEjG0QYNXojgG5HYn2xiph4Vlg/3VMXqVkNxY7HmKROz0RZ5V2I6qVKE8tJzHsNbanAshRd0RTVVHCHbENv26+qRKbYo7Acv3eq3qAV2XYx3Ozm8E4IU9kPrnI4ZMKyTepIqnCTqTTthTIRpwSBxI81HdLS5tY8OfvwxCe4ur9GJcBZh7vSJGVcMBZxR1ftu14MXLjn7ibJgYGWhOAALudwZ0mY8ZI/IZYOT5fTFap94tX/PQ3W02B6ZI40Apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4dBrKVxxHs1Uw8v95r+rtflCIbAQyJTkK3rFyggemU=;
 b=GXn7sVlCagVpjyY8l97j1eRwCllArczhHI3+o+vcS30bqfpjjGq3XWVYXIog7ESmdteMobjX/DY/qlmMTm/FqK5Ne4A4v2dhrq7VBiXMuHWNOMK6svwrurUF9DUM6zOaS3iVcXCuiGTWNbjaLh2HNeMSIbZSBgqzRXJJlwH2ZMEn2nOIBvkVX7EqlHOD7rLjg6VTEQOvUiCdAZMhC4FuTN3u0ytRCGriWsVqQ0XKalBQsXUe24njK0JMtqkPNR+u9PVXzlDSvYOt9chFDmEsdcUPnXz9/KgxAbms3VfIJXtNG7IZx5xz9BgX+FfYFzJjtsv8k9DTL6Kqxgn+Omq6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v1 2/2] transport-pci: Move transitional device id to
 legacy section
Thread-Index: AQHZSWV4NX7IzhdbwkyDbIfeVwzPFK7gRuKAgAHStRA=
Date: Mon, 27 Feb 2023 02:54:09 +0000
Message-ID: <PH0PR12MB54811B0B6E6E95A659DA41B0DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225220636.429990-1-parav@nvidia.com>
 <20230225220636.429990-3-parav@nvidia.com>
 <20230225175847-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225175847-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6787:EE_
x-ms-office365-filtering-correlation-id: 48e64324-fe5a-4223-c4ed-08db186de5fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F00qWg54Aeh21o/p2wx1BtUiKINBWRCEjuAlYNb21sbR6ZEbiPh7eZnYOSsyQifUwUniY7NZViWmoAhEfSRMHhrOHxBYCfxyVp+7OzlswIhI8lQpnyxAquPoJMtSwEHyLRI1woANro53vQ0HNoC4JpqRU0GqLJWyR5L8Mu2QhyQJqOe1fAFPhhVwUzqFx9m9qphUWL6yGfwbPrP3LzOvQmL80NTmgQ6Sb/9IoClK+rPaF5cuZi/PmWhL5U0q8scGzHcsaFIQ5ix2FRFW4SzQaNAkRi+D1nq2eXKZYclUKzHk8wzXLpZhyVo2fzMQKx8cIKnjFXphP/EcOfeBa0dDXphXhkJyCLSIJfYQ9kbM4jwYPatXxvDbCb1s5HeLKW+iV0YfupDjkGHj81LXlCP3WjgN3+YUpF+R31mHcOQd6Zo+zjTx2ywgTbQ1IkCxgwFyQ4Sn4HBiFtop5IclxI43O23xRYB2jHGNEBpD8j0PrQJwfNQ1RU9+wJb+m6Nth+nXPWYYvH21MNQSy5Xu27H+vN1AUJoO8cYoHgdArLeTobeBFnrptW41zCLwWNWM0r8XPH7vDRiji9PWUu+NDhQK4S3/Giey10i7jIZPIuVV6DEnOj85G1KIKqnXs2unw1I8v856qlRUd5OGZ9OOOOp+sPmGkfaSj0ydWNxa2GkzckDfAcTGEOkTMsBeb/AjLk1cwfdIWCyl6HitCipTQJMwpsxf/sVH6n3X1mgbgyTFogvEVjmrfuScBLb2bssTur5X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199018)(26005)(186003)(41300700001)(9686003)(107886003)(6506007)(478600001)(8676002)(76116006)(4326008)(64756008)(66476007)(66556008)(66446008)(66946007)(38070700005)(316002)(55016003)(54906003)(7696005)(966005)(33656002)(86362001)(71200400001)(6916009)(8936002)(5660300002)(38100700002)(2906002)(122000001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qdAdfHXA8MQH2ECx0/5WpooeBAnAFerjZuWRaPBCFds5OiiIWAQQbf+AEHHx?=
 =?us-ascii?Q?EMkhMqSAed6pss+TqRBlwFsmNrEu+9fS1k+7Y1ERFjwiRiSYXWmLTGtIJVeF?=
 =?us-ascii?Q?RCT8VBQQ8uvWYeLgLUN9C8VOoL1CYEiNEhAgx+mpschS/uqUjahFr4Kwe5/Z?=
 =?us-ascii?Q?JZyy8fyW1EZW9U/zVqEb6TK8mGPwiPWPIizuNy9JmRTx7vaLjNtLHTJVZpbb?=
 =?us-ascii?Q?7pAyIhCtpItI6idYqr4pRujbpzz6eoRUG9yhAG+UmWMp0PnlFNAea+AjIg4X?=
 =?us-ascii?Q?bsCgXCnW+HD+gctQcN5rCGQmgD8CEITVagkw56857PkL/7q73PG3xzr0SEXr?=
 =?us-ascii?Q?PmfbtOSw3AUL+3sEzyk4NnA+jWU4OJ8F1IQnsltHxQMaU32AjUThZX89cWcp?=
 =?us-ascii?Q?aWO6uX4C9THEMRjt3yR6S+f8U9sHhR/DZoQsoqGF/eF7pdmTTUL+1j5KAHci?=
 =?us-ascii?Q?Mn3FpgIHFPzS1kwpe3iFRZe9x5GBqR7NFvjd1hfa/0RO1cvxYs6r7VRw5SsG?=
 =?us-ascii?Q?ECP2KKXJA+Y3OWqb8C89R+k+wzsR2Slm65xdXjcOl3LcgPP3/YgUVHOrZQdR?=
 =?us-ascii?Q?N6SugEAI02lQADnAesmuosYuTJS/1+lTygqlBHiYI/01sJtp9muZFzZOvDWK?=
 =?us-ascii?Q?QrE+AW2VKJ3Ne5LpkgWXI/1/jlCZuXgXb3K2Wz2OG0763ofiV9BPQbLu7auU?=
 =?us-ascii?Q?8GructW2pTEPy7HDTCB0aw2tB2Sw+IVmV5h+fgYordL7ZXeWKOGJdIgFUBoQ?=
 =?us-ascii?Q?8ue5T4WOCk1SrdooVwaFr85s9n87HenTC+Xmzqk0bzhcAKhupH05IVmBrqZn?=
 =?us-ascii?Q?soBeZf+zF9QpeHM9ixxzQTmP82ej0hef7TPxXuY6AuWLNuuaFYmfPEJtCt5Z?=
 =?us-ascii?Q?wRDuYOI37UG3yADE5rQBX7J8IhDugF9tn6xTqXExqSwgjjsfnvUKlrzXzG4a?=
 =?us-ascii?Q?UEylEYuUBCh8qIy7qTpcMdMD8StxbLHJwXYiyeRbXs+mC4Qzee2Jb4iDIrKt?=
 =?us-ascii?Q?UrVD494Is+YRHlKTIMEW4AxtfesPfCLijR8bayiKFjvC5uvsRCGjY150gHmR?=
 =?us-ascii?Q?GL11fJxErTUy8Adi9cmMQaImaodOp8yDo1xuRlccmvPgHLPe8hV4EBpRR6fH?=
 =?us-ascii?Q?5Ir7slVuMBU6W0UtA/Kou4BjXA+lDnEhEY08udkaP2tPobiT8iqIvntFXVma?=
 =?us-ascii?Q?BKZEfASZ6NW0aSOFnKVuJ3pZC+ET33R+zxGW8GUkoupcOKiBeG7VgIxubmu0?=
 =?us-ascii?Q?0acrxOyv7Aaj0aRKKlFyVqv77AqFU9Dt0XkQeBAwxoTd86RgJLzyOqNppNa2?=
 =?us-ascii?Q?VtdUmlR+kIxKAJdgQkmUv2mLEM399lZyeW4E0WefL8ZA76AC42+w5uvetsq4?=
 =?us-ascii?Q?08jNUCr8jKtIpUwb7T0h0iX4vNLa6pG/VzjuovYsBwXnd6JJhd00YgL4nMot?=
 =?us-ascii?Q?OsMD4naOm3ojXRpThG9gNwpK13SztbrCY6kOcHKqdYUopFXCO5Ah3WN/0yoI?=
 =?us-ascii?Q?3NSlZASZHV00M2KFX/6oklHN5LHL5nNX0+etgwl4VgUKJ163SmKyTR9I/f4T?=
 =?us-ascii?Q?Mxg5liTcI/rKehMNbnY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e64324-fe5a-4223-c4ed-08db186de5fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 02:54:09.2016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4ARqggqJmYA5fSGSLKe+SbniSdtDe7LZVyBvchnEbFeKghA6R/uNdSSE6K0K6r5iedzhipJKSsgVELZ2JEQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
Subject: [virtio-dev] RE: [PATCH v1 2/2] transport-pci: Move transitional device id to
 legacy section
Message-ID: <20230227025409.NALyUrRPBNA84TalbB-gdg-eI3j9tR7Lu4fvK1LXISw@z>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:00 PM
>=20
> On Sun, Feb 26, 2023 at 12:06:36AM +0200, Parav Pandit wrote:
> > Currently PCI device requirements section contains mix of normative
> > statements for for regular (non transitional) device and transitional
> > device under one section.
> >
> > Some requirements of the transitional device are also located in
> > legacy interface section which is the right section for it.
> >
> > Hence,
> > 1. Move transitional device requirements to their designated Legacy
> >    interface section
> > 2. Describe regular device requirements without quoting it as "non
> >    transitional device"
> >
> > While at it, write the description using a singular object definition.
> >
> > This is only an editorial change.
> >
> > This patch is on top of [1].
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> nack I already answered this. legacy sections describe legacy interface o=
f
> transitional devices.
>=20
Legacy device id of the transitional device is 0x1000 for net.=20
Legacy revision id of the transitional device is 0x0.
Why revision id belongs to legacy section, but device id doesn't?
Still trying to understand this convoluted policy.
Will re-read your email again if that is explained somehow without bringing=
 the driver in context.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

