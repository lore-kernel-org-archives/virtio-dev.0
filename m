Return-Path: <virtio-dev-return-11540-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D56C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:37:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 04D4629FD3
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:37:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2E4D986719
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:37:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E98F49866F0; Wed,  8 Mar 2023 16:37:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D520B9866F1;
	Wed,  8 Mar 2023 16:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQYnMjlvqmpxPxEH28GcfOFCCxNCIMtv1Vw7xqyflHrAMTT2LHm+QB43J5u4HRjAYz9n9Blhe2V7fII583a2q8M78syTMv/rR69hSTZ9HjU9SNCWx1Be/HrmHutrRy8V0ONT25NjF2rqaDlu0P+l1OwayTWIvNWM7wCU0u4EcTLI8cjbyQfv0ZEhy23l2M6fKgJXnme1IE8cwgmiB+UySn9/Cgmf/IEbV2lcMxyRXPlfFsG7ocR2QANf3TZDy4lKijWK5nwXVQV5ymXKvnpaGHesqXJ/rytW5YU+tVAXkSGjzG46GGh3wXcp26t1VxX8oZMwPQtRZEzeGOyhAuJ0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IukM4MvkNEP9MkCZBzimyNNQQ5gvPP+MjvzhV8bm47E=;
 b=mltpedF5gitSq7dweRsTlcctcSdDp4fC8vVuocgB1bdxX3UiWLOfPXIBe8S2DOceCKr6B8QCneIRs0s0IlcZTkKo049caGKzu8zjHTHyy/5gB4dm60OXtmxeGklkM/IiqvAKDFPkxqceMC48DPzYgq/Q1ahKju+IxZ38bn2/G1haUmdSsBJ3cqpimE1CfQWuH+6IAAauxI38GA8Nuj9pdT649DEFlJOli81ufqpf3d6PLUtFWRYghFSTSH7xAVz/DjNGSWFYs2CVKma6TJA1nDC2Ca0SP/E6Iqs/5GOc/NdDzVO/TU9u/H+gYM3K1a7R8LSE20BlHFV2EsUNjbVxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v10 06/10] mmio: document ADMIN_VQ
 as reserved
Thread-Index: AQHZTQelIthVWRw0HU6AQhgBU7+T767n0VLQgADqfQCABvOAcIABa4AAgAACGkA=
Date: Wed, 8 Mar 2023 16:37:16 +0000
Message-ID:
 <PH0PR12MB5481BECC6EBF47BB7B88B322DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87a60nky8b.fsf@redhat.com>
