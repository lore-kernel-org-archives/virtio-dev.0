Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com> <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
Date: Mon, 16 Aug 2021 10:09:34 +0800
MIME-Version: 1.0
In-Reply-To: <20210811100550.GC21582@quicinc.com>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

CtTaIDIwMjEvOC8xMSDPws7nNjowNSwgU3JpdmF0c2EgVmFkZGFnaXJpINC0tcA6Cj4gKiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiBbMjAyMS0wOC0wMiAxNDowNjozOF06Cj4KPj4+
IE1heWJlIGlmIGl0IHNlZXMgc3RhdHVzIHdhcyBub3QgcmVhZCBpdCBjYW4ganVzdAo+Pj4gc3Rh
eSBpbiByZXNldCBzdGF0ZSBhbmQgbm90IGV4aXQgaXQ/Cj4+Pgo+Pj4KPj4gT3IgSSB3b25kZXIg
d2UgY2FuIHVzZSBpbmNyZWFzZSB0aGUgdmVyc2lvbiBpbnN0ZWFkLgo+IFdoYXQgc2hvdWxkIGJl
IHRoZSBndWlkYW5jZSBmb3IgYmFja2VuZC9kZXZpY2VzIGhlcmU/IEdvIHdpdGggdmVyc2lvbiAz
IG9ubHkgaWYKPiBpdCByZXF1aXJlcyBkcml2ZXIgdG8gcG9sbCBvbiByZXNldD8gT3RoZXJ3aXNl
IGl0IG1heSBicmVhayBleGlzdGluZyBzZXR1cHMgLQo+IGxldHMgc2F5IFFlbXUgaXMgdXBkYXRl
ZCB0byByZXBvcnQgdmVyc2lvbiAzIHdoaWNoIHdpbGwgYnJlYWsgb2xkZXIgZ3Vlc3QgaW1hZ2Vz
Cj4gdGhhdCB1bmRlcnN0b29kIHZlcnNpb24gMiAtIHRoaXMgaXMgZGVzcGl0ZSB0aGUgc2FtZSBR
ZW11IGJlaW5nIGNhcGFibGUgb2YKPiBzZXJ2aW5nIHRob3NlIGd1ZXN0cy4KCgpNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgcWVtdSBzaG91bGQgc3RpY2sgdG8gdmVyc2lvbiAyIHNpbmNlIGl0IHdv
cmtzIGZpbmUuCgpUaGFua3MKCgo+Cj4gLSB2YXRzYQo+Cj4gLS0tCj4KPiBRdWFsY29tbSBJbm5v
dmF0aW9uIENlbnRlciwgSW5jLiBpcyBzdWJtaXR0aW5nIHRoZSBhdHRhY2hlZCAiZmVlZGJhY2si
IGFzIGEKPiBub24tbWVtYmVyIHRvIHRoZSB2aXJ0aW8tZGV2IG1haWxpbmcgbGlzdCBmb3IgY29u
c2lkZXJhdGlvbiBhbmQgaW5jbHVzaW9uLgo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gVG8gdW5zdWJzY3Jp
YmUsIGUtbWFpbDogdmlydGlvLWRldi11bnN1YnNjcmliZUBsaXN0cy5vYXNpcy1vcGVuLm9yZwo+
IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6IHZpcnRpby1kZXYtaGVscEBsaXN0cy5v
YXNpcy1vcGVuLm9yZwo+Cgo=
