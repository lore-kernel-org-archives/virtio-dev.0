Return-Path: virtio-dev-return-3629-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A0DFE5818EFB
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Mar 2018 03:06:36 -0700 (PDT)
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 22 Mar 2018 10:06:23 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19108DC47@SHSMSX101.ccr.corp.intel.com>
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
 <20180214145340.1223-2-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19108B0FE@SHSMSX101.ccr.corp.intel.com>
 <a11f1b52-c031-014c-8c23-1732f3d4666c@arm.com>
 <739fbfdf-1651-8036-367a-52940b93dee6@arm.com>
In-Reply-To: <739fbfdf-1651-8036-367a-52940b93dee6@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH 1/4] iommu: Add virtio-iommu driver
To: Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

PiBGcm9tOiBSb2JpbiBNdXJwaHkgW21haWx0bzpyb2Jpbi5tdXJwaHlAYXJtLmNvbV0NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXJjaCAyMSwgMjAxOCAxMDoyNCBQTQ0KPiANCj4gT24gMjEvMDMvMTgg
MTM6MTQsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToNCj4gPiBPbiAyMS8wMy8xOCAwNjo0
MywgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gWy4uLl0NCj4gPj4+ICsNCj4gPj4+ICsjaW5jbHVk
ZSA8dWFwaS9saW51eC92aXJ0aW9faW9tbXUuaD4NCj4gPj4+ICsNCj4gPj4+ICsjZGVmaW5lIE1T
SV9JT1ZBX0JBU0UJCQkweDgwMDAwMDANCj4gPj4+ICsjZGVmaW5lIE1TSV9JT1ZBX0xFTkdUSAkJ
CTB4MTAwMDAwDQo+ID4+DQo+ID4+IHRoaXMgaXMgQVJNIHNwZWNpZmljLCBhbmQgYWNjb3JkaW5n
IHRvIHZpcnRpby1pb21tdSBzcGVjIGlzbid0IGl0DQo+ID4+IGJldHRlciBwcm9iZWQgb24gdGhl
IGVuZHBvaW50IGluc3RlYWQgb2YgaGFyZC1jb2RpbmcgaGVyZT8NCj4gPg0KPiA+IFRoZXNlIHZh
bHVlcyBhcmUgYXJiaXRyYXJ5LCBub3QgcmVhbGx5IEFSTS1zcGVjaWZpYyBldmVuIGlmIEFSTSBp
cyB0aGUNCj4gPiBvbmx5IHVzZXIgeWV0OiB3ZSdyZSBqdXN0IHJlc2VydmluZyBhIHJhbmRvbSBJ
T1ZBIHJlZ2lvbiBmb3IgbWFwcGluZw0KPiBNU0lzLg0KPiA+IEl0IGlzIGhhcmQtY29kZWQgYmVj
YXVzZSBvZiB0aGUgd2F5IGlvbW11LWRtYS5jIHdvcmtzLCBidXQgSSBkb24ndA0KPiBxdWl0ZQ0K
PiA+IHJlbWVtYmVyIHdoeSB0aGF0IGFsbG9jYXRpb24gaXNuJ3QgZHluYW1pYy4NCj4gDQo+IFRo
ZSBob3N0IGtlcm5lbCBuZWVkcyB0byBoYXZlICpzb21lKiBNU0kgcmVnaW9uIGluIHBsYWNlIGJl
Zm9yZSB0aGUNCj4gZ3Vlc3QgY2FuIHN0YXJ0IGNvbmZpZ3VyaW5nIGludGVycnVwdHMsIG90aGVy
d2lzZSBpdCB3b24ndCBrbm93IHdoYXQNCj4gYWRkcmVzcyB0byBnaXZlIHRvIHRoZSB1bmRlcmx5
aW5nIGhhcmR3YXJlLiBIb3dldmVyLCBhcyBzb29uIGFzIHRoZSBob3N0DQo+IGtlcm5lbCBoYXMg
cGlja2VkIGEgcmVnaW9uLCBob3N0IHVzZXJzcGFjZSBuZWVkcyB0byBrbm93IHRoYXQgaXQgY2Fu
IG5vDQo+IGxvbmdlciB1c2UgYWRkcmVzc2VzIGluIHRoYXQgcmVnaW9uIGZvciBETUEtYWJsZSBn
dWVzdCBtZW1vcnkuIEl0J3MgYQ0KPiBsb3QgZWFzaWVyIHdoZW4gdGhlIGFkZHJlc3MgaXMgZml4
ZWQgaW4gaGFyZHdhcmUgYW5kIHRoZSBob3N0IHVzZXJzcGFjZQ0KPiB3aWxsIG5ldmVyIGJlIHN0
dXBpZCBlbm91Z2ggdG8gdHJ5IGFuZCBWRklPX0lPTU1VX0RNQV9NQVAgaXQsIGJ1dCBpbg0KPiB0
aGUNCj4gbW9yZSBnZW5lcmFsIGNhc2Ugd2hlcmUgTVNJIHdyaXRlcyB1bmRlcmdvIElPTU1VIGFk
ZHJlc3MgdHJhbnNsYXRpb24NCj4gc28NCj4gaXQncyBhbiBhcmJpdHJhcnkgSU9WQSwgdGhpcyBo
YXMgdGhlIHBvdGVudGlhbCB0byBjb25mbGljdCB3aXRoIHN0dWZmDQo+IGxpa2UgZ3Vlc3QgbWVt
b3J5IGhvdHBsdWcuDQo+IA0KPiBXaGF0IHdlIGN1cnJlbnRseSBoYXZlIGlzIGp1c3QgdGhlIHNp
bXBsZXN0IG9wdGlvbiwgd2l0aCB0aGUgaG9zdCBrZXJuZWwNCj4ganVzdCBwaWNraW5nIHNvbWV0
aGluZyB1cC1mcm9udCBhbmQgcHJldGVuZGluZyB0byBob3N0IHVzZXJzcGFjZSB0aGF0DQo+IGl0
J3MgYSBmaXhlZCBoYXJkd2FyZSBhZGRyZXNzLiBUaGVyZSdzIGNlcnRhaW5seSBzY29wZSBmb3Ig
aXQgdG8gYmUgYQ0KPiBiaXQgbW9yZSBkeW5hbWljIGluIHRoZSBzZW5zZSBvZiBhZGRpbmcgYW4g
aW50ZXJmYWNlIHRvIGxldCB1c2Vyc3BhY2UNCj4gbW92ZSBpdCBhcm91bmQgKGJlZm9yZSBhdHRh
Y2hpbmcgYW55IGRldmljZXMsIGF0IGxlYXN0KSwgYnV0IEkgZG9uJ3QNCj4gdGhpbmsgaXQncyBm
ZWFzaWJsZSBmb3IgdGhlIGhvc3Qga2VybmVsIHRvIHNlY29uZC1ndWVzcyB1c2Vyc3BhY2UgZW5v
dWdoDQo+IHRvIG1ha2UgaXQgZW50aXJlbHkgdHJhbnNwYXJlbnQgbGlrZSBpdCBpcyBpbiB0aGUg
RE1BIEFQSSBkb21haW4gY2FzZS4NCj4gDQo+IE9mIGNvdXJzZSwgdGhhdCdzIGFsbCBhc3N1bWlu
ZyB0aGUgaG9zdCBpdHNlbGYgaXMgdXNpbmcgYSB2aXJ0aW8taW9tbXUNCj4gKGUuZy4gaW4gYSBu
ZXN0ZWQgdmlydCBvciBlbXVsYXRpb24gc2NlbmFyaW8pLiBXaGVuIGl0J3MgcHVyZWx5IHdpdGhp
biBhDQo+IGd1ZXN0IHRoZW4gYW4gTVNJIHJlc2VydmF0aW9uIHNob3VsZG4ndCBtYXR0ZXIgc28g
bXVjaCwgc2luY2UgdGhlIGd1ZXN0DQo+IHdvbid0IGJlIGFueXdoZXJlIG5lYXIgdGhlIHJlYWwg
aGFyZHdhcmUgY29uZmlndXJhdGlvbiBhbnl3YXkuDQo+IA0KPiBSb2Jpbi4NCg0KQ3VyaW91cyBz
aW5jZSBhbnl3YXkgd2UgYXJlIGRlZmluaW5nIGEgbmV3IGlvbW11IGFyY2hpdGVjdHVyZQ0KaXMg
aXQgcG9zc2libGUgdG8gYXZvaWQgdGhvc2UgQVJNLXNwZWNpZmljIGJ1cmRlbiBjb21wbGV0ZWx5
PyANCg0KVGhhbmtzDQpLZXZpbg0KDQo=

