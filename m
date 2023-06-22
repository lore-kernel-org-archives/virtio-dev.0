Return-Path: <virtio-dev-return-13039-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3104EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 14:27:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4187D42829
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 14:27:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3329F9866D7
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 14:27:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 25F0F98626D; Thu, 22 Jun 2023 14:27:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C3CD9865D0;
	Thu, 22 Jun 2023 14:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn9orHdvVGeswNxoLG73xilWhnKDUEwm4dQ0wBvY5SkmIWZmdrJ+bng/6xag2ZfsYbvaJxeMAzooSlmtnFYaCihShP9B/l237IhaU75BN7ggLgVFP/xZcr8bnRrtoDCo6H8YWblg5KX1bkYhUn9SRRA2U+o0DzG++IA8WFItQIM4h2kOeib4h2avRX2kxb0Jg5v3ja0lOYnQ0Iij6IlmNpFnSPnRYoq/T7K6s0Dp/Tv07GkVLDHSNfFZbXzwYm4RtjnwYR3b0W44T+sVbD5ZsD/D3zFu0VsS83tkJL8UnrWw4rVLwP62UcNBue5yNeRgTugimbIEnf5+8hIXq8DXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPCIHbPDVpIteLFcQQmsHkmwEIRnLDJBPVIifyxf6Sc=;
 b=n0+Rq3lSI0uQwoemgHKTK6mtutYBZMiXUfIXfX6x2e36V5rRnZ2PG3oXTxqjBOp+w9/zW0lodfnczX0V9igxDz37BGSTtgArsY07q2J9B5i3be2u+/gelEYAAxgbdGVbvGnOlk+sqn09a9KGrTixblbHz7nlM64Va/HeW2M5e1//1FRc68FCDaan+DGYEzlrz3F0aKm4NFq7ah8XxoKWK7VS8tjEoLbZWuUuBS6f38IV8BQvqh6SxoerCWFVpQ8ZVqnv3w9F+o/L4+fc03jTKr6r764OkodAunt8F56T712D89nR8MbaIqvmmQINg5byrkwgPhNy8iKEax+SiOElLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggAAXcACAAAvqkA==
