Return-Path: <virtio-dev-return-13696-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3FFCA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:52:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 14A3C1318D3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:52:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0126C986633
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:52:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E7B91986490; Tue, 12 Sep 2023 06:52:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6A7A986485;
	Tue, 12 Sep 2023 06:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8eKyLXkJKQNcNzsBAEbvdzfFvTNOFp0XTL6CeKerqJKiGXH6VwAkHLqb+jU/sqRcyvvjIz2x+6ljFVyNMPTDj6RIbnBW9RaYe50xL/QEbgWuLMC4r7RRZymNQCVGI3Q0mCqdyR3FunPvQZOpOyWa4Fuxt7Jj83FdvMrWWFFWdCS12LBplspQ5MGLGS4akGrTbEvLwdeAGsQn8JXhSDJVWPLpORJManQ/ZAD5UrQ4LL+lXQPXGn8/jI7zLdZ3duFFZYX1SrMkRY3HaqQTaR6vj/cmEujLCxV51D8L4Mi95ZrPummwj5IKq5ny5XQpYZTcbrhV7ZKL31Awf+txbrRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEHuRP1oNos3GlVIVmTsBuO9Nru895/CGH9VKwh7RQU=;
 b=NmwgXvSC4BZHTpf/AjskYC8wsQOZ0FSiyfj9+OZVROf27V6QYuNCqlvWIzwDCdlHCzjp/6xgqtLG1AX+z4FLqdv16nCFNplSiI3EF1hTkh0kjJeIERHA7FdB05dwXRlZgNV2uNt+EddmogG4G2awI1NbPRXX1Tjfdv2dRL43q2HrcbCZXhBJplQ/cmgpswBIp6jIdgOuW5MfiCz4+4MBUDtaWEyroF2upI6/mO1WnEDMdan5H2wPsCHZqafCrOH8WVYsnvJ39LCV0wW/yiKYys4PH0AxZoq0ktfwTxu+Wh2soLvo5WlyLwLH0arcnJDbuiYzY525kjk4S2r4SYQGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TA=
Date: Tue, 12 Sep 2023 06:52:22 +0000
Message-ID:
 <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
