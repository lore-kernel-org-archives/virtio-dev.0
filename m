Return-Path: <virtio-dev-return-12498-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93097C7EE21
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 13:54:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C26CBF3F6D
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 13:54:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACE439864E1
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 13:54:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A01229864BD; Tue,  2 May 2023 13:54:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C582986485;
	Tue,  2 May 2023 13:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtkHNzOoy6t0Bsity2y1jCPOZXkQNZZ4U8tAWz4qG5TWRaXPu5xYlr0KujdZEanq78tIaR7w0OkhqW+heqqyNUJAjdq1cedrroq2WYlQL1umbMm5hzp8oMEBOtQtQeRfhVdTNYXoQ1eHlU1TGq3oWRgVVvzM4bt0+mqjJlcz5ate0o73aN9NUtKOOKBxpFLege2+ZxV4MtAcusnA3NpxA6Hu9oO6Zky8jUcBDvBQiv+kCBcUyDyaUYQpQGFeQlF48jGof/T5QxEq0PVZckGPvPvpUxgYl1MfFMhhBNcL86UUbROD6K4WBwJy7r9SHHMhMX0d8NrdeO0mdQMVcgOnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtLLWMiE2P5uH1Q7qgqX907Q0QAKvGrhn9rTVHdxIwE=;
 b=OVhsBNKK94BB+xkxUpeDY7Iokwwlzz7Iz1cxZitJdImCukFFn5TvrVLE+NBCBOAGrb1qnm5709C8bJbkhia2o+aB5J/f2vpRdg1RBMGwD2tLGWW6gBRCtiUwFVrdWkBEReO79Dh7j7GliSZeB7tadgZuMAvUOtfJLtFPs8esX/W6WLYQSwKkRMBpqrVuK8Lz1DzPaLTIEGIhhOLiWDn6JL+aHh3ggBPcLiHLayopETJbhvw77oOjCgm+D8Ev48uXWPdWpJvecEoxVCP/BSt7jX9DRU+WYTO7oe+ZpQu7OzUqq0rooxi9l/s25wfY6cm9UkXJa12InEbpbRHK8uKmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, "mst@redhat.com"
	<mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK871I6AgArxGoCAAG1MYA==
Date: Tue, 2 May 2023 13:54:36 +0000
Message-ID:
 <PH0PR12MB5481AC4E6EB12DD865964E5EDC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <f66589c5-63bb-0844-f128-a63d72a9d7ac@nvidia.com> <m2a5ynw6aw.fsf@oracle.com>
