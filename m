Return-Path: <virtio-dev-return-12689-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1874DC77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:26:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5610E16E5C6
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:26:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5155B9865C1
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:26:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 475D8986549; Mon, 15 May 2023 15:26:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 348B298650E;
	Mon, 15 May 2023 15:26:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heuSU7CxXqVKhKiEEq2nVDb3edWfFCzc/dXtG0yx2cJY2Z4FhckV9oU6uOVDfB6YkRh3mCROnKv7oXBVY5DDQ3aBxrgXg6B9AxL2PaWWjLX5F6/hb1uYxwshdeFljOf2VPaIgaz5bHhri5r8H0AWp5Jty+Vrtys+l+HO1JJx1E66uGWWpEeWhjl4jQxubJPHc1nwnOv9s95GEtjltUNG5pN3cE1sRHZ/HXCHP9X378lwLODYVGE1KW1tDFWFkZlUzPIY7B5lSXcq3FaMyrssdnNhyHac7CQpxdoi1x/UcmV9WxG6/KeJuPeSxN+8PZWUCGEIDIFheDH8uP3fbdyW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmKJkMFgQ73beGqZyne7R+K5Hg1U+orzT08fNijP85o=;
 b=Ke3FP7j4Q0+a+RceO2vigIoj2WaywKcw43267knfRHrfKDwI9IzHS9tCedH0Z4c8yohwUZYU0pLmCwE7j8TvJpRsrcwENA1GiwTqW+2fxkVHe3YC4r4d0EU811nX0PJuZFNFAQk3vqJ1QEt/GQA9s+Hd6J2x8Iwu1TmVadNjc/Gp9veW3yFB6FVC374PH/LS2TxVp8zbvMBEC+EQYun/GXQ5F2UPrcLMNZrB8oVPpX3jFxSQt63ULa3HNqSmvBUMb4TIEJXAmhGe0D6c6ZgBaJr+CDVETpXEV2J3TeUrct56gPlq/Otlxk6DHJ31rgV4PpvkZPYYEs09oCkHSlzzWg==
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
Thread-Topic: [virtio-comment] RE: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIAA9w4AgACx3QCAAADx0IABk3UAgADMjwCAAP8YgIAAZ+fQgAW+igCAAKt/wA==
Date: Mon, 15 May 2023 15:26:44 +0000
Message-ID:
 <PH0PR12MB54813E7270B9ECD015989E3FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
 <d79a83db-46eb-7f7e-da8e-f39b58b1bc0f@nvidia.com>
 <CACGkMEsR1bJGWjn7TTrvMZV3=fCqggWXjXRXK179YiTUxVTc6g@mail.gmail.com>
 <PH0PR12MB54819321E95065EBFF7D714CDC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eec75132-fe69-5b99-fd5d-d227257b92f2@redhat.com>
