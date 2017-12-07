Return-Path: virtio-dev-return-2778-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C06C51CB807D
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2017 23:59:58 -0800 (PST)
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 7 Dec 2017 07:59:28 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4CC4FC@DGGEMA505-MBS.china.huawei.com>
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
 <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
 <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
In-Reply-To: <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [virtio-dev] RE: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
To: Halil Pasic <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

PiANCj4gT24gMTIvMDYvMjAxNyAwODozNyBBTSwgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6DQo+ID4g
K1xmaWVsZHtvdXRjb21lX2xlbn0gaXMgdGhlIHNpemUgb2Ygc3RydWN0IHZpcnRpb19jcnlwdG9f
c2Vzc2lvbl9pbnB1dCBvcg0KPiA+ICtaRVJPIGZvciB0aGUgc2Vzc2lvbi1kZXN0cm95IG9wZXJh
dGlvbi4NCj4gDQo+IFRoaXMgYWluJ3QgY29ycmVjdC4gSXQgc2hvdWxkIGhhdmUgYmVlbiBzb21l
dGhpbmcgbGlrZQ0KPiB2aXJ0aW9fY3J5cHRvX2Rlc3Ryb3lfc2Vzc2lvbl9pbnB1dC4NCj4gDQpS
aWdodCwgd2lsbCBmaXggaXQuDQoNCj4gPiArDQo+ID4gKw0KPiA+ICtccGFyYWdyYXBoe1Nlc3Np
b24gb3BlcmF0aW9ufVxsYWJlbHtzZWM6RGV2aWNlIFR5cGVzIC8gQ3J5cHRvIERldmljZSAvDQo+
IERldmljZQ0KPiA+ICtPcGVyYXRpb24gLyBDb250cm9sIFZpcnRxdWV1ZSAvIFNlc3Npb24gb3Bl
cmF0aW9ufQ0KPiA+ICsNCj4gPiArVGhlIHNlc3Npb24gaXMgYSBoYW5kbGUgd2hpY2ggZGVzY3Jp
YmVzIHRoZSBjcnlwdG9ncmFwaGljIHBhcmFtZXRlcnMgdG8gYmUNCj4gPiArYXBwbGllZCB0byBh
IG51bWJlciBvZiBidWZmZXJzLg0KPiA+ICsNCj4gPiArVGhlIGZvbGxvd2luZyBzdHJ1Y3R1cmUg
c3RvcmVzIHRoZSByZXN1bHQgb2Ygc2Vzc2lvbiBjcmVhdGlvbiBzZXQgYnkgdGhlDQo+IGRldmlj
ZToNCj4gPiArDQo+ID4gK1xiZWdpbntsc3RsaXN0aW5nfQ0KPiA+ICtzdHJ1Y3QgdmlydGlvX2Ny
eXB0b19zZXNzaW9uX2lucHV0IHsNCj4gPiArICAgIC8qIERldmljZSB3cml0ZSBvbmx5IHBvcnRp
b24gKi8NCj4gPiArICAgIGxlNjQgc2Vzc2lvbl9pZDsNCj4gPiArICAgIGxlMzIgc3RhdHVzOw0K
PiA+ICsgICAgbGUzMiBwYWRkaW5nOw0KPiA+ICt9Ow0KPiA+ICtcZW5ke2xzdGxpc3Rpbmd9DQo+
ID4gKw0KPiA+ICtBIHJlcXVlc3QgdG8gZGVzdHJveSBhIHNlc3Npb24gaW5jbHVkZXMgdGhlIGZv
bGxvd2luZyBpbmZvcm1hdGlvbjoNCj4gPiArDQo+ID4gK1xiZWdpbntsc3RsaXN0aW5nfQ0KPiA+
ICtzdHJ1Y3QgdmlydGlvX2NyeXB0b19kZXN0cm95X3Nlc3Npb25fZmxmIHsNCj4gPiArICAgIC8q
IERldmljZSByZWFkIG9ubHkgcG9ydGlvbiAqLw0KPiA+ICsgICAgbGU2NCAgc2Vzc2lvbl9pZDsN
Cj4gPiArICAgIC8qIERldmljZSB3cml0ZSBvbmx5IHBvcnRpb24gKi8NCj4gDQo+IFRoaXMgaXMg
dGhlIGRldmljZSB3cml0YWJsZSBwb3J0aW9uIGFuZCB0aHVzIHdoYXQgd2UgY2FsIG9wX291dGNv
bWUgYWJvdmUuDQo+IFNvIGl0IHNob3VsZCBoYXZlIGJlZW4NCj4gfTsNCj4gDQo+IA0KPiBzdHJ1
Y3QgdmlydGlvX2NyeXB0b19kZXN0cm95X3Nlc3Npb25faW5wdXQgew0KPiA+ICsgICAgbGUzMiAg
c3RhdHVzOw0KPiA+ICsgICAgbGUzMiAgcGFkZGluZzsNCj4gPiArfTsNCj4gDQo+IElmIHdlIGFy
ZW4ndCBjb25zaXN0ZW50IGFib3V0IGl0IHRoZSBkaXZpZGluZyBpbnRvIHBhcnRzIChsaWtlIG9w
IHNwZWNpZmljDQo+IGZpeGVkIGFuZCB2YXJpYWJsZSBsZW5ndGggKG91dHB1dCkgZmllbGRzLCBv
cGVyYXRpb24gb3V0Y29tZSAoaW5wdXQpKQ0KPiBpc24ndCByZWFsbHkgaGVscGZ1bC4NCj4gDQpJ
dCdzIG9rIHRvIHVzLCB3ZSBjYW4gZG8gaXQuIEFueSBvdGhlciBjb21tZW50cz8NCg0KVGhhbmtz
LA0KLUdvbmdsZWkNCg0K

