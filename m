Return-Path: <virtio-dev-return-13439-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F61C04A94
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:00:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E04D12A88C
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 10:59:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D605E9866DF
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 10:59:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C7FFC9866AE; Thu,  3 Aug 2023 10:59:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B12D89866B1;
	Thu,  3 Aug 2023 10:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmIbEH78NGK3k+5JpxUIBKxATOevfeR9/CIlxQUJaZDwPL35w6lnHLcNLrKXaI5LxvSc/b9TIp+HoFx6qFJzehJyda6BHXISfIP/D6Rcvddl0WHga4qon0qOZpAp1AKKskV+stmmrb3Vr8QR/L2qD5RtG2K+S0JcKHco5Fw+6Lif0WvQbIkvoBA8MQXv/ORg0OoNRra6K2cv/yYsOY8XMaYYrJjV8X2+T4gh1VpD7UOUjrDnQBdwVW9DWkj9gBdTPBlEmmNNhJwVUo2trEXW3JhKlG9WpzABJWPucJBfdGmhSPo83OL8J5CMGXLK7tg9k6onzhpvnvnYQuEXwPd6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4QUJOvnoLlKZecppiQKzVKVQd/DoZQzWwBgHOXN5+g=;
 b=YSZdJOjG7KoRQJUikCzKV/VHM/3MUoBrL0uE5trdlxdK4q1nmuLQ6xDRJ4833OPlpLvBSjuz/Wpgs/enpt9K3P08pO0cbaBGBbEnzOsu5fi8VRSF5dinDT3aubPtmAhxh1Zn9HU7jhUq116TWXNkftMdSgCJM4F4s/xoLM3oS21aqfRQ1cO7SyhoGi/+1k3e5s/qjShQATCVDJcP0KIDivtay9wmDQQGEtQzvu77YGM46WZ5iOhJDHpoTmOL7+OGDMQyfwnVKqJtJrct6YFnpfs9+sqzB1dZTwsV5QaiCub+5xIFJSg+Y7JV1n+gYe/FzxCeg06elFBTQFBsux9MWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [RFC] virtio-net: support access and control the member devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkA==
