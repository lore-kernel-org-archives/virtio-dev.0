Return-Path: <virtio-dev-return-11315-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A901C64ED8
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 16:00:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 614382A826
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 16:00:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AE47986665
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 16:00:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F84E98644F; Mon, 27 Feb 2023 16:00:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39F02986478;
	Mon, 27 Feb 2023 16:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDiullAJW6jwAvh8KH1LvQuH5/NvQDhKlciURK4frW6pq6PPOX+IjcxiFUc6ghjRwm4YqNBsXhhUMn4vcwi0gzC9pTvrzTpo2hpc6adovS5YN7jlEWF8M3XQvczsXPB16HX0GJpkAOq+iDwyyDkBCn/lc9VpJNjA/KMlV6VBq2MzMsLArP6LQHo6RN9UvKWc0TIaCX8rdZqHDn9TcDm3rJ46vU3NkhJSPvvW4ZGP3wAMdU0f7NFfom1P8JMSrnQBkkkR8T7HVwFNboVooWKW3WmJHJfTKvZ5c/HC6XdTx3i0a97j0BdWwp95Np716aRroJmRhqS7VGP5tM9aX8WSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXTJfmIDUyHhOi6ueekLNLNK7laCVGHJbzsSX5CJF7Y=;
 b=CubaEDgtFlSMriwfPn6cG2a/j4ld0eOLZ1wfwKOudpt+IZK2Uj8Uk1dnY+U9c3GD/RbEnlNpWgZX6WcZrGFDbwozIofYRIpVU6Ogki2PPLbjtJ/3tlw0HnusDXLiL6u387UvDR6T0xQFlU1/MCY/RbDrjm5L5+U73jCAQy2q2hx3XgMSwec0oShPItBMNn4KbFEAS6Xwz3+xN1b7FZVRRVCmBDoJhXauhlrOh3oMbakY0LZ0kDYeRnYQS0SZCeDWZ6CuImto3EGCn2hVqwgEvYnU3oEphqgWPTCPCOPyfEegLYdyEkrWmG4UP1NbIzp1jULmVRiJtMagY5AIzhG62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 0/3] Rename queue index to queue number
