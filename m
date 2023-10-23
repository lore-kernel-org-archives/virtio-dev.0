Return-Path: <virtio-dev-return-14014-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD36ECDB474
	for <virtio-dev@archiver.kernel.org>; Mon, 23 Oct 2023 13:35:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 13197795A9
	for <virtio-dev@archiver.kernel.org>; Mon, 23 Oct 2023 13:35:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CC999869A2
	for <virtio-dev@archiver.kernel.org>; Mon, 23 Oct 2023 13:35:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 01420986987; Mon, 23 Oct 2023 13:35:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFB14986677;
	Mon, 23 Oct 2023 13:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C69HyAAKUADxAOss5USzb/DaX4M8EsTyJYlwFMkVFaSEIOsveLpdbaNWKAkoO1s2dqdvrC8A69DElO7E+efgcuQPKfRRPpkOfpNoCPbtXdeo8PO/I7dOk1y7eRWNUY5JCIZltPz9BITMxHwpUV4CxcJWwDK5g/uxjKLmPhPqLPl77EK75WpePNUy+BvZ7/WTYmfgfCaxI8YxsEh03SjXVNAj9XepDLbfs73b45w6BuPq0kfWD5m4fZfqYRUNqw4Z6rvV5cOCgOaJZgYdK0XJNDUCorOwRcNinPtHyeiPFZtBOrSFHKSlSqx6Y/qT7l4nRsxX3qnf2ejgFVohPsbRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td5WjqCwL8x1xCR1Y0OGJ7Zi9SkLLQ46XmCOMhcFxPE=;
 b=i1i15jIyLzyTjKIAbCNAYsNCRQsBt8QistflvWC7Cs1XS50vYLv8zRpGJ20CcnHhLBZJPrNtEPvv2FtyOf6qe6xjINyo2KOA2SFkpIeo77t7s72n6asvw5ykLe09wuMMjMSqsSx4/SFpf7AgrbUuvfDxb84TBpsrBKBKkDRajYFRVjDm2N4CpX0u4ezvdt8RFcVS9krYT9rgu6seBf7M0MFhytBe9gShPs3wIhjt0534dwYCu9ixHA3T77RNHaAurhvRGZ+xWS3sUvDjmPaj1X4ZFRX+CtFtMWeGSggYzTc3oVA2meTylY1O3qlyoXJvEpa/Ke9EqR40uX6+V8EFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Thread-Index: AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEA==
