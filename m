Return-Path: virtio-dev-return-4778-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B10BF985D21
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Aug 2018 14:02:28 +0000 (UTC)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 6 Aug 2018 14:02:05 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739722502@SHSMSX101.ccr.corp.intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
 <1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
 <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
 <5B681B41.6070205@intel.com>
 <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
 <109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
In-Reply-To: <109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v3 2/2] virtio_balloon: replace oom notifier with
 shrinker
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

T24gTW9uZGF5LCBBdWd1c3QgNiwgMjAxOCA5OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMTgvMDgvMDYgMjE6NDQsIFdhbmcsIFdlaSBXIHdyb3RlOg0KPiA+IE9uIE1vbmRheSwg
QXVndXN0IDYsIDIwMTggNjoyOSBQTSwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+PiBPbiAyMDE4
LzA4LzA2IDE4OjU2LCBXZWkgV2FuZyB3cm90ZToNCj4gPj4+IE9uIDA4LzAzLzIwMTggMDg6MTEg
UE0sIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPj4+PiBPbiAyMDE4LzA4LzAzIDE3OjMyLCBXZWkg
V2FuZyB3cm90ZToNCj4gPj4+Pj4gK3N0YXRpYyBpbnQgdmlydGlvX2JhbGxvb25fcmVnaXN0ZXJf
c2hyaW5rZXIoc3RydWN0IHZpcnRpb19iYWxsb29uDQo+ID4+Pj4+ICsqdmIpIHsNCj4gPj4+Pj4g
K8KgwqDCoCB2Yi0+c2hyaW5rZXIuc2Nhbl9vYmplY3RzID0gdmlydGlvX2JhbGxvb25fc2hyaW5r
ZXJfc2NhbjsNCj4gPj4+Pj4gK8KgwqDCoCB2Yi0+c2hyaW5rZXIuY291bnRfb2JqZWN0cyA9IHZp
cnRpb19iYWxsb29uX3Nocmlua2VyX2NvdW50Ow0KPiA+Pj4+PiArwqDCoMKgIHZiLT5zaHJpbmtl
ci5iYXRjaCA9IDA7DQo+ID4+Pj4+ICvCoMKgwqAgdmItPnNocmlua2VyLnNlZWtzID0gREVGQVVM
VF9TRUVLUzsNCj4gPj4+PiBXaHkgZmxhZ3MgZmllbGQgaXMgbm90IHNldD8gSWYgdmIgaXMgYWxs
b2NhdGVkIGJ5DQo+ID4+Pj4ga21hbGxvYyhHRlBfS0VSTkVMKSBhbmQgaXMgbm93aGVyZSB6ZXJv
LWNsZWFyZWQsIEtBU0FOIHdvdWxkDQo+IGNvbXBsYWluIGl0Lg0KPiA+Pj4NCj4gPj4+IENvdWxk
IHlvdSBwb2ludCB3aGVyZSBpbiB0aGUgY29kZSB0aGF0IHdvdWxkIGNvbXBsYWluIGl0Pw0KPiA+
Pj4gSSBvbmx5IHNlZSB0d28gc2hyaW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FX
QVJFKSwgYW5kDQo+ID4+IHRoZXkgc2VlbSBub3QgcmVsYXRlZCB0byB0aGF0Lg0KPiA+Pg0KPiA+
PiBXaGVyZSBpcyB2Yi0+c2hyaW5rZXIuZmxhZ3MgaW5pdGlhbGl6ZWQ/DQo+ID4NCj4gPiBJcyB0
aGF0IG1hbmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8NCj4gDQo+IE9mIGNvdXJzZS4gOy0pDQo+
IA0KPiA+IEkgZmluZCBpdCdzIG5vdCBpbml0aWFsaXplZCBpbiBtb3N0IHNocmlua2VycyAoZS5n
LiB6c19yZWdpc3Rlcl9zaHJpbmtlciwNCj4gaHVnZV96ZXJvX3BhZ2Vfc2hyaW5rZXIpLg0KPiAN
Cj4gQmVjYXVzZSBtb3N0IHNocmlua2VycyBhcmUgInN0YXRpY2FsbHkgaW5pdGlhbGl6ZWQgKHdo
aWNoIG1lYW5zIHRoYXQNCj4gdW5zcGVjaWZpZWQgZmllbGRzIGFyZSBpbXBsaWNpdGx5IHplcm8t
Y2xlYXJlZCkiIG9yICJkeW5hbWljYWxseSBhbGxvY2F0ZWQgd2l0aA0KPiBfX0dGUF9aRVJPIG9y
IHplcm8tY2xlYXJlZCB1c2luZw0KPiBtZW1zZXQoKSAod2hpY2ggbWVhbnMgdGhhdCBhbGwgZmll
bGRzIGFyZSBvbmNlIHplcm8tY2xlYXJlZCkiLg0KPiANCj4gQW5kIGlmIHlvdSBvbmNlIHplcm8t
Y2xlYXIgdmIgYXQgYWxsb2NhdGlvbiB0aW1lLCB5b3Ugd2lsbCBnZXQgYSBib251cyB0aGF0DQo+
IGNhbGxpbmcgdW5yZWdpc3Rlcl9zaHJpbmtlcigpIHdpdGhvdXQgY29ycmVzcG9uZGluZyByZWdp
c3Rlcl9zaHJpbmtlcigpIGlzIHNhZmUNCj4gKHdoaWNoIHdpbGwgc2ltcGxpZnkgaW5pdGlhbGl6
YXRpb24gZmFpbHVyZSBwYXRoKS4NCg0KT2gsIEkgc2VlLCB0aGFua3MuIFNvIGl0IHNvdW5kcyBi
ZXR0ZXIgdG8gZGlyZWN0bHkga3phbGxvYyB2Yi4NCg0KQmVzdCwNCldlaQ0K

