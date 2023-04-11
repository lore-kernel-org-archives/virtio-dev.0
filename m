Return-Path: <virtio-dev-return-12134-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F7FC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:01:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7BA0326A37
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:01:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AF8E986601
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:01:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 60D629863A4; Tue, 11 Apr 2023 19:01:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DDA998636E;
	Tue, 11 Apr 2023 19:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjBArPAJNODtXbzIpx29rEvojVzGbBDpREv6ckYq2srmhi/dJz8dC4ht1qzmf0iXtX9I9XYl2EnVLND5qGiagnGktvtrxdJj0oLQ08HHQ4Juu2sggKhMx5rsM4h99Z05kh57QJ4PlQAQHONo2IPqnwAD+MXbaWdxpKzotL8EA+xJplMXwbQC965wjcAwep44ksTUuw6fqW6Tj4rfFyviLqg3V/pRn3uD2oa0UQR47yeooOuQB9awOwp/a+w9+yCAJyEbj10fdFAPEeZ0fltGMaeXSHFkyIcQ9B2y/OZ2Bk+FJPz8MIze5sbvarLZiZde++X5wWY3+KuiFu87UWn4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHzs0UHdeJBRUhVP9kj965/okcOzxrLGeGINnOUvzVc=;
 b=MpWMsI+IoaeOER0DHbGfzXtVpV1j2RRLrCNbv5P7DF/NgMW3c+Ih4epvurrKwgkLDTMTlNtVe4Xb4wFdFU7mkjpoP2WDHF/5x/slAxUWrPHzSUnQEc3htCUOZ2YMRIWoge2s6T9RL83d5yazkpjKL2nFcRBssIeBdwD46Nl5uvQ7fM6xCI8BY2RIAZCBNdItdJh8akIsykOM/yiNvZRhCHc/Zl9Js+4W/p52yH+jtjfC5UwEOWZKSauKZM8Gwfh6idkPkzu+8Cf1H2T5gryJcW6PGqNU23aC1lqXwl9uc9Sn8f0dV2i2VLN7hTli88lawlxc2G5iJXtvj7ysKWAyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability
