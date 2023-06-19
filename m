Return-Path: <virtio-dev-return-12956-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C90EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 12:33:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C2972B00F
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 12:33:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CB499865B6
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 12:33:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F82E98639F; Mon, 19 Jun 2023 12:33:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 159DB986397;
	Mon, 19 Jun 2023 12:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHPd0G/+K2IfW4mdYWqCK9cEa5tSwCgu+Mg5GPZXRZynta+p8jldIGgEjJEKE6RWapNmRhtS2egMuPnYOhTVJSxvSCkuCYul7sPFma5CER2dgjYNoqjUDYbHOH7aLZcK+BGtO+ku6GRgRJN3nqg0y8wMlO/E1tkM6WFvzpGIdQFTk5CLmP00nXpQKLI7s57wdJHKQ+mugPC1RqWmv8tpdpnsjS/sEL0/S9i97sew8622aQmlaJJDGnSw2f5K3hSTiEQ6CxsvAzPbJO5Lu7dOKgcLlI2/8XutmwgbVa9mAitP92iYVXZ+XeXIYL+ipitkIQ0U4E1BgA875xuzMcpYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOYfiTgQiNhtIAfmbKlme/vGGqs29DPb9DNKlyVgWts=;
 b=kryTcC5t8D5zgJP6tEQG9MmrcBWp5JG/g50sA/rIza/QaijSch8OJoNYn6heJpB5KbxEJu1wgfsFSIiYaHDkmWztqdxm/PZD7KYtbBRVIqvyJQqw2uG95SzeX9m/iZvJFIlvU5Au3l99z/wYYjgwQBzD0TTT2SQnTb9BcsJiiXMrDaVTMggQ6saziZ8aL0Noyi4Llu9vhaBW1v5TNGHZjG+CZrtnbIQkTgRs+M35JOJkWUMJpHCOOzkRijjMcV1Wn+5LM1C8UdpKj1VW5B5o7IlneGDvYnDKuZNOxNSh7Dn8+d5HV+ksqnCrrnIR0XfF43/8BG6H0uWGrEc/6KX3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Thread-Topic: [virtio-comment] Re: About custom device counter
Thread-Index:
 AQHZnPYBhAj3P4GR10mqaBAnc/G3uq+Gs4AAgABUQYCAAWnBgIAC+GGAgAIVnICABJomEA==
Date: Mon, 19 Jun 2023 12:33:33 +0000
Message-ID:
 <PH0PR12MB5481D058584D7AF742C1FEE1DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
 <20230616101113-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230616101113-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6685:EE_
