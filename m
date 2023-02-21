Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] RE: [virtio-comment] RE: [PATCH v9] virtio-net:
 support inner header hash
Date: Tue, 21 Feb 2023 16:50:56 +0000
Message-ID: <PH0PR12MB5481DFE61340CB9ACED1DEEADCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ff76a6e-fd77-4cf3-a9ad-546696ab843d@linux.alibaba.com>
 <PH0PR12MB5481E635794E2B63B9A110A3DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f7080485-e8bd-048f-b8ea-cd86757f7b1c@linux.alibaba.com>
 <PH0PR12MB548135774CD69A5A5F475FB2DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85de2618-6018-5436-6e8a-4d5253b42e64@linux.alibaba.com>
In-Reply-To: <85de2618-6018-5436-6e8a-4d5253b42e64@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgRmVicnVhcnkgMjEsIDIwMjMgMTE6NDQgQU0NCg0KPiA+IFBhdGNoLTEgdG8gaW50cm9k
dWNlIHRoZSBmZWF0dXJlIGJpdCwgZGVzY3JpcHRpb24sIGFuZCBsaW5rIHRvIENWUSBkZXBlbmRl
bmN5Lg0KPiA+IFBhdGNoLTIgZm9yIGl0cyBsaW5rIGluIHZpcnRpb19uZXRfY29uZmlnIHN0cnVj
dHVyZSBhbmQgZGVzY3JpcHRpb24uDQo+ID4gUGF0Y2gtMyBmb3IgbmV3IGNvbW1hbmQgdG91Y2hp
bmcgY29udHJvbCBWUSBwaWVjZXMuDQo+IA0KPiBZZXMsIGFuZCB5b3Ugc2VlbSB0byBoYXZlIG1p
c3NlZCBteSBvdGhlciByZXBsaWVzIGluIHRoaXMgdGhyZWFkOiksIEkgcmVwaHJhc2VkDQpXYXMg
aXQgY29tbWVudCAiQW5kIHZpcnRpb19uZXRfaGFzaF9jb25maWcgc2VlbXMgdG8gc3VmZmljZSBl
eGNlcHQgZm9yIGxlMTYgcmVzZXJ2ZWRbNF0uIiA/DQpJIGRvbuKAmXQgc2VlIHRoZXNlIHJlc2Vy
dmVkIGZpZWxkcyBpbiB0aGUgY3VycmVudCBzdHJ1Y3R1cmUuDQoNCj4gaXQgaGVyZToNCj4gdmly
dGlvX25ldF9oYXNoX2NvbmZpZyBzZWVtcyB0byBiZSByZXVzYWJsZSwgYXMgdGhlIHY5IHBhdGNo
IGlzIGRvaW5nLCB3aHkNCj4gZG9uJ3Qgd2UgcmUtdXNlIGl0Pw0KPiBUaGUgcmVhc29uIEkgY2Fu
IHRoaW5rIG9mIGlzIHRvIG5vdCBleHBhbmQgdGhlIHZpcnRpb19uZXRfaGFzaF9jb25maWcgc3Ry
dWN0dXJlLA0KPiBqdXN0IHNldCBhIHNlcGFyYXRlIHN0cnVjdHVyZSBmb3IgVklSVElPX05FVF9G
X0hBU0hfVFVOTkVMIGFuZCBpbmNsdWRlDQo+IGhhc2hfdHVubmVsX3R5cGVzPw0KDQpUaGUgcGFy
dCB0aGF0IEkgYW0gbWlzc2luZyBpcywgaG93IGRvIHRvIHJldXNlIHZpcnRpb19uZXRfaGFzaF9j
b25maWcgYW5kIHNheSBpZ25vcmUgYWxsIHRoZSBleGlzdGluZyBmaWVsZHMgcmVsYXRlZCB0byBy
c3MsIGJ1dCBvbmx5IGNvbnNpZGVyIGhhc2hfdHVubmVsX3R5cGVzPw0K

