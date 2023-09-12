Return-Path: <virtio-dev-return-13701-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C3BCA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:44:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 86AEC1922F9
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:44:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D73B986655
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 07:44:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6BBB4986634; Tue, 12 Sep 2023 07:44:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A80C986485;
	Tue, 12 Sep 2023 07:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC5dc8ym7fQc87S+Oqmx6kiU95ufwfAbsjfHyFbMWOZfZFswP00pRR4bhEEtv8SFT+AnoAlG22r6SXZHbp3Vzi9Q1Ur9H573vPU0xVUk3GkELcdH5mMQYT5+oguCJf0e0YePy6/lINrGaVTYetxG2eUb7BqPvLziiBmExXRnFYI0Cp/C6yOnpiZvCLv1SgsRpvSLVM1kwXA+cYvMOnTeBjYqz7k+3NwiFB2vIDQK+lVkYe9O8aIamDQxXsYCQp1xSGvdQoFe/rA8t3C0sNuKYslHFM5O9jYAcL019pIkCkk2NnXjr3Pi+LIJhxpDl001M+LUDo6oU/cDy+Cr8fZl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym77PABEWrbx3DP+wL/U3TKl4fhXZj9PTRozfgvwpXg=;
 b=KuwqZRKbM4zXTdZMxjCzVWL3ECLA9VBbgtWJXeMaKtpjd2OkT2iDxyHeLpGLsrmd+evTRdzVue6AzShe6pGSUGUp+vqgTMZYHieguIz+MCWeMGkuWlKHg7dOc4uzsgkYgztk6I123ctlLAJ9h4YdXq/rroUD+/UuY3OR/cv6N/qLiWo5RYQ1IQVtsHDKsf1P1WkgNHUfnmlmBXqSQPn5BCTRyctoOh+eX6D37mCTuOxW7mOV1QD/43TyzhQm5THtNRY9awWQxChk52irRDPK6jjXSJNjamDs1U1au3V5I2B+5WZRw5gDx/yqpPQTA8JM6V0fx0dDDMt6yUvSir8YOA==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TCAAAzeAIAAAVow
Date: Tue, 12 Sep 2023 07:43:59 +0000
Message-ID:
 <PH0PR12MB5481CBCF7BEE5637D16BC179DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5449424a-4872-0164-0c3f-caa34ad46388@intel.com>
