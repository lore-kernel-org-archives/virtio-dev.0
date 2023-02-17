Return-Path: <virtio-comment-return-4352-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 17 Feb 2023 16:11:34 +0000
Message-ID: <PH0PR12MB5481CE26E7DBD263B449574CDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org>
 <20230217052404.GA114259@h68b04307.sqa.eu95>
 <20230217053039-mutt-send-email-mst@kernel.org>
 <CAJs=3_B7snyMbjfL3vaKKe3wfx2XomLeVzCiCPNxFpy_ZTbepA@mail.gmail.com>
 <20230217062539-mutt-send-email-mst@kernel.org>
 <CAJs=3_Am5rpEnHjRZNEZVryxAOc69gJQcSbVXphn63CvsWenCw@mail.gmail.com>
In-Reply-To: <CAJs=3_Am5rpEnHjRZNEZVryxAOc69gJQcSbVXphn63CvsWenCw@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

DQo+IEZyb206IEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgRmVicnVhcnkgMTcsIDIwMjMgNzoxOCBBTQ0KDQo+IEkgd29uZGVyIGlmIHNv
bWUgb2YgdGhhdCBzaG91bGQgYmUgaW5jbHVkZWQgaW4gbXkgcGF0Y2guDQo+IE1vc3Qgb2YgdGhh
dCBpcyBub3QgcmVsZXZhbnQgYmVmb3JlIGludHJvZHVjaW5nIHRoZSBwZXIgdnEgY29tbWFuZC4N
Cj4gU28gbWF5YmUgSSBjb3VsZCBqdXN0IG1lbnRpb24gaW4gdGhlIGRldmljZSBjb25mb3JtYW5j
ZSB0aGF0Og0KPiAiQ29hbGVzY2luZyBwYXJhbWV0ZXJzIE1VU1QvU0hPVUxEIHBlcnNpc3QgYSB2
aXJ0cXVldWUgcmVzZXQuIg0KPg0KRm9yIHN1cmUgY29hbGVzY2luZyBwYXJhbWV0ZXJzIG11c3Qg
bm90IHBlcnNpc3Qgb24gYSB2cSByZXNldCBpbiB0aGUgZGV2aWNlLg0KVlEgcmVzZXQgb3BlcmF0
aW9uIGRlc3Ryb3lzIG9yIGRpc2FibGVzIHRoZSBWUS4NCkRldmljZSBzaG91bGQgbm90IGhhdmUg
YW55IG9ibGlnYXRpb24gdG8gbWFpbnRhaW4gc29tZSBwYXJhbWV0ZXIgb24gdGhlIGRpc2FibGVk
L2Rlc3Ryb3llZCBvYmplY3QuDQoNClVzZXIgbGlrZWx5IGRpc2FibGVkIHRoZSBWUSBiZWNhdXNl
IHVzZXIgbWF5IHdhbnQgdG8gaGF2ZSBhIGZyZXNoIHN0YXJ0IGZvciB0aGlzIFZRIGZvciBzYW1l
IG9yIGRpZmZlcmVudCB1c2UuDQpBbmQgaGVuY2UsIHJlY29uZmlndXJpbmcgdGhlIG5ldyBhZGRy
ZXNzZXMsIG5ldyB2cSBzaXplLCBuZXcgdnEgbm90aWZpY2F0aW9ucyBwYXJhbWV0ZXJzLi4NCg==

