Return-Path: <virtio-dev-return-13218-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F44EB64DD
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 16:10:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5EB9C866A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 16:10:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 596FA9867F9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 16:10:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4E35F986597; Tue,  4 Jul 2023 16:10:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 370C4986599;
	Tue,  4 Jul 2023 16:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkTFfTB4PpJ78fXmyabDUL4fHT7eiM5fkF+gkOMzXqvt3cz5MaaSuvLv1/D5aoNdIKAQyQlH4o671+uk6D2637Yf97N88Oz6KFP4e9EJBotdkRURdbv4svMzeJ03KEqZpCZDs1vMVIkT6v/CNyzq73IqPhLbdIGdsEwZvG+vkzMFSjeGXA7S3t+orT+yC3uWQJkmAuyQv88wSaBsYixidWrYVeHo6A7Gh2PSwmTLvwtfwVKN9ZoQkpN8LjYZtKM6woCKQlHwtTPJjAXPzYMNA2XyqOxifCAX7vZioXCZfljy5f5IQaBlCA8Fk1/r1e2VlYEFHdHtUs1ljsaLxcmckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbUBqPErmUGUOqZ8as9gRVJji4d+Zv42wFzmldmmq4I=;
 b=RKUDRQdatV3qE+xI9WLTnGhQV0QOREWvhTxZtigN05gOAma9TGN9qhpMoD3HUpjnTvwHKmMyPjpHNgv/Yp+vM/QdFHeUlKOAvNbvL6A+HpPjQtJnKEFA+s0o8qQqLnxVX4qBIv9OnOF6rBEk9qfhtJodXFJFGKyQ4kDsH75/ChT/oBiqcZbzy8guvXP1ApEM8nY1mjsuxD8TpmoEneuGRlgPWXGigh5mfINMdSVdUbCttzqYM0flbHHHmawMEBW4P6tfyS3yuewdDL30i/97mgrpYtxYJuvf17YUqe2YIX/8qI3+7Fm7VLIv4qJcgIOfqxKyohD823lQFsJpk7ScRQ==
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
Thread-Topic: [PATCH v8 0/4] admin: Access legacy registers using admin
 commands
Thread-Index: AQHZqwo3LlOIYLW4T0GWzsM1aRxlEa+pn0VQgAAmcgCAAAgu4A==
Date: Tue, 4 Jul 2023 16:10:19 +0000
Message-ID:
 <PH0PR12MB548136724DDAE47C640865F1DC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
 <PH0PR12MB54811B4999A4249C55AAB41FDC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230704114012-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704114012-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7927:EE_
