Return-Path: <virtio-dev-return-13797-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8AFC46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:54:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1164F7E98E
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:54:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD51F986427
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:54:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C037C983DFF; Mon, 18 Sep 2023 06:54:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0F0098638E
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 06:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+IBXKHCFnaaAlgXLqR+u9d37Me18QomEuTH0aF1IibPez4nhHJ8qZl59UnF/JZfLGXCfwLA6D3q6TTwMMaRD9fqyqaJ4xaW95Em5Z4zhshLzUreGxyvXoAT9bMLJPuypmM3x2zNZhUgvWHW+VSv0hXcvNCtHT/ON+tZGd1jETw3RffKEJPKmZpTUjntFdLZwqrWzPg5nJFTc/AVDKS3S114Tcu+GhdmHRccjTT3ciyNCKkeDK+2NCNtNN07r6rghd9LtaBYliL73oEZVgtCJoxZrk8wkciR3NYrCdcU/UYTda0jkZlPwZ+/abpTYnCRe/82SgG5+reynw6vVgQKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ0dSWkYBPlNINgTeKj9kimtKcgJwJOIHV25GWUxo/I=;
 b=LF0pp59jFHvKg4gPHktPvy9mvDADY21tKkFmVM4ItxbslFXRlDk2blQ6cJz4JTWEJBPgHdxVxGnGG+veCjVWBqcaOf7lH4fEmbXldO+Xtdt+mfbOd7WbdYq1vTeJjyLVdgBoX/Ww6VMrCUJW3whoVT6ji+u/p5HpRYMxi16G4MMhGdrdNvJKmemc6OuoVRiDoROuKtz7B37Nu+z7UNGwGslXgvPrelH6n5uQAo6ov1PhLg/D22kgmD9x0JFusoEMYpOjI5C87Q2MymNSVQgDQrVx2QwgplwFb4mLCbdCcIIaabl1E2u/deyANQswmDDmGlMtdPaPqQUMRdBmN3b9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmA=
