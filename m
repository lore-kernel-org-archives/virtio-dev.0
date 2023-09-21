Return-Path: <virtio-dev-return-13901-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B7ACD494B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A7801CA254
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FC7A986692
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:20:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0C6A4983D6F; Thu, 21 Sep 2023 04:20:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D268B98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWbzApsNxXmjOno+FrszCyEw0HX12P6mc23Vv1vuueU/CYzw8qaegNn7k6Y5skEv8R+fuI//4BOGVanPWu11E2225RElfpNKCbPJayG2rU8JpzTJNtcdQ4gl3xOuyhqo0i0Seg+/4Zhldab/TmwpwK7OAtVDEG9LX0qt3uPWRKp8smMWbXzA1WqcUbOB9yLMS21k1lPmG/JWBXN0jPud+9TPaQ/+Btd3eZjJ5E3OsgxZR8P+03MrKpq2uQD9xb965VIfyOScXuK9WOTGHR5tCPiMBWv5kx+beiuqwF/klcr9MdI81aFT4jxwUEGMN1YmbxfUPTHdZ7cIPfPUneEiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHZHi7bLBCu9Wcs+j/uoteZPF6MLbyQsmW+k50S+rSM=;
 b=D+o3PD/u9nRiWo91G4WfBDTE52KqvBSxp1fDJAjKS4vg2DgQ1i4SR7eJgOH5n508UE9W1/DKuOaciYOh9mzN3hc7gO9jG2W9pEq3729OnutvlIE3YsdpcEMVcMHdHdHyMpPZfMD91cmFm79O5SF6djx93SKckibhHmVqLiqbLUUZlwSmTCRHyblQdnHJ4ww/ZrtS3tOHBSz2W30nReyFOFWLWxG5GDvjjsMdbnZ+JePn1Ur/PUCn4FtF0ynpBwKbtzvasIWn8mwdoLjG1SsSWLxCJAMU+1kPWev0bhC6YJPZdA/CBkg5eM39lwnmqeNDmj3lAVCU1uQH3jiZhF05Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsIAABJcAgAAA3EA=
