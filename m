Return-Path: <virtio-dev-return-13007-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB777EB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 15:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 598D34282F
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 15:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 309A298662A
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 15:50:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 209349865EB; Wed, 21 Jun 2023 15:50:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAF979865BA;
	Wed, 21 Jun 2023 15:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juaXs5+SoIIftQCiZ6AxkzqkxIYDXwZ6eDGCp1PI/ZK6ytsvrqRJMWi4uBSjhJlcADCICujXs+h+tF15xakujbCgsAwb28PwsQbiVw+zJ84XiWgJSN+LqB2/0PamoL3VSwW4rB2mCNDp0ac/VJxM9nLxI8B+Z4BRxp/nAjciDS62y77RK6BbF+2KyfbUf4gjL7jH21mHX8L8a1wrGDNKFp08FBlRQHmgfsae0n3cFwW2sCIXntnPWIC/FbknfEBHmH5icYAWRNZkIVtXR6rjYxZT1Iv+rr/h1X7re2w0m9Xwm1fSA0YVFWktoxuxKHbw9+RvsrxlocTwer4kR/A7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cyjX7G9iJBPf/DvITvjAP/lywcz18H8lqbz5Fm1v6I=;
 b=MoQi2E+G9O0c3RiujES9KOk8BrLSUYJj1T5j0z09/AtdiriKWNi624wIcn9hq3/a/gCPTB7HMyuJaxqIXgMORS7uuB3IZ9cb6h3FgCPHSdKDBqnVE30kbsa6yhzrk0hoahuA9a5LtBXDRWt5OuVnzN8Yf1h1Yrfo0iO54MCJrD1ToSUJ6XSJOcX5oWKaOFHph3Ni4OXYic8eWpSBffDmkFw5mWTSj5WFS0uifM3SPRzOpXCLHGshTlR9SgK1YJYQCIo0vKuAUQvrGGyeTem7gVoxna+ZmLm+dnt9H6JClz8x93XUqVndWZq+fvpCmiegV4rNGTSLYnZVODqMHcJRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkIAABE6AgAAA1fCAAVC94IABrvFg
Date: Wed, 21 Jun 2023 15:50:00 +0000
Message-ID:
 <PH0PR12MB54812103E5CB5CF860B9B50CDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8772:EE_
