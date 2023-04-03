Return-Path: <virtio-dev-return-11886-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D02CC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:42:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 781C642572
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:42:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 665949863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:42:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A48A9863D6; Mon,  3 Apr 2023 14:42:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 443069863DD;
	Mon,  3 Apr 2023 14:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op8ulWEQ6pseRmIgkbjfcxqy9j1yaXln8TyqG12whVz0/PkYo+Ta+J0yulDrL1EuRpADzIA7oqonld36QS425lNja3NXVnwX/6iy8vW+xSyUd/haUt5A3i2iYLSLn2CJPxgLcnpFIYQCdQR3jnRtfSGwuar/6O29fpOyNDttQU90YZyZ/Mco3vW0+RWiPVCTshOcrThDTGwmhVE+984rfYo2PK2ch9jbgqZSqhXHXJ89j7D7GF9B25vT6UcHYA87hgX9kxhO5fjsMa+XvrWF1fW/li+nQVz3hBpjRS2FWyqLI4iBJTvx0dydFk+ufpWiypJHzhxqhqr5wzrk4HXYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwL6ChmT0xEyWqtw/swUuRBiyFa8UsSdVC0ElezNhCo=;
 b=VzjmbWXLDE43ZXUDy8Yt7BzI95AznPgrIdk9igm7wesWwNpG7bxnCkI0M0d/EugVQ7KcQYEtWdh3QY6NqogzexXOPc/Tqw+MrtHVyYdOqEuSJ9xPmNbs4BK1TZTPt2/ELJNhHZ61grVd3ntLYHcxbn88jUChEL/c818LTVaKo+gBCk71MnZkBPQ3PN2FXGcvmUH7Til5iqwUWcPmEYW9PjSdvauU9D9JPR+RFoB8n/DioWYd2VRj7Z8RuGfwFJ/iWTB0wdidGpgVUGuUnN3qQBLSLQjo6WxzAO3lXBj4ezNTkjV32Imd02GG3ExsTdgwLL4jP64H6MORcNzMoZcM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section
Thread-Index: AQHZY1tGdy5B+WGsTEetsq6ex3gwSa8UcZ4AgAD0knCAAkPqgIACA4iA
Date: Mon, 3 Apr 2023 14:42:15 +0000
Message-ID:
 <PH0PR12MB5481FEAA37D23191932F5C7FDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-3-parav@nvidia.com>
 <20230331024233-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481977FD9EF430B891A1F3FDC8F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230402035420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230402035420-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8936:EE_