Date: Thu, 21 Sep 2023 04:19:46 +0000
Message-ID:
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
In-Reply-To:
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6684:EE_
x-ms-office365-filtering-correlation-id: 3bae1a43-cb6c-4db3-18dd-08dbba59fce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FE9FFeFGcaCNjr3qUgze/0AIdxAWFCPn2juGULVNVVtJ7hEBNNMXGvhp7Up8on9ZaSxQ0h3DEJf4VdZyV0+omUYyljWFuXaN/hSxqNncxOVa6n2SnVDiTJkjgdVaFxnHq0tXuPKD4U1obppO9j+/7n4AdX86kK4DYGxhdihMNqe/yKuSu2xEnat2vSKXrzWJLROzsBEeJGM7x/Eb98hPpGEb8lvP95OA2eXYTywFpJNH7tKtugMmMaZ4XNXIY8opoDn8Wt5NoZU2Zb2ch8AfyS7v4wrVbMcYSY7xwvs4zIY1sWurSlVZ1tkry8usFRVaIBjtKvyfbO01zdpmPLLaBWdNG+HKAGdivHYfl6ik+3NiBTKNhtJ1KwVVhqdA6oIDUD+sswnfTfqFrs/5EBeItH+lkRWWQm9VNDz7LppWlOoRvFatw7CqC5ezrbR885EJN570AoIid1DhalTc84qWFAvAN1iIpldHx2oUUZZPQ/CGvwcsH0uMFTlER0FRctrgXnz6cBxZLt4onBb19h3YpuHVLqAL6QRO95oUV/bYnHCQxUzM0yQsM8xrn1mAKCHNTkBv+5aVJg8fwLhOuBuk/HqMZc3Cpc1nzGTTGuoLV6LYkkpIwp5ybhxfOrq8vYAjgqYKyw4JFizmOUj2aFGTqLeypLI4yFOA5LlosjtlR94=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(451199024)(26005)(52536014)(8676002)(8936002)(122000001)(4326008)(15650500001)(83380400001)(33656002)(2906002)(5660300002)(55016003)(86362001)(6506007)(53546011)(7696005)(55236004)(966005)(71200400001)(6916009)(64756008)(9686003)(54906003)(66476007)(478600001)(66946007)(76116006)(66556008)(38070700005)(41300700001)(38100700002)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGg4dkJxK3J5SXZxOVMrWTV2c0hHRjJnSXI2M255UkYzclJlazNPbWpoV1F5?=
 =?utf-8?B?dFE3ZnBGdjZGZThudmI0bVZIcHpBQlFWWFRMaFRLa2E3WU9rVnZmZFN6ZXlt?=
 =?utf-8?B?dlhvbTliNytxdTJVc0RaUlV2bWVocXpiV3p3N1RBL3BOaWdxN1Z2VHFXN25t?=
 =?utf-8?B?MTNBMWkzSFNiSHFBdEs2RXhFY3gwVGJQTVZhMkRYNmxjQUNqOFU0dzNld0dh?=
 =?utf-8?B?T2oyUUFyeGZJTFBYcTIrU2xDSHRvTWRZK1BMaUVmZFd0eWE2bTZGZ2IxMnJ3?=
 =?utf-8?B?aHlkSHZlOGx5bFlBNUNQZDd4aTNjU2g5T2I2SGVLdktYc05zN3M4SzBqVHZU?=
 =?utf-8?B?Z1J0NlRvcUpjMm12OVZscXRhTE1iWUhNc1d2QVVEMTY5bk8vQnFPMWVhR1I1?=
 =?utf-8?B?WFM3cWJ6TTZGK1JuZlpjZFU3T21DcEV2cXU1ZURwcjRib3R0VVhuR2RSMUh2?=
 =?utf-8?B?M1N4dDBCN3J2c242c0hmNFZsamppcHBkZTJhdG5lTm42eGU2TFNCemtJZkxn?=
 =?utf-8?B?b2F4ZncvanlmTXBpck8waFd0aStYeU1ycjE5MW8zRFZRb2xmM2ZjelJSWkM4?=
 =?utf-8?B?dkhBaTI0bjlrenRJQjBGV1kzYVhyVW0ybit3T08rd052eUN5NU90N3FwSjJQ?=
 =?utf-8?B?SXFSTFM4cTNocGdZVkZIa3BPZnp2cVErMGdRNG5RZ2ZBNW9Nay9VSXg3UW5C?=
 =?utf-8?B?c3lrSVA0RU9LWEVjUGxCdC9nR2xLMG5PYXhWdXRPNXpZOGdkc0haS0dzb3pS?=
 =?utf-8?B?UHNLK1pDK2dXd0U0NGxwRVFJaUdqeTVub1VmVjBnUkIvUno0WGhkUmpPdERt?=
 =?utf-8?B?ck05V1g4cTlvNGRoelRRbmFTR054OUxCeFI3ZGNGYkR3YUUrK2poYndGVUJY?=
 =?utf-8?B?akMzTkxsNnJ6M0d1ZkVPNlZKTHBocjdFUTYzVWN5blprOXBtb3dMaG5FcnBD?=
 =?utf-8?B?cDdFTFE2Vms0ZUY1bTlmaTVKOEpaYzgyR3Jobnk2M041YXVEV3JFcTUySmZ1?=
 =?utf-8?B?dWJWYW4yckJkNFRlUmwzbUJqQmM4Um1yK2JGck5ybGpPSko1VTlpY3hpU0FX?=
 =?utf-8?B?bG1MeS96a09pMkxBU2xqOUN4NnAvaDJaenV3cGlHL2RKQ0U4RDdLdVRBM0Ft?=
 =?utf-8?B?TW12Y0JuRnhjNElteEN1M1h1S3JBVWo1VWdLT0c1VUw3S0xNSGs1RkM3NFkw?=
 =?utf-8?B?MzA3R2tQaGJGbEdGSytZbElyT0lVcWV0K2RHY0FxQTZmL3l5ZnBFOWlxeDl4?=
 =?utf-8?B?Mm15N1hoLzIzOE5OV2xLRWh3Wmw1YU01T3N0R1FFcmpWOHQ1Tzkvcy85dWx6?=
 =?utf-8?B?WkNpb2xoZFYwZy9SRG1ITDlLc2RTMUZId2hOQnA1UmpNUWlvY0dVU1ladCs1?=
 =?utf-8?B?TmNJVllQbGFyalJvb3l4ZkxFUG1FVTBYcUlBSmd4N2FpeWtWeWdpQWVyRlZ2?=
 =?utf-8?B?N1g2VjdzSEdGQk5ZbktjTVd0VG4xd3hzWUZrdDV5QjhOaFUyTmczWDl0Wmdi?=
 =?utf-8?B?MUdCdThvNmltL1pkTHBTNG1YWXIzaWlRdUhvK1c4U25UT2o0WEpzZGJSTkpS?=
 =?utf-8?B?NkJxQU1PbWJFaWswV3VTdWpJMmYveHFPU1JGNGNTSEFtQkNlRkdFK1BkRTA4?=
 =?utf-8?B?VkFvTXVlQS8rZnVuOUhWajNqTDhYUG5uZEJ1TWRGU0haOVhpbjJ3cnlVblpx?=
 =?utf-8?B?a3ZSeERLMmMvUUl4cEwvTU92RTBsaCtUWFh3RjcxWDlqNXZiL3VpM0hxUlN5?=
 =?utf-8?B?WG5DWWRDbTh2KzJwMzNraE5BNjJ6THBjL2hseWdGZUxlY3YzWndRZjhBQTIy?=
 =?utf-8?B?blRxUDJ2UFRXcFJtMVV6N0krbUJnSlp1dmtWakxnQldPTGVVUjZvclRZdHVt?=
 =?utf-8?B?aTlSSGNlSm9tUnBLVVFrTm83TVhSdGp4ZTVwdE4zd0V1a2FGbGxXMTEwL0ti?=
 =?utf-8?B?dHlJcVBscStZa2JWNXNIa0ZaWmNzVUNOS05leWxuci9mZjNDY1JSQ2I4MXVU?=
 =?utf-8?B?cUMwSEQvbEFHRXRlOEx1UmlvclZOdk5YUTNMbHZxMmlmY3g3QW9ORmtaVEl0?=
 =?utf-8?B?MnZGeDBCSXFESGdGMEdFcVI3dFdQenloeEkwOHA2am1EaGswbmhDK1FDNzVU?=
 =?utf-8?Q?EZPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bae1a43-cb6c-4db3-18dd-08dbba59fce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:19:46.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qN9roZDx90gmHRGXv6qWkPmdN7s7pZLkzFHQ4ZAWtWKnhZrXbU03PKxSu3732C2bm37fJ2kJPN6Bl0A09G6+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjMgOTozOSBBTQ0KPiANCj4gT24gVGh1LCBTZXAgMjEsIDIw
