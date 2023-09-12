Return-Path: <virtio-dev-return-13718-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF2CCA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:40:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 300618504C
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:40:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E89298658F
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:40:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED88A986485; Tue, 12 Sep 2023 10:40:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD90F98648C;
	Tue, 12 Sep 2023 10:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eii4Y5mWK1JfwFAToikjaz99FMMGBUEMPq+V2VDlBeMDnabD9kihP7QFLsB9cmrYa15XBF4xSnUYs0zJowKLKHJuskq7NVhYBYOPPIGIugczUXHJAePQz8KXR9CtcmRiotLI55NmAoAV6qXIWSHtPlvq0IkRV5uMkyIHZIBO8zhSo+n/tDX43F6mA8QtdqHViNcA2uUiil2jtvZpveyIoDLo7ZTnInMrXu2bAXRCDEy4g/l3/DPItrzpIQFu8QcTo29mOqlCQbx2DfeO0cPEV/XD2K/nJpbtMc6vec5vv2mHZZGv9m/Hu1tn46rLgF0rntVY4nQ3wJVKxX6NpVNtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skSxpZqMebNBm5OpFdviK9IJjj3HQtwdVVPPHIy2ymQ=;
 b=VVjvPSt1O9RSKeH9ImlKRYRGEfcaM1d/8wmGyYxKJkMU5qvkD+R8GlQevP/vgiiHYnRNDt8e1RuBLjOPKrXelH09vQX+QWA906b4G9rh9fSvTry6pB+RhkuRYAZuvmG6xAS7i1FXeKGa3VOs4/XhUHzQRyZJyduue/tbvRLrZw+5JcQTvEhsorIlDNp4zgga6ZtDxQb1SME6ZcN35atr7700urmaNvvlqjVmdcG/ZACxq1RQzt97oxOsATmjM6U5a3dFnbVzJGrVFT2/duj9XUu57WHIH8pXV99civiz4z7sIVWLGJ6lurTJX2k4t+ElE8044LbZLnrjIz0UEDp5AA==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAABGsggAAPgQCAAACMgIAAA6oAgAAAf+A=
Date: Tue, 12 Sep 2023 10:40:22 +0000
Message-ID:
 <PH0PR12MB548132955552FF41EA1B43BEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <PH0PR12MB5481036BC22785DC22A394D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c39bfe6-1acf-6ee7-2a0c-1861fa680eb4@intel.com>
 <PH0PR12MB54815CE0845F866CD8125662DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b892785d-2850-f5e6-531f-d4934ebc7085@intel.com>