In-Reply-To: <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4522:EE_
x-ms-office365-filtering-correlation-id: 4d617942-b98f-46d3-0ceb-08dbb35cd09d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HkKV94HX68/ewipYqvU0iHUCqQxXeEWVrd4qzAetbZgO3IA9bWqbOkYzdgpEW9YoEV6Cr5/j9J64vCwR+h+xULmdYMiigDFhTl0MV73C5DUBf+0elHfPi0Kxy/YLWAPdo4n+oWHlGFcy0QEffZ5teY1NjIFVdayAVZuecLlCmb0Xl5XPE+spzOnoNwMIqWdyIDKpwulTsRie/2qphCnVKhvsMg056S1NybWw/W1MxrSfJsxhlcDn33aUdazSePqqkj0uTodF6GtEIhW/mL9osmWOYu50gEE4PC0lcygoo0oqN3GQBdZhoYtrtShWl3W7M+0vaSx6Z122MpxBKN4MPvHv2ZDRCNO/KuqzKaUcdpCiTbKzXNp5AZ9XCacawqH2CxIuK7dZd1WOqu91ln5dcE5DUZOzUwkFZoEWIOEKmxIpNd9vq1xOyrgEG9GFBLkG8zphCcma9wupm7PC8FshNYPgDCMHvw2liwxfPRfaE2OADzpoKuh6iQL2NmBZ5+U8YPUXQbIKOBfCGAUNlXl4P5jUuQIARLXYjIn9vM8aU9ikciB3Yn4evSOKl91eUradt2rxoipg0oakp6Qy3wvVxuRKj6qgnsH2I26vaMJ8zN+/jeodamvIjWQF2UG5S5W4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199024)(186009)(1800799009)(52536014)(8936002)(4326008)(8676002)(55016003)(110136005)(26005)(316002)(54906003)(66476007)(66446008)(66556008)(64756008)(66946007)(76116006)(4744005)(2906002)(478600001)(5660300002)(41300700001)(71200400001)(6506007)(7696005)(9686003)(83380400001)(122000001)(86362001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2U5b3RsbU5wTUJMdHJuWDdPRE1iMmhSalVQZ2xSNndPSFFGYWRGWWFHY1gw?=
 =?utf-8?B?N2RFTmFUNG1kY0lxUmVvSVk4dFMwOTlmdjAxeHhreWZEc0F4WHZIWDlUeUVn?=
 =?utf-8?B?Nm9wNTBBc2lvRDI1NjBUNWxMWWN2VVMxbXhTT1ZXaVlwbmZLb2J3OWcvek1y?=
 =?utf-8?B?QlBSSjA1MkcxNG1MazRKNFlkSmQ3UlU1QWF6REFxV3dmcFNES3N2TE5pamxJ?=
 =?utf-8?B?OVhLK1cyWXBXeGhRWklSNC9UY1AzOHd5RVRBc3Z0ejJDQnBTa0pyeHdBOSsv?=
 =?utf-8?B?S2FGcWU5WnJ1MklNSzg4REY3NythdzBzc2QzTW56QTlNZ1hSam4zZUJkUkhR?=
 =?utf-8?B?V2xUM1hHM01ZUC9VZy9WSnA0aWdWMUQyTXRUbjBwRVRNNE8rSGNCM2NNVnhw?=
 =?utf-8?B?ZEJPWkhrb3A5VkhYcC95Q0ZZUTBNS0p1cG03QkluanN5enBqQmFPU1hYZ0hE?=
 =?utf-8?B?NUQ0cTNvNVAzT1lJYkFMZUFiUFR0S1hRaHU0R0VDNVI0RW1YbEh6ZmhRbHc3?=
 =?utf-8?B?YmdqWVNkQ0dGOERobFlGMUF0UlZjSFJpOGRTUjhENkltcEdHUmMxcGZpaEYr?=
 =?utf-8?B?dDZ2OVRTeG1Qa25LVU0xNWdlZ3dSUEtIczFRR0t6b0Jydnd0NnA1OWlUeEtX?=
 =?utf-8?B?eVMvdFdlY2kvQTNFd3hqUmlrNlkzbDE2QjhKcm1VY3dvVGxEUkpZOTRzZGI5?=
 =?utf-8?B?WmhuU0U1QlVmWGlTaW5ralBSaUt4TnJsS0RjSlpsak5NOEw4bXhjU1lwck9z?=
 =?utf-8?B?Ujd5c1gzMytZOUVNcHcxUDVzL2tXWllSR0VOcC9oMTJOMFNhSDNqS0E2VTRX?=
 =?utf-8?B?eUtsV1Nla2FWbzVVQ2VQZUJFUExYZG92cE41SCtuV1Q0dmYyVHo0ZEM3RTEv?=
 =?utf-8?B?ZXFuVk5pdVFqVm9wZnFRM0ZKcHlXaDU5SVVTbWk3NXJrWnpnckJsVDlmQ01T?=
 =?utf-8?B?bGl5L1hMdEdaWFRnei9jbG9CZ2dzNkVHdnYyNDFkZndKRktXZjhTblFXSVZi?=
 =?utf-8?B?Q2VrS3RSNi92TlZsSTRtaEZRSWs1eXd6aTVnWWJabnVsdWpMNENxQmhyRTRT?=
 =?utf-8?B?d1QzMTVBNlUzVUU3RWMrUzYweG1HRXl0UUlkRUxrRnNRMWVTOVZGTVg2djMz?=
 =?utf-8?B?N2lMRHBjelVHLzZqaGVSNDNvSnZ6NXE4Um5ZdW5Kd2tLdE01bnNnSnI4Qmh5?=
 =?utf-8?B?c2NwRWxQWGhvWk50ZW5hc0xFa1ZveWFObS9YSFB1QVlCbFhlVnJvSUlmQWEy?=
 =?utf-8?B?bjBtYUhPM2NzMG12cDlnNnBQakUweGNrSHVpVjRkTDdZc3NpUmt6QVlpYTAw?=
 =?utf-8?B?SUhwbGxWZDYwZWFyUENERjZQaFpBVW5jVmdHbGJiSVVZWm5aRzdyUmxwclFq?=
 =?utf-8?B?VFNuNGJhTjBsNWdFeGJzMXNCK1BsYXkzNHZrK015OTlIYjk3Z3dRU3Q4QTdU?=
 =?utf-8?B?cUFjS0tRdDI2b0Q4Z0dYSUJrdW90bEhPdzQ3YkdBamxEckFHaW1raTRUOGcz?=
 =?utf-8?B?SjUzeVhvZXF4SlpHZDlUN2dJdVpHOWFMdDdVcWtGNU5CWU9jNEo5YVYzSjJu?=
 =?utf-8?B?TjVsTzd4T2ZhUDFUSjRVVlNOWUs3R2FNNndzYlhMSFdFeko3ZlE1a25LQ01S?=
 =?utf-8?B?ZkFIVHcwNzc3S3dZQVRseXlDeHZac1lMaGVnY3FkeloxSmxCZWpXWkx3dmZ0?=
 =?utf-8?B?dFZnT1hRVjk1T3BhL1RLN2RYQ2g5MGt5ZlQ2S1VvR3R5TGV1QWYwcUhpSGNH?=
 =?utf-8?B?YjJtSVQyVS93STZ3ZXFsK1VLMTdUUHhuQnVmdkZCRHk1b003Zm13aEI1RG9P?=
 =?utf-8?B?M1BOdEVKUGZoTmxZTFJWNitWU05KZ01OanZCSXIzdUxoRHdLMHFCT0JNSEdN?=
 =?utf-8?B?c09DbStBSU43c2JWRXozRGdkUUQ2TFJQZ2hhNm1wVEg0YkVlZktIWHB1N2cz?=
 =?utf-8?B?NXBJa0JKSmg4WlE4dVJTWTQxK2M0dGxPdm1IOGtJRC9WYjYrY0dlZHRPZzBh?=
 =?utf-8?B?QlM3dUFKbzYyQncyemNrRGF3YzRxOHBlR0ljRnRTSXd1RVljUjNlWjdBT0Ft?=
 =?utf-8?B?c2ZzNnZSekNidTF0amlqa3pFZ2ZrbFVKNi80N2MxQnBoM3h6M0RrOWlZb0Jw?=
 =?utf-8?Q?jVOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d617942-b98f-46d3-0ceb-08dbb35cd09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:52:22.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jUljsF5bxGHRvhF+xas7wWGCeK9H57wgb7XaYglRYF/QujxZW03a+fx9Vsms19wh4NwGVGDG0hxkWK7KLny9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAxMjoxMyBQTQ0KDQo+IFdoeSBuZWVkIFAyUCBm
b3IgTGl2ZSBNaWdyYXRpb24/DQpBIHBlZXIgZGV2aWNlIG1heSBiZSBhY2Nlc3NpbmcgdGhlIHZp
cnRpbyBkZXZpY2UuIEhlbmNlIGZpcnN0IGFsbCB0aGUgZGV2aWNlcyB0byBiZSBzdG9wcGVkIGxp
a2UgWzFdIGFsbG93aW5nIHRoZW0gdG8gYWNjZXB0IGRyaXZlciBub3RpZmljYXRpb25zIGZyb20g
dGhlIHBlZXIgZGV2aWNlLg0KT25jZSBhbGwgdGhlIGRldmljZXMgYXJlIHN0b3BwZWQsIHRoYW4g
ZWFjaCBkZXZpY2UgdG8gYmUgZnJlZXplIHRvIG5vdCBkbyBhbnkgZGV2aWNlIGNvbnRleHQgdXBk
YXRlcy4gQXQgdGhpcyBwb2ludCB0aGUgZmluYWwgZGV2aWNlIGNvbnRleHQgY2FuIGJlIHJlYWQg
YnkgdGhlIG93bmVyIGRyaXZlci4NCg==

