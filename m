Return-Path: <virtio-dev-return-13265-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0C9EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:46:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B40B1190922
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:45:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BDE698680A
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:45:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 87771986728; Thu,  6 Jul 2023 16:45:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68F9A986729;
	Thu,  6 Jul 2023 16:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6ku0tyVBd3fN0zOqkIqtdPJmpNHZI5Tvat4qLp3a9w4IISgMCkwjFih6F5CMr3a+cZl7ErCUG/U9jtyrQACSklpxF3SMGvfVDy0aZQOMmlUMKyinElcNElE1lpVi0oNHRurFcbJ3zFoPY5CbQIEtRkiPPDqrqgZO6YpnT0/k7gPqbLVByuTMJnJDjrmomZYTH6mZ9F+zflD98rJWZUNttqy5rycqvnWmtcFGCUnPrXYSSKa1ExRNTVYkTAPSEmPHjlnBvGId6SMZUGHLI3qNwbcD87vYG3D53fWrQ8wla2yYrK9D7BcBim37FZFhlmw0IpuUE3XahwMnN07hrD/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npEtcR0VX/VN9JW8x1tmo1bFfZKSsobeymU9rdJU+aw=;
 b=Y2hJwXn2bVUcYFc40ok8C4NZeILPptqyRRvkeDAiIMj/qRYy9ZNAS937sQ3kGxzn8Fv4QIA6pTqo6IPkJvQcf+tuqSZMNo/LuqhfLJ3uPKxCPxbqFBs2mS4/jxwDODjHODRz/692JmxgBvDp/LzOIm5ypsKcpUdryYjLv5kzNWnPKx4PtlWPJ7PCxqWZOWo1Xv+5AmPM9FHyjNl6JbTNm6DbZ7EiVgK4PRcyy7YXKv3/8R6RMExXK4qV3p84tKPg3f1Bkc4K/3x0qG3NJ8aYvAYYpHhjFrfSKOCvMQMVW8Mqkr62c3zrd+CSRwC2idxwA+4CtoyUFWiay8h+U0Qk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAADCYCAAAC9EA==
Date: Thu, 6 Jul 2023 16:45:50 +0000
Message-ID:
 <PH0PR12MB5481FC84712B83663691BB5FDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <20230706123220-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706123220-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM3PR12MB9392:EE_