In-Reply-To: <5449424a-4872-0164-0c3f-caa34ad46388@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7066:EE_
x-ms-office365-filtering-correlation-id: 85756c91-3601-4541-e3cb-08dbb36406c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e6mc3K/7UZK2x6l9/gpQsv7AD+Pkzk8MMxGvy262Dx2iZxusFbj8gEaZtfKYUs1xoCSNjVJ7NHqcBu25P4KIxF8vmpJApKWac9dh541UUtmjlBpFwHZ/bAH6GoUqiKJFUxiCXopTX7TZCsAOX+kqNd+QmKeVLKJhf87D2viStrFdMG0DZOlIfV38mx/+5M/fKmmUpmGPYTze6ae24ID9xFFzBVaQz03HZT9asfTM+8An+HIMvgofpO/WI89VQuoBfrMkImboycnNPi1TY/wKfzlTBIM1OUjY2rEoCCVzJbkcvwQ2c+bwwOw7euqSB086VxsRXf9EZbFOqKn2Wox1LNCHRmBA3fI//sMbr6gGwMh19k6YU9J8gO1zTJvAn9C0nejF0UbYThJPR5s3N/GpGSwkr/LtnbyYkC6791CEz4siyCQnieaAqosH+K8u8sPN8OYQSb6jWD0OPPSH4FP+Z3D7Zx9i+zyPu8UswnFdaE0twc/ojjZ0e7XyVm/RFhLaDs1kLVTOv4eLhIpNLtHXKCHW//b5caA4rM9JAiuNnjsa+B4WCWTlYFiQ5YUrzIwHFumhb10CASyYURy/rby6W3ldB92+czJsWINqI6+nsSjJJ9+8N4kB6USvLeoxo73dKp5zpdDVzGIWbUHouUR6GrWA6rDk3OGiH+eBEACRUTA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(186009)(1800799009)(451199024)(478600001)(38070700005)(38100700002)(966005)(122000001)(26005)(71200400001)(7696005)(9686003)(53546011)(6506007)(41300700001)(54906003)(66556008)(110136005)(76116006)(66946007)(316002)(66446008)(64756008)(66476007)(83380400001)(52536014)(5660300002)(4326008)(8676002)(8936002)(2906002)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHNNSm9RSWFGK24vNHhnZW1HOFFicGtxQ3VkbzIwbHBCMTQvSERodmxUT2FV?=
 =?utf-8?B?OWZ5bDVvK1NIUVA0YkJNY3NCSG5kckhkUG9HLzI2VGhMcnViQjFLbUg2VFph?=
 =?utf-8?B?eEM0QzA1OUhvWngvc1RPeXgyTHBuWmNFVEdFSmZlbnlKL3pZdklLSXFsZlF3?=
 =?utf-8?B?MEJtRENsYWhmM2VmQVJFeGQxbDJxdjBMbWdxYUhvUUNlZHhhNmduRWpUSnNO?=
 =?utf-8?B?b210dDlOdTFRUW1DZmlQZERjY2ZPWkJyUmlUTnZES0tQRzB6U3VSa3RZMFgx?=
 =?utf-8?B?Ykg0WlJOdmI5L1lOU0w2cm51ZFZteHZuV3NUdTBXbndsTGVOWEJ4WEYwdUJD?=
 =?utf-8?B?dG1idmlFZVY1aW1lZGtKMUtqUmhxV2VVanlCV2JJRUNteVFlQ1ByRzBXTU9G?=
 =?utf-8?B?WTdXaDBLZlNtdU00cStNNUlRbnM3Q3ptQXl1ckg3d0orZG5DNlB3blFkb0dR?=
 =?utf-8?B?b2hmQ0FzbmhwaFcvYWpOeWI0OHBYd0hkU2pPaDRaOVNGa09uZVFuV2RvQ3Ba?=
 =?utf-8?B?NXFkSXdZWGZRdzFjWEw1aVRkRWI1Z2tHK1BrZHhxSUNIS2dHVnpVR0FuYTBq?=
 =?utf-8?B?bzRMQ2pmQmxub0hGcUhTVzl5R0s5dTJJME5PbzMweGZURlg3enBkQkViUUNs?=
 =?utf-8?B?VXR2ZENJajJEQ0lhc3R6QVhmSm5WM0loY2xTbDlJSXJnY3dWTThkR0tOc2tN?=
 =?utf-8?B?UXBuVVJhZDBXNUtyS2RpTDVSSXZlQWVHcGZaZ3ZGNGtMcU9WUHRYUll5MEky?=
 =?utf-8?B?cG1wQVZFdDJ5Mk9TZkhiSUhwb2hhT1BvZDFyWUJ3TUdFcEVwcDBTSkE1bUtj?=
 =?utf-8?B?bTJ4aDJ3Z1ErWEh0TGhtWnB1aER5cVk4NmxKbkxwUjdYWlRlamZ1SmxQOUJz?=
 =?utf-8?B?VkJ4SHpPWFcxSGN3ZzRrbEtNUWxBN3BLWjUzS1h3UUY4a2pVN2F4L0hNWjBL?=
 =?utf-8?B?SVltM0sweDdsKzE0RlZLNkVvUUlGWVlLRmllZXNEMXB0VTZyMXBOREFWR3B3?=
 =?utf-8?B?REM2VXQ1WlZaa2tTcW9hRFgzNmZ6U3FRK2JpK2R5V09pME9FdVByOFU5NVZu?=
 =?utf-8?B?blRFZE8xeHpOZ0VXQW9tUmluRE5rcGl6SUNVZGVtdlEzOXNIMlk1cFY0RkJh?=
 =?utf-8?B?bmUyUFdIMmhqUlZzejBFUkE3SVZQV0g0TXlONERmbTJTMUc1Rkp5b3BlQXpN?=
 =?utf-8?B?SWdoanZWNU4ydXIybDdlUXNXSVVMUmZSNkszcTFBZWRsbnd2aUZsRlZaWERB?=
 =?utf-8?B?OVZMU0IvcVU4MnRDa01hSXQ2SFE2L0xUM2t0bFJCaGZ6amVOTjBVY1Z6Vnp3?=
 =?utf-8?B?TSt3dW1tVUNHWEZZRTNsZEI1YWtpVm52RFA3WDJxWDg1SmVSQnVFVFFKSkVN?=
 =?utf-8?B?bTY0R0FuMkFRWjR0NGFEU2xjVSs2emNxcC9iWWUwUHA3MTJXMmZXSW5xVkxT?=
 =?utf-8?B?V1R4TFpVYTdKdnZQSmtyejBwN08xdDZCRi91cEpMSm9LK0Z5Q1ltRFZzTEJt?=
 =?utf-8?B?Z0ZMMzVjZFptNVhHWGZIajVlQ3pHdHJlUU9uT3BBTEgvdXNBYjVsOTVUYWR2?=
 =?utf-8?B?WHpMYlNjQ1hkMkxEM1BuVWI2SnlMcHBYMnlweFdPOFdzeE1aMDgydDNhS0tu?=
 =?utf-8?B?anB2d3BkWWJRbDJyMUJnSHlFaEkwT0EwTWNHZ2FkUlJUTVVQQlFsc0ZYbVFN?=
 =?utf-8?B?bUlORGEyb1VsRzlDYXhVRGorKzRqR0RtU1FkTkFvZUlLejA1RTJNN0pHb1dz?=
 =?utf-8?B?dVcrVkxPSWc1ak5Rd2FCTWMrR1RPUDJaa0N4bEkyK1A3NXkrL1JuZnpSZXdh?=
 =?utf-8?B?bVdHUUpsVUV2Tm4rbmJ6NXRQYUUwUFQyQWUzOStwbEJyR1NNNDg5SWVlVDB0?=
 =?utf-8?B?azVWZXZqbWZKWkQ5UVNHd2JEOVd3cGJyL0NSakZOQlVnckpYdVdWRnVQYWZo?=
 =?utf-8?B?ZGRDSnE5SlB4dXJIbjkrWk9Xdm9JQkszZUlHa3A4MXYwMHVTL0dUVGhDS0wy?=
 =?utf-8?B?ZDcxYVpqSHFkN3RHOE9zd2QrdE9Mc21NVlhSNFN2TDNEa0hQTndyQng3ZlN6?=
 =?utf-8?B?K1ZvZzVxVHp2R3BvdHhUVGVTejJvK2VjTVNac3l1VVRHdndxOEhYWFk1YW03?=
 =?utf-8?Q?pfsc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85756c91-3601-4541-e3cb-08dbb36406c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 07:43:59.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50KSMpuvVTIWBgg8VCaXFAhmcZM6IqVh1bcD0CbZEdlkYe+qH3uo3jyCXNXpDNh4kBJ5JLqYoVNrFrfy/keUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAxOjA2IFBNDQo+IA0KPiBPbiA5LzEyLzIwMjMg
