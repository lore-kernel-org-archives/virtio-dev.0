Return-Path: <virtio-dev-return-13825-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED427CD54A7
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 08:31:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4031529FD5
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 08:31:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 180FF98655A
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 08:31:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED9BA983E25; Tue, 19 Sep 2023 08:31:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD6859864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 08:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPRtFiGosKKk3QN8WFldzmkhYbLqegE4H2wwVAFKg0FMYSHG9KNW88OVZsYHoyCTdR29v1L95TuGWUu8yoCd9F8b1KdhmsV9qsInFLd7rZKB9cV9IPXvouNHo/AWfO04e/Cvz3kE0peELxo6DyVDyKGTUc9976PRY3qu1nsZISYrgXAXtoN5c2ulRU0yZb3TklifPRwlIetYvF19x/xYYv4l+Zucreh7y5WTbf6ultop3+pp3wS5tDYwppBVGBqXq+NZzvH5BBeTlEacyinFCpVjqbeHLRWK/jfHqkWuBa+bLOs+9gjr7xhMDaVudtvqbc91VfDGq2tqD2YlYsfQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTJHcFejykcc7i/A2B1qvjtMKf+hATIWry3RZPONMsg=;
 b=f5Q9PZ9SnjmUVBdMSCEY4I29XvpDwXKa9A4xedFSKutyLdQx063ksz/nZd9TL9PYPBiDKPSjhGZ2FZMYXfL1rXoupwXUWaCissioB6m7Kn38+4I99Sc2V5CqaCc3z0+c29wZjuefdZzYDdxUSyyaXdmGZjBjYx6TQSA1Ft6VN/76oZx1jdTYxgZBNPPGG9pSvKnJalL31VEba1AcXQ3pvEYqQ+nDfKn99Jf1CNgLWmaSov7fkczWu5Q2FnC6tH/JF9PRvxNY3qlXuT76pP0EiOAU6EVta8juEsGR0zSX1NiVa73mBQ+3X8bgdkhfVQSk1OCk42BSHuMYK9FpoAOQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAWpyAIAAEyeQgAAkaoCAAAFRwIAAA4eAgAAHBjA=
Date: Tue, 19 Sep 2023 08:31:08 +0000
Message-ID:
 <PH0PR12MB5481B11949AFD1415AF4F267DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
 <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <474be878-333b-7c80-f116-28b90a3eca4d@intel.com>
 <PH0PR12MB5481236F275C1A0314D85FCFDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6b1b7993-08bc-f2a8-4cd9-92301372373a@intel.com>
