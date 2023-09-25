Return-Path: <virtio-dev-return-13944-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9BFCE7A95
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 15:38:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CB1D87A1AC
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 15:38:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFBBA9863A9
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 15:38:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 990C9986379; Mon, 25 Sep 2023 15:38:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 895EC98637A
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2023 15:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGPHCX3ccwucBOBkGevr5HLiHgb6apB4dBfYSS/Qz6+HXsLMefaJwKNydwpkbCKS7jDKRmU6Jvvk6tIyg/M3G9TprtMnOnwNIlEOJ+yUzuedv+QBavkQfqaEIaNuiXjH98VI45RLlJLiG0TQQ+Oqvgz1/UPWmEJj94oN89j0ToZW8wkt7+MgVvd8J0APlw1EwxFSO7j3AcckvxMVIjEze58OZawEaDjPJijwbMES9rkEx1njp5ORm3rXmtj8yJx8D/pUk4fBGoC/4EEaR2yKj1YzRoTHaSZbzlXKbutC7Kbf+REbz1cPBkFbwIaibEgeFYEN+Q1FsTjzTzb8xJHqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSr5/G8m9CFBoeDOgFFGdUtxAV/Cq3aDgyUmCtgF504=;
 b=M4g/0g6UKwNHPTrrZUiEgR7orGA/oHGZ7A/a5GFlRzdbIwg31C5cfzivXyth1KWes5wn3sM4t4xcLXYp8DYwpmdGme505pGV8QEPQDQmQcKjd5ouPwYG5LCc/NTYtfduwBAF0Ta19vCOn0V5urHlDJ9mPWi30p9eFY3sKi+bc4fsUxFWiYwCAKJo269nKXt19CKbtLsf70XmRHUmvoj797L6P9BxxqxuodlDpZfcazXC/3z4MU4RSwwrC0jRriIRJ7OmkDZzkP0iVs+n4CoHsHA2P0dcu1jQXoYkCUEbhkTisPToKHtdhE75yDGsFS1ZFDgYaB4eyddecnGao2WENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: jeshwank <JESHWANTHKUMAR.NK@amd.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "Mythri.Pandeshwarakrishna@amd.com" <Mythri.Pandeshwarakrishna@amd.com>,
	"Devaraj.Rangasamy@amd.com" <Devaraj.Rangasamy@amd.com>,
	"Rijo-john.Thomas@amd.com" <Rijo-john.Thomas@amd.com>, "Nimesh.Easow@amd.com"
	<Nimesh.Easow@amd.com>, "babulu.ellune@amd.com" <babulu.ellune@amd.com>
Thread-Topic: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device
Thread-Index: AQHZ76H22ay2E/QuEkGoBDFkRsXpPbArrOHA
Date: Mon, 25 Sep 2023 15:38:21 +0000
Message-ID:
 <PH0PR12MB54813F8968ABA023D551E05FDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
In-Reply-To:
 <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7292:EE_
