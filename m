Return-Path: <virtio-dev-return-12656-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E7EC77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:18:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4F32342A6A
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:18:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48C529866E2
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:18:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3E1229865E9; Thu, 11 May 2023 16:18:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B2439865E3;
	Thu, 11 May 2023 16:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrij5qPtU88KCsmO5sPExhxuFfqsUiZ7tcf7lcYPH2vByU66IuKQvzEGC+VDJ9yO3CPvpXru6dbooQfvKVrJzXo8e6tSJgnngKCMGWrAQx54kQgB1OOQ6EsBfOH23UVL0fLxAuJb0v2kQpWky5x4HBYxWz4BgfJvHARdfhSHJR8E3PoB9icWe/RlN/7CbpTxHYU5EGO/jrjDI23+AQmU8IbM002NO0wa8JSY5rh/8RBWUtY7fjNhpezYZgTuaREtzYwuMxVbcUUXes/vEuPggCYQuSBdFWNAhE8qPhO5DsSJhQYwxCJHDFFsy7Q62K8Ulzj4agthDIJ3hTV48VUmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URGru5wOdnYuSCs+2y847YFpTZHqGE5yCIZ9N82CAq0=;
 b=Taa7b6+dKBl5Ab/7PrzRPn3Oh3yvoktdUd/XaC1L5g2B+BoOXzz74EZ1LeHvBeJGhMkHzxZSYWJu18RUdC31ZwTsIuFnm8ewqW5Qjct2hF0IpRgbP3d/EDesbC7SnzEsJUmhipe10lJekKfJjtZdXm+bYiIZmNeuzpg/mbjTH5r5sBlyjFb/Of9/lBLtfhTsw7nnecJM1gqCoKRBpteAb4i1/2USSVgBYw1wHMw2j75zVakydCKyoQY7RAvxsvhA+XhawW5YQIwEVY9/xrr9zpTG7tBDJ6kGJgqPDst6HTGB7cs80IQbYxxgRhwS6XCfa2+Ph+Qy5svqXV/4ctcc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v17 00/11] Rename queue number to queue index
