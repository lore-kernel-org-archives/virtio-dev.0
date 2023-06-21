Return-Path: <virtio-dev-return-13017-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57692EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:39:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A45C6444C
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:39:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A43D9866B1
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:39:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D3FC9865C1; Wed, 21 Jun 2023 19:39:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 717429865BD;
	Wed, 21 Jun 2023 19:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyblPgOzFp1KKtLg5TVq7ad7pTzpxxTXlpJkKdyD+gHzvp/nScIASgC43ucHqN81EwmMy1lDmtJ1oqjdVZSOfHBARfZWCeJEFUKMD3dBGGjgHrUUjR60WUE5RuOOZgpnGm8+TVlsFdl7IDVT4b/36Lj4i3ChGY0f7gqc2tVKD+i1sFFIrIsZRKk9bypw8Q9nQg+TLMkEzswV+UBaOXLHMpMPq2GGdnlnvhL3wUKMPaAeTGCe0BQn75N3xOdmSU+mMpjBLQpchRZAlH4lm2MSndteAPZhUIuu8p0F/Zh9HOgoGlYwc104ebi4kPMO7MvvHYYNxPIon+416kKkVOfJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBps8VoRtfLKXOvJ2ElXXoHhd742VPUIU8CmOVu8t0Q=;
 b=OOr1jNiCEpTSFo8QMYpd1IS+1tAWNxP9mCABUBG8zZ1lg7a5vZXhEYzfSyVLVgLV7++sCwuv2v7IH6txdMKWSJWV1iN9h/7z1iOUNBBtx8cyLZejZNcNzjXIiC8f6919PMF1P22wMR4OWq7EVGT+EYXmXr0YQKfvIlKSfzrkbHVZTpCv3JEbSOHlg1tNvEB0STlsgPxWMzaRTSYhpJP8S9148eEEsTl1tXf6muTe68p+04ZDBP8yWXuuWLul7S4kVk1jU45E9r1kzELqZw3VpUkzChxah21c5Q1Eecrjh/8k5dBmRvYi9EeIU8+cPQru3F1mBBbXWBCu/aCxqtaqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAABD7EIAAG5MAgAAAR2CAAAKTAIAAAHNw
Date: Wed, 21 Jun 2023 19:39:19 +0000
Message-ID:
 <PH0PR12MB54816D7D508F94ADA30E2CC1DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621152451-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FDB711FBC0528822106FDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621153237-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621153237-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7437:EE_
