Return-Path: <virtio-dev-return-13155-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985A3C0015E
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 17:41:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D187242A65
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 17:41:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C940898670C
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 17:41:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE9EA9865D5; Thu, 29 Jun 2023 17:41:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A96989865D8;
	Thu, 29 Jun 2023 17:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUtNGdx5c1mqQT6RYSfImjuRSW+2eFlYisnqv7OJhCHWO654tL31WnT3SK4XyvSqgsnePq7Ydh3BTa2xVUrHPKd5X3xyT6e89frk9jOSX7FSWCzu6AGSlLNYh1SFaxNWNF05s08iT6UT2KGpyKCiFvmVnycMjh4R47uXmJ8spR6QSdDO4DvK7VUhVKa+0/fQ7atzEvWYumS5VSpWR9DhBvScclxS99l6zrOnWh4MEO+71urzCeaf5DcAxMDLlDEOAL6VsCPYT7bci300Tv72u3MPRWGZtlRR+UJS9f47GvY8Y6/jBOh7XPRUv0w/FbJPQeH6nlhk2Kge3fwv+kjPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBH183qjLFcaDRpQA1Ssx08PWn6rHO/v0qv5JNzUNDg=;
 b=FqmLsnWZ8adGgv5ffjT4pIsXe3o0dBrygifNhYYy/kamHMGhFF+E6kcHaeNyAd9mkOtipB01DXMlr7Gek4qhvIGjD7VbAZ/NvlN0aLvlpqEPi03R1bfYU4ebWvTvb/FAoQnFXeCG/4BjATUc5inE1Elz/mtXq7NJJfU+TawW0Q62Kf1Y/Ucc74lrYp56ZW2tqFtkN2CCpSvTWH+Kr79r9w/umNncPpOEKn9S5hH2QZqtWXk4WpkRDMBphI3ROuhaTNIKj0gNxHq7w4L1dYEk+nNRr869qQA2dUMmDghXK/ixzSi1dsNZ/QacZDIo4GCDIDqFUbfy687k7ky6ByP77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [RFC] virtio 1.3 schedule
Thread-Index: AQHZbVowHQ//dzYagEuvvD+Wg8MTsa+ig3og
Date: Thu, 29 Jun 2023 17:41:34 +0000
Message-ID:
 <PH0PR12MB54819136AEC54AA081DD395ADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <87edoyqvnu.fsf@redhat.com>
 <20230407071926-mutt-send-email-mst@kernel.org> <87r0spjct2.fsf@redhat.com>