x-ms-office365-filtering-correlation-id: 2ca2bc95-ac33-45ab-7258-08dbbddd72be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JqeA4MVK8cDFgYSvrl/2Rc0EqJUWFEThF60Imiva8K36szwW+pKiUeEh1FLhNBMLLdYjRSKLZBzLzuCbUUGJgwLMq07Hke0OKkVF2ViKqwOt5eQUAsaAV259lj4VVEojTP565r4HbiWL35CBPmJGGXLD5vnOLIu2ZiF0CF0Q8fUJ1zxJl8AVER7GeqN1KOMMisF90o0YM6cMHO6Ju1hOIGBHfRMYsRRQSJYzJRGjNY78lBh1bMIyL3xAqBnyDjjNgDqR9M/DnYrvqyU4voQuL0NijPf8TkLxpdWruYqnqm+IR3ax3bWMbrLewM2IpezR3v46LEFJ/4T5iXttH4x2hu9XniTD6ZDXwjfzVbpQ14Ly4YJrGUyVCC0mXJxY92cN/SiXbZ6xU8aOdNjDRjS1b1pnMTKk/8svAPFuIxu2vPDhLVpvC0NlornljOfDu1aJpPpVQvBbXna7/tKGKwBIbU8lIEP236QBfhedH2Frint7ubJ2MK5zNO/lktwEWpQCg0jDluM9LUi7Sdnh7+mV6W9PebhgBrDZ7epIOI7LMH4p9XF5jQtIJ7U/KfLKjD3yB45k7rwTqyDpwxw0tT9uMp5F1ncIKEoO3ydNoevEpNdyGGvr0A0yuB/OYMkzt/sc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(41300700001)(316002)(66476007)(76116006)(5660300002)(8936002)(26005)(64756008)(66946007)(66446008)(9686003)(54906003)(53546011)(6506007)(110136005)(71200400001)(8676002)(52536014)(66556008)(7696005)(4326008)(2906002)(83380400001)(478600001)(66899024)(55016003)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUhieDkwR0ZKNVVjN1VWNkw2ci9TOGRCYjlqUkltcnBRQ3FMM1hpV1l6Q3c0?=
 =?utf-8?B?Wm11TEtReHV4aktHZHhHbFdMRWNYTjMvOVMxdGpzQVNIK0VDUjlaWURCMUcw?=
 =?utf-8?B?NDRmVHN0OXVBaXFZSXVENm5SVlpoZ3V6VVZGaDUwZElZNWx6c2xsU1l4dk5m?=
 =?utf-8?B?R0ZmNDE0ZW53R1BWN2pPWXVzMGFmaU1BeWVHSk5Vb3FOamdBNXYxUVBxN3FJ?=
 =?utf-8?B?aDgwZ1hvRmZvSXQvN1BjRGtSbzBZbDFSZnEyYkk5MGNDWXdTVC9ENkpDQUJv?=
 =?utf-8?B?ZzJwV3JpZ09SVmxIeWJaL0NybU9Gc0tCTCt5Z29ocGptMWJpSlFQQXJXMWtD?=
 =?utf-8?B?Zml6U2FXZ3poL0JRUEtrUWR2NEdZeFVmTUZHbWFMaEVqOUNRZjRRMjhqM0tu?=
 =?utf-8?B?aXFjVFdWQWtoK3pXa21CdjZ0eTR5dWRNMDdxNXlvMVR5a2FrenlKa3J6WUJZ?=
 =?utf-8?B?NUhDTXFaQk85V3plRmtVUTU2TW0vdE1KWjQ3R09rQ0hVeXdTKzVBUDNaVjNw?=
 =?utf-8?B?NFVGWFpRMnhMalFoWm5Nem1qZXpMYjVZY09NNVEzTTZkTDdTc080WUpzYnVO?=
 =?utf-8?B?VFRsNUp2SjNiVlY4UWJWS0wwRFp6aVNzZ2Uvb0U0MUVPYWc4d3BVL3FoQlhN?=
 =?utf-8?B?dzZNanNZRUdQZlluRSsweTVhWFFDRTJva3RqenRMRG4vUkttaWZpN1dJNk83?=
 =?utf-8?B?RzhPK1B0bXNPNEFMdno4d0l5MHYwTjZwWXJMQjZhdVpZaUg5ZldzUnlpUEps?=
 =?utf-8?B?bWpZWHhsNEZzbC9nT0c3ajFWczRTK3RrclAvbG1qUVVVclRQQ2Nqd0tqM3FX?=
 =?utf-8?B?aGtaOUlxdzFOQ0xvUVlsTm9RZ2NLMk5TN0pObnliQzQxNlNueFdkOHhDcU4w?=
 =?utf-8?B?WXlJTG9hc3Q4WmhjRi83eTgvdFVXbjV3dTMwNmJWSkpHMTFkUHZIa0phejM4?=
 =?utf-8?B?VmZXZzZydTcyTlFXc0J1QzV5RWFhZDlBSElKUDNEOGxlT2xGb1JzODQ3MWpt?=
 =?utf-8?B?VVhaMTI1cDBUUXdkc0lzb3JrdnV4RDZGVkJRRThKUFJneEkwUTJGVzBadG83?=
 =?utf-8?B?bmo0OW5rZWcwWDJ6a2J6eDU3WHlFVE5yWWZhNGNYWmxtTDVoamw2N0lHR0NQ?=
 =?utf-8?B?VU9kSk5EbkgvVEpKZ09oZjNPUVpEeG5WWkdIYVV3aW5xOW5Nd1VhMlJRRE9C?=
 =?utf-8?B?U1h6VitGYXFjSnRVSTY4VzIvTnZqVm1jdkdkY0VHbzhRQWhaTXlMYmRSWVVO?=
 =?utf-8?B?dWlUbU1oSG5LSXBRRkVLWmVGbDJoRDZubm54ZDcyMStiQTNvQ3RkaFU4MXcv?=
 =?utf-8?B?a2JaazIrMktzZWNrVjVjWS92TmVhQS9UZFFLbXV1eXcrQ1kwb2RtSzNBMTFF?=
 =?utf-8?B?cmxqd0pPaDhKQkZnQjRWOG9nRy9QcTFDNUJueXljNktidGJDU0tKV2EwVmIw?=
 =?utf-8?B?Wm1HaGd2SkVtWlNIblVwT1pTZE5pK1RNUHdLbnM4eU1UdnVlNUcyWGdpamtM?=
 =?utf-8?B?dGYzK0xrM3lObGk0MS9WMHZLNEFkNm16TGhYS2VmQ29WY3pMRnZCMm9TWmYx?=
 =?utf-8?B?cFdzMVd1Vk1FVURpK0dMUUhxU0sweGhuL1NIY0JNenAwbDVTbVEyTWVYelk5?=
 =?utf-8?B?WGtidlljOE9Qd2tBNmk1UWNNL2RJOWlkOFVYdmZQTFA1Q2w1MldNeTZENmVr?=
 =?utf-8?B?S3UwUHp0WitCU1VWMVhEYUF2VXNqWjc2OW5ZYjJJTThkSm52L2JKN3lQKzJK?=
 =?utf-8?B?MHlRQTV0R3hIejg2TzlCSURkMFhxS0ZIZzJLZGpKMWlnOXFwMFFrS3dNZVVL?=
 =?utf-8?B?Qi9Qa3VkTk9uRTlkL3dDZDJlWW9zb25IeXdRYXh4WDJDaFVNUWk5bG1OSFgw?=
 =?utf-8?B?eGwwVzE3NkxYcmRReCswNUU0eUx1bzVyZnJGTjJNOVhPUE1zdE9xeCtrUEdq?=
 =?utf-8?B?NytSaUxxRjRNWHVCT2U5eEdYelB6enhrOXZaUmtRaFg3WGR2ZGk3Unk3VVN4?=
 =?utf-8?B?SHoxM1hGQlpLNUZrejhwZnZnM3dGTHpMeE1BeExJdDcwRm5KdHBnTm95ZkVs?=
 =?utf-8?B?aTZGcndtN09yZ1hKREE0ZXlpNW45anRGSlp6aVhoRkJQMG5XbHcvVmMyMDBx?=
 =?utf-8?Q?6AKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca2bc95-ac33-45ab-7258-08dbbddd72be
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 15:38:21.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xt112o+zoSb0dv+jI1aLxScxi3J6h6lGsIejTValUoDFCdJkzksIvrPrAipiT7G4mm7uMKXLHdMKwF79EczTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
Subject: RE: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device

