Return-Path: <virtio-dev-return-11377-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6AFC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:43:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8023744347
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:43:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 765AE98678B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:43:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6B8D698667E; Thu,  2 Mar 2023 13:43:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EF8B986674;
	Thu,  2 Mar 2023 13:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1fix+lptqUxteN86TEmxwsPNSgDc3iWqyGOKrqehFBCIQfFwxkHmcjj1cVYOrmsxTYBTR+lBxDxBhqYYsWft5uWJ3hVyo+i5q7x7uWYhwbywgyC+lMjUd1Nwx7NJ06VfHUIKwg9oH8A9bx2Fe9iGP7eogSjftOrx4k0Dj/HrrKCy57JDnAcyut6gjgljZaCGPFxieSF/3AtWRx4+dD0xPUXbHchHssRBzCksjDz4sW/N91fHnteJbU18wqLNVWu06UhVDU/AbErY8XO0f7+mdhFin04MKNQFtI6aTlDZy6c696879W56jqQh6bTfFaIJQpm5B4bs5AFyn2wClhTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYAUApQ10OgVDRLYN1MeY9RkbHYOVgdeuUt9khGWIC4=;
 b=lLcfmAIbTCqXgVxXxIfSdf1tO8rimIejD0LmAOOYa/WaX2svlH7XgI48yWzZXuTMbwPy1AMNaKvO4CTBZwKdw4Yga+Aq4z1YB9LHvc+RfguqaZCQHg11H1g30whePwvRgT6bOCgNAD5doYFM3nkD6nQN3UJctop0AgPcCg5CxAs7GixsPGH3b3idEReyBTlbT/M3l0Dap1O8lA2htrNr1mFV4zwHf8y3i+/AmY2p3anuizjOeuFRz5/o18rzUWXEUW1bTvYq4apwknjA2pw0h3Aq5NRJeBf87MBgugOKBxv+3ff69WgjrnE3awRJc1my8FZIcZTpM/KhA2lPn7uK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number
Thread-Index: AQHZR0pAxGvxqZYuNUuHEK6ngQ2mvq7igR2AgAO1AICAAARNAIABUChg
Date: Thu, 2 Mar 2023 13:42:59 +0000
Message-ID:
 <PH0PR12MB5481F696FAA2F5D5DB35912BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com> <20230301182207.23f995cd.pasic@linux.ibm.com>
 <20230301123044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230301123044-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6355:EE_