Date: Mon, 23 Oct 2023 13:35:19 +0000
Message-ID:
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5326:EE_
x-ms-office365-filtering-correlation-id: 1832bada-f4ce-49d3-01bb-08dbd3cce647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5j8k3LEYhnTpWekT2XI7QeYkZH9TfMxs1B76cXYWnUV70NmMIp7kBWxgzNPHeXWZTPfISVwR+qZtetFKQm+/IroS/v8BTs8OtHwuMQseFUPSuWyYtxkMKYQIE1bEJ7IjEOW4xR6w/uHCsj9qfEYLuqRho1PcyNQ4VDil8TavhuH7b6VTikH0hzjCvBAsgDQvNfHdN6WLsOFk5ulv4RzeSJmb5HOkmwXoNrzquK2Io19OqzKFjEHza7iDMmlKI8O3RUUCj2UjbOitjDuSX+zVlekvJsJjiwd9cKDwYA7phsFSNuqUAWTPK79cpuSxejoUmfbm/Sglg3O4Qg9mabglq29NS7jUeWtG9bCzW6Oav300VztdXZIuCYkEnB1Lg5PIATgJ+OlykkDjbOrLaEjv9GsnwUrN9YO4GAJLX0/3k4KJyJjLrx6y8S9E+5vgC83wBwHsAblBwzmDLVvvf8KPTwkjQ09Z2mNn3m6QcmTw1AKyfRDqUgde0E7wzjZCHfKWbcx2mq+fyFl5s3hoNs0/vxfWokf0FYAjs7SmVBkNnttjTu84zaQHFSmbOzHkKfbyExr8DCp7WTX9hcLpPTNcFmJsiwx6BIhS8pS+kCgaWX7+jV2JfLhHV4QmEox7POL1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(55236004)(33656002)(55016003)(66946007)(316002)(64756008)(54906003)(66476007)(6916009)(76116006)(66446008)(86362001)(38070700009)(38100700002)(122000001)(66556008)(83380400001)(26005)(9686003)(71200400001)(6506007)(7696005)(8936002)(2906002)(478600001)(5660300002)(41300700001)(7416002)(52536014)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzNIb2dNTUZYVEhvbEFubGRsVzU3WXJYY0JOWnRVZXJZdEtmcUVmSXRGRE9G?=
 =?utf-8?B?TTRGM2N6dzJueEdSSjB2amQ4dlJJYjIrL1d3eUJHTTEvaXN6aTJvMzJzaWhL?=
 =?utf-8?B?QS9XVWl3R1hzYWREMXBsM215V1o5YUU0SWt6cTdpYTNRK1dBWmxhdFZFU09a?=
 =?utf-8?B?NSt6a1E0V2JDUnZMQjlucDFkMVM2NzNLWk8yWmorYUFLeUNxZktxTjRZTHJT?=
 =?utf-8?B?K3diSnAzSk42RHA3THJSbFZ6T3JqUks1cFN4dnhGeEFabC8xeWhCSEY0em9q?=
 =?utf-8?B?emJ5eGF5QmNjQXF3VUdpVFhvckQzMU55MUFPbnRCbWlic1M5bnhWenVwVlJO?=
 =?utf-8?B?bXVLUGVvWWhtOTIyKzRadGJldnNzazlQSGF5cWlUSXdVdi9lQ3R5V0t1NWh0?=
 =?utf-8?B?TEVwOUNzcVh4TEREeEsvZldMdmYxN1RJaGdOcVcwR2R6TS9GaGVPS2tlcnN5?=
 =?utf-8?B?eHFucytUQVdYZkQrRzRnS2ZLOU82YWFGTHdmRWx3SlBNNGxhL1JlOVRsSjNo?=
 =?utf-8?B?UmNSbGRRNCtaUXMvMWcwUVozcGEzb2M0d2JTc3MzeGNIKzBiekxYblBmTDNn?=
 =?utf-8?B?a3Q3YS9wVks1ZVlKOExUTmRZV1pjckpuZEVBc0dhODNtTWx2Sld3dzJpUUwv?=
 =?utf-8?B?SkNxY0djTXlEWVdHanFTYldGeDlScU5HdzZjYTJ5ZDd4NHVhMC84TnE5NVV3?=
 =?utf-8?B?QVNDSTlYNTRXMHEyMXpDYU40eTN0YjNOTTFDY0VUdkxETER5YnBJaStScUEr?=
 =?utf-8?B?ZUg1RnIwcGozRkorUlhUQklHbittMGNXV3U4VzIxNU9ldE1nT1VuZ0FZTHFM?=
 =?utf-8?B?OWtzL3hGdUI3a2JLZ2FnWmp3bGp0S0habTgzQzg2MFJXT25lTWZJVGd2VlJ1?=
 =?utf-8?B?RlZWbXd1cy81S1lMY2pMQ3JEazFPQUR2OHA3ZlEycWhkUzlCVjJ5QmZyRk9l?=
 =?utf-8?B?ZjR4NzBYdFJrNE9OcnVHRmNyTVdCc2N4cjY5MFJ3WlBDVkxvaE1tRHErQVI3?=
 =?utf-8?B?VHNFYjlVRWhtaFJqdVI1b3RFOFRaMlVnbWIrZGJpMVJoY3h4emg5S05POWcv?=
 =?utf-8?B?cUpxQ0V2OHd1MEVNNlRIUW1EM0sxYVlaSDF3ZjdMeU5CeHZxRVJaaVp1NFJn?=
 =?utf-8?B?VFQ0bEU5MmxYNlZXNHFMMHpZVWx3T3FtYTJpSjQxRFJKK2JVdVNFRmsweGF2?=
 =?utf-8?B?WFNRZDFqa3hRaXB0bmtuTGpXMGN0N0VYSSthUFVpa2JaZjVWY2ZqWFdjRkJ4?=
 =?utf-8?B?U2RXc1FWWHB6emlGSERGMm1XSlQ0UnJHUHAzd2xuVjdBa2Z1ZHFaMEVxTUIy?=
 =?utf-8?B?YmZIa0R5Mkt2U0I1U1p1ZTNDVkRMWXk2L3hGK3hHNVZmdWlveU55RWFlTldX?=
 =?utf-8?B?U0l1YXpkT0dJTzcxeXNjR1YvLzNuVWZLZXVrTUM3Z3VrY0lWcHJHSElWRWNI?=
 =?utf-8?B?UC9OQmU4Tmk5ZVdaMEZudWgybnlXY0ZVc21KWEFzRkNiU0N3ZmhlSHlPaWFE?=
 =?utf-8?B?Skg1Y2ZEMi9RMWk4S2lpQmhITzI1NXhVRGtxeC9pNlpjREdicDFMSHd5Y1k1?=
 =?utf-8?B?L0NQMmVDTVpoa3BJbmtrcjlSaDg2UTFsQzFDUDlQTFdVS0p1eUNxZEV5RjU0?=
 =?utf-8?B?K0c3K0F2OEY4ZnVvdlhCUmRSUVRtRURDdllJZGYzWUlGcWZBa1ZYTjl1VkMx?=
 =?utf-8?B?cGkrb3ZqakQ4L1R1NDNUaGJDRk1TTElsNHZlVWhjNHdTUThMSSszeUQxTFg3?=
 =?utf-8?B?dm0yekd3dVhyTk1KZ0YxN1pCSytUQmpiVFBLZGwwbmZGUmVhVzhRL3ZXUEQ1?=
 =?utf-8?B?UkpINk9tQzk4d2FrdHlLYlUwMUNhbm5IZzVvdnFuaHdVNFZheHhOK1o1R09i?=
 =?utf-8?B?NmFQOStYK3VYNFMwQnF2cC9PQ0JvaEZXMjE1YjVNcVdkTFhvYWRNcG9QQ0Vv?=
 =?utf-8?B?QmcyeVMwMG04VXNIdDl3d3FzT21Gb2hPNnBqV0NhZkZmRjZmaCtpc2UvZ2Z6?=
 =?utf-8?B?NTJNdTdQRUlnZys1bVJhaVM0am5JYVN5N1dWRy9idmkrd3gyTkE4eUY5czNB?=
 =?utf-8?B?R2lKZzdIZUdFRGJXSGpBSE1Ud2FEbDNYRkdiS2F6N0dudHhkTjdrKzhXUU5F?=
 =?utf-8?Q?a5nM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1832bada-f4ce-49d3-01bb-08dbd3cce647
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 13:35:19.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZMO1WMM17lm77J1xm2bW60TroNalIXrY7h04HOBqh8lVoEU94xygAc6eSiHbYVhrfR8F5AapDmCLfoXTwUAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
Subject: [virtio-dev] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDIzLCAyMDIzIDQ6MDkgUE0NCg0KPiA+IEkgdGhpbmsgdGhpcyBjYW4gYmUg
ZG9uZSB3aXRob3V0IGludHJvZHVjaW5nIHRoZSBuZXcgcmVnaXN0ZXIuDQo+ID4gQ2FuIHlvdSBw
bGVhc2UgY2hlY2sgaWYgdGhlIFBNIHJlZ2lzdGVyIGl0c2VsZiBjYW4gc2VydmUgdGhlIHB1cnBv
c2UgaW5zdGVhZA0KPiBvZiBuZXcgdmlydGlvIGxldmVsIHJlZ2lzdGVyPw0KPiBEbyB5b3UgbWVh
biB0aGUgc3lzdGVtIFBNIHJlZ2lzdGVyPyANCk5vLCB0aGUgZGV2aWNlJ3MgUE0gcmVnaXN0ZXIg
YXQgdHJhbnNwb3J0IGxldmVsLg0KDQo+IEkgdGhpbmsgaXQgaXMgdW5yZWFzb25hYmxlIHRvIGxl
dCB2aXJ0aW8tDQo+IGRldmljZSBsaXN0ZW4gdGhlIFBNIHN0YXRlIG9mIEd1ZXN0IHN5c3RlbS4g
DQpHdWVzdCBkcml2ZXIgcGVyZm9ybXMgYW55IHdvcmsgb24gdGhlIGd1ZXN0IHN5c3RlbXMgUE0g
Y2FsbGJhY2sgZXZlbnRzIGluIHRoZSB2aXJ0aW8gZHJpdmVyLg0KDQo+IEl0J3MgbW9yZSBzdWl0
YWJsZSB0aGF0IGVhY2ggZGV2aWNlDQo+IGdldHMgbm90aWZpY2F0aW9ucyBmcm9tIGRyaXZlciwg
YW5kIHRoZW4gZG8gcHJlc2VydmluZyByZXNvdXJjZXMgb3BlcmF0aW9uLg0KSSBhZ3JlZSB0aGF0
IGVhY2ggZGV2aWNlIGdldHMgdGhlIG5vdGlmaWNhdGlvbiBmcm9tIGRyaXZlci4NClRoZSBxdWVz
dGlvbiBpcywgc2hvdWxkIGl0IGJlIHZpcnRpbyBkcml2ZXIsIG9yIGV4aXN0aW5nIHBjaSBkcml2
ZXIgd2hpY2ggdHJhbnNpdGlvbnMgdGhlIHN0YXRlIGZyb20gZDAtPmQzIGFuZCBkMy0+ZDAgaXMg
ZW5vdWdoLg0KQ2FuIHlvdSBwbGVhc2UgY2hlY2sgdGhhdD8NCg0KPiA+PiAtLS0gYS90cmFuc3Bv
cnQtcGNpLnRleA0KPiA+PiArKysgYi90cmFuc3BvcnQtcGNpLnRleA0KPiA+PiBAQCAtMzI1LDYg
KzMyNSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZQ0K
PiA+PiBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+ID4+ICAgICAgICAgIC8q
IEFib3V0IHRoZSBhZG1pbmlzdHJhdGlvbiB2aXJ0cXVldWUuICovDQo+ID4+ICAgICAgICAgIGxl
MTYgYWRtaW5fcXVldWVfaW5kZXg7ICAgICAgICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8N
Cj4gPj4gICAgICAgICAgbGUxNiBhZG1pbl9xdWV1ZV9udW07ICAgICAgICAgLyogcmVhZC1vbmx5
IGZvciBkcml2ZXIgKi8NCj4gPj4gKyAgICAgICAgbGUxNiBwcmVzZXJ2ZV9yZXNvdXJjZXM7ICAg
ICAgICAvKiByZWFkLXdyaXRlICovDQo+ID4gUHJlc2VydmluZyB0aGVzZSByZXNvdXJjZXMgaW4g
dGhlIGRldmljZSBpbXBsZW1lbnRhdGlvbiB0YWtlcyBmaW5pdGUgYW1vdW50DQo+IG9mIHRpbWUu
DQo+ID4gUG9zc2libHkgbW9yZSB0aGFuIDQwbnNlYyAodGltZSBvZiBQQ0llIHdyaXRlIFRMUCku
DQo+ID4gSGVuY2UgdGhpcyByZWdpc3RlciBtdXN0IGJlIGEgcG9sbGluZyByZWdpc3RlciB0byBp
bmRpY2F0ZSB0aGF0DQo+IHByZXNlcnZhdGlvbl9kb25lLg0KPiA+IFRoaXMgd2lsbCB0ZWxsIHRo
ZSBndWVzdCB3aGVuIHRoZSBwcmVzZXJ2YXRpb24gaXMgZG9uZSwgYW5kIHdoZW4gcmVzdG9yYXRp
b24gaXMNCj4gZG9uZSwgc28gdGhhdCBpdCBjYW4gcmVzdW1lIHVwcGVyIGxheWVycy4NCj4gPg0K
PiA+IFBsZWFzZSByZWZlciB0byBxdWV1ZV9yZXNldCBkZWZpbml0aW9uIHRvIGxlYXJuIG1vcmUg
YWJvdXQgc3VjaCByZWdpc3Rlcg0KPiBkZWZpbml0aW9uLg0KPiBUaGFua3MsIEkgd2lsbCByZWZl
ciB0byAicXVldWVfcmVzZXQiLiBTbywgSSBuZWVkIHRocmVlIHZhbHVlcywgZHJpdmVyIHdyaXRl
IDEgdG8NCj4gbGV0IGRldmljZSBkbyBwcmVzZXJ2aW5nIHJlc291cmNlcywgZHJpdmVyIHdyaXRl
IDIgdG8gbGV0IGRldmljZSBkbyByZXN0b3JpbmcNCj4gcmVzb3VyY2VzLCBkZXZpY2Ugd3JpdGUg
MCB0byB0ZWxsIGRyaXZlciB0aGF0IHByZXNlcnZpbmcgb3IgcmVzdG9yaW5nIGRvbmUsIGFtIEkN
Cj4gcmlnaHQ/DQo+IA0KUmlnaHQuDQoNCkFuZCBpZiB0aGUgZXhpc3RpbmcgcGNpZSBwbSBzdGF0
ZSBiaXRzIGNhbiBkbywgd2UgY2FuIGxldmVyYWdlIHRoYXQuDQpJZiBpdCBjYW5ub3QgYmUgdXNl
ZCwgbGV0cyBhZGQgdGhhdCByZWFzb25pbmcgaW4gdGhlIGNvbW1pdCBsb2cgdG8gZGVzY3JpYmUg
dGhpcyByZWdpc3Rlci4NCg0KPiA+DQo+ID4gTGV0cyBwbGVhc2UgbWFrZSBzdXJlIHRoYXQgUENJ
ZSBQTSBsZXZlbCByZWdpc3RlcnMgYXJlIHN1ZmZpY2llbnQvbm90LXN1ZmZpY2llbnQNCj4gdG8g
ZGVjaWRlIHRoZSBhZGRpdGlvbiBvZiB0aGlzIHJlZ2lzdGVyLg0KPiBCdXQgaWYgdGhlIGRldmlj
ZSBpcyBub3QgYSBQQ0llIGRldmljZSwgaXQgZG9lc24ndCBoYXZlIFBNIGNhcGFiaWxpdHksIHRo
ZW4gdGhpcw0KPiB3aWxsIG5vdCB3b3JrLiBBY3R1YWxseSBpbiBteSBsb2NhbCBlbnZpcm9ubWVu
dCwgcGNpX2lzX2V4cHJlc3MoKSByZXR1cm4gZmFsc2UgaW4NCj4gUWVtdSwgdGhleSBhcmUgbm90
IFBDSWUgZGV2aWNlLg0KSXQgaXMgcmVhc29uYWJsZSB0byBhc2sgdG8gcGx1ZyBpbiBhcyBQQ0ll
IGRldmljZSBpbiAyMDIzIHRvIGdldCBuZXcgZnVuY3Rpb25hbGl0eSB0aGF0IHRvbyB5b3UgbWVu
dGlvbmVkIGEgZ3B1IGRldmljZS4g8J+Yig0KV2hpY2ggZG9lcyBub3QgaGF2ZSB2ZXJ5IGxvbmcg
aGlzdG9yeSBvZiBhbnkgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NClBsZWFzZSBleHBsb3JlIHRo
ZSBkMDwtPmQzIFBNIHN0YXRlIGJpdCBpZiBjYW4gYmUgdXNlZC4NCg0KVGhhbmtzIGEgbG90Lg0K

