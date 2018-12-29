Return-Path: virtio-dev-return-5216-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EE4B985E33
	for <virtio-dev@lists.oasis-open.org>; Sat, 29 Dec 2018 02:45:53 +0000 (UTC)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 29 Dec 2018 02:45:49 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
 <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
In-Reply-To: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation issues
To: Christian Borntraeger <borntraeger@de.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

T24gRnJpZGF5LCBEZWNlbWJlciAyOCwgMjAxOCAzOjU3IFBNLCBDaHJpc3RpYW4gQm9ybnRyYWVn
ZXIgd3JvdGU6DQo+IE9uIDI4LjEyLjIwMTggMDM6MjYsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IFNv
bWUgdnFzIGRvbid0IG5lZWQgdG8gYmUgYWxsb2NhdGVkIHdoZW4gdGhlIHJlbGF0ZWQgZmVhdHVy
ZSBiaXRzIGFyZQ0KPiA+IGRpc2FibGVkLiBDYWxsZXJzIG5vdGljZSB0aGUgdnEgYWxsb2NhdGlv
biBsYXllciBieSBzZXR0aW5nIHRoZQ0KPiA+IHJlbGF0ZWQgbmFtZXNbaV0gdG8gYmUgTlVMTC4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHRoZSBmaW5kX3ZxcyBpbXBsZW1lbnRh
dGlvbnMgdG8gaGFuZGxlIHRoaXMgY2FzZS4NCj4gDQo+IFNvIHRoZSByYW5kb20gY3Jhc2hlcyBk
dXJpbmcgYm9vdCBhcmUgZ29uZS4NCj4gV2hhdCBzdGlsbCBkb2VzIG5vdCB3b3JrIGlzIGFjdHVh
bGx5IHVzaW5nIHRoZSBiYWxsb29uLg0KPiANCj4gU28gaW4gdGhlIHFlbXUgbW9uaXRvciB1c2lu
ZyBsZXRzIHNheSAiYmFsbG9vbiAxMDAwIiAgd2lsbCBoYW5nIHRoZSBndWVzdC4NCj4gU2VlbXMg
dG8gYmUgYSBkZWFkbG9jayBpbiB0aGUgdmlydGlvLWNjdyBjb2RlLiAgV2Ugc2VlbSB0byBjYWxs
IHRoZSBjb25maWcNCj4gY29kZSBpbiB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQoNClllcy4gSXQg
cmVhZHMgYSBjb25maWcgcmVnaXN0ZXIgZnJvbSB0aGUgaW50ZXJydXB0IGhhbmRsZXIuIERvIHlv
dSBrbm93IHdoeSBjY3cgZG9lc24ndCBzdXBwb3J0IGl0IGFuZCBoYXMgc29tZSBpbnRlcm5hbCBs
b2NrIHRoYXQgY2F1c2VkIHRoZSBkZWFkbG9jayBpc3N1ZT8NCiANCkJlc3QsDQpXZWkNCg==

