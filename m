Return-Path: <virtio-dev-return-13190-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AD0EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:42:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BE4462A8E3
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:42:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6D9D9866F8
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:42:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB28C9865E9; Fri, 30 Jun 2023 11:42:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94DF19866EC;
	Fri, 30 Jun 2023 11:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6LdukKcU9pUvfZR5FDx7goSYs7NwN9mKIb/hUxUM33x7Cu+uHPOruDhhapmMlvKpM5nh2YSUoQLb6/9ybgh/wEgbY+8/rkFKCmGQwp3Cmfke1KbXdpcCkNX0O5wbte8QIQqh66jr+x9lg+LEhUGbcwKoaoRvz9RGNUP10Jjeiop1OP2R8oxHSTaZGU4zJCmh7p6DojbsQJrfdCkeyIrT1Ldje+RItVVDeUn8PYMz99rRnE4CxgJ1HhYz1x3JX6Ri7sy9NV3nKNjvMTXObxXqaTzU7oOTgUUFYh+TjwDskadk6VoGiDyYHPgGJKkLys5kXYrVnDI1mte2l4zWKN7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MMX12mjEdYn1UiWswyixJ0P4K+j7OHzPrjHXSmykew=;
 b=fYoFQScTkp7zC4rmImhu4s3yjhK7nnaCX94U153WDaqKzYf8+TtWE2oXk2ppUrysOf/ZYein1AjlQbJBUhaIzkOvh51idhEkxmvwSVmf72fk7QUYc/WOW35QfLMuTE0wfzbraNTwQ2xDn/uijJ/B3Fp5CHb+USaT72z+zuuD2wpcymWKa7LXxM964hy+eaUYANRqD6AwmjqvahVBaQaCdoEOLCmWA/DvfycUVNk3kD0O4JCpzOdRs+IRz9JYev/oIZW+01KQ4oA2b954X/d/EOcE2Nh0kQXa7p2YNH961GFYALkmTXONzbT+pquxaWUTLf1SwTZyMfCPsDLRLJ2kEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] Re: [PATCH v19] virtio-net: support inner header
 hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAABaNgIAAnu/AgADMRwCAAh6S4A==
Date: Fri, 30 Jun 2023 11:42:46 +0000
Message-ID:
 <PH0PR12MB5481D58281F6FB5B67B1F53DDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtgomh1EGNLqhXQssRW02nnHkamxT5rV5eZZ9BZFH=uJA@mail.gmail.com>
 <PH0PR12MB548102A43104218F481B8679DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsk-eH19bdBgMvxrX-xqpOX=RELv-BadZdGq+K0_6xh+A@mail.gmail.com>
In-Reply-To:
 <CACGkMEsk-eH19bdBgMvxrX-xqpOX=RELv-BadZdGq+K0_6xh+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7279:EE_