Date: Thu, 22 Jun 2023 14:27:31 +0000
Message-ID:
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
In-Reply-To: <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5128:EE_
x-ms-office365-filtering-correlation-id: 9bda2ad9-f98d-41a6-6b2b-08db732cd07a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 91K7nstgDBLjlryQsocHS2silwrIywgH4lg7c56Ebe1NJsGY7uwe8NJXfsR7MJ2wLJwLItmEuPnykLJcNZvx0wEcLuoDfQ63e6N/4Bv7w6CN6trD4f672kQf07Jv9znAKkMaFp46ObY825PZcK4WjOVKqqEWSN9mRhvY4DlvtI+y7/BwgkR2rjJxRKRazCGqZVfESfSvpNIm5hIKRbedZML1Q1VqJbOhDsvBw3dp66IZ8ZOw5N3cBtBTiP9RiiTjcMfwO7Rmoq5tqz8LLhdprazUQufR/peLxN5pI8MlZkGNhnNcwbf6iXIKNw6uSsa5P4AYmSWKDAysJv7JkqW5jV5pq7wPk3abEmWeWKZh35spRwn56PqjKnif4nXdCmbBGzCxsNqzBPIqAbtJapbkCIpgQOBD7US/G7Grs7TztheN37cXXwR3bbTQ9h6xNEkVbFqn5hqUo0cilMAL2RqK96J2y9PF4zSVTQIsjCm3Ea+lf1iIQwxkSNNjpbHYx4GbuAp1mOSGQCQLyvAx0RenkfisUtRtzTDQ9bKHOOWXZlvcfhYt43q9S0TrSHKhFFJTCEDvr8L4P9O+ohsecLsLhCvuLp/v9H2iwBloaZ9gXRtJFfqk0Twg0mrNDPabehjE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(38070700005)(55016003)(86362001)(38100700002)(8676002)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(41300700001)(4744005)(52536014)(5660300002)(7696005)(6506007)(478600001)(71200400001)(4326008)(76116006)(186003)(26005)(9686003)(54906003)(110136005)(122000001)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1p0M1FPNCtmUmcvTWdpamg1cDJjRzdnNWVKOU4xYmd4djBZY0gzOVZXT1lt?=
 =?utf-8?B?WStGZHY4VjNhUW9teTJtbnY4UzRCUFF2SUwwVGpIWkt2bXJTRkJwYStSalRl?=
 =?utf-8?B?TXd1dDJ6Q21JdTkvd1BnNXUzUWdWVzRVNzJvK2lIOHB3dEpoVzc2SXNpb21w?=
 =?utf-8?B?QU1IeWdRZm0zTE5WRmh2ZjlZNW5YU0tEc0lKbXQvY0dRSkNyOWs0WnFxVzFZ?=
 =?utf-8?B?OUlTQ3UwVDEyWXdRZHFhdExlMU5YMUVGQW5TMWM4RVN4WFBPQktEdFlXcEFw?=
 =?utf-8?B?Ukc0VGV5YzdicGRRakFVZVF6NG9kKzlCNW9sdUFrcmY5TjQ2L0xFbjBqUnlk?=
 =?utf-8?B?QVBRV1dDRFJlNHVNZmMydkt2d3UvUmttL0NSZ3FwQVNFSlYzQnlQeS9pS2Ju?=
 =?utf-8?B?cGJ1d0tjTzNMaUlWTjQ0TjBreGhucVNoUmt5R0d5ZHdXSm9mbU1GZ2dDenF0?=
 =?utf-8?B?Mjh6UkVXeHhlMGVMdHdiY1Vrb3I4RFZxb3AyM2ZpblM5ZGV2QlVhbDVNblZx?=
 =?utf-8?B?Y216U0pqWlFHcVpkUEFhdmNCU1ZXZUxuR1BmL0lhTVRodWxacmZUaTRPT1Er?=
 =?utf-8?B?UVdHUlFzSHVneXJ1SVpCRUEySXVuLzRHWGsyZDdWQmZ5QWJ3TjFUSWFMTUli?=
 =?utf-8?B?S2FxRXdTMlFmN2g2SE1UWGJJL3Ezc3pnb0pYRU1XZm5QVDRnbkh2M1h3Q0ZC?=
 =?utf-8?B?cnRMWUU5bEJNQ2xFdFZMTUprVWlTaHU0UnRnZjgyOEFwaC9oM01MaXluNERo?=
 =?utf-8?B?U0FLb3RkekwvOEdyMjdldkNROHQ2VlMxQWx4bVk5TlJSc1lwckd5eWFvbWFL?=
 =?utf-8?B?NDBMVnJ0VXBZbDNXR05NOExjT0pBUEYwdmZFTTZtYjZhUnlteUZlQ05mUVo1?=
 =?utf-8?B?ZHZGT09XRUtBWUxQZ3lFZHlqUkdqZGNPNDdRTnEwZ2JwNTNEVUJxYTg3cGJ5?=
 =?utf-8?B?dzF2V2p2Y0JSdFAyVU1LeWxMS2dxQzlkcmpjUnU3bE03NFR3N0tNZis3ZnBS?=
 =?utf-8?B?MlFDSUpqZUFkTnFIWXhxVUZBTndJMWFzeFVjbGRTSmJUZFc3UTdpS3laL014?=
 =?utf-8?B?YmtxR3RSbUZxZ05lRzNyaTRxSUpBbDZheDQvYkJaSTNlS3VITlVaTnlDY3hZ?=
 =?utf-8?B?bmkxN3dGWEVRUEhJcW9RbFNxdVhzeW8yVGVBaVZuYy9HMzFqcEhQK0Uyb0hK?=
 =?utf-8?B?d28rWUJBWUlxNWpaaHgvdklQQzV3dWRYVmNGM2RWRGhhdmR2cWZoekdiNzdQ?=
 =?utf-8?B?OW1uSkNXamdKUVp6SlpIUTcwQnZZZUJwNElRR3Qrc2RQQjJqVU4rM28zWVBu?=
 =?utf-8?B?TnNqZVg4amFOdmRLMUNrNHZOaG1qVFJETjVJOUF0NlVSb0JzSzVKNEZCdGla?=
 =?utf-8?B?dGtnd3d1bk8wUGZxWXZlcEVHbjVFTTdCNlBNcTA0Qko1OElnR2RQUElpZGtT?=
 =?utf-8?B?Qjl6QXZtU0JEN1pFd1RLV0NRV3RXcUoxVnVaNGJ6emdHYlFsZ2htZHJwVW90?=
 =?utf-8?B?clduNGdzRG5HK0sxOWY4am91ZGIwUnlCcGtla0lldVdRZzlnSS9pdk5OQ2Vk?=
 =?utf-8?B?RVM1MjFDVXpBUTgzUlcvek1OdzNwNnBQbERHYThQUXF5RDlMM09FTy9PRFlG?=
 =?utf-8?B?T1BKVHk4ZDNCR3g4UFBDR0JJWHdOZWtzVDQ3b3E2czdPeEFsczluY0ZPVG9Q?=
 =?utf-8?B?TDlPNk0ycmx4Q1RPNGQ0Y2pwS2xWYUd4TEdEVThzU0tZdmJobG5xRVhHUVdH?=
 =?utf-8?B?ZXlLcU4zUWlpZk93T3ZwckxSa2dWQ1Zod3NNeEtvMU5SejNqYllRRWhtTmMz?=
 =?utf-8?B?RmZhNnFuKzB6clIvQUJKUFFaaHlkS0FpajlYZlpjeTNCWmpNYjhNaUZFdldJ?=
 =?utf-8?B?VkErdEIvbHErWFhMMXBDaEFHMGdFQm5TZTFuQ1BQcTJDV05mWTh6U0piNE05?=
 =?utf-8?B?Y1V5dm40OVFCS2dhTUlkTzZDaStScE9mQjMycG1Pc2t1Nk01WS8yWnpzN3JF?=
 =?utf-8?B?VStCUHNIODdQYnZZUmpqOWJ4aE05UnVCdXhOWjlwU0ZOV2FJdFk0OGxMTzdD?=
 =?utf-8?B?bDRTelRCU1VKblN3R29IZWc2TmNnNGprYzBMNU9zOGFCY29IZXV2S0FBMkZG?=
 =?utf-8?Q?sVo8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda2ad9-f98d-41a6-6b2b-08db732cd07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 14:27:31.6077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTzZnXzeAcHsK1isl1Vu9VFV/QX25DmVYCf51JQDBcgcNTrxVg7gFCrkG2MwJ7twE5puXs77pUlFXk77EOPqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash

DQoNCj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgSnVuZSAyMiwgMjAyMyA5OjQzIEFNDQo+IA0KPiBZZXMsIEkgdGhpbmsgd2UgYWxz
byBoYXZlIHRvIGNvbnNpZGVyIHVwY29taW5nDQo+ICDCoMKgwqAgMS4gZGV2aWNlIGNvdW50ZXJz
IChlLmcuIHN1cHBvcnRlZF9kZXZpY2VfY291bnRlciksDQo+ICDCoMKgwqAgMi4gcmVjZWl2ZSBm
bG93IGZpbHRlcnMgKGUuZy4gc3VwcG9ydGVkX2Zsb3dfdHlwZXMsIHN1cHBvcnRlZF9tYXhfZW50
cmllcyksDQo+ICDCoMKgwqAgMy4gaGVhZGVyIHNwbGl0cyAoZS5nLiBzdXBwb3J0ZWRfc3BsaXRf
dHlwZXMpIGV0Yy4NCj4gQ29udGludW91cyBleHBhbnNpb24gb2YgdGhlIGNvbmZpZ3VyYXRpb24g
c3BhY2UgbmVlZHMgdG8gYmUgY2FyZWZ1bC4NCj4gDQo+ID4NCj4gPiBJbnN0ZWFkIG9mIGRlY2lz
aW9uIHBvaW50IGJlaW5nIFJPIHZzIFJXLCBhbnkgbmV3IGZpZWxkcyB2aWEgY21kdnEgYW5kDQo+
ID4gZXhpc3RpbmcgZmllbGRzIHN0YXlzIGluIGNmZyBzcGFjZSwgZ2l2ZSBwcmVkaWN0YWJsZSBi
ZWhhdmlvciB0byBzaXplIHRoZSBtZW1iZXINCj4gZGV2aWNlcyBpbiB0aGUgc3lzdGVtLg0KPiA+
IE9uY2UgdGhlIGNtZHZxIGlzIGF2YWlsYWJsZSwgd2UgY2FuIGdldCByaWQgb2YgR0VUIGNvbW1h
bmQgdXNlZCBpbiB0aGlzDQo+IHZlcnNpb24gZm9yIG5ldyBmdXR1cmUgZmVhdHVyZXMuDQo+ID4g
VGlsbCB0aGF0IGFycml2ZXMsIEdFVCBjb21tYW5kIGlzIHRoZSBlZmZpY2llbnQgd2F5Lg0KPiAN
Cj4gWWVzLCBJIGFncmVlLg0KPiANCj4gVGhhbmtzLg0KDQpSaWdodC4gU28sIE1pYWNoZWwgbWFp
biBjb25jZXJuIHdhcyB0d28gdnMgb25lIHN0cnVjdC4NCkFuZCBnaXZlbiB0aGUgR0VUIGFuZCBT
RVQgd29ya3Mgb24gZGlmZmVyZW50IGZpZWxkcywgaGF2aW5nIHR3byBzdHJ1Y3R1cmUgaXMganVz
dCBmaW5lLg0KVGhlIGNvZGUgaXMgZmFpcmx5IHNtYWxsLg0KSSBkb27igJl0IHNlZSBhbnkgcmVh
bCBpc3N1ZSBoZXJlIHdpdGggdjE4Lg0KDQo=