x-ms-office365-filtering-correlation-id: 509098ed-f91e-4f05-3305-08db7ca92980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9SG9cH9TIfU2XX7ZbGVRP4qdjRSnQDcCy1gvfdE4g87xUBV4Akmbue2Mqx0e8/T7RhMpwiqEK2zEle6qxdY/7VPeSPEv9OqEhouhoQ1UYb3jdmgfc7U9vAX2s5g8lSSKO6CTB28bTjElXAje25UkD3vVMW4X7OuzS9hEttPEZHckVqemeS/R9uXgkWHY+CcfIVfgeY4/lSow77GGFEyotJwFAHZz81mSnDAr6fU82plFI9PzdTnaDfrL/0aGekXKFFxsfHLaUDwyT1i5+hRWFQmDm462qk/674enBsoKXzAN+xeJXFZEhR/gwPAs79Zgx/Cv4p8+GmkH8c2XhJ4KIj4zv9hql1bOSJu8qjIRIzkOI2dpbnYhYGfGkiZ6BI0DzZdnn8cmytJxI30/pnEhfvkf9Vi5ew/sO4UQ4CgsU84kQz2QhaRIdH8/7dNgG1wBEmYPTxLeG2EW6Ikg4wOLz5wE0szspMriAOCRspKf0we8YQoVRhM7bOmp0+0v7z/O+o3EsxtZBMldL3QD/HoFcGDS45gF9QyjwO9yXoMzKW7sYQsTjv7ja6xbNBiBG7A9gV9qa8iTu7T9qobHc+D15Ob8zCx4sw74qQxI/nT43a0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(6916009)(4326008)(64756008)(66476007)(66556008)(76116006)(66446008)(66946007)(122000001)(38100700002)(107886003)(86362001)(38070700005)(186003)(26005)(6506007)(9686003)(83380400001)(558084003)(33656002)(478600001)(71200400001)(7696005)(55016003)(54906003)(41300700001)(8676002)(8936002)(52536014)(5660300002)(2906002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YVbT2JceYIOKvaXLSW7VuPZwqo9xPfSwim+yxgrMqcf8+T954DMAlG5/ooAR?=
 =?us-ascii?Q?N+2WnzVaY9u2CR2PewLEOl40MnK8wGuDyt3A9CWVABISpLjDe7SOpzMcS5ht?=
 =?us-ascii?Q?M1rN2OTujSHMTSaxw9lQEehbUrSPsteKvhLby37n9yTblDSxzdY6zpIKMokY?=
 =?us-ascii?Q?XqoxQys/mr54QzUUSpycQgNg0jDmt19vEWVUP7zJ/DUOUGAdaCgyxbg26IXx?=
 =?us-ascii?Q?irZPMub7SCeEtawyR39wwO5uLDISkKHO6TbPocDkjIynzGDP8pBP7rYr9ahW?=
 =?us-ascii?Q?Y9bQPVGvgTdFM5HxwMDVzxiniSHhdjUN70Q73QHXSA/F3Ual4ALouWy/A2k2?=
 =?us-ascii?Q?lRlJWajmnNzBTu0Q8W7ro861qPWk47wsedwZsyjZUDgf6t7UGEaKrEEIZRyH?=
 =?us-ascii?Q?5gy5I1JrgR9A/Swt+C8iALqK5+OlSiHXEcCZODk6H76y9X7R6k5bQfdUb0iw?=
 =?us-ascii?Q?Bb6RQWaj2qVAbSQubA9Mu611rgSm7ri83fdd1ftEs123CpiCg1/IZ9bzett7?=
 =?us-ascii?Q?bTYMDOH3NmVHcBDh2kN1pwtmV597l0L9PtkASJBcInEnV5L+Z+fIzJx+6a4o?=
 =?us-ascii?Q?kLh2WgfZ2lsd/cpoMsdST7Y0eU2zde6BTYJnWOflhVista1hQDo8+tGIHBXU?=
 =?us-ascii?Q?deXak3XXrVHiRQ/7AmAG/f4AvOV8AS1BDH2+fLID8T+ITRqlRaSajlNHen21?=
 =?us-ascii?Q?lJ4KBWUF+R5uSZeDunFn9c2PEZJ7pRRXS7sAic96VWKTEo9gBp/dWIVcCXa4?=
 =?us-ascii?Q?Gi8TgAE87nCxLqSXk+YLIqWFnXPKe1cS75hIs51R/4wIZQbJKTtzY9hFXiEN?=
 =?us-ascii?Q?IEzhq9KuX3l5S0QrFTGH1Qyh25nDmEd87NF9PnW0BONDDJ7q0QXpReif/Bjr?=
 =?us-ascii?Q?8+vvm7LtgxhJ3Cb7nqO/Gg9tAXEruylYm1uFX7XilXNh2XnPUnam0OMtI6Bc?=
 =?us-ascii?Q?nyPtM8a0lwx8PF8NnKdN9/kA4YmAs8kdyrFwyM0+1QB985uW9aEnhDVFQWBd?=
 =?us-ascii?Q?hsnGu95X4JV+gaau/c2wvh4vNjrLZvhMmE+uWwQ/Ihw9EXnfHdHoj//72yWU?=
 =?us-ascii?Q?gd9Up9nPNIabMh+ODKQJyXjoQ1i5wwG0nmKOhDSQocBUXWfyCI0TSlHbb44/?=
 =?us-ascii?Q?BTLgxHFMTN/f/VmxNTYZU5eoH2H0c/UzuEMy7Y7uwJo6KB9LhlUmdC9YzbbW?=
 =?us-ascii?Q?bp8jF7NtzsF2HXBJbFXHKgjFx4+fN3mZMuCDl0oqv6nfIjg+cDqJuBMgk9VC?=
 =?us-ascii?Q?JxG8h6tbV1r6r6rAbRgwNjGsxEIezoLjoidLXxhAt4aAIcKlanwZKUry1TTw?=
 =?us-ascii?Q?8ss5N8G0KonxxmBTNPnxPBTULZgt5JWGVVmErEcu2RB6znXF4YRxnabyFs1C?=
 =?us-ascii?Q?1cr7ak9BTO97DC89eK5Be324wHE1nfrhb1pijOAusHitlEDRQx0UlKwa6qpr?=
 =?us-ascii?Q?jTAJPOp4lXz6BvNq4cVA5hbaXTJFMjyBNxwTo3O7WNUOcc6Mw4km9O62DDyk?=
 =?us-ascii?Q?OpHqlmStwXRwCX1L44JPuHmQXHvMxb+Q00tRZgOmHsdHyqgV2Mtuv1CA+SrX?=
 =?us-ascii?Q?mMviQ3q0JiAJBtve/6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509098ed-f91e-4f05-3305-08db7ca92980
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 16:10:19.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgRQSm0pn4W50rDVKQPPnaWqWhWTMo8t0K0+gmMZGXyiqcla2RdsKg4cfiMiAopsjA3dLg+Ug8M2Z82MsNzrsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
Subject: [virtio-dev] RE: [PATCH v8 0/4] admin: Access legacy registers using admin
 commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, July 4, 2023 11:41 AM
> > Do you have any further comments on 3rd and 4th patch?
> > I fixed your comments of v7, and some more were fixed.
>=20
>=20
> Hope to send review tonight, max tomorrow.
Ok. thanks a lot.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

