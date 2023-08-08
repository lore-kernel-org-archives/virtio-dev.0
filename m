Return-Path: <virtio-dev-return-13492-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ACCC04A94
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:17:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B811371C8A
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:17:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEE8A986499
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:17:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9CC25983EB3; Tue,  8 Aug 2023 04:17:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 88458986460;
	Tue,  8 Aug 2023 04:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHOOPW4VFhEFB6mJK5opFs+kWTsDUxCJ8Xp6db4K604X0rwUauC95UQrIRPgCtaVxiFhD3DDPODLSB3C8fA8lB7kvtBhbxtTSuksWHb1lOXVklGHnAQjrw/RN7Vbnsx9m0E10k0rQ7zK16q0IWT+KCzR8oe58sZwZpi9/JHfI+wZ3DVABvtULQkkTDIJyXmQXtJX7ciiaB06Eul/U5CjQthbOEG+tKZunJSInlyRScz4EqWoM6MuSqMce6PHCLeCxvgv2tcs7W/msem2AKXa/ZUf5xpScG25bPyNkfceBkSV5Lh8o9aTI/12NbTuUB6q05owFD9ZA2yO0gywp0WEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poXmZjTJVoLq+4M4kQBbBNVXUHnrPxz7baSuBrZ/H98=;
 b=bxOg2bfhofpzIjR8g3tZrAdiLaTtPoklcjUA6+aceGi9GdfDHJ6N4sLp2tuZvgxaGQ4bgxVG9LPpL1oZxAxXeHlms2fPvxtM19a4LmbOCbKovVjdN3/6p8z1EvQeBxgPVB7Ky/ao49wncQUsqiNadsCTLJmv0lsgAHZr9UWfwyy6wNXXCOpAWJONfi2emUeAh6n8/4kRUeVCaqfU51CJv46wUchDUz0wFFssmVe14bByZpq5mRpu0k9gWC7wOgILpJqPaDzW8HQdYFVModlgBlQH51l8g2NBI00YBpDVwSbJLewAC/1V5cdAXBUWtOhAaFu2Zwxci87mlxtRTBL59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAESeeAgAFTlICAAAUXAIAACRuAgAABk3CAAAoJAIAABc7g
Date: Tue, 8 Aug 2023 04:16:59 +0000
Message-ID:
 <PH0PR12MB5481C7090E20AF17A9B2C437DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
 <PH0PR12MB5481D3BDFB943D7856D846A9DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvzU4SE8wBoTE6A56S9bGM_rtv=nU113WhEUL2EBEBaug@mail.gmail.com>
In-Reply-To:
 <CACGkMEvzU4SE8wBoTE6A56S9bGM_rtv=nU113WhEUL2EBEBaug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4473:EE_
