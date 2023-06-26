Return-Path: <virtio-dev-return-13071-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63363EB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 04:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F3AB1EADE
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 04:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A7A1986432
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 04:05:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6CF0A986367; Mon, 26 Jun 2023 04:05:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC1D0986364;
	Mon, 26 Jun 2023 04:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWp+ZKPclOlKpqluIVC/fvNJpPrsg9zdcrr8DqrZCqfe1OCymYpRWI0E2smPCcORC8zUr3Jell5kI1g3CJ9zNLGr0Za6WO4fUIcpUjMoRRjAJpGh5CIHZw0kWzFOeUN8PCZrRpiA8eo9zJXd2P4ap2Mmy/jAh8o+TdpitqsQ02Var1KAl7N5BI3Zob/tijKgsZSmGQRPhlyDut9u9MlS+J5hMOkQvSmnR14ixPScsdcQECtEX3W01xH60Sob1d+k6yHuaRVT4zGZLW/p1Woha0raZtVWew8jVryekAl+FXrzlA3D2WRAdTYMHqG+woXBJEEDHGMelEaShz9AvTlWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEq+x8ijx64l/R8gYRW0p1ZRhQPHGKlB9YXxYSrANG4=;
 b=mg6u+ArP9EpgXnfcmr+sXDXKt8Zr7waNPFaw7+8K2GViLgy7GL4LDeo1zPU2IJBdGh6Oa21JGGAdjZziZkWKxhfULg1vdheVbyppLk8jXDhuRb76Kvl8CmWIpVsytU12wC2W+DVEN9K5p1eKG+Q5TZ/RhZTySWtG/lu5tZMxZHdiBIvaiC+LFbYP8HvU9pk6/EhTOhy0gvzReSxsgUvtlBagJGVt5j0uWhcKtH84Mh/Q/87l9J1JZdGPdK5GeHkNP3WKHCFan1ovGDHgZ19rWBZrNhCJJf2og+0xtw4/aWamQ55Mpr6y5SSJsATUTXc3cdkWeYUWzg69IcXRCUHj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgABWWwCAGoDYAIAAAFhA
Date: Mon, 26 Jun 2023 04:04:24 +0000
Message-ID:
 <PH0PR12MB5481F5505D76E77C2A1C3327DC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <20230609030109-mutt-send-email-mst@kernel.org>
 <CACGkMEseaZAgPdtf9AvwxLarkYXRMC0zCJqnjWQFJ90t0pSZzA@mail.gmail.com>
In-Reply-To:
 <CACGkMEseaZAgPdtf9AvwxLarkYXRMC0zCJqnjWQFJ90t0pSZzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7663:EE_