x-ms-office365-filtering-correlation-id: 52199f88-2f48-4b81-d3d8-08db70c16525
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ly3CeM6lS3VLO0WAMqeGMEU7qDmRWBfjN5wKz317yoqDqF62xNB/xZ784PCJYpx94NI7UhzMmEKDzMLAxTXKMm9xf/1TvT5jklSkq1l488qg/bN8FrTImFDCxADfN5PKAzhJS1OrpCCRDnMt8dhzYJz58AlF7cuMNlW18l3ohR993zNKFcRxs+dinJ3bDQnZZlBukL1hDhKASevyPTz5LEnJmv01Erm88vN5v94+9URqj6knJIHYQChaI5lw/TX0QE5e+z5/SKK4G1Z1zqhFIcpx32LgX9FDlO6YazzVNFRioFAhGnRANGcZSbb5A4BJYm56v+wj1QdZ7djARV9l8cApX+F8DohlqFoWhwycKFDSbfLFJlbAKC/WjU7zgC6EHFM6+qJ+UAWGCRVgkW3vBDIy7DpX998u5EL/oqT8Swo0hO9ZrWxZhT/hgt13O1BhMFPPu6bXDJhW2lCM/u6dlHVD9rgv0//KNSdbiHNdKufESNWwzEtMRvoazCoDFPAQ7TYQD5RgOriaETikiIkKO8NRUllCa0ShPXeOn/9gbYPLm0FVBtA/rUmYCble+1slIF/V6NP84p/LazJmdNlI3HqsuhIeTTX8emK3N5eWfO73ITloeqI0bbLj2wMqSXEJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(122000001)(83380400001)(38070700005)(86362001)(2906002)(52536014)(76116006)(5660300002)(54906003)(110136005)(66446008)(64756008)(66476007)(186003)(8676002)(66946007)(8936002)(66556008)(26005)(4326008)(478600001)(38100700002)(41300700001)(55016003)(6506007)(9686003)(71200400001)(7696005)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kkuJ2UeDgtyFdn1G0sYshvbMJwBZ/WHmCzhgOHY9v/s4NXRrDuVMLx8/mSKo?=
 =?us-ascii?Q?YgS/sR95g7rK20qHvWqstrwxX5GnI+w950flUzFJWTSkuyAmq5Xayo7Y5z7E?=
 =?us-ascii?Q?lmvF38y23W5z1DIPJ8ybNgm1P1WetfpDB06r8pZtIpCDvIf00yUVOGjavJP5?=
 =?us-ascii?Q?VqqxFX5snZgrjGn64rSpiZVmdlhvVFLGKIF9TnxIFhJx3R4lFPVtx8fQVJHL?=
 =?us-ascii?Q?gOJY/eUJt61mz1JOxsQDygWcM+nxIKQpX4BnOIW7yCpQ3yWvCI3yFO6aTWF9?=
 =?us-ascii?Q?Gg+y/hfinaTfgdZIMdGG8Zg9din89XzrZTQ0yM9ki/kMas5veaI78N39QsT8?=
 =?us-ascii?Q?uZEI4ZUhzFAV1ix6SGu4coHrYUXbvJZYgcgEj904BcLreUNTss+h2Bh7sg0E?=
 =?us-ascii?Q?ttmIZbolxac5XCHvC2AbsVULAiXyuHeto+FIYOvVL5A3ktlXV7VyQrolyEwm?=
 =?us-ascii?Q?pdfs7BIm8bV3kPRKXaE1yL6A/HJpjs9rRvTF8R4jLdAA9RsL6B2Ntxq/flWs?=
 =?us-ascii?Q?4ZdxieDcFJXujg+Nqma3/jOyXKtkaalwOjvbCsLLC50GckRU1CrHnwyblhd+?=
 =?us-ascii?Q?z4Rv/cJbU/fkcZvjIoNhfISNx4S1mlR2eI2YUuqRhq2ydupthxKDxD/zc9t6?=
 =?us-ascii?Q?mxFguqoEwfHgnBtbMpcanLyIt8/vD1sMkkufrSRWuE1meddrpr2CrVbT9uAU?=
 =?us-ascii?Q?z78uuUMyy4QVqCv/OPtSQCQkDl3kDQVqakO1IRV+WI5I42Dwb3b9w9Px6isn?=
 =?us-ascii?Q?s3zrgBDfEXU0HSaMtNXy+pSaQ4c59g+0QjAsfx1eMNafls5CTRVZ/W2ZK5XZ?=
 =?us-ascii?Q?bYANNwl/wlhkA7QKW4/XhJKbvautmhm9UA6w128mFAguhLgfo7jmErCqoef6?=
 =?us-ascii?Q?R7ymvQXOm7LWBMODMsGhZ0PfJkjYGDIhPpDq5TbyIWaBIJqekxr0Kdna4lik?=
 =?us-ascii?Q?l0Y+p7+L1Y4KdX3ptey3TE2P8rZ0zwFl778E4SajtnpAhdmNn08r1Of75mlv?=
 =?us-ascii?Q?uibp5G/SO8YffyicpHDLw0r4vbq3GEuEc+Knz/sEt3vVp7iE1uNk7quLGkfO?=
 =?us-ascii?Q?C+HaPHw6nKVgnYr6Aegl9n98TZ6sdlr5gj6a/HFJfg4Yc2wXezmnMqDV9wdk?=
 =?us-ascii?Q?kIDIyDdT0ykvVXITQzJwGooAVr1ggJIw+MVHr2lEimLFwTq+nOThQbOKV7fk?=
 =?us-ascii?Q?qS88G4/VUlfXeC6z6XgSOLxy2CBcD5V5MnI5lc5iJaSD2V91WeMpW76UQELi?=
 =?us-ascii?Q?mmhhLz6jyEmFqgsUldwyr1CDjXKMnfSleCboBYmVA0OXEvx88S+7uOGv/g1D?=
 =?us-ascii?Q?/uEJcILtap+3ZhROTGIUcNgA+3o5x28YAv35zrh8V+CrQprtDp/HiUeRjidS?=
 =?us-ascii?Q?3wwrvMpWSkZyW/rTS3YFo40V9X3ScgBUFWznaorTv1CZKOd9bbeTR8Y3PR07?=
 =?us-ascii?Q?e917FmLHeTi/Dmg+eh7YnGqPDjQOmrvAy6uQKK2jnX0Nqbx99LnZsOvF9GGw?=
 =?us-ascii?Q?xKxMrvpUBY8z4DBCrXkqCTmCsh3pDa1H4zO7tj2hvg37JA+rkdlPwDpneIHz?=
 =?us-ascii?Q?sd+z/aVuodf2Xq4/Wz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52199f88-2f48-4b81-d3d8-08db70c16525
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 12:33:33.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDsPTIBzHqHVGs5FLG0IABM0HZ75YrLCw+0PhJReZqFxJQHyBcWzxiz7hz29pMoDI1ObBTze+gt8NP73fPHYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
Subject: [virtio-dev] RE: [virtio-comment] Re: About custom device counter



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, June 16, 2023 10:13 AM
> > Such as "limit", in a cloud scenario, multiple users purchase
> > different VMs, and these VMs share the capabilities of the same host.
> > In order to ensure that each VM will not affect others, the network
> > card(virtio-net) capability of each VM is limited. When these users pur=
chase
> VMs, this limit has already been determined.
> > So if the network card traffic of a vm exceeds the upper limit, packet
> > loss will occur. It is necessary for us to count these packet losses.
> > And the device should expose to the user.
>=20
> OK so here, driver is expected to rate limit yes?
>=20
Some implementations of txq are lossy and some are not creating backpressur=
e/flow control to driver so driver can rate limit it naturally.
So a tx packet drop counter is needed to cover the lossy implementations wh=
ich is abstract enough regardless of reason on why device dropped it.
A more granular counter becomes vendor specific that we can possibly avoid =
or place under different command.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

