Return-Path: <virtio-dev-return-12616-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ABCC7EE22
	for <virtio-dev@archiver.kernel.org>; Tue,  9 May 2023 03:56:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B00DF3F547
	for <virtio-dev@archiver.kernel.org>; Tue,  9 May 2023 03:56:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5EB4986547
	for <virtio-dev@archiver.kernel.org>; Tue,  9 May 2023 03:56:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9B5839864BD; Tue,  9 May 2023 03:56:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 890A19864EE;
	Tue,  9 May 2023 03:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br2LF3PWpYEFQSiSlGgW8ef5EILhzJm8r+HElPpn32j/PVJfHrmxgtCupR6x3R3C6HVhrNuBetUz6czagvPf1u3y6areBPtXuMMRSgYEGQyBwRlr7EFdmGZNiId9Dv8hnYvzefQDWCTEwrTL0F62x+H4C7pY3Cy0ymUT4uPTJ4KpjZOInAE514qd0g5MtCVopJm+Bfd0pGOVjfOgYvl7LX+kpxpwM5d41emx/0GIBCxKNOxM8hLTUDWoEfwvGAukLIDgWTyBxCeb6GI3AaDjQq/q8pxlR5Qw/eaMWKa8fta6KGtWaDd32qCzZJZUUmKxJRkSTi3/mLe5YgOdiG4N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W3wq88j9PUlULDv5p4EOPSMsceNepvWhSNrSZLU0ao=;
 b=EVS60pE0/jA50DvawAAgtRI62Y5bHlv+pIosgIZb+UMvgIVxZ0Ysn9MhrwDE1bZiYQU9ydC4UgiwAOuT6mooDjfCCYy11MRk1lEZzq9yiWXWAqLYKoTAnluGrzGSIoWXAtsuu7vDCeFkfj50DCj8uzZG6zuFnclhAHHmkk/HH5WtBqeR1OxMSWWu15dSg/OM2SxDm1zd0GZ31MpYzP4WDIzdgeN7I/SdysiazKgsaW/PMhq4d1CN71aE4ejXtp4Fqgs0QqLxchUAE1oBNnXWz88B22loo8wO1tpCfA6w9zaJqWYdYdiBAYf0O4OhrmwpjgQrcNQEg3LxvHD2uMrDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIAA9w4AgACx3QCAAADx0A==
