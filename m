Return-Path: virtio-dev-return-4412-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8ADD65818D8E
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jun 2018 18:19:50 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 16 Jun 2018 01:19:36 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A5CDB@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
In-Reply-To: <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v33 1/4] mm: add a function to get free page blocks
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, Rik van Riel <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

T24gU2F0dXJkYXksIEp1bmUgMTYsIDIwMTggNzowOSBBTSwgTGludXMgVG9ydmFsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgSnVuIDE1LCAyMDE4IGF0IDI6MDggUE0gV2VpIFdhbmcgPHdlaS53LndhbmdA
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIGZ1bmN0aW9uIHRv
IGdldCBmcmVlIHBhZ2VzIGJsb2NrcyBmcm9tIGEgZnJlZSBwYWdlDQo+ID4gbGlzdC4gVGhlIG9i
dGFpbmVkIGZyZWUgcGFnZSBibG9ja3MgYXJlIGhpbnRzIGFib3V0IGZyZWUgcGFnZXMsDQo+ID4g
YmVjYXVzZSB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCB0aGV5IGFyZSBzdGlsbCBvbiB0aGUg
ZnJlZSBwYWdlDQo+ID4gbGlzdCBhZnRlciB0aGUgZnVuY3Rpb24gcmV0dXJucy4NCj4gDQo+IEFj
ay4gVGhpcyBpcyB0aGUga2luZCBvZiBzaW1wbGUgaW50ZXJmYWNlIHdoZXJlIEkgZG9uJ3QgbmVl
ZCB0byB3b3JyeSBhYm91dA0KPiB0aGUgTU0gY29kZSBjYWxsaW5nIG91dCB0byByYW5kb20gZHJp
dmVycyBvciBzdWJzeXN0ZW1zLg0KPiANCj4gSSB0aGluayB0aGF0ICJvcmRlciIgc2hvdWxkIGJl
IGNoZWNrZWQgZm9yIHZhbGlkaXR5LCBidXQgZnJvbSBhIE1NIHN0YW5kcG9pbnQNCj4gSSB0aGlu
ayB0aGlzIGlzIGZpbmUuDQo+IA0KDQpUaGFua3MsIHdpbGwgYWRkIGEgdmFsaWRpdHkgY2hlY2sg
Zm9yICJvcmRlciIuDQoNCkJlc3QsDQpXZWkNCg==

