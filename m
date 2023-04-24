Return-Path: <virtio-dev-return-12364-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BDAC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:02:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 564E12A82D
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:02:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FBE498663F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:02:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 43196986393; Mon, 24 Apr 2023 16:02:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B5CE98635B;
	Mon, 24 Apr 2023 16:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjcJYmPSbyvtr5SfqWvt6SRwOaJo9NakvE86krq5w8f5ubzRLZ4T5bHRfGh8d63T3ujN50KN2sDilUzPgS/HTUVwJwseb+xBmaPP08PzkIcZGM9mdMxhYy/n2HJQ8KQtgOHFvsLltxZo1ardoOdq6r6FQDTKQgGFYma0CFXdkrIs7rRIWCRpJIDgrsyPxoa7anxbzP3kK02yWhjoyW2g5NneDYGMOTVpuAgJnbSsYsUdQDVudpObiprjp87qx2JwCWgOaScZe0gixNTQ9sB89JFOdEl8ZNu04liv2/MVpYIi9QRa1Dq03ztUqnHHW7JDEhec9/CDq3K9h2c+yoVW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP5ztTVJW+Z8Qe+rXR1Sb54X8YPSzi/rFgdxPpy+JDA=;
 b=nw5YdRbTdj1JO8J+CulTL/kSsSs8NVnRtw6iMapyA29es/orCo0OCvFBB6EC3z//K8VsyUoviooHMCKDo524YY3VUddP5be2ni3qEjvLosuo1wzCHt9/lIiXf/DsJMOKSfXl/ZME8zUiz6WZXFeuW3XII2My5ltBMWQ6t+yAD56lIFQLGYNzpos+cXxqNv5B3D6Q/e3mDNjRMPHtqyELTV0SyvW5KFecfMguA7t9a7btIu5lRBzzp1YnU/EIrQl+ZeZUgxcQqjc5A0H9zSejQ0z9mp+LyuPxqdTDwmVGCdEleb+O65GdHq1ShZNkk1HUv5Qo/hmCCyPvMoFT3WuPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id
Thread-Index: AQHZcmDe+hgtkWplfUa2ohK75caGUa86eteAgAAKKwCAABhd0IAAB+EAgAAA/vA=
Date: Mon, 24 Apr 2023 16:02:00 +0000
Message-ID:
 <PH0PR12MB54819D9F66A116999A5CD3C7DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-11-parav@nvidia.com>
 <20230424152221.54c44489.pasic@linux.ibm.com>
 <20230424094202-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818907C4A9BF2031664166DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230424114849-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230424114849-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6382:EE_
