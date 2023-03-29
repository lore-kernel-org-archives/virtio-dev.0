Return-Path: <virtio-dev-return-11838-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD68C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:01:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 950857C2EE
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:01:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8498A9864E9
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:01:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 767F298649F; Wed, 29 Mar 2023 13:01:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64F289864A3;
	Wed, 29 Mar 2023 13:01:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUYKEETsqcCzG34iAA/PjI7hD7iUFoMfFCblEqWMmfL0yKnDTXdpxtOKjj2iN9jlrtlqckwokLizRrqeCrEbkRQatPOqx3DTzPpnAu9f9waqKuzLckHdFqKIUMDDIABAi53epKaJg2fcRJBQZ3zro9kpjfp4Q2wv+2FhyCifWX8H2glJEd47AEXBUGolN863aAw1fWnGb0JwNBAZ5w0CEgXqOEmmQAWy2RfBVNymPOKxn3pirj1MD6nh+4Q9shW/9yy/ceClVCGc8WnPVsvUV7+Png4WXQ/bmJ9Piok2EzlutiVVXDQXw7cF8J+QKr8gxeOunb9RIUS12Hya1d7GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtB4ntXt/vkLmuSV/vnM+1fpLdCqih4EGJZYi574uwU=;
 b=iZB6LKYFfhEC6iutTqbd898lKIn5GL86Z2rWnWDi0AgBut2bX4+s3iJnnkQ+5fnKi+vgcJ+PwpScK1EfdCUO7tXFo6eOC2wnlDicrbFMU/UhouEsJqp0lrB/f2y3yUUdB8TuWVQ1QKBSrx8wevb6vozbNX8QE/Kjvx/GgTYkZ4VUqbU8aJJJBQk/lQJ3CMFAxNJGXxK3O9+Sf1J5oTWpFJZK8FAc9B24JbsLXYiOjHUEvPPX82KCgWxzYWPDSirpCTvIlHfUFtPnDHOZI2w1PUFYjdne8xPSS8VrN36JQpSa3nRiW4WAgJ9gelZl0rkroxTJb5AapmR6nu/P1wAXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v9 6/8] transport-ccw: Refer to the vq by its number
Thread-Index: AQHZYbJ2BxRVxjsTPEiGUjIAcfKTqa8Rfr2AgAA6nOA=
Date: Wed, 29 Mar 2023 13:01:12 +0000
Message-ID:
 <PH0PR12MB54814459EB692BD78D1D093FDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-7-parav@nvidia.com> <87lejfnbvc.fsf@redhat.com>
