Return-Path: <virtio-dev-return-13135-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB0EB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:38:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB9D686421
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:38:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 972BA9865CA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:38:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 87555986585; Wed, 28 Jun 2023 17:38:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 713A4986587;
	Wed, 28 Jun 2023 17:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKZvKOqXoySODaxKZod1uRyIcGWIwBWTmOokh/LNxBzhFgMCN3prUX4s1NKPNhmgHpltsEAaMr4iM5+OeyCvfEH7i+eAK0eZ9yJ90nFCav11lez/ZdA91UVfloWCT7O9rpZQgXRTcVoxHFVPzvKpFsSwohlE2V5JTN30+/Nry/FGDjLBVhIK478i+KAp+2aqnxz9yaHTDIWJ4A90O/8t14zeUnm8Aq5l3zte4yEpJf/oM6BSSlMRgpzW/Tlgmeoxx8sT/ooZ857+AlLuYJoKd15bWOLUcRk7JtAs0InZkyf5rClBsFMEZ42enZ2LWruPSF3ICP1ZtuTlM4oA2ASTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RvtZIQLmwmFgpohK6UpWKg5wwaKh4FIlT8cJC7bsPU=;
 b=GiCp/DWKGlW6VmWM9KHyWBjS+M74o6LmYroJOG/us3cJ44cVZ+oYjbcvsLdABqIbpTWRFR64G1X7SWZ8xsQUspalvREpUoYUx1OQGfb3sxXAzLdiMtO+lirl12jViCKN4GSKZVAUPydSPkcq+NYKw0EysZx1Nj1zcwrIij0n0SD4v48Qd/yf5xDWuNJIbZcpJoRw8sHUqUZfYI0n6cnk74lHAb7GCpLf8bMzWR7KW0KmNB8gkf4pgp37ubPCh7GC17q7QU13C+DQWVUBlEKmVyxeLmC452x4Fbb5kLaCfWl7my/oS1mFFeYpGutf0IZXVhRa8aW5AuqrxCVcsMq6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2A=