In-Reply-To: <m2a5ynw6aw.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5380:EE_
x-ms-office365-filtering-correlation-id: 87047908-f06c-40c1-f896-08db4b14c451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UvdS1WZvE7dxNviYIPqi/PJXFpd3M57X/Sc3Pm3dcF5auqTQUj7u6SaWh0TB5MpO8UsK0ioQ2c7tWF69VHjdN4S+RhfItRBw4NfQ6QV2qNEmJUQjGTD6rkSZl2sfuEADRX4x9Ojxp5DisfFmI9msYYt+PdOgwQd12sqJDPKqJbUE8xUxP8z/tgoqSlNN0VyJMvqNuIM+joZgsXi8qbTC38Z2bUqsb1c9CrmTzCiTWCxG/PnVFIlVXcjdXB1fR7YntMPNufqhScP/X6n9EpTS95s6m6Wwt4IeMrp9+d3QTNpAhSj1SB9QX7NEMuDxnTLqS9dYFH4FiZ+3e/3228Nuc4mtd+Urb8j+j5e7+9425Kfc+mMWCFtQoyIljK/SogSVct6dyaXIx1ERRfFIIoLLXx3s8X2/5p/nAksvw2sYSlCgHSTMBvR76Tw+YGQSm/MSOBZIusZn7MCiY8cU4nCY01fR+m5q4Kv6lbnb3L5oMphMY+Wu40FUkBbb5P+oGzY8QdBD6/CMa4nEIRv8z/VSkVE+QuEYjEoThxr0pVcf+yD01V8aktFbeR+cOsl0FwpS8iV133bD/3+RqCPbnvGHmCj6zSTaF5dr1ukgcXE4UdFVXxNMfvISZtMCvz49SDMo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(76116006)(86362001)(6506007)(41300700001)(8676002)(8936002)(38070700005)(52536014)(5660300002)(7696005)(316002)(71200400001)(2906002)(33656002)(110136005)(55016003)(54906003)(478600001)(9686003)(38100700002)(26005)(122000001)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3N4eEF4SmY0dW1mdWNUSEhjc2YvUDNVYnRSdFo0d3I4SVpKUmtDTXhTY2dO?=
 =?utf-8?B?ZC9uRTFpRXgyL1RlYm9GNlJTMmJLVFdvakNSa2t0amJiRjhrNDVnV29YRzdN?=
 =?utf-8?B?TmJxTEs0dllJMnA2eWhBTHZLVTRLRzBleWpxNG9mZWpNQjh2Vmg1K2lheDhq?=
 =?utf-8?B?alVobmF0V2xzYWI5MjQ1WnVjK3g4REN6dnZjTTZhZmtLRlkrQ2lKNEViZTI4?=
 =?utf-8?B?bVc5Nm9mUmEvc3V1RHJNdmhIdnBpZDVDaVZRM2FRcEl2NTM0aUk5cjF5UzBN?=
 =?utf-8?B?MDAyajdkUkxXVVEyTlJ4NWowQVFzSzUxaFJOY1d2dlp6U0JVUnkxWDdTT3Z1?=
 =?utf-8?B?YnlJUjVXTWw1djZYYlBsUyt1RmU3dlR0RmlVdlVPeCtlMk1DT3luSXJjYjVm?=
 =?utf-8?B?MW5FbTVwR1dKTE4wNE1lSGpuZTMwQXg4L0tQT0x1a1F0ODhheGNzQmxYalBI?=
 =?utf-8?B?cVV1ZjNQdUF3Sy8vSU8yUWVQeS9WR3BKWktUVHk5N05Qa29Bc3FZK1ZUOXNF?=
 =?utf-8?B?Z2MvOCthdVUrRnZ1RE43RmtFWlBGQ0plNElRdTRmeGVJdVZFOW9qQUpJWGdo?=
 =?utf-8?B?OThpczVmRG1GbkVQdW5SZVVreG5IL3N5RU5sQnlHV2pYeFNhWlIwTVNlSVoy?=
 =?utf-8?B?QnZyc1NjZENCanM3TGFxTjBraTRNTU5FTjU3YU83MDl5OVVtQ3dGN3ZESHVx?=
 =?utf-8?B?citHaDl2Rmp5dnZlcUNkblJzS2tvNlN3Q2FMdk5oeThTVGc5NHhSbHNFeUR3?=
 =?utf-8?B?akozQmpiVy9DSjdFcFNETzB3a2gycVFXM24wWHpBSW9RdkdGVWlMQWRmNGRL?=
 =?utf-8?B?a2NoWFNyM1BuWFNHRGZsT0ZDeG52c2xVNEFKZmlpRVlxclNzajdrc1JPL0ZY?=
 =?utf-8?B?MEN6ZjFCUDBIZldYWlJtZEhiekVIQlByM3k4OW95UkxST3U1TGN0cStNSmh0?=
 =?utf-8?B?TVV6WThxTlBRbDExMWlrQlR6ZHJ0WVFsbWhsbXlaQ0NoVHZLNTI3REdkQndB?=
 =?utf-8?B?eTdabFZ1dnhsNGtwcTA5RjZzQmlUNHhFay8vN01rSS9qNTZtWHJEWm5uaFFS?=
 =?utf-8?B?MzM4VFNVUjVKWlk2UFFzUDBOSjRwY04wTlVFNitBeGZPZERPWVkzWEFLSUJ1?=
 =?utf-8?B?SDRuYUt5VjI1elU2aklhUTdmbWpqWlNvdzQrU3ZXSnp6VXRyTEVGRHdOT1F1?=
 =?utf-8?B?c0h2MStPZURQSUpKU0lVN3ZDZDZxa3JCWlBteGl5SnpwTDhiT2dUb21aN200?=
 =?utf-8?B?VHVzM3JQQUZ5TFYzM2hZVm5WT0dGaVBEU3ZnbFVRU01JbVRkaHROQ3VkSkR1?=
 =?utf-8?B?V1ZOU3BINFVGbW1ISXYyRmVHVUFoZEl0UW9hc0ZNakNkaDV5bTRZYWtYbWxo?=
 =?utf-8?B?OUYxcjc4RjBQTDBTZVdBUG93S2ZMd3YwdWJMc2FNQWVXd0p5K1hCLzdydU1Y?=
 =?utf-8?B?ajk2TWUrRWlKWG1HMVdCTXNQUzhWRDVrMEg5YVAwVGlJcTRjeC9QZXBqUG9x?=
 =?utf-8?B?Mjh1MHErMU5WOWFlOCt0SDBqejFpT0h4VWtpeENnWlBoOUF0SW52WTBxRjF1?=
 =?utf-8?B?WXBEMHdmZUh1R2pUdXJ2dGZLdFpHZFZoTjBZQ0h3b0ZIQlZ4RzhWeUp5NW5F?=
 =?utf-8?B?QUYwZWVFaHpCcWdEZU1pbzk0RThJT3BnWFRIUlBvZWkvZ0tQRitla21OSDRa?=
 =?utf-8?B?K3dOTmZxV3JDL1drUFMvdUNOTWtSenJXemxDYmxkalRSODFFQTFuTWR2aHUw?=
 =?utf-8?B?OFVySXBPVzh5d21JdUpMa0ZRSDFjdTlNYVA5L0tzQXUxTzdaNXRFZ3pPRE54?=
 =?utf-8?B?eDhML2VKM0N0d3lwdGdlNnBNKzlWRjVYdmlONWcwOU5DTEluSFhSbytDMUtl?=
 =?utf-8?B?Unlzc3pTNEhLTnBOdkNjNUlNZ3dMOVNjTnRmaXJNQWVVdTl0QmhKbWxjMVMw?=
 =?utf-8?B?TDRDU3BycXdaOGtRemFaNmNzUnU4MUV4MDFnUFd0R0ZDTnFBKzJ6bGg4U2l5?=
 =?utf-8?B?L0lBd0JCeUdMVnU3dTRNa1g2Z29DYWVIUWVnV1FUUUR5RW1HS3ZTUzlOQzNx?=
 =?utf-8?B?UWQrR3BwY2E0bjFTa2lIc3lKZmtEVHg3bzVtdWY4MDI2RVJqNEhYNW5wMkdZ?=
 =?utf-8?Q?I8brxAf42UeHDb/8zumzBfyKl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87047908-f06c-40c1-f896-08db4b14c451
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 13:54:36.7656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1QmIlPln40thZL+tbyy1wESDC5DIyFLFEfdlfc+H0Y+tojtoo/PWz505gyBO+UJPtthveuud/AJR9B4nysRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device

