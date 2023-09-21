Return-Path: <virtio-dev-return-13895-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB877CD4947
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:51:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3483E335C6
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:51:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EE97986686
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:51:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00A74983D6F; Thu, 21 Sep 2023 03:51:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E504E98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 03:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IawC2ciyICXjGrRPsN43exorIpOljGEzBMDXJDeCAfSTm+pNHz3JFAx3CtsJ1N0+YoZhW64hSFm4drVTJoEWjGg+x9vapTocKZao/PJ+HjP6VHQmUyMJMd8RnoVJRPM5/0iEXM1G8PD/4FUT1KNi2bnjUlrt3QPjJs9Bw1Lsa0MRuojmn8l9mwDE6KPCXV4AOTVY8AqEg2zJMfs+fNf4KCP+FB4e1VTvJflT5ee1iitKCurOH1suJQhpnJsovXhViN/qpXp3g+4+H3bHqPMcItko8XTv5/zU6rruk5ZyXLnCnjktZH9OZFcjiIyxVIx6FtOBR0ZFRnAo1ko1Mya0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Ir9ImB+1ISdQAhCKMpIkR2I+H6q4YIHEQotOGextA=;
 b=YO8LBgm0hVG7O0JuvrzK4/b+V1IJqc8y6G6fLPC8Nj3lGkbaQSlSFgyZEj1ESB12LKhSVlLIISYmWVeE1TSi4r5Lk3ttl8u8VS4Qua1l9qX0+5OOKbK+/PGVL675i+IyX44Zz/bzVq5V+QKdE6hkbwjUTjjpXw8EAHKYE5eVEc4k5C5t0Y1Pw/sGOkBQ2EfYVZizgsw5VOsWSxHv7QaMR2e1jA46PelhJ05gbExVYwD9ZAnofM68NMPRTMxyPSb2JCqMoQ8wDccq18Kma/lOh+N+2lOhkQlwDtl7ZOMSv59C1gh3csPoC3mqb5M1aF9lobTt5zAuQwrZY3/VHyMYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAAu6AgAAG2oCAAPQiAIAACZXw
Date: Thu, 21 Sep 2023 03:51:29 +0000
Message-ID:
 <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org>
 <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
In-Reply-To:
 <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB9027:EE_
