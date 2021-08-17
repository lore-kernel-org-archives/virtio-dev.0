Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
References: <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com> <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
Date: Tue, 17 Aug 2021 13:45:12 +0800
MIME-Version: 1.0
In-Reply-To: <20210816074558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

CtTaIDIwMjEvOC8xNiDPws7nNzo0OCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gTW9u
LCBBdWcgMTYsIDIwMjEgYXQgMTI6MDU6NTBQTSArMDUzMCwgU3JpdmF0c2EgVmFkZGFnaXJpIHdy
b3RlOgo+PiAqIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IFsyMDIxLTA4LTE2
IDAxOjM1OjQ2XToKPj4KPj4+IFNvIHRoaW5raW5nIGFib3V0IGFsbCB0aGlzLCBxdWl0ZSBlYXJs
eSBpbiB0aGUgc2V0dXAgcHJvY2VzcyB3ZQo+Pj4gaGF2ZToKPj4+Cj4+PiAgICAgICAgICAvKiBG
aWd1cmUgb3V0IHdoYXQgZmVhdHVyZXMgdGhlIGRldmljZSBzdXBwb3J0cy4gKi8KPj4+ICAgICAg
ICAgIGRldmljZV9mZWF0dXJlcyA9IGRldi0+Y29uZmlnLT5nZXRfZmVhdHVyZXMoZGV2KTsKPj4+
Cj4+Pgo+Pj4gaXNuJ3QgdGhpcyBzdWZmaWNpZW50PyB0aGlzIHdpbGwgZmx1c2ggb3V0Cj4+PiBh
bGwgd3JpdGVzIGFuZCBkZXZpY2UgY2FuIGRlZmVyIHJlc3BvbmRpbmcgdG8gcmVhZHMKPj4+IHVu
dGlsIHJlc2V0IGlzIGNvbXBsZXRlLgo+PiBIbW0gbm90IHN1cmUgaWYgdGhhdCdzIHBvc3NpYmxl
IGluIGFsbCBNTUlPIGRldmljZXM/IEkgdGhpbmsgYSB3aGlsZSBiYWNrIEphc29uCj4+IGZlbHQg
c29tZSBvZiB0aGUgTU1JTyBkZXZpY2VzLCB0aGVpciByZWdpc3RlcnMgY291bGQgYWN0IGFzIHBs
YWluIERSQU0gZm9yCj4+IHJlYWRzLCB3aGljaCBtZWFucyBkZXZpY2UgY2FuJ3QgYmxvY2sgc3Vj
aCByZWFkcz8KPj4KPj4gLSB2YXRzYQo+IElzIGl0IHdvcnRoIGJvdGhlcmluZyBhYm91dCB0aGVv
cmV0aWNhbCBpc3N1ZXMgdGhvdWdoPyBKYXNvbiB3aGF0IGlzCj4geW91ciB0YWtlPwoKClJlLXJl
YWQgdGhlIHNwZWMsIGFuZCBpdCBzYWlkCgoiCgpNTUlPIERldmljZSBSZWdpc3RlciBMYXlvdXQK
CiIKCkkgYmVsaWV2ZSBwbGFpbiBEUkFNIHdpbGwgbm90IGJlaGF2ZSBsaWtlIGEgcmVnaXN0ZXIu
IFNvIHdlIGRvbid0IG5lZWQgCnRvIHdvcnJ5IGFib3V0IHRoYXQuCgpCdXQgdGhleSBhcmUgaW5k
ZWVkIGRldmljZXMgdGhhdCBhY3QgYXMgYSBwbGFpbiBEUkFNIGZvciB0aGVpciBjb250cm9sIApw
YXRoLCB3aGljaCBtaWdodCByZXF1aXJlcyBuZXcgdHJhbnNwb3J0c1sxXS4KCkFub3RoZXIgcXVl
c3Rpb24gaXMgdGhhdCB3aGF0IG1ha2VzIFBDSSBkaWZmZXIgZnJvbSBNTUlPLiAoRS5nIFBDSSAK
cmVxdWlyZXMgYSByZS1yZWFkIGJ1dCBNTUlPIGRvZXNuJ3QpCgpbMV0gaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMjAvOS8xLzI1NQoKCj4KPgo+PiAtLS0KPj4KPj4gUXVhbGNvbW0gSW5ub3ZhdGlv
biBDZW50ZXIsIEluYy4gaXMgc3VibWl0dGluZyB0aGUgYXR0YWNoZWQgImZlZWRiYWNrIiBhcyBh
Cj4+IG5vbi1tZW1iZXIgdG8gdGhlIHZpcnRpby1kZXYgbWFpbGluZyBsaXN0IGZvciBjb25zaWRl
cmF0aW9uIGFuZCBpbmNsdXNpb24uCgo=
