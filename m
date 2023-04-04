Return-Path: <virtio-dev-return-11980-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3776AC77B60
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:37:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C3CE41EF6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:37:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93DCB98658A
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:37:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82C04986524; Tue,  4 Apr 2023 16:37:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DF10986583;
	Tue,  4 Apr 2023 16:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbqqQ5SlCx20beGxrV7ZIXQ54MJFTY3O+3wiyc1PkGLTrmM1ZjK9CeTcV1c2X8LFhQxUUfPxtOgAQeOmBY7SNiHGhILZWiQ5LWptU0Z+0kgJBkTfcpWmLVLLzgp+gdpNWu+6iUD5zycsN/PBx3/+2PsAYZ8kMOpVjut1Ar/KFvsKhpxRun+LffHRVlUAAopDO4V8xFa/hliv5frhY6U8r8MQwpyVJQLN60QJ0ro8bEc5IK1aJAkzVpbbGCbgZXLcyN0czQ1KCOSQ6Iet7kt54WwxOTKWWEyXIoE8Jqwko+cKSivqBOmvwfGun9PUrabyRwNZg/VhFlySSamDmRBUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIpEFBJ6Z8QQF22bDUfjXJKt+PVNtt/EgWJMhBOyhlQ=;
 b=KYBWdE/2dwWj4SUzKZaRnIsyW1i7EFRYSy+iMnFxA3ZfiBIuiBdBqUAPhn1P8HUF+/AEx04iYLeftUH0SX0gYTcq7TyaInHMCE40qtixhRcCZHOTAYGHuXpEZr239RPfSQ8nJPOKTa15CG6BPnM6gzbEbwpPVK1LH9YILDly4VHemOG+nSqw/YC3IyLFZRPBXkadnHpAyTqrsvd7qZKkZVx9hm2VwXMzTReRV5qlJK5SOlrzLHTNCusXR4hxV2tAO4qLOCDsPuAvRPJ5aHQxAbFncf+n6K3TAeuYZh/YjdWsklo+7niOhJidGonUgjolWaOVd/X8eEJ+XXNdVO6JlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v11 0/8] Rename queue index to queue number
Thread-Index: AQHZZn7RHugQcMhYx06hsK0lOjYfdq8aukGAgACfKBA=
Date: Tue, 4 Apr 2023 16:37:01 +0000
Message-ID:
 <PH0PR12MB5481D042F58691E84A1E31F7DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230403225052.585498-1-parav@nvidia.com>
 <20230404030244-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230404030244-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5047:EE_