In-Reply-To: <eec75132-fe69-5b99-fd5d-d227257b92f2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5956:EE_
x-ms-office365-filtering-correlation-id: cdc7f969-1e50-4196-bc82-08db5558ca8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 br2/uxvLW6h3WsA5IPv87L4LbVZXO43RXChn0N/RaRx87OKiYw1get7H3QB1Oua5trYT3dA9BKtDTWPvACDCmtRZo04oZCFyL9iBBIW/CkHpsogyfhBOeRDvoRDXCenKHfbY6+6ncscwX4iyzqUxkehN9e+RS1+Ve7ZnH7Mal+OKDJbWjKed7xTgntX3XxNK/v76vPmv+GeZ8RlZeTlVncUfrlTAro4BwyiZtf3RZ1uH53Icu89oC5v/vDaXm/JAeRadTxZe3xAiHVeWeYobzGWeBe1gTxeSdJqzOmjOTzpO07M0MsCZot95w784Bc66R3GRMnxHunpQ1cpR9epuTTWkjBRTcVKDcpsiNpV8YF3nblf9tESn3hF3I5WXPUJ1HIopGjyLAZP/aWthfVZbbd2v0OV1I+7TPP6Uxcsz938twEbtC9mRuvKwUI61voy7qn5W+/pScYhs0LVuBOvYAFiECWCW1ZVTL/Tzw+iG9Z4sSwMLNdqjTVLGCMJyr8/rdGDJtXmg+TmGrLeORMeWEl/UEWdfEjLzlYzsJUZn+qt5HOrHsNr8BSm6uGAiRRQyNfBj2aNp4ho/duecY19HK8KBo0P3OqWgSra4NRSLEWaqEiVtR8wTyipai0CBIuyi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(55016003)(4326008)(2906002)(107886003)(83380400001)(76116006)(66476007)(66446008)(64756008)(66946007)(66556008)(478600001)(7696005)(54906003)(8936002)(8676002)(9686003)(52536014)(186003)(6506007)(5660300002)(41300700001)(6916009)(71200400001)(316002)(38070700005)(38100700002)(86362001)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGs0QTE2T3pIUWQ3QlYremVla2VrMnI4NjdxRVFrZE1UQkVoTWpCZGl4NG5n?=
 =?utf-8?B?aXBsa0NtVFF1akhhZnR4VjFUVTZ2QmFZOVNvYUZYWlA4Rkpkek5EWlZtMnU1?=
 =?utf-8?B?U2I0aWNxU2YxbGUwYTRzWUdGNGlaejJzVmorZC83a3FBOTFjRkxMcFArbGk2?=
 =?utf-8?B?TE9QS2FKS1NQSEJxUzU5UUlPbFAyTkh5S2c5M283V3dXNWYvTVAxbVFwbFJu?=
 =?utf-8?B?Y1lmdksxcEcwSE02TW5pUDN1bjVKNjhKa2hLeG5EME83dnFPV2RnblN1WkJq?=
 =?utf-8?B?T0lSd2IzRU9RVW5HVDhTY092N2VyTHhrbTljTlNUVEtiSjFDbEdRQ0Z4TmIr?=
 =?utf-8?B?WWNISXF5TnJSSVAzRnc4NkcrRjhLY1BBYmFQVkdKRnNwck5MK2VtT3Jnb0Nr?=
 =?utf-8?B?WFF4VXJ1ZjQ2MUxTYTVJeFZBbFVBTHRQTFpWV2pKMHNlSUNHaU80amtqc0xJ?=
 =?utf-8?B?T29oWHN3OGpNYkxTZHl0MVJYTXkrS0dYWEdFYW4vUWFpclh3QVVTZitmSUp6?=
 =?utf-8?B?UFFuT0doRWhFSGo3dHRkU3pwTGVrcktQWFlPV2dNdm5ERFI4VnFLWHQzT3ds?=
 =?utf-8?B?TTYvOVhCS3N2OWgrU09aV2c1NVBlTVZaa25wMnZRdTRwM2hzWC90SkhhL3kz?=
 =?utf-8?B?TE1ob2VGS29lV0xVc0hCV0Q2YUJyY2VEWmY5TlJlYStER3B1SzdxK0Y1aWRw?=
 =?utf-8?B?QXlQZzhSQTg3ekJMditldGlFU2N6SWFicXJlK2dGbVpZWno0V2JxcGV6eGhH?=
 =?utf-8?B?RGxVVWUwTSsvbFBQcVgrN3pIR3U0dVAyU2hrVDk0U2xEQzB5bUtXSk9qZ2tZ?=
 =?utf-8?B?TVRnRHJ3RUd6T083N3dRK2x2aWd1NThDTXlGU1h0cS9JdHI1VEZsNVFYdzdB?=
 =?utf-8?B?d1phUkpoaHlBRGVrZ25IUW5OTE1Rb2VScWRidlErbVYyV2NLUlBpbzFsUHFL?=
 =?utf-8?B?Rlp6bndYcVFTNVZQbUVYTXFFc2V0Wmp4eG9ncFdoZnFmOUhwdDlpUFNoWTFs?=
 =?utf-8?B?bXVKQXlvSm5ocmJMa3F6ZFd3dE9Cb1NaaEREQmlOa1ZQMytoZmx0eUxwT1Uy?=
 =?utf-8?B?QlFGNFhPWUdLWGhBOUY3dldUc21UeThnOW1LK0VXN0hoSHZqejZoRHl1bXRw?=
 =?utf-8?B?Y0E0Yi8wT0NSTzFndUNSWE9NbVdBd1dqZ0dGL1FUdDREU3RRNy9ZVDFIa0Jw?=
 =?utf-8?B?ZVZWb2RPeXYrbDVtM3QrR2E5a3RVUkpmZFJMU3dqM1VNVkEzeitmZEgxd240?=
 =?utf-8?B?eTZxNS9PMkxwZDNVczFUdXc2dDBpNnpWRk1qM2hNVlk5SUhrdmRzL1A2Q0s5?=
 =?utf-8?B?U3o2Q1hGb0kvS0tTVnJzL1prVnpzdytkREZLNkthWTBiOWpqWWVUT04wZCt0?=
 =?utf-8?B?SHRsWmNWZm1ESm8wQ3NHTExJbnRxSGR3R1B1Uk1ENko3cDJkSkttMGtJWEpz?=
 =?utf-8?B?c09ZTXFHRnQvRE5QRFNwa3pPNm1mWmFONWloVzBvbk90VWZGemVsL0hRMmJo?=
 =?utf-8?B?a0RnVTRvd05YZktIdE5QcWYwbTB2RERKYW1JMG1wNEN6Y2dKOWt4cEd2Ui9X?=
 =?utf-8?B?V3pNQ2pQKzdjRUxzVityTzFSUG5CejRmRWM1emhiV2pIbS95YnhidTVVclZY?=
 =?utf-8?B?VDh5ZjBGSzZjbGFVV29sUWtaVjFzZXJIUHVDeUpCRFBpR0tjbTF1a2JRenNO?=
 =?utf-8?B?NUN3NUFuK2dxbVFZdXRtV3VpNkh2U2FhUWdlMENvZkxyNHZGMzlyWnFNY3dh?=
 =?utf-8?B?RnF0Skx3S0VEYkpPeS9XcHh0RWZCV2tBTEJyeWNCZkZudDFadXBHRTUwMlBq?=
 =?utf-8?B?TXMwbDJBa0RxbmZSYmJxdm13eWNmcUF2cGlPUGxxaXVzTmpGdUdTaDMvTDRZ?=
 =?utf-8?B?cXA2dmVDNlkwM3JEWUJBMEtlU1hXaU4zeUErbkh2OFp0L213Mk1DYVVjbDln?=
 =?utf-8?B?ZEtmTU5jVkxNcjNkV1dBbkxRVTBYSWxUZ0Q2cWVBRjVLZDZuRS9IeDE4K1pz?=
 =?utf-8?B?cXE3RDJLcWQvU24yTnlsb0czS3dwdFZCWUxFWGVQNmJCeWZ2Yy9PNzhlV1M0?=
 =?utf-8?B?bnI0TWYwRGJDN0hCdW9qTFZ1VUFaMDM1bU9jTG53d1FQZTBkRmJlUVpoaklM?=
 =?utf-8?B?ZkJucU8wL3FmeVZ6cXNvbmhyb3crOFRiVE4yczd3dzZBblYvME0xNXdFS25h?=
 =?utf-8?Q?AXeRxNdPgOX3lp2ktGU8gu8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc7f969-1e50-4196-bc82-08db5558ca8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:26:44.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4WlU6q8erLTn56/tVJG3rf0ynlEdkfQpInhFqPfSRJ9pBTp1Htub/LDiuN/5moRPf+gTWgxtcS16IdUiwa5Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgTWF5IDE1LCAyMDIzIDE6MTIgQU0NCj4gDQo+IOWcqCAyMDIzLzUvMTEgMjI6MzEsIFBhcmF2
