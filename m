Return-Path: <virtio-dev-return-12021-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFE1C761A6
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:11:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85A9923D5E
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:11:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6987C9865B7
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:11:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5F24B9865A7; Wed,  5 Apr 2023 13:11:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DE229865A8;
	Wed,  5 Apr 2023 13:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiZ87L/s0lZJPNF5q1JH//1ke/7I7tGj+jBV5xZvUOITRR+YWE1spoxp+fLE/o9nxn/XYE56a6kq3VuZeIKKGFgyZYum09HaebAL9zHZvk51qrE+pfFJko8iUj2++1al+OtOTYZj5Pzjz7R9qQZnVZoY1bLUddATPQmeCE+5mhNEtHgOfiS2fRK7cQSAv5F8YCscwdBJ2N1BzogHDlMSDeJ3IAdy7FFBNTEs3zJPztA0igRxPSnNpWOh+COaH9goNC+JW1JY//HI8PNsc5R9/3x4PjGrGKKGpUCWhCL240gUeRXR/gE5TGCPrZo+CUDA9g3S/Gr+IJpBmg7adn0fjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7YoL3KyqVM0Li0NN9dBiduotT06e0Zdl2fLUWCYK2U=;
 b=Jy/MTWOdxlvqTkVks0c/tB0j1vB6UfPp5O+inVYDMkvrI95Nrp+29/qYwzNwaTV4lAD3SKU9Q2odfTEAZE3DEebcB7pxrp7ZCBY/xxTdaVXPGYPSDZBleLd3eM17kiABMOIy1C3VlYnc5ivjBTk+qBLNZ5ZCcvOl4Vrbt8gZdeZ3ql+76jzrmhlpOjGqKeG2G/mOr/dp4edWaLCavThdLc2vTVEczTQqdi7xkWdUOTu4MiboLooka+cJMgrXzAFV/jrkoFg8e4V0s0lUgH6poXg2ZkRuOaV3TrmdCi3hST+qM9HZ4tP6GO0p5LII0uDik9PD4/VoA0MuxxwqzlGtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 00/10] Rename queue number to queue index
Thread-Index: AQHZZ1r7qcAtV+zCXketiXJJvf9y0K8cMW+AgAB+93A=
Date: Wed, 5 Apr 2023 13:11:09 +0000
Message-ID:
 <PH0PR12MB5481C6B9DDC40D382B9197BCDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405013038-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405013038-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6529:EE_
