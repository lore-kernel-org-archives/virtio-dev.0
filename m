Return-Path: <virtio-dev-return-13925-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19156E7071E
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 11:28:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 77E5E2A828
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 11:28:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EFBE98669B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 11:28:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 627B898667F; Thu, 21 Sep 2023 11:28:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A98D986680;
	Thu, 21 Sep 2023 11:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Iix31LMabIbvLrw14aR+vxEsQUnNHClSsw6MJ5c15SaLnDKkoatzFCOObFsS+Cm4gS6Tgxa/y6ybPyR8coSRFb+S3mZMmq8Ilu1CeN3YVhm2WPoHTJN/LDiiBjGxJ10PHoRoUb9oQXMr0a1Gxr1LUtWIzONBqO/ogpWXcKYPQfG9dPdIbbm6vQaxjwmU9V+smmbfjPYZ1gZKXLI3SCetlHyk6bOPbo4dPYMOcYPSpYB1ua43I2w653XvkzfokVUEYcWVwgW0+Veu/j/VuS3zB5QXGZKMqgmTNbTQ4/U4j4M+0cOMU4Af2MxgPLjsNM+b5YOCkNsVad2hW4+C/fPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFmPZCVoFtp5uckRg453YRluiUGe1AvFJYBXyKgquXo=;
 b=l7wyMuNcr25DWRXynwl2Yey93HMO6Gh0uysNST1e6J3ryq6yLGz8Bcc45U5k2Dh6F28hHhT+VlYpciP+IL1ZzN4PcY1Ub1XjG+s6L0BQ5c9fG8nb5iBeAYkuJ7TFhOyV6fQiISvVwYLXQbniIeuJZpTv3estUs6adjcnaiMIPJzG9M4qYVB5Cs8GXQ/6sNbJnflnuOV3L1cQ01stLRMmCdzaSG9+OB2qUaFnkfDimyagDignUWdhTDQ4tp+vS7fAOxsnZQISPYBw8VGXSQLvHZwJsLDg6wXlpTrr+L35ALE5KauqVCJ5AhUF4nw8+nIyq1r4WfmS6iwP1GXvb0KeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jason Wang
	<jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAAVfAgIAAAElwgAAJ5gCAABYcAA==
Date: Thu, 21 Sep 2023 11:28:28 +0000
Message-ID:
 <PH0PR12MB5481D2B821CBDD72823B2620DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e8d00e8c-fe32-83fc-fd13-edf3458b8c33@intel.com>
 <PH0PR12MB548188F479E7D7FF56845F39DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c1afd674-28bb-d8d4-7eee-ab1916a3f947@intel.com>
