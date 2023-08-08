Return-Path: <virtio-dev-return-13497-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A793EC001DB
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:38:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2669F78DB3
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:38:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12BA89865A8
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:38:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 055B6983EB3; Tue,  8 Aug 2023 04:38:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4381986460;
	Tue,  8 Aug 2023 04:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZeRRbOcO1FckCO3y6bpsC88DCr3cpSu2SnvLE1GQT5dwQieb6IWNVRysJWnCkqUzmHtfapeU8Rqxf8BE84pbGKtaW4OXi/FLpEiULIzO+sGustRLddmW8PhBScBfmt+WlkSaC5EfhvltfmuCPkdUf198JGdSpDh8h4bHHciFBUoXmjqCtRzqsk438q8fbR6TxZtz2XokdVPIq0I9mnOqS4/Pkh/j4uhLWf4hrhjFmJZfLdpmT29kXCimU7IbzXlAO4p3bfmX/JtXoF7UjBbqvHgxDmr7/Cg6J4vts1j7AnVyaw8biNLzFMPB9KZBjxuR1gqiw08mpl/9Bf40qbRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5KOZxpEegX6i9uc0rsa764l3UXJg8rNNP4iAybq59Q=;
 b=kBtG2S8BWRo+dhd0VWxGYFakbEmK7ByfaxIi073HdTTsRf66u740EPp6NOCYxcmlIAcv7tGmisZsH8LoepxDe8c2ExDgYwI4vsZiff1BS4IQVD1l/cpg8Q/lwtmi4e5aWYYqgkvGS5QeKIIQeuy9PUMHj5TdoWXZMHA2grN/wJGH2ktBztlVGkIh391VbC+teyFmeD4Q8ajZPnDqyj4LZk9WGqbdqxFXPu2D5BDNCOQpJlLxZhq6gI598OlUsm8iDOKH9C/hwFfUya38bQPYntIVXRnlgL5+IHbmy2am8gMUXD7z4bN7dW1f3ErnkzH8+LomUAAeIlISrAXYhll/dA==
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
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAESeeAgAFTlICAAAUXAIAACRuAgAABk3CAAAoJAIAABc7ggAAGKgCAAABhoA==
Date: Tue, 8 Aug 2023 04:37:56 +0000
Message-ID:
 <PH0PR12MB54810FEA361DFB7C759F2AADDC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481C7090E20AF17A9B2C437DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvRJ3wn_oeue9nDGL-itq=zY=m3_GgsoC_WSU+PYO_s0w@mail.gmail.com>
In-Reply-To:
 <CACGkMEvRJ3wn_oeue9nDGL-itq=zY=m3_GgsoC_WSU+PYO_s0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB9126:EE_
