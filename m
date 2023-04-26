Return-Path: <virtio-dev-return-12434-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A32C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:24:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 57E9D29FCD
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:24:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5342A98666B
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:24:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 45D8D98663C; Wed, 26 Apr 2023 14:24:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3237C98663F;
	Wed, 26 Apr 2023 14:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5Ad0Xhl8yKU56MsKveORL/M9LGzLJaK1y7t/AGOWJxyzg/9EfrUNKlzk8y1Vyg6Z5T//wA72ylaszTxNgbNQl1P0awtlYL2EbJ8qyWag/X/2o0FA7ww5qBpcn5biqfu8CnBHRj/vKDelo0TfUZ2bJL0K71qsonSdGvI9bBpb4HK4qZD8e4yXkhAXKLO4XVsk8wv9ElAOp6zqVF0T+E0Xwacgmb5zCPxC1ZwgV59PQ0GZO9KRVJtgjjr/D2sP3izdgiuBghzs3O46mf6TF0/3VdbA4zscZNPpr6ZhJILiU9QHC1APM4b+yPc1oHOGrOQbOCJS0NUYgRkGfBq2UWLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT+mTEKsjpRgfH9GYUspvg88OG8nLATLjtwn1+By/QY=;
 b=XrVsLzk3kTnGOYfsykpx8CbLtNkZzIp9KVL9J5cn77MnVQTyJPeK9QVSb+mgTm0Zap7fYHNwf5nIWgOmCPNOdY4tCZsyIOwQznbn5Ma+naovKP8ZU/xRjkm9UAYyAJc4Noj2g3VMLnudghCqciDUv3SOAVBmlUEXyYNmGNqWKJLXpLXwgFZPnA+35JlgnxKFINCPZmEaX72NfB1s7sULr7TByILzdVl2YDqBZCZkZkuRnEinfQYaDQqjfWJh3POjHcA/VGX5KEHyh/+rer7Q5dupaJ6yGSukQp4uAD8avQcv5wTeskUsimeoYmPwe82v9q2AI0/DcwbKsGLsVAc/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v13] virtio-net: support inner
 header hash
Thread-Index: AQHZdbY0vUbPhs5ETkuums+/PkRABq88fZaAgAEg8YCAAABEcIAABYoAgAAAppA=
Date: Wed, 26 Apr 2023 14:24:48 +0000
Message-ID:
 <PH0PR12MB54817E0B2B0B232B49320F5CDC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
 <PH0PR12MB5481EA937633233A9A9E5E30DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1d0adb7d-fcc8-404d-8105-bc1f818bc3a3@linux.alibaba.com>
