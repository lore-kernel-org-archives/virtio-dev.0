Return-Path: <virtio-dev-return-12734-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC3C77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D7ABBF3EDD
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4959B986767
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:20:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AADB19862FB; Tue, 16 May 2023 21:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E22DF9862F7;
	Tue, 16 May 2023 21:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL3ADtwZvMV3vfYZlEz66RfHLDQifsxXoate2Z+joNTiM0w+CjJI4wmMjIrr1Izxi08WQ1CGSud+wW5Nbqa1qknxEntGPXlmvl9qLT6c2zY3WaO1kZmSSj1V8CQW2Kk1oPjraOudnfnLiq3yBs/RigbRiS7zsLpMwt0DCBw05PcGzi8uRRISEbm/t2I+sdhAOMgc5XWwP1kigq0K4oOcPkjt6KCnIxvxk/++GeuNqOHpOPQl73E5y1Ut6WLLUAUzq2durFVYGdzS071Ezq1SY0F6qxrOJdv6JHrG5UVMOH1xRXmhuKxWChy4VSrHsE5o4yJACX81UB0bRoMhNbx7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yJPcnkGHoYeLJGsETxyksgqsLX+i0T80bT/I7QDbJg=;
 b=Yr+7a+c3vWBuGXoVLiwvE9ZNvc6WQhC30rSd3P5BYbpCy5+88V63eoTvM+ndAMzqXCvbhXG00oZYcmYqSYaAt42z2qYDZIv73rlXzAM2pX/jKY8oYilor+gdR08VkaClfjeCcxf3YcTMFKHe4h91tDqE2BldFKfyOseu350+IJdAnP3I1eyxD7ia7NxtygWyv9DjhddUTUCcC5iS0opLN38YcVN7EmQ0gi+HmUNvfcHlmtWvxSfjV0UIx/ywwo6OjNcruVAwumcnkZT4Jlunzg56NkC/azt4ec8JpIZgBJDvhQo0hwix8RWrOnRivIznvKovxP5VeNAkN+H+nBmxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgACLkzCAAPN2gIAA1fCggAAe9ICAAASUYA==
Date: Tue, 16 May 2023 21:19:02 +0000
Message-ID:
 <PH0PR12MB5481EE9429669D53FA8E77AADC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <PH0PR12MB548136C3582B9DE232AEFDE5DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516021401-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816BF1E277820C594A6344DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516165509-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516165509-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB8605:EE_
