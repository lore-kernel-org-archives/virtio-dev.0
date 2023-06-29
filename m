Return-Path: <virtio-dev-return-13172-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E5EC001B0
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:10:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CBA781EADE
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:10:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC37A9866F1
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:10:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ACBAB986677; Thu, 29 Jun 2023 22:10:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9793498667F;
	Thu, 29 Jun 2023 22:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKK8dOxV+6y9WKIwlDak651Dw6KyyV1qfvzFXU4lhi3sFj7IbWbj4CsnpAr0oSM5eB68irKHJ48i8njsBtEY96Aiqw5I9rjySNqKEzU9m2QNYwIrQz3W61P4OLG3X+VL7TJ+53TzBUaNEgFvDBhvDyQ0C++Qy3Nz6BmtCZjJVrflij/IoduXqmatQXTqmIJuGgJuWo5nVzTSIR67m/RiXXT4ylbjzVUOJL0cHZaJG052Q5E1kKk9iUuFgeU6tw99SqMpKlgGo/7IAYjtKBIzBkv04B4L80KQZFnW1we03HoBpaP5uPgYy5zIsyl/YiHk44+fuszAf4QjDomv5ISLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16RhhlY5+UAMv4lmQqHMPjxAN4LXI5+DL9e5n3wTVCM=;
 b=XO+ukX8IlD6E71WZu/wsepr1GHMqjH1mi+gcEcdiM1P/muFugh+TStMY8mv00qpLGDR5xrxJqE6UM+b/fn1U5re0GmSeiZ0S6yE7BLfuJQCcQ4v0rvGCatzKHDC8539jtnZ/xwAmtkdxjwOBIbv8Age77Lut1mJqj5U6Lsmt/kTEOilGE3MbSN+u4j3L5vv+Ct7CvSQgpj3ZPf8T6IaYw8KTFXUJVyzDpDGdDq8No1oE5yDcCEJ7iWELa2SfYa/7mUtl16txsZbcNPCXyAD85L7jukuaHkxAzJi5OrV6Yicbzjk4DGu9N4zE2zO7lUPiCtn+HpvedZ4rF3wSaXgEhg==
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
Thread-Topic: [PATCH v7 3/4] admin: Add group member legacy register access
 commands
Thread-Index:
 AQHZqTvrGu2WS2SUoUu7prURQx0ADa+iM1gAgAAbrdCAAASiAIAAAHOggAACqICAAAB+wIAAAn2AgAAAcuA=
Date: Thu, 29 Jun 2023 22:10:53 +0000
Message-ID:
 <PH0PR12MB548186C2583259967459E3C9DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-4-parav@nvidia.com>
 <20230629154634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629174443-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548102851D796A39FEC61275DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629175234-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FAD16EDAE283D0356B4BDC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629180620-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629180620-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5620:EE_
