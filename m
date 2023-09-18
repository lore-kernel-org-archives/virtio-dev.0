Return-Path: <virtio-dev-return-13785-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D4C46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 04:32:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C0AD32CADB
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 04:32:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A93998641A
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 04:32:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7CC97983DE1; Mon, 18 Sep 2023 04:32:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AC8498638E
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 04:32:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA3lbmbJEun5bnvVhmQnC0O93CpICLtYXllm0u+iIGnq+vUwOwc6yfftCKuu4ZFMGTt8c6WI/VXcgnVe0zRwIWPJ8g+Jzss1wdaCdUq++hcjznbk6W6Jpt1EWuLOO6/sjXn2hE9JFmUHl02iV7rV+Hi1WmqfuGIKa1EuVR6I6t1wqvysXdFWkZszZ6vz0X5lLHOrDyYhygkG4RKr1TkTz46y86LccFHimsjIAG9HSsufrMYGyF+9wGHb8xXAHlqdfDZo0Qt7XvAxDulg+FNDsrL7LTCKxhByQQlHF9haD+94F1PUjHkcJzJGKu4S4SGr04+nFz3L2ZlJggPWDzMxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+eaRuOU5i0negsuDt3HBXqWA3Ps7WzDCU+Nz/1Vi4E=;
 b=N9iII4C/HLiFeXpQmp6lgK8XJfPj6mbRhGyBPqo6/JtXSkMU4FRVxLm+Wewp1+6WUsOnBDgOnlfYIzM14rAKEt6VtO2W2U2CdyANw4PtvrRvxq+WY7xjrK4aZhaJ7HcQCL57kLo/cH4rdZmAVjqcrqwTwP2F3n4jqxzh8axFYcgU0VrZjAVWh7w5utnGMuCxCFJ74O4dP0KCrXzXKiPpFwf4RidKkYMDJnwmjofZt2XQWZJesxWOqJHJksqwb7Ln6yWnNm+lxqceByOEAj7RYJtPU6wn6fnVxWaD+WtYlxtJetTh+xzptiVBdyokdlTELhD/Oq6q9Q/uQcFIuYdSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index: AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgA==
