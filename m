Return-Path: <virtio-dev-return-12133-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C0CC77B6F
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 15:46:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 46574F3F46
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 15:46:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42B199865FA
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 15:46:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 358529863D8; Tue, 11 Apr 2023 15:46:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F57B98636E;
	Tue, 11 Apr 2023 15:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHTFYc9BtRiFSLVR5WaujY8NBxMoGG4go3YwUhos1pOoCGB72qfQWVg1RzzsG3Q0XAdPjjYddMXdzdJ5jc8GQ1RtRSj6k7dTSCQB5h+Bs1uC7dqygEzvjk3FJpIT6ZgJuLr3ba2chq8kl8w9blw4nMuj0g5/ri02nhoGzO3lgC1h19wWyJ17impsySBz6/5lM81o4xRB8l0lVBVGnpXF0NzkIdE7W0+JL8yauf6k5pp9hDutRTDtG00slckg3fabtepymuZ+Fesd1Cv1jH057jYObLoOT6B7rZdBV1d09KBLjIygZPust2hAdBOleqZDaNp0Oq0wckcVkOYO9dsy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qw9vjCc+/618S5F1WkEZiotOE/liTwgfpawjJMdTOQ=;
 b=hLXFVwGqL/vvNffYQhsFgExoju/KJ/D0bRHC6x0i3wewoc6h/AKQUcGsqmJR9L58LRaTiGUtN2W7nmA3XjXAMntESwgZIPZAvq5TXp17+rAo8CoeEC+S9J1WYazjeh7vepWs5SJFY45SDnfwR3n8cgMV45bllPHQzqxp6X3EyOXv87WL3NdGWAjU2Ip40C5fordaZ74SrTvmzG7jrngqVYnTxnP96xvxOjMZThyMCPnIfkmRUOZBaEGGyXDwVaP6g8rZhgMoBdyG9xw1lVLZCT+R2x0w0t1bfx6hErwP1sUKfGph9B/PDotNexMJKYgd3R1Hx0G9ZFjRmreRjaibFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v11 04/10] admin: introduce virtio admin virtqueues
Thread-Index:
 AQHZZj13Sh975GzMPkylhblJLNg33q8eCnyAgAaIG4CAAA69IIAAYYiAgAEltvCAAAcjgIAAHOaQ
Date: Tue, 11 Apr 2023 15:46:13 +0000
Message-ID:
 <PH0PR12MB5481F007EBEBE8BF14B55EFCDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
 <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
 <20230410092104-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBA1F5A746DA89CD6BF3DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230410160357-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E78E40F84BBF68687F7ADC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230411100023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411100023-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8245:EE_