x-ms-office365-filtering-correlation-id: 8096eadc-7867-49f9-80f0-08db97c93cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Frf/zMI+SG/Xjszx0pNN8f9ol1C8AhDKdtBMjL7JB8erUTMUf2Ykk4kwQ0kFP3JavkeMkIPQHmT4/mZsrlim4t6ZQfcGVuRTCpIGKPIgxb71fFVnoKcaRNLDatmml+xgv9VD58THDxhtz33TvRE0Fa6GP1Fs8juoP4vJN6iOPe6Nn52PdFqCS83mjygZEk8tt5wDP8wUTb30yINW2O4PL0SH7Zbz0Ew918gwjeE1PSzUMxiKIgQOkWRNHzrrAypaszmhdfneojqR2G473/kPQ8znJJGcbF349zKzkXz3Bo5KV+hg1OzJZ8LkQaleP1PzCjHHOJB5pmhJpXOFGW88hUNreTVRzOlyn1KHxOXSe0X9wDUGBawjeKbtfL+MWMMmFhNVfKxe/HKoqNONFTH72XcLgyza7S76F7nFp9w6hjYTBHGnNgCjtYjUlVrisSFiqhNU1LqbngWJ63kF1+lXid2xtqm8xCYNE0BODnOz1eUTUIzrSbkcfJddcY1LS4vl8tF1o2Llr02b69PBBFjs9cUK2wcic6H1BVnxLsgmmzbq9ogyesM5I25+QoI4Q3WlRZglyvKWoH3z1WZqnkuYRC/Ye7+wF2cWXpdadL8257UlVijnBJunwzx+lwXFKoLpv5VDUSPUpnELaJ4iPBa2za2W/efxksxjgYpqJoBtCMI+h8LSqlQwLn0TwryRpeo+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(90011799007)(1800799003)(186006)(90021799007)(83380400001)(2906002)(5660300002)(71200400001)(38070700005)(54906003)(7696005)(64756008)(66446008)(66476007)(122000001)(6916009)(76116006)(66946007)(66556008)(33656002)(9686003)(4326008)(55016003)(316002)(38100700002)(41300700001)(86362001)(8936002)(8676002)(26005)(6506007)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MG9hQXJmY210aUZldjRHK0E3WWJhT2FXK21KMGRISEZWVWIwUXRxY1BEVkYv?=
 =?utf-8?B?S2dpOW1OZjV2WVRBMUNYeXN3alZ5ZzQ2Rm9wRGZTa1crMkFEQis0aU10cHFq?=
 =?utf-8?B?SmpCbVN4Vnh5bEZmR1hxdnhrblV5bkZIWFl2bEsxdVE1dmFqdEpKRGcwM0dU?=
 =?utf-8?B?RVN0dW9ENitVdXpNaW5jdmtsMVZHZ2lHNUNlZG9LWENUQjM1aHpFTitDeDE3?=
 =?utf-8?B?Q2I5NGNSS3M3TXlTRUFVL1dEVGlmUWpBQ0JXWDJTRzVyemFWU2lXZ1g5bStz?=
 =?utf-8?B?UjNHNlRzVXlmWEl0b08wRXVXckp0TDhTb3Z1MDNXbWhUL1JGRW9JOVM5TzlN?=
 =?utf-8?B?bjhTdnhWV2czRThac2RKQU4vdmxzWklBV1dabXhNczdjS2hvU2J1eU4vL3Z3?=
 =?utf-8?B?VFdHQmNkaVZQOUFaWTJ1MGVhS2sremdTR25NNWh1RHZCZU01UjFPdVBKcWhU?=
 =?utf-8?B?bytPaEtIeFUzdk5SYi9KckVOanM4b3hncGI5elRiR0N3STEvcGVDNTJuMEE1?=
 =?utf-8?B?ZGl5c2RtdlpWSHlBOUF2YmhKRnlubEt6WDhUY2RYcUQrenZlSE1uWnpLTjI1?=
 =?utf-8?B?SHJocFFWMVZpWHpwb01lbTJUVkFSSkxYbU1pQWJKbUpLdzBqK0RjbzJmMk0z?=
 =?utf-8?B?UmNtZXlTcTFiU3E5VGY3WkFQczd2QmZqQ0ZuclJUTngrbXRVTHBvQnVhYU9S?=
 =?utf-8?B?T0JtSWkzblZrY1oyTXBzcXR5SVRCMFFXSVE0Q3JJREZQR0g4SkUyUGFIS1Va?=
 =?utf-8?B?THNpbmI2NkNQRjdFaG9EVi9DOFJHZmRTSjRhRFlhandkMm5jaS9LV3UyRnZL?=
 =?utf-8?B?alFqZWI5Wmg5QVRqaWJtMWFOTnRkQ24wVFNlTWcwWVdqRXI3NU8rR296OFlx?=
 =?utf-8?B?Vnp3TWo0dzJDeUx2dzFrYjN3M015TDVkOUZsTTNIQlJtdTl4aUx1aGV5VjB5?=
 =?utf-8?B?V1RYQ0RNUElOYTVGVHh4YWhnMUR2MnRCL2t4YUVJcDRlM1dLVTZ1NkYxczNj?=
 =?utf-8?B?akQwbTN2Ri9PMk4wNEJBM1RCOE5mZE5icnV5cVM2UnpoT1V6dUY4VDROY1Iz?=
 =?utf-8?B?dHpkUy9JUTUwRzV5QzQrai9HTGZEZVBMdzhvczd3aEhuWWlQUkcvMnE0NjV6?=
 =?utf-8?B?dWNZTjR5Tm1aOXpnOThsYU56eWlYTWcwZnlQbVZLK1dWMXBiNTBoV1ZpV29H?=
 =?utf-8?B?cHkycitFdUNoakladHQ4MkNTckxtYllyRlZLKytmQ1hWbWdEb0E0RGJ0QjMy?=
 =?utf-8?B?Q09TRHhNQmRCVFNtU0lSTitOY0hYSjdNN09oWXFOaXZra3lZVzdZaEJUWHU3?=
 =?utf-8?B?cXFXTHFzdlJLZzVkMEIvNmVwNGNtMG45SWdZcFp5WURzUjBqZWZQdVdQR2x6?=
 =?utf-8?B?eXJuVXJROFI2ZDREd3k5anQxK211OUdaZFYxWUFsOFlOWDNYN25ETi9FS004?=
 =?utf-8?B?T3I2NXBmeFFXcXZpbzdUZ29SRyttaGZHT24zb1ROWWh0M0ZUdzdIVm55SlM2?=
 =?utf-8?B?NGpjbUNYMG55cTRiSTRsQk1tUzk4clc1VmdCU1lZa1RYWWxwZFhxM25LYXIz?=
 =?utf-8?B?dHo5TDk3bHlqNlNtKzlZa2VNVm04QjhHellwTjJWRGhsQVlVL1lpZnpjZ25s?=
 =?utf-8?B?UTdBalJTWXhPYlhKbFd1ZlFvYWlwc2U3TWVrQ3FIdno1Q1lhalI4QXUvN1Rv?=
 =?utf-8?B?eUVxYkduQlhGYW00S25zYWlkWkF1eVFqVUllMkZidWRwOVZSZWVJTFAzUWZ6?=
 =?utf-8?B?UHhXYjR1WEowMlBmMzRmalFRckV1NktFc0ZNZ0dYRGhHbmF3cGFmTm5leVBX?=
 =?utf-8?B?OG9sTlgzZGJOY1liYjVXUXBZNUVqcDFHNTNpYWhWMlhjdy80Q1NTK0Q5UGlR?=
 =?utf-8?B?S21KY25CZEp4cXZTUGlWOEtCR0huMzArRUdGTGtUWlYvd3hZTXNXUWdHdzA1?=
 =?utf-8?B?TzJBK0hRZkpVQmdZVWVXWUN5MTFJcmFQNGpMaDlISzdkSVZlVHdLS0RjZjAx?=
 =?utf-8?B?V3MwWmlpdjlVQ2kzNmJBVXZIRnNLYldCVndZWlJlQmZvTmJ6N3RMVXBUbGQ4?=
 =?utf-8?B?WHh2R3pQcDYvYnRVcEZOUkpDdlk1a3h1T1Rqc1VsalFqNWNPb0srK0psbDFL?=
 =?utf-8?Q?R/2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8096eadc-7867-49f9-80f0-08db97c93cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 04:37:56.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exPiE36RXRcObRlOQhf3k1t/wBZBzCQZye62rCMaQjX0gXYmTJJWPqcvTPyatkFi9Sx+5pdENc8txFgzjd5zBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
