Return-Path: <virtio-dev-return-13617-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B22ECA0FE9
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 03:31:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BEBD112D34C
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 03:31:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFF1A9865EE
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 03:31:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A06F798648B; Tue,  5 Sep 2023 03:31:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A26D986410;
	Tue,  5 Sep 2023 03:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSFF2kkRPVBsWUPPxhC5Otcwz6BTuD4rBj2q3Jcpui8IIf1dxQ9SsoTklpLK9tgi/PhXDr+qSr+SgclAEoBeEuic9ZNiC7fRT7NOZf4T2OxtFmwPwB9IDCPJmL25ckwv7i85pxvDu8Y00C55DyO7FI6Xo3PAMpAqLYo/pVQ+SlzGd3mUpvbfcdh5fS8vaBbwjRxgxjlIRO4CRZG6OHwxGD7+iKDqWwOuAOx+kSLpp/PZKBFohaRWzr4ceOP0Eak+4r8jEIOU6QvWsKLiObYWTYchqAGf4dB3kBkpCJsi8BPTw568KM2E3nuf4x63PXPZXBlpP1GhYZoZkq0aFW0XAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khbhDPc1o6msxdCrenzPKKzxlsTKauAXwt9uGQNNezA=;
 b=XurBxr/tXevISBCfRJiOgGOkS2c1p8YjaVRU4ukf5ofZERcgoSqMHGIJciakFwvtyITSLCXYW5ReQGc5ikfwG84IOTIqQCSB35fBPmU132bKlj/iN+LPt7VyrCtky4wlpTNkkFytFTF+jML13lHoxZq7pKfj6ZJqrkx0PhzOmsG9p1krPbifNrO2GaK1Whki8hz8fXHYNaprLEeTRGPC9cznARUkroDElgWsaHO4rbI9enJh6sbhqDwSDLBTHJG05w3HDpJaMMGhIK2s4OlrdvjaFpT/aq3mi69OEE6Lh7/eESOxASY/TgJ1eVpsrvu0lc7yMg02rkM4CHhUajsrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Heng Qi
	<hengqi@linux.alibaba.com>
Thread-Topic: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats
Thread-Index:
 AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYIAAA0cAgAABWeCAAAy/gIAAGFyQgAAOWYCAABFEUIAA9qeAgAAI84A=
Date: Tue, 5 Sep 2023 03:31:41 +0000
Message-ID:
 <PH0PR12MB548108B8FB8E60E9A9502C5BDCE8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
 <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693882549.2640717-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693882549.2640717-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7335:EE_
