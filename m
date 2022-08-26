Return-Path: <virtio-dev-return-9839-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FD3698656D
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Aug 2022 16:41:18 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 26 Aug 2022 16:41:16 +0000
Message-ID: <PH0PR12MB5481BB5F85A7115A07FBC315DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220825123840.20239-1-gavinl@nvidia.com>
 <20220825123840.20239-3-gavinl@nvidia.com>
 <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
In-Reply-To: <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Si-Wei Liu <si-wei.liu@oracle.com>, Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>
Cc: Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

CQ0KDQpGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IA0KU2VudDogRnJp
ZGF5LCBBdWd1c3QgMjYsIDIwMjIgNDo1MiBBTQ0KDQo+IFNvcnJ5IGZvciB0aGUgZGVsYXkuIERp
ZG4ndCBub3RpY2UgYXMgdGhpcyB0aHJlYWQgd2FzIG5vdCBhZGRyZXNzZWQgdG8gbXkgd29yayBl
bWFpbC4gUGxlYXNlIGNvcHkgdG8gbXkgd29yayBlbWFpbCBpZiBpdCBuZWVkcyBteSBpbW1lZGlh
dGUgYXR0ZW50aW9uLg0KDQpDYW4geW91IHBsZWFzZSBzZXR1cCB5b3VyIG1haWwgY2xpZW50IHRv
IHBvc3QgcGxhaW4gdGV4dCBtYWlsIGFzIHJlcXVpcmVkIGJ5IG1haWxpbmcgbGlzdC4NCkNvbnZl
cnNhdGlvbiB3aXRob3V0IGl0IGlzIGNsb3NlIHRvIGltcG9zc2libGUgdG8gdHJhY2suDQorCS8q
IElmIHdlIGNhbiByZWNlaXZlIEFOWSBHU08gcGFja2V0cywgd2UgbXVzdCBhbGxvY2F0ZSBsYXJn
ZSBvbmVzLiAqLw0KKwlpZiAobXR1ID4gRVRIX0RBVEFfTEVOIHx8IGd1ZXN0X2dzbykgew0KKwkJ
dmktPmJpZ19wYWNrZXRzID0gdHJ1ZTsNCisJCS8qIGlmIHRoZSBndWVzdCBvZmZsb2FkIGlzIG9m
ZmVyZWQgYnkgdGhlIGRldmljZSwgdXNlciBjYW4gbW9kaWZ5DQorCQkgKiBvZmZsb2FkIGNhcGFi
aWxpdHkuIEluIHN1Y2ggcG9zdGVkIGJ1ZmZlcnMgbWF5IHNob3J0IGZhbGwgb2Ygc2l6ZS4NCisJ
CSAqIEhlbmNlIGFsbG9jYXRlIGZvciBtYXggc2l6ZS4NCisJCSAqLw0KKwkJaWYgKHZpcnRpb19o
YXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMpKQ0K
KwkJCXZpLT5iaWdfcGFja2V0c19zZ19udW0gPSBNQVhfU0tCX0ZSQUdTOw0KPiBNQVhfU0tCX0ZS
QUdTIGlzIG5lZWRlZCB3aGVuIGFueSBvZiB0aGUgZ3Vlc3RfZ3NvIGNhcGFiaWxpdHkgaXMgb2Zm
ZXJlZC4gVGhpcyBpcyBwZXIgc3BlYyByZWdhcmRsZXNzIGlmIFZJUlRJT19ORVRfRl9DVFJMX0dV
RVNUX09GRkxPQURTIGlzIG5lZ290aWF0ZWQgb3Igbm90LiBRdW90aW5nIHNwZWM6DQoNCg0KPiBJ
ZiBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGIGlzIG5vdCBuZWdvdGlhdGVkOiANCj4gSWYgVklSVElP
X05FVF9GX0dVRVNUX1RTTzQsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082IG9yIFZJUlRJT19ORVRf
Rl9HVUVTVF9VRk8gYXJlIG5lZ290aWF0ZWQsIHRoZSBkcml2ZXIgU0hPVUxEIHBvcHVsYXRlIHRo
ZSByZWNlaXZlIHF1ZXVlKHMpIHdpdGggYnVmZmVycyBvZiBhdCBsZWFzdCA2NTU2MiBieXRlcy4N
Cg0KU3BlYyByZWNvbW1lbmRhdGlvbiBpcyBnb29kIGhlcmUsIGJ1dCBMaW51eCBkcml2ZXIga25v
d3MgdGhhdCBzdWNoIG9mZmxvYWQgc2V0dGluZ3MgY2Fubm90IGNoYW5nZSBpZiB0aGUgYWJvdmUg
ZmVhdHVyZSBpcyBub3Qgb2ZmZXJlZC4NClNvIEkgdGhpbmsgd2Ugc2hvdWxkIGFkZCB0aGUgY29t
bWVudCBhbmQgcmVmZXJlbmNlIHRvIHRoZSBjb2RlIHRvIGhhdmUgdGhpcyBvcHRpbWl6YXRpb24u
DQo=

