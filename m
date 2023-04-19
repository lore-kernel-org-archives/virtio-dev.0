Return-Path: <virtio-dev-return-12313-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0BCC77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:35:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21C4D41EEB
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:35:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1399798662B
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:35:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 075C5986432; Wed, 19 Apr 2023 13:35:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA6AA986426;
	Wed, 19 Apr 2023 13:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0fQcSR0BphpGXNtbA5FkHkAdviOBA9UGdlefBIwB1ty4RQGKxuhX9cP3vkbDwfsWF4BP34ZpQpsHByRdSz7uxnEHoRG+1Or/B+g7KsyK6DM8z90AdkrZi8awmLYk4e6m+QieAhalG/i2u4VzlW4oerZtuEIC3G1rNj6TpPtT5OPPm0L171dzV80C54934Yd37Z8NggOUFmZ7UHMBiFpUzS9eqUeQh1gGwNcOVYq+QpA2o/DSW4LyPZeKwb6iC1dJNuBmOH6TTF+UeV0qX5V+5Oz41Ymk0kjG9ojsSwYOLRBP9qyQ6GvIIS8TylDVP78J0WAfHfD71j9uXe+ZcP7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tPHc+OurWGP8lp8JXEDmPyDqWq5H6GJ6ah4gBS1mmA=;
 b=ZJf3oBRviTK9AGUPaCSS3xaBkqpuMerNyDTgTrpU8ng0OWGeCg2Cz/1bwoL1WAEHstlNmZp7z0tlHoWyuJhYfi+mmb3la3Bh1/xdDNeHyAO8qQghdJkUKo34aYqoRgt8+6qM3xwt91Q9wQLVxD2i52/SU0vTBhJ4RoU2iPW+UazqOAEv2IwoZn5dvw4p2x1Nv7fRKf21jX8rimxsqzbWy7OY8sAtz9SG+t4o1kIMTnisYkS4/tHiS128/+F9+jc77/Fl/H3s/tJT4lU125gNONonu/QYEa2EXI1fw2BEdtTqedzD5F7HjTbkIyyJDNNgOc0nVJfRcZNx/xLPk17zBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] device-types/multiple: replace queues with enqueues
Thread-Index: AQHZbLDQUabXUOZYdke6uzVPKsmTjq8yrYqAgAAAUmA=
Date: Wed, 19 Apr 2023 13:35:32 +0000
Message-ID:
 <PH0PR12MB5481908F52883B1C3BE31A15DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411200358.753101-1-parav@nvidia.com>
 <87bkjkngj6.fsf@redhat.com>
