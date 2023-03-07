Return-Path: <virtio-dev-return-11490-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376DFC678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:52:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B9882A821
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:52:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76BAF9866DD
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:52:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6B61B9864DC; Tue,  7 Mar 2023 18:52:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5460C9866D0;
	Tue,  7 Mar 2023 18:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka+/lmAzBYXF8VX0LO6OzuZGOEzS00yu1+DFQWevXccNvZsnK0o4Na6bQ7TiqmqGNaObdA5zJivGJzV+G/Epi83gPRkqsIUh1/JX8B/PwKvkgaRpMchFLxX6pFcSI8K8dG4ejv1In+qv01dLRQu6LgatX7MURSri51PqLK/pK7eNxJqYLDo1di1aeNNStOTYLkuSV8HXM9sF7jQXvscc8DpwXMOIPQL4jyAD4BD7I4zkkQChO8Svrw4VL/XmGt2JJvhSJjKeZc3uTidMTNIAKsupcCaFT9y6oBftvrA7KilwXfC04n7R9flvrwy+eqVMo3fs0CVctd9lvPRPWS6+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AinydvAL53K07UbjljhqR7g8k/wM/eyINuCbNtOn3HM=;
 b=FAZKGRWrajngBJCvb8SoyoKwMqJwYkC7B457sPZD8X3uPSlV/evXTu7kZqJzPTEuPjgckJIgDEmYuEDROZqr5cqPR7PLnjVANtHzhtNeIcsB9pSzPzB07xXsqJ83B/Ewyx7K4HzDOdWgLqf6zQG/h1SZICpJLGcNKjSlqCqRQjFmP2srgi1H4JYVCXcZbG+A5cHUvBa/OWiWvL712RQWMKkq7qhutjMk53vMFzdZjfjV3fBXNSFBWX1JPSMOzZVzgPwOOs8ah7TOTw4OkCHAmpC6T9B0V4CVQzgESjcb++Invr2nzD6cRrGFk3Sp8//nh57+1I8yqVVuyuJv1+xneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved
Thread-Index: AQHZTQelIthVWRw0HU6AQhgBU7+T767n0VLQgADqfQCABvOAcA==
Date: Tue, 7 Mar 2023 18:52:03 +0000
Message-ID:
 <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230303032434-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5949:EE_
