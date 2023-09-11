Return-Path: <virtio-dev-return-13667-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8EFEE801F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:30:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7AA4A2B07F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:30:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AAA0986499
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 07:30:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5AAAF981BDD; Mon, 11 Sep 2023 07:30:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48BB298635C;
	Mon, 11 Sep 2023 07:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITAe2/dh0qbRkC8lRJIr0TPmY54qbZFsEOwZ0+b7bwfpUoucSDalt7RVNtPk7tHV8tob8XvNgrNk0lK2wQ6XG3tyyI94ePsliYC3RXfkGSN3k+mxIAEOWYZ7xKsRaulPvY1SOApsU3//TMRb/0GCJFBooPVgxMWJ1vx6+srE3hZPkhJ2wVLcpXwx5kIRzbqo5tUefZDy3GsWoe1w+G9Ykc/OQQt5Hip4khZzpKO4Gfuj8WKpFBoWvPHTgHlb3gluJ/Y6YxStTVw/aNUBUMyA37SMjHvIyJ7jy6DKUul1LQfyV2z20wEYCFNPhgCJ/H8UtXSBTSxdXH/XVe94gjMjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABPX4WHEucy+j+8bPx+9GZY/sTSFn0ViRlp7zB7p9ug=;
 b=gV+gcQkci8xkoMHT/9oHiICirGO7RLABKqaTQaiLN1DjI6bXoKSHkX0IyQvXbJVmzEEbBl06Dq3i9pdcRbH2JXEjLoY1vDBHDwbMxZILNuAelka1b2cEphgJgAsdTjwWdjXqPjR9O3eEM6D/UCbGuop8gQdvT1vaSBzz5lPiDiF2qWKQz4uaxeOhoNYVmzUEXb0NJtpaQC4OeyMRHuLBcaNHmciBye4LcI27Qhlfb+yEOc07T8E/ebKnBQsEHuXNyTtJ7r0pwvu81ryIuFX+xntgmCCY7bR14+0fpImwgXI3JKMfi1UsjSiaEQoE/HiKH/F+Ah0BIywV2JodC3uLRQ==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWA=
