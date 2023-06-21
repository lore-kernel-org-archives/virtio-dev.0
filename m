Return-Path: <virtio-dev-return-13016-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173FFEB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:37:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4D2391EAFF
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:37:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 428309866E6
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:37:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35C499865C8; Wed, 21 Jun 2023 19:37:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2199F9865BD;
	Wed, 21 Jun 2023 19:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcATu9UQCuEWAP4WEVdnzJT2QpGu+8H0LG8RVgO1O4lxlY6jrpEJk2BZs7D5TPw2/yBNrb2Cr9O5l16jobA5Pb27hHhQHra1nYnW4U9g3+fOPtadRElkNeW76DW09Y8WIDWIcsCwnknVfuzSUrQvJ3hfamjyuY8RsTcb/F7WxSxmljKP1gaal5XCZcZZVDzMtUyR/KRWzIJTe7fysIyzo+8MmJhlVCRCPvpdNZ8l3fPfGoIquJwJ5QEgWD7qYLFbrNMELNJcAmRbrcUTHpNfwRhLmRPvWZcrp36E/MtclnSnAeOLMiJxZySa42Y4n6RInMTL+DCmPrYSqgh13pjdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmy2/kn+Dkw/3GEDXKUhsB4ENWflGb+VVgEqXaQQzT0=;
 b=KScIpC1JLWTSc+HHM/oyeoIJRiPPeei6mP97The1TXssc7toI8thVSl+XIRYY30xvB8JIBudf7BJFqaFcgPs2FAuh8+WZGJW1nZffysTjWlUIM6fa65TlG9LpqQYlmbtAYZdALjd3Q/6Zo9gdneXI2mowDCxgnSz4can9IVSrQAaFFwOxKmo3d2mjDCAm57tI7iGXnMYArAL8iiqzv7o0DKP5Zzhh2ufIkY4F2jRVbPyxCp2Tkd3LTbp8rl6Tl3aNnmh5LLsRmtqV3EnXhU3DNEjVK/W+nY2cSH6O5UI/+b6QNY8/QDqpqTNGpoN4rH9TVwDU7OhIduc0vR9h24YOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index: AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyA
Date: Wed, 21 Jun 2023 19:37:00 +0000
Message-ID:
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621152559-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4399:EE_
x-ms-office365-filtering-correlation-id: 06f6a00a-8fdf-4c04-c232-08db728ee234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2/E9ZoWtHetjuk4r2WLYKLlQr6wsd8WGzWEs+osKcJsnh8aZJwtt9YP1bq0EWCGEliBHH4nnGpe+o48mNym6eiRs9wIvRWst3Y3JiTcELLygczJe0nvCNUNFdCYo6rHCkzoH22bAHpDyCFZFxHEexk2TM1OPHxCkpAX0F9oiAQw7lihpDKEQ5S+bZOYKfG3v0L+dhEAJkc9tougQ8pkkFVhZ8OHsgsioH37XeTFaPyKmMfV8PijAjhQIs5lv6idgqbkOjkenRnreOjcwktV2me4GFLoQvB/zFkg2nJowmCfghzBrOqpQSJKqosiBL4lan/+hohL0W92U3WuhuRdAm4VwlBesEVQOQdqYxuYCXpLE+nBEC3UrCNY2WHv79vT83BaMurP8rAFdMcHwYlypW30nya6Thpeo1EtrePAGKSmfwI3InxD/LnfwypGfBSe5PkakcqoFKq9vPhYZHyh8Gw2Tn6gFkLdGp5oL2qMOl9pePpIf/hR9nzW2xFCwoJYyb1DtLnfNGEoPCawB9JYBPk9BJx3JD/nie5QZ1blqH1MtXKOIlag5IsA77i4Xw1N0crx2YofraLYnFeZFsTGmCwlKRRamjYMCi/e0nlRq6fcpm5MxhlFcZ3wZHzcVA+G1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(64756008)(33656002)(5660300002)(52536014)(8676002)(41300700001)(66476007)(86362001)(8936002)(66556008)(66446008)(122000001)(4326008)(316002)(38100700002)(76116006)(55016003)(66946007)(478600001)(6506007)(2906002)(4744005)(186003)(9686003)(38070700005)(7696005)(110136005)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2GA0cp3LMwkRBmu8i+IEM2o6+NOJGyaN2wkLo3w8X+WXo4j0KYVHb0C2zWsW?=
 =?us-ascii?Q?Tp6OUIpw5dwIwFDfwl9K/mtw4oOAotbKtE4thVWj6zQepqym9yXHvTvIoh/+?=
 =?us-ascii?Q?w4zw6KYtCVGdnutmm52HcJ7+jUxbWj1Miz+Hw+3o+8J3hH0i+n8Fw3MjBVD9?=
 =?us-ascii?Q?jBRrDiDxKx7eTO5h5Xa0j3kzR0DFQNyrsKrkxyu8cxClUOOlYj+VAqOgnIqm?=
 =?us-ascii?Q?pMeQYRVI0Hm7QOl/HqCMysrJK8EDKX+CUQWTmyUsdNMwYvup/JVEDLHh/bzo?=
 =?us-ascii?Q?xG2/FkXBE5PPXMOMnc1hjKz8yNW2172VLbeTch9LzB+d0hTWBJz0es6B7eDO?=
 =?us-ascii?Q?OPi65p6Md6B6mcSRbvjlr+DpDE71cgbKYGTLUH7rz1n4GCJzxnAlEHd5JnW6?=
 =?us-ascii?Q?X5GXqvEBF1sDfjmLrxpDSwHMUrME2uWUZZK0O0HBJk6KuhSBmvvZlhSiAGJ9?=
 =?us-ascii?Q?3NnH+BpBk8SxAy+tLM4W2tF+OhqBT4Xi9Ym3au8W3nHkahGrJnVDjhMK+X96?=
 =?us-ascii?Q?zrFZfB2hH27nBbifn+S2P2oImMlGa0JXUEn3btSsOjFf1UytErcZn4lkFz+M?=
 =?us-ascii?Q?tS4PhIIkGn4zrzejrCqZo17JPc4NCUJTJbKyFnT4qIzMy05FBZ0Vvl2bqlzF?=
 =?us-ascii?Q?5i+IRygKdeBLi2FmiDoPMoEXGouz6AuBYj6x3rKKTAkRxw+3YMXVdgmyVoC/?=
 =?us-ascii?Q?kZjvJDxgX92DRm+W7vO/FXm3ULPeF4832ijaNyAkJ+N+X8l48ZTBpGB1Ad6C?=
 =?us-ascii?Q?A5BtAsK7BT2S2mjWjH5BL5ht3GHw0Tm7xSx92cG4ExNdNPV/IZ4uAEAmqoum?=
 =?us-ascii?Q?yAZZAaJeOZQ+kw9doUqDWdbdm2KFx9kQddzlxz71EZYGT4Jy13DdYwl7IFEd?=
 =?us-ascii?Q?ghMDIDFo3XzWCryARLKdKSohJmewAl5vdO7TChJ1Jdt11VrfWJ9sd6j1XrSe?=
 =?us-ascii?Q?/GvlnW9DRmnOGVNrrE5L+CLUiYPYzwVcQHmbeLrtUOc3fCqh+ICkwgLVZdnl?=
 =?us-ascii?Q?yoQ7P1Kqok4OLOJkmD/X1L9k1hhxnnhgGhA62s3CZFuCYFEk72+YlXZ6m8Nb?=
 =?us-ascii?Q?K8njpY/l5o9zYedZQamqY+90a8qDPBcuscy5S/m5HsjrPp+aegm1oqvkDQoQ?=
 =?us-ascii?Q?LgUNAC9Dghv13Mp8hKZxG4MZ5wEfkdFx+Sr+1Q+I3OZLbFQ1Zd3GPjGMNP9R?=
 =?us-ascii?Q?JDPyqz2QzjfhMlSsoGHF03W9XIyb7aoNtUeS15pmwvYRpknlrlk48M6NoE+w?=
 =?us-ascii?Q?LTQ5yEqF3leroaiW3AmUI+ypY/G3FWniO9A+gDR9tuF7lRDzwdeVKUhlar82?=
 =?us-ascii?Q?SJK+poo041KPrOGOVDvSzBz5S0ljYK1hbRv8U6U6IPUH4pcFbxiydyILD2JV?=
 =?us-ascii?Q?8uD6yICk3J2b2rpljZYTeih17JKw9BtPL4Cf4urVGt6uEAhERj56bGO8I2kB?=
 =?us-ascii?Q?KQ76hPcdfgzV7Iy34MJv13+dv3Uf4g+jqQg7eZoRpdbsnY8PiU3SiGtSoBCo?=
 =?us-ascii?Q?VZ0TnJKI9TrMKDc4l+C0TEdtzYQFAE5nFc43YMBjFFyXYILr7LjOzKLqNohf?=
 =?us-ascii?Q?bG01Fu0thuZrzb6BoZuOI5Q4j1YyR9vUKcuAFpX+D0gkPzqoUHM85IUbnLOP?=
 =?us-ascii?Q?tAr8hCSjjuJFKU5+0nkuUtw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f6a00a-8fdf-4c04-c232-08db728ee234
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 19:37:00.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwO40fP7cT0R05cC38NCmnNlE2LA1Bngq7WBITNYlJImZdpJZYxwdZwvZS8Y4N1SMLxNCeOnacljKtV9XGjIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 3:32 PM

>=20
> Well RSS is designed (imho) better since it keeps the supported types in =
config
> space. Doing it here would have removed the need for GET command.
> Yes I know Parav hates config space, no I don't think for a read-only fie=
ld like
> this one this hate is justified.
> Did we discuss this and decided not to add it in config space for some re=
ason? I
> don't remember ...
>=20
Yes, we discussed this in v12 or before to have symmetric interface to have=
 it via get and set via cvq.
Should be there in the change log.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