x-ms-office365-filtering-correlation-id: 3350497d-042c-40bd-3efa-08db56532c0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 grgvczyjpggfi861VFhhFjimRCThjTePFl4NYuluxvHi5Jmt2ek0rH2MHLWZF+X5+ThjRRGy+HqSCW272N7KmL4R9SMGbN+iMsbEFRUMQfyfIy3fNWOffXGpP01VF8mwaeNT8YEM/u4WSWrYFhsZq8Noc6omgsQByxoDmm1vRufr2wawGpSgVAzAuZObePHg4ZHxALS7Z4Fh7kJjt0m2wqN6KONv/Gg3Gd29lbLvgDHIGv2Lk2D/78ypK0BAApKuoH1ewdmklFPyS25Q/b5K+Do3k8A0BlMVjmrG64kzF/Y84EdRjduj1uXT28XZT07VPwAa1MW7eeMqNrOR+CfJ/ehPUqXNMIgYQwk5gfB8LDXxVEkEAtVlOc52eJ0SAHwxkDaGBd396ulS+NgCj/FK2h6q3uPeq4aKU3cuxwwFH0V9ZnNq52HLBqqdDdXMEEnHsa3Xu1TPHPtb4nq5rYvsv8EwQzKDV7nzeMKTWkM2oeuU1HzrEOCXk3PRE60eTXnAab+1mXPp3cRIU6buldUoUOo7yuiVzxfIrQoufp4DFQE6j0tYmzpT2FOowA8GWwx4Tn+PJp1lb1jknJtdEiEywYodovumPzpiVqz7pu2BryIdrNfWeESKJeSuMY8bn0hF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(54906003)(86362001)(478600001)(107886003)(186003)(55016003)(9686003)(7696005)(26005)(6506007)(33656002)(71200400001)(316002)(122000001)(38100700002)(76116006)(41300700001)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(6916009)(8676002)(52536014)(5660300002)(38070700005)(83380400001)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzBTZDdGdlRDYVR1bWl4dldUTTJlVDREZU1ZRDl1Umx1VHFmdit1ZGdRQ1ZM?=
 =?utf-8?B?cTRSMW52dW9aT0J6TFlwcFVGdkFPZnpvK3hSMExvR1g4TXF5LzFMaDFJUHNU?=
 =?utf-8?B?RWw1SUM0cWwrWU83cGlSRjRiTVM0M2VOTy9tc2FqTkJGSDBsUVBsYW1IVU9B?=
 =?utf-8?B?WEdTYXVUV3E2ZG5kb3lEamd0N09HU0RuRkEyOUg1Z1dOd0hKT0NBSlFGem5Z?=
 =?utf-8?B?cTNnNlZLcFVNWE9GdUtuRmlXSFZCeXprYVhhM3dhdnhJR0JuRHNaRFdiR2Iz?=
 =?utf-8?B?RTBqWkR4SVVNbTVhRDc0bm9NV0xzR0FYU04velJHZXc0eTFuUzFUMElOK3Av?=
 =?utf-8?B?UUs4TElOWXhaVUp3SktMUW12RzVPSmFnbVRrdXMzdjN1RG10UTZNS2hOVTJj?=
 =?utf-8?B?WGI4VGVuUm5tZmR6WmI4UE12aEYzOHFWNlFyamQxWmhOR0ZQZ0Q0OWxONlVB?=
 =?utf-8?B?V0hWdFJmUytuNFg3ak1oUUFuNTZLT1lYekRMd1R6WUdrbWwzMGVXZ25uLzlR?=
 =?utf-8?B?WUhBRk1Uc0JLdks3ZFpZR211ZEZmaUhIRytMYXhNQk5ZSElrSDhJcnJwSkFh?=
 =?utf-8?B?MFlqcnRSdzF5OTVyalJObjFCYnFLRFBSclhoMXVHYlZYRTFiQzZmckpoVytE?=
 =?utf-8?B?Q0oxWUFVMFNLdzBFNkM5KzRoSG9aVld5TlgyamdBcUVVbDNVSitEckZUSWly?=
 =?utf-8?B?cDBXZUpBTkFzdlNEOGZkSEU3Z0JVcTgvT25XK0dsYUhBdkxPWk03SHF1U3lk?=
 =?utf-8?B?QzQwdUVXazFmVnB4Q1AvV253K25pYW5nV0xjSlRwU0RhTFp6aHVjZldpVUly?=
 =?utf-8?B?amlKaXQzZzJ4QjBYNWw2UENaYkt6VHFJUjRWT21IQ25UNEpSQXgraVdzeGtx?=
 =?utf-8?B?SkM0VUM0bjhjRlFzd3U2NFFnSG44dEJrZnUrOStpem1UNmE2NG52c0ZZcHlx?=
 =?utf-8?B?MVVrYi9PYmgrSm9tUVp5NWZiVlY0Q3ovZ044TVN6TmhBaStyeWxSTzllRUdi?=
 =?utf-8?B?YXIvYkV2TlU2bWx4NS83WTVBMUUxdTF3L2p5a21HOTZXN08vbkZITFhTNVI3?=
 =?utf-8?B?ZDBzd21MRVRxR1JVY3lvSTNhRnNDRXpkb3N6YjZOcmdhOUJha0pyVkFvZWNY?=
 =?utf-8?B?Wktyd2JQNkNqS3BPRWs2U3poQU9Mdkc2OWJNcmsyclVLRXl4ZmJUS1FwWUZz?=
 =?utf-8?B?Z2dlRS9NMjNxNzVPNldWdTA5dzAxK2drMTRxUW55U2xGU0Z2U3ZnWXAvMzdn?=
 =?utf-8?B?dXo4U0ZldzNCZzN5M3dlWkQ0WEpTRmhWYTViOWRaUCtxVW9CR3QveXdkM0Mv?=
 =?utf-8?B?b1RlSy9DMHdlcmJucVF0ZCtiVzR0Y3k2VXRRWG1Vc3Zod1kzblBIc0N6OFB2?=
 =?utf-8?B?SmYyR2lUSllKcTdTck5nWWRpVk9KUk8xYkFpRXhxelFRZjFWeHpWNjdKdGhm?=
 =?utf-8?B?Ykk1bkdKdEdFQ1V0YkM3TzRqcjRsVDhxaXJaM1RZSThwSWpOTkZRdTR5SzFC?=
 =?utf-8?B?STdWYUNUNCsrRzBlT1kwcW4zR3dlcTY0V2taOXVKbUF6MFgrRzdJQ0Z2TUx6?=
 =?utf-8?B?U2ZLT3NUNWhjc0ZKUTkxRUlyU2dLMFlmNFFCdThRdjNTK0VldDJoOVhXOFBH?=
 =?utf-8?B?aXBaWWNhYTZ5VmVyTUloWmgrVWgvQmY4OUxXdHhRSGpVUFp4TTBQWmNiLzFX?=
 =?utf-8?B?Rlo1ZGVJOUZ2TjJNY3JqclVIN2xzOGFwRkJZT0ExZzBVNWkxc3QvRU9mem1r?=
 =?utf-8?B?ejRORUpuUExuemovc0d5K2JzNmRnRUc1RjFRZy8zTk16MC9WSkNEUERDT1Br?=
 =?utf-8?B?Nmx3bjFhUmJZa29pVW9LNjlmU2tadlhpb3NLODhnTlBONjVFSW5JRWJ5RmdZ?=
 =?utf-8?B?bUpJYnZsSkRxMXJaeFlCbURvaWdqbWxuKy9jUXd1VHJ2b29YM1EzanVvMUNz?=
 =?utf-8?B?bnZyQ3RTb2lud3JSUXpxOEl0WUdkbTk2QmZ5ejFxMHZ0VW9SUEhHRjdoTkZ6?=
 =?utf-8?B?TlFoNkU3RVF5Ri9ZaVlRaFdZeUVXalg0NTIvNnRPQ1N4UHdYR2dDWkVEbE9U?=
 =?utf-8?B?cmtJOWE0YnFPYkxrWEJhQTNpa3BKZlVhOTF3bzFoMVp6bDlYalJrekI2cVFK?=
 =?utf-8?Q?fdhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3350497d-042c-40bd-3efa-08db56532c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:19:02.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMKeRLCaetkGXmvXYlqDwDZxkI1/4beCywxDiYhjzZdqCR6VIdCfr+Sdojro/Cj9EG6MFAT4hSgxeF4MU/tiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSAxNiwgMjAyMyA0OjU4IFBNDQoNCj4gPiA+IExldCBtZSBnaXZlIHlvdSBhbiBl