In-Reply-To: <1d0adb7d-fcc8-404d-8105-bc1f818bc3a3@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB8362:EE_
x-ms-office365-filtering-correlation-id: 2f581376-946f-4074-7058-08db4661fdcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 woYw8NUuSCMYGNO7k6HlNvl3M/WD0QT0WZdtyKBB9epd2IPfPi/vheNVocs7HR9qCZbAfeWy2N25IkYNNWdQvu/XCZRZSHwgIsLA1VxaKYqW+NZMfN6VUgtwx8o0Jt0CcCuaAXkiMCCg50qrU/Y8HUkn/p3bcTnTMInYOGh0VG82ZpKuaHii3CV1PgbWd1XMP3pmqXJ9BzpJA8pMsxkpBBenQ1nVmcogSaGS9I3Svp3gu60obj+ICQt1VFz2lB3tb7yagJ/TigXgJbC8VzjfgSAB22L3Viz8dbdUDey2y1kQw23h5zoUWyj9Ci5gBr3qQE5KKohqrKDG5I7dhgNfjHxgAYQs/TdpWIk+NGqp8OA2pTxpyrRBj5hSFprVJfIB1+5hPAaVNlE4bqekxCDCzYcDx5gYjWgbhse2CiOSZVQ+aMT/aC9ge21ukjqwPVUsytBsXstIp6FNNdQGF2/QWvi4m+w+w4Y+lhLiiIPiL8henKuyoRdO7+5PtV8zurAeaR+8CFgud+Jtn070KV5d4Pnu2fTzKFbEk8YLYQrteoDfEC2f6V53Nqcqim+oFweAuz9bjpFIhS5rmpZhJK7iX4qzPhyqTvIoIyx8usEVyD186AhdvW9steLCZ5IgKcrf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(66946007)(76116006)(316002)(71200400001)(4326008)(110136005)(64756008)(66476007)(66556008)(66446008)(478600001)(83380400001)(38070700005)(2906002)(122000001)(86362001)(8676002)(8936002)(5660300002)(186003)(26005)(7696005)(54906003)(52536014)(41300700001)(9686003)(6506007)(55016003)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blYwdXIvSjVMakxZMTVpcGNackYrWmRhY3oxREF1UHVYRENFWHFvc3l6WHAy?=
 =?utf-8?B?UEcxSlQ4N212T0xIeTNWYnl6Mk4xZTJudHpycEtTQXZuN1pLUVBjYW8xR3RW?=
 =?utf-8?B?ckI0eE50WXIxQzQvM1M4Y3p0Z2laWTRpaEhUNzBDcFJKd052LzRUSkhCZDFq?=
 =?utf-8?B?d3crWTR3Z2lVUHJidDJBRE5LTVdWdE96ZVVmbDJDWk9mVWx2Zm83dCtZVXZk?=
 =?utf-8?B?YWorNXBlaW9xY2s0b2dPK1Q3MUpTWWQ1NmpRWHhxTk80ZmtkMjRhVzJBazUw?=
 =?utf-8?B?NjA1TlZCVnlLTElGd3N1VjhmM2lUVUxmZXZ5aGxjR3hBVXFsbHNHOFU3R01t?=
 =?utf-8?B?NTd1NG1za2JWSk00SzJuNE1Ob3BtRW5VbzBuQUtsbDFPcHo1VU01N0V3Zlpn?=
 =?utf-8?B?NDc5bE1STk9xSTQzODBrVjNEWUtudmdtMXlsUWdlTGZ1Vm5iNlBTY2NDK0hi?=
 =?utf-8?B?RWtCa2haN3ptWEFXWjIyd3NvakVSNlc5S2kvWjZLdEJXT21JalVGMjFyVWdH?=
 =?utf-8?B?ZHVLNFpNTWNaM2Vnd0JTVDk5RXl3WlJtcGlCcEJuMWRmOTM1VUtUSjFOTUJn?=
 =?utf-8?B?Q1pEU0JMSlZSYkpJcG9heHViZXN1MXNtcmF2MDYwbWVXVTRnMW41cnNBS3M4?=
 =?utf-8?B?TkRhcndsNUJhZjFDNThpSi84ZWNaOXVwbGtnUXh1U3JkOUpIQ21HK1JiT2hp?=
 =?utf-8?B?WXV0STdpSUE0V01qYlViZHk4RXFsVTZhZUpQalJEVTJLakRtTTNzKzhNVUlY?=
 =?utf-8?B?Sk5WeEZ6ZDBXR2FNMlR1cXdOUzZueHVucUZicVgrTjFVbFVFRldORDlnSlBB?=
 =?utf-8?B?QUozbWpHdE42Z3hESk9sTVUxS0NYQ1hZQm00NmlKUHB6cWtEZnpqSTVZeVhn?=
 =?utf-8?B?MUVFb01FZ0tuSHFlTHpSQWxBbTVOc0p0OEh1ZWJ1emxxWnA0b1RXcE5DUDl2?=
 =?utf-8?B?bVU3NmptRThiRFNnc3kybFFwQjd4YTRhemxkcTNoT0Qzc3NKK3d2bXNqVkx1?=
 =?utf-8?B?cWpWT0IvQjIrRy91UW5zRGdFT0piQ2E2cFV6VkRDdUQ1cForbFdiNmZUTXQ3?=
 =?utf-8?B?YzYzSmNVWHNaMXR4R2RUd3lNQ2s2RFdKMHIvWFZEWjA0Y1FZOTcyS3ZVNTZk?=
 =?utf-8?B?OGIrNUxocFN4djFlTm9vQk42Q1ZtZ3FjWW84V2NocVVJWkVBSGhVd3I1RzA3?=
 =?utf-8?B?M00wY0piWnYxekxGcExFamFGa3VvaDFIVlFia21GSDducVNpMnd1b21saEJG?=
 =?utf-8?B?ek5hZDNlZ0NTZWtLRlZVbXVaSmdVQW5td0tkNEJCT0RNKzJtTnhlQmhKNXRD?=
 =?utf-8?B?K0toUFhtaUZWZCtJTnJ3aCtja2MvbTU2SGpMOFBCdnlnV3NyYlFROTJSRzVL?=
 =?utf-8?B?c0NyUGoyR0RyU0JhOXE4SDBiTnpsdFFkVU5wNzIwbGQ4ais4N0thVXoxQkpi?=
 =?utf-8?B?elVzZ3BRSk1xTTR1UFlWRUh4bFhFVmVlR2RkQjRuT2s1UDhhR2xtcmgwaHhL?=
 =?utf-8?B?WXpkT25Ibmh6TmJRMitGalV6SDgrV2tjR2lTbE8rdjI5OHp0UHRXUUExNFhI?=
 =?utf-8?B?Z2VpVHBXV1JLMmpZOHQyVU5BeWRycEYzNlA1TW5ZUm1wWDlUZW9kWlZpMWdY?=
 =?utf-8?B?T1ROMm5kSFh6Ry95RWxBNWM2Uk1vOTVGY0MrWW9WaDhsZHlvM0RDMTlESmNB?=
 =?utf-8?B?UFQ4VFF2Vk9rbDNHT3FTdStGVE9uY2VUL3V0ZStsSzhGOS9GeHJMWWladkFj?=
 =?utf-8?B?TXlrREcvaCtDeVpSRVI3eHAzd1BlZFo3YURPZUM2MStJYkJDYkpycnZyckQr?=
 =?utf-8?B?SU4waGZCOGNwcXFKZkFPUWh3L0djcVduUnY5MkZhZHdINFpWQWdKTjR2TDI3?=
 =?utf-8?B?c3hZalJCYVhrYS9JYTdiS2YxWnI4c3l6bGpDRVRpWm9Cak1MeVlqM0NmMGJZ?=
 =?utf-8?B?bzVORjV6VjhMcFFnOThJaUtpdzk0Skl4ZHYzSDBncjFtR1hRTGFLV1RBTVZQ?=
 =?utf-8?B?aVNsZ01mejR3NjhDWEJmWitNZ1VUMlpYQmFtZk5McjMxaTRQQkI4bEEvUkt1?=
 =?utf-8?B?S3ptUTZJVFFrT0VBaWFhakw0RGtPdmlIelN3M1hua3Z2S29kZlBxNlNjUkpU?=
 =?utf-8?Q?bY9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f581376-946f-4074-7058-08db4661fdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 14:24:48.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ff51cRxIyTgSCA97plwMZaa65z5Z0NUTULtazZKXAWhcpz3ndm1PdHhm77FoAn8qLNaSqfV1jc9/D0tk3O9wdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net: support inner header
 hash