x-ms-office365-filtering-correlation-id: 055201e3-0aa8-4683-3a9f-08db1b2409bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hSsctBFYnAB5nhNdMXMvAlANZJY4ARumETjtjDKpGTCVR3ac6kaDO/R54QojtsiWoXsQEkv7yiVZhiMv0KURGGL+W1glX3vI48jqt6kRs7MKYcL5cpRWXu8lI3xCgI2rIoQn9LCfYNpxtiCQQdvCKCzlJ18vqj8DcK8cm8o1/nn7NXtr5lSgvfafWNt77jj7Ppo6YvP74D2+15naaew2kxluvt7bec7nEcdvajJga0sZDu/pb/GmjDIqJcW5c3M5Lxzdd5Etd3loLN582PG6AcyYG4cdaimAFaylCCLGFTr9yBbnJn8Wyqm0O7lz5PfV+kYbFF5YZozKwiph4adp9zeDO5qhT6OzjIkwvfWnQLQ3Qvj6lqfb45LKxviPTdclWiLvHLbrnjn/s/yIBDnBy3DiOmXRE51JUYaCuISgqUg3KZe/Z0C48kIwQlp0Yf4VasNMnO9qVsc/JmLu/j131ErnktzPPkgOB4xsVH1qbVGT+C9gkmXGC++U9/KkCv+GnZgu4YwQcvneQ1a05BT/An+WSdqouCmiQBwxMBm97LrZFTkxNbO0GGOYVr1NtiQ0aTjAPoXOX0vK4SjP7szq+xviE9L1FWtuWzscRk3thJzAxa4aGyf7eSLmgkXHEf2Ff2kQsO/DB5kYbnmnua8d6qh7AN/ajvTsNrnMLZnrE1mtw+xWrFcA8uaJmthpG+C1+zeBmk2Q9VpOWJfO/uQJBA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(33656002)(86362001)(66946007)(52536014)(41300700001)(64756008)(66556008)(66476007)(55016003)(8936002)(8676002)(5660300002)(4326008)(66446008)(2906002)(122000001)(38100700002)(38070700005)(7696005)(71200400001)(107886003)(478600001)(316002)(54906003)(76116006)(110136005)(186003)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dHnMndocXXBah6l4AsZ+T9WUKt+krDPMG3/HBjoeMRTNOVQrJIvtzlux4w90?=
 =?us-ascii?Q?8+i0NaFXWbvJ+BEzti/4Y3ATXlPk4RPkabC86mPoNPY27BFkEmo+8wFnkizk?=
 =?us-ascii?Q?ThHKTZzRi4l7F6K1oGk2AZ+pCkhdiaY44j2NsgCtstWxM2uG0adiJmqA6Y+J?=
 =?us-ascii?Q?C40yWG2ZMbcbTX0GSEtuDGJ2jkPJHIJCW0EBUQoeQd3wQRYR7KIpSbDUC4ju?=
 =?us-ascii?Q?L1GE5xajn4lZOUxWU1WqRhq8vJRjG6tr4n56r1fZYZpZTixNqR7WljCoFqtM?=
 =?us-ascii?Q?M1XTper5hZClDjOwtWHFkHmynlXLW+1FjzG8t3KzIeGjfZbH9STX5cdJ3r+g?=
 =?us-ascii?Q?lvtTmalvt9rXD3lyIND0YS4IITVu3WzIo0fxEEB/2kEYoVeI/xqSWkX5pH0E?=
 =?us-ascii?Q?fWb0jg/7H+sRYXfsmv8fi90IGj7mrZ+PO+ocTIPHGjOQBdD4JjDP/buFnLEO?=
 =?us-ascii?Q?PYcUH69ldWTN27BOOtOX2y07pWevyuEcxkLWS3e55yYCyNYFUtLvmiYTZDz5?=
 =?us-ascii?Q?mpRzcINgOpaHTgDEU/9vqBz5g+43eOsRbIFNaiVZMk1IkA/CciAr3rAXNbhs?=
 =?us-ascii?Q?e60pqsMEyZXEPBw09gO3vcj737p/W09ZtAA/MBj2Y/2lqzjdUr01kv5kOygP?=
 =?us-ascii?Q?+s6kl8VkFpfc7dnezorLRZvUo5V0o/m1LxIp7h/rNNX4YUqxzj6TO/BmAbSR?=
 =?us-ascii?Q?dg7nZUq6D8IRbjWFNQuBKGIQOIGwZQIutrLcbniD865UwPeZa1vUHuORanGx?=
 =?us-ascii?Q?RvkyNh+ffYuclNGO6U50kxXUQ9LGrpmXrxaHRRw1CzE7bQgkXL4dLa/aeMyB?=
 =?us-ascii?Q?lpBkHEzVC/F55RYfDeED+SZX45OJ1u0EiMHKRP7QfPWMwSMfRLMB4MIobx0S?=
 =?us-ascii?Q?DBQcAeRsTDbEm9wIA/8mrE5FMRuFteNVEN6RbShgKuQCSgliqEj+b5NQX/UB?=
 =?us-ascii?Q?HHhunV+K+qIG9L0kPnorYK4H8t5kY7RngQrw3SVDZWy98FNGTtpZ7DTjZOUP?=
 =?us-ascii?Q?o/BmggpETy5RbxEu0vuMR4qE0nY+Vph1nkEPxNzbNpnsQK7oPlIGkQ6QFgR/?=
 =?us-ascii?Q?ym8Q8pgMnAQ9IIEfX/ehC5tbeaCpg/xWWsOVopAhAO/yvMqNTxpO3pLXWIV1?=
 =?us-ascii?Q?enhhpH9DK6qL86e1zZGwAcQWJajRLxW4QN9jU+MuC6U/Cd05oE1BRNe9ElMw?=
 =?us-ascii?Q?uhXQKIx6z7QOgriJepgPefVmbRKVgh4Srl7ZqF9gqJsgovssy3olweK85lSh?=
 =?us-ascii?Q?+MrhfEhqzfdmO/oRpGQkaAzo9JdVrxUXl+r6BkL9CkGY3goUbuLxO9px4a3p?=
 =?us-ascii?Q?Kn3Itdz2kykqa2rffqByRnsOHx8koxFR3pSog1Tj6Rh+pN69ywfmGiXBihOH?=
 =?us-ascii?Q?OHhD87rbsQroOUGosKJb3/ra7FFU7AXtOHdlcUKK7trxTaHXE2OqjLmqgVYk?=
 =?us-ascii?Q?WPRrp5GCoFNmRElWfqzmdCWpBDDt+xk3pD6jC8ImP0IhzM7q10ZgToOLpXUG?=
 =?us-ascii?Q?5Hhc0ZRt8yVqnQvxGe3RXY5TXIDKHRDwTXY3yAo3/eEdfeFJbJg5MIuMzStM?=
 =?us-ascii?Q?1PpXUpP+2ApAyTso0Iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055201e3-0aa8-4683-3a9f-08db1b2409bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 13:42:59.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aV6RQwBdE4Ig0CcQ4yHpXQuTmJlhHis/vK5ND9LSQYg1yf3rkDn9LopIY17LzY7RihVWwa+S2QTQcYmKv0p2nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 1, 2023 12:38 PM
>=20
> On Wed, Mar 01, 2023 at 06:22:07PM +0100, Halil Pasic wrote:
> > On Mon, 27 Feb 2023 09:45:31 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > > For the vq index/number, I'm not that sure that "virtqueue number"
> > > is better that "virtqueue index" -- actually, I'd prefer the latter.
> > > We'd need some renaming either way.
> >
> > I prefer index as well. Especially that we start indexing with 0. Also
> > seems to be the more common term for such stuff in both Mathematics
> > and CS.
> >
> > Regards,
> > Halil
>=20
>=20
> Basically I am saying that this:
>=20
> /* Queue size for the currently selected queue - Write Only */
> #define VIRTIO_MMIO_QUEUE_NUM           0x038
>=20
> is a bad name because queue number seems to be ambiguous.
>=20
> Maybe start with just getting rid of uses of QUEUE_NUM meaning size?
>=20
>=20
> If we want to use queue index we need to fix RSS spec in networking
> since that seems to want to use queue index in a very weird way:
> networking has this idea of calling queues like this:
> receiveq1 receiveq2 ....
> why 1-based? I guess we wanted this to be clear even to a 5 year olds ;)
>=20
> And then for extra fun, in the RSS section we say "0 based index" where w=
e
> seem to mean "this number in the queue name, but subtract 1 in your head"=
.
> Why subtract 1? I guess we wanted these 5 year olds to practice math ...

:)

I think vqn is just fine that helps to keep things simple.

I will insert the patch to fix the net device's index text and other text s=
uggestions that Michael had for MMIO side.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

