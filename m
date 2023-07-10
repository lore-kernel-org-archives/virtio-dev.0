Return-Path: <virtio-dev-return-13328-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C7CEB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 12:08:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 55A1F2A88B
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 12:08:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4410E9864BA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 12:08:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F2E498645C; Mon, 10 Jul 2023 12:08:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18713986462;
	Mon, 10 Jul 2023 12:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY6ElJsMgOkzlRalW3yZrYaxaZQba5u3G7aOzlI/lD9nXxxjNKaVSJEQpXP0n++pTUewljCXekeANIsOVNTbtfWmIxplb1NAk9LKfcnPDeRyIKYIdVi450+230hy2PAod9blANSLQinbmS+3DPig9XWd4lRKx7ZE2P7Psk1xDgwDPD1mvq3r3TJl1Oyy/BoGh8M+KNSz4YY4FqEtyylsQo8VZ+ilDUYoacrNgnhX9V/OOO29kKAoJfYuiiBENU+wl/xXefpxgvlWRwTjoRfcxrVT/LBD6/LceI6RFZnYCLHgqTNf63Z0oSFp+ZoYkX9PMm9EyiUKvRgv/FqHSkCBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syJOP7YPr5kOBbv5AsRXZZQQpX5UxqCTVV224W7P9do=;
 b=GFD1NIymDOHQ7HKKWfUsKNT50GUjLyGI8dYFtDczOlFr3BtiKryEgTKDGmxU1IilhMEJBMdPkcf4UJnViz94on+kVgcv0kdNPoEbKtpEabeEAuUFMxJMmILsDlkdAwqBTagMqhBQh+0IzhmOyCgxhbBQlfweI1JuJb06wTdp9kMu9mtvxxQ7hQCHU5E4B6Py2NyacS1qdf6PIzUNEOiDSTs2ufsMsHBfPqPtrVXD0RnQhwAiIfhSHEhdnzWfW1m328MMr+jD8eTJEjsrLJftuPlyMe2vFU7xZCmA3Yjh1MrkAQAiS10MmJ5Ck1FZw3dO3Fzi/Cpzp0ZDmp/NCQwkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] [PATCH v13] admin: Add group
 member legacy register access commands
Thread-Index: AQHZsOgWDJbZS5QbLUum6ujYtKcWkq+ywpCAgAApwkA=
Date: Mon, 10 Jul 2023 12:08:00 +0000
Message-ID:
 <PH0PR12MB54811FFAFE03F215F2E59E26DC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707153019.147039-1-parav@nvidia.com>
 <87pm50yumq.fsf@redhat.com>
