Return-Path: <virtio-dev-return-13403-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B45C04FE0
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 14:13:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 02BE82AC50
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 14:13:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D799F986843
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 14:13:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD7CD98683F; Fri, 21 Jul 2023 14:13:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA53B986840
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jul 2023 14:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctWs6gHs6G9V0IiOr44hzWckroEQJvSBewQ8BaEE+rUKsuQP2Zvv1eNpRl4WN9W3NJFiBgTaZbmJ9VXBNV77UabxRhCJgoKOGUAOt+zuLxl2t+n4D1esX7OOyye12YGklKtCp6Tlu5+6/6E0qNaf93zvSdgid5U5APuBta+1+m87M42ksTWIS/w1yzHysg9ll70dX0LT1eIHd4fdozznQMRuoT0DmwoSPWMxR3eTz3+pzMSJRIRt2kSA7FXJcuG9G995vobsrUfAuWitARp1gXHuBvHQ6f2UxN5KwUXFoSqEm73fgfdJR4vK1epy4IxsE3x9COwWugHwgceorMNKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sIj2qR/+/NnVTymJit6laSkdwmrKodyjkS51UE6YIk=;
 b=L/gnhXo+Ke9U/TaXJcHYnaXsZZqxpoWb9iDqlCx/dkH03/+Jfu+FtVICNCbPJI51KnoTTgfREfuqEy9QsDT+04+h3az0DnFxgvfpBJAjIvEfSBxS+cwO2ErO5rIfTkLxxE5V9vTDAJpRYOWPRxO2dRJ0rBJwIdvtlbLpHo7Xk9SGG2TsGcShFYoQhHE2pi1IknEhFdZhdJgUkzYbQVOjOwLokllZ/QDgHyONDG+UgWLIEq6WXD/xNBb5ATDYpHYtvgwmF5gsfu+4ezaXOVhsKU5JOAiQ6cQpvXaQDi4DoRWnMPKW//tKNOaMI74AqXI7nxnxWS8tdvJfa4CDD8Pztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>
Thread-Topic: 1.3 and branching (was: [virtio-dev] Re: [PATCH v12] virtio-net:
 support device stats)
Thread-Index: AQHZu85h2ipEtgLNFkqIjuvynewXfK/EKc+AgAAZUXA=
Date: Fri, 21 Jul 2023 14:13:05 +0000
Message-ID:
 <PH0PR12MB54814E707F426273C3299323DC3FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <20230712072050-mutt-send-email-mst@kernel.org>
 <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
 <20230712075319-mutt-send-email-mst@kernel.org> <87mt01jp1b.fsf@redhat.com>
 <20230712082616-mutt-send-email-mst@kernel.org> <87mszp8nae.fsf@redhat.com>
 <20230721083327-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230721083327-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CYYPR12MB8855:EE_