x-ms-office365-filtering-correlation-id: 6fc48b8e-9e2c-40aa-378a-08db352ad0e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cn2qQpKe9fhx2/oePF/I8lbAMGNzo5l3YDkqIv2PRZ4fB3fjp1C08bt1tuDDVrPnb7FTlhmDYAVGE5o7olmZiGC400oavBwwSmECqPhpaQGYpGJ7wcNMJsIaD+VVOFm12Uc/sOatdFJxS9XdheCgDcY6V/rgKeYjiQ6xYlit7IDCJ7IUGq5RMPUIcJTNL3pT87hQvksWYxwACReZ/mvaQqzg1WakBgQMr1ScXKO59+3cgiQTy5Gh/FphhxoWANDTNvAIIvFuI6ZXlxan3lNMiNOPgNhr7R+nSR/Qpg0BHo3izu7vRAVdTKgro4BVZKfurpmS+ic9zPM4JMatDcWVsh33pgwxkH5sO+Y6Tl+MnoBDX8cQhFPnX/oxFNnVVkYb3GeCrUkx+Ez2CSj5Tf01Z/WlOAWGpWlVJujKn8NaExHrJ2gqTl8Tcbfwu6EMlaRLqj2bLoUJ6stpTsG/FxzlAZV5UAz0HMpLVJcW3fNpLw5vzAF8VzjIP9kd8DaYDemtR99HuTuDNiOgMBKnjuh1GGBauo6ORKKlXkNJYGDZNVg69oQDppAgRG+BjP+7jvAK08zmimoSinYN9VSprV2PEjl5tHRY88gAOZYaZo9QWbxl8DTfR3PJbT4myLZLLEmSxs7yVz3rn1+OkoVXP0iJBjs+hHzSRJD1v3g2T/pyQU0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(9686003)(26005)(6506007)(186003)(86362001)(7696005)(33656002)(478600001)(54906003)(316002)(966005)(5660300002)(71200400001)(8936002)(4744005)(2906002)(38070700005)(76116006)(66556008)(66946007)(4326008)(66476007)(8676002)(66446008)(6916009)(38100700002)(52536014)(64756008)(122000001)(41300700001)(55016003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o0BiiRIEVyO5IFIg9QrMCzZeKzjGtZqcxuDQeGqJ1TtX4pi7c7iWXCU3S214?=
 =?us-ascii?Q?bIlVzSYGkUgEVxGd1SJWzcs0k5/3GwoE9OJ6XPiw5Qm8jIUt8cqlfjH6GQxp?=
 =?us-ascii?Q?3CwmYYtY/OBAC4IqYJil7703qXdBgqXJYlyb0W5bld1+ZB/XtZvHQ5bC5sQs?=
 =?us-ascii?Q?D57Q2y5OX4TcUMR5Thz9GuqiWZWw9gFxkd5BTz3ydP8g0NPA/gDoTGmS4pBQ?=
 =?us-ascii?Q?vWRHA+4aUgsLulrmsp9ZTdVuX/76VveOh/Sz/WRHN3Z3SVDQV2n663irIZsR?=
 =?us-ascii?Q?NV1c6nPnAvBGHsROCTLcstBfQ0vSdJSXt8fdFEETqb8u200pfHUaQROz9A0T?=
 =?us-ascii?Q?7+Cz+5lPUPjSvu3qj8aPLKQuJHSsujNRYzY+xijUGti+vJzAY0r/x86l6jcn?=
 =?us-ascii?Q?l7zj+CuyV8k3tigAr7r/cXJPpSETvStAVmMWBrqGPS5/2cBRNu9Jl6eYD+5v?=
 =?us-ascii?Q?E0zS7KImHVHrJkFAj7DXFqEaq3/GnuYxBqeybkClEu6oDGhJFU7Z4zwmLIj5?=
 =?us-ascii?Q?mN6Po2GRmYn1SxV57uOd8DLlu01MNRjXeyBUX6Qsf1ZPwmlLi1Das0NeRp1W?=
 =?us-ascii?Q?qn7r3zAbFadM8VWPIZpAVxWxDfU0jNt6hjBK/I5qkqiRaTiwZj/urML4FUbm?=
 =?us-ascii?Q?9uoJM5H4Fy4FaiyWHtAWl4tLZiy2U/LIwev5rLeOfc1bIpR/hvPezbLYeoeo?=
 =?us-ascii?Q?LUYsB20s2Y5B2ReqD3jKz/F6DSOUstVuRX58AvOuThrwDhSFl+KIPcQx9nby?=
 =?us-ascii?Q?19TxFKkm/wH0gET6j3HowAmNrMvMxD70tHL+EiJMqK8UL+ySgEPuXiYgjbWT?=
 =?us-ascii?Q?Mjl1V0sZjPd+KfHAuwqBRbIhgzwyUpxgPg3oR06OxCUOo3nKUMq4fRFlLSVq?=
 =?us-ascii?Q?7rHmGu5R4cpcMrojjUbH6FDhWpf+TeBUzBMYlBR0X1BStIILVAXkJCYHd6+I?=
 =?us-ascii?Q?WOhwDZwFQs+SmYNLoSkHY2GYQuwGL8DtYEthpQUsA7XRBICkN6bdwvDM/kpd?=
 =?us-ascii?Q?YUfSHEJ2m5TqNpYos0u+VPk+yAKo38wwrC3QYMZjrkEm9uQyZN5f3DHbQr2W?=
 =?us-ascii?Q?BwHW3C8bcJr/TH7ZwiH4yrYZRO1bBoFwyQqJ/PRFcEAqbA4gQnNe2+v2FNGY?=
 =?us-ascii?Q?z9tNSIH6eiaSMaEwfCeN/ktRb6lAaDgh1yFvUZJGo5+v1C816/eRCjKAG9dW?=
 =?us-ascii?Q?rM18lGYOfkkOlx31EhmEmTjDgXBtPWLpKP7/JmUf2FVIijLMd4KExWHMIdYK?=
 =?us-ascii?Q?0opxOcuIPxB89zPdnAkAf8ud6NXlWgDwSLKzI3K9UnQjZEfv6rDnrpuXd0Eh?=
 =?us-ascii?Q?VfW1Ob1Pn9cHp4ts76+8FdPoZSgEFGpuWTimiMqOm9/hXKzcCFsv6688mp0m?=
 =?us-ascii?Q?BOv1CfygyOLPvmlaCPIjajoW67XmiJssA32Aw6S3eg1iPfnFOK+GVR5a8s6n?=
 =?us-ascii?Q?acUssDL6HiGC1evDqipXWKeJsanF9n4tHQy8cFj1exehqPdoZP48pi6//CgX?=
 =?us-ascii?Q?i7ivuzPdQ8OWj4yMkRXU4Ec5kuFmRTKEE2NJJKdrQFRflCkSBABqpo/IyIx7?=
 =?us-ascii?Q?4lxhpEu41rkspnsGadg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc48b8e-9e2c-40aa-378a-08db352ad0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 16:37:01.2433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWwxRYd/xMhf7SUaoObsogaXYiAuQqz39LDZEEqRaCTfEPIwVQcw8uAfs9nZmNT5NeOd316mFSmd13O/KXsgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Subject: [virtio-dev] RE: [PATCH v11 0/8] Rename queue index to queue number


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 4, 2023 3:04 AM
> > Please review.
> > This series fixes the issue [1].
> >
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
>=20
> Could you knock out a version based on Halil's suggestion of using index
> throughout?

Great. Finally, there is an agreement in choosing a word. :)

Will send shortly after interrupt coalescing patches merged to github.
Don't see it there yet.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

