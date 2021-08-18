Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
References: <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org>
 <20210817100333.GA9207@quicinc.com> <20210817124811.GB9207@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2023e566-3331-a386-fb7c-5b4a50248a58@redhat.com>
Date: Wed, 18 Aug 2021 10:57:16 +0800
MIME-Version: 1.0
In-Reply-To: <20210817124811.GB9207@quicinc.com>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>, Xie Yongji <xieyongji@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

CtTaIDIwMjEvOC8xNyDPws7nODo0OCwgU3JpdmF0c2EgVmFkZGFnaXJpINC0tcA6Cj4gKiBTcml2
YXRzYSBWYWRkYWdpcmkgPHF1aWNfc3ZhZGRhZ2lAcXVpY2luYy5jb20+IFsyMDIxLTA4LTE3IDE1
OjMzOjMzXToKPgo+PiBIYW5kbGluZyByZXNldCBpcyB0aGUgb25seSBvcGVuIGlzc3VlIHdlIGhh
dmUsIGFzIGd1ZXN0IHRyaWdnZXJpbmcgcmVzZXQgaGFzCj4+IGN1cnJlbnRseSBubyBwcm92aXNp
b24gdG8gcG9sbCBmb3IgcmVzZXQgY29tcGxldGlvbiBhbmQgaHlwZXJ2aXNvciBpdHNlbGYgY2Fu
bm90Cj4+IGhhbmRsZSByZXNldCBjb21wbGV0bHkuIFRoaXMgaXMgd2hlcmUgd2Ugb2JzZXJ2ZWQg
ZGlzY3JlcGFuY3kgYmV0d2VlbiBQQ0kgdnMKPj4gTU1JTyBpbiBoYW5kbGluZyByZXNldCwgd2hp
Y2ggd2Ugd2FudGVkIHRvIGFkZHJlc3Mgd2l0aCB0aGlzIGRpc2N1c3Npb24uCj4+Cj4+IEkgdGhp
bmsgdGhlIG9wdGlvbiB3ZSBkaXNjdXNzZWQgZWFybGllciBvZiBhIG5ldyBmZWF0dXJlIGJpdCBz
ZWVtcyBsZXNzCj4+IGludHJ1c2l2ZSB0aGFuIGluY3JlbWVudGluZyBNTUlPIHZlcnNpb24/Cj4+
Cj4+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWRldi8yMDIx
MDcvbXNnMDAxNjguaHRtbAo+IEFsdGVybmF0ZWx5IHdvdWxkIGl0IGJlIGZpbmUgdG8gbWVyZ2Ug
YSBjaGFuZ2UgbGlrZSB0aGlzIHRvIExpbnV4IHZpcnRpb19tbWlvCj4gZHJpdmVyIHcvbyByZXF1
aXJpbmcgYW55IGZ1cnRoZXIgY2hhbmdlcyB0byBzcGVjPwo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19tbWlvLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4g
aW5kZXggNTYxMjhiOS4uOWRiODFlNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fbW1pby5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+IEBAIC0yNjIs
NiArMjYyLDkgQEAgc3RhdGljIHZvaWQgdm1fcmVzZXQoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYpCj4gICAKPiAgIAkvKiAwIHN0YXR1cyBtZWFucyBhIHJlc2V0LiAqLwo+ICAgCXdyaXRlbCgw
LCB2bV9kZXYtPmJhc2UgKyBWSVJUSU9fTU1JT19TVEFUVVMpOwo+ICsKPiArCXdoaWxlICh2bV9n
ZXRfc3RhdHVzKHZkZXYpKQo+ICsJCW1zbGVlcCgxKTsKPiAgIH0KPiAgIAo+ICAgCgoKSSB0aGlu
ayB3ZSBzdGlsbCBuZWVkIHNvbWUgY2xhcmlmaWNhdGlvbiBvbiB0aGUgc3BlYy4KCk5vdGUgdGhh
dCBkb2luZyB0aGlzLCB3aXRoIGFuIHVudHJ1c3RlZCBkZXZpY2UgdGhlIHN5c3RlbSB0b29sIGxp
a2UgCm1vZHByb2JlIG1heSBibG9jayBhdCB0aGlzIGZvcmV2ZXIKCldlIHByb2JhYmx5IG5lZWQg
YSB3YXkgdG8gZmFpbCB0aGUgcmVzZXQuCgpWRFVTRSBtZWV0cyBzaW1pbGFyIGlzc3VlLgoKVGhh
bmtzCgoKPgoK