x-ms-office365-filtering-correlation-id: 5a158c49-26c3-45b0-d1b9-08db75fa6df1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AORRvJ/QEVH71xvbyNkwpcpkn1z2FLc7w/sJYuHcdIBt62mpNNMJEYwk7C3Gm9hyglFT8T9gokKvc6VSICAHa+1TKFqhiMDE/zBfwGepbJYDISGlp9Glc0lYseYIc9XZ392HEyWgwzwWSqlgRCqjIB1sZCeZkZvwb2Bn4CFoUoYUv5hPtVlONorL5l/byrDi2xGJ3ENU8/WoC6vlXJB7r+25u03BSN+EFEKQNBhFVQHtu3MVyD+LgWGQIP1xcJvRQkoLtfuFLckzvxCLGg5lrn8CcQRgk6SZWNxoqB1D2kXztlOvWYAL6BTPBjLOxIkQB50sY+bfygm7mixcKB3RWb1MDl7ZmBLNuubncBZ28PffWPBNuc6stft9yV/mXjr3nXRIjvKMqvcNnmNfNIxyBQ5mblmG7Fv0hhNbNXwQez0P9OarPruSiuUrx5xB2Pz3ykNMDFNtvtNL2COJZSdkXYB9JNJO0FiWjT5PsjX0/H4yGK4HudBOjEahaChK50OU/7yEfTcHRC3oGIjPFjgsq8M0KOA/ejXg94mMyPQH2zHbtUjzG/0YugjO4aUufuylnA/ZHgY/J1SE63ZNEV6dwFCZY0DUJ2ZWArzEB1TGigT1jSEHyESHZP2O45fjmHmw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(107886003)(478600001)(7696005)(71200400001)(110136005)(54906003)(83380400001)(26005)(6506007)(186003)(9686003)(2906002)(5660300002)(52536014)(33656002)(38100700002)(122000001)(76116006)(4326008)(64756008)(66946007)(55016003)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(66446008)(66556008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3ltZ0ZZeFI5bk1zVklHQ0NkZVgvZUkxaU1NUkRqQ3lQazlXLzNuWTZSRWlF?=
 =?utf-8?B?SE5ESEdqK1doSHJyRWdZd3Fic0VubnkrekcyVDVIWHd2Ull2eW8ra3E2TFpN?=
 =?utf-8?B?dWVlZ04zcVk0Q1p0a0I3dnkxeEVtMERJM2lVdmdFMWRQeDhqanNOeUVmT29R?=
 =?utf-8?B?MzN3RTlKNVBHZEx1eTFCTFFHREJGckppSXJ1TjZialB0WTRnaEJzMlJia2pY?=
 =?utf-8?B?bHhqVjVtZlJrQ2k5ZHdNamE0Rjk0VmhJUmtoL085c1RhbnpaYkJDTFUySzNT?=
 =?utf-8?B?K0ZRaXNPdkc5MzN4N0RtRVNRNndsRjhURS8wcnhwVm5wd0VVT3JuUUVFc2Zo?=
 =?utf-8?B?TWFWVnR2THNUSkdUZVV4NVRNdUpUMlZ4cUpHTU1QZkhNNDFzeXBnT3FVS0F5?=
 =?utf-8?B?Ulo1Vi9xc2dnV1ZlaklvT2h2VHAxbysyY0YydUhzMjRZb2N4UW10QUFnRnVj?=
 =?utf-8?B?OEJoZUNHclFBbEZYdE1nR1JNU2tDRUI4b0MyMXBGWHN1S2hCWk1PNWUzVDN6?=
 =?utf-8?B?V24yRGt5Vm1DZjFJdzFRZGxudVRwVEttSWREeVRaenBTd092aGVNTzZVMkFW?=
 =?utf-8?B?MTBNR3lacm00VWpjdXNvNTI2bVdrZW0xVWlLSWRMY1hQdDU1MDBBZk9WVmpP?=
 =?utf-8?B?QjhqRDJqdnA4Ym1nczEreE0yUkx2MVZuQWRCSGZ3VUJLSmRwYVFuVFQxNHVL?=
 =?utf-8?B?dXJzUXN2UWxadzZsMjY2MzZkL0hPL3hQcy9LbU5EVUcrd0I5ZGptU3hhanB0?=
 =?utf-8?B?bzVoOXFHOVdzWll2UDNibnJ1aWd4cU4rVGlOSVBhSmVpcFV2SXVqMlU4SXNv?=
 =?utf-8?B?c0JZdE1HS3F0TWVGWkdRU1RINVR0dnI3b2doWjRaVW90VEhsR3FXUmFCOGlE?=
 =?utf-8?B?U1U1Vk1rMmpaSHpzcTF2SnhTeGYxcE5YT3RoTjRqZzEvdnVGR2xrRGhuNTFn?=
 =?utf-8?B?MWhmdk9ERXI1Nk9rZENHc3JIWmVmaGROVmRZVDJWd1VJUG1iM2RMVFloaTBP?=
 =?utf-8?B?SGNCLzlzL2k3V3J3dzJDKzIwaGloNS9Kd3pPcHZYVUtvaEpvWVpMQW1oN0tu?=
 =?utf-8?B?eWg3aWdQYlFMbi8zVjg4WVMvbUFmWEdCdGcxbWRmTXFlWkZJdWZ6eEVqOEVW?=
 =?utf-8?B?MWo0VWMrRXNHRHlrMUVMSHlJTkQ1YW83U1F4MWovblBzaTJaVnpPVytndjNC?=
 =?utf-8?B?c3ZicEZEWXNwUG9qemFXM0E5REd0cllSbGJXNGtBTWlqQ0ZuVDU3VjhDV25k?=
 =?utf-8?B?dTlWUUNOQ3loTVVXNDI4MHI3V29UMFhnaEU2V0FET3VUZCtVSElCT3NqMGdq?=
 =?utf-8?B?d21nZ3h4Z3JwYjFxTklqakVqTDZTcm1LakVkdWVFUlk5SlBOV0lrZTd4amhD?=
 =?utf-8?B?OHBiVzRHSXlzOE9SdDZoNDgxb2Q1aXBFWXFiQTYrdFNOSWpXS2ZsUFpDSjhi?=
 =?utf-8?B?K0Nzb3pQZHZYbmkrRkVjSGU3SzBBV0hVUDdoSmh1SjVNeUoxaTNLeFpDeDM2?=
 =?utf-8?B?MHZWQXF1V1hKT0JYQjlEVWNVS1dPRk1YQkJlM0licHdPZndIeUhqSkU2YmZt?=
 =?utf-8?B?UnJ5WVpWT09vQ3Blc0tPVHNTbWJvSHc2UXFOcWxpbE1BNlpOcXA3ZlJmZCt2?=
 =?utf-8?B?SXRZRzVoako0ZCtLdXVLUzdMLzZTZlRHcVlScmkyaGk0dDdVOVNBa09FaUEy?=
 =?utf-8?B?Z1l0NG9xaHhqMzhWQ0Y1MEhKT3QxankvM0hVazA0cTVDcGhNQnNjMlZKLzRZ?=
 =?utf-8?B?RzFSbmhJaEc3Ny9DS0pkU0pTVkZjeEVDVGRJc3VQZGJKTEZyMFZ1M0M5eEhM?=
 =?utf-8?B?MUI5YzI1ZnVXc3ZESWFVK1p4UEFLS1NhMCtrUXZnLzdYSlFNRHZ4UDNqY3ND?=
 =?utf-8?B?NEZCVXR1dWVZLzhXTmRsRkc3NlB5U0VYN01IemR2azRmQ2JyVFBDK2IwMlE3?=
 =?utf-8?B?ZHRsV1dRN3VydUE3TlcvQTdlcEdsR0N3WFU5alY2aTZXMHB0QWpVYkg1MkQw?=
 =?utf-8?B?bGM1SE9wdHhqbWJJNzBGY1dGMnpKL3hkMUpVbTI2K2JaN1MxYkovVnA3WW1r?=
 =?utf-8?B?anU2UXIyS2lUcGxvVzRpanFROHRERmlyaGx3dkc0UktvK0FkQ25CZTZPVi9C?=
 =?utf-8?Q?kt78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a158c49-26c3-45b0-d1b9-08db75fa6df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 04:04:24.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pExdeF7liw7ApPT0Ta6xPLRyBrKJ9PNPmqfwyc+kCM67Pq+4LO8J7VNLpCiBNBx+eitVPZr36GHLlcQ+4xFidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

DQoNCj4gRnJvbTogdmlydGlvLWNvbW1lbnRAbGlzdHMub2FzaXMtb3Blbi5vcmcgPHZpcnRpby1j
b21tZW50QGxpc3RzLm9hc2lzLQ0KPiBvcGVuLm9yZz4gT24gQmVoYWxmIE9mIEphc29uIFdhbmcN
Cj4gU2VudDogTW9uZGF5LCBKdW5lIDI2LCAyMDIzIDEyOjAwIEFNDQoNCj4gPiAgIFRoaXMgd2F5
IHdlIGp1c3Qgc2F5ICJtYWtlIGxlZ2FjeSBndWVzdHMgd29yayIgYW5kDQo+ID4gICB0aGlzIGlz
IHRoZSBwcm9ibGVtIG9mIHRoZSBoYXJkd2FyZSB2ZW5kb3Igbm90IG91cnMuDQo+IA0KPiBQcm9i
YWJseSwgYnV0IHdlIG5lZWQgdG8gdHJ5IG91ciBiZXN0IHRvIHNpbXBsaWZ5IHRoZSB2ZW5kb3In
cyBsaWZlLg0KPg0KPiA+DQo+ID4gLSBsaW1pdCB0aGUgaW1wYWN0LiBXZSBkb24ndCBnZXQgdG8g
bWFpbnRhaW4gdGhlIHNldCBvZiBoYWNrcw0KPiA+ICAgbmVlZGVkIGZvciBsZWdhY3kgaW4gdGhl
IGh5cGVydmlzb3INCj4gDQo+IFRoaXMgaXMgb25seSB0cnVlIGlmIHRoZSB2ZW5kb3IgZnVsbHkg
dW5kZXJzdGFuZHMgdGhlIGJlaGF2aW91ciBvZiB0aGUgbGVnYWN5IGFuZA0KPiBpbXBsZW1lbnRz
IGl0IGNvcnJlY3RseSB3aGljaCB3b3VsZCBiZSB2ZXJ5IGhhcmQuIFdlIHdvdWxkIGVuZCB1cCB3
aXRoIHF1aXJrcw0KPiBpbiB0aGUgaHlwZXJ2aXNvciBzb29uIG9yIGxhdGVyLg0KPiANCllvdSBj
YW4gaGVscCB2ZW5kb3IgdW5kZXJzdGFuZCB0aGUgbGVnYWN5IHNvIHRoYXQgaHlwZXJ2aXNvciBk
b27igJl0IGhhdmUgdGhlIHF1aXJrcy4gOikNCg0KPiA+IC0gd2hlbiBzb21lIHdlaXJkIGxlZ2Fj
eQ0KPiA+ICAgc3VwcG9ydCByZXF1aXJlbWVudCBzdXJmYWNlcywgaXQgd2lsbCBiZSB1cCB0byB0
aGUgdmVuZG9yDQo+ID4gICB0byBmaXguIEhXIHZlbmRvcnMgYXJlIGFsc28gbW9yZSBhZ3Jlc3Np
dmUgaW4gZGVwcmVjYXRpbmcNCj4gPiAgIG9sZCBoYXJkd2FyZSAtIHRoZXkgd2lsbCBqdXN0IHN0
b3Agc2hpcHBpbmcgbmV3DQo+ID4gICBoYXJkd2FyZSB3aGVuIHRoZXJlIGFyZSBubyBuZXcgY3Vz
dG9tZXJzIGFuZCB3ZSBjYW4NCj4gPiAgIHN0b3AgYWRkaW5nIG5ldyBoYWNrcy4NCj4gDQo+IEJ1
dCB0aGUgaGFja3Mgd291bGQgYmUgdGhlcmUgZm9yZXZlciBpZiB0aGVyZSdzIHVzZXJzLg0KPiAN
Cj4gPg0KPiA+IC0gdGVzdCBvdXQgYWRtaW4gY29tbWFuZCBpbnRlcmZhY2UuIFRoaXMgdXNlLWNh
c2UgaXMgc21hbGxlcg0KPiA+ICAgdGhhbiBmdWxsIHRyYW5zcG9ydCB2cSBidXQgc2ltaWxhciBl
bm91Z2ggdGhhdA0KPiA+ICAgd2Ugd2lsbCBsZWFybiB2YWx1YWJsZSBsZXNzb25zIGZyb20gaXQu
DQo+IA0KPiBBbm90aGVyIGlzc3VlIGlzIHRoYXQgdGhlIGludGVyZmFjZSBpcyBkZXNpZ25lZCB0
byBiZSBQQ0kgc3BlY2lmaWMgKGF0IGxlYXN0IGZyb20gaXRzDQo+IG5hbWUpIHdoaWNoIG1heSBy
ZXN1bHQgaW4gYSBzdHJhbmdlIG1lZGlhdGlvbiBmb3IgTU1JTyBsZWdhY3kgZ3Vlc3RzLg0KPiAN
Ckl0IGlzIG5vIGRpZmZlcmVudCB0aGFuIEFRIGJlaW5nIG9ubHkgZm9yIHRoZSBQQ0kgdG9kYXku
DQpTbyBmYXIgbm8gdXNlciBvZiBNTUlPIGxlZ2FjeSwgbWF5IGJlIGluIGZ1dHVyZSBpdCBjYW4g
YmUgZXh0ZW5kZWQgaWYgcmVxdWlyZWQuDQoNCldlIGRvbuKAmXQgd2FudCBsZWdhY3kgdG8gYmUg
dGhhdCBncmFuZCBlaXRoZXIuDQoNCkkgYW0gbW92aW5nIG1vc3QgdGhpbmdzIHRvIGdlbmVyaWMg
c2VjdGlvbiAoaW5zdGVhZCBvZiBQQ0kpIGJhc2VkIG9uIE1pY2hhZWwncyBpbnB1dHMuDQoNCg0K
PiA+ICAgRm9yIGV4YW1wbGUsIGl0IGFscmVhZHkgaGVscGVkIHVzIGZpbmQgYW5kIGNvcnJlY3QN
Cj4gPiAgIGEgZGVzaWduIG1pc3Rha2Ugd2hlcmUgYWRtaW4gY29tbWFuZHMgaGFkIDggYnl0ZSBh
bGlnbmVkIGxlbmd0aC4NCj4gPiAgIEFzIGFub3RoZXIgZXhhbXBsZSwgSSBhbSB3b3JraW5nIG9u
IGFiaWxpdHkgdG8gcmVwb3J0IGV2ZW50cyB0byBhZG1pbg0KPiBjb21tYW5kDQo+ID4gICBpbmZy
YXN0cnVjdHVyZSB3aGljaCBpcyBjdXJyZW50bHkgbWlzc2luZy4NCj4gDQo+IElmIHdlIHdhbnQg
YSBNTUlPIGludGVyZmFjZSBmb3IgYWRtaW4gY29tbWFuZHMsIGl0IHJlcXVpcmVzIG1vcmUgZXh0
ZW5zaW9ucw0KPiBmb3Igc3VjaCBraW5kIG9mIG5vdGlmaWNhdGlvbi4NCj4gDQo+ID4gICBXaXRo
IHRoYXQgaW4gcGxhY2Ugd2Ugd2lsbCBiZSBhYmxlIHRvIGFkZCBJTlQjeCBlbXVsYXRpb24gZm9y
IHZlcnkgb2xkDQo+ID4gICBndWVzdHMuDQo+ID4NCj4gPg0KPiA+DQo+ID4gSW4gc2hvcnQsIHRo
aXMgaW50ZXJmYWNlIGFzIHlvdSBjb3JyZWN0bHkgcG9pbnQgb3V0IGlzIG5vdCB0aGUgbm9ybWFs
DQo+ID4gd2F5IHdlIGJ1aWxkIGludGVyZmFjZXMgc2luY2UgaXQgaXMgbm90IG1vZHVsYXIgYW5k
IGxlc3MgZmxleGlibGUgdGhhbg0KPiA+IGluZGl2aWR1YWwgZmVhdHVyZSBiaXRzLiAgSG93ZXZl
ciwgZm9yIHRoZSBsZWdhY3kgaW50ZXJmYWNlIHRoaXMgbWlnaHQNCj4gPiBiZSBhIGdvb2QgdGhp
bmcuDQo+IA0KPiBPaywgSSB0aGluayBJIHdvdWxkIG5vdCBvYmplY3QgdG8gdGhpcyBwcm9wb3Nh
bCwgYnV0IHdlIHNob3VsZCBub3QgZXhjbHVkZSB0aGUNCj4gcG9zc2liaWxpdHkgb2YgaGF2aW5n
IHRoaW5ncyBsaWtlIExFR0FDWV9IRUFERVIgaW4gdGhlIGZ1dHVyZS4NCg0KVGhhbmtzLg0K