x-ms-office365-filtering-correlation-id: 708ed42c-b94b-4aaf-bbff-08db7e40750c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NzjYSWUAk8/5WEDQQInRIHMS3PGoyZVqwE6EHGDI5Fp0l0fXwcBNqqIOcfczN8S/AHtbiZd+mDcAbIu0b+Xs3xhNTFR7rl4jmkxG0eF5MbQKi3zyuCyk86764imZzVeJT/1qc1DW/kFJO8xbTbSEzVAkGqwQ0vApLS+SxnuYo+tE0NRunptTWLSBcesT+J4l4ZOpPJnwBe2C+LHpuZZEFCagf40gLCn0KEsHHBGesh19Fw25ANqqTuG8ZTm2NIAbkb7atjaPg/YvIo9J19KPmJYYy8B1XYZ3zyGo5mZWgp1NPldGDi65Y0Jd41gOKvUoPJLBTzpGthA6oxjht6UQ2gAZ4ytcWsBIT2wM21xKtHM7G9rrUTVL69li/xqYcLA2si8/BGpxKrmbEkpGIjvL1D4jcC/x6nELklGBL0Ns9w9mG/W4XZmZUNJTYSfS2IBkv8Nb8IZNNhw2NGX0P6UKMhgm0sawp7VFCYlxjvNI2A5TIXEkTBWgMMKCHQlcFWxPtvQDFkzTZq+DeU84A9PFsjWeZqr3POrEJO/cUcGnrz64S2ZuD8+EXT0IxpZ2AryLcKkyX9GDkNCfeclRQEpnUe4ITPkFVGz6RMBSSKzzK8ep42WF4n2iWCAWQDfMHDow
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(52536014)(38070700005)(86362001)(33656002)(2906002)(5660300002)(4326008)(55016003)(9686003)(478600001)(186003)(83380400001)(6506007)(107886003)(54906003)(76116006)(7696005)(122000001)(110136005)(66556008)(316002)(71200400001)(38100700002)(66446008)(66476007)(64756008)(66946007)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0iNYS+udHtX+MMED7luL7mz6QiWR8pM9gUDrifJmRstlumRmcg18raP+TjXN?=
 =?us-ascii?Q?d+rbpsXno8F6iv6SryZRcGBgCu/6CTfMVwNR9RJFsjUmINOemM7RrpkGcnXT?=
 =?us-ascii?Q?PS1sRj2si38peLA99NpJSg30UwrfHHiXKI4wq51bEdPtgnamggD8qDNr66D3?=
 =?us-ascii?Q?G2DVS8SsJ3DAiC+aBQAVj/A2eZ00bXmkTR1OlSjPyp9CdCKHkIA5h/fZdPwx?=
 =?us-ascii?Q?4QByg3CAjltsTvc5eNlGGI7YbpjrkCPS35zSBFPJeb1y4s3550eNP+wvG6yV?=
 =?us-ascii?Q?8Fw5L8cSPNE8iUWQuwCNE5gWlHNTF4NDPtFAf/ZN763fHrfHEO+dOA0UeS2b?=
 =?us-ascii?Q?zM2Jck4ipELWNqy9631DbAc6sKs1bs7Cle8LlDYBsq0o+gV8pdLjjHd0nn+a?=
 =?us-ascii?Q?WXwCSTbeXFDDeEVWJFti/Yg1NfRQQmR0OUgpej2/JqkmWfEEY+xkFSR5DLgz?=
 =?us-ascii?Q?Wo/cUDvcGiHGL+re4rw93MVMmPFnccVTv3sbq7DjXtmUfwx6mCBXyvRMiSK9?=
 =?us-ascii?Q?V0Oq1GvRHWdPsI8059Mx+G0Vwwd5OF7il6PpXtSi+YHxhbdlwPNB+TtpxPh6?=
 =?us-ascii?Q?CyptYeIPIeDzEaF7JD8t5ojCcKzXqmy6/pUFO7itsRYAhHBpB52wuhB/aKZd?=
 =?us-ascii?Q?xyeo9f76hnYga9lz2eyuXSfk+M2yaMIn1uWyrNjAu/59I8K4BgS7O5tf6WI0?=
 =?us-ascii?Q?TuMqMslkH0FbHCdvI277fav1RxQ29AFMQWt9fZxLTR80NBeAaKAcSiqX+oAw?=
 =?us-ascii?Q?xlAkx0OqUMT0jbW+0aRoGer/j60Tpx4UEfgqJh9c9edezqNNC1TmsySUbc/m?=
 =?us-ascii?Q?soVs6tsHIlR9ZZfgcMUIMfq4WeFvfsk542kDCYxm0TY90AWeu8avvCfo/mXD?=
 =?us-ascii?Q?FsHvJp+o7TbKOAEAmARtKhTWJCU+MvEaCmr3UmTb8h3t5MrmI7wbe04VCksp?=
 =?us-ascii?Q?z5HlQz3DcsEACsL45sOqL4ZaRLN7HYlL3l3mFTOgZ+ud9ry5+cK1LB3y/xSa?=
 =?us-ascii?Q?ujNFC3sA7/p0ysC+8Lsts7yll3jufwSFiMgZntDEJNliS3EZfM4SCdV1e4Sb?=
 =?us-ascii?Q?4XWwA/cQY5pcL/A5eeuJD+aOS4XVHqapioPP2CrJDzBW4O1C8M0BojTTkk5M?=
 =?us-ascii?Q?zrKK9H6vnhVoPSdQWx5QMG4uTKqsA57HNiX8Bfy0nKEA5fpmK36gyt0Zyx+E?=
 =?us-ascii?Q?G5nObBHaURZtgk0KyLdGgLQP/UlLgoEKFh76ias91CLlaM7vkSlTtUmJMmPw?=
 =?us-ascii?Q?D4a9axfYdMBJ3FdIlbgUFHSJjaMK/8NBu4FqP4p77C7Ig2xy4a3Xgtsu7wDq?=
 =?us-ascii?Q?4Nd1cUYOi+ssvyX2v1qtAKZ76ZJZqH7aBq52D0hcxKzcr9dXQ1xk/XnZWSVH?=
 =?us-ascii?Q?bVKUuKz7QFh0N2TMMQYr18KasfghCfbmJEB1WWEjk5IMrEmgYPEyGZh8+o/U?=
 =?us-ascii?Q?0vYHSr3yRilZLmMAjH4Xa0N2xFCKeEbeSxsnqJI/cde+xTbrC6OC1B0o4NYZ?=
 =?us-ascii?Q?lu1C1ojkEwPPr9770dw0LyoT0GSozDbIn3zw9OPvyeFBYiG+xezFMTjv64T7?=
 =?us-ascii?Q?gAKV4pIniUS6ZqHchz3GY8OYlaJ8mXWKt8C0oZrRFYdIxTxV7C05Nt4Xp6+W?=
 =?us-ascii?Q?OLNPmvk10PtVEOmeLuNg4SI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ed42c-b94b-4aaf-bbff-08db7e40750c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:45:50.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQUk2flkdfOfhLhpZ9sCsaa4W/ciBO3Kync77iBH3/E4hRDxNFtN15a0iQp1wr2DoEiN/7H1RtDUn5CJfdoMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 12:39 PM

> > > +The group owner device or the group member device or both MAY
> > > +support driver notifications region.
> >
> > Make this "a driver notification region"?
>=20
> I think in fact for conformance we can just refer to supporting the comma=
nd.
> The command can return an array of structures, each referring to the memo=
ry
> of the owner device or the member device.
>
Array and referring to owner/member is already present in this patch.

Do you suggest to drop above statement?
=20
>=20
> > > +
> > > +For the SR-IOV group type, the owner device supporting
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > > +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> > > +commands and its member device SHOULD follow the rules for the PCI
> > > +Device ID,
>=20
> what does "its" mean here? Of the group?
Yes, will change to the member device of the group.

> Members of the SR-IOV group type are VFs. They can not follow the rules f=
or
> the Device ID: the spec says:
> This field in all VFs returns FFFFh when read.
>=20
> Even if you somehow refer to the software it's extraneous anyway since th=
e
> spec proceeds: VI software should return the Vendor ID value from the
> associated PF as the Vendor ID value for the VF.
>=20
> We'll need a separate statement for Device ID.
>
Will split the line for Device ID.
=20
> > > +Revision ID and Subsystem Device ID of the non-transitional devices
> > > +documented in section \ref{sec:Virtio Transport Options / Virtio Ove=
r PCI
> Bus / PCI Device Discovery}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

