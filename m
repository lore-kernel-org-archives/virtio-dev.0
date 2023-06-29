Return-Path: <virtio-dev-return-13162-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FDDEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:26:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 567DD4290A
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:26:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49022986709
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:26:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 37E4898413B; Thu, 29 Jun 2023 21:26:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F8C2986677;
	Thu, 29 Jun 2023 21:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLKdYR47yVDzqu+d8j4HUEv4eUcuCSgQ6rIivJVFv3g5NB2BubUyICqR+jQzrrhXzhwmnI4mYy6gyG9GcUeGBicboZEdd6hzabtOlXCWZOsV1veWv3QU8vzsSfM5scdEK6vvA+OErImli26lc8B1F55V+zFpdSRuTtHCDh5dW/FMeRLQYSeByY9+uiExEAO16w0xX5u5u2GMyqugVJP8/8YoXwVARc+DtWIvT5K282t+TRcOs+3AOn4JQ+UCbnrUphsIIWBLQmkpyGQQUCjECIK9/gsAhab6D6LdvC166kCN4tuKCxCmNl3KEWXw92aYA2nVP2RIWQ7J5FT7CSId4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb85QdDz/Lt8Ew/V3+Jh3/EXhbtSWEayf2AMKhQfLjU=;
 b=l2BJsCIp3mgGmd1ag5Q1CRq51E/NLbFqI2nRt2FvtiPmiD9vGJZ/qfv8tzYHG9V9r+DgX4ypAVRVOPAY2TBenic1gxnRh+GNiJP5Cg1XiqgKRYsvXvl7TFXUzzvtDlNs9omEql7Z6kNRrsqv7HNXaB9Yc5l+zdBOEqNwa7F6WEbGPLoZ8+NPxSFUta+FB52pJUA+MPytlX6k//O3qJ69GGQ6JmoBJTaMCFauB+3X5r5bb5LQWdxOrBZQE+8GN+PZSA0y502WqJSSmBlX6MJU8SCDu/yZeJwIT7Fu4ufdVF02rG4iho95KTCkCpsgiB8yMxSoKTXqYBDdcf6xar7Row==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v7 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZqTvss7QOWMrqzk+6ekRzXD35Ma+iNGeAgAAYaMA=
Date: Thu, 29 Jun 2023 21:26:03 +0000
Message-ID:
 <PH0PR12MB5481D453B751068CCE6C68C6DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-5-parav@nvidia.com>
 <20230629155022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629155022-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6983:EE_