MjMgYXQgMTI6MDHigK9QTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOg0K
PiA+DQo+ID4NCj4gPg0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjMgODo0OCBBTQ0KPiA+
DQo+ID4gPiBBcyByZXBsaWVkIGluIGFub3RoZXIgdGhyZWFkLCB0aGUgaXNzdWVzIGZvciBCQVIg
YXJlOg0KPiA+ID4NCj4gPiA+IDEpIE5vdCBzdXJlIGl0IGNhbiBoYXZlIGFuIGVmZmljaWVudCBp
bnRlcmZhY2UsIGl0IHdvdWxkIGJlDQo+ID4gPiBzb21ldGhpbmcgbGlrZSBWSVJUSU9fUENJX0NB
UF9QQ0lfQ0ZHIHdoaWNoIGlzIHZlcnkgc2xvdyBjb21wYXJlZCB0bw0KPiA+ID4gc2luZ2xlIHJl
Z2lzdGVyIGFjY2Vzc2luZw0KPiA+ID4gMikgVGhlcmUncyBubyBvd25lci9ncm91cC9tZW1iZXIg
Zm9yIE1NSU8sIG1vc3Qgb2YgdGhlIHRpbWUsIHdlIG9ubHkNCj4gPiA+IG5lZWQgYSBzaW5nbGUg
TU1JTyBkZXZpY2UuIElmIHdlIHdhbnQgdGhlIG93bmVyIHRvIG1hbmFnZSBpdHNlbGYsIGl0DQo+
ID4gPiBzZWVtcyByZWR1bmRhbnQgYXMgaXMgaW1wbGllZCBpbiBhbGwgdGhlIGV4aXN0aW5nIHRy
YW5zcG9ydHMgKHdpdGhvdXQgYWRtaW4NCj4gY29tbWFuZHMpLg0KPiA+ID4gRXZlbiBpZiB3ZSBo
YWQsIGl0IG1pZ2h0IHN0aWxsIHN1ZmZlciBmcm9tIGJvb3RzdHJhcCBpc3N1ZXMuDQo+ID4gPiAz
KSBGb3IgbGl2ZSBtaWdyYXRpb24sIGl0IG1lYW5zIHRoZSBhZG1pbiBjb21tYW5kcyBuZWVkcyB0
byBzdGFydA0KPiA+ID4gZnJvbSBkdXBsaWNhdGluZyBldmVyeSBleGlzdGluZyB0cmFuc3BvcnQg
c3BlY2lmaWMgaW50ZXJmYWNlIGl0IGNhbg0KPiA+ID4gZ2l2ZSB1cy4gT25lIGV4YW1wbGUgaXMg
dGhhdCB3ZSBtYXkgZW5kIHVwIHdpdGggdHdvIGludGVyZmFjZXMgdG8NCj4gPiA+IGFjY2VzcyB2
aXJ0cXVldWUgYWRkcmVzc2VzIGV0Yy4gVGhpcyByZXN1bHRzIGluIGV4dHJhIGNvbXBsaWNpdHkg
YW5kDQo+ID4gPiBpdCBpcyBhY3R1YWxseSBhIGZ1bGwgdHJhbnNwb3J0IChkcml2ZXIgY2FuIGp1
c3QgdXNlIGFkbWluIGNvbW1hbmRzIHRvIGRyaXZlDQo+IHRoZSBkZXZpY2UpLg0KPiA+IEluIFsx
XSB0aGVyZSBpcyBubyBkdXBsaWNhdGlvbi4gVGhlIGxpdmUgbWlncmF0aW9uIGRyaXZlciBuZXZl
ciBwYXJzZXMgdGhlIGRldmljZQ0KPiBjb250ZXh0IGVpdGhlciB3aGlsZSByZWFkaW5nIG9yIHdy
aXRlLg0KPiA+IEhlbmNlIG5vIGNvZGUgYW5kIG5vIGNvbXBsZXhpdHkgaW4gZHJpdmVyIGFuZCBu
byBkdXBsaWNhdGUgd29yay4NCj4gPiBUaGVyZWZvcmUsIHRob3NlIGFkbWluIGNvbW1hbmRzIGFy
ZSBub3QgdG8gZHJpdmUgdGhlIGd1ZXN0IGRldmljZSBlaXRoZXIuDQo+IA0KPiBJJ20gbm90IHN1
cmUgaG93IHRoaXMgaXMgcmVsYXRlZCB0byB0aGUgZHVwbGljYXRpb24gaXNzdWUuDQo+IA0KWW91
IGNvbW1lbnRlZCB0aGF0IGFkbWluIHZpcnRxdWV1ZSBkdXBsaWNhdGVzIHNvbWV0aGluZ3MuDQpB
bmQgSSBleHBsYWluZWQgYWJvdmUgdGhhdCBpdCBkb2VzIG5vdC4NCg0KPiA+DQo+ID4gPiA0KSBB
ZG1pbiBjb21tYW5kcyBpdHNlbGYgbWF5IG5vdCBiZSBjYXBhYmxlIG9mIGRvaW5nIHRoaW5ncyBs
aWtlDQo+ID4gPiBkaXJ0eSBwYWdlIGxvZ2dpbmcsIGl0IHJlcXVpcmVzIHRoZSBhc3Npc3RhbmNl
IGZyb20gdGhlIHRyYW5zcG9ydA0KPiA+ID4NCj4gPiBBZG1pbiBjb21tYW5kIGluIFsxXSBpcyBj
YXBhYmxlIG9mIGRpcnR5IHBhZ2UgbG9nZ2luZy4NCj4gDQo+IEluIHlvdXIgZGVzaWduLCB0aGUg
bG9nZ2luZyBpcyBkb25lIHZpYSBETUEgbm90IHRoZSB2aXJ0cXVldWUuDQo+IA0KTm8uIGl0IGlz
IGRvbmUgdmlhIGFkbWluIGNvbW1hbmQsIG5vdCBETUEgaW4gWzJdLg0KDQpbMl0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvdmlydGlvLWNvbW1lbnQvMjAyMzA5MDkxNDI5MTEuNTI0NDA3LTctcGFy
YXZAbnZpZGlhLmNvbS9ULyNtMTdiMDlhY2Q4YzczZDM3NGU5OGFkODQ3NjRiMzE1YWZhOTRmNTlj
OQ0KDQo+IFRoZSBvbmx5IGpvYiBmb3IgdmlydHF1ZXVlIGlzIHRvIGluaXRpYXRlIHRoZSBETUEu
IEJ1dCBpZiBETUEgY2FuIGJlIGluaXRpYXRlZCB2aWENCj4gdmlydHF1ZXVlLCBpdCBjYW4gYmUg
ZG9uZSBpbiBvdGhlciB3YXlzLg0KPiANCkxldHMgZmlyc3QgZXN0YWJsaXNoIDQgdGhpbmdzIGlu
IGFsdGVybmF0aXZlIHdheSwgYW55IG1vdGl2YXRpb24gdG8gZG8gc28gd2l0aCA1dGggcG9pbnQg
d2l0aG91dCBnaWFudCByZWdpc3RlcnMgbmVlZCBpbiBkZXZpY2UuDQoNCj4gPg0KPiA+ID4gMSkg
UGFyYXYncyBwcm9wb3NhbCBkb2VzIHNldmVyYWwgY291cGxpbmdzOiBjb3VwbGUgYmFzaWMgYnVp
bGQNCj4gPiA+IGJsb2NrcyAoc3VzcGVuZCwgZGlydHkgcGFnZSB0cmFja2luZykgd2l0aCBsaXZl
IG1pZ3JhdGlvbiwgY291cGxlDQo+ID4gPiBsaXZlIG1pZ3JhdGlvbiB3aXRoIGFkbWluIGNvbW1h
bmRzLg0KPiA+IEluIHdoaWNoIHVzZSBjYXNlIHlvdSBmaW5kIGRpcnR5IHBhZ2UgdHJhY2tpbmcg
dXNlZnVsIHdpdGhvdXQgbWlncmF0aW9uIGZvcg0KPiB3aGljaCB5b3UgbGlrZSB0byBzZWUgaXQg
ZGV0YWNoZWQgZnJvbSBkZXZpY2UgbWlncmF0aW9uIGZsb3c/DQo+IA0KPiBJcyBpdCBvbmx5IHRo
ZSBkaXJ0eSBwYWdlIHRyYWNraW5nPyBJdCdzIHRoZSBjb21iaW5hdGlvbnMgb2YNCj4gDQo+IDEp
IHN1c3BlbmRpbmcNCj4gMikgZGV2aWNlIHN0YXRlcw0KPiAzKSBkaXJ0eSBwYWdlIHRyYWNraW5n
DQo+IA0KPiBFZWFoIG9mIHRob3NlIHdpbGwgaGF2ZSB1c2UgY2FzZXMgb3RoZXIgdGhhbiBsaXZl
IG1pZ3JhdGlvbjogVk0gc3RvcCwgcG93ZXINCj4gbWFuYWdlbWVudCBpbiBWTSwgcHJvZmlsaW5n
IGFuZCBtb25pdG9yaW5nLCBmYWlsb3ZlciBldGMuDQo+IA0KU3VzcGVuZC9yZXN1bWUgd2l0aCBk
aWZmZXJlbnQgcG93ZXIgc3RhdGUgaXMgZHJpdmVuIGJ5IHRoZSBndWVzdCBkaXJlY3RseS4NClNv
IGl0IG1heSBmaW5kIHNvbWUgb3ZlcmxhcC4NCg0KRGV2aWNlIGNvbnRleHQgaGFzIG5vIG92ZXJs
YXAuDQoNCkRpcnR5IHBhZ2UgdHJhY2tpbmcgaGFzIG5vIG92ZXJsYXAuIFdoYXQgZG8geW91IHdh
bnQgdG8gcHJvZmlsZSBhbmQgbW9uaXRvcj8gSW4gY2FzZSBpZiB5b3Ugd2FudCB0byBwcm9maWxl
LCBpdCBjYW4gYmUgdXNlZCB3aXRob3V0IG1pZ3JhdGlvbiBjb21tYW5kIGFueXdheT8NCklmIHlv
dSBkZXNjcmliZSwgbWF5IGJlIHdlIEkgY2FuIHNwbGl0ICJkZXZpY2UgbWlncmF0aW9uIiBjaGFw
dGVyIHRvIHR3byBwaWVjZXMsIA0KRGV2aWNlIG1hbmFnZW1lbnQgYW5kIGRldmljZSBtaWdyYXRp
b24uDQoNCkRldmljZSBtaWdyYXRpb24gd2lsbCB1c2UgdGhlc2UgYmFzaWMgZmFjaWxpdHkuDQpX
b3VsZCB0aGF0IGhlbHAgeW91Pw0KDQpBbHNvIHRob3NlIGNhbiBiZSBzcGxpdCBsYXRlciB3aGVu
IHRoZSBhY3R1YWwgdXNlIGNhc2UgY2FuIGJlIGRlc2NyaWJlZC4NCg0KDQo+ID4gT25lIGNhbiBh
bHdheXMgdXNlIHRoZXNlIGNvbW1hbmRzIGlmIHRoZXkgd2lzaCB0byBhc19pcy4NCj4gPg0KPiA+
ID4gMikgSXQncyBzdGlsbCBub3QgY2xlYXIgdGhhdCBQYXJhdidzIHByb3Bvc2FsIGNhbiB3b3Jr
LCBhIGxvdCBvZg0KPiA+ID4gY29ybmVyIGNhc2VzIG5lZWRzIHRvIGJlIGV4YW1pbmVkDQo+ID4g
Pg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyB3aGljaCBwYXJ0IGNhbiBiZSBpbXByb3ZlZCBpbiBb
MV0uDQo+IA0KPiBJIHdpbGwgZG8gdGhhdCBidXQgaXQgbWF5IHRha2UgdGltZS4gSXQncyBuZWFy
IHRvIHRoZSBwdWJsaWMgaG9saWRheS4NCg0KSSB1bmRlcnN0YW5kLiBObyBwcm9ibGVtLiBUYWtl
IHlvdXIgdGltZS4NCkkgd2lsbCBwcm9jZWVkIHdpdGggdjEgZW5oYW5jZW1lbnRzIHJlZ2FyZGxl
c3MgZm9yIFsxXS4NCg0K

