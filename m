Return-Path: <virtio-dev-return-9961-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 934849865DF
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Sep 2022 02:33:57 +0000 (UTC)
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Date: Wed, 21 Sep 2022 02:33:50 +0000
Message-ID: <0bc06659385bdcb94151065d2d652616453b1587.camel@wdc.com>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
	 <YylvChyEpFUiAuu8@infradead.org>
	 <CAJSP0QWbLizQDTkPC74-DMm_fBR6w5ZboPWOqCx+T1KJGbcTPg@mail.gmail.com>
In-Reply-To: <CAJSP0QWbLizQDTkPC74-DMm_fBR6w5ZboPWOqCx+T1KJGbcTPg@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH 0/3] virtio-blk: support zoned block devices
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <10DACD12B73D0D4AA788A76D9AA2C755@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
To: "stefanha@gmail.com" <stefanha@gmail.com>, "hch@infradead.org" <hch@infradead.org>
Cc: "faithilikerun@gmail.com" <faithilikerun@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hare@suse.de" <hare@suse.de>, "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

T24gVHVlLCAyMDIyLTA5LTIwIGF0IDA2OjQxIC0wNDAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAgU2VwdCAyMDIyIGF0IDAzOjQzLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFN1biwgU2VwIDE4LCAyMDIyIGF0
IDEwOjI5OjE4UE0gLTA0MDAsIERtaXRyeSBGb21pY2hldiB3cm90ZToNCj4gPiA+IEluIGl0cyBj
dXJyZW50IGZvcm0sIHRoZSB2aXJ0aW8gcHJvdG9jb2wgZm9yIGJsb2NrIGRldmljZXMgKHZpcnRp
by1ibGspDQo+ID4gPiBpcyBub3QgYXdhcmUgb2Ygem9uZWQgYmxvY2sgZGV2aWNlcyAoWkJEcykg
YnV0IGl0IGFsbG93cyB0aGUgZHJpdmVyIHRvDQo+ID4gPiBzdWNjZXNzZnVsbHkgc2NhbiBhIGhv
c3QtbWFuYWdlZCBkcml2ZSBwcm92aWRlZCBieSB0aGUgdmlydGlvIGJsb2NrDQo+ID4gPiBkZXZp
Y2UuIEFzIHRoZSByZXN1bHQsIHRoZSBob3N0LW1hbmFnZWQgZHJpdmUgaXMgcmVjb2duaXplZCBi
eSB0aGUNCj4gPiA+IHZpcnRpbyBkcml2ZXIgYXMgYSByZWd1bGFyLCBub24tem9uZWQgZHJpdmUg
dGhhdCB3aWxsIG9wZXJhdGUNCj4gPiA+IGVycm9uZW91c2x5IHVuZGVyIHRoZSBtb3N0IGNvbW1v
biB3cml0ZSB3b3JrbG9hZHMuIEhvc3QtYXdhcmUgWkJEcyBhcmUNCj4gPiA+IGN1cnJlbnRseSB1
c2FibGUsIGJ1dCB0aGVpciBwZXJmb3JtYW5jZSBtYXkgbm90IGJlIG9wdGltYWwgYmVjYXVzZSB0
aGUNCj4gPiA+IGRyaXZlciBjYW4gb25seSBzZWUgdGhlbSBhcyBub24tem9uZWQgYmxvY2sgZGV2
aWNlcy4NCj4gPiANCj4gPiBXaGF0IGlzIHRoZSBhZHZhbnRhZ2UgaW4gZXh0ZW5kaW5nIHZpcnRp
by1ibGsgdnMganVzdCB1c2luZyB2aXJ0aW8tc2NzaQ0KPiA+IG9yIG52bWUgd2l0aCBzaGFkb3cg
ZG9vcmJlbGxzIHRoYXQganVzdCB3b3JrPw0KPiANCj4gdmlydGlvLWJsayBpcyB3aWRlbHkgdXNl
ZCBhbmQgbmV3IHJlcXVlc3QgdHlwZXMgYXJlIGFkZGVkIGFzIG5lZWRlZC4NCj4gDQo+IFFFTVUn
cyBOVk1lIGVtdWxhdGlvbiBtYXkgc3VwcG9ydCBwYXNzaW5nIHRocm91Z2ggem9uZWQgc3RvcmFn
ZQ0KPiBkZXZpY2VzIGluIHRoZSBmdXR1cmUgYnV0IGl0IGRvZXNuJ3QgdG9kYXkuIFN1cHBvcnQg
d2FzIGltcGxlbWVudGVkIGluDQo+IHZpcnRpby1ibGsgZmlyc3QgYmVjYXVzZSBOVk1lIGVtdWxh
dGlvbiBpc24ndCB3aWRlbHkgdXNlZCBpbg0KPiBwcm9kdWN0aW9uIFFFTVUgVk1zLg0KPiANCj4g
U3RlZmFuDQogDQpBIGxhcmdlIHNoYXJlIG9mIGh5cGVyc2NhbGVyIGd1ZXN0IFZNIGltYWdlcyBv
bmx5IHN1cHBvcnRzIHZpcnRpbyBmb3INCnN0b3JhZ2UgYW5kIGRvZXNuJ3QgZGVmaW5lIENPTkZJ
R19TQ1NJLCBDT1BORklHX0FUQSwgZXRjLiBhdCBhbGwgaW4gdGhlaXINCmtlcm5lbCBjb25maWcu
IFRoaXMgaXMgZXNwZWNpYWxseSBjb21tb24gaW4gaHlwZXJzY2FsZSBlbnZpcm9ubWVudHMgdGhh
dA0KYXJlIGRlZGljYXRlZCB0byBzZXJ2ZXJsZXNzIGNvbXB1dGluZy4NCg0KSW4gc3VjaCBlbnZp
cm9ubWVudHMsIHRoZXJlIGlzIGN1cnJlbnRseSBubyB3YXkgdG8gcHJlc2VudCBhIHpvbmVkIGRl
dmljZQ0KdG8gdGhlIGd1ZXN0IHVzZXIgYmVjYXVzZSB0aGUgdmlydGlvLWJsayBkcml2ZXIgaXMg
bm90IFpCRC1hd2FyZS4gQW4gYXR0ZW1wdA0KdG8gdmlydHVhbGl6ZSBhIGhvc3QtbWFuYWdlZCBk
cml2ZSBpbiB0aGlzIHNldHVwIGNhdXNlcyB0aGUgZHJpdmUgdG8gc2hvdyB1cA0KYXQgdGhlIGd1
ZXN0IGFzIGEgcmVndWxhciBibG9jayBkZXZpY2UgLSBjZXJ0YWlubHkgbm90IGFuIGlkZWFsIHNp
dHVhdGlvbi4NCg0KRG1pdHJ5DQo=