Date: Mon, 11 Sep 2023 07:30:19 +0000
Message-ID:
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
In-Reply-To: <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4296:EE_
x-ms-office365-filtering-correlation-id: e7ee58a5-32d9-4b9f-c582-08dbb298f3a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F322/TsdfzIMwFwiKxc81WRJN+THqRHs5v7FZ9LacARt2gIxExSgHESwEPWV9MoBbiBKf/8ANt8T0yy0EloRl+gNedAQ/GsykUFYfxOrDDiBVjBtAn/veLzr0AyVRgmSo1qUjmJCSY2C9Xce2P+SbAlR6hFQoWBvmO68j9WsvBhNNZ32EMl15c0+tdNXo6irLaGlMCZC7psYvzDB+ytPtzu6LBVizXNzugojpdtpv1eZ1q61AgLkhXFAqsONbgjjvfHluEZSfH/HLdnALRBYv6wBzqTnyADvGfk8bkE9riAUs3eb4oMeEi8WKWBr+/C9uUPDArRURkInofxR3CaqcuAMTpQGA7XOe/BXBEMUlHnzyH6rGxWit6BI9IgzdtyAHmXI3YMwg/RTtggqMf6yHj5eMo2qWwrnix0u4nsCC6D6LU+aN1DmnnhkEoxUF+A3g3XciaLaFasn0ikb49P93HSRdChntUzUyx7VaUpltZzOztHakL7AtSQ68PPfcoMVs0uTq72/4T6q49ZM82FqsnDAmhfVPJPpOCCCGAzRs2lBT1E/SvBJgN7QQuvMQlsQJhje2iknTBuLgpTeHeF390MQMzhDz8y1twKOX9YVJ94L6Zh51dGXrrWBx7iWenbV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(76116006)(110136005)(2906002)(86362001)(83380400001)(7696005)(6506007)(53546011)(55016003)(71200400001)(33656002)(9686003)(38100700002)(38070700005)(122000001)(478600001)(52536014)(5660300002)(4326008)(8936002)(8676002)(66476007)(66556008)(316002)(66446008)(54906003)(64756008)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlJvQStCRzB0WEJlZVhRRU9Wd1p0K1IzUDlyTGNDSFlMWmh3elRxeG1lYzZk?=
 =?utf-8?B?c2VENnU4cm9rRFU0dHNNUkxHWHpLcjE0UDRBQys1cDNvdytjZy90RUk0MUZu?=
 =?utf-8?B?VFIwK0phV0trVGU4TDVQbDUxWjRuTDZBY2Y0b2RBRW84dUtQNmk1eE9nSmtZ?=
 =?utf-8?B?aytpYTROTWVKN21mOFllYWNmRHFJODJQeHBSOURCQk1uVlR6bzBnSjMrUERB?=
 =?utf-8?B?R2llRlZJVSthalQzOHFWQnJGRlp2bGdSOWRaQ0ZUOTg0R0EzaTNLcWNqVVEw?=
 =?utf-8?B?T09kRGpNNVgwb2V2b0JvZmdzTzRnQUhNVXdLV3ZoOUZXc0lvMjBuQlpMajJQ?=
 =?utf-8?B?UUV4Qm9SRnJ3NWJKNmt3bUJIOE8ySXRkbzlpWVBuYldhVUtVYi94L0loY2ph?=
 =?utf-8?B?UjdRNUxFUlo1cmdZcmFPYnZ1azZwdjN0STFKUlFRSnNFblljMlo3WG5kdTY0?=
 =?utf-8?B?TkZRelduWkI5MmRTNWFXWWE1Q3F2d282bHMzUE1Dc3IxR2lURVd1NEZOb2Fu?=
 =?utf-8?B?cnkwdjQ5QTlVK0xmaEU2cUZpakt6YXRsOUhZSVBSb0pPSjMxc1JWMFp4QUZD?=
 =?utf-8?B?Q3VPSkhiK21zSkFJZlU0bjU2MG11eUNCMlgrNkxEbEVyY2xBcHgwRWZWU2Yv?=
 =?utf-8?B?b3djWkkvN0k0MkorYi8rbjBzYmxWaUNVQ0xLSDRISjFLRzhtd2MzN1liNjA3?=
 =?utf-8?B?bzhtYXFQOVdaSGl0WG9qT1pnTXd6U3BwekROZGFjM001Y25WODZVZjUxR1Jh?=
 =?utf-8?B?eWZMTUt3akxkNVA2MGNjamVNT3lOMUVjYkE4UkdPTGNLRU9HRHdPK1c2T3B4?=
 =?utf-8?B?Yy93U205bUFHWkx2WGh1Njh3Wkx0ZVNTbWIyR2VrejRRbmNNSFgxSXFEalhP?=
 =?utf-8?B?UDg0Nm1IT3FUWHliVVBhUktXSUJUTDI4dEF1VlpYTFliVzJUUnIyWVJGRlZt?=
 =?utf-8?B?SzE0bXhnQ1pEMEU0aHUwY0taQU1jOXpzKzFNVHpSM1pCRUl3ZlBqbW9HL25o?=
 =?utf-8?B?RGpKRktzRzEwcDhQY3JkcGYxb1FmUEJwaEkzTFpnSW1sQWtXWGc3UTdTZ1BG?=
 =?utf-8?B?eW8yckFWZWFtdW5yUlJ5NXJCREpLdXBuOGxqcnE5MVd1SzhIVWRpRi9hdndZ?=
 =?utf-8?B?Y1BxdUh3MnZMcUxTMEI5TEJod1BtNFplTk9YQ0RPaGh2ZktYUlFWY1gwaEpD?=
 =?utf-8?B?ZGpxZHBNSHU2UzEzaGhiR0VWQXlheDJpTW9Lczg1S0tTaUVrdktvL3NIaUZ6?=
 =?utf-8?B?S3c5dU8zYTh2a1h1YnVTZVFreEkwZ1VjOExScEdMRmxRSzhGZFJvK2ZHVFZo?=
 =?utf-8?B?c3RIbkxIWTdjSmh5bjZSR3JmeUlWeVcvdEtuNXQxbWQ4cEwwano0allMbGpz?=
 =?utf-8?B?Z1d0ejE0VDI3dWdLd2E5VmJYYmZjcDhIS0NMR21XckIyQjVZdnY5Z3FURHI1?=
 =?utf-8?B?U3NLNGE1eGx6SkorN2tVOTRMaWJWYUNESFlPTU9LK2VXUzBZSGJiVzFoOXBl?=
 =?utf-8?B?ZE91V2VUTWpVZTdCbkI1aXlzVlpkdXY4ZDE0WGk4azhpcko5WTROb3kwMi9t?=
 =?utf-8?B?VW5JRlMxWE5TeFBwWDhZdjJZVVYrLzRDMHVISStHZUNvRENrNExlbXhNZDBU?=
 =?utf-8?B?U0dYWmtqMHVyNkJkVXJ5bHBJQndyTTI2Y0VMRDR6S3JSK1lqd0pjeXJMS082?=
 =?utf-8?B?bVFiR2Y0SHBtdDZDSmp6eGZTOEtRNE1wb280NFJqdVU0WFNHZDQzVFg4ZStn?=
 =?utf-8?B?bGZ5c283SGtmejNPbXZJazMxT2MrL2JpVHpTMUVIeFdRMkVWYXhReXh6NUlN?=
 =?utf-8?B?YXJTUmo3aXI0ZXdVdHFlbVJrd083b0IxMENvK253KzRLSGlRNFdtMHd5aVUw?=
 =?utf-8?B?NmVBUHg3QnRuR0ZTMzJJUzlnWDNCZGF5UVdwaStsbEdsNllndTFpS1RtSTZq?=
 =?utf-8?B?WW1vZ0wwR2tGZTJvTmpCQ2NsSEM0VndDVXFWdUNBTFJPYlBRaTdOcHY0L2xt?=
 =?utf-8?B?QmNJM3hFdUQyMUJiUjNXeFN3S3Zya1R2VjdBQkFJOUtKR2hpZVQvOTJJN3NK?=
 =?utf-8?B?ZlhoTXNUY2hEeWl4QWhyWHRMUGUrQkQzNCtuMkpUWHoyWEhLZFUxcHhyc0kz?=
 =?utf-8?B?UGtHTHBxaDMyS2FhVlIzLzhpRVdZMDR3QmRDVitUNGZ3V1FweUtlY3dubFNU?=
 =?utf-8?Q?2Jz64zQCfa52Srhw+lGAYzow6F782go5AHHyIX3fi8yY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ee58a5-32d9-4b9f-c582-08dbb298f3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:30:19.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQ/n46z3Ez4XziOp38+6pGjuLPvDbgN+X4dLpsZG3Ao8WxUG3eZMJ1vyzgXrYC+bPSGxzraVz1BZyUNeNoangw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiBTZW50OiBN
