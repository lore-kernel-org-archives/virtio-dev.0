Return-Path: <virtio-dev-return-13034-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3034AEB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:05:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3BF232A8FB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DCD6986858
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 048699865D1; Thu, 22 Jun 2023 01:05:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E7649865D0;
	Thu, 22 Jun 2023 01:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMPiieIkAxb7fB4bgF1FtWaz6XiVU6REbW2Wg3xZw0LmqEikddMiBymTrzla5+TQAKHWpcNDCSbQDFcelDqZc0WP7f3Mcxy0xOkAX4Mp9iiKYm+/ANWk5bBNjJt0YdtSkkkzKY50MlY3VTCDR4RFeRlMKjCxLSGtkNdIwFRkXvZqUFc2R3+V8GDXLHlut9LAPTAlX64ntDfaEIZKYlMOBURqBWDWRv+WFGTaUUrx5hfmWnQoDuo0EcP5lF1QNTu5DmqwqP1nCnvhJ5Ta80lsQ5wkkNYsDF/wtTUFz0kO0Gm6+xQwjBqhrlomll4e0yvJr9eN6k9yqRktsFLkk+SpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yxRRA++Vk69RefNh8biK1psBwro/aUUpKeyQFDUOQk=;
 b=JymnUIPoaJj4oWsbVhlpIFUnkTGR6xuh/SVDJooVMzA4oXwzGZQIHkHOhMpt7j7n3KgWWjDvdKHl34gpWNI95RLS2RX/EkqNoN7CaKPwczxcKFdRYEg/RxAP/GldZO4+U1wZUaIjX3LrqG4binw9HSxZXJpbTMev1k1a1YXA8tiXOYPRdbY0KSoTaz6i+AdOxd5EZEHFqp6zUoU5FP4Bigf1VyWvm9AIxjUczvCYpC6xjiy6jr9BhlJO3gzz1MRzxfUFk0SxpVr5tG+O8aiUuH1QiCgTidSYwSOR/kt7NAAFNCjQ+9BTQcabglgbnyB86xKZLTtbhRuq8ok1UAPdPw==
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
Thread-Topic: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAEcwAIAAAHoA
Date: Thu, 22 Jun 2023 01:04:30 +0000
Message-ID:
 <PH0PR12MB548161398FD1A470FBA6E604DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4cdc8590-be35-fa58-9c5f-bd0ecf5d5661@linux.alibaba.com>
