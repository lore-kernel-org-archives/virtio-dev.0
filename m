Return-Path: <virtio-dev-return-13518-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0499C001B0
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 13:05:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E8DF94EE9
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 13:05:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 533FD9863A7
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 13:05:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 46A20983F78; Mon, 14 Aug 2023 13:05:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50D2198633D;
	Mon, 14 Aug 2023 13:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0EpfF8whtg9cYB5sqSTqcPuTu/2SWYXbIlWMn+xkgHCA3l8HkgfdTYXFmbEk13ZHij0I8n761dWZ0vR7V1K2ra9om76aKQ1I10WfFkCrLRCUGN99/f4TsSfiUcs08Kkel2Ox+40BrOaNq2ltn38deYfedbkBgcJkCStkEz2oLwVWji2bHpxcXqjwfcE2r4Fb2RiW5uUkPd0nlN7dOrvTRtuoyy5a3xD0RevAfRK7tGNFuqt8mHfelTcIWFnB4aVba9htjlC8w2X6JWCGCjdUKz4jvRhe3IvFdkMoIK3B4w8OuPPqN1VHDY5iy05cqeW/kYQ0e83bFFkkIupV8yowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqDLiqZU41OvQ2wm4LoLzhNMOlldYncN+T6sbJFbVxs=;
 b=UiaDEE1zofo18dXtfoHOeJ736aIGDlwmitDas3o4xMg7yHd96GE2yAHH6qjuD4bEJ0nqEqh5bNGknHkgW4KQN4j5+dbpOBTsaM6xzh4n04HFCscZILgSbmfPWMrTXeRV0hVlh7w11IDILIaejaSAle/uyHzED/T/mqqPG8tNsdCXEDZWhJXhSfhmQEXxaUObxzuP0QC+6uafDJxJIErli2AtW3Yewq+K4XdGTSx5hft50VpAbwfDI3MVDnec+evxQf7SoEct8J3dPdmBpaScVVC89JkkFwJ0X9S4xDArX9XQ7otgSJjHUJIGynetoEDcZ2Qs36QgTe2v/gUGDEHB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Satananda Burla <sburla@marvell.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
Thread-Topic: virtio-net ip restriction.
Thread-Index: AQHZyc+nILPxO9tD+EKehXYOD067TK/pypjQ
Date: Mon, 14 Aug 2023 13:03:53 +0000
Message-ID:
 <PH0PR12MB5481425BD4582648FDD1B127DC17A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1691481880.8297818-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691481880.8297818-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB8859:EE_