x-ms-office365-filtering-correlation-id: 9f9e1a47-0d7b-429c-81c4-08db795f1fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sS6W1b8LH3HY+wEX9MewzQNIytJdya2h2zGfWN4KMoirVag3uAT/JVHHM/IEakGGQPs44gJd+QU377E6RLwrMhu9eCZphbhFlnCeQKgM24MQrlqKtlg+x5P5k+USciL+0dWiwxbCKWd17fbRTkH3H6Tt4kVd11gatu/LTasxtfhS/U5UU/uAKLH7Be5jnaGeynWJs9x26GogWN4h7F+/Xse6fPGNyy8xXMHgq/NirNiJHFfTZ8IxoUrxOW9CoMcohvSjiGvygebBrP+EVfMJOfi5odnYOIvHYKl2xUMf5jf8QFv2SprWMwce6vt6Accxpb5JC2HiL1Gal+FuQYqhKjHSJuZqCpt7HzeA3d/gNWIv2M807EG4ETM3J0q0IuTJWEqQtHeOtTNrZE8O1hEXXDpJ8ezcbMOaweNm2kxXpHkmxR3LRhImhJO1fT5CD+cKGo8yE3dfozer2367LLgv79GmhFQxNGOxsoUeHTEPaQ0DCgCV3WIZpgqVGNCDErWxDg1GRs0ISiSSQhoGqespffyq/8xO2S0tw96m7yySqFQnTupXteOJAtLu96P2aLbT8owD9LZHrVfLq6Yz3slXJ2ifvJJ9c/2BkelZC2A9yvPjDX03oWUAqZSEciL8pRu2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(66476007)(8936002)(64756008)(122000001)(52536014)(76116006)(86362001)(38100700002)(6916009)(41300700001)(8676002)(4326008)(316002)(66556008)(55016003)(66946007)(38070700005)(5660300002)(33656002)(26005)(186003)(7696005)(6506007)(66446008)(2906002)(9686003)(478600001)(54906003)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjJkTVQwU2wxTVgvNHlsMVVadnVUcDNnUEZqWmhlZ2wyc1FTMkM1RHUxQXJm?=
 =?utf-8?B?ZDZMOEs3QkhhNlVQZHpxdEVSWFRWSjBBc0VBN3l5TXR2ZFFoeHg5NGxYdk95?=
 =?utf-8?B?TjhoVVBiMXIzT2U3aFJsUzZ1TkRpMEJFVjEwYVNqQUJaSFRnR2RRbWE3OFNM?=
 =?utf-8?B?MDdiUEJQNFVydWtycVdwTzdZQnhRR3NMcENaZXpCb2tXZ3ExSE1MV1FteGE5?=
 =?utf-8?B?QUprUmxLR1JuejhFZmhMTkRXM0JRY051QjBCbC9reTQ3OXpoWUF4dTNHdHNY?=
 =?utf-8?B?aVF1cnF5WCt5SW43QmJScXJTL3Z1MkZ0VUNhSzU3dmN0NkQrZktPWDF0bzFM?=
 =?utf-8?B?VjVXdGJvaHB2NjRFcG8zaGVTM1ZWVzR0OU5ucXlHaUZTQm8yZEdPeTVCMTRy?=
 =?utf-8?B?MWplTHdnblRlU1hKbURoam02MHNHTm9wd21XZ0JVcjJzVjdwV2Zaam1qVU9I?=
 =?utf-8?B?eFQ3L21WU2llRi9lTUdzSlI0QmNnL3BNdU9ra28rOXBzbnp3Nk9HTWdNeGJL?=
 =?utf-8?B?L0dIMHBuMVVUT3Nyc1NaWk5USXhKWHlGRzNwMDF5TUNmT3RoajZoTktoN2tw?=
 =?utf-8?B?bjJhb3hBNTQyZ2toeS9KSjAxbUVHWkZKWHZpTGYyZnQ3SDlLbkdYNXRZRWRk?=
 =?utf-8?B?TWYyZVNoSzRsNU5TRWhsMTB4Y3hhK1pVd2crOXk0aXIwUUhKMlNwUVBWTE1O?=
 =?utf-8?B?a3RGSW1sNWNTODFPakVFMXlDeFRSYitGeDZYa2xWL28vQ09HZnBuM01YWkpH?=
 =?utf-8?B?MVRLMG1zTTFMN0MzNlJUMUxVazB4aC9paVFmU3FUeE1wRjdjMHRsdm5BTjZU?=
 =?utf-8?B?em1JeWdMU2NmaGtLT3RaMzlWc3J2MTBoUnNXQWtVTlNBNlRnYUtVMXhLRTVk?=
 =?utf-8?B?Z0ZnY2FkWWNzVThPemp4dFQ2bHh4MmU4OC9oamttRllwekhWRnRoN0Q5dnNR?=
 =?utf-8?B?QU04aEVrZEtrcjAyVzVzdENVanZ4R3ExNFByT0NwNTZqMW5Xd0UrTTU2eFBx?=
 =?utf-8?B?QkNsOVkxa21HbGRxZS9pNnVBR1k2MXdVK25TNjYvMUVZN1R0Yk9wamZkYnpN?=
 =?utf-8?B?WC8vcjJzejVueWtBd3Q5cmtDenVMWFlIaUtkWjNnaTkrZDQzQXl0RXBkclM3?=
 =?utf-8?B?OWQwa3dLYlBHL1BEdnJ2dCttZVUvMHpwQlc1aDcvdWtvdXFnK2JicWtNYXls?=
 =?utf-8?B?aUJvc1VkMVFhUmZPVVhnYm1MUEprTTRBSnlHc3JsSjVFbENySzljd2RkMUNX?=
 =?utf-8?B?dklNdVE3M3FXWEU0ejRNUFAwMTRsT2hvVWwwRGQ3NDVta3BzUkFLVnE2cGkr?=
 =?utf-8?B?WitrK2FvR0wxaythOFh1T0FtYk5BRkNiOU56Z1loSDRiR1NpSUVvdHJnZkhT?=
 =?utf-8?B?QzY2dEY4Mzg0c3V5TU1NelJtNTB6ZXgzQTFTTERuZzN3b216Sk1ONUNaN2xs?=
 =?utf-8?B?bE5XWGF6ZmUzVVpNMkFTMy82WGcwcWxWbjRzcyt4R2NBczlSSUdKSmthRVpC?=
 =?utf-8?B?VjBIMzhyTDI2eDBhM2dIUXRyclNRelZVUzhLZFB5TUpQNHFnK3l1S0dYTTJh?=
 =?utf-8?B?amx3RHE2REZsMklIMWVyeW9ROEdoemNjNDU1VGtwV1BKK2ZBRzZ3WmFRVzYv?=
 =?utf-8?B?VUFJVDk0a1FEUFhiV01mYWNlQUdYK3U5SkFSZ2Y0MXhlZWw4MWRRK1A3Z05E?=
 =?utf-8?B?a1o5dTBPNmo2aXV2VFBSenJHRFY4MXBPMnNwOHFCRkY3NHlCZU9aTWtoNHJX?=
 =?utf-8?B?cTJxL3lnMnZRMmZkOFcxaTZjRWNyTjQyak00NkdBVmtFL1VUV2NuSHM4ZDd0?=
 =?utf-8?B?V29SYWJiN0g3RW1mY3NjRTZ5RXgxc3BQdExnbjdlUmYyS3ZLWnRxaHVuKy9o?=
 =?utf-8?B?RnNIVG54VjZPS29qQTdkTG52cXFoUmJrYk1XWHVUYVBSd0dpVWVXZm94dkdw?=
 =?utf-8?B?Q3R3OW5iRXpFTURYOWU5Ui8vc0hra2VHRGNBMnBYN3o3eEJpQ2RqbklyTFNH?=
 =?utf-8?B?K3JNNmZSOUFSTDJzeURUTWtyOWkwb0QwRjhBUHpLeXc2Mkd4ZGMvRXlPSWhw?=
 =?utf-8?B?c3M2dStGWDNEZ1NRcXJVYnVYN2hYU2M3WkNtSzFCTjJoOVFEV0h5a3lLZTY3?=
 =?utf-8?Q?JJcU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9e1a47-0d7b-429c-81c4-08db795f1fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 11:42:46.6158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyR5UZQaIwMGCEjvCn8Ap7aRYLRN8OcsfK+ZtsyxvnBvYwKomrdxM1Qssf2ba0Ut9KjhmKRirvEtlsOJGWV3TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
