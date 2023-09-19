Return-Path: <virtio-dev-return-13828-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F170CD54A9
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 09:09:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D711EC6230
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 09:09:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAE7598651F
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 09:09:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 93049983E25; Tue, 19 Sep 2023 09:09:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81CDD9864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 09:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2MIWRTuCmr7E+FIJ2oRDfILhVuMIGCkwU6Qj7cjgJfOHRpFgJxYxQ7ZBE0RJ7wfE3xYQIJsZl0GpzoZgEtWMwtSsRb6sQUpjGuy5AYVm3RPL393uWuIrdkEiuwDdCfiZDtoSi3xR1+PIV2ND+XeciXJNwKZzc4XagBJuGz8LwZJ+cWFT1ldO0kiFCq2tsqcB8Salf5pGnR5vefQeVSfwpjULhz/aoTfksR6g6dkgkuOUqi55p2hWvxIg5TYsEXb2FWKBTxE7ESLUV29Cm8uJ3VZmwv+0sLy6M40qsWvBq+vwSHgpoydZFjipqE0MbaM/PiXFCUj6909qMov5Z1qQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNUiJhXNJ2skueEUNp8fpA0F/zOG1aOXBoWEldN6y24=;
 b=OXzSLY/f55oz8d5HuKtvxDHOzJnq9R6fkUNYSJBWUqF7ItKgkCEOS+8mNLs9yhLVe+PA8RjV6RH7E/7lpuRpFg1dymPfX90t87Y7qQJ5FNOGFOXt4M+1Qqxl3O85IBpN8FdB0DBnSliD999IDaWhjxuI5T0camkPQhL60YmskXYPqhu7oloOsxMZLD6tHPj7NBRnei+fS9zHXCdkxrJmsoHkN+iPsZZsLV/JAmhURwFXhIxElQGPoFLxoy7zfqBu3t8/RJkY+V6mGpnNj2IIzeGrs1heptGwnAXm5Gc05EDTgB5J79L33Ezqlz4QQBOmfnkreljL/eWRgQealKj1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAWpyAIAAEyeQgAAkaoCAAAFRwIAAA4eAgAAHBjCAAALqgIAACEUQ
Date: Tue, 19 Sep 2023 09:09:28 +0000
Message-ID:
 <PH0PR12MB5481AB79F0D8E418F2845224DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
 <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <474be878-333b-7c80-f116-28b90a3eca4d@intel.com>
 <PH0PR12MB5481236F275C1A0314D85FCFDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6b1b7993-08bc-f2a8-4cd9-92301372373a@intel.com>
 <PH0PR12MB5481B11949AFD1415AF4F267DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d3a707f1-22bc-1886-92d3-4240bc648cff@intel.com>
