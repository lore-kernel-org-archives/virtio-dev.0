Return-Path: <virtio-dev-return-13780-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E37BCD37B4
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:29:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A65FE157EE6
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:29:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9309698666A
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:29:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 81F1998621D; Sun, 17 Sep 2023 05:29:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FFD09843C1;
	Sun, 17 Sep 2023 05:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKQK7YfuT/7vg5T7oWDE5SoB/z25YZpTYLZ6bv/n/4plJGapKwEc4LA/rMdYU//nSil02IaqFIETmBTR5/7IPO5KfJ7IId93jSJsNaaq2VT8mNlmBj4PFEZ7XbjX5tvjlNF9mhWkvYEvsGMLIXiAw1TAhCNQkG3MEDsshkULiSgOU9IUBQm9Ky6ZX99tmWXBznit+kx5hBXUA5ZPYL2g3OHSVeJL0Vewa++TuyNzHIrFJ6seE54XpEBzdLgKGgIkLdsWHxzKku4H+gM/EteJdGBVeJNcYYKMfgqQ5ta8uRRwom3jO5M3akeBMIUNfXi5ghD9FKogAuM74QbuO2q8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8Yek/SCHmnp7NtrJ6wk+RAVc8bwg2pCbLaXmK1EUWc=;
 b=E7NBiYWEPx7fzwWRqk2BIfn9E2MiLQqvR8tWWYW92+VYJV96ISRwNWEHzKzOZ5est6dXFqzUaD+rEE0TL0Iy0XM1ihEeQ70zIAomnPFtcUdn9y/wuTZWI4Uz1zqjG2zlJjm5VIVMpDgzxNdEcHP+wzU0gAl90M3KYcQmwDv69zg2rMN6pBGOZgexU7bEpYYpTuZjVQy8VVZKNnZHeulBUUwzwWS+z6a8P0rFl/c5emtEBOLcOuwnQmnQRSU60S7qPsh82UrtFD68prRK5qur7eaP3RpWeWH2K64IQfIHw7h0blgrLDugJgJn2BXpVFOn55iYvTNODtDC2lHPoFCaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIABe3mAgAAAQYCAAXhzgIAE3Fug
Date: Sun, 17 Sep 2023 05:29:08 +0000
Message-ID:
 <PH0PR12MB5481EB8FFDE1915271D3CA4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs+5AjGzeDbWZYSkOMw65d6g6oDfgbOapa1G3EbtLUy7A@mail.gmail.com>
 <PH0PR12MB54811C3EC1618E413695D8FDDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMz3KShVbxpf_DLSx8qde=8JAdPPYOnA_udEfQ8UU+uQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtMz3KShVbxpf_DLSx8qde=8JAdPPYOnA_udEfQ8UU+uQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6977:EE_
