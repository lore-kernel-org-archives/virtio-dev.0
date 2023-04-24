Return-Path: <virtio-dev-return-12360-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3043CC7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:30:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6C16D44343
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:30:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63DE498643E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:30:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A8EB98635C; Mon, 24 Apr 2023 15:30:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47B8D98635B;
	Mon, 24 Apr 2023 15:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR0kkC3LWh1yYt1N8ZoqdInaOsNmQZFRH66XkzIPWYP8GGRQhUJl7JK0OF6zUjzYMExgv7WlYdthe255A2tM93lqHGLumxOieh2JsXR5lOXD4bShmIbYbzB14rEewWWpqQDJfS5kFkuulLOTH4/He8MO0rTatiqUtv+BtafovxMG5eg7fMD7YlWErhpnRFluMumQVzQ2haZ+9ZzpCpMaXWUYiwoorCJbNOCDuKyyRPKavy/E8Sde9uE+puVoJwwbVB59TURqI5Hr4NILW0L/7mSzxvhaPJJmThPl4mqpxnrUfE/oS7Q5+2fJUZI9Akekc9nV48MSM3IKMY6ylD7dOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6HCWd330iJ637r1QRcLKxBE/k8hX95N35wWIlmm968=;
 b=X+YtqVesmO5+A+qulbjrQp/v84/suMwY+sgO0ZGijF4cKz+v/kYwL3bk/j7QJl/I2V3z7e2YwzzFKfVUJlSPZ7TxggU9i1wKjv+Shp/UcdlhCIfy2HtSlEgwc1n84kpXMGgf60r4Yox+4fwQdbJ1+ngdvob1xEdXxMPHaW0cmydTm+A9jZeKm9SjdvsseRTAPZk/6G+PCg/UZ9BG/tzTfORzwQi07uhaie31qX4ZwoA+PkM86Dp7co34Ztc/JoXHTi80Af/oNHWAs7CRYvtm4E+73br342U+ZHwLe1xWbfZ2/8KRFYV0zfNPU7D1j34eJ/FcxLaH6GrMBjQDGc1nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id
Thread-Index: AQHZcmDe+hgtkWplfUa2ohK75caGUa86eteAgAAKKwCAABhd0A==
Date: Mon, 24 Apr 2023 15:30:33 +0000
Message-ID:
 <PH0PR12MB54818907C4A9BF2031664166DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-11-parav@nvidia.com>
 <20230424152221.54c44489.pasic@linux.ibm.com>
 <20230424094202-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230424094202-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4222:EE_
