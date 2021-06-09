Return-Path: virtio-dev-return-8183-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39FA79865D5
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jun 2021 15:37:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  9 Jun 2021 16:37:38 +0100
Message-Id: <20210609153740.262346-1-stefanha@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/2] virtio-fs: add notification queue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: virtio-dev@lists.oasis-open.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Liu Bo <bo.liu@linux.alibaba.com>, vgoyal@redhat.com, iangelak@redhat.com, mszeredi@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

djM6DQogKiBDbGFyaWZ5IHRoYXQgZW1wdHkgbm90aWZpY2F0aW9uIHZxIHNlbWFudGljcyBhcmUg
ZG9jdW1lbnRlZCBmb3IgYWxsDQogICBzdXBwb3J0ZWQgbm90aWZpY2F0aW9uIG1lc3NhZ2UgdHlw
ZXMuIFtWaXZla10NCiAqIENsYXJpZnkgdGhhdCB0aGUgZGV2aWNlIGhhcyBpbnRlcm5hbCByZXNv
dXJjZXMgZm9yIGxvY2sgcmVxdWVzdHMgYW5kIHdoZW4NCiAgIHRoZXkgYXJlIGV4aGF1c3RlZCBF
Tk9MQ0sgaXMgcmV0dXJuZWQuIFtWaXZla10NCnYyOg0KICogRG9jdW1lbnQgZW1wdHkgdmlydHF1
ZXVlIGJlaGF2aW9yIGZvciBGVVNFX05PVElGWV9MT0NLIG1lc3NhZ2VzDQoNClRoaXMgcGF0Y2gg
c2VyaWVzIGFkZHMgdGhlIG5vdGlmaWNhdGlvbiBxdWV1ZSB0byB0aGUgVklSVElPIHNwZWNpZmlj
YXRpb24uDQpUaGlzIG5ldyB2aXJ0cXVldWUgY2FycmllcyBkZXZpY2UtPmRyaXZlciBGVVNFIG5v
dGlmeSBtZXNzYWdlcy4gIFRoZXkgYXJlDQpjdXJyZW50bHkgdW51c2VkIGJ1dCB3aWxsIGJlIG5l
Y2Vzc2FyeSBmb3IgZmlsZSBsb2NraW5nLCB3aGljaCBjYW4gYmxvY2sgZm9yIGFuDQp1bmJvdW5k
ZWQgYW1vdW50IG9mIHRpbWUgYW5kIHRoZXJlZm9yZSBuZWVkcyBhIGFzeW5jaHJvbm91cyBjb21w
bGV0aW9uIGV2ZW50DQppbnN0ZWFkIG9mIGEgcmVxdWVzdC9yZXNwb25zZSBidWZmZXIgdGhhdCBj
b25zdW1lcyBzcGFjZSBpbiB0aGUgcmVxdWVzdA0KdmlydHF1ZXVlIHVudGlsIHRoZSBvcGVyYXRp
b24gY29tcGxldGVzLg0KDQpQYXRjaCAxIGNvcnJlY3RzIGFuIG92ZXJzaWdodCBJIG5vdGljZWQ6
IHRoZSBmaWxlIHN5c3RlbSBkZXZpY2Ugd2FzIG5vdCBhZGRlZA0KdG8gdGhlIENvbmZvcm1hbmNl
IGNoYXB0ZXIuDQoNClN0ZWZhbiBIYWpub2N6aSAoMik6DQogIHZpcnRpby1mczogYWRkIGZpbGUg
c3lzdGVtIGRldmljZSB0byBDb25mb3JtYW5jZSBjaGFwdGVyDQogIHZpcnRpby1mczogYWRkIG5v
dGlmaWNhdGlvbiBxdWV1ZQ0KDQogY29uZm9ybWFuY2UudGV4IHwgMjMgKysrKysrKysrKysrKysr
Kw0KIHZpcnRpby1mcy50ZXggICB8IDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMzEuMQ0KDQo=

