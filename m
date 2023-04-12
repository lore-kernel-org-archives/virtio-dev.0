Return-Path: <virtio-dev-return-12163-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B970C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:13:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0D8562AC4D
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:13:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 056259865F6
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:13:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EDB4B986512; Wed, 12 Apr 2023 04:13:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DAE3C986509;
	Wed, 12 Apr 2023 04:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZbQ736e/D7Q5DiHJRt6XCZfVcPTwWghRf0q+GydtLheqKmi7MYHkSp/01qrFOWZ1FJiBihWl6lhTeiBsQk/+kQ4wjOayMGKBXzOhFBTWXZxhZtOJei5g5pgllZu0JabHPLBspZ19dR5XmNQlAD9f/CXahZLHjNaN3O8R6WkFuxSZ7iNxlJUfa3j5e0UkE7Pl9/d1QY2P2uzvLVahyoBtmu4DBlof6CgBm3wbkB/vNdedl9+PLzGpZWXRB+NeDGyGnRI3vX/W8SQs9++GcaaXUfnmeQ8eKiSW3GEABzNP0AFxid9xZiPX4vQ6VtiZXgBopxfuNblvGFLkj2k4xO+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGFVIKHveNR6b9InSk9CZAm5lUlZc5W9H21kUvswN7A=;
 b=jdRGv+XEEWxjDR2qkClWchu4P2no7Ixa9hTCxbD8Yonc3vIDnL/nsukdRbNK7SjINo9n+ao2fN8VqZdkAiGuT5sGEI0Q83jjE6J9UA/MGx9RVdnAlyIUtl4WsUhr9bKrTNIewLOZcQL7i6Fd0anJTNZ5HCr5fSa1LYmVt+cilr62Jt3akYmNIoJQZhpjZZRWpg2uYKxPT3ZW0FV34wfy53+Ws3CZ6rRz4g85aGET9FVIjJxxj7lWzcwFk5YoScUzPX9wfvy6lzGFn2iYwu3pfnhkZd+Eo2B5qJ+BAVNb436oCB/GKTU0khp9i2fFxMg7QNucd/Aa3EEI7QyST1RULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability
Thread-Index:
 AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgAERMACAAKCVAIABAn+QgACZ4YCAAAExwA==
Date: Wed, 12 Apr 2023 04:13:11 +0000
Message-ID:
 <PH0PR12MB5481B0A178BC82B290E6EFB7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEstkFaH1rh+O-D9h=bin_09ut2_GnSZDsxrQi_ptDtBKg@mail.gmail.com>
In-Reply-To:
 <CACGkMEstkFaH1rh+O-D9h=bin_09ut2_GnSZDsxrQi_ptDtBKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB8588:EE_