x-ms-office365-filtering-correlation-id: 7d1956b4-0015-4e78-89e5-08db97c64f85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tk4aE4mN7W3xAvpUBnthDZaOkXtfk1WOLDvoMHHmSpuVxHNv07FbWHfJM98vzibLTFi7S64KzuTKijNF959MdnqW5jnuM0jH8x4AkSXdBk6QDWCsua2nof2kNo4zXxczQTOM2uT9ufHj4doC6/mb6tZZBQbvqqXU2PRK120UheavZp/qzXsWAtnBuuQ98+e5QmHItwti65zSCxT0OjlMNmcvIuMgoJ60YTxlR0RDhfAYhbTZe8ma82PCw3xr1AYQUN8Q+xt3sg/cLven6QnvGnYiQ5wzV7mc0msSA2TGFtpbVUkktXvnh6sSy898Xtnx8F7/3EQ2aEyvxVNxnlHYu4uGEaGd8zI71zh4vdzYxGDvAv7bKyiJYNT1XG5CEfWnvAWFEIi1X3zG4bO+Y2La7kJP8J0RU6eqnn1ILWfl7a8b3vQzkZHL2kK24iaD8+mK5TedvqRg5eMMfHP/x6407VtKa8VUeVSgiEbql9RfATdl9OMT5d1LAzzfyWSHEFgCCMyxeID5pnAnJL9KvfnWe7we0pUg3y4r+WNcsI6KbML/YVX/lPMKa6gWJ/iXbGvgB6IRl3VZ33mfV8FT4meVlK1SifP/cdJd2ClWWLwUCaBc6Bg82aXQsXZ3Wv/LkDZtzOl+RTOvvQNdC8NnDSsxg7E2ANzoXdYIMgLgpPgPe9u9FW+0wxIE5nA2Z/1p2zry
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(90021799007)(1800799003)(186006)(90011799007)(2906002)(55016003)(83380400001)(41300700001)(52536014)(5660300002)(8936002)(8676002)(38070700005)(33656002)(86362001)(478600001)(122000001)(71200400001)(66446008)(54906003)(38100700002)(26005)(6506007)(9686003)(7696005)(66556008)(4326008)(66946007)(66476007)(6916009)(64756008)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODM0L1hReENrYzlTMDBvbldhekdwbm82b0dLclU2NFVOVy83OFZ6ZjdSeWxE?=
 =?utf-8?B?T016eERjTGgxbFNaTlpUeitJT0ZpdFdiM0VaQjFuM29QUGdvcFFLR2dVdThN?=
 =?utf-8?B?bTFnaXFZUUhvRHEreEhnTTU0R29ZM2hXRzdKWjMvSExIbDVCL2hncVFSODBD?=
 =?utf-8?B?SFpIQ2VCc2UwSExjdFdCa1ovNG04UjVnMVhOenZTcTVrUEZ6U0ZtWkZOUHpP?=
 =?utf-8?B?OWtaQkpGbnhSMDA0aG16V2ZqWjkvSGJXbU5RaFdBdnhnYVhnMVNXQy9qd1RQ?=
 =?utf-8?B?T0JsbHU3RW9zMGhEdXpNK0lmaFNqc1c4YVc0c1N4OHRJRmVNZGdYQktiWXla?=
 =?utf-8?B?UFhaeGIwS2lac010blREN1l4QVJpTnVDK1JPRG9tNmF4OFFVdDM2ZFl2NEJ4?=
 =?utf-8?B?bjNPeG0yZkJZMEhKMXBOMG92enhVbGpCcXhGOXRLUzVlUHNYZFVyMUhuT1Zx?=
 =?utf-8?B?dzFsQ0FGSkErM1phcUZkRldYM3FEVjdINzJwMkdjYnZ5ank3MlVrZE03TDNo?=
 =?utf-8?B?eGxrUXBpVW5MaXBMUmNHc1l3VDdnZkdTQUJNWEFBaDlST0k5VStMSStnbXJu?=
 =?utf-8?B?RXM0NThJN2NyVkw2OUNZdTNVRXFGbmRiRjlaWWl1OVUrMGZiMGN2Q0JWWm1X?=
 =?utf-8?B?ZE1qVDZoWFN6VzB5MXNIUnRlUUNubllSMG9pb29yRjAwUS83VnVSOEFEWjdo?=
 =?utf-8?B?T2RKbXRYaHZiWFpVYXE1VmZ6RmkvQ3pnRVhXSmhIM3RQU3pVVTdRVk51VEkr?=
 =?utf-8?B?MitiVE5JZnIyazA2RE1FMmJhLys3YnpxL1U3Z3NON0hqQXdDK1dUTUJNTDJB?=
 =?utf-8?B?TTQ0bmM4Z1lZMnd3OTJJdzVNVitzUEhISkkyc0NZaGlCQ3FFdUVkNnUyL24r?=
 =?utf-8?B?NHV1VC93V0N3d1lNMFprUEdPQ2RXWE1VTmUwOERoNHBNL0hRNkZiWG1ja3Z4?=
 =?utf-8?B?TmJUVCtrYkUzV2JHTktkMEdDa0UzZVRvTCtUUkhKWXJNY2tIZUl0ZCtFVWxL?=
 =?utf-8?B?RFNZNzQ2SSs3VTJtM3JJaTVPc1VqME1YTm4wQVNRNnllYndjMlVsdjh0WmN3?=
 =?utf-8?B?MHpZVC9aVnRPRWxjOVp3WkIwVDBEcnV3T3pJUjU1WmhyMndlbTYwRVEybDUw?=
 =?utf-8?B?NHZQLzlHNDlJZW4rQUhESWx4SXQ2V1VOSnB5bnpQVnpORE9sL2MrZzhXdXdC?=
 =?utf-8?B?Q0RIOXRNSE91MWJVYVJYNVlmY0JlK2djZmlnL1RIOUNRT0FwRWwxRTgzOS8w?=
 =?utf-8?B?VEdMR0ZvSVd6RkNDZGVyQ2w0VG1TS25leU0xNklLb2ZscFBOeS9pM0hTWUFl?=
 =?utf-8?B?aEJDZ3U1OUxocGtLQUlKRkszYU9IZ2VlQ3A5b2dqZXRzT2dIRnQzVWZBS1lB?=
 =?utf-8?B?Z01jeHNtVXJHWXF0ZllLNHB6QUVNcE1LcmpNcW9xYlF5cUtCbC83enk4YThS?=
 =?utf-8?B?OE5Rb3FLRlhhY0g5ZEdVcGc0alhLMlBxU3kvMG9XdjZ3elB2V1VJcHRMQnla?=
 =?utf-8?B?NzBFSThTZWxCVExQWExsMHh4RXk1TTVRSWhQeDZIN0VnQW96WjNDUVVTVG10?=
 =?utf-8?B?R3YybnovckI3aWhhSkxNZDRKMkhDeFdkZkJWRWxzeEx0aXo0andZdnlhYk4z?=
 =?utf-8?B?Z0N5Vk8xV0dONWxMbm4wWkZpYjR3azA4b2tRR0dOOVI3dGVwekhubVVsaHIr?=
 =?utf-8?B?RFpvWXhvcUdCOTU1Vjh6NksxMVVabWdZL2tPczZOTGNhSDdNU1B4V1lYUTJQ?=
 =?utf-8?B?b2xWYXFPb3MzeUdlVVBFTlZvNEZwa1RkSW1jaWlQVHBVSEY2VEdjUjhPYTJD?=
 =?utf-8?B?MlQ3YklFN3JNRkFUNGMweTJjSHE0aTJhTGpsbTBKbk9ZcTdQWEVha0grYlp6?=
 =?utf-8?B?Z3h5L1hTUDNMSHpQRjN0WFdLK2JCM1RpOTUzKzUraUdwckw0anovR0lBeDF6?=
 =?utf-8?B?aWovOWh3SU9WdERaOUNYMlNQTnBYeUo5QkxsUVRMS2hETVhsaThXSzBvUk9Q?=
 =?utf-8?B?K2VrR29CRFY1c0oyZWJPREl6SHlvSEY5dVBaRmdrdFlORWlWQXkwd25YK3Bv?=
 =?utf-8?B?SnVjTno5S2RvcEZKS3lxQXM2ZC9RTVgvYzNTRkNpbjZ3U1ZHSkNQeCtZSTJC?=
 =?utf-8?Q?TKSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1956b4-0015-4e78-89e5-08db97c64f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 04:16:59.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCx97ELcQB7+6I7Y71wJOwwkvBnrjobv2ZZ0S4K/nHTRrNy68PqLCmx812k9IWGwZGz/X/g9KtljzrYIyr8eQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