DQoNCj4gRnJvbTogRGF2aWQgRWRtb25kc29uIDxkYXZpZC5lZG1vbmRzb25Ab3JhY2xlLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgTWF5IDIsIDIwMjMgMzoxOCBBTQ0KPiANCj4gSW4gbGluZSB3aXRo
IG91ciByZWNlbnQgZGlzY3Vzc2lvbiBhYm91dCBhZ3JlZWluZyByZXF1aXJlbWVudHMgZm9yIHNw
ZWNpZmljYXRpb24NCj4gY2hhbmdlcywgSSB3YW50ZWQgdG8gc2F5IHRoYXQgd2UgaGF2ZSBhIHNp
Z25pZmljYW50IGV4aXN0aW5nIGVzdGF0ZSBvZiBWTXMgdXNpbmcNCj4gdGhlIGxlZ2FjeSBpbnRl
cmZhY2Ugd2hlcmUgdGhlIGN1c3RvbWVyIGlzIGRpc2luY2xpbmVkIHRvIHVwZGF0ZSB0aGVpciBz
b2Z0d2FyZQ0KPiB0byBhIG5ld2VyIHZlcnNpb24gKHdoaWNoIG1pZ2h0IGNvbnN1bWUgdGhlIDEu
eCBpbnRlcmZhY2UpLg0KPiANCj4gR2l2ZW4gdGhhdCwgc29tZSBtZWNoYW5pc20gZm9yIHN1cHBv
cnRpbmcgYSAobW9zdGx5KSBoYXJkd2FyZSBvZmZsb2FkZWQNCj4gbGVnYWN5IGludGVyZmFjZSB3
b3VsZCBkZWZpbml0ZWx5IGJlIHVzZWZ1bCB0byB1cywgYW5kIHRoZSBwcm9wb3NhbCBoZXJlIHNl
ZW1zDQo+IGxpa2UgYSBzZW5zaWJsZSBhcHByb2FjaC4NCj4NCg0KVGhhbmtzLCBEYXZpZCwgZm9y
IHRoZSBpbnB1dHMuDQpJIGFtIHdvcmtpbmcgb24gdjEgdG8gaGF2ZSBsZWdhY3kgaW50ZXJmYWNl
IHN1cHBvcnRlZCB1c2luZyBwcm9wb3NlZCBBUS4NCg0KSSByZWFsaXplZCB0aGF0IGJlbG93IGxp
c3RlZCBQQ0kgZXh0ZW5kZWQgY2FwYWJpbGl0aWVzIGlzIG5vdCB1c2VmdWwgZm9yIHRoaXMgd29y
ayBiZWNhdXNlIGV4aXN0aW5nIGNhcGFiaWxpdGllcyBpbiB0aGUgbGVnYWN5IHJlZ2lvbiBuZWVk
IHRvIGJlIGFueXdheSB0aGVyZS4NCkFuZCBuZXcgQVEgaW50ZXJmYWNlLWJhc2VkIG1ldGhvZCBk
b2VzbuKAmXQgdXNlIGFueSBuZXcgY2FwYWJpbGl0aWVzLg0KU28sIEkgd2lsbCBkcm9wIGJlbG93
ICM1IGZvciBub3cuDQoNClJlZ2FyZGluZywgb3BlbiBxdWVzdGlvbiBiZWxvdywgdGhlIEFRIGNv
bW1hbmRzIGZvciB0aGUgU1ItSU9WIGdyb3VwIGFyZSBmb3Igc3BlY2lmaWMgZ3JvdXAgbWVtYmVy
Lg0KSGVuY2UsIHdpbGwga2VlcCB0aGUgcXVlcnkgYXMgVkYgbGV2ZWwsIHVubGVzcyB3ZSB3YW50
IHRvIG9wdGltaXplIHRoaXMgZnVydGhlci4NClNpbmNlIGl0cyBvbmUtdGltZSBxdWVyeSBwZXIg
VkYsIGl0IGlzIG5vdCBodXJ0aW5nIHRoZSBwZXJmLg0KDQo+ID4gNS4gUENJIEV4dGVuZGVkIGNh
cGFiaWxpdGllcyBmb3IgYWxsIHRoZSBleGlzdGluZyBjYXBhYmlsaXRpZXMgbG9jYXRlZA0KPiA+
IGluIHRoZSBsZWdhY3kgc2VjdGlvbi4NCj4gPiBXaHk/DQo+ID4gYS4gVGhpcyBpcyBmb3IgdGhl
IG5ldyBkcml2ZXIgKHN1Y2ggYXMgdmZpbykgdG8gYWx3YXlzIHJlbHkgb24gdGhlIG5ldw0KPiA+
IGNhcGFiaWxpdGllcy4NCj4gPiBiLiBMZWdhY3kgUENJIHJlZ2lvbnMgaXMgY2xvc2UgdG8gaXRz
IGZ1bGwgY2FwYWNpdHkuDQo+ID4NCj4gPiBGZXcgb3B0aW9uIHF1ZXN0aW9uczoNCj4gPiAxLiBT
aG91bGQgdGhlIHEgbm90aWZpY2F0aW9uIHF1ZXJ5IGNvbW1hbmQgYmUgcGVyIFZGIG9yIHNob3Vs
ZCBiZSBvbmUNCj4gPiBmb3IgYWxsIGdyb3VwIG1lbWJlcnMgKFZGKT8NCg0K

