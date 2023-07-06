Return-Path: <virtio-dev-return-13259-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9A8EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:16:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E139118C9CE
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:16:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2A3A98681D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:16:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C481A986728; Thu,  6 Jul 2023 16:16:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE425986729;
	Thu,  6 Jul 2023 16:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luHtQwlOXAKS2dtNBqHjCt8exTIQbB7BsfsPAaFm2cNFhJ/mHJwGpyOjg2ykLx5J9x7q5uyaQH9rtQuDsZG5lJa439EMxpNRwQvYZIBDvhy6fwkZ9SS2EmILA6HXYbsreGI6EDvov/HQfYUByVzsvR7xZW4f7hllMM4BoKu13cFW9GEy7w7EhQH42XoWae215TuKhvwSKdhvJqj8mwnURF0pYrYDIaJ+6DY4rCnPt7tW97zE0KQzc2M1Hd3blqtLW0bvHUReIRV3XzKNKtMHsyjuEwu3tGRxWNqIl26cL5jglTukmGnH/mxR0QKpY9PwMD7ZmNarWj6te2AT/INCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ho6KNQdb6EfRb4v+4zA1m58I9lC8ULJq3CjyyDAU+g=;
 b=HiUg9HQVQP4/PO9J/2PhnZAaRe8qMjbXMjQJdDOEnpim2f9Z8D3x7NUl6c7qWNU2hyRlcXaWasGD327/TIdo2Lg6YSGQkKVr/aSi/tbezg2BfHcsFCPOW6UN/v8AmcZdukUqWMun29M+V25fMuJkF17F5N1//TxRF+LEL9RcUE0PU7spNJE6PePO2gCt9GrTukDkUk982pABcHSSI3Dr9dS5fuo1hgT5en3O5PhTfjrFq0H22Yuc/yMGL+oYTENQ4lQTpL+3HkpKFHAWvu/E/AH8jkCTU0wNSCm7UVdugHFFRQlbRuW0TY5F2mcnqFmh5LGMmpIEjP4WZtTbyqBPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v10 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZr8EBJMgClpRUj0GLXcbax4fBXa+s6a4AgAABBzA=
Date: Thu, 6 Jul 2023 16:16:15 +0000
Message-ID:
 <PH0PR12MB5481C70AF6299C0D53DEAA23DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-4-parav@nvidia.com> <87ttuhuii7.fsf@redhat.com>