DQoNCj4gRnJvbTogdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvLWRldkBs
aXN0cy5vYXNpcy1vcGVuLm9yZz4gT24NCj4gQmVoYWxmIE9mIGplc2h3YW5rDQo+IFNlbnQ6IE1v
bmRheSwgU2VwdGVtYmVyIDI1LCAyMDIzIDQ6NDcgUE0NCj4gVG86IHZpcnRpby1kZXZAbGlzdHMu
b2FzaXMtb3Blbi5vcmcNCg0KSSBub3RpY2UgdGhpcyByZXBlYXRlZCBvY2N1cnMgZXJyb3Igb2Yg
Y2hvb3NpbmcgdGhlIG1haWxpbmcgbGlzdCBhcyB2aXJ0aW8tZGV2IGZvciBzcGVjIHdvcmsuDQpJ
IHdpbGwgZml4IHRoZSBPQVNJUyBkb2N1bWVudCByZWZlcmVuY2VzLg0KDQpJbiB0aGUgbWVhbnQg
dGltZSwgdGhlIG1haWxpbmcgbGlzdCBzaG91bGQgYmUgdmlydGlvLWNvbW1lbnRAbGlzdHMuLi4g
Rm9yIHRoaXMgcGF0Y2guDQoNCg0KPiANCj4gSW4gYSB2aXJ0dWFsIGVudmlyb25tZW50LCBhbiBh
cHBsaWNhdGlvbiBydW5uaW5nIGluIGd1ZXN0IFZNIG1heSB3YW50IHRvDQo+IGRlbGVnYXRlIHNl
Y3VyaXR5IHNlbnNpdGl2ZSB0YXNrcyB0byBhIFRydXN0ZWQgQXBwbGljYXRpb24gKFRBKSBydW5u
aW5nIHdpdGhpbiBhDQo+IFRydXN0ZWQgRXhlY3V0aW9uIEVudmlyb25tZW50IChURUUpLiBBIFRF
RSBpcyBhIHRydXN0ZWQgT1MgcnVubmluZyBpbiBzb21lDQo+IHNlY3VyZSBlbnZpcm9ubWVudCwg
Zm9yIGV4YW1wbGUsIFRydXN0Wm9uZSBvbiBBUk0gQ1BVcywgb3IgYSBzZXBhcmF0ZSBzZWN1cmUN
Cj4gY28tcHJvY2Vzc29yIGV0Yy4NCj4gDQo+IEEgdmlydHVhbCBURUUgZGV2aWNlIGVtdWxhdGVz
IGEgVEVFIHdpdGhpbiBhIGd1ZXN0IFZNLiBTdWNoIGEgdmlydHVhbCBURUUgZGV2aWNlDQo+IHN1
cHBvcnRzIG11bHRpcGxlIG9wZXJhdGlvbnMgc3VjaCBhczoNCj4gDQo+IFZJUlRJT19URUVfQ01E
X09QRU5fREVWSUNFIOKAkyBPcGVuIGEgY29tbXVuaWNhdGlvbiBjaGFubmVsIHdpdGggdmlydGlv
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVEVFIGRldmljZS4NCj4gVklSVElPX1RF
RV9DTURfQ0xPU0VfREVWSUNFIOKAkyBDbG9zZSBjb21tdW5pY2F0aW9uIGNoYW5uZWwgd2l0aCB2
aXJ0aW8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVEVFIGRldmljZS4NCj4gVklS
VElPX1RFRV9DTURfR0VUX1ZFUlNJT04g4oCTIEdldCB2ZXJzaW9uIG9mIHZpcnRpbyBURUUuDQo+
IFZJUlRJT19URUVfQ01EX09QRU5fU0VTU0lPTiDigJMgT3BlbiBhIHNlc3Npb24gdG8gY29tbXVu
aWNhdGUgd2l0aA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVzdGVkIGFwcGxp
Y2F0aW9uIHJ1bm5pbmcgaW4gVEVFLg0KPiBWSVJUSU9fVEVFX0NNRF9DTE9TRV9TRVNTSU9OIOKA
kyBDbG9zZSBhIHNlc3Npb24gdG8gZW5kIGNvbW11bmljYXRpb24NCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHdpdGggdHJ1c3RlZCBhcHBsaWNhdGlvbiBydW5uaW5nIGluIFRFRS4N
Cj4gVklSVElPX1RFRV9DTURfSU5WT0tFX0ZVTkMg4oCTIEludm9rZSBhIGNvbW1hbmQgb3IgZnVu
Y3Rpb24gaW4gdHJ1c3RlZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFwcGxpY2F0
aW9uIHJ1bm5pbmcgaW4gVEVFLg0KPiBWSVJUSU9fVEVFX0NNRF9DQU5DRUxfUkVRIOKAkyBDYW5j
ZWwgYW4gb25nb2luZyBjb21tYW5kIHdpdGhpbiBURUUuDQo+IA0KPiBXZSB3b3VsZCBsaWtlIHRv
IHJlc2VydmUgZGV2aWNlIElEIDQ2IGZvciBWaXJ0aW8tVEVFIGRldmljZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEplc2h3YW50aCBLdW1hciA8amVzaHdhbnRoa3VtYXIubmtAYW1kLmNvbT4NClJl
dmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQoNCj4gLS0tDQo+ICBj
b250ZW50LnRleCB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9jb250ZW50LnRleCBiL2NvbnRlbnQudGV4DQo+IGluZGV4IDBhNjJk
Y2UuLjY0NGFhNGEgMTAwNjQ0DQo+IC0tLSBhL2NvbnRlbnQudGV4DQo+ICsrKyBiL2NvbnRlbnQu
dGV4DQo+IEBAIC03MzksNiArNzM5LDggQEAgXGNoYXB0ZXJ7RGV2aWNlIFR5cGVzfVxsYWJlbHtz
ZWM6RGV2aWNlIFR5cGVzfSAgXGhsaW5lDQo+ICA0NSAgICAgICAgICYgICBTUEkgbWFzdGVyIFxc
DQo+ICBcaGxpbmUNCj4gKzQ2ICAgICAgICAgJiAgIFRFRSBkZXZpY2UgXFwNCj4gK1xobGluZQ0K
PiAgXGVuZHt0YWJ1bGFyfQ0KPiANCj4gIFNvbWUgb2YgdGhlIGRldmljZXMgYWJvdmUgYXJlIHVu
c3BlY2lmaWVkIGJ5IHRoaXMgZG9jdW1lbnQsDQo+IC0tDQo+IDIuMjUuMQ0KPiANCj4gDQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2Ny
aWJlQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1h
aWw6IHZpcnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KDQo=

