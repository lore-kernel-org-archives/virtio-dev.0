Return-Path: <virtio-dev-return-14225-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43C3C47DA2
	for <virtio-dev@archiver.kernel.org>; Fri, 12 Jan 2024 09:44:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F008C2AC43
	for <virtio-dev@archiver.kernel.org>; Fri, 12 Jan 2024 09:44:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA845986708
	for <virtio-dev@archiver.kernel.org>; Fri, 12 Jan 2024 09:44:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C85AD9866E5; Fri, 12 Jan 2024 09:44:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6EFD9866E4;
	Fri, 12 Jan 2024 09:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxKwU8wTKe5DNTs3l0M+g28jNnFAsjam8JMbZ0YY/Lj0iGmNNqzXNbuXcvClUBcj2sBRY2Y+DuheUCQF817NOQW0U/XP1OyvyAej7moCWYxyVaRUd3d93RXUNZ8ZVn0FTt5wT0iBR7t0vvI87EcsQO/im6VlIChcBBWd0xOT7flA+M7T37H/JiZYx9BCn9Pkii8hBYsnLu9yRJHs3B37YJL5kv+0NSrtWxMmo75Gw/JLTnRIk0uZTHTRbBw+tkuoeLTCWh1lHCZUq+hF+1lkiZLAmdC+DDj9tbcHXm6EJu2V53DEMi6WoM0AUrUD7OjiYYQob1WlbbIj58DWy2xW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYCs2lNuVRfFx/cN0Q22v0gxv2zONGU5WFCxO22i2n0=;
 b=kJiQf9qMvWQK7zEYIF0FEVLei3RdybOBhsPeNsw9w9lDw/1nsAXFATOAX8Leju85CeXAKMIJ4j88xbE6Ai5fd/q76Njcwq+1+EikBxAoS0uOWZgUjPLJ56DXQ1hwIFS4i1ICqrWJwlqGjQglNdb9DGIRjMI5zAjQHrLLtHu3KaFbqdcio8mHUTnIrJp5SLaSKX1bkxkChbbX2JDP8qbtUW9bd0lHJkBHhABbt2rXYubOncCz5vQfZzcXyXlHlef0v4xejm4j6pBzvj7XM8oB64XanKakZrxLf67MI10CmXE5yVRhn1X8Qh5GXBSfgToTbKwWLiZzOHBQ/9dsGzfHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1A
