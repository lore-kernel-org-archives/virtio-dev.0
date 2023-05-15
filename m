Return-Path: <virtio-dev-return-12697-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04926C77B75
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 18:00:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A9FE127CAA
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 18:00:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C9149865BD
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 18:00:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4DB819864EE; Mon, 15 May 2023 18:00:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 335A1986509;
	Mon, 15 May 2023 18:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKEilHbOMXZONaynB4Y97RT8yk98Kw6llmX8+LwTxxH7rPAzwaSsb8rPnOh/ivi2hWmX0QJU66w8wYCO61XjjUrAUczbWqKigtoH7BtX76VbyIMSYSqGgMu6/fhwSZpBe05XoiTdwpsO6ruu0lctIpmcrMXDBzjodL4cWaik0waRzSvOpKfMbMGhPZlqK9eUyCTQgWs/QkxOO+9l9JPsRNl4I7lj4MMqQfemgDbZQFhTIT1wNY1c0f/XdjtMQUN2MFYHw0okhe1JlqD0+bzijMlGs5/HldvL0Oly8fj8hLsCh5R/5N32MUsubSF0kwuuIdXCMXGPW2WwdAgRO6m0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgntueyMhqqfQaCWQsZ+FI0i0p/XvpuGyYfmHTrDP5Q=;
 b=N6by4UdlylYlhZJidvyfyPjxzV9e+uRSswPUFR2BBhjnJZlb6Hx0G5l1PHQZ4vUHR6ClUCUgkTsgRe7sGQWkRjJr1e6qHt8NvF+ahDzNqu1hrgeo90qeJhmWjrwb5eoXEADhl5oV4yszpfr5+3GMK+SdmdWLahkVVukMa/96qeLzYh/+1cSrGJzDquKGpC9yfnOXpvEmDwtyt1Yd1bz2sItVEugIzF5LI4KRGIrZIFLX1dTZi8rQzACLptaXB3TWInNohYpCZAGlMfrQveCFkAVXcEeDuMpLIADuo2n6AYot8rq38x8fXARJyf2qYh368hEm/hNInmNAHj4IBc4YcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAXjRYCAAIxikIAAJMIAgAAAtkCAAAKBAIAAAGNA
Date: Mon, 15 May 2023 18:00:02 +0000
Message-ID:
 <PH0PR12MB5481923CB4F23968C39F14D8DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515135513-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515135513-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB5514:EE_