x-ms-office365-filtering-correlation-id: 1e72f45e-6b75-40b8-a209-08db3b0c3ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FnJW0IJi72MzrVX8RwEWk93xki3Pb4yDuxfxDiSRDvqsKB9GLGbAj6HxT5+JjwHjiTbKXTutFw+bA+VyyQKmj8BCT8L85cTcCwfmUyHpuCWiGBMvy9Plkv7f6pHwJhh8wSe1iq0YD9x4kimB3O7+i8rlEQBVw9RGHxpHfzU/1/zb6THLR5P7U39PTkMh4+9tH/nIISOAhlGOuWxXD42dRkAdZirzOhpXKjKDnp6AF0nY5Y6EPRHteCMbDzF5ghnML9YDcOz5xfOr+OdRIcU8e2iHS/ZS1nL6j3Ku0S3NNwBi5DlW95RlDfs3sQqlePVqaFeq/qBdNauvNk1XIgqKHX/lJdvu3keBszzQ7U5M86AOa9Ig7gRz5XNHh5yat2l2NeNppZmc9nAGkfD9TitdyOwSNY4V/viJUfyPpIl/j3kajE4JuioGngy96VWEdRGMr8Wm9xkXFGSS0qwQFyVbnVyNbfGXVHLtsTOOH6osycR+kKjQqa3WmdLr3Z25vNav8INZjykH/NQgMyZUecxvQWZ40DoLcTTGt49MZj84cKfk3Yt/62QDR1WgA2lBpzn0KGnixDfTnfYfFAxQIPZJnRjFyLB7NpDFRI6VXSXHqzzu/AMiekCYGRialxxOWtno
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(33656002)(38100700002)(5660300002)(52536014)(2906002)(38070700005)(316002)(8936002)(55016003)(86362001)(8676002)(66556008)(6916009)(4326008)(122000001)(41300700001)(66476007)(66446008)(64756008)(66946007)(76116006)(6506007)(186003)(54906003)(9686003)(71200400001)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1NtVnlPZVpoRXJWeGxaMEplWm5yanJBS1BXT0dWWjJBUHF6R1EyczUvWFBS?=
 =?utf-8?B?Vm1tZmZMeDM1bHdoNUZFbE1rdDNzOFo2QXhxVzJCZXdwdmtkNURIN3p6MVg0?=
 =?utf-8?B?VGNNdjZaL25JS2R1b0xwYmpMZDErQklHeUNjQjBjN1Y3MXpWZk1rcUt0K1dD?=
 =?utf-8?B?cm42RjVnQXhNSXVicE4weER5Sm8vREVQdnJhVlNjK2c5M3dCNVgxK0llZDI5?=
 =?utf-8?B?eDA5dkdBVm54L2dxMjB4V1FrYXRianRicEoxaGRPMzhuQmdjY0lEZmsraWVl?=
 =?utf-8?B?MWFTSGhDUm55enFEeDljUlZHTU9YKzZnazNzb0YranJka3RMWmxyUWRGVEp1?=
 =?utf-8?B?MGcxTWZuNmt6U3dJM1dWSkVYRHBvUXdlQjAxK1NFWUNEdTFJUEVPeERvdk5j?=
 =?utf-8?B?MjZ1dGlMRXJHOG91RUVBY2I5WUEweCtxK1ZRZGFJdTNLUEU4NGluaHhHVmF3?=
 =?utf-8?B?UDAyK0ZGSVQzOWdlanphR0pFYzVucXV3R1p1YkVaNlJIZHR6NzFqTHNPRkJV?=
 =?utf-8?B?NWlKZ0t3SjBuRzMxZllBUURwSE1kazZ4a29wY2tUTkkydGg3a0NnS0pKb00y?=
 =?utf-8?B?Y1hlNEc2SzgxYWR1N2R3SUtBUjRqZ285TUJNYkdpQlFYRnF1d1E2REpycWx3?=
 =?utf-8?B?Y2d2TEhjTVdmMmJ5YnVNd05La01WYXVQeGJaN25VbkkyOEVGZ0R2QWQrZkpU?=
 =?utf-8?B?eFh0SUErb3diMWZSeFJoTVFDNE9icXJSZS9GU2xtMHluRllodnZwOWRtYVFW?=
 =?utf-8?B?SUtxZ2R5UnhWaXVpTGFzMEtQN0JNZFA5MVkyc1docDZkV0liTWxtYmROYVpz?=
 =?utf-8?B?OUdCeWwrZzhUYURlSFZHTTUxSkdENUVtQ1F5ci9SY1lUMVRkY1UweEIzNjdL?=
 =?utf-8?B?VHhXWDMySWFYQm5zTU5ySkdWZStjWkdCakl3cTVGL3F0dWRvR1hxZUdNUlo3?=
 =?utf-8?B?bHVaY2JjekVyZ1BmV3VHLzdLWHQ4azFIUllaVVVZb1J5MjRQQ3NzYllNN1Vk?=
 =?utf-8?B?QmJ1Vkc4K3lnaUUzL0t0UjhwUmR1RGZNazNUQ29pd1plQ2ZRQjZhWUsrMkNK?=
 =?utf-8?B?MDk0elhhRmExRURuczlzNWVVL1RhcGJhTUtzV29kbytRWlFJZnN4Qjl4LzJN?=
 =?utf-8?B?MmU3Rk9RU3RIeUNIMnR2UlhCYUNaWWExcUdwYVNEMjFaaEEwRHhtaXQ5K29Y?=
 =?utf-8?B?U3hvZmIwNDVBTGVoUm9kd2VqVzNhcjVRbmZGZ1JhNFhNd1Q1ck1HZG4zSUtG?=
 =?utf-8?B?Vmk2UU9HOFVHNVJYVlRhWUVhSUVrRytKcVltNjRCSEs2ZWRYQk81VG1nNm5v?=
 =?utf-8?B?alBNT0l2OVBxd2Fmek9IWWlVdHZDMWt0elYxZldvaVMrZmh4VzVtNG1FR1M3?=
 =?utf-8?B?eUtGRy9mOVU2UWh4Q0lOUTRVUkRJMWpDMjE5S1dsUS9SL0pQd0RrWE1iUEp0?=
 =?utf-8?B?V3BjZUROVmwyUDF0UlhWam5wNDJSdDBGVTE3T2ZHMERuNTZOcURlUktBRHR0?=
 =?utf-8?B?OWxOaTRjOHlBaWtUcTVFTUpZUjRtTzBCVnRCQk5Cb1djMFdtL1dyZzdqTkJk?=
 =?utf-8?B?ajZIS05HR0owTDNYMElrNjNtZjErZXo4R3VKWGRuUTZrOSsxR3RQalVKSW11?=
 =?utf-8?B?SzlObDhNbVdSandFZmEwc0tuRGxJTVI1cGdjTGZidmVWanRoTXZkRzdLSThT?=
 =?utf-8?B?c3d6clR3OHRCRDl3UGZPakNwQVIzNkc0UE85Y0MyVUtzZ0dyY3pqb05OUll6?=
 =?utf-8?B?VWY5elJ5NENFRjNna09LclN1TDc1elhTazIrNmlCYVYzazY5T1lCUERiNlpU?=
 =?utf-8?B?SHE4SGpmOFhJWkl1ZU05ZmxjNmhibWg1RldYZHlQRTYzVXprWHkzOGxMN2NC?=
 =?utf-8?B?cU5MQUp6YWMxclVNdVRtS2Z4YzlXWUhvVG14bW83NDlrQ0NlaFB4VWpJQmZU?=
 =?utf-8?B?eDZIM0Jwd0RUMzBhYjRKRjg1R2cwOVZ4WGttbzNmeUN2SmE2NlIrV2xjV2c5?=
 =?utf-8?B?QXkvOTA5dU9DdHZNT1ZCa2E0a0RGUHJob2dCVUhvNVNZM29GK2M1VUtjem9D?=
 =?utf-8?B?ZmhmajFRZUFHQVBtaWpMN2VoSTNlK1F6SE1HbVJDRzNGUE9YSGtqeUZ1YXYv?=
 =?utf-8?B?cmJ6ck9lTDRlbGEzQXJwRXVjeW9Yekc5QVMzaW1uNE0vVnJtVEtKckl5NG9u?=
 =?utf-8?Q?odQYYscdJD/Fskswz1/+skg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e72f45e-6b75-40b8-a209-08db3b0c3ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 04:13:11.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MD/p7RaD82YqzBoZ7SIeHWvc4s1FlfL/gqAx/4fghfaSEOW8FR9M63bhuiS75hINdMEP377Df9qvmJ8JS6xfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
