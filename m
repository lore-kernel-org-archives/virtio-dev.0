Return-Path: <virtio-dev-return-13214-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B1EEB64D9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 13:26:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EE6A370EC
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 13:26:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F440986721
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 13:26:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 716E7986599; Tue,  4 Jul 2023 13:26:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D23A986595;
	Tue,  4 Jul 2023 13:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7oJ1uxm82/Z8CmODXbC+0Ft6eaK1IsbDbBRrzucTwPdDoone5fuIByRtvBtGhY5KnPRdjiAhAKs2dvZnsmKC9ix5zs5qPeXqqspiE+jff22X7NoVXK3Nim6Fe2ar641SWWtKSdZT/UJBX72XLEvnLyNYui9X7Y+rLOd56h6m2eKesbkAF2U/Wim/NKyQZZB9scjvL73Qk3Db+XL5VIDZfNuVyMij4ONI1Hy7rzzB3HlZ1OtkqixJk/lCHsWDYc4Smm2TsI6BcQV6EkgtBWHumg+w8zf6KWPHSloJzCZV56FTsqMkwdsezYDLXqB4eFeXl032h3IT2UUsSZmgYbxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hT3icXyOeeUenUyjbvvgmAGXQQT7T8Imo5t4M/AyRM=;
 b=l99FZE4wVB5L1WJ09JL9GeLqTFNZFhQPJrrco5C1I5HNfutQKQIeNJTR2kh6kf0xn18ClGQsrCkZyL9tUAN2sphhT456jM11ceUrcHRlBOFRZM6CxGz5z+mI1RoikXlsG8B9vF7VwPxGkKbz1mvKdZtNjmXxkcxVBSqPlOLdWlKokxs3KTodCrK4+ZtnCjKARN25PYoEb7JHtEd3Tu1uduc8a5flXj96tB0RpSxtipZubDOD268jJmJtlpbtFfkhIhRnmdxDjYE99v0lPrNx/N/OSOlN08pPQ/4BCppDXwmOAUMwNt7G1+TO+uS3c/fcXa0/NXfbSParof1w4mtwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v8 0/4] admin: Access legacy registers using admin
 commands
Thread-Index: AQHZqwo3LlOIYLW4T0GWzsM1aRxlEa+pn0VQ
Date: Tue, 4 Jul 2023 13:26:20 +0000
Message-ID:
 <PH0PR12MB54811B4999A4249C55AAB41FDC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