Date: Fri, 12 Jan 2024 09:44:40 +0000
Message-ID:
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB6534:EE_
x-ms-office365-filtering-correlation-id: 9b65454f-a449-4b2b-bc03-08dc1353194b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VcHYUFSTkOtmPnS9NjcTnVfIqHAtOkz+YfjzB79LsSEIEq8SKazZlii4jVJdgs/M7Z4Cs+ZY4gfvNSAR7bobk6tfGxjKzVEU4SmP1EFfyArcA4KlayY9uPvtzGzKRb0sHcSzFEcCL8Ftve9xTlf6mKQHEoN91D0pR2pd+56Yke+yk7EAIkLsZlhzMu/OCI0+peWEk05hyLHxiMrRZTd0RIH7wxdDbsWTEBL20xDUwoQCMo8Cze05r+OyJ6tO3NfrGq20Ibuq5ERiKYStNf88SvvKqlg9dbOireFSeJM9gBvS881NVNemqZzbZ9U6wU0SwbY0TA2mqcuLFb7ft498h6C8fNP6GMKrjSww+3vAdIwYjMUvvySFGQQlzdOFdTdTotxOqCSL5AMV5iKBs+zgjkTXAddpJmuaqgQSWZAlP83bnXdSVNktk8a5I+Ck4QYtsqAvoDQeefBhIzvO/IxxU+KAwr2pnKqHnRETg4CQ7vIgRe5GVH3cwJlT8Ch3Y+drsYuYrcs9aA1fqLo3RU8+3WpRu5wkRYK/aBR+2y4nz4RwSlXsW0XfJ3fAs4cjLsO55YJTJhuL5zuOAK+iMbEOr5X9OMxO7poUavQIo2xqtcjg/s4ZjvlvZl72Vzkhd0Tb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(83380400001)(64756008)(33656002)(38070700009)(41300700001)(76116006)(110136005)(86362001)(66946007)(66446008)(38100700002)(122000001)(66476007)(7696005)(26005)(53546011)(9686003)(55236004)(6506007)(478600001)(66556008)(54906003)(71200400001)(316002)(2906002)(8936002)(52536014)(4326008)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjdxUG9heUNnU0I5NEo5bk91Nk5EbmphcWR1U25YdGl1SEU0RVk1N0QrcDRB?=
 =?utf-8?B?SjM5SmVFYXhmME1ya3JpaGxHMnA4OWZxMmp2VGRXMEpFZUt5YUJwYndhZHYy?=
 =?utf-8?B?QnNwR1FrdGNlTklWVE9CSE0rc1E1NlNEY05PN3F0SWJ0MXg1Z0RFY2YwWmhX?=
 =?utf-8?B?TE5QUDJiUlQ3NU9DUExrdmNiazlmaUZLZ3JYYU1GcjdQaityUkFvUUg3SjZX?=
 =?utf-8?B?U0NsejZCTnFRcE9jOWc2RERuUTltTjExUHFVL1huRW81N003eEJyVGkyK3RC?=
 =?utf-8?B?ZnVSa0wwNjVxNnhlL1BBS3Z5d0c2U084NzhrV2p2SFlWcXZadmtZYXZJTUxL?=
 =?utf-8?B?SXRudVF2RWU0TFNtUFBQQlEwVzBseVBYNTdONHNtQ2FJeUoxK29TMFBsZWVU?=
 =?utf-8?B?RFNnUjNuNGdmUUFYcG8wNFlOY3IxYVI3ejlEaFgzSy9MSDdDR3cxbGRTQlNH?=
 =?utf-8?B?bXNqQ2ZHWjBRNGRNVXZiblVnb2JnelJKTUpIYjVxT1NaNjRzTGtscXprOWdr?=
 =?utf-8?B?TWV4cmZyNHkzQUoyWTFQYWgzYm1SYThrQXlVK05sMDVxQVU3eUJIN1JUMTd5?=
 =?utf-8?B?RzhXdFdhNHdTOFpLNXpIdS9tOU83SGJDT0JqM3BKWm5PVzVnWFI5cVFZekZF?=
 =?utf-8?B?R3hvTkhoYXZwWEw1UTd5cFhJZ21GQkNpd2preFFDWEI5ZTExMFpYVkZSbENs?=
 =?utf-8?B?a2Z5eTRheExRZjJGM044VDRBdWxnZDJaUDJremtRWWhzQjBzZG5PdnlETUZI?=
 =?utf-8?B?SFZ6TGR6SythN2RSS0l1N1lETkkwbUlZY2NWU0lOS2xCcXN3TFRTWm01N1J3?=
 =?utf-8?B?YlNzWE1VVHpQYm9CenB0NE1JWTl0WGZJRjA5bWF2TWc1bE1BS2JyTlJEaVc4?=
 =?utf-8?B?T1czdWh0UFZVYlgvbm1lQ0phUTM3UFhGY1J6UWtndVVDbjNNSk0wT0pRcTRZ?=
 =?utf-8?B?Y2RCdFpOZlQ5akxsVXFQaHdlMWtaVURja1JVMktiZ3IvYnh5MlhnUExXMDhw?=
 =?utf-8?B?TkIya0JrcDdNY3VMMXFid0M2aUdORlIxZnNIalJtL2krV0FKMFh1RU1QZ0tn?=
 =?utf-8?B?Ti9IbzZDR1hqdDlZTEd1UUhHalNJTTMvZlE3Y1hwS1lEQ0dkazhPTThDcHlr?=
 =?utf-8?B?dnBST3poSVYrZUxrOHZZc3BJYVBtVUFyeXF2VGZ2aklwOGlSWHE1M1Z6V1Fl?=
 =?utf-8?B?b1ZmaHNKckY3MHVVTEFtZGx4M1R5Q1BvSUMxS1JDYUdDVUNoUkp5VHVYejJE?=
 =?utf-8?B?TGlpdEtkMDBVbDZRNGp5Zm8xbDhVbGgrTnZmdjQxOEM1Mkg5OXBOV293dk94?=
 =?utf-8?B?dzFzcjBqaGk4TGQrZENiWk1mN1NXaHpqQnRaSGxteklLNm9lcWV1UDFXaHBL?=
 =?utf-8?B?TWQwWHFObFhHbXNSdDdSQmRMdjZXc3BvelRuaUN3akNoQmZpeHA3eFZIengr?=
 =?utf-8?B?M2RrZDhDT2l6aTUvMGtNN2U3YmRtejVha2YzQjZreGxsM0ptSURTZnZjOFdU?=
 =?utf-8?B?M0RqM2I2TWdOYkN3Y0xzblRFUnV4RytaSzN1OGQ4blo1RERQSytWM3FRa0dR?=
 =?utf-8?B?eW0wclRBZ3NYWUc0dUtqOUp3bEZDTlZwSS9BMVBWUFQ4RkZyWXhBK3lYaG1V?=
 =?utf-8?B?SXZ6OFg2K1FYa1czU2dWMzJNbzVKQkdJVEJrNzRaY2NVVVNzVWpDNnI3NG0w?=
 =?utf-8?B?RWhyNy9WOGU4VGphWm05cDdUaTJHbGJ6VUZxZGdCSjd0WG5YaWRnNEovQVUw?=
 =?utf-8?B?UEl5T3d2QkxKZllnbGNNbWhMRGlhV0p4VHh2cVJJdXZ0V0ZDNTlGSEhqS1Bv?=
 =?utf-8?B?VStVN1lOWkdKU0JQUFFxZnZFMHFEdElmazdpcjhwWHR3eHRGL05rOVBmZHhI?=
 =?utf-8?B?dlRLd2dEWUxFcm9aQ3UwbGtyM0R0MEY4NTVSTTBBM0dkQ05TV0pPTmRtZ0Jl?=
 =?utf-8?B?V1VLRkttczcyY3RlT1NsZGtORnFGalN4YkZaYlppWE1QbC83SXQ5bFJDemhN?=
 =?utf-8?B?T3AvVjBGa3YvRUFBcDNvNHNiWVByUXU3WUNMYjhOemlqeFdaSjUzamxrWGRj?=
 =?utf-8?B?WU1sWUZVTkhRbzJDMFI2L0pLWi9RVXVUZVFVU1lEQk9VT3E4dFZ3Z0RnelFD?=
 =?utf-8?Q?zdJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b65454f-a449-4b2b-bc03-08dc1353194b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 09:44:40.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8LlPXv8JQVPcGhlRCJRVyY/5zXUlNGTfGWTloMB/gYaVTOBqu2j/eJ1OXsGWRvQjDT4983TW+cjlUG96oqJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