x-ms-office365-filtering-correlation-id: 809f3a04-8bac-4982-d18b-08db78edb4b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q1A9bQU6NeDIjSSgnL+M+takqIx0lQ2074kLw/3ABANtF6VvJh5tjD6XL51TOT6E4wCrX4IzzQeTrdZXOKW4R+t2b/DaRRZGJf3vrwC2aJ4mYfe2k3tAIXRwTAUS5bfWgkVM8gGWXwMRLiuMt6RO+xbOb/7WKtL5aeySlrcoJd2Bd3ptv5XfJTgm5Xo+h6FOw5IDO786w4IGa/jA1d3VUHhWQkXS2su8x/sRQqRifqbow6E8xYjhSV+RbkJZkdh4dJgD9/hbATN0dZFeEcfzrkfle2Jm/48FxkB7+9Y/5DR94wJouAeTY4yvpiQrOh3cRAToH9Ezl3GolNI92Pb2ISkPZeDfsnGyJi6sje5NGBG4SzzT9M4oRbKnVELQ9Q7qrNbTesJea/eyVCR7q1vo/FBgQ9Z71QgRZZhqUjB6xYk5QHUAMV1UmmrlzbbwFYmYD64G3oCC11UDJ2hUXwxdDZoqnpdjbU5jIfkWKi1uCkqJaRyV6DhcUgXgfZgl0IvQdtlugD5jOiuezl8cXTahc1pbpkFB8JrZ4VCG09vPpcgX9hqDe4qminJCeKh+T5Ro1QlM8LsEERLVbIVjtQzciRWGFSUM0iF9wPz/+1ibl2rqC0GaVOwzRqOYDiCh9zL9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(54906003)(478600001)(7696005)(83380400001)(55016003)(86362001)(66446008)(66556008)(64756008)(6506007)(66476007)(4744005)(38070700005)(186003)(9686003)(26005)(71200400001)(66946007)(33656002)(2906002)(107886003)(6916009)(8936002)(122000001)(4326008)(76116006)(38100700002)(5660300002)(316002)(41300700001)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cTQJFo/vBw2+Vf7nY1hQJnTZi40WVICtZKvrAcaUeQkcXtG70vR4BJmv25HJ?=
 =?us-ascii?Q?RCFldMk2yM5rce9S4uHxNHw5yhUYTDwLsTxP8A84cFon/Lqymby9wT5lcDCE?=
 =?us-ascii?Q?LkVWvKsTfOxfnebXN4a3+e+jNrQwOPnqvR6rm7Ot/uG3YlblszGD3oFvw4Yn?=
 =?us-ascii?Q?SOplHOptPxJmV0kkvkBWaty4SNrylVl2BJ/C3+BGQ10SXssTmDwBeJu5O/Xm?=
 =?us-ascii?Q?7/ioijs+jf1DoGwlZJJdropYdPxNOwlGAvHEPxvKkBhD1wxSpdvfkUh8QDdm?=
 =?us-ascii?Q?C+YCiE/LdRrJ/dfj4Tjeckk/S+rVGrOoTRW/v3sFneJwspaYjokqjyMzAvQM?=
 =?us-ascii?Q?ogkxeS9b7xYU5ftud0pRALae9zK0q3zq7Qpk4kw2lGZaQi1uoTdGN5NbJvRk?=
 =?us-ascii?Q?BECA52vWlOo8hTZbEmpWOSu2WhODGQ6Qnnqe2fruF7quGh7tpU6Ee8ATG+hK?=
 =?us-ascii?Q?HRWxZJn7T/z2NVg4G01XY3rOtVWXzf7eVL4BVlpYiDcCnTU+nl7qficPo0AP?=
 =?us-ascii?Q?i42bVJ6naWcYyxojfCYKGjONssF3sdxAt0MQ1sAoHpKBz4m8hRkeI0MKTfOz?=
 =?us-ascii?Q?TeMCmjOS5xRr9CtzldxYrWOhVeX72FGGxrwF/GJlrDMVmsgoAO07c4YcCU9a?=
 =?us-ascii?Q?ZnqA2TaIwwv6F0Zlybp1paEAAs8Hc4rF4NyWoeGX1pLnoEoQgxxINLcxulNn?=
 =?us-ascii?Q?JihLgtIB+PK18IiydJ6bDYoEaKUpwnKMXDfh30eO817b7ComQIneJv2btR9h?=
 =?us-ascii?Q?uWd9GlCnYkrEp+nlvn7JaAK6vh/8wtmpMzmyyssYBzkhGUgAUhRpkeVMfr3K?=
 =?us-ascii?Q?1+6/Xx48GL0JGq/K7RC0FeSqnAJoXGdRnwA+o1smD8yd9ghodjFN6oxcVaxL?=
 =?us-ascii?Q?5AbD750yR26k5sNLUiIW60ZmlUkoO2pdoCjHazF4vEXuaVOieZePavX+Z9h5?=
 =?us-ascii?Q?FBLPhxhqe2eDvtOyAeDoo3vQlFuUmbyN1dmb3TbmO4lJMmCqnMI+Uzox+fT9?=
 =?us-ascii?Q?sXxwJ6+uUhMFw8eVobkHUuK4uuVIajmFjKN3gGRQkgSizpv+qTuad8clh+4m?=
 =?us-ascii?Q?EjJByji+5Ts277YypevG4p1k7bOUSFDpPNTWR3eng5iLvD9HchDmhQAMeQWy?=
 =?us-ascii?Q?HTqJl63dwYrRMIAXLDdymVCDdDsqe30oxjenLIxFEn8bLJsuCKM00O+WTKZ/?=
 =?us-ascii?Q?JDm+BbGtOx0iUBcze5HJLeBWJ2ounOUnm/N9QrtBxioF9dQ65sBSa0F4BO21?=
 =?us-ascii?Q?7jLuV7SssPeRT7prlkPgn5q20myAbuit8fWTUD9Q0dRMx73kZjKmsQMWMA7d?=
 =?us-ascii?Q?TnlXGYOtGL4CKEehX6a8VKZgc0KFaA11W8zgWWNRHQpX84Thp+oh6Nc05e7K?=
 =?us-ascii?Q?/WHFZnZd75NPVsCVys0ZmtG5VR85dcY78sX/4glqvGEcm2j17RkvKJNcczob?=
 =?us-ascii?Q?88xuuQEwLhy6TaJRBz55+Dykaj9LRY1Id90QT/dC1ai6VWUKx6Oc8jqWYlaE?=
 =?us-ascii?Q?7gGVl+fXqybuba6vJUnCX2L/qknvD6/eN+jF4ZuJg5JCjB98u++2vGeE/2zn?=
 =?us-ascii?Q?1AXeB00uGv6j7lIS/vk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809f3a04-8bac-4982-d18b-08db78edb4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 22:10:53.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkuLDnPkLwCZwQm/bwaXGTIS+WhrRNHVmGmY14sUxlz/B45INqWb35yBoPQvzDVRBCw9bZ8mwMoKbwduiawIPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
Subject: [virtio-dev] RE: [PATCH v7 3/4] admin: Add group member legacy register access
 commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 29, 2023 6:08 PM

[..]
> > Ok. For v8 I will have link and keep in pci transport section. Later I =
can move as
> union if needed.
>=20
> I can do that too.
>=20
Ok.
If you can merge the first two editorial fixes, I can drop them from v8.
I didn't attach github issue in those first two patches.
=20
> > SIOV for PCI and CXL will look very different, so SIOV legacy I am not =
expecting
> any change for these commands.
>=20
> SIOV will need a notification structure within BAR, and it could reuse th=
e same
> one.
>=20
> > > Also look at virtio_pci_notify_cap and check whether any normative
> > > statements there should apply here. Alignment I guess?
> >
> > I will move below normative from pci to generic.
> >
> > The group member driver SHOULD use the notification region supplied by =
the
> group owner driver.
>=20
> By owner device.
>=20
Ok.

> --
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