In-Reply-To: <4cdc8590-be35-fa58-9c5f-bd0ecf5d5661@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB9246:EE_
x-ms-office365-filtering-correlation-id: 974f4b97-6c82-40bd-993a-08db72bca297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dBx4c5Efb/fxP2BDdc+T99HOqIrczleiZEfTpx7rdtSDscWA98T7IIv9YCFYcxmO+h2peM9r+bMjjGdNNKBR+b+luQ7DVvaRnvVO2sP2N+PFVYrDpX7QS8tVhuA/M4UUnCB/0AcOSY/3qwYecXEw43rW76mGDJAAoPBJ4dA6TqO2WKQNBQJ3SZcQcvDHXMRcu27KXso2YACNPJ6+ghR1kE+yONwUVr1c5MsJRaYRjBcCUnUmCoZ0sYoBnDIbJkAuYY72kdpBVYP0sxWsm9qUjPqeno9ZQndpUr782Ww2fvSxD73qkktNmZXVwck7v+75kNlkn98Uv0VUWQJr/P/8Htfx3zfyqUR19wBX5R7HMWRC9hsRLhpp6jegKknsmut3+AlXrcICm3nreTvfbhKkwyWEDdTyq3uRPJ6pT33N5hKJ3CwUE/O1ZPFrwj+5I4Gyus13RRUQ0V/ingc3rfGuO7gUURK/Q878axOeEYK1B/2wws2vGLII4MDF7WtkaflIl/cQlOpJDBcBAKbfZoZ+N86fT1ELzw+HRMI8q8OLxVzneRIzeGMPm2CDqCI/ooSFwvo2DEitlX4j9bykeCpXC1tylZ5Sk8nRCSIhh+sniQ5jbHtByllUgHnL+lLN2kPe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(122000001)(6506007)(186003)(9686003)(26005)(38100700002)(55016003)(8936002)(8676002)(41300700001)(5660300002)(33656002)(2906002)(52536014)(38070700005)(71200400001)(478600001)(7696005)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(83380400001)(110136005)(54906003)(316002)(86362001)(4326008)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmpSQmViaEUyczU1bEdJRWRCSVQ4TzZSYituS2NXTmJqeWE3NjJNVXdHQ0dV?=
 =?utf-8?B?MXBDYWhHcVV6b1cxZ29CQ05rYXN3VVZCeGF4NjFjRFNrUHBKQjU2TUhEbHJq?=
 =?utf-8?B?Ni9lS1l5NTRUNHRyTm5FTEVjczgrUnQvYVpzbldzZXZwNy9pbnJZcmNraW1S?=
 =?utf-8?B?UXlRMjVaai93TGdYVmxpdlE2ei9JZ3dCQk82QVc5cmpPM3c0elNWUE50c0VV?=
 =?utf-8?B?ZVpBbnlzRWtSODI3ZW9PK3k0bWVDMDJJZVpBVThsbm5ha1RTTDdKSVgzdFdY?=
 =?utf-8?B?MER6VXZvdE9UVzVxTVRPbkwreGxpOG9YUjZFTFN5T3hIbENNdEJaUDdwYVZY?=
 =?utf-8?B?RTYzdTR6ekg3T3VrUXEyMERBWGFPTEplTXdnWDB6Wm5kdzNqOGUwQmVVMGth?=
 =?utf-8?B?M1lPTXdkTzJRSjZ5UmdyZGxxb2sySnErQ1hraHRvdndBbkh4R1JTbDlKK3Ra?=
 =?utf-8?B?VHpwSHYrR0dEQ0Z1NmpQK3VidnpxTm4xdm1MSzdPcUkzclIzdEFTbjZ0dlFj?=
 =?utf-8?B?VTVMRVA4NVorTGxNZ3JFby9TZmZlcnRteXNGMUkwcjIwejdkMWtxN25jMXVC?=
 =?utf-8?B?Z1grRVZEL1R6bjE0TkJPL1lCL0syUTZMOUZMMVF6a1VkR1BQQkZhMXBZSHJu?=
 =?utf-8?B?clpOZm4rTnpZSmxEZTZjSUtRY3I0cVhScGZ1TmM3eE9XVFhpMlcwNVhwbUZC?=
 =?utf-8?B?anRmR0RtMjA5UnRLZThPSnpHR0VkcWxRVVg5aU1DZ1lEN011b3lXM2xzTkFB?=
 =?utf-8?B?MFc4R0l4cmFsbU5GQzd5REt1d2c2VC9NTGFoTFJwSVorM0trWm9BcUhyTlp3?=
 =?utf-8?B?QXRVTmw4RzFkZkcxd2VaRGFweGsrN0VYTHRxa1RpdGdwRHdNNlN4anRkR2FW?=
 =?utf-8?B?dXhnbkdXOTNaSjhycklYUnBNYWVEU0s2NHVFaHhxdW5rMmtsVktsdnJmTzli?=
 =?utf-8?B?c3VrZ2FyMWxJSWNRd2haTVZWaTJHWWhVcHZZcEdKQWdWM0hCZ2FqdnhHTlls?=
 =?utf-8?B?Sm43dWwyNXlwOG5RZ0hyWTEvVGQwZkhvYzh5RkVkRWwxT2xZVllXNGNRSjVY?=
 =?utf-8?B?akp2MG51S1pIYW9hNVc2TzI1M05MY3ZyTkJWd1ZsdGgyQjdyazZIRyt1K2xz?=
 =?utf-8?B?ZnppQTQzUkJvS0s3VTh5Nk50Wkk2aGx5R2lkWDF0MU0rTmw3REFIcFo2dFR2?=
 =?utf-8?B?di9PbHpVSURncFExbnkyVHFxVzdTbFJoK1QrR0R2dU5lbk5LZlRxOHI3ZW1k?=
 =?utf-8?B?UU83ZHMxWFgyNFZPMklhU2d6RTg2QnYzdFYzem5zU1FPMTNGMlNtblAzMWlX?=
 =?utf-8?B?eUhoTFA0TWJLM2tJT3lpa3ZHYXlRMURZc0JPeWt5Nk0rQ0YwaldhdlZnRHlB?=
 =?utf-8?B?MEVwM0pHaWloQXgwWklTdjRta1NuOU50R0tLRzJCNmtQU2lkK05CWFdBYStQ?=
 =?utf-8?B?bHJhMng4WDNKNlViWUVLQ2c0RmVPUUtvNDVYSDhkOW9MaW1WL29zUXNrZk5y?=
 =?utf-8?B?RE5QbS9wTXNzWmtHNVJleVo1bU41S3llQndTb21Zem9KbHVHekY3MXVsTGZC?=
 =?utf-8?B?azRFWGxEWEVMSC9NdHVoSEpBRFZZNzRiZXdCcHJUcmxhTldTTjRCZlN1c1pD?=
 =?utf-8?B?NGptc0xudE1rRXlqUUZ2OGhQeVdnZmxaM2FVYTJocENWeVpRV04xZTVIbDdV?=
 =?utf-8?B?bVR6Ui8yK05sY2duNi9WZkhtOGFBc3hRbkpFOURQVXE1U28zbGlERUJHWDhj?=
 =?utf-8?B?MlJQWEF4R3FtYzFhZXhNWi8ySUpFRGl4NjZYS3dKYXJCUFkrdXZqYnZSRGpv?=
 =?utf-8?B?dlNsRUJmQ2VWbm9kbW90WmdUV2xEdE4xeDZFM3RwU3R3c0NVd0doRDdIcnJa?=
 =?utf-8?B?UFRjbm0rckh5R3o0c2V5VnIzd0pIVzgxd2NFdVRUTDF6NkpnT0JWT0lIRVhH?=
 =?utf-8?B?L2tDYUJqUWMxdHUzNTM2RFg5MVdKT2NYWkRZaWxXT2NVSlEyYU9YdGIwMEkr?=
 =?utf-8?B?aEtBVW50akZYbGVXSjFXd2dwZFF4TGZndFk4RlpwWUk5NGpnNHRuWU1FT0hT?=
 =?utf-8?B?c0k3ZkQ5WHNtcmd5cUhiVWtwaDNRN3JxU0cvQ3VENlRoMnJocHNUV3VPL01B?=
 =?utf-8?Q?pG3o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974f4b97-6c82-40bd-993a-08db72bca297
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 01:04:30.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdeziUxOn/xDoSH6ttZuuY4+HyrkUueYc3vyarhCVzcYV0JL1Ty56lN/38iJOc+waupmW4midoeJs4/xH3nWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
Subject: RE: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash

DQoNCj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIEp1bmUgMjEsIDIwMjMgODo1OSBQTQ0KDQpbLi5dDQo+ID4gV2UgZGlzY3Vzc2Vk
IHRoaXMgaW4gdGhyZWFkIHdpdGggeW91IGFuZCBKYXNvbi4NCj4gPiBJIHByb3ZpZGVkIGNvbmNy
ZXRlIGV4YW1wbGUgd2l0aCBzaXplIGFuZCBkZXZpY2UgcHJvdmlzaW9uaW5nIG1hdGggdG9vIGFu
ZA0KPiBvdGhlciBleGFtcGxlIG9mIG11bHRpLXBoeXNpY2FsIGFkZHJlc3MgVlEuDQo+ID4gU28g
dHJhbnNwb3J0aW5nIHJlZ2lzdGVyIGJ5IHJlZ2lzdGVyIG92ZXIgc29tZSBhZG1pbiB0cmFuc3Bv
cnQgaXMgc3ViLW9wdGltYWwuDQo+IA0KPiBQYXJhdiwgeW91ciBpbXBsZW1lbnRhdGlvbiBwcmVm
ZXJzIHR3byBzZXBhcmF0ZSBzdHJ1Y3QgdmVyc2lvbnMgYW5kIGRvZXNuJ3QgbGV0DQo+IHN1cHBv
cnRlZF9oYXNoX3R1bm5lbF90eXBlcyBleHBhbmQgaW4gY29uZmlndXJhdGlvbiBzcGFjZS4gSSBy
ZW1lbWJlciB0aGlzLg0KPiBJIGFncmVlIHRoYXQgd2UgZG9uJ3Qgd2FudCB0byBqdW1wIGJhY2sg
YW5kIGZvcnRoLCBlc3BlY2lhbGx5IGFzIHRoZXJlIGFyZQ0KPiBwcmFjdGljYWwgcmVhc29ucyBh
bmQgNSB2ZXJzaW9uIGp1bXBzIHRvIGdldCBzdXBwb3J0ZWRfaGFzaF90dW5uZWxfdHlwZXMNCj4g
YmFjayBpbnRvIHRoZSBjb25maWcgc3BhY2UuDQo+IA0KUmlnaHQuDQoNCj4gVGhlIG9yaWdpbmFs
IGludGVudGlvbiBvZiBNaWNoYWVsJ3MgcHJvcG9zYWwgdG8gbWVyZ2Ugc3RydWN0dXJlcyBpbiB2
MTggc2hvdWxkDQo+IGJlIHRoYXQgdHdvIHNlcGFyYXRlIHN0cnVjdHVyZXMgd2lsbCBjYXVzZSBh
c3luY2hyb255Lg0KDQo+IEkgZG9uJ3QgdGhpbmsgc28sIHRoZSBkcml2ZXIgY2FuIGNhY2hlIGVu
YWJsZWQgaGFzaF90dW5uZWxfdHlwZXMgZXZlcnkgU0VUDQo+IGNvbW1hbmQuIE9yIGFmdGVyIHRo
ZSBTRVQgY29tbWFuZCB0aGUgZHJpdmVyICpTSE9VTEQqIHVzZSB0aGUgR0VUDQo+IGNvbW1hbmQg
YWdhaW4sIHdoaWNoIGlzIHRoZSB3b3JrYXJvdW5kLg0KPg0KVGhlcmUgaXMgbm8gbmVlZCB0byBw
ZXJmb3JtIEdFVCBhZnRlciBTRVQuDQpBIGRyaXZlci1kZXZpY2UgY29udHJhY3QgaXMsIGlzIFNF
VCBjb21tYW5kIHJldHVybnMgc3VjY2VzcywgaXQgbWVhbnMgZGV2aWNlIGFjY2VwdGVkIHRoZSBj
b21tYW5kIGFuZCB3aWxsIGFwcGx5IHRoZSBmaWx0ZXIuDQpJZiBkZXZpY2UgZmFpbHMgaXQsIHRo
ZXJlIGlzIGFueXdheSBlcnJvci4NCg0KTGF0ZXIgd2hlbiBpZiBkcml2ZXIgd2FudHMgdG8gbW9k
aWZ5IHRoZSB0dW5uZWwgdHlwZSAoYWRkL3JlbW92ZSksIA0KYS4gZWl0aGVyIGl0IGNhbiB1c2Vk
IHByZXZpb3VzbHkgcmVhZCBzdXBwb3J0ZWQgdHlwZSAoaWYgY2FjaGVkIGluIGRyaXZlcikNCmIu
IGlzc3VlIEdFVCB0byBrbm93IHN1cHBvcnRlZCB0dW5uZWwgdHlwZXMgKGlmIG5vdCBjYWNoZWQp
DQogDQo+IFRoYW5rcy4NCj4gDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJlQGxpc3Rz
Lm9hc2lzLW9wZW4ub3JnDQo+ID4gRm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDogdmly
dGlvLWRldi1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQoNCg==