Date: Tue, 9 May 2023 03:56:38 +0000
Message-ID:
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
In-Reply-To:
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6660:EE_
x-ms-office365-filtering-correlation-id: 7b79ea83-b3f5-4340-c149-08db50416458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C/vkdJ+H4qjlT9Ok8kKd6jTBbFt+va1fyIWS6Ptw5KZlkF+IDGtiDiFs8GTHvZ8d5AoJjJFm/VML/BmM2MOs28FLM8qAcOiXG/LrxHJ4LG4pmdQF4b6WXFMAWO///lM+8OrsI2f4Jx2i7xapNOgkODXe64lo2V6jCM65PtCQNTME5DYySIiJxFZ+85CX+tjaLi92EbkcC0TYJNQZHV4GSDHuLQd9idG/pRt+PvBw4VyWbAiNW8jSQAMcJTOLANGBueAAFGEKi4TQLI2TE3MaqXJQ5cxdKcG4evsy1ewKFeUlgQKPqrTJIV8KGFe3ixWhAv7whrKhCf3Vvn0HArNCEHi4MfyvKZNMz62GmxdaRHziqxGFtJGhPi4mKQCrKt/Do9WS6A7vKXog4jMhj5I4tnvLaRdvG2h+56OXzbehCd0Vx9s3BfMTMKrv4LzK/lxZoRNq6TD6ih5LyzIxWejBHD7PQ4turO5zvZbJUWc06xSkY6oqQ+IGWCLNGTTp0YQ+FuvhFE2qGcKR9X2p0yKQ6YO0DIe779r7gQWWfgR5IU93KJIdkctstuWm2RPRmX5fPJwXcEK1buDrV2SekEFxMra1UXjSrRz6w0P4E0C8uFuf73s6wghHvnHrmIFah5di
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(86362001)(66476007)(33656002)(54906003)(66946007)(316002)(478600001)(76116006)(66556008)(66446008)(64756008)(6916009)(4326008)(7696005)(55016003)(5660300002)(52536014)(2906002)(71200400001)(41300700001)(8676002)(8936002)(122000001)(38100700002)(38070700005)(186003)(26005)(107886003)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjlHUTFPc1RpNFU2RHhHM3RURTVNbGF5VDFHcWw4T2lTbUVuVzBPQXUzTjNx?=
 =?utf-8?B?WDdKZHBpTlo1LzBRU3JqRWdLSm1QcC91Q1dwNFpKQ2ROc1ZyYTFxWWpCSGgy?=
 =?utf-8?B?OUltMGRsOGQ1NVU5MmxsMlNHNC9jSVllYjA2OTQ1UFVHMEtEM2ZJN1RnQ0ZL?=
 =?utf-8?B?aDBQeFYzaXN1TGY0d1JDWFpTdGF1WVZMUUwxcEJlQ09NWHdSR0VwUlVlSmk2?=
 =?utf-8?B?UjVwQ0ZxWFQvNGYrZmFIWmN0bFVTUDhqekJ4bDVlUmluclhmV0hKUTIvRjJy?=
 =?utf-8?B?bUpvc1dtcnlqTGJVUnVPcVN5ME9sWTBPUnZsTFhNejRJY0NGZUJPMHVPUjBm?=
 =?utf-8?B?OWVRL25kTGo1bFBBNmE4YVA5K2xhZ1VGUllPT28yenJnRzM1SEY2VW9YY01s?=
 =?utf-8?B?cXNaWVVZdWlWMWh0RGNwQzF0bWV1ZzZxN0t1Q1UzOVRZOWxldTdua2FTVlVz?=
 =?utf-8?B?ZEpjeDBNejZjVGdvd1JhWnNoMnZleXVLTG8xVTQ5KzR1VEpseDlvWDJvaXIz?=
 =?utf-8?B?V2tTRmNtZ2dnVVlkYjlidlQ0YkJtT0ZPQTFsc1lUaUZiU0dEdGp1a01VdFNt?=
 =?utf-8?B?SS9Nd25vNHBJQkVVakRJZWtITXFIVVByOUU4TkltYU44dGc0dlpLMDZQamE0?=
 =?utf-8?B?NzhKU2VpTUNkVDlwY0EzNlBPYXlDbDhnalJwM3VqR1U5RENFc1p0cmxKbzZt?=
 =?utf-8?B?T1lyRTdwK0xVTHlYVFgxeURiTXpJRDl5RDlDMFU4dEV0Mk45aTY5MUx0UTZC?=
 =?utf-8?B?YklpVmp1TUNzRkZaeEtZc1ZncVplYU1OT24zUUVDd2NEVjIydWJzNFNkRWhO?=
 =?utf-8?B?V0xmd0pCM0dRWUlVUjFLckE1L3ZtRlp4NENTdnlidDV2Wk1sYjI1cFpIdG04?=
 =?utf-8?B?WWs1dGwvL29VYStwakhmOWVkdThVZ0xTNkVGOUNWM1AxeFkvd2lkbzJVaE82?=
 =?utf-8?B?cjFNeExlU0dPajVpY2tBRkptRStielBzdHdJRDNDalkyQ01QYjc1QnN2NWtM?=
 =?utf-8?B?Zlh1bWdBckgyUDlJNlNueTZVc1BBVSt5Mzl1cE1IZFhkTmJpQW5pdWFMTHYz?=
 =?utf-8?B?ZkFFTVNieWtoNkNXMWZNOWZ0NitncUJWaVJRblJrUnpJTlJqUWNBMGxHQVBr?=
 =?utf-8?B?NjdUYncxSVRlN0ZFK1VTQVNOT1BFVmh2S05TbmRoc0FGQWNVb2JYVCtmNlRz?=
 =?utf-8?B?Qzl1aDMrZmRqamxUOWo4c00wTlhJVUFoRElScjRSTW4xam15RlF1Y1d6aUh2?=
 =?utf-8?B?YnByS3RidmhWbXU4a3EzWnRZREU5aE9MWVZJczhZVkNpbTlCczRUeXhvTGdh?=
 =?utf-8?B?YnIwdTVsR3kwL2tJRXpPNm9xdDlUa210dmt4UWppS3hnajl6NnpRcmxkZzBs?=
 =?utf-8?B?OHVmUjNYSGRmeVFpRHFVVHpuZTJvZUg1QnAvT3BIRlo5TzNVV2VYZ21jblVt?=
 =?utf-8?B?bEhZRUVTQ2UxekMyU213Z1NmOHR2aU1ZU0FmbHM3MElCOFluMFlxKzZCZGtt?=
 =?utf-8?B?UlJOMjc2ZU9yKzZBT2MxUEx5cERiU21LOGY2Q2NLWUs2dzd2M20vTkdFNWxw?=
 =?utf-8?B?NTd3VWRsTTY2ZUc3Wmt5d0VaOGtRa1hURTJLQzczOHp6UVpRQ1ljNW5BWEVl?=
 =?utf-8?B?eDlNWjVrWFk3OVNjbGp4OXNGYUhYamFTSHJITjNQdkZCK3VQVUFtM0dWeUlV?=
 =?utf-8?B?cWIxeVliQUxzZTA2cUlSUkViUVFjbnE2RHJyNGxGR2x5aXFNWmJ5RFV1UGdn?=
 =?utf-8?B?ZW92c05mMnl5VEx6L3JLK3MzTU5tYmVmN09Fd082RzNvaXRmSEZ2NjYzU2Uv?=
 =?utf-8?B?WXAyYVZ4R1RLUUVUQXhYZ0xUWjRnSnVINy9HZkMyUHhHbkhhWFFFMytVdlNV?=
 =?utf-8?B?NTdUK0hibGh4WVdhMHdvcmRRNDJpQ2dXMkRxK2FoWVVsSnMwZDlQekthekpS?=
 =?utf-8?B?SXo0WS90MWVtZ25VMkZSTnBkK1RpYUMvZ1BrejZLM1lKNXlOUkJ3QUFWOXFG?=
 =?utf-8?B?VVVPcldaQ0NxaVp6SVJTNUgxb3FLSHhXeDgvMDF4ZkRLMlV5UUQwOThwc3ZP?=
 =?utf-8?B?ZkpabkNNVDlUY1NJZVdpNFp2WStQUmFVeG8vYXVMb0ZqQ2VDdWp6ZnNoRitl?=
 =?utf-8?Q?QVsA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79ea83-b3f5-4340-c149-08db50416458
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 03:56:38.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBQk+nQwCZl4IeC3brmRiu9Ha64mszYdgPsM7m+MJpo5H43v7y8mQ/gN/Z6sf5Yju+KvNm6KVnd5j0JNBfOTig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXks
IE1heSA4LCAyMDIzIDExOjQ1IFBNDQoNCj4gPiBUaGUgZnVuZGFtZW50YWwgcmVhc29uIGZvciBu
b3QgYWNjZXNzaW5nIHRoZSAxLnggVkYgYW5kIFNJT1YgZGV2aWNlDQo+ID4gcmVnaXN0ZXJzLCBj
b25maWcgc3BhY2UsIGZlYXR1cmUgYml0cyB0aHJvdWdoIFBGIGlzOiBpdCByZXF1aXJlcyBQRg0K
PiA+IGRldmljZSBtZWRpYXRpb24uIFZGIGFuZCBTSU9WIGRldmljZXMgYXJlIGZpcnN0IGNsYXNz
IGNpdGl6ZW4gaW4gUENJZQ0KPiA+IHNwZWMgYW5kIGRlc2VydmUgZGlyZWN0IGludGVyYWN0aW9u
IHdpdGggdGhlIGRldmljZS4NCj4gDQo+IFVubGVzcyBJIG1pc3Mgc29tZXRoaW5nIG9idmlvdXMs
IFNJT1YgcmVxdWlyZXMgbWVkaWF0aW9uIChvcg0KPiBjb21wb3NpdGlvbikgZm9yIHN1cmUuIE90
aGVyd2lzZSB5b3UgYnJlYWsgdGhlIGNvbXBhdGliaWxpdHkuDQo+IA0KU0lPViBkb2VzIG5vdCBy
ZXF1aXJlIG1lZGlhdGlvbi4NCkNvbXBvc2l0aW9uIGlzIG9wdGlvbmFsIGxpa2UgVkZzLg0KDQo+
ID4NCj4gPiBIZW5jZSwgdGhlIHRyYW5zcG9ydCB3ZSBidWlsdCBpcyB0byBjb25zaWRlciB0aGlz
IGluIG1pbmQgZm9yIHRoZQ0KPiA+IGNvbWluZyBmdXR1cmUuDQo+IA0KPiBGb3IgdHJhbnNwb3J0
IHZpcnRxdWV1ZSwgaXQncyBub3Qgc3BlY2lmaWMgdG8gUENJLiBJdCBjb3VsZCBiZSB1c2VkIGlu
IGEgbXVjaA0KPiBicm9hZGVyIHVzZSBjYXNlLg0KPiANCk1heSBiZS4NCk1vcmUgYmVsb3cuDQoN
Cj4gPiBTbyBpZiBlYWNoIFZGIGhhcyBpdHMgb3duIGNvbmZpZ3EsIG9yIGNtZHEsIGl0IHRvdGFs
bHkgbWFrZSBzZW5zZSB0bw0KPiA+IG1lIHdoaWNoIGlzIGJvb3RzdHJhcCBpbnRlcmZhY2UgdG8g
dHJhbnNwb3J0IGV4aXN0aW5nIGNvbmZpZyBzcGFjZSBpbnRlcmZhY2UuDQo+ID4gVGhlIHByb2Js
ZW0gaXM6IGl0IGlzIG5vdCBiYWNrd2FyZCBjb21wYXRpYmxlOyBIZW5jZSBhIGRldmljZSBoYXMg
bm8NCj4gPiB3YXkgb2Ygd2hlbiB0byBzdXBwb3J0IGJvdGggb3Igb25seSBuZXcgY29uZmlncS4N
Cj4gDQo+IFByb3ZpZGluZyBjb21wYXRpYmlsaXR5IGluIHNvZnR3YXJlIGlzIG11Y2ggbW9yZSBz
aW1wbGVyIHRoYW4gaW52ZW50aW5nIG5ldw0KPiBoYXJkd2FyZSBpbnRlcmZhY2VzLiBJc24ndCBp
dD8gKGUuZyBpZiB3ZSB3YW50IHRvIHByb3ZpZGUgY29tcGF0aWJpbGl0eSBmb3IgVkYgb24NCj4g
YSBTSU9WIGRldmljZSkuIEFuZCBpbnZlbnRpbmcgYSBuZXcgaGFyZHdhcmUgaW50ZXJmYWNlIGZv
ciBjb21wYXRpYmlsaXR5IG1pZ2h0DQo+IG5vdCBhbHdheXMgd29yaywgaXQgbWF5IGJyZWFrIHRo
ZSBhZHZhbnRhZ2VzIG9mIHRoZSBuZXcgaGFyZHdhcmUgKGxpa2UNCj4gc2NhbGFiaWxpdHkpLg0K
PiANCldoYXQgSSBwcm9wb3NlZCBiZWxvdyBpcyBuZXcgaGFyZHdhcmUgaW50ZXJmYWNlIGZvciBu
ZXcgZmVhdHVyZXMuDQpOb3QgZm9yIGNvbXBhdGliaWxpdHkuDQpDb21wYXRpYmlsaXR5IGlzIGNv
bWluZyBhdCBhIGNvc3Qgd2hpY2ggaXMgbm90IHNjYWxpbmcuDQpJZiB5b3UgYXR0ZW1wdCB0byBz
Y2FsZSwgaXQgYnJlYWtzIHRoZSBmdXR1cmUgcGF0aCBmb3J3YXJkIHRvIGdvIHdpdGhvdXQgbWVk
aWF0aW9uLg0KDQo+ID4NCj4gPiBTbyBldmUgZ3Jvd2luZyB0aGVzZSBmaWVsZHMgYW5kIG9wdGlv
bmFsbHkgcGxhY2VtZW50IG9uIGNvbmZpZ3ENCj4gPiBkb2Vzbid0IHJlYWxseSBoZWxwIGFuZCBk
ZXZpY2UgYnVpbGRlciB0byBidWlsZCBpdCBlZmZpY2llbnRseQ0KPiA+ICh3aXRob3V0IG11Y2gg
cHJlZGljdGFiaWxpdHkpLg0KPiANCj4gQ29uZmlnIHF1ZXVlIGlzIG5vdCB0aGUgb25seSBjaG9p
Y2UsIHdlIGhhdmUgYSBsb3Qgb2Ygb3RoZXIgY2hvaWNlcyAoZm9yIGV4YW1wbGUNCj4gUEFTSUQg
bWF5IGhlbHAgdG8gcmVkdWNlIHRoZSBvbi1jaGlwIHJlc291cmNlcykuDQo+IA0KUEFTSUQgaXMg
Zm9yIHByb2Nlc3MgaXNvbGF0aW9uIHNlY3VyaXR5IGNvbnN0cnVjdCwgaXQgaXMgbm90IGZvciB0
cmFuc3BvcnRhdGlvbi4NCg0KPiA+DQo+ID4gSW5zdGVhZCBvZiB3ZSBzYXksIHRoYXQgd2hhdCBl
eGlzdHMgdG9kYXkgaW4gY29uZmlnIHNwYWNlIHN0YXlzIGluDQo+ID4gY29uZmlnIHNwYWNlLCBh
bnl0aGluZyBhZGRpdGlvbmFsIG9uIG5ldyBxLCB0aGFuIGl0cyBkZXRlcm1pbmlzdGljDQo+ID4g
YmVoYXZpb3IgdG8gc2l6ZSB1cCB0aGUgc2NhbGUuDQo+IA0KPiBKdXN0IHRvIGJlIGNsZWFyLCBp
ZiB3ZSBoYXZlIFBDSSBvdmVyIGFkbWlucSwgVkYncyBjb25maWcgc3BhY2UgY291bGQgYmUgdGhl
DQo+IG1pbmltYWwgb25lIGZvciBQQ0kgc3BlYyBjb21wbGFpbnQuIFRoZSByZWFsIGNvbmZpZyBz
cGFjZSBpcyBhY2Nlc3NlZCB2aWEgdGhlDQo+IGFkbWluIHZpcnRxdWV1ZS4NCj4gDQpZZWFoIEkg
dW5kZXJzdG9vZCB3aGF0IHlvdSBhcmUgc2F5aW5nLiBXZSBkb27igJl0IHNlZSBhIHBhdGggZm9y
d2FyZCB3aXRoIHN1Y2ggbWVkaWF0aW9uLg0KVkYgYW5kIFBGIHRvIGhhdmUgc2FtZSBsZXZlbCBv
ZiBkaXJlY3QgYWNjZXNzIHRvIHRoZSBkZXZpY2UuDQoNCj4gPg0KPiA+IEZvciBleGFtcGxlLCBh
IFBDSSBkZXZpY2Ugd2hvIHdhbnRzIHRvIHN1cHBvcnQgMTAwIFZGcywgY2FuIGVhc2lseQ0KPiA+
IHNpemUgaXRzIG1lbW9yeSB0byAzMCBieXRlcyAqIDEwMCByZXNlcnZlZCBmb3Igc3VwcG9ydGlu
ZyBjb25maWcgc3BhY2UuDQo+IA0KPiBUaG9zZSBjYXBhYmlsaXRpZXMgKDMwIGJ5dGVzKSBjYW4g
YmUgYWNjZXNzZWQgdmlhIGFkbWluIHZpcnRxdWV1ZS4gU28gd2UgZG9uJ3QNCj4gbmVlZCB0byBw
bGFjZSB0aGVtIGluIHRoZSBjb25maWcgc3BhY2UuDQo+IA0KU2FtZSwgU0lPViBhbmQgVkZzIGRv
IG5vdCBwcmVmZXIgbWVkaWF0aW9uIGdvaW5nIGZvcndhcmQgaW4gdGhlIHVzZSBjYXNlcyB3ZSBj
b21lIGFjcm9zcy4NCg0KPiA+IEFuZCBuZXcgNDAgYnl0ZXMgKiAxMDAgZmllbGRzIGRvZXNuJ3Qg
aGF2ZSB0byBiZSBpbiB0aGUgcmVzaWRlbnQgbWVtb3J5Lg0KPiA+DQo+ID4gSWYgd2UgaGF2ZSBv
cHRpb25hbCBjb25maWdxL2NtZHEgZm9yIHRyYW5zcG9ydCwgdGhhbiAzMCoxMDAgYnl0ZXMgYXJl
DQo+ID4gdXNlZCAocmVzZXJ2ZWQpIGFzIDMwMDAvKDMwKzQwKSA9IDQyIFZGcy4NCj4gPg0KPiA+
IE9ubHkgaWYgc29tZSBWRnMgdXNlIGNvbmZpZ3EsIG1vcmUgVkZzIGNhbiBiZSBkZXBsb3llZC4N
Cj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCBoZXJlLg0KPiANCkxldHMgZmlyc3QgY2xhcmlmeSB0
aGUgbm9uLW1lZGlhdGVkIHBhc3N0aHJvdWdoIG1vZGVsIG9mIHRoZSBWRiBmaXJzdCB0aGFuIGNv
bWUgdG8gYWJvdmUgc2NhbGUgZXhhbXBsZS4NCg0KPiA+IEl0IGlzIGhhcmQgdG8NCj4gPiBidWls
ZCBzY2FsZSB0aGlzIHdheS4gVGhlcmVmb3JlIHN1Z2dlc3Rpb24gaXMgdG8gcGxhY2UgbmV3IGF0
dHJpYnV0ZXMNCj4gPiBvbiBuZXcgY29uZmlnL2NtZC90cmFuc3BvcnQgcSwgYW5kIG9sZCB0byBz
dGF5IGFzLWlzLg0KPiANCj4gSnVzdCB0byBiZSBzdXJlIHdlJ3JlIG9uIHRoZSBzYW1lIHBhZ2Uu
IFRoZSBwcm9wb3NhbCBvZiBib3RoIHlvdSBhbmQgbWluZSBhcmUNCj4gYmFzZWQgb24gdGhlIGFk
bWlucSBmb3IgUEYgbm90IFZGLiBUaGUgcmVhc29uIGlzIG9idmlvdXM6DQo+IGFkbWlucSBwZXIg
VkYgd29uJ3Qgd29yayB3aXRob3V0IFBBU0lELCBzaW5jZSBpdCB3b3VsZCBoYXZlIHNlY3VyaXR5
IGlzc3Vlcy4NCj4gDQpUaGUgY3VycmVudCBwcm9wb3NhbCBmb3IgbGVnYWN5IHNob3VsZCBiZSBz
ZWVuIGFzIHNlcGFyYXRlIGFuZCBub3QgdG8gaW50ZXJtaXggd2l0aCBwZXIgVkYgYmFzZWQgY29u
ZmlndXJhdGlvbiBxdWV1ZS4NCg0KYWRtaW52cS9jb25maWcvY29udHJvbCB2cSBwZXIgVkYgYW5k
IFNJT1YgYm90aCBkZXZpY2VzIHdpbGwgd29yayB3aXRob3V0IFBBU0lEICh1bnJlbGF0ZWQgdG8g
bGVnYWN5KS4NCkJlY2F1c2UgdGhleSBhcmUgbGlrZSBhbnkgb3RoZXIgcXVldWUsIHN1Y2ggYXMg
dHhxLCByeHEsIGN2cS4gQWxsIG9mIHRoZXNlIHF1ZXVlcyBhcmUgbm9uLW1lZGlhdGVkIHRvZGF5
IGZvciBQRiwgVkYgZGV2aWNlcy4NCihBbmQgc28gYWRkaXRpb25hbCBjb25maWdxIGZvbGxvd3Mg
dGhlIG5hdHVyYWwgbW9kZWwgZm9yIGNvbmZpZyBzcGFjZSBhY2Nlc3MpLg0K