In-Reply-To: <87r0spjct2.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5868:EE_
x-ms-office365-filtering-correlation-id: 7d0f3aa2-0271-4d8b-df37-08db78c81554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1MCn4K6HPM9gW2nP2U6JsGwrlYYCEA6KJdRNaxCh2tTDea+e9ZeTnVIhXGwNIy0YtdZyGEBsCHfiaMU2DeGvOniZqQXyc4cwpXQXlChvKIKkovlVXSGnPFsNTkFbGF2XAykpH93gmCutzN+uE+87aib7PKTjlZIf0x1D6CwxAzTLPa0Px3HREPqDKgUmLfkUNiCWsejMbcTLh8+L/dl7WVeTZjZ2fyMoJ5wsW8eXOaQAr/2ruNSKnLD4Mq46BqHRwxu/62S/hw8VGC5g1bqI9jH03gU8NrsQEx0tNct2bm1P4XQjRPnW4ESBG6gEhh5WJE5T8dCnq6MecX2cpaTU+RNNtcnkzWq8dYeCVyeN5qnXfFtzyXuQfEPsFWJvg9OsDNqrEi2nEf8svxnzn+l//OUIdpicuhQYsRF28ZaN8weI6B5gIJY57xX9SH2JTeCJ0nRBLzPrjEAmIGohRhsF6m47/3SbAxpD5UKJwYcYurtvPjvj4zdosoUDcosmoWDM/cYin6QLwR7oCkdfQsU7fKz0UKsfNsI6KgOaGI6AwoqXGzV7EOOnaOdYEp3ZBAnvd2PHdbRi/CSJSBLZ/dQ7v3ZWjQAgVkjBZXIYKUxZFG3gwbQpud9bqA/udBDBJ7caz7foPPcBEqfbwmZtBqPb4/BhIvnYz5FkD8UPCIRFx0tKtodP8aRf4VZ+5I1H2wr6kxYIwn4mYPcwMOXp3vlLxQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(6506007)(54906003)(2906002)(122000001)(83380400001)(38100700002)(71200400001)(9686003)(26005)(186003)(7696005)(55016003)(966005)(41300700001)(110136005)(86362001)(52536014)(478600001)(316002)(66476007)(76116006)(66946007)(66446008)(66556008)(8936002)(4326008)(64756008)(5660300002)(8676002)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MzQAtPh7iMpD2KgJ80MLei2BGmxhmfIcqb4Uv7FI5wZVbwAj0DHTYY3c5Cbz?=
 =?us-ascii?Q?TUIT21aaNS4abbGxf2cusVLmBdgz+9T7oHwe8vP4basT4D3T0OJdypgndzkA?=
 =?us-ascii?Q?kMurfpK/r/C8fwZXJuS8qiijMR118AHbIISwHrtzWI1pEzWQxX40zUcyEF/h?=
 =?us-ascii?Q?zz3a4CwDXyBbKoXc9zijwvyp0ZI58dz/7xti1vbKM9KQSoVcyyXoKbgkuIXK?=
 =?us-ascii?Q?3ugV6iJP1JdXaSVlVMnKdlGGbqB3nCMAcdJwOymNd06AikVzISYReKqtLA8l?=
 =?us-ascii?Q?XX6wE9VwmxhoyTDS77xJ9ysTDS92ihUFZX37GVAB1GRsQR6hR4LbOWS8J1w9?=
 =?us-ascii?Q?9cItU0jTgomeTW2iSBfJzikrqPvJE8nHFg/xRw22/rTEZEYXR4tp+YnnYzcK?=
 =?us-ascii?Q?kX0QPjncWsZKDBXrttRub49K6fgLrPiIjZWPV9e0Gu5ZhYuaPEySw7QcUFaL?=
 =?us-ascii?Q?cxhxkyFbshzqVHjFbkB8pPoa7Pzc+f2UiZYSbeheGY1L8J3HCZIAPvNn3Kqe?=
 =?us-ascii?Q?XZKTlrgRlr0PSdXZusg8xgvnS5ekTYB8FypwFXTuw2igZXAYlw4gLu2brmyl?=
 =?us-ascii?Q?Ih0Sa9LSA8JOkHyQ5vM3j8hrKZBl0NlwnJIbMsMguJFzBFY6tX3wuehhypO3?=
 =?us-ascii?Q?0BNeGbmyJ3TtLnzsw4ha7zIGXH/OzAkxjzwh1lxx84e7UPhgiMxFFQ2MQ/v0?=
 =?us-ascii?Q?gl3a4dClGKYAF90RbzB2So80UoBlJxTj38tuEKHiQwsGBA2eBFPac0RFXmrw?=
 =?us-ascii?Q?dO4uQxqFq09giArxNT/2R8TbW96vD/kCXmGZofRrG0EvQ+jtHQQq4DQbXYf2?=
 =?us-ascii?Q?NgrfTiKOtKuJQ0lnJ0ZI3KVZFwXnlDNLLQTsdOmoFWU6nTq+OX5MWK9R8Qo2?=
 =?us-ascii?Q?OAwbpu495WMt9ZyY33/qaiYdFyE7Cv/oNMlxrvWg+fpQRYASo55e/phULoIj?=
 =?us-ascii?Q?H99BR+wgz3C1WnwSJlI4L01PAdDBMOTKwrJCyVnZ9bSWxHChQ88vVKjMhlES?=
 =?us-ascii?Q?JI8hFItaY9PpCgen3m3aSLExat3YJAaLcJw0cgZvVZ3vPcVtDSMXUU70C3Xa?=
 =?us-ascii?Q?9xx2ZIFIt9bzfSkHxQjfd9xx70Vv3SrAxS9+U8iYSX0AoPtHWrLmtaU4EHRB?=
 =?us-ascii?Q?MF/HZ0pncTdCcCjr17Kc0g9+Rz859vRSlEXd5gLeHVPwBZXdtrmmwH6f2Hne?=
 =?us-ascii?Q?8i/DQl8+vQRk6vsGzup4xe5V//ImGCEM7AKS9nvfKZ+QjMUUC//CpL6jpHwD?=
 =?us-ascii?Q?3x/SmIp5b+u/HYRb/P6UaQeeIjohgdUTTyTedI75jgrw/QgrFsOADZEVjA4r?=
 =?us-ascii?Q?67CAyp0J9WXk9W2zQXdUf9hY31AF60y+RcOT/MGtMuqdc2wq/2xYL3hLKBY0?=
 =?us-ascii?Q?KwGLrcMxiUZF6zuSgeIaa8GJGt5FPOSBe6SqAXgYhczLSHQQ6YA/9WPe/ZV9?=
 =?us-ascii?Q?WmzENjuP5QaHGMqTsUup8YIqaKdbKx8DBN+00Ne65ZmtT5zguL4g/bEKpzv+?=
 =?us-ascii?Q?GcAD7bItT4sE/jo2oldly8d4Eas6TwhSnHETyucY4ActRCuQ/X858tyy7R9x?=
 =?us-ascii?Q?Pw63IUgCENB0kFM4usw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0f3aa2-0271-4d8b-df37-08db78c81554
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 17:41:34.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6g3pyKAtIK7hptfpSbekosl4QsKpr0dfbyVhBadoOnLs1tIdU46ts1Px5OtyUb8NFbl0sSfU/vK2YkGypC5vlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
Subject: [virtio-dev] RE: [virtio-comment] [RFC] virtio 1.3 schedule

