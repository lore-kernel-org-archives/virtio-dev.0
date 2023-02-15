Return-Path: <virtio-comment-return-4260-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 15 Feb 2023 16:43:58 +0000
Message-ID: <PH0PR12MB5481C6814AD7DEFB24ED55F2DCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
 <m25yc3xcch.fsf@oracle.com>
 <CAJs=3_BSMQAjHGN-cDBruxSE69reT+aFwUY8asLOpVF=1b-OgA@mail.gmail.com>
In-Reply-To: <CAJs=3_BSMQAjHGN-cDBruxSE69reT+aFwUY8asLOpVF=1b-OgA@mail.gmail.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH v3] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTUsIDIwMjMgMTE6MTkgQU0NCj4gDQo+ID4gPiArXGJl
Z2lue25vdGV9DQo+ID4gPiArSW4gZ2VuZXJhbCwgdGhlc2UgY29tbWFuZHMgYXJlIGJlc3QtZWZm
b3J0OiBzcHVyaW91cyBub3RpZmljYXRpb25zIGNvdWxkDQo+IHN0aWxsIGFycml2ZS4NCj4gPiA+
ICtcZW5ke25vdGV9DQo+ID4NCj4gPiBUaGlzIGlzIHF1aXRlIHZhZ3VlLiBIb3cgYWJvdXQ6DQo+
ID4NCj4gPiBUaGUgYmVoYXZpb3VyIG9mIHRoZSBkZXZpY2UgaW4gcmVzcG9uc2UgdG8gdGhlc2Ug
Y29tbWFuZHMgaXMNCj4gPiBiZXN0LWVmZm9ydDogdGhlIGRldmljZSBtYXkgZ2VuZXJhdGUgbm90
aWZpY2F0aW9ucyBtb3JlIGZyZXF1ZW50bHkNCj4gPiB0aGFuIHNwZWNpZmllZCwgZm9yIGV4YW1w
bGUgYWZ0ZXIgbGVzcyB0aGFuIFxmaWVsZHttYXhfcGFja2V0c30NCj4gPiBwYWNrZXRzIGhhdmUg
YmVlbiBwcm9jZXNzZWQgb3IgbGVzcyB0aGFuIFxmaWVsZHt1c2Vjc30gdXNlY3MgdGltZSBoYXMN
Cj4gZWxhcHNlZC4NCj4gPg0KPiBMb29rcyBnb29kIHRvIG1lLg0KPiBJJ2xsIGFkZCBpdCB0byB2
NCBpZiBub2JvZHkgb2JqZWN0cy4NCg0Kc21hbGwgaW1wcm92ZW1lbnQgYmVsb3cuDQoNCnMvbW9y
ZSBmcmVxdWVudGx5L21vcmUgb3IgbGVzcyBmcmVxdWVudGx5Lg0KDQpUaGlzIGlzIGJlY2F1c2Ug
d2hlbiBMU08gb3IgTFJPIGlzIG9uZ29pbmcsIHBhY2tldCBjb3VudCBvciB0aW1lciBtYXkgaGF2
ZSByZWFjaGVkLCBidXQgdXNlciBidWZmZXIgbm90aWZpY2F0aW9uIHdvdWxkbuKAmXQgb2NjdXIs
IGJlY2F1c2UgdXNlZCByaW5nIHVwZGF0ZXMgYXJlIG5vdCB5ZXQgZG9uZS4gVGhlcmUgaXMgbm8g
cGFydGlhbCBjb21wbGV0aW9uLiBTbywgbm90aWZpY2F0aW9uIGNhbiBiZSBsZXNzIGZyZXF1ZW50
LiBIZW5jZSwgdGhlIHdvcmRpbmcgc2hvdWxkIGJlICJtb3JlIG9yIGxlc3MiLg0K

