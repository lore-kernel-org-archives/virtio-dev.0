Return-Path: <virtio-dev-return-11793-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B493C6FD1D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 23:20:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 62520150E41
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 23:20:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA74D9864A3
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 23:20:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5077A98637D; Mon, 27 Mar 2023 23:20:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B9BE98633B;
	Mon, 27 Mar 2023 23:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJwSWJRJ1TcnQMi8lj2kKRjRQ8InY+e//Oai74MkQi4Nd+OQLWrJ45wkKi0yd6ucIZa6f970DkZm2OX28SKfQFkBxOO0axrI8Rijlmdtmfl0BFbF1KZtpNc7CQjPgsjztPc1KEaCbk6gLO/2kWQES9bb+cbgxZZEqzud0fdWlprnSmVbZaxD/WrGDB48ufOnesufiEV2tDFAjpHv7PiZq+a+k+gTN4Mn7PPQFEorlYTK1AIwbaXqcqY9rZgCxQgcjlxAPV2G9bbgauqHkymOg7ydgfI19DMPqv6bg9/2xh4H/AG2kyoMFtGTi+h8Gs7dmOwk4PbYPZ9SrtlsFmTJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGAoyIn+LEVfpANgq8jmh15bLyeJGc8AptQ3AhTapTY=;
 b=GEOHCWJbOzBBJHZ9KreA9i6e5HxHyMGljxvMhRUSjyoKbjIpmBMpXIyKHXyqBWC7lcIfvbDEtGn7aPUtGndtaDgv2RGBxJy8pYQcxShV2wtGEyoKy8je8QFHO4TB6heumFCyVwL9liKclSOdlvGphM+gwbPP4KkVNf9Kjg27nfDLclEyQvGwlixgFTz5MtZ5go7X9IfouNCxnbxq3OMT8+x3fJGk8utBL22OTFzoQjo5g4YUXT90qNxlRPuwl3McLfU/kqFohgHiA8KS2JHkCYLA38c/f27ZBEPT7102JWxysTzxaa7byTKyihLWP3BGtMkeUKpsEHmAbHkwXg6SDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v4 2/8] transport-pci: Refer to the vq
 by its number
Thread-Index: AQHZXQixzE/7exJdNkCid5x4gJ9GZ68PQnEAgAAH3uA=
Date: Mon, 27 Mar 2023 23:19:35 +0000
Message-ID:
 <PH0PR12MB54810F25B0E3069E18C8D9A4DC8B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322215243.249524-1-parav@nvidia.com>
 <20230322215243.249524-3-parav@nvidia.com>
 <68fc71b0-2026-fd99-22f3-d0313e597373@nvidia.com>