b25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyAxMjo0OCBQTQ0KPiANCj4gT24gOS8xMS8yMDIzIDM6
MDcgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFu
IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAx
MSwgMjAyMyAxMjoyOCBQTQ0KPiA+Pj4gSSBkb27igJl0IHNlZSBpbiBoaXMgcHJvcG9zYWwgaG93
IGFsbCB0aGUgZmVhdHVyZXMgYW5kIGZ1bmN0aW9uYWxpdHkNCj4gPj4+IHN1cHBvcnRlZCBpcw0K
PiA+PiBhY2hpZXZlZC4NCj4gPj4gSSB3aWxsIGluY2x1ZGUgaW4tZmxpZ2h0IGRlc2NyaXB0b3Ig
dHJhY2tlciBhbmQgZGlyeS1wYWdlIHRyYWtpbmcgaW4NCj4gPj4gVjIsIGFueXRoaW5nIGVsc2Ug
bWlzc2VkPw0KPiA+PiBJdCBjYW4gbWlncmF0ZSB0aGUgZGV2aWNlIGl0c2VsZiwgd2h5IGRvbid0
IHlvdSB0aGluayBzbywgY2FuIHlvdQ0KPiA+PiBuYW1lIHNvbWUgaXNzdWVzIHdlIGNhbiB3b3Jr
IG9uIGZvciBpbXByb3ZlbWVudHM/DQo+ID4gSSB3b3VsZCBsaWtlIHRvIHNlZSBhIHByb3Bvc2Fs
IHNpbWlsYXIgdG8gWzFdIHRoYXQgY2FuIHdvcmsgd2l0aG91dCBtZWRpYXRpb24NCj4gaW4gY2Fz
ZSBpZiB5b3Ugd2FudCB0byBjb21iaW5lIHR3byB1c2UgY2FzZXMgdW5kZXIgb25lLg0KPiA+IEVs
c2UsIEkgZG9u4oCZdCBzZWUgYSBuZWVkIHRvIG1lcmdlIHR3byB0aGluZ3MuDQo+ID4NCj4gPiBE
aXJ0eSBwYWdlIHRyYWNraW5nLCBwZWVyIHRvIHBlZXIsIGRvd250aW1lLCBuby1tZWRpYXRpb24s
IGZscnMgYWxsIGFyZSBjb3ZlcmVkDQo+IGluIFsxXSBmb3IgcGFzc3Rocm91Z2ggY2FzZXMuDQo+
IFdlIGFyZSBpbnRyb2R1Y2luZyBiYXNpYyBmYWNpbGl0aWVzLCBmZWVsIGZyZWUgdG8gcmUtdXNl
IHRoZW0gaW4gdGhlIGFkbWluIHZxDQo+IHNvbHV0aW9uLg0KQmFzaWMgZmFjaWxpdGllcyBhcmUg
YWRkZWQgaW4gWzFdIGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KWW91IGNhbiBsZXZlcmFnZSB0
aGVtIGluIHlvdXIgdjIgZm9yIHN1cHBvcnRpbmcgcDJwIGRldmljZXMsIGRpcnR5IHBhZ2UgdHJh
Y2tpbmcsIHBhc3N0aHJvdWdoIHN1cHBvcnQsIHNob3J0ZXIgZG93bnRpbWUgYW5kIG1vcmUuDQoN
Cj4gPg0KPiA+PiBJZiB5b3Ugd2FudCB0byBpbXBsZW1lbnQgTE0gYnkgYWRtaW4gdnEsIHRoZSBm
YWNpbGl0aWVzIGluIG15IHNlcmllcw0KPiA+PiBjYW4gYmUgcmUtIHVzZWQuIEUuZy4sIGZvcndh
cmQgeW91ciBzdXNwZW5kIHRvIFNVU1BFTkQgYml0Lg0KPiA+IEp1c3QgVlEgc3VzcGVuZCBpcyBu
b3QgZW5vdWdoLi4uDQo+IEluIHRoaXMgc2VyaWVzLCBpdCBjb250YWluczogZGV2aWNlIFNVU1BF
TkQsIHF1ZXVlIHN0YXRlIGFjY2Vzc29yLg0KPiBNU1QgcmVxdWlyZWQgaW4tZmxpZ2h0IGRlc2Ny
aXB0b3IgdHJhY2tpbmcsIHdoaWNoIHdpbGwgYmUgaW5jbHVkZWQgaW4gbmV4dA0KPiB2ZXJzaW9u
Lg0KRm9yIHBhc3N0aHJvdWdoIG1vcmUgdGhhbiB0aGF0IGlzIG5lZWRlZC4NCj4gPg0KPiA+Pj4N
Cj4gPj4+Pj4gQWRtaW4gcXVldWUgb2YgdGhlIG1lbWJlciBkZXZpY2UgaXMgbWlncmF0ZWQgbGlr
ZSBhbnkgb3RoZXIgcXVldWUNCj4gPj4+Pj4gdXNpbmcNCj4gPj4+PiBhYm92ZSBbMV0uDQo+ID4+
Pj4+PiAyKSB3b24ndCB3b3JrIGluIHRoZSBuZXN0ZWQgZW52aXJvbm1lbnQsIG9yIHdlIG5lZWQg
Y29tcGxpY2F0ZWQNCj4gPj4+Pj4+IFNSLUlPViBlbXVsYXRpb24gaW4gb3JkZXIgdG8gd29yaw0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+PiBQb2tpbmcgYXQgdGhlIGRldmljZSBmcm9tIHRoZSBkcml2ZXIg
dG8gbWlncmF0ZSBpdCBpcyBub3QgZ29pbmcNCj4gPj4+Pj4+PiB0byB3b3JrIGlmIHRoZSBkcml2
ZXIgbGl2ZXMgd2l0aGluIGd1ZXN0Lg0KPiA+Pj4+Pj4gVGhpcyBpcyBieSBkZXNpZ24gdG8gYWxs
b3cgbGl2ZSBtaWdyYXRpb24gdG8gd29yayBpbiB0aGUgbmVzdGVkIGxheWVyLg0KPiA+Pj4+Pj4g
QW5kIGl0J3MgdGhlIHdheSB3ZSd2ZSB1c2VkIGZvciBDUFUgYW5kIE1NVS4gQW55dGhpbmcgbWF5
IHZpcnRpbw0KPiA+Pj4+Pj4gZGlmZmVyZW50IGhlcmU/DQo+ID4+Pj4+IE5lc3RlZCBhbmQgbm9u
LW5lc3RlZCB1c2UgY2FzZXMgbGlrZWx5IGNhbm5vdCBiZSBhZGRyZXNzZWQgYnkNCj4gPj4+Pj4g
c2luZ2xlDQo+ID4+Pj4gc29sdXRpb24vaW50ZXJmYWNlLg0KPiA+Pj4+DQo+ID4+Pj4gSSB0aGlu
ayBMaW5nIFNoYW4ncyBwcm9wb3NhbCBhZGRyZXNzZWQgdGhlbSBib3RoLg0KPiA+Pj4+DQo+ID4+
PiBJIGRvbuKAmXQgc2VlIGhvdyBhbGwgYWJvdmUgcG9pbnRzIGFyZSBjb3ZlcmVkLg0KPiA+PiBX
aHk/DQo+ID4+DQo+ID4+DQo+ID4+IEFuZCBob3cgZG8geW91IG1pZ3JhdGUgbmVzdGVkIFZNcyBi
eSBhZG1pbiB2cT8NCj4gPj4NCj4gPiBIeXBlcnZpc29yID0gbGV2ZWwgMS4NCj4gPiBWTSA9IGxl
dmVsIDIuDQo+ID4gTmVzdGVkIFZNID0gbGV2ZWwgMy4NCj4gPiBWTSBvZiBsZXZlbCAyIHRvIHRh
a2UgY2FyZSBvZiBtaWdyYXRpbmcgbGV2ZWwgMyBjb21wb3NlZCBkZXZpY2UgdXNpbmcgaXRzIHN3
DQo+IGNvbXBvc2l0aW9uIG9yIG1heSBiZSB1c2luZyBzb21lIGtpbmQgb2YgbWVkaWF0aW9uIHRo
YXQgeW91IHByb3Bvc2VkLg0KPiBTbywgbmVzdGVkIFZNIGlzIG5vdCBhd2FyZSBvZiB0aGUgYWRt
aW4gdnEgb3IgZG9lcyBub3QgaGF2ZSBhY2Nlc3MgdG8gYWRtaW4NCj4gdnEsIHJpZ2h0Pw0KUmln
aHQuIEl0IGlzIG5vdCBhd2FyZS4NCg0KPiA+DQoNCj4gPj4gSG93IG1hbnkgYWRtaW4gdnFzIGFu
ZCB0aGUgYmFuZHdpZHRoIGFyZSByZXNlcnZlZCBmb3IgbWlncmF0ZSBhbGwgVk1zPw0KPiA+Pg0K
PiA+IEl0IGRvZXMgbm90IG1hdHRlciBiZWNhdXNlIG51bWJlciBvZiBBUXMgaXMgY29uZmlndXJh
YmxlIHRoYXQgZGV2aWNlIGFuZA0KPiBkcml2ZXIgY2FuIGRlY2lkZSB0byB1c2UuDQo+ID4gSSBh
bSBub3Qgc3VyZSB3aGljaCBCVyBhcmUgdGFsa2luZyBhYm91dC4NCj4gPiBUaGVyZSBhcmUgbWFu
eSBCVyBpbiBwbGFjZSB0aGF0IG9uZSBjYW4gcmVndWxhdGUsIGF0IG5ldHdvcmsgbGV2ZWwsIHBj
aSBsZXZlbCwNCj4gVk0gbGV2ZWwgZXRjLg0KPiBJdCBtYXR0ZXJzIGJlY2F1c2Ugb2YgUU9TIGFu
ZCB0aGUgZG93bnRpbWUgbXVzdCBjb252ZXJnZS4NClFPUyBpcyBzdWNoIGEgYnJvYWQgdGVybSB0
aGF0IGlzIGhhcmQgdG8gZGViYXRlIHVubGVzcyB5b3UgZ2V0IHRvIGEgc3BlY2lmaWMgcG9pbnQu
DQo+IA0KPiBFLmcuLCBkbyB5b3UgbmVlZCAxMDAgYWRtaW4gdnFzIGZvciAxMDAwIFZNcz8gSG93
IGRvIHlvdSBkZWNpZGUgdGhlIG51bWJlcg0KPiBpbiBIVyBpbXBsZW1lbnRhdGlvbiBhbmQgaG93
IGRvZXMgdGhlIGRyaXZlciBnZXQgaW5mb3JtZWQ/DQpVc3VhbGx5IGp1c3Qgb25lIEFRIGlzIGVu
b3VnaCBhcyBwcm9wb3NhbCBbMV0gaXMgYnVpbHQgYXJvdW5kIGluaGVyZW50IGRvd250aW1lIHJl
ZHVjdGlvbi4NCllvdSBjYW4gYXNrIHNpbWlsYXIgcXVlc3Rpb24gZm9yIFJTUywgaG93IGRvZXMg
aHcgZGV2aWNlIGhvdyBtYW55IFJTUyBxdWV1ZXMgYXJlIG5lZWRlZC4g8J+Yig0KRGV2aWNlIGV4
cG9zZXMgbnVtYmVyIG9mIHN1cHBvcnRlZCBBUXMgdGhhdCBkcml2ZXIgaXMgZnJlZSB0byB1c2Uu
DQoNCk1vc3Qgc2FuZSBzeXMgYWRtaW5zIGRvIG5vdCBtaWdyYXRlIDEwMDAgVk1zIGF0IHNhbWUg
dGltZSBmb3Igb2J2aW91cyByZWFzb25zLg0KQnV0IHdoZW4gc3VjaCByZXF1aXJlbWVudHMgYXJp
c2UsIGEgZGV2aWNlIG1heSBzdXBwb3J0IGl0Lg0KSnVzdCBsaWtlIGhvdyBhIG5ldCBkZXZpY2Ug
Y2FuIHN1cHBvcnQgZnJvbSAxIHRvIDMySyB0eHF1ZXVlcyBhdCBzcGVjIGxldmVsLg0KDQo+ID4N
Cj4gPj4gUmVtZW1iZXIgQ1NQIG1pZ3JhdGVzIGFsbCBWTXMgb24gYSBob3N0IGZvciBwb3dlcnNh
dmluZyBvciB1cGdyYWRlLg0KPiA+IEkgYW0gbm90IHN1cmUgd2h5IHRoZSBtaWdyYXRpb24gcmVh
c29uIGhhcyBhbnkgaW5mbHVlbmNlIG9uIHRoZSBkZXNpZ24uDQo+IEJlY2F1c2UgdGhpcyBkZXNp
Z24gaXMgZm9yIGxpdmUgbWlncmF0aW9uLg0KPiA+DQo+ID4gVGhlIENTUHMgdGhhdCB3ZSBoYWQg
ZGlzY3Vzc2VkLCBjYXJlIGZvciBwZXJmb3JtYW5jZSBtb3JlIGFuZCBoZW5jZQ0KPiBwcmVmZXJz
IHBhc3N0aHJvdWdoIGluc3RlYWQgb3IgbWVkaWF0aW9uIGFuZCBkb27igJl0IHNlZW0gdG8gYmUg
ZG9pbmcgYW55DQo+IG5lc3RpbmcuDQo+ID4gQ1BVIGRvZXNudCBoYXZlIHN1cHBvcnQgZm9yIDMg
bGV2ZWwgb2YgcGFnZSB0YWJsZSBuZXN0aW5nIGVpdGhlci4NCj4gPiBJIGFncmVlIHRoYXQgdGhl
cmUgY291bGQgYmUgb3RoZXIgdXNlcnMgd2hvIGNhcmUgZm9yIG5lc3RlZCBmdW5jdGlvbmFsaXR5
Lg0KPiA+DQo+ID4gQW55IHdheXMsIG5lc3RpbmcgYW5kIG5vbi1uZXN0aW5nIGFyZSB0d28gZGlm
ZmVyZW50IHJlcXVpcmVtZW50cy4NCj4gVGhlIExNIGZhY2lsaXR5IHNob3VsZCBzZXJ2ZXIgYm90
aCwgDQpJIGRvbuKAmXQgc2VlIGhvdyBQQ0kgc3BlYyBsZXQgeW91IGRvIGl0Lg0KUENJIGNvbW11
bml0eSBhbHJlYWR5IGhhbmRlZCBvdmVyIHRoaXMgdG8gU1ItUENJTSBpbnRlcmZhY2Ugb3V0c2lk
ZSBvZiB0aGUgUENJIHNwZWMgZG9tYWluLg0KSGVuY2UsIGl0cyBkb25lIG92ZXIgYWRtaW4gcXVl
dWUgZm9yIHBhc3N0aHJvdWdoIGRldmljZXMuDQoNCklmIHlvdSBjYW4gZXhwbGFpbiwgaG93IHlv
dXIgcHJvcG9zYWwgYWRkcmVzc2VzIHBhc3N0aHJvdWdoIHN1cHBvcnQgd2l0aG91dCBtZWRpYXRp
b24gYW5kIGFsc28gZG9lcyBETUEsIEkgYW0gdmVyeSBpbnRlcmVzdGVkIHRvIGxlYXJuIHRoYXQu
DQoNCj4gQW5kIGl0IGRvZXMgbm90IHNlcnZlIGJhcmUtbWV0YWwgbGl2ZSBtaWdyYXRpb24gZWl0
aGVyLg0KQSBiYXJlLW1ldGFsIG1pZ3JhdGlvbiBzZWVtcyBhIGRpc3RhbmNlIHRoZW9yeSBhcyBv
bmUgbmVlZCBzaWRlIGNwdSwgbWVtb3J5IGFjY2Vzc29yIGFwYXJ0IGZyb20gZGV2aWNlIGFjY2Vz
c29yLg0KQnV0IHNvbWVob3cgaWYgdGhhdCBleGlzdHMsIHRoZXJlIHdpbGwgYmUgc2ltaWxhciBh
ZG1pbiBkZXZpY2UgdG8gbWlncmF0ZSBpdCBtYXkgYmUgVERESVNQIHdpbGwgb3duIHRoaXMgd2hv
bGUgcGllY2Ugb25lIGRheS4NCg0KDQo=