In-Reply-To: <c1afd674-28bb-d8d4-7eee-ab1916a3f947@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6354:EE_
x-ms-office365-filtering-correlation-id: 452e592a-1374-42c6-a931-08dbba95e0af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6Bp4wDYOeHU2zqLzY+1qpEbp/+/bHA8QWpBQbebqd4g7S2eOF/PQeBRyInty/jHQ2jZeroAOSXmPQ5FzpHcHzwjTGislBgyXBFKvbdstOySGGgY1BT9ZkpsT7NwHUBar59B6sMYXHHJwBfHQmdZHljyCCcWjYMFts5qbjAU3VteuIgm9E7fO4p81hCAVYGw8RS+D1VIxiKLMlSJ4TL0RKqSUCsAvyyA9MoI/E+WLAuMXdEFmTt1yUXPLufWb5n5KS6UECJsJGoqbRud5tJ5pbCFUXrZVIXAkRteZAEaKtHFXpazNj90xTlLVWITLzL7094CECV690It4J4wXSJkB8DtwJPwtaMHCvJPMYWMJzzuqa9dUQM7rUFIJ57UvnvwJCX0ywxye3C0xsRS/n5VX9Mv2eAx44eKqtRSt3dM4XHHikJrJUvy9sOu8ZWaPMXLEiKZiNdM813mjXbfqhXXKpPyH85JulKwVkHLzghyuCvBD79Drl8SURouDUbnA2TqoPrBW8jehfiVoQaUaLDIymh4g1sOetm6TTFRBqWDVBkZbw0t9rMGNPHnpkMLaEY64/QKm6sQ4vsFEXjee74FgIwqwZWTnJdd1vvZKNHBfDlhhJJTh4ADRV9FGOHMynV5nXpVQo1Ivl8ApnaUp436cBFkhuEncqxq+ZyXjlH5eQkY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(966005)(71200400001)(55016003)(6506007)(53546011)(86362001)(7696005)(55236004)(110136005)(9686003)(54906003)(66946007)(66446008)(66476007)(38070700005)(316002)(38100700002)(76116006)(41300700001)(66556008)(5660300002)(64756008)(84970400001)(478600001)(8936002)(8676002)(26005)(52536014)(2906002)(33656002)(122000001)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWZzTnFmTTdxdFJVb0pqeEJUYXZKVnNkOExmK2RkNUZnNzhDZzYybDRTZFVE?=
 =?utf-8?B?a0hHMS9rR1M3amdzckdRa1BRNDg2T1hoS21RMnJBS00yNlRFQnVyS3VrOU1K?=
 =?utf-8?B?M09mVitLcWc2b0lkWmpNektuODkyUWsrZEJGT2JHMzR6Ui9TUTFzMmRwenBF?=
 =?utf-8?B?Z0gxaXQ0UXFFNkwySlFreDZqVkNiN2JNQTBRY1dIZWlFNHRFOGZ0TFQvYm5y?=
 =?utf-8?B?dXVvaTVrQnJXTFVpa00zb1ZDdkZpeWFycEZ3dTJsUmtOZmZaNVJZeCtaaG04?=
 =?utf-8?B?bzA5MHJ4UmNGNmppbzhRTzdHb0hRTkloYmFXazJPY21Bc1VHbzdzTmo2WDV3?=
 =?utf-8?B?cDJVdkxObWZKVjN1emlQWnI5UXRacmhUZERIMnpXc2lta0RTOGtIRDkwSm1l?=
 =?utf-8?B?bjBYbkJzMUZLOHA3TXNlWUxDYXViaGJLaHI0dlI4ZVNpanFBaU01ZEt0Z1R5?=
 =?utf-8?B?bEx1MEI4NXIvSXI2VVVGdWZNams5SFlqeS9MdjhnNHhscy9qc2hieVVreUFs?=
 =?utf-8?B?aitLQ1JyK1ZySUIxYk1kaDFUYi9SdGtabGV3aUg5VjZiaUdOWXpaamJzLzlY?=
 =?utf-8?B?eEE5TmZyWG9RNmJxbzgxTDdvOWZmdU80U3J5YlNYYlJpQXhHR21USGZtRWQ4?=
 =?utf-8?B?WDJVZStMT0luRVZUR1RPZG1vOGNsZTM4QzNBQ0dqMWF6YlUxQ3FGdndqcjhl?=
 =?utf-8?B?VTd4L05iVmRUenlOVVljakVjVFdZaGJQUHZpNitTbGQxTlU4ZkFXTEEzWGpn?=
 =?utf-8?B?WnB1K2dXS3JlUHArdXlYRysxclFSN1UwNnpja2JjU3Ezb2tyeG9ZRHJpWTNW?=
 =?utf-8?B?Yi92Q0J2R0d5NEJESnJhNDFvV3BXcURBcHRDdVVmYWEzcXhSNG45OGNuZVZR?=
 =?utf-8?B?NFlLTW80UWNldXlQQjQyUFRzbUQxRG5MbUdWYVh1QWtHTDhwMndoOUhDd0F0?=
 =?utf-8?B?QnJ3ZC9TQkhSTjN1b1hVWXMwbitXdHd3QkNZVmtKUkNsWU0rT1ZraGlRS0s0?=
 =?utf-8?B?TS9iSG5vcDRDMUZlZktnYmxqdUtGb01GaXYrU3VSS1UrMmFPTmZqbksrSUxN?=
 =?utf-8?B?anJFMUhKeHRsbkgxUm8rY1VDMWFNcGdHWk1Na0g0QjdrQmc4YnhoUVhOVnNK?=
 =?utf-8?B?VVR4dENIck5RNlBENC9sVFFuZ2tvdG1TMWNkekg3Nnlva0k0dGRCVEI2QVl0?=
 =?utf-8?B?K2lGd3ZQRmVXcWlKWUtjdTRFUVErUjNESUg0S2duS3dKa21jYlNENXEwQW1o?=
 =?utf-8?B?d0s3VE1OMFI2TmVoamRPNW1DZkFVd2V3UVlmWlpQc1FPYithb0owZk41NlZC?=
 =?utf-8?B?L2ZVd014SnJqa01ZTFFmVGJBS0JSc2tYWkFuRU5rRjRPemVkdGVTbUlxOXRQ?=
 =?utf-8?B?NzA5eEZiWXlMTUY0MW5vT0lmZCtNcmQzUkovbnIwQWZnTWFmNGoyK1FzRGVp?=
 =?utf-8?B?UWNYU3pWWXlQTm9UeWVQTFVCQm5tVjdrcXIxRHdVcDVnN3kyWklVcHBrV2RP?=
 =?utf-8?B?SXVPN2VUb2EybnJUYnVkM0VDaXdSaVlSWFROQVQxWnpjQ1NFNkZacHNJc0lQ?=
 =?utf-8?B?VzNyWlcyQnRpZkM4azhidnJYTC9nMFdRRngwdDRrNmY4bStLc0p0S2x3aEZT?=
 =?utf-8?B?STdOVVZCZlQvdW9qWXNNSnVSUmNNaklZQVlaalNiWFpCdmxCUHRhRDB0TFh1?=
 =?utf-8?B?d1drZ1JicjFDNU9Pc09ML2tNU082MVoweUpwbDBXV09JaW5KU3I3bWFKcUxO?=
 =?utf-8?B?ZUZRRlFtazJHeHVLdk05VFFzb254OG0rbGxzS1hHOCs2YUZNTmh6ZTNlZXdQ?=
 =?utf-8?B?RjFxTDJUNkpJNUR1YWJucVlQVVNCaDl0eVRwSERzalZmN04yOE1LQ2NpL29P?=
 =?utf-8?B?dmQ4RFJPT0IrdXljclc3bnozemkyK205TFI0Mk1vUTBIeHY0TUxRZ3gxT0xk?=
 =?utf-8?B?YVhnT2RtelhYaUY2Mmk1QTVWQXFOVmFsNVBySFFlZzlSTlhzVlZDV2NFQmp0?=
 =?utf-8?B?TEg5NTRhMzh1UFdoVWlpS2l4b0NLei9UaUxtMGNvcjIzakp5Y2FMK1Y1V204?=
 =?utf-8?B?ZXlsQ3NMWlhhUnhLSHFGTUNPUUpxcmVJelJMRXNPK3Y5a2FPcStZeDlvY3FJ?=
 =?utf-8?Q?7GSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452e592a-1374-42c6-a931-08dbba95e0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 11:28:28.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l25T9k9qVTPkUtNUVZXGJW0cYgGHia0mo1Yxcg4+97hulkqVgPIg3xSITFRJPVkfaY/cbTV/jsyGlnIuDoRpQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjMgMzoyNSBQTQ0KPiANCj4gT24gOS8yMS8yMDIz