In-Reply-To: <68fc71b0-2026-fd99-22f3-d0313e597373@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7133:EE_
x-ms-office365-filtering-correlation-id: 475f505b-9d20-4124-203c-08db2f19bab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hGF2GglBKHYWq6Th3FAGdVEGLYvxjgDgBZfqSUGtaXq2By2fiyK09rRslMDZ/6b6HUSadSn2Uvx5T1YnoKL9NFqwJekj7ar+kPcoivT1GQzKEcVVuAQANZ0uQZwhsvSp+hq5VSbXPXkqq+RfR3Kp1Wc+lInUl3PtVQd7DqyxwRaIxufJhT4cCM4+Da+mLRhSO5nyasU5sAyHuV3RX/HvvZH71M+SKOs9sv2w0aezKKeaZb3y49fGVF7Xo7MVhxGGxikw5VZcrQoUt2fD0IO72KEZYvSlv/kUrrAs3b23g0A1pNUtGITGUQSlMrZK381g+MPH8E7Q/CzB7QDUgS3eiMTyuZS7Pk3JaO7eC8DvPykBZqk/XwkbfffqrF23c0aJK28zVAE6x+bEpafLXNkmuTNPZy1hk85dP3aFElo6ZQYJMiHgHPsoO7xtOySWF/JT1qUPUlN0RHaA0+nt2Ee/3xSjCgtN0LIvwReWecaYLbmMKY2iseYSMYn6A62t99PNonpIaexAvL+fGZeob/IITpU9OksWxM4zjlAkK9VuvE8nccl+mUYv6EPB1DWqt6ELuT3gPSdhDdoVpvn0C3fAQ+DHuh+7b0rNaP5WOMX1gP5lSesXN6AsibRnX1NYwGYr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(38100700002)(7696005)(2906002)(8676002)(71200400001)(122000001)(52536014)(5660300002)(41300700001)(66476007)(66446008)(4326008)(8936002)(64756008)(66946007)(66556008)(76116006)(38070700005)(478600001)(110136005)(54906003)(316002)(83380400001)(86362001)(107886003)(33656002)(26005)(6506007)(9686003)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2pBUy9UTDhmOElqTG15aFFmVlpQdm8yV0g5K1g3eHh3SFFhcnNsTTZwbjl6?=
 =?utf-8?B?c2g3WUpMWEVtY28rcG5Cd2J6QVpUVDk1TEJpR2lIWU1DQmxZV2h6bHpMNWg2?=
 =?utf-8?B?dEx2cjk2S1RYdEU1dUJteEIxRGpiTEFwRTJJazBmelIvM0dSWkx4WXkwQWZ1?=
 =?utf-8?B?QkdIOEpJNUd5MjFkNFV3TUdmY1NnVlZBS2xCMUcwRlNXNUova1NKRlZZMVh5?=
 =?utf-8?B?RU5kUGlQWUk3Z1hNc1MxVGVDQldKVXZFQ3FYcUdSVWxSWEN2cFMxV1A1ZGpk?=
 =?utf-8?B?endvL3F2Sjkzd2J6ZFRWc1ZkNlZoMWk4S1loeExuVERjSlhtZUR0MEpnc1la?=
 =?utf-8?B?bTdpcTZLK0VWeGdFWlB1eGszWnY0bkUrblZQdjc4OGc2QldIUGthQUZObU1k?=
 =?utf-8?B?OXlFQXYrbjhlSmprREtVU2UwOHgxcWgvdVd1cHQzRjFRbEdlVlB4VFBrMEtO?=
 =?utf-8?B?MC9kUTR0YnU0Y3ExUWpmRXZBVlZseURtZG01ekVOVWx3ZDR6cFZCOUdNVDVO?=
 =?utf-8?B?d1VCV3U2ZmZFaUFPQWNDZkZiVmRXR0ZVODdtRWhSMHZZQjZWaEo4TEtQRm93?=
 =?utf-8?B?TFR0aDhxQ0p1Z0JxVG02Yk5VMjE2aitETzBvV1RncjRrLy9LYldRQm1LeFhs?=
 =?utf-8?B?MWcvK0JFVU0rZDNJOXBXQXhxY2dVTTYxTkRRZjZ3YWdsQXFmamtOOWlseis4?=
 =?utf-8?B?MlRlZUNDRjRCZ2NIczRYYW8weklUWWtWUThWWlVZck8rd1pvbkRTcW1Bajk3?=
 =?utf-8?B?S3VBc3hramhmZkF0Q1IrV05rdVBxLzY1M2drT0pCbWxBbTBFL1NUcTBHa1J5?=
 =?utf-8?B?dW1UV29HWTRyL2F2SHUxZGYySEZoMjhzWTZDbDJ0UlYzVm11R2t5b0hBRGk0?=
 =?utf-8?B?cGttR25rS0ZET1lFQ2I3dFdxeVRNRU1MVERKVk05VTV1MG42TlR4N2lUMVQz?=
 =?utf-8?B?bWpLZGdBSkNjUGVCMW8vT3FrenJvNlNhazQ0YmVTTjArQmJSeS9mbTdKbmFl?=
 =?utf-8?B?aStqWFpZTmlFN2ZYT3h4aHhremYrYUJrWmZSbUpVU2hpd2dheTBlMEI1VWlO?=
 =?utf-8?B?SW1uNTIydTdjd2ZwYjVIcXlEb0ZxbGxzaTRkTTgxQVMzOVV2ejhiWmZOQitQ?=
 =?utf-8?B?TTE2c05BNWJPOXJ2RkZHTUY2UFR3NnJTcGl3M09MbVRObGJaMTZLL1NHdTRa?=
 =?utf-8?B?YTFqTGhkK2tpdi9TOGJScVJFNExzYUVhaTIzMG5rZXEvMDY3czJua2JTNDFD?=
 =?utf-8?B?Y2VzQ2Q5RUx2dWtWWWNpd1A5VEx5d3RyTDFYbXZ2VjFOaU9HTkxSQ1lPd05r?=
 =?utf-8?B?bGlWSGQxNUVUK2YwYkd2TkptMlAvQ05PWnRRaUFTUTJLVkRpdEl5a0tMTUI0?=
 =?utf-8?B?bDk3bzRMN1VxUXI2OGdDOU5mNVRkK05lYTI0VWNMVGpnK29xZW9UN1BoNkds?=
 =?utf-8?B?ZUxTeCs1REdQN2hONWl0aVdtaHBmVTcvWDhzbXAzSW9sdG8weFovVlNtQXhD?=
 =?utf-8?B?cHFGUkRqejdmcHBWdUpRREFVd0tVb1VXZEw5WTdNN0JIVTE5VmdyVS9sVGhB?=
 =?utf-8?B?MzRPS045VERoY09ESW41WUlWOFcwYjQ0RGJ0NWtTT3RRWjBvYmFRNWExa1Zn?=
 =?utf-8?B?bXNLM2I5S0o0dUl0SGtQeUNmcFBORkQ4WWE3enRRVmNNVmgzQS90R1FCM01a?=
 =?utf-8?B?ZEZPRGtPMWQ1Y0R5VHZ2U2NLNnZuUnVJc0tyWVp1cWJiajdZRWUyNDRWMGUw?=
 =?utf-8?B?aGs0ZGlyQ0lzMWVBRlRKTllTMDZvcUt5K09DMFFoQkVnbE9hb2ZDZHIxR3pj?=
 =?utf-8?B?OEYyUm40Sk5ERkR4ZzJMLzUzM1c5eDQ5WTdWeTRPajV3d0pEek13a1JsNkUv?=
 =?utf-8?B?a1JMMWRuRzBQTks0WmhnL05SNytZWm4vbXR1N0V4RmlRVXVnbGRRSGlJa0xW?=
 =?utf-8?B?blFuZEREeG5ndk44a0pvcUt3dUttd0wxMEd4TTlESm50bkczSTdhNUhsWHd5?=
 =?utf-8?B?WmJRZGhiNXNjd2ZlZFZ0bkpDWlRoL1hNamdYRURPODZnUW10Uk5qZWtkaG1q?=
 =?utf-8?B?YlFhdlNUL2NtYTBSeFMvSmpRbkdJaVJaelZ0NWZDZkNTQmtXRWZodTJEdHo0?=
 =?utf-8?Q?N7i4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f505b-9d20-4124-203c-08db2f19bab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 23:19:35.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hce2jLmbyr1H6KnP66mwENbIxvZWTNyN2ZZErHJInXfreinHCW88JG0p4fSkbQlVT+Byd7zLxr425OW2lax4Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v4 2/8] transport-pci: Refer to the vq by
 its number