Thread-Index: AQHZR0pAxGvxqZYuNUuHEK6ngQ2mvq7igR2AgAB41TA=
Date: Mon, 27 Feb 2023 16:00:24 +0000
Message-ID: <PH0PR12MB5481CA831447E7E7AEA46A58DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com>
In-Reply-To: <87a60z5wes.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4181:EE_
x-ms-office365-filtering-correlation-id: ef843976-c864-4588-abce-08db18dbbc6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 537OmhqsETRZK5kh6/0VAGolWOUV+slz5JqcAkNcCPchuTsz6Twd07e3cfnRi547tp+GNN8JzUYnyRTrpALAC4/DSy19kSdc0D1Q5HOLZvSYoL7B7G20Rp6hQcQQBsegLkVbJ6xzBxUxTD87L2ASwf4bw4DmUQwfp4mUqMUzOXNe1a16Wsk0+F6C1n5MY571buDEpKuo7wfFAgcUBhGV7IyR1HjHtBNIqvEB+fq5xnkhPSBezpq2XgTj4Ix2lbLtVIfVNTA+bNj3M8YrCf8Pfl/IxC6sFG3CnjlZe3eQE+fWFZ0TFTZ3eWKC7gcae8tG7xEgnR/jDeuNvO2PpwWkQ8yXyA0seArw1n7IL3IF3/1S/yPFAVUAnJYKtJxjMdtpfH2fcORKIJasAxJja5fBtwLvh34FsSR5b7B+wlFE/LAUasQCcleB5Xs1RgyJwZqqOM6qsliBdBDjkvxPYQ6IIe7OoQHfwKFgNroGvEZfj9tpCsX/0lWpNorDKX0NX81HzOypEVFB5jXKc9cFFzM2xWr7qrum2R4AiVEfp1v5SXwzZAH8ovGCaRXN6VvQTZzZzKoYzUuq13VDBpePhESLVxlj1T/9WrCXFh7LkdXgQkBm+qmaAKci3+x0s4sCKhzwz7SzdPwL5f0SXsy6IN92k+dpcOpk0CvC1SRpBXJr4oOem5fN20f4yDgZPnxSksZF/MleU4dF4Rv5BffCSo3wNt06UnCRLmWIawFsuwgmC/mrRfHP69JbtGsaCaTXZp9kGypwnx4u+OvgmSIM0hYdbMrH0gzjduR1S8X2v3i76VU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(33656002)(5660300002)(52536014)(86362001)(55016003)(8936002)(478600001)(83380400001)(107886003)(7696005)(966005)(186003)(71200400001)(9686003)(66476007)(76116006)(6506007)(66946007)(66556008)(38100700002)(41300700001)(64756008)(110136005)(4326008)(8676002)(54906003)(66446008)(38070700005)(122000001)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YqMK7udrjziNxCv9b6zMheRjQGxWsJexeaiRH1uFEJqjEaf+im9Idw6BjxHj?=
 =?us-ascii?Q?ViF7PZ8clNr44YRfeAVj/4Y76hhQ2YtNiGKjHuEg0DPpEFN5QwyPPyQFTYek?=
 =?us-ascii?Q?zHdxLbpq6qiGT6Q80P7hQOJTbhSpilWoQUxCYRicilBZcLKvWm50Vua9lrsf?=
 =?us-ascii?Q?nk1kWdtVGfrTtivmj/o8FG3PdZ8uXH1zLdAJGwkU1h3nG+2nOwgxxyjaAfA/?=
 =?us-ascii?Q?auEXQ5IlV57q1Vvcn3VT9iHO5EPyceZN52SjgCncMLQ0dPv7UfuZQ/CeJFB8?=
 =?us-ascii?Q?UXSX5A2EdDJ8950Ebh/3tN9TeNEIieyEwY+d9gWRgbRfeoOfevx6fj8puHgz?=
 =?us-ascii?Q?9Tip5QEXeEwi2jdRT+EZwOcZwfZgOyOwQbGcu0fJ9I/8ncvm3J3gwWtwp3gG?=
 =?us-ascii?Q?0S7UBrDkLuZLYFXHlpRmvG1H3UHw1bHFMY/aVwZsxkyTy+9+P/ZmmFX1BYW+?=
 =?us-ascii?Q?rwcFDcdJU9Tk6id+RS5ktv9p/12lrmPqiagiZmiEIJ3UMJiXQ+imDH/munju?=
 =?us-ascii?Q?cpagZQ3wdx78wLKuM0AWHRYYhgIXsoicAR3q4TbOuzu/8nkBPqw/q/OcZjin?=
 =?us-ascii?Q?cwWcDrwH/F9gbLJicMrfDnoVd0zjmLsNO9Ve7DMf+gMgSeHljYIOg/1cCZ2p?=
 =?us-ascii?Q?DgPQN1WIcKCJ9T8zA6tET3E0mjNZMmhJjb8IErNNDY4K9GVsOmcU2qNTMg3Y?=
 =?us-ascii?Q?IG3mkI8xpQsiBnEu9uYTabRrU71aCadZoEskY2ZVFsEbnadpNcNnuKX/qluX?=
 =?us-ascii?Q?BnGyJDfbNOKj/NtdivEzgjlV9eAU33lBiXiCB1Rsh0gtXHbpg5N5Go4AO3jZ?=
 =?us-ascii?Q?xFXctn4prBLwH50xwFfdzXGmYGV/4dGWWO+/8qjrAzyxSY2KJXBSiFcVvOjN?=
 =?us-ascii?Q?Odlvy6eIuuc5sQ0klY7if2JQ0a2whG1mfh8WXMfKN5yUXyrcYutXuBouutgW?=
 =?us-ascii?Q?jA85NOdzP8eV21tiaDblKeacqVisK3l1UwGrbQLAeq8MRx4R/1/cUm/N0mL6?=
 =?us-ascii?Q?cK5kTl9VO6zD9bsU6JEhbV45aPYOstbkTxqlWYpC3O+GXBc6zHbfnyrVN7AI?=
 =?us-ascii?Q?zzpj9uBIN4Nw75rdkaZ59Fmzwki49hooiLYXrYPhN7hStEU2W6OzUV/d/bTl?=
 =?us-ascii?Q?smLQ4r3LvTLX4AfGvlrp8QP6oPOhGJEV7b6FAPFF9FPpGzWPRrPGnugRq4Am?=
 =?us-ascii?Q?CZR7SB+vIwhTbWhll5neJ1Gd7n5eyPcuq5MtOKLE85Z+YRsqm7im/RrszdUS?=
 =?us-ascii?Q?+a+P3Q1uABNHP5l/JRoUFQI1zf+suY9Cwc3/QJt77+jKr+yyjVwzUvl3tqlM?=
 =?us-ascii?Q?sKfuQbgjCLeVknimdwR2Dq227TDB4OHJtx4ExFgMc43/B2lgu+r7EwNX7z2D?=
 =?us-ascii?Q?qha3K4CjfoAp+MtRxglFLgO0J7ADmy5G20DLQTbSNMQZLydY3ttuCqPTQ8gI?=
 =?us-ascii?Q?8QN1rxbCDlGwTvseAFHv7lvRx2Lvlh0Qaw5Bpgv3yV2+wAVEr/YcSEldicur?=
 =?us-ascii?Q?YXIwTg8CMxVpODsgZGdVgc0uBWb3J0oSB6bBznnlLC5xuOas+9w5QJY8kZv4?=
 =?us-ascii?Q?LiXGWEEAS+oDo3sXNQhEX5v1QGK7mizF2SSgeBrXCj0mVRoQLIKozB3VPlf+?=
 =?us-ascii?Q?gBQ4Z6XWZW+GhfSWgZv8IeY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef843976-c864-4588-abce-08db18dbbc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 16:00:24.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gS5NZoKQCson7JIU/navAgqY854RmN48S5MY/2YcT1g7Hk+OxeR4Iy5duKH9bkRYZC0mASn79/DoqUD2c+cmlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