Date: Mon, 18 Sep 2023 04:32:11 +0000
Message-ID:
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
In-Reply-To: <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4414:EE_
x-ms-office365-filtering-correlation-id: 51c91bb9-30ce-4bd2-9b3b-08dbb80039c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dv5QIn17aMKTJLYIbEaT5IWv5Y7C9sBFQSQA/hgQlto1HexYwFeS+jUYIg6QNdNunIKJa+u/mbWq/QekX9A6hoZQaXHKXwnWEWDoBIcXjDd0Hrfk/jgQamZuMinlUkOJBrD5JhPng10p/IdR+DrEhiSPkFUK2DbEKzLmEy0sLVNU9FL49NyEwF7YdOsTGDbqZ9QH5PBaa0kQIWyi58mar5zPCngfA9/WRS+8826/4tz+ZJIv3P9SdmHhRATvvt09LtjNIqVAeImyqf3ncHxtYdIOJEm+AAiwVcHnmGUkO076ZsiTVVkZBspzx1vJfeDk7X27hHxg1uFr4egivRjXXYOT+EJcGFM+jtiz3lcRKAQFoo2kXbYVHkjehRI2TEDAop82b2FRuXDdfcPIdj63/SFGvx/CnJw/OM8Xs7Yf43L0YGkHx/cUbnHO5sswZ3M8PNsqleC0ZmoXfWi3n9Z8MJ4GaDwAr4ldd7IdqDzhnLDMUyrmc0TJ2LYDnMXpuX+f7jAAeZ9DNcHC2n67Y+p+gdbEGwwBPfO0b63akWxL+fJRFV0HCtfWa+mBdu19PwufPHF4vB5rlSS5Qb5aKcfQzF5BSwW1K4lFSwxkEaM7jYCRuJ0O4r2bgDyAYlwx07bq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(186009)(451199024)(26005)(83380400001)(52536014)(5660300002)(8936002)(8676002)(55236004)(6506007)(7696005)(9686003)(53546011)(478600001)(122000001)(71200400001)(41300700001)(66946007)(110136005)(64756008)(66446008)(316002)(66476007)(55016003)(76116006)(66556008)(86362001)(2906002)(33656002)(15650500001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1JZakJIRHFvSXBReDE1WHV5S2pEZlJuVUx3T2pTa0l2TmVrUysva0FJRDRp?=
 =?utf-8?B?NnVzZEhsWWxJRHd5Vm90T1hGVjJKOFNDek1qeXhwY2JnNjhINytidzBNTXJW?=
 =?utf-8?B?dnRxd2xLV011RVl4R21HZzA0T2hKdkR2bWpoa3N2WGp0SjI0TUkzck93NHNo?=
 =?utf-8?B?MEhqcWl1UG5USjVldmJLY1FhQkFnRmZvNThqeW9IbjdSa3ZFRVgycjV2b1Vy?=
 =?utf-8?B?cHR5VmxWK29HdVo2Qzc5OEtOZUpzZWhoYWY1Z0FoQk4wTVlMYkJHWTh4THRx?=
 =?utf-8?B?aGNhQVNCOWd0Nk52KzJ3bkljMmRsNDdVZ1dpWWt3RHRWNHpxclhwcDlnaGJJ?=
 =?utf-8?B?dHBhbWU3WHZQRjdYdkw1VUowb2lvTlR6Mko4S1RPOEU3WUpQTEZiRzlSNkdH?=
 =?utf-8?B?aGJqWnZtMlI3cUoxY1hIZVFQaUxncmJyN2EzSWJtOWE1MzZqcjBCZ3hyZDgx?=
 =?utf-8?B?MWNzVEk2QVpWRjQxUmU3S014b3lRNk1DS3Q4UFRZL1JZMXZxQ1UvZzNoRXlv?=
 =?utf-8?B?dmdQUGVnQnN3Z3RGbmZCV1o1MmFjdHIyRG81SzBZYkV2YnJwOEVLenhOMENa?=
 =?utf-8?B?elN3YUxmd0F0Nm1LbEZCWGY0eDRvV05oTXg0QzVJZUUwbWtJSk5qUjM1UGZi?=
 =?utf-8?B?YVV6bnk5Q0N3Rmp2a3RlM1JLVko5d2sreFZBMmtPMFNtMzFzM2lYMHMxWTV6?=
 =?utf-8?B?azlUdGRGU0JBOFFMVTlMQVNUNVFqaXR5andRemI5Y0ZjU1VIUW1uQy9FeHQ4?=
 =?utf-8?B?K3Zyemd4aDFKaG9rK0l6ckZ0OGFVRzQxZmxSaGdDWE1KazM1M1I3ZzBndGtz?=
 =?utf-8?B?L2d1bG9MZHNPbmV1d3B4cjhTUlJvSlZjajdGUzlLbGJRV2J5SmRiSjlqVi90?=
 =?utf-8?B?akVHRTVZdmJUeUdhbExXa040RjVNMmtSTW9IN2Z1SGJNVXc5SWU2bjV0UnBo?=
 =?utf-8?B?OVZ6RmcwMHlkaGxYYTU0V0haZVlxU1BqeFVkMmF2N3I2dlJDbnVzbmo2TVI1?=
 =?utf-8?B?MXRCREtYVDBPZ1UrV21SY0dmWVIrQXRPRWVNaGs5YnBRMWYyczFhUkFyQmsw?=
 =?utf-8?B?clNPMm5DdkI0M1FITW41QzFIcWdMWlZmQnIvWnU0TWcwRE83QW1YLzA4SEFU?=
 =?utf-8?B?anV1OWJaMHNNcUtNOVVaQmVHc0FyQVk2SmVVN3dRcVp0QzlwRnhhUkdOazJU?=
 =?utf-8?B?SDlEM0dubEQ5aFQyNGUrM212KytTdFNCdTVkWFMyNkg3aWllR1NPblFYNlY0?=
 =?utf-8?B?T3FGUFl4cTJhVVNyV3RNdS8zaHJXa3M0cVRYVTFZZndGZlhjVS8zazV2Mkl6?=
 =?utf-8?B?cEFFVGtRWUtncEtHUEd3SkdGWVYrVVNVN1B5QjdQRThVNXJtTDR5NVhQV1Yv?=
 =?utf-8?B?WWFDa0Y3dkMwUWhTWm1iRTlnaHhyVlZhOHNlSW9rMGVPb2VYOG1sQ2F4a1Jq?=
 =?utf-8?B?T2JkaFJXMXp0N0hoejYwY1ZEZmhYL2RLWTU5a3N2TjMrdWk3VDlad1hidHNV?=
 =?utf-8?B?MmRUN2ZrYmVkRW9pdDg2c0hRUWF4MmlVTnRTTVFLTlFtNm5TdU80blBtczQy?=
 =?utf-8?B?MEdtaElLNkJzY01uOHpqVGc1WHcrL0gzeU1OV1FMS1hWaDhLR2ptTENpT0Jm?=
 =?utf-8?B?M1ZEcmVkWjlxeGJmelE0Y29tYmVlbnV4OENnUTZNb2RyellJQjB2bDMrYmpC?=
 =?utf-8?B?aU5CZmhEWm1JWEo4RUhINVRHdGNvWS9QdGFZZEpKdDJ4TFRYNm41eFN5aWpM?=
 =?utf-8?B?SmNNZEFxWUZrQkowZGtmWG5ESm1icjJ0QXUycWtUaUkxNUdoRy91ZG9qSDlL?=
 =?utf-8?B?L08yaWhPcUlMS2NibW43U3R6TEJCQnNXaXpKckt2dC9WTkV2bnNnMmg3dlJn?=
 =?utf-8?B?VWZQNnlRcnIzcUxRV0hzdGlCc09pZFZMcWlJREIzQVc0T20zYVdkcVgwcUEv?=
 =?utf-8?B?Y1F3aVZZN09VNHdWVXNRWms1ak1YWnlIQ2plbUJVK0RkUi9zYkVNVHB0VGxW?=
 =?utf-8?B?TlE1aGhuSzBUbnM0Vm53V2JTVWNPOFY4RXpjaGZNTzBzNFJkQjlmcXFOY0Ja?=
 =?utf-8?B?WGxmaDVCa0VXenlHcWRqWUpsR01iOHlJdlRIT3NDN1FYTjBTSmFjS2Jpellr?=
 =?utf-8?Q?VqyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c91bb9-30ce-4bd2-9b3b-08dbb80039c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 04:32:11.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWimT8xydMV5eLlDxYyBvfJI13aCfjs8jWPr7v7sO9++kd0Dz+ZLwHswveFcUb5tTr4deDgZ4wzG8HKGFW07Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMjMgODo0MCBBTQ0KPiANCj4gT24gOS8xNy8yMDIz
IDE6MzIgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogdmlydGlvLWRldkBsaXN0
cy5vYXNpcy1vcGVuLm9yZw0KPiA+PiA8dmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZz4g
T24gQmVoYWxmIE9mIFpodSwgTGluZ3NoYW4NCj4gPj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MTUsIDIwMjMgOTo1OSBBTQ0KPiA+Pg0KPiA+PiBPbiA5LzE0LzIwMjMgNzoxNCBQTSwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOg0KPiA+Pj4gT24gV2VkLCBTZXAgMDYsIDIwMjMgYXQgMDQ6MTY6
MzJQTSArMDgwMCwgWmh1IExpbmdzaGFuIHdyb3RlOg0KPiA+Pj4+IFRoaXMgc2VyaWVzIGludHJv
ZHVjZXMNCj4gPj4+PiAxKWEgbmV3IFNVU1BFTkQgYml0IGluIHRoZSBkZXZpY2Ugc3RhdHVzIFdo
aWNoIGlzIHVzZWQgdG8gc3VzcGVuZA0KPiA+Pj4+IHRoZSBkZXZpY2UsIHNvIHRoYXQgdGhlIGRl
dmljZSBzdGF0ZXMgYW5kIHZpcnRxdWV1ZSBzdGF0ZXMgYXJlDQo+ID4+Pj4gc3RhYmlsaXplZC4N
Cj4gPj4+Pg0KPiA+Pj4+IDIpdmlydHF1ZXVlIHN0YXRlIGFuZCBpdHMgYWNjZXNzb3IsIHRvIGdl
dCBhbmQgc2V0IGxhc3RfYXZhaWxfaWR4DQo+ID4+Pj4gYW5kIGxhc3RfdXNlZF9pZHggb2Ygdmly
dHF1ZXVlcy4NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBtYWluIHVzZWNhc2Ugb2YgdGhlc2UgbmV3IGZh
Y2lsaXRpZXMgaXMgTGl2ZSBNaWdyYXRpb24uDQo+ID4+Pj4NCj4gPj4+PiBGdXR1cmUgd29yazog
ZGlydHkgcGFnZSB0cmFja2luZyBhbmQgaW4tZmxpZ2h0IGRlc2NyaXB0b3JzLg0KPiA+Pj4+IFRo
aXMgc2VyaWVzIGFkZHJlc3NlcyBtYW55IGNvbW1lbnRzIGZyb20gSmFzb24sIFN0ZWZhbiBhbmQg
RXVnZW5pbw0KPiA+Pj4+IGZyb20gUkZDIHNlcmllcy4NCj4gPj4+IENvbXBhcmVkIHRvIFBhcmF2
J3MgcGF0Y2hzZXQgdGhpcyBpcyBtdWNoIGxlc3MgZnVuY3Rpb25hbC4NCj4gPj4gd2Ugd2lsbCBh
ZGQgZGlydHkgcGFnZSB0cmFja2luZyBhbmQgaW4tZmxpZ2h0IElPIHRyYWNrZXIgaW4gVjIsIHRo
ZW4NCj4gPj4gaXQgd2lsbCBiZSBhIGZ1bGwgZmVhdHVyZWQgTE0gc29sdXRpb24uDQo+ID4+DQo+
ID4+IFRoZXkgYXJlIG5vdCBpbiB0aGlzIHNlcmllcyBiZWNhdXNlIHdlIHdhbnQgdGhpcyBzZXJp
ZXMgdG8gYmUgc21hbGwgYW5kIGZvY3VzLg0KPiA+Pj4gQXNzdW1pbmcgdGhhdCBvbmUgZ29lcyBp
biwgY2FuJ3Qgd2UgYWRkIGFiaWxpdHkgdG8gc3VibWl0IGFkbWluDQo+ID4+PiBjb21tYW5kcyB0
aHJvdWdoIE1NSU8gb24gdGhlIGRldmljZSBpdHNlbGYgYW5kIGJlIGRvbmUgd2l0aCBpdD8NCj4g
Pj4gSSBhbSBub3Qgc3VyZSwgSU1ITywgaWYgd2UgdXNlIGFkbWluIHZxIGFzIGJhY2stZW5kcyBm
b3IgTU1JTyBiYXNlZA0KPiA+PiBsaXZlIG1pZ3JhdGlvbiwgdGhlbiB0aGUgaXNzdWVzIGluIGFk
bWluIHZxIHN0aWxsIGV4aXN0LCBmb3IgZXhhbXBsZToNCj4gPj4gMSluZXN0ZWQgdmlydHVhbGl6
YXRpb24NCj4gPj4gMiliYXJlLW1ldGFsIGxpdmUgbWlncmF0aW9uDQo+ID4+IDMpUU9TDQo+ID4+
IDQpaW50cm9kdWNlIG1vcmUgYXR0YWNraW5nIHN1cmZhY2VzLg0KPiA+Pg0KPiA+ICM0IGlzIGp1
c3QgcmFuZG9tIHdpdGhvdXQuDQo+IEkgZmFpbGVkIHRvIHByb2Nlc3MgInJhbmRvbSB3aXRob3V0
Ii4NCj4gDQo+IElmIHlvdSBleHBlY3QgYWRtaW4gdnEgdG8gcGVyZm9ybSBsaXZlIG1pZ3JhdGlv
biwgaXQgY2FuIGNlcnRhaW5seSBiZSBhIHNpZGUNCj4gY2hhbm5lbCBhdHRhY2tpbmcgc3VyZmFj
ZSwgZm9yIGV4YW1wbGU6DQo+IGEpIGEgbWFsaWNpb3VzIFNXIGNhbiBzdG9wIHRoZSBkZXZpY2Ug
cnVubmluZw0KPiBiKSBhIG1hbGljaW91cyBTVyBjYW4gc25pZmYgZ3Vlc3QgbWVtb3J5IGJ5IHRy
YWNraW5nIGd1ZXN0IGRpcnR5IHBhZ2VzLCB0aGVuDQo+IHNwZWN1bGF0ZSBndWVzdCBvcGVyYXRp
b25zIGFuZCBzdG9sZSBzZWNyZXRzLg0KVGhpcyBpcyB0aGUgbW9kZSB3aGVuIGh5cGVydmlzb3Ig
aXMgdHJ1c3RlZC4NCldoZW4gaHlwZXJ2aXNvciBpcyB1bnRydXN0ZWQsIHRoZSBDQyBtb2RlbCBU
RElTUCBlbmFibGVkIGRldmljZSwgVFNNIHdpbGwgZGVsZWdhdGUgdGhlIHRhc2tzIHRvIHRoZSBE
U00uDQoNCkZvciB1bnRydXN0ZWQgaHlwZXJ2aXNvciwgc2FtZSBzZXQgb2YgYXR0YWNrIHN1cmZh
Y2UgaXMgcHJlc2VudCB3aXRoIHRyYXArZW11bGF0aW9uLg0KU28gYm90aCBtZXRob2Qgc2NvcmUg
c2FtZS4gSGVuY2UgaXRzIG5vdCByZWxldmFudCBwb2ludCBmb3IgZGlzY3Vzc2lvbi4NCg0KPiA+
ICMzIFRoZXJlIGlzIG5vIFFvUyBpc3N1ZSB3aXRoIGFkbWluIGNvbW1hbmRzIGFuZCBxdWV1ZXMu
IElmIHlvdSBjbGFpbSB0aGF0DQo+IHRoZW4gd2hvbGUgdmlydGlvIHNwZWMgYmFzZWQgb24gdGhl
IHZpcnRxdWV1ZXMgaXMgYnJva2VuLg0KPiA+IEFuZCBpdCBpcyBjZXJ0YWlubHkgbm90IHRoZSBj
YXNlLg0KPiBQbGVhc2UgZG8gbm90IGNvbmZ1c2UgdGhlIGNvbmNlcHRzIGFuZCBwdXJwb3NlcyBv
ZiB0aGUgZGF0YSBxdWV1ZXMgYW5kDQo+IGFkbWluIHZxLg0KPiANCkkgYW0gbm90IGNvbmZ1c2Vk
Lg0KVGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgYSByZWdpc3RlciBwbGFjZWQgb24gdGhlIFZG
IHdpbGwgYmUgc2VydmljZWQgYnkgdGhlIGRldmljZSBpbiBleGFjdCBzYW1lIHRpbWUgcmVnYXJk
bGVzcyBvZiBWRiBjb3VudCA9IDEgb3IgNDAwMC4NCllldCBhZ2FpbiBub3QgcmVsZXZhbnQgY29t
cGFyaXNvbi4NCg0KPiBGb3IgZGF0YS1xdWV1ZXMsIGl0IGNhbiBiZSBzbG93IHdpdGhvdXQgbXEg
b3IgcnNzLCB0aGF0IG1lYW5zIHBlcmZvcm1hbmNlDQo+IG92ZXJoZWFkLCBidXQgY2FuIHdvcmsu
DQpObywgaXQgZG9lcyBub3Qgd29yay4gVGhlIGFwcGxpY2F0aW9uIGZhaWxlZCBiZWNhdXNlIG9m
IGppdHRlciBpbiB0aGUgdmlkZW8gYW5kIGF1ZGlvIGR1ZSB0byBtaXNzaW5nIHRoZSBsYXRlbmN5
IGJ1ZGdldC4NCkEgZmluYW5jaWFsIGFwcGxpY2F0aW9uIGlzIHRlcm1pbmF0ZWQgZHVlIHRvIHRp
bWVvdXRzIGFuZCBwYWNrZXQgbG9zcy4NCg0KRGV2aWNlIG1pZ3JhdGlvbiBpcyBqdXN0IGFub3Ro
ZXIgM3JkIHN1Y2ggYXBwbGljYXRpb25zLg0KDQpJdHMgYWxzbyBzYW1lLg0KTXkgbGFzdCByZXBs
eSBvbiB0aGlzIHZhZ3VlIGFyZ3VtZW50Lg0KDQo+IEZvciBhZG1pbiB2cSwgaWYgaXQgZG9uJ3Qg
bWVldCBRT1MgcmVxdWlyZW1lbnRzLCBpdCBmYWlscyB0byBtaWdyYXRlIGd1ZXN0cy4NCj4gDQo+
IEkgaGF2ZSByZXBsaWVkIHRvIHRoZSBzYW1lIHF1ZXN0aW9uIHNvIG1hbnkgdGltZXMsIGFuZCB0
aGlzIGlzIHRoZSBsYXN0IHRpbWUuDQo+ID4NCkkgYWxzbyByZXBsaWVkIG1hbnkgdGltZXMgdGhh
dCBRb1MgYXJndW1lbnQgaXMgbm90IHZhbGlkIGFueW1vcmUuIFNhbWUgY2FuIGhhcHBlbiB3aXRo
IHJlZ2lzdGVycyB3cml0ZXMuDQpQZXJmIGNoYXJhY3RlcmlzdGljcyBmb3IgMzArIGRldmljZXMg
aXMgbm90IGluIHRoZSB2aXJ0aW8gc3BlYy4gSXQgaXMgaW1wbGVtZW50YXRpb24gZGV0YWlscy4N
Cg==

