Return-Path: <virtio-comment-return-4062-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 22:08:41 +0000
Message-ID: <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
In-Reply-To: <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing
 moderation
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open
 . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists .
 oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgOCwgMjAyMyA0OjU2IFBNDQoNCj4gPiBBbHZhcm8sDQo+
ID4gRG8geW91IGtub3cgaWYgYW55IHNvZnR3YXJlIHVzZWQgaXQ/IENhbiB5b3UgZ2V0IHNvbWUg
cmVhbCBkYXRhPw0KPiANCj4gSSBpbXBsZW1lbnRlZCB0aGlzIGZlYXR1cmUgaW4gb3VyIERQVSwg
c28gYXQgbGVhc3QgMSB2ZW5kb3IgaXMgdXNpbmcgdGhpcyBmZWF0dXJlDQoNCkJ1dCB3aGljaCBz
b2Z0d2FyZSAodmlydGlvIG5ldCBkcml2ZXIpIGluIHdoaWNoIE9TIGlzIHVzaW5nIHRoaXM/DQoN
Cj4gKEkgd2lsbCBhZGQgc3VwcG9ydCBmb3IgdGhlIHBlciB2cSBjb21tYW5kIG9mIGNvdXJzZSku
DQo+IEkgcmVhbGx5IGRvbid0IGtub3cgYWJvdXQgb3RoZXIgdmVuZG9ycy4uDQo+DQo+IFlvdSBh
cmUgc3VnZ2VzdGluZyB0byByZXNlcnZlIHRoZSBjb21tYW5kIGFuZCBmZWF0dXJlIGJpdCBmb3Ig
c2FmZXR5LCBzbywgaWYgd2UNCj4gcmVzZXJ2ZSB0aGVtLCB3aHkgbm90IGp1c3QgdXNlIHRoZW0/
IFdoYXQgZG8gd2UgbG9zZSBoZXJlPw0KPiANCklmIGl0IGlzIHVzZWQgYnkgc29tZSB1bmtub3du
IHNvZnR3YXJlLCBvbmx5IHRoYXQgc3cgYnJlYWtzIGJ5IHVzaW5nIG5vbiByZWxlYXNlIHNwZWMu
DQpJZiB3ZSB1c2UgaXQgYnkgY2hhbmdpbmcgdGhlIGRlZmluaXRpb24sIGl0IG1heSBicmVhayB0
aGF0IHVua25vd24gc3cuDQpJZiB3ZSBrbm93IHRoZXJlIGlzIG5vIGtub3duIHN3LCB3ZSBhcmUg
YmV0dGVyIG9mIHdpdGggcmVkZWZpbml0aW9uIChieSBhZGRpbmcgdnFuLCBhbmQgYnkgcmVtb3Zp
bmcgdHgscnggZnJvbSBpdCkuDQoNCj4gTm90IGhhdmluZyB0aGlzIGZlYXR1cmUvY29tbWFuZCBl
dmVuIGNvbXBsaWNhdGVzIHRoaW5ncyBub3cgdGhhdCB3ZSBhcmUNCj4gdGFsa2luZyBhYm91dCBy
ZW1vdmluZyB0aGUgUlggYW5kIFRYIGZyb20gdGhlIHBlciB2cSBjb21tYW5kLCBob3cgZG8geW91
DQo+IGNoYW5nZSBwYXJhbWV0ZXJzIHRvIGFsbCBUWCBxdWV1ZXM/IHRvIGFsbCBSWCBxdWV1ZXM/
IHdlJ2xsIG5lZWQgMiBzcGVjaWFsDQo+IGluZGV4ZXMsIHNvIHdlIG5vdyBuZWVkIGxlMzIgdG8g
aG9sZCB0aGUgcXVldWUgaW5kZXguDQpObyBuZWVkIGZvciBzcGVjaWFsIGluZGV4Lg0KSG93IGRv
ZXMgYSBkcml2ZXIgZGlzYWJsZSBhbGwgcXVldWVzIG9yIHJlc2V0IGFsbCBxdWV1ZXM/IC0+IE9u
ZSBieSBvbmUuDQpTbyBpZiB1c2VyIHdhbnQgdG8gY2hhbmdlIGZvciBhbGwgVFhRLCBzdyBjYW4g
ZG8gaXQgb25lIGJ5IG9uZSBieSBpdGVyYXRpbmcgVFhRIHZxbnMuDQo=