Thread-Index: AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgAERMACAAKCVAIABAn+Q
Date: Tue, 11 Apr 2023 19:01:16 +0000
Message-ID:
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
In-Reply-To:
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4369:EE_
x-ms-office365-filtering-correlation-id: 6af079f6-82f4-4600-7b42-08db3abf20a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BRse+Ptr4nlfJZClESdBDgPLJMnEUv5bIhEAOHT4fsFdzLzkzOcUAXByTZvcbf77AvtMTgGrmxC5ZvmrUJi0uYJh27MBoGoV0BuFZ7PUForBk8w07X25QXxQOm+vdXy+FBBInnI4ynzuEuAvKgWO7Rr7NUbnSYH+oGGc3oD9eSiZwdtoohAN8mlq1IbZ1rBWrkJ7BJGsX3mkqRDWxqNURONwsOl3SN3EPrRsVSBAdB3Ku4z2XqBeHzJnnKA8oi0dSc1WTU2YcUfVwZh7fLjQ5v+rkE4JTdPoA9HkYEaHeYphYG9Zlo3fsx8LkL0ioRNc3wSIj9VTZqenBMIZH/45H5g9YerPptOOhi/PeNRbp0gDYvszfYzydClY0NrkAC4tQ38fkIXNMeJsfs+QGycEXu4z/xxS9YSFf+Dbqfun4YXOIVKxdWC2PEbCIkPYF+G2BAqHmpV6HOsh3rIkfacbTm0gPEkkHjdp5gd9Ji7wZBS3V7v0ciW+Dc63QYxA4N3eAyDK2sZWOQxl3H0VjyOmEXxuzWjhicUJlEMaR4eyBfxlFJxYCjWyJ4UpyOb4AHm9Q9uW55RwMr/juuAeBtZL702PGoEIRkxBX5vv14z2p9OujHtSspSD4pj0KnlCH91u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(66899021)(6506007)(9686003)(8936002)(8676002)(4326008)(86362001)(52536014)(5660300002)(71200400001)(6916009)(41300700001)(316002)(7696005)(2906002)(478600001)(76116006)(66556008)(66476007)(66946007)(66446008)(54906003)(64756008)(55016003)(38100700002)(83380400001)(26005)(122000001)(38070700005)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTc4MkVUYmkzeDN2NmNlU2hvNEcyWjhESFBsU0J6QXpzZnltZ2M5QTRvV0h6?=
 =?utf-8?B?TGwyV2cwZk9IQWNoNmErbi9mSTh0ams1L0QxNDF6UkhHWWQ0dGZaQnh5dzdw?=
 =?utf-8?B?WEgvVGlNT2F0ODc2YUZTU2loYzBpN1NXUU8wWDJXemRKaUNxTi9IVnVqMmZT?=
 =?utf-8?B?RVVRWUgwQ2xpN3hITnVmWjBKSDd0cHZWNGl1N1BycjlvZUZHdnJFY2lVSzM0?=
 =?utf-8?B?bVhUYmdKbTVCR2Ywb0lTVmhuaUdSa2ttYTJKNHlXdzdlN1hGYmRZWEdNRm1n?=
 =?utf-8?B?dWJSRDM4NDUyUWgrZXJDT1pJSzRFUHpMTit4aVg2UzZWUmkrSWhubEFyYWlP?=
 =?utf-8?B?MUNWYWVCTkFLWjdOQVorWWVBaExCcDBOOE1zOFUvR0hHSUtaUDJ1VFAwZXdh?=
 =?utf-8?B?WUJSVTR2SmwwWGxKdkk3VDlETXUzNjNrVDFYMUwvb25rRGpmZTMzUnVFMkhX?=
 =?utf-8?B?MERiZkdnU1ZwWS8zVDExOXlYUlNWZ0dyQ2s1UGhCSnp0elNpUHA3M1NOcGFQ?=
 =?utf-8?B?ZlBnWlppZW9xa0kzYjJUMVRGV0t4bWZ6V0VNLzZONHNBSXhSeVBFWXVpV2Nz?=
 =?utf-8?B?N3NueEVBdlFHUExUajhLR0NKbG44MGZyUXhPZDBVK2x6MWpJcWJJVzAxTXUr?=
 =?utf-8?B?U2tGRFVqM2lBVnpoNWhTcEZaK1lySnJGTVRNOERDOG9MSEVGek5MTnZXLzB0?=
 =?utf-8?B?UHhkZENlaTN4dXJoNXNaN2lqOFl1SXVqWUk1eWVmbHN4ZjFkRDBrTHFJL01a?=
 =?utf-8?B?cTA5eVA2b3ZvNU9MRS9FcjNSV29UT3hNZ1U3UUhHam1nQ0tRZnhpU1dOdjNZ?=
 =?utf-8?B?ZVI2bVlhVnl2YUkzSFZmY1BraFppcGxRblVNRForY0M5emZxYkFtWUpkcDZF?=
 =?utf-8?B?MGVBNXE0S3V3NXppb09jMDgxc2ZFQ1hPQ2xvSm5NZ25ycVVRcDlUUGlnN1E2?=
 =?utf-8?B?QzYxWFVnVVBZMkNuK2UyUDFMemRUV3BnK1gxbDIzMlQwKzY0dnk0RmRIdVJI?=
 =?utf-8?B?NEVlNDJ3YlNyWWVBaVdQb1o1cENOa0dvN29uR1N6YnYzc2d3SWNobDc0bUpQ?=
 =?utf-8?B?WDVlSk9mV01LdUduTGgreGw5N0huaXZiSXAweVBCUldxdXdMUTNaUHpManpn?=
 =?utf-8?B?bWN4UFdydk1rR0wxZXJWMjdDdkR1Y0hOTlB5OGh2RmVJVXZMTHpweVB2OCty?=
 =?utf-8?B?RHBUTFNSREpCTkZnMFYwWlg1QkRxT2FaYmZUd2p2c0JMMjVybFcvcUtTS1Yy?=
 =?utf-8?B?SXFPSDE3MHJKMVZSSUw3eWdjRStaeFdjQm5HODUraFRpTEpNU280UWhHUGlY?=
 =?utf-8?B?dHhzdVpZZmk5amlhK3EwRU1hN1Q5SmZzeTJBQVhRNXYwNEtvVFJ3SW85NUJL?=
 =?utf-8?B?eXh4SDdoRlY4LzkwQmZFK0w1Mll3bC9CVnpPbW9vZzFHZS9KaTNwZWJrV3c0?=
 =?utf-8?B?M1ZMMWRybWU2YlNPYU5NVjFIdzI5R291RGJKM1R0akFURTBjZWdnRy9welFu?=
 =?utf-8?B?SWI4bHNINU5jNlhMSURrUmxHTnI0UkNTeitGN1RTRzNFT3lOMnJxTmM1VFkx?=
 =?utf-8?B?Wkx3RVNOZnZpd0oxZlh5eXRHZTl0ZmJNY3B4VjdmazRmN3pIVUlEVWxScmJE?=
 =?utf-8?B?dUE4MWR1RUkzRmZhTzNMSjdaWGhMaW5veGltd3pqNGIwdHJnVGxZQzY0a2Z1?=
 =?utf-8?B?UVdsMHFXcURGaTAxbXZ4S0hNSTgzTDUzdDljNGxjbFBmZG94UmI3ZGhjOVFW?=
 =?utf-8?B?SzZKd21nT2hLekMwT1VkUExqMTRnMTBxSU0xdm15YmdiZHNKMTh6cExpSFVj?=
 =?utf-8?B?a0pDSFA2cjRtRVpybWhTbVkrNHIwQWRrakVvQlV5RllQbC9VdGNnMEZCTS9B?=
 =?utf-8?B?STVybUJ3YXgyaVY1OCtRcENuZUpMVmVtaWEwQ3Nyak9oZGl6bTEyd3BQYitO?=
 =?utf-8?B?RjNnQmdZZitYdGx1Q01WUkVodm54eUZxRzlCd1YvVzl6Y3JQYkY2b3MvMFhG?=
 =?utf-8?B?bHMxZkViK1pmckZwWWgzY09ob3RBaUhreWdOTkJyOWVYR1dpWkF5SkNiVE5O?=
 =?utf-8?B?M3FPU3JrdVJHaUJOUFQ4aVRFcDlRY1hBTEU1V21SUGFWNjBSVm40SDFKMEY3?=
 =?utf-8?Q?7r/o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af079f6-82f4-4600-7b42-08db3abf20a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 19:01:16.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPeMnJlTECGtS3tV61w022flIcBd9evgOGIRvlQpOYSjjomVeWo717RziICvL5a9t6h8SnaRYNXpXHnRMrw8zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