x-ms-office365-filtering-correlation-id: 2123b855-a203-426d-f39d-08db1f3d0ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IAKGHCkUie4QnIAxs4n5aVMap4o8ui9lwuQDyu3Pj5uzSZFIOL48lWazZHmKNqvO3GQ/pjc9JRSO8fc5dcRNQfD4bITIXhUfCbMjBOpPmJV4WbqN0wrpgMTiDVmXNg9IuuHJqLR/g68F6NtxuqL2eRcvE0spWUX/e16eYSvIM+X1SmvY5UR/RzgwqEFWhpY7yoWdt0RRgXwiNhvAvQLtiyJ4meVcdT38oy7gWN+grTcdQSKwPFaoy+xVQWKCz1weY0eZgavHo/apQvnCat5Y/wOWXOti7MPENN+1kKt6lu3oMCKwFQl5x0W5C2HKJWrDUZ0a2CywG48ZadS41eeSiH8HXxlWXkVAVSAUZWAq5+NdjFL2ymMFQqTtcjRyJyNKg4SHdMNddm83XilFYsO2gpMda9CULMaA8kHhRXHtDjpCOZsUHC+9dpa/Mppg4FY46YMor7dyrrjJaT6ONtHneQ9FRgpzltN3I17LDD3+AZJztlNIZmXdMk9VHyXhMJ3VFw1iUmOaZ+4CdqOc2XX1eBo5PEsD2D4cXnStr/253WTR7d7WeKfSF/L54CvunWMTQAP6V9vDaOoQmpZoqnKpf7uNFyVti3yfVylpkpd69IVzwmBt8urqcHY/2V83EZL5XI4LidWANe/g3TuQ/hjcK8niyoNay9wbGNIi+7QofNxmKl2DsVb/UEhKyaWbM0VdKJaExm4ZZgXfdSNcuANknUf0J5p8waTwa3X/qzlq8Fe23x3ZCtiXYrDZjJsfRw0G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199018)(7416002)(5660300002)(2906002)(8936002)(52536014)(41300700001)(66446008)(64756008)(8676002)(66946007)(76116006)(66556008)(83380400001)(54906003)(316002)(107886003)(4326008)(478600001)(71200400001)(7696005)(966005)(55016003)(6916009)(33656002)(66476007)(6506007)(9686003)(86362001)(186003)(122000001)(38100700002)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oGh6lvdNDHi+Sh1lSvxG963MjIZYWjwOlrUQ9Or1DxqqAybH5FvUzgSWXo8v?=
 =?us-ascii?Q?f9uYmjl9zs0bS4ud7NS5pqVeDF0CyV6xQXOhvRDqc8PXyMyL83HsUcRKSkHB?=
 =?us-ascii?Q?7ItC69u26XxqL1/Yc+CJxvrk1KYS0uen+N6PqqXDpF5PgC6cRE8sqxfq6c9a?=
 =?us-ascii?Q?ALZy4k8YFxW8EqKz2C8J7Xj/Ia0NpppmAES/kv29yO4P0fPRxbH2XTY/GXSX?=
 =?us-ascii?Q?wpASr4K3b80Vbsyfcj3ATQpdfYAzKX+O1gcXGgSKqzCIFeIS+s2zfbPYDs2r?=
 =?us-ascii?Q?+MBtShK2mTWG0+3N30j090dN9Ofqnh1I98RrI2ZsquiubURhzirY1l28gJni?=
 =?us-ascii?Q?HtjDhKSVjzXin1gWmxxNIJ1Od+QPj/MYddqpwCayUeUPQiKCD0/WWWK277VQ?=
 =?us-ascii?Q?qa01r+7FQKM0ZR3L+of2+v+wOefEE7L1mSpJV5Abg0TFlZ9gKffz48LfcR4/?=
 =?us-ascii?Q?EWrh/k1lkiHT9b56rlcPK9UBuzvcPuYemfGgO4gzq193uRxE9BV9sZ0nqfMm?=
 =?us-ascii?Q?rtDb/tJ+fXAsqQaL73zMZFuQaYnQAS3hXD5Hp5ltfNRmp5NZS0LaAcNefJ3T?=
 =?us-ascii?Q?S9yrH1ORvSXhLSJ0zs9Pj8jo1bSaldCnMKS7HpLLyHPvibsq+X3WJJDznqFH?=
 =?us-ascii?Q?Nvp8lN1i6P/Ghfox0EIEWpaF++zF6gm1mw9gjVtyfw+Ul6dhvvm93jW/vgIN?=
 =?us-ascii?Q?GQmnqyVdiwlmTgvvZSitL9ZkBGn8Bn7xuAaWJEI4cLhhZV8iVXlqQWO537Ea?=
 =?us-ascii?Q?EQT7zBywIZOes0wSg42Xn3oAacwj1B+ED4+ur3iQg3GPWcbENLzyw9pouJu9?=
 =?us-ascii?Q?G2Pm1hE3rwOkgMf3TvxJp3/CnfaCIlT4yXk2p2dGFi14JYlkZZ79DnjAiubK?=
 =?us-ascii?Q?5RF5SXepuuKHVhWo8Y8qA5mgJXlLA+1ZGhzeuPGVwgq6iP4HY8JxOsc9Fu6X?=
 =?us-ascii?Q?RtVR4zqLmKFdeCtwLSc59xePTJBlfK94HWL+wZLrR6NZpOAA4HhLBowD4VRI?=
 =?us-ascii?Q?hCOAyP6MgJRfCTHUA+k9g7yb5F0HeoJ4vqR4yzfiUMZDrBYGo5zl/AD7hHc+?=
 =?us-ascii?Q?AJ+WQuvBogE7rdOmyihUTSvsJpcl7s+TIAyD+jRky4O1h07r3zPyI37H5TGv?=
 =?us-ascii?Q?MqD1mirwZCtvW2zAxITmoGSTk/Yg/H8h0lFIF9en/qiqaX42nFHRJBveur18?=
 =?us-ascii?Q?uUh3YBsmGO3RfZmuV6ROYZavpdQmuQ7tH3rTs52lWC1bNo6bmvTE0ghGli5x?=
 =?us-ascii?Q?y/YSD9AO7XABXQqwf772T+i6F6WLPclMDIVAWpk7R26Bg9k4s8EVMjYD7PmZ?=
 =?us-ascii?Q?dytOXI/Wk/mDfNxif4nDHE5Rtw/4x2JuR6OCyXJ8sr7wln3K/moqZYL2bOLo?=
 =?us-ascii?Q?xqBLknFvjAJsQ5SptaeAysgFLV8nY04mJZDK9o0FOJSqLbhue1txwVMqw30o?=
 =?us-ascii?Q?tlEMSmAfAAwxtawt5NHHINdQrhoIjunV70QIxUp3j0ttTPPTJCiO2EW2duPA?=
 =?us-ascii?Q?dhhunqKmI1lSUFIJjUe6YMN1/+b6al4tgyEd2yFkwr9OzsWwEpPcbyjjQQa2?=
 =?us-ascii?Q?na3hCphHRg6P/tiV82E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2123b855-a203-426d-f39d-08db1f3d0ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 18:52:03.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1fPvpbq+bbBfDRN6LEKUROgLPNfDVa1b1Fv9/CM7YJic2mCJ6/S1+llc8izAWOhAaIroiDEwM1krUNlJFCMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