Subject: [virtio-dev] RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCA4LCAyMDIzIDk6MjEgQU0NCg0KPiA+IFRoZSBpZGVhIGlzIHRvIGludHJvZHVj
ZSBmaWx0ZXJzIG9uIHRoZSBuZXcgdmlydGlvIHN3aXRjaCBvYmplY3QgZm9yIHR4IGFuZCByeA0K
PiBib3RoLg0KPiANCj4gSXQgY2FuIGJlIGRvbmUgaW4gdGhpcyB3YXkgZm9yIHN1cmUgYnV0IHRo
ZSBxdWVzdGlvbiBpcyB3aHkgaXQgbXVzdCBiZSBkb25lIGluDQo+IHRoaXMgd2F5LiANClRoaXMg
b3B0aW9uIGJlY2F1c2UgaXQgaXMgaW4gdXNlIGJ5IHZlcnkgYmlnIGFuZCBtYXR1cmUgZWNvIHN5
c3RlbSBvZiBtdWx0aXBsZSBzdyBzdGFja3MsIGtlcm5lbCBzdWJzeXN0ZW0sIGRyaXZlcnMsIGFu
ZCBuaWNzIGZvciBzZXZlcmFsIHllYXJzIG5vdy4NCg0KPiBBIGRyYXdiYWNrIG9mIHVzaW5nIHN3
aXRjaCBpcyB0aGF0IGl0IGludHJvZHVjZXMgZGVwZW5kZW5jaWVzLg0KPg0KRmVhdHVyZSBpcyBu
b3QgYSBkZXBlbmRlbmN5LiA6KQ0KIA0KPiA+IEEgdmlydGlvIHN3aXRjaCBvYmplY3QgY2FuIGJl
IHBhcnQgb2YgYSBleGlzdGluZyB2aXJ0aW8gZGV2aWNlIG9yIGEgbmV3IHZpcnRpbw0KPiBkZXZp
Y2UgdHlwZSBpbiBpdHNlbGYuDQo+IA0KPiBUaGF0J3MgZmluZS4NCj4gDQo+ID4NCj4gPiBYdWFu
LA0KPiA+IEFzIHdlIGRpc2N1c3NlZCwgc2luY2UgdGhlIG93bmVyIGRldmljZSBwYWNrZXRzIGFs
c28gbmVlZHMgdG8gYmUNCj4gPiBmaWx0ZXJlZCwgcG90ZW50aWFsbHkgb3V0c2lkZSBvZiB0aGUg
b3duZXIgZGV2aWNlIGl0c2VsZiwNCj4gDQo+IFRoaXMgc2VlbXMgdGhlIGFkbWluIHJlcXVlc3Qg
b3V0IG9mIHRoZSBzY29wZSBvZiB2aXJ0aW8uDQo+DQpOb3QgcmVhbGx5LCBpdCBjb3VsZCBiZSB2
aXJ0byBzd2l0Y2ggZGV2aWNlIHRoYXQgbWFuYWdlIFBGIGFsc28uDQpBdCB0aGF0IHBvaW50LCB0
aGVyZSBtYXkgYmUgdHdvIGZ1bmN0aW9ucywgUEYgYW5kIHN3aXRjaGluZyBQRiwgc3dpdGNoaW5n
IFBGIGZpbHRlcnMgdGhlIHRyYWZmaWMgb2YgdGhlIFBGLg0KDQpBbnl3YXlzLCBJIGFtIGp1c3Qg
bm90IGZpbmRpbmcgaXQgdXNlZnVsIGVub3VnaCBhdCBjdXJyZW50IHBvaW50IGluIHRpbWUgZm9y
IHVzIGFzIGZhciBtYXR1cmUgYWx0ZXJuYXRpdmVzIGV4aXN0IHRoYXQgdXNlcnMgYXJlIGNvbWZv
cnRhYmxlIHdpdGguDQpJIHdvdWxkIGxpa2UgdG8gbGlzdGVuIHRvIFh1YW4gaWYgdGhleSByZWFs
bHkgaGF2ZSB1c2UgY2FzZSBmb3IgaGF2aW5nIHN3aXRjaGluZyBQRiBhcyB2aXJ0aW8gb2JqZWN0
IG9yIG5vdC4NCg0KDQo=

