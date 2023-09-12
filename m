Return-Path: <virtio-dev-return-13688-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983AECA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:58:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F1A342B061
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:58:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2D1F986636
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 05:58:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D7606986490; Tue, 12 Sep 2023 05:58:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C44AB986485;
	Tue, 12 Sep 2023 05:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qmf1DM4H8JDgLwJG2S1Ek0QoenWtJsvUUg6bkwWkObQtZOModO8LLWrLJ+9T2jLg7aWWVRDxE2dJOMSK2DMoktX07/F21EfS87R6h8cfhtJww76LFdWs0v2ihmUDnXJyrXwZEkg4kUkoCmFf9U/15RJtVJ5p/EjUppnu/hjss0CuIqwdde+pUVwHsYXu0kUY8YomSV3SCkiLsFmOK27zGq6+WzKSUVouGIGvzaomns8tQ9P1N4JklMPzXZHnL7uF/q7W5rkTHH1o+09eUkV2xCX7/HFnlaI8snkmjQUc5PyHcE/f82f5uF5eeWne9z0aezp7CMOCQfEZAfY7ZYudJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do7p6oNPLx8iUdG12cBDy1khRuyGV7U1lcX+Qx6KqGQ=;
 b=hQS2KSGYrRYw2FI/QpmB5zdCjjU4Q8/5tf026EF7iPKkkA/GX+06lV3ikDsujXuNWcpZLG9DFAfybWWDXLpZagRrj3C4OkFMfAlT6x3fpweBVEYGkIu62neOdnY8fBv2FiCqTawbKl4AxEDtqTvw/n5Pw8gt/bkpJ219dyhXfOLQFF7zOWDm75SXmX6XUjtkWU4hVcqc0VR5CjnRhKKhH030E6FFoubaJZPSOR+bNTYM0AccMLOzP/Hgg/fZL+833xYlX+teu9N2VtpAsynJC5/ZlUW0b5okm1J5vdq4w0dS4975REXUQgfnM2aeVvNRshG4RYdaKrK4GId59WjDWw==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAI3wCAAS5OAIAAHWKQ
Date: Tue, 12 Sep 2023 05:58:02 +0000
Message-ID:
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
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
 <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
