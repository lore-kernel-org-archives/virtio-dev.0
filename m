Return-Path: <virtio-dev-return-13686-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87BCCA0EC9
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:50:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AAC9D79528
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:50:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95A559865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:50:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 84C2F983E27; Tue, 12 Sep 2023 05:50:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 698CF986485;
	Tue, 12 Sep 2023 05:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP8zfe/XrIUC35i0RIY21kmFwLHqGnLJURYseRB+/s6FYZlbSqb3OD5sQ2eZx5+UyPxl803Krfe+XIm3FEBQNxN/xP5Brg6fn4PzXTeYmq6RTGPUCGqVogenhBifJMaA948V22zpMidDQWkk+qAdz9cjkqX2VKtOcuVHlb4JiImzPF6+RouRecsVtCD+dEAieYIRWufWofTfOz/lRiBEaxtY1ayczr+0s0Yms4JU61gFdGbqyudEUm38OJFHYoX0OeKIiAVG1QT3NDAwM51oIbHkcinPV57WxS6m+BoO+R7U1GmLGdngHqDWSNi8o+nTNB1mBcAx7yBXiKrtpLU6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TiD0pVCCyiYgvPC+IxCZEVEJEILjoWoAeiK7KeZXDk=;
 b=l7wZjAbCB/HLGTn2CV1ozwtJ2RHF1DFUCEzlls9qoYkznlWp7YSpwRSWNIGdo2JifVcappVz5AHumByXsjPoKuflxOraPeJuF4rgJNM4dCjzqrqrMR5qL1wFbpQR+PCRvIjqw6NTABiMM1K071y7Tf08BSgPOjl521W74EsCfMY34Xf1bwxsFWG6FwxOgHAUeMk9aQuyvg/FLLJGhcHCfe3sb+CP5X9iiV0VwA19568REfv+cmSR/TtKsvoMPVxOF2AAaPPXmLMhNPEBIbXmg5iNN30QrXhnBee5jXfOEgCuvyOTs5KnX6fZ3Hw/ec4mw2nyjfBzL5pTQUTLZWFgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQuGgIAAIkIQ
Date: Tue, 12 Sep 2023 05:50:05 +0000
Message-ID:
 <PH0PR12MB5481B44B636DA997885AABBEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtAe3j+A=gNEOJiZF8rcJnT-zw7Xg67LLM92FZCm0XqyQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtAe3j+A=gNEOJiZF8rcJnT-zw7Xg67LLM92FZCm0XqyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7370:EE_
