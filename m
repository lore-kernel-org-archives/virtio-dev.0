Return-Path: <virtio-dev-return-9722-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42FFF986332
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 19:18:34 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 9 Aug 2022 19:18:30 +0000
Message-ID: <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
In-Reply-To: <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
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
YXksIEF1Z3VzdCA5LCAyMDIyIDM6MDkgUE0NCg0KPiA+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDI6
MzkgUE0gQ3VycmVudGx5IGl0IGlzIG5vdC4gTm90IGENCj4gPj4gc2luZ2xlIHBhdGNoIG5vciB0
aGlzIHBhdGNoLCBidXQgdGhlIGNvbnRleHQgZm9yIHRoZSBldmVudHVhbCBnb2FsIGlzDQo+ID4+
IHRvIGFsbG93IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsgd2hlbiBndWVzdCB1c2VycyBpbnRlbnRp
b25hbGx5IGxvd2VyDQo+ID4+IGRvd24gTVRVIHRvIDE1MDAuDQo+ID4gV2hpY2ggYXBwbGljYXRp
b24gYmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0byAxNTAwDQo+
IHRvIHNlbmQgcGFja2V0cyBidXQgd2FudCB0byByZWNlaXZlIDlLIHBhY2tldHM/DQoNCkJlbG93
IGRldGFpbHMgZG9lc27igJl0IGFuc3dlciB0aGUgcXVlc3Rpb24gb2YgYXN5bW1ldHJ5LiA6KQ0K
DQo+IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBh
bmQgTVJVLCBpbiB3aGljaCBjYXNlDQo+IHRoZSByZWNlaXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVj
ZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUgd2hlbiBtdHUgaXMNCj4gbG93ZXJlZCBk
b3duIHRvIDE1MDAgZnJvbSA5MDAwLiANCkhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1YdSB0byAx
NTAwLCBzYXkgaXQgaXMgaW1wcm92ZWQgdG8gcG9zdCBidWZmZXJzIG9mIDE1MDAgYnl0ZXMuDQoN
CkRldmljZSBkb2Vzbid0IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNwYWNl
IGlzIFJPIGZpZWxkLg0KRGV2aWNlIGtlZXAgZHJvcHBpbmcgOUsgcGFja2V0cyBiZWNhdXNlIGJ1
ZmZlcnMgcG9zdGVkIGFyZSAxNTAwIGJ5dGVzLg0KVGhpcyBpcyBiZWNhdXNlIGRldmljZSBmb2xs
b3dzIHRoZSBzcGVjICIgVGhlIGRldmljZSBNVVNUIE5PVCBwYXNzIHJlY2VpdmVkIHBhY2tldHMg
dGhhdCBleGNlZWQgbXR1Ii4NCg0KU28sIEkgYW0gbG9zdCB3aGF0IHZpcnRpbyBuZXQgZGV2aWNl
IHVzZXIgYXBwbGljYXRpb24gaXMgdHJ5aW5nIHRvIGFjaGlldmUgYnkgc2VuZGluZyBzbWFsbGVy
IHBhY2tldHMgYW5kIGRyb3BwaW5nIGFsbCByZWNlaXZlIHBhY2tldHMuDQooaXQgZG9lc27igJl0
IGhhdmUgYW55IHJlbGF0aW9uIHRvIG1lcmdlYWJsZSBvciBvdGhlcndpc2UpLg0K