Date: Thu, 3 Aug 2023 10:59:53 +0000
Message-ID:
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6603:EE_
x-ms-office365-filtering-correlation-id: 768ca541-da40-42e3-441a-08db9410c410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rWcUYKGPLhl4qSdueQsCJAEXLUPIPSMg8HtayeMzhnyKQKmaz+pWOKYXebq3OeUlw1Q4KNbxnthpJB7amoVnibGvBhUvY/y2qY0C+u2sOLjB4APXYEQhSmvqQRt0ZwQt6JYOvtejMWc411eGYbXqJkQAnCyozJ+CZyzDMpPQKqP01TmSvY0xwttT2LqJf8W9HG9K4fOThLGrZAjca5GFRqJnYbrAac78ECtqxsPraPjdCeMJrKWecCC6ZH4dLqW6cuOTfp/y7WoKYPzKb66HXwQ6aCaQMxe3yPcNm9tuswe18YJpJU4giboLokDewwEwVcY2yeVaXmmQG6w4TWf6wUaSDiDZ2oosi/rk5UWTQtxuYuJAsgdgWIb1ksGWn7WBphjzaFqow1pcEhDdYYSjSeoq46uA70njtq2LSDEtV2ojjXcuCBYzBdid8KzSOWj9EzrdeRCnpLKr8620++kVfVhqpqgs9DBXkW6j0EkHgUHbVW5U6BHIVue52hG7LD/hV+O69SpoSWaCCVoIoWHQZis7c+d+o66IDA3UQGZ/c8GtyJeeY3zpbQ9ubTvtQlTGqMzo7zHVadSUQUZEv+QF0QfucHqXLBIFaEULWdO5y5mCB0cgasg4EQgVUuz7vL02
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(6506007)(83380400001)(26005)(186003)(4744005)(316002)(76116006)(2906002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(7696005)(71200400001)(52536014)(9686003)(54906003)(110136005)(478600001)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ptBksTeVI0dHqDRtfLDhE/lMAELOeP33MKuFETTVEG+/si5vVU2MO3aOtjJS?=
 =?us-ascii?Q?daP2crJLZaoJQQHjxj7nRkh1MjKxvKe4MM58quwO5p9eB4d61KrdAfH+3IRr?=
 =?us-ascii?Q?h24sMOtXOQABvk5Jw9K1dYWXMj5hkfsj2/gmVvb8atFujDAMeCv2jh2bA9Lk?=
 =?us-ascii?Q?MPqZQfvUc6a8Cm2SMs4jdcnDkHoMl5qYtwOPs+8do2q6cHlaUFimDzjcJ3i3?=
 =?us-ascii?Q?7PhACUYc4jLghoMYc0a35mWJl2hrWeE/N+t5NW2hzbarGO2beXy1NV7L+dXx?=
 =?us-ascii?Q?mkhxCSLxaNIGRabshGh7jF+BGkDsHHszOvG7ILYQMLLl0zQg4VP2J2OQuKkR?=
 =?us-ascii?Q?4mZL+6cywX9PkugTogGKn/sdzdbRQsKtI3fRptd/Gu2A6voj5qttmnULDM8z?=
 =?us-ascii?Q?4ck5ThRjABu239n7Nmqt+wMiD07Xs2zzAydfT8g2qrWZCxK0CU8ousJ5LBg4?=
 =?us-ascii?Q?1ET74zqrFPk5zqyFI2bd1D2Grl+YSfPShitCZwmlpmwdeMXQUGyenHOM2rmr?=
 =?us-ascii?Q?wIwTaTsi4kpiQu4p2RsXGlM2yQHYIa/Zh3TFDgLlV3TEvNG5wmiC2ccaVurJ?=
 =?us-ascii?Q?Hf295ElxiVSwGSaABJjHazDTF89Q0dA0ll37lldckhChkfryRocrTCOB8nKN?=
 =?us-ascii?Q?TKH5mr7b0cUQeh/c2mwjanD8MoACZkCkS2+FMCGv+FQE0K9nPV2S97kxzeC+?=
 =?us-ascii?Q?PyVnFvi9y9L2++7OcCBdvlj47b8c09dBipVUjl4UL+1MciTi0u8Upkk+p5UY?=
 =?us-ascii?Q?+UDZ9pLZjCzFn0K4dVnmPixoRN8ck3Nf4VJE++PnSwcaskvbzv+4ew67N+HY?=
 =?us-ascii?Q?izLIggOOoVjTsSITX3hJnsoVkOit5e6xoBqeCDM9cLYWQRw5tVpe7wseZnmt?=
 =?us-ascii?Q?KVoOqmOdm7allJ75BDMkP4I4i1FFobsvRU45zNG6x/QJPndyD+uuuMlyQ9l8?=
 =?us-ascii?Q?e5Fdr5DOhb5CU1nrGw9BAujsDYT4KF0f4hZCJzfdKksnol5QH48ueDaK5tg8?=
 =?us-ascii?Q?sUHtiW/DvMg2OIqjNbDwkae7V/GGvi80UYLP94VKgg0mr8Rho4V9wQI8+4v8?=
 =?us-ascii?Q?pSGkIidhbEiJam01CwdlXOzIsMgFrZ2/uTDi0Anw4smviDKjflRbXoRD461A?=
 =?us-ascii?Q?JJbYCQUGnQI1T5zfAE0A3Cjljg9P5BYJh9OXE/QmhErNQPTWP4AS2o6KJyf6?=
 =?us-ascii?Q?9nSehsC8XTeFGXbyLCnDetKvI5vcEiVEHiTiG6Hzw2IIigSGLksfrLVGKC+Q?=
 =?us-ascii?Q?DPfFRmZ+FXDNazTEyUZ1OLwrGYDopj8C7o/jiRCho0jp56N9Az5w/c6K1aZP?=
 =?us-ascii?Q?WRV45HQOsRgPa/ei4QcV8krCFP7lLV41DVQ5GNs/WOtol8rx3s5upjZx1TWz?=
 =?us-ascii?Q?dSawtpqEHVc3G/pCqibajM+tnv6QdnQEwAhuDpb5X+azDu7Z85a5fBsOl1zF?=
 =?us-ascii?Q?4u4/tM53S3R6PVSW6Ki0mZy8Z/SZVNWL5B+sGuya6iM+J2YkonUn+hGW2QQi?=
 =?us-ascii?Q?TwtUUfxUM3PNxVutMMMoijo5dTaSuJJVBXNgkFe5j+Ag/CXQrzTR0/b4LAZP?=
 =?us-ascii?Q?e48ADJs2Fdx/g4EsjxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768ca541-da40-42e3-441a-08db9410c410
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 10:59:53.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koiVoeAJrMV/WhzuAlStwzoRvoA4Tf+xJbthpKkVWmf6Ei+L30R3xhZXtGluWzrTJHVlXEgPnUmHFyXKU67EhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
Subject: [virtio-dev] RE: [RFC] virtio-net: support access and control the member devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 4:22 PM
>=20
> Do you mean we introduce a new admin queue command
> VIRTIO_ADMIN_CMD_VIRTIO_NET_GET_INFO?
>=20
> Then we will have too much commands for net, block.....

VIRTIO_ADMIN_CMD_DEV_CTX_GET

One command that gives device context information in TLV (type length value=
) format.
One of field of the device context is device config space.
Device will return the information depending what device it is, net/blk/con=
sole each returns different info.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

