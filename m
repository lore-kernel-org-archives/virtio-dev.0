Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] RE: [PATCH
 v9] virtio-net: support inner header hash
Date: Tue, 21 Feb 2023 17:39:05 +0000
Message-ID: <PH0PR12MB5481F7A90A83A317A9682BE7DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ff76a6e-fd77-4cf3-a9ad-546696ab843d@linux.alibaba.com>
 <PH0PR12MB5481E635794E2B63B9A110A3DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f7080485-e8bd-048f-b8ea-cd86757f7b1c@linux.alibaba.com>
 <PH0PR12MB548135774CD69A5A5F475FB2DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85de2618-6018-5436-6e8a-4d5253b42e64@linux.alibaba.com>
 <PH0PR12MB5481DFE61340CB9ACED1DEEADCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <913230f2-24bc-a2b0-1a5e-c0f1414f888d@linux.alibaba.com>
In-Reply-To: <913230f2-24bc-a2b0-1a5e-c0f1414f888d@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgRmVicnVhcnkgMjEsIDIwMjMgMTI6MTcgUE0NCj4gDQo+IOWcqCAyMDIzLzIvMjIg5LiK
5Y2IMTI6NTAsIFBhcmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4+IEZyb206IEhlbmcgUWkgPGhlbmdx
aUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjEsIDIw
MjMgMTE6NDQgQU0NCj4gPj4+IFBhdGNoLTEgdG8gaW50cm9kdWNlIHRoZSBmZWF0dXJlIGJpdCwg
ZGVzY3JpcHRpb24sIGFuZCBsaW5rIHRvIENWUQ0KPiBkZXBlbmRlbmN5Lg0KPiA+Pj4gUGF0Y2gt
MiBmb3IgaXRzIGxpbmsgaW4gdmlydGlvX25ldF9jb25maWcgc3RydWN0dXJlIGFuZCBkZXNjcmlw
dGlvbi4NCj4gPj4+IFBhdGNoLTMgZm9yIG5ldyBjb21tYW5kIHRvdWNoaW5nIGNvbnRyb2wgVlEg
cGllY2VzLg0KPiA+PiBZZXMsIGFuZCB5b3Ugc2VlbSB0byBoYXZlIG1pc3NlZCBteSBvdGhlciBy
ZXBsaWVzIGluIHRoaXMgdGhyZWFkOiksIEkNCj4gPj4gcmVwaHJhc2VkDQo+ID4gV2FzIGl0IGNv
bW1lbnQgIkFuZCB2aXJ0aW9fbmV0X2hhc2hfY29uZmlnIHNlZW1zIHRvIHN1ZmZpY2UgZXhjZXB0
IGZvciBsZTE2DQo+IHJlc2VydmVkWzRdLiIgPw0KPiA+IEkgZG9u4oCZdCBzZWUgdGhlc2UgcmVz
ZXJ2ZWQgZmllbGRzIGluIHRoZSBjdXJyZW50IHN0cnVjdHVyZS4NCj4gPg0KPiA+PiBpdCBoZXJl
Og0KPiA+PiB2aXJ0aW9fbmV0X2hhc2hfY29uZmlnIHNlZW1zIHRvIGJlIHJldXNhYmxlLCBhcyB0
aGUgdjkgcGF0Y2ggaXMNCj4gPj4gZG9pbmcsIHdoeSBkb24ndCB3ZSByZS11c2UgaXQ/DQo+ID4+
IFRoZSByZWFzb24gSSBjYW4gdGhpbmsgb2YgaXMgdG8gbm90IGV4cGFuZCB0aGUgdmlydGlvX25l
dF9oYXNoX2NvbmZpZw0KPiA+PiBzdHJ1Y3R1cmUsIGp1c3Qgc2V0IGEgc2VwYXJhdGUgc3RydWN0
dXJlIGZvciBWSVJUSU9fTkVUX0ZfSEFTSF9UVU5ORUwNCj4gPj4gYW5kIGluY2x1ZGUgaGFzaF90
dW5uZWxfdHlwZXM/DQo+ID4gVGhlIHBhcnQgdGhhdCBJIGFtIG1pc3NpbmcgaXMsIGhvdyBkbyB0
byByZXVzZSB2aXJ0aW9fbmV0X2hhc2hfY29uZmlnIGFuZCBzYXkNCj4gaWdub3JlIGFsbCB0aGUg
ZXhpc3RpbmcgZmllbGRzIHJlbGF0ZWQgdG8gcnNzLCBidXQgb25seSBjb25zaWRlcg0KPiBoYXNo
X3R1bm5lbF90eXBlcz8NCj4gDQo+IEFyZSB5b3UgcmVmZXJyaW5nIHRvIHN1Y2ggYSBjb21tYW5k
Pw0KPiANCj4gI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfSEFTSF9UVU5ORUxfVFlQRSAxIHN0cnVj
dA0KPiB2aXJ0aW9fbmV0X3R1bm5lbF90eXBlX2NvbmZpZyB7DQo+ICDCoMKgwqDCoCBsZTMyIGhh
c2hfdHVubmVsX3R5cGVzOw0KPiB9Ow0KPiANCj4gVGhhbmtzLg0KDQpZZXMuDQo=