Subject: [virtio-dev] RE: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, March 3, 2023 3:34 AM
>=20
> On Thu, Mar 02, 2023 at 06:40:55PM +0000, Parav Pandit wrote:
> > Did you miss reviewed-by from [1] or this is an old series reposted?
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00242.html
>=20
> As a general rule, we don't strictly need to track reviewed by since ther=
e's a
> ballot (and presumably people review before voting).
>=20
> People also tack on Signed-off-by: (and I do it too) but as long as we do=
n't
> document what it means it's kind of vague, and the process of subscribing=
 to
> the mailing list is a kind of replacement.
>=20
> If you think everyone needs to follow practices like netdev does, we real=
ly need
> something written up, and agree on it.
>=20
> E.g.  I work on the linux kernel too, so I can copy practices from there,=
 but even
> linux isn't uniform.
>=20
> And I wonder whether it's worth it - it definitely makes contributing to =
Linux
> harder, and even within Linux it pushes contributors away.=20
The number of virtio spec contributors are in order of magnitude less than =
Linux kernel or just the Linux netdev.
Patch split up reduces lot of time author and reviewers.
For example, interrupt moderation at v10 can be very easily split up where =
prep patch can have RB tag and v11 doesn't need reviewers and author's time=
.
Your work here with 10 patches is yet another good example of it.
I remember Max and I started with 6 patches... and current 10 are more usef=
ul way to split them.

> At least for Linux
> tracking history in a precise way is extremely important since it's helpf=
ul with
> stability. Spec is very different.
>=20
> Until we have a good contribution documentation I think we should not ask
> people to follow a pseudo Linux work flow with requests like "please spli=
t this
> patchset up" or "track changes across patch versions"
> simply because there's no good docs to teach people what exactly is the b=
est
> practice.

Yes, I wanted to update the contributing document. It is in my to-do list.
But given the small crowd of contributors right now, almost everyone is fam=
iliar with the RB, ack tag.
At moment it has two main reasons.

1. Acknowledge the work and efforts that go in the review
2. When in question, reach out later to the spec author or reviewers to kno=
w about context/design etc.
3. Same reviewer doesn't need to go through the patch which already has RB =
tag of him/her.





---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