In-Reply-To: <d3a707f1-22bc-1886-92d3-4240bc648cff@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7024:EE_
x-ms-office365-filtering-correlation-id: 69632e87-5441-4609-0751-08dbb8f020fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xkJFhzkd9ecV17C1zjjA5ymSiMjOWMKObZ/uHDD5rCCj2Y9oC3i8Nz2qktU4m4DXGRdysHxzt3juz60mp8EpJ1O3I4ap5Lq9jdYo8MBo4y0aCi14xBn7oDtlSSz1a64cQ/zXQKVxl2lE3npKe/qoD1t/SK9KOfdIJC0fuZIDpC7p+tV+hFMpVOaiDrLHCFeRR8tl100fw3LpdccPjpGkSX1FYO/kvpLHX1QbgLHTjTUdHNCvc/tUwbrbLsf/9sfrcQEIqzrkO5/3rfkAwk1ZODwWfqWLYotmdqIK9fULuIFGChfgPbKONVd7zZW7tXort4DXdjaB4jMjmN/8rwM275Nq6uZXPxVjNLPiVtavUuRR9SeyfBjFdCnF3jT+X+wLTU+H8s20jGgRCcwTJlRtz7OdkKM/e6AFNWtCp3BjMc2ZBeXcz2G/wF9Ekx6+6AYBFSyvkiLdLnPTMnVkv9v2rFozvNE31cg9ZDmdC5ctoLtKRIoTaTyWRwq8XGdDTesqymqhSjPid57lVdej2Kl/x6eM7lmgQhBBhu4lU5vS94lBllyD89GHgZw+QwzokJCyndNSbcI3oopaCVL71kSHtYq+rlNc3Hjq6jNzZNYzvFI2DhCWd+3BlYCCqvVWYX7v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(2906002)(5660300002)(52536014)(4326008)(8676002)(8936002)(41300700001)(316002)(54906003)(76116006)(66446008)(26005)(66946007)(110136005)(66556008)(66476007)(64756008)(478600001)(53546011)(55236004)(7696005)(71200400001)(9686003)(6506007)(55016003)(122000001)(33656002)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXIyb29acFpUVzN1cHdjZzV6Zi9YSUwyNUFKelR4Mzh4ZGpVS25sNU5TdU1S?=
 =?utf-8?B?OHExZGR6WnVwK1I1anozMHNGSzh2YThYWGwyaThYNnpSSUt3S1F4dlVSTXZj?=
 =?utf-8?B?WmxtQXBLaW1GbHpUeUNMK0hjYXFtQUt6KzNidy92VCs2SFJnNlFTdmp3dGY3?=
 =?utf-8?B?MmZPRW92bUV0eDlWblFlYWVwSDlaY3ZRbmFyREFaeHFleGhDZWRzcTVKWUQ1?=
 =?utf-8?B?akI5QldJRCtvZnFjN0MyaHRlZmI1Qm5XNFZsK2h6ZUJONG55ZGhkSXowUy9r?=
 =?utf-8?B?WGhGeGVVempTc0lkclpvYU81bnIrcTNvY2pSRkN2YlIxRXJ0UWJndmhNZmlB?=
 =?utf-8?B?QkVxWm9hNXhqQ3IrV0g2NjFXNnBKZzhJT2Q5eEZ1S1VwM2FvTlU3c2xWRk50?=
 =?utf-8?B?M0V5RVM0cmlneVIyVXRxVDR2Wlc4Sm90YlU2RTRuZCtZL2k3eGQxUTcvWXdt?=
 =?utf-8?B?RVN6YXVPdjN3SXhLTXZqVis5WENnNldlVTJpL3c2V25SRGtCRXJibjc5MUpN?=
 =?utf-8?B?OExkZzJmSmpWSFUweGVxZHVnd2JEUGQ2UisvU1ZBZVZsUVoxZzM0R05Zb2tt?=
 =?utf-8?B?Mi8zU2xtMFR4S1MwaW15N0JDcUZ4Z2czYUJ5M1VNbEJ4RjJtQjRlTDFCZTZv?=
 =?utf-8?B?dUx2ZEtod0hmRmI3emdOWHYvOW5MYk54Kysxc2VDYXhteTR0ZW0wK2o5WXNO?=
 =?utf-8?B?LzJrWUFpNGRJVmRVNWl4dkFaaGRMOG9KMXF4TzRvUXREV2NUWmRHVGEvUWVo?=
 =?utf-8?B?ZDNFZ2huVDNVd0J5WVpXSVAxWWZ0SnM4aEZ0Nmc0RzlaRy9lYXB6VEFYVHNJ?=
 =?utf-8?B?OHlGejFaeUo1NHFiMjNKODd5WXpwRWs5bmkvaXpXNGsvaTBDWUZ1TkxLQlQ3?=
 =?utf-8?B?R1JVekYybnVZUWJlYkp5Si9jRTZiVENUY3ZJUWVUck5JQ0k1ZG52RzF1WGds?=
 =?utf-8?B?Z2l1OVRUQno1VzZkdmVRSXJSdnAzN2VRNmhnTTF2VDdJSCtLbEc4K2p6cEZk?=
 =?utf-8?B?ZXRDOThzMWVwMTNuNjlmbEZheFlRa3hGMFZzUmlFK0xib3lkNjh2VGlFcUJ5?=
 =?utf-8?B?UTFYcFc1QVNiTzJwY3Vqd0trU1BGT3NNOEEvT2N0NTFqdi95WTZkYlEvNHg0?=
 =?utf-8?B?M2lXSWdWQ2ZJc3ZDNzR4aVZUK3g5ejRRbHBIYVNVamJVcFZ0MDlmN1RId0xR?=
 =?utf-8?B?cFpGWjdJMmRPVVlZSnRWclpMQ1VqZmNvbHVkTytZbUZxYktuSFVhZllRQ2dl?=
 =?utf-8?B?ZmNxYUx5SGFFT1RnZzU3NnVIMWEyS0lLWVhaaEdtOXJEQm5sQ29PSUk2Nzhr?=
 =?utf-8?B?REN6RzdUOS8vWENkMHlJdFN3YmNkem9HZFFzV2gxVUkySVZiMm5GVGFmZWp4?=
 =?utf-8?B?dzZ1RkQwNm1zUzM3UUNhNHFFZVF6NnRLemtyVmtKZ0pYWG5HazZnNUZzVktQ?=
 =?utf-8?B?NjA1a3NIZGgvcFNPeWgraGlENnRvRUcwK2ZGVTN5ZnZLUFhudE1oc2xrRkZC?=
 =?utf-8?B?RXdmTVBUUWNKNGhMcjI3c1A5dWVYQkNrNGhPakJVK3JOWkFkTWtIY0psWHNx?=
 =?utf-8?B?QUx1c0ZMTkZmeVJZa01tcUxtVlJvQ0REeW90MGJmUGJlWTZ2SjlXY0poem9o?=
 =?utf-8?B?eFdQYStRNFF5RTg0L2M3NW9rcXIyaVoycFBZeHpQTm9qZ3d3RUl3UWI2dmNO?=
 =?utf-8?B?bDVpM2FzdGZzYUNWNU5FRWhyVStEaVhibEFmazlqemgwb1gxdVFaYVJMUndn?=
 =?utf-8?B?M05qZkZleHlIZ24vZGtaNkFMTXRYYkJTU1g3ZWYrNFB2aHB5cjQrd2ZvNWt5?=
 =?utf-8?B?UU8xMU9uZmhIaTBmTnBRWjRoOGpHMWlTeDBMWmFkWTMvd1FIcE13ZHBOWjRy?=
 =?utf-8?B?Um1SQnJpRnI1MlYzbXA2bmRheHdyeTh2UEU3eUdJem90Mis0S2pXWWdVRlBZ?=
 =?utf-8?B?bXJIZ3JDUVZqb1RWMVJydC9FRGYyUlVJNkhCTFVuOEZlMjVtNVpvalJUVjlN?=
 =?utf-8?B?V0R1OEpzalU4VDhjYnM0V3RLRGhZQkQ1cjZDZFN5QVZJMW9JeEY3ZC8xaFVH?=
 =?utf-8?B?YTdQbCtCWFpOQkJ3SzRSUmt5QzF2bDc1Q0JYbU0zaGt1cDFsN0NxakhGYm51?=
 =?utf-8?Q?0pZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69632e87-5441-4609-0751-08dbb8f020fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 09:09:28.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgEtD/l6iU7hyMQ8rVIl65dUbggSttSk8MNCOs+LRPPkyaujevL77oaQWTwUMZnibAawx8CSXwdsWgDMxo/ImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjMgMjowOSBQTQ0KPiANCj4gT24gOS8xOS8yMDIzIDQ6
MzEgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE5LCAy
MDIzIDE6MzQgUE0NCj4gPj4+IEluIHlvdXIgcHJldmlvdXMgZW1haWwgeW91IHdyb3RlLA0KPiA+
Pj4NCj4gPj4+IDEuICJzbyBsZXRzIGZvY3VzIG9uIExNIHRvcGljLCBvdGhlciB0aGFuIGNvbmZp
ZGVudGlhbCBjb21wdXRpbmcuIg0KPiA+Pj4gMi4gImFnYWluLCBURElTUCBpcyBvdXQgb2Ygc3Bl
YyBhbmQgVERJU1AgZGV2aWNlcyBhcmUgbm90IG1pZ3JhdGFibGUuIg0KPiA+Pj4NCj4gPj4+ICAg
RnJvbSBhYm92ZSB0d28gY29tbWVudHMgZnJvbSB5b3UgSSB1bmRlcnN0b29kIGl0IHRoYXQgd2F5
LCB5b3UNCj4gPj4+IHdhbnQgdG8NCj4gPj4gZm9jdXMgbm93IG9uIHRoZSBMTSBfb3RoZXJfdGhh
bl8gQ0MuDQo+ID4+PiBIb3cgdG8gcmVhZCBpdCBkaWZmZXJlbnRseT8NCj4gPj4gWW91IHNhaWQ6
IkxpbmdzaGFuIHdhbnRlZCB0byB0YWtlIHRoaXMgVERJU1AgZXh0ZW5zaW9uIGluIGZ1dHVyZS4i
DQo+ID4+DQo+ID4gQmFzZWQgb24gYWJvdmUgdHdvIGNvbW1lbnRzIGZyb20geW91IHRoaXMgaXMg
d2hhdCBJIHVuZGVyc3RhbmQuDQo+IEkgYW0gbm90IGEgbmF0aXZlIHNwZWFrZXIsIGJ1dCBkbyB5
b3Ugc2VlIEkgZXZlciBtZW50aW9uZWQgdGhhdCBJIHdhbnQgdG8gdGFrZQ0KPiBURElTUCBpbiBm
dXR1cmU/IEFueSB2ZXJicyBJIHVzZWQ/DQo+ID4+IEhvdyBkbyB5b3UgY29uY2x1ZGUgdGhpcyBz
dGF0ZW1lbnQ/IERpZCBJIGV2ZXIgc2FpZCBJIHdhbnQgdG8gdGFrZQ0KPiA+PiBURElTUCBleHRl
bnNpb24gaW4gZnV0dXJlPw0KPiA+IENDIGFuZCBURElTUCBnb2VzIGhhbmQgaW4gaGFuZC4NCj4g
Pg0KPiA+IFNvIHlvdSB3YW50IHRvIGNvbnNpZGVyIFRESVNQIGV4dGVuc2lvbiBub3cgKGFuZCBu
b3QgaW4gZnV0dXJlKT8NCj4gQXMgSSBzYWlkIGJlZm9yZSwgQ0MgYW5kIFRESVNQIGlzIG91dCBv
ZiBzcGVjLCB0aGF0IG1lYW5zIHdlIHNob3VsZCBpZ25vcmUgdGhlbQ0KPiBmb3Igbm93Lg0KPiBB
bmQgSSBkb24ndCBwbGFuIHRvIHRha2UgVERJU1AgaW4gZnV0dXJlLCB5b3Ugc2hvdWxkIG5vdCBj
b25mdXNlIHRoZSBzZW50ZW5jZXMuDQpBaCwgSSB1bmRlcnN0b29kIG5vdyB0aGF0IHlvdSBkbyBu
b3QgcGxhbiBURElTUCBpbiBmdXR1cmUuDQpUaGFua3MuDQoNCg==