Mjo1MiBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIs
IDIwMjMgMTI6MTMgUE0gV2h5IG5lZWQgUDJQIGZvciBMaXZlDQo+ID4+IE1pZ3JhdGlvbj8NCj4g
PiBBIHBlZXIgZGV2aWNlIG1heSBiZSBhY2Nlc3NpbmcgdGhlIHZpcnRpbyBkZXZpY2UuIEhlbmNl
IGZpcnN0IGFsbCB0aGUgZGV2aWNlcyB0bw0KPiBiZSBzdG9wcGVkIGxpa2UgWzFdIGFsbG93aW5n
IHRoZW0gdG8gYWNjZXB0IGRyaXZlciBub3RpZmljYXRpb25zIGZyb20gdGhlIHBlZXINCj4gZGV2
aWNlLg0KPiA+IE9uY2UgYWxsIHRoZSBkZXZpY2VzIGFyZSBzdG9wcGVkLCB0aGFuIGVhY2ggZGV2
aWNlIHRvIGJlIGZyZWV6ZSB0byBub3QgZG8gYW55DQo+IGRldmljZSBjb250ZXh0IHVwZGF0ZXMu
IEF0IHRoaXMgcG9pbnQgdGhlIGZpbmFsIGRldmljZSBjb250ZXh0IGNhbiBiZSByZWFkIGJ5IHRo
ZQ0KPiBvd25lciBkcml2ZXIuDQo+IElzIGl0IGJleW9uZCB0aGUgc3BlYz8gTnZpZGlhIHNwZWNp
ZmljIHVzZSBjYXNlIGFuZCBub3QgcmVsYXRlZCB0byB2aXJ0aW8gbGl2ZQ0KPiBtaWdyYXRpb24/
DQpOb3QgYXQgYWxsIE52aWRpYSBzcGVjaWZpYy4NCkFuZCBub3QgYWxsIGF0IGFsbCBiZXlvbmQg
dGhlIHNwZWNpZmljYXRpb24uDQpQQ0kgdHJhbnNwb3J0IGlzIHByb2JhYmx5IGJ5IGZhciBtb3N0
IGNvbW1vbiB0cmFuc3BvcnQgb2YgdmlydGlvLg0KQW5kIGhlbmNlLCBzcGVjIHByb3Bvc2VkIGlu
IFsxXSBjb3ZlcnMgaXQuDQoNCkl0IGlzIHRoZSBiYXNlIGxpbmUgaW1wbGVtZW50YXRpb24gb2Yg
bGVhZGluZyBPUyBzdWNoIGFzIExpbnV4IGtlcm5lbC4NCg0KRGVjYWRlIG1hdHVyZSBzdGFjayBs
aWtlIHZmaW8gcmVjb21tZW5kcyBzdXBwb3J0IGZvciBwMnAgYXMgYmFzZSBsaW5lIHdpdGhvdXQg
d2hpY2ggbXVsdGlwbGUgZGV2aWNlcyBtaWdyYXRpb24gY2FuIGZhaWwgYXMgaHlwZXJ2aXNvciBo
YXMgbm8ga25vd2xlZGdlIGlmIHR3byBkZXZpY2VzIGFyZSBpbnRlcmFjdGluZyBvciBub3QuDQoN
ClsxXSBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50
LzIwMjMwOS9tc2cwMDA3MS5odG1sDQo=

