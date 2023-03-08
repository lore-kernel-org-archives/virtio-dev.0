Return-Path: <virtio-dev-return-11554-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E56C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:45:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5C0D92A889
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:45:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5451398670A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:45:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 493B0986416; Wed,  8 Mar 2023 21:45:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36E2F986312;
	Wed,  8 Mar 2023 21:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGkquzE8s2hD1+ahVbvcmu3TbcV4HQMbmpFZgI+oWTqPkyO3H+WIduxbaaWVgFLM8GXNo+iqqy7wYPUsGeRuGFOq9NV5atubu6PS4y4iVq5ao7m6GUGtmN13nLGUAK+z04+IHVUSYhkqAk3jQ8sxCNf12NI77zYv+TaWE4VRk7lS3Mem1rgXvqyE+RMsXPwJrBRNh/zwkhDwwNi7+4c/l3z3KyQS3+lQy2JFdcSRRzTRl+0xhJwVEz2xTq/DdYIzBPES5fKmACUOHdNwSmnmgWfNFncmvLKDJYUzu29+ybexa34NDtL9uyIKAyFagzHJyf9mJCEQqUJJWplMDWClnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYlevB6V+c1YuEQWU8bB+Rqv6ku5SK+Ml69jOt7dn4U=;
 b=DVwmt4Kb4t+nKzBRsc2UjlTeOBsbmJSm8+WEtqQpoirXCxG4ZxXuTpVY5xLRoa9gPH2FqSRlWpsvZsVbJFsIh2UqDar+oO1LEWy0Y6XCJ7pkxZTghOQvontjd7DHD59s6fY95qVmeFkyKvG/Kxsxerhz+4bg9cNuUrQHm9N37UX0Xpxba2TcTBw6/CCsmNy3rP0ya7ZxlniuYVhQ2AlPlbqMq3OIpKqKAa7GKT+UsxP8FkJFerlrsewGvbLZa4Cic3JxjTDgcPhhsMKozsYbr/AkCvCdPaewgqYGnVBjNWt4H3iLxs/VI86C0F/HAbB5HhRTPKEvNNpoQFbhBXmufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index: AQHZUaV1hq+swD5r7EeFCHM9rP6wha7xaNIQ
Date: Wed, 8 Mar 2023 21:45:18 +0000
Message-ID:
 <PH0PR12MB5481E320D33B4594F050B3C8DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho> <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho> <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
