Return-Path: <virtio-dev-return-13738-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C4ECA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:36:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3FBEE2ACA8
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:36:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34A1A98665E
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:36:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2927498612D; Wed, 13 Sep 2023 04:36:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18195986630;
	Wed, 13 Sep 2023 04:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWm/QrntmB1dv8ltJvO9oUIPnnH3XlSCjQifi0qVIeO5ZBanAEMeYndQSdKiQGJLqOo4lKTggfpvR65NyHe4g79KWlGLOK05HNx4GrrKcYmLU2RP1HyyUEBp7D6IAb1R3SW2jdwSyUTCDISFopf1vijXvKDam71uGrD7yXMJti1HTWeUB5EbZ2dEKVA5XoiIjwe0YaOpiWyg1oknAyRyOo5wK/M+EsjV1GMMjPMbLzpiqPv7SMmAcw5YItIePXyfdCAv3xMFF0Kz9moNY73zVGHfnFek96nl8cs7ZCZXGlmJZFn0Q+0aSZqRVILkEr5RP5PZDt/9uQfTMqI5JLIEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGuua5KLDHZFeGdjKG5XWN0rt1X+oZpPyfWw+SKTL3k=;
 b=izjtUQCSSXnmNehEk4kUcOhhTG4dlodFtDwDdLw+ORiW7cRVbsC1rCcWExS74AMIoqm+BwFxBaliKT6mLGq6ZA97Qw/N6w4VMjv45UMTas5UD1TsDT4W6l1uQ/2fTUCv8s3Jf5prIvYpYTjogO/x9bSK7w+E4E8mgFR1wQxjIyVWiF16u7dC91Y6vKaP1/KLOc1LaN4w9LqFNZaMegx8V3HAYIOT6FF2iafHt2bvnVX56kuKWOCIs6oc/hAIKy1KiK2wt5sXIjxMdfuwwBH2akRJLiU+6zylrBxqiXRF1SCj8mc0om3VZIGfnb3NbNlLT7+Fgde+QdxgbIrB3prjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAI3wCAAS5OAIAAHWKQgAALxgCAAABUEIAADrWAgAAAMqCAABphAIAAAHKAgABCsYCAAAlpEIAA8YmAgAAAtRCAAATBAIAAAm0w
Date: Wed, 13 Sep 2023 04:36:50 +0000
Message-ID:
 <PH0PR12MB5481F21E67549A3F2CE95B9DDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E3CC2F6107515F9D7FFEDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
 <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <987f72eb-f82c-da4b-229c-ffc5b60d6fb4@intel.com>
 <PH0PR12MB5481F256CCB58C10DB65A8D1DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0861d9ff-d126-c6e4-0deb-74ca81675eeb@intel.com>
 <PH0PR12MB5481678840AE3B1B2D97D512DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <30bed94a-e99e-1561-def3-719e25a0dd26@intel.com>
 <PH0PR12MB5481687C209231F8C4CE8A1EDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7424d2ae-2366-882f-bd84-04ee5714764b@intel.com>
 <PH0PR12MB5481E322E66419AAC61822ACDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dd40c978-3606-594d-f70e-6ce2c120a693@intel.com>