Subject: [virtio-dev] RE: [PATCH 0/3] Rename queue index to queue number
Message-ID: <20230227160024.omfLRnLRtqXQaMNtpMmRtJ7Z8ARu78iJkGcF-X2DnPk@z>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, February 27, 2023 3:46 AM
>=20
> On Thu, Feb 23 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > 1. Currently, virtqueue is identified between driver and device
> > interchangeably using either number of index terminology.
> >
> > 2. Between PCI and MMIO transport the queue size (depth) is defined as
> > queue_size and QueueNum respectively.
> >
> > To avoid confusion and to have consistency, unify them to use as Number=
.
> >
> > Solution:
> > Use virtqueue number description, and rename MMIO register as QueueSize=
.
> >
> > Patch summary:
> > patch-1 renames index to number for pci transport
> > patch-2 renames mmio register from Num to Size
> > patch-3 renames index to number for mmio transport
> >
> > Please review.
> > This series fixes the issue [1].
> >
> > This series is on top of [2].
> >
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> > [2]
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
> >
> > ---
> > Cornelia:
> > I was not sure about ccw for vq_config_block and vq_info_block
> > structures index field refers to the queue number or not.
> > Can you please clarify?
> >
> > If it vqn, I will send v1 by replacing index to vqn to be consistent
> > with other part of the spec which also uses vqn.
>=20
> The vq_*_block structures use "index" for the vq index/number and "num"
> for the number of buffers (queue size).
>=20
Shall I change it too given the below response?
Or ccw sync is not very interesting at this point?

> I'm wondering what terminology we should standardize on. For the size of =
the
> queue, we have queue_size, QueueNum, and num. Calling it some variation o=
f
> "queue size" and mentioning that it refers to the number of buffers makes
> sense.
>=20
> For the vq index/number, I'm not that sure that "virtqueue number" is bet=
ter
> that "virtqueue index" -- actually, I'd prefer the latter. We'd need some
> renaming either way.

In other thread, we discussed with Michael to use vq number to align to the=
 following ongoing work.
1. existing spec=20
2. future patches that he wrote for AQ (v10)
3. VQ level interrupt moderation patches (v9)
#2 and #3 uses vq number terminology.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