Subject: RE: [virtio-dev] Re: [PATCH v19] virtio-net: support inner header
 hash

DQoNCj4gRnJvbTogdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvLWRldkBs
aXN0cy5vYXNpcy1vcGVuLm9yZz4gT24NCj4gQmVoYWxmIE9mIEphc29uIFdhbmcNCj4gU2VudDog
V2VkbmVzZGF5LCBKdW5lIDI4LCAyMDIzIDExOjE4IFBNDQo+IA0KPiBJdCdzIG5vdCB0aGUgZmF1
bHQgb2YgY29uZmlnIHNwYWNlIGl0c2VsZiwgYnV0IHRoZSB3YXkgdG8gYWNjZXNzIHRoZSBjb25m
aWcgc3BhY2UsDQo+IG1vcmUgYmVsb3cuDQo+DQpTdXJlIGFuZCBpdCBpcyBsaW5rZWQgdG8gb2xk
IGFuZCBuZXcgZW50cmllcyBpbnRvIGl0LiBJIGV4cGxhaW5lZCBpbiB0aGlzIHRocmVhZCB3aXRo
IGRpc2N1c3Npb24gd2l0aCBNaWNoYWVsLg0KUGxlYXNlIHJlZmVyIGl0Lg0KIA0KPiA+DQo+ID4g
PiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgew0KPiA+ID4gICAgICAgICB1OCBtYWNbNl07DQo+
ID4gPiAgICAgICAgIGxlMTYgc3RhdHVzOw0KPiA+ID4gICAgICAgICBsZTE2IG1heF92aXJ0cXVl
dWVfcGFpcnM7DQo+ID4gPiAgICAgICAgIGxlMTYgbXR1Ow0KPiA+ID4gICAgICAgICBsZTMyIHNw
ZWVkOw0KPiA+ID4gICAgICAgICB1OCBkdXBsZXg7DQo+ID4gPiAgICAgICAgIHU4IHJzc19tYXhf
a2V5X3NpemU7DQo+ID4gPiAgICAgICAgIGxlMTYgcnNzX21heF9pbmRpcmVjdGlvbl90YWJsZV9s
ZW5ndGg7DQo+ID4gPiAgICAgICAgIGxlMzIgc3VwcG9ydGVkX2hhc2hfdHlwZXM7DQo+ID4gPiB9
Ow0KPiA+ID4NCj4gPiA+IFdoaWNoIG9mIHRoZSBhYm92ZSBkbyB5b3UgdGhpbmsgY2FuIGJlIGFj
Y2Vzc2VkIGZyZXF1ZW50bHkgYW5kIHdoaWNoDQo+ID4gPiBwYXJ0IG9mIHRoZSBzcGVjIHNheXMg
aXQgbXVzdCBiZSBzdG9yZWQgaW4gdGhlIG9uY2hpcCBhcmVhPw0KPiA+ID4NCj4gPiBNb3N0IGFy
ZSBub3QgYWNjZXNzZWQgZnJlcXVlbnRseS4NCj4gPiBUaGUgZmFjdCB0aGF0IHRoZXkgYXJlIGlu
IE1NSU8gYSBkZXZpY2UgbmVlZHMgdG8gcGxhY2UgaW4gYSBtZW1vcnkgd2l0aCB0aWdodA0KPiBs
YXRlbmN5IGJ1ZGdldC4NCj4gDQo+IFRoaXMgcmVhbGx5IGRlcGVuZHMgb24gdGhlIGltcGxlbWVu
dGF0aW9uIGFuZCB2ZW5kb3IgYXJjaGl0ZWN0dXJlcy4NCj4gRm9yIGV4YW1wbGUsDQo+IA0KPiAx
KSBNU0kgQkFSIG1pZ2h0IHJlcXVpcmUgbXVjaCBtb3JlIHJlc291cmNlcyB0aGFuIGEgc2ltcGxl
IGRldmljZQ0KPiBjb25maWd1cmF0aW9uIHNwYWNlDQpTdXJlLCB0aGF0IGlzIGFsc28gZ2V0dGlu
ZyBzb2x2ZWQgaW4gcGFyYWxsZWwgb3V0c2lkZSBvZiB2aXJ0aW8gc3BlYy4NClNvIE1TSSBCQVIg
c2F2aW5nIGlzIG5vdCByZXBsYWNlbWVudCwgaXQgaXMgZGlmZmVyZW50IGFyZWEgdGhhdCBpcyBn
ZXR0aW5nIG9wdGltaXplZC4NCg0KPiAyKSBJIHdhcyB0b2xkIG15IHNvbWUgdmVuZG9ycyB0aGF0
IHRoZSB2aXJ0cXVldWUgaXMgbXVjaCBtb3JlIHZhbHVhYmxlIHRoYW4NCj4gTU1JTw0KTm90IHN1
cmUgSSB1bmRlcnN0YW5kICJ2YWx1YWJsZSIuDQoNCj4gMykgV2UgY2FuIGludHJvZHVjZSBuZXcg
d2F5cyB0byBhY2Nlc3MgdGhlIGRldmljZSBjb25maWd1cmF0aW9uIHNwYWNlDQo+DQpZZXMsIG5l
dyB3YXkgZm9yIGV4aXN0aW5nIGNvbmZpZyBzcGFjZSBhbmQgZXh0ZW5kZWQgKG5ldyBmaWVsZHMp
IG9mIGNvbmZpZyBzcGFjZS4NCkkgZXhwbGFpbmVkIHRoZSByZWFzb24gdG8gZGlmZmVyZW50aWF0
ZSB0aGlzIGZldyB0aW1lcyBpbiB0aHJlYWQgdG8gTWljaGFlbCwgc28gSSB3aWxsIG9taXQgcmVw
ZWF0aW5nIGhlcmUuDQogDQo+ID4gU3BlYyBpcyBub3QgZ29pbmcgdG8gdGFsayBvbiBvbmNoaXAg
YXJlYSwgaXQgaXMgdGhlIHJlZmxlY3Rpb24gb2Ygc3BlYyB0aGF0IGZvcmNlcw0KPiBjZXJ0YWlu
IGluZWZmaWNpZW50IGltcGxlbWVudGF0aW9uIC4NCj4gDQo+IEV4YWN0bHksIGl0J3MgaW1wbGVt
ZW50YXRpb24gc3BlY2lmaWMsIHNvIGNvbmZpZyBzcGFjZSBpcyBmaW5lLCB3ZSBqdXN0IG5lZWQg
dG8NCj4gaW52ZW50IG5ldyBtZXRob2RzIHRvIGFjY2VzcyB0aGVtIHRoYXQgZml0IGZvciB5b3Vy
IGhhcmR3YXJlLg0KDQpZZXMuIExldHMgd29yayBvbiBpdCBpbiB0aGUgbmV3IHRocmVhZC4NCg==