x-ms-office365-filtering-correlation-id: 45b43eb3-c088-4546-5fec-08db556e34e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q4kmDdJBUC57Nsj6D++70gjGOquz58p0irCyIgaftPi7CB4C6zM4yK8yz2B68I5I3pR3PkEb1029FO2CEwrndMw5MNm1Lp2TfkWZRB1ew1Jx1ZLHG72LSsVLqkLXyXYubexb/K0fq+8G7aF8x3NrPfzyP4UwJgp04ZuBpX6LhECbRotF0y5G5/zTh2QBj8zxBI52agq46pd+rbrIqh+Fo6dIayWFv2qXt/HHAQw7cm4Xxj85eCVgXJOHTtdVmHQtOBymc9auva5TqLgyYuPNJd4mMbGeBhZspLjg6zjMf0gut/O6cqTIpudp/Hzu3hpsn7AL9M+m0yHhzNEFlXqa72HeLMAdhAYqrQXtxDXQn5TMejuYr7oRnIgJVLm1f9qnvV36SiE+8+Z1NJEYoJ+J0RzqFmpjdfU4Fe4H1cNTTWCg+CbxEGOEuGvk+IrutaB70TzyAjbatfpRTmglflmfrznEnd9dW4uz56oXQe9vP88XVdsf6PTGTuuShcGr0stGhHcXIrzOddMSprdA9J0vGQ2NWeMIsmokTXivg9RsEY6ZmGO5sUS3bUUI0gYIdMOcZ6qtSJuNe78JuYgLMqNmSyeeberhooks2g6FgEy8pGNDll3mZirLBRVVJc1lXyCl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(83380400001)(7696005)(71200400001)(478600001)(54906003)(9686003)(6506007)(186003)(107886003)(33656002)(2906002)(6916009)(4326008)(38100700002)(64756008)(122000001)(38070700005)(76116006)(66476007)(66446008)(66556008)(41300700001)(66946007)(8936002)(8676002)(52536014)(5660300002)(55016003)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8NQBdb+FxAqpqpoFqL33bIZbQEesKPvy9ZUg8aUX4GlTpOi8d6VwVGIyUvI5?=
 =?us-ascii?Q?oevjmtHlKZj6pqAeRrHLulJahS7B5S5SiSpYyaF1vyxCH8kH5Iw2dkU4xQJy?=
 =?us-ascii?Q?lKMkR0C+o1ikYklSxbh95ArjGYtXoJlEAsgpllXtKOL0CEKulUPpR5uOoes9?=
 =?us-ascii?Q?218BmQVnCH68g3JTamXLzAn78jyNuKJ4yeG6LMcNpiB7xDE/jUHwVChhWdsI?=
 =?us-ascii?Q?NxQJ12AJ4orzMXkedag1lzVo+YLmbsIu7Nm9WYIJspsjsL+1LSlxIT5MkXBo?=
 =?us-ascii?Q?o7WUt80SgC83p/GeXNjDlxHy02F0auYZMFtNjvDfhIgOI7A0lTftzHNTiku0?=
 =?us-ascii?Q?TgbQj6guZjKvYalCvZAdyKgnCVZaIMw80BO18B4XJOABjUBE/4WXOPgkFqzk?=
 =?us-ascii?Q?qXmHrVHSj33xMF41wjuod0fZ+0Z/8r9f9bfwMxzJ8nKp8EhywHOQ4e4ouosq?=
 =?us-ascii?Q?DR7eyX9A5zDAn/mo6XG3jFrGW1/OnwaLr4ROgeOji2Ikc2zK7z+fAw57+Rp9?=
 =?us-ascii?Q?u3Cq9IrAPTir+KjkWakLEZo0YOUXcxTxlMDuC6tzeF65+AUbdx/JdJF7QLlc?=
 =?us-ascii?Q?WaYNTsn2DFuVYLHF4Rq7lJnbGF2Iuq06TTOFLQCmDLNEYFnQG028T2Sytsqk?=
 =?us-ascii?Q?01MTPNkcHO4xEAZOaoXEAeOBduq5tJbLn4xKRnVng0AkkdTwNbIKRgBLq/wo?=
 =?us-ascii?Q?qXPOn4mgC0DZ8ITzgTto8VkhF00lp1BMmqPvMh7IA9BLfZQgBuhIwwiZBl5A?=
 =?us-ascii?Q?Z9wgjvurswKWTQlpJwZvabrvRyt6ee9QeEJhaN5Pc1mI1RMy9Kuz26eucW11?=
 =?us-ascii?Q?5VkQpgK+wmDoinHZhq0hFTB7ULezuTj4geQnre3ep+USMC3HE271wttnOMnV?=
 =?us-ascii?Q?KH+XOntkl3gKizTTDUBcxOI8ThtGyG9A6ws3+smN+F0dAN1Sl1Y2jVTOLJ33?=
 =?us-ascii?Q?ozPj/AmN7fYcDS+hsSs+46qvFghUGcFNFf9Ows8Nuz6mmQ1I3JiNWY1fPRXy?=
 =?us-ascii?Q?34XNA2vlvK2qewz/oUbqg+pjLJ7ER6x4YEPtDW2lvxQ8iiUkKFrxuYvQZHwh?=
 =?us-ascii?Q?Th+vytE34tQaUkfaCYK23aqYLg46EMQUVr590hVOM5B8CtDASms22Qjpqmn1?=
 =?us-ascii?Q?Z5ivtqxYL++CHvxk/mhmdYdkZk9n4/JPQd+gjp5Sf1jSNBOLdMc/c14Ww45u?=
 =?us-ascii?Q?oxRgW90juWRpi2qUN3Z+Kw0e9pg/jZynv5VxyqDXLQ9B4jIaCHWrEUE/kiJ1?=
 =?us-ascii?Q?81C//8FiMuE+ieeDKqpzN49jfeuCUVKT8fcjdOeRcBbfwepO7DISEPxroAnF?=
 =?us-ascii?Q?sWvwNyx+SHfOOzzxp536em8+S/29C67RSKhqvEKzlJWvQTPJsqa6THhwHIm0?=
 =?us-ascii?Q?e7s2N+CuuXRWgPM1bZpWn9Jj007Nhbd1FYh6AG+QWm31MSI9Vt5UQ66AIwLK?=
 =?us-ascii?Q?SOLS63IbXM9UDiFvX5pFoD6WSiJiRDnJVQ+WWM7zeGrBqfh49BSiH/ZYTuVw?=
 =?us-ascii?Q?lwKxZSxQ6fqpFy7bE34i78cAWoQ62+Iw9NceiMNNfVPmj7T11Paq+TliTBAo?=
 =?us-ascii?Q?sm1uNLy05LIB6QrDgz2792PzaXP03Mtb9rX2i4VomtboyieZ8JUoIqD+FTmo?=
 =?us-ascii?Q?i+hF08e+mKa0yaaP3HqE50Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b43eb3-c088-4546-5fec-08db556e34e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 18:00:02.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cKLciBnUi5FQa8I5rzJD7PGPp8Z1bhxQxGMGmktBKCL1gLKzbg8Z6iB/vEM8p47qJpGu/h9Ud4y8YE5k/smRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 15, 2023 1:56 PM
>=20
> On Mon, May 15, 2023 at 05:51:05PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, May 15, 2023 1:45 PM
> > >
> > > On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
> > > > All legacy interface via AQ.
> > > > All modern interface access via PCI or its own transport between
> > > > driver and
> > > device.
> > >
> > > I am wondering however about the hypervisor notifications.
> > > Generally these are the most problematic aspect here I feel.  For
> > > example, how does it interact with VIRTIO_F_NOTIF_CONFIG_DATA?  And
> > > generally, having both guest and host be allowed to access device's B=
AR
> seems problematic.
> > > Can we reserve a PF BAR region for these things or is that too expens=
ive?
> >
> > VIRTIO_F_NOTIF_CONFIG_DATA is not present for the legacy.
>=20
> it is not but it just might be required, or it won't be there.
>=20
How can it be required if it not part of it?
I likely didn't follow your question/comment, can you please explain.

> > For modern device, guest driver will access the device own BAR directly=
 with
> its own config_data anyway.
> > Should we reserve a region in the PF BAR for SF/SIOV device?, should de=
vice
> report which BAR/area to use for the given SF/SIOV device?
> > May be yes, those are different discussions with tradeoff to consider d=
uring
> SIOV discussions. It is not related to VFs.
>=20
> For SIOV it's a given. But we can do this for SRIOV: reserve a PF region =
per VF.
Each VF has its own BAR area for driver notifications.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