x-ms-office365-filtering-correlation-id: 68c08f79-ed64-4c84-24c1-08dbba5609e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fKcRVlp6AwL3ZOBvyrpcTNt8xaLDH4E/VYkNnxGD3RPM1hwPyxkwGn+J7SeOBoysG78UzX3lnPihBBnBfLSZqot8cbyhyYaWveRucr1Bt3nwkmbBXKgGTsGJ4xSg8NjDij4J1R83gRLYQXry7zkz5+mzVopu2hBMYI6yTXXnW38lp9e72eGhyYyICAEhl3BXp2HSKkjS3D08rpDNeYt1/0fZt/0j4x/NEaR4Q4esF0AIfyHSkkzZSZooX9Z34CHcXmoCAevjE6qMcD6eaOz99gtCBuudvE3YJqTS7Kl7P1ttCTUG3MLOf1q6q7UxSmRY6zTIZom82T+2q+j0pk9C/LkoqkmF74sFSkdYI4dvkxu0C2soR7NKsijzNBEHoaoNmI4SVavaP/UeLzxVKBypstIFpnU91cx+f51loQdOBuQyU/mCVsHMdnAy+zEmCpBXaPnIualaSdxcxwKaM3fX9m4MndR669n6ZPd0vZ40TCvNol3iiol1BOXKIPVvET9gSTLPhZURvc4PZaa2gpylahlmKiDqZFAA6QGyFkkZxushDFvGkoMmy9RXF9FZXargbs6BRifnd/WRljgYG28JW2ScEVtPOVhBPPHb1yA3DQX5jHdjEPE60Z+mJqcQR0ppiqh8d4REapX7xo3X/bS2mDSWe8NSRBmZZCGy5Y1v1G0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199024)(186009)(1800799009)(4744005)(2906002)(33656002)(83380400001)(4326008)(8936002)(8676002)(52536014)(5660300002)(86362001)(26005)(316002)(38070700005)(38100700002)(66946007)(110136005)(9686003)(55016003)(478600001)(122000001)(55236004)(7696005)(6506007)(966005)(41300700001)(66476007)(66556008)(66446008)(76116006)(54906003)(64756008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGJvQk9BaFJvK1JTT0dFbW5UaUhLTnVvazd6dytCeW0rY0tvdWJpa1BLUlQ2?=
 =?utf-8?B?VVNOUTYrR3J6SmZ1UzhPQnFxQVk3bDZZdFRtbnBUNUJzenhvVmxmMnQ1NGps?=
 =?utf-8?B?K2l3WXJLVGJHV01xWHR1YjJYVWV2YyttUTI0MnF3YVBwenNaRmRxa2R5MjRi?=
 =?utf-8?B?U1gvUWMxd2IzMUMzdmVKQVlueGNId3I5SkpmTmo2UnVsTVJlV1hiTjlKTlYv?=
 =?utf-8?B?WjR3aHJuOHN4ay9kWmtxRHlFZng0MXRnNWVRRGdoS2NKeXRDMHl0dUQwUllO?=
 =?utf-8?B?d0IySEpPdEpudHdBc1VFcmtWTDJzaThKNGpqdE1MRVJweGdBeFYydTY2K0VD?=
 =?utf-8?B?NXVBa2Rxd0N5TUw4a2NjUWJROVkxYkg3WUl4Mm9jY2NOTFg1MDVxQ2hBR09H?=
 =?utf-8?B?enZDVmdSSzdIYXE5b2x2L2hubmhxWndZUHcwazRXWkVJQ0l6dVArdmY2bGpQ?=
 =?utf-8?B?ZXVjZlhSbWxRMnpxRzd6UDIzcEdHbUp0NW5XZ1NHb09WdDNSSDlvM0huMVVn?=
 =?utf-8?B?QmdRczNxREZnQXZ1VDFiKzFaK1hwSEp3bHQ3MmlkM0VPWnBJR1IrTXJ0NXRk?=
 =?utf-8?B?bzJkSmJSbS9nQWNmeisyRW5DUnlsa0FSZ2QrSTdoVDZoaUhlOXZwMGtTM3Zz?=
 =?utf-8?B?eDh5UjlUUUdyaG1jNjJUdHRWSUhVMXlxNGtVK3lXUmdwakY4b2tJMjlUT2FS?=
 =?utf-8?B?M3E2YlU0cTZTaUVlNUc2bkdrZXJVWlpWN05Wa2JFcmlPNjg3M25MMHVKRW83?=
 =?utf-8?B?T2hyc3RPcnFqTlJ4ajdBcXVablJ4SkxUSmVmcDBYMkJ6ZVJLaXRsdFlQM0Ey?=
 =?utf-8?B?cVNHeVZEeFV6ZXIreE5kR0syYXRsNmhUeUhuYUJkblBnc1R0SC9lUWozSEFL?=
 =?utf-8?B?Rnl6N3VVbDBZSEphLzlCSEx1M3AveUdhZlJSeFplY3hnMW96OEM1SkJuL3dP?=
 =?utf-8?B?Q2xyVXZSay9ORmNGNi9HY1RRaEZMYjZuc3Z2eEh4ZDJ6OUFlSzhHK2hwNlVV?=
 =?utf-8?B?RHRSNnBuOWViRndWREUxbzJtcHNDd0JDcmVtMVNKVCtKbDJpZ3N4SGZHSmNV?=
 =?utf-8?B?eFRmemlETDFiS25ZVk1YUnJHUjFWaGYwNUdCMms1U2RaRW5tN1gzbVFjMmla?=
 =?utf-8?B?T2hpUDJJbjJ4VnBDeW1WUFRxcmx4QlU1OXFrMDVEWjhub0pJeTBIbm5nbkpq?=
 =?utf-8?B?YTg2ZlZaV3JsN1NpcW1iNHlNRmd0ZTEvazdQdWdhOXY1YS9UT1hBQmFwaEp3?=
 =?utf-8?B?SDc0NWROQ2R1bHptZ2JFb1owMjBXU0JseVlLL0x5TlE5UkkxMVpybzl0dStI?=
 =?utf-8?B?bUpGWnEvSDBQM3pRY2NjREQrRmlFOXpjS3NxVmV6cGEyb1Rwem9kbytiMG5D?=
 =?utf-8?B?MVNQOGlwL1R1Ujhudk54Uk81QTd0eVYySGUxYWh3UEsrZWdIMkZHOVllRE5O?=
 =?utf-8?B?VGwwMkM5eUxJVnJ3N0Qra2JMOTJOa3oxNEMrMnFtTEs2WjJESFY3a3NVWnBh?=
 =?utf-8?B?V0t2MldseXM2RjhHWGpZcFovRDc3a1M2M0N2NmsvcmFxa1lDeDdNM2lLU09s?=
 =?utf-8?B?TERYRFZvdkRNL25wWUJGbWdYV1V6UGJyWjRkUXVobVBwYW5iUkhMejE0bVdU?=
 =?utf-8?B?RTQ1RmN4d0dsMC84WDVNdzUxK2RlSDRSZGlabm4wak9wZllCYmErbzhLRGh1?=
 =?utf-8?B?YWNzYW9sanhQZlhKZEpqek1UT3F0Z3d2allRTURwRVcxcnJLUnVMK0VhMVZE?=
 =?utf-8?B?K0lrZDdpQTZPS0xEK0VQejlXSlpMQUJRZzJvMDF0ZWl3TUwxSXBaZmJnRFRm?=
 =?utf-8?B?Y2NOM1grQjlHcGZEdUFMU21LZmR4TkxQMzVWVXhYTFVoUVhBckhLNy8zMzgv?=
 =?utf-8?B?cFlOMzZhVitEZ2treEtIOW5scVp4Uk9LWi9HOS9KZXJUdTdDNTZHRHcxL01m?=
 =?utf-8?B?cXcrNnlvRm51K0EycUJWaVZUUFZLVUVJUDBOMUluTkVuY2xyZzlRSEtzeW1m?=
 =?utf-8?B?Q2ZkMXJOdURyRXU2R3F1T2g4K1FLam9LTWFLNkp4K1ZDMWlZQmVoK2FXNFhs?=
 =?utf-8?B?ZnRYS2YxRTRjS2NUd09KaDAvTmdRRGNScnVlaWZuS2ZucThpbjIwWjhkNGNv?=
 =?utf-8?Q?1Pss=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c08f79-ed64-4c84-24c1-08dbba5609e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:51:29.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgk1wnX7j4VSSuY053owanri/CPmTB5q5fp2FmbdkqtgXa3Qw2FCqIkhr8RwJtP+hd+1OddIi/AXVuFaopNpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA4OjQ1IEFNDQo+IFRoZSBtYWluIGlzc3VlIEkgc2Vl
IHNvIGZhciBpcyB0aGF0DQo+IHlvdSB3YW50IHRvIGNvdXBsZSBtaWdyYXRpb24gd2l0aCBhZG1p
biBjb21tYW5kcyBidXQgSSBkb24ndCBzZWUgbXVjaA0KPiBhZHZhbnRhZ2VzIHRvIGRvaW5nIHRo
aXMuDQo+IA0KVGhlIHdheSBJIHJlYWQgYWJvdmUgY29tbWVudCBpcywgdG8gZHJhdyBhIHBhcmFs
bGVsIGxpbmU6IGRlc2NyaXB0b3IgcG9zdGluZyBpbiB2aXJ0aW8gc3BlYyBpcyB0aWVkIHRvIHZp
cnRxdWV1ZXMuIFdoYXQgaXMgdGhlIGFkdmFudGFnZSBvZiBpdD8NCldlbGwsIGl0IGlzIG9uZSB3
YXkgdG8gYWNoaWV2ZSBpdC4NClRoZXJlIG1heSBiZSBkaWZmZXJlbnQgd2F5IHRvIGRvIGFsbCBi
dWxrIGRhdGEgdHJhbnNmZXIgd2l0aG91dCBhZG1pbiBjb21tYW5kcy4NCldoYXQgaXQgdGhlIGFk
dmFudGFnZSBvZiBpdCwgcGxlYXNlIGxpc3QgZG93biB0aGVtIGluIFsxXSBmb3IgdGhlIGNvbW1h
bmQgd2hlcmUgeW91IGNhbiBmaW5kIGFsdGVybmF0aXZlLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvdmlydGlvLWNvbW1lbnQvMjAyMzA5MDkxNDI5MTEuNTI0NDA3LTctcGFyYXZAbnZp
ZGlhLmNvbS9ULyNtZDlmY2ZhMWJhOTk3NDYzZGU4YzdmYjhjNmQxNzg2YjIyNGIwYmVhZA0K