In-Reply-To: <dd40c978-3606-594d-f70e-6ce2c120a693@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7105:EE_
x-ms-office365-filtering-correlation-id: 4ec1ef06-f20e-4cc8-ebb4-08dbb4130c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QzPvc1IytPpRx6pTsKCqK3UZECMwn21QqGCaHwxe5LA3bzAkRBs8x2czs7Inx8Er3XL0OexnziIxjsTdg7ZfYPWEEjFdrFNLolroJ2ZxetAEYSegjYLdsBMCrhOibiYZtLElB9rwe8dtTjuoX7zztm4f5AtJGqFF4BWukJW90egUBHdPPtepinVrFbUe3qNu1OTs64J4kSpYloGiHO3n4UT5TTPU05mJs/fAy5bFvm2pGbnjKm/uUXiCdc/bZ8hxgNWDxKJtVQ1fiPMmhTS3L+9COa1Zo861OZWdiB2nkCC+6XzfPIncGa923GCsuT58zb4NcMHHt2VcKKqF9rRQX7HnYEG5w6IWMkZPNRfU316Q4iCog/o338dQm910uaM7SBG+p7RH1WQeVEE0T8T8sOTjnVI9W+OCMJ7fa3ss0YeN6Fq1WQCnL5dMtXERFtuwcEKjhdWzzB1/5qb5jTB8NFg8/exgc1ZdU6y9ynatiagCHHmzeyt6HehmJIYLBxD2hk4l7pIo8MzTCAU9A0wctqkLSzAgNrJhp8J1OaEciAxdIC0VCCYBBoJLMuw7r9WLMo0tMzMKCtDCp+JXtrGnMhYfMApPwSlkmjBHesjPr4Z2VmcbaEfc+JowvOhoAr3C
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(122000001)(71200400001)(478600001)(86362001)(83380400001)(6506007)(64756008)(7696005)(26005)(33656002)(9686003)(110136005)(55016003)(8676002)(76116006)(54906003)(4326008)(8936002)(66476007)(316002)(52536014)(66556008)(66946007)(5660300002)(38070700005)(2906002)(66446008)(38100700002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEdVdjZ2N3JNVnE2MUdTMTlZUWFaeTdSNDdZek9ZVnZXRjRmeVdlQUltQ1JO?=
 =?utf-8?B?NUJWQmVWczdKK2M3TWFMcWlGajA5dXdqdnl3Zm0yenlya3U3VWUzWmEzRDQ1?=
 =?utf-8?B?dTIzZjVpQmZTODIvczcveGlyU1orMlY3RitxVUJWV29ZRnFtMmRDTlJtMVlo?=
 =?utf-8?B?SGJkTTZtdmlCT01QYTVlQjdpczRtMTVSelpLYUNScXJ4cGp6dGl5bU5BNjM5?=
 =?utf-8?B?NFVMRm43VlMwWnhYSEhVL00vMW5DS0VJM2pPWWxGMFdyckI0cy9YQXZCNk9j?=
 =?utf-8?B?dEU2RXpZSEdNY0V4RmxjWUh2aUxSV2E0NDNKbmpDMjMzUW04bCt4ZkxQaXd6?=
 =?utf-8?B?OWVkZktJQzltWFdQRXoyUTB0ZUo4S0lBbEFvVmxLRUltdk9pVnBJVWMxVEE0?=
 =?utf-8?B?TGdoM2QwckF3L1d5aXNuNFNuMXRlZUxjVy9XdDFtSXV4NXRiZC8vMUFSTFEx?=
 =?utf-8?B?YklEaXozZ1FuNHNWa1E1YnRoajBqZjc5eHdvWmVzTk55eGN6L2YxY1lPQUxp?=
 =?utf-8?B?b1ZiM1BORi91S09oYi9UVG55UzZIeWRDRE4xWGEzSDdKakJXanhLZmh6cjYx?=
 =?utf-8?B?WUJPa1lITGVFSS9QbjRUUVRJWmtSUHNCRFNRRmp5SnpiR2xYZ2JMeXpaeTlj?=
 =?utf-8?B?UjhCK1llNkFSZU1haEtoR0Q2azRPYmNyeWlBdnEvOTYwREMrVE1vakEvZzFE?=
 =?utf-8?B?ZEd2QUgzRHpkR0xLTHBZKzVUUHRFMzdkcXl6dyttOXdMbXRYVUNOWHd3V0FR?=
 =?utf-8?B?VklVMGdHU0tpSUFHcWtDeVIzdG10dVhCNXU1TXB6Wm1hTDJkZG1jOTRBMU80?=
 =?utf-8?B?dDVJb2l2SWtjS21ZUThROU9ETlBhQmlGRUo3ajJtVWV0SnR2WHM4RUhCTUEr?=
 =?utf-8?B?ZGNGUjhhUlZMZmI2cTZHQlQvSkhtWHVicUdJU2d4RTFVRWtmWW9oUnRuMmFE?=
 =?utf-8?B?cFVyZjdyVklOM2NMTFhmVEV0bGNLOHl4Q0lVK2dLeUdYa0xJVlo4NXJuY0xv?=
 =?utf-8?B?MXFLcGR6WG9paGVxUUtQL3lJMy9uY2ZUQm9veEpZbEUwTlR5L3dFL0NpYmpi?=
 =?utf-8?B?aysvdldHd2J1WUNYbjJhZndKNUNaVmttRVRVRmtLSGhoTTdtWEQ0RWl5R3RL?=
 =?utf-8?B?WjFzcGxkSnpSMXY4bGpVZm9SNFhidWdaeHVvSDR2YUR2SnA4b01FYW9HYVQz?=
 =?utf-8?B?Q1VxY0Rtcnc5VElobTdtYXd3V3dKZlE0Qjh4cHNnNEJDZGtxUjJHcmxWMDg0?=
 =?utf-8?B?aTBnL0VBWTZRMUIxT1JZSXVpN1hsM3VoQjFnMUlXTWphVzBhWVRtTG9TWHVk?=
 =?utf-8?B?YTlyZ2VSRXRUUGpaend1b295VXB2Q1g5M3dlSTVEZFlndW1JRjIrMDhHMWQ3?=
 =?utf-8?B?clpBYVBHQTQwa3dIdm8vL09ZVEJ6Vnc2dm44UzUrLzJ5K1Y0bkZZNkxGMTE1?=
 =?utf-8?B?VFZPLzB0cUhKdkVmRXVSS0MwVjVyYk1ocDJPWFc3OXZRUDJpY3NuclpXejA2?=
 =?utf-8?B?RExGeFVzQWVZWlFEa2tZSEN1ckhKWW9nbzBLeVVSTzQ4dFdaWTNQQ2JLUWM1?=
 =?utf-8?B?Ty9ObzZ1am9CejNyK1FqZnVjRE5jd2Ywbjc3cGdqL256MHc2MDNhbWdCYTMy?=
 =?utf-8?B?djE1dTM1RGhIaGY3N0dWc2xlMDhIbE1sTFloRmVWSEw2VjRDU1Z1Q2REd1Vq?=
 =?utf-8?B?V2xlZjZwYmtUL3pOY0VLOWVuZGduRTI3YXI5Mk96RXNXN1ZmbEYyRXlRZGVr?=
 =?utf-8?B?WmtnK0hlQ3lsOUdKblF0UHJkWHNZZzM3OUVuOWJZZyt0R3Z0NDJRdURGV2ty?=
 =?utf-8?B?cTNGa0hBeGpHUzlEK3hCaFpPQjJkSzhUYldCOXdUYjh3YWhGeG9CQmpHL09Q?=
 =?utf-8?B?U0FwMEdxY3gwNmt5NFZpdkU2eFcvQmU0aURNOCtscC9nYm1Ca2RuU2J1RlRM?=
 =?utf-8?B?RlUyOVZkdmhOTWNPR1FpZ3d4SEo2UlZKWGNTRUxDbEdkaThMSzFqQk9kdXkz?=
 =?utf-8?B?L2FJbXFtL1Q3TzQrbm4ycUVTc2ZrNzhKQUhSSnRTbE1yYVJWYkNmeXkxMmha?=
 =?utf-8?B?d0FhY01FaFovVExYT3ROTFZBUlJLWk5vRmR3UkJqWnl0RGdPU3NleWpTb2pY?=
 =?utf-8?Q?OlCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec1ef06-f20e-4cc8-ebb4-08dbb4130c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:36:50.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bKwZtwO07vZYD12Vn3/E4urKEu8QTfg7PJhbQfxdU77ZcmuUshDNcqbh1m5kyW9lUN4j2rL0B51U+zyBaGlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDk6NTEgQU0NCg0KDQo+ID4gVlEgZGVwdGgg
ZGVmaW5lcyB0aGUgVlEncyBsaW1pdC4NCj4gc3RpbGwgc291bmRzIGxpa2UgbGltaXRsZXNzIGFu
ZCBJIHdpbGwgc3RvcCBhcmd1aW5nIHRoaXMgYXMgeW91IGNhbiBzZWUgaWYgdGhlcmUgaXMNCj4g
UkVBTExZIGEgcXVldWUgY2FuIGJlIGxpbWl0bGVzcywgd2UgZXZlbiBkb24ndCBuZWVkIE11bHRp
LXF1ZXVlIG9yIFJTUy4NCg0KSWYgeW91IHNlZSBzb21lIHZhbHVlIGluIGxpbWl0bGVzcyBxdWV1
ZSwgcGxlYXNlIGFkZCBvbmUuDQpJIGhhdmUgbm90IHNlZW4gc3VjaCBjb25zdHJ1Y3QgdW50aWwg
bm93IGFuZCBkb27igJl0IHNlZSB0aGUgbmVlZCBmb3IgaXQuDQoNCj4gPg0KPiA+Pj4+IElmIHlv
dSBzYXksIHRoYXQgcmVxdWlyZSBtdWx0aXBsZSBBUSwgdGhlbiBob3cgbWFueSBzaG91bGQgYSB2
ZW5kb3INCj4gPj4gcHJvdmlkZT8NCj4gPj4+IEkgZGlkbuKAmXQgc2F5IG11bHRpcGxlIEFRcyBt
dXN0IGJlIHVzZWQuDQo+ID4+PiBJdCBpcyBzYW1lIGFzIE5JQyBSUXMuDQo+ID4+IGRvbid0IHlv
dSBhZ3JlZSBhIHNpbmdsZSB2cSBoYXMgaXRzIG93biBwZXJmb3JtYW5jZSBsaW1pdGF0aW9ucz8N
Cj4gPiBGb3IgTE0gSSBkb27igJl0IHNlZSB0aGUgbGltaXRhdGlvbi4NCj4gPiBUaGUgZmluaXRl
IGxpbWl0IGFuIEFRIGhhcywgc3VjaCBsaW1pdGF0aW9uIGlzIG5vIGRpZmZlcmVudCB0aGFuIHNv
bWUgcmVnaXN0ZXINCj4gd3JpdGUgcG9sbCB3aXRoIG9uZSBlbnRyeSBhdCBhIHRpbWUgcGVyIGRl
dmljZS4NCj4gc2VlIGFib3ZlLCBhbmQgd2UgYXJlIGltcGxlbWVudGluZyBwZXIgZGV2aWNlIGZh
Y2lsaXRpZXMuDQo+ID4NCj4gPj4gSW4gdGhpcyBzZXJpZXMsIGl0IHNheXM6DQo+ID4+ICtXaGVu
IHNldHRpbmcgU1VTUEVORCwgdGhlIGRyaXZlciBNVVNUIHJlLXJlYWQgXGZpZWxke2RldmljZSBz
dGF0dXN9DQo+ID4+ICt0bw0KPiA+PiBlbnN1cmUgdGhlIFNVU1BFTkQgYml0IGlzIHNldC4NCj4g
Pj4NCj4gPj4gQW5kIHRoaXMgaXMgbm90aGluZyB0byBkbyB3aXRoIHNjYWxlLg0KPiA+IEhlbmNl
LCBpdCBpcyBicmluZ2luZyBzYW1lIHNjYWxlIFFPUyBsaW1pdGF0aW9uIG9uIHJlZ2lzdGVyIHRv
byB0aGF0IHlvdSBjbGFpbQ0KPiBtYXkgYmUgcHJlc2VudCBpbiB0aGUgQVEuDQo+ID4NCj4gPiBB
bmQgaGVuY2UsIEkgcmVzcG9uZGVkIGVhcmxpZXIgdGhhdCB3aGVuIG1vc3QgdGhpbmdzIGFyZSBu
b3QgZG9uZSB0aHJvdWdoDQo+IEJBUiwgc28gdGhlcmUgaXMgbm8gbmVlZCB0byBkbyBzdXNwZW5k
L3Jlc3VtZSB2aWEgQkFSIGVpdGhlci4NCj4gPiBBbmQgaGVuY2UgdGhlIG1vZGUgc2V0dGluZyBj
b21tYW5kIG9mIFsxXSBpcyBqdXN0IGZpbmUuDQo+IFRoZSBiYXIgcmVnaXN0ZXJzIGFyZSBhbG1v
c3QgInRyaWdnZXJzIg0KPiA+DQo+ID4+PiBPbiB0b3Agb2YgdGhhdCBvbmNlIHRoZSBkZXZpY2Ug
aXMgU1VTUEVOREVELCBpdCBjYW5ub3QgYWNjZXB0IHNvbWUNCj4gPj4+IG90aGVyDQo+ID4+IFJF
U0VUX1ZRIGNvbW1hbmQuDQo+ID4+IHNvIGFzIFNpV2VpIHN1Z2dlc3RlZCwgdGhlcmUgd2lsbCBi
ZSBhIG5ldyBmZWF0dXJlIGJpdCBpbnRyb2R1Y2VkIGluDQo+ID4+IFYyIGZvciB2cSByZXNldC4N
Cj4gPiBWUSBjYW5ub3QgYmUgUkVTRVQgYWZ0ZXIgdGhlIGRldmljZSByZXNldCBhcyB5b3Ugd3Jv
dGUuDQo+IEl0IGlzIGRldmljZSBTVVNQRU5ELCBub3QgcmVzZXQuDQo+ID4NClN1c3BlbmQgbWVh
bnMgc3VzcGVuZCBvZiBFbmdsaXNoIGxhbmd1YWdlLg0KSXQgY2Fubm90IGFjY2VwdCBtb3JlIHN5
bmNocm9ub3VzIGNvbW1hbmRzIGFmdGVyIHRoYXQgYW5kIG5vdCBzdXBwb3NlZCB0byByZXNwb25k
Lg0KDQo+ID4+Pj4+PiBJdCBkb2VzIG5vdCByZXNpZGUgb24gdGhlIFBGIHRvIG1pZ3JhdGUgdGhl
IFZGcy4NCj4gPj4+Pj4gSGVuY2UgaXQgZG9lcyBub3Qgc2NhbGUgYW5kIGNhbm5vdCBkbyBwYXJh
bGxlbCBvcGVyYXRpb24gd2l0aGluDQo+ID4+Pj4+IHRoZSBWRiwNCj4gPj4gdW5sZXNzDQo+ID4+
Pj4gZWFjaCByZWdpc3RlciBpcyByZXBsaWNhdGVkLg0KPiA+Pj4+IFdoeSBpdHMgbm90IHNjYWxl
PyBJdCBpcyBhIHBlciBkZXZpY2UgZmFjaWxpdHkuDQo+ID4+PiBCZWNhdXNlIHRoZSBkZXZpY2Ug
bmVlZHMgdG8gYW5zd2VyIHBlciBkZXZpY2UgdGhyb3VnaCBzb21lIGxhcmdlDQo+ID4+PiBzY2Fs
ZQ0KPiA+PiBtZW1vcnkgdG8gZml0IGluIGEgcmVzcG9uc2UgdGltZS4NCj4gPj4gQWdhaW4sIGl0
IGlzIGEgcGVyLWRldmljZSBmYWNpbGl0eSwgYW5kIGl0IGlzIHJlZ2lzdGVyIGJhc2VkIHNlcnZl
DQo+ID4+IHRoZSBvbmx5IG9uZSBkZXZpY2UgaXRzZWxmLg0KPiA+PiBBbmQgd2UgZG8gbm90IHBs
YW4gdG8gbG9nIHRoZSBkaXJ0eSBwYWdlcyBpbiBiYXIuDQo+ID4gSGVuY2UsIHRoZXJlIGlzIG5v
IHJlYXNvbiB0byB3cmFwIHN1c3BlbmQgcmVzdW1lIG9uIHRoZSBCQVIgZWl0aGVyLg0KPiA+IFRo
ZSBtb2RlIHNldHRpbmcgYWRtaW4gY29tbWFuZCBpcyBqdXN0IGZpbmUuDQo+IFRoZXkgYXJlIGRl
dmljZSBzdGF0dXMgYml0cy4NCkFuZCBpdCBkb2Vzbid0IGhhdmUgdG8gYmUuDQoNCj4gPg0KPiA+
Pj4+IFdoeSBkbyB5b3UgbmVlZCBwYXJhbGxlbCBvcGVyYXRpb24gYWdhaW5zdCB0aGUgTE0gZmFj
aWxpdHk/DQo+ID4+PiBCZWNhdXNlIHlvdXIgZG93bnRpbWUgd2FzIDMwMG1zZWMgZm9yIDEwMDAg
Vk1zLg0KPiA+PiB0aGUgTE0gZmFjaWxpdHkgaW4gdGhpcyBzZXJpZXMgaXMgcGVyLWRldmljZSwg
aXQgb25seSBzZXZlcnMgaXRzZWxmLg0KPiA+IEFuZCB0aGF0IHNpbmdsZSB0aHJlYWRpbmcgYW5k
IHNpbmdsZSB0aHJlYWRpbmcgcGVyIFZRIHJlc2V0IHZpYSBzaW5nbGUgcmVnaXN0ZXINCj4gd29u
dCBzY2FsZS4NCj4gaXQgaXMgcGVyLWRldmljZSBmYWNpbGl0eSwgZm9yIGV4YW1wbGUsIG9uIHRo
ZSBWRiwgbm90IHRoZSBvd25lciBQRi4NCkFuZCBJIHJlcGVhdGVkbHkgZXhwbGFpbmVkIHlvdSB0
aGF0IHlvdSBuZXZlciBhbnN3ZXJlZCwgaXMgaG93IHN1Y2ggcXVldWUgY2FuIHdvcmsgYWZ0ZXIg
ZGV2aWNlIHN1c3BlbmQuDQpBIHdlaXJkIGRldmljZSBiaWZ1cmNhdGlvbiBpcyBub3Qgc3VwcG9y
dGVkIGJ5IHBjaSBhbmQgbm90IHRvIGJlIGRvbmUgaW4gdmlydGlvLg0KDQo+IHNlZSBhYm92ZSBh
bmQgcGxlYXNlIGZlZWwgZnJlZSB0byByZXVzZSB0aGUgYmFzaWMgZmFjaWxpdGllcyBpZiB5b3Ug
bGlrZSBpbiB5b3VyIEFRDQo+IExNDQpUaGUgd2hvbGUgYXR0aXR1ZGUgdGhhdCAiV2UgLi4iIGFu
ZCB1c2UgaW4gInlvdXIiIExNIGlzIGp1c3Qgc2ltcGx5IHdyb25nLg0KUGxlYXNlIHdvcmsgdG93
YXJkcyBjb2xsYWJvcmF0aXZlIGRlc2lnbiBpbiB0ZWNobmljYWwgY29tbWl0dGVlLg0KV2hhdCB5
b3Ugd2FudCB0byByZXBlYXQgd2FzIGFscmVhZHkgcG9zdGVkLCBzbyB0YWtlIHNvbWUgdGltZSB0
byByZXZpZXcgYW5kIHV0aWxpemUuIElmIG5vdCwgZGVzY3JpYmUgd2h5IGl0IGlzIG5vdCB1c2Vm
dWwuDQoNCg==

