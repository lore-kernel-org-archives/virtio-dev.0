Return-Path: <virtio-dev-return-12699-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACE5C77B75
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 18:05:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06F0C2AC4A
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 18:05:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F21059865A6
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 18:05:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E64099864EE; Mon, 15 May 2023 18:05:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE7E6986509;
	Mon, 15 May 2023 18:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUePe9TgbE+LxY4fIY8hGci8uJgOwRZh+JQISLySssnfTlqm3U8SHnz/kG1O5jVIH5bonW+Xh3V/N78g/CPqrFvQahbeAqnqc1jnsO+5etHuVouPa9Y80WY+eEzh79EA1qZBBNpGbG/czdB8wovYoPxN8be/y7nlPFkJBhxSo47QngJN67c6vGLnd+pplFmcNk0CVIzeiis1TiR60yOanc8qisoiR8IGDQJcIqS7hdiqGlgTXPUp2IeOyXKBR8AmzxvfwmTdwbucoOLQf6Um+zCxbEjWhjF3QThkPkdg8FaFlvubtwF+M6H9qlyjg9pZHIZSyqYshdxTf9nfH4XdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+93GuKaQAOk8AjXs6z7dciAlqZwkDlzwLm2WfyEFleY=;
 b=g6MzDsySP/AteYG9XfWe453QHF5kdbw8ISA9EpNG5yayrc8SHq7RAAoo8MXx75/c4wS8LiKc0xOGwr1qQc2uio2j7D+QF4gwY047YtjYpfZZQrtLskGpHnf/Juo7opKcpExZVSGCHxHwTvUVxe7WVSf73uBuO2V9Eh/2L79f/N4CizqgXnqhyqs6CT1+Vmfr8ZiOKaruKSD7Rk5ruZX8vhPFnNf2EZgjdS5D66kqLjMnsrryBI+2bHFBxgZcK8dUrUus0/qRyPAi8VDIaB8hcyFVG9z6N2EJzRe903PyEIVw85mmVmqjgLthI7EFzrZ7dHvMdTKZDzyorg4F4EgIzg==
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
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAXjRYCAAIxikIAAJMIAgAAAtkCAAAKBAIAAAGNAgAABJgCAAABJ8A==
Date: Mon, 15 May 2023 18:05:33 +0000
Message-ID:
 <PH0PR12MB548129CA3921657D5D811317DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515135513-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481923CB4F23968C39F14D8DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515140052-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515140052-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7565:EE_