Date: Mon, 18 Sep 2023 06:54:50 +0000
Message-ID:
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
In-Reply-To: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB6891:EE_
x-ms-office365-filtering-correlation-id: 79f21de8-a439-4e7f-ea56-08dbb814279c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WXhZ2YcIJCzybZsKsf1o1hVPtojShqWKQkG559/hncl6xLZRG49YQr1D3t9BEGIqbznanr7DE7q7c7zHjbyUilaL8rOLAmvs1AHitcKRJaLfLbo/okLB2npGP0cIgVk3VVsMQpEf2fP494ho9Wq8RqVh7gNzX1gxMgMIEuzmxGgAcm+Zd3ICw8WZ6dmIzswQ3ERRzlatwH5nG0YccRk3Df33ACWsQtn7FRSWlCYzgPc3aUjwLKFirgSKKRFU7r5SoPg3PF44iDayPvDGbBw+YuzAJ+s5w0kN7zZUjQkMFTZfVOF3l5K8Sd1W0VlgamzXJ+QvOz+MO9r36g0T0OpW+mujZIEFElv7xlNbblPgdQfv+kSOSw3TTUaDYv7T4t4Ex383frfjGCThV0ZABAtb1BY2jHa9M4sG1abwM9aQlYQJycGgk5xHs2Egjhe6jwGr1X1cLbx53VMukVcqBZjquBitG2+aYM8KHJxvnrHlVfHsLaJRnRule38xecLWuCucv1Kwt602QarG1sVR1olJfrHfSP/hyYEt80dUYf9TSkIpdVLSTYqfEbz/DuwE7ExZCX2vqqKcThDlXBxa+On7hplN1kHfOmDitdyv03VLhyXRQqgmFZRpWANBH/Y2j+fP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(38100700002)(38070700005)(122000001)(55016003)(86362001)(33656002)(7696005)(6506007)(52536014)(110136005)(316002)(64756008)(478600001)(5660300002)(66446008)(83380400001)(9686003)(66556008)(66946007)(66476007)(41300700001)(76116006)(2906002)(8676002)(71200400001)(8936002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVFkaTVSbjBuMkN1QUZxdU5aakx1b0dpdHB3SFJnL1BlQzM1WkUraS9hSklD?=
 =?utf-8?B?NE16a2VFdHVVaERFRlJ3Y09vWkFQeGRLdGVPOStKY3JnL3RkSDlaZWppZEhT?=
 =?utf-8?B?c1REOXFubEJjRS9Fc0FqY3RZckFvYzA5K1ZhNng0bGlML1NoYWhBY25hOVNU?=
 =?utf-8?B?cjdkWGkxMk5nRVFEUmQ3eHZHcU1qeERUSll4eUV1Z1cwWW9ZTjFzSmNJbUhw?=
 =?utf-8?B?SmtnUTRhand4bEJSaXVJZ05LcHpnR29HZFpTWkhDT096ZW1pakU2aXFuNEhl?=
 =?utf-8?B?YVNUVXFncndLNi9sMTRRRkxvNG5jaEI1SlRFeGc0dGlJWGN2VTUrenE0Wnhj?=
 =?utf-8?B?L1dLbTE2ekx4cUNpdkJraTZWVHkyRmpNS2VWYkJrdjFSeThvTjJRdGtwMFBv?=
 =?utf-8?B?bHJrc2R2WnlVYWJFcVJuSmtobFk2UzhJZTNJQWtQMVM1Z1RudVRLeWM4NXNU?=
 =?utf-8?B?N2dXKzJ1SC9HRkN2VzdVSUhsTURjT1FleHN0QjlqRFl1UUJVWmhPZjhqeFBX?=
 =?utf-8?B?ZmF6T1lFK0ROb3g2bzdoenJKK3RoM2pnS1hORjJZTlVkaUVrRmhjQkFzWTR1?=
 =?utf-8?B?V3Vwa05pTHhpbVpCQkowQk44cXFmSGs0dVFWL28rMldNYTQ1ZC9CWUFIUmRM?=
 =?utf-8?B?Nzl6cC9UNjdDd0draUNGaEpad3RmYUxRR0c1TEVBSzZzMWFiUHpLNTZja2VB?=
 =?utf-8?B?eHp4OXpseWs1dytNZTZOV2dQbVBwQktteDM2SHcvVEpQOTZPN1NUM2tCc2Ju?=
 =?utf-8?B?dmdibittSWVKSlVMUGg4N3N2bFBTeFVRQkdFbU5udHJqdWpIbjNZT1ZUYzZZ?=
 =?utf-8?B?RThPSFh2OWNQanZQbVNyOFl0VERwQ3JNKzRVVHdnS0lVQk5nTnVUMUNpc0lX?=
 =?utf-8?B?QXhjWnVSVnNDMDY0Tkw5Z0VJL0pGOUZ5V00wU3lKaVFsdHJtK0xXcUp1ejlN?=
 =?utf-8?B?NU5TYTRINXRqSTZTL3lmT1FuWXBZekR5dzYvemZTMmdud09ZSTFtZmd5UFFw?=
 =?utf-8?B?ZnZuVGw4VjJNemp0d3ZhY2xSRGlBTGcrdFJBTkZodlhoTVhaWjhaeWI1cEwv?=
 =?utf-8?B?MGJQb0VKbEZadEhUSjNIMjVkS1R2YUx6WUZOa0FUdnVLQjUxSE11b2xSWEta?=
 =?utf-8?B?V1BmOFRVN3d0R2RCWHNOWVlWOVQwem9mUk1IKzRYQ3dRUUNQT0ttcUdwSUlh?=
 =?utf-8?B?M3F4c2hFN1IvNTkvWG1CU1lodnlFWFpac2d1a2QraXdMVlRZbDlYNXgyTGhl?=
 =?utf-8?B?TytyQUswNTNpaHdnMUsrNlk0ekNPaTdLTWdTR0VWbVVhUGJXOUFKaHBWRjNq?=
 =?utf-8?B?YTd1V3M5Z3ZOUmFyMnFGNlVKVmxMYVFTNXFTWmtIbW12YXpraFRMaCtiektu?=
 =?utf-8?B?YVAzZUNEMStzbzlFMDNlYUJMTUlUbUZ6OGU3elhudzUzRmJWU2tUTVN1TFJi?=
 =?utf-8?B?YjR4VE9KaVg4OUtieXpRcjRTcjczQ3VZSGk2WEJCak0yQzlnTU1ESnNRVWxw?=
 =?utf-8?B?Mmw2bElSL3NCYTE0aUtrUE54SEMyMHpDL1EvaDgwYTZpa2ZYYVZmdVlRTHJ5?=
 =?utf-8?B?aE4weHFJWHF4Uld0RG1CVjNRbVkrZkVhZjRQR1pxUEZrK1NXS2o1dkRhcHRE?=
 =?utf-8?B?a3o2TE54WUFGNm9ZNjBjQTBmK3NhTFRsazlJNy9wdDliaXA4cXlZd2RycVZ0?=
 =?utf-8?B?cmRZVEJ1U3N2R2pQREFrNDlzcGlIUFZ3SXVpQVhUWkJ0RjVRczVOTDdxR2dV?=
 =?utf-8?B?bThRaEdQeDF3c1pLRFZCalZmYmJOVGNESlJSOE1oeFpaazNpTjdLcUx2Nm1x?=
 =?utf-8?B?LzlaRTFiVFVLeTUvMWRnYU9qQm42eTJRRFlmTVdjK2dZNkFFNXNReTlsaU5S?=
 =?utf-8?B?ODlxMS8rTFJUMGpwWVhxK2ZBSEV6am9BdGlNM3FpeUF3U2p3aXhhdXgrYnBQ?=
 =?utf-8?B?dHJCK1A1OXBUVUs3VVZiTEhwYXlWaFpYL09UT05SYzlBWHcyUEM2VXhRTnJi?=
 =?utf-8?B?OTAwUGdTQys2RnFBRW91NDZrYUhYVFRLYm5YTnlPdURCcmdCSENsWmlDdDlp?=
 =?utf-8?B?OURuYVI2eWF6elBPOUxESmtNZTFyN1ZrUlBSZDVaS2QyM2RycitOSm0xUTN0?=
 =?utf-8?Q?lfIQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f21de8-a439-4e7f-ea56-08dbb814279c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:54:50.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z95Zi9mmvSGHxleZKM340OGrqIPWG0lDkfOiHFgzU/krEzyq87FKv6BOgMbyP9agplEz48KxTeT+yEY2iqddHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiBTZW50OiBN
b25kYXksIFNlcHRlbWJlciAxOCwgMjAyMyAxMjoxOSBQTQ0KDQoNCj4gc28gYWRtaW4gdnEgYmFz
ZWQgTE0gc29sdXRpb24gY2FuIGJlIGEgc2lkZSBjaGFubmVsIGF0dGFja2luZyBzdXJmYWNlDQpJ
dCB3aWxsIGJlIHBhcnQgb2YgdGhlIERTTSB3aGVuZXZlciBpdCB3aWxsIGJlIHVzZWQgaW4gZnV0
dXJlLg0KSGVuY2UsIGl0IGlzIG5vdCBhdHRhY2sgc3VyZmFjZS4NCg0KPiA+DQo+ID4+Pj4gRm9y
IHVudHJ1c3RlZCBoeXBlcnZpc29yLCBzYW1lIHNldCBvZiBhdHRhY2sgc3VyZmFjZSBpcyBwcmVz
ZW50DQo+ID4+Pj4gd2l0aA0KPiA+Pj4+IHRyYXArZW11bGF0aW9uLg0KPiA+Pj4+IFNvIGJvdGgg
bWV0aG9kIHNjb3JlIHNhbWUuIEhlbmNlIGl0cyBub3QgcmVsZXZhbnQgcG9pbnQgZm9yIGRpc2N1
c3Npb24uDQo+ID4+PiB0aGlzIGlzIG5vdCBoeXBlcnZpc29yLCBEbyB5b3Ugc2VlIGFueSBtb2Rl
cm4gaHlwZXJ2aXNvciBoYXZlIHRoZXNlDQo+ID4+PiBpc3N1ZXM/DQo+ID4+Pg0KPiA+Pj4gVGhp
cyBpcyBhZG1pbiB2cSBmb3IgTE0gY2FuIGJlIGEgc2lkZSBjaGFubmVsIGF0dGFja2luZyBzdXJm
YWNlLg0KPiA+IEl0IGlzIG5vdC4NCj4gPiBIeXBlcnZpc29yIGlzIHRydXN0ZWQgZW50aXR5Lg0K
PiA+IEZvciB1bnRydXN0ZWQgaHlwZXJ2aXNvciB0aGUgVERJU1AgaXMgdW5pZmllZCBzb2x1dGlv
biBidWlsZCBieSB0aGUgdmFyaW91cw0KPiBpbmR1c3RyeSBib2RpZXMgaW5jbHVkaW5nIERNVEYs
IFBDSSBmb3IgbGFzdCBmZXcgeWVhcnMuDQo+ID4gV2Ugd2FudCB0byB1dGlsaXplIHRoYXQuDQo+
IGZpcnN0LCBURElTUCBpcyBvdXQgb2YgdmlydGlvIHNwZWMuDQpTdXJlLCBoZW5jZSwgdW50cnVz
dGVkIGh5cGVydmlzb3IgYXJlIG91dCBvZiBzY29wZS4NCk90aGVyd2lzZSwgdHJhcCtlbXVsYXRp
b24gaXMgZXF1YWxseSBkZWFkIHdoaWNoIHJlbGllcyBvbiB0aGUgaHlwZXJ2aXNvciB0byBkbyB0
aGluZ3MuDQoNCj4gc2Vjb25kLCBURElTUCBkZXZpY2VzIGNhbiBub3QgYmUgbWlncmF0ZWQgZm9y
IG5vdyB0aGlyZCwgYWRtaW4gdnEgY2FuIGJlIGFuDQo+IHNpZGUgY2hhbm5lbCBhdHRhY2tpbmcg
c3VyZmFjZSBhcyBleHBsYWluZWQgYWJvdmUuDQpXaGVuIFRESVNQIGFyZSBub3QgdXNlZCwgaHlw
ZXJ2aXNvciBpcyB0cnVzdGVkIGVudGl0eSwgcGVyaW9kLg0KQW5kIGhlbmNlLCBpdCBjYW5ub3Qg
YmUgY29uc2lkZXJlZCBhdHRhY2sgc3VyZmFjZS4NCkFuIGh5cGVydmlzb3IgY2FuIGV2ZW4gZGlz
YWJsZSBTUi1JT1YuIA0KDQo+ID4NCj4gPj4+Pj4+ICMzIFRoZXJlIGlzIG5vIFFvUyBpc3N1ZSB3
aXRoIGFkbWluIGNvbW1hbmRzIGFuZCBxdWV1ZXMuIElmIHlvdQ0KPiA+Pj4+Pj4gY2xhaW0gdGhh
dA0KPiA+Pj4+PiB0aGVuIHdob2xlIHZpcnRpbyBzcGVjIGJhc2VkIG9uIHRoZSB2aXJ0cXVldWVz
IGlzIGJyb2tlbi4NCj4gPj4+Pj4+IEFuZCBpdCBpcyBjZXJ0YWlubHkgbm90IHRoZSBjYXNlLg0K
PiA+Pj4+PiBQbGVhc2UgZG8gbm90IGNvbmZ1c2UgdGhlIGNvbmNlcHRzIGFuZCBwdXJwb3NlcyBv
ZiB0aGUgZGF0YSBxdWV1ZXMNCj4gPj4+Pj4gYW5kIGFkbWluIHZxLg0KPiA+Pj4+Pg0KPiA+Pj4+
IEkgYW0gbm90IGNvbmZ1c2VkLg0KPiA+Pj4+IFRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IGEg
cmVnaXN0ZXIgcGxhY2VkIG9uIHRoZSBWRiB3aWxsIGJlDQo+ID4+Pj4gc2VydmljZWQgYnkgdGhl
IGRldmljZSBpbiBleGFjdCBzYW1lIHRpbWUgcmVnYXJkbGVzcyBvZiBWRiBjb3VudCA9DQo+ID4+
Pj4gMSBvciA0MDAwLg0KPiA+Pj4+IFlldCBhZ2FpbiBub3QgcmVsZXZhbnQgY29tcGFyaXNvbi4N
Cj4gPj4+IHBsZWFzZSByZWFkIG15IHByZXZpb3VzIHJlcGxpZXMgaW4gb3RoZXIgdGhyZWFkcy4N
Cj4gPiBJdCBkb2VzIG5vdCBhbnN3ZXIuDQo+ID4gVGhlIGNsYWltIHRoYXQgc29tZWhvdyBhIHBv
bGxpbmcgcmVnaXN0ZXIgZW5zdXJlcyBkb3dudGltZSBndWFyYW50ZWUgZm9yDQo+IHNjYWxlIG9m
IHRob3VzYW5kcyBvZiBtZW1iZXIgZGV2aWNlcyBpcyBzb21lIHNwZWNpZmljIGRldmljZSBpbXBs
ZW1lbnRhdGlvbg0KPiB3aXRob3V0IGV4cGxhbmF0aW9uLg0KPiB0aGUgcmVnaXN0ZXJzIGFuZCB0
aGUgTE0gZmFjaWxpdGllcyBhcmUgcGVyLWRldmljZS4NCj4gPg0KPiA+Pj4+PiBGb3IgZGF0YS1x
dWV1ZXMsIGl0IGNhbiBiZSBzbG93IHdpdGhvdXQgbXEgb3IgcnNzLCB0aGF0IG1lYW5zDQo+ID4+
Pj4+IHBlcmZvcm1hbmNlIG92ZXJoZWFkLCBidXQgY2FuIHdvcmsuDQo+ID4+Pj4gTm8sIGl0IGRv
ZXMgbm90IHdvcmsuIFRoZSBhcHBsaWNhdGlvbiBmYWlsZWQgYmVjYXVzZSBvZiBqaXR0ZXIgaW4N
Cj4gPj4+PiB0aGUgdmlkZW8gYW5kIGF1ZGlvIGR1ZSB0byBtaXNzaW5nIHRoZSBsYXRlbmN5IGJ1
ZGdldC4NCj4gPj4+PiBBIGZpbmFuY2lhbCBhcHBsaWNhdGlvbiBpcyB0ZXJtaW5hdGVkIGR1ZSB0
byB0aW1lb3V0cyBhbmQgcGFja2V0IGxvc3MuDQo+ID4+Pj4NCj4gPj4+PiBEZXZpY2UgbWlncmF0
aW9uIGlzIGp1c3QgYW5vdGhlciAzcmQgc3VjaCBhcHBsaWNhdGlvbnMuDQo+ID4+Pj4NCj4gPj4+
PiBJdHMgYWxzbyBzYW1lLg0KPiA+Pj4+IE15IGxhc3QgcmVwbHkgb24gdGhpcyB2YWd1ZSBhcmd1
bWVudC4NCj4gPj4+IEkgdGhpbmsgdGhlIHBvaW50cyBhcmUgY2xlYXIsIGFuZCB5b3UgYWxyZWFk
eSB1bmRlcnN0YW5kIHRoZSBwb2ludHMsDQo+ID4+PiBzbyBubyBuZWVkIHRvIGFyZ3VlIGFueW1v
cmUNCj4gPiBZZXMsIEkgYW0gY2xlYXIgZnJvbSBsb25nIHRpbWUsIG5vciBBUSBub3Igbm8gcmVn
aXN0ZXIsIFJTUyBxdWV1ZXMsIG5vbmUNCj4gY2Fubm90IGd1YXJhbnRlZSBhbnkgcGVyZm9ybWFu
Y2UgY2hhcmFjdGVyaXN0aWNzLg0KPiA+IEl0IGlzIHByZXR0eSBjbGVhciB0byBtZS4NCj4gPiBB
bnkgcGVyZm9ybWFuY2UgZ3VhcmFudGVlcyBhcmUgZXhwbGljaXRseSByZXF1ZXN0ZWQgd2hlbiBk
ZXNpcmVkLg0KPiA+DQo+ID4+Pj4+IEZvciBhZG1pbiB2cSwgaWYgaXQgZG9uJ3QgbWVldCBRT1Mg
cmVxdWlyZW1lbnRzLCBpdCBmYWlscyB0bw0KPiA+Pj4+PiBtaWdyYXRlIGd1ZXN0cy4NCj4gPj4+
Pj4NCj4gPj4+Pj4gSSBoYXZlIHJlcGxpZWQgdG8gdGhlIHNhbWUgcXVlc3Rpb24gc28gbWFueSB0
aW1lcywgYW5kIHRoaXMgaXMgdGhlDQo+ID4+Pj4+IGxhc3QgdGltZS4NCj4gPj4+PiBJIGFsc28g
cmVwbGllZCBtYW55IHRpbWVzIHRoYXQgUW9TIGFyZ3VtZW50IGlzIG5vdCB2YWxpZCBhbnltb3Jl
Lg0KPiA+Pj4+IFNhbWUgY2FuIGhhcHBlbiB3aXRoIHJlZ2lzdGVycyB3cml0ZXMuDQo+ID4+Pj4g
UGVyZiBjaGFyYWN0ZXJpc3RpY3MgZm9yIDMwKyBkZXZpY2VzIGlzIG5vdCBpbiB0aGUgdmlydGlv
IHNwZWMuIEl0DQo+ID4+Pj4gaXMgaW1wbGVtZW50YXRpb24gZGV0YWlscy4NCj4gPj4+IGFzIHJl
cGxpZWQgbWFueSB0aW1lcywgcmVnaXN0ZXJzIG9ubHkgc2VydmUgdGhlIGRldmljZSBpdHNlbGYg
YW5kDQo+ID4+PiByZWdpc3RlcnMgYXJlIG5vdCBEQVRBIFBBVEgsIG1lYW5zIHRoZSBkZXZpY2Ug
ZG9uJ3QgdHJhbnNmZXIgZGF0YQ0KPiA+Pj4gdGhyb3VnaCByZWdpc3RlcnMuDQo+ID4gSXQgZG9l
cyBub3QgbWF0dGVyIGRhdGEgcGF0aCBvciBjb250cm9sIHBhdGgsIHRoZSBmYWN0IGlzIGl0IGRv
d250aW1lIGFzc3VyYW5jZQ0KPiBjYW5ub3QgYmUgZ3VhcmFudGVlZCBieSByZWdpc3RlciBpbnRl
cmZhY2UgZGVzaWduLCBpdCBpcyB0aGUgaW1wbGVtZW50YXRpb24NCj4gZGV0YWlscy4NCj4gPiBB
bmQgc28gZG9lcyBmb3IgYWRtaW4gY29tbWFuZHMgYW5kL29yIEFRLg0KPiB0aGUgcmVnaXN0ZXJz
IGRvIG5vdCBwZXJmb3JtIGFueSBkYXRhIHRyYW5zaXRpb25zLCBlLmcuLCB3ZSBkb24ndCBtaWdy
YXRlIGRpcnR5DQo+IHBhZ2VzIHRocm91Z2ggcmVnaXN0ZXJzLg0KPiBCdXQgeW91IGRvIHRoZXNl
IGJ5IGFkbWluIHZxDQpTbyB3aGF0Pw0KSnVzdCBiZWNhdXNlIGRhdGEgdHJhbnNmZXIgaXMgbm90
IGRvbmUsIGl0IGRvZXMgbm90IG1lYW4gdGhhdCB0aG91c2FuZHMgb2YgcG9sbGluZyByZWdpc3Rl
ciB3cml0ZXMgY29tcGxldGUgaW4gc3RpcHVsYXRlZCB0aW1lLg0K

