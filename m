Return-Path: virtio-dev-return-3647-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 64F495818DC6
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Mar 2018 08:35:38 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 26 Mar 2018 15:35:34 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739486FFD@shsmsx102.ccr.corp.intel.com>
References: <5AAE4124.5010602@intel.com>
 <20180319062023-mutt-send-email-mst@kernel.org> <5AAF7C72.5070403@intel.com>
 <20180320004900-mutt-send-email-mst@kernel.org> <5AB06EE9.1030306@intel.com>
 <20180320045134-mutt-send-email-mst@kernel.org> <5AB07D7F.90205@intel.com>
 <20180320051840-mutt-send-email-mst@kernel.org>
 <20180326110904.GI19266@redhat.com>
 <286AC319A985734F985F78AFA26841F739485EE3@shsmsx102.ccr.corp.intel.com>
 <20180326150403.GN19266@redhat.com>
In-Reply-To: <20180326150403.GN19266@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [Qemu-devel] [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "quintela@redhat.com" <quintela@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

T24gTW9uZGF5LCBNYXJjaCAyNiwgMjAxOCAxMTowNCBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4gT24gTW9uLCBNYXIgMjYsIDIwMTggYXQgMDI6NTQ6NDVQTSArMDAwMCwgV2FuZywg
V2VpIFcgd3JvdGU6DQo+ID4gT24gTW9uZGF5LCBNYXJjaCAyNiwgMjAxOCA3OjA5IFBNLCBEYW5p
ZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+ID4NCj4gPiA+IEFzIGZhciBhcyBsaWJ2aXJ0IGlz
IGNvbmNlcm5lZCB0aGVyZSBhcmUgdGhyZWUgc2V0cyBvZiB0aHJlYWRzIGl0DQo+ID4gPiBwcm92
aWRlcyBjb250cm9sIG92ZXINCj4gPiA+DQo+ID4gPiAgLSB2Q1BVcyAtIGVhY2ggVkNQVSBpbiBL
Vk0gaGFzIGEgdGhyZWFkLiBMaWJ2aXJ0IHByb3ZpZGVzIHBlci10aHJlYWQNCj4gPiA+ICAgIHR1
bmFibGUgY29udHJvbA0KPiA+ID4NCj4gPiA+ICAtIElPVGhyZWFkcyAtIGVhY2ggbmFtZWQgSS9P
IHRocmVhZCBjYW4gYmUgYXNzb2NpYXRlZCB3aXRoIG9uZSBvciBtb3JlDQo+ID4gPiAgICBkZXZp
Y2VzLiBMaWJ2aXJ0IHByb3ZpZGVzIHBlci10aHJlYWQgdHVuYWJsZSBjb250cm9sLg0KPiA+ID4N
Cj4gPiA+ICAtIEVtdWxhdG9yIC0gYW55IG90aGVyIFFFTVUgdGhyZWFkIHdoaWNoIGlzbid0IGFu
IHZDUFUgdGhyZWFkIG9yIElPDQo+IHRocmVhZA0KPiA+ID4gICAgZ2V0cyBjYWxsZWQgYW4gZW11
bGF0b3IgdGhyZWFkIGJ5IGxpYnZpcnQuIFRoZXJlIGlzIG5vLXBlciB0aHJlYWQNCj4gPiA+ICAg
IHR1bmFibGUgY29udHJvbCAtIHdlIGNhbiBzZXQgdHVuYWJsZXMgZm9yIGVudGlyZSBzZXQgb2Yg
ZW11bGF0b3IgdGhyZWFkcw0KPiA+ID4gICAgYXQgb25jZS4NCj4gPiA+DQo+ID4NCj4gPg0KPiA+
IEhpIERhbmllbCwNCj4gPiBUaGFua3MgZm9yIHNoYXJpbmcgdGhlIGRldGFpbHMsIHRoZXkgYXJl
IHZlcnkgaGVscGZ1bC4gSSBzdGlsbCBoYXZlIGEgcXVlc3Rpb246DQo+ID4NCj4gPiBUaGVyZSBp
cyBubyBmdW5kYW1lbnRhbCBkaWZmZXJlbmNlIGJldHdlZW4gaW90aHJlYWQgYW5kIG91cg0KPiA+
IG9wdGltaXphdGlvbiB0aHJlYWQgKGl0IGlzIHNpbWlsYXIgdG8gdGhlIG1pZ3JhdGlvbiB0aHJl
YWQsIHdoaWNoIGlzDQo+ID4gY3JlYXRlZCB3aGVuIG1pZ3JhdGlvbiBiZWdpbnMgYW5kIHRlcm1p
bmF0ZWQgd2hlbiBtaWdyYXRpb24gaXMgZG9uZSkgLQ0KPiA+IGJvdGggb2YgdGhlbSBhcmUgcHRo
cmVhZHMgYW5kIGVhY2ggaGFzIGEgbmFtZS4gQ291bGQgd2UgYWxzbyBhZGQgdGhlDQo+ID4gc2lt
aWxhciBwZXItdGhyZWFkIHR1bmFibGUgY29udHJvbCBpbiBsaWJ2aXJ0IGZvciBzdWNoIHRocmVh
ZHM/DQo+ID4NCj4gPiBGb3IgZXhhbXBsZSwgaW4gUUVNVSB3ZSBjYW4gYWRkIGEgbmV3IG1pZ3Jh
dGlvbiBxbXAgY29tbWFuZCwNCj4gPiBtaWdyYXRlX2VuYWJsZV9mcmVlX3BhZ2Vfb3B0aW1pemF0
aW9uIChqdXN0IGxpa2Ugb3RoZXIgY29tbWFuZHMNCj4gPiBtaWdyYXRlX3NldF9zcGVlZCAxMEcp
LCB0aGlzIGNvbW1hbmQgd2lsbCBjcmVhdGUgdGhlIG9wdGltaXphdGlvbiB0aHJlYWQuDQo+ID4g
SW4gdGhpcyB3YXksIGNyZWF0aW9uIG9mIHRoZSB0aHJlYWQgaXMgaW4gbGlidmlydCdzIGNvbnRy
b2wsIGFuZA0KPiA+IGxpYnZpcnQgY2FuIHRoZW4gc3VwcG9ydCB0dW5pbmcgdGhlIHRocmVhZCAo
ZS5nLiBwaW4gaXQgdG8gYW55IHBDUFUpLCByaWdodD8NCj4gDQo+IEFueXRoaW5nIGlzIHBvc3Np
YmxlIGZyb20gYSB0ZWNobmljYWwgbGV2ZWwsIGJ1dCBmcm9tIGEgZGVzaWduIFBPViB3ZSB3b3Vs
ZA0KPiByYXRoZXIgbm90IHN0YXJ0IGV4cG9zaW5nIHR1bmFibGVzIGZvciBhcmJpdHJhcnkgZGV2
aWNlIHR5cGUgc3BlY2lmaWMgdGhyZWFkcw0KPiBhcyB0aGV5IGFyZSBpbmhlcmFudGx5IG5vbi1w
b3J0YWJsZSBhbmQgbWF5IG5vdCBldmVuIGV4aXN0IGluIFFFTVUgbG9uZw0KPiB0ZXJtIGFzIGl0
IGlzIGp1c3QgYW4gYXJ0aWZhY3Qgb2YgdGhlIGN1cnJlbnQgUUVNVSBpbXBsZW1lbnRhdGlvbi4N
Cj4gDQoNCk9LLiBNeSBhY3R1YWwgY29uY2VybiB3aXRoIGlvdGhyZWFkIGlzIHRoYXQgaXQgZXhp
c3RzIGR1cmluZyB0aGUgd2hvbGUgUUVNVSBsaWZlY3ljbGUuIEJsb2NrIGRldmljZSB1c2luZyBp
dCBpcyBmaW5lIHNpbmNlIGJsb2NrIGRldmljZSBhY2Nlc3MgaGFwcGVucyBmcmVxdWVudGx5IGR1
cmluZyB0aGUgUUVNVSBsaWZlY3ljbGUuIFVzYWdlcyBsaWtlIGxpdmUgbWlncmF0aW9uLCBpZiB0
aGV5IGhhcHBlbiBvbmNlIHBlciBkYXksIHJ1bm5pbmcgdGhpcyBpb3RocmVhZCB3b3VsZCBiZSBh
IHdhc3RlIG9mIENQVSBjeWNsZXMuDQoNCkJlc3QsDQpXZWkNCiANCg==

