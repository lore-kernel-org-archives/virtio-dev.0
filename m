Return-Path: <virtio-comment-return-4283-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 16 Feb 2023 14:23:55 +0000
Message-ID: <PH0PR12MB5481226BA7D05A44CF59166EDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
 <PH0PR12MB54817EAF86DF11B9FB0DCB8EDCDD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f26d28f7-d213-28d7-df7f-513c1d39930f@linux.alibaba.com>
 <PH0PR12MB54817FE1744032D13AAFB74EDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e7056681-25fc-eada-8628-1810ca94c155@linux.alibaba.com>
In-Reply-To: <e7056681-25fc-eada-8628-1810ca94c155@linux.alibaba.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH v8]
 virtio-net: support inner header hash
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQoNCj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgRmVicnVhcnkgMTYsIDIwMjMgOToxOSBBTQ0KPiA+PiBJJ20gcmVhbGx5IG9rYXkg
d2l0aCB0aGlzLCB0aGUgdHVubmVsIHR5cGUgc2VlbXMgdG8gaGVscCB0aGUgc29mdHdhcmUNCj4g
Pj4gZHJpdmVyIGRvIG1vcmUgdGhpbmdzIGluIHRoZSBmdXR1cmUsIGZvciBleGFtcGxlLCB0aGUg
ZHJpdmVyIG1heSBub3QNCj4gPj4gd2FudCB0byB1c2UgdGhlIG91dGVyIGhhc2ggdmFsdWUgd2hl
biBmb3J3YXJkaW5nIHBhY2tldHMuIEJ1dCBpZg0KPiA+PiB0aGVyZSBpcyByZWFsbHkgbm8gcHJh
Y3RpY2FsIHNjZW5hcmlvIGZvciB0aGUgZHJpdmVyIGF0IHByZXNlbnQsIHRoZW4NCj4gPj4gbGV0
IHVzIGhpZGUgdGhlIHR1bm5lbCB0eXBlcyBpbiB0aGUgXGZpZWxke2hhc2hfcmVwb3J0fT8NCj4g
Pj4NCj4gPiBSaWdodC4gTGV0cyBvbWl0IGhhc2hfcmVwb3J0IGluIHZpcnRpb19uZXRfaGRyLg0K
PiANCj4gT2suIFdpbGwgZG8uDQpPay4gdGhhbmtzLg0KDQo+IA0KPiA+DQo+ID4+PiBXaGF0IGlz
IHZhbHVhYmxlIGlzIHRvIGhhdmUgYSBWTkkgYWxyZWFkeSBpZGVudGlmaWVkIGFuZCBjb21pbmcg
dG8NCj4gPj4+IHRoZSBkcml2ZXIsDQo+ID4+IGxpa2UgYSBoYXNoIHZhbHVlLg0KPiA+Pg0KPiA+
PiBUaGlzIGlzIHRvbyBzcGVjaWZpYyB0byBhIGNlcnRhaW4gdHVubmVsIHByb3RvY29sLCBub3Qg
ZXZlcnkgcHJvdG9jb2wNCj4gPj4gaGFzIGNvcnJlc3BvbmRpbmcgVk5JIGluZm9ybWF0aW9uLg0K
PiA+Pg0KPiA+IFRydWUuIEkgd2FzIGNvbnNpZGVyaW5nIGEgaGFzaCBvZiB0aGUgZ2VuZXJpYyBv
dXRlciBoZWFkZXIgdGhyb3VnaCB3aGljaCBpdA0KPiBjYW4gcmVhY2ggdG8gZ2VuZXJpYyB0dW5u
ZWwuDQo+ID4gQnV0IGl0IGlzIGEgdmVyeSBkaWZmZXJlbnQgZmVhdHVyZSBvZiBpdHMgb3duLCBz
byB5ZXMsIGJldHRlciB0byBzcGxpdCBhbmQgcHJvY2VlZA0KPiB3aXRoIHRoaXMgdG8gaW1wcm92
ZSBpbm5lciBoYXNoLg0KPiANCj4gSXQncyBhIGdvb2QgaWRlYSwgYnV0IEkgdGhpbmsgdGhlIGN1
cnJlbnQgd29yayBuZWVkcyB0byBmb2N1cyBvbiB0aGUgaW5uZXIgaGVhZGVyDQo+IGhhc2gsIGFu
ZCB0aGUgbW9yZSBnZW5lcmFsIGZlYXR1cmVzIHdlIGNhbiBjb250aW51ZSBpbiBvdGhlciB3b3Jr
Lg0KPiANClJpZ2h0LiBNYXkgYmUgbXkgcHJldmlvdXMgY29tbWVudCBkaWRu4oCZdCBjbGFyaWZ5
IHRoYXQgZW5vdWdoLg0KV2UgYm90aCBhcmUgc2F5aW5nIHNhbWUgcG9pbnQgdG8gbm90IGZvY3Vz
IG9uIG91dGVyIGhlYWRlciBvcHRpbWl6YXRpb24gaW4gdGhlc2Ugc2VyaWVzLiA6KQ0KDQo=