x-ms-office365-filtering-correlation-id: ba275988-73b8-4589-b5e6-08dbb3541d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lG5xAYWjGmarNt4BtJB1RhkRGOcyFv8B/9DYQdNTKYTT00sLvUgYQBi4Xt59FFhwhWHHsN6hf27yHqOZmEAjQJQjlxmly1Hq4EvFCv6O+O3NjR4+BmfqEIk2LKou9WifFWdAJkEUROlSy0kkg9AplKDmH4afWIovW2i9aQhohuZDbLwWaTgyqEmmzM2rmXzORUWgESKI7nUYQ6nH0jnK2mA6NGKTmEjZyVIICzQvJpKlAUJnoghGEsmypow7cjl+YsK474PYRcwPlSp6h4/VYHpPZYAvEdns77Bd0eyV9MSAa/ei1VowK9n7Cz4GK+Vt/GXVOPh6dHcR4iAnprgNjVAMsAZkIkIMBjEj5MDM8mO14MriMj9mQxs9/+glAzYZONZ/wEum5mb38fyzOPvad//DwRTY0dE3x7HJL1ZKQSAZLJTZSfH6Rwdmvf/HTF4pl86OJjcryYmbT12k+BzhBiKo0+tVzvyXKrsmiZog/it5NdAmWaAg4Kd5r4oRiiv6Zzp567ZVsieiA33e8pZudTOGjZhq/DDnHCCKcR9V3zJQTy0KKCF8NYBPocEvaMXy+ymcMcGo3UJOwxYquc/Vy5xEHMNQq0NSUiUAc8j984y1bxcRMGYi/0iX/sItXdb3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(55016003)(52536014)(8676002)(54906003)(4326008)(6916009)(66446008)(66556008)(66946007)(8936002)(41300700001)(2906002)(316002)(5660300002)(76116006)(64756008)(66476007)(53546011)(7696005)(9686003)(71200400001)(38100700002)(6506007)(38070700005)(122000001)(26005)(83380400001)(86362001)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3ZudkQxanVtdy9DZ25JN3IyR0xjZURWNXprS3dQRk91UzF3VzJIaGlLemtD?=
 =?utf-8?B?bmFYSFpLcGV0U3hPUzN5UTJPbmdaK1JIUC82WENtOHVHYmpJb3U1a3E4UEpZ?=
 =?utf-8?B?c0JUMG5MeDB6ajJ1VVZRQWVLYXpuMVUyOVNtQ0JTdXNLckR3V2pNdzlTall6?=
 =?utf-8?B?NEMweTBKdlVOQnRXMTBUSnRFYUg3NHB1dVRaQ3Q3Z0pWNlA0bU5teUxyMTBW?=
 =?utf-8?B?L2ZoZlptb0M3eUNBcTZjMDFXSW5za24wVFkrbjlHOEs2cWVMcTdNSEFhUit5?=
 =?utf-8?B?ZUV5TVV5VGtNbVF1V3A0UEFhVGl2UGpUTVVZb2Vhd1B1dDEyVXpNajVVMG5m?=
 =?utf-8?B?Y3grRG5UbVlFelQ0eHFpeTJqRWhWRFFVcWo0N0YxNDhUTEo3UmxCazJ6Mzl2?=
 =?utf-8?B?YmlCVUtoQnErbEY5M0xPb2Vud1NoczMxbG5TT0hNV1BxMVZEZHA2R1Bzaktk?=
 =?utf-8?B?V1U2OUhFSEV6SERxdEJ2Zk85eHd1R0puUk5FODdsM240dE44cmdCbTV5Wllx?=
 =?utf-8?B?aVNHdFVOamtkUkNpdmVVR0pJS0UyTVhxVlEyTU0rRVl6ZllaZ0NmanpQWlZQ?=
 =?utf-8?B?RkhlaFFVTURoOURXUkhzT0xnSVN6bXRGSmtiQlB0aFoxOFgrMDIyKzFIZjNr?=
 =?utf-8?B?MERVQXVUOVdJc1JjeTVNUVYvVGo4c0tVOXhTbVFQa3lTM0FQWlg0QzZnL1hZ?=
 =?utf-8?B?MVhRTVVUTTFVeUNjdkYyZ2Y3S3orVk9nRC96eWZnVFYvZkxLRVVFQkxuVjht?=
 =?utf-8?B?czVVdnViS3E4NVU5VkV4clgwUnI3bUxUaDJQYmF0a1Z1czZ6K1VibEFmK1E5?=
 =?utf-8?B?VkNxS09RQW5EbXI2M21YcVEyNjhWTFBmMUZuNENPa1JsWTBOSXRKZSt1bHZk?=
 =?utf-8?B?UUhSU1lZWkhwMzlKTGhabTVJRWhiVWFjdzZTVEEvbjIvc1lTUjlDSFZiZUZP?=
 =?utf-8?B?UU1SaTJJVU9sTHVaWGVQZUxUM2phRTF0Um1iUld1cXIvUHlUb1IweEV6QnNj?=
 =?utf-8?B?TWM2bVdzSE1VdHc1SElZVEtYWkVvTS84cEdvMk1sY3RQMFR1a1h5QThKMHRv?=
 =?utf-8?B?OVdDUEVoR3AxUU91RU1MVGdlc0d1NFJVeHE2TnczVnlqZHNxRVNFbGNnMWly?=
 =?utf-8?B?bVFpVFRVczk4SVlGbU9LRE51Q3Y5NE53RW15QlhrQVJlakN5TzVkL1ZZNy9V?=
 =?utf-8?B?OEg4WnVVL3FIcmZSQWlmYVFzbU1BTzRSYmk5TmJGeFpJSm1GZGt4Mkg2Z01a?=
 =?utf-8?B?eUs5b1Q3cXpacmo5emZpREF6cGtSWkQ5dmRvdklqajlSMlYvUmNFTmwyVFRw?=
 =?utf-8?B?YThrZFBzNmhRMFN6RnREcGpscG5ld3MwbUNEVDdUK01zcTRiSHlnTEpNbVVN?=
 =?utf-8?B?bmtXdlQrckZwOHAxU1BjOENXVjZHd3lxMGMzazI5UUlqQWh2YmRJZTZUTXlz?=
 =?utf-8?B?NzZlbkxKeXBZcWJ1QjRFS1EyUUZ2QjBGbGZGeEJVQlU2K0xxQXlRUEhrakNt?=
 =?utf-8?B?SUR3RElIaHNFcnVPM0tIMWtoK0tnZHdhcmhGeGZmenlSUmFtalA0NVVRQUVw?=
 =?utf-8?B?WnZRSDlFMUw4akVSc0Yyb0FUOTVxZnBJQUZIZEFxNHpwRk5qU0huc1dsS3d1?=
 =?utf-8?B?V3FwMFIxZ1RzbFNxMjU4WWRhSFlnUzNFeGhYMUZVVWRXOHBJZXJndEJGTzNZ?=
 =?utf-8?B?Njk0Q1V3MEpBdGNZWExNcFdaMkNRQWlhaXZxeGhkOGI4b00xYXZTK2NJZGx4?=
 =?utf-8?B?WTVQYlJsZXFNN1FGZXBLUm9LU0kzSTQ3R1pYYUc2RU9sa0R4ODErUmdmY3FR?=
 =?utf-8?B?RUlYMTVsaFJLMGh5bFlqQTkrcEhJNHJDbmh2R0hoUzNLelNqZVRTQVBLVHF6?=
 =?utf-8?B?TlZ2MXBZZk9vWG9LZFdpc3ZNcnAxcHozME1HMUVzOXhQcUhYWHJrUy9ib0Vk?=
 =?utf-8?B?QVlndkkyM0l4RmNXUkJaaUJPeUpKR2hIYjVZVnIzS2xwTVc5dGhIRTdxRGxY?=
 =?utf-8?B?TytiejJkL0I0bDg4Mlk5bW5rR1oybGhmMFl0VjduSm5UREdxV1pTQWNjV0lC?=
 =?utf-8?B?eFN5K3Q0UXRKSlZHc1FHay9RRUVUL2FxbVRXU0tYSkk2Qml6cEQ2bHNOOE9E?=
 =?utf-8?Q?fERU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba275988-73b8-4589-b5e6-08dbb3541d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 05:50:05.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzQMzR9xX8CW6I/FhU5Iaq9AiKR1XUnBBYc7cdbmV2ab+bgvarayTKVsYSrg1xU34351JLzxnnmw9PbTNUo+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAxMiwgMjAyMyA5OjE0IEFNDQo+IA0KPiBPbiBNb24sIFNlcCAxMSwgMjAy