x-ms-office365-filtering-correlation-id: 1ca3c945-74e6-45cd-e5b3-08db728f3518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 prn6DQ0VrOmQhmvqwYJ656yiv/pXVg2xNG2wI3O8Yf7nCQlFd/2yd17ig/QG2d9Dp+Ljhn7lvtbWYWwX1GOBxYTNlE0qiSXw1nqDKZVV1n+lGf59QzPlywQdHwZ7sqiH500YlNn/Ewxpch4OogdvZ90Ayokpwve4QMw+W6EsR/PgSxnmKYBopTNgTFCtqPcyNtc3XmVV3Ym+B4YchDFF8oF3lsL3t6zW6+PrRwLovOzvY0aKMOaJQR38l2gaJuNAhAooGMmNlP//EdSUxFDRPZZhd7P47z7aMpm6nzBecjsrXXMFTsBiLrA2cn5LGu6uMQQvD//j3NlWimFPWt25pd6DMtN5eoEXI37w0j6LT7KFJ+/faJmNYDQUkYi1j0kYwKFVUCMF2RR4CLdO8/toU0+W3wTNRcUDBeN4McaehNrya42t3eWOkrK1B8AuaC2SfqOC1d6IL5nZdNmUUL77YRyCSVz3isyn3nwCNxoozJO6gphGnVl9CyHdQGObrvScwrkTI/ED7pmuPtJBNTqBHUwYwp9g3kTQ5PoxJs9UR7Q3xPQAaF+zgHM8kNJSBHfL/To/wZqkxnZDz1izlxcR241V70wqXDAPhsJzIj29KsV1sS9EMg7OzvFYCiJfAyy/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(54906003)(7696005)(478600001)(71200400001)(76116006)(6506007)(186003)(9686003)(4744005)(2906002)(66946007)(66556008)(8676002)(316002)(66446008)(66476007)(64756008)(6916009)(4326008)(41300700001)(52536014)(5660300002)(8936002)(38100700002)(122000001)(33656002)(86362001)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TRYuBiyvwBigRne1ARjPJqDtyfAIjgCEPZDij7sSxGO0qD7FU7jFE59NuEpk?=
 =?us-ascii?Q?0o5BxnUXzWIR3LG5d0lQyPc93Cw3r38W3Sk8A6qyRGF/eIe6bLysneuAagy1?=
 =?us-ascii?Q?/HYEFnL3r9Z1bh4KpKAtiKiCPP132ZvVXcuKO5NNc34HyKch/JImPxRaEUil?=
 =?us-ascii?Q?AcaRF0DdGcbvfZ1L66x1rEk6bgWnGLyXdlG+3C2S8486VXpxB3SwEK25EllS?=
 =?us-ascii?Q?/Ye3B1JN8SQ8cTfSA8ON/DALj3I30ChgtYRP7/am2Zq02feo/1DlaPdVd9TK?=
 =?us-ascii?Q?s5jE81rweOVp6r23l6aJ5MaPE8poA6G46CdGqUq9d9O6dfE3+dYTN2QwvqUk?=
 =?us-ascii?Q?goODozXIT8CvLHmKWmjT3dXl5i9SxjaHqapJ2gL5xYO3Ut4pCnnHfCSXx6MW?=
 =?us-ascii?Q?TTQothecIq6jsKcQQoJW0yRe6IvdO8LEY1UtC6Tf35/pS2NBFaPSWboJ5DHF?=
 =?us-ascii?Q?ddVhGEQGmpYUJiiPjtbjMbfKP4T+/1+VTQFU5v7at7hO1AQxNsrttdXUqxpB?=
 =?us-ascii?Q?EJfTQT8O9lkKP5T2CUCBfMFZsrDvo3b5cUwI1aS/3M/WZcFqNiQ4/2Pbzu6a?=
 =?us-ascii?Q?8syj38MnWJtGFM/MJBQ+6hDqoMZSahkRgdFIeDKVqGJjT198D/tKSekBBO1o?=
 =?us-ascii?Q?CBjUM6gYxZaZBEtQyoJLABFeqeV90XSTIbTc0Amt1238Rp0yBSBtHcWGxW4D?=
 =?us-ascii?Q?BoWhsT1NRyV3z4P6S3FVNoUzEnL7W9F3WBRy2d8JGDX9wX4Y0ZGwZhM/Vn6x?=
 =?us-ascii?Q?ycapvLXNZRTFaiLS7fktxsGv5H4pnslZ6wIgh24yq8vBP1gobP3umaXu/T9v?=
 =?us-ascii?Q?6MosVk/LbHlYPjLkJBI+Y37X73of4UZFyHqF33jX5FOT6TnoGxbfX2TONeIA?=
 =?us-ascii?Q?OBMZSwdLRc61NDXSCx+ueL0TThVEedPUrpCYtPt+xP/6E5qL/FBML9nNcepa?=
 =?us-ascii?Q?8fHZOsvUwu+sFaXmoSq/imuM8H8iDWESTemSI3A1INKcxkHMHT1ngO+Pbe8F?=
 =?us-ascii?Q?HzBNY3vE1Bw1bsdFplk18k4/p1IsViTgQ6ZUdYbKhQZ3n3aCjR6HP1Og8YO+?=
 =?us-ascii?Q?UD18adctbFtCiOC76jOz/tbuxseq0c6eqgIAtGLUfO2jbaJ7W1jcYY7m3u+F?=
 =?us-ascii?Q?DhR91jaSaHPGL4NZEvDs7zE8RIWnga/eL1qkre4gw1aA6rJWBsyoMhHw8zLE?=
 =?us-ascii?Q?ZNqXnMSwvB4zytbqRqcjwk4ibfxZxj+P2XAvsWKaUzCqpFUMmvJ/WEbkilrc?=
 =?us-ascii?Q?Uow2LEiiq8Hh9uwro0JCsls3J0rrr14GQLLyPa0puPQyzarxrvIrJ1NAtihv?=
 =?us-ascii?Q?4XjJLr+U/AeuW9CESAE47Qs25+c7/pHvnTanMtWkHM2aUiadJCyqwT9xGKkI?=
 =?us-ascii?Q?vIqnFJC4BwYdZe6M3RITmGrsFhkU7S4nrjSwZ8iLn7/3l7L5FGMKSj8zPriY?=
 =?us-ascii?Q?s2GdwqbKt8dCRnLQ6OMV0YxzwEaWP6rDatZ6o6qzTctPLHciy+FVa9UBuQgA?=
 =?us-ascii?Q?VUIouFoa0qnNp45C0vWHx1NCW3GQ8eHsuR+dgAyPka9+XW5oAr8gG6wKXw2s?=
 =?us-ascii?Q?sdlGJAQzISrbIeaov3/UiJc4kKnKMPPsVbH384nJqHnjI2b+AWrBPDHhMcDA?=
 =?us-ascii?Q?9m8BQ1DuNWrb84mEjiQ2ewM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca3c945-74e6-45cd-e5b3-08db728f3518
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 19:39:19.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W20xyY+mUbwKWZus3NO0iSWARA8FMdGS+SqD8wTa/eUCR41vG++Wh6+iM5aEA8NLYBeHOQjRfyLRh377HUL3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 3:36 PM
>=20
> It can be helpful for debugging. E.g. if driver sets a bit that device do=
es not
> recognize, it can figure out that driver has it set in supported mask.
Device is reporting error code anyway when it receives a unexpected command=
 contents.

> Or if it seems like a waste we can just ask drivers to put 0 there, works=
 for me
> too.

I fail to see this being any better or equal to two structures.

>=20
>=20
> > Two structures are cleaner.
>=20
> Frankly what's cleaner is what RSS is doing, supported mask in config spa=
ce.
> Was this discussed in some version? I don't remember.
>=20
Yes, we discussed.=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