IFBhbmRpdCDlhpnpgZM6DQo+ID4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTEsIDIwMjMgMzoxNyBBTQ0KPiA+Pj4gYSBj
b25maWdxL2NtZHEgZGlzY3Vzc2lvbiBpcyBmb3IgbmV3IGZlYXR1cmVzIGZvciBQRiwgVkYsIGFu
ZA0KPiA+Pj4gU0YvU0lPViBkZXZpY2VzIHRvIHdvcmsgaW4gX25vbl8gYmFja3dhcmQgY29tcGF0
aWJsZSB3YXksIGJlY2F1c2UNCj4gPj4+IGZvciBuZXcgZmVhdHVyZXMgdGhlcmUgaXMgbm8gc3Vj
aCB0aGluZyBhcyBiYWNrd2FyZCBjb21wYXRpYmlsaXR5DQo+ID4+PiBiZXR3ZWVuIGd1ZXN0IGRy
aXZlciBhbmQgdGhlIGRldmljZS4NCj4gPj4gT2ssIHNvIHdoYXQgY29tbWFuZCBkaWQgY29uZmln
cS9jbWRxIGhhdmU/DQo+ID4+IEkgdGhvdWdodCBpdCB3YXMgc2ltaWxhciB0byB0cmFuc3BvcnQg
dmlydHF1ZXVlLCBidXQgaXQgbG9va3MgbW9yZSBsaWtlIGENCj4gY29udHJvbCB2aXJ0cXVldWUg
aGVyZS4NCj4gPiBZZXMsIGl0IGlzIG1vcmUgbGlrZSBhIGN2cSB0byBkbyBkZXZpY2UgYXR0cmli
dXRlcyBkaXNjb3ZlcnkgYW5kIGNvbmZpZ3VyYXRpb24uDQo+ID4gSnVzdCB0aGF0IGl0cyBnZW5l
cmljIGVub3VnaC4NCj4gPiBGb3IgZXhhbXBsZQ0KPiA+IGNyZWF0aW5nIFZRIHRoYXQgc3BhbnMg
bXVsdGlwbGUgcGh5c2ljYWwgYWRkcmVzc2VzLg0KPiA+IERpc2NvdmVyeSBhbmQgZW5hYmxpbmcg
bmV3IGRldmljZSBhdHRyaWJ1dGVzIHdoaWNoIGFyZSByYXJlbHkgYWNjZXNzZWQgb3INCj4gYWNj
ZXNzZWQgZHVyaW5nIGRldmljZSBpbml0L2NsZWFudXAgdGltZS4NCj4gPg0KPiA+IFRoZSBmdW5k
YW1lbnRhbCBkaWZmZXJlbmNlIGJldHdlZW4gY2ZndnEgdG8gdHZxIGlzOg0KPiA+IENmZ3ZxIGlz
IGJldHdlZW4gdGhlIG1lbWJlciB2aXJ0aW8gZGV2aWNlIGFuZCBpdHMgZHJpdmVyLg0KPiA+IFR2
cT1hcSBpcyBvbiBncm91cCBvd25lciBvZiB0aGUgdmlydGlvIGRldmljZS4NCj4gPg0KPiA+Pj4+
PiBDb21wYXRpYmlsaXR5IGlzIGNvbWluZyBhdCBhIGNvc3Qgd2hpY2ggaXMgbm90IHNjYWxpbmcu
DQo+ID4+Pj4+IElmIHlvdSBhdHRlbXB0IHRvIHNjYWxlLCBpdCBicmVha3MgdGhlIGZ1dHVyZSBw
YXRoIGZvcndhcmQgdG8gZ28NCj4gPj4+Pj4gd2l0aG91dA0KPiA+PiBtZWRpYXRpb24uDQo+ID4+
Pj4+Pj4gU28gZXZlIGdyb3dpbmcgdGhlc2UgZmllbGRzIGFuZCBvcHRpb25hbGx5IHBsYWNlbWVu
dCBvbiBjb25maWdxDQo+ID4+Pj4+Pj4gZG9lc24ndCByZWFsbHkgaGVscCBhbmQgZGV2aWNlIGJ1
aWxkZXIgdG8gYnVpbGQgaXQgZWZmaWNpZW50bHkNCj4gPj4+Pj4+PiAod2l0aG91dCBtdWNoIHBy
ZWRpY3RhYmlsaXR5KS4NCj4gPj4+Pj4+IENvbmZpZyBxdWV1ZSBpcyBub3QgdGhlIG9ubHkgY2hv
aWNlLCB3ZSBoYXZlIGEgbG90IG9mIG90aGVyDQo+ID4+Pj4+PiBjaG9pY2VzIChmb3IgZXhhbXBs
ZSBQQVNJRCBtYXkgaGVscCB0byByZWR1Y2UgdGhlIG9uLWNoaXAgcmVzb3VyY2VzKS4NCj4gPj4+
Pj4+DQo+ID4+Pj4+IFBBU0lEIGlzIGZvciBwcm9jZXNzIGlzb2xhdGlvbiBzZWN1cml0eSBjb25z
dHJ1Y3QsIGl0IGlzIG5vdCBmb3INCj4gdHJhbnNwb3J0YXRpb24uDQo+ID4+Pj4gSSBtZWFudCB3
aXRoIFBBU0lEIHlvdSBkb24ndCBldmVuIG5lZWQgYSBCQVIuDQo+ID4+Pj4NCj4gPj4+IE5vdCBz
dXJlIEkgZnVsbHkgdW5kZXJzdGFuZCwgYnV0IG15IGd1ZXNzIGlzLCB0aGlzIGlzIGNvbWluZyBm
cm9tDQo+ID4+PiBtZWRpYXRpb24gdGhvdWdodCBwcm9jZXNzLg0KPiA+PiBOb3QgYWN0dWFsbHku
IEkgbWVhbnQsIGZvciBleGFtcGxlIHdpdGhvdXQgUEFTSUQsIGZvciBtb2Rlcm4gZGV2aWNlcywN
Cj4gPj4gdGhlIGNvbW1vbiBjZmcgc3RydWN0dXJlIG11c3QgYmUgcGxhY2VkIG9uIGEgQkFSIHRo
cm91Z2ggTU1JTy4NCj4gPj4NCj4gPj4gQnV0IHdpdGggdGhlIGhlbHAgb2YgUEFTSUQsIGl0IGNv
dWxkIHN0YXkgaW4gdGhlIG1lbW9yeSBhbmQgdGhlDQo+ID4+IGRldmljZSBjYW4gZmV0Y2ggaXQg
dmlhIERNQS4gVGhlIGhlbHAgdG8gcmVkdWNlIHRoZSByZXNvdXJjZXMgZm9yIHJlZ2lzdGVycy4N
Cj4gPj4NCj4gPiBZZXMsIGl0IGNhbiBzdGF5IGluIG1lbW9yeSBhbmQgZGV2aWNlIGNhbiBmZXRj
aCB2aWEgRE1BIHVzaW5nIGEgVlEgdXNpbmcgaXRzDQo+IG93biBxIGZyb20gZ3Vlc3QgZHJpdmVy
Lg0KPiA+IFdoeSBkb2VzIGl0IG5lZWQgUEFTSUQ/DQo+IA0KPiANCj4gTGV0IG1lIGNsYXJpZnkg
bXkgdW5kZXJzdGFuZGluZy4NCj4gDQo+IElmIHdlIHdhbnQgYSBwZXIgVkYgdmlydHF1ZXVlIHRo
YXQgaXMgdXNlZCBieSB0aGUgaHlwZXJ2aXNvci4gV2UgbmVlZCBQQVNJRC4NCj4gT3RoZXJ3aXNl
IG5vdC4NCg0KWWVzLCB3ZSBhcmUgb24gc2FtZSBwYWdlLCBvbmx5IHdoZW4gc3VjaCBkZXZpY2Ug
aXMgbWVkaWF0ZWQgYnkgaHlwZXJ2aXNvci4NCldpdGhvdXQgbWVkaWF0aW9uIFBBU0lEIGlzIG5v
dCByZXF1aXJlZC4NCg==

