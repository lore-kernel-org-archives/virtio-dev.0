Return-Path: <virtio-dev-return-12232-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FED9C77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 04:08:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7F00326A3B
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 04:08:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76AA1986637
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 04:08:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6BF8C986611; Fri, 14 Apr 2023 04:08:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5939E986600;
	Fri, 14 Apr 2023 04:08:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZFRx7mTXetXEQJuKSGdhhQgUvzalFp5Gr8ODjJAZQ+az6WP2K9YSn/MCJiehUJuCLiQdyyHzlGi/6pXCNR8wUMmuCzbDw5Jl2mr0cdg5nA5LqYGziOTw/JCgyQ5CSVQiegP05s4LMciDP0HY1IzKJCyeUbH8n0d97Q3V3PKfz0FgQ5UuugdJQHulJ0vdfVERGAD3rWgE2XTr3Yv2bhTFCZA+U5Qq4G01aE2ZNobR6Cg+OBgtlam45e4942Tpb9psw72Rj1VrEfmnO6acfpExhIJ5V4JBPme8caCGu3eAjwnK4GYVcbsyfhwd3nchat+cHiVoOdNYMdzEYApk+1wNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbQ4UmVw1U0BnMp1SCq6Bfyypq1AmBlQdcgHAgW+C5Y=;
 b=H3X/3zY4uCC/ONU9kXiW6wTZczgEeHQMJsVejJJjTNBqGc/sUWs7BCTwM326PZvtQzOd99AjGV8WNim5hHYd7qSH7RundfjjaG0dDlz1qrpjTZtdgkezqj2rK/FWjFpwNs80zmZgB3yFuSx2ufQHqYZUGv62dgfhElU1DxhHYkZgOtlgIiO98KLOGPzm+Rdx/oky9MGR3ajysBA3gVSPn++RTYt/S+raPrddngbQoc/qirIpv7R/WELmwQCFsWFkvZeySjOMqEtW3CSsopX7kmNoOlle8lkdAB0/kbYRj3qeeOIjgrEIFdrP3c1Gx7woQjV46i66A+Tw6v6MjsRyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net:
 support inner header hash
Thread-Index:
 AQHZZej1XywEX8fM8U6/FbgnxdM+I68op7GAgAB7oQCAALOiAIAAWpcAgAAOCwCAAAEzgA==
Date: Fri, 14 Apr 2023 04:08:08 +0000
Message-ID:
 <PH0PR12MB5481C050DA4052A520070F43DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
 <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
 <20230413174525-mutt-send-email-mst@kernel.org>
 <CACGkMEttCB7J4bd8HoB4z7zQrhZArBHCECWcuuHy2eJVoV7tew@mail.gmail.com>
 <202ec911-85fb-4afa-1970-652085830fc8@linux.alibaba.com>
