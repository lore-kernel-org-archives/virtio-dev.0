Return-Path: <virtio-dev-return-13662-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A55EE801F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:47:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2884E1318C6
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:47:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 243BD98665C
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:47:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 17582981BDD; Mon, 11 Sep 2023 06:47:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0610D98635C;
	Mon, 11 Sep 2023 06:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxEAmUGpQN+0RoFYbQKOfaCyg+MGT1W0Q7vQ2SzmUC+EmUb4m7ls8y215+Lc/e2Hqc8qDHNstGud+lF4ww1a7r6BWiCIGSjJU5UI9ztyCs0wpud7yNe6CjPVMciSrbL5vwq3md7d1Axb8SJmMeHMXteheFF/0+67ALSvMQvsWPD5uMPspL/7DpkSh2e75MkyfmsevUMga1NQwCsYMFexLg7iJDS4ontA+D7DxHcbzSgWFEg5sUtsxkbRxuZt2Hlqeg6eDMPMloBqcpFZ4OUppqpJ/Sii+RLL6N5zv5Y9Xw1FkoTiMzdppzmsPLHjBrhnuFq8IeNvlOyUnzTW7hYimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdgv/j8EX0L4tciIH33ZRJuGJcEqbfp6CPSfTRPFih0=;
 b=KLIqorTdW8s+dCpmrfVRXf4vrwaf/ob7rZyrq75SuHdhouaqsRXDfpL9CLTT5oKQtWzjGsqgIHj/b/z/XpO7a4sScKjXJD2JSUJmxR/P7vL8sMP3MT2KP0KyQmcu6Z9bigDGZR1rJpG4s1xPzp5WbwNpO3j6K/8oZ0whvhFTrofGffnscpq1XNOTb4pGRHN/194G+pbo7TWY5ATnlEGBn1/AXjaoeXpitEXQpYajJGABGW38CXiQWUK1Z6WGjHFUR6pDMZbRfEwlqOuCT3wqNFnfKEOhdzEfB4ajwkqfFYspGuJVw/625KZpZYO4iTKaf+EUy3Az/JN6DUHM/mCkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index: AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQ
Date: Mon, 11 Sep 2023 06:47:43 +0000
Message-ID:
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
In-Reply-To:
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5294:EE_
x-ms-office365-filtering-correlation-id: 8c590104-7ee6-4a3f-277e-08dbb2930048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HRTo76fkFJNKalkAzJfpOp6XzrUYEQHTn+nHGr+RM1d//YiHGCLCxBc6wNcNiYHzsGZtjVWB1g59KvcjRL0frqpYiV53x4aJ+pYCV2lsy1/KGGFszOwcT7PYApjiGlOGsIC27QVLbheRB5BjRSZrV+xwiXgIxQWK41F1ELQlznE+DrOZq4XiUVXsUJBLTBG009TKLCsoC8LhOzKlup8747h+PoxcsdhWBrZ64wZwQ8YomriLrsRKCo7wDnMw44qIP8cZ05fJvOkgCU7YUOOSVgWsqbfH17JhErZK93EEd47wYOPgRlPVAES+qrc+HtrRmHNFthHHIbdAx/CrvNwis2C3/MzjuOwNt1fBpuZon+b5HOAiZSXlu3t1pE9tfDJnsxtRcnFebKpqfEflye9g5B5dH8p0ZSuKLj4yLUZe/mjwzNEA6efSswaM8qu5dU6lhVSMw1r0leS7t8viM7uNKaek93vEkSG05jz+YySPnIYueHkyzD8uDnyd0WRQLSilc/MGaXUBvn+pQyRfVpKwSN9tYpSBSEJ1+sN4qntQEe8mTcyN+RsFfaNb+VW8icsecBoCVxlliVZm7F0Fq2u8jYi5PLEFqRvWWluYRJGLgAfnqHt6Lz6/a2cO06QhPk2VyGXHk1UFlifHp1owG3ykCjWtiBkDDNykAifhmPM9B3s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199024)(186009)(1800799009)(5660300002)(52536014)(66946007)(6916009)(316002)(41300700001)(54906003)(66446008)(8676002)(8936002)(4326008)(66556008)(64756008)(66476007)(76116006)(38100700002)(122000001)(966005)(478600001)(55016003)(71200400001)(33656002)(7696005)(6506007)(53546011)(86362001)(2906002)(83380400001)(38070700005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WitqVXcvUzVOa0wyVjlPZk5TdlY3eWpDdUJMWllSYjlVZlFhMnh4cjV6bWxv?=
 =?utf-8?B?NDQ1UVMxK0RjMjV1eHZJUWFWUU1OUEd4YmswK1RyQlloYUF0amcvYTRJZVVX?=
 =?utf-8?B?SkpQVVU0QU5aaUkveTlSSnZYbGtySFJwa05HWm9oUzUrQWF2VS9aS2J0Zm5D?=
 =?utf-8?B?Sm42ZDNGeHZLZVZpZnBCbCtRY05LMEU3Zjl4Z2NHOUM4SytuOHNmWUw2T2Ur?=
 =?utf-8?B?eDdjbGo3dXlFOEVSeGVKZ2Zpd01FckNmNWZCL3cxaGhYeWRQL3hIUklMTnNG?=
 =?utf-8?B?NmZUaHR1T3JxT0UxSkY4T1IzTXFLOHRuU0IwSGh1K1VGaXhkZUF2YVc1d1V6?=
 =?utf-8?B?NE03UnNsSWZ2NDR2YVFEcWdyYUovMGR0ZTZIVC8xZlYzQ3VhejBCRWR6Vy9i?=
 =?utf-8?B?enBLc0IvVzZQdXFOS25jcjNYSDRWS3dwR0NaM2Z0Z3NMZHlBSkZOSW9rN0pt?=
 =?utf-8?B?dFdWbjFZUDMyK25DNENOMWZRbjJSbnZNYUFRbzh1a1JqMkxOYjBBcE16Y3lQ?=
 =?utf-8?B?bklWbVhzNFQrb2lDNy9mUHJDM0hNT2EwdnFpWHFMZlhMV1J5azQyZE1ub3Bj?=
 =?utf-8?B?ZUxrLy9SK3M5YU1jWjI3djJyeHN3MzN2bnExWDVMTk1xek5UcE5lenVhQUtx?=
 =?utf-8?B?ck1JTThRMExDTjR1b0FKMmVyclJvUDRFSUR0VVpwYUtqVXlBSS9oY1FReDZw?=
 =?utf-8?B?b2prMEwxSktjbGM1MVU1RlFtTmhiQzlNa2RyWHR4SXRVTDBlcWpPdjZqdFNh?=
 =?utf-8?B?NXdVRCtXcWE5ZUp4aUpybGl3TWF6UWVpdm9sRWFjenFDaEVhbHh5bnMrQStM?=
 =?utf-8?B?Wk1hUGEvc2pGN1hrTmc1Nm5pNXhvb3l3RVo0TWNzYnN3SERNUHJ5UzZnRlVp?=
 =?utf-8?B?Z3RQV3FRUkMrZ2lZN1I5TDNuNzBXUlQ4Nmx3dS9GeVd4ZFY3T2cveldTN2ow?=
 =?utf-8?B?SGlwOENEMjFodXN6dnZqaWcrd2JpRzZNK1Z0bGp4RTBURmkzeE0vUzVHVkov?=
 =?utf-8?B?M3FYTG5SQ0h4OThWYmVKTDhLUjdlU0tCd3ZYaElsOHh5M3ZXYlZzMFRaYm1T?=
 =?utf-8?B?RVlvM0k1Y2V3MllTV1RyTi9STW1qeTJ2QlR3YTNJbVpMV2poNWF1ZzJXQTZL?=
 =?utf-8?B?RzdqVFVBTForajFIb0M3NDU4dTdWSU1VR3pqU2lmNTh6NllnS1FEK3pTaDB3?=
 =?utf-8?B?b3cvSWpHUk9JbkFyMkpXaWV3dGdCVjRjOER3VTBlZTNEZ2NEZDArV0VGb01l?=
 =?utf-8?B?aHBCWGhJcHhUckRkZXRaQkZkeGNkK1FhTlVVWjlXdmczMlJ5dm5iWGhFdVo0?=
 =?utf-8?B?ODg2Nzl2b1Y0QW9oeGd6V1gySUtKUzBobEZFcXFzcHJSOHF6NStCRVBLYXE5?=
 =?utf-8?B?ckxhWWs4YnVSWktTMm5oWDhXeEFsVUIzMmx6ZHR5dUZ0TG9NWG5hdXJudUsy?=
 =?utf-8?B?cGtGWld5MXZQVis0c21TcXVEWjBoQ1JqMnc0ODdSNE9qWHNZaHlzMHI1c2NT?=
 =?utf-8?B?Tnpqd3BKbW5zeHZ6VHFjSUtvR1VCUkZvVkNJM3hQZlBmRDFadWMvMEttOUxk?=
 =?utf-8?B?TjJUL3NYWXFJMklNYS9ENkpwci9zcHdHUWI0alkxa3ErcWJsTmdrNXpOMHF6?=
 =?utf-8?B?YzhSOCtFcUt5NjR2RExqdWlRQndiMGNUVmdnbzZVNmJpQXNZZXQrVmNzOG9D?=
 =?utf-8?B?QjkzRVg1Q1lIdVdCTDY4ZWNGTklOZUZrdVh1YytIYnhNdG9EeThZbDBGbDBG?=
 =?utf-8?B?eURkaDNKSmNJZC9ZZXMxbHdBSHVncFNGZFJIS3dYMlZSREJadHEzZ1hYa2pJ?=
 =?utf-8?B?dmRURlpFV2JaUHA2R0tYWmMvRHhaZDBITWZqR0VyQ2JJQzNDdTJ2cnVxQTU4?=
 =?utf-8?B?aFZwVXhMTUJPclNwSGlEc0NaVkM5ZzVXQ2loSFR3VFVxVHJML0pURzNJVUZM?=
 =?utf-8?B?MzRNdG9kbVNITmZicFdUejE4cDJaYjM3eTgyazRzMWE0bTBRZlg2TzBTek85?=
 =?utf-8?B?Yk84STJuZ3lYN3RqbDNHUURrK2Y2bU1XYTMzNDBwbWk3KzRMTmphaGVRVWhu?=
 =?utf-8?B?SXJlVGlnMTlnbGNxZHB1YmttSi9Kb0JjUExjdDF6ZHZRU3NNZU8zaXMzQ1I4?=
 =?utf-8?B?OWk1USsxRTdXNUF5ZllieURHZXdhUmtLakkvZDhHNzNSRVA5cS9hV2FQZHBI?=
 =?utf-8?Q?Gqa97eWVt3CS5bBx97bVzOar4tSuoLw1QLaSaFwb2h4s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c590104-7ee6-4a3f-277e-08dbb2930048
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 06:47:43.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxYwJ+CPDo30wAUe6HBXQeC9MLLmvYxziUjJ9NGiGt8HMz3OhBAidM9PbBjSjtPWe85vDLjKW+s1a5QrS3Kqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjMgMTI6MDEgUE0NCj4gDQo+IE9uIE1vbiwgU2VwIDExLCAy
MDIzIGF0IDEyOjEy4oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEhpIE1pY2hhZWwsDQo+ID4NCj4gPiA+IEZyb206IHZpcnRpby1jb21tZW50QGxp
c3RzLm9hc2lzLW9wZW4ub3JnDQo+ID4gPiA8dmlydGlvLWNvbW1lbnRAbGlzdHMub2FzaXMtIG9w
ZW4ub3JnPiBPbiBCZWhhbGYgT2YgSmFzb24gV2FuZw0KPiA+ID4gU2VudDogTW9uZGF5LCBTZXB0
ZW1iZXIgMTEsIDIwMjMgODozMSBBTQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgU2VwIDYsIDIwMjMg
YXQgNDozM+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIFNlcCAwNiwgMjAyMyBhdCAwNDoxNjozN1BNICsw
ODAwLCBaaHUgTGluZ3NoYW4gd3JvdGU6DQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHR3byBu
ZXcgbGUxNiBmaWVsZHMgdG8gY29tbW9uIGNvbmZpZ3VyYXRpb24NCj4gPiA+ID4gPiBzdHJ1Y3R1
cmUgdG8gc3VwcG9ydCBWSVJUSU9fRl9RVUVVRV9TVEFURSBpbiBQQ0kgdHJhbnNwb3J0IGxheWVy
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJIGRvIG5vdCBz
ZWUgd2h5IHRoaXMgd291bGQgYmUgcGNpIHNwZWNpZmljIGF0IGFsbC4NCj4gPiA+DQo+ID4gPiBU
aGlzIGlzIHRoZSBQQ0kgaW50ZXJmYWNlIGZvciBsaXZlIG1pZ3JhdGlvbi4gVGhlIGZhY2lsaXR5
IGlzIG5vdCBzcGVjaWZpYyB0byBQQ0kuDQo+ID4gPg0KPiA+ID4gSXQgY2FuIGNob29zZSB0byBy
ZXVzZSB0aGUgY29tbW9uIGNvbmZpZ3VyYXRpb24gb3Igbm90LCBidXQgdGhlDQo+ID4gPiBzZW1h
bnRpYyBpcyBnZW5lcmFsIGVub3VnaCB0byBiZSB1c2VkIGJ5IG90aGVyIHRyYW5zcG9ydHMuIFdl
IGNhbg0KPiA+ID4gaW50cm9kdWNlIG9uZSBmb3IgTU1JTyBmb3Igc3VyZS4NCj4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+IEJ1dCBiZXNpZGVzIEkgdGhvdWdodCB3b3JrIG9uIGxpdmUgbWlncmF0aW9u
IHdpbGwgdXNlIGFkbWluIHF1ZXVlLg0KPiA+ID4gPiBUaGlzIHdhcyBleHBsaWNpdGx5IG9uZSBv
ZiB0aGUgbW90aXZhdG9ycy4NCj4gPiA+DQo+ID4gUGxlYXNlIGZpbmQgdGhlIHByb3Bvc2FsIHRo
YXQgdXNlcyBhZG1pbmlzdHJhdGlvbiBjb21tYW5kcyBmb3IgZGV2aWNlDQo+IG1pZ3JhdGlvbiBh
dCBbMV0gZm9yIHBhc3N0aHJvdWdoIGRldmljZXMuDQo+ID4NCj4gPiBbMV0NCj4gPiBodHRwczov
L2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwOS9tc2cw
MDA2MS5oDQo+ID4gdG1sDQo+IA0KPiBUaGlzIHByb3Bvc2FsIGNvdXBsZXMgbGl2ZSBtaWdyYXRp
b24gd2l0aCBzZXZlcmFsIHJlcXVpcmVtZW50cywgYW5kIHN1ZmZlcnMgZnJvbQ0KPiB0aGUgZXhh
Y3QgaXNzdWVzIEkndmUgbWVudGlvbmVkIGJlbG93Lg0KPg0KSXQgZG9lcyBub3QuDQpDYW4geW91
IHBsZWFzZSBsaXN0IHdoaWNoIG9uZT8NCiANCj4gSW4gc29tZSBjYXNlcywgaXQncyBldmVuIHdv
cnNlIChjb3VwbGluZyB3aXRoIFBDSS9TUi1JT1YsIHNlY29uZCBzdGF0ZSBtYWNoaW5lDQo+IG90
aGVyIHRoYW4gdGhlIGRldmljZSBzdGF0dXMpLg0KPiANClRoZXJlIGlzIG5vIHN0YXRlIG1hY2hp
bmUgaW4gWzFdLg0KSXQgaXMgbm90IGNvdXBsZWQgd2l0aCBQQ0kvU1ItSU9WIGVpdGhlci4NCkl0
IHN1cHBvcnRzIFBDSS9TUi1JT1YgdHJhbnNwb3J0IGFuZCBpbiBmdXR1cmUgb3RoZXIgdHJhbnNw
b3J0cyB0b28gd2hlbiB0aGV5IGV2b2x2ZS4NCg0KPiA+DQo+ID4gID4gSSB0aGluayBub3QuIFVz
aW5nIGFkbWluIHZpcnRxdWV1ZSB3aWxsIGVuZCB1cCB3aXRoIHNldmVyYWwgcHJvYmxlbXM6DQo+
ID4gPg0KPiA+ID4gMSkgdGhlIGZlYXR1cmUgaXMgbm90IHNlbGYgY29udGFpbmVkIHNvIGF0IHRo
ZSBlbmQgd2UgbmVlZCB0cmFuc3BvcnQNCj4gPiA+IHNwZWNpZmljIGZhY2lsaXR5IHRvIG1pZ3Jh
dGUgdGhlIGFkbWluIHZpcnRxdWV1ZQ0KPiA+DQo+ID4gWW91IG1peGVkIHVwLg0KPiA+IEFkbWlu
IHF1ZXVlIG9mIHRoZSBvd25lciBkZXZpY2UgaXMgbm90IG1pZ3JhdGVkLg0KPg0KSWYgeW91IGFj
dHVhbGx5IHJlYWQgbW9yZSwgaXQgaXMgZm9yIHRoZSBtZW1iZXIgZGV2aWNlIG1pZ3JhdGlvbiBh
bmQgbm90IHRoZSBvd25lci4NCkhlbmNlLCBvd25lciBkZXZpY2UgYWRtaW4gcXVldWUgaXMgbm90
IG1pZ3JhdGVkLg0KIA0KPiBXaHkgbm90PyBMaW5nIFNoYW4ncyBwcm9wb3NhbCBtYWtlcyBldmVy
eXRoaW5nIHdvcmsgaW5jbHVkaW5nIG1pZ3JhdGluZyB0aGUNCj4gb3duZXIgb3IgaW4gdGhlIGNh
c2UgdGhlcmUncyBldmVuIG5vIG93bmVyLg0KPiANCkkgZG9u4oCZdCBzZWUgaW4gaGlzIHByb3Bv
c2FsIGhvdyBhbGwgdGhlIGZlYXR1cmVzIGFuZCBmdW5jdGlvbmFsaXR5IHN1cHBvcnRlZCBpcyBh
Y2hpZXZlZC4NCg0KPiBJbiB0aGlzIHByb3Bvc2FsLCB0aGUgZmFjaWxpdHkgKHN1c3BlbmRpbmcs
IHF1ZXVlIHN0YXRlLCBpbmZsaWdodA0KPiBkZXNjcmlwdG9ycykgaXMgZGVjb3VwbGVkIGZyb20g
dGhlIHRyYW5zcG9ydCBzcGVjaWZpYyBBUEkuIEVhY2ggdHJhbnNwb3J0IGNhbg0KPiBpbXBsZW1l
bnQgb25lIG9yIG1vcmUgdHlwZXMgb2YgaW50ZXJmYWNlcy4gQSBNTUlPIGJhc2VkIGludGVyZmFj
ZSBpcw0KPiBwcm9wb3NlZCBidXQgSXQgZG9lc24ndCBwcmV2ZW50IHlvdSBmcm9tIGFkZGluZyBh
ZG1pbiBjb21tYW5kcyBmb3IgdGhvc2UNCj4gZmFjaWxpdGllcyBvbiB0b3AuDQo+DQpFdmVuIGlu
IHByb3Bvc2FsIFsxXSBtb3N0IHRoaW5ncyBhcmUgdHJhbnNwb3J0IGFnb25pc3RpYy4NCk1lbWJl
ciBkZXZpY2UgcHJvcG9zYWwgY292ZXJzIHNldmVyYWwgYXNwZWN0cyBhbHJlYWR5IG9mIGRvd250
aW1lLCBwZWVyIHRvIHBlZXIsIGRpcnR5IHBhZ2UgdHJhY2tpbmcsIGVmZmljaWVudCBxdWVyeWlu
ZyBWUSBzdGF0ZSBhbmQgbW9yZS4NCg0KDQo+ID4gQWRtaW4gcXVldWUgb2YgdGhlIG1lbWJlciBk
ZXZpY2UgaXMgbWlncmF0ZWQgbGlrZSBhbnkgb3RoZXIgcXVldWUgdXNpbmcNCj4gYWJvdmUgWzFd
Lg0KPiA+DQo+ID4gPiAyKSB3b24ndCB3b3JrIGluIHRoZSBuZXN0ZWQgZW52aXJvbm1lbnQsIG9y
IHdlIG5lZWQgY29tcGxpY2F0ZWQNCj4gPiA+IFNSLUlPViBlbXVsYXRpb24gaW4gb3JkZXIgdG8g
d29yaw0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gUG9raW5nIGF0IHRoZSBkZXZpY2UgZnJvbSB0
aGUgZHJpdmVyIHRvIG1pZ3JhdGUgaXQgaXMgbm90IGdvaW5nIHRvDQo+ID4gPiA+IHdvcmsgaWYg
dGhlIGRyaXZlciBsaXZlcyB3aXRoaW4gZ3Vlc3QuDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBieSBk
ZXNpZ24gdG8gYWxsb3cgbGl2ZSBtaWdyYXRpb24gdG8gd29yayBpbiB0aGUgbmVzdGVkIGxheWVy
Lg0KPiA+ID4gQW5kIGl0J3MgdGhlIHdheSB3ZSd2ZSB1c2VkIGZvciBDUFUgYW5kIE1NVS4gQW55
dGhpbmcgbWF5IHZpcnRpbw0KPiA+ID4gZGlmZmVyZW50IGhlcmU/DQo+ID4NCj4gPiBOZXN0ZWQg
YW5kIG5vbi1uZXN0ZWQgdXNlIGNhc2VzIGxpa2VseSBjYW5ub3QgYmUgYWRkcmVzc2VkIGJ5IHNp
bmdsZQ0KPiBzb2x1dGlvbi9pbnRlcmZhY2UuDQo+IA0KPiBJIHRoaW5rIExpbmcgU2hhbidzIHBy
b3Bvc2FsIGFkZHJlc3NlZCB0aGVtIGJvdGguDQo+DQpJIGRvbuKAmXQgc2VlIGhvdyBhbGwgYWJv
dmUgcG9pbnRzIGFyZSBjb3ZlcmVkLg0KDQogDQo+ID4gU28gYm90aCBhcmUgb3J0aG9nb25hbCBy
ZXF1aXJlbWVudHMgdG8gbWUuDQo+ID4NCj4gPiBPbmUgY2FuIGRlZmluZWQgc29tZSBhZG1pbmlz
dHJhdGlvbiBjb21tYW5kcyB0byBpc3N1ZSBvbiB0aGUgQVEgb2YgdGhlDQo+IG1lbWJlciBkZXZp
Y2UgaXRzZWxmIGZvciBuZXN0ZWQgY2FzZS4NCj4gDQo+IFRoaXMgaXMgbm90IGVhc3ksIERNQSBu
ZWVkcyB0byBiZSBpc29sYXRlZCBzbyB0aGlzIG1lYW5zIHlvdSBuZWVkIHRvIGVpdGhlcg0KPiBl
bXVsYXRlIFNSLUlPViBhbmQgdXNlIEFRIG9uIHZpcnR1YWwgUEYgaW4gdGhlIGd1ZXN0IG9yIHVz
aW5nIFBBU0lELg0KPg0KVGhpcyBpcyB3aHkgbmVzdGVkIGFuZCBub24tbmVzdGVkIGNhbm5vdCBi
ZSB0cmVhdGVkIGVxdWFsbHkgYW5kIEkgZG9u4oCZdCBzZWUgdGhpcyBhbGwgY292ZXJlZCBpbiBM
aW5nIHByb3Bvc2FsIGVpdGhlci4NCkZvciBwYXNzdGhyb3VnaCBkZXZpY2UgdXNlIGNhc2UgWzFd
IGhhcyBjb3ZlcmVkIHRoZSBuZWNlc3NhcnkgcGllY2VzLg0KDQo+IEN1c3RvbWVycyBkb24ndCB3
YW50IHRvIGhhdmUgYWRtaW4gc3R1ZmYsIFNSLUlPViBvciBQQVNJRCBpbiB0aGUgZ3Vlc3QgaW4g
b3JkZXINCj4gdG8gbWlncmF0ZSBhIHNpbmdsZSB2aXJ0aW8gZGV2aWNlIGluIHRoZSBuZXN0Lg0K
DQpBcyBwcm9wb3NlZCBpbiBbMV0gZm9yIHBhc3MgdGhyb3VnaCBkZXZpY2VzIG5vIGN1c3RvbWVy
IG5lZWRzIHRvIGRvIFNSLUlPViBvciBQQVNJRCBpbiB0aGUgZ3Vlc3QgZm9yIG5vbi1uZXN0Lg0K
DQpOZXN0ZWQgaXMgc29tZSBzcGVjaWFsIGNhc2UgYW5kIGxpa2VseSBuZWVkIG1lZGlhdGVkIGJh
c2VkIHNjaGVtZSB1c2luZyBhZG1pbmlzdHJhdGlvbiBjb21tYW5kcy4NCg0KSW4gYmVzdCBjYXNl
IHdlIGNhbiBwcm9kdWNlIGNvbW1vbiBjb21tYW5kcywgaWYgdGhhdCBmaXRzLiANCkVsc2UgYm90
aCBwcm9wb3NhbHMgYXJlIG9ydGhvZ29uYWwgYWRkcmVzc2luZyBkaWZmZXJlbnQgdXNlIGNhc2Vz
Lg0K