x-ms-office365-filtering-correlation-id: 7a767e9d-71d9-4d5f-a42c-08db89f499fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IRI7Wwgr7jLNCKNZvCuzU93SnnplCey/Du254rs8ZvYLt4FNwMFoO4SP9o6a5FkGV8kOw6nt1/ScVlLEB2LobcF18GJFj6/JW8b/k0ZTggkb5pLoV3IAlDjBv+8X8rGpFaGqhhFyHx9WP4uN7hB28PciW61oswjP9ucC+qhHCUmypRNVc0TsbLf8sT/zMbeWW6jBDe5R24W/DuWjD+sa+vmnBHdwrAdN7UHKVTcsPv8Pkr78muqWnK608Jzu5+K+IHC292RHIzSD70ZZfawY1pRiwMdL0c06sliSf/896PI9jtsnUob52yUFBiHTKuHU35313KDaEyMbayYJtZ9P6Zlzf2OR2gBRSG4s4wMmrf7Ak6qxlkaJV60dOybrZ4NBWO1AbbxajEVeUkqkiSaYS5wOzcW4/LJzWuxq83bfsQbFzti9s5BjKUmyTJlpSf4f7TAsurlD9VU51pQXhv+FukM8eKl0rdas4d2FLN7qp4xKxBSmZB16f5wjDGdp+YTua7wEBp4G9WXlsqSsY5fqAfyR81CoKsqgej8nA6bNL9JYW4dPZjovp7Ja3ls7k7EumgpVm/SsFlod2+tXjOXSejX1sEZFGNu9GBnvKaMR06H66vGaDB/HQvrrOu/fesqf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(38070700005)(478600001)(186003)(26005)(6506007)(9686003)(64756008)(71200400001)(55016003)(4326008)(4744005)(86362001)(8936002)(41300700001)(316002)(8676002)(7696005)(66946007)(2906002)(110136005)(38100700002)(66446008)(122000001)(66476007)(5660300002)(33656002)(54906003)(66556008)(52536014)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EPjvJ13yXbB3luI36VBwHBjPlR9bnEqehLTT1Ij8BlB0A6XeK5CsWDz82z3f?=
 =?us-ascii?Q?7fCWPRmppeF28gYNWJeyzjhZBtPObnMlCcddsWuiuq8zcKUvZ1TP9QjlLj38?=
 =?us-ascii?Q?R8FEfenFy6mrE3IeuK9aSsQ09O6HYam/m38iDbf7szTlZrIho3YIdG8MBK9I?=
 =?us-ascii?Q?Crcat6dzRhi7ZsUDUCK6+tkebvOWm/8QdteJZSF1cbOYzFs7LwtYmtRh3kdo?=
 =?us-ascii?Q?TcqX9LhGupQmETZ14h/N0lDYI+6twPPjIXuqO5KjHODPHvkb2l3iz9YooUOU?=
 =?us-ascii?Q?iVP1F1qnFKF1dNF4QIbtCvg1dLnZqc0xtx+h+xUz2bYRQoHrqUnOHIbRfk95?=
 =?us-ascii?Q?NwA+8qcbP3MbT2sij24QDKmxfqBUSVJy6ItwWIQ8GkpuHBjdz7OZ8ZtbDejm?=
 =?us-ascii?Q?jyRSFN3WjLApKjqjBqUVrDHZ3chkKLAW5aF+BAUgaj1w62s8S4RG62nAS1mv?=
 =?us-ascii?Q?yKCvmn93h+fifv88L9cf40HJNd02SNZtI69KrSEgExN9QcsCWry2XFM2yKwe?=
 =?us-ascii?Q?YiEb+qd58mpoz1F0L22f6S2nyHIfcoM601eLHEUO+agGhswOkc5VxtPnl/1A?=
 =?us-ascii?Q?9BUyia7YRFWHkfafmjdPb9HWBz4mMjk/tgInizWA602YiD7ntL9j8Lc5QW01?=
 =?us-ascii?Q?XnBQS7VLK9Uv7BOv4qKbsbj/TPGBXofsXEPbziE0CNnjzUfdONSkqIjqcDJi?=
 =?us-ascii?Q?au2Om1fQELanEs/WchXxFxBFTEb9YwWbWMBThbhO3V42LVEf34rqluIImw4y?=
 =?us-ascii?Q?5pzIdceYBNo9XA1cV0JHC5W+k+ypxZIDV8GUjpcAEhNlv8p55/vJ5ikLlP64?=
 =?us-ascii?Q?1bjFAO7uWxVmRR+bCQlTD0auXMt6ygnw80WlEuxu8q9pISuzNlntiJQy0WuY?=
 =?us-ascii?Q?QGkIuyK5CZi67lCtI+SdAZK+9ALQG8jJAiZFLYvW+zVQ0HCD84zkWQko3FDA?=
 =?us-ascii?Q?Huk9sW5F/jpoD6vBDbQ2jvU9djYFVDCrRW1fjRkmhVqr0vIbQ4uDWlt5zdsY?=
 =?us-ascii?Q?ZE6JTuV3n+ZDs/mfPu6GkOV+cP6o+G7NYq50N1SYyub/q6lGKtJGWuQTtX4Q?=
 =?us-ascii?Q?5RLs/4cBekinlhtjsQtUdcsxV2s0MpdReB83Z4zKZZx0XNzrx6Cml+1YPWXV?=
 =?us-ascii?Q?aU+XvwQQ2CYhWEMUzTWPNf+np2gdsa8/M8asfkete6ABoBYqsnExo0VY6EYX?=
 =?us-ascii?Q?9ztSRqhkplhjGU6e76qPWTSDEFfY6ic19RivQbFlCVkByjzpSvIV8bOz2ZJ3?=
 =?us-ascii?Q?ajeNTdGOCZcxSegLghZClrdbb0ofLr12n1luIKGgnO8HHSv3cVWmEbApSlMU?=
 =?us-ascii?Q?f9hG5WdkUJAV3Yam/dm0bSI74/8P4ujx4jidsL9IxVtn8jontOIKJhOx3dW3?=
 =?us-ascii?Q?C48IhMN8eZXOG2+As3eFdc2n1E61quTuxiaylz7wSFsHXAiyOyVkNNiRQtn+?=
 =?us-ascii?Q?5akGTVjbtYbBfF0cLyTqE4U6h9eiCAIxj+eyYKWOlLy2+RkXfsfe4rc9oj6k?=
 =?us-ascii?Q?GoIIsO6ia2IUoOtQ4bskZtCfJ5xvpanWfQuqW0o2z1natAQMNAQpPcrEkz4X?=
 =?us-ascii?Q?/QQLUrHRMMlPe2Em1cI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a767e9d-71d9-4d5f-a42c-08db89f499fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:13:05.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgVbWJkF2mAy0RXb9yHwyDlcomoeeJOg7OltRuECqNqytgeHqgJv80x8NYM/OTTGjidyKQwrPZe5mCmt0b3/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
Subject: [virtio-dev] RE: 1.3 and branching (was: [virtio-dev] Re: [PATCH v12] virtio-net:
 support device stats)



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, July 21, 2023 8:42 AM
=20
> Yea, makes sense.
> I think we are all set WRT what we planned to be in 1.3 - right?
> Next step is preparing the changelog and packaging it all as WD, then vot=
ing to
> approve it as a CSD/CSPRD and start public review.
>=20
> Have time this week? if not I will get to it next week.

Let me know what to do for change log prep and I can prepare it today.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