x-ms-office365-filtering-correlation-id: 71c2743a-5d14-404e-c10a-08db44d8d899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M+bg117xryxCkRDqDTzVcbG6RLcbJ6IavGAtqZav+1gU1WNq07YlNXHaJqIfFtmURIsyRgHJy0nt10bv2u5tITO76fUCNdTm0hugIzZHE1tYYTZxJwa0ICesiP6fG6CDDy0HnVh6oSM/1+rzm0OwnVOeWi5fy2JxlLG0S1b0t4vRRoGd9raFNxWz6A+ZlJLv/yN3DjW22q98YfWKByGnQ2lhCYWJW9a0CmQhZx5LwA/uwulc3osaDRm0duCwrqgaSmf726ZstgvXaZurg9G//oFgGPIDUGMOrVvfPU15iX48MqzDXaPrwomDrnpJ/aPAj0IRIItQ9ahXByt1YeMxmI8SU3H74lTjAlWZJgrZSGhr14Im8vhV88nfHkHpsAMaHJ7mpq9LriD1JgCVRw9O7YWRrBBvPWIi9c3NBpJPydHrEBAJe8ZiJpo1IL638VeE3ZXCJpfhtenhuB8qJojaeMYWsZnXr1zr8AsKL5shYp67OSL4ezWxwOxJq9f9EtG+W7a5zxxogkcR+jM4+55PiWZhifoGSfQlhVr8yV8zVEurC60chJV1HE0dVkxLED7Co9SsEnsiXbgN36m1HDfO/7p81fdlC0YNNl+pSv9sEqxuHiFYP3upBaW7Q203l7k8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(110136005)(54906003)(86362001)(107886003)(186003)(7696005)(26005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W/utDP4t/LbhF8idWAQXeOi9h0tSYoq0ZT8Kf5v9h4cOYssBy8XwLL/rqVJx?=
 =?us-ascii?Q?tlF/ERfAL5SePmATSRRYgy5S7jD53mIgLxfE6caRaaZJZwRvPPYkbB4EiC+W?=
 =?us-ascii?Q?7JsAg/GETc6wgeJoSYGWOpEHZets27KkEY++w2J0Wxcbx1QiANHoUK/lgod8?=
 =?us-ascii?Q?MDLmfgmVUp4RVDBuktLzoWO05E1MKYS8RHsKrk35VTuMUN+UmUr+lmBRSN3N?=
 =?us-ascii?Q?gqYm9fZyUrx/J70qJPrXhM/C2/ymurv3GThGdgoWI3RjJWDtEov1GdXqKKdt?=
 =?us-ascii?Q?WuMpx5y4TgOoUakI2R+ENJFaUKrWzZzLTr8ZJgIIcjxzmxuTsaAVQodi+0Tt?=
 =?us-ascii?Q?zXzcNs6CB6PdEiqNjMSIFgXhV4Jc3SXy0frKO2pJBmHbY1TBBLIpA75VPEI7?=
 =?us-ascii?Q?yckyYQ4FbC9CoEBEsanOaFvcWWL0ydgFR938deFPWn+wiiFBfwPWsjFwsZNJ?=
 =?us-ascii?Q?KkcJyb8NPqVIzmLc6HlxAjHG7UzP7/kE93BGthelNTyqmuNjpwTpzYLk500+?=
 =?us-ascii?Q?w3mUqjyizwjNT12NVt+JUNLy00LWOngxBLqJ39TMVNXcN9r0wdC8BJD7GZpQ?=
 =?us-ascii?Q?8yLs4DgjlgwNxtxEUcvfRAySmok1aUIUZNEI/X2BrqRHcOtUSk1l12/F21R5?=
 =?us-ascii?Q?MRAc6morQloJ1wFg3exSLA8mceG5qWzoEigJqQ8FZZ6dxnrhrUKvIPjK6PwJ?=
 =?us-ascii?Q?18MMTG2p/EwGBCZHDN3i6xKWxGZoJCz2PKKXxQ7XOLUN5GU56gCZnopoChUv?=
 =?us-ascii?Q?hOP1RdUeWGQsP/ISJAvKsrA02cKfEGq8Jx9Saeg7dmNeoW/+yK5/yILtReMG?=
 =?us-ascii?Q?8iF1LC9osubTVksVG9DUhLGYcdwzs5lkYPANkNE+p3rlLAbZApByRJ67DEJO?=
 =?us-ascii?Q?BXwyyxAWJHAoL02EAUSPP1DSmRM/cTNMY5O1nMQjcsGRaCkfkoo2aDqgm4J8?=
 =?us-ascii?Q?jpmzc5UaDvmEhQn+QPyKdI+n+kIOHuBi1KM9VDk5v6pqOjvhWvZWw8m7I5OV?=
 =?us-ascii?Q?NTCuQZWW6R6QfwJMO8HRuoNxnFlB5cqb10UwgFsQ7f97vzsTHaAW4s/8965E?=
 =?us-ascii?Q?hYVZTJzD3HbCVs6IF7UBxd1vECttBn4Bk7HlzIQqUEYP9BhsI0tL8hSNLykM?=
 =?us-ascii?Q?qYw+9ubxi0UQqErEakYHRRA8em7wDawxYOZ1lMFPH+mIgGohUm1DzCZUzUIv?=
 =?us-ascii?Q?rjXEFbRdXng4e47n9OgtK946kqM71hAyYN9uonHTIog1BNE7pQusuBsuXeM3?=
 =?us-ascii?Q?B96dAzKJP47/weo+uUPxJ+odrxjnSdNfx39c8HWqQPJ1o6o3f6oe0z2QBnym?=
 =?us-ascii?Q?i9hCFMCBuIbOkoWNmZ6nzK+bcYBYUF5g/mCklMZmlTzc7Wse3WytdW3DcpA3?=
 =?us-ascii?Q?O+qkbEezgAL7mRCJwb9PRmU3M4rG1ZW1udeKkivKzDYpCoVz24HgoD0OXUGF?=
 =?us-ascii?Q?7rxW4Qmw/7vX4PkFrq0rKsNisF6ttUBzOce8DlxvCSRBaXZlRNTtvZHbJ4lV?=
 =?us-ascii?Q?cmhvxIXdivPBj86iLdAyKDt1OQixoq872/xm2sIMCrPdkbIeJ7DaNYR/lFZn?=
 =?us-ascii?Q?YZEZHZAHgfJR44gt+eg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c2743a-5d14-404e-c10a-08db44d8d899
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 15:30:34.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl8XF+pT56SOAZq0epEYjUBmAL4sek89WN9i6KoDzw2eYhwqvWZ/6rfsyc8yN9ILaSVqBDi8fo/7vxjWq76ccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
Subject: [virtio-dev] RE: [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 24, 2023 9:59 AM

> > >  Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command
>=20
> maybe add:
> 	including virtqueue index of relevant receive queues
>=20
Structure struct virtio_net_rss_config has many fields for RSS_CONFIG comma=
nd.
It is not much help to say including receive queues, including indirection =
table etc.
The structure is evident and all those fields are described in the struct i=
ncluding the receive virtqueue.


> > >  struct virtio_net_rss_config {
> > >      le32 hash_types;
> > >      le16 indirection_table_mask;
> > > -    le16 unclassified_queue;
> > > -    le16 indirection_table[indirection_table_length];
> > > +    struct rss_rq_id unclassified_queue;
> > > +    struct rss_rq_id indirection_table[indirection_table_length];
> > >      le16 max_tx_vq;
> > >      u8 hash_key_length;
> > >      u8 hash_key_data[hash_key_length]; @@ -1453,10 +1458,15 @@
> > > \subsubsection{Control Virtqueue}\label{sec:Device Types / Network
> > > Device / Devi  \field{indirection_table} array.
> > >  Number of entries in \field{indirection_table} is
> (\field{indirection_table_mask} + 1).
> > >
> > > -Field \field{unclassified_queue} contains the 0-based index of -the
> > > receive virtqueue to place unclassified packets in. Index 0 correspon=
ds to
> receiveq1.
> > > +\field{rss_rq_id} is a receive virtqueue id. \field{vq_index_1_16}
> > > +consists of bits 1 to 16 of a virtqueue index. For example, a
> > > +\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6,
> > > +which maps to receiveq4.
> > > +
> > > +Field \field{unclassified_queue} contains the receive virtqueue in
> > > +which to place unclassified packets.
> >
> > It does not contain a receive virtqueue but its \field{rss_rq_id},
> > i.e. it's "receive virtqueue id".
>=20
receive virtqueue !=3D virtqueue index.
The receive virtqueue is description. The structure rss_rq_id is clear enou=
gh to indicate that how an receive virtqueue is communicated with the devic=
e.

> Yes all this last chunk is not an improvement.
> My whole point was that we do not need a name for this thing that is stru=
ct
> rss_rq_id. It's just a weird way to store a vq index.
>=20
> Also \field{rss_rq_id} is confusing since it's actually \field{struct rss=
_rq_id}. We
> are using C-like not C++ like syntax ;)
>=20
> One way to address all this:
>=20
> \field{struct rss_rq_id} contains a virtqueue index: \field{vq_index_1_16=
}
> consists of bits 1 to 16 of a virtqueue index. For example, a
> \field{vq_index_1_16} value of 3 corresponds to virtqueue index 6, which =
maps
> to receiveq4.
>=20
> Field \field{unclassified_queue} contains the virtqueue index of the rece=
ive
> virtqueue to place unclassified packets in, in \field{struct rss_rq_id} f=
ormat.
>=20
The data type of the unclassified_queue is struct rss_rq id, so we don't ne=
ed to emphasis it again.

For example, we don't say, max_tx_vq is in le16 format.

I am going to keep the current version as it is better than then extra verb=
osity.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

