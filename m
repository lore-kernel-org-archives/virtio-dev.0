Return-Path: <virtio-dev-return-12395-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B217CC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 04:10:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 153142CADB
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 04:10:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE7DA986656
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 04:10:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E1A9198642D; Tue, 25 Apr 2023 04:10:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7B349863D7;
	Tue, 25 Apr 2023 04:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxM8uLuXV58HAHnp7Xm9VFQ2nYtHquWmJwXikBqErsshqQzWj4JYdhvdr6E5aWuVwy5yjooE8aXrh69u5fwhGAAPiB5ueo+V1IhA06aLxUX4SMdIzgpiLsF6cz1JU5zBx3fKWUIROTkkj1WjxvX+y0zTjJfpigz1+W1ea6PjL7m0qOkRbRb0w5jmj92Ousof0qITEjp18pvdo+J4olhDPrQfkrtif47YV6bHWkUgwlxZ2ExZ1Ak2NbTOpa8QzIIogcN13XHeZ8k0b3Hu4B4QxIgnDGw9gL4bAo4Y8X6UOAtjTCYlR2bYCuAOr67i8jiGqJwHT/NGxqOpQSZxgGA7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6HDWKs2wioN2Xie68tvvWvn78Lh799c9hMYYmU7MJI=;
 b=JdtEWzKrkx96+jonMNQhDHS6pCHvKK7kNFpurnCTga9JcXGiOhyzvpLs2IiUsjKnPeNjnh0jg749PKWfmzeFbGeRVdGHsP7E4yQHQviP5n+Hx1gj4XY3CQb4FvAXbelbI63409pdzFwyJ/A92aDgLEg8WZ4a4VFprKSvKwMC1LnKYJzIZ7NQkEIpqD7JuL51wHNzSI5WSsLnHMnZ6BtlyPUX4DD7pTU6qpii8piiI/oU43/KadYwhRAXpOc0974EtMBKsz6e8uN2va2yOcyV0v004IumkmXs3VzoJD2nQ2JtWMZuSjcflWRHgOl27hBX6X9YGztuckrXwh/jXexhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v14 04/11] transport-pci: Avoid first vq
 index reference
Thread-Index: AQHZcmDc0+RjFXYMYUGy1LzDFDzlLa86fMqAgADywlA=
Date: Tue, 25 Apr 2023 04:10:00 +0000
Message-ID:
 <PH0PR12MB5481ABEFADC3ECFD93E645FADC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-5-parav@nvidia.com>
 <20230424152919.70254ffa.pasic@linux.ibm.com>