Hi Cornelia, Michael,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Cornelia Huck
> Sent: Wednesday, April 12, 2023 12:17 PM

> >> - July 1st 2023: enter feature freeze; all proposed changes must at
> >>   least have an open github issue that refers to a proposal on-list
> >> - August 1st 2023: enter change freeze; everything needs to have been
> >>   voted upon (i.e. we can start with preparations for a release like
> >>   compiling the change log)
> >> - at the same time, fork virtio-next, which can be used for developmen=
t
> >>   while we're working on the release
> >> - August/September 2023: prepare draft, initiate initial voting etc.
> >
> > Hmm looks like you forgot a 30 day the public review period (or is
> > that included in the "etc"? ).  During this period we will likely
> > receive review comments which we have to address. Should the changes
> > turn out to be material, another public review period will be required.
> > Let's spell it out please.
>=20
> Yeah, that's what I meant with "etc"... let's make this:
>=20
> - August 2023: prepare draft, aim to have it ready and voted upon by
>   August 31 the latest (preferrably earlier)
> - September 2023: public review period (30 days)
> - October 2023: another public review period, if needed; otherwise, get
>   comittee specification ready and voted upon
> - October (maybe November, if we're running late) 2023: virtio 1.3
>   released
>=20
> The most important dates are feature freeze on Jul 1 and change freeze on=
 Aug
> 1, I guess; for the rest, we depend on whether people are out on PTO, whi=
ch
> kind of feedback we get, etc. -- but as long as we release
> 1.3 in 2023, I'll be happy enough.

We have two extension features that has gone through several reviews and ar=
e in advance stage (and also late) for 1.3. :)

1. inner hash v19, rolling to v20 anytime this week. 1 Patch.
[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00490.ht=
ml

2. first user of aq for legacy access at v7.
2 patches. First 2 are Fixes.
[2] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00491.ht=
ml

Both need few more days of review and vote.
Shall we please have few days in July for them so that it can be part of 1.=
3?=20
or whole July is needed to prepare the draft spec?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