In-Reply-To: <87a60nky8b.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: 1856b628-b8fb-4653-dbf0-08db1ff360b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fOkpDtC/bdQw77fI5W7oDULvTWAiZ9UPFTEzdjHKm0vStXyhdsRG0WlZYc4yE3e3uz4b0Apje/IAQUs75vGJ3dddW5wlrHfELlox95CvAu0ZlIT6oby/EEJAE0QZOLjt/37GmGJSwZKffKbuQX5ONsNjo3/k/lLsGPmOYdf2EsJ6mS3ljjkLnVAvFsMMNXvN700Cual10J/jF2Vm6YMQvGDZUhQ64dNdG5HwLrIffpLXXSngnWOtXeiySivSPy2j2zhlh4mkD3qXrIE1OD9QhRkwy39e+i1SP6HmtVjQvOTdTJ8FC0Md/dU36yrYVkyBsiR/25+76GvjJtAbWqU+ZvCN/iZOlWx7wo0RwZrk1DrqmLj6aXmMxv3PfMUDHFDXf/OIIZtb1GJGM7lB35TtVIa7qff2fygNa+1elZEnywHdlg0kIyjjgWqAGwnWYjmamA4c6JhNYF2ff/xNRPIw9zlG1PeUqwN8VEZeyeSFOfdrh4famYgJDLjayQ+sDL8iIHI1LYVG3Bfnb5MIgaVD7dFs8M6VJmScwivPJGaxxes2EPJkrk5X7NhowiwgMTJlomc6ajQW3HrlNnbeJuqAX5Gqs9aZZU6D6a88LTkwNFfpmIwFv1Kkx0ZBpBgcJbz54pWojGbn129ZbTsOOWg5OsxSHsyeHUClmPxsbQJTuZKA6MCVnjRJ0uV5FRYv5ezC8qhJw7qGBRX50HSiS3yJIQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(33656002)(7416002)(5660300002)(52536014)(8936002)(2906002)(41300700001)(76116006)(66476007)(66946007)(4326008)(64756008)(66446008)(66556008)(8676002)(83380400001)(316002)(54906003)(107886003)(478600001)(110136005)(71200400001)(7696005)(6506007)(9686003)(122000001)(186003)(38100700002)(86362001)(26005)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DvBd21GAv7v2LXu8oRcI4QS30Y6wkRcDghr21DYyiXrcEjc9fomo0U64TYnC?=
 =?us-ascii?Q?1TN4BVEqUzEg5rX4cK1lnvoNqbZH/882IheDk2m+e6v6VXoSU/unlSWjCw6f?=
 =?us-ascii?Q?CZqZTi9cipuazHogNmodq13Oo4jJWrfii4qv+WPPVtcPaAsWOIKM9tTCbPiQ?=
 =?us-ascii?Q?dqlu918k7vMQ/jqwD6mM5QZBV5HiZ56Dng6deL4B238M6CX2EWByUMVM9R6V?=
 =?us-ascii?Q?gGCzJez+jiNcL/bGtLfGcYkMw3Hts68bv1zeSIHKrqRLVzDcAb1vxUscbxow?=
 =?us-ascii?Q?n2acowFqVa7lwlUQ++gJbt/QSh0Hvr/umnRlYa6tthoEROayPc8e138Yp2Zb?=
 =?us-ascii?Q?SOwD3OrlDUal+/U04FwipwtJCqR/4w7v8yPENltT8U0OIh9EB0zVF4cR7LCA?=
 =?us-ascii?Q?LJEHW8vxdue2Oz5JjrnS7uOKMw6jrtPkyt7KE2rTZu3MDJlOTb2h64sAKZjQ?=
 =?us-ascii?Q?6kpOMuajy11iCbAe0Aokf5h7MJB6cyh4nupjlFG+1ronoRJxL8Adfz54hzk8?=
 =?us-ascii?Q?Ll/TJTxedJfuRdjK6EfoCiJ10XzgJkUYM9atQbUuGnReIlvx9rud9Ft63yXY?=
 =?us-ascii?Q?UJL8AuMgGU+7NhdsOoJYok40WuhSMnl2Z1t/bpwaWKlQ4zcOXna9NHC035ww?=
 =?us-ascii?Q?CDBPphUUlT9JRwp9OaZLNTFcttPcnXxdgl3aK6sDPmeB5WwUsLieMEaKpAlG?=
 =?us-ascii?Q?2BQvxgES46j/4muPrVGiX/smlgWuMHcqtc5JYuQC3DoKcg3YP2uAI5RQwg2G?=
 =?us-ascii?Q?ixjB4NepqjdmJ/S8RKnsA/u6QBb8Sr1Z0fRfNBTmemoFC6UTdVs1GJl6R+1s?=
 =?us-ascii?Q?l0/Pv67Dah6Bj9C+5GVqvHum/yi0Vyaqg4TQuBRQIF5f+xhpe/+lx5UvQt/Z?=
 =?us-ascii?Q?0Rsh2PpWDT6KaFFhur36UZDF6UNEU5IFbfg3fde4a+JccgNFL4kmVqxLH2dD?=
 =?us-ascii?Q?GGkdtFPLEdFebEwDz3urdkpGKF622NGM1siYdG2mWYyeOW4ryz8ybRlKqFdb?=
 =?us-ascii?Q?TLi8jDa85oddPMqbknEEW7SmIvJE/Z7x1c3WAou2J+a4LKn/qPLMIFD+UIyl?=
 =?us-ascii?Q?Me8+sUnANp9BgZp+LFaHsM9MSzZPsqIQAtPa1pl4ih7IK015PJTBomoFE/i0?=
 =?us-ascii?Q?z2I+zZngG+S5n4XhsUmb/ofzdqCWWxNEvHel3I2lU0yBlw1dDMmvLEowB0Fr?=
 =?us-ascii?Q?YsjRyjyeDTPWrSTgnK1Bp/3OEb21A9NQo+newZDz6jpbGn4ZdEWJQ9e6iJWU?=
 =?us-ascii?Q?WqLyk/i5RbNfbAzn0HI74K1liGAP+/eMIzD2CBQEZt9Tr+11FvKjQiFOk+0M?=
 =?us-ascii?Q?y/VcjVBQ2ZewH4XPaVZkd5GFvGgeRoMUM0AcHBYvp6V/Afl/ENixCnIHnpc4?=
 =?us-ascii?Q?OzCpI81iLTSKLYb2GI9Ya1wt9ZtP8JUNN6qA+r20/Waz4ZeuEGKAxlFwcDsE?=
 =?us-ascii?Q?sZvwDSbGLEMlscsb5a8ZcNFFEb+EhP/nPoAiSqtri9huIUUqRcCyZQBhHB4U?=
 =?us-ascii?Q?wZcf7BHNTh1fQcRbSLa7OdsV7CbAsNKgIqE6NNvSJ8DfuShbVr9+yDxXSMDg?=
 =?us-ascii?Q?JgY47BM0zbtXgSZ/XQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1856b628-b8fb-4653-dbf0-08db1ff360b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 16:37:16.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny84uKNURGKFkmk1NfYzJ73cb3cT+utsAM4UtSb58U7tWcnXPlUvcUCOY6IiC2xg0ZNdQRtlxGLo+CQdP9PQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v10 06/10] mmio: document ADMIN_VQ as
 reserved



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, March 8, 2023 11:24 AM