In-Reply-To: <87ttuhuii7.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6458:EE_
x-ms-office365-filtering-correlation-id: 7547aa91-5e19-4a22-5b46-08db7e3c52f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oHGzNT493lSrOilbBpW5RxR6kmgOWCc6iDBYyf6KHWrCzK4Sliedk8mqLdzcOD8hS3DxWTsnfPyxDB6ro8pkACHQ38QB+nn7ZXbzDfBjk0CwUzVBx6oGRp87sTcm/pzaZ2DcdNsHumOuTKZ7VqRpmrYSj41Zji5lldA1fqcIzeG3sWwGWYB4cLXWkM1vgOhJyTffgY3cof1zgMjGW/VQyv7McIFlcoUZz7zT/qw2ZT4HWcs8oCVWYyaafbbD+eL+acEw9+WT5EMAN3YC0SQngnCUaW998coknvW9ILTouMB2qjfeCVhC8f0TgnB8PL+szQVuUS1xAhVqkf5G+CUWLSQD/qNwZRmuF+8/TdYWV5zFtvF+xriFHWUvPVgXROp01Dcn3wn3zqGZ0C9VQ3uscCWPF05wgGM1nfs8X+EPHvjpHvIXVGdEpWoIn50YJzSczQnEPYr7MaTiFD4PXxXy9oYc+y2yJ+JaObgSXZgEeFQIofnFcA8e12eCHtn5kn7f2FpRdq16+wzhhuPxKeO7nt5Ux3nHoAn5RYLNmAllbTNpo0Y8HD2qkpf40FO7sjNMQmK7WJcfZUMmnhiBF4ants16L9Ni0GadehmcohRx+ZLrzc9TkI94uGoIbP2hXl+f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(52536014)(5660300002)(66556008)(64756008)(4326008)(2906002)(76116006)(66476007)(66446008)(66946007)(316002)(110136005)(54906003)(41300700001)(4744005)(186003)(7696005)(71200400001)(478600001)(8676002)(8936002)(107886003)(6506007)(38100700002)(122000001)(33656002)(9686003)(86362001)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cbkoIZlIijsKp2HfZSoszfxNYr+BUYUxoJavUQOxAixh45dlfSuVXtMX6nqW?=
 =?us-ascii?Q?dNgFTI3gyOszz2TOJova+ii40cFHRc44DHgfqtEHo4btVKXjv0hOOSOuSDWw?=
 =?us-ascii?Q?YiMvmC9RzFb/9DNcjzpVjex9jY867Z5JL/FebXiuLCRZ2LfDHtW+23iotMGZ?=
 =?us-ascii?Q?SJ5BEK54nANEMA8H0muzQLyk5YQrQRHRqC1q4Y638Htt9IrjGpHwoLUSeUvJ?=
 =?us-ascii?Q?TPCqPDboDOw3rTtf7JorDz9VYSzSd59JgwuPoLptcXleQKpsWXK06gdK4+MR?=
 =?us-ascii?Q?WSy2RPafjXOJhPfh+C75qXBjNqhCv9fZ4sskHqMu2Nqy/xOByryOYJPQUZ01?=
 =?us-ascii?Q?puN0/WYCVqVipKovBBq33MNgTfmgr6c0ulOnGB/oq3u0JceWO60gukyOaT1P?=
 =?us-ascii?Q?/9WpEd0AtMn5LGh9pMstjOufQ+54BiOBRLU8xE8bGunAd463TSTX9KSNLUhR?=
 =?us-ascii?Q?sO6gQdVeRfbT/he2oShfyGJvOLK3g2OEjlWyIMRtYTHBnEIXZykAXXYFVFZ7?=
 =?us-ascii?Q?7Gk/GvzrmDafkliUKKU45IDz5N9+g6Y7cMEXeGpH4ciNLKofWXmcL7E4sNgr?=
 =?us-ascii?Q?gBdEQCo2jlFgWnyEhhYIme1NQfOK3VrwT5LgkN7OcLZTX/mrWgcIakcRB9ET?=
 =?us-ascii?Q?ve6qpy+/FMHeG+/Laa0XXRZ4yhnuKLqdvAs1fhWjKOxhW0QchAxPKpf7CET9?=
 =?us-ascii?Q?sAKfPieg9HfhjBvet61XAcHYmmR6P9+BI59HpGjpu5pQDjVDaXgXeQWjByJW?=
 =?us-ascii?Q?gG9faZTa3NKss3c7P0zODTTYiq43K0A2Gfxz+M99Jsj95vmnMt4wgkELSKhp?=
 =?us-ascii?Q?JIgTZJZVmpvLF2nQQzqoqqcdrtuN0av7Swvyn6JgijHePUnhtY+3UfWDvt6q?=
 =?us-ascii?Q?RjscSAD3+rYgGYRCVjb6AL0nY9wmi7iiQrxU/2vVOFrUrbD4KxY7I7cR4ivB?=
 =?us-ascii?Q?4hs3eIq8YFSx6R5runXuePu5Nvdk84OydJG5p0clv7Y0L002iRm1OjJ+lwdE?=
 =?us-ascii?Q?UyHlW0htKohe7BPVZH/w46p9/shbxzqSFmNDcYK//0cRb+oZZxeuwNTQVMu6?=
 =?us-ascii?Q?u7UhJjr+EztyiayqVuiF4NM2fhxe9dE9dioS7fV6aNDVNPlfhtDr8/suSmC0?=
 =?us-ascii?Q?XvPqbZ3Iwe9pvk7wUQlvaOjjAzmB8Zx4M9wQXvpBlyp9b6GwKLZ3+ygBRdsc?=
 =?us-ascii?Q?WBsCqdFkSuQNlp01YihocCHYV1UCQSo47m8M8TNyby6KyRNZo1iVdc1iw1tf?=
 =?us-ascii?Q?YvwZr2z3VtiZf/zON8tMvucezR3h2fiBWLVMYU66GwtldYqoPQpSO/+mzH6r?=
 =?us-ascii?Q?HkYCY6OE3YQpEZ4J2LzAS2yqBGb+7AwP3qE79LmhlXQOOZu0V0xIUk/SoJ58?=
 =?us-ascii?Q?wOu0DOFqjhEqsUwpIf+aIYoCdsLJLydcRCbv7D5iRERqnfV1xiHgKGI/1gc3?=
 =?us-ascii?Q?UIdacffm2i5LMQWxvZWRKo7A9tiM9I5urX9Le8Bd3/FpYZjEL1XLYu64Tzv1?=
 =?us-ascii?Q?cepYycJxzMj5pzjUVUTrCT5wUGadaL1emHVX+GFH0DevAOJxEOC7OcO46eKQ?=
 =?us-ascii?Q?tUILii0st5w4R1rRPpzg87yk5yFveD7iWrUyAJvX9apPfdVVPGT1MFOOKPJq?=
 =?us-ascii?Q?GcEEF8QsqCHvR8stEbWWRX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7547aa91-5e19-4a22-5b46-08db7e3c52f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:16:15.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2huRL0/GcB4+EuC5n+jVfAlfqn8miMNvvsqIz2t1o/ePBs4EULQ8KP9iQZQlwynYRk0wLEV8cC9npQxLXgy5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
Subject: [virtio-dev] RE: [PATCH v10 3/4] admin: Add group member legacy register access
 commands


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, July 6, 2023 12:12 PM


> > +In some systems, there is a need to support utilizing the legacy
> > +driver with the device that do not directly support the legacy
> > +interface. In such scenarios,
>=20
> Please use either Michael's or my suggestion from v9 here, using definite
> articles here isn't a good idea.

Yes, working on it.
I am taking, below suggested version.

	In some systems, there is a need to support utilizing a legacy driver with
	a device that does not directly support the legacy interface.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