In-Reply-To: <87bkjkngj6.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7761:EE_
x-ms-office365-filtering-correlation-id: 90da238d-54bf-409e-484b-08db40daf303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JtnGVzQT23kl+Nk0RH17+QcGzX5DjDQgkFccHQQS+HQGEpT0YaT6Ug++gOn2nOtbw5oser+Jxo9wLrpd8qh6K46CiF5oyasJjcpi8ykfAnQZi/DNz0LAQWi/C52ArPlBo1ZoWSj26SUjdQiWroiSyYOgkRkI57ltzjbeKa3kyHAM1mLPXc2kz737cJYAcrIYWLcTPb7hs2LLoeNvmvdCnJgBE8rJ+6HfOgfe7b3Ke7O8DWlNsGW3dy5LWwIx63N+lEtYxZHGrINX/6EtVisXBfOROFRjWNMV9CM4wOf69T9DG6NQ6p7MSTN5O241z5JW2ublYAr2o45XrjJR2IVNloRneur+A5EOGR3XQ3j0d0p6dQaPbcip5URaU7H9TMUub5jwqarSaFs12/GMUrFxCMwk7X67q2zVWrrZTzlZrAeGfdh9kEo1fhqX78BrNIJyztDowPdNVPFSgnSrfhGQd2f1+ocMH3e9vjTY4Ub5BTV63ZWZJsvPgFJdxyvH0vFK+OeUjpRfXe0Fo/vwyaoZJZY5AEVQtJB6smrO/773ZSuPEwh5pTXefePSn5fOTFwvI0hWmQcOC9sCDlFgsRFE61RLee0T8cTGF0xcaZZmDhPBhI4caTyrwsL9FfyYYE36
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(55016003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(478600001)(110136005)(316002)(54906003)(8936002)(8676002)(5660300002)(52536014)(41300700001)(122000001)(38100700002)(186003)(83380400001)(9686003)(7696005)(71200400001)(107886003)(6506007)(26005)(33656002)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tDA+l61C6tElCxUtWd9tHnszDLRU+NEyKbQopCRD4WoFPBkrvYDijsID9Lut?=
 =?us-ascii?Q?CODmQ2qMdLPPU3quKQplhYNmagB+TNv//DwNsf/CzmH+efZRNjAi6xNxGKYc?=
 =?us-ascii?Q?kCZ8Y/p9rmc2lr+uau9jQqvtzRZ73XEGV5eC+yx57MPj5mJK54b7J8xi0sPY?=
 =?us-ascii?Q?ctDn1BlTwUNq6khs3qPDwBxrBJMuSGu5Va9b8xD0/XxxdXN5XkJAzBCDDqvT?=
 =?us-ascii?Q?8D6xT9+lyTfeF5r/c87jQw3vR0bXWvjOUl6ayKVkmHnuVmvsCpa9VbtFTw7b?=
 =?us-ascii?Q?EOqpXy+cYM+1cb+4NFPEPhyjugxOTvxBkYrhBcKbO7LMjN3Z6do82/WbK142?=
 =?us-ascii?Q?3+U+91zO7P+bpyWF3rLR024YivDXaI8lCh1nS8QOkYpHlDzilJkbJ/C4Z+ZT?=
 =?us-ascii?Q?uGS48d+0gnWrvdbag6ahC/SrAloMfKdaiUmVtPOkz4012T1V8FokZQKKqMc4?=
 =?us-ascii?Q?qvBIzrKGXG7yIxYQ3kyOKJRSnaOK7505cOnQ55VDRLbYgeG9PFFzocLciV7h?=
 =?us-ascii?Q?IExdOMYLwzAah5/YTe+mPsbzkBoxbsu2GHyBXhZ4t8HrPGQ9QW6fWOqSsdpU?=
 =?us-ascii?Q?S1tHAKrfdc6OaHRQ7R1XSR4HcyjVBcezpHDGm9B2qD6X13EBul3J7hJv7DN9?=
 =?us-ascii?Q?r42aW2Jgmie4/4kqkAwfSktC7H8/W8BGoSPEfGl0oNuak7RYYl7gjLlxoGNu?=
 =?us-ascii?Q?lwyPk1Oy7uLFb92uMESKwbo7VUxIj7TqAdjzglQcm1wQqPDQ5aBnew29EN1f?=
 =?us-ascii?Q?fXptMQWUWzB3yAviAz+c4bFmUQwnkD0W84FyEMA5leLrhkp7Enu3FEoDJbSL?=
 =?us-ascii?Q?v+R3L8pywtrq7SFEr/tOkmygmUYorOaXN/JPB6xCTdCwrWVhzt/JOimTd64K?=
 =?us-ascii?Q?qyIkkh7S9pyI/ffzsuVUrt4GspMhd48HvVvOoqu5LB7D1gpB+n3gMpJb6JHM?=
 =?us-ascii?Q?ui3cpqJnTijNIlmcSHXWptSN2hAi2xxFXxiz4hwH1q0PfwPmr9Sh+70PzFjI?=
 =?us-ascii?Q?axZ+7JniY6rTGK96BZRzdQJXja/oXdbajW4ZGBHnC/QPB1MUjjfcnepLjmld?=
 =?us-ascii?Q?LsHTtd7ZhhdBe/WxTZUjDUNV4ewLKEjLuukfV8SJftSmJmxUOD7T+LM5EwXG?=
 =?us-ascii?Q?NidXG3861g/qDd/2n9l/7CEq/rJWMzQkMzFZvaOeDSdvG1pyBuyMjSmgggVX?=
 =?us-ascii?Q?Qq5NMQx1GxD2RpPwLKN+xiQ7CHuLpKMm73lPJv34ALNZV2WGwFKj16AogScC?=
 =?us-ascii?Q?n/FIyPZLs2REiBMhTU5dU7UB7zPHmO7Cyrm0lvW/wqchQu8uIueZ7O2cT8/A?=
 =?us-ascii?Q?q23H10+KGQQlKVr+oC5Id0IDGXbalVJn4tQ29msw1Oy2xDPC8b4zqbpfQDdY?=
 =?us-ascii?Q?XACIlufs4LoKWFjJuHHc2dk513ul82klvXaEO81Z1p5msq8hvvOtYZtyHmQ/?=
 =?us-ascii?Q?8U0Re4KwRGJEV1Kd1Ycwg1AS1p21XL+JjcItTeo/bkpo9EjZDOj11B7x5A/9?=
 =?us-ascii?Q?VaTJq2QNaT8oKTLreWWhgad/Qdo4AcmhDIrw+c5YprSX0V3N/naZFFIJjSkW?=
 =?us-ascii?Q?O0Svk1y7rTJxd9ApdYU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90da238d-54bf-409e-484b-08db40daf303
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 13:35:32.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9UGNO5KfdmFuRGjdXyMRX794r2+zXmYl4zDVM4EyRmHtYku50mVDpQo9YA/IDV0DdtaGncjSCnqr+TmQ/YWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
Subject: [virtio-dev] RE: [PATCH] device-types/multiple: replace queues with enqueues


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, April 19, 2023 9:33 AM
>=20
> On Tue, Apr 11 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Queue is a verb and noun both. Replacing it with enqueue avoids
> > ambiguity around plural queues noun vs verb; similar to virtio fs
> > device description.
>=20
> Personally, I don't think this patch adds much, but I don't really mind i=
t, either.
>=20
> >
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  device-types/blk/description.tex   | 2 +-
> >  device-types/gpio/description.tex  | 4 ++--
> >  device-types/i2c/description.tex   | 2 +-
> >  device-types/scsi/description.tex  | 2 +-
> > device-types/vsock/description.tex | 2 +-
> >  5 files changed, 6 insertions(+), 6 deletions(-)
> >
>=20
> (...)
>=20
> > diff --git a/device-types/vsock/description.tex
> > b/device-types/vsock/description.tex
> > index 105bb30..07909d6 100644
> > --- a/device-types/vsock/description.tex
> > +++ b/device-types/vsock/description.tex
> > @@ -218,7 +218,7 @@ \subsubsection{Buffer Space
> > Management}\label{sec:Device Types / Socket Device /  \field{buf_alloc}=
 and
> \field{fwd_cnt} fields.
> >
> >  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket
> > Device / Device Operation / Receive and Transmit} -The driver queues
> > outgoing packets on the tx virtqueue and incoming packet
> > +The driver enqueues outgoing packets on the tx virtqueue and incoming
> > +packet
>=20
> "queues (...) on" reads natural to me, but I'd use "to" with "enqueues"..=
.=20
Yes, I agree.
The driver enqueues outgoing packets to the tx virtqueue reads better to me=
.

> can any
> native speakers comment?
>=20
> >  receive buffers on the rx virtqueue. Packets are of the following form=
:
> >
> >  \begin{lstlisting}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

