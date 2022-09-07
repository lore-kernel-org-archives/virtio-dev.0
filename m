Return-Path: <virtio-dev-return-9929-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D7B7986534
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 22:11:51 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 7 Sep 2022 22:11:48 +0000
Message-ID: <PH0PR12MB548125D85533125828CE8454DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815E541D435DDC9339CA02DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8d80bb05-2d01-9046-6642-3f74b59cc830@oracle.com>
In-Reply-To: <8d80bb05-2d01-9046-6642-3f74b59cc830@oracle.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] RE: [PATCH v5 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBTZXB0ZW1iZXIgNywgMjAyMiA1OjQwIFBNDQo+IA0KPiANCj4gT24gOS83LzIwMjIg
MTI6NTEgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gQW5kIEknZCBsaWtlIGNvbW1pdCBs
b2cgdG8gaW5jbHVkZSByZXN1bHRzIG9mIHBlcmYgdGVzdGluZw0KPiA+PiAtIHdpdGggaW5kaXJl
Y3QgZmVhdHVyZSBvbg0KPiA+IFdoaWNoIGRldmljZSBkbyB5b3Ugc3VnZ2VzdCB1c2luZyBmb3Ig
dGhpcyB0ZXN0Pw0KPiA+DQo+IFlvdSBtYXkgdXNlIHNvZnR3YXJlIHZob3N0LW5ldCBiYWNrZW5k
IHdpdGggYW5kIHdpdGhvdXQgZml4IHRvIGNvbXBhcmUuDQo+IFNpbmNlIHRoaXMgZHJpdmVyIGZp
eCBlZmZlY3RpdmVseSBsb3dlcnMgZG93biB0aGUgYnVmZmVyIHNpemUgZm9yIHRoZQ0KPiBpbmRp
cmVjdD1vbiBjYXNlIGFzIHdlbGwsIA0KRG8geW91IGhhdmUgc2FtcGxlIGV4YW1wbGUgZm9yIHRo
aXM/DQoNCj4gaXQncyBhIG5hdHVyYWwgcmVxdWVzdCB0byBtYWtlIHN1cmUgbm8gcGVyZg0KPiBk
ZWdyYWRhdGlvbiBpcyBzZWVuIG9uIGRldmljZXMgd2l0aCBpbmRpcmVjdCBkZXNjcmlwdG9yIGVu
YWJsZWQuIEkgZG9uJ3QNCj4gZXhwZWN0IGRlZ3JhZGF0aW9uIHRob3VnaCBhbmQgdGhpbmsgdGhp
cyBwYXRjaCBzaG91bGQgaW1wcm92ZSBlZmZpY2llbmN5DQo+IHdpdGggbGVzcyBtZW1vcnkgZm9v
dCBwcmludC4NCj4gDQpBbnkgc3BlY2lmaWMgcmVhc29uIHRvIGRpc2NvdW50IHRlc3QgZm9yIHRo
ZSBwYWNrZWQgdnEgaGVyZSBiZWNhdXNlIHRoZSBjaGFuZ2UgYXBwbGllcyB0byBwYWNrZWQgdnEg
dG9vPw0KDQpJdCBpcyBjb3VudGVyIGludHVpdGl2ZSB0byBzZWUgZGVncmFkYXRpb24gd2l0aCBz
bWFsbGVyIHNpemUgYnVmZmVycy4NCkJ1dCBzdXJlLCBjb2RlIHJldmlld3MgY2FuIG1pc3MgdGhp
bmdzIHRoYXQgY2FuIGJyaW5nIHJlZ3Jlc3Npb24gZm9yIHdoaWNoIGl0IHNob3VsZCBiZSB0ZXN0
ZWQuDQoNCkkgYW0gbm90IGFnYWluc3QgdGhlIHRlc3QgaXRzZWxmLiBJdCBpcyBnb29kIHRoaW5n
IHRvIGRvIG1vcmUgdGVzdCBjb3ZlcmFnZS4NCldoYXQgaXMgcHV6emxpbmcgbWUgaXMsIEkgZmFp
bCB0byBzZWUgdGVzdCByZXN1bHRzIG5vdCBhdmFpbGFibGUgaW4gcHJldmlvdXMgY29tbWl0cyBh
bmQgY292ZXIgbGV0dGVycywgd2hpY2ggaXMgbWFraW5nIHRoaXMgcGF0Y2ggc3BlY2lhbCBmb3Ig
dGVzdCBjb3ZlcmFnZS4NCk9yIGEgbmV3IHRyZW5kIGJlZ2lucyB3aXRoIHRoaXMgc3BlY2lmaWMg
cGF0Y2ggb253YXJkcz8NCg0KRm9yIGV4YW1wbGUsIEkgZG9u4oCZdCBzZWUgYSB0ZXN0IHJlc3Vs
dHMgaW4gY29tbWl0IFsxXSwgWzJdLCBbM10gdG8gaW5kaWNhdGUgdGhhdCBubyBkZWdyYWRhdGlv
biBpcyBzZWVuIHdoaWNoIGhlYXZpbHkgdG91Y2hlcyB0aGUgbG9jayBpbiBjb3JlIGRhdGEgcGF0
aC4NCg0KU28gd2FudCB0byBrbm93IHRlc3QgcmVwb3J0aW5nIGd1aWRlbGluZXMgaW4gdGhlIGNv
bW1pdCBsb2dzIGZvciB0aGlzIGFuZCBvdGhlciBwYXRjaGVzLg0KDQpbMV0gY29tbWl0IDVhMmY5
NjZkMGYNClsyXSBjb21taXQgYTc3NjZlZjE4YjMzIA0KWzNdIGNvbW1pdCAyMmJjNjNjNThlODc2
DQo=