Thread-Index: AQHZfvN3yyxAOVQfgEizFAKQK/e/1K9VSetA
Date: Thu, 11 May 2023 16:18:01 +0000
Message-ID:
 <PH0PR12MB5481E96FA70E661EB75F9E4BDC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230505014614.571520-1-parav@nvidia.com>
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 71d3a52e-9eb0-4e18-2939-08db523b4afd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b5Giht6k+MEAE5uBjNteuXieEFRyExpGOYvn13f/Q0bJAAZ3ZmO1uuPMfHfDmvjRV/GBNSk642DxpiWB6goM8uctq/JBhUFJfGM2L3Wk1Lz5pqZuwbBm6oFtZu7+NT8JuoSMTRt0FlbznizbUzyRhQ+VqEpqlcrEiv9I6ULn4Nhu/jo72C/xLdVeoyLajJcKc7crvMni88a5SqhST20G+oSwf6aZZJvnFWBoHTd2t5wvISao1LgnD+OlDRaXgY/uimUGKVLYdrDByVaS6bMXuFbIsxjrLitWo8Y3kPVKz2j6//MX7DdgpG6wzpSlaRxrqR6j/QoV2DuB44TSkFiQxkCvcMAPh9XShMTapDb3YvtOi0tNxZ36cwRqv7JSjme6M8YM1pud5BfEN/51keMbrAqvtXVE4UDecB+3H7eg9i7IlemLaKvMPYb6WI73cWRhwhISferXmdQe/sKyA6RwDknHk62BGu+f5lY7O+cgpG1oRh37J5ppYKFSDSbYzQhupIEKNBzjB+JE8hv1SE8H5gW4E6S08+kkoy26bDjBzcojUdHVac3Nyfgns7Oh39WPmwB/Z+O94mUjycJNK+7o/24Yr5ZOw//ib43bZaPyaPDEBMYyIQUPGrjkENsC1KRMrdtH6+I6GSX1cT8EqeYg61QbC0q+V5klD9pn00aqqYE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(5660300002)(52536014)(110136005)(54906003)(478600001)(316002)(7696005)(8676002)(41300700001)(71200400001)(966005)(8936002)(66446008)(64756008)(66476007)(76116006)(4326008)(6506007)(66946007)(26005)(9686003)(66556008)(107886003)(83380400001)(2906002)(186003)(55016003)(122000001)(33656002)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t6aaAzyI4gyD4Y02roOucUNb9x7m1Q0iKkHbgMMuYmbjadAqAECsicMNwQed?=
 =?us-ascii?Q?o6HhbgdpWdswUpgo1pg08Hy2MOknu/nfCMJw89wXtfY9/bDcJwJftL1g19Q3?=
 =?us-ascii?Q?Zy1qkWUN8COKuM30QMC7bHnibEy/6+mdYTNuzlbET2HXSJjif2kZnpYc1vis?=
 =?us-ascii?Q?5WEhmkbiJs0v0/JbvRvIrU/DoxmcqBjof6OhLKQWaWq3UAX7IIvLmOt23hch?=
 =?us-ascii?Q?xYGbPXbflj48fyru360bIVwohoGX/vKu0Or26KzGYD4BdkLrXiBgJCsOir6Z?=
 =?us-ascii?Q?xRhuouLr8wJ4FCWG9R5XSxwLXPLusf+XSJS/h/zJFbYex23BOjxhWr9SMVAa?=
 =?us-ascii?Q?l1EKHqyaKA4g1QRD4wvgfu/HcCuX4jya0fpqVJjd5/SGfw96lglllaZ9puXh?=
 =?us-ascii?Q?0YHCOqTWrWu3p8bUOgaLN3+nFpN7rqEZOhO6IqOcpMmJZZJK4hJWTSeCDjDE?=
 =?us-ascii?Q?Jlwe/+rigI+wBNEgjFNaRSUP76NtzfX6TzwoWsbH33jsaZhn3v0HKE37iQRX?=
 =?us-ascii?Q?R7Nqtbtq/E1nUeWo+3l3E7PAVYNhWLicP73G0nXcUI4FU3P1Y74KUSZMf+nc?=
 =?us-ascii?Q?tn86XIoRcKPCif453KyFQ0mwtw9L5L48BEjNifzf+02vcmKpxuXNRl+T8M0W?=
 =?us-ascii?Q?LlNu8wXHblaU6QvY45Gm3F5Sx710/jQkRZHIpSZAUQy6tXAWskNJOdDQLBFQ?=
 =?us-ascii?Q?8DJXI8O5vUbsOevHW1JmmMMzSf9z/5T/AmPWqlvIcpsfB4k++5h0zK4kdOl/?=
 =?us-ascii?Q?tjH2qTqq05mHOCKABbvWDD9gTWLqUSmFCA9gBdLiGG7i1QZ00mONHLh1or07?=
 =?us-ascii?Q?lRixJ92nNSshyG0oMXPFhSOWxLZVrdJ8l89eKvpVbZVu4tHpkOs6JRRL6j9k?=
 =?us-ascii?Q?bPpC0UhWLvNcYEqwnV873rAZysagW8Mz1NLH5DwszCVRVqRn0DFvgshV6+QL?=
 =?us-ascii?Q?+FrkWO1qHsAlevtu6cgIN0QMB9BU7W3glS/8UDyGLGWURm2dROHftHThKMcz?=
 =?us-ascii?Q?EasGQ+3MdQ/nZnxpLsHCJi1scNbTnFn5OkEEjwIpyNA8zkezJ9fwpmtKimyr?=
 =?us-ascii?Q?kSbA9oCym1sSm+qudql4uQ6mG/egOcQgco3Pr7LpoToHFuE+ovnB6177UV4Z?=
 =?us-ascii?Q?rFX11R43Od3DIiUMw7yv60SJJdg0vKwhKjtSXp2FM3qc7q4WEuyyXZ+JCzQq?=
 =?us-ascii?Q?jMywD8H85IqjtNcZ107Mqo3ePPmXhDHKH/YnD9sMqNVF+lE4O3qSdrz/8BpY?=
 =?us-ascii?Q?QM+650TUz++H61e/hY1Bv607TZH6Wz2D9ybwJv6XerNIBnzt1bq6Xlpgx4NC?=
 =?us-ascii?Q?PbKRSnFeSMnHDtxPmUtFmq6vOIIx8+soqIQ259dFjifkpuv2j96ohBnhipev?=
 =?us-ascii?Q?wqGxCqdcMnasdFZ6rfMKlpFCN+PsnJTSzPgLLuh2gQ9X6+GCRNiCNVbbtXe7?=
 =?us-ascii?Q?EclnFuL08qHDX5DCBQe/7SLXU/ag6PEXsuUb7qCbhkrrCjaBkY/6jrRD04on?=
 =?us-ascii?Q?Bk0XlhQwYXBVW0TQ9sQjAIzEk1UOcn4zvL/seODEI9NrFSRWZ7EYjyCQFs76?=
 =?us-ascii?Q?BHL2sFkKJ212S1GtYsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d3a52e-9eb0-4e18-2939-08db523b4afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 16:18:01.7448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc/UkvF3kcKPcHeFAb1LI/2qbfdFApwjDOEFKeiQK3ncGQ1ZB4pGHcEZvu44DHMV64zsSWwHcunyz6wvhuJ0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