In-Reply-To: <87pm50yumq.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: c62090db-d07d-4f0d-4f1a-08db813e4e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pc/FxGVLbAAvYrQzGNSQvBppy1FwJA7g3geX4yd3Al5qcwoYndK0K86hqcvnJk5DgaO7pMj+K4LrhamNHsPafsJu8Uzhvbms5XwJJUbi2JNh/GnatSXFLTyoJcZ+TH0OsOHGslv+z28Oltg8ZwNmUwK34FP1oEMgaAkNAd5aaawz+EM6ajBLhxKLmAy4Jix9V20Cav+y3Q70Pz07qzkcg7RItXF41Oh+Vm3ZVZo1T26MFXPvIgwM5zVAuU9JQe/LhEA00fIhK86e0FSj+p3xVnRwRJH6Setwf5shcxj4pl7QDM/P69vDRcdkcpyKf/KEYIKVX91agxtCcPZFj7NbvYWPSQoRXwRxFQsS/uRM3QoWw55itggIe1vIeCMFEh8/5Lctv5Ev33YNFxzY92ewBRIlMKPbqnYFCYciViDNRofL0bCsicWv1OaFpyengpXAYCYpZZxHt8Kgg4cp68uUZ2n1mHMOL+3aQ7rqSNoTeXbbr3k1U4UBZNVxOhrgjbC6rjyJPaxIjgRGEQd73fWhCrmq2STh2vMeEmNIBtprBuqQhzBDs69c4rDX6niyKmlFHExpaMcW/UNKNArCfiazh7pHlh9TGDUPUxn4aR6twYeMudEMD3hMpGXY6E36hIk7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(7696005)(478600001)(76116006)(110136005)(54906003)(71200400001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(66946007)(26005)(6506007)(107886003)(186003)(9686003)(38100700002)(122000001)(8676002)(64756008)(4326008)(66446008)(5660300002)(316002)(66556008)(66476007)(41300700001)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nEeu/uyn0CsSPcU/TNfZoC5nKZ9hUIbYg/zZQTznrrJY2EElmZDH5zewl5CY?=
 =?us-ascii?Q?/KW2ii0X1sm2fJvIeEUhfqXkLSZ8t6gb5D5WlpHViKkUDBqNFlMPtokKpfxP?=
 =?us-ascii?Q?Tr0qN3Rviz7Lw6J9y35qHjb3QGLFN/6VPoYxyWBDj8e/BJnIjmkzb/HENfsF?=
 =?us-ascii?Q?jlpdUB9xlVKxhthY45mTt51L8rbncL0uxtg0rQ0nhqsL2rUGPHw58cbFPV1g?=
 =?us-ascii?Q?A99+E1p2QhfsXb0u/38xJrCtWCSH7U/4/Z9C0lXziDqleJiqgnV4CplD/MHP?=
 =?us-ascii?Q?C1U2d5BaONzStPozYQE+n7j6qf/BIbuoYzks9MWzNPJoUBpTUfypAP2Ian1B?=
 =?us-ascii?Q?MwCIZVWkpSIjUZFY0WncHgWeYhrAJt1kPFXecmiSUIgdLzZ7wwW7Jra/xyXk?=
 =?us-ascii?Q?3Ta2E0h2H0wLpGAxwj0mGg195cRDDUpu9ob2yZgBbLqS79U5bZjbgBBZnS3V?=
 =?us-ascii?Q?yL1/Ggk/pLSXK3ZeqC6yQKzXr1t27q7B2PrOrfNyTeiscuKY1bTyEBqFQqZI?=
 =?us-ascii?Q?l5cf4CzjneQjWPZ9UQkudbsQg9+p69b10PXtdHJvNmm+OutO6JPq/9HuNJi+?=
 =?us-ascii?Q?KxVLWdoWwgPsbqv8Q05Vsh0C/crxwJLZ4JRZMoP8iYWD/etoz59fB6+HTgcw?=
 =?us-ascii?Q?HmbHpB6WLVr0yr3N4KLj48MGdivR33XcF1jodqN6dTEYyizChE6VNgBQkFyX?=
 =?us-ascii?Q?/PNNRgAu8q/csa0+hcAc+iVxb91/V7aT7YSxHoZt80hL0O5lGJRIj0otjeGn?=
 =?us-ascii?Q?aUPd3TrZCjrZnK1C2jg4vttuAAZDGr+nAiAsF1vWHk53Z+qqjrOm7lVDvQNi?=
 =?us-ascii?Q?U3KaBJedTUW+9g7Zzb1NJM6WN7sdcNlYs97Gz+8zLbyFSFRM/fDvoIGJahAv?=
 =?us-ascii?Q?Qp9haZOm1FrITz3747ErpqgdYvVoQW0oDuodWR6BMLj2PBy8ABUP71/s8KIl?=
 =?us-ascii?Q?fFl2O8f8wayTCj4aRBGPKUgwL46SIhO0WHoGIowfy0AzN7/pyoF8jX7hfX2W?=
 =?us-ascii?Q?dgcfs7v+2GJCay+3NBDIbD5DqTX4DhC0SOA4X1EyPqU/9RsT8q6ovjQp8hWL?=
 =?us-ascii?Q?LuafQ9Xr8qQf1ktfGB9PB2c23gwHGk9YHg7sSW7+jevA/BS/dryEB6rMKVA9?=
 =?us-ascii?Q?tcv3gVvABk9y+ZlV70+rxevgT+tdhYp7i2DKY2gLvdzWwQtfBOL6rHG8CZV0?=
 =?us-ascii?Q?LFtkyCDJbH7y84I3r5qwlmxXn7/nSvEjJOIusIHzzPFlg2KADV9FcrGf826o?=
 =?us-ascii?Q?O3iDGwKDgDsQfJt0qI5arW2Ij5oVo2KkVJn9vYzOgkTqXUzu47HeMVhstVT/?=
 =?us-ascii?Q?dpHHgsibqYLvhE2nbcUD7qFz+ChfGrL5tqBOMLlxt/XF3ga+1dYaKOwP461n?=
 =?us-ascii?Q?4LaLTOjGbCt2bViUN4OHcA9VgNEED/WGG/fBkzYOSeYitz/y+oWp5JmeOvdP?=
 =?us-ascii?Q?n3VATVCEdNneLzRMQyLH1DIn+KWsqU3j1OTaDvsrtt/vuTte2fIxgfrTfQwB?=
 =?us-ascii?Q?Lq84Q1fzcOn99e6obknxu4qakxOMhnAOeuwO5MkyNt1u8tzcQxDHYh2cQe9I?=
 =?us-ascii?Q?ky5pl02xcIata4al47E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62090db-d07d-4f0d-4f1a-08db813e4e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 12:08:00.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TG25U8d19Ry6zjYhRtfc6Bp7v5T5wc4xN01+cvPHveTYl0nOdE4jYsArAtnPI0knWzEt5yWrAvBJB+/RqgLEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] [PATCH v13] admin: Add group
 member legacy register access commands



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Cornelia Huck
> Sent: Monday, July 10, 2023 5:38 AM


