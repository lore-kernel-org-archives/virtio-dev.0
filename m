Return-Path: <virtio-dev-return-13807-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E14ECD37B0
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 18:41:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CC6E92AD54
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 18:41:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3A999864D2
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 18:41:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9F1D598640C; Mon, 18 Sep 2023 18:41:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 917B998640D
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 18:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDexZTj/vPVSzUNdvNjM8mfqzlDJBuzamsTndFImsZPepvD48NVyHH8JF/F+1FtJE5bT260ibmI/fDUs5Op1CNnmZchSZEatrNhfkQFH6Oi8H6l/g7BLnjQI2YzwhDWrikbxqa9OyHPDMtENbHqgfWpy3aeuI1E9YHFe8Wkrfik674BFcmewc0G46yO4/tutR+r4xHw/fwa2EqiH+J3U1QNoFnLFC5KPWMDCmJ7nDVBKeZHcUxOlgfi2ah9S45B/wVeRoKQqJa6QI7QGR5VDMQqg1eFvB1BEdUZuSpdhf8xp+JeZGvWLyF97M0DfyO8xmhil1buBGvtrJjShPRZa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy0hEpeu2PpGWWMQF6rau2C/x2F5YHvFPsP8Q1ykmLk=;
 b=kaTa/PKxSvRqk+OSFA0ViDzb5PZnEpDOgsKwI9pz1xELbPSyNy+XGz2JU4F055WOXEI96CoPQCMiDAhhv0hNtZh5puz3TQs+fOVgVNeV1lVsg4BSM89srOhZM8MLW+LYuUyRqybtrE0G3dk0KjUz7l273eJfD9vfja7nc59snvSMCnPDXb7VcVEmCeNviXeKfO5UcISxuZ8c7zUzwVOOVaOy1foeabTtUpSOL3Quz1PcfypmJ1yDReUSNLN59jtCHgOshPlTQSdcJz+ScDJGsX4znUCqsMqHEh1ay2w+T8INzrALN0jQHafD9lajwdsMh/xM+Dn7shPvQtAHQTYhkA==
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
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98Q
Date: Mon, 18 Sep 2023 18:41:55 +0000
Message-ID:
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
In-Reply-To: <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4409:EE_
x-ms-office365-filtering-correlation-id: f8918be7-2550-424e-b4a2-08dbb876ef1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6aKVhQprAqHoIl57AB8jGZ2E6wRh9O1SCCT4A85z8aqYjhOh7BxeT4UeTF0oIJTQBGLH3cwucKlnzcp8+6NEJWER9HbSHmNN4LshxE9U8R+80Cmpaw6nfXfs17VYduVYvfe8wOWiR8fSXOt/vP4Deskw3P3nysn74v+Hf2FG2oTiNMS5JoSGfGiA4m3jLcmDgPaekwERIBcC79qA0xvvsGIKA0mmXIOJin+pr0ON1fqih98C/sRjLZuNzNanW4BKyx4uPdmFdH8YTknwM4S9Hh+Lscm1YdLilkK8AYB9CYTsN0CSnfjnB+TCjZokv6EMwpBNfaOzDhvuuqB5mniM9bxR8q6Z1asOU3yd+MFQraMV9tPOxA1doB/xh9S6wdpK5t+izX0Mfh8fWnYHqhrZy9ypsgvs/8xJsCZ0wCZ3ASz2CUuumAdf35p2Niw51omovg3Oc+7G5m5gR7mJXfzNAwPDAL1qesJITHitpDrhesGOJsHtbQQ05ySczdYM4WyGopcEcD612yPikBrr2WUBCCz4FlE2iKVjZs45EhOaDVvXdiQhUrV7fEvJavdOyp0oJW8sNMrwUMrqWay9VC9AIWHe/AztruLih/gBX60PE6809x8HuiweJscYhS94mUcN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(55016003)(66556008)(38070700005)(26005)(2906002)(33656002)(15650500001)(5660300002)(38100700002)(86362001)(122000001)(8936002)(8676002)(316002)(41300700001)(76116006)(66476007)(66946007)(64756008)(66446008)(71200400001)(478600001)(110136005)(83380400001)(52536014)(6506007)(53546011)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjBZN3d5aUova0VyTnpZS3pOUG9maU5WOHcra1lLRElrNDZEVjJ0anBTckpM?=
 =?utf-8?B?WjVDUTRjQVRBYkQ0LzQ0Y3paR3JzeGFyUlc4YmdlRkc2eld2ZDZZMTRUZ3dx?=
 =?utf-8?B?anpBS0xZNjFlTjdPbW5SQjR5a1lHZVVYSFpRSjByNnJ5SzZqWklPeG1uUWs1?=
 =?utf-8?B?TVdPNnZBMUQ5eTN5MTFEYW9iUHRNeDlpaGdXaENscXZLZDV2TjdYWFRzNHFk?=
 =?utf-8?B?RHBJNmwvNGRHeDU3aGNuUU1MRWlEN0lFQ0s0bUs5VVBEZHcwWi8rdHB2dzFC?=
 =?utf-8?B?ZEFwMFpuVHRvQkN6TDFUcGxPdkNMQU1sc015OVVMQWt6cS92eEI1dHdCMjA0?=
 =?utf-8?B?WnFCeWhydzczeC9vS3V5OWNHQmRHUzNCbkUyNHIrOUJRaUFGUHFDbkNuTnpl?=
 =?utf-8?B?SFBrejAxbXdGWXpqUkE5YUhYajQvMytuTlZ4MmpvR0xBcVFia01jcVpNTHZU?=
 =?utf-8?B?bzRnNlQrNFN4WDlmQXE2SFkrSnU0YUl0LzBQWVBpTHBPYVdmY0JXUHZScFFw?=
 =?utf-8?B?eWtGNkM1NTJKaHQvNkpIWnpEZzNpL0tWR2Y3eDBKZ1Zkc0pFUCtSSmNCdU91?=
 =?utf-8?B?RDZQMzlqYVg5WnFPU052a0pub0t0UEZsWXZIUkEzbXRpQnpHMmhUSVZ5MWto?=
 =?utf-8?B?aGcwMjFGN2UvQXpaQzJDRDNqUkJlS0FwRDkvWkV1RGdaLzdTWDBUb3RWNDhY?=
 =?utf-8?B?Rk1lV1NITDhad1A5ODIrL1FxNEUvaDhkcXNIYTV6QXZGdVYxZ3ptd0ZMS3gw?=
 =?utf-8?B?MWxnT244TlN3VSttdE5IdXphYWVBMGhxZERkbFV6TUdrdlRId09VVUdPcDJL?=
 =?utf-8?B?SEpzOCtiamdFb2l6VVI3eU5QYmN0U05zZ3hQMGZNK3pVZDhlMTJRazZiWitq?=
 =?utf-8?B?ZWdZQXVBRVNhdlRZM1JoaXRybGdKUmYrVmN1OEMvRmtXVWZiQlVmd21NYXhm?=
 =?utf-8?B?amtHdi9veDByNlpxQnhTSGh1bWx4Ymd2Wk1zZndkdCtSL2ZnWFdKTi9NVWF1?=
 =?utf-8?B?STMrMExxRExYSVRvUXhyQjZ6SUlFYUpXeEpTOCtvQTZQTjhLdmpVWjRUeTlO?=
 =?utf-8?B?Nk0xSU5lZzcydDFIV1hoaGN6bUtqK2xGQ1oyUVhjSkh4ckNBQzFjZTN1cS8r?=
 =?utf-8?B?LzVxOHBLSlpVaWlJNEtEcHB3NklEc0lqNnRFNjYvOCszSlV6aTh3SkJKNlA3?=
 =?utf-8?B?c1NPNXpUSER3LzRhVy9EVUsxWEdROGdNeXV0OXpSOThGU3FialQyZTRacXdk?=
 =?utf-8?B?eUxybnZlWlIvczBteGVpWkplSzBMZXRjOXRVSC8xeW5uK1RiNi9NZjcyOEhw?=
 =?utf-8?B?WEt6MnJXVllCRUNFcEFzV3RHSnVKY212V2hFTTNCNTlUZFI0N3JLOGtMVmsw?=
 =?utf-8?B?UjVYUEJPWUZrajlsekthM1dUclhxOU5BQWorQkJZM2ZJTXdmS1o3dWdTSHRG?=
 =?utf-8?B?Z1NLdlI4WkVxbUQvcUtYVTBuOWdvMk8zMFMvR1FYcVdrSEV1UkpCd3BaWGNB?=
 =?utf-8?B?RTZBVVVxSVN1dTd0MjlwUEkraEtqQmVwbGxuQ3F5TUlIckRkWWJyQ280cS9v?=
 =?utf-8?B?MTkyZTJSYVVGbktKZzlFZ0g2UWFBY2dPYWdaMEk5UGlQbWtIYXlSakdHd04z?=
 =?utf-8?B?a3FUcVRKWm9KQ001MlhDUnRkaUV4Y2NUZGlQWEpYUmdnQ1pOd2VJRDNNMEV2?=
 =?utf-8?B?M2hocHZqd0RZTW4vYVg3NDUzajh6R2tNeGxCZ0l1ZlRWOXByYkhjTzBvQzY1?=
 =?utf-8?B?M29zRW5TUzUxSFZ6OGtzb2tsMHA4NlFKWUZrY290ODZSRWFMNGUwelk1Q1Rn?=
 =?utf-8?B?REV5TWZVeFlUaERGY2ZmVG1oVG5oRDRuL0kxWjRoU1lQNmUzN1dSeXI0dWdX?=
 =?utf-8?B?TjBYbjVGemNVa2RuRWNHN3VSQ0Y3OGNNNVk0RHNxZ0NxYjI4VExTYnE3Rklp?=
 =?utf-8?B?bm1WbmJwRVo5aW5iMEtmd3dTdFdIT2JyUndOSGo4dmRjOGtGM0gzNE84SXZI?=
 =?utf-8?B?TkM2NXhzS0tzbWNYaFJVRkFQNVRtWXZ0Z1JKcFdTUUpwV3JQNTVGNktzamVS?=
 =?utf-8?B?YlJSa3NBRlEzRWRjRTl6V3BSYXhGY1NKSjZRM1NyTkZSNHZXajlaUmg3ekhN?=
 =?utf-8?Q?1gmc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8918be7-2550-424e-b4a2-08dbb876ef1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 18:41:56.0108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iF4Rvt5gAPPRJdA75aDbRVjG1H2opQE3TEGVAUClpKrX/vMnhECs0BpcKw50aWmF24JqIIeNltMSLkwoZYp40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDM6MDUgUE0NCj4gDQo+IE9uIDkvMTgvMjAyMyAy