Subject: RE: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

DQo+IEZyb206IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmcgPHZpcnRpby1kZXZAbGlz
dHMub2FzaXMtb3Blbi5vcmc+IE9uDQo+IEJlaGFsZiBPZiBKYXNvbiBXYW5nDQo+IFNlbnQ6IE1v
bmRheSwgQXByaWwgMTAsIDIwMjMgMTE6MjkgUE0NCg0KPiA+IEhvd2V2ZXIsIGl0IGlzIG5vdCBi
YWNrd2FyZCBjb21wYXRpYmxlLCBpZiB0aGUgZGV2aWNlIHBsYWNlIHRoZW0gaW4NCj4gPiBleHRl
bmRlZCBjYXBhYmlsaXR5LCBpdCB3aWxsIG5vdCB3b3JrLg0KPiA+DQo+IA0KPiBJdCBpcyBraW5k
IG9mIGludGVuZGVkIHNpbmNlIGl0IGlzIG9ubHkgdXNlZCBmb3IgbmV3IFBDSS1FIGZlYXR1cmVz
Og0KPiANCk5ldyBmaWVsZHMgaW4gbmV3IGV4dGVuZGVkIHBjaSBjYXAgYXJlYSBpcyBmaW5lLg0K
TWlncmF0aW5nIG9sZCBmaWVsZHMgdG8gYmUgcHJlc2VudCBpbiB0aGUgbmV3IGV4dGVuZGVkIHBj
aSBjYXAsIGlzIG5vdCB5b3VyIGludGVudGlvbi4gUmlnaHQ/DQoNCj4gIg0KPiArVGhlIGxvY2F0
aW9uIG9mIHRoZSB2aXJ0aW8gc3RydWN0dXJlcyB0aGF0IGRlcGVuZCBvbiB0aGUgUENJIEV4cHJl
c3MNCj4gK2NhcGFiaWxpdHkgYXJlIHNwZWNpZmllZCB1c2luZyBhIHZlbmRvci1zcGVjaWZpYyBl
eHRlbmRlZCBjYXBhYmlsaXRpZXMNCj4gK29uIHRoZSBleHRlbmRlZCBjYXBhYmlsaXRpZXMgbGlz
dCBpbiBQQ0kgRXhwcmVzcyBleHRlbmRlZCBjb25maWd1cmF0aW9uDQo+ICtzcGFjZSBvZiB0aGUg
ZGV2aWNlLg0KPiAiDQo+IA0KPiA+IFRvIG1ha2UgaXQgYmFja3dhcmQgY29tcGF0aWJsZSwgYSBk
ZXZpY2UgbmVlZHMgdG8gZXhwb3NlIGV4aXN0aW5nDQo+ID4gc3RydWN0dXJlIGluIGxlZ2FjeSBh
cmVhLiBBbmQgZXh0ZW5kZWQgc3RydWN0dXJlIGZvciBzYW1lIGNhcGFiaWxpdHkNCj4gPiBpbiBl
eHRlbmRlZCBwY2kgY2FwYWJpbGl0eSByZWdpb24uDQo+ID4NCj4gPiBJbiBvdGhlciB3b3Jkcywg
aXQgd2lsbCBoYXZlIHRvIGJlIGEgYm90aCBwbGFjZXMuDQo+IA0KPiBUaGVuIHdlIHdpbGwgcnVu
IG91dCBvZiBjb25maWcgc3BhY2UgYWdhaW4/IA0KTm8uIA0KT25seSBjdXJyZW50bHkgZGVmaW5l
ZCBjYXBzIHRvIGJlIHBsYWNlZCBpbiB0d28gcGxhY2VzLg0KTmV3IGZpZWxkcyBkb27igJl0IG5l
ZWQgdG8gYmUgcGxhY2VkIGluIFBDSSBjYXAsIGJlY2F1c2Ugbm8gZHJpdmVyIGlzIGxvb2tpbmcg
dGhlcmUuDQoNCldlIHByb2JhYmx5IGFscmVhZHkgZGlzY3Vzc2VkIHRoaXMgaW4gcHJldmlvdXMg
ZW1haWwgYnkgbm93Lg0KDQo+IE90aGVyd2lzZSB3ZSBuZWVkIHRvIGRlYWwgd2l0aCB0aGUNCj4g
Y2FzZSB3aGVuIGV4aXN0aW5nIHN0cnVjdHVyZXMgd2VyZSBvbmx5IHBsYWNlZCBhdCBleHRlbmRl
ZCBjYXBhYmlsaXR5LiBNaWNoYWVsDQo+IHN1Z2dlc3QgdG8gYWRkIGEgbmV3IGZlYXR1cmUsIGJ1
dCB0aGUgZHJpdmVyIG1heSBub3QgbmVnb3RpYXRlIHRoZSBmZWF0dXJlDQo+IHdoaWNoIHJlcXVp
cmVzIG1vcmUgdGhvdWdodC4NCj4gDQpOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgZmVhdHVyZSBiaXQu
DQpQQ0kgdHJhbnNwb3J0IGZpZWxkcyBleGlzdGVuY2UgaXMgdXN1YWxseSBub3QgZGVwZW5kZW50
IG9uIHVwcGVyIGxheWVyIHByb3RvY29sLg0KDQo+ID4gV2UgbWF5IG5lZWQgaXQgZXZlbiBzb29u
ZXIgdGhhbiB0aGlzIGJlY2F1c2UgdGhlIEFRIHBhdGNoIGlzIGV4cGFuZGluZw0KPiA+IHRoZSBz
dHJ1Y3R1cmUgbG9jYXRlZCBpbiBsZWdhY3kgYXJlYS4NCj4gDQo+IEp1c3QgdG8gbWFrZSBzdXJl
IEkgdW5kZXJzdGFuZCB0aGlzLCBhc3N1bWluZyB3ZSBoYXZlIGFkbWlucSwgYW55IHJlYXNvbiBh
DQo+IGRlZGljYXRlZCBwY2llIGV4dCBjYXAgaXMgcmVxdWlyZWQ/DQo+IA0KTm8uIGl0IHdhcyBt
eSBzaG9ydCBzaWdodC4gSSByZXNwb25kZWQgcmlnaHQgYWZ0ZXIgYWJvdmUgdGV4dCB0aGF0IEFR
IGRvZXNu4oCZdCBuZWVkIGNhcCBleHRlbnNpb24uDQo=

