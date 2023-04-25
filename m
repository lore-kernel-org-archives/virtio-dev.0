Return-Path: <virtio-dev-return-12408-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DB6C77B76
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:38:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EC3232CADE
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:38:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2D2A98646D
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:38:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C2E6C986447; Tue, 25 Apr 2023 13:38:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF9A3986449;
	Tue, 25 Apr 2023 13:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI+yi+PUUZK40xv4XSf7mV7Va89gySLJH81SdD1+oXDEnuGXHqXl3CgjaipvATJd84n9dJCVw4xTA+qhZpIqDVJJni46YpoC5AORykKAO8iYG6dJuoM90SytyZyMZ4NBz5tKWAk33mqojsUaWwys1LZQOOs2TgPuRkOq1IRJiP7WtaP7djF2OV43wFkinrmOzoX19rnIaHGimctFsmAGA/+GRV4zBHevvy6hYgplL5o2Fkhe2OCCmn0cO2nrj/aD39rTPd/La0kAwZ9GKTQw6VxdqXuqlYd2wDevWA38xtTpzjvGMDp1Sf8XzXyqmkNRSZNv7l4/EdjWNBU2wtK4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2v3SjmHrT3UxkcPTuRkF/+77I9lPKLJWTUPOjptD+Y=;
 b=kNBD0iGXtVyZwQTRodCwBobh5DUbqOy3SkHOI8OcF2wA6PnKRIURP/T+bCb/rOCAPoYYcjVBfb0J4WQHGaEd1th45xzCIOmnZMiWZ4Yzx+DEAgP3cjj4mcK7z3GeELAcxLoxnIkjFrQ1Zkf4fyAzkcMppRB7BdOA6T5n4zLF3CpMUg9JYNkM0+lCWbQ6hZ+IRWwu5LCd3xZwDNSBeR+qTPnS2vdvrvrALwabZDao8vVaNNMQ7QhPEYeIF3dlpAY4CaIl+0IfgSODJAidClAFVooaqv3q2EKLnIvvvgbzqbaTEOaJq1lhHYOKRhSxN1ZgLwnIATj6u6TSte9fEpc34Q==
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
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v12 03/10] admin: introduce group administration commands
Thread-Index: AQHZdswMuKG6jk+9I0m5FI6AWEnz/687YNgAgAAtfwCAAHQjIIAABG8AgAAAneA=
Date: Tue, 25 Apr 2023 13:38:21 +0000
Message-ID:
 <PH0PR12MB5481BB7BCD1D9FF68395633BDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425092651-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425092651-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: 7d760770-ab46-409f-5258-08db459255ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RXgWHb0IYpWMyu7V97yXXZgDCqRhp9yZzoTGf8eAMbBuGU9qjxRd9E2pC2F5hzcvPdGm7bomRg0S50ZXy9hhhFaBgWuZaqvoitDV5i/3ZJvKh1tf0F0TA2Dnym/2sLUc9B6j+FHZ8O2njeSgxe1cnBqm2oPKd9xYCc0GlgpF0+kzdtKCIebeVfrDSplV9fJ74zZ4NYn0XiJIzQjqwaynUWmPQ+mGDj/kiWq1EGbIC+a5mSzjG0iqhWT8bFtXAhIVXjKG0n1zWGhVQCzU3hPIuHMHtXw3c6b6sbpccj1eIiHxDS3ehBVi9dkCflWiRKRGLwHNMLfgJrl8tDgSaKFN1/McQ6jssTlrHQW5aY47XZq0s5iArsZuaV8x50AkB3OgZgvbyLTCYDJWLZvsEg2YkOchKn1CeSnpWzJw0MuApGQEDRE3UUrJdykH6rirUt/BYv7wOmIn2YADOaZmr6FmYDrJY/OKd/SL7e8Nc7k2lXGKFv/gGJJ9tZO7upD8E/Bv9Z76CmsLGhAy1ICZP2fCVePYFv6sYsdzPCtpOjB8fOcnHWt/yqoWldFnfXBHQifdV5eNGLTrd7KKcE5L5nmfzg6MzbnTtyzbEvz9I/Iknnc3/S1z5dPdIqIdvc4Svdq7Eaz6NwFLq9ASrQRBS7dvWv0bHtbZcpWWokMtLuJnmyQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(8676002)(8936002)(54906003)(38070700005)(478600001)(66476007)(66556008)(55016003)(64756008)(66446008)(6916009)(76116006)(66946007)(4326008)(7416002)(122000001)(316002)(41300700001)(2906002)(38100700002)(52536014)(5660300002)(86362001)(186003)(966005)(26005)(6506007)(9686003)(33656002)(107886003)(7696005)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0L6n2KBnCknKpIPWv7WFVEx8wA4YNLYGi2fo7t56DtCmtSokZxahWmVEsMj8?=
 =?us-ascii?Q?Fpl6g8E8X9E+nRB/ls5K0RviH2yIJKKrnwt0x3WM6RGC7YmhmKq6kJq/GDfw?=
 =?us-ascii?Q?rfHmRlURvi7OB2WHxKR453Rw7+6dDjc3hs2y+mKbBkXUvSUox5HIxLaipKvm?=
 =?us-ascii?Q?dMAO/vcRE+bjEjRI1IrKh5N2KQ7cTbGpq5vY4nUwGS0T0dKl4TK2rQrbHs4j?=
 =?us-ascii?Q?CU3wFT860pFhXIIFtIovAquIMmHDQ3dbJbzcdfOfftFyeVyo9FcyqWcdmlSk?=
 =?us-ascii?Q?XJ3z90z0Z7oeY/EF8koI0SLXx6aGcDT9KAe3KqMHwVPwOW7zNhY6Z7gmgCRP?=
 =?us-ascii?Q?glRq1eFnbDsyZCrYDvG+AtWmh4sBf1W6wvga0o7jo/HloGbKYaKLfv1CoFBC?=
 =?us-ascii?Q?KtDw2JaNX7fsYet22pzIAynLDemjvV7jVq/al0z3DT469ItwMDzOM86Z2a/t?=
 =?us-ascii?Q?Jcbcc94C2mBVDnJVPq7zyQ4cQ/yxzT1P23tDknk/BKSM3u83YmKE02KYn9NN?=
 =?us-ascii?Q?histtSUEp4Pcq1NdmuS8Tdk7HolwUGxMSe/WB08UVt/YnGAkYVrf2JxfAX9N?=
 =?us-ascii?Q?g0jv6J3ZVBj1fjI9TOthZtJ/2YemVvJy3Vjd57kHSTdb5uBwZUFgkMREK709?=
 =?us-ascii?Q?2WbQe2fp5JoiigX8WxVATdvdaqnjEvgl6+dtNQva+27Sxk+YV2+mwaIG8vHy?=
 =?us-ascii?Q?13aQhXJfr1xX8Uph1X/zfOcey2vzvm956nX/dLV+b/gKIu4r5ugQngDV/azR?=
 =?us-ascii?Q?QPHQwsX/tRvxXV3NUUCQFIsNKfjD6RALmCCy1JN7MQItvK/L9Q+FZO3OF4L2?=
 =?us-ascii?Q?PpLOzcmHjRdcIyhWs5QfjDu09X5xO8jVn+Qknu+o3r0ai3Gdk9J8+fO43xNs?=
 =?us-ascii?Q?n0F8V4NZ5+ESf0r7Ear1m1j/FWXeLEgXBLDlz96gebbB9YTl1gfD//Mc01Yb?=
 =?us-ascii?Q?Yhy0uVFmHlLJGbo4aojaxq/rrH0jo9/wgnLIFYnik1i4w7dmR3Ke4yQUtYQT?=
 =?us-ascii?Q?sLCBf+X1Hl0L65of5nK9PHqR3X6eekVZLVwhjmYm+VCj5rXoFi2vpmvV4G/A?=
 =?us-ascii?Q?v9601OEjK6qzwKQLwGSynWl6DOxYTgH3mTTCKJ1K1u0UPXoZTptUVkvnyVlS?=
 =?us-ascii?Q?9/pzPFNpekIPbPqt3UgptfIszbf0Zx9vMtdPuUBPMjfk50XXH2AzE29156oT?=
 =?us-ascii?Q?RMChim2gVwUAdCxpZiOQiIYuNJkI10iiSXu6BF+E+DXyC9awLG66NYP09bmp?=
 =?us-ascii?Q?tv0OjoWmXpXj3l/wPH7f9syXjcUcWeqqXVPbEt1uOK9pJHqi3BZNdaxQiQag?=
 =?us-ascii?Q?TbwnE9eame6pyTac7fnAkwKKoRbtvhlrgajo5zlK42nkNgH1wc9ZrKkawkpB?=
 =?us-ascii?Q?ehuIaZtQqI1b0BfcIc4LCFelXOrE08LPpjbRqCbPsffIiBH4DtppfhnF+U68?=
 =?us-ascii?Q?WdXnXX+OO9tsvio2lUZjwYjeqM129RzEy4ISzmJ5v8uc4f9ReWyyC30ctQuz?=
 =?us-ascii?Q?o50WUuyHeoIvmsIY79N0mLDVgQMKUASN2Q+SIgkADbAiXtxmKEVp8paAsD/n?=
 =?us-ascii?Q?r6o5LuunTMUL2MlHHas=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d760770-ab46-409f-5258-08db459255ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 13:38:21.2157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOeT5EWvQcCrpK+dx5dkYrbnIxHKT9MYlUx/c7ewdYO19/fOvA5V7iFqiFryTsj7VRRStUpX3JU1CLaA817hYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
Subject: [virtio-dev] RE: [PATCH v12 03/10] admin: introduce group administration commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 25, 2023 9:32 AM

> > I am requesting to drop the commit point that limits the usage of the A=
Q.
> > Do you agree that AQ can be extended for use beyond VF and SIOV group
> management commands?
> > Or one should create a new VQ type?
> > If it is the later, I don't see the need of multiple AQ.
>=20
> not management. that is old term and indeed too narrow.
> administration as in hypervisor (admin) access through PF while guest has
> access through VF.
>=20
> legacy access you link to below seems to fall within scope:
> we access VF through a PF.
>=20
> So what is the problem?
>
Commit log confused me. You clarified above.
It is clear now. Hence no problem.
=20
> maybe we'll change the meaning down the road. I do not see the immediate
> need currently though.
>=20
As long as we agree that it is open to widen the scope, it is acceptable.

> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202304/msg00511.html
>=20
> Then I don't see a problem. It's just commit log, not spec. Let it slide =
is my
> suggestion, this is spec text not code.

Ok. I feel it is still worth to have commit log updated. If you happen to r=
evise v13, please do.
Else its fine.

v12 surely doesn't merge cleanly. So v13 is needed anyway.

Can you please generate? Patch-5 of v12 fails to apply.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

