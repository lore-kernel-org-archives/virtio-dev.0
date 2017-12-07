Return-Path: virtio-dev-return-2781-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 110511CB807B
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2017 01:46:15 -0800 (PST)
From: "Avi Cohen (A)" <avi.cohen@huawei.com>
Date: Thu, 7 Dec 2017 09:46:06 +0000
Message-ID: <B84047ECBD981D4B93EAE5A6245AA3610159329D@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [Qemu-devel] [virtio-dev] virtio -  mem-page swap for inter vm
 comm.
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

PiBPbiAyMDE35bm0MTLmnIgwN+aXpSAxNjowNCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiA+
IE9uIFRodSwgRGVjIDcsIDIwMTcgYXQgNzo1NCBBTSwgQXZpIENvaGVuIChBKSA8YXZpLmNvaGVu
QGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+PiBUaGVyZSBpcyBhbHJlYWR5IGEgIHZpcnRpbyBt
ZWNoYW5pc20gaW4gd2hpY2ggMiBWTXMgYXNzaWduZWQgYSB2aXJ0aW8gZGV2aWNlDQo+ICwgYXJl
IGNvbW11bmljYXRpbmcgdmlhIGEgdmV0aCBwYWlyICBpbiB0aGUgaG9zdCAuDQo+ID4+IEtWTSBq
dXN0IHBhc3NlcyAgYSBwb2ludGVyIG9mIHRoZSBwYWdlIG9mIHRoZSB3cml0ZXIgVk0gdG8gdGhl
IHJlYWRlcg0KPiA+PiBWTSAtIHJlc3VsdGluZyAgaW4gIGV4Y2VsbGVudCBwZXJmb3JtYW5jZSAo
bm8gdlN3aXRjaCBpbiB0aGUgbWlkZGxlKQ0KPiA+PiAqKlF1ZXN0aW9uKio6ICBXaGF0IGlzIHRo
ZSBhZHZhbnRhZ2Ugb2Ygdmhvc3QtcGNpIGNvbXBhcmVkIHRvIHRoaXMgPw0KPiA+IFdoaWNoIG1l
Y2hhbmlzbSBkbyB5b3UgbWVhbj8NCj4gPg0KPiA+IHZob3N0LXBjaSB3aWxsIGFsbG93IFZNLXRv
LVZNIGNvbW11bmljYXRpb24gd2l0aG91dCB2bWV4aXRzIHdoZW4NCj4gPiBwb2xsaW5nIG1vZGUg
aXMgdXNlZC4gIERvZXMgdGhlIG1lY2hhbmlzbSB5b3UgYXJlIHRoaW5raW5nIGFib3V0DQo+ID4g
cmVxdWlyZSB2bWV4aXRzPw0KPiA+DQo+ID4gU3RlZmFuDQo+IA0KPiBJIGd1ZXNzIHdoYXQgQXZp
IG1lYW5zIGlzIHByb2JhYmx5IHZldGggdGFwIHN1cHBvcnQgKFJGQykgaGVyZToNCj4gDQo+IGh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c0NTQwNDAuaHRtbA0KPiANCj4g
QnV0IGluIGZhY3QsIHdlIGRvbid0IG5lZWQgdmV0aCBhdCBhbGwsIGJ5IHVzaW5nIHJ4IGhhbmRs
ZXIgdHJpY2ssIHdlIGNhbiBlYXNpbHkNCj4gaW1wbGVtZW50IHBhaXIgbW9kZSBvbiBUVU4vVEFQ
Lg0KPiANCltBdmkgQ29oZW4gKEEpXSANCkkgY2hhbmdlZCB0aGUgc3ViamVjdCBzbyBhcyBub3Qg
dG8gaW50ZXJmZXJlIHdpdGggdGhlIG9yaWdpbmFsIHRocmVhZA0KSSBhbSB0cnlpbmcgIHRvIGZp
bmQgcmVmZXJlbmNlIGZvciB0aGUgbWVtLXBhZ2Ugc3dhcHBpbmcgbWVjaGFuaXNtIC0gd2l0aG91
dCAgc3VjY2VzcyB0aWxsIG5vdyAuLg0KQmVzdCBSZWdhcmRzDQpBdmkNCg0K

