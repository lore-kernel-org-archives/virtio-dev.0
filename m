Return-Path: <virtio-dev-return-12193-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FE3C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:55:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18DF92A887
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:55:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12A2198660D
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:55:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 070BD9865EE; Wed, 12 Apr 2023 05:55:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7A0398650E;
	Wed, 12 Apr 2023 05:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSBq6buaP437ugidmcYthgxwGc4dEKrcnAIsUZuIs6BM+vlHqTfwUiiCNWkxI4se19YNpmdAsxmAB9RyHMI0XjZM44AtUKmrD0SfOml0IMrxlsxdDZyfKp66NSLYF9asQWO8WMtv8pxHzhXbRdhEewmIZULOCEcP7IBRsQmXZrPEp0nZGKsPgrfh1DNdEYG7GPh8g4w1TsSDxPYOoIu4zVtXSdrcVHCU/oeieFKGieCPkHj6A1UmIcethg+O0MXzr1UzvFB79334nmGMYYiF7Xzidt7YWWd6aNjdg8ryOqw6SWEFHdTXqqa+yB4ktFeZcoRx09aNsK8I+nIZzwhycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsoI/RKnrV9B1ZoR5tWzvldMhsqM5+eIOAtsvI629qE=;
 b=OlWmBaourGGq8UdYCKOO7D0iuwt0t7HuyRs/OSHPyooRsB54BCmabkuMt1ov7AJCLYMRvwxXw+w6+YtkTP9Lmv2RLCKDqhozT9TtEJckDCX7gOuU2t7RGFXrnQCJ11HniXUdM0Szb7HlH+4ZWU39XHqqBbtvI6oZcKzRVv07bt/meo9VymtfacqQdo/jvTNNGqsbUINlrpKDZNhUUO8jy0HMD/neudyeuxVSrsUW0Nz1EFXiIDx/xh+eeAK3Chf3tWeM4kUZNL8GApjgNGDwhh2tOBr0w2qx2it06Jbi1LYT+fPMACaRoZjkkDB1GCfLRhIMvERmN+renXFFegZ+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIA
Date: Wed, 12 Apr 2023 05:55:36 +0000
Message-ID:
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
In-Reply-To:
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB8743:EE_
x-ms-office365-filtering-correlation-id: 735529f3-33c0-4b3e-ab15-08db3b1a8981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8K+X+X+Wb8FsQnurto8ERtd7Gy/GRjYkaVuT0G5e0jQuAunHXynKG0q1JwRdXGEjCuFiobsg/t6hHxbpm0ffRR4SxPS9MMlYSbF06tgxWEnt3sXU9E3iyHlZ5pq9uxybr1fp0EaV5VX4C/zr3vTLWB4uOOFo71HRAOn05U9sF4mEML+smiu8iRXOqCKnGkb1lyC/9nIGlBFbjDDSv3UbVTMteOjSTTIthR9W84nhSXbAkI/f9c0/cR415ZEMVIiz7Dj+D8oBYtg2f7M3ZOt3v1uHEr5eldHSED3U5IUVwow5ExKnZenDHh75x2DSkhRfk1/5O59bD9pJg8iOGbLO3r/A7FSOgMF3pjf8nwSJUcifmPyeTPvj8aoMKIPdJb74lx5dtGhWzcqYoGtldYhUic0uHwbLCLHoBaAbfIiUjkTdM7RG9cZkrBwFjLIyRGO0y1s4HNStdLTGXVWDopzIy2zIFXcmrMr5fLm4RgVVLqK86/wRdem7T42sGGqfRStrKqDMTCdFnPTS5yumfbCwzZ05SUzx4ah3yYIBchiq4leoGJ89llzelsrCcvq4rH7dQrzdC8APXOALtOlh/80M5fkQ7ePoYnNgh2WPOsthhaYlMQhVdO1kMKXGDuyeW6Mo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(38070700005)(2906002)(5660300002)(52536014)(55016003)(8936002)(86362001)(38100700002)(8676002)(66899021)(33656002)(122000001)(7696005)(9686003)(6506007)(54906003)(478600001)(71200400001)(186003)(66946007)(66556008)(41300700001)(64756008)(66476007)(76116006)(6916009)(4326008)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REI2SFpFVkdKb2Z5ZjV2c0d3UHhUL3JPbjV0Q3RJZHVtUDFtTVZCTWtDc05Z?=
 =?utf-8?B?S0N6SFFpUSs3eVpIa3F3WmtTYjNHSHFDY2J1RklSTjNDSFNRTVJkVnFwYmZS?=
 =?utf-8?B?bGliRmRqcHcrSlk4Y1g3VzFjSGJ5VWtSZlJtWkp4YnhuTWFMeTVHUmZZWDYy?=
 =?utf-8?B?QUt0aTZxL1N4bDVMb2tlek4yRjJRd1F2K2YwOGJvbUlKMDNaejM4bWFreGlQ?=
 =?utf-8?B?WE5BNWZ2VkxmRm14aWFMcjY3MndlRlBLdkViRiszOVV2K21tTENMbHpFcTNW?=
 =?utf-8?B?N1FkUU9PN1orV25aUk9SZUlXN3d4WUJRak1hRW5zQzNrMkJEVlBRdjJ0Y3FQ?=
 =?utf-8?B?WUN1RjlUcTV4U3NEVXRXeThlTTRoR2wwK3ZYaGpXZjZWSmo3MXBYdXo5Sjlm?=
 =?utf-8?B?YlZjOFJxNmZ6K05jc2YxL2g2MzRQRFNUaFVraWprRmdHYlhBdWVjMjI0TW5y?=
 =?utf-8?B?cHk4cmJpVjc4Sk95VStGbk1aRG5PbFRPWnJIMloyWm10bURqeUNSZjFEbERa?=
 =?utf-8?B?TjVQQUNJOTlKVTlWaGRrTmZFQnVaM1hXSis2OEdCMFRBVGxVekJFMVBDK0VQ?=
 =?utf-8?B?ZGlHYmNIR01YUUpLTUdHTFFNdUpOK3NlME8rV0QyU3RBNnVaR0xnWVorTm5D?=
 =?utf-8?B?NHVPNWtNV0Vqc1VRdXo2SGlla1IwNHNkSGlsbnBaSWJhbk8vUGVEK09GMVl4?=
 =?utf-8?B?a0wvc2k3OWJJWmhRT3NJSzcrUXBOU3NXNGE1VzIxSmdBRmE1dmd2ZkkzU21P?=
 =?utf-8?B?cWxzWmFOUU9HZjZkQXZwZHR6cDZrbjJlcDBHeXRvV1lQR1lNRW9UN0gwSXdo?=
 =?utf-8?B?QU5HRDFJNUV0ZGM0dHFRVmgwL3JteitFbXRVUitpWUF2YlhvVFladm1vMm1P?=
 =?utf-8?B?aWhGVWxTemxjVzROQ0VwNHZBMy9nV1c0bVlkd3ZWSEZ0TXhuNlk4MnRRd0pL?=
 =?utf-8?B?dTBMMGgxL0NGSDdpcUc2UWxVUnZoczljMXZtOFlqbCtkV3F4aEJxd0ZjQ3hq?=
 =?utf-8?B?eDBHNTRONnZDOEJzREFxcC9FcS92dkRwZFFKWUh5eEI5WXBja0FrdHFiMEVz?=
 =?utf-8?B?WVl1R1hldmpSTVVualcyU2QxelpCRWtlcTdKanlMNHlGUDdyNTh1RExabm9h?=
 =?utf-8?B?V0RkT0VnZ0pvemdTVzdITE9ZUHNFMWU2eFZrcnZlbzAyRUttcnhZNzhkMWtH?=
 =?utf-8?B?dkhqNC9GYTg1L2lkcTIrNVFpWlRhNHF5N3V5Q0dMbExKLzMxS0V0MzVtUk15?=
 =?utf-8?B?WW9DajJteFNVZHdkMlY5UUo2MElOUm5ISFVLSHRvRk9pV2h4cnpXRnJTd3Rp?=
 =?utf-8?B?N3NRV2lyUnVJMWFXVi9Gc1pYUENtWWJsbHcwRkxwK1pGcmtyQno1bitEQmlX?=
 =?utf-8?B?UGxFM3dtcHJ6eVJYVlN6WHZ5V25RM280YUZZakh6RzNkS1FEU1JkdUpSZjdo?=
 =?utf-8?B?SUU5REZ0S2IvOWNhYlhFVzJHQlgzWi9Dem9SeDFsWGNGMVJ2a3hobVpzb3Iv?=
 =?utf-8?B?WWsrMkNQRk83T0ZBZis1cUp1Mm04VzNiaFc5bUh1em9URytXdVN4STVDT1pP?=
 =?utf-8?B?VW5nRDFDQ3o1ZnpXNHBJTGFOSkRQeDBaMzB3RCtpNjlQYU5zRWorbEhET2wr?=
 =?utf-8?B?dWsyUE95UEtBcDVWdkRPZ2Zzd0hEZmE1WGNsbGxuQUdVOXZLZjZyZ1NCSG9a?=
 =?utf-8?B?WmF3NCt0clRNV2x5SWRSZ1gyYURJQ1FhT0Q5WklFQmJBdVFZenFLRVpDRVYv?=
 =?utf-8?B?TG9TOUo3NHNDWnpPTW4zZWN6NzUvRnVxNmRTQmJRYjl0amZYOHZEZzk5ZTFv?=
 =?utf-8?B?dXgvUE9RNlc1OHQweWpBQWRaM1MrOXR0RFJzRDB1bHRhSjlUZGlXNDdKd1k4?=
 =?utf-8?B?VDFsdlA4Y1lpZm5LTEZqQ3dadnVvb3k2enl6TUl5eUlxbmRGK24vVit5MzNy?=
 =?utf-8?B?aCtsRmZ2c1JobzFiU1NZOFpIWWEvVURmY1c2MGxKdzNSeHhyYUZtZnpOczlp?=
 =?utf-8?B?d29JSExQNFZ0YmpTY25WMTRHQjF3cUJqV1NQYm80c0RzWGc0eWREOGVSRTlH?=
 =?utf-8?B?dWQzQWoySkxjYWU4WllHODZCVFI5V0pORmVJZTViWGNVZzFoaW5nWWJUeTNX?=
 =?utf-8?B?c21PV2lkOEpxTXVFYzJvYnlkNFhIczVBRTNhRHZYUmMvdnZnYnB6ZndUcU5h?=
 =?utf-8?Q?ojvJNOSxAhlmY2Z+di3Pxlk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735529f3-33c0-4b3e-ab15-08db3b1a8981
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:55:36.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChUDEubatS20ggVGENV+nrKnHMCmaIgBqznhba5GMhBNwbl1UT6v2bFhzt9aBY9DTFy+GH9K83+ZFUigi8HHaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxMiwgMjAyMyAxOjM4IEFNDQoNCj4gPiBNb2Rlcm4gZGV2aWNlIHNheXMg
RkVBRVRVUkVfMSBtdXN0IGJlIG9mZmVyZWQgYW5kIG11c3QgYmUgbmVnb3RpYXRlZCBieQ0KPiBk
cml2ZXIuDQo+ID4gTGVnYWN5IGhhcyBNYWMgYXMgUlcgYXJlYS4gKGh5cGVydmlzb3IgY2FuIGRv
IGl0KS4NCj4gPiBSZXNldCBmbG93IGlzIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgbGVnYWN5IGFu
ZCBtb2Rlcm4uDQo+IA0KPiBKdXN0IHRvIG1ha2Ugc3VyZSB3ZSdyZSBhdCB0aGUgc2FtZSBwYWdl
LiBXZSdyZSB0YWxraW5nIGluIHRoZSBjb250ZXh0IG9mDQo+IG1lZGlhdGlvbi4gV2l0aG91dCBt
ZWRpYXRpb24sIHlvdXIgcHJvcG9zYWwgY2FuJ3Qgd29yay4NCj4NClJpZ2h0Lg0KIA0KPiBTbyBp
biB0aGlzIGNhc2UsIHRoZSBndWVzdCBkcml2ZXIgaXMgbm90IHRhbGtpbmcgd2l0aCB0aGUgZGV2
aWNlIGRpcmVjdGx5LiBRZW11DQo+IG5lZWRzIHRvIHRyYXBzIHdoYXRldmVyIGl0IHdhbnRzIHRv
IGFjaGlldmUgdGhlDQo+IG1lZGlhdGlvbjoNCj4gDQpJIHByZWZlciB0byBhdm9pZCBwaWNraW5n
IHNwZWNpZmljIHN3IGNvbXBvbmVudCBoZXJlLCBidXQgeWVzLiBRRU1VIGNhbiB0cmFwLg0KDQo+
IDEpIEl0J3MgcGVyZmVjdGx5IGZpbmUgdGhhdCBRZW11IG5lZ290aWF0ZWQgVkVSU0lPTl8xIGJ1
dCBwcmVzZW50ZWQgYQ0KPiBtZWRpYXRlZCBsZWdhY3kgZGV2aWNlIHRvIGd1ZXN0cy4NClJpZ2h0
IGJ1dCBpZiBWRVJTSU9OXzEgaXMgbmVnb3RpYXRlZCwgZGV2aWNlIHdpbGwgd29yayBhcyBWXzEg
d2l0aCAxMkIgdmlydGlvX25ldF9oZHIuDQoNCj4gMikgRm9yIE1BQyBhbmQgUmVzZXQsIFFlbXUg
Y2FuIHRyYXAgYW5kIGRvIGFueXRoaW5nIGl0IHdhbnRzLg0KPg0KVGhlIGlkZWEgaXMgbm90IHRv
IHBva2UgaW4gdGhlIGZpZWxkcyBldmVuIHRob3VnaCBzdWNoIHN3IGNhbi4NCk1BQyBpcyBSVyBp
biBsZWdhY3kuDQpNYWMgaWEgUk8gaW4gMS54Lg0KDQpTbyBRRU1VIGNhbm5vdCBtYWtlIFJPIHJl
Z2lzdGVyIGludG8gUlcuDQoNClRoZSBwcm9wb3NlZCBzb2x1dGlvbiBpbiB0aGlzIHNlcmllcyBl
bmFibGVzIGl0IGFuZCBhdm9pZCBwZXIgZmllbGQgc3cgaW50ZXJwcmV0YXRpb24gYW5kIG1lZGlh
dGlvbiBpbiBwYXJzaW5nIHZhbHVlcyBldGMuDQoNCj4gPiBUaGUgUENJIGRldmljZSBleHBvc2Vk
IGlzIHRyYW5zaXRpb25hbCB0byB0aGUgZ3Vlc3QgVk0sIHNvIGl0IGNhbiBkbyBsZWdhY3kgYXMN
Cj4gd2VsbCBhcyBuZXdlciBmZWF0dXJlcy4NCj4gPiBBbmQgaWYgQkFSIDAgaXMgaGFyZCBjb2Rl
ZCwgaXQgbWF5IG5vdCBiZSBhYmxlIHRvIHN1cHBvcnQgZmVhdHVyZXMgdGhhdCBtYXkNCj4gbmVl
ZCBhZGRpdGlvbmFsIEJBUi4NCj4gDQo+IFRoaXMgcGFydCBJIGRvbid0IHVuZGVyc3RhbmQsIHlv
dSBjYW4ganVzdCBwdXQgZXhpc3RpbmcgbW9kZXJuIGNhcGFiaWxpdGllcyBpbg0KPiBCQVIwLCB0
aGVuIGV2ZXJ5dGhpbmcgaXMgZmluZS4NCj4NCk5vdCBzdXJlIEkgZm9sbG93Lg0KTWF5IGJlIGEg
c3RlcCBiYWNrLg0KDQpXaGF0IGlzIHByb3Bvc2VkIGhlcmUsIHRoYXQgDQphLiBsZWdhY3kgcmVn
aXN0ZXJzIGFyZSBlbXVsYXRlZCBhcyBNTUlPIGluIGEgQkFSLg0KYi4gVGhpcyBjYW4gYmUgZWl0
aGVyIGJlIEJBUjAgb3Igc29tZSBvdGhlciBCQVINCg0KWW91ciBxdWVzdGlvbiB3YXMgd2h5IHRo
aXMgZmxleGliaWxpdHk/DQoNClRoZSByZWFzb24gaXM6IA0KYS4gaWYgZGV2aWNlIHByZWZlcnMg
dG8gaW1wbGVtZW50IG9ubHkgdHdvIEJBUnMsIGl0IGNhbiBkbyBzbyBhbmQgaGF2ZSB3aW5kb3cg
Zm9yIHRoaXMgNjArIGNvbmZpZyByZWdpc3RlcnMgaW4gYW4gZXhpc3RpbmcgQkFSLg0KYi4gaWYg
ZGV2aWNlIHByZWZlcnMgdG8gaW1wbGVtZW50IGEgbmV3IEJBUiBkZWRpY2F0ZWQgZm9yIGxlZ2Fj
eSByZWdpc3RlcnMgZW11bGF0aW9uLCBpdCBpcyBmaW5lIHRvby4NCg0KQSBtZWRpYXRpbmcgc3cg
d2lsbCBiZSBhYmxlIHRvIGZvcndhcmQgdGhlbSByZWdhcmRsZXNzLg0KDQo+ID4gUmlnaHQsIGl0
IGRvZXNu4oCZdC4gQnV0IHNwZWMgc2hvdWxkbuKAmXQgd3JpdGUgQkFSMCBpcyBvbmx5IGZvciBs
ZWdhY3kgTU1JTw0KPiBlbXVsYXRpb24sIHRoYXQgd291bGQgcHJldmVudCBCQVIwIHVzYWdlLg0K
PiANCj4gSG93IGNhbiBpdCBiZSBwcmV2ZW50ZWQ/IENhbiB5b3UgZ2l2ZSBtZSBhbiBleGFtcGxl
Pw0KDQpJIG1lYW4gdG8gc2F5LCB0aGF0IHNheSBpZiB3ZSB3cml0ZSBhIHNwZWMgbGlrZSBiZWxv
dywNCg0KQSBkZXZpY2UgZXhwb3NlcyBCQVIgMCBvZiBzaXplIFggYnl0ZXMgZm9yIHN1cHBvcnRp
bmcgbGVnYWN5IGNvbmZpZ3VyYXRpb24gYW5kIGRldmljZSBzcGVjaWZpYyByZWdpc3RlcnMgYXMg
bWVtb3J5IG1hcHBlZCByZWdpb24uDQoNCkFib3ZlIGxpbmUgd2lsbCBwcmV2ZW50IHVzaW5nIEJB
UjAgYmV5b25kIGxlZ2FjeSByZWdpc3RlciBlbXVsYXRpb24uDQoNCg==