x-ms-office365-filtering-correlation-id: 191388ff-0d90-49a9-2965-08db726f2bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XdPe282WgDkZ/XkVRPARaihLNoLwDiMX1rhDVJxSwu00cM/0EPiBV+dvcwtBhdAdA9NBeFiK+pXwnuBFk+pTBjsjymUUrFkdHqn/m8jFY+WfNwJjjMC+P685dr0zEiEfCnFYy8ZTGJSl1m1jjMJYU2FHnWULodJII50UUNSwbxielGo0cmy7zBYnG2HszmopOWunWNt5HfhLt8mEeCB3QKf5+WPGUSqrg39sttB50gxcB9s6LjmwBvSI5GzFC13PoXPZFcvuuO77sQgsJGaRe2wgqYELIGXsf4l4IrELt5cWHLL5ks2hHcs7dcOQR5C3eg+DRrzTmf+Y7ED+HmyIIdvSjvRIApfqYrdqDoKNUXmn2Q1ZifaqIvLX2N23hdbT0vPajR7skLCeXPsyj5xJDUcTrgvXzFBfKy/OflS1cyic9DHYiVeD4GueDJcCGhijlVS+A1hb61TVvpWC8oO1dzT3YwfZLW7O8rpIilsdmJYuoDciYPwE68XQyoadXyQIKGkZNPHNtGOmouibhGeZdCu+fJymtLJtfYVdLh41K0XbYOZeX1eybA0iXcqaVgECkttLfbTwVjFI+ByDdfD8lVEoCpqCMuAWeQ3GaDSYz4I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(478600001)(71200400001)(4326008)(76116006)(54906003)(6506007)(186003)(107886003)(9686003)(7696005)(2906002)(8676002)(8936002)(41300700001)(64756008)(316002)(66946007)(66476007)(66446008)(66556008)(52536014)(5660300002)(6916009)(38100700002)(122000001)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vtLBnBUV0pH5G4Xote/5wEC+THqX4PcABuy+ITvCgLlrj3qu+Dzm45qQIjxp?=
 =?us-ascii?Q?EzhpO7JuNw6gKUELoTtE6WX48fI1+W92N/4SpEQ0KfW9gJjiJw2Z1YjPrjje?=
 =?us-ascii?Q?aiRYyjQRmtNDfo4asRxkZ/iYpNKgY5YFkxzg1OgqeyYktsBZXd60SazFxWcO?=
 =?us-ascii?Q?2B24IjS+h6BVTnusVgbQpuoMcStGOs+JdJyelaGuqelt6+4Vsb1rIcUoKOeU?=
 =?us-ascii?Q?4pcML3mmLAl/Vt5wYhLl1jI96pt8RH8VGavyUkgSMjgc2OM9gpwRSoG6cK/9?=
 =?us-ascii?Q?V+ZgFGs9KS5gac6qvTtY0MHZig9IhG19IPqSgSrFrUZ8YcR3syUTmFqPUOuO?=
 =?us-ascii?Q?OKPFsXJoGwfhgQPL6D/Etz6KYu8Z1oFiAymR5Ud/nySbYy7VZL5fNLl24VKL?=
 =?us-ascii?Q?ANYFKvDNSmFhZOfBNT2iZXswfgdzIsN6Ee1iYJ1YCdR9p2wexX2sO2QSVFbB?=
 =?us-ascii?Q?ml/V+xaDIjDF6o4WAOr85K1JT1QmcBEAdAt2WNZ+FdR8E1S4jm/ZQBt5kJNl?=
 =?us-ascii?Q?Z5eitzydmi3e7h+hjQ4nEamZ7LkIoKQidcqBeB/0J0unsy/rlZWwK8KL0/Kj?=
 =?us-ascii?Q?eepnFuoZmOedj5w0KqazL/HZsrkC/z0riH8xhDi646T7P088MQlnj8ADe4DY?=
 =?us-ascii?Q?FetIvoLrtnGUdpMxJ26O7rsxrZOBJ+i02CFqRaw8PBWJX2pYxGaITKfMlX3N?=
 =?us-ascii?Q?zneEGnlTPxs6GIh87c2dCDAuSRNxB7k/dQ4eXmJhzdP7FoSyd1550Jp/37Uj?=
 =?us-ascii?Q?hxj0toVhBeA0l+GcnoRk6ZqvdZRWJDREY14zBonhwkXFjb9vsPH/yGX6iQ3G?=
 =?us-ascii?Q?4ukXuCHMhD6dCEd7f0AVo4vhr7tV6Qc0veQur9iA71qIpxO0ZUkHnQmgUlIr?=
 =?us-ascii?Q?6g+EwfjfYYOkPM1mWQObGIYRPpRQ9zpImDn2wGuXcvCSh6Im/Dx0FcqAJgci?=
 =?us-ascii?Q?M5NLuibs5PCWnAexT2L7M2zn9I+a3ozHRSVUd5AjcK3y7o9wxXnhJ4/mjT5W?=
 =?us-ascii?Q?eaKlcd2E0J/2ZU5IeAAe9eH1kp72Cwd2ufLq+1S8X2YF+vKAa7l/ukEwbBHi?=
 =?us-ascii?Q?9aQmbzY0Qbu3H7NqGJJZPObt+ohjsWoUzd8LaWOIfk0y7+4OatYO4KDb012/?=
 =?us-ascii?Q?/oaRvrL5b+zihin73rrmzkTS4hd6km1kkfTF/EdUqCLd2aFQWbg0dUo9OFNC?=
 =?us-ascii?Q?Y185/qnkDEjH2nb/mcU6BHoHMFBQWhjcLP6wI7ugqvfUyLEBut0xGv6kg8iO?=
 =?us-ascii?Q?BSfthmXb/vdUzTaOtHlfpBawt2/qddgETVAxxkH7+JpHL3q1C+4YeVL+7MWi?=
 =?us-ascii?Q?+I+1A4bY0NZ5dL4FbHJKnzcJkWAc8LecKigCmM+yXDArlkbxyyOPnaL6zRk3?=
 =?us-ascii?Q?4jc+2ReeMeDwFa3dr8FrME39jBpVXXorbloJlYWjN9KVGyp3zOWH+pQHVFMS?=
 =?us-ascii?Q?JVEDGJKvAdUn2ciDik1SJXUqoe5eC2yL/EAMeVjglsiL922H7uDqGDzxnbHU?=
 =?us-ascii?Q?XzSYJ/7XlUSgXNAT9a6C/zX0b2iSl7aHC4GIweV0V6FcPB3t6+iHhaWBakng?=
 =?us-ascii?Q?/rqSGUN2vUR/24mRgmfjCafskoC0BVENNm/2dJ0sQHAXoVD9RPmzfyaJRqP7?=
 =?us-ascii?Q?g2BG6OddAJ6Bc43d7kmyRkg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191388ff-0d90-49a9-2965-08db726f2bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 15:50:00.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7QpLenQ07woyR01tUd0IY0VpMSE3TpxGdeAy36cmjUPDMQXVPx4tQg8g+lLEi468y6T6b1+ZFVJOie36OZGkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Parav Pandit
