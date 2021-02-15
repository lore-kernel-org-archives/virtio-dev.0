Return-Path: virtio-dev-return-7994-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72D1E985E96
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Feb 2021 09:54:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 15 Feb 2021 09:54:08 +0000
Message-Id: <20210215095410.85607-1-stefanha@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/2] virtio-fs: add notification queue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: virtio-dev@lists.oasis-open.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com, mszeredi@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

djI6DQogKiBEb2N1bWVudCBlbXB0eSB2aXJ0cXVldWUgYmVoYXZpb3IgZm9yIEZVU0VfTk9USUZZ
X0xPQ0sgbWVzc2FnZXMNCg0KVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB0aGUgbm90aWZpY2F0aW9u
IHF1ZXVlIHRvIHRoZSBWSVJUSU8gc3BlY2lmaWNhdGlvbi4NClRoaXMgbmV3IHZpcnRxdWV1ZSBj
YXJyaWVzIGRldmljZS0+ZHJpdmVyIEZVU0Ugbm90aWZ5IG1lc3NhZ2VzLiAgVGhleSBhcmUNCmN1
cnJlbnRseSB1bnVzZWQgYnV0IHdpbGwgYmUgbmVjZXNzYXJ5IGZvciBmaWxlIGxvY2tpbmcsIHdo
aWNoIGNhbiBibG9jayBmb3IgYW4NCnVuYm91bmRlZCBhbW91bnQgb2YgdGltZSBhbmQgdGhlcmVm
b3JlIG5lZWRzIGEgYXN5bmNocm9ub3VzIGNvbXBsZXRpb24gZXZlbnQNCmluc3RlYWQgb2YgYSBy
ZXF1ZXN0L3Jlc3BvbnNlIGJ1ZmZlciB0aGF0IGNvbnN1bWVzIHNwYWNlIGluIHRoZSByZXF1ZXN0
DQp2aXJ0cXVldWUgdW50aWwgdGhlIG9wZXJhdGlvbiBjb21wbGV0ZXMuDQoNClBhdGNoIDEgY29y
cmVjdHMgYW4gb3ZlcnNpZ2h0IEkgbm90aWNlZDogdGhlIGZpbGUgc3lzdGVtIGRldmljZSB3YXMg
bm90IGFkZGVkDQp0byB0aGUgQ29uZm9ybWFuY2UgY2hhcHRlci4NCg0KU3RlZmFuIEhham5vY3pp
ICgyKToNCiAgdmlydGlvLWZzOiBhZGQgZmlsZSBzeXN0ZW0gZGV2aWNlIHRvIENvbmZvcm1hbmNl
IGNoYXB0ZXINCiAgdmlydGlvLWZzOiBhZGQgbm90aWZpY2F0aW9uIHF1ZXVlDQoNCiBjb25mb3Jt
YW5jZS50ZXggfCAyMyArKysrKysrKysrKysrKysrDQogdmlydGlvLWZzLnRleCAgIHwgNzEgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgODQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yOS4y
DQoNCg==