Subject: [virtio-dev] RE: [PATCH v17 00/11] Rename queue number to queue index


> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, May 4, 2023 9:46 PM
>=20
> 1. Currently, virtqueue is identified between driver and device interchan=
geably
> using either number or index terminology.
>=20
> 2. Between PCI and MMIO transport the queue size (depth) is defined as
> queue_size and QueueNum respectively.
>=20
> To avoid confusion and to have consistency, unify them to use index.
>=20
> 3. Field name vqn in the driver notification structure is ambiguous as it=
 is
> supposed to hold either vq index or device supplied vq config data.
>=20
> 4. Device is really supplying queue identifier or a opaque data in the
> queue_notify_data register, and this often get confused with very similar
> looking feature bit NOTIFICATION_DATA.
>=20
> Solution:
> a. Use virtqueue index description, and rename MMIO register as QueueSize=
.
> b. Replace virtqueue number with virtqueue index c. RSS area of virtio ne=
t has
> inherited some logic, describe it using abstract rss_rq_id.
> d. rename queue_notifify_data to queue_notify_config_data.
> e. rename vqn to vq_notify_config_data to reflect it can hold either vq i=
ndex of
> device supplied some id.
>=20
> Patch summary:
> patch-1 introduce vq number as generic term
> patch-2 renames index to number for pci transport
> patch-3 rename queue_notify_data to queue_notify_config_data
> patch-4 remove first vq index reference
> patch-5 renames mmio register from Num to Size
> patch-6 renames index to number for mmio transport
> patch-7 renames num field to size for ccw transport
> patch-8 renames vq by its index for ccw transport
> patch-9 for virtio-net removes duplicate example from requirements
> patch-10 for virtio-net updates rss description to use vq index
> patch-11 for virtio-net to update cvq notifications coalescing commands
>=20
> This series only improves the documentation, it does not change any trans=
port
> or device functionality.
>=20
> Please review.
> This series fixes the issue [1].
>=20
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163
>=20
> ---
> changelog:
> v16->v17:
> - improved item name
> - dropped to itemize two normatives as it reads odd in the pdf at start

Can you please start the voting for this series?

I have updated the latest links in the github.
https://github.com/oasis-tcs/virtio-spec/issues/163

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