x-ms-office365-filtering-correlation-id: d28acb66-283e-4ee5-7e9f-08db34519e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0fX4N2Tsl6qD/kxUlTVwmd5gpYNtfyeS5zJcgVOodm7jgmvAAVmHjd9ZTpALlY7Pg/jM/I78dBA8CmwgYGGjtoKoRMOcJv08azq5fti8iYC4RM5A55lnQoI586oNUalTewOwUWPqwIvFXYCRK8CDgp6ZWo2bN/3+oDgSZNSHNnHldgfMP/lJezIv0EPD3aVEoIlf8v71RK5GszSS5ceuX5d2w6fLeoKW1zCGXD5Wr8RHlkpB260mr3ZGP/9Npi1ksWBAY+JKbXuWkEIMKEOzZxPfpAW2BuHvREUe/yNke3P3vlF+XhdU30AhIYSZOI1WirwUdUavZttCqReU9YdsSIZ+Ur00OJBKfj+d2gP+wJVyvvkCB89BFOJTq7NYPDPAG/UuVzk2QE6vSTjqd/naHCxtguI7FjQoJuNHKqMVN4KG0wTdE6BnzmYIrL7IEzQJ7dymkz9zCP8FTQ3ci0xgIw6/g5J6xmruuUCENDJzgMQV7yHTz2CVsTALNQD31GQuHBUk6i6oIlgF4RRCJibqWnTGgbP1v+4WhEqfETvmlOsAZA0rhM1vxfjdxyuy//tbRA+6n1at+z9+Fr3jqCcXom/uI30qsJ0Sd/9GHg+dHbJShQZFAriy1gifGH2F4vD4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(7696005)(71200400001)(186003)(9686003)(6506007)(6916009)(8676002)(66946007)(66476007)(66446008)(76116006)(66556008)(64756008)(41300700001)(5660300002)(122000001)(38100700002)(54906003)(316002)(478600001)(8936002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JRsthS5t7IFJpDAm6nHh25XYarpXQXjc8dyyIZYqDWEML7QBLBLKMYEq5NIu?=
 =?us-ascii?Q?F2mDzuQlxpCaSrhASjpzzF2OmCiMw8Lu5l8dTbGmq1NrWDiv4RWTMZYGXK2C?=
 =?us-ascii?Q?t7bc7Kl/OqXOvSeOGsxTOcmmx6P2sh+Yycyf0DD96CduYPc3Lz2NKeu0XYyG?=
 =?us-ascii?Q?/RomkRwjtAJqcn6FZHJOkKBSJRAu+txNdmE97i/7TYs7QyCMjBitJiieO2k9?=
 =?us-ascii?Q?ef2Jnz6mkXJXVZPQdlGEZKDlcy7Z1qRYGUAKnCFGeCf/US2Yrph4iQ5tpGmg?=
 =?us-ascii?Q?1yearSZrF2Z4+l49gpuPeZCh9iSaNungqCof/20M49e4L4ssl0TgEXlaQ/W1?=
 =?us-ascii?Q?vgc1jun+Rq/s832AUjMtNeBopFr+bPfTHjPCTNfdSu2lRFLKc6IrXQz+umxJ?=
 =?us-ascii?Q?z5jcZycAwV9ilehlg3ATCa9kkHoA+Dk+S5jrpIBWPdOxCCXBimONHvBuHs+f?=
 =?us-ascii?Q?Uyc3QiLVDO7/RsD0VeB0dVLmfHyxlf8FHqWNPFdFe9rAfdgYjeKd54jAnEL8?=
 =?us-ascii?Q?pl9k7xw6kvqQMUwhZaTBSurDlkQcMrXpQFs9ycwHzjFl5zDyKee45pPZE6rc?=
 =?us-ascii?Q?mtzD8nFmBYAPlfAFl0qw7QIbPA97lzaUmph9hmi4aoRPLhaXJ5LJHJ3VLapu?=
 =?us-ascii?Q?znGErjIqhoL9/4Mm4n22IxkcBWPxzlMqIoksXuzgUO0c2lsQY5u1MCsYMHlO?=
 =?us-ascii?Q?u6BdMoWh1FJqpgl/ua01iYVYWhtoXk4TPNtzYe2zc8/wiBLGZS0JRGAzUL/A?=
 =?us-ascii?Q?0el9xXwhTwvynjTiVTodJkRMMJVIC3uggriEtj06H6JoLES7Udm7pby+1vo4?=
 =?us-ascii?Q?jbW1xXpp3kcOwlmdBiB8NLhJi85JFGH5S2SRdy5mnPVVwCCtmd09xjHfyZ1R?=
 =?us-ascii?Q?VrQp+z5x1BDb2AlKJYINX5m01S7+yciKl5iXP4OyEBG6Azi65tKqy8URpeKm?=
 =?us-ascii?Q?Ypng8nnryY+GetMcfCCavfXiMtpIVlJXT/XMzx4ASDELh4fu2NerFIBEnwtp?=
 =?us-ascii?Q?q4ipy7rqTZ2tTFSopZoiINw5nrISpv0VU924KxbYTKb7NI8Y92cwc/GVl6zn?=
 =?us-ascii?Q?G5J8aZQDriuDqGbOd6R1NtWtbLKdehWAeq+ggbij/x0LqApRM5AE8n/nXYr8?=
 =?us-ascii?Q?b5KE+v8WtyfprenOoAyUo9aQuXS+jeyyW48jWPZy463CwdHizXAu597B8w6c?=
 =?us-ascii?Q?ZEa06WP63e/s5xT04QNK9VWQaoKI3wxjk+Yg/WkVKmdS3GLItsb0g4oGvx8V?=
 =?us-ascii?Q?ouaqv4Xk7I2KPysuKFcCoMh34CpYnhjPrHPbJ4+lhuJi9RHtOxAuRfFQ5IlA?=
 =?us-ascii?Q?iZkqqPnC/vJq9ZtYu0i/wpFHsp3OKaOvrZIs+5Xv4UhzLEjEZNDDpPjWL0Pb?=
 =?us-ascii?Q?pl7jzPsQ0WD76q9fpI07Zek7BheD1++S6ENZZ0hm4s2769HZUkNObOdgqMl7?=
 =?us-ascii?Q?whmJyr+HT/s/vRiqEzUYVlzho2iyPEM6Z6IQ+XVOZOwEEfjEKYI69tOBfaL5?=
 =?us-ascii?Q?g6ieJlSFhSB5EiLsDpf5HqH667w/1YRRq4/XcdM+W6paOtscFdRfBpqNg3UC?=
 =?us-ascii?Q?fM9uT78ZocNEfAcd3ngEF/qRXea9dIReNvT1cYZZe54cy28xHLYT/sg0LeA/?=
 =?us-ascii?Q?kCrNFxafv7n/6XyK8YO/FCc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28acb66-283e-4ee5-7e9f-08db34519e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 14:42:15.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrWMCfoXTDjJ8ACGvTsrB3MlA7QSYwg9I0xG3WviugyYJ/T36Lvuysg65hB0SgEnniPUqql7xr6+8EjgdOALpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936
Subject: [virtio-dev] RE: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, April 2, 2023 3:55 AM
>=20
> On Fri, Mar 31, 2023 at 09:24:21PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Friday, March 31, 2023 2:44 AM
> > >
> > > On Fri, Mar 31, 2023 at 01:58:25AM +0300, Parav Pandit wrote:
> > > > Currently PCI device discovery details for the transitional device
> > > > are documented in two different sections.
> > > >
> > > > For example, PCI device and vendor ID registers are documented in
> > > > 'Device Requirements: PCI Device Discovery' section, while PCI
> > > > revision id is documented in 'Legacy Interfaces: A Note on PCI
> > > > Device Discovery' section.
> > > >
> > > > Transitional devices requirements should be documented in "legacy
> > > > interfaces" section as clearly mentioned in 'Legacy Interface: A
> > > > Note on Feature Bits'.
> > >
> > > I already commented on this, I disagree.
> > > Modern drivers must be able
> > > to completely ignore legacy interface sections, but they do bind to
> > > transitional device IDs.
> > > This change breaks this assumption.
> > >
> > Legacy interface section holds the detail about transitional devices.
> > We do not have,
> > "Legacy only" section.
> >
> > It doesn't make sense to partial information in legacy and partial in o=
ther
> place.
> > Modern drivers are not mentioned in the spec terminology section.
> >
> > Can you please explain, how can modern driver ignore the text " Transit=
ional
> devices MUST have a PCI Revision ID of 0." written in legacy interface se=
ction?
>=20
> Modern drivers ignore revision ID. It is 0 to accommodate legacy drivers.
For transitional device the revision ID must be zero and "a driver" miust c=
heck it be zero.
The section refers to Legacy interface covering transitional devices (not j=
ust legacy device).
So it cannot be written in spec from undefined modern driver POV in the spe=
c.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

