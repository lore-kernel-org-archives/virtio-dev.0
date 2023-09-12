Return-Path: <virtio-dev-return-13694-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C40CA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:47:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2AFD8602EF
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:47:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21854986630
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:47:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 15B12983E27; Tue, 12 Sep 2023 06:47:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02F6D986485;
	Tue, 12 Sep 2023 06:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfuPiQJxVFtUOza8w6wB7/Ad38A3Sb52GRgkOpmMW5gt+N9OPjFabXk9NVAvf/nxRwoIW/5r2CsOZ9kbGJEgnT1RNcZm4GJI4lR/Vod13f6H4qUD8Xn+BWKKGGB5A/FZfVVStnRuLEq5CVe+4/MkEdvUNURo4HqEDHRpU2EM+FF8mNr7S+SYChBgDXWivNs8FoiwJlm/1CZ++lsvigUq+r6NLzciS7dN7pjvcDRFnJEl3eczx+pTCPWPiF9/N8U8f8H2pRbyCIXL2V4FxOxGZbFCaujqrjUEEXkicCNpgX5pUIfpowZ3KyPMPVVa+AUZMYlT5beaaFWmT0Cz1Z+HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2cx6MBVKbJxJpT69AHpNGe81COCswxO0KHKludkKuI=;
 b=HyZFbpLVbNl7v3OJP2UdJPXAP9DvtK7G8e/V/OoBL4jJZF/v0CihD1JwKg0Hj/J0Wy5Hn/t5Y+jnBYYxl1EJVEWhSb4OxQIYcfVnLj8eFDN/0TB+FIW3KkqVlErBA2/th89i7264gioWNxPzVm5D53jtYctgl5S9i2+WMu1WPizyDQzFhRrQIJXdP8EI2w+mF/NORPhaCyNAkdB2v8hPTtbdMQne6KwjL5KDuOesNG5zflTY+mCGVxg1X8CE49U/GHbkP+qvUFTXaKluNuMVYOa1wNXePvqcgtHUBjlE8Tj3Q7nvIEMD3osWbif0BZ5243GWFTcL0W7CeGI+Qkndbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAI3wCAAS5OAIAAHWKQgAALxgCAAABUEA==
Date: Tue, 12 Sep 2023 06:47:41 +0000
Message-ID:
 <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
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
 <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
