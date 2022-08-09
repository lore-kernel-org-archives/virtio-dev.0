Return-Path: <virtio-dev-return-9720-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B339986332
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 18:42:26 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 9 Aug 2022 18:42:22 +0000
Message-ID: <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
In-Reply-To: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
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
YXksIEF1Z3VzdCA5LCAyMDIyIDI6MzkgUE0NCg0KPiBDdXJyZW50bHkgaXQgaXMgbm90LiBOb3Qg
YSBzaW5nbGUgcGF0Y2ggbm9yIHRoaXMgcGF0Y2gsIGJ1dCB0aGUgY29udGV4dCBmb3IgdGhlDQo+
IGV2ZW50dWFsIGdvYWwgaXMgdG8gYWxsb3cgWERQIG9uIGEgTVRVPTkwMDAgbGluayB3aGVuIGd1
ZXN0IHVzZXJzDQo+IGludGVudGlvbmFsbHkgbG93ZXIgZG93biBNVFUgdG8gMTUwMC4NCg0KV2hp
Y2ggYXBwbGljYXRpb24gYmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10
dSB0byAxNTAwIHRvIHNlbmQgcGFja2V0cyBidXQgd2FudCB0byByZWNlaXZlIDlLIHBhY2tldHM/
DQo=

