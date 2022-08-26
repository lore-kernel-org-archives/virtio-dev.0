Return-Path: <virtio-dev-return-9841-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9807498656D
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Aug 2022 18:33:07 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 26 Aug 2022 18:33:04 +0000
Message-ID: <PH0PR12MB54817615D702376C33188518DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220825123840.20239-1-gavinl@nvidia.com>
 <20220825123840.20239-3-gavinl@nvidia.com>
 <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
 <PH0PR12MB5481BB5F85A7115A07FBC315DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
 <784140bb-53d1-e00b-f79a-7b95b0c1052f@oracle.com>
In-Reply-To: <784140bb-53d1-e00b-f79a-7b95b0c1052f@oracle.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Si-Wei Liu <si-wei.liu@oracle.com>, Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>
Cc: Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQoNCj4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPg0KPiBTZW50OiBG
cmlkYXksIEF1Z3VzdCAyNiwgMjAyMiAyOjA1IFBNDQo+IA0KDQo+ID4gKwkvKiBJZiB3ZSBjYW4g
cmVjZWl2ZSBBTlkgR1NPIHBhY2tldHMsIHdlIG11c3QgYWxsb2NhdGUgbGFyZ2Ugb25lcy4NCj4g
Ki8NCj4gPiArCWlmIChtdHUgPiBFVEhfREFUQV9MRU4gfHwgZ3Vlc3RfZ3NvKSB7DQo+ID4gKwkJ
dmktPmJpZ19wYWNrZXRzID0gdHJ1ZTsNCj4gPiArCQkvKiBpZiB0aGUgZ3Vlc3Qgb2ZmbG9hZCBp
cyBvZmZlcmVkIGJ5IHRoZSBkZXZpY2UsIHVzZXIgY2FuDQo+IG1vZGlmeQ0KPiA+ICsJCSAqIG9m
ZmxvYWQgY2FwYWJpbGl0eS4gSW4gc3VjaCBwb3N0ZWQgYnVmZmVycyBtYXkgc2hvcnQgZmFsbCBv
Zg0KPiBzaXplLg0KPiA+ICsJCSAqIEhlbmNlIGFsbG9jYXRlIGZvciBtYXggc2l6ZS4NCj4gPiAr
CQkgKi8NCj4gPiArCQlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LA0KPiBWSVJUSU9f
TkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykpDQo+ID4gKwkJCXZpLT5iaWdfcGFja2V0c19zZ19u
dW0gPSBNQVhfU0tCX0ZSQUdTOw0KPiA+PiBNQVhfU0tCX0ZSQUdTIGlzIG5lZWRlZCB3aGVuIGFu
eSBvZiB0aGUgZ3Vlc3RfZ3NvIGNhcGFiaWxpdHkgaXMNCj4gb2ZmZXJlZC4gVGhpcyBpcyBwZXIg
c3BlYyByZWdhcmRsZXNzIGlmDQo+IFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxPQURTIGlz
IG5lZ290aWF0ZWQgb3Igbm90LiBRdW90aW5nIHNwZWM6DQo+ID4NCj4gPg0KPiA+PiBJZiBWSVJU
SU9fTkVUX0ZfTVJHX1JYQlVGIGlzIG5vdCBuZWdvdGlhdGVkOg0KPiA+PiBJZiBWSVJUSU9fTkVU
X0ZfR1VFU1RfVFNPNCwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYgb3INCj4gVklSVElPX05FVF9G
X0dVRVNUX1VGTyBhcmUgbmVnb3RpYXRlZCwgdGhlIGRyaXZlciBTSE9VTEQgcG9wdWxhdGUgdGhl
DQo+IHJlY2VpdmUgcXVldWUocykgd2l0aCBidWZmZXJzIG9mIGF0IGxlYXN0IDY1NTYyIGJ5dGVz
Lg0KPiA+DQo+ID4gU3BlYyByZWNvbW1lbmRhdGlvbiBpcyBnb29kIGhlcmUsIGJ1dCBMaW51eCBk
cml2ZXIga25vd3MgdGhhdCBzdWNoDQo+IG9mZmxvYWQgc2V0dGluZ3MgY2Fubm90IGNoYW5nZSBp
ZiB0aGUgYWJvdmUgZmVhdHVyZSBpcyBub3Qgb2ZmZXJlZC4NCj4gPiBTbyBJIHRoaW5rIHdlIHNo
b3VsZCBhZGQgdGhlIGNvbW1lbnQgYW5kIHJlZmVyZW5jZSB0byB0aGUgY29kZSB0byBoYXZlDQo+
IHRoaXMgb3B0aW1pemF0aW9uLg0KPiANCj4gSSBkb24ndCBnZXQgd2hhdCB5b3UgbWVhbiBieSBv
cHRpbWl6YXRpb24gaGVyZS4gU2F5IGlmDQo+IFZJUlRJT19ORVRfRl9HVUVTVF9UU080IGlzIG5l
Z290aWF0ZWQgd2hpbGUNCj4gVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMgaXMgbm90
IG9mZmVyZWQsIHdoeSB5b3UgY29uc2lkZXIgaXQNCj4gYW4gb3B0aW1pemF0aW9uIHRvIHBvc3Qg
b25seSBNVFUgc2l6ZWQgKHdpdGggcm91bmR1cCB0byBwYWdlKSBidWZmZXJzPw0KPiBXb3VsZG4n
dCBpdCBiZSBhbiBpc3N1ZSBpZiB0aGUgZGV2aWNlIGlzIHBhc3NpbmcgdXAgYWdncmVnYXRlZCBH
U08gcGFja2V0cyBvZg0KPiB1cCB0byA2NEtCPyBOb3RlZCwgR1VFU1RfR1NPIGlzIGltcGxpZWQg
b24gd2hlbiB0aGUgY29ycmVzcG9uZGluZw0KPiBmZWF0dXJlIGJpdCBpcyBuZWdvdGlhdGVkLCBy
ZWdhcmRsZXNzIHRoZSBwcmVzZW5jZSBvZg0KPiBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZM
T0FEUyBiaXQuDQo+IA0KWW91IGFyZSByaWdodC4NCk5FVElGX0ZfR1JPX0hXIHNldHRpbmcgb2Yg
dGhlIG5ldGRldiBpcyBhbHJlYWR5IGd1YXJkZWQgYnkgVklSVElPX05FVF9GX0NUUkxfR1VFU1Rf
T0ZGTE9BRFMgYml0IGNoZWNrLg0KU28sIGl0cyBmaW5lLiBJIG1pc3NlZCB0aGF0IGNvZGUgcHJl
dmlvdXNseS4NCg0KSSBhZ3JlZSB0aGUgY29uZGl0aW9uIGNoZWNrIHNob3VsZCBiZSBzaW1wbGVy
IGxpa2UgYmVsb3cuDQoNCmlmIChndWVzdF9nc28gfHwgbXR1ID4gRVRIX0RBVEFfTEVOKSB7DQoJ
dmktPmJpZ19wYWNrZXRzID0gdHJ1ZTsNCgl2aS0+YmlnX3BhY2tldHNfc2dfbnVtID0gZ3Vlc3Rf
Z3NvID8gTUFYX1NLQl9GUkFHUyA6IERJVl9ST1VORF9VUChtdHUsIFBBR0VfU0laRSk7DQp9DQo=