x-ms-office365-filtering-correlation-id: d3eae1b9-4e05-4ff1-dee6-08db9cc6e99e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A1koRN0O2WksaAne/beS8f784fhSowkSkcp8kABMkvHkFHBjrw37pA7NCj/BDgAgsywYVXUpFeS3rSOjr2BDz9FpfFdd2tiA9JdWrm5RQH7KFZ392lFRXHpQRtQsEIt3wmkxpYCBZz6XJWt4san0XFEFpl3iUr94QziMFnIowJTmdkmwxj9//R+jKATn5M0m+S4NH2VXuTlkrx8ePbX4Zod1Oe0R4OM2QQplLVFj9NHXJsfhF2cTAQYXAKh1Zobf3A3+gI51DvKZGFOvuCn0XMe2AH06se4gmOTBHxr/v4i9iU9AWv3Lzb4NsYIhK6WuEdbUtYUi+z8R0RSxCh/NlW2/KhzivSNj4LMEBXwlC6jni2GPCDDY28awR1wmWM5oTm+1bnZvruqVhon/4M7OZcgnDLhICwSZwIbVHw7wsEi6tYNsiUrD4OVHFeONQyDIzVp46AWvQNh1Ofrm/tlDMo7GANMqbnk4hvmoZJd0LjB1i3kfQ/0A7FYd3pFzGjcI58M4MozW63qKqUMDB93sKhhsb/ojNJrsezaoOexG3vWLsjvkaDLm9CNwzrMrwiQDOBnlC6OdGmuhHc90DUT3gP+NijPQ281XKdL6IynG7iQJGUKKQsrqnvK0uCf04BDV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(1800799006)(186006)(451199021)(478600001)(7696005)(26005)(9686003)(6506007)(2906002)(3480700007)(83380400001)(4326008)(52536014)(66446008)(66556008)(76116006)(64756008)(66476007)(5660300002)(66946007)(316002)(8936002)(8676002)(71200400001)(110136005)(54906003)(41300700001)(33656002)(55016003)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eR5hQqvPr/7BIsSs8e6hIgfSy0jZFlAkm+jTftqr0xZbHNENVUEaV3BSo+jJ?=
 =?us-ascii?Q?Nt2RkSuh4fo03nZrImrlXgWxSnydRUuKLrBlw6wjJMQ6JyedZE2Qs6w5MEIE?=
 =?us-ascii?Q?J1NgTqMyU8Vx7pFBxfCL1ReuEHBwiQRYJVa9SWjUQmciYhTPaHU5QgYzfGnA?=
 =?us-ascii?Q?gMUKiI8fmeJyxvfpHKzB+U42kz/6gc0a6jG0S1grnzkavl2XvgbZTEFFnMu7?=
 =?us-ascii?Q?32qy0+QUgpSkGAo31Nt1KLiu0KETNrFTGZiqJy8IjrXrHrrzQZ6343MpoDBQ?=
 =?us-ascii?Q?p5jWpx9K6KPZgvCnCxUq4ca6C9WMMldksiYDMiYgL/Roo1dqXz97YuP8oxnQ?=
 =?us-ascii?Q?mH+rZY6SrWUqLhgOHCjVwOWAjeM+rjEm0ixwNPSanQMFjbpmmXjMq5lP+/AB?=
 =?us-ascii?Q?udDZfvTAkDvPNdi+KOrEtdLmAu38uJ99EWWUSaYMUYyth02d9cacJ+sLWJOl?=
 =?us-ascii?Q?jfzVllRDov5UfrubtyUOdqbbL43LOD39PJCkb4LDJa6/9o82mtTjFq8QI3bq?=
 =?us-ascii?Q?/TAJGZEcU5qnFvD8I5To+ZYg0LBPiOi0EOK9H7pIwBd86UjQDbvnhnosaLkB?=
 =?us-ascii?Q?JJZ5yFNDVcP+eiCDsiNkYJdoU3NHuRg+ItXqwjQ9pIOXeu4kiyaqWR8hye41?=
 =?us-ascii?Q?PY259uDEqJ2tP65lfEvlP3XdAM9YTRFxpvOR2e4hiiFrSqR6IT5781TnRO5b?=
 =?us-ascii?Q?KUNjM/S05ghCblA2DCzVCslxWlGtgB1aT8AcDRC9omwGV4s0MoyG6JniBSyt?=
 =?us-ascii?Q?qCrGc1U0oRqDnfU1UixH1ufuJncZhf3CsTmvX2v/O1DKgCXEbqAv3hc8ENKr?=
 =?us-ascii?Q?iQSk9h2pJUmJKg3XnUBcoyOnGhInJUSiQUsWOZQhnyxcNJUeoTUy2ins42S+?=
 =?us-ascii?Q?eg6Dk/LNuVNbrT5l76YoSS+If4diVFNaWfz5vIQX6VWyNfQJ/GTMf9Wx5Wvk?=
 =?us-ascii?Q?dnbPDLLEulQDlVDM0Em2Rsmi/rWv84cUlsQZEeZ3d/N122prb07VlmreAqBg?=
 =?us-ascii?Q?89IBEnYYBUJYWIg8ALn3UuuiymoL9LxjvjwIRiR7186CnBouSoA7y26lKzPz?=
 =?us-ascii?Q?pv3KjvOpOeZrABzKlfJgWzCxibbwNJZsqpo6bptMn+WOxqrw+/5Jfk0DRx4v?=
 =?us-ascii?Q?Vo/v4L+1DU3IAgyYxj82hmmzGDVObeqfk5GDFYvhPG+X4MZQAE3u2wiJDylQ?=
 =?us-ascii?Q?+/uaKThpelNt0DOKF6fJoKehfPI5TMG5L34h69AbGEXAngyq0lMWGguB1iAc?=
 =?us-ascii?Q?lX+isVzQ1NtbEKpwXkkSTkgAy4PW8AG+Tp7e5R2EBaTVIrud4j+hWME1NT2/?=
 =?us-ascii?Q?p3vYQKQ0aU7NsHvRN4J5LRv+KP/6wXyjCz04r3ZIFLN5mULdBDjzT/eL7a8p?=
 =?us-ascii?Q?cZ8edffmVUBcAGpNBT1H+I/fJfQxDfnXV4tTZ8lILWH7v61jZOwavcQyrvvq?=
 =?us-ascii?Q?LDOVOBfiU801aMWNOPbM5apdrvIhkPHearFnhul+Ww7QGFvcBXZBK8pim7EG?=
 =?us-ascii?Q?8wrEjrSH69ul1092ckunGC+188ZSQb1/1j49o9MHwcI71qMdPKxjoAj/nOiK?=
 =?us-ascii?Q?6d0x3Uj3fnnD6kzHy+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eae1b9-4e05-4ff1-dee6-08db9cc6e99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 13:03:53.9780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya5Ot302r6mNcSS13nbBwJX9DbM0YBtp1zXXnRNJMf5XGnWFYMnZLa4XlOcJNOKkUotfPqTRX3/9bhn/b22VWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