Subject: [virtio-dev] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQoNCj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiBTZW50OiBG
cmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMjo1NSBQTQ0KPiANCj4gT24gMjAyNC8xLzEyIDE2OjQ3
LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiBGcm9tOiBDaGVuLCBKaXFpYW4g
PEppcWlhbi5DaGVuQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAy
NCAxOjU1IFBNDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDIwMjQvMS8xMiAxNjowMiwgUGFyYXYgUGFu
ZGl0IHdyb3RlOg0KPiA+Pj4gSGkgSmlxaWFuLA0KPiA+Pj4NCj4gPj4+PiBGcm9tOiBDaGVuLCBK
aXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+ID4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5
IDEyLCAyMDI0IDE6MTEgUE0NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBIaSBhbGwsDQo+ID4+Pj4g
U29ycnkgdG8gcmVwbHkgbGF0ZS4NCj4gPj4+PiBJIGRvbid0IGtub3cgaWYgeW91IHN0aWxsIHJl
bWVtYmVyIHRoaXMgcHJvYmxlbSwgbGV0IG1lIGJyaWVmbHkgZGVzY3JpcHQNCj4gaXQuDQo+ID4+
Pj4gSSBhbSB3b3JraW5nIHRvIGltcGxlbWVudCB2aXJ0Z3B1IFMzIGZ1bmN0aW9uIG9uIFhlbi4N
Cj4gPj4+PiBDdXJyZW50bHkgb24gWGVuLCBpZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2ggcWVt
dSB3aXRoIGVuYWJsaW5nDQo+ID4+Pj4gdmlydGdwdSwgYW5kIHRoZW4gc3VzcGVuZCBhbmQgcmVz
dW1lIGd1ZXN0LiBXZSBjYW4gZmluZCB0aGF0IHRoZQ0KPiA+Pj4+IGd1ZXN0IGtlcm5lbCBjb21l
cyBiYWNrLCBidXQgdGhlIGRpc3BsYXkgZG9lc24ndC4gSXQganVzdCBzaG93biBhDQo+ID4+Pj4g
YmxhY2sNCj4gPj4gc2NyZWVuLg0KPiA+Pj4+IFRoYXQgaXMgYmVjYXVzZSBkdXJpbmcgc3VzcGVu
ZGluZywgZ3Vlc3QgY2FsbGVkIGludG8gcWVtdSBhbmQgcWVtdQ0KPiA+Pj4+IGRlc3Ryb3llZCBh
bGwgZGlzcGxheSByZXNvdXJjZXMgYW5kIHJlc2V0IHJlbmRlcmVyLiBUaGlzIG1hZGUgdGhlDQo+
ID4+Pj4gZGlzcGxheSBnb25lIGFmdGVyIGd1ZXN0IHJlc3VtZWQuDQo+ID4+Pj4gU28sIEkgYWRk
IGEgbmV3IGNvbW1hbmQgZm9yIHZpcnRpby1ncHUgdGhhdCB3aGVuIGd1ZXN0IGlzDQo+ID4+Pj4g
c3VzcGVuZGluZywgaXQgd2lsbCBub3RpZnkgcWVtdSBhbmQgc2V0DQo+ID4+Pj4gcGFyYW1ldGVy
KHByZXNlcnZlcl9yZXNvdXJjZSkgdG8gMSBhbmQgdGhlbiBxZW11IHdpbGwgcHJlc2VydmUNCj4g
Pj4+PiByZXNvdXJjZXMsIGFuZCB3aGVuIHJlc3VtaW5nLCBndWVzdCB3aWxsIG5vdGlmeSBxZW11
IHRvIHNldA0KPiA+Pj4+IHBhcmFtZXRlciB0byAwLCBhbmQgdGhlbiBxZW11IHdpbGwga2VlcCB0
aGUgbm9ybWFsIGFjdGlvbnMuIFRoYXQgY2FuDQo+IGhlbHAgZ3Vlc3QncyBkaXNwbGF5IGNvbWUg
YmFjay4NCj4gPj4+PiBXaGVuIEkgdXBzdHJlYW0gYWJvdmUgaW1wbGVtZW50YXRpb24sIFBhcmF2
IGFuZCBNU1Qgc3VnZ2VzdCBtZSB0bw0KPiA+PiB1c2UNCj4gPj4+PiB0aGUgUE0gY2FwYWJpbGl0
eSB0byBmaXggdGhpcyBwcm9ibGVtIGluc3RlYWQgb2YgYWRkaW5nIGEgbmV3DQo+ID4+Pj4gY29t
bWFuZCBvciBzdGF0ZSBiaXQuDQo+ID4+Pj4gTm93LCBJIGhhdmUgdHJpZWQgdGhlIFBNIGNhcGFi
aWxpdHkgb2YgdmlydGlvLWdwdSwgaXQgY2FuJ3QgYmUgdXNlZA0KPiA+Pj4+IHRvIHNvbHZlIHRo
aXMgcHJvYmxlbS4NCj4gPj4+PiBUaGUgcmVhc29uIGlzOg0KPiA+Pj4+IGR1cmluZyBndWVzdCBz
dXNwZW5kaW5nLCBpdCB3aWxsIHdyaXRlIEQzIHN0YXRlIHRocm91Z2ggUE0gY2FwLA0KPiA+Pj4+
IHRoZW4gSSBjYW4gc2F2ZSB0aGUgcmVzb3VyY2VzIG9mIHZpcnRpby1ncHUgb24gUWVtdSBzaWRl
KHNldA0KPiA+Pj4+IHByZXNlcnZlcl9yZXNvdXJjZSB0byAxKSwgYnV0IGR1cmluZyB0aGUgcHJv
Y2VzcyBvZiByZXN1bWluZywgdGhlDQo+ID4+Pj4gc3RhdGUgb2YgUE0gY2FwIHdpbGwgYmUgY2xl
YXJlZCBieSBxZW11DQo+ID4+Pj4gcmVzZXR0aW5nKHFlbXVfc3lzdGVtX3dha2V1cC0+IHFlbXVf
ZGV2aWNlc19yZXNldC0+DQo+ID4+Pj4gdmlydGlvX3ZnYV9iYXNlX3Jlc2V0LT4gdmlydGlvX2dw
dV9nbF9yZXNldCksIGl0IGNhdXNlcyB0aGF0IHdoZW4NCj4gPj4+PiBndWVzdCByZWFkcyBzdGF0
ZSBmcm9tIFBNIGNhcCwgaXQgd2lsbCBmaW5kIHRoZSB2aXJ0aW8tZ3B1IGhhcw0KPiA+Pj4+IGFs
cmVhZHkgYmVlbiBEMCBzdGF0ZSwNCj4gPj4+IFRoaXMgYmVoYXZpb3IgbmVlZHMgdG8gYmUgZml4
ZWQuIEFzIHRoZSBzcGVjIGxpc3RlZCBvdXQsICIgVGhpcw0KPiA+Pj4gMi1iaXQgZmllbGQgaXMN
Cj4gPj4gdXNlZCBib3RoIHRvIGRldGVybWluZSB0aGUgY3VycmVudCBwb3dlciBzdGF0ZSBvZiBh
IEZ1bmN0aW9uIg0KPiA+PiBEbyB5b3UgbWVhbiBpdCBpcyB3cm9uZyB0byByZXNldCBQTSBjYXAg
d2hlbiB2cml0aW9fZ3B1IHJlc2V0IGluDQo+ID4+IGN1cnJlbnQgcWVtdSBjb2RlPyBXaHk/DQo+
ID4gQmVjYXVzZSBQTSBpcyBpbXBsZW1lbnRpbmcgdGhlIHN1cHBvcnQgZnJvbSBEMy0+ZDAgdHJh
bnNpdGlvbiBhbmQgaWYgaXQNCj4gZGV2aWNlIGluIEQzLCB0aGUgZGV2aWNlIG5lZWRzIHRvIHJl
c3BvbmQgdGhhdCBpdCBpcyBpbiBEMyB0byBtYXRjaCB0aGUgUENJDQo+IHNwZWMuDQo+ID4NCj4g
Pj4gU2hvdWxkbid0IGFsbCBkZXZpY2Ugc3RhdGVzLCBpbmNsdWRpbmcgUE0gcmVnaXN0ZXJzLCBi
ZSByZXNldCBkdXJpbmcNCj4gPj4gdGhlIHByb2Nlc3Mgb2YgdmlydGlvLWdwdSByZXNldD8NCj4g
PiBJZiBOb19Tb2Z0X1Jlc2V0PT0gMCwgbm8gZGV2aWNlIGNvbnRleHQgdG8gYmUgcHJlc2VydmVk
Lg0KPiA+IElmIE5vX1NvZnRfUmVzZXQgPT0gMSwgZGV2aWNlIHRvIHByZXNlcnZlIG1pbmltYWwg
cmVnaXN0ZXJzIGFuZCBvdGhlcg0KPiB0aGluZ3MgbGlzdGVkIGluIHBjaSBzcGVjLg0KPiA+DQo+
ID4+DQo+ID4+Pg0KPiA+Pj4gU28gZGV2aWNlIG5lZWRzIHRvIHJldHVybiBEMyBpbiB0aGUgUG93
ZXJTdGF0ZSBmaWVsZC4gIFRoaXMgaXMgbXVzdC4NCj4gPj4gQnV0IGN1cnJlbnQgYmVoYXZpb3Ig
aXMgYSBraW5kIG9mIHNvZnQgcmVzZXQsIEkNCj4gPj4gdGhpbmsoIVBDSV9QTV9DVFJMX05PX1NP
RlRfUkVTRVQpLiBUaGUgcG0gY2FwIGlzIHJlc2V0IGJ5IHFlbXUgaXMNCj4gPj4gcmVhc29uYWJs
ZS4NCj4gPiBXaGF0IHlvdSBkZXNjcmliZWQgaXMsIHlvdSBuZWVkIHRvIGRvIE5vX1NvZnRfUmVz
ZXQ9MSwgc28gcGxlYXNlIHNldCB0aGUNCj4gY2FwIGFjY29yZGluZ2x5IHRvIGFjaGlldmUgdGhl
IHJlc3RvcmUuDQo+ID4NCj4gPiBBbHNvIGluIHlvdXIgY2FzZSB0aGUgaWYgdGhlIFFFTVUga25v
d3MgdGhhdCBpdCB3aWxsIGhhdmUgdG8gcmVzdW1lIHRoZQ0KPiBkZXZpY2Ugc29vbi4NCj4gPiBI
ZW5jZSwgaXQgY2FuIHdlbGwgcHJlcGFyZSB0aGUgZ3B1IGNvbnRleHQgYmVmb3JlIHJlc3VtaW5n
IHRoZSB2Y3B1cy4NCj4gPiBJbiBzdWNoIGNhc2UsIHRoZSBleHRyYSByZWdpc3RlciB3b3VsZG7i
gJl0IGJlIG5lY2Vzc2FyeS4NCj4gPiBIYXZpbmcgUE0gY29udHJvbCByZWdpc3RlciBpcyBhbnl3
YXkgbmVlZGVkIHRvIGRyaXZlIHRoZSBkZXZpY2UgcHJvcGVybHkuDQo+IEV2ZW4gYXMgeW91IHNh
aWQsIHRoZSByZXNldCBiZWhhdmlvciBvZiBQTSBpbiB0aGUgY3VycmVudCBRRU1VIGNvZGUgaXMN
Cj4gaW5jb3JyZWN0LCBhbmQgZXZlbiBpZiBpdCBpcyBtb2RpZmllZCwgaXQgYWxzbyBjYW5ub3Qg
Zml4IHRoaXMgcHJvYmxlbSB3aXRoIFMzLg0KWW91IG1lYW50IEQzPw0KDQo+IEJlY2F1c2UgdGhl
cmUgaXMgdHdpY2UgZGV2aWNlIHJlc2V0IGR1cmluZyByZXN1bWluZy4NCj4gRmlyc3QgaXMgd2hl
biB3ZSB0cmlnZ2VyIGEgcmVzdW1lIGNvbW1hbmQgdG8gcWVtdSwgcWVtdSB3aWxsIHJlc2V0DQo+
IGRldmljZShxZW11X3N5c3RlbV93YWtldXAtPiBxZW11X2RldmljZXNfcmVzZXQtPg0KPiB2aXJ0
aW9fdmdhX2Jhc2VfcmVzZXQtPiB2aXJ0aW9fZ3B1X2dsX3Jlc2V0KS4NCkEgZGV2aWNlIGltcGxl
bWVudGF0aW9uIHRoYXQgc3VwcG9ydHMgUE0gc2hvdWxkIG5vdCByZXNldCB0aGUgZGV2aWNlLiBQ
bGVhc2UgZml4IGl0Lg0KDQo+IEFmdGVyIHRoZSBmaXJzdCB0aW1lLCB0aGVuIHNlY29uZCB0aW1l
IGhhcHBlbnMgaW4gZ3Vlc3Qga2VybmVsLA0KPiB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUtPiB2aXJ0
aW9fcmVzZXRfZGV2aWNlLiBCdXQgdGhlIFBNIHN0YXRlIGNoYW5nZXMgKEQzIHRvDQo+IEQwKSBo
YXBwZW5zIGJldHdlZW4gdGhvc2UgdHdvLCBzbyB0aGUgZGlzcGxheSByZXNvdXJjZXMgd2lsbCBi
ZSBzdGlsbA0KPiBkZXN0cm95ZWQgYnkgdGhlIHNlY29uZCB0aW1lIG9mIGRldmljZSByZXNldC4N
ClRoZSBkcml2ZXIgdGhhdCB1bmRlcnN0YW5kcyB0aGF0IGRldmljZSBzdXBwb3J0cyBQTSwgd2ls
bCBza2lwIHRoZSByZXNldCBzdGVwcy4NCkhlbmNlIHRoZSAybmQgcmVzZXQgd2lsbCBhbHNvIG5v
dCBvY2N1ci4NClRoZXJlZm9yZSwgZGV2aWNlIHN0YXRlIHdpbGwgYmUgcmVzdG9yZWQuDQo=

