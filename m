Return-Path: <virtio-dev-return-12759-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AE3C77B7D
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 02:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E3F6370FB
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 02:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D5719867BB
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 02:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0CB6C986720; Fri, 19 May 2023 02:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6438198671F;
	Fri, 19 May 2023 02:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihEt2yydfAuQAxHtjIucQwxiiLHzCtgOuq7YjDyJwFFoDMWgb+ADzP0bSwkp8azmXLfCduSsU5MfdxN8vG9sDrPMEcjg1hcHQslPKKG87+zozcEzYf+G8/36ZQeQaCJilclJHWaTKbnTuR3zEhbdB7uaIhTn8VdVuGrSQU8JZovP7xopt3M5iTqqggCsjEKqkBESIZMIQ3gO8GokgqPRkSKFBudNIuHB1aRxOX22vZBYj9rAY10GGVyDNFZ909S0PWYmSN3u3EuEg7+HHtoltrfbUsb7NDYZ59hQXeb0ZSg5PNS/21sguueGnihuDrV4NHnlzKF1/p6WWBmrwgPW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyU+XULKvp6vC2oX1OfY7V+pQs8LDQ07OewvY0ksD0k=;
 b=c8XgF/fJBTTIB3bdkDE7DhH7rN5PZGNB5w35Hx2cRx1m/MaR3RNLLJmjfNBzLEQoJ7H0BUSluol3LCMlJHgsPAASqF3kouj35jyrDQfmMv8tZ6hN9anMZNiA4pzWyOJ496mZehFNOiKuLb3KFUP9CXoFu6LC4N4qqUuG8kzOQT+cC2qA6+zXufsCOr5Q2nppCvYmwLIOXL2y4WWQSZa8WI1PMv/GpVswmPwMUhuOpSNdbBaQie8C8NWEI2O7inRw8lv5u4l+P1fUHTMhvHQadW3O9604o30n4LN3hkCnBzbJ7sVXU62GmJ2l8wZsRhb/lyN4GhRjVM9gF3Z1ttqhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index: AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAAZ/sAgAAAvBA=
Date: Fri, 19 May 2023 02:04:31 +0000
Message-ID:
 <PH0PR12MB5481F073BD627152064ECEE0DC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <CACGkMEt+XLvGmj5Cez8Sb_T0UfujCi16u5zpMAe+jJG+JJXr6A@mail.gmail.com>
In-Reply-To:
 <CACGkMEt+XLvGmj5Cez8Sb_T0UfujCi16u5zpMAe+jJG+JJXr6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6759:EE_