DQoNCj4gRnJvbTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4NCj4gU2VudDog
TW9uZGF5LCBNYXJjaCAyNywgMjAyMyA2OjQ5IFBNDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9jb250
ZW50LnRleCBiL2NvbnRlbnQudGV4IGluZGV4IDFhYjc3OTQuLjBmNjM0YWMgMTAwNjQ0DQo+ID4g
LS0tIGEvY29udGVudC50ZXgNCj4gPiArKysgYi9jb250ZW50LnRleA0KPiA+IEBAIC0zMjEsNyAr
MzIxLDcgQEAgXHNlY3Rpb257VmlydHF1ZXVlc31cbGFiZWx7c2VjOkJhc2ljIEZhY2lsaXRpZXMg
b2YgYQ0KPiBWaXJ0aW8gRGV2aWNlIC8gVmlydHF1ZXVlc30NCj4gPiAgIFZJUlRJT19GX0lOX09S
REVSIGZlYXR1cmUuIElmIG5lZ290aWF0ZWQsIHRoaXMga25vd2xlZGdlDQo+ID4gICBtaWdodCBh
bGxvdyBvcHRpbWl6YXRpb25zIG9yIHNpbXBsaWZ5IGRyaXZlciBhbmQvb3IgZGV2aWNlIGNvZGUu
DQo+ID4NCj4gPiAtRWFjaCB2aXJ0cXVldWUgaXMgaWRlbnRpZmllZCBhcyB2cSBudW1iZXIgb3Ig
YWxzbyByZWZlcnJlZA0KPiA+ICtFYWNoIHZpcnRxdWV1ZSBpcyBpZGVudGlmaWVkIGJ5IGEgdnEg
bnVtYmVyIG9yIGFsc28gcmVmZXJyZWQNCj4gPiAgIHRvIGFzIGEgdmlydHF1ZXVlIG51bWJlcjsg
dnEgbnVtYmVyIHJhbmdlIGlzIGZyb20gMCB0byA2NTUzNS4NCj4gPg0KPiANCj4gUGxlYXNlIHNx
dWFzaCB0aGlzIHRvIHBhdGNoIDEvOCB3ZXJlIHlvdSBpbnRyb2R1Y2VkIHRoaXMgbGluZS4NCj4g
DQpMYXRlc3QgdjcgZG9lc250IGhhdmUgdGhpcyB3cm9uZyBodW5rIGhlcmUuDQoNCj4gDQo+IA0K
PiA+ICAgRWFjaCB2aXJ0cXVldWUgY2FuIGNvbnNpc3Qgb2YgdXAgdG8gMyBwYXJ0czoNCj4gPiBk
aWZmIC0tZ2l0IGEvdHJhbnNwb3J0LXBjaS50ZXggYi90cmFuc3BvcnQtcGNpLnRleCBpbmRleA0K
PiA+IGIwN2E4MjIuLjA0NGMwODUgMTAwNjQ0DQo+ID4gLS0tIGEvdHJhbnNwb3J0LXBjaS50ZXgN
Cj4gPiArKysgYi90cmFuc3BvcnQtcGNpLnRleA0KPiA+IEBAIC0zOTAsMTMgKzM5MCwxNSBAQCBc
c3Vic3Vic2VjdGlvbntDb21tb24gY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUNCj4gPiBsYXlvdXR9
XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+ID4NCj4gPiAgIFxpdGVtW1xmaWVsZHtxdWV1
ZV9ub3RpZnlfZGF0YX1dDQo+ID4gICAgICAgICAgIFRoaXMgZmllbGQgZXhpc3RzIG9ubHkgaWYg
VklSVElPX0ZfTk9USUZfQ09ORklHX0RBVEEgaGFzIGJlZW4NCj4gbmVnb3RpYXRlZC4NCj4gPiAt
ICAgICAgICBUaGUgZHJpdmVyIHdpbGwgdXNlIHRoaXMgdmFsdWUgdG8gcHV0IGl0IGluIHRoZSAn
dmlydHF1ZXVlIG51bWJlcicgZmllbGQNCj4gPiAtICAgICAgICBpbiB0aGUgYXZhaWxhYmxlIGJ1
ZmZlciBub3RpZmljYXRpb24gc3RydWN0dXJlLg0KPiA+ICsgICAgICAgIFRoZSBkcml2ZXIgd2ls
bCB1c2UgdGhpcyB2YWx1ZSB0byBwdXQgaXQgaW4gdGhlIGZpZWxkDQo+ID4gKyAgICAgICAgXGZp
ZWxke3Zxbn0gaW4gdGhlIGF2YWlsYWJsZSBidWZmZXIgbm90aWZpY2F0aW9uDQo+ID4gKyAgICAg
ICAgc3RydWN0dXJlLg0KPiANCj4gd2h5IGRvIHlvdSBhZGQgbmV3IGxpbmVzIGhlcmUgYW5kIGJl
bGxvdyA/DQo+DQpXaWxsIGZpeCBpbiB2OC4NCkJlbG93IGxpbmUgYWRkaXRpb24gaXMgZHVlIHRv
IGV4aXN0aW5nIGxpbWl0IG9mIDY0IG9yIDY1IGNoYXJzIHBlciBsaW5lLg0KIA0KPiA+ICAgICAg
ICAgICBTZWUgc2VjdGlvbiBccmVme3NlYzpWaXJ0aW8gVHJhbnNwb3J0IE9wdGlvbnMgLyBWaXJ0
aW8gT3ZlciBQQ0kgQnVzIC8gUENJLQ0KPiBzcGVjaWZpYyBJbml0aWFsaXphdGlvbiBBbmQgRGV2
aWNlIE9wZXJhdGlvbiAvIEF2YWlsYWJsZSBCdWZmZXIgTm90aWZpY2F0aW9uc30uDQo+ID4gICAg
ICAgICAgIFxiZWdpbntub3RlfQ0KPiA+ICAgICAgICAgICBUaGlzIGZpZWxkIHByb3ZpZGVzIHRo
ZSBkZXZpY2Ugd2l0aCBmbGV4aWJpbGl0eSB0byBkZXRlcm1pbmUgaG93DQo+IHZpcnRxdWV1ZXMN
Cj4gPiAgICAgICAgICAgd2lsbCBiZSByZWZlcnJlZCB0byBpbiBhdmFpbGFibGUgYnVmZmVyIG5v
dGlmaWNhdGlvbnMuDQo+ID4gLSAgICAgICAgSW4gYSB0cml2aWFsIGNhc2UgdGhlIGRldmljZSBj
YW4gc2V0IFxmaWVsZHtxdWV1ZV9ub3RpZnlfZGF0YX09dnFuLiBTb21lDQo+IGRldmljZXMNCj4g
PiArICAgICAgICBJbiBhIHRyaXZpYWwgY2FzZSB0aGUgZGV2aWNlIGNhbiBzZXQNCj4gPiArICAg
ICAgICBcZmllbGR7cXVldWVfbm90aWZ5X2RhdGF9PXZxIG51bWJlci4gU29tZSBkZXZpY2VzDQo+
ID4gICAgICAgICAgIG1heSBiZW5lZml0IGZyb20gcHJvdmlkaW5nIGFub3RoZXIgdmFsdWUsIGZv
ciBleGFtcGxlIGFuIGludGVybmFsDQo+IHZpcnRxdWV1ZQ0KPiA+ICAgICAgICAgICBpZGVudGlm
aWVyLCBvciBhbiBpbnRlcm5hbCBvZmZzZXQgcmVsYXRlZCB0byB0aGUgdmlydHF1ZXVlIG51bWJl
ci4NCj4gPiAgICAgICAgICAgXGVuZHtub3RlfQ0KPiA+IEBAIC0xMDA1LDcgKzEwMDcsNyBAQCBc
c3Vic3Vic2VjdGlvbntEZXZpY2UNCj4gSW5pdGlhbGl6YXRpb259XGxhYmVse3NlYzpWaXJ0aW8g
VHJhbnNwb3J0IE9wdGlvbnMgLyBWaXJ0aQ0KPiA+ICAgVGhlIGRyaXZlciB0eXBpY2FsbHkgZG9l
cyB0aGlzIGFzIGZvbGxvd3MsIGZvciBlYWNoIHZpcnRxdWV1ZSBhIGRldmljZSBoYXM6DQo+ID4N
Cj4gPiAgIFxiZWdpbntlbnVtZXJhdGV9DQo+ID4gLVxpdGVtIFdyaXRlIHRoZSB2aXJ0cXVldWUg
aW5kZXggKGZpcnN0IHF1ZXVlIGlzIDApIHRvIFxmaWVsZHtxdWV1ZV9zZWxlY3R9Lg0KPiA+ICtc
aXRlbSBXcml0ZSB0aGUgdmlydHF1ZXVlIG51bWJlciAoZmlyc3QgcXVldWUgaXMgMCkgdG8gXGZp
ZWxke3F1ZXVlX3NlbGVjdH0uDQo+ID4NCkkgbm90aWNlZCBtZW50aW9uaW5nIG9mIGZpcnN0IHF1
ZXVlIGhlcmUgd2hpY2ggaXMgbm90IHJlbGF0ZWQuDQpTaW1pbGFyIGNsZWFudXAgdGhhdCBTdGVm
YW5vIHN1Z2dlc3RlZC4NCkZpeGluZyB0aGlzIGluIHY4IHRvby4NCg0KPiA+ICAgXGl0ZW0gUmVh
ZCB0aGUgdmlydHF1ZXVlIHNpemUgZnJvbSBcZmllbGR7cXVldWVfc2l6ZX0uIFRoaXMgY29udHJv
bHMgaG93IGJpZw0KPiB0aGUgdmlydHF1ZXVlIGlzDQo+ID4gICAgIChzZWUgXHJlZntzZWM6QmFz
aWMgRmFjaWxpdGllcyBvZiBhIFZpcnRpbyBEZXZpY2UgLw0KPiBWaXJ0cXVldWVzfX5cbmFtZXJl
ZntzZWM6QmFzaWMgRmFjaWxpdGllcyBvZiBhIFZpcnRpbyBEZXZpY2UgLyBWaXJ0cXVldWVzfSku
IElmDQo+IHRoaXMgZmllbGQgaXMgMCwgdGhlIHZpcnRxdWV1ZSBkb2VzIG5vdCBleGlzdC4NCj4g
PiBAQCAtMTAzNSw3ICsxMDM3LDcgQEAgXHN1YnN1YnNlY3Rpb257QXZhaWxhYmxlIEJ1ZmZlcg0K
PiA+IE5vdGlmaWNhdGlvbnN9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0IE9wdGlvbg0KPiA+
DQo+ID4gICBXaGVuIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGhhcyBub3QgYmVlbiBuZWdv
dGlhdGVkLA0KPiA+ICAgdGhlIGRyaXZlciBzZW5kcyBhbiBhdmFpbGFibGUgYnVmZmVyIG5vdGlm
aWNhdGlvbiB0byB0aGUgZGV2aWNlIGJ5DQo+ID4gd3JpdGluZyAtdGhlIDE2LWJpdCB2aXJ0cXVl
dWUgaW5kZXgNCj4gPiArdGhlIDE2LWJpdCB2aXJ0cXVldWUgbnVtYmVyDQo+ID4gICBvZiB0aGlz
IHZpcnRxdWV1ZSB0byB0aGUgUXVldWUgTm90aWZ5IGFkZHJlc3MuDQo+ID4NCj4gPiAgIFdoZW4g
VklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEgaGFzIGJlZW4gbmVnb3RpYXRlZCwgQEAgLTEwNTMs
Nw0KPiA+ICsxMDU1LDcgQEAgXHN1YnN1YnNlY3Rpb257QXZhaWxhYmxlIEJ1ZmZlciBOb3RpZmlj
YXRpb25zfVxsYWJlbHtzZWM6VmlydGlvDQo+IFRyYW5zcG9ydCBPcHRpb24NCj4gPiAgIElmIFZJ
UlRJT19GX05PVElGX0NPTkZJR19EQVRBIGhhcyBiZWVuIG5lZ290aWF0ZWQ6DQo+ID4gICBcYmVn
aW57aXRlbWl6ZX0NCj4gPiAgIFxpdGVtIElmIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGhh
cyBub3QgYmVlbiBuZWdvdGlhdGVkLCB0aGUNCj4gPiBkcml2ZXIgTVVTVCB1c2UgdGhlIC1cZmll
bGR7cXVldWVfbm90aWZ5X2RhdGF9IHZhbHVlIGluc3RlYWQgb2YgdGhlDQo+IHZpcnRxdWV1ZSBp
bmRleC4NCj4gPiArXGZpZWxke3F1ZXVlX25vdGlmeV9kYXRhfSB2YWx1ZSBpbnN0ZWFkIG9mIHRo
ZSB2aXJ0cXVldWUgbnVtYmVyLg0KPiA+ICAgXGl0ZW0gSWYgVklSVElPX0ZfTk9USUZJQ0FUSU9O
X0RBVEEgaGFzIGJlZW4gbmVnb3RpYXRlZCwgdGhlIGRyaXZlcg0KPiBNVVNUIHNldCB0aGUNCj4g
PiAgIFxmaWVsZHt2cW59IGZpZWxkIHRvIHRoZSBcZmllbGR7cXVldWVfbm90aWZ5X2RhdGF9IHZh
bHVlLg0KPiA+ICAgXGVuZHtpdGVtaXplfQ0KPiANCj4gSW4gZ2VuZXJhbCwgYWZ0ZXIgZml4aW5n
IHRoZSBhYm92ZSBtaW5vciBjb21tZW50cyAtIGxvb2tzIGdvb2QuDQo+IA0KPiBSZXZpZXdlZC1i
eTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4NCg0KVGhhbmtzLiBXaWxsIGFk
ZCB5b3VyIFJCIGluIHY4IGZvciB0aGlzIHBhdGNoLg0KDQo=