Subject: [virtio-dev] RE: virtio-net ip restriction.


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 8, 2023 1:35 PM
>=20
> ## Background
>=20
> For cloud, the ip restriction is important. Because the user of the vm is
> untrustworthy. One user may use the ip of another to config the netdevice=
 to
> receive and send packets. So we need to restrict the ip traffic of the de=
vice(or
> port).
>
A VM can do the same with the mac address too.
Why is mac ignored?
=20
> ## Implement
> Now we have these choice:
>=20
> 1. introduce the switch(as the part of pf or as a separate device under a=
ll PF
>    and VFs ), the switch support rx/tx filter 2. the virtio-net device su=
pport the ip
> restriction
>
#1 is the right approach, it is not either or.
Virtio switch object can be part of the virtio-net device or it can be inde=
pdent device in itself.
So the definition we do should be generic enough so that it can be done as =
part of indepdent device in future without replicating all.

The concept of switch port etc is needed.
=20
>=20
> Parav wrote:
> > I understood that you for some reason do not need restrictions for the =
PF.
> > I do not know why you don't need it. :) Most cloud setups that I came
> > across so far, needs it, but ok...
>=20
> PF is used by the administrator, so the ip restriction for the PF is not =
important.
> But we can have this feature.
>
In some cloud a PF is also owned by the tenant.
Hence its administration to be done outside of the PF.
Therefore the virtio switch object definition to be built for long term and=
 apply to a narrow case for now as PF->VF.

=20
> > The design for the switch object needs to cover the PF as well, even th=
ough it
> may not be done initially.
> > (hint: an abstraction of switch port to be done, instead of doing thing=
s directly
> on the group member id).
> >
> > We are seeing use cases reducing of having switch located on the PF for=
 its
> VFs.
>=20
> So for you, we should introduce a switching PF?
>
Yes.
=20
> > So please reconsider.
> > I remember you mentioned in past in other thread, that mac etc is contr=
olled
> from the infrastructure side.
>=20
> YES.
>
Hence the administrative PF doing switching and VF configuration is desired=
.
=20
> > So, I repeatedly ask if you _really_ need to have the switch object as =
part of
> the owner PF or not.
>=20
> For me, that are all ok.
> Could you explain the difference between these?
> So I would to know which one is better and which one is simper?
>=20
> > Which sort of contradicts with locating the administrative switch on th=
e
> owner PF.
>=20
> Why?
>=20
> For us, all is on the DPU.
>
If all is on the DPU, can the ip restriction be applied on the DPU for the =
VFs (where there may not be any virtio net device).
If so, why do we need to introduce things now?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