> Sent: Tuesday, June 20, 2023 10:12 AM
>=20
> Michael,
>=20
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Monday, June 19, 2023 2:07 PM
> > We don't need to do it now.
> >
> > > Current VF capability is kind of ok I guess ...
> > >
> > Already proposed one?
> >
> > > If you want admin command to query then it would need to map in PF
> > memory.
> > No need.
> > It is similar to rest of the configuration access commands.
> >
> > > I understand two concerns with this:
> > > - you worry that this forces ordering requirements - it's true and I
> > >   don't know of a good fix. So if possible use VF BAR by preference?
> > > - you worry about wasting physical memory space
> > >   this we can fix by sticking VF# in the kick.
> > >
> > > As an alternative, if we can make the new command able to
> > > communicate offset in PCI BAR or in VF BAR or both then I think
> > > that's also an acceptable
> >
> > A new command proposed was for VF BAR that member driver can ask to
> > its group owner driver (like rest of the config commands).
> >
>=20
> Are you ok with the admin command to query the notification address of th=
e
> member device bar?
>=20
> I presented both the proposals.
> We need to conclude this now without keep flipping between two from versi=
on
> to version.
>=20
> a. v3 with admin command
> pros:
> 1. self-contained via AQ for rest of the control path operations.
> 2. Can work with future siov device who may want to support legacy 3. Doe=
sn't
> bake things in low level pci capabilities which is hard to get rid of 4. =
Able to add
> new command or new response if some device wants to support this on PF
> (very unlikely)
>=20
Given that this has more pros and no objection to it,=20
I will revise v7 today with query admin command like v3.

> b. and v6 with capability extension.
> Cons:
> 1. Does not have above advantages
>=20
> Pros:
> 1. Uses existing PCI capability for the extension
>=20
>=20
> > A future command can tell for the PF BAR if needed and some device
> > wants to do such extra implementation.
> >
> > > compromize:
> > > drivers that have trouble mapping VF BAR after querying PF can just
> > > map PF BAR. WDYT?
> >
> > PF BAR for notification can be done later when there is some device
> > who really have the limitation and wants to do that.
> > We don't see that additional need as driver notifications are present
> > on the VF already as listed in the alternative.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