Date: Wed, 28 Jun 2023 17:38:29 +0000
Message-ID:
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628132122-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6831:EE_
x-ms-office365-filtering-correlation-id: 287e2e16-a01b-4716-007b-08db77fe7cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9PDyPOSXuBytyBrO+T+SJbILKU2cpZPeVkUspOx1amgFk2XDCbQ1rEPLM9pS2FobrWE1kDjDr3yyXysceMc5I2BXs9+TdSCYFfwwwcVDC+h8qP53GEKFwPrxnvhQemfn+yfp6eOL89DAjXM53x9hKjAS+xztdL8/t7J4OIDSTWqN6QBG6vPamQn3W2YoaU6mqnQsvfZ21BLG7ak1avjvacVLSzRBvqmBLxSXn7mPhVwloI7IHcFYaOt2LGcY9Bt+Pw8wYYeb+7xTyWXiDWgN6KSF5FCeMHHDDxsfwPvK5CzEUfrvTgtB78yILtEuFbE4LaD5V9zHRDx2GL4VD/yxXkhAVcyMpB6ajtWUQZnGgUucb5ZNRZhtsa2QTR2Hmv8TsZ0beK0uR915UzzLuPBSzH/Kq484sOjZX13S4aFHYbbPNAaG6IER7u6dqvyAsk3YzJuNWsEqagXD7yRy9IfAIm0sBWdRofB9dkz929obOupOOY/7OTjx+uDUpCwqRBg0uWSCKd19Dil67e+tYbiBk6bxtznb28STryWMA0EevAElVJq1LWYHFU+tYV/ynHOoK7Ldwotlu4VdEpqaJcg88t71vbvq3j6wSqZ2nLWl33VR9SOG3ED0bkPf/nVfEN8Z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(26005)(6506007)(5660300002)(7696005)(2906002)(54906003)(478600001)(9686003)(186003)(83380400001)(71200400001)(86362001)(41300700001)(33656002)(122000001)(66946007)(52536014)(4326008)(8676002)(66446008)(55016003)(38100700002)(76116006)(316002)(8936002)(66476007)(6916009)(66556008)(38070700005)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q4Lep87OP/geMg6dxfL37zTp9iI8yleDKSZ8nq8E81q5C23TyxgFj5p2hKfJ?=
 =?us-ascii?Q?r03YgP5YHb+TxQMG76zJN/Bw+djRQtn9Y6z3o3mEs7OxkofxclC7nd6SQKE7?=
 =?us-ascii?Q?s4pdNaTpu/A8678zsTxYutF5OYhTBQAeg64l/f663jEZpHpHxV4fMoFr9xO1?=
 =?us-ascii?Q?AR38DbNJ41Xm7IZ7lNLLgEQ52KpBvcSRucZdYNIad+cI78G5MsFByKgZJn5E?=
 =?us-ascii?Q?ipvc9TfCFLxp5q1R1yBibHDrwmyamnmacgNT+L+tAJVv0vER8F5gxPqO+n92?=
 =?us-ascii?Q?h/lTUfHWoWOzSGH0jRfB6hwHAGU7HLKuj5wFy/9s2q2NokjGTNX50tdOQKv9?=
 =?us-ascii?Q?lrRoX+dPI6uGpKDOn7zHvL0QIlZh5BQojq05ynQtuKFqgpgCHG8ChL2Ppt9B?=
 =?us-ascii?Q?1X7r65DZ16IdmHcFPTCgUwzfahNF9W2OYQFXYvdB4yVflQA4e5DsxJNZjTvg?=
 =?us-ascii?Q?0Go+6z3ONybofV5ZIFC8S32NWEERTuDJPIMnJbsjvcfmz53NY7UQMUGx9HiJ?=
 =?us-ascii?Q?TvFwLzJl5ZaFMsZLbLDad1pBxDmxuwb4vEfhTAknFmyG3PN2LB/CFs4r7oIg?=
 =?us-ascii?Q?Mqi1K9yL33YaWZcePH6LyOB0WfcqWYuHk2HjGka0OvRBT5hX1V3s205zT94i?=
 =?us-ascii?Q?YALKtuDWvNRUDDhygWY1Z31fyzx/9AlHEefE3yaBNj6VvSGCoJaIJeIgZCoH?=
 =?us-ascii?Q?mlFkWw59bV1uLdZRcyxb0tSXDJWWeOTKSRAN2smjqS61ClT47HQO273Wxt4c?=
 =?us-ascii?Q?rbMBcL9VtqEe1kiZcWNR5ofAL8PY7xhl/Rwale+O8demogvb/blI2yzmMM8w?=
 =?us-ascii?Q?tbJ1j5KQaGxSFJvnaahg6YACNfM1hFozOyZkOnnCO7A7kehZRgc1561BSyvw?=
 =?us-ascii?Q?IxxDCcRcxgg9uBKyhHS6NwLkUac5NvVE1og+0Dui8qTkgzORSX2c5Lz1/nfn?=
 =?us-ascii?Q?Xy1t3Ewc18qUpGJ41S7pIw5BTwKIwTIxf4oai6qSC1UJrUCI5o2pG+NRYvgQ?=
 =?us-ascii?Q?LKyReo8qk24hbQX+00TaN7/u+hYmpb1bhxvXKUiD7E6GUdTxN3BBbVI7tcBg?=
 =?us-ascii?Q?tWxdoynp363bLqhy47mA6r2erR/NE7byh5xdvhlWVEh23DQKjGMfYGJRdR9s?=
 =?us-ascii?Q?317f+jaI5ugkTjT/Ulp/UVaEbmYpUjHJz/F9xm7d4o46lLfts5WnhfLHk+eL?=
 =?us-ascii?Q?2Fva9qu3p3w6jx1M0nTBRdLZjHhAMO5PXpVNLpBg9IlV+hykUhciYKAv3AfJ?=
 =?us-ascii?Q?J4TYgW1yPLUyqzCwFBYWMo+7uE4NRPFcgCzie+guc4Cy6+n3tnkS4bO+5dKb?=
 =?us-ascii?Q?7QD3Xg68fvspJGmeEhI+yVV42UxB7KyO3J4+7YCxrK+dOkOe0ihoCUiH/no1?=
 =?us-ascii?Q?kPt8AeP281YKFrGtRMV8u95OhumEObk2ru2v7lrNH+XlG6YbmjORn5c017Jj?=
 =?us-ascii?Q?cTBebkqE0y23xZ7Zf+gYLlskQ7fUufHfQWIfFn2QNw9y4UT0NqYQOAsKpDUW?=
 =?us-ascii?Q?a19KpT7QM16NaPygumplf/K06WFDDp1Z6eSycK8QzLKjrazkUUHlHpRkxKfM?=
 =?us-ascii?Q?MF5OA/6FVkIDONPDJyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287e2e16-a01b-4716-007b-08db77fe7cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 17:38:30.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFSmF4lqkrIokKqhU5Y+xMJWiTwWYfDR6h/DKmfuNkzsq8CQb0OhIJ2Uqoj+QnsQtlC/CxEA61idhnP2MRSzzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 28, 2023 1:24 PM


> > Because when device has two ways to access config space, it always have=
 to
> account and build the interface that, hey some driver will not use DMA.
> > Hence have it always in the MMIO accessible area.
>=20
> Maybe I get it. You want to use the new features as a carrot to force dri=
vers to
> implement DMA? You suspect they will ignore the spec requirement just
> because things seem to work?
>
Right because it is not a must normative.
=20
> There's some logic here, for sure. you just might be right.
>=20
> However, surely we can discuss this small tweak in 1.4 timeframe?

Sure, if we prefer the DMA approach I don't have a problem in adding tempor=
ary one field to config space.

I propose to add a line to the spec " Device Configuration Space" section, =
something like,

Note: Any new device configuration space fields additional MUST consider ac=
cessing such fields via a DMA interface.

And this will guide the new patches of what to do instead of last moment ru=
sh.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