In-Reply-To: <20230424152919.70254ffa.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7932:EE_
x-ms-office365-filtering-correlation-id: ce586b9b-12be-44d9-e8b8-08db4542f0a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dyR8fZvFsnmDLf6BoRECTzrT4k7B1YbnzBNHVtjYO3KtuxvdIVyUqVEXWW0MNAF++CE5KaupotXwHGHAI7hE6ZOrSd1S3JbW7YZuTxEgBfPvPZhWkQ3Zj/DIbYHoFXl62mA6rPBBukAIwzgen+a3ues/388RGQmAxQo+alXlPspwzidqJoVQkNZUMv8Dbh9To12Xr83+8lgUtDicR13/tWnoYDzOtSL9VWdLAf+2CbpgLlQmkM/Xs5f2F2avoVvYQXdAK+Z2IUM24GFfaJAtywePwDK4+OK31P9LV3txFLp3cMREx3WZ4F57/cG2UbLHxgAY9SFlOR35lVWgM96/7KboUU2f3yLDH8VUm2TA9cwz8BPueHDih+pH5Wol9+1gr1fxmCHnmoOqBnrqkbIzCpVODICLug6FIYJUUm2m3mAkCNjd/xVtMp6SMi9twcePd022cNB6hCECQCqHK0FMq0+35t6ZUxFJjaXtrl39T38rMBxQ2HtKGtFzJKpQv5XspFzBFsacKe40FBoYyhIVFmnUCk6IuZgFzinEHGMxBcKXvxcykahMmyV/YHrm4zvDOyOPDlqZEeDejWK/TfVOymh9NLyL6b+m45hHPQ8VkKWSuHuN+au06HLnGYwjBUHS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(76116006)(2906002)(66446008)(66476007)(66556008)(66946007)(64756008)(6916009)(316002)(4326008)(52536014)(5660300002)(8936002)(38070700005)(8676002)(41300700001)(33656002)(86362001)(55016003)(186003)(9686003)(26005)(122000001)(71200400001)(107886003)(38100700002)(478600001)(7696005)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rpsz7Pdg4gTw995nKet4vqjFsFSqHGC8McNFWeSRs6zwUo4+FsCiK3HZ4i3F?=
 =?us-ascii?Q?H52vZU1AdDbNwd92lHjTYc0JW0Q4lqTbcfl46Xf2Ldw+hckAqZ7PPEpaoPoY?=
 =?us-ascii?Q?/CYKDE7IO5Zi/5+aqVhTdMB7QAltq9juqofRHroypdbvGBk3F59MbHT/R1Dy?=
 =?us-ascii?Q?ngtEqi+j8PrkP3wCJcr3yg9El0Bu+eUavQIie+G/WLw1tI0wfFJ/f1CiY7sU?=
 =?us-ascii?Q?oEaarbA/r2xzQ0RcWRCcmarSXHI529SpSowEqOFn41ldKWP/8yh4Fsp8pUwt?=
 =?us-ascii?Q?5V8A76+gcQ2IZWS+4JQZt02pyoG7U5u7d9+2L5TTl6mDn9ck0ZCHB3NIkV/n?=
 =?us-ascii?Q?JUANSVcpppz5K4gL6aCKAhZWPUI5T7R4cAs8jv4d7qvk7C+0jqGqrnrWVY6z?=
 =?us-ascii?Q?YE04pUd0Gfe9OIrjbCRjYtGJG0rFwfg69wtpSdQIZRrBsqO4WJ5rkjEggVi/?=
 =?us-ascii?Q?+okXFMk30cnyfeLIM8oyMEQPCx/GyrgqCNkOS4duTg3nX7RP6LsKxW4/us9Y?=
 =?us-ascii?Q?6tw+LBExjPHIl4ua2eA5cZs+F8N5EPNUi+ZepMtSiQkAwRSTFe/eRgSK7/L8?=
 =?us-ascii?Q?++cM7cE9n+q9Tbyxi3HjhVLnyqhK0DG/JPGSehOBic1lGwJRAoq8vUTeoEmA?=
 =?us-ascii?Q?UYUt46su0BStRs+oZdzeYZCAoMob9HRFNo6wnHOjVmsw1RWT7JcI9qlutSGR?=
 =?us-ascii?Q?1qcvxtCfpDo1yXXIric4fY4Dogj/FD9hnev7zf1ysnHb7dcXZLNX7EFKMGAh?=
 =?us-ascii?Q?glXDqbtnLB/13RfPTU4d/Vb5knAkTfpI5x9oV84ctKcPXTuc7oXaMGZuWIM+?=
 =?us-ascii?Q?169acI70UxIJWPXaj324Unfzh8a7PQnxPKzAW/+tt/IwmFqO1eA/1H8hBnMI?=
 =?us-ascii?Q?mhAiX/dsvgoPQVqtSXbbcEjTye4deboC1SRQOigOR85cvnP3mQKLtMURpnmb?=
 =?us-ascii?Q?Gcx2vW7c1mji52zFNl9pY+AL9IMiu/vzd/jouJXeMs3LPym0xjwrw6r0bH7l?=
 =?us-ascii?Q?YjUSvXXB7QR5l4v8e+8o0EUaTnFI+zZHPy3Wd9Zv1CHGC9pUaygt0NVk6syI?=
 =?us-ascii?Q?VFd2Y1M5b2TCAL1CvIjEpQ4/EAkZI4ByaDpjy+QHB1QsWjAIMniFAvg5XoEH?=
 =?us-ascii?Q?uvhE0mgmM2+lPV7kLoFVgN9MNULBgZHsh1ZZA/VJgsGwpag4XTiyPAgaE9kh?=
 =?us-ascii?Q?uJBUHvQU0DpD3e8N6hizcJCmNAKss6Qd4tOGhtHetPxk0BueFy50wyPSXY88?=
 =?us-ascii?Q?YxcKSh/EWqUIC08lG8iL7ST4SAO0ecb9kgS1svobnX2+KariOmMghjau4+Yb?=
 =?us-ascii?Q?jHUTI5/S50vgiA6+HkMkEC690H6QfxZVLDznlXQWq+8WfXRT+D4aUk7ZOnjV?=
 =?us-ascii?Q?foH1ZcVcrnwSPatCHH2hZvZN6Y9E+Br75mwlVjJc7iRPhf8f2hYqqO3Zpq2g?=
 =?us-ascii?Q?uMGaYEfPzynFv8afZg9KtvJg6ZgymsYto3us8Q6XfXtCN4EVUWeStsqKR1MN?=
 =?us-ascii?Q?xMCO6+ZcCH477xkm3fcp/XNmamYWAYy427AGkkUh6OyO7VU5jXSmjulalBXV?=
 =?us-ascii?Q?hQor/pNyWyB+Z4gYTzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce586b9b-12be-44d9-e8b8-08db4542f0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 04:10:00.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QOs85iaazZgIuhhxkxrzZG0hgkBEkTAZWbFGJVaWvCEhuEjH4TZ3moLuCgNRuP21xcuDg3hp/ZpoPuKI6F9yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v14 04/11] transport-pci: Avoid first vq
 index reference


> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Monday, April 24, 2023 9:29 AM
>=20
> On Wed, 19 Apr 2023 04:46:32 +0300
> Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Drop reference to first virtqueue as it is already covered now by the
> > generic section in first patch.
> >
>=20
> TL;DR:
>=20
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>=20
> Rationale:
> ---------
> I agree, what a virtqueue index is should be described in a single place =
instead
> all over the place. And further improvements can be done on top of this s=
eries.
>=20
> Discussion:
> -----------
> Is it indeed covered now by the generic section in first patch?
>=20
> In [1] you state the following: "There is nothing like a zero based index=
. A VQ
> can be any u16 _number_ in range of 0 to 65534.
> Number can also start from zero. So zero based index =3D zero based numbe=
r."
>=20
> I don't really understand what do you mean by this,=20
Like you described the vq index range is device specific and it is already =
documented in each device type.

A driver can choose to enable its "first VQ" located at vq index 2 for a sp=
ecific device type.
So, for device the first VQ is vq index 2 instead of 0.

PCI spec wrote "first queue is 0", this was little misleading how driver an=
d device see it.

So vq index starts from 0 but it need not be the first VQ, that's what I me=
ant by above line and range description.

> but I'm afraid it is not
> consistent with my understanding. Can not be any number in range of 0 to
> 65534.
>=20
> Rather in general it depends on the device type, and on the device how ma=
ny
> queues it support. Let us call this number dev_vq_max. And if dev_vq_max =
> N
> > 0 index is associated with a queue the N-1 index is also associated wit=
h a
> queue.
>=20
> Let me also note that the number of queues supported/provided by the devi=
ce
> is a matter of the device. For many devices the number of queues is a con=
stant
> given in the specification. A Network Device tells its driver how may que=
ues it
> supports via max_virtqueue_pairs, Crypto Device via max_dataqueues, and
> Console Device via max_dataqueues.
> The transports PCI also has num_queues which is documented as "The device
> specifies the maximum number of virtqueues supported here." while CCW and
> MMIO have no transport specific means to tell the driver about the number=
 of
> queues supported by the device. In any case, if the number of queues prov=
ided
> by the device is N, each of those queues is uniquely identified by exactl=
y one
> index from the range [0..N-1]. Furthermore the role a certain queue plays=
 is
> determined by its index. E.g. for the Console Device virtqueue identified=
 by the
> index 3 is the "control receiveq".
>=20
Sure. All you wrote is correct.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