x-ms-office365-filtering-correlation-id: 16a631f5-70bd-4e00-1374-08db580d6287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NDCYZ1nwQKIeGR+Srr9lpo+ts9FIv8mXh8UuMUxI250eZYYFP+ByxiTuUv1ItDG1T4Tc8RCOSNhmpxrDioEo4TK+qGHN0oEg56QqnMC6IL4YCEVpjGoohwcYMDcr8LF+DQMBzE81yfs/1gxVKuFNPxEnpM6Wlq0+K0PaWgfGNY/E1TNVhxdppQUtSqJgA7KPUCjX03QS+zm+gHIrsaIU83iEXpqm7DFoO+vO5Ty98T8G4jYfSGhWpW+/GdonmWsM5lNWj3ndfmfW7ZGhmz30Tw8lpoJQLVjlAPaQ0bNKJwLMIsSAknHM7/IeDp6ED3aBfUSjOhemh7/FDzUoqBv7abvn/oAl4xX3HlTWYPcrxLGFmXLTLhWPyLtJCAbjpvqmqoOE7exz+nTa12DQllx7+XTpAxZIi/zQTldD/gISSe1kPmiunl9ciaTv/u+mfwK7QosPwCJSz04zvdUwNsPpG1ZkK/olyONL0ikUsxOrPLKl6pD9fSvfPJOahQzEdsZpZcNYk60v21odc98COtCQ9gkDEG0cTPmTNZNgjVHTsfJ2PwTT0wkjcgNl8+Oh1ZGE5cqn6HxDuGNE/0B1rEAlMrySLiXAXpxqqA0tCyPiTlQIQ1fYtHHgnCdlTYGOicXd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(41300700001)(8936002)(38070700005)(107886003)(2906002)(8676002)(7696005)(6506007)(26005)(55016003)(71200400001)(110136005)(54906003)(66946007)(66556008)(33656002)(38100700002)(83380400001)(9686003)(76116006)(316002)(478600001)(186003)(5660300002)(4326008)(66446008)(64756008)(66476007)(86362001)(122000001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkFERzRUUy9VTGQzR0R5UUo2Sys0cCtvZ1dwb2RyQkpsOEhXTjZ2S1JOM3NP?=
 =?utf-8?B?KytUejYvM0pLalp2bnNQb3R2ZUVHRU9YVE5YMStmczVqNFpxTlo0QmM3Snl2?=
 =?utf-8?B?UlBFd0JmbGw2OGJVdVpTdHl4VWJ4Y1dZeDJZdXpCSC9idTEyRUZXaEVBVlpR?=
 =?utf-8?B?L0tCVk9qYWkwd0ZSVjR3Qzh1Y3NqejM1bG0vcWRXL2VRQWhLN1ZRaS9rblNO?=
 =?utf-8?B?enlxWVIrcWdzcXdSY2VUZWpKeFFvNzBicXo2Mkk2Uk41S0tOZWl1Q0pVemxT?=
 =?utf-8?B?bkdrYXJDcnZUbkh6Vy9hSnFES0hXR0ZvSk9lb0Fva1JwcTMxMS9jRTg2aG1B?=
 =?utf-8?B?TlRYN3kvUmM0RDNScXlaNG9qWnVuODYvQW9PSG1ZdWlzUXQvdHZpWmlpTXhN?=
 =?utf-8?B?VlhQZ0NOYWF3bTl1SU1OUmNrb3lEcGt2RjVaTWVRUWpuMTBuS3NMb3FqckVh?=
 =?utf-8?B?Rk5VcGpQUnFNV3lhOHBDUG10ODluSm9ZWFZlQVpEZmFXOVhEQ2l1am44MXQw?=
 =?utf-8?B?VWtNVWE5RFE3ZDlndG9VZldiSTBWWnBNL0NLR2NVcm01amUrelI4QTllVGd5?=
 =?utf-8?B?NHdkdGpCT2Nvb1p3NVhWaGQ3dnRuODFFT3Q0a2J4bXoyQ3FDQTQ2Z2o1UW5Q?=
 =?utf-8?B?NGkvVHR2UFM0aHVReitQUWFBRjJ1cWVETmEzZUhVSjB0cFkyT0pvTzNqNC9V?=
 =?utf-8?B?NHhHb3VzeUJlUEl3Y0JlMVBQWENIaHlrN3kxTjllT0d5c2QrTWlHVUpDb0Fm?=
 =?utf-8?B?dDIxT0pUU3cvM2U3T0xwM0IxRnhzclNMRkc2M1E4Z3lBdXorSUFGRXpFMDJ2?=
 =?utf-8?B?TlhHWFVoSDIyQnR6bnZEdlFiY2pFN1M4V1ZacDJaRXlYRGF1YjVoYitkbVBk?=
 =?utf-8?B?bEpPSVpnUEZIcmw5bzlFK0MyeVJ2Q0hKSUpXMkgxajl3YnAzM0V3UjN6emIx?=
 =?utf-8?B?b2NiV1hDUDdOcEk5RUZUQUIzcVJJeHk5US9WSEhnallOMzl1SEplZkVRWFAx?=
 =?utf-8?B?YjVHK1AwUjl6WXJQZVI3eVBKdGJiV0tXM25YOVpaRXhJc0lmNlpjeW95eEZn?=
 =?utf-8?B?b0lTUzhwSVh2aVBWVlBicURFVXhMa3FaUzl1SXk2Q000RnYzNHA0d2JZalAy?=
 =?utf-8?B?N0o5K29vRkZMMnZKQ0YwcUd1UTZKN1FKOTFvb2ZvaEp1L2diRzRDOXI3V2My?=
 =?utf-8?B?RUE5RDlvbStubW9kVWdnTTRVVEk2SVVlTHV4ZlZGMkdGWHpWNzlDS1lNTFZ1?=
 =?utf-8?B?b0lrSGR6V3ZzcDdHVkQ1SHF1STNLRWpkUlJEUTRVOW5FZkYyeE9WazdockZo?=
 =?utf-8?B?enhXQlhOTGlnK2RqTHhTeFhMdEFtTHRDdlNRS0lpd0N0anBNaGhZSWRSL1p2?=
 =?utf-8?B?OGxQS1hHUGRrZWdnb1JHVnFiRVBMaXE0NHphZGo3Z3o0bTZUNWV5WlRLVXZF?=
 =?utf-8?B?ai9NbXo4eFZSSUxNcVhHcHhWdTVGbVMxbytCaEZwdEhuVXVPK0dzTnNaOG11?=
 =?utf-8?B?dDJjcU5SWnNxQlBFVVFKcnc0WHdINEx6ODRscCtGMUh2T2xtUGZ4U1h3Qktr?=
 =?utf-8?B?K1JYN2djOFlOdlFSQkFNalRlSnkvNXlHVE50VnFsZHJJNC9OVFpTN0k2L2lR?=
 =?utf-8?B?SnA0Z2RTanBrdjdxcDRRcDllUkQzZnFTbG5WdmVHSDVxVXNubzdUNmtKa3V6?=
 =?utf-8?B?TFg5Yi9rVEE0d2JjKyt6cXFPaHZjbi93ZXkyNVZodVZNbGVERytKNFdQRHIw?=
 =?utf-8?B?cWVYTWdqeFpOL3dFSWpQemlDWTQyWnM0a2ltYW1JTzQ1ZktMMW1XRjFkZjJq?=
 =?utf-8?B?WCtmcFVSQTNBTjNPakFrUTh0eVVsaTg3bVl4ODd5NkJndFJTeEdWSGgxWHFi?=
 =?utf-8?B?di9wOHdQSklLNmh3dnRpVWNrMUdUMVl1Wmd5dVVZVDdiTG51a0xDM1lwL0dY?=
 =?utf-8?B?dVpIVUt0aEF6YXpONWR3T0F4Y3A2aERWOE94YjdMT2ZmR0cvSmdBMjhMK090?=
 =?utf-8?B?L2RMUHVaR3Q0RnB5bFI5cUJwanZnWjFtOHpjWmVZWHREN2dXQWlMaDdOQ3RC?=
 =?utf-8?B?aHRNSU81QWFpc3ZpWFRVLzZNdmJaK1BXT0lGeDBpa3dkazNnMFZlbkU2M1Nl?=
 =?utf-8?Q?goIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a631f5-70bd-4e00-1374-08db580d6287
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 02:04:31.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmTSx171E5SnmDJQ7djI0PALkrOV+jDScdolhx/zkH7p5jcwcgcQU7WxH9KZrLwF0Oo8k90qND3tN1y3HlpMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE1heSAxOCwgMjAyMyA5OjU0IFBNDQoNCj4gPiA+IEh5cGVydmlzb3IgbmVlZHMgdG8g
aW5zcGVjdCBNU0ktWCBlbmFibGUvZGlzYWJsZSBzZXR0aW5ncyB0byBkZWNpZGUgd2hlbg0KPiB0
byBpc3N1ZSBjb21tYW5kICMxIHZzICMzIGZvciB0aGUgcmVxdWVzdGVkIG9mZnNldC4NCj4gPg0K
PiANCj4gSSBkb24ndCBrbm93IHdoeSBpdCBpcyBhIHByb2JsZW0sIGZvciBhbnkgaHlwZXJ2aXNv
ciB0aGF0IHN1cHBvcnRzIGxlZ2FjeSwgdGhlDQo+IGNvZGUgKE1TSS1YIGVuYWJsZW1lbnQgZGV0
ZWN0aW9uKSBzaG91bGQgYWxyZWFkeSBiZSB0aGVyZS4NCj4gDQo+IEFuZCBpdCBpcyBqdXN0IHNv
bWV0aGluZyBsaWtlIHdoYXQgUWVtdSBoYWQ6DQo+IA0KPiAvKiBUaGUgcmVtYWluaW5nIHNwYWNl
IGlzIGRlZmluZWQgYnkgZWFjaCBkcml2ZXIgYXMgdGhlIHBlci1kcml2ZXINCj4gICogY29uZmln
dXJhdGlvbiBzcGFjZSAqLw0KPiAjZGVmaW5lIFZJUlRJT19QQ0lfQ09ORklHX1NJWkUoZGV2KQ0K
PiBWSVJUSU9fUENJX0NPTkZJR19PRkYobXNpeF9lbmFibGVkKGRldikpDQo+IA0KPiBJcyB0aGlz
IHJlYWxseSBleHBlbnNpdmU/DQo+DQpOb3QgcmVhbGx5LCBpdHMganVzdCBhbiBhZGRpdGlvbmFs
IHF1ZXJ5IG9uIHRoZSBjb25maWcgYWNjZXNzLg0KDQo+ID4gPiBTbyB3ZSB3aWxsIGhhdmUgdG90
YWwgNSBjb21tYW5kcyAoaW5zdGVhZCBvZiAzKS4NCj4gPiA+DQo+ID4gPiAxLiBsZWdhY3kgY29t
bW9uIGNvbmZpZyByZWFkDQo+ID4gPiAyLiBsZWdhY3kgY29tbW9uIGNvbmZpZyB3cml0ZQ0KPiA+
ID4NCj4gPiA+IDMuIGxlZ2FjeSBkZXZpY2UgY29uZmlnIHJlYWQNCj4gPiA+IDQuIGxlZ2FjeSBk
ZXZpY2UgY29uZmlnIHdyaXRlDQo+ID4gPiA1LiBxdWVyeSBkZXZpY2Ugbm90aWZpY2F0aW9uIGFy
ZWENCj4gPiA+DQo+ID4gPiAjMSBhbmQgIzMgc2FtZSBjbWQgc2lnbmF0dXJlIGJ1dCBkaWZmZXJl
bnQgb3Bjb2RlLg0KPiA+ID4gIzIgYW5kICM0IHNhbWUgY21kIHNpZ25hdHVyZSBidXQgZGlmZmVy
ZW50IG9wY29kZS4NCj4gPiA+DQo+ID4NCj4gPiBTb3VuZHMgcmVhc29uYWJsZS4gSmFzb24/DQo+
IA0KPiBCZXR0ZXIsIGJ1dCBmb3IgdHJhbnNwb3J0IHZpcnRxdWV1ZS9hZG1pbnEgd2Ugd29uJ3Qg
Z28gdGhpcyB3YXkgYnV0IHVzaW5nDQo+IGluZGl2aWR1YWwgY29tbWFuZHMgZm9yIGNvbW1vbiBh
bmQgb3RoZXIgY29uZmlndXJhdGlvbnMgZm9yIGEgbW9yZQ0KPiBkZXRlcm1pbmlzdGljIGJlaGF2
aW91ciB3aXRoIGEgc2ltcGxlciBkZXZpY2UuDQo+IA0KPiBUd28gdGhpbmdzIGluIG15IG1pbmQ6
DQo+IA0KPiAxKSBUaGVyZSdzIHByb2JhYmx5IG5vIG5lZWQgZm9yIGEgQkFSIGFuZCBpdCBzaG91
bGQgYmUgc3VmZmljaWVudCBmb3IgYW4gYWRkcmVzcywNCj4gdGhlIGRldmljZSBqdXN0IG5lZWRz
IHRvIG1ha2Ugc3VyZSB0byByZXBvcnQgYSBjb3JyZWN0IGFkZHJlc3MgaWYgQkFSIGlzDQo+IHJl
bWFwcGVkLiBJdCBoZWxwcyB0byBzYXZlIEJBUiBmb3IgVkYgYXMgd2VsbC4NCj4gMikgV2UgbmVl
ZCBhIHNpemUsIG90aGVyd2lzZSB3ZSBkb24ndCBrbm93IGlmIHRoZSBub3RpZmljYXRpb24gYXJl
YSBjb3VsZCBiZQ0KPiBtYXBwZWQgc2FmZWx5IHRvIHRoZSBndWVzdC4gQW5kIGluIHRoZSBjYXNl
IG9mIHZpcnRpb19wY2lfbm90aWZ5X2NhcCwgdGhvdWdoIGl0DQo+IGNvdWxkIGJlIGltcGxpZWQg
YnkgdGhlIG9mZnNldCBidXQgaXQgZGVzZXJ2ZXMgYSBmb3JtYWwgY2xhcmlmaWNhdGlvbiBhcyB3
ZWxsIHRoZXJlLg0KPg0KQSBkZWRpY2F0ZWQgY29tbWFuZCB0aGF0IHJldHVybnMgQkFSLCBvZmZz
ZXQgYW5kIHNpemUgaXMgZWxlZ2FudCB0byBhdm9pZCBtaXhpbmcgcGNpIGNhcGFiaWxpdHkgYW5k
IHJlZ2lzdGVyIGxpbmtpbmcuDQpTb3J0IG9mIHNlbGYtY29udGFpbmVkIGNvbW1hbmQuDQo=