> >> And I wonder whether it's worth it - it definitely makes contributing
> >> to Linux harder, and even within Linux it pushes contributors away.
> > The number of virtio spec contributors are in order of magnitude less t=
han
> Linux kernel or just the Linux netdev.
> > Patch split up reduces lot of time author and reviewers.
> > For example, interrupt moderation at v10 can be very easily split up wh=
ere
> prep patch can have RB tag and v11 doesn't need reviewers and author's ti=
me.
> > Your work here with 10 patches is yet another good example of it.
> > I remember Max and I started with 6 patches... and current 10 are more
> useful way to split them.
>=20
> I'd argue that splitting changes in a way that makes it easy for reviewer=
s is a
> good thing for any project (although practices on many forges seem to go =
into
> another direction...)
>=20
In my experience in dpdk, Linux netdev, rdma, nvme, tells me that patch spl=
itting is common practice.

> >
> >> At least for Linux
> >> tracking history in a precise way is extremely important since it's
> >> helpful with stability. Spec is very different.
> >>
> >> Until we have a good contribution documentation I think we should not
> >> ask people to follow a pseudo Linux work flow with requests like
> >> "please split this patchset up" or "track changes across patch version=
s"
> >> simply because there's no good docs to teach people what exactly is
> >> the best practice.
> >
> > Yes, I wanted to update the contributing document. It is in my to-do li=
st.
> > But given the small crowd of contributors right now, almost everyone is
> familiar with the RB, ack tag.
> > At moment it has two main reasons.
> >
> > 1. Acknowledge the work and efforts that go in the review
>=20
> I agree, and I try to include tags when applying.
>=20
Sure. It is not about you.
It is about the patch author when he/she sends v9 to v10, adding R-b tag in=
 v10 (for the already reviewed work of v9) helps to ack and speed up the v1=
0 review.

> > 2. When in question, reach out later to the spec author or reviewers to=
 know
> about context/design etc.
> > 3. Same reviewer doesn't need to go through the patch which already has=
 RB
> tag of him/her.
>=20
> I tend to use R-b in that way as well, but it relies on the patch author =
not doing
> substantial changes between versions...
>=20
> I guess the usage of R-b et al in the virtio spec stems from the fact tha=
t many
> contributors are also Linux and/or QEMU contributors  -- not sure if it m=
akes
> sense to enshrine their usage, but
>=20
> 4. We can get an R-b from a non-TC member who is an expert on the topic (=
and
> follows standard Linux/QEMU/... practices.)
>=20
The intent here was between vN to v(N+1).
Virtio spec maintainers are likely adding R-b when they merge anyway. No is=
sue there.

> In the end, how the TC members are voting is the only thing that matters =
for
> inclusion.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