x-ms-office365-filtering-correlation-id: 21964d01-a122-449d-3cb5-08dbadc09ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l1fSvQ6vTGpb7BO+4yGw9emudk5GHlx/Rpm4bT9u3zEVPqEfRZA3ICVYgEhwYYyi4ZhaRp2G7XVl8jR0OhyWTRyigMjs1ozHbZbo4i0dlwxybf+PT1IerKs26Bq4RplKLF/OOqL1n9Vq3hdLKnUQ56x5Fa0ysB+bD0aR1J5XAFnmkX+Ii+CWwlI42oOdRE8lUNSiXu81yRPwZ5cb+OZ+3u/Odelq4YP0BFdLbpAMXg1J4yP0s66qmQIOYsb0jDoRUtuJBx1OSl/Mytv0g784c+wt7c2OBgJffYThuFDwsznMpqEyQOfbi93oxtNMM6PfUg8yvzwqn81kiNWJBgMcQhWBFxkal/5BDtQ5y31y0AfVzSEYCwfUeUZnBMmdbKgTyU4BqHVpf+2ruG+g63UNVc7l07Di0H+76iSlBrvxx1y9kPGHC6quYbsaVkPFFslRI3l9Rs6vSXRXEYFlsTm1GVYLljIPtyPMNqg8cEqVdHzP+WCPf4MiAGQm5KZdf2YuKbDPqdR2RxNC48FeiZWWUT7ytNiJEavaEanLkSl878MwXLP8rNnDCByAk7a7yDRd0s0mIbJEss4UiqjN2WD2yFdyffwe08bzsAorFCBwRjJJZ1gyUbR2O93UK6g41USh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(41300700001)(71200400001)(7696005)(6506007)(122000001)(478600001)(38100700002)(38070700005)(83380400001)(26005)(9686003)(4744005)(55016003)(54906003)(66476007)(316002)(66556008)(6916009)(2906002)(66446008)(33656002)(64756008)(86362001)(76116006)(8936002)(66946007)(52536014)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlpFWmxBLzl3N1dhNnpyQWk0dmViUVNzK2lSSk1qeTA3aWQwKzBHU0o2aUJz?=
 =?utf-8?B?NDZ3bm54V0M3bWhkTXYzazhvR0VNZFJhMGgxbGZYWG55d3krV3NIcHFVNEEy?=
 =?utf-8?B?dWVXSmpDbCtRVjdmYWswdnlLLzg3T3F4VjZSaThrdCtQaTlwR3BpTWhhZ3JY?=
 =?utf-8?B?Nk1wZEUzSG55azcwbEoyVTcvY0JrR2ZyR2JybXVBUXd5TGY3WFpnWXFmdHMw?=
 =?utf-8?B?M3poTWFVci91NTJQckYybU5OZ3BpYVQwVStDeWtQNFM3d0NSbHdlT3Y2eDZv?=
 =?utf-8?B?UFd0L0krQ2hlOUNRUmpvWU5kK2dyN0wxTFdNenlOaFozenpsKzA1MHkyUTlq?=
 =?utf-8?B?ek50RFVTblo2VU1EOEV5RnlZRCtZWmdnbHF4VlF3TkdBUGZEUFlKdXM4RXNU?=
 =?utf-8?B?NkhkMzJGRlNYY3JBV0FKbzVkQ0xpS0ZuZm90ZktlZ0w5K1lnTXB1UzR4NC9y?=
 =?utf-8?B?UklsMTZiOEZERXh5NHMxcHgxb0NiWituQzFQRTdwbzg3ZjNhbVNSOHNTSzdy?=
 =?utf-8?B?OUR0Uk5BUmdvcFZXdnEvQ255ZVRrNGdzQm1oYXkzU29nTDJVUlc4KzJSZ3E1?=
 =?utf-8?B?dUpxbVdjUUh6S0ppNW14ZC9zUzN5U3VHSnl1UEhYMXFaZGxPaDhkMUZWNCt5?=
 =?utf-8?B?WFlWK3M0dkpqblFXekc5cVlKcGZ5b1VHTjJ6emsxVjgxTkkrdzJTQ3RGMHpL?=
 =?utf-8?B?UTEwTVRvdVdZNXVkODhTQ3Q3QVRMSGI1RUJQNTJiQVdQdklaWUdNSHdYd3hm?=
 =?utf-8?B?UUkrTU02NUpwWmZsR2t4Wm5tcDFsSVA1T3AzM2d4V2ZhTkZwSW5Tb0F0VHpT?=
 =?utf-8?B?Y3o5blRKZG9uSTc4enZENzl1S1FxQ1BlMzZLdy9FSE5hZlkyY3U1S0tXUnJJ?=
 =?utf-8?B?dlRkdHpyOW51cVZtcmNoaW1PeC9mbXROSTg2WFh0Z25FNmFuNFQvVGZyYlRl?=
 =?utf-8?B?am9USkZDTDJPODFwSzlYUmJSMHpoUWVwVmZ6UGxRblQ1L3hmTHN1aEhsYlJC?=
 =?utf-8?B?MXBHdUxSeTJjcGlRYnAxR2xSRHplQkhOdTRXUkU3TUl6UndWeHFDMWM2ZFM3?=
 =?utf-8?B?dDdzK2pISlBLTk5MZGg5V3g1UGNOMkpZT01HeE5iVDB1YUdva2JEaWRackRP?=
 =?utf-8?B?OVdRL2JNdStMZFVuOFBtZGg1eXhlejM3S3kzWjRSdnBnRWtDVjlpZGNRRkF4?=
 =?utf-8?B?V1JsN2huMVRhdElNbnczMFM4eEloa3p2Z2pYQjc2TDJoSDNDb29lRWZOUXBx?=
 =?utf-8?B?SUtmTkxwQlBncGhiVER4c2hzMWt6YU9SZlhmR1hBa2tpd1p0MGlzQ0orWExW?=
 =?utf-8?B?SGZIT0tSS3p3ZjhiNGhERHJQb2tZYTRNamtMcERSMDRkUC9WNFpsVTB4MGpS?=
 =?utf-8?B?akFRZGVBZjBNbnc4bWNmclo1WEh6eG5IRDlhL0dBRmdoMjZTanZpelFOT3hz?=
 =?utf-8?B?UXFyRGVrN05pd1I4QUZUV3A0czFtcDRqK20vOXgvbERkWHl5R3pLZmNVNEJF?=
 =?utf-8?B?UE1CWjBtSFpjSlBXeEVpRFBnU3B2SURGT215cGQvZ0Z0YXplSDFmUG44UWx1?=
 =?utf-8?B?Y0NPMDZQSUdVZm5NUUx0dGNabVpCeiszQ1ZiaEs2RjdlK3MwdlJCNW5KbkZU?=
 =?utf-8?B?S3VpWlpFQjFoTzhKbVdVb0x0YWlzQXJFWm9OVXkzOWFhdVF3OXhVYmRnaTZv?=
 =?utf-8?B?cUlPNTExdm5pYnNVTVVkUnJYVzJtQ1ZjN3pWTHRrditaYTFPZml6RkxVdWRQ?=
 =?utf-8?B?SERLVmNpTTYyZVpUZVJtQWZJLzlOaCtFbUh1bHB0ZVNCdjJhdS8zNSsyNEU3?=
 =?utf-8?B?SkFuQjFITEdsTFNRWkM1RVlMV2luUlJCbHg4a29WbXBVdy9selVHN04xM0FT?=
 =?utf-8?B?d2ZISjlFV3NabjBCQjZsU0tESUlzNkVaWU9KQ1QzWkFRNFFpV1VScmZuWWgw?=
 =?utf-8?B?aHZ0L3ZLL2lCZWIrSWNUdHJWSUVmTjFzdXdlMU1HVXVuZTF4ZVBmUkZEQS8x?=
 =?utf-8?B?aDdVMU1PUzhaekQvNjFlVnd2Q0dZVS9GdDRwMHUrTGp6a3F6MTVMRXlydU0v?=
 =?utf-8?B?ZHVWSlgzUnF2YzBaVkp1NTVOQmlidUFjWGpXMDJzWVVNTTl1TE1EN2owYmIy?=
 =?utf-8?Q?QGU0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21964d01-a122-449d-3cb5-08dbadc09ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 03:31:41.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ea7u830SZI9h5ksZfAXQtM/7NKOjZBDGW1jWhhzIFRDJ6BvH8ZIns4rsBvWo4wZykM9++nLaSEB2l9HuWIBUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
