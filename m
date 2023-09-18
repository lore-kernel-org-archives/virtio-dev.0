Return-Path: <virtio-dev-return-13791-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E01CD37B0
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:37:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 844C6613D0
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:37:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 575C4986427
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:37:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3690F983DFF; Mon, 18 Sep 2023 06:37:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2497498638E
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 06:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJtn/5uV4KX46fC9f8olts/5W9yi//km0ej4sHbPzRBGgtSx0W2BDg8dyAZEHuS5fhhgn096X9zpA5fevwwkOjxl7K+DnbO5pk3YMHUqvrgu3CIjpNJAqG8ZH7nW+mWOeefH/s5IxpS5wbvvJmkiT/aDSUBOdswLSik+nLL8Ma8HuN0g8q2LQ2kOEJOt2wyjZwES2eXEi9zmvnhlrFZGV/bcksXGk/SMFVFXV/R/MIF+z+XzTHTGsrP5AJGJqgRbmDMijp0Qrzzc45NFotNiIAgP6bfK4EQSBGNgsABidkB+PAY8+zcpzwxFKxUi3HtR7H4pvhXqr+CeqwPUUzM2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSmtS/uo8+YoE21elZgAilhIHCPz3yaeMJed8OaV9dk=;
 b=dFDzTcbynrPq6tYvJW2XM9kmQwoaW1R/MaxAHzA63iSg49fX+i7obKl21Ybcu4qtxEiWGMlR5Fv+J2qmCwe8tIfFyAKh0RtKXOsA87nX240IeIFkm7UPi/w/m5pW37S3z7/BedLfxr1qR8cvZq7w3vi4RExGSJOQA1FZNzjdZJWT1o0c2AZx0jImzyIhzlkhULTMMtYYPyAkLT7WHq6XWKaRPOdUNnTrygy60xIsTFhBN2UMobLUXMK3Q+c1AILc2M3E2g05nbEmaRGu6fKJAlCzbnu0HLwvJYYUqPh0TI1h5KS46uBADHQQB2w4kKJNTIQZae0UlbceoOUOD+8Bdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIA==