x-ms-office365-filtering-correlation-id: 7f256fe5-f428-4e6c-1ec9-08dbb73f0406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YrR4OvO+2sxnym9+km/auXq9w4VYntV38K/FOM4iPI5YeR7FxXFm6owlupYUcSR4Ep1ooorBHfeeroxMRJTCJMgnOdK0G2aPQosyny37niPkOKJicCvUgSSpRvspsGqSKwTPGmywseBnY4Tf19GcV1b1Iu10MtWbXALVwl81oI34ubmG8ZN6etoDgImxOqb4yOZO6az1RCo2RROuJ+COsMNwkxIKRqTA6lmbxJQQEeF3Qs9PXpIUeRmzZhA5F84V9bnL2AJfvCHQ1INCjLXmyBQTVhIpoQ+iptgNTkbs38Qkn7D40djGwIbgAreDf3nkn+mDp6RTxxmiXo8gE/i67xyZkmw4zHvzrg2o5RQ/HtvndPy5qyZpz0534Je7+5RqR949XC8SctYo2XGVl2UxOE8lfVBcWVziKwWYMshRHUrUFZYUidBZuY6wohkTh5EB99K7WviD+aBT0XVLJn1mKc5Wj4Id+n9Do76+aHol0Nvs1nzV3EK7soX9ay7uDkq7t0oOAUPNb9Yeyr1oBqJdEUxdHXsCulQSpQ5V4LrYe1YIZe9CEBmeGIkkpzT3oXCKUDM4yvrHw3mu1nG9L2iOyd/rceILeWIaVD0L5U/cCiykGAY1u8sm5fNGmrkxJXXL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(52536014)(8936002)(8676002)(4326008)(122000001)(33656002)(2906002)(55016003)(5660300002)(86362001)(53546011)(7696005)(6506007)(55236004)(478600001)(71200400001)(6916009)(316002)(54906003)(9686003)(76116006)(66946007)(66446008)(64756008)(66476007)(38070700005)(66556008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFB5VTFRdm8rNGIrZzBGWU5nQnFOZjBjZEZ3R3JzblpJUC9hMWZoVzR6SkpW?=
 =?utf-8?B?UitQN21kdHNzREJwL0tqYTA1cVIyL2FUU1JMMGFXT0Y2Ry9rWEU4ak5FczYy?=
 =?utf-8?B?TVVCUGt1UDVrZTIvd0Z2YytUZ2FWYnQzd2d0ejhlRmxUeDhsaGZXNUNTTEU2?=
 =?utf-8?B?SFYzR1NLMGV6UllMMGRVWnEzbVJGZnZ4VlVlRHljUTNDZDVwUlEwdm84b1o4?=
 =?utf-8?B?L2hua0NDRHhmaUExaVd0ZzVNUEdWZmtxZENTZ08vYkNzOStrK2Z6TVdselhZ?=
 =?utf-8?B?TDdBajR3WUxvQnV6VmN0UnNCQ3Q2aGlLWmRtNFVHVlM5K2ZkSkhFSHltQXAw?=
 =?utf-8?B?NWFCTW5QeEhmUUlFSWdreXh5QjhTUE9mL21JK3BjRTlNWkoyUkJ4SDlZWWcy?=
 =?utf-8?B?eElaTklHRDJhV1JqV05nVFRNOS9WYnZibVdRTnVMQktHN0dsRHR6WjlpY21Y?=
 =?utf-8?B?Y2tyS2ZPMTdHSnp3T3dNQnpYM3JLUXA3bm5vbHlvcHRxMCswY0ZvSW5nNGQz?=
 =?utf-8?B?ZHFBRnhPSllGSno4OGxiWktleFMyUnRxYzZmcEVpYmdNT2I3YmdsbThUSS85?=
 =?utf-8?B?NlZqMm93Rk5Hd3A4aTRTbWVwYkgvancybmRzaUlqWGwzTWVVaGhWaFFOd1dN?=
 =?utf-8?B?TXhOLzg0b1VGUHFNNDl5SmZXL2dWQlhic3lqWVJiNnRoN2R2RXBGYUp4T0cv?=
 =?utf-8?B?eGloRU1OcmZOMi9xM25wV2dvc2VpL3BCcEFlOEQ0QWEzYTJnQ1JVN3pBWGJ3?=
 =?utf-8?B?clcwRitIa0xPSGVSeC9Ib3RPRlpkbzZqWTB0VksvR2RDSlVtVElnbkJFYjdZ?=
 =?utf-8?B?UVlNeHpyQkRkSG9VeEF4aHNFWUk2Skp3eEswaE95RERvTmRMcFc1U05Bem13?=
 =?utf-8?B?Mm9JWjBQRW9aTmE1c1krWWRmcjVackdjc2I3d3E1SWt0aE9tMUl1SHowRjdT?=
 =?utf-8?B?QkQ3eFVPU2tXQ2dCQ1ZlZFQxNGlTVVBweERpUGVLYTVacVBKd2hEUXEvQlZ4?=
 =?utf-8?B?eU8rVTBQeXhzUWl2ZjZSWS9CMXIzMmRKTTdNMXRIZHMxdzc4VEFGQXE2V2do?=
 =?utf-8?B?S1l6eGJERnpjeTh3UkxHRE9RWWlaVXVJYmxHYWRUdHk2cHBEVlZQRjRuR210?=
 =?utf-8?B?NlJ5Y1dmM1FzTHVVdmhuWHFDWFUvVk1VbzlzMVBvWHU2bDZFbFVQRU85cnZ4?=
 =?utf-8?B?Wm80MFh5dkVIT25QOGVkeDFQbnZmWEJLZDZ0RXFmNnFYSHBBOTZrSGpacUNu?=
 =?utf-8?B?anNHNXVJS0N6QUxNMDVlWGZhNVRoWDErM2pjeG1SWWR1WnJId3dGTzg4VHFG?=
 =?utf-8?B?VEVOQjZqdmtaR0hleTArdmVRY2huUWNCSStHSVJOWTk4NXF1ZENyWEZXSC8w?=
 =?utf-8?B?M242QVJsNjlkZzUrVWJ3M0s3K3JkZWVOU3puUHRJdzhGSnVCQWNQM01oZFFz?=
 =?utf-8?B?ZzRYUHgzcENoNVhLRlZ5d0hGR0hxUlBrSjJybHlHZTNPN000YUxzYUhEVlVk?=
 =?utf-8?B?RXlSTnNqNHNWb0syV0lEcUk4VzFTOUQ3OW8wOFJFa0dGMlhvWFVUU3ZoaTVo?=
 =?utf-8?B?OFlXbkZ4SWV5Nk9SMDVMbTNMemV4c1VLaUxLS1B5UWx5NGI2dW1FZWhqWEJj?=
 =?utf-8?B?dnNiWk9Pd1ZmRHdINnNKRFhhOTdKUkJxaWgyano5dmR2TGlBbTRJN3c0NDVl?=
 =?utf-8?B?dXh4dGpkeGxJTzhSVzkvekplVHdtNTAyUk1MNlpsVjFkMHd3WjJubGJQUGdq?=
 =?utf-8?B?dDdkOElwbG0rY1Y4TmticWh4dnVQNnJLL3VhaG9JZmx4ZThpVkdzalJWSmxJ?=
 =?utf-8?B?Z25hamVKcldmS1ZSeG1ObFNJOS9HTE94UzlKSFp3U041bHE0a2xkdXNKWmlX?=
 =?utf-8?B?VXEzSEl3U1VsTy9VN0V0a0Z4ckxBNmxBdWsvM0p1dXk5L1FOYVh5N1pSVUR1?=
 =?utf-8?B?S2xSNW94VzZadytvcG1yMGprRXNZNXB2WjJuMS9MSHAxTEJJQ1JLZE1pNnVL?=
 =?utf-8?B?TVQrYnRzTk1ZM3NJdFp1dm1IV0p1Ym5MVGNiRGZWMllPTzRJRjFDVXpTTTRM?=
 =?utf-8?B?aE1OSmRSdW5ZTUNDUXMrdTFQdzhvNmlsQVZUL2lOU0tYZXFQblU5bDRBMG45?=
 =?utf-8?Q?vQVA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f256fe5-f428-4e6c-1ec9-08dbb73f0406
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 05:29:08.0785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5B2kpnbrRfYOjW6I/Kw2nFIZKebSEW/bv/jEwlpSDAjzQhSA7Sp35gCTMItOZwEZMYgaXFw841UZyc3a3bpI4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjMgODo0MiBBTQ0KPiANCj4gT24gV2VkLCBTZXAgMTMsIDIw
MjMgYXQgMTI6NDbigK9QTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4g
U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMjMgMTA6MTQgQU0NCj4gPg0KPiA+ID4g
SXQncyBub3QgYWJvdXQgaG93IG1hbnkgc3RhdGVzIGluIGEgc2luZ2xlIHN0YXRlIG1hY2hpbmUs
IGl0J3MgYWJvdXQNCj4gPiA+IGhvdyBtYW55IHN0YXRlIG1hY2hpbmVzIHRoYXQgZXhpc3QgZm9y
IGRldmljZSBzdGF0dXMuIEhhdmluZyBtb3JlDQo+ID4gPiB0aGFuIG9uZSBjcmVhdGVzIGJpZyBv
YnN0YWNsZXMgYW5kIGNvbXBsZXhpdHkgaW4gdGhlIGRldmljZS4gWW91DQo+ID4gPiBuZWVkIHRv
IGRlZmluZSB0aGUgaW50ZXJhY3Rpb24gb2YgZWFjaCBzdGF0ZSBvdGhlcndpc2UgeW91IGxlYXZl
IHVuZGVmaW5lZA0KPiBiZWhhdmlvdXJzLg0KPiA+IFRoZSBkZXZpY2UgbW9kZSBoYXMgemVybyBy
ZWxhdGlvbiB0byB0aGUgZGV2aWNlIHN0YXR1cy4NCj4gDQo+IFlvdSB3aWxsIHNvb24gZ2V0IHRo
aXMgaXNzdWUgd2hlbiB5b3Ugd2FudCB0byBkbyBuZXN0aW5nLg0KPiANCkkgZG9u4oCZdCB0aGlu
ayBzby4gT25lIG5lZWRzIHRvIGludGVyY2VwdCBpdCB3aGVuIG9uZSB3YW50cyB0byBkbyB0cmFw
K2VtdWxhdGlvbiB3aGljaCBzZWVtcyB0byBmdWxsZmlsIHRoZSBuZXN0aW5nIHVzZSBjYXNlLg0K
DQo+ID4gSXQgZG9lcyBub3QgbWVzcyB3aXRoIGl0IGF0IGFsbC4NCj4gPiBJbiBmYWN0IHRoZSBu
ZXcgYml0cyBpbiBkZXZpY2Ugc3RhdHVzIGlzIG1ha2luZyBpdCBtb3JlIGNvbXBsZXggZm9yIHRo
ZSBkZXZpY2UNCj4gdG8gaGFuZGxlLg0KPiANCj4gQXJlIHlvdSBjaGFsbGVuZ2luZyB0aGUgZGVz
aWduIG9mIHRoZSBkZXZpY2Ugc3RhdHVzPyBJdCdzIGRlZmluaXRlbHkgdG9vIGxhdGUgdG8gZG8N
Cj4gdGhpcy4NCj4gDQpOby4gSSBhbSBzYXlpbmcgdGhlIGV4dGVuZGluZyBkZXZpY2Vfc3RhdHVz
IHdpdGggeWV0IGFub3RoZXIgc3RhdGUgaXMgZXF1YWxseSBjb21wbGV4IGFuZCBpdHMgY29yZSBv
ZiB0aGUgZGV2aWNlLg0KDQo+IFRoaXMgcHJvcG9zYWwgaW5jcmVhc2VzIGp1c3Qgb25lIGJpdCBh
bmQgdGhhdCB3b3JyaWVzIHlvdT8gT3IgeW91IHRoaW5rIG9uZQ0KPiBtb3JlIHN0YXRlIGlzIG11
Y2ggbW9yZSBjb21wbGljYXRlZCB0aGFuIGEgbmV3IHN0YXRlIG1hY2hpbmUgd2l0aCB0d28NCj4g
c3RhdGVzPw0KDQpJdCBpcyBtb2RlIGFuZCBub3Qgc3RhdGUuIEFuZCB0d28gbW9kZXMgYXJlIG5l
ZWRlZCBmb3Igc3VwcG9ydGluZyBQMlAgZGV2aWNlLg0KV2hlbiBvbmUgd2FudHMgdG8gZG8gd2l0
aCBtZWRpYXRpb24sIHRoZXJlIGFsc28gdHdvIHN0YXRlcyBhcmUgbmVlZGVkLg0KDQpUaGUga2V5
IGlzIG1vZGVzIGFyZSBub3QgaW50ZXJhY3Rpbmcgd2l0aCB0aGUgZGV2aWNlX3N0YXR1cyBiZWNh
dXNlIGRldmljZV9zdGF0dXMgaXMganVzdCBhbm90aGVyIHJlZ2lzdGVyIG9mIHRoZSB2aXJ0aW8u
DQo=