Subject: RE: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats

DQoNCj4gRnJvbTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDUsIDIwMjMgODoyNiBBTQ0KDQo+ID4gU3VyZSwgaXQgY2Fu
IGF2b2lkIHNlZ21lbnRhdGlvbiwgYnV0IG5vdCBhdCB0aGUgY29zdCBvZiBza2lwcGluZyBtdHUg
Y2hlY2suDQo+ID4gRm9yIGV4YW1wbGUsIHNlbmRlciBzZW5kcyBza2Igd2l0aCBnc28gd2l0aCBl
YWNoIHNlZ21lbnQgb2YgOUssIGFuZCByZWNlaXZlcg0KPiBoYXMgbXR1IG9mIDE1MDAsIHNhbWUg
c2tiIHdpdGhvdXQgc2VnbWVudGF0aW9uIGlzIG5vdCBnb29kLg0KPiA+IEJlY2F1c2UgZ3NvX3Np
emUgc2hvdWxkIGJlIHNhbWUgYXMgMTUwMCB0byBtYXRjaCB0aGUgbXR1Lg0KPiANCj4gRmlyc3Qs
IGZvciBtZSwgSSB0aGluayB0aGUgc2l6ZSBvZiB0aGUgZWFjaCBidWZmZXIgc3BlY2lmaWVkIGJ5
IHRoZSBkZXNjIGlzIGlycmVsYXRlZA0KPiB0byB0aGUgZ3NvX3NpemUuDQo+IA0KPiBBbmQgdGhl
IHJlY2VpdmVyIGNhbiBzZXQgdGhlIGdzb19zaXplIHRvIG1hdGNoIHRoZSBNVFUuDQo+IA0KPiBT
byB0aGUgc2VuZGVyIGNhbiBzZW5kIGEgZ3NvIHBhY2tldCB3aXRoIGFueSBzZWdtZW50cywgYW55
IGdzb19zaXplLg0KPiBGb3IgdGhlIHJlY2VpdmVyLCBpdCByZWNlaXZlcyBhIGJpZyBwYWNrZXQs
IGl0IGNvcHlzIHRvIHRoZSBkcml2ZXIgd2l0aCBtdWx0cGxlDQo+IGJ1ZmZlcnMsIGFuZCBzZXRz
IHRoZSByaWdodCBnc29fc2l6ZS4NCj4gDQo+IElzIHRoYXQgcmlnaHQ/DQoNClJpZ2h0Lg0KQnkg
ZGVmaW5pdGlvbiBvZiBHU08gaXQgaXMgc2VnbWVudGVkLg0KU29pIGNvdW50ZXJzIHNob3VsZCBi
ZSBmb3IgdGhlIHNlZ21lbnRlZC4NCkFuZCBmb3Igc3BlY2lhbCBjYXNlIG9mICJOb3RlIiwgdGhl
cmUgc2hvdWxkIGJlIHNlcGFyYXRlIGNvdW50ZXIgdG8gaW5kaWNhdGUgR1NPIHdhcyByZXF1ZXN0
ZWRfYnV0X25vdF9kb25lLg0K