IDU6MjYgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+PiBGcm9tOiBaaHUsIExpbmdz
aGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgU2VwdGVt
YmVyIDIxLCAyMDIzIDI6NDkgUE0gVERJU1AgZGV2aWNlcyBjYW4gbm90IGJlDQo+ID4+IG1pZ3Jh
dGVkIGZvciBub3csIGFuZCB0aGUgVERJU1Agc3BlYyBtYWtlIGNsZWFyIGV4YW1wbGVzIG9mIGF0
dGFja2luZw0KPiA+PiBtb2RlbHMsIHlvdXIgYWRtaW4gdnEgTE0gb24gdGhlIFBGIGV4YWN0bHkg
bWF0Y2ggdGhlIG1vZGVsLg0KPiA+IEkgZ2F2ZSBoaW50IHllc3RlcmRheSB0byB5b3UgdG8gY29u
c3VsdCBSYXZpIGF0IEludGVsIHdobyBzaG93ZWQgVERJU1ANCj4gbWlncmF0aW9uIHVzaW5nIGEg
ZGVkaWNhdGVkIFRWTSB1c2luZyBzaW1pbGFyIG1lY2hhbmlzbSBhcyBhZG1pbiBjb21tYW5kLg0K
PiA+IEJ1dCB5b3Ugc2FkbHkgaWdub3JlZC4uLg0KPiA+DQo+ID4gU28gbGV0IG1lIG1ha2UgYW5v
dGhlciBhdHRlbXB0IHRvIGV4cGxhaW4sDQo+ID4NCj4gPiBXaGVuIGluIGZ1dHVyZSBURElTUCBk
ZXZpY2UgbWlncmF0aW9uIHRvIGJlIHN1cHBvcnRlZCwgdGhlIGFkbWluIGNvbW1hbmQNCj4gd2ls
bCBiZSBkb25lIHRocm91Z2ggYSBkZWRpY2F0ZWQgUEYgb3IgYSBWRiB0aGF0IHJlc2lkZXMgaW4g
YW5vdGhlciB0cnVzdA0KPiBkb21haW4sIGZvciBleGFtcGxlIGFub3RoZXIgVFZNLg0KPiA+IFN1
Y2ggYWRtaW4gdmlydGlvIGRldmljZSB3aWxsIG5vdCBiZSBsb2NhdGVkIGluIHRoZSBoeXBlcnZp
c29yLg0KPiA+IFRoZXJlYnksIGl0IHdpbGwgYmUgc2VjdXJlLg0KPiA+IFRoZSBhZG1pbiBjb21t
YW5kcyBwYXZlIHRoZSByb2FkIHRvIG1ha2UgdGhpcyBoYXBwZW4uIE9ubHkgdGhpbmcgY2hhbmdl
cw0KPiBpcyBkZWxlZ2F0aW9uIG9mIGFkbWluIGNvbW1hbmRzIHRvIGFub3RoZXIgYWRtaW4gZGV2
aWNlIGluc3RlYWQgb2YgYSBQRi4NCj4gaWYgeW91IHBsYW4gdG8gZG8gaXQgaW4gZnV0dXJlLCB0
aGVuIGxldHMgZGlzY3VzcyBpbiB0aGUgZnV0dXJlLg0KPiANCj4gQW5kIFRESVNQIGNhbiBiZSBt
aWdyYXRlZCBpbiBmdXR1cmUgZG9lcyBub3QgbWVhbiBhZG1pbiB2cSBMTSBpcyBzZWN1cmUsIEkN
Cj4gaGF2ZSByZXBlYXRlZCBmb3Igc28gbWFueSB0aW1lcyBvZiB0aGUgYXR0YWNraW5nIG1vZGVs
LiBhbmQgSSB3aWxsIG5vdCByZXBlYXQNCj4gYWdhaW4uDQoNCj4gPiBUaGVyZSBhcmUgb3RoZXIg
c29sdXRpb25zIHRvbyB0aGF0IHdpbGwgYXJpc2UuDQo+ID4gSSBoYXZlIHNlZW4gYW5vdGhlciBv
bmUgdG9vLCBtYXkgYmUgRFBVLg0KPiA+DQo+ID4gSW4gYWxsIHRoZSAyIGFwcHJvYWNoZXMsIFRE
SVNQIGlzIG1pZ3JhdGFibGUgYW5kIHNwZWMgd2lsbCBldm9sdmUgYXMgbXVsdGlwbGUNCj4gdmVu
ZG9ycyBpbmNsdWRpbmcgSW50ZWwsIEFNRCBhbmQgb3RoZXJzIHNob3dlZCB0aGUgcGF0aCB0b3dh
cmRzIGl0IHdpdGhvdXQNCj4gbWVkaWF0aW9uLg0KPiA+IFZpcnRpbyB3aWxsIGJlIGFibGUgdG8g
bGV2ZXJhZ2UgdGhhdCBhcyB3ZWxsIHVzaW5nIGFkbWluIGNvbW1hbmRzLg0KPiA+DQo+ID4gSSB3
YW50IHRvIGVtcGhhc2l6ZSBhZ2FpbiwgZG8gbm90IGtlZXAgcmVwZWF0aW5nIEFRIGluIHlvdXIg
Y29tbWVudHMuDQo+ID4gSXQgaXMgYWRtaW4gY29tbWFuZHMgaW4gcHJvcG9zYWwgWzFdLg0KPiB3
ZSBhcmUgZGlzY3Vzc2luZyBMTSwgcmlnaHQ/IENhbiBURElTUCBoZWxwIHlvdSBoZXJlPyBURElT
UCBzcGVjIGdpdmVzDQo+IGV4YW1wbGVzIG9mIGF0dGFja2luZyBtb2RlbHMsIGFuZCB5b3VyIGFk
bWluIHZxIG1hdGNoZXMgaXQsIEkgZ2F2ZSB5b3UgcXVvdGUNCj4gb2YgdGhlIHNwZWMgeWVzdGVy
ZGF5Lg0KPiANCj4gVGhpcyB0aHJlYWQgaXMgYWJvdXQgbGl2ZSBtaWdyYXRpb24gYW55d2F5LCBu
b3QgVERJU1AuDQo+ID4NCj4gPiBBcyBNaWNoYWVsIGFsc28gcmVxdWVzdGVkLCBJIGtpbmRseSBy
ZXF1ZXN0IHRvIGNvLW9wZXJhdGUgb24gZG9pbmcgam9pbg0KPiB0ZWNobmljYWwgd29yaywgc2hh
cmVkIGlkZWFzLCBrbm93bGVkZ2UgYW5kIGltcHJvdmUgdGhlIHNwZWMuDQo+ID4NCj4gPiBbMV0N
Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0aW8tY29tbWVudC8yMDIzMDkwOTE0Mjkx
MS41MjQ0MDctNy1wYXJhdkBuDQo+ID4gdmlkaWEuY29tL1QvI21mMTViNjg2MTdmNzcyNzcwYzZi
Zjc5ZjcwZThkZGM2ZmVhODM0Y2ZhDQo+IHNlZSBvdGhlciB0aHJlYWRzLCBJIHByb3Bvc2UgdG8g
cmV1c2UgdGhlIGJhc2ljIGZhY2lsaXRpZXMgb2YgbGl2ZSBtaWdyYXRpb24gaW4NCj4gYWRtaW4g
dnEuDQo+ID4NCg0KSSBkb27igJl0IHNlZSBhIHBvaW50IGluIHJlcGVhdGluZyBhbnl0aGluZyBh
bnltb3JlIHdpdGggeW91ciBjb25zdGFudCByZXBldGl0aW9ucyBhbmQgaWdub3JhbmNlIHRvIGlk
ZWFzLg0KDQpJIGFtIGhhcHB5IHRvIGNvbGxhYm9yYXRlIHRvIGRyaXZlciB2aXJ0aW8gc3BlYyB3
aGVuIHlvdSBjYW4gZ2l2ZSB0aG91Z2h0cyB3aXRoIGFuIG9wZW4gbWluZCB0byBhZGRyZXNzIHR3
byB1c2UgY2FzZXMgdG8gY29udmVyZ2UgYW5kIGRpc2N1c3MuDQoNCjEuIHZpcnRpbyBkZXZpY2Ug
bWlncmF0aW9uIHVzaW5nIG1lZGlhdGlvbiBhcHByb2FjaA0KMi4gdmlydGlvIG1lbWJlciBwYXNz
dGhyb3VnaCBkZXZpY2UgbWlncmF0aW9uDQo=