In-Reply-To: <202ec911-85fb-4afa-1970-652085830fc8@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5907:EE_
x-ms-office365-filtering-correlation-id: b671b46b-4235-4249-1f40-08db3c9ddb3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pih6lS7M97hvV0Zrk6Pl0zfRkjteKlLriZtAX90JVbk8eE+LJ4LyuPCGWjkmNwcOsIiQ8cd344xwbcYnMDmCM9JKQD4PH9wwg5CEPfndPDvOR9451e2Myytf2iWSEie7eap7wib3ieD9LRr11L/nxT4hYIKzmoYGLJ7uDa62aZ4AAFdtNvRvOSIAaEb6uSxbFD1+Ae4dNkPeC2soJ/NzP3SMYjxu/iXJpk8mM6R6nWXWw9YcNVS4JGt8QKtZ0+3fNaTonOrZRfnYLBZKUvpCI7R6giLN/J0XBEsdJiqHE4qenhlfYKxWs6GFlS1WscCPpHgbNOTjKbYxQbhJu1uRotS/44TlXnHunc/eKXuEsYcgszLdJY1OgF/pi98SHHeEOnHoXBL+H78oOmssZ0RTNbywrUUyHIhW6GM+MosTMX1BCdwCipDioj5Q+EAj5Hwh4btFTGZGUw59AL9kfQOsOsZzkcQ+sSekJLW80PbVp1Hx7+ND/OyqtHlM96Rbm6LfepegtWjbvxayEqWf3y8VC3xUizrcG4lhAeNpTmuP9bmQns9pqAufAmfFksC5PCLh21tfigigYM5O6Hgym4MgMgx9jHez0yEXB3pZSry7BppIGFCjA8ceNb9qBADRty7OQGgOXOBt6CbfM2RADlgCiQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(26005)(76116006)(86362001)(66946007)(6506007)(4326008)(66476007)(66556008)(64756008)(316002)(9686003)(110136005)(66446008)(186003)(71200400001)(966005)(53546011)(7696005)(54906003)(478600001)(55016003)(8936002)(52536014)(33656002)(122000001)(41300700001)(38100700002)(5660300002)(8676002)(38070700005)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3VFcHhGeTMyUVF3Q1p6Tk9RQkd4Ui82Z2t1aEdRaVlMR2toN2Y1WHd6QUYv?=
 =?utf-8?B?WkFZNzRYUEFXNVRTcktWU3QvQzMxNFFPOWFEY2J0YW5zRGNIa0x2ZzhoNHVu?=
 =?utf-8?B?NkF2WnlUa0RSbWFUU2NPaklLRVdzWklaT2xRWktlWmVrV1U0ZDBoNlpJZHZr?=
 =?utf-8?B?Wi9wZ1RRYnVXSGxHRkpQNjRUUDdWbXdXRURValkyeS82L0k0empZTDFBMXJJ?=
 =?utf-8?B?dmVhaXJ3QXJ6OWs5SXY2ZkRBZFZHNktHTlVaZXdka3FhMjdMWjEvUGhHT3Zr?=
 =?utf-8?B?UlMwbkVMM3VZLzI4Z2FBN2V3WFVPNU40SzFBY08yaXh6akpadS9SbEY1T2hn?=
 =?utf-8?B?TlduZ0ZqWXlVVHZkTUtpUjU4RWtYYS9sbDNycnMzZjhLT1hVbzR5Y3BRcDNI?=
 =?utf-8?B?WFhQL2toUFJPMmM5bjNoZXJ5Z2d5c3A2MVNOeC8xcGZ6b25DQXZYb1Q3NGxa?=
 =?utf-8?B?cUlnQVRBMXpXa2Vrc0gzV1lHOGRLSU5hejVUNVZGOXNGaEdSeitxMFNGSkdQ?=
 =?utf-8?B?ZHV1dyt3citwaGN4MW9EWWY1dnpZUE1kU2tsNTV5aFIwWVJWdFdMbi9JSit2?=
 =?utf-8?B?NXJsNlhuV21na2llcHNpVlpzZUFuM2NkY0hTNGRBOHhPTmVMK0lEUVVYcS9v?=
 =?utf-8?B?Y2ZKQi9ncUpIN3BmeGdMOTNXK0t4RE0wSzNXTFY3c0ZGam1SSnB4L08yQlZp?=
 =?utf-8?B?Q2JPWktwVklJNm9OS01jZFNLYVZLUkQ3SjZEOEEzL0hWQjhXWk1VUlplYU5X?=
 =?utf-8?B?UktzenAzaVFFLzN5VXU4R3pKMHB5c2Q2eEMyZ3MwZDhDNnYxYm9zOWs5WUI0?=
 =?utf-8?B?V1BEWjJVQ1VTQjV5NUU5dWkxOElKT3NzTENKekYwcDh0dW1LT3ZtNGJ0NEdi?=
 =?utf-8?B?WXFaNEo3WFVVZnNOR2oxRE5vRDIxcEg2RzVCdFlvcmI1Um53bU1mVnBYR2ht?=
 =?utf-8?B?L3BmNFhnY2trVUpzRGcwS3h6dkJHeTV5Y1RUL29MUisrTitnMG11WVh1R0oz?=
 =?utf-8?B?M1BNTWhzanR4TkV4TzdrTEQ5R0pGS3VhQnhnL3JlMmVlMnpJNE9SeVQ2NkdE?=
 =?utf-8?B?dnFKTCt0RVRoaHZBTmFDcmVWYytlbzZENHVwMlk4ZlRPbnY1UnR1dGlPTmpP?=
 =?utf-8?B?MWhjdXZNejROOGdmbmY3eVdBN0RkNmhqYXVtaXhGWEpWZU85bm5weEdETUh0?=
 =?utf-8?B?Ym9WQXZ6QmtUaldaRjJSWjZnTU1IV3I1VTdCRm53MGthRWl5ZWlFbmE2UUVE?=
 =?utf-8?B?WGZRcWZRSUtaNDU0QW5ibGhNeGRDVXJrZTI2a3pnaDRVcU1QSVNGUTBGeHJp?=
 =?utf-8?B?K2tEbG9hMklQOFBNcVpmMExWVmFNSTZla3R4U0NlQUtmdmJ1Y1VvTk5vY1NK?=
 =?utf-8?B?bFJQNklkR04wMngrMEZzYUVjK0I0azJUVTFoeVNOV0x2OSt2QXNmK3RDOEdq?=
 =?utf-8?B?RkE3Ykp3V29wZ3g0UW1PV29vaHp6dHZnUjFoM3BjcklXMHcwRmRHTEJXNWJj?=
 =?utf-8?B?MVA2N2kremVtYTg4c0doc1BzbnpYaXFGeEswcGNHTlp6VXQwckNjR3UwUDMv?=
 =?utf-8?B?ZCtMVzgrRXpvN1p1YlRvQTBoSVV5NEtwSTVyWjB1NHpCcGljdkdmRHY1QVhR?=
 =?utf-8?B?ZjZKY3NheitHTzh5ZGt0SVdWZ0VuYWI2WmJYSGsxOG8xeE9ZaFhTZGM5anJS?=
 =?utf-8?B?b3hkRmoxalR3cjRaOTRvMzBoSUs0L3BORW9lczFCenlMY0E2cDBUaTN6NDhy?=
 =?utf-8?B?WVJaclBGakVhSHdWVlVXMFJGL0I3akN5bENCbVoxM01XK1NiS2xoVkwydXVt?=
 =?utf-8?B?MGhiTThiVzJURUFaTDFkTHVGalRiaEt3VTlRSkVkSHNPaXVlbWJkeWx2WVYw?=
 =?utf-8?B?ZDhuVmlNK1ZyS2s5cXJzYVZRT1NLc3E0R1d0YzgrR2lOMTFHbEw0bUlicUFm?=
 =?utf-8?B?U1crL29ZT1UxSGNSTUNVbnBWKytUYi8xSzBta0I1S2FTTUdOSTdrd3Z4Mzhy?=
 =?utf-8?B?ZTNvMjh5azJCaXNpNXJLV2NHSTlrcy9HUVpzVFlJTFZWVkpyWW1ad3NJdUNo?=
 =?utf-8?B?WFAzYUd4S0xjaERrVWtVNWR2c0lzcThsTDg4Y2xxQ0EvaUdDNlhCN21HNkNP?=
 =?utf-8?Q?5nVM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b671b46b-4235-4249-1f40-08db3c9ddb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 04:08:08.8364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tep29qLWD83i5oKxVE9QBqjL2TKlJy4xEI748kKXjz9uxmuWPKTADDzTVVwaesohaOHU0W7T7OzU5DH/sZ+GDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net:
 support inner header hash