OjU0IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxp
bmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAy
MDIzIDEyOjE5IFBNDQo+ID4NCj4gPj4gc28gYWRtaW4gdnEgYmFzZWQgTE0gc29sdXRpb24gY2Fu
IGJlIGEgc2lkZSBjaGFubmVsIGF0dGFja2luZyBzdXJmYWNlDQo+ID4gSXQgd2lsbCBiZSBwYXJ0
IG9mIHRoZSBEU00gd2hlbmV2ZXIgaXQgd2lsbCBiZSB1c2VkIGluIGZ1dHVyZS4NCj4gPiBIZW5j
ZSwgaXQgaXMgbm90IGF0dGFjayBzdXJmYWNlLg0KPiBJIGFtIG5vdCBzdXJlLCB3aHkgd2UgaGF2
ZSB0byB0cnVzdCB0aGUgUEY/DQo+IFRoaXMgaXMgb3V0IG9mIHZpcnRpbyBzY29wZSBhbnl3YXku
DQo+IA0KPiBJIGhhdmUgZXhwbGFpbmVkIG1hbnkgdGltZXMgaG93IGl0IGNhbiBiZSBhIGF0dGFj
ayBzdXJmYWNlLCBhbmQgZXhhbXBsZXMuDQo+IA0KQW5kIG5vbmUgb2YgdGhhdCBtYWtlIGFueSBz
ZW5zZSBhcyBmdW5kYW1lbnRhbGx5LCBoeXBlcnZpc29yIGlzIHRydXN0ZWQgcmVnYXJkbGVzcyBv
ZiB0aGUgYXBwcm9hY2guDQoNCj4gV2hhdCBoYXBwZW4gaWYgbWFsaWNpb3VzIFNXIGR1bXAgZ3Vl
c3QgbWVtb3J5IGJ5IGFkbWluIHZxIGRpcnR5IHBhZ2UNCj4gdHJhY2tpbmcgZmVhdHVyZT8NCldo
YXQ/Pw0KV2hlcmUgaXMgdGhpcyBtYWxpY2lvdXMgU1cgaXMgbG9jYXRlZCwgaW4gZ3Vlc3QgVk0/
DQoNCj4gPg0KPiA+Pj4+Pj4gRm9yIHVudHJ1c3RlZCBoeXBlcnZpc29yLCBzYW1lIHNldCBvZiBh
dHRhY2sgc3VyZmFjZSBpcyBwcmVzZW50DQo+ID4+Pj4+PiB3aXRoDQo+ID4+Pj4+PiB0cmFwK2Vt
dWxhdGlvbi4NCj4gPj4+Pj4+IFNvIGJvdGggbWV0aG9kIHNjb3JlIHNhbWUuIEhlbmNlIGl0cyBu
b3QgcmVsZXZhbnQgcG9pbnQgZm9yIGRpc2N1c3Npb24uDQo+ID4+Pj4+IHRoaXMgaXMgbm90IGh5
cGVydmlzb3IsIERvIHlvdSBzZWUgYW55IG1vZGVybiBoeXBlcnZpc29yIGhhdmUNCj4gPj4+Pj4g
dGhlc2UgaXNzdWVzPw0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGlzIGlzIGFkbWluIHZxIGZvciBMTSBj
YW4gYmUgYSBzaWRlIGNoYW5uZWwgYXR0YWNraW5nIHN1cmZhY2UuDQo+ID4+PiBJdCBpcyBub3Qu
DQo+ID4+PiBIeXBlcnZpc29yIGlzIHRydXN0ZWQgZW50aXR5Lg0KPiA+Pj4gRm9yIHVudHJ1c3Rl
ZCBoeXBlcnZpc29yIHRoZSBURElTUCBpcyB1bmlmaWVkIHNvbHV0aW9uIGJ1aWxkIGJ5IHRoZQ0K
PiA+Pj4gdmFyaW91cw0KPiA+PiBpbmR1c3RyeSBib2RpZXMgaW5jbHVkaW5nIERNVEYsIFBDSSBm
b3IgbGFzdCBmZXcgeWVhcnMuDQo+ID4+PiBXZSB3YW50IHRvIHV0aWxpemUgdGhhdC4NCj4gPj4g
Zmlyc3QsIFRESVNQIGlzIG91dCBvZiB2aXJ0aW8gc3BlYy4NCj4gPiBTdXJlLCBoZW5jZSwgdW50
cnVzdGVkIGh5cGVydmlzb3IgYXJlIG91dCBvZiBzY29wZS4NCj4gPiBPdGhlcndpc2UsIHRyYXAr
ZW11bGF0aW9uIGlzIGVxdWFsbHkgZGVhZCB3aGljaCByZWxpZXMgb24gdGhlIGh5cGVydmlzb3Ig
dG8NCj4gZG8gdGhpbmdzLg0KPiBzbyBsZXRzIGZvY3VzIG9uIExNIHRvcGljLCBvdGhlciB0aGFu
IGNvbmZpZGVudGlhbCBjb21wdXRpbmcuDQpvay4NCg0KPiA+IEp1c3QgYmVjYXVzZSBkYXRhIHRy
YW5zZmVyIGlzIG5vdCBkb25lLCBpdCBkb2VzIG5vdCBtZWFuIHRoYXQgdGhvdXNhbmRzIG9mDQo+
IHBvbGxpbmcgcmVnaXN0ZXIgd3JpdGVzIGNvbXBsZXRlIGluIHN0aXB1bGF0ZWQgdGltZS4NCj4g
MSkgYWdhaW4sIHRoZXkgYXJlIHBlci1kZXZpY2UgZmFjaWxpdGllcw0KVGhhdCBkb2VzIG5vdCBz
YXRpc2Z5IHRoYXQgaXQgY2FuIHNvbWVob3cgZG8gd29yayBpbiA8IHggdXNlYyB0aW1lLg0KPiAy
KSB3ZSB1c2UgdmVyeSBmZXcgcmVnaXN0ZXJzLCBldmVuIHN0YXR1cyBieXRlIGRvZXMgbm90IHJl
cXVpcmUgcG9sbGluZywganVzdCByZS0NCj4gcmVhZCB3aXRoIGRlbGF5Lg0KPiANCj4gUGxlYXNl
IHJlZmVyIHRvIHRoZSBjb2RlIGZvciBzZXR0aW5nIEZFQVRVUkVTX09LLg0KSXQgd29udCB3b3Jr
IHdoZW4gb25lIG5lZWRzIHRvIHN1c3BlbmQgdGhlIGRldmljZS4NClRoZXJlIGlzIG5vIHBvaW50
IG9mIGRvaW5nIHN1Y2ggd29yayBvdmVyIHJlZ2lzdGVycyBhcyBmdW5kYW1lbnRhbCBmcmFtZXdv
cmsgaXMgb3ZlciB0aGUgQVEuDQo=

