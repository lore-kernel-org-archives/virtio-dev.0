Return-Path: virtio-dev-return-6171-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1C6C985E44
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Sep 2019 03:22:06 +0000 (UTC)
From: "Huang, Yang" <yang.huang@intel.com>
Date: Thu, 26 Sep 2019 03:18:22 +0000
Message-ID: <0B92A36466FABC4D99BAF0BDB1FA8BBC41591202@shsmsx102.ccr.corp.intel.com>
References: <1569296893-26006-1-git-send-email-yang.huang@intel.com>
 <1569296893-26006-2-git-send-email-yang.huang@intel.com>
 <20190924073457-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC41590D15@shsmsx102.ccr.corp.intel.com>
 <20190925055102-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190925055102-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v5] Add virtio rpmb device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>, "Fang, Peter" <peter.fang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

PiA+ID4gSSBoYXZlIHRyb3VibGUganVzdGlmeWluZyBsYXlvdXQgb3V0IG1vcmUgdGhhbiAkMzAw
IGZvciB0aGlzLg0KPiA+ID4gRG8gd2UgbmVlZCB0aGUgbGF0ZXN0IHZlcnNpb24/IEVhcmxpZXIg
b25lcyBhcmUgZnJlZS4NCj4gPiA+IEUuZy4gZm9yIGVNTUM6DQo+ID4gPiBodHRwOi8vd3d3Lmpl
ZGVjLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL2RvY3MvSkVTRDg0LUI1MS5wZGYNCj4gPiA+DQo+
ID4gPiBBbmQgZm9yIFVGUzoNCj4gPiA+IGh0dHBzOi8vd3d3LmplZGVjLm9yZy9zaXRlcy9kZWZh
dWx0L2ZpbGVzL2RvY3MvSkVTRDIyMEMucGRmDQo+ID4NCj4gPg0KPiA+IFVGUyAyLjEsIGVNTUMg
NC41MSwgNS4wIGFyZSBhbGwgT0suDQo+ID4gVGhlIGxhdGVzdCB2ZXJzaW9uIGhhcyBwdWJsaXNo
ZWQgZm9yIDMrIHllYXJzLg0KPiA+IFJlZ2lzdGVyIEpFREVDIGFuZCB0aGVuIGZyZWUgdG8gZG93
bmxvYWQ6DQo+ID4gaHR0cHM6Ly93d3cuamVkZWMub3JnL3VzZXIvcmVnaXN0ZXINCj4gPiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgeW91IHN0aWxsIGNhbm5vdCBkb3dubG9hZCB0aGVtLiBUaGFua3Mu
DQo+IA0KPiBTbyBlTU1DIDUuMSByZXZpc2lvbiBKRVNEODQtQjUxQSBhdA0KPiBodHRwczovL3d3
dy5qZWRlYy5vcmcvc3RhbmRhcmRzLWRvY3VtZW50cy9kb2NzL2plc2Q4NC1iNTENCj4gZnJvbSBK
YW4gMjAxOSBpcyBub3QgZnJlZWx5IGF2YWlsYWJsZS4NCj4gDQo+IEFuIGVhcmxpZXIgdmVyc2lv
biBKRVNEODQtQjUxIGZyb20gRmVicnVhcnkgMjAxNSBhdA0KPiBodHRwOi8vd3d3LmplZGVjLm9y
Zy9zaXRlcy9kZWZhdWx0L2ZpbGVzL2RvY3MvSkVTRDg0LUI1MS5wZGYNCj4gaXMgZnJlZWx5IGF2
YWlsYWJsZS4NCj4gDQo+IEhvdyBhYm91dCB3ZSBkZWNpZGUgb24gb25lIHNwZWMgdmVyc2lvbiBh
bmQgcmVmZXIgdG8gdGhhdD8NCj4gRS5nLiBqdXN0IFVGUyBvciBqdXN0IGVNTUM/DQoNClN1cmUu
ICBJIHdpbGwga2VlcCBlTU1DIGFzIHJlZmVyZW5jZS4NClRoZSByZXZpc2lvbiBvZiAyMDE1IGlz
IGZpbmUgZW5vdWdoOg0KaHR0cDovL3d3dy5qZWRlYy5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9k
b2NzL0pFU0Q4NC1CNTEucGRmDQoNCg0KKC4uKQ0KDQo+IGlmIHlvdSBwdXQgZXZlcnl0aGluZyBp
biBhIG5vcm1hdGl2ZSBzZWN0aW9uIHRoZW4geW91IGFyZSBub3Qgd3JpdGluZyBlbm91Z2gNCj4g
cHJvc2UuIFBscyB0YWtlIGEgbG9vayBhdCBob3cgb2xkZXIgZGV2aWNlcyBzdWNoIGFzIHRoZSBu
ZXR3b3JrIGRldmljZSBhcmUNCj4gZG9jdW1lbnRlZC4gWW91IHdyaXRlIG91dCBnZW5lcmFsIGRl
c2NyaXB0aW9uIGluIGEgbm9uIG5vcm1hdGl2ZSBzZWN0aW9uLCB0aGVuDQo+IGEgc2hvcnQgbGlz
dCBvZiByZXF1aXJlbWVudHMgaW4gdGhlIG5vcm1hdGl2ZSBvbmUuDQoNCk9LLiBJIHdpbGwgcmVm
ZXIgdG8gaXQuDQpUaGFua3MuDQoNCg0KDQo=

