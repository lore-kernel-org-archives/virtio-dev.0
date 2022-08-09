Return-Path: <virtio-dev-return-9726-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86B6D98633A
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 21:13:47 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 9 Aug 2022 21:13:42 +0000
Message-ID: <PH0PR12MB5481B4552000CF20B0F73B4BDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
In-Reply-To: <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>
Cc: mst <mst@redhat.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCA5LCAyMDIyIDQ6MzMgUE0NCj4gDQo+IE9uIDgvOS8yMDIyIDEyOjE4IFBNLCBQ
YXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIgMzowOSBQTQ0KPiA+
Pj4+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4NCj4gPj4+PiBTZW50
OiBUdWVzZGF5LCBBdWd1c3QgOSwgMjAyMiAyOjM5IFBNIEN1cnJlbnRseSBpdCBpcyBub3QuIE5v
dCBhDQo+ID4+Pj4gc2luZ2xlIHBhdGNoIG5vciB0aGlzIHBhdGNoLCBidXQgdGhlIGNvbnRleHQg
Zm9yIHRoZSBldmVudHVhbCBnb2FsDQo+ID4+Pj4gaXMgdG8gYWxsb3cgWERQIG9uIGEgTVRVPTkw
MDAgbGluayB3aGVuIGd1ZXN0IHVzZXJzIGludGVudGlvbmFsbHkNCj4gPj4+PiBsb3dlciBkb3du
IE1UVSB0byAxNTAwLg0KPiA+Pj4gV2hpY2ggYXBwbGljYXRpb24gYmVuZWZpdCBieSBoYXZpbmcg
YXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0bw0KPiA+Pj4gMTUwMA0KPiA+PiB0byBzZW5kIHBh
Y2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2ZSA5SyBwYWNrZXRzPw0KPiA+IEJlbG93IGRldGFpbHMg
ZG9lc27igJl0IGFuc3dlciB0aGUgcXVlc3Rpb24gb2YgYXN5bW1ldHJ5LiA6KQ0KPiA+DQo+ID4+
IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBhbmQg
TVJVLCBpbiB3aGljaA0KPiA+PiBjYXNlIHRoZSByZWNlaXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVj
ZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUNCj4gPj4gd2hlbiBtdHUgaXMgbG93ZXJl
ZCBkb3duIHRvIDE1MDAgZnJvbSA5MDAwLg0KPiA+IEhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1Y
dSB0byAxNTAwLCBzYXkgaXQgaXMgaW1wcm92ZWQgdG8gcG9zdCBidWZmZXJzIG9mDQo+IDE1MDAg
Ynl0ZXMuDQo+IEZvciBiaWdfcGFja2V0IHBhdGgsIHllcywgd2UgbmVlZCBpbXByb3ZlbWVudDsg
Zm9yIG1lcmdlYWJsZSwgaXQncw0KPiBhZGFwdGFibGUgdG8gYW55IGluY29taW5nIHBhY2tldCBz
aXplIHNvIDE1MDAgaXMgd2hhdCBpdCBpcyB0b2RheS4NCj4gPg0KPiA+IERldmljZSBkb2Vzbid0
IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNwYWNlIGlzIFJPIGZpZWxkLg0K
PiA+IERldmljZSBrZWVwIGRyb3BwaW5nIDlLIHBhY2tldHMgYmVjYXVzZSBidWZmZXJzIHBvc3Rl
ZCBhcmUgMTUwMCBieXRlcy4NCj4gPiBUaGlzIGlzIGJlY2F1c2UgZGV2aWNlIGZvbGxvd3MgdGhl
IHNwZWMgIiBUaGUgZGV2aWNlIE1VU1QgTk9UIHBhc3MNCj4gcmVjZWl2ZWQgcGFja2V0cyB0aGF0
IGV4Y2VlZCBtdHUiLg0KPiBSaWdodCwgdGhhdCdzIHdoYXQgaXQgaGFwcGVucyB0b2RheSBvbiBk
ZXZpY2Ugc2lkZSAoaS5lLiB2aG9zdC1uZXQsIGJ0dw0KPiBtbHg1IHZkcGEgZGV2aWNlIHNlZW1z
IHRvIGhhdmUgYSBidWcgbm90IHByby1hY3RpdmVseSBkcm9wcGluZyBwYWNrZXRzIHRoYXQNCj4g
ZXhjZWVkIHRoZSBNVFUgc2l6ZSwgY2F1c2luZyBndWVzdCBwYW5pYyBpbiBzbWFsbCBwYWNrZXQg
cGF0aCkuDQo+ID4NCj4gPiBTbywgSSBhbSBsb3N0IHdoYXQgdmlydGlvIG5ldCBkZXZpY2UgdXNl
ciBhcHBsaWNhdGlvbiBpcyB0cnlpbmcgdG8gYWNoaWV2ZSBieQ0KPiBzZW5kaW5nIHNtYWxsZXIg
cGFja2V0cyBhbmQgZHJvcHBpbmcgYWxsIHJlY2VpdmUgcGFja2V0cy4NCj4gPiAoaXQgZG9lc27i
gJl0IGhhdmUgYW55IHJlbGF0aW9uIHRvIG1lcmdlYWJsZSBvciBvdGhlcndpc2UpLg0KPiANCj4g
VXN1YWxseSwgdGhlIHVzZSBjYXNlIEknbSBhd2FyZSBvZiB3b3VsZCBzZXQgdGhlIHBlZXIncyBN
VFUgdG8gMTUwMCAoZS5nLiBvbg0KPiBhIHZpcnR1YWwgbmV0d29yayBhcHBsaWFuY2UpLCBvciBp
dCB3b3VsZCByZWx5IG9uIHBhdGggbXR1IGRpc2NvdmVyeSB0byBhdm9pZA0KPiBwYWNrZXQgZHJv
cCBhY3Jvc3MgbGlua3MuDQpPay4gU29tZWhvdyB0aGUgYXBwbGljYXRpb24ga25vd3MgdGhlIG10
dSB0byBzZXQgb24gKGFsbCkgcGVlcihzKSBhbmQgaG9wZSBmb3IgdGhlIGJlc3QuDQpVbmRlcnN0
b29kLg0K