x-ms-office365-filtering-correlation-id: 7a3b3160-713d-4860-5937-08db35d7392e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 em7Py0O0ytciykeImf3lShlO8jyYxFitWaeRDWxY2clE7+mswywomS/9jx+q5gSZsc2GmgymbTIVk4V6/uFuOobqhyH8gAKiG5XYXgin6+LizWj4xc7h7uiveTtT4MkTeJWAF5mTchUE7O5guNCNryey2IrRqHAgn0lh73qlBywa+VXS4OqJ6PqkbgvQTgUQALnP751Gk3tA7GrGR7OHR0tK2QQgoBPXIMh8rc+ixt275JPQx+1cOO9psjkWFp5vsgBC/zMYL/YagZ2mS2WSqg8gfjwHy6/+HHvq+HbEccwGvzcShX5TCSRoqw+B5EFZXp6QRJC1IU3xIbrrR3YNnowwXIrOKz95OsJi0RR3v3ZFtAZoyKh1Zd5YyQYp8j+zr8LpjfulrARDIJvT/kkmhuDo/BNdjvPcylViCjT4tDwAqBZN9YhorTXtYzeFBxFu2Cr9OnkGapGhTB/pzCYCOBdIeOnf+Ux+WvaW3jYCftilGQywlr4rZiqVK34GaqpeQ2BMbQ5qAWhNjHuXv+BzVcttAht2+e38vBo7Khbp2k19jWLz13ZGsez6sc/Jk75UYoCRLew87PLao+e3iQsU2/octUy0RwtmGySlvRDs9m4yXZR6ICj/wMU4Joy3Edh0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(55016003)(9686003)(107886003)(186003)(2906002)(54906003)(8936002)(86362001)(5660300002)(38070700005)(4744005)(6916009)(4326008)(316002)(52536014)(66556008)(83380400001)(41300700001)(8676002)(478600001)(6506007)(66476007)(66946007)(38100700002)(33656002)(122000001)(66446008)(71200400001)(7696005)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YpQgndvXYPB7akIrpI8gLtr1DcEX4f638EoPyz7MTy8bptMFBapXlBZtMhYW?=
 =?us-ascii?Q?uM9sVcStTjNHZFTZRKw6kYwJxBLX3TqJw5sSOPIl43YILbS2ddcQx5XkODNv?=
 =?us-ascii?Q?bsmQzmBEhhpNZIdckYJJVikeRGxZ6ipb+BjYoTclzSSdmCVZoOHr/XsjUCx2?=
 =?us-ascii?Q?nm6jiXWxNKLIJG041Ig1CRjT+HokpQk8zkr2j8dEeH7AOZxPVrBf5AoSRRUp?=
 =?us-ascii?Q?Y1JHYPI44KRslCPJFRl9EgSkHyURwnG2AB0VSeP6SlvzvU9+mYTkMHoL6Uge?=
 =?us-ascii?Q?zGYyJYdvL71EGO76GB7ByqYLTcylom7ILYoAU9wtnYD7ePsPzbv161raXtfd?=
 =?us-ascii?Q?W5FoLA+hYpXeF5P1voPiCz43SpoEftTrlF6ZygMOtPuR4ln/hIqL3rf0h//Y?=
 =?us-ascii?Q?CgZuxzlYhamI0VJLl3pRD1UL7nBTdpiBLFAqAXqehbHPvGYeyEkjzWxkIW5U?=
 =?us-ascii?Q?QeDU1LFSDNR8/12toRG0ioQjZ/UFjFj/eRpnQUfATSYGnBrERrnFGByw2z79?=
 =?us-ascii?Q?XQc5p47OAczXa5r4khtRaW40ZTqLDUySopMdgVOmhswr+XPzKZ38IibVegXr?=
 =?us-ascii?Q?2MoCDwMlnAREWbDJ4ajNmSuNSBoAAXbG9Tnmu9lXKCa9zwn2+1BpwnxmHEP/?=
 =?us-ascii?Q?OgMh3I4uuUucK1HQTZXrfWvYK2ToaPecrnqfaJNjpEfofokYW8Oj9qhaSO8P?=
 =?us-ascii?Q?/TK7N4KfapqTeRZKNVVpaJZUUPpEyc5xai4yleoPSjhQR0FoUyJLsGHrbGWK?=
 =?us-ascii?Q?JVqjy6locpXCo586Jg0O9SDsQm5i8I7F+U+ibdfqe0WMCEZMiG3wH5bsOXwA?=
 =?us-ascii?Q?Eaeig1uEOgxIObGAWlHmdEza0L1lydeUYoJhqSkqd9TZxpxAK8355n8Efi3t?=
 =?us-ascii?Q?eIjmW/2/cKq9VB7Q9rdSPnvegW3JzpEI0oulLXA09+TCb49e0l44f23p8jWA?=
 =?us-ascii?Q?+fRtyXdj9WRReRpInQMyslZwJQKhequx3HNfZ1Jz9/GsXBubWzYlexarWX6o?=
 =?us-ascii?Q?PeZ2BRQbYm46SWpBhJbqFeWvvRvm9a5r/mpCvDn4Oagyf8+pOGdzhZZ6UNHt?=
 =?us-ascii?Q?QZ+oSABokwvEa/ehlwFqenyktRR+IgTrZcFOAZBecusKIYZKoo5yb/8ALPgz?=
 =?us-ascii?Q?1RZkFkK4tRHHBd3zkq0FHRWRqNrhVUoO4GdkJCE7Sype23rghwnJNCsg9aXj?=
 =?us-ascii?Q?fBaQXHkBc+9Amgor8fUYXKFKadZx1vXCZw02KPrSabkQ4JAUKyrpQEmLoc6k?=
 =?us-ascii?Q?PY8ip/Oyu0I4E3QITez0KamwdIGLVAj09u4GWWvZ9f26AEEz7IoVOcV5MhtW?=
 =?us-ascii?Q?pCSwjjMsDnDHgP+2slkFdAL7MGust5ihjdi8czJj2YB9RrV/JqjCIvTvMY3g?=
 =?us-ascii?Q?fuHt1zWf/oXP9Q1Ru0/JZ/DEiQxuyoYXZuJWchlBb3a8FP8BNKoVxps/JoKO?=
 =?us-ascii?Q?yqRsAFjHhzQfD0Pf5K6Kkbm59hT4uDTAkX+5XpciVYhi6uex0PKAS6tn5qMa?=
 =?us-ascii?Q?CjtQiJdCLw1GmN/ZveWpWSF+frs4Ro71isf/0XCEpYg6PLozs8u3HH/yvk6g?=
 =?us-ascii?Q?+2JHmQB/Eq6m+Iq0x0GzOax2F7jlN4Te+3w0tKe559wxhj55ycCR4mEMWHCO?=
 =?us-ascii?Q?hJe2ssu7zH+Vs41DUd0hLwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3b3160-713d-4860-5937-08db35d7392e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:11:09.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuucZ/gc//REOEHjOu8EoSXX7tybPXlnXx1Vby8X/AWt/hUYz3wGnnf5Dcrq2srCbQTkkhpHCAGhpLyXX028cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
Subject: [virtio-dev] RE: [PATCH v12 00/10] Rename queue number to queue index


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 1:33 AM

>=20
> I like where this is going. I will change AQ patches to be like this, but=
 it's holidays
> here in israel so not reposting immediately, pls review assuming I will a=
ddress
> that change.
Yes, will review AQ shortly.

> For same reason pls don't expect quick review.

o.k. we need to wrap up AQ, transitional device soon to be part of 1.3 spec=
 as users needs to start using it soon.
So once holidays are over, lets close the open items for both of them.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