In-Reply-To: <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4434:EE_
x-ms-office365-filtering-correlation-id: eb374e7a-5271-4cf3-8e87-08dbb35c2965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 STETkbIpxIO3KwKUR7w7S5IAxk31pyfmLRNnFpjrfgeUuI61lZws3xg53GD3sAvOG4mm8MJ73QKZO/jSDQlaKeNhumZpDcdU7aQlXfQLx7VzCKWBKxNmtiUGt1xTbqY49eXItqlGGr8/255yxGhwoUDWoDmTApSUnkIlahSYVmoAsMcyUzkxChU2Tja4qyO5VZpHvqq8MlaLnlA1KF4jQNnUY2oCf5sQbEP8C2YiOSqDOUWOmNy5Z4bns6I99OtQ2kGUVPtujdScgG9oZpcwyJssMUt8k6EbVa1nFh75YOiiTJg2LRUv++xFQXWPdgNigBC7d8MK+UVses5iDSEtnT3lBkoQXuIppnqNkmka4+O/qMQJZe8CP9D8QlCuLwmyKthpkCXtXC3F2lUezj3yijADVnoAHwBICiJB9F8yNLSP3dc/BNyn20z0woixL+68vVMgjNGZsQHojwAxWpx/ZdM4vETH67bPyAvu04IsJ0OzYgXLAUmnKXxHBfy2t0tQmjsKz2xIE5kZ0cG32BSLK5/L72aA3Rnc5zmEqGHnPqleCC8s7xC0dXrsVQjsnIaVhIXYNWat8fuks0pzvfp0puRv/E0W5K/OnHH+8Sylk5aaNGfxEH5lqhWTQPm3QXpo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(186009)(1800799009)(451199024)(26005)(38070700005)(38100700002)(122000001)(478600001)(9686003)(6506007)(71200400001)(7696005)(53546011)(41300700001)(110136005)(316002)(66556008)(66946007)(66446008)(64756008)(54906003)(76116006)(66476007)(83380400001)(33656002)(52536014)(5660300002)(4326008)(8936002)(8676002)(2906002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGRVRXcwTHVJRElLeUJwL3V4d1hqM2E0TWdGMlNPM0FaYmJWaFhic3FYSUVS?=
 =?utf-8?B?dTFSVkpsMVFTKzZSNXA3QU9EU2NVRWp5UVRua2dFR3QxS1llRmt5NFVMZVJV?=
 =?utf-8?B?SnczaFR1S3BFYTJ2ZlVjVjFGSW0xT2l4YVNkVjJZaFA0eThrWUlyaHFmb0dZ?=
 =?utf-8?B?R0xrYjFtVjZVMEwwbWtNYUZSYmlGUHhjQmV3dW9mMnorQW5iNXBEdktVcGxo?=
 =?utf-8?B?cmlDS2FiNzgzRWw0b2lBZjVHUWhRMzVGWlhQN3JnVitkTlhUNCtxSXlNYlVy?=
 =?utf-8?B?UG13d21JSjg1aitTOUI2dXBTMWJZVTQ3enZMK0RScGhyZzVVTHJ3NjRIamZ6?=
 =?utf-8?B?bUdya2xRUVdkaUtLQzNjK1Z6Y0ZLaFdoTzJoRlM4Q3dya3FWRlZhT0poQjJT?=
 =?utf-8?B?S0pJMXpwcURyMjNlNjdibjA3eFVkdWFDQmxVWnhnemFoWitwaU5aU0RPVXcy?=
 =?utf-8?B?eGxKVHc2dWxPcFc4SWMwMVA0VGRFdndxbWo3YVJQeEdCRDlYR3FhcnN6YXNF?=
 =?utf-8?B?VEQzbm12NDlnaXpoQktvUFV0NkI3L1YzaDUwNVN5SjBkQVdJcWI2aHZsVDY2?=
 =?utf-8?B?Qk05QjRTckgwMEZLSUhxWGtlM2d6WlVQYUZBL2ZLclBhdjlzSnl2YVVsd0E3?=
 =?utf-8?B?aXU2bjBsRVlpTU5HNENjZERQM3NoOUVYSGNYVHNnL2ZHWGpDYzZLdnBUWWNP?=
 =?utf-8?B?eGxncWM2cjlUTjFndC9wL0l0M2J2enovMTlYUGVRelZOSi9vVWhiRklMclJa?=
 =?utf-8?B?TmNkamZyRXRkTlZqU0kycnlzQkloZTN4d3NUZlRLb3BSYjJuL3plNHIwdnBl?=
 =?utf-8?B?OVNBcUdOUWQyald5MFlkc0VPWWhhU21oZ0FkWWs3djlYTGI2RVlFMjlXY2V1?=
 =?utf-8?B?MjlFM3V5Nk5UQnJRSzZHTGxPRnNWcGtXajJGeFNROWphS0Z2YTk3YnBkd09V?=
 =?utf-8?B?dmlNeExXd2h4U0VvQTZveXExVWVEZW5jRU56ZVNYQitQYUExQmJKcDRIVlNV?=
 =?utf-8?B?ekg3dFVZMFFVcUhyYU5jbnM0ZXB1a3FWVFZqRUJxcmptdHpnWW1UUllheXJ1?=
 =?utf-8?B?U1I0YTdwSVh3dy9ENm5mTkFWNTJlbFAvNDB5anY1TFZnTHltTElCckxhdkxP?=
 =?utf-8?B?WFV1S1o3Y2xEZ2hzaFBUZ1QrOFBCbmIvTHVoMGtjUE96eERQZ2d3OFpyMFlQ?=
 =?utf-8?B?YVdYRXVzOVl5ZjJLRTFsR0RRdkNwWWpsUXpMMjlWeTgzbzhPaXhuM29iTGZl?=
 =?utf-8?B?ZXlBcWsySENkRGtqK3R1MkovV0JWbWlLVzlsdWRNaURnempFOG5iUWNVckd5?=
 =?utf-8?B?ZnhENDVONVNMWDMwbDdIaVJ6LzVWRS85NmVzZytZSGZqQzJsMldFamRRTnhT?=
 =?utf-8?B?WE9YY2RYbHlKOGJBNjA2TW0xbUxITXhlZ1c5aXVBWFBaWFVOY3FCeDJ6YUpZ?=
 =?utf-8?B?SzJENnlTS0NIMVlBbUxTbHJNMllGcFM3dVdJc3VDbkZ2Z3JGY3Q5bnJmUkll?=
 =?utf-8?B?YVg2TFB5eWh4TnVmVzNVdk16Y2ZuV1Y4L0FHVFhPcWFSTGxXckpNVUdwazZw?=
 =?utf-8?B?SnluQS9Qb3U5Q2pCdko3TkUwNnpKRldpSm1SUGhaY21vaUpNZU1NZFdYalNy?=
 =?utf-8?B?dGJRcnJkZVI3b3Y2WEdzYnhnU1dOcVpTNU5tblhzNEl1NWp5YStlNE95amRs?=
 =?utf-8?B?aFBQN292aHhscjBwNlRWeERxTkkvWUpMTWdCaVkwaTFXanJNaVMwZTYwVERh?=
 =?utf-8?B?anNDQWxYVzRyZ2k2bVZFWWJMZ0hmTUZSQWpIc3dZWXpScHR0ZjR5QUlzMmVw?=
 =?utf-8?B?WXFudE53N1FSbVV1MTFjblBBb0JnRWpHMVFTQzA1K1V5ek9ibm4zb0tzenZu?=
 =?utf-8?B?RlpudWFUdUNDbjMyZ29YTk5lQUVvNDhsdVhCV2Q2TTJJZElqSmdnOFhSeVBv?=
 =?utf-8?B?NFhsNFFzT2dXMWxVdzBicFJna2VXcnV1K2xObC9MeVQ2UlhRYkFvOGdpRGox?=
 =?utf-8?B?SVFTZ0puRyt0SjllS0xrTDRjd0Nab2xjbDlaVVVzeXNQakFyQ3JlYnhnSjRX?=
 =?utf-8?B?VU1FRWt1UnpzNEt6eWh4R3VlaHdZRGswWU5LS21Ua0NBQnZaWG5NT25sTTdl?=
 =?utf-8?Q?NW7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb374e7a-5271-4cf3-8e87-08dbb35c2965
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:47:41.5557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIA3LyRXByD2KuBrRHqwzMIkPNL8T7xh6MksZaXnpOe6h9oVpLoN76B4JMjEXCaK4xs9w9YcKAyHFm0tSNnGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAxMjowNCBQTQ0KPiANCj4gDQo+IE9uIDkvMTIv
MjAyMyAxOjU4IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFpodSwgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJl
ciAxMiwgMjAyMyA5OjM3IEFNDQo+ID4+DQo+ID4+IE9uIDkvMTEvMjAyMyA2OjIxIFBNLCBQYXJh
diBQYW5kaXQgd3JvdGU6DQo+ID4+Pj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1
QGludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyAzOjAz
IFBNIFNvIGltcGxlbWVudCBBUSBvbiB0aGUNCj4gPj4+PiAiYWRtaW4iIFZGPyBUaGlzIHJlcXVp
cmUgdGhlIEhXIHJlc2VydmUgZGVkaWNhdGVkIHJlc291cmNlIGZvcg0KPiA+Pj4+IGV2ZXJ5IFZG
Pw0KPiA+Pj4+IFNvIGV4cGVuc2l2ZSwgT3ZlcmtpbGw/DQo+ID4+Pj4NCj4gPj4+PiBBbmQgYSBW
RiBtYXkgYmUgbWFuYWdlZCBieSB0aGUgUEYgYW5kIGl0cyBhZG1pbiAidmYiPw0KPiA+Pj4gWWVz
Lg0KPiA+PiBpdCdzIGEgYml0IGNoYW9zLCBhcyB5b3UgY2FuIHNlZSBpZiB0aGUgbmVzdGVkKEwy
IGd1ZXN0KSBWRiBjYW4gYmUNCj4gPj4gbWFuYWdlZCBieSBib3RoIEwxIGd1ZXN0IFZGIGFuZCB0
aGUgaG9zdCBQRiwgdGhhdCBtZWFucyB0d28gb3duZXJzIG9mIHRoZQ0KPiBMMiBWRi4NCj4gPiBU
aGlzIGlzIHRoZSBuZXN0aW5nLg0KPiA+IFdoZW4geW91IGRvIE0gbGV2ZWwgbmVzdGluZywgZG9l
cyBhbnkgY3B1IGluIHdvcmxkIGhhbmRsZSBpdHMgb3duIHBhZ2UNCj4gdGFibGVzIGluIGlzb2xh
dGlvbiBvZiBuZXh0IGxldmVsIGFuZCBhbHNvIHBlcmZvcm0gZXF1YWxseSB3ZWxsPw0KPiBOb3Qg
ZXhhY3RseSwgaW4gbmVzdGluZywgTDEgZ3Vlc3QgaXMgdGhlIGhvc3QvaW5mcmFzdHJ1Y3R1cmUg
ZW11bGF0b3IgZm9yIEwyLCBzbyBMMg0KPiBpcyBleHBlY3QgdG8gZG8gbm90aGluZyB3aXRoIHRo
ZSBob3N0LCBvciBzb21ldGhpbmcgbGlrZSBMMiBWRiBtYW5hZ2VkIGJ5IGJvdGgNCj4gTDEgVkYg
YW5kIGhvc3QgUEYgY2FuIGxlYWQgdG8gb3BlcmF0aW9uYWwgYW5kIHNlY3VyaXR5IGlzc3Vlcz8N
Cj4gPg0KPiA+Pj4+PiBJZiBVRFAgcGFja2V0cyBhcmUgZHJvcHBlZCwgZXZlbiBhcHBsaWNhdGlv
biBjYW4gZmFpbCB3aG8gZG8gbm8gcmV0cnkuDQo+ID4+Pj4gVURQIGlzIG5vdCByZWxpYWJsZSwg
YW5kIHBlcmZvcm1hbmNlIG92ZXJoZWFkIGRvZXMgbm90IG1lYW4gZmFpbC4NCj4gPj4+IEl0IGxh
cmdlbHkgZGVwZW5kcyBvbiBhcHBsaWNhdGlvbi4NCj4gPj4+IEkgaGF2ZSBzZWVuIGlwZXJmIFVE
UCBmYWlsaW5nIG9uIHBhY2tldCBkcm9wIGFuZCBuZXZlciByZWNvdmVyZWQuDQo+ID4+PiBBIHJl
dHJhbnNtaXNzaW9uIG92ZXIgVURQIGNhbiBmYWlsLg0KPiA+PiBUaGF0IGRlcGVuZHMgb24gdGhl
IHdvcmtsb2FkLCBpZiBpdCBjaG9vc2UgVURQLCBpdCBpcyBhd2FyZSBvZiB0aGUNCj4gPj4gcG9z
c2liaWxpdGllcyBvZiBsb3NpbmcgcGFja2V0cy4gQnV0IGFueXdheSwgTE0gYXJlIGV4cGVjdGVk
IHRvDQo+ID4+IHBlcmZvcm0gc3VjY2Vzc2Z1bGx5IGluIHRoZSBkdWUgdGltZQ0KPiA+IEFuZCBM
TSBhbHNvIGRlcGVuZHMgb24gdGhlIHdvcmtsb2FkLiA6KQ0KPiBFeGFjdGx5ISBUaGF0J3MgdGhl
IHBvaW50LCBob3cgdG8gbWVldCB0aGUgcmVxdWlyZW1lbnRzIQ0KPiA+IEl0IGlzIHBvaW50bGVz
cyB0byBkaXNjdXNzIHBlcmZvcm1hbmNlIGNoYXJhY3RlcmlzdGljcyBhcyBhIHBvaW50IHRvIHVz
ZSBBUSBvcg0KPiBub3QuDQo+IEhvdyB0byBtZWV0IFFPUyByZXF1aXJlbWVudCB3aGVuIExNPw0K
QnkgZm9sbG93aW5nIFsxXSB3aGVyZSBsYXJnZSBwYXJ0IG9mIGRldmljZSBjb250ZXh0IGFuZCBk
aXJ0eSBwYWdlIHRyYWNraW5nIGlzIGRvbmUgd2hlbiB0aGUgVk0gaXMgcnVubmluZy4NCg0KPiA+
IE5vLiBib2FyZCBkZXNpZ25lciBkb2VzIG5vdCBuZWVkIHRvLg0KPiA+IEFzIGV4cGxhaW5lZCBh
bHJlYWR5LCBpZiBib2FyZCB3YW50cyB0byBzdXBwb3J0aW5nIHNpbmdsZSBjb21tYW5kIG9mIEFR
LA0KPiBzdXJlLg0KPiBTYW1lIGFzIGFib3ZlLCB0aGUgUU9TIHF1ZXN0aW9uLiBGb3IgZXhhbXBs
ZSwgaG93IHRvIGF2b2lkIHRoZSBzaXR1YXRpb24gdGhhdA0KPiBoYWxmIFZNcyBjYW4gYmUgbWln
cmF0ZWQgYW5kIG90aGVycyB0aW1lb3V0Pw0KV2h5IHdvdWxkIHRoaXMgaGFwcGVuPw0KVGltZW91
dCBpcyBub3QgcmVsYXRlZCB0byBBUSBpbiBjYXNlIGlmIHRoYXQgaGFwcGVucy4NClRpbWVvdXQg
Y2FuIGhhcHBlbiB0byBjb25maWcgcmVnaXN0ZXJzIHRvby4gQW5kIGl0IGNhbiBiZSBldmVuIGZh
ciBtb3JlIGhhcmRlciBmb3IgYm9hcmQgZGVzaWduZXJzIHRvIHN1cHBvcnQgUENJIHJlYWRzIGlu
IGEgdGltZW91dCB0byBoYW5kbGUgaW4gMzg0IHJlYWRzIGluIHBhcmFsbGVsLg0KDQpJIGFtIHN0
aWxsIG5vdCBhYmxlIHRvIGZvbGxvdyB5b3VyIHBvaW50IGZvciBhc2tpbmcgYWJvdXQgdW5yZWxh
dGVkIFFPUyBxdWVzdGlvbnMuDQoNCj4gPg0KPiA+Pj4gQWRtaW4gY29tbWFuZCBjYW4gZXZlbiBm
YWlsIHdpdGggRUFHQUlOIGVycm9yIGNvZGUgd2hlbiBkZXZpY2UgaXMNCj4gPj4+IG91dCBvZg0K
PiA+PiByZXNvdXJjZSBhbmQgc29mdHdhcmUgY2FuIHJldHJ5IHRoZSBjb21tYW5kLg0KPiA+PiBB
cyBkZW1vbnN0cmF0ZWQsIHRoaXMgc2VyaWVzIGlzIHJlbGlhYmxlIGFzIHRoZSBjb25maWcgc3Bh
Y2UNCj4gPj4gZnVuY3Rpb25hbGl0aWVzLCBzbyBtYXliZSBsZXNzIHBvc3NpYmlsaXRpZXMgdG8g
ZmFpbD8NCj4gPiBIdWguIENvbmZpZyBzcGFjZSBoYXMgZmFyIGhpZ2hlciBmYWlsdXJlIHJhdGUg
Zm9yIHRoZSBQQ0kgdHJhbnNwb3J0IHdoZW4gZHVlIHRvDQo+IGluaGVyZW50IG5hdHVyZSBvZiBQ
Q0kgdGltZW91dHMgYW5kIHJlYWRzIGFuZCBwb2xsaW5nLg0KPiA+IEZvciBhbnkgYnVsayBkYXRh
IHRyYW5zZmVyIHZpcnRxdWV1ZSBpcyBzcGVjIGRlZmluZWQgYXBwcm9hY2guDQo+ID4gRm9yIG1v
cmUgdGhhbiBhIHllYXIgdGhpcyB3YXMgZGViYXRlZCB5b3UgY2FuIGNoZWNrIHNvbWUgMjAyMSBl
bWFpbHMuDQo+ID4NCj4gPiBZb3UgY2FuIHNlZSB0aGUgcGF0Y2hlcyB0aGF0IGRhdGEgdHJhbnNm
ZXIgZG9uZSBpbiBbMV0gb3ZlciByZWdpc3RlcnMgaXMgc25haWwNCj4gc2xvdy4NCj4gRG8geW91
IG9mdGVuIG9ic2VydmUgdmlydGlvIFBDSSBjb25maWcgc3BhY2UgZmFpbD8gT3IgZG9lcyBhZG1p
biB2cSBuZWVkIHRvDQo+IHRyYW5zZmVyIGRhdGEgdGhyb3VnaCBQQ0k/DQpBZG1pbiBjb21tYW5k
cyBuZWVkcyB0byB0cmFuc2ZlciBidWxrIGRhdGEgYWNyb3NzIHRob3VzYW5kcyBvZiBWRnMgaW4g
cGFyYWxsZWwgZm9yIG1hbnkgVkZzIHdpdGhvdXQgYmFraW5nIHJlZ2lzdGVycyBpbiBQQ0kuDQoN
Cj4gPg0KPiA+Pj4gVGhleSBrZXkgcGFydCBpcyBhbGwgb2YgdGhlc2UgaGFwcGVucyBvdXRzaWRl
IG9mIHRoZSBWTSdzIGRvd250aW1lLg0KPiA+Pj4gTWFqb3JpdHkgb2YgdGhlIHdvcmsgaW4gcHJv
cG9zYWwgWzFdIGlzIGRvbmUgd2hlbiB0aGUgVk0gaXMgX2xpdmVfLg0KPiA+Pj4gSGVuY2UsIHRo
ZSByZXNvdXJjZSBjb25zdW1wdGlvbiBvciByZXNlcnZhdGlvbiBpcyBzaWduaWZpY2FudGx5IGxl
c3MuDQo+ID4+IFN0aWxsIGRlcGVuZHMgb24gdGhlIHZvbHVtZSBvZiBWTXMgYW5kIGRldmljZXMs
IHRoZSBvcmNoZXN0cmF0aW9uDQo+ID4+IGxheWVyIG5lZWRzIHRvIG1pZ3JhdGUgdGhlIGxhc3Qg
cm91bmQgb2YgZGlydHkgcGFnZXMgYW5kIHN0YXRlcyBldmVuDQo+ID4+IHdoZW4gdGhlIFZNIGhh
cyBiZWVuIHN1c3BlbmRlZC4NCj4gPiBUaGF0IGhhcyBub3RoaW5nIGRvIHdpdGggYWRtaW4gdmly
dHF1ZXVlLg0KPiA+IEFuZCBtaWdyYXRpb24gbGF5ZXIgYWxyZWFkeSBkb2VzIGl0IGFuZCB1c2Vk
IGJ5IG11bHRpcGxlIGRldmljZXMuDQo+IHNhbWUgYXMgYWJvdmUsIFFPUw0KPiA+DQo+ID4+Pg0K
PiA+Pj4+Pj4gTmFtaW5nIGEgbnVtYmVyIG9yIGFuIGFsZ29yaXRobSBmb3IgdGhlIHJhdGlvIG9m
IGRldmljZXMgLw0KPiA+Pj4+Pj4gbnVtX29mX0FRcyBpcyBiZXlvbmQgdGhpcyB0b3BpYywgYnV0
IEkgbWFkZSBteSBwb2ludCBjbGVhci4NCj4gPj4+Pj4gU3VyZS4gSXQgaXMgYmV5b25kLg0KPiA+
Pj4+PiBBbmQgaXQgaXMgbm90IGEgY29uY2VybiBlaXRoZXIuDQo+ID4+Pj4gSXQgaXMsIHRoZSB1
c2VyIGV4cGVjdCB0aGUgTE0gcHJvY2VzcyBzdWNjZXNzIHRoYW4gZmFpbC4NCj4gPj4+IEkgc3Rp
bGwgZmFpbCB0byB1bmRlcnN0YW5kIHdoeSBMTSBwcm9jZXNzIGZhaWxzLg0KPiA+Pj4gVGhlIG1p
Z3JhdGlvbiBwcm9jZXNzIGlzIHNsb3csIGJ1dCBkb3dudGltZSBpcyBub3QgaW4gWzFdLg0KPiA+
PiBJZiBJIHJlY2FsbCBpdCBjbGVhciwgdGhlIGRvd250aW1lIGlzIGFyb3VuZCAzMDBtcywgc28g
ZG9uJ3QgbGV0IHRoZQ0KPiA+PiBiYW5kd2lkdGggb3IgbnVtIG9mIGFkbWluIHZxcyBiZWNvbWUg
YSBib3R0bGUgbmVjayB3aGljaCBtYXkNCj4gPj4gaW50cm9kdWNlIG1vcmUgcG9zc2liaWxpdGll
cyB0byBmYWlsLg0KPiA+Pj4+Pj4gY2FuIGRlcHRoID0gMUsgaW50cm9kdWNlIHNpZ25pZmljYW50
IGxhdGVuY3k/DQo+ID4+Pj4+IEFRIGNvbW1hbmQgZXhlY3V0aW9uIGlzIG5vdCBkb25lIHNlcmlh
bGx5LiBUaGVyZSBpcyBlbm91Z2ggdGV4dCBvbg0KPiA+Pj4+PiB0aGUgQVENCj4gPj4+PiBjaGFw
dGVyIGFzIEkgcmVjYWxsLg0KPiA+Pj4+IFRoZW4gcmVxdWlyZSBtb3JlIEhXIHJlc291cmNlLCBJ
IGRvbid0IHNlZSBkaWZmZXJlbmNlLg0KPiA+Pj4gRGlmZmVyZW5jZSBjb21wYXJlZCB0byB3aGF0
LCBtdWx0aXBsZSBBUXM/DQo+ID4+PiBJZiBzbywgc3VyZS4NCj4gPj4+IFRoZSBkZXZpY2Ugd2hv
IHByZWZlcnMgdG8gZG8gb25seSBvbmUgQVEgY29tbWFuZCBhdCBhIHRpbWUsIHN1cmUgaXQNCj4g
Pj4+IGNhbg0KPiA+PiB3b3JrIHdpdGggbGVzcyByZXNvdXJjZSBhbmQgZG8gb25lIGF0IGEgdGlt
ZS4NCj4gPj4gSSB0aGluayB3ZSBhcmUgZGlzY3Vzc2luZyB0aGUgc2FtZSBpc3N1ZSBhcyBhYm92
ZSAicmVzb3VyY2UgZm9yIHRoZSB3b3JzdA0KPiBjYXNlIg0KPiA+PiBwcm9ibGVtDQo+ID4gRnJh
bmtseSBJIGFtIG5vdCBzZWVpbmcgYW55IGlzc3VlLg0KPiA+IEFRIGlzIGp1c3QgYW5vdGhlciB2
aXJ0cXVldWUgYXMgYmFzaWMgY29uc3RydWN0IGluIHRoZSBzcGVjIHVzZWQgYnkgMzArIGRldmlj
ZQ0KPiB0eXBlcy4NCj4gZXhwbGFpbmVkIGFib3ZlLCB3aGVuIG1pZ3JhdGUgYSBWTSwgdGhlIHRp
bWUgY29uc3VtaW5nIGhhcyB0byBjb252ZXJnZW5jZQ0KPiBhbmQgdGhlIHRvdGFsIGRvd250aW1l
IGhhcyBhIGR1ZSwgSSByZW1lbWJlciBpdCBpcyBsZXNzIHRoYW4gMzAwbXMuIFRoYXQgaXMgdGhl
DQo+IFFPUyByZXF1aXJlbWVudC4NCkFuZCBhZG1pbiBjb21tYW5kcyBjYW4gZWFzaWx5IHNlcnZl
IHRoYXQgYXMgbWFqb3JpdHkgb2YgdGhlIHdvcmsgaXMgZG9uZSB3aGVuIHRoZSBWTSBpcyBydW5u
aW5nIGFuZCBtZW1iZXIgZGV2aWNlIGlzIGluIGFjdGl2ZSBzdGF0ZSBpbiBwcm9wb3NhbCBbMV0u
DQoNCg==

