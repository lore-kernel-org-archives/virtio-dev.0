Return-Path: virtio-dev-return-4777-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11DF2985D1F
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Aug 2018 12:46:08 +0000 (UTC)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 6 Aug 2018 12:44:42 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
 <1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
 <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
 <5B681B41.6070205@intel.com>
 <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
In-Reply-To: <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v3 2/2] virtio_balloon: replace oom notifier with
 shrinker
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

T24gTW9uZGF5LCBBdWd1c3QgNiwgMjAxOCA2OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMTgvMDgvMDYgMTg6NTYsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IE9uIDA4LzAzLzIwMTgg
MDg6MTEgUE0sIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPj4gT24gMjAxOC8wOC8wMyAxNzozMiwg
V2VpIFdhbmcgd3JvdGU6DQo+ID4+PiArc3RhdGljIGludCB2aXJ0aW9fYmFsbG9vbl9yZWdpc3Rl
cl9zaHJpbmtlcihzdHJ1Y3QgdmlydGlvX2JhbGxvb24NCj4gPj4+ICsqdmIpIHsNCj4gPj4+ICvC
oMKgwqAgdmItPnNocmlua2VyLnNjYW5fb2JqZWN0cyA9IHZpcnRpb19iYWxsb29uX3Nocmlua2Vy
X3NjYW47DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5jb3VudF9vYmplY3RzID0gdmlydGlv
X2JhbGxvb25fc2hyaW5rZXJfY291bnQ7DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5iYXRj
aCA9IDA7DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5zZWVrcyA9IERFRkFVTFRfU0VFS1M7
DQo+ID4+IFdoeSBmbGFncyBmaWVsZCBpcyBub3Qgc2V0PyBJZiB2YiBpcyBhbGxvY2F0ZWQgYnkg
a21hbGxvYyhHRlBfS0VSTkVMKQ0KPiA+PiBhbmQgaXMgbm93aGVyZSB6ZXJvLWNsZWFyZWQsIEtB
U0FOIHdvdWxkIGNvbXBsYWluIGl0Lg0KPiA+DQo+ID4gQ291bGQgeW91IHBvaW50IHdoZXJlIGlu
IHRoZSBjb2RlIHRoYXQgd291bGQgY29tcGxhaW4gaXQ/DQo+ID4gSSBvbmx5IHNlZSB0d28gc2hy
aW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FXQVJFKSwgYW5kDQo+IHRoZXkgc2Vl
bSBub3QgcmVsYXRlZCB0byB0aGF0Lg0KPiANCj4gV2hlcmUgaXMgdmItPnNocmlua2VyLmZsYWdz
IGluaXRpYWxpemVkPw0KDQpJcyB0aGF0IG1hbmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8gSSBm
aW5kIGl0J3Mgbm90IGluaXRpYWxpemVkIGluIG1vc3Qgc2hyaW5rZXJzIChlLmcuIHpzX3JlZ2lz
dGVyX3Nocmlua2VyLCBodWdlX3plcm9fcGFnZV9zaHJpbmtlcikuDQoNCkJlc3QsDQpXZWkNCg==