eGFtcGxlLiBJIGZlZWwgdGhhdCBkZXZpY2Ugc3BlY2lmaWMgY29uZmlnDQo+ID4gPiBzaG91bGQg
YWxsb3cgYXJiaXRyYXJ5IGxlbmd0aCBhY2Nlc3NlcyBzbyB0aGF0IGUuZy4NCj4gPiA+IG1hYyBj
YW4gYmUgcmVhZCBhbmQgd3JpdHRlbiBhdG9taWNhbGx5Lg0KPiA+ID4NCj4gPiA+IE9uIHRoZSBv
dGhlciBoYW5kLCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBmb3IgY29tbW9uIGNvbmZpZy4NCj4gPiA+
DQo+ID4gV2h5IGlzIHRoaXMgbm90IHRoZSBjYXNlIHdpdGggY29tbW9uIGNvbmZpZz8NCj4gPiBT
cGVjIHNuaXBwZXQ6ICJXaGVuIHVzaW5nIHRoZSBsZWdhY3kgaW50ZXJmYWNlIHRoZSBkcml2ZXIg
TUFZIGFjY2Vzcw0KPiA+IHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbiByZWdpb24g
dXNpbmcgYW55IHdpZHRoIGFjY2Vzc2VzIg0KPiANCj4gSSBtZWFuLCB3aGF0IHlvdSBzYWlkIGFi
b3ZlIGV4YWN0bHk/DQo+IGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uIGV4Y2x1ZGVzIGNv
bW1vbiBjb25maWcuDQo+IA0KPiANClNvLCB3aGF0IHByZXZlbnRzIHRoZSBkZXZpY2UgdG8gZmFp
bCBBUSBjb21tYW5kIHdpdGggdGhlIGVycm9yIGNvZGUgd2hlbiBhbGlnbm1lbnQvd2lkdGgvc2l6
ZSBpcyBub3QgcmlnaHQ/DQoNCj4gPiA+IEkgZmVlbCB3ZSBkbyBub3QgbmVlZCB0byBhbGxvdyBl
LmcuIGFjY2VzcyB0byBib3RoIGNvbW1vbiBjb25maWcgYW5kDQo+ID4gPiBkZXZpY2Ugc3BlY2lm
aWMgb25lIGluIGEgc2luZ2xlIG9wZXJhdGlvbiwgdGhhdCBpcyBqdXN0IG1lc3N5Lg0KPiA+IEl0
IGlzIGp1c3QgYW4gb2Zmc2V0IGFuZCB2YWx1ZS4NCj4gPiBXaGF0IHBhcnQgYm90aGVycyB5b3U/
DQo+IA0KPiBFLmcuIHRoYXQgaXQgY2FuIGNyb3NzIHRoZSBjb3VuZGFyeSBiZXR3ZWVuIGNvbW1v
biBhbmQgZGV2aWNlIGNvbmZpZy4NCj4gDQpUaGlzIGlzIHRoZSBsZWdhY3kgdHJhbnNwb3J0Lg0K
DQo+IExvb2sgd2UgZGlkbid0IGJ1aWxkIG1vZGVybiBiZWNhdXNlIHdlIHdhbnRlZCB0byBtYWtl
IHdvcmssIHdlIGRpZCBiZWNhdXNlDQo+IGxlZ2FjeSBpcyBicm9rZW4uICBTbyBlaXRoZXIgbGV0
IGxlZ2FjeSBkaWUgYWxyZWFkeSBvciBsZXQncyBidWlsZCBhIHNhbmUgaW50ZXJmYWNlDQo+IHRv
IGVtdWxhdGUgaXQgcGxlYXNlLg0KQWxtb3N0IGV2ZXJ5b25lIGJ1aWxkaW5nIHZpcnRpbyBkZXZp
Y2Ugd291bGQgcHJlZmVyIGZvciBsZWdhY3kgdG8gZGllLg0KSSBhbSBzdGlsbCB0cnlpbmcgdG8g
dW5kZXJzdGFuZCB0aGF0IHdoeSBiaXNlY3RpbmcgcmVnaXN0ZXIgZGVmaW5pdGlvbiBvZiBsZWdh
Y3kgbWFrZXMgaXQgc2FuZS4NCkRldmljZSBiZWhhdmVzIGJhc2VkIG9uIHRoZSByZWdpc3RlciBv
ZmZzZXQsIGlzIGZpbmUgZm9yIHRoZSBsZWdhY3kgdHJhbnNwb3J0LCBndWVzdCBkcml2ZXIgd2ls
bCBtYWtlIHRoZSByZWdpc3RlciBhY2Nlc3NlcyBhbnl3YXkgaXQgcHJlZmVycy4NCg==