x-ms-office365-filtering-correlation-id: a5ead2cc-baef-4232-42b6-08db78e77165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jUndKF7/Gu/OhrU0GnWsmmIP4U6HQPLvPv9gcF6WtCNQfSyhhfVw2pRNnvU9bUObO81EQwLaB689y2xPgcFLjgdI1tG19Ytl2nuL7SDfD3R5vURmYy3eD0ZJf54D8t7r18fb+zbfh8HwRb7y7dya2Z+bSQsUwPloKZ9yx4k51VjzY2ijqe5+pak0/c6xQ6TXw8o67gZufZvUZf1f8LSd//wa48uH0ntqPu7dsABH00xr/Z9KBEvLxLbv/ACR7A1L+3Ran5Zs3FK7LdtIWgUV5zFgWLt3bO/ZLGkXpkmmSP/C9BXZPw412ekKh0DaPuAVyAVQiRKWF0AdOIxcEnCnz4eutzi5jhQra801Ek877wEMltM5TtN7FYGooWGBiL/JxrE7N0X9U9jJhVnuJT+T4z+WtTBYSQfKuFJo37gQDeZi8abxcrLm12yqRgYXUQrIQr7b7wTE4BW+0p1ddvZFmicMs4pTLU6O7hJAYy07lneGlbHInCCukPOuIeuZq3qEHsNn58xSNCTBbsWOIxV0kezwCZ6fRYL7O3JFrcQgfoOzfaRjmvxEhJgY2lxnf4HUDtXWcPJ11+abgnwKt/NIxlol0UYuFQ0dctJrZOfTkc+42G7UHsXR+xBhXCwRfqRE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(6506007)(66556008)(107886003)(71200400001)(26005)(54906003)(83380400001)(7696005)(2906002)(186003)(9686003)(478600001)(33656002)(86362001)(64756008)(316002)(5660300002)(66476007)(122000001)(52536014)(76116006)(66946007)(8676002)(6916009)(66446008)(41300700001)(8936002)(4326008)(38070700005)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aL5NXw5dgMsEVirhWpgayOLFFHsZiozCMX1t/0wEyRPBsq2CUS/jy6HuA1Jr?=
 =?us-ascii?Q?VHuXi6glWnXNChkOPSLH7Z0Ea1uLIzZb0cUv0Se2LKF+irZA1JgX7/niK/Kg?=
 =?us-ascii?Q?NDckN+wH4U/X6KCodQ0vbxiL0E9ITcgLqYl63C/nNtYosp2edUovhg6mIQlR?=
 =?us-ascii?Q?CGXe0xptv30uPZYngJOxPeLV32llaAt+Vfem9jRYw5VZJu/OVZjUI7eE0eqn?=
 =?us-ascii?Q?mP2xsbJQssmZpKvSGHwMB7Ry3MVZF95M5Z8SOSW0pWXOnwGvgJt4ERekfCV4?=
 =?us-ascii?Q?egoMwAscKR+SFS8yKI+ynGeYolOzuHHWIRpRwfojipfQA9BrJiUJ1T0TX5jQ?=
 =?us-ascii?Q?3CiwlerUSEScSeLpzAMvE7Tnagr0n7IuDKHbtK9oLEX+xfTgU4KZeOWj4JcQ?=
 =?us-ascii?Q?hovDWQJ18EVJRbhksiX3c1oUPExXU9MbAB3tFH+SIyqIdR50Je8Gpkm27BWd?=
 =?us-ascii?Q?/xm7U/4w0AcXpVZuxeWY/h4kGzb4KB4apND68CuAUl2cwTaYdl99bqotPNfV?=
 =?us-ascii?Q?cLRHgmtG/v9sTN7gN8XU0ChWRCCdPCb7QGUFtHkAZIg4Go21Lv1IhEN/MqqQ?=
 =?us-ascii?Q?8OMVCW9e+hl5BV4Ei0Ikz+ABHpLIkkne9NXtBAo9PAh72shv0bXqH0M740CE?=
 =?us-ascii?Q?/6mKMibzvECtStZm0QLzdYbrmkByxlTJ+pb5xpDW4zuAJq7yjLiMDfGpMQsP?=
 =?us-ascii?Q?IFBqV7aiFUdwRBc5/ejWlQUppyhhUru5VC5R3SbYwNsZUckxCqdrSwKoBptS?=
 =?us-ascii?Q?2+oTdSYSAf6h/OXi0osBC2gJcvDNh0srRZZcu+95d5jw6LSMEMJwoVUbT9F6?=
 =?us-ascii?Q?1zhgKsOD12BBSlM7nBQbYDZuZJ26ibrM8j9oyNkWzJmu3tgsS/mct47L6Fip?=
 =?us-ascii?Q?o59ov88q8CUPgRycHT+11Ez+hbh1si5cS+dTwjSjIy4hvrTDyE1JBDK5+LJ+?=
 =?us-ascii?Q?qhPHjpEWB4myKgL7IR7Jd7lYfAryak/1X6u3tR+g35ZzI+hoPfg4xykg5GsS?=
 =?us-ascii?Q?Acjtre/ATqMSiD7ZuoEKfmmFa0ecrnmbasx/mDbY1C2z88T768/dfd7kqf6l?=
 =?us-ascii?Q?gIFbUE9SMoDC0IvSk7i/bF1vBmXAla8NIdZH1Fi0opcRhQWByEEXRhjucZd5?=
 =?us-ascii?Q?mMGl31X/teqqD60n4pXfJwGaQiV/99HyAW+567H/ZHM5H8/31rFluvdo2Y3d?=
 =?us-ascii?Q?A+1IZYtwzmW4+purDOY0RAtX9J3hU/0JKmcG3HSfllPH7rxqPTMY8btolLO7?=
 =?us-ascii?Q?UQoomofUHvtndHjYASSksfWlMlcPsDaCAxfL6lsO/4S+aB8+un7KHt6Yig+z?=
 =?us-ascii?Q?5TvXZRlkmViUiNHvufDpIttrYsc7XCzxNm0nEJSqPy0n+S1qHaupW4YJmiqy?=
 =?us-ascii?Q?T8E81Q44R4d9WWtN2Ml4vRnGvZ1SlGpmNiNjKCNTkFqJMdTKIRUmt6MAQ0hX?=
 =?us-ascii?Q?T7NqF9CxbdsTbZt/9RxqGCmJKo1ex2gjhA9JfyMsTpk+bZlxEEh/bU5BJho6?=
 =?us-ascii?Q?7xSAL/BvyXSXNNwiEZcN9q99qGD7Cb67DHqrOq0vCIqLaeElSPrMMAxtPy/2?=
 =?us-ascii?Q?SkudRfxjyiGFMWikeIw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ead2cc-baef-4232-42b6-08db78e77165
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:26:03.8027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xuBpPQxxlKYVODBh40/sEHCbCmabdoDUi0i4Kv277yKHn1Ls04d+aoOnofV5wkMrofcOzDu4uV4US82/jo/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
Subject: [virtio-dev] RE: [PATCH v7 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 29, 2023 3:54 PM

> > +In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
> > +\field{region} is defined as following:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_notify_region {
> > +        u8 owner;    /* When set to 1, notification region of the owne=
r device */
> > +        u8 bar;    /* BAR of the member or owner device */
> > +        u8 padding[2];
> > +        le32 offset; /* Offset within bar. */ }; \end{lstlisting}
>=20
> Is this just a legacy thing or somehow generic? If the former please stic=
k
> _legacy_ in the struct name.
>
Yes, let me prefix legacy to it.=20
=20
>=20
> > +
> > +The group owner device hardwire VF BAR0 in the SR-IOV Extended capabil=
ity.
> > +
> > +The group member device does not use PCI BAR0 in various PCI capabilit=
ies.
>=20
> what does this mean? what various capabilities? VFs don't have PCI BAR0 a=
t all
> ...
>=20
The PCI capabilities listed in "section 4.1.4 Virtio Structure PCI Capabili=
ties"

> > +
> > +\devicenormative{\subsubsection}{Legacy Interface: Group Member
> > +Device Legacy Configuration Region Access}{Virtio Transport Options /
> > +Virtio Over PCI Bus / Legacy Interface: Group Member Device
> > +Configuration Region Access}
> > +
> > +When a PCI SR-IOV group owner device supports
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> owner
> > +device MUST hardwire VF BAR0 in the SR-IOV Extended capability and
> > +the group member device MUST NOT use BAR0 in any of the Virtio Structu=
re
> PCI Capabilities.
> > +
> > +The group member driver SHOULD use the notification region supplied
> > +by the group owner driver.
> > +
> > +The group owner device or the group member device or both MAY support
> > +driver notifications region.
>=20
> why is this text here as opposed to the other file?
> But really I think for now it's easier to just have everything in admin-c=
mds-
> legacy-interface.tex
>
Because the owner/member flag is in this structure.
It was too much to split a byte out of a structure for the spirit of keepin=
g it generic.
=20
Most things are in the admin-cmds-legacy-interface.tex.
Here only PCI specific structs are located.

Do you propose to move above=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