x-ms-office365-filtering-correlation-id: e15c718d-6209-4ce6-f057-08db44dd3cd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wP5oRcaAeqZ7+BdbwXylDo1Yu0pdfpDyzKTKQY4ak/ZEgnpo3V1XcBDD3Z3EoipMEm3cC3W7O2TXl1CWYPeWjmjcFRs3nzeYsaZwdSVLZ5OfHqF4EBBMdfZHwoGKu+7VAcldFLCryj8LxYFwZN4J2B9yQsXYUr8MkngswYJJONv7uWPmGxgo2e2CjdGjwDzAMTUSgJAY04bgbUKQPgKYKICR1I61l/2M8oDSYpt6ielIE58W3SCPLSRb+LFEK3wt8hTSKMSWPNu8BhlGkFASmy2nhUi42AInSfjg2efJlnH3fXMoeS/H0qZW19i7OJazc6uy+hyG+abLQVFlPQK4d6WeO+8BGR0S6TZLji28wBJnOMBOMRcqYLLWHfL/+9bWmG+7ULGSnmgN+gNWzLI6yc2JFUXZSkDnV0gGzWggwidZKcG8hwuZtCi4JKvn1x2WJ7Gnc8crvE4GidA/XcOx9Pll5dScDePlnD7Kct7msqJ3LyypOzacv5/48r8erfRqnxiFUCOYoRgdexp45z59iYcO7SlTC7XOIp3qhdkddfgUyb7l65OGf5ay0jeDmZpSSoXBpv0IOgpjGV66DfDRrwNfcSmru6mYegWhB8LIv/SU1WIjIXcppYjl/FYe0Wan
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(54906003)(38070700005)(478600001)(316002)(6916009)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(122000001)(41300700001)(2906002)(8936002)(8676002)(52536014)(5660300002)(38100700002)(86362001)(186003)(26005)(6506007)(33656002)(9686003)(107886003)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RdtMrPk8Zkh4eVrllv7lo1WnERUDHKzwXNdscBRVvlYxoGZM3OdcQfKKgvoZ?=
 =?us-ascii?Q?mx3DeQwueX9nRDOEyTB29GW4rwjERiDPbgr2Jy1WG+iE4vLn8/2upnJPklg7?=
 =?us-ascii?Q?w1fcMEZPhIBwPDyqcu4nscU0GZ/btxDMcWkJ8f5cMCOw+HPeqc+aGHl3WBw2?=
 =?us-ascii?Q?5TOu33/ZaDhw0ETKw1eg4aliHw3klrBs5NhwuDAirfngtuUgOkPtc4phcgIZ?=
 =?us-ascii?Q?88ORyRRBVEuWk3zFDUmgWLq74b2+s1E+tz4RtqOhbA+A9H+nN9hi+Ofnmvh5?=
 =?us-ascii?Q?DkS3fAQYxAkNCtL+2F9h97zSBFhj+MvLmX3Xydb900st3DffUt2ipDBPITwL?=
 =?us-ascii?Q?KgjKdyqQ7iBMHZga67aNPPgETF5pKlPGwHpsvXuEYxpGJ97o+TsuogIINa+S?=
 =?us-ascii?Q?QwqDEyh0dOpslUa0UBeAVxDwiodkQKQ8sL2zUlLb1Yw9mRbm/NE3EVA13rLr?=
 =?us-ascii?Q?j8L7wQ2U159p8+VGx7dVOXZs88X0LYWxfIC+7ydGUAv6WOgTx4hoPyWGV0kW?=
 =?us-ascii?Q?I0vvR0hFsRddU09uq6AfOtwCzBJkMN+YJsNHphSlC5Tc25A+eMGHz74bpmWP?=
 =?us-ascii?Q?IXjvciSa1UrpCiZJu96IoJcZZdG0NjZG+e2CsftXVtjB2hrePS2oFQnyOU47?=
 =?us-ascii?Q?/9E0InSIHWseoclcLMAkiALALmi1y0He1r8ZEPvrYqkIhyOx/4z1TfGeM3Pm?=
 =?us-ascii?Q?GYVSgFK3OUuGHXsUk/SSTB6KSB2rmcIL+4Kqn9uahtYGgSIcK1l72qda03ok?=
 =?us-ascii?Q?IWfO2KcyO7wbdRL3BF5EdJL9TwJEy8e8SVoHT4BwRjpBohU0Ipnc+c8iejDa?=
 =?us-ascii?Q?rhLcKGXaXqe/OkcoBiCwPdToG4Xq+srV05V/MSALIFYQBoThKEA6wkvWelNK?=
 =?us-ascii?Q?5EtJS5f5WIIJ9LcYWrIE9Dm3FoNMp0sBfKw5f+K/g+Ad+25UP1/Ydri0iyCX?=
 =?us-ascii?Q?biPMexCylvA5k9i7kwZvdyAYdctM4dcbhIAlDhGpSpym3OdGJWog3cJLxYFG?=
 =?us-ascii?Q?+3hUIZ9XROH9PTAnUtKTz0qZoh0r3Zfw//Ag1JSHiuqvEXVPte52Ho9/8YZf?=
 =?us-ascii?Q?6TSmjN/NFEJRxWSoe5To2HmTkzhWvwlAn500bDy5PyniymPSOK6FQUfCDeQB?=
 =?us-ascii?Q?WwSeePK8juTp8EzdQXHXT0C2Mmt7C3u7iXy3DLbUsv6813LVdk1XQBfgVRmc?=
 =?us-ascii?Q?Ko0MLblqrfNVhPkT+bVmzFR0+Sbnu2b1ebEUhVa5RDl2BSewto3MOQrHzDBh?=
 =?us-ascii?Q?Xb3yj3q+Ko2XSX5TApxfeji07HSCiM69WHr/ZXE4YSzl61LE1DKWNhCZVIaf?=
 =?us-ascii?Q?WjKxjjcFoexrQ/HS8pnKLCYE6GGFcTwKoe406p2Nf+9Huezd2rqc06GDVZIu?=
 =?us-ascii?Q?aZKe+49FW3id/mL4/JKfDGziO+CEYwRiXnQ+dsy3cLarkQV9WrPC3YCKd8oi?=
 =?us-ascii?Q?XHQWZndmAHaUa+awp4ET3aR87xZO2H9LWDiWTBFcCRPkPgFo4yMswsQm8i7T?=
 =?us-ascii?Q?mWMOI+xvDD7cXRLrk/xWaQobuVCZ38iN8WlEFOfSASBw2WxZIZZavi2nCj2o?=
 =?us-ascii?Q?j58K6QqOPyD22S3tPok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15c718d-6209-4ce6-f057-08db44dd3cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 16:02:00.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6FXrwkSDfuVfXvVp/gloPrHC4uYiS0CfZKF5b2BMY9cNHSaMS6njZa/8OY3MusfOue4X0+NBQJZIQn4RZVApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
Subject: [virtio-dev] RE: [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 24, 2023 11:54 AM

> > The data type of the unclassified_queue is struct rss_rq id, so we don'=
t need
> to emphasis it again.
>=20
> oh, you can drop that:
Bit 1 to 16 mechanics to be defined once in rss_rq_id definition.
I don't want to repeat it 3 times for unclassified q, indirection table and=
 on device side.

So I didn't follow this comment about comment.

> 	\field{struct rss_rq_id} contains a virtqueue index:
> \field{vq_index_1_16}
> 	consists of bits 1 to 16 of a virtqueue index. For example, a
> 	\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6,
> which maps
> 	to receiveq4.
>=20
> 	Field \field{unclassified_queue} contains the virtqueue index of the
> receive
> 	virtqueue to place unclassified packets in.
>=20
What is proposed is this patch is:

"Field unclassified_queue _contains_ the receive virtqueue in which to plac=
e unclassified packets."

This we can change to,

Field unclassified_queue _specifies_ the receive virtqueue in which to plac=
e unclassified packets.

> but in any case, there is no point in saying "\field{rss_rq_id} is a rece=
ive
> virtqueue id." This concept of "receive virtqueue id"
> is not really useful.
>=20
Without repeating text 3 times rss_rq_id serve the purpose.

>=20
>=20
> > For example, we don't say, max_tx_vq is in le16 format.
> >
> > I am going to keep the current version as it is better than then extra
> verbosity.
>=20
> Maybe "specifies" instead of "contains" then?
>=20
> +Field \field{unclassified_queue} specifies the receive virtqueue in
> +which to place unclassified packets.
>=20
Yes "specifies" is good. This helps to define the format also at one place.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