x-ms-office365-filtering-correlation-id: f2e5e1ba-9e43-44b1-6af3-08db3aa3e184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dNQEIE94TvBvEJh8LBiDCabye687SXcuDgd9+XiB8o+4e/Npdv4s0EF4jifgJh3kwTsyGsEJfxNmqUGtRCd2BfQIl97rd2ZkZfUGDyG63Crf3zWQJx0J5BGDASjJS6VvSHd0uvmvh717Pgr+EoVzprQFS4b7o4OGh9Sq0mrDnRVAhqn0mRH0PeFwba5xodw9x0zQen8QY5bVe+qLwo9369m4Smpwh180QWPbWrA3vvcINdBvSvLcRQFX8UJ/WawtO0QLOj0NJb24JVDFwvO7Pqs9RooVrUiPSywcFNfHAne33FkGUTTaNszeXu+Aug0S/GxFF5QnPRsdvbplyilqVPKVBUnAov7QSNSdpZQ2bcKTSjZI4FTab5G6+wXgXhIFcN1wE8kTLJEcTdPqG2LqEbuqHZVMW64NZ1liVtJx58Sh71OHWi39KXtLRQt8Ez7q3YLNQ/lwPZogXRupgyNLWqKLEfEbS+WE+ztDXOq55AJqfmzoUFdgRHIOyeHRZoiGBRMqyVPWIaKs1wxIeAbdTxe0EvUhKTGq+kti6u0pWEGNj9w8S5KT74rQiMmQk4w2aM3Df7YoZ6KHvG3RGbsWnHv44wqOEMi8ejKvI4sEnWbhv7JTnloMXey1rsT+5frd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(71200400001)(478600001)(7696005)(316002)(9686003)(6506007)(186003)(54906003)(4744005)(2906002)(5660300002)(4326008)(66946007)(76116006)(7416002)(66446008)(41300700001)(8676002)(107886003)(6916009)(66476007)(64756008)(52536014)(8936002)(66556008)(122000001)(86362001)(83380400001)(55016003)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nFfyx4d8LVwAANfIzE993nGH6HpwXZDVR0EfQ5k77z12sGmPTZMitvxM3Ghz?=
 =?us-ascii?Q?v7dHi4dwbLA03t5qRPfG6VAx4MkvEYruHjnxKnDuZiScxj8OjWmhCpy5CjBe?=
 =?us-ascii?Q?pcuFI0NlHt4kbVACvZBQHUc8cb2zAgGM18QBVA03SmHQ+jADSQHzOTcr6k/b?=
 =?us-ascii?Q?2VAfL22c0ExI9hMQC8cNNmoDeqNl8OgOpx2Tdsq7kjyCM4WP4jAKFO8hQdND?=
 =?us-ascii?Q?hBB4k6Q6kb9VSFcNjFIPyQRUwJIhmH7ERFChkJqq7GYsNGlImo4iEkxs/K9L?=
 =?us-ascii?Q?YWMKh43Q/4L93CDkxBD4e1briajmQzOuC+PVrrW3dvTY+VlehhLqe52bNkyX?=
 =?us-ascii?Q?oYN/DnEoJ3c9iTVcWo9CSB6Ew3wtAJaW977cFxIYSvW2667rM3QIZ5JS/75c?=
 =?us-ascii?Q?VQ1h2evyGOAn0egK2u+xW6u621oC2nyCM5u55DvsBOhCl6fR27b8SRPwWf9U?=
 =?us-ascii?Q?OsW4QnjvB9SH9OVxzo84ULqPQCU32ttXrqP1vjwu2ganhoUR2JxMMT9O+pHJ?=
 =?us-ascii?Q?kWLDw8i/ikPWAH3DwT12yHtYkTSoKxaNwtb7Ib46UbL/vADTkhR1r2Ap6yVQ?=
 =?us-ascii?Q?pln3RC+SJloEAKpuqovIa9XTUAulEVKjsNpAEkWuERCiWTQxnMeLDMpFxuzU?=
 =?us-ascii?Q?vyPWJVRuCUYL5qeCvLv5ksInpQtutNStTR24JptsWbqd+OQmoX0Z0b3WYcAH?=
 =?us-ascii?Q?JudcCQF1Pgw+vpn2lZGIYS1zZOxM8W5Dj5HCHC0tst/EzzlH+UqmqkQ86y+U?=
 =?us-ascii?Q?0UB+34r3nBfTB6JmXSID6BHI9Pt4W2Ym/cKcl+vEAoZzmcsSfovkbldeSm/3?=
 =?us-ascii?Q?JqHM0itG55Ls03rvW5xxqf8qnrASty42DB3ir03IjClHTiDrqfZrSIZway6a?=
 =?us-ascii?Q?TbQJ9+uP7yGxZnB1zKS0Jg61Etd+DcGAv+bV0NvCft8luJdZ82Fe338wGe61?=
 =?us-ascii?Q?YYHCQPIAn1/VgEG6l8Z6cVS0hXloYLvHsc4mS5G82n9hgu+Z383H0MX45Auh?=
 =?us-ascii?Q?gMbweqZlPALLyT5G3S4adXRxwK/06PtbV4ZCJksG0A6VqojA61111lbCZLBe?=
 =?us-ascii?Q?E7g5QbrVWCrPaYRwElGd9OE60BvgI9fFhz/XZ7R/2SR9LflafsyiCHLSsKpx?=
 =?us-ascii?Q?YmwfV0CoE+kLPkSGd9bQblujchMLgTt+yHAepEnj83m8gjr3cuZabT0+kP1r?=
 =?us-ascii?Q?DeVj93Lc2ecoyB1Lj72AQWKnxC04StirIsOTTYQrAwPXxaZ5My0G9AxChMwk?=
 =?us-ascii?Q?OzROz4h4STztdMwNqAHOkBjSZIsb/iibVlQtGPj0yYGcz2gUp7maGyuuddyg?=
 =?us-ascii?Q?crHof9G2jbHPoR1J/jLJv7ibr4n9AJl/CPgrh3ZEa0DY+bKwlBlnCMvR+Hc0?=
 =?us-ascii?Q?Zw/A3nzqbuXab1P/bLRnwMbr9WHasfnAark0U+lcAu1PUzdK0S+tR4/+n76s?=
 =?us-ascii?Q?6Tm/pP3W/SWAPTczAl5EdWeWM+sRAxuwAJDCHgkemmIT1LgTVcIiyaU8wbcC?=
 =?us-ascii?Q?PVXZOgqPZAPYcYYNGhQbT4wdmbFwOXeEL1Ggh87bFV2G7Y3rdL+4XlQSGHUd?=
 =?us-ascii?Q?56DyoyuUlgiddMIUAXhQigi4/3p0jnpmjvOQUGoxysD5Tg2zZgzpAFnXKp+7?=
 =?us-ascii?Q?XFGeqZg2sg0zuW9LPepmF+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e5e1ba-9e43-44b1-6af3-08db3aa3e184
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 15:46:14.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x++JvXodlrA9KsV6j8DSIKBsLIJvNmOxKfyz/kMki7le/J9QU95c7oQlnklUtuPZyWnvNUA5j8C2JoGRmgXmpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
Subject: [virtio-dev] RE: [PATCH v11 04/10] admin: introduce virtio admin virtqueues



 From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 11, 2023 10:01 AM
>=20
> On Tue, Apr 11, 2023 at 01:39:32PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, April 10, 2023 4:05 PM
> > > > >
> > > > With my limited knowledge, when written for third person doing the
> adding
> > > entries to the queue, "enqueue" is suitable.
> > >
> > > Look it up in a dictionary.
> >
> > Queue is verb and noun both.
> > As opposed to that enqueue is not ambiguous being only verb.
> >
> > When "driver queues" is read, it needs tiny more efforts to realize tha=
t
> queues here is verb and not plural driver queues.
> >
> > So, without strong opinion, enqueue is preferred but it's up to you.
>=20
> If you feel like this feel free to change all of text to enqueue.

Ok. Thanks.
Will change. AQ series doesn't need to wait for this cleanup.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