DQoNCj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBG
cmlkYXksIEFwcmlsIDE0LCAyMDIzIDEyOjAxIEFNDQo+IA0KPiDlnKggMjAyMy80LzE0IOS4iuWN
iDExOjEwLCBKYXNvbiBXYW5nIOWGmemBkzoNCj4gPiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCA1
OjQ24oCvQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4+
IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDA3OjAzOjI2UE0gKzA4MDAsIEhlbmcgUWkgd3JvdGU6
DQo+ID4+Pj4+ICAgIEZvciBleGFtcGxlLCB3aGVuIHRoZSBwYWNrZXRzIG9mIGNlcnRhaW4NCj4g
Pj4+Pj4gK3R1bm5lbHMgYXJlIHNwcmVhZCBhY3Jvc3MgbXVsdGlwbGUgcmVjZWl2ZSBxdWV1ZXMs
IHRoZXNlIHJlY2VpdmUNCj4gPj4+Pj4gcXVldWVzIG1heSBoYXZlIGFuIHVuYmFsYW5jZWQNCj4g
Pj4+Pj4gK2Ftb3VudCBvZiBwYWNrZXRzLiBUaGlzIGNhbiBjYXVzZSBhIHNwZWNpZmljIHJlY2Vp
dmUgcXVldWUgdG8NCj4gPj4+Pj4gYmVjb21lIGZ1bGwsIHJlc3VsdGluZyBpbiBwYWNrZXQgbG9z
cy4NCj4gPj4+Pg0KPiA+Pj4+IFdlIGhhdmUgbWFueSBwbGFjZXMgdGhhdCBjYW4gbGVhZCB0byBw
YWNrZXQgZHJvcHBpbmcuIEZvciBleGFtcGxlLA0KPiA+Pj4+IHRoZSBhdXRvbWF0aWMgc3RlZXJp
bmcgaXMgYmVzdCBlZmZvcnQuIEkgdGVuZCB0byBhdm9pZCBtZW50aW9uaW5nDQo+ID4+Pj4gdGhp
bmdzIGxpa2UgdGhpcy4NCj4gPj4+IE9rLiBBbmQgTWljaGFlbCB3aGF0IGRvIHlvdSB0aGluayBh
Ym91dCB0aGlzPw0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoaXMgdGV4dCBkaWQgbm90IGRvIGEgZ3Jl
YXQgam9iIGV4cGxhaW5pbmcgdGhlIHNlY3VyaXR5DQo+ID4+IGFzcGVjdC4gSGVyZSdzIGEgYmV0
dGVyLCBzaG9ydGVyIGV4cGxhbmF0aW9uOg0KPiA+Pg0KPiA+PiAgICAgICAgICBJdCBpcyBvZnRl
biBhbiBleHBlY3RhdGlvbiBvZiB1c2VycyB0aGF0IGEgdHVubmVsIGlzb2xhdGVzIHRoZSBleHRl
cm5hbA0KPiA+PiAgICAgICAgICBuZXR3b3JrIGZyb20gdGhlIGludGVybmFsIG9uZS4gQnkgY29t
cGxldGVseSBpZ25vcmluZyBlbnRyb3B5IGluIHRoZQ0KPiA+PiAgICAgICAgICBleHRlcm5hbCBo
ZWFkZXIgYW5kIHJlcGxhY2luZyBpdCB3aXRoIGVudHJvcHkgZnJvbSB0aGUgaW50ZXJuYWwgaGVh
ZGVyLA0KPiA+PiAgICAgICAgICBmb3IgaGFzaCBjYWxjdWxhdGlvbnMsIHRoaXMgZXhwZWN0YXRp
b24gbWlnaHQgYmUgdmlvbGF0ZWQgdG8gYSBjZXJ0YWluDQo+ID4+ICAgICAgICAgIGV4dGVudCwg
ZGVwZW5kaW5nIG9uIGhvdyB0aGUgaGFzaCBpcyB1c2VkLiBXaGVuIHRoZSBoYXNoIHVzZSBpcw0K
PiBsaW1pdGVkDQo+ID4+ICAgICAgICAgIHRvIFJTUyBxdWV1ZSBzZWxlY3Rpb24sIHRoZSBlZmZl
Y3Qgd2lsbCBsaWtlbHkgYmUgbGltaXRlZCB0byBhYmlsaXR5IG9mDQo+ID4+ICAgICAgICAgIHVz
ZXJzIGluc2lkZSB0aGUgdHVubmVsIHRvIGNhdXNlIHBhY2tldCBkcm9wcyBpbiBtdWx0aXBsZSBx
dWV1ZXMgKGFzDQo+ID4+ICAgICAgICAgIG9wcG9zZWQgdG8gYSBzaW5nbGUgcXVldWUgd2l0aG91
dCB0aGUgZmVhdHVyZSkuDQo+ID4gQW5kIHRoaXMgaXMgb25seSBmb3IgR1JFLWluLVVEUD8gVGhp
cyBtYWtlcyBtZSB0aGluayBpZiB3ZSBzaG91bGQgYWRkDQo+ID4gR1JFIHN1cHBvcnQgZm9yIHRo
ZSBvdXRlciBoZWFkZXIgbGlrZToNCj4gPg0KPiA+IGh0dHBzOi8vZG9jcy5uYXBhdGVjaC5jb20v
ci9GZWF0dXJlLVNldC1OLUFOTDkvSGFzaC1LZXktVHlwZS0xMC0zLVR1cGwNCj4gPiBlLUdSRXYw
DQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgZm9yIHR1bm5lbGluZyBwcm90b2NvbHMgd2l0aCBzcGVj
aWZpYyBmbG93IGZpZWxkcywgc3VjaCBhcyBHUkU6a2V5DQo+IGZpbGVkLCBOVkdSRTpGTE9XSUQg
ZmlsZWQuDQo+IA0KPiBUaGlzIHJlcXVpcmVzIHVzIHRvIG1ha2UgYSByZXF1aXJlbWVudCB3aGVu
IGNhbGN1bGF0aW5nIHRoZSBoYXNoIG9mIHRoZQ0KPiB0dW5uZWxzIHdoZW4gRl9UVU5ORUxfSEFT
SCBpcyBub3QgbmVnb3RpYXRlZC4gSXQncyBhIG5ldyB3b3JrLg0KPiANClllcywgSSB0aGluayBK
YXNvbiBpcyBzYXlpbmcgdGhlIHNhbWUgdG8gZXh0ZW5kIHRoZSBvdXRlciBoZWFkZXIgaGFzaGlu
ZyBmb3IgbmV3ZXIgcHJvdG9jb2xzIHdoZXJlIG91dGVyIGhlYWRlciBlbnRyb3B5IGlzIGF2YWls
YWJsZS4NCg==

