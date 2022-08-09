Return-Path: <virtio-dev-return-9731-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2DC0986350
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 21:49:09 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 9 Aug 2022 21:49:03 +0000
Message-ID: <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <20220809173542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809173542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBBdWd1c3QgOSwgMjAyMiA1OjM4IFBNDQoNClsuLl0NCj4gPiA+IEkgdGhpbmsgdmlydGlv
LW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBhbmQgTVJVLCBpbg0KPiA+ID4g
d2hpY2ggY2FzZSB0aGUgcmVjZWl2ZSBidWZmZXIgd2lsbCBiZSByZWR1Y2VkIHRvIGZpdCB0aGUg
MTUwMEINCj4gPiA+IHBheWxvYWQgc2l6ZSB3aGVuIG10dSBpcyBsb3dlcmVkIGRvd24gdG8gMTUw
MCBmcm9tIDkwMDAuDQo+ID4gSG93PyBEcml2ZXIgcmVkdWNlZCB0aGUgbVh1IHRvIDE1MDAsIHNh
eSBpdCBpcyBpbXByb3ZlZCB0byBwb3N0IGJ1ZmZlcnMgb2YNCj4gMTUwMCBieXRlcy4NCj4gPg0K
PiA+IERldmljZSBkb2Vzbid0IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNw
YWNlIGlzIFJPIGZpZWxkLg0KPiA+IERldmljZSBrZWVwIGRyb3BwaW5nIDlLIHBhY2tldHMgYmVj
YXVzZSBidWZmZXJzIHBvc3RlZCBhcmUgMTUwMCBieXRlcy4NCj4gPiBUaGlzIGlzIGJlY2F1c2Ug
ZGV2aWNlIGZvbGxvd3MgdGhlIHNwZWMgIiBUaGUgZGV2aWNlIE1VU1QgTk9UIHBhc3MNCj4gcmVj
ZWl2ZWQgcGFja2V0cyB0aGF0IGV4Y2VlZCBtdHUiLg0KPiANCj4gDQo+IFRoZSAibXR1IiBoZXJl
IGlzIHRoZSBkZXZpY2UgY29uZmlnIGZpZWxkLCB3aGljaCBpcw0KPiANCj4gICAgICAgICAvKiBE
ZWZhdWx0IG1heGltdW0gdHJhbnNtaXQgdW5pdCBhZHZpY2UgKi8NCj4gDQoNCkl0IGlzIHRoZSBm
aWVsZCBmcm9tIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZy5tdHUuIHJpZ2h0Pw0KVGhpcyBpcyBS
TyBmaWVsZCBmb3IgZHJpdmVyLg0KDQo+IHRoZXJlIGlzIG5vIGd1YXJhbnRlZSBkZXZpY2Ugd2ls
bCBub3QgZ2V0IGEgYmlnZ2VyIHBhY2tldC4NClJpZ2h0LiBUaGF0IGlzIHdoYXQgSSBhbHNvIGhp
bnRlZC4NCkhlbmNlLCBhbGxvY2F0aW5nIGJ1ZmZlcnMgd29ydGggdXB0byBtdHUgaXMgc2FmZXIu
DQpXaGVuIHVzZXIgb3ZlcnJpZGVzIGl0LCBkcml2ZXIgY2FuIGJlIGZ1cnRoZXIgb3B0aW1pemVk
IHRvIGhvbm9yIHN1Y2ggbmV3IHZhbHVlIG9uIHJ4IGJ1ZmZlciBwb3N0aW5nLg0KDQo+IEFuZCB0
aGVyZSBpcyBubyBndWFyYW50ZWUgc3VjaCBhIHBhY2tldCB3aWxsIGJlIGRyb3BwZWQgYXMgb3Bw
b3NlZCB0bw0KPiB3ZWRnaW5nIHRoZSBkZXZpY2UgaWYgdXNlcnNwYWNlIGluc2lzdHMgb24gYWRk
aW5nIHNtYWxsZXIgYnVmZmVycy4NCj4NCklmIHVzZXIgc3BhY2UgaW5zaXN0cyBvbiBzbWFsbCBi
dWZmZXJzLCBzbyBiZSBpdC4gSXQgb25seSB3b3JrcyB3aGVuIHVzZXIgZXhhY3RseSBrbm93IHdo
YXQgdXNlciBpcyBkb2luZyBpbiB0aGUgd2hvbGUgbmV0d29yay4NCldoZW4gdXNlciBwcmVmZXJz
IHRvIG92ZXJyaWRlIHRoZSBkZXZpY2UgUk8gZmllbGQsIGRldmljZSBpcyBpbiB0aGUgZGFyayBh
bmQgdGhpbmdzIHdvcmsgb24gYmVzdCBlZmZvcnQgYmFzaXMuDQpUaGlzIG11c3QgYmUgYSByZWFz
b25hYmx5IGFkdmFuY2UgdXNlciB3aG8gaGFzIGdvb2Qga25vd2xlZGdlIG9mIGl0cyBuZXR3b3Jr
IHRvcG9sb2d5IGV0Yy4NCg0KRm9yIHN1Y2ggY2FzZSwgbWF5IGJlIHllcywgZHJpdmVyIHNob3Vs
ZCBiZSBmdXJ0aGVyIG9wdGltaXplZC4NCg0K