Subject: [virtio-dev] RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCA4LCAyMDIzIDEwOjAzIEFNDQoNCj4gPiBUaGlzIG9wdGlvbiBiZWNhdXNlIGl0
IGlzIGluIHVzZSBieSB2ZXJ5IGJpZyBhbmQgbWF0dXJlIGVjbyBzeXN0ZW0gb2YgbXVsdGlwbGUN
Cj4gc3cgc3RhY2tzLCBrZXJuZWwgc3Vic3lzdGVtLCBkcml2ZXJzLCBhbmQgbmljcyBmb3Igc2V2
ZXJhbCB5ZWFycyBub3cuDQo+ID4NCj4gPiA+IEEgZHJhd2JhY2sgb2YgdXNpbmcgc3dpdGNoIGlz
IHRoYXQgaXQgaW50cm9kdWNlcyBkZXBlbmRlbmNpZXMuDQo+ID4gPg0KPiA+IEZlYXR1cmUgaXMg
bm90IGEgZGVwZW5kZW5jeS4gOikNCj4gDQo+IFdlbGwsIEkgbWVhbnQgeW91IG5lZWQgYSBzd2l0
Y2ggaW4gb3JkZXIgdG8gbGV0IHRoZSBJUCBmaWx0ZXIgd29yayB0aGVuLg0KPg0KT2suDQogDQo+
ID4NCj4gPiA+ID4gQSB2aXJ0aW8gc3dpdGNoIG9iamVjdCBjYW4gYmUgcGFydCBvZiBhIGV4aXN0
aW5nIHZpcnRpbyBkZXZpY2Ugb3INCj4gPiA+ID4gYSBuZXcgdmlydGlvDQo+ID4gPiBkZXZpY2Ug
dHlwZSBpbiBpdHNlbGYuDQo+ID4gPg0KPiA+ID4gVGhhdCdzIGZpbmUuDQo+ID4gPg0KPiA+ID4g
Pg0KPiA+ID4gPiBYdWFuLA0KPiA+ID4gPiBBcyB3ZSBkaXNjdXNzZWQsIHNpbmNlIHRoZSBvd25l
ciBkZXZpY2UgcGFja2V0cyBhbHNvIG5lZWRzIHRvIGJlDQo+ID4gPiA+IGZpbHRlcmVkLCBwb3Rl
bnRpYWxseSBvdXRzaWRlIG9mIHRoZSBvd25lciBkZXZpY2UgaXRzZWxmLA0KPiA+ID4NCj4gPiA+
IFRoaXMgc2VlbXMgdGhlIGFkbWluIHJlcXVlc3Qgb3V0IG9mIHRoZSBzY29wZSBvZiB2aXJ0aW8u
DQo+ID4gPg0KPiA+IE5vdCByZWFsbHksIGl0IGNvdWxkIGJlIHZpcnRvIHN3aXRjaCBkZXZpY2Ug
dGhhdCBtYW5hZ2UgUEYgYWxzby4NCj4gPiBBdCB0aGF0IHBvaW50LCB0aGVyZSBtYXkgYmUgdHdv
IGZ1bmN0aW9ucywgUEYgYW5kIHN3aXRjaGluZyBQRiwgc3dpdGNoaW5nIFBGDQo+IGZpbHRlcnMg
dGhlIHRyYWZmaWMgb2YgdGhlIFBGLg0KPiANCj4gVGhhdCdzIGZpbmUuIEJ1dCBzdWNoIGZpbHRl
cmluZyBuZWVkcyB0byBiZSBkb25lIGluIGEgc3dpdGNoIHNwZWNpZmljIHdheSBub3QgdmlhDQo+
IHRoZSBhZG1pbiBjb21tYW5kL3ZpcnRxdWV1ZS4NCg0KQSBzd2l0Y2ggb2JqZWN0IG5lZWRzIGEg
Z2VuZXJpYyBmbG93IGZpbHRlciB2cShzKSB0byBtZWV0IHRoZSBoaWdoIHJhdGUgbmVlZGVkLg0K
U2V2ZXJhbCBvZiB1cyBoYXZlIHdvcmtlZCB0aHJvdWdoIHRoZSBmbG93IGZpbHRlciB2cSBmb3Ig
ZmV3IHNldmVyYWwgd2Vla3Mgb24gYmktd2Vla2x5IGJhc2lzIGFuZCBvdmVyIHB1YmxpYyBtYWls
aW5nIGxpc3RzLg0KDQpXZSBjYW4gZGlmZmVyIHRoZSBkZXNpZ24gZGlzY3Vzc2lvbiBvbmNlIHdl
IGhhdmUgY2xhcml0eSBvbiByZXF1aXJlbWVudHMuIDopDQo=