In-Reply-To: <20230630042006.1569920-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB9239:EE_
x-ms-office365-filtering-correlation-id: 63ab2fc4-792f-4353-b8be-08db7c92415d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7LRQVWeMmuYKn4WdGZS84Wj6zo3HaemEMleGGk1uVnpCCECWhHprETj13XH8oBrCM7kIqDn7zqBZ5R77tRU7oxIZx1Z9EQXpkIhLUNIdOCKcqW9eX2sRcpSWRFX9K9QTzgH7GzJmvef2M8RZnDdHqnuGmPdF3exqYAZgd7vgJmi6ScciScuxT5RMmwwcPIw4LaWV7SjK6h9chiIZxHdPFBe05udu4SQAsGBpqv911bWr144nsgRQYiCGwGhdDHW22z0Q2fhXaE3P9FYr0Zow9e3ERLPJCtrYCcMlbDzoEFxGQjoVmYC04yWAiqGzZ1Na1A+KPmV+0S4Qr6eprFcTNhtiYPxzV+V2valX//o0HtSFx7pnuI4c2Y4CRgu7p7gdnjlTEXDp8uBnfDxC1kxJ5MPfrfCjsLdlxe6B9FC3pgnBFrDocoq2Dk8p9pEAQOGFDlCalxfDcip05SQq12evLrF6UBtV+A/m8QsqmZUiapWvPge5TPwIXv1rXW8ee6QoKG9HGJ1C/jIiRhtMwlnkgQkScyplHm946u3H4mSeinDBtj6vqY+6Och+2fW+GR+jCfOFWv2muf2TwsF9XCJGYhmOm8BqkYCuBOk7/NyCG4l+7hO8cmOO63bkQs8MHZjSIYs76agDgO41Dx1yYJtvuQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(41300700001)(5660300002)(52536014)(54906003)(110136005)(55016003)(71200400001)(7696005)(2906002)(316002)(8676002)(8936002)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(33656002)(966005)(478600001)(107886003)(38100700002)(38070700005)(186003)(86362001)(66946007)(122000001)(83380400001)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTE4Rm0yaW44dnhrMFNYUnlTWTl0SjFUSGMxNS93UFNxNEhHL3RXZU1OTWRp?=
 =?utf-8?B?WnEyWkZMcGlpLzNkVmdYZ2JQRElUR0lmNWIrbmJ4NzdOWjRPZk53c3JSdmN1?=
 =?utf-8?B?VmVrVTkwQUdabm5HMXdxOXpwWjBKVjBzSWoyN0p1cnlZN0ZXTHBYMUY0ekRj?=
 =?utf-8?B?bmtCQTdiSmFRMjAwdjRuZ2lxTXFDNk82M29Fem01TnNFVTkzQkNzcmhzNXVW?=
 =?utf-8?B?bVlnZXpLNHZ5R29nd0JscmcwcnNTSk5KeldkM0FWSjVGY2pZWmY3MlpPdzd0?=
 =?utf-8?B?Q0d1Z2tRUjdRbjQzcU5FY1BvaUhlQmVucFNPeStnTFVlcG9JeWlaMGhGMXV4?=
 =?utf-8?B?SnRxbTVhSngwZ0NSMHRzcmRNd1RKeTNrdHBiWk1BVEQvaEg3SGRFOXVLRVlQ?=
 =?utf-8?B?UHlFVlk4NVFPWTBnVndENWRrVVp6OHZjV2Jrd05tNTdkSGdHelNNMXpNcldB?=
 =?utf-8?B?blB2RnZDbm9ZaGlZcWh3Qjd3Q1pqRVYzZnVCR1hPOEx3S2U1ek1pL3Q3anIz?=
 =?utf-8?B?cjFuR1k4K3Q4QnlXRTVCTmYzZHBQQzZWZHI4eHRxZ3B4MFA5bWZTS1FpOGtO?=
 =?utf-8?B?MGlLZGN6Wk5PL1Y4UHZEQW5XUzRFWGRHVERlcFlNbDg3Vk8wNWt2b3N4dVdZ?=
 =?utf-8?B?Mmt1WEc1bkJ3K2g2THppWWcvU3hPVnhnbmRqbmJMTWZ4NUpuZ3ZnV2o0QVhl?=
 =?utf-8?B?cU85YVhMQXlXaWVEdFA5N0dlTnlRdnpKaDNYejluNzRTcWdVTTBnVUJNOWRr?=
 =?utf-8?B?ZEFrV2dQWUxDL1ZsYkxvcVFkN01LRUUybklpZUJtVzhXOER6YXlmM3hPN2dD?=
 =?utf-8?B?a2pRSkJmZk9CT2EvU2VNYXN6YUFFclc0cEoySnNFK3RnL09raW04MXR4YitB?=
 =?utf-8?B?TjhGSVZ5eVd5SFlMVGdmVG04ajZ1QUdXVEwrVmRRdzNydXgvaEUvNTV6MXVS?=
 =?utf-8?B?RU9rMjBlZW9HZmYvc0lKbXRRdm0zMEtxV241WWdCTEdnNG9PZDFyeDluelVl?=
 =?utf-8?B?anVXMnZvRlg3T0Nia1JsQkZpc21BYk5mbk9paVZJMHQxQndmZ1ErQ0w1dmRz?=
 =?utf-8?B?YndkeUk4Wjl2dm5xQmt4dWU1czQ0M0Zxb1pxa2pxYzRZQVZXQVJaYnJaaWM3?=
 =?utf-8?B?UkEyZUgwMHB2Qk1UT3BlSm8rWFNIdWZLZzBZOXFVNk53MHRZSlp6ZC9nSjFT?=
 =?utf-8?B?NldybXU2UmZNMzM2aDU5Vm5vSlpISjl0cmozTmlSb05VbytnUDdSR2hYK3Nv?=
 =?utf-8?B?dVlaNzBaL0lrN0JJMC8vMUh3Z0RJeEFIY3drSitEK1AvL09KMWlvMmYrL09N?=
 =?utf-8?B?aWxWdHdrVmR5blNzTGpIdVNyaFJyTFBvT3l1M0NPSWFndjR3bUZRbFV0b0gx?=
 =?utf-8?B?c2RuTCtKOXZvM08yakNRVk1GcDBSOWh4SE03SXJOSSt0RUMwRTZGRy94c3c3?=
 =?utf-8?B?NU9IVmRrN2FTbzUxZlFzUVFuWEluR0VCcW8zTUczeXpzWFQwQWdOWlJFeXdq?=
 =?utf-8?B?Qy92aEE3UWRoeVllTzgxQXg2T3JSV29QbjhXM3U0UnduQW5KYzhkZHc1Q3BJ?=
 =?utf-8?B?ZE9NdldDblExb1h3S3dKTFRESGtreXh5ZVpQdjhOakNreW9RenhUaTE3K3Bl?=
 =?utf-8?B?WjA1enlBZ0EwanVxZHhOWjlkRDZzamkrd2E0RzI1aUc2ajhxTTNVRFQwdlQx?=
 =?utf-8?B?ZTNXb2FHaHZ5NFdRV1FhWm5KYWJDVU9GSEFhQmpBM1JXOXNkK1A2YU1RTndo?=
 =?utf-8?B?MUJacklmR0NoeDJydXJ2aTY4QlEwM0ZDeWZDWHpoRU13UVpOV01JZFFoalU0?=
 =?utf-8?B?RDJOazZ1M0RTYUV3OTVBVEwvVUp1VjNialB5dEFQdG9EZkxkVWxVaDFST1ZQ?=
 =?utf-8?B?RzNnVU5iVWFTWDRGK3l3V3owSXB4VWE0ZXVFQUVBdjhNY3QwU3NIWE5UNWNy?=
 =?utf-8?B?ai9NZUFiVjliR0J6eWtTcUJnNmRWN0hmcS9NdWQyY3FhZ0krVTkxMDVsUHhm?=
 =?utf-8?B?aXREMEI2QkpJa0QvVjQzV1lLRGc5V0NzM05pcVhFYWRiSk4vYXE5T2dVQ0JC?=
 =?utf-8?B?U0xTQkt6VTl2Z1lVMktPWjNLNlFsVW1kUm5RaTRic1lPOXdaVUZqSHNLZnJq?=
 =?utf-8?Q?zT0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab2fc4-792f-4353-b8be-08db7c92415d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 13:26:20.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dq2YCpAhPvPzdIKhqQsjQU6w/VtaLJpVv41P1nTacclpzugMdBf0lse/qPa4xNAVXS9sdEk5HbsoCU4BGB3uOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