> On Fri, Jul 07 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> (...)
>=20
> > +When the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> command,
> > +the group
>=20
> s/supports/supports the/
>=20
> > +owner device hardwires VF BAR0 to zero in the SR-IOV Extended capabili=
ty.
>=20
> (...)
>=20
> > +\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a
> > +Virtio Device / Device groups / Group administration commands /
> > +Legacy Interface}
> > +
> > +A device MUST either support all of, or none of
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
> > +
> > +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
>=20
> s/For/For the/
>=20
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the device
> MUST decode
> > +and encode (respectively) the value of the \field{data} using the
> > +little-endian format.
> > +
> > +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
>=20
> s/For/For the/
>=20
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands, the
> device MUST
> > +fail the command when the value of the \field{offset} and the length
> > +of the \field{data} does not refer to a
>=20
> "do not", I think?
>=20
> > +single field or is not completely within the virtio common
> > +configuration excluding the device-specific configuration.
> > +
> > +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
>=20
> s/For/For the/
>=20
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the device
> MUST fail
> > +the command when the value of the \field{offset} and the length of
> > +the \field{data} does not refer to a
>=20
> "do not"?
>=20
> > +single field or is not completely within the virtio device-specific
> > +configuration.
> > +
> > +The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE MUST
> have the
> > +same effect as writing into the virtio common configuration structure
> > +through the legacy interface.
> > +
> > +The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ MUST
> have the
> > +same effect as reading from the virtio common configuration structure
> > +through the legacy interface.
> > +
> > +The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE MUST have
> the same
> > +effect as writing into the virtio device-specific configuration
> > +through the legacy interface.
> > +
> > +The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ MUST have
> the same
> > +effect as reading from the virtio device-specific configuration
> > +through the legacy interface.
> > +
> > +For the SR-IOV group type, when the owner device supports
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> > +commands,
> > +\begin{itemize}
> > +\item the owner device and the group member device SHOULD follow the
> > +rules for the PCI Revision ID and Subsystem Device ID of the
> > +non-transitional devices documented in section \ref{sec:Virtio Transpo=
rt
> Options / Virtio Over PCI Bus / PCI Device Discovery}.
> > +
> > +\item the owner device SHOULD follow the rules for the PCI Device ID
> > +of the non-transitional devices documented in section \ref{sec:Virtio
> > +Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
> > +
> > +\item any driver notification received by the device at any of the
> > +notification address supplied in the command result of
> > +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO MUST function as if the device
> > +received the notification through
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > +command at an offset \field{offset} matching \field{Queue Notify}.
> > +\end{itemize}
> > +
> > +If the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> command,
>=20
> s/support/supports the/
>=20
> > +\begin{itemize}
> > +\item the device MUST also support all of
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
> > +
> > +\item in the command result of
> VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO,
> > +the last \field{struct virtio_pci_legacy_notify_info} entry MUST have
> > +\field{flags} of zero.
> > +
> > +\item in the command result of
> VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO,
> > +valid entries MUST have a \field{bar} which is not hardwired to zero.
> > +
> > +\item in the command result of
> VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO,
> > +valid entries MUST have an \field{offset} aligned to 2-byte.
> > +
> > +\item the device MAY support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> with
> > +entries of the owner device or the member device or both of them.
> > +
> > +\item for the SR-IOV group type, the group owner device MUST hardwire
> > +VF BAR0 to zero in the SR-IOV Extended capability.
> > +\end{itemize}
> > +
> > +\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a
> > +Virtio Device / Device groups / Group administration commands /
> > +Legacy Interface}
> > +
> > +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
>=20
> s/For/For the/
>=20
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the driver MUST
> encode
> > +and decode (respectively) the value of the \field{data} using the
> > +little-endian format.
> > +
> > +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
>=20
> s/For/For the/
>=20
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands, the driver
> SHOULD
> > +set \field{offset} and the length of the \field{data} to refer to a
> > +single field within the virtio common configuration structure
> > +excluding the device-specific configuration.
> > +
> > +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the driver
> SHOULD set
> > +\field{offset} and the length of the \field{data} to refer to a
> > +single field within device specific configuration.
> > +
> > +If VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command is supported, the
> > +driver
>=20
> s/If/If the/
>=20
> > +SHOULD use the notification address to send all driver notifications
> > +to the device.
>=20

Will fix all above comments along with other comments from Michael in v14.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