Date: Mon, 18 Sep 2023 06:37:05 +0000
Message-ID:
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
In-Reply-To: <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7148:EE_
x-ms-office365-filtering-correlation-id: fd36c671-52e9-41eb-ff4d-08dbb811acf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xihl6aVg44Ek4m9Ly/ToegtFmQE5TFYkNvuntNY1IlkD/lAxoCkvj7gDONlqfPDCTZpXO8GsGGfO5dDNEJBzKPbEFQHxcI6IyJ8xV60ArG4JIu9XLdCfmSIdes1Uuw/i1Zuw/E4V4P3H8DQlX71cfQrEGP28y7cHr1hm90VEiUcXwK3qvr0yYtpMzpujFFBNDUY7xu/ZvNEB9EgtIO47dNFC/imRpsoZpGOeHFKNasJT8I8zxpb1h7hZ1vavHfmEQE/W1qgIFC0o1Vc9Q29FxrSdhf/B6hnnn+mUJgHtH3jYK6XEF4SS5tD7PAU/FooEtwr3pL3Wz+wQ9pl0JHA3zlgGY/kzeXTbp73r/M0pebxMqITGONvB5WuXIVcGKe80gFlnZMBSz8mZaFVyZcVVgRVBZTVLZX1yq2uPhRddiQTIclC6zr+XQF8AXkjqwYCOnSQeLefOQzLMUiwi4344ohZVeWoaaSTHKonoE7srbfydLdCuX2aPvXHw9OcSA8bGVRWCC1lQ4O4L+KQyuo9BTraA99trqCwmpeTA5fSe8qlvjCiFXJO714N9AHCoi+/KTwGx2WW1XS5CwBWAmYVDzI8cGCoC+sXKZdXt6sMkdGg6nCYDEubAate3H8VTfFai
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(1800799009)(451199024)(186009)(122000001)(55016003)(86362001)(38070700005)(33656002)(38100700002)(7696005)(6506007)(53546011)(478600001)(2906002)(5660300002)(66556008)(66446008)(52536014)(66946007)(64756008)(66476007)(15650500001)(76116006)(8936002)(71200400001)(8676002)(9686003)(83380400001)(41300700001)(110136005)(316002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R00wWU5NdTBHR1Q1azRVK3Q3OVZaSDdrZDIraVBhTHN4UkdHbDIxekhmQXh4?=
 =?utf-8?B?RDA4U1FjTzRqbnpQWE01L2pJSmduZXBmWEVndkVmSEY1NE1Uc3JWdkdpdW1Q?=
 =?utf-8?B?cndwSmFhNlpScE5hRTF2d282c2dMMENrOHl6MDRpQW9NYXFWUVlWRjF6MFF3?=
 =?utf-8?B?VkQ2V2lRbjk0QTlsQ0N1SXMzRU9YVWFRTFZ4bzFHQjRaMnJyK0M5UGRzbDVn?=
 =?utf-8?B?bm1rb09xTWtaaTVjaDRQTyt5WERqS1N2TzlHSkQzbVNTY0hMSDhha1FBd3lt?=
 =?utf-8?B?RllQczlCS0w4UEM5N2lKZjFJclB4RGRmZkVyZTJqd3pTYnFQU1Jjb2Q5ODRp?=
 =?utf-8?B?YlhRREhzY0oydkkvdjZQT3RvOVFzSnliZDdwZm96ZldoUnlacDRpU2FWNjFx?=
 =?utf-8?B?TitvcnZXanRrRWtZRnpOUW9aNURkSnY3WjMrTUF2UDNwSlN5Q1BXMU5JVWFZ?=
 =?utf-8?B?dDc4cHB1TmFXTm43ZVF1YUJiQVBHdjlyWUpGQlJsUnlBWkptTDBNT1VyZ2p0?=
 =?utf-8?B?VnZvYThyL2xlME1vT01LRjlXN0NjV3dsQ3lEc3lHVE40Tk5zK3EwQ2M3Nitj?=
 =?utf-8?B?SENkOWUxMGtzY2ZOMzQxa21SL0lvZnJHZEl2VzVIT1YxS0srelNmeWhwQVRk?=
 =?utf-8?B?Y1MvcUZvclpqVnVqZ2VWVk9Pd0RSWTNqcmlUU2FOWFFadnlSVDJyOEtXZUFU?=
 =?utf-8?B?dnpxRE8ySUJhR3gzWlpoMEw2dVR5Q2V5di91VmUraGhZMWtodmNzM0M3MDVF?=
 =?utf-8?B?Z3oxN0VXMDdUd2lGTEk4OVdBZHZhdHJzRi96TEJsejRmWXFpY2JjUTZwb0ZR?=
 =?utf-8?B?QkcveURHU3FjVnlISUhncnNhTGdPMi8wS0xDdk1rS3JsTElzUWhpQzNDak01?=
 =?utf-8?B?VGtmd0d1d2dwUktwdDhZVXRPeXVnT2R2TTR6ZHg5SWNYTytTTGxEUCtKMVZ4?=
 =?utf-8?B?YndDaDR5Rit5UTJaVm42YUVsaHovT0ZNM05xM2d3aGhxNGNOZ3JwZVVCWldt?=
 =?utf-8?B?eW1qcDdMQ3ZoSTdaUTlsdWRQaGFUeTNQcFBuQk5wL3RvRlpFK2lyRytzYVhm?=
 =?utf-8?B?cmU5K3NlVGlNQWFSUEE3dFB3Q2hQS0JQcURRQkc1aEUvWmYzTVlWSm1STDZz?=
 =?utf-8?B?VmR4NmRWTTcvRDNvb1JJVU4yMlJrVURvc0xoM1hxNTltbG5rSnFsMS82VlpV?=
 =?utf-8?B?dlRqK1dPTFo4dVd0UmxEa1FpZTZabHFLK0lzdlVSUUxOS0RVbFFzdTJRTndi?=
 =?utf-8?B?WnhuRnR5eTBJdEVJSHFVWitnbk1jMHVKZldwQ3U3OWFPSXR4U1dacG1WSzJR?=
 =?utf-8?B?RTVqRjJZSlMrMXYyb1Nja09WQk1zaFQ0Rk5hS3R5T0xCdmNUejJnNTlOOGJ5?=
 =?utf-8?B?b1NDckkzZVRVU1RJY2ZBZUpPYXZ4NHBuN0NUMkhCMS9jYzE5WFJLalgrV3hT?=
 =?utf-8?B?Q1J2UnR4ZHFjdlNzY0w3MVpqYmV4RWRWSHZ3UkRNaUk4NEpBSDZvd2NYVDNQ?=
 =?utf-8?B?UXR0cEl5WVlHam8wOURMdy8vWGVPYnc5VVkwRUcyRjVQdENpb2J3NnM1b2Ew?=
 =?utf-8?B?RGtrRG5FcVVaUmRtMW16RTArNGdpOUttYkxGWmdneWdKQmdYYTFhYitpVmFi?=
 =?utf-8?B?NzlDWkVQdU9JT2hRSnlVSDMzWUM0YjZobWI0MWlYUTRBZlY5dkJzbzMrUEhZ?=
 =?utf-8?B?MjZnV2ZaaGkzVnVWYmRUbjZERGpmVEsyM2VHTk04aXVyeVRUOWNDL2tlZnBP?=
 =?utf-8?B?REJ2Nk1CSkVpMnhsQUZDVDJCbXNHL3dCUmtoQ3lpQk1JNDQ4RDQ2NTFZRXNs?=
 =?utf-8?B?c0NsM1Z2WW53UkdoNVZMZXJHQjlqOU95K04zaFNGRlU4NUVNbkRXdldHMjEz?=
 =?utf-8?B?aytYcWthdklZNmFXMGlmdkNTZXA0MW5FZzAvMVJkaWtYZ3F6bmRlTDM1ZjFF?=
 =?utf-8?B?amROMXU4UUNuQ2lpcndqUUtTZU9JcUtWWGg1NHNBWmhwSzZlMFoyUkVFNHRq?=
 =?utf-8?B?dFlXd2RPc3FWbGlqRmdRQzlLNS9hNEJKdkVpMlBlRy9YY3kvcjZsTWwydXF2?=
 =?utf-8?B?R2kxY211ZUMyd3NHaExXbk1ZaFp5NkNBQXI0S0l0UlplR1JheEM3RTlhYlVI?=
 =?utf-8?Q?lxtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd36c671-52e9-41eb-ff4d-08dbb811acf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:37:05.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQwwegMpfeinpat01i5OZHOXtxkDKVVpTakqQ9T7S+z7i7Ggs2uBaTA6su/RnY1r8Q6l7bX3rkC3vl7cgyedSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDEwOjU1IEFNDQo+IFRvOiBQYXJhdiBQYW5kaXQg
PHBhcmF2QG52aWRpYS5jb20+OyB2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnOyBNaWNo
YWVsDQo+IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFt2aXJ0aW8tZGV2XSBSZTogW1BBVENIIDAvNV0g
dmlydGlvOiBpbnRyb2R1Y2UgU1VTUEVORCBiaXQgYW5kIHZxDQo+IHN0YXRlDQo+IA0KPiBDQyBN
U1QgYW5kIEphc29uDQo+IA0KPiBPbiA5LzE4LzIwMjMgMToyMSBQTSwgWmh1LCBMaW5nc2hhbiB3
cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gOS8xOC8yMDIzIDEyOjMyIFBNLCBQYXJhdiBQYW5kaXQg
d3JvdGU6DQo+ID4+DQo+ID4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPg0KPiA+Pj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMjMgODo0MCBBTQ0K
PiA+Pj4NCj4gPj4+IE9uIDkvMTcvMjAyMyAxOjMyIFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+
ID4+Pj4+IEZyb206IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gPj4+Pj4gPHZp
cnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmc+IE9uIEJlaGFsZiBPZiBaaHUsIExpbmdzaGFu
DQo+ID4+Pj4+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDE1LCAyMDIzIDk6NTkgQU0NCj4gPj4+
Pj4NCj4gPj4+Pj4gT24gOS8xNC8yMDIzIDc6MTQgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToNCj4gPj4+Pj4+IE9uIFdlZCwgU2VwIDA2LCAyMDIzIGF0IDA0OjE2OjMyUE0gKzA4MDAsIFpo
dSBMaW5nc2hhbiB3cm90ZToNCj4gPj4+Pj4+PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzDQo+ID4+
Pj4+Pj4gMSlhIG5ldyBTVVNQRU5EIGJpdCBpbiB0aGUgZGV2aWNlIHN0YXR1cyBXaGljaCBpcyB1
c2VkIHRvDQo+ID4+Pj4+Pj4gc3VzcGVuZCB0aGUgZGV2aWNlLCBzbyB0aGF0IHRoZSBkZXZpY2Ug
c3RhdGVzIGFuZCB2aXJ0cXVldWUNCj4gPj4+Pj4+PiBzdGF0ZXMgYXJlIHN0YWJpbGl6ZWQuDQo+
ID4+Pj4+Pj4NCj4gPj4+Pj4+PiAyKXZpcnRxdWV1ZSBzdGF0ZSBhbmQgaXRzIGFjY2Vzc29yLCB0
byBnZXQgYW5kIHNldA0KPiA+Pj4+Pj4+IGxhc3RfYXZhaWxfaWR4IGFuZCBsYXN0X3VzZWRfaWR4
IG9mIHZpcnRxdWV1ZXMuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBUaGUgbWFpbiB1c2VjYXNlIG9m
IHRoZXNlIG5ldyBmYWNpbGl0aWVzIGlzIExpdmUgTWlncmF0aW9uLg0KPiA+Pj4+Pj4+DQo+ID4+
Pj4+Pj4gRnV0dXJlIHdvcms6IGRpcnR5IHBhZ2UgdHJhY2tpbmcgYW5kIGluLWZsaWdodCBkZXNj
cmlwdG9ycy4NCj4gPj4+Pj4+PiBUaGlzIHNlcmllcyBhZGRyZXNzZXMgbWFueSBjb21tZW50cyBm
cm9tIEphc29uLCBTdGVmYW4gYW5kDQo+ID4+Pj4+Pj4gRXVnZW5pbyBmcm9tIFJGQyBzZXJpZXMu
DQo+ID4+Pj4+PiBDb21wYXJlZCB0byBQYXJhdidzIHBhdGNoc2V0IHRoaXMgaXMgbXVjaCBsZXNz
IGZ1bmN0aW9uYWwuDQo+ID4+Pj4+IHdlIHdpbGwgYWRkIGRpcnR5IHBhZ2UgdHJhY2tpbmcgYW5k
IGluLWZsaWdodCBJTyB0cmFja2VyIGluIFYyLA0KPiA+Pj4+PiB0aGVuIGl0IHdpbGwgYmUgYSBm
dWxsIGZlYXR1cmVkIExNIHNvbHV0aW9uLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGV5IGFyZSBub3Qg
aW4gdGhpcyBzZXJpZXMgYmVjYXVzZSB3ZSB3YW50IHRoaXMgc2VyaWVzIHRvIGJlDQo+ID4+Pj4+
IHNtYWxsIGFuZCBmb2N1cy4NCj4gPj4+Pj4+IEFzc3VtaW5nIHRoYXQgb25lIGdvZXMgaW4sIGNh
bid0IHdlIGFkZCBhYmlsaXR5IHRvIHN1Ym1pdCBhZG1pbg0KPiA+Pj4+Pj4gY29tbWFuZHMgdGhy
b3VnaCBNTUlPIG9uIHRoZSBkZXZpY2UgaXRzZWxmIGFuZCBiZSBkb25lIHdpdGggaXQ/DQo+ID4+
Pj4+IEkgYW0gbm90IHN1cmUsIElNSE8sIGlmIHdlIHVzZSBhZG1pbiB2cSBhcyBiYWNrLWVuZHMg
Zm9yIE1NSU8NCj4gPj4+Pj4gYmFzZWQgbGl2ZSBtaWdyYXRpb24sIHRoZW4gdGhlIGlzc3VlcyBp
biBhZG1pbiB2cSBzdGlsbCBleGlzdCwgZm9yIGV4YW1wbGU6DQo+ID4+Pj4+IDEpbmVzdGVkIHZp
cnR1YWxpemF0aW9uDQo+ID4+Pj4+IDIpYmFyZS1tZXRhbCBsaXZlIG1pZ3JhdGlvbg0KPiA+Pj4+
PiAzKVFPUw0KPiA+Pj4+PiA0KWludHJvZHVjZSBtb3JlIGF0dGFja2luZyBzdXJmYWNlcy4NCj4g
Pj4+Pj4NCj4gPj4+PiAjNCBpcyBqdXN0IHJhbmRvbSB3aXRob3V0Lg0KPiA+Pj4gSSBmYWlsZWQg
dG8gcHJvY2VzcyAicmFuZG9tIHdpdGhvdXQiLg0KPiA+Pj4NCj4gPj4+IElmIHlvdSBleHBlY3Qg
YWRtaW4gdnEgdG8gcGVyZm9ybSBsaXZlIG1pZ3JhdGlvbiwgaXQgY2FuIGNlcnRhaW5seQ0KPiA+
Pj4gYmUgYSBzaWRlIGNoYW5uZWwgYXR0YWNraW5nIHN1cmZhY2UsIGZvciBleGFtcGxlOg0KPiA+
Pj4gYSkgYSBtYWxpY2lvdXMgU1cgY2FuIHN0b3AgdGhlIGRldmljZSBydW5uaW5nDQo+ID4+PiBi
KSBhIG1hbGljaW91cyBTVyBjYW4gc25pZmYgZ3Vlc3QgbWVtb3J5IGJ5IHRyYWNraW5nIGd1ZXN0
IGRpcnR5DQo+ID4+PiBwYWdlcywgdGhlbiBzcGVjdWxhdGUgZ3Vlc3Qgb3BlcmF0aW9ucyBhbmQg
c3RvbGUgc2VjcmV0cy4NCj4gPj4gVGhpcyBpcyB0aGUgbW9kZSB3aGVuIGh5cGVydmlzb3IgaXMg
dHJ1c3RlZC4NCj4gPiBQRiBpcyBub3QgYWx3YXlzIG93bmVkIGJ5IHRoZSBoeXBlcnZpc29yLCBy
aWdodD8NCj4gPiBBbmQgeW91IGRvbid0IHBhc3MtdGhyb3VnaCB0aGUgUEYgdG8gYW55IGd1ZXN0
cywgcmlnaHQ/DQo+ID4+IFdoZW4gaHlwZXJ2aXNvciBpcyB1bnRydXN0ZWQsIHRoZSBDQyBtb2Rl
bCBURElTUCBlbmFibGVkIGRldmljZSwgVFNNDQo+ID4+IHdpbGwgZGVsZWdhdGUgdGhlIHRhc2tz
IHRvIHRoZSBEU00uDQo+ID4gVERJU1AgZGV2aWNlcyBjYW4gbm90IGJlIG1pZ3JhdGVkIGZvciBu
b3cuDQpUaGF0IGlzIGZpbmUsIHRoZSBpbmZyYSBpcyBidWlsZCBzbyB0aGF0IGl0IGNhbiBiZSBt
aWdyYXRlZCBvbmUgZGF5Lg0KQW5kIGF0IHRoYXQgcG9pbnQgdGhlIHByb3Bvc2VkIGFkbWluIGNv
bW1hbmQtYmFzZWQgbW9kZWwgYWxzbyBmaXRzIGZpbmUuDQoNCj4gPj4NCj4gPj4gRm9yIHVudHJ1
c3RlZCBoeXBlcnZpc29yLCBzYW1lIHNldCBvZiBhdHRhY2sgc3VyZmFjZSBpcyBwcmVzZW50IHdp
dGgNCj4gPj4gdHJhcCtlbXVsYXRpb24uDQo+ID4+IFNvIGJvdGggbWV0aG9kIHNjb3JlIHNhbWUu
IEhlbmNlIGl0cyBub3QgcmVsZXZhbnQgcG9pbnQgZm9yIGRpc2N1c3Npb24uDQo+ID4gdGhpcyBp
cyBub3QgaHlwZXJ2aXNvciwgRG8geW91IHNlZSBhbnkgbW9kZXJuIGh5cGVydmlzb3IgaGF2ZSB0
aGVzZQ0KPiA+IGlzc3Vlcz8NCj4gPg0KPiA+IFRoaXMgaXMgYWRtaW4gdnEgZm9yIExNIGNhbiBi
ZSBhIHNpZGUgY2hhbm5lbCBhdHRhY2tpbmcgc3VyZmFjZS4NCkl0IGlzIG5vdC4NCkh5cGVydmlz
b3IgaXMgdHJ1c3RlZCBlbnRpdHkuDQpGb3IgdW50cnVzdGVkIGh5cGVydmlzb3IgdGhlIFRESVNQ
IGlzIHVuaWZpZWQgc29sdXRpb24gYnVpbGQgYnkgdGhlIHZhcmlvdXMgaW5kdXN0cnkgYm9kaWVz
IGluY2x1ZGluZyBETVRGLCBQQ0kgZm9yIGxhc3QgZmV3IHllYXJzLg0KV2Ugd2FudCB0byB1dGls
aXplIHRoYXQuDQoNCj4gPj4NCj4gPj4+PiAjMyBUaGVyZSBpcyBubyBRb1MgaXNzdWUgd2l0aCBh
ZG1pbiBjb21tYW5kcyBhbmQgcXVldWVzLiBJZiB5b3UNCj4gPj4+PiBjbGFpbSB0aGF0DQo+ID4+
PiB0aGVuIHdob2xlIHZpcnRpbyBzcGVjIGJhc2VkIG9uIHRoZSB2aXJ0cXVldWVzIGlzIGJyb2tl
bi4NCj4gPj4+PiBBbmQgaXQgaXMgY2VydGFpbmx5IG5vdCB0aGUgY2FzZS4NCj4gPj4+IFBsZWFz
ZSBkbyBub3QgY29uZnVzZSB0aGUgY29uY2VwdHMgYW5kIHB1cnBvc2VzIG9mIHRoZSBkYXRhIHF1
ZXVlcw0KPiA+Pj4gYW5kIGFkbWluIHZxLg0KPiA+Pj4NCj4gPj4gSSBhbSBub3QgY29uZnVzZWQu
DQo+ID4+IFRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IGEgcmVnaXN0ZXIgcGxhY2VkIG9uIHRo
ZSBWRiB3aWxsIGJlDQo+ID4+IHNlcnZpY2VkIGJ5IHRoZSBkZXZpY2UgaW4gZXhhY3Qgc2FtZSB0
aW1lIHJlZ2FyZGxlc3Mgb2YgVkYgY291bnQgPSAxDQo+ID4+IG9yIDQwMDAuDQo+ID4+IFlldCBh
Z2FpbiBub3QgcmVsZXZhbnQgY29tcGFyaXNvbi4NCj4gPiBwbGVhc2UgcmVhZCBteSBwcmV2aW91
cyByZXBsaWVzIGluIG90aGVyIHRocmVhZHMuDQpJdCBkb2VzIG5vdCBhbnN3ZXIuDQpUaGUgY2xh
aW0gdGhhdCBzb21laG93IGEgcG9sbGluZyByZWdpc3RlciBlbnN1cmVzIGRvd250aW1lIGd1YXJh
bnRlZSBmb3Igc2NhbGUgb2YgdGhvdXNhbmRzIG9mIG1lbWJlciBkZXZpY2VzIGlzIHNvbWUgc3Bl
Y2lmaWMgZGV2aWNlIGltcGxlbWVudGF0aW9uIHdpdGhvdXQgZXhwbGFuYXRpb24uDQoNCj4gPj4N
Cj4gPj4+IEZvciBkYXRhLXF1ZXVlcywgaXQgY2FuIGJlIHNsb3cgd2l0aG91dCBtcSBvciByc3Ms
IHRoYXQgbWVhbnMNCj4gPj4+IHBlcmZvcm1hbmNlIG92ZXJoZWFkLCBidXQgY2FuIHdvcmsuDQo+
ID4+IE5vLCBpdCBkb2VzIG5vdCB3b3JrLiBUaGUgYXBwbGljYXRpb24gZmFpbGVkIGJlY2F1c2Ug
b2Ygaml0dGVyIGluIHRoZQ0KPiA+PiB2aWRlbyBhbmQgYXVkaW8gZHVlIHRvIG1pc3NpbmcgdGhl
IGxhdGVuY3kgYnVkZ2V0Lg0KPiA+PiBBIGZpbmFuY2lhbCBhcHBsaWNhdGlvbiBpcyB0ZXJtaW5h
dGVkIGR1ZSB0byB0aW1lb3V0cyBhbmQgcGFja2V0IGxvc3MuDQo+ID4+DQo+ID4+IERldmljZSBt
aWdyYXRpb24gaXMganVzdCBhbm90aGVyIDNyZCBzdWNoIGFwcGxpY2F0aW9ucy4NCj4gPj4NCj4g
Pj4gSXRzIGFsc28gc2FtZS4NCj4gPj4gTXkgbGFzdCByZXBseSBvbiB0aGlzIHZhZ3VlIGFyZ3Vt
ZW50Lg0KPiA+IEkgdGhpbmsgdGhlIHBvaW50cyBhcmUgY2xlYXIsIGFuZCB5b3UgYWxyZWFkeSB1
bmRlcnN0YW5kIHRoZSBwb2ludHMsDQo+ID4gc28gbm8gbmVlZCB0byBhcmd1ZSBhbnltb3JlDQpZ
ZXMsIEkgYW0gY2xlYXIgZnJvbSBsb25nIHRpbWUsIG5vciBBUSBub3Igbm8gcmVnaXN0ZXIsIFJT
UyBxdWV1ZXMsIG5vbmUgY2Fubm90IGd1YXJhbnRlZSBhbnkgcGVyZm9ybWFuY2UgY2hhcmFjdGVy
aXN0aWNzLg0KSXQgaXMgcHJldHR5IGNsZWFyIHRvIG1lLg0KQW55IHBlcmZvcm1hbmNlIGd1YXJh
bnRlZXMgYXJlIGV4cGxpY2l0bHkgcmVxdWVzdGVkIHdoZW4gZGVzaXJlZC4NCg0KPiA+Pg0KPiA+
Pj4gRm9yIGFkbWluIHZxLCBpZiBpdCBkb24ndCBtZWV0IFFPUyByZXF1aXJlbWVudHMsIGl0IGZh
aWxzIHRvIG1pZ3JhdGUNCj4gPj4+IGd1ZXN0cy4NCj4gPj4+DQo+ID4+PiBJIGhhdmUgcmVwbGll
ZCB0byB0aGUgc2FtZSBxdWVzdGlvbiBzbyBtYW55IHRpbWVzLCBhbmQgdGhpcyBpcyB0aGUNCj4g
Pj4+IGxhc3QgdGltZS4NCj4gPj4gSSBhbHNvIHJlcGxpZWQgbWFueSB0aW1lcyB0aGF0IFFvUyBh
cmd1bWVudCBpcyBub3QgdmFsaWQgYW55bW9yZS4NCj4gPj4gU2FtZSBjYW4gaGFwcGVuIHdpdGgg
cmVnaXN0ZXJzIHdyaXRlcy4NCj4gPj4gUGVyZiBjaGFyYWN0ZXJpc3RpY3MgZm9yIDMwKyBkZXZp
Y2VzIGlzIG5vdCBpbiB0aGUgdmlydGlvIHNwZWMuIEl0IGlzDQo+ID4+IGltcGxlbWVudGF0aW9u
IGRldGFpbHMuDQo+ID4gYXMgcmVwbGllZCBtYW55IHRpbWVzLCByZWdpc3RlcnMgb25seSBzZXJ2
ZSB0aGUgZGV2aWNlIGl0c2VsZiBhbmQNCj4gPiByZWdpc3RlcnMgYXJlIG5vdCBEQVRBIFBBVEgs
IG1lYW5zIHRoZSBkZXZpY2UgZG9uJ3QgdHJhbnNmZXIgZGF0YQ0KPiA+IHRocm91Z2ggcmVnaXN0
ZXJzLg0KDQpJdCBkb2VzIG5vdCBtYXR0ZXIgZGF0YSBwYXRoIG9yIGNvbnRyb2wgcGF0aCwgdGhl
IGZhY3QgaXMgaXQgZG93bnRpbWUgYXNzdXJhbmNlIGNhbm5vdCBiZSBndWFyYW50ZWVkIGJ5IHJl
Z2lzdGVyIGludGVyZmFjZSBkZXNpZ24sIGl0IGlzIHRoZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxz
Lg0KQW5kIHNvIGRvZXMgZm9yIGFkbWluIGNvbW1hbmRzIGFuZC9vciBBUS4NCg==