Subject: [virtio-dev] RE: [PATCH v8 0/4] admin: Access legacy registers using admin
 commands

SGkgTWljaGFlbCwNCg0KPiBGcm9tOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAyMyAxMjoyMCBBTQ0KPiANCj4gVGhpcyBzaG9ydCBz
ZXJpZXMgaW50cm9kdWNlcyBsZWdhY3kgcmVnaXN0ZXJzIGFjY2VzcyBjb21tYW5kcyBmb3IgdGhl
IG93bmVyDQo+IGdyb3VwIG1lbWJlciBhY2Nlc3MgdGhlIGxlZ2FjeSByZWdpc3RlcnMgb2YgdGhl
IG1lbWJlciBWRnMuDQo+IFRoaXMgc2hvcnQgc2VyaWVzIGludHJvZHVjZXMgbGVnYWN5IHJlZ2lv
biBhY2Nlc3MgY29tbWFuZHMgYnkgdGhlIGdyb3VwIG93bmVyDQo+IGRldmljZSBmb3IgaXRzIG1l
bWJlciBkZXZpY2VzLg0KPiBDdXJyZW50bHkgaXQgaXMgYXBwbGljYWJsZSB0byB0aGUgUENJIFBG
IGFuZCBWRiBkZXZpY2VzLiBJZiBpbiBmdXR1cmUgYW55IFNJT1YNCj4gZGV2aWNlcyB0byBzdXBw
b3J0IGxlZ2FjeSByZWdpc3RlcnMsIHRoZXkgY2FuIGJlIGVhc2lseSBzdXBwb3J0ZWQgdXNpbmcg
c2FtZQ0KPiBjb21tYW5kcyBieSB1c2luZyB0aGUgZ3JvdXAgbWVtYmVyIGlkZW50aWZpZXJzIG9m
IHRoZSBmdXR1cmUgU0lPViBkZXZpY2VzLg0KPiANCj4gTW9yZSBkZXRhaWxzIGFzIG92ZXJ2aWV3
LCBtb3RpdmF0aW9uLCB1c2UgY2FzZSBhcmUgZnVydGhlciBkZXNjcmliZWQgYmVsb3cuDQo+IA0K
PiBQYXRjaCBzdW1tYXJ5Og0KPiAtLS0tLS0tLS0tLS0tLQ0KPiBwYXRjaC0xIHNwbGl0IHJvd3Mg
b2YgYWRtaW4gb3Bjb2RlIHRhYmxlcyBieSBhIGxpbmUNCj4gcGF0Y2gtMiBmaXggc2VjdGlvbiBu
dW1iZXJpbmcNCj4gcGF0Y2gtMyBhZGQgZ2VuZXJpYyBsZWdhY3kgcmVnaW9uIGFjY2VzcyBjb21t
YW5kcw0KPiBwYXRjaC00IGFkZCBwY2kgc3BlY2lmaWMgZGVmaW5pdGlvbg0KDQpbLi5dDQo+IEZp
eGVzOiBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xNjcN
Cj4gU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0KPiANCj4g
LS0tDQo+IGNoYW5nZWxvZzoNCj4gdjctPnY4Og0KPiAtIHJlbW92ZSBlbXB0eSBsaW5lIGF0IHRo
ZSBlbmQgb2YgZmlsZQ0KPiAtIHJlbW92ZWQgd2hpdGUgc3BhY2UgYXQgdGhlIGVuZA0KPiAtIGFk
ZHJlc3NlZCBjb21tZW50cyBmcm9tIE1pY2hhZWwgYWRkIGxpbmsgdG8gcGNpDQo+IC0gcmVuYW1l
ZCByZWdpb24gdG8gcmVnaW9uX2RhdGENCj4gLSBtYWRlIHJlZ2lvbl9kYXRhIHdpZHRoIHRvIGJl
IDE2IGJ5dGVzIHRvIGNvdmVyIGZvciA4IGJ5dGVzIG9mZnNldA0KPiAtIG1vdmVkIGdlbmVyaWMg
bm90aWZpY2F0aW9uIHJlZ2lvbiByZWxhdGVkIG5vcm1hdGl2ZSBmcm9tIHBjaSB0bw0KPiAgIGdl
bmVyaWMgc2VjdGlvbg0KPiAtIG1hZGUgYmFyIG9mZnNldCA2NC1iaXQNCj4gLSBwcmVmaXggbGVn
YWN5IHNwZWNpZmljIHN0cnVjdHVyZSB3aXRoIF9sZWdhY3kNCj4gLSBtb3ZlZCBnZW5lcmljIG5v
cm1hdGl2ZSBmcm9tIHBjaSB0byBnZW5lcmljIHNlY3Rpb24NCj4gLSBhZGRlZCBsaW5rIHRvIHZp
cnRpbyBwY2kgY2FwYWJpbGl0aWVzIHdoZW4gcmVmZXJyaW5nIHRvIGJhciAwDQo+IC0gcmVtb3Zl
ICdzaG91bGQnIGZyb20gZ2VuZXJpYyBkZXNjcmlwdGlvbg0KDQpEbyB5b3UgaGF2ZSBhbnkgZnVy
dGhlciBjb21tZW50cyBvbiAzcmQgYW5kIDR0aCBwYXRjaD8NCkkgZml4ZWQgeW91ciBjb21tZW50
cyBvZiB2NywgYW5kIHNvbWUgbW9yZSB3ZXJlIGZpeGVkLg0K