In-Reply-To: <6b1b7993-08bc-f2a8-4cd9-92301372373a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB9007:EE_
x-ms-office365-filtering-correlation-id: 47e95799-36e8-468c-cc6a-08dbb8eac5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0xTp4xDA0op69HrD9imG81ssxTfDcmtVaHEMGq7PagiVZByeGTTzhTbNhOUZbjshZQ1zBA6k59cF840Jafsmzn+6MiwzhHhaed4uwItVzVUSwEduV8Z22TIM4ewNxSF7AVDvXzelE9OweQKpy17Q5fS9RopB4EltkjaqHTAMblS7ulftiTxhVtHQJoiwWtVnSO2Bf+O8TsSRXNn8AeArxRdx05itnT9CN5/BBe9fkZrAJSKtWwbK2b+PUU6T//1GqkyZiEF07pqwg1lyGrvl0xkVHgQ65+Iim5wsKJoauPSpSeiW4MVGu8MLvsXZhKmJ3je8fOXDXNyaz+5a0RDArzJOL7zeLn6u73FrFhn/VbfyrImBjHKgKhrOQc9DHOGWw3CRWtAI0x6yGbi/bnHtwJL0pIBL6dhN/vA/NT8XUcxR0nIYZew3+UwljsmBNgFpxIwQ/W9uHUbtNq/KICSVBjVNOFDkiolIm8WcmU3F0PrTOqZwgRW9y8gBlOKJpf5a85iJSNSqt0Fq+pBEawgdrXGrCTVzgiLCdVPrdOmOfrDDgNCl6XSxRWROorGknfHVxtmrk3ikfk3UcxcW3yP5zUje0Uuu10d9l75vXrxbip+/yT8qsclVw78qo24pYSmB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(186009)(1800799009)(451199024)(76116006)(110136005)(55016003)(66446008)(64756008)(54906003)(66946007)(66556008)(66476007)(316002)(478600001)(71200400001)(122000001)(38100700002)(38070700005)(2906002)(4744005)(33656002)(86362001)(41300700001)(5660300002)(52536014)(4326008)(8676002)(8936002)(26005)(7696005)(6506007)(55236004)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVFHR3NScnRCdTdJcnczazVVeTdXMlVlb0Racld5Q29YeUc4VHRZZE82cEhE?=
 =?utf-8?B?L3NrNGs2ZTZiOU52NE5zbURmQlNOYVBDV2IzVG5pNnhYaXRkWE84MzNJQnlV?=
 =?utf-8?B?MEhNZFJvWTlOQk41WjVrSDVrUGIxdUltY1YxczRleDRtSExQZGVuSThRdFMr?=
 =?utf-8?B?aFg2V2wzVG5zOVZJaytHdlliQzVORnpkcklDaEwzUGllT2Jjdjh3UU5sQkhM?=
 =?utf-8?B?aXU3SUxUbVpxMHpmMVdKSUpPOEp0WXJHRzU4L3FqWDhOWnNkQ2ViOEsrak9u?=
 =?utf-8?B?MUZUWHdkT2EwSitpakNsVzgvMEFMQ2NsZE1DTXVZNmxEVDlqdGFpVklyK0Jw?=
 =?utf-8?B?M1FycUxZWEJIdFJVcTRQYnpsYUJrMEt2VE5iekp5MUhjSmZHTEUzRHIzdjFY?=
 =?utf-8?B?ZGtJaTRkWHBqRlVscTF5cFJZRGYvdmlQdXRsSjlkOUk4SFI2Q1RSNGxiNU1x?=
 =?utf-8?B?cy9VNjFMUkpZeUFpVTcyZTVVZXFMS2dCcm9LUXRaMUhSaDZOZUYvVTFuaUlh?=
 =?utf-8?B?UTNzN2VnOFltd2RIT1RwZ1hQc2UrZ3R6NUg2R0MxY29GQVh5amNDM1JjZ2ZW?=
 =?utf-8?B?RndGY3pBdS83NUtZdVdOZFBEY2RGVjBIWlJjblI1NGpaYlNnUUZzMHVFRjd1?=
 =?utf-8?B?NG9pU042Sm9OaEMzSnJqM3NmK3VPbU1VejBCZkVFanhhVi84Qk5ac2dHNTBL?=
 =?utf-8?B?YktJRVZtM3pQVHVWOTQveHBKQVZxYzJQaHBZNHRUeGVXM1pXSTh2OWE5RUlV?=
 =?utf-8?B?SFBNczdyWXY4MDZJV3dRa3drMHN2YTcrSWc0aWJLazBiWFBKbC9zSFhtSEVs?=
 =?utf-8?B?cHduYkRZZ1lOQXZ2VW5iSEI4c29XT1NWTE9uQ25KbnR0ME54NVRGbkpYUGJ3?=
 =?utf-8?B?Q0l3d0crRGg2NU9qZWJYTkh6L1NPK0JOWHp2TnBpaXZQSmY3YTY5NFdDRFBZ?=
 =?utf-8?B?d0M5MkdyemI3eFJCMWp4SVdXK09LY0psNzVvTXdDRHNsTWhGV2pzbGxxeHNE?=
 =?utf-8?B?QUVnN1dqMm9ER0pNd0I4cUgyc1Nwb0lVQXNXY3dNQmNYTFozVGVibkZldXRQ?=
 =?utf-8?B?REMzT3o0VzZldCs4VjNIY2ZlaWJFampqK2xzOVVmVkNubnMzNFRBb21HYk5X?=
 =?utf-8?B?UEx6Nndxb29PZEwwMmhwOHE5ZDVzQ1d2dW95b09pTTliOTdpaWtDUHdVRDBw?=
 =?utf-8?B?amluZHNCRWNMdkdqaVBDeWl3WW0zT2RhWVVPeks4SzU3MDNtTmoxSW51TjF5?=
 =?utf-8?B?SzBLT1pvN3BTcGs1UEhXc1BXbDdYUEs4U2ZYMGxlMUlSNEVBQmVWVEU1WlZ6?=
 =?utf-8?B?QWpJQlRLdzBGZWdRRFBWVEFkTXZzWTFoM1ZaTjRiVFVWZTViaE1QbVlzQ2Jl?=
 =?utf-8?B?djZVTzhnNVozKzhsUVZwUkI3S0p4SnBnM0dzdWFNb3ZxWnYvTkRCSlRnbFVo?=
 =?utf-8?B?QkhKWTRZeldLL21ZOTNHcmNlYjc5S0phNnFCbFFFZDdUMndvSUJiYllLQ3Yv?=
 =?utf-8?B?ZGh0cGlXNmpxRXZSVE55WXVqcmZ0UGVicE9YeFZCbEV3ajBwMEk1MkgyYUVX?=
 =?utf-8?B?Ym9vZWl2NHZHZW9sVU9hZmM5NktVMkh0M0NsSEYzRjRxWUw0Mkl0WE9lMEt3?=
 =?utf-8?B?cHJiOXFKMFcxdVNYaVFvbTI3V2h2U3RPTEcrTlFaSHlmMlEzUFBZdTVFMmhq?=
 =?utf-8?B?dUs4emhRZmNBL3B1Z1I2ajkrTGd5bVFKTWNPeEJaYkpQdVhMMGtvZmFMTk5M?=
 =?utf-8?B?eHA2T09oSnh1bDBGZXlWVUk3eGorQy9XNXFEdXlORUtpTXNkbUdmWWx3a1Iv?=
 =?utf-8?B?V2t2ZzZkSVVCTjdsSDI2Y2RSUEVKWlhFZytvMytZT1NGRjhDRFpPQzA4SVhP?=
 =?utf-8?B?UU5sVkxRT3kxcm9palZkdmJsZVA0eWdqSHFnV0VhSU43c1NZMitGeEZCMUFj?=
 =?utf-8?B?cHArOUFWMy9EQk9peHJOMXp1TGN3bHVHekIyb2REcWwvcUVrdExvV3g4bU5a?=
 =?utf-8?B?UDhPNUNicGFkSnF2NEpSb1I4K1NFS0gxeDFwRnd6UnNBZFVDM3JTRjE2L1pm?=
 =?utf-8?B?SFNjR2tUQjc4cC9kUThIRkI4RjlVZnI0VVFvSjlQYUN2b2ViK0xHSVkvZ1BH?=
 =?utf-8?Q?WqwI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e95799-36e8-468c-cc6a-08dbb8eac5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 08:31:08.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/1Fwf7qwG+KxiQnvr/sYSLjhZwFEAGzK3pOczzY81NQYf+CTilqQcgXunxyL98/NY3b0Oq4iLIjqz1WbI+NMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxOSwgMjAyMyAxOjM0IFBNDQoNCj4gPiBJbiB5b3VyIHByZXZp