MyBhdCA3OjUw4oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4g
Pg0KPiA+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4g
PiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDExLCAyMDIzIDM6MDMgUE0NCj4gPg0KPiA+ID4g
QnkgdGhlIHdheSwgZG8geW91IHNlZSBhbnl0aGluZyB3ZSBuZWVkIHRvIGltcHJvdmUgaW4gdGhp
cyBzZXJpZXM/DQo+ID4NCj4gPiBBZG1pbiBjb21tYW5kcyBmb3IgcGFzc3Rocm91Z2ggZGV2aWNl
cyBvZiBbMV0gaXMgY29tcHJlaGVuc2l2ZSBwcm9wb3NhbA0KPiBjb3ZlcmluZyBhbGwgdGhlIGFz
cGVjdHMuDQo+IA0KPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJhbGwgdGhlIGFzcGVjdHMiPw0KVGhl
eSBhcmUgY292ZXJlZCBpbiB0aGUgcHJvcG9zYWwgY292ZXIgbGV0dGVyLg0KMS4gc3RhdGUgbWln
cmF0aW9uLCBwMnAsIGRpcnR5IHBhZ2UgdHJhY2tpbmcsIGxvd2VyIGRvd250aW1lLCBmbHIsIGRl
dmljZSByZXNldCwgbm8gZXh0cmEgbWVkaWF0aW9uIHJlcXVpcmVtZW50Lg0KDQo+IA0KPiBPZiBj
b3Vyc2UgaXQgY2FuJ3QgaGFuZGxlIG5lc3Rpbmcgd2VsbCwgcGFzc3Rocm91Z2ggZG9lc24ndCB3
b3JrIHdoZW4geW91cg0KPiBoYXJkd2FyZSBoYXMgTiBsZXZlbHMgYWJzdHJhY3Rpb25zIGJ1dCBu
ZXN0aW5nIGlzIE0gbGV2ZWxzLiBUcmFwIGFuZCBlbXVsYXRpb24NCj4gaXMgYSBtdXN0Lg0KT25l
IGNhbiBkZWxpY2F0ZSB0aGUgd29yayB0byBvdGhlciBWRiBmb3IgcHVycG9zZSBvZiBuZXN0aW5n
Lg0KDQpPbmUgY2FuIGJ1aWxkIGluZmluaXRlIGxldmVsIG9mIG5lc3RpbmcgdG8gbm90IGRvIHBh
c3N0aHJvdWdoLCBhdCB0aGUgZW5kIHVzZXIgYXBwbGljYXRpb25zIHJlbWFpbnMgc2xvdy4NClNv
IGZvciBzdWNoIE4gYW5kIE0gYmVpbmcgPiAxLCBvbmUgY2FuIHVzZSBzb2Z0d2FyZSBiYXNlIGVt
dWxhdGlvbiBhbnl3YXkuDQoNCj4gDQo+IEFuZCBleHBvc2luZyB0aGUgd2hvbGUgZGV2aWNlIHRv
IHRoZSBndWVzdCBkcml2ZXJzIHdpbGwgaGF2ZSBzZWN1cml0eQ0KPiBpbXBsaWNhdGlvbnMsIHlv
dXIgcHJvcG9zYWwgaGFzIGRlbW9uc3RyYXRlZCB0aGF0IHlvdSBuZWVkIGEgd29ya2Fyb3VuZCBm
b3INClRoZXJlIGlzIG5vIHNlY3VyaXR5IGltcGxpY2F0aW9ucyBpbiBwYXNzdGhyb3VnaC4NCg0K
PiBGTFIgYXQgbGVhc3QuDQpJdCBpcyBhY3R1YWxseSB0aGUgb3Bwb3NpdGUuDQpGTFIgaXMgc3Vw
cG9ydGVkIHdpdGggdGhlIHByb3Bvc2FsIHdpdGhvdXQgYW55IHdvcmthcm91bmRzIGFuZCBtZWRp
YXRpb24uDQoNCj4gDQo+IEZvciBub24gc3RhbmRhcmQgZGV2aWNlIHdlIGRvbid0IGhhdmUgY2hv
aWNlcyBvdGhlciB0aGFuIHBhc3N0aHJvdWdoLCBidXQgZm9yDQo+IHN0YW5kYXJkIGRldmljZXMg
d2UgaGF2ZSBvdGhlciBjaG9pY2VzLg0KDQpQYXNzdGhyb3VnaCBpcyBiYXNpYyByZXF1aXJlbWVu
dCB0aGF0IHdlIHdpbGwgYmUgZnVsZmlsbGluZy4NCklmIG9uZSB3YW50cyB0byBkbyBzcGVjaWFs
IG5lc3RpbmcsIG1heSBiZSwgdGhlcmUuDQpJZiBib3RoIGNvbW1hbmRzIGNhbiBjb252ZXJnZSBp
dHMgZ29vZCwgaWYgbm90LCB0aGV5IGFyZSBvcnRob2dvbmFsIHJlcXVpcmVtZW50cy4NCg0K