In-Reply-To: <ZAhdzCd6qwWydesz@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5266:EE_
x-ms-office365-filtering-correlation-id: 13cbb163-5208-4583-3e07-08db201e6912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JbV3aanPv8+jkCnwYvoKAVnvSqKcZZD9INReiUkS6qnr4XnOgP8hLl1AAfelrHOJaEt4tYIcoywdkhlD288cgkaoHM3+/75NAIgejlzHkx0s3971hhb/N4ubTD+Nlgwn3iBmLg909o4K/oaMRfBzj/wzUugChh+D6la/+tYeE49jn+/+pWy3bkI8Y+vg3PdSOhXtT+LbcmtJUXNDf2Z3SLXd8NhsTK1cjfL4YSKUX3q4CeFVj5Psy8ihNLYSp3BF1Fmd3qpygHgfQqpGoTUZmsJt8wizoBmCe8nkTxKEQ+FO+bZo6yTGvFQPIDkrNPp7Wi8xI9kcvlZy/FNuc1xCa1aut9755iFkngL3tS0k5dF8ZnkVWeAHA7Igqm87nCCBrfL9Ms2TTvN6sUVeqoeaeISW9yGfqzIcbZfGi5HihpVku+A5zwKq8YIGq+3Tu8RXm6haehknVUFEQwlWFAbaDOQm87zKaq4ehiQ5USvL74OZBVGfpefVLW5pnKAxHU+2+nb/qdYSMZu51HDE85gyE18/c8zaYZXAEz1yX6qhTx7A3Itp0kDM/wh3MSrFQHUuVQhksXavVgrF4hxiYEZK7eAaBXS4eqc5COcsKpXoyMQuNyARDn6NCAxGooSn4tccaozkGbyxMYajPDaoiXKqxy1OHeQ9VrCCJ6Rey2mBbpqfYMObXRdPt7P9eyyYsizSCY47E200sPV1YDlFsF0P7A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(478600001)(186003)(122000001)(71200400001)(54906003)(33656002)(38100700002)(66556008)(55016003)(9686003)(7696005)(76116006)(66446008)(66476007)(66946007)(8676002)(4326008)(64756008)(38070700005)(2906002)(6506007)(5660300002)(107886003)(7416002)(52536014)(316002)(110136005)(41300700001)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IofyJqwI1JpSMHKWldm62xA2hW+AGunRxcxyqL5vyDsmZvABi+GO6KA9cmdL?=
 =?us-ascii?Q?3K9nEh2hjbUNsoDCGvgprvzTz+SMp1zMC0owCTcR7bp2/0AsHYwxaoTxTVe7?=
 =?us-ascii?Q?9BG+9nwbN7tBMWtfIfSMjLNjdnWNKsZUgcU7vGEBHAb4TTPLnrNvsbqiIGq3?=
 =?us-ascii?Q?suSiaGN8EVnjzyWP1ZhwwKoSv+t9HDkixr/vuGkP/cgRXMxVEYorGjl/7SRy?=
 =?us-ascii?Q?EwQZPVo2xsTFllvv/rQnVBXd8sN2oMsjzsVYAT5x7bIc0UFwKV/Xf0WPHiSF?=
 =?us-ascii?Q?pVpMRh1cobS5/CklYxoDtQ7SiVhzJoDUpMPimvXJbRbCwepJl5e3Ho6Y/6yH?=
 =?us-ascii?Q?iuMw5nG1zoKkuXpNHkGNCC91ya8X8LNuo+c/GhuVBceffRMpkX0DqfcoUOZz?=
 =?us-ascii?Q?JAtrn1RG2Pyx0n/PcYGxqNuU/gFCLaLPzWsjV1sVKPczkfRYv8sMQ9yrNMsI?=
 =?us-ascii?Q?NFS8Gvu50b69eAoK4W0AHJSiQmNpg8eJgSakWdMixrk6DQ0aW+cyzs0L+xn5?=
 =?us-ascii?Q?eUCEL+fmOCLJcjamyL4qi0CJ/xIt7w6iPB+fsZ3iXb2ooIcj2lS5g/64+fAW?=
 =?us-ascii?Q?LEYUl9N8ssqc2Fu98tBHDZIhyAMSB75goklqJAmNYwbLb5tPHuI2I6eHmXi5?=
 =?us-ascii?Q?P3wePbzqyncF9jHCwmyrMfhRB1jR6KKT430Bkwn7qnr1LEPXT2Viab93sWIw?=
 =?us-ascii?Q?pMvf3UsgMLWN3zszjLPz4O0ipH06PaKZ8lI654n7t0toBYgt61LfiVArKLI1?=
 =?us-ascii?Q?GJy2Uh5cGNed4cuAgHWBy7kRUmVru7MxkIOuxjlFvif9GSot1kprHNHcut0J?=
 =?us-ascii?Q?FSi/n0X0wg9f0ozRb2IIcQ+w56mS50A63d1yvQK19MfvceFhyRACJIo5tWUK?=
 =?us-ascii?Q?IhDgqnWa7Sbv+sntCFBZDupn6jVmL0S3vPOMcdrDeYqGcAAxN2WVOT4xjFXZ?=
 =?us-ascii?Q?BVo3P3tgJaSkWmEgB2oM/9lNvgqc0oCbfG0nsqM8QeQfLHBHCAYZwmWFFQUa?=
 =?us-ascii?Q?9oHKC/uBOut8Jrh57aGCJcu6KSYPMGbOIZQFu0AKAtmD9JjvH+xqkhz7DCZG?=
 =?us-ascii?Q?AzWsQrnFn4gHeYdT3Pozcf0C93TR8GCIMbybvFRAq6dmTdE3O8/56cMv13ey?=
 =?us-ascii?Q?+j+dM1/CkPCZUVhvyS50ewyNlTRLsWegc1zvMc88yBOD5cIRP+CGGXKHtVdN?=
 =?us-ascii?Q?xodsIL/4bT5tI3c6IjU4M1zQVAs54GjfPFVWsmaFBjG1OJdDY+N14I96huKt?=
 =?us-ascii?Q?QD7cJAG/e4i3oeNbRD6Ul3I2ETvbYVMeigGFNRbVUwCKAwWMsY4qxpxNaFVJ?=
 =?us-ascii?Q?VZUSe4YjHLQKjNgl9yGHt/l9R8ybp96MH4ycnHEdivK6lJDDvT6BcciuNHGT?=
 =?us-ascii?Q?6dFmP8kvAYQJkwlJ0ZE5qWxy69eLbxwO/NohsDnlms9U6y78TaKCQgAZSI27?=
 =?us-ascii?Q?uNZ3QOsEsNnBfe3PhKWtQt3kI6FULLulnAbu+hJaCVreTFrh5o7qcW/MUCRk?=
 =?us-ascii?Q?/V8+CRpLyndZAm1d27PB1NCq87RyYLUmP29iYSwNHL4ajmywtYwbZ4BlN83I?=
 =?us-ascii?Q?mbib+3e7H81KqtvJFTbvT4V7zrUNmzaNpXmH0c3j6UJ9DgUyiGI0p9vkQuNW?=
 =?us-ascii?Q?DdbHgT/R+Lpb2+Ly/Xa4KMw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cbb163-5208-4583-3e07-08db201e6912
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 21:45:18.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOcPuRm3AaJDPSIzlMwyRSVSehiJNilJDaDvFDIvfnfm+oTxFP87n76ufE/o+kFtyih6BBrLFTs46SV+9AhRFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues


> From: Jiri Pirko <jiri@nvidia.com>
> Sent: Wednesday, March 8, 2023 5:05 AM

> >For example a common feature is to program a vlan and have device put a
> >given VF inside this vlan.
>=20
> I don't follow entirely. The way how the VF is connected to network shoul=
d be
> ouf of the scope of this interface. The eswitch manager should take care.=
 What
> you say sounds awfully like the "ip vf" legacy interface, which should no=
t be
> considered here I believe.
>=20
> If PF would be the eswitch manager, there are other means to do network
> programming, using eswitch port representors. But I don't think this is t=
he can
> of worms we want to open now. I don't think we have a usecase for it curr=
ently.
> Am I wrong Parav?
>=20
>=20
We want the ability to program/provision the virtio feature bits and virtio=
 config space parameters of the VF through PF.
These are host-facing parameters that usually migrate from one to another h=
ost when a VF migrates.

A future device may even do this out of band, but we are far from it.
At that point in the future virtio management device can take birth and do =
things over it.

ip vf was legacy interface and it is not applicable here.
virtio net doesn't implement it either and I don't see any user asking for =
it either.
All users have migrated to using tc mechanism for long time now.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