b3VzIGVtYWlsIHlvdSB3cm90ZSwNCj4gPg0KPiA+IDEuICJzbyBsZXRzIGZvY3VzIG9uIExNIHRv
cGljLCBvdGhlciB0aGFuIGNvbmZpZGVudGlhbCBjb21wdXRpbmcuIg0KPiA+IDIuICJhZ2Fpbiwg
VERJU1AgaXMgb3V0IG9mIHNwZWMgYW5kIFRESVNQIGRldmljZXMgYXJlIG5vdCBtaWdyYXRhYmxl
LiINCj4gPg0KPiA+ICBGcm9tIGFib3ZlIHR3byBjb21tZW50cyBmcm9tIHlvdSBJIHVuZGVyc3Rv
b2QgaXQgdGhhdCB3YXksIHlvdSB3YW50IHRvDQo+IGZvY3VzIG5vdyBvbiB0aGUgTE0gX290aGVy
X3RoYW5fIENDLg0KPiA+IEhvdyB0byByZWFkIGl0IGRpZmZlcmVudGx5Pw0KPiBZb3Ugc2FpZDoi
TGluZ3NoYW4gd2FudGVkIHRvIHRha2UgdGhpcyBURElTUCBleHRlbnNpb24gaW4gZnV0dXJlLiIN
Cj4gDQpCYXNlZCBvbiBhYm92ZSB0d28gY29tbWVudHMgZnJvbSB5b3UgdGhpcyBpcyB3aGF0IEkg
dW5kZXJzdGFuZC4NCj4gSG93IGRvIHlvdSBjb25jbHVkZSB0aGlzIHN0YXRlbWVudD8gRGlkIEkg
ZXZlciBzYWlkIEkgd2FudCB0byB0YWtlIFRESVNQDQo+IGV4dGVuc2lvbiBpbiBmdXR1cmU/DQpD
QyBhbmQgVERJU1AgZ29lcyBoYW5kIGluIGhhbmQuDQoNClNvIHlvdSB3YW50IHRvIGNvbnNpZGVy
IFRESVNQIGV4dGVuc2lvbiBub3cgKGFuZCBub3QgaW4gZnV0dXJlKT8NCg==