In-Reply-To: <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7370:EE_
x-ms-office365-filtering-correlation-id: fc380a7d-71ca-4f6a-3b9e-08dbb355399c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TsXDxMI0iZK7KWfmNAfflm0gDW4F10LU5aXrRsVOXG9fy8ODaynoX0LFZDsy1YD16DVzYFr/pKcJtuOeEIvsYMPEvs9MBOJvIKSGJQ3cfieqbUYsEWMQZAoObtFNhLnbgLB7SBbp8dI+0Heyj04tI+aeMIN3DTptEwrfFtjxDR5h9HHK71tVPloeuR9OY+mczPC8M+uB6X2Rs0KG99M6SYSC/yPutschE9SOjgc6VJ9IfZ0DX42DxgqEK6dlH+0mh3HgIH3mwG6rBFPEuCpGlCn5u1WdCnw3k3g3LAG5Ac/dEGwVgoO327TMtn/lzWKU4GqVvJuzeqCLCM1bQ+5LsXrIRrexd8ioEn0Yi6lNi3zG+xxSxMHNneViDbADzc3MNQWRnCFyruPEgNbj2bBYRPV39Qr1dG2d25uxRF+OwpBFw/0rG74di5GIVZf8Srwz9vhz4hZVjopkwbuOu+OYt3o6Jx38Ft3en5PmzMg3V5LkG6agl+9JD11arFfGyo06lO4v3fMkX9V76b44Hkeek1gBnTXdxiQGB1LjjylXcHveUhhjTdo+Le98Lor8Fy6rbEvg3usVCIl3QCd/9vgw4TtlDJA7r/p4/h6PuwXRzZHfwRXXO/Jsf4Vsdh3TqhXo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(55016003)(52536014)(8676002)(54906003)(4326008)(66446008)(66556008)(66946007)(8936002)(41300700001)(2906002)(316002)(110136005)(5660300002)(76116006)(64756008)(66476007)(53546011)(7696005)(9686003)(71200400001)(38100700002)(6506007)(38070700005)(122000001)(26005)(83380400001)(86362001)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHovMFB5VUxtWlhyYUp6M1dHemFIMHJMVHdabHlsRXM4b2JXS1R0VVByKzhB?=
 =?utf-8?B?RG1pb09XTCtHNEtzR0Irdk1RTDNiN1pkRlZZWjlIZTFWcDNzSExnazdNdSsy?=
 =?utf-8?B?YlU3ZkRBSi9OYk1YYVRkbjA2Q3NpckxtN2JEcmwyZHlwQ1pBSEhRaUp0Z3Y3?=
 =?utf-8?B?Um1QUWN3S1ovbnZRZ01qMlRxOHVjVFhlS0k1aStIS1ZSQjIwOTVSblhDRUNW?=
 =?utf-8?B?aGVCbW9INlBvMkpoM0tmTElUeC8reWZjSlZHdENJS2lNeVhjN3FxYXRicWNX?=
 =?utf-8?B?YVZLbnJTa1R2djQ5akwwRnJ2N0djMyt0L1J4aWxxL2pQVk82Wm9pZXRyWHRC?=
 =?utf-8?B?N2tLelhmZlR3bis1WUpKWlVIRDMySjNOL0NRZmFMUlc1SkpZbVY0bmNDNGdt?=
 =?utf-8?B?V0dNaDRPN1AvbHVPSUpVM0RNSG53RXVvU0gvVTJmZ0loaUhtUTIzRkRxaUNF?=
 =?utf-8?B?VUpLK0xZdU9RS1JoZ0MwcUI1bkxTb0FjT1lUUEp4aUxDams1SHMrUmdCOUpM?=
 =?utf-8?B?UjB1cHlqZXcyV1MwamE3Q05TaFlnQ0ZHbWhHYnh5T0RxS1lFNlFTL3lDdzR2?=
 =?utf-8?B?TmNZSWtBVW5ZcmxQRDZWK2R1WjVOMG0xOXNSSS9PZ2pDcU5uNk5rSFZlaVZC?=
 =?utf-8?B?NnZhMTlRSEhmQURpbm1EQmtyN29PQlhUdDFCbXpnaHR6bE45RHpEaXREWUJD?=
 =?utf-8?B?Z3Vlb296QVZaeisxZEgwdy9VWWpVS1QvTmozaWQ0T0Q1d2t4V2NxY1lpZUtK?=
 =?utf-8?B?dDk2TFdqVUpITDhkczJTdnY3MytWMEVMVFk5a1E3djM2Q0R3R3N6QkdMYjVk?=
 =?utf-8?B?Zi95aE5zMnZHOE96cHlvSFFWbGxwUERIUHhURUlwbFdYdVpSQlg2L29vcUhJ?=
 =?utf-8?B?ZitzVVNZWlpyUXNLVFNlV2VGR0pkYWF0VGcxVTdkT01sOVA5OUlDbXk3Q2JF?=
 =?utf-8?B?VWJVZzNjcFlmKzU3cWNOT1ExK2JVRExlejhDc3NLVFRzN2pVTnZueTh3Mkww?=
 =?utf-8?B?L2plMk5MZHR1YUJyMkhZMlFoZUdYUGQrczY0U0FhWVBid0tmUlJKajdHRTF4?=
 =?utf-8?B?QlA1Ly9qUS9ranZERlhLOEhDLzNjb3R2dHZUUDhUSUtTL2xsN0Z1bndqVFZo?=
 =?utf-8?B?bFk5cW02NE53Q3hzSUJrbkgrRHEySnNackZiN3krd2J0TVJMUExJQTRLUmtQ?=
 =?utf-8?B?V2MyWTNObjkzeVUvRFIvQmFsYVR0MmdSUElLVDZrVzlvc084Y2N1MHh0RXlV?=
 =?utf-8?B?NU9TdHB5R0NLbWM3UjJvVXhDSlZLczNjN1ZvUmtBY0d2dTFjSUZTSUtHUnFo?=
 =?utf-8?B?c1RQelV1eG1SeW5IZDJsSEROKzlOWTZDY2JtTXZxVWY0WE1pN3ZVSHNvektS?=
 =?utf-8?B?b3VkdlNuRi80MjA4K1Y2aGRaWnNMTHNkYTJZaU5WdW1CNEdsamJxS1RiTDlx?=
 =?utf-8?B?TTV0VUNuVldkTUE1dkhFOXQwcTJuRVk0RmNZaC9UOXV3TmwxeG1IWVdnNHF6?=
 =?utf-8?B?UlNaUHJnbUk1K2VVb0J1OHFNYzY0S0lWQVQ4K2dEV3g5RkRlQ2xwYlhRR0xy?=
 =?utf-8?B?OEg5bnoxT0orR2R3SWp4NVFseVdKdTJ3Ty9UTTAvZTBqc3Y2a2NYL2JRK1My?=
 =?utf-8?B?Z3pzdFJvMCs3azRTMnBTSmJSSnRLV1hvQW1VWkVCSm1FalBFblVYLzNSRDZl?=
 =?utf-8?B?TGozTFprTUdUSGdPeVBmd3ZKOHVVbVIrdS84VzFESDNGaVRUWGp6RWowMERH?=
 =?utf-8?B?SHlidmlhbGxET1FLbitNNXBqem50OURBQkVrSUVEVFJpRTNBYzFIQjJZcUNF?=
 =?utf-8?B?WU1lTSt6d2k0SkFXbXlkdDNhRkI0UjVveVkzdGs5QnJhMVlqbDh5QUtJTDAw?=
 =?utf-8?B?UDBjblpoRE96dGR4WlhobnJLZDhPUm9wclRQc1dnVEhRaE53UFVXRGprRURw?=
 =?utf-8?B?NlJ5Y3VFa2xEZE85ZTVRWTVhUVR2aFMrN3VUVjhZRDVLMU9STzZtWitNQWFK?=
 =?utf-8?B?ZjBnbWJSWTkwc2NYQ1hOMXlmM0ViY0JvelRNb0FuK2tkanNZak1SdWFGa0dG?=
 =?utf-8?B?TlhOaU1wRG03WHJ5SjFnWUNGRmxXVG4ybjROTzFuSGRaRW5yYnNDYVBqSndz?=
 =?utf-8?Q?DA4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc380a7d-71ca-4f6a-3b9e-08dbb355399c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 05:58:02.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxGP8ICBfN/0E6uOWorqx7T7CXozmz6HJYgpVS2ns4dIKNrbIxidbxG/EvrCIFq9gAITKJgiSoTSEG1qy4aqqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyA5OjM3IEFNDQo+IA0KPiBPbiA5LzExLzIwMjMg
NjoyMSBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwg
MjAyMyAzOjAzIFBNIFNvIGltcGxlbWVudCBBUSBvbiB0aGUNCj4gPj4gImFkbWluIiBWRj8gVGhp
cyByZXF1aXJlIHRoZSBIVyByZXNlcnZlIGRlZGljYXRlZCByZXNvdXJjZSBmb3IgZXZlcnkNCj4g
Pj4gVkY/DQo+ID4+IFNvIGV4cGVuc2l2ZSwgT3ZlcmtpbGw/DQo+ID4+DQo+ID4+IEFuZCBhIFZG
IG1heSBiZSBtYW5hZ2VkIGJ5IHRoZSBQRiBhbmQgaXRzIGFkbWluICJ2ZiI/DQo+ID4gWWVzLg0K
PiBpdCdzIGEgYml0IGNoYW9zLCBhcyB5b3UgY2FuIHNlZSBpZiB0aGUgbmVzdGVkKEwyIGd1ZXN0
KSBWRiBjYW4gYmUgbWFuYWdlZCBieQ0KPiBib3RoIEwxIGd1ZXN0IFZGIGFuZCB0aGUgaG9zdCBQ
RiwgdGhhdCBtZWFucyB0d28gb3duZXJzIG9mIHRoZSBMMiBWRi4NClRoaXMgaXMgdGhlIG5lc3Rp
bmcuDQpXaGVuIHlvdSBkbyBNIGxldmVsIG5lc3RpbmcsIGRvZXMgYW55IGNwdSBpbiB3b3JsZCBo
YW5kbGUgaXRzIG93biBwYWdlIHRhYmxlcyBpbiBpc29sYXRpb24gb2YgbmV4dCBsZXZlbCBhbmQg
YWxzbyBwZXJmb3JtIGVxdWFsbHkgd2VsbD8NCg0KPiA+DQo+ID4+PiBJZiBVRFAgcGFja2V0cyBh
cmUgZHJvcHBlZCwgZXZlbiBhcHBsaWNhdGlvbiBjYW4gZmFpbCB3aG8gZG8gbm8gcmV0cnkuDQo+
ID4+IFVEUCBpcyBub3QgcmVsaWFibGUsIGFuZCBwZXJmb3JtYW5jZSBvdmVyaGVhZCBkb2VzIG5v
dCBtZWFuIGZhaWwuDQo+ID4gSXQgbGFyZ2VseSBkZXBlbmRzIG9uIGFwcGxpY2F0aW9uLg0KPiA+
IEkgaGF2ZSBzZWVuIGlwZXJmIFVEUCBmYWlsaW5nIG9uIHBhY2tldCBkcm9wIGFuZCBuZXZlciBy
ZWNvdmVyZWQuDQo+ID4gQSByZXRyYW5zbWlzc2lvbiBvdmVyIFVEUCBjYW4gZmFpbC4NCj4gVGhh
dCBkZXBlbmRzIG9uIHRoZSB3b3JrbG9hZCwgaWYgaXQgY2hvb3NlIFVEUCwgaXQgaXMgYXdhcmUg
b2YgdGhlIHBvc3NpYmlsaXRpZXMgb2YNCj4gbG9zaW5nIHBhY2tldHMuIEJ1dCBhbnl3YXksIExN
IGFyZSBleHBlY3RlZCB0byBwZXJmb3JtIHN1Y2Nlc3NmdWxseSBpbiB0aGUgZHVlDQo+IHRpbWUN
CkFuZCBMTSBhbHNvIGRlcGVuZHMgb24gdGhlIHdvcmtsb2FkLiA6KQ0KSXQgaXMgcG9pbnRsZXNz
IHRvIGRpc2N1c3MgcGVyZm9ybWFuY2UgY2hhcmFjdGVyaXN0aWNzIGFzIGEgcG9pbnQgdG8gdXNl
IEFRIG9yIG5vdC4NCg0KPiA+DQo+ID4+Pj4gQnV0IHRvbyBmZXcgQVEgdG8gc2VydmUgdG9vIGhp
Z2ggdm9sdW1lIG9mIFZNcyBtYXkgYmUgYSBwcm9ibGVtLg0KPiA+Pj4gSXQgaXMgbGVmdCBmb3Ig
dGhlIGRldmljZSB0byBpbXBsZW1lbnQgdGhlIG5lZWRlZCBzY2FsZSByZXF1aXJlbWVudC4NCj4g
Pj4gWWVzLCBzbyBob3cgbWFueSBIVyByZXNvdXJjZSBzaG91bGQgdGhlIEhXIGltcGxlbWVudGF0
aW9uIHJlc2VydmVkIHRvDQo+ID4+IHNlcnZlIHRoZSB3b3JzdCBjYXNlPyBIYWxmIG9mIHRoZSBi
b2FyZCByZXNvdXJjZT8NCj4gPiBUaGUgYm9hcmQgZGVzaWduZXIgY2FuIGRlY2lkZSBob3cgdG8g
bWFuYWdlIHRoZSByZXNvdXJjZS4NCj4gPiBBZG1pbmlzdHJhdGlvbiBjb21tYW5kcyBhcmUgZXhw
bGljaXQgaW5zdHJ1Y3Rpb25zIHRvIHRoZSBkZXZpY2UuDQo+ID4gSXQga25vd3MgaG93IG1hbnkg
bWVtYmVycyBkZXZpY2UncyBkaXJ0eSB0cmFja2luZyBpcyBvbmdvaW5nLCB3aGljaCBkZXZpY2UN
Cj4gY29udGV4dCBpcyBiZWluZyByZWFkL3dyaXR0ZW4uDQo+IFN0aWxsLCBkb2VzIHRoZSBib2Fy
ZCBkZXNpZ25lciBuZWVkIHRvIHByZXBhcmUgZm9yIHRoZSB3b3JzdCBjYXNlPyBIb3cgdG8gbWVl
dA0KPiB0aGF0IGNoYWxsZW5nZT8NCk5vLiBib2FyZCBkZXNpZ25lciBkb2VzIG5vdCBuZWVkIHRv
Lg0KQXMgZXhwbGFpbmVkIGFscmVhZHksIGlmIGJvYXJkIHdhbnRzIHRvIHN1cHBvcnRpbmcgc2lu
Z2xlIGNvbW1hbmQgb2YgQVEsIHN1cmUuDQoNCj4gPg0KPiA+IEFkbWluIGNvbW1hbmQgY2FuIGV2
ZW4gZmFpbCB3aXRoIEVBR0FJTiBlcnJvciBjb2RlIHdoZW4gZGV2aWNlIGlzIG91dCBvZg0KPiBy
ZXNvdXJjZSBhbmQgc29mdHdhcmUgY2FuIHJldHJ5IHRoZSBjb21tYW5kLg0KPiBBcyBkZW1vbnN0
cmF0ZWQsIHRoaXMgc2VyaWVzIGlzIHJlbGlhYmxlIGFzIHRoZSBjb25maWcgc3BhY2UgZnVuY3Rp
b25hbGl0aWVzLCBzbw0KPiBtYXliZSBsZXNzIHBvc3NpYmlsaXRpZXMgdG8gZmFpbD8NCkh1aC4g
Q29uZmlnIHNwYWNlIGhhcyBmYXIgaGlnaGVyIGZhaWx1cmUgcmF0ZSBmb3IgdGhlIFBDSSB0cmFu
c3BvcnQgd2hlbiBkdWUgdG8gaW5oZXJlbnQgbmF0dXJlIG9mIFBDSSB0aW1lb3V0cyBhbmQgcmVh
ZHMgYW5kIHBvbGxpbmcuDQpGb3IgYW55IGJ1bGsgZGF0YSB0cmFuc2ZlciB2aXJ0cXVldWUgaXMg
c3BlYyBkZWZpbmVkIGFwcHJvYWNoLg0KRm9yIG1vcmUgdGhhbiBhIHllYXIgdGhpcyB3YXMgZGVi
YXRlZCB5b3UgY2FuIGNoZWNrIHNvbWUgMjAyMSBlbWFpbHMuDQoNCllvdSBjYW4gc2VlIHRoZSBw
YXRjaGVzIHRoYXQgZGF0YSB0cmFuc2ZlciBkb25lIGluIFsxXSBvdmVyIHJlZ2lzdGVycyBpcyBz
bmFpbCBzbG93Lg0KDQo+ID4NCj4gPiBUaGV5IGtleSBwYXJ0IGlzIGFsbCBvZiB0aGVzZSBoYXBw
ZW5zIG91dHNpZGUgb2YgdGhlIFZNJ3MgZG93bnRpbWUuDQo+ID4gTWFqb3JpdHkgb2YgdGhlIHdv
cmsgaW4gcHJvcG9zYWwgWzFdIGlzIGRvbmUgd2hlbiB0aGUgVk0gaXMgX2xpdmVfLg0KPiA+IEhl
bmNlLCB0aGUgcmVzb3VyY2UgY29uc3VtcHRpb24gb3IgcmVzZXJ2YXRpb24gaXMgc2lnbmlmaWNh
bnRseSBsZXNzLg0KPiBTdGlsbCBkZXBlbmRzIG9uIHRoZSB2b2x1bWUgb2YgVk1zIGFuZCBkZXZp
Y2VzLCB0aGUgb3JjaGVzdHJhdGlvbiBsYXllciBuZWVkcw0KPiB0byBtaWdyYXRlIHRoZSBsYXN0
IHJvdW5kIG9mIGRpcnR5IHBhZ2VzIGFuZCBzdGF0ZXMgZXZlbiB3aGVuIHRoZSBWTSBoYXMgYmVl
bg0KPiBzdXNwZW5kZWQuDQpUaGF0IGhhcyBub3RoaW5nIGRvIHdpdGggYWRtaW4gdmlydHF1ZXVl
Lg0KQW5kIG1pZ3JhdGlvbiBsYXllciBhbHJlYWR5IGRvZXMgaXQgYW5kIHVzZWQgYnkgbXVsdGlw
bGUgZGV2aWNlcy4NCg0KPiA+DQo+ID4NCj4gPj4+PiBOYW1pbmcgYSBudW1iZXIgb3IgYW4gYWxn
b3JpdGhtIGZvciB0aGUgcmF0aW8gb2YgZGV2aWNlcyAvDQo+ID4+Pj4gbnVtX29mX0FRcyBpcyBi
ZXlvbmQgdGhpcyB0b3BpYywgYnV0IEkgbWFkZSBteSBwb2ludCBjbGVhci4NCj4gPj4+IFN1cmUu
IEl0IGlzIGJleW9uZC4NCj4gPj4+IEFuZCBpdCBpcyBub3QgYSBjb25jZXJuIGVpdGhlci4NCj4g
Pj4gSXQgaXMsIHRoZSB1c2VyIGV4cGVjdCB0aGUgTE0gcHJvY2VzcyBzdWNjZXNzIHRoYW4gZmFp
bC4NCj4gPiBJIHN0aWxsIGZhaWwgdG8gdW5kZXJzdGFuZCB3aHkgTE0gcHJvY2VzcyBmYWlscy4N
Cj4gPiBUaGUgbWlncmF0aW9uIHByb2Nlc3MgaXMgc2xvdywgYnV0IGRvd250aW1lIGlzIG5vdCBp
biBbMV0uDQo+IElmIEkgcmVjYWxsIGl0IGNsZWFyLCB0aGUgZG93bnRpbWUgaXMgYXJvdW5kIDMw
MG1zLCBzbyBkb24ndCBsZXQgdGhlIGJhbmR3aWR0aCBvcg0KPiBudW0gb2YgYWRtaW4gdnFzIGJl
Y29tZSBhIGJvdHRsZSBuZWNrIHdoaWNoIG1heSBpbnRyb2R1Y2UgbW9yZSBwb3NzaWJpbGl0aWVz
DQo+IHRvIGZhaWwuDQo+ID4NCj4gPj4+PiBjYW4gZGVwdGggPSAxSyBpbnRyb2R1Y2Ugc2lnbmlm
aWNhbnQgbGF0ZW5jeT8NCj4gPj4+IEFRIGNvbW1hbmQgZXhlY3V0aW9uIGlzIG5vdCBkb25lIHNl
cmlhbGx5LiBUaGVyZSBpcyBlbm91Z2ggdGV4dCBvbg0KPiA+Pj4gdGhlIEFRDQo+ID4+IGNoYXB0
ZXIgYXMgSSByZWNhbGwuDQo+ID4+IFRoZW4gcmVxdWlyZSBtb3JlIEhXIHJlc291cmNlLCBJIGRv
bid0IHNlZSBkaWZmZXJlbmNlLg0KPiA+IERpZmZlcmVuY2UgY29tcGFyZWQgdG8gd2hhdCwgbXVs
dGlwbGUgQVFzPw0KPiA+IElmIHNvLCBzdXJlLg0KPiA+IFRoZSBkZXZpY2Ugd2hvIHByZWZlcnMg
dG8gZG8gb25seSBvbmUgQVEgY29tbWFuZCBhdCBhIHRpbWUsIHN1cmUgaXQgY2FuDQo+IHdvcmsg
d2l0aCBsZXNzIHJlc291cmNlIGFuZCBkbyBvbmUgYXQgYSB0aW1lLg0KPiBJIHRoaW5rIHdlIGFy
ZSBkaXNjdXNzaW5nIHRoZSBzYW1lIGlzc3VlIGFzIGFib3ZlICJyZXNvdXJjZSBmb3IgdGhlIHdv
cnN0IGNhc2UiDQo+IHByb2JsZW0NCkZyYW5rbHkgSSBhbSBub3Qgc2VlaW5nIGFueSBpc3N1ZS4N
CkFRIGlzIGp1c3QgYW5vdGhlciB2aXJ0cXVldWUgYXMgYmFzaWMgY29uc3RydWN0IGluIHRoZSBz
cGVjIHVzZWQgYnkgMzArIGRldmljZSB0eXBlcy4NCg==

