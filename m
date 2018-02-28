Return-Path: virtio-dev-return-3311-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 28 Feb 2018 01:07:35 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B613498@SHSMSX103.ccr.corp.intel.com>
References: <1519633014-8683-1-git-send-email-changpeng.liu@intel.com>
 <e264f4f4-ee96-e77a-54c9-a4f07b996359@redhat.com>
 <FF7FC980937D6342B9D289F5F3C7C2625B613009@SHSMSX103.ccr.corp.intel.com>
 <3b74b21f-5851-1e89-c77b-89fff8f16106@redhat.com>
In-Reply-To: <3b74b21f-5851-1e89-c77b-89fff8f16106@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: RE: [virtio-dev] Re: [RFC] virtio-blk: add discard and write zeroes
 features to specification
To: Paolo Bonzini <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
Cc: "cavery@redhat.com" <cavery@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>, "Harris, James R" <james.r.harris@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI3
LCAyMDE4IDQ6NDIgUE0NCj4gVG86IExpdSwgQ2hhbmdwZW5nIDxjaGFuZ3BlbmcubGl1QGludGVs
LmNvbT47IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmc7DQo+IHZpcnRpb0BsaXN0cy5v
YXNpcy1vcGVuLm9yZw0KPiBDYzogY2F2ZXJ5QHJlZGhhdC5jb207IHN0ZWZhbmhhQHJlZGhhdC5j
b207IFdvZGtvd3NraSwgUGF3ZWxYDQo+IDxwYXdlbHgud29ka293c2tpQGludGVsLmNvbT47IEhh
cnJpcywgSmFtZXMgUiA8amFtZXMuci5oYXJyaXNAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W3ZpcnRpby1kZXZdIFJlOiBbUkZDXSB2aXJ0aW8tYmxrOiBhZGQgZGlzY2FyZCBhbmQgd3JpdGUg
emVyb2VzIGZlYXR1cmVzDQo+IHRvIHNwZWNpZmljYXRpb24NCj4gDQo+IE9uIDI3LzAyLzIwMTgg
MDY6NDUsIExpdSwgQ2hhbmdwZW5nIHdyb3RlOg0KPiA+PiBQZXJoYXBzIHdlIGNhbiBwdXQgYSBi
aXQgaGVyZSBzYXlpbmcgd2hldGhlciB3cml0ZV96ZXJvZXMgd2lsbCBldmVyIGxvb2sNCj4gPj4g
YXQgdGhlIFxmaWVsZHt1bm1hcH0gYml0PyAgTGlrZToNCj4gPj4NCj4gPj4gCXU4ICAgd3JpdGVf
emVyb2VzX21heV91bm1hcDsNCj4gPg0KPiA+IEkgZG8gdGFrZSB0aGlzIGludG8gY29uc2lkZXJh
dGlvbiwgaWYgd3JpdGUgemVyb2VzIGlzIHN1cHBvcnRlZCBhbmQgZGlzY2FyZCBpcyBub3QNCj4g
c3VwcG9ydGVkLA0KPiA+IGV2ZW4gdGhlIE9TIHNlbmQgd3JpdGUgemVyb2VzIGNvbW1hbmQgd2l0
aCB1bm1hcCBiaXQgZW5hYmxlZCwgdGhlIGJhY2tlbmQNCj4gd2lsbCBhbHNvDQo+ID4gaWdub3Jl
IHRoaXMgYml0LCBzbyB0aGUgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXIgc2VlbXMgdXNlbGVzcy4N
Cj4gDQo+IFRoZSByZWFzb24gaXMgdGhhdCBpdCBsZXRzIHRoZSBndWVzdCBPUyBrbm93IGlmIFdS
SVRFIFpFUk9FUyB3aXRoIFVOTUFQDQo+IHdpbGwgYmUgZmFzdCBvciBub3QuICBJdCdzIG5vdCBz
dXBlciBpbXBvcnRhbnQsIGJ1dCBpdCBpcyBlYXN5IGVub3VnaCB0bw0KPiBhZGQgYW5kIGFsc28g
ZWFzeSBlbm91Z2ggdG8gZmlsbCBpbiBmb3IgdGhlIGhvc3QuDQpPaywgSSB3aWxsIGFkZCBpdC4N
Cj4gDQo+IFBhb2xvDQo=

