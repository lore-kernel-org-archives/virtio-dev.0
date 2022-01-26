Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Wed, 26 Jan 2022 13:29:27 +0000
Message-ID: <PH0PR12MB5481B051AFA529851B0167B3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com>
 <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <56a7bf50-509d-f9d5-df78-858cb1b156c1@redhat.com>
 <PH0PR12MB548182EBE025ECA44124A11DDC5F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b6fc2eb9-8023-29c6-ce59-6a9f3810d057@nvidia.com>
 <20220125070649-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220125070649-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIEphbnVhcnkgMjUsIDIwMjIgNTozOSBQTQ0KDQo+ID4NCj4gPiBTbyB5b3UgZG8gYWdy
ZWUgdGhhdCBtYW5hZ2luZyBhIG1hbmFnZWQgKGNyZWF0ZS9kZXN0cm95L3NldHVwL2V0Yy4uLikN
Cj4gPiB3aWxsIGJlIGRvbmUgdXNpbmcgdGhlIEFRIG9mIHRoZSBtYW5hZ2luZyBkZXZpY2UgPw0K
PiANCj4gSSB0aGluayBKYXNvbiBhc2tlZCB0aGF0IHRoZSBtYW5hZ2VtZW50IGNvbW1hbmRzIGFy
ZSBzcGxpdCBmcm9tIHRoZSBxdWV1ZQ0KPiBpdHNlbGYsIHN1Y2ggdGhhdCB0aGV5IGNhbiBiZSBp
bXBsZW1lbnRlZCBpbiBtb3JlIHdheXMgZG93biB0aGUgcm9hZC4NCg0KQWRtaW4gY29tbWFuZHMg
aW52b2x2ZWQgRE1BLiBBbmQgYWxzbyBtdWx0aXBsZSBjb21tYW5kcyBjYW4gYmUgZW5xdWV1ZWQg
dG8gdGhlIGRldmljZS4NCkkgZG9uJ3Qgc2VlIGFueSBvdGhlciBjb25zdHJ1Y3QgaW4gdGhlIHNw
ZWMgb3RoZXIgdGhhbiB2cSB0aGF0IGVuYWJsZXMgZHJpdmVyIGFuZCBkZXZpY2UgdG8gYWNoaWV2
ZSBib3RoLg0KSGVuY2Ugc3BsaXQgdGhlIHF1ZXVlIGZyb20gY29tbWFuZCBpcyB2ZXJ5IHdlaXJk
IGZvciBzcGVjIHRvIGRvLg0KDQpBIHJlY2VudCBhZGRpdGlvbiBsaWtlIHZpcnRpb19mc19yZXEg
ZGlkbuKAmXQgYWRvcHQgdGhpcyBzdWdnZXN0aW9uLg0KDQpJZiB3ZSBqdXN0IHdhbnQgdG8gc3Bs
aXQgc28gdGhhdCBhZG1pbiBjb21tYW5kcyBjYW4gYmUgdHJhbnNwb3J0ZWQgdmlhIG5vbiBhZG1p
biBxdWV1ZSwgd2Ugc2hvdWxkIHJlbW92ZSBiZWxvdyBsaW5lIGZyb20gc3BlYzoNCg0KIlRoZSBB
ZG1pbiBjb21tYW5kIHNldCBkZWZpbmVzIHRoZSBjb21tYW5kcyB0aGF0IG1heSBiZSBpc3N1ZWQg
b25seSB0byB0aGUgYWRtaW4gdmlydHF1ZXVlIg0KDQpBbmQgcmV3b3JkIGl0IGFzIGJlbG93LA0K
DQpUaGUgQWRtaW4gY29tbWFuZCBzZXQgZGVmaW5lcyB0aGUgY29tbWFuZHMgdG8gbWFuaXB1bGF0
ZSB2YXJpb3VzIGZlYXR1cmVzL2F0dHJpYnV0ZXMgb2YgYW5vdGhlciBkZXZpY2Ugd2l0aGluIHRo
ZSBzYW1lIGdyb3VwLi4uDQpXaGVuIFZJUlRJT19GX0FETUlOX1ZRIGZlYXR1cmUgaXMgbmVnb3Rp
YXRlZCwgYWRtaW4gY29tbWFuZHMgbXVzdCBiZSB0cmFuc3BvcnRlZCB0aHJvdWdoIHRoZSBhZG1p
biBxdWV1ZS4NCg0KTG9va3Mgb2s/DQo=