x-ms-office365-filtering-correlation-id: 59153aba-d701-4e7e-f33b-08db556efa0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x/CskQHpdLjjRzfXT2nQyFEP+yEnU1JBXt0KmqvgicBeoGY2iyCe4e6VvCZF5In5GYSjxnHyCPPdEBGXbj7LwTCOwku8CsTrJ9tRhoHSxMOas6FLULgJfUFGp6UmwI9XI6vxeB0JT7iV4blpB9Jvxiz6bk06YzRUKAxlzNu3i6CRtNxEeKNE8jLWZxRN7LB+hmCdD4FoRXyAq7YMWYNLgZOSXxnAs9swiz9XjY2aqm2tCiRhxIrJ4hv9ystwmodhNHU9cW1j1AHZp293DPCR6mmUo+7YurZO6UyumAcdSs0+5R0NCRiN5Qtz1EdcLFOLU2T1CJ2KatG6GNAokMz4wqZGSuX4z/EP5rK/4vk9n3Xk8+TVpDuEmTwDF8G55em+KIyF7yuVy9Cqo4qEBPVqQDfvRQZGtvJngXiPWr6gtZSBYZ4DzMd204/722AwgEtG/VU//7pAjuzBo8b3lJAFj/AFYSpVg+t61B3iPWAhr2A6leGuZP/waW4CuowEyk34wFApAn2ZolpAwsBb4nMTYBkC7stN1w70YMM9zP6eFYylzDtyPilffnC6rtyIthO1oUCbZt6KxJQy3jIQUHoZD5NZZA+raJtxh2VBQxR0xpVh+pVLypzhQcfqCBHICKFf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(186003)(38100700002)(41300700001)(7696005)(107886003)(71200400001)(83380400001)(9686003)(6506007)(478600001)(54906003)(6916009)(66476007)(66556008)(4326008)(66446008)(64756008)(76116006)(55016003)(66946007)(122000001)(316002)(5660300002)(8676002)(8936002)(52536014)(86362001)(33656002)(2906002)(38070700005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NHl9WdwaK2JVrAPsfO15dIIjVcZwrHFCbJE8lQdTP5g+00SOgR6ijhKFmnfn?=
 =?us-ascii?Q?5TptaxBb/0w08Mk3SEnadmlY2NDmG1QZVTrGhTv/uUttETvOlqMHX/c6gPxH?=
 =?us-ascii?Q?iyz7fA+px9Nir5ZzIIrGSzmBnu0BlVRIlMp8F5WkCLzJditnOTvmDg5GC8vh?=
 =?us-ascii?Q?j0kmI26JaQ8NLKPH2qufujYa1On7sI8UuoaGuqzsOT3jo5NX9cMe6Fv24too?=
 =?us-ascii?Q?V/QNUkiOXcipzgwj8M2WsWJcjbYFpRp5vihgDbdIHsaRS/ToYeUrVle/XEEg?=
 =?us-ascii?Q?3vmLyrcRD997S3Xit6boOccgdMMs9zw0WdJgXJwkpl2D9fmcxJ78WnScFMK6?=
 =?us-ascii?Q?FS6OyHuelEeUA00IVW9NK1YdwrOdmuH5kwqVx3lODXy7X+uwungus/gz4GeF?=
 =?us-ascii?Q?v0PMSmNN2pwOJMFJqBqdQOPFKOVVnTVQ4MEBq3IRYvDshzVTtp5uwqsvpmXW?=
 =?us-ascii?Q?8tXbfOFwuQ99q1uTsZcQemhUs1Pb3gAxM75kpt+DwQ8xuRvk0n+T14panCA3?=
 =?us-ascii?Q?TPj6W4Sjr32NjQu8azx8w4zhbfTBZJptcnJag6YO36R04yEbmUsEdRZLQKkI?=
 =?us-ascii?Q?IIthVeGodsCeAsjhRXR5VK3gdvmzi8nl3kzXc2p+f2BmTIZVXVLmNhmTSANV?=
 =?us-ascii?Q?SKuA5UVqJh+Ten/iHxTHUVJjHqm36Udk0kMgzu1AIHG1ilW6c3h3lrITQCcD?=
 =?us-ascii?Q?QVJQwEB9Rek9prratmZIkeFrAmdkZUtIFW8ODdlhoB95IWR7pl/wnuaZ3Rjh?=
 =?us-ascii?Q?hPZbexhov0CPm4W+CEhN+Uju1KNrarpThKlFfZfN0r9107qgCuZ2tpRRpnXh?=
 =?us-ascii?Q?m3BSHpgo3h6m3uj3pM/aHVdR0VW2LL+c5i6DWxbh0iqL4xw3hzEgK0QD0Qp8?=
 =?us-ascii?Q?rtvKtwQh+yj6OBqcwCkqF+aB652fqkF9DkOhH7BuNZ+9hCJxs2Zk37DLXx2q?=
 =?us-ascii?Q?UP10BV9n11hD2hLp6GjYrZO2wiLzPZjzpgTKbEYMqIqnz2eOGwSJRfmZeMOp?=
 =?us-ascii?Q?xwsr8Cw9oIhiHL3wHBDFLJDqJZBepH92hUrmC+MNjrhBA7PjBXMGV4I+ND7c?=
 =?us-ascii?Q?YBqhjPZPMvKfoHVtp/3VCIK4mgvk7e0QSg6cXTk/+hsYT/RTIckK+7DvwDCJ?=
 =?us-ascii?Q?SWNUvcaJih0JXZau8lpGUQzrEpZ5XrEihlaGgpiq2AQzfR+m3nUpSrwkR++j?=
 =?us-ascii?Q?OTYA2qNvl4e2LbF32FN1e3gqg4ekvKX1OqacjJ6MVGr/dgBmsWOFMOtk8nT9?=
 =?us-ascii?Q?t2rrTVD/hOHgeMwEPdYW77N4EOFb/JO+KoqnZ//s7UOhZZrPV6EZNZAVWD/G?=
 =?us-ascii?Q?ekf0TIxB8d3r0wK8GDjROp4Db3g9U3qJ2LP1WqUCsLxQmVZMVw9dNX/2GRQk?=
 =?us-ascii?Q?5Tm2DMwHpGayg9Y8KDeMJyP5ah5eTcF4/z3Xu+TKmXXxjh/UyxzwKAuKJeJ/?=
 =?us-ascii?Q?R1RuJHKaBS2iLEXvNs/iL+SmVIgS11tpSa4cbCxuBSDuxeMKsV7ocwhDzYWL?=
 =?us-ascii?Q?dPUYE8Flfi88uBMcImNHSRFAWB2HjQaHQqmroUBRYs3qNBuQdvs3GfKcYA67?=
 =?us-ascii?Q?D6hD8r7X+VjxuyWdLFeDGnVym1nmdKVnPCaKW9Ypnf9zaC5A9opQCJq3Bt8G?=
 =?us-ascii?Q?o+Opecg42N899zoFv8p8FNQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59153aba-d701-4e7e-f33b-08db556efa0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 18:05:33.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ9qdpq16zL7lYsJWqP5d6ZO6f3RFMMfXB8zy6mmsn/HompJ8wbupwKIgZohROcVvOntS8ImkTUjit682Cz8MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 15, 2023 2:02 PM
> > >
> > How can it be required if it not part of it?
> > I likely didn't follow your question/comment, can you please explain.
>=20
> VIRTIO_F_NOTIF_CONFIG_DATA is there presumably for a reason.
The discussion is for the legacy interface for which CONFIG_DATA doesn't ex=
ist.

>=20
> > > > For modern device, guest driver will access the device own BAR
> > > > directly with
> > > its own config_data anyway.
> > > > Should we reserve a region in the PF BAR for SF/SIOV device?,
> > > > should device
> > > report which BAR/area to use for the given SF/SIOV device?
> > > > May be yes, those are different discussions with tradeoff to
> > > > consider during
> > > SIOV discussions. It is not related to VFs.
> > >
> > > For SIOV it's a given. But we can do this for SRIOV: reserve a PF reg=
ion per
> VF.
> > Each VF has its own BAR area for driver notifications.
>=20
> But it is passed through to guest presumably.
Yes, so?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