DQoNCj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIEFwcmlsIDI2LCAyMDIzIDEwOjA0IEFNDQoNCj4gWWVzLCBidXQgdGhhdCBzZWVt
cyBsaWtlIGEgdGlueSBjb3N0LCBhbmQgdGhlIGN2cSBjb21tYW5kLXJlbGF0ZWQgc3RydWN0dXJl
IGlzDQo+IG11Y2ggc2ltcGxlci4NCkN1cnJlbnQgc3RydWN0dXJlIHNpemUgaXMgMjQgYnl0ZXMu
DQpUaGlzIHNpemUgYmVjb21lcyBtdWx0aXBsaWVyIHdpdGggZGV2aWNlIGNvdW50IHNjYWxlIHRv
IGJlIGFsd2F5cyBhdmFpbGFibGUgYW5kIHJhcmVseSBjaGFuZ2VzLg0KDQpBcyB3ZSBhZGQgbmV3
IGZlYXR1cmVzIHN1Y2ggZGV2aWNlIGNhcGFiaWxpdGllcyBncm93IG1ha2luZyB0aGUgbXVsdGlw
bGllciBiaWdnZXIuDQpGb3IgZXhhbXBsZSANCmEuIGZsb3cgc3RlZXJpbmcgY2FwYWJpbGl0aWVz
IChob3cgbWFueSBmbG93cywgd2hhdCBtYXNrLCBzdXBwb3J0ZWQgcHJvdG9jb2xzLCBnZW5lcmlj
IG9wdGlvbnMpDQpiLiBoZHMgY2FwYWJpbGl0aWVzDQpjLiBjb3VudGVyIGNhcGFiaWxpdGllcyAo
aGlzdG9ncmFtIGJhc2VkLCB3aGljaCBlcnJvciBjb3VudGVycyBzdXBwb3J0ZWQsIGV0YykgDQpk
LiB3aGljaCBuZXcgdHlwZSBvZiB0eCB2cSBpbXByb3ZlbWVudHMgc3VwcG9ydGVkLg0KZS4gaHcg
Z3JvIGNvbnRleHQgY291bnQgc3VwcG9ydGVkDQoNCk1heSBiZSBtb3JlLi4NCg0KRGVwZW5kaW5n
IG9uIHRoZSBjb250YWluZXIvVk0gc2l6ZSBjZXJ0YWluIGNhcGFiaWxpdGllcyBtYXkgY2hhbmdl
IGZyb20gZGV2aWNlIHRvIGRldmljZS4NCkhlbmNlIGl0IGlzIGhhcmQgdG8gZGVkdXBsaWNhdGUg
dGhlbSBhdCBkZXZpY2UgbGV2ZWwuDQoNClRoZXJlZm9yZSwgYWJpbGl0eSB0byBxdWVyeSB0aGVt
IG92ZXIgYSBub25fYWx3YXlzX2F2YWlsYWJsZSB0cmFuc3BvcnQgaXMgcHJlZmVycmVkIGNob2lj
ZSBmcm9tIHRoZSBkZXZpY2UuDQoNCkEgZHJpdmVyIG1heSBjaG9vc2UgdG8gY2FjaGUgaXQgaWYg
aXRzIGJlaW5nIGZyZXF1ZW50bHkgYWNjZXNzZWQgb3IgYXNrIGRldmljZSB3aGVuIG5lZWRlZC4N
CkV2ZW4gd2hlbiBpdCdzIGNhY2hlZCBieSBkcml2ZXIsIGl0IGlzIGNvbWluZyBmcm9tIHRoZSBj
b21wb25lbnQgdGhhdCBkb2VzbuKAmXQgaGF2ZSB0cmFuc3BvcnQgbGV2ZWwgdGltZW91dHMgYXNz
b2NpYXRlZCB3aXRoIGl0Lg0K