In-Reply-To: <b892785d-2850-f5e6-531f-d4934ebc7085@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6335:EE_
x-ms-office365-filtering-correlation-id: 2086840f-d4f7-43be-178c-08dbb37caac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LQbZTkXdyujgUk/SNW3YXI7N7jGFJsGf3HxcLKaiaEaXlEAGXV3veU0eU4pvAEvK8iLdE614BOZ+S8ScZFOdE4u8KN0rVJrkdiKD5+GGDONlcY0kQnbocT+Zp0AYCOMpKe/7oGpUmVpMWVOoEEJy0jZSSY6atlVNVKSSM9VD1k2wnVG88dQ2mM5GvoCgcHWkG6q8oHynv3D0Zj61J0KIGHjYBV1nvDjUNMckaaqZ9jhByAxhbDqhcRhiEQilpUHC3l+aiG32PYLuB96I9YA2AFggb9cl+3TojRJyjDPpsvN+f3vDuBWLpIPIyz6W2cerFqkHSkwWdDsgqyRaHJCgIZaCLM0fALOvVoxufvS0XwYskbe05i4g6QOvTuX7Y8sKXjn1plJ4mgSVU94XSEomhYvH5Incp1sX+3Vqzc7D2rxNmdRyJhb1Hf2AnyKDJ7KB/IfrygdscSIsUp2wKkCKlUQUYFZn9CIYwVVV95O3Wf6rhWZVCV32TIcDBkYo69xVj/Fk1bjO7yOe/+7yK8LLkd+edPHxhGvvIEJ0aKheHsacVyKfUoA/4V9XJVc0La8dbXojIPkYKsA2aHp1PuXu8REdFVR2Z0cKH8rpXN+9WZU+8KEcZnuy/qGxStrZJCYg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(5660300002)(52536014)(66946007)(41300700001)(316002)(54906003)(66446008)(8676002)(4326008)(66476007)(8936002)(64756008)(66556008)(110136005)(76116006)(122000001)(478600001)(38100700002)(71200400001)(6506007)(7696005)(86362001)(2906002)(83380400001)(53546011)(26005)(38070700005)(33656002)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVZqOUpsc0hxZUduZGtiT1daK0lZam54cTZ2SCthWUcxQkE2MCsxU3RUVXpu?=
 =?utf-8?B?d0pZNzIzNmFPNy81b2xHSU1wL0JsanVONHYvb01iTUFRdTU4K2Q0TkpINlNV?=
 =?utf-8?B?WW90T1dtOHdRVGlMeU9hSkRERWhyZ0Z1ZWZDNXF3MTVDRXBydHRuQWp5T29u?=
 =?utf-8?B?c2YwNU4wbEZ5QlNmYnlrYTNGWFlvK24wZlRTNDl3YVExMSs1eEM4UmNOS0dJ?=
 =?utf-8?B?N3I1N1NYcm01Yjl0UTdxNUdYZlRWMXhJUFdNMUx4Q055TVlCZXlrTktBdUZF?=
 =?utf-8?B?SDlzQTJsTTFDQTNwbThHZWRKamRGT3Nsd0JBdG1QRXRJNU5WN3h4dkpWWW0y?=
 =?utf-8?B?NGw2MU1raldkMzNOT3ZtTWp6bVVVU053US80ZC9tdFVTTTNsRDhLUGRKMStQ?=
 =?utf-8?B?RUVJbHAwLzdlMUhWNmZKNTRxc2NseXAvR3lXaXlmQUFnWWZZSGZZZ1REcUQ3?=
 =?utf-8?B?TTgwbndRUlNCNGFxeHFYRzZTZGw5R1d1T21tS1l2Njl4RHJ4QmFIVG1XRi90?=
 =?utf-8?B?R3ZKNEZNYi9ZOGJUWDJRVWFDdTdJbGI0b2ZqRzVSbEp1QTlqQmJWaURaVXBr?=
 =?utf-8?B?OGhyMHZtWi9ZZ0dFSmlnNkVDWGtOaTAvdkcwVW5iajNuNjhrWkV6NmVxb3ZI?=
 =?utf-8?B?YVZkNWtYMXh4T2VLNWhlWm5lTk4zdjJFaThwZ2kvR3FNN0Z6ZWMvV2txRytz?=
 =?utf-8?B?ZzBob3liNGVwZjh1ZVNlSVl1R0UxY3YzdUtYWmZCQkxtZUdROWJKbzNPSTlH?=
 =?utf-8?B?SzZEUWk1TUtYYmhmNTg1NFY3RnRBQzM2V2RzWUJiL0xiRCs2eU5SdjRValhN?=
 =?utf-8?B?TC9NVFBOYjk3U1dhWTl4WDdMVE5TSlB0ZGJ4VDErcjhDOGllN28rUUFqTU9t?=
 =?utf-8?B?UWFtc1MraHZjSC93UktKV2liYzBLcFYyTVVlbU5ybVJHR3FMUS8wSXZsQ1pB?=
 =?utf-8?B?SkFaL2FqTGVmQ0NFeFdJWmtjR3ZHbmZ3VEthS29ZbU45Yzd0eTNxQW5tMkdW?=
 =?utf-8?B?bHpmNjlQaFdaN0N0R0dZTzlYTkMzdGUvMHgxQU52akpDR1I1M1BsS3Z4aEJn?=
 =?utf-8?B?Tno4UDlpT2VNMWpZT3AzeXZQR01DODhBRzNyaTFldE0wSjNtQXp6bWdnMHY3?=
 =?utf-8?B?TnplUXNvamJzTVB2UXJpSHVGSDlTU05BdGRxV2ZTcEdudHRSV2lQWnlYRm8z?=
 =?utf-8?B?U1haeTJCalRDemxsWXg4NEJFVUJhSE9wMG9XUEp2MFdkblNnTWpON1VIajc1?=
 =?utf-8?B?U3ZpNnJRMC9ub3l5SGhOdHpEWHVQNXFKUFM1cllNRlN6UlhadkYrZmtsWUxK?=
 =?utf-8?B?YllGaTlVR1htTmFsYTNMT2JzQ3lnVFBqUFhSS2s5bVlDTkVoZjNvenVaQ0Yx?=
 =?utf-8?B?Um9HSnllTXVWamcxcmlUNFl0OTZSUGRFZE9jQnUwcWRVSVdxbE54anNYdGJi?=
 =?utf-8?B?TmJ2dFV1OXp4OTFRRFNhcnl6TXNxR3VLQk1WWStRNzNsb1NzWG9xTnBoVHVV?=
 =?utf-8?B?ODl1WlFZZHZmRTUyMGRyN1kwNVJWeC9oNVBRUUZOaTFobVVCYTZzVlJJRUh6?=
 =?utf-8?B?T3hCOCszdW40dlpLRVIrOTk0eUZJQjhPVCt1QjYyMGJEOG5ERWJvS0R3TFlZ?=
 =?utf-8?B?SFEyMGI3d0lTeTllQ2xCLzBBM3BjWTBvZlNIT3dRRW9ldzFVZVhPQkY1aGg5?=
 =?utf-8?B?QldZN0Ezc3dtQ3NCVmljaWdMSk9LVFhLcVIzU0RWLzY5YXdKT3RDV044c2pW?=
 =?utf-8?B?MjcreVhsdjIxSjZ4UlZVVUNaOXZuZGZ5ZzZtWG5ISnZjY2c2QnRwSWlGRG5I?=
 =?utf-8?B?bnlaS1dBWlhyM2xESnppcTFuY2FYRVdGTnVSZzFIVnhMdnhiNm90WkIwV2d5?=
 =?utf-8?B?SzByRzRJTmcvMlE1NnZVcVlneXYwOHFBZXlWVE4wNmtpMFVnNEZBZlpReTVP?=
 =?utf-8?B?QWlyZ0diTDluWmhmQUs5aU13TkxqaVBZU1VYK0QvcTVBL2ZkWkJncmVqa0dF?=
 =?utf-8?B?eFk4b1I0T0xOQ2dhY21jbm9LVmY4MjFkMEpPaGxSRHFkM2l4bDAzL3FlYk9r?=
 =?utf-8?B?dFQyZEEwOWcwdUYvcHA3dGZHbTZzaHN0cms2eU9TK2lzck9uL1B0ZlNic3FX?=
 =?utf-8?Q?1eec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2086840f-d4f7-43be-178c-08dbb37caac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:40:22.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VylLtTNfqlezs8GrWt19W6WziQp2XUVcQW83n19UKueTyKY5qdeBqVLVW09gseTS2RkqTDU4cNw6/WXOSkTr9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyA0OjAyIFBNDQo+IA0KPiBPbiA5LzEyLzIwMjMg
NjoyNSBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIs
IDIwMjMgMzo0NyBQTQ0KPiA+Pg0KPiA+PiBPbiA5LzEyLzIwMjMgNToyOCBQTSwgUGFyYXYgUGFu
ZGl0IHdyb3RlOg0KPiA+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRl
bC5jb20+DQo+ID4+Pj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDIzIDI6MzYgUE0g
SWYgeW91IHdhbnQgQVEgdXNlZCBmb3INCj4gPj4+PiBMTSwgaXQgc2hvdWxkIHN1cHBvcnQgbmVz
dGVkIGFueXdheSwgZG9uJ3QgYnJlYWsgdXNlciBsb2dpYy4NCj4gPj4+IFlvdSBpZ25vcmVkIHRo
ZSBvdGhlciBwYXJ0IG9mIG15IHF1ZXN0aW9uIHdoZW4geW91IGFza2VkIGFib3ZlLg0KPiA+Pj4g
aS5lLiBhIFBDSSB0cmFuc3BvcnQgZG8gbm90IGFsbG93IHN1Y2ggd2VpcmQgYmlmdXJjYXRpb24u
DQo+ID4+IEkgZmFpbGVkIHRvIHByb2Nlc3MgeW91ciBjb21tZW50Lg0KPiA+PiBEbyB5b3UgbWVh
biB0aGUgcmVnaXN0ZXJzIGRvbid0IHN1cHBvcnQgbmVzdGVkPw0KPiA+IE5vLiBJIG1lYW4gcmVn
aXN0ZXJzIGFjY2VzcyBzaG91bGQgc3VwcG9ydCBkZXZpY2UgcmVzZXQgZmxvdyBhbmQgRkxSIGZs
b3cuDQo+IERPIHlvdSBzZWUgdGhpcyBpcyBhIGNvbmNlcm4/IE9yIHdoeSBkbyB5b3UgdGhpbmsg
dGhlcmUgYXJlIHByb2JsZW1zPw0KWWVzLiBhZG1pbmlzdHJhdGlvbiBxdWV1ZSB3b250IGFuc3dl
ciBhZnRlciBTVVNQRU5EIGlzIGRvbmUgaW4gZGV2aWNlIHN0YXR1cy4NClNvIGhvdyBkbyB5b3Ug
cGxhbiB0byBzdXBwb3J0IEFRLCBpbmZsaWdodCB0cmFja2luZyBkaXJ0eSB0cmFja2luZyBhbmQg
c3VzcGVuZCBkZXZpY2Ugc3RhdHVzPw0KDQpEZXZpY2UgYmlmdXJjYXRpb24gaXMgbm90IHN1cHBv
cnRlZCBpbiB0aGUgcGNpIHNwZWMgYW5kIGl0cyBoYWNrIGluIHZpcnRpbyB0byBkbyBzby4NCg0K
QXMgSSBhc2tlZCBmZXcgdGltZXMgYmVmb3JlLCBpZiB5b3UgaGF2ZSBzb2x2ZWQgdGhpcywgSSBh
bSB2ZXJ5IGludGVyZXN0ZWQgdG8gbGVhcm4gbW9yZSBhYm91dCBpdC4NCg==

