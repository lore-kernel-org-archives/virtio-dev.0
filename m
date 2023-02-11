Return-Path: <virtio-comment-return-4149-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 11 Feb 2023 13:57:05 +0000
Message-ID: <PH0PR12MB548169C04642C7C7585FF7FFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
 <601ef040-bac2-dd6d-b32c-2029be17c071@linux.alibaba.com>
 <CAJs=3_Az-v8dm3NO6hgEm27zPfk2=6PMu93rzzvinnuD7MHUKQ@mail.gmail.com>
In-Reply-To: <CAJs=3_Az-v8dm3NO6hgEm27zPfk2=6PMu93rzzvinnuD7MHUKQ@mail.gmail.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+DQo+IFNl
bnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAxMSwgMjAyMyA1OjE5IEFNDQoNCj4gPiBUaGVyZWZvcmUs
IGlmIG91ciBzcGVjaWZpY2F0aW9uIHRlbmRzIHRvIGJlIHByYWN0aWNhbCwgd2UgY2FuIGFkZA0K
PiA+IFBhcmF2J3MgcHJvcG9zYWwsIGFuZCBpZiBvdXIgc3BlY2lmaWNhdGlvbiB0ZW5kcyB0byBi
ZSBtb3JlIGdlbmVyYWwsDQo+ID4gdGhlbiBoYW5kIG92ZXIgdGhlIGNvbnN0cmFpbnRzIHRvIHRo
ZSBkcml2ZXIgaW1wbGVtZW50YXRpb24uIHdoYXQgZG8NCj4gPiB5b3UgdGhpbms/DQo+IA0KPiBI
aSwNCj4gSSB1bmRlcnN0YW5kIHlvdXIgYW5kIFBhcmF2J3MgcG9pbnQsIGFuZCB0aGF0IHRoaXMg
aXMgbmVlZGVkIGZvciBuZXRkaW0uDQo+IEkganVzdCB0aGluayB0aGF0IHRoZSBzcGVjIHNob3Vs
ZCBub3QgZGljdGF0ZSB0aGlzLCBhbmQgdGhpcyBzaG91bGQgYmUNCj4gaW1wbGVtZW50YXRpb24g
c3BlY2lmaWMuDQo+IFdoYXQgaWYgYSBPUyB3aXRoIGEgZGlmZmVyZW50IGFkYXB0aXZlIGZ1bmN0
aW9uYWxpdHkgd2FudHMgdG8gc3VwcG9ydCB0aGVzZQ0KPiBmZWF0dXJlcz8NCj4gDQo+IFRoaXMg
aXMganVzdCBteSBvcGluaW9uIHRob3VnaC4NCg0KV2UgZG9u4oCZdCBkaWN0YXRlIGl0IGluIHRo
ZSBzcGVjLiBpbiB0aGUgc3BlYyBqdXN0IGRlZmluZXMgDQphLiB0aGUgYmVoYXZpb3IgZm9yIGRl
dmljZSBzaG91bGQgZG8gd2hlbiBib3RoIGFyZSBjb25maWd1cmVkDQpPbmUgd2F5IHRvIHNheSwg
aXQgZG9lc27igJl0IHRyeSB0byBjb25maWd1cmUgYm90aC4NCkRyaXZlciBzaG91bGQgZGlzYWJs
ZSBvbmUgYW5kIHN3aXRjaCB0byBvdGhlci4NClNpbXBsZSBmb3IgZHJpdmVyLCBkZXZpY2UgaW1w
bGVtZW50YXRpb24gYW5kIHNwZWMgYXMgdGhpcyBpcyBtb3JlIGNvbW1vbiBzY2VuYXJpby4NCg0K
T3RoZXIgd2F5IHRvIHNheSwgc3BlYyB3YW50cyB0aGUgZG9vciB0byByZW1haW4gb3BlbiBmb3Ig
bWl4ZWQgbW9kZSBoZXJlLg0KYi4gSW4gdGhpcyBjYXNlIHRoZSBwcmlvcml0eSBpcyBkZWZpbmVk
IGFzIChsYXN0IGNvbmZpZ3VyZWQgZm9yIGEgZ2l2ZW4gb2JqZWN0KS4gU28gZGV2aWNlIGlzIGNs
ZWFyIGhvdyB0byBpbXBsZW1lbnQgbWl4ZWQgbW9kZS4NCg0KI2EgaXMgd2VsbCBrbm93biBjYXNl
LiAjYiBpcyBtb3JlIGZsZXhpYmxlLg0KQm90aCBzcGVjIGRlZmluaXRpb25zIGxvb2sgZ29vZCB0
byBtZSwgd2UganVzdCBnb3QgdG8gZGVzY3JpYmUgaXQuDQoNCg==