In-Reply-To: <87lejfnbvc.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB8035:EE_
x-ms-office365-filtering-correlation-id: 0b7684fd-0377-4279-aa22-08db3055ac28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UMDw6xRcgdWQ1/IBKrAn3z4a9I1+sgopOt+IlN8uSMbCS6PRhj0s2Y05C+BcIU7Ur+NDyqsRtFKn8LoPnl3UfOYjXXXv2TOY8qbxOdSaCsEHWtax0tYmpIPyxd8AX38k7s+vGoTGqQjBPP356pDJASI9y0i7o+vl68KatJmnrzKR/7IiW74jb2F3RhdrwyQ8WP7gmt4kkP/q22FnEY3X7iNtBEuqD7FnuhNHWcYV8zhfU5JhEEq2R/bUEItTzTyX9d3UTKUeqtlHoDwh054zxd/KDeEQWbSsiWHxWJ0lvMuYJgOIGMcQxPSH+lF18RnDVNrWHUih1ACLLgZArwfLI2FQY5t+ynuLJ+3lIkbAEwf3X1RBQVac+pjMk+K1nW+U7qRpSsXm61uGTlA9XKwsOgWxdEHMfKj9TTU5oC6Se9CKNnHT4mveN5yV9GaQkM7Hs50DN8kdYAdaHuC27EW93lJg15Ffpir/bMPQMdutR68ygVLVHZbSXeUTrPVlVg5VUYxVGkuaIxJWg0Lbxt2DQYsSEBlqjfSll8+ivZzDti0lyBT1DWOwZPiSNh6Fly0EI26euP236GmwdE2tiSoxrDCODK8pIwGEbTU9N49e2fy/LE/ki5s5N8W9DcH+2+iU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(110136005)(66556008)(4326008)(66476007)(5660300002)(76116006)(66446008)(8676002)(54906003)(66946007)(26005)(64756008)(7696005)(316002)(8936002)(71200400001)(6506007)(4744005)(9686003)(52536014)(186003)(478600001)(122000001)(83380400001)(41300700001)(2906002)(33656002)(86362001)(38070700005)(55016003)(38100700002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uMdghAczmF4z9UomzmuF8Et9Srw945hzZKJMynhWba4F3JrH/ItvIhG3Nmwg?=
 =?us-ascii?Q?wT480ZInoR8VHJotHpYenZ6nzbdzs01kEsYMgj0PPIe2a1fAR5EtXrzXfFuw?=
 =?us-ascii?Q?Hf7c5EdvebwciTmc1fhw+vRfnRQQxTLHreWFRCRMxulu7v77zeJcqX5asiuu?=
 =?us-ascii?Q?0MmQGZ9uWYkQFCmq9ZhczLRmNw5j7T6aq9u8RXrJCmgl7J+3GHf+89d4lXl/?=
 =?us-ascii?Q?LE1ueNE0PNhqiib8R3HSA74AdbuSJnTdnETqRkOajWhjZZaa2O6wnXhyjxTa?=
 =?us-ascii?Q?VO6iVZtB9dU6Jh+GIVCnccTltKSuT5lDVo142ey87/cLSUVyu8Wzuba6kSAl?=
 =?us-ascii?Q?TBeN1BjS1DvG8wwg7bsn3SGrhVO+PUeJyg7gO1S/jWO2VXX17xEVKMlEu9Fl?=
 =?us-ascii?Q?t8u3EV2kVfeGEkSzwXwksb0Y4rlpuQ6SAxEvglsLUm9sxuBtjy6CIqQ4Kwru?=
 =?us-ascii?Q?dS+3Ey4EGin/ZbNGzDuB7cUhURBNW0h7A/QSS2mMFddLy9jtgUUC5yHLLLII?=
 =?us-ascii?Q?argdbmwb2ITUdTDqWRI3aNPadjE2YQaXg97ptdFgRHBpLlqnuVIfNCCnSwIl?=
 =?us-ascii?Q?0AQ2lurqXEguryZut3XeHqNQbSKPUr0bEoVpQvJVPfiPYn5Bka7pwfAIBgKK?=
 =?us-ascii?Q?wPgmy6RfbdkcSFmBaQIXPC1pQn4uD+zJrYH6DG4jTNoqEfwV7vaaDHwGUZAI?=
 =?us-ascii?Q?gWMDWO/2ciyWIZTY+RcP+ohdoR6MOZrTdBvvKXk93ofLqU046GB0ETZ7F/Pf?=
 =?us-ascii?Q?6OSMNDLVn0w4RISjuajSL86l9Nlpt2ItkpXn5175YbxCxWgnri7hgbYTHO4J?=
 =?us-ascii?Q?+uOOBvliAkrVKR4vPpkvGJMUjEOX81eZDrSgjKrViKfldzNROHHY4IuGss8c?=
 =?us-ascii?Q?mKG3indRsVNORQVb2zylF15hjV960CNUs/E7d5NXm2et5ixbWlR2ka0Q9UCS?=
 =?us-ascii?Q?w/7dXooOwY7ely1mAc9/aYRpI8O9IVF3KdfqV2HYFifl2trWVHDZG1oqFiOh?=
 =?us-ascii?Q?AvDxsrr+o281AiuonD60ujHMutITjf2wK0S8aZuqw85IQcdt8/yFKgI7G2Yg?=
 =?us-ascii?Q?YxPmg67AXwGG2Ny3jK0t37kgQ07dSRYmZUW5Odbcxz9hR9ooTp0+mptgu3tm?=
 =?us-ascii?Q?zoih21C70wtUH95gTRHqEyHO7jzuMTX72rkVz99AqkzJhIIM8wjsVQu8Wz10?=
 =?us-ascii?Q?xEGcG2eISh0P1ZOQbRv+Gk5/DhnKqtietSDRD/zk1g4XqjEvPVf3yQ2UOfcJ?=
 =?us-ascii?Q?AqznbXj6w0xk1uMQWNVzK46PjdvrKRhNkz6pibZtJEaWgSW8rOzN/vzVZSI3?=
 =?us-ascii?Q?LFnPoj1+RH3Ks9leGyaORGu+nAwRYY9o40hYyvVuiqhWWK15oSJvs1ndfGGG?=
 =?us-ascii?Q?1v1fBczAZuULaKrNIMGf0mANFgDzaLR+6UEr1DcZ7a6/zgo43Wx4Qmamuf8S?=
 =?us-ascii?Q?Yvzz1TaAHb/BVqkiUOHcBMP7NFrLAn/ATzfSr8nQ/TrCfG2cpR5mWjxbO1e9?=
 =?us-ascii?Q?IH1Dma31Lk6cGrdZqifmMC5e+KMikPkA1CzN5o4+plftXfoGYIo8R0rdjV+a?=
 =?us-ascii?Q?F30PQ3tgwmp2CEH9W0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7684fd-0377-4279-aa22-08db3055ac28
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 13:01:12.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXiuYf9bS0ILp+TC8jK6L7DZaSqciUgkI9ByWrmP+uteWLtfwPXvsTdUTGWrHXoSdf3KtJ1/XvtMqkeUHtdF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
Subject: [virtio-dev] RE: [PATCH v9 6/8] transport-ccw: Refer to the vq by its number



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, March 29, 2023 5:30 AM
>=20
> Same comment regarding s/Previously/previously/ as for the last patch.
>
Will change.
=20
> Also, I'm not that happy with the name "queue_select". Sure, it matches w=
hat
> pci and mmio use, but ccw does not quite use the same mechanism:
> vq_config_block is not a structure that always exists where the meaning o=
f the
> fields is controlled by a selector field, but a structure that is provide=
d by the
> caller and then filled to refer to a certain vq. I'd prefer this field to=
 be named
> "vq_num" or something like that.

Rest of the spec uses "vqn" at places.=20
So I will change queue_select to vqn.
Are you ok with "vqn"?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