Subject: RE: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxMiwgMjAyMyAxMjowNSBBTQ0KDQo+ID4gPiBJdCBpcyBraW5kIG9mIGlu
dGVuZGVkIHNpbmNlIGl0IGlzIG9ubHkgdXNlZCBmb3IgbmV3IFBDSS1FIGZlYXR1cmVzOg0KPiA+
ID4NCj4gPiBOZXcgZmllbGRzIGluIG5ldyBleHRlbmRlZCBwY2kgY2FwIGFyZWEgaXMgZmluZS4N
Cj4gPiBNaWdyYXRpbmcgb2xkIGZpZWxkcyB0byBiZSBwcmVzZW50IGluIHRoZSBuZXcgZXh0ZW5k
ZWQgcGNpIGNhcCwgaXMgbm90IHlvdXINCj4gaW50ZW50aW9uLiBSaWdodD8NCj4gDQo+IFJpZ2h0
LCBidXQgd2hhdCBJIHdhbnQgdG8gc2F5IGlzLCBzdWNoIG1pZ3JhdGlvbiBtYXkgY2F1c2UgdW5u
ZWNlc3NhcnkNCj4gcHJvYmxlbXMuIEFuZCBJIGRvbid0IHNlZSB3aHkgaXQgaXMgYSBtdXN0IGZv
ciB5b3VyIGxlZ2FjeSBNTUlPIGJhciBwcm9wb3NhbC4NCj4NCkFzIEkgZXhwbGFpbmVkIGluIHRo
ZSBjb21taXQgbG9nLCB0aGVyZSBpcyB2ZXJ5IHNtYWxsIHNwYWNlIGxlZnQgaW4gdGhlIFBDSSBj
YXBhYmlsaXRpZXMuDQpMYXN0IHRpbWUgSSBjb3VudGVkLCBvdXIgVkYgZG9lc27igJl0IGV2ZW4g
aGF2ZSBzcGFjZSBpbiB0aGUgUENJIGNhcCAxOTIgYnl0ZXMgYW55bW9yZS4NCg0KU28gc3RhcnRp
bmcgd2l0aCB0aGUgZXh0ZW5kZWQgUENJIGNhcCBmb3IgbGVnYWN5IE1NSU8gYmFyIHdpbmRvdy4N
Cg0KPiA+IE9ubHkgY3VycmVudGx5IGRlZmluZWQgY2FwcyB0byBiZSBwbGFjZWQgaW4gdHdvIHBs
YWNlcy4NCj4gDQo+IFdoYXQncyB0aGUgYWR2YW50YWdlIG9mIGRvaW5nIHRoaXM/DQo+DQpJIHRo
aW5rIE1pY2hhZWwgZm91bmQgb25lIGFkdmFudGFnZSBvZiBiZWluZyAyeCBmYXN0ZXI/DQogDQo+
IE5ldyBkcml2ZXJzIHNob3VsZCBwcm92aWRlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgc28gdGhl
eSBtdXN0IHNjYW4gdGhlIHBjaQ0KPiBjYXAuDQpZZXMuDQo+IFRoZSBPbGQgZHJpdmVyIGNhbiBv
bmx5IHNjYW4gdGhlIHBjaSBjYXAuDQo+IA0KWWVzLg0KPiA+IE5ldyBmaWVsZHMgZG9u4oCZdCBu
ZWVkIHRvIGJlIHBsYWNlZCBpbiBQQ0kgY2FwLCBiZWNhdXNlIG5vIGRyaXZlciBpcyBsb29raW5n
DQo+IHRoZXJlLg0KPiANCj4gSXQgd291bGQgYmUgbXVjaCBtb3JlIHNpbXBsZSBpZiB3ZSBmb3Ji
aWQgcGxhY2luZyBuZXcgZmllbGRzIGluIHRoZSBQQ0kgY2FwLCBpdCBpcw0KPiBhbHJlYWR5IG91
dCBvZiBzcGFjZS4NCj4gDQpZZXMuIFdlIGJvdGggYXJlIHNheWluZyBzYW1lIHBvaW50LiA6KQ0K
DQo=

