Return-Path: <virtio-dev-return-13898-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F471CD4949
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:03:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E7B0A7C0C7
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:03:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA427986689
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:03:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CDC5A983D6F; Thu, 21 Sep 2023 04:03:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C057C98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsBlSmBrl9oK05tJkGbos+x3BAF49fw9/ugFTWvxT9WBW9E6Q+mdFvqDinnojYgM4D99SG2Bw2JHgPkRY8M4BRdY2N2xW8W4dHpeCsdR6uMfhluyrHsqB2iyu//kfdUSymP9ku0d0wXX6RlDwwfqd3ZvSrx8/f/7al3zmJXJroBZGCzSUOLM6uNdImq6P57ZZLWKstS6/HqwgZ2fewOjgvDtb4G/8I7z15mHHSi569mhPPmQfAnL04q7N31gB0LsPpeduX4+sjUZCWViRV7eL56I0ovRV49adVeZJK8T8x/C3ZykUp6v2Mt14wdHojXDbgbHLqFZ03ZRMNkpz5Qwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR+Wr83xO/HUAFX8WHiW4skA8T7QQsfCb3/PEi9ub6w=;
 b=FgSvDLSi/bd7ywNEsfFNIPy0JLvIa9e0b2ucT3NEcLJqOQuYWy7qeOVPn0kV/Cw3mNpiACSE8Nlso8VXexWzFC/0R0Veb38dX9RmMhUKtEDMovzBf2vNORdORoOeMgVVtwTamifUyGT/OmzrFhdCYVLH5DXI4rzuXZXaiP9KuqcjIkowa6YVr/9j9x6N6JtcdcP4U1A+NcMlasHoVKeJN3Fk751KmgFg0+9qjzvg6Q2Oy9Tng4OpH8yqHj+kKLgWy2BTFr+U0edgAQHpCR7zpT0x6Xfhtt50RZa3uwZPwxeT8TKetGIYt/5z2MokGE+EoKvMX+taSZit/dOrjWeS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAA/wWAgAAMVDA=
Date: Thu, 21 Sep 2023 04:03:22 +0000
Message-ID:
 <PH0PR12MB548152EF966D8C740A2A5542DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
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
 <CACGkMEsVtZ19KQt5QmHZV_AbGdoTf0fOx-QQHLeNv6UoMBWJnQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEsVtZ19KQt5QmHZV_AbGdoTf0fOx-QQHLeNv6UoMBWJnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7620:EE_
x-ms-office365-filtering-correlation-id: fbbed91d-64f7-4303-d5dc-08dbba57b275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cdPBE1jCqDgeedCGJatBad3B8ff4yko1vGV5ZYLoBCmlck9qy+NY/Owf0sznte5rnW1bZ1zrlcl1c1/vMdf8mGdNea7MteYH/X6WWVQpnFqBy2O2wc6eFvEuL6pU4G3VXr4UJIL0NpEQo3hp8eOmot9btFYfz+lJ0ETDriuOAfCDUHKOf/8tT6PZmrIilzcPkW+5UQAP0Lwr7plr7Xg2XOvqILxMVmfXH01ZSUY1GN7O108obC5eTRQ+a8Ie2Ix7YkoXny2f5i3br2M6vKHfMN9zu/Kjr8YwhuPSrTivhzvpT3pcBwag6clOdtHWtWQOn/YVa/N3z5jSeDNXGbf8itGUBs6bhgkdulTXDCqtV05IYIHAttv7Zt6fIN7mGm0dyJHnmbNye4SaLP2ALL6gQbKM6nZzNfVD7ZEerLicYGKKsQY+f//XVTNTY71qHB0NBhpcFV8RYzXWYtVk1mzBqpxWlRfrdeQx0Z8Ezrx7J65OobNOPVXpmPWyJrUzMFbl3eNj8RNggdazYR9yj3XITDTvShx6oyw+7PqGf4A5HzRhyoclaOeVMlnLu2e+jJbaEBihsn0p9HH6i2+jb1A1o1Zqe5UbLiw1jvQILE58bp/6DRk09vJ90AaEH1k7+06E4GbG2KvBSoSXApNzkLQxNbfah48rCslq93oMsWa375U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(186009)(1800799009)(451199024)(7696005)(6506007)(55236004)(55016003)(33656002)(38070700005)(38100700002)(86362001)(122000001)(4744005)(52536014)(2906002)(71200400001)(478600001)(4326008)(26005)(9686003)(5660300002)(966005)(8936002)(41300700001)(110136005)(76116006)(316002)(66556008)(8676002)(66476007)(64756008)(66446008)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkdyVHpQYkxOZjV3SHNQMnpacVFSUmVIdWc5SE5SUGpUTnBtUlNUYm12NFR2?=
 =?utf-8?B?WCtWTld1dUZuZ0J3U3Fid3IwMGFaa2N4ZFU2Z0dxR3lGZ1k3NlVoSzI0blhi?=
 =?utf-8?B?ZmRZbGRBVGthWjZMUW9JNFdMSERscDBJc29Dc2t4Q3Ardlp5QlpSREJmazlo?=
 =?utf-8?B?ckF5WnFhNkhMaDFMMm1Uc21HR1FxenB5cUlyb3ZtcEdrRGwyL2lTQmhQTUNZ?=
 =?utf-8?B?ZEozQzVXQlNRK21VM1RJd0VicldoTEpaaSsya3lDWG5wSW1pcjBpL29rakJn?=
 =?utf-8?B?bDJlbkVHQk00bEVEd1V5UjlSc3lSU2hnT3FxV2xkajJPYkkzQlZYZm5nSEUr?=
 =?utf-8?B?cVNJeFhWSDI0akx2YnFqeWpWWXQ2Z1dhbnFodkJHMGg1d1NNSnlMbVJMMGhv?=
 =?utf-8?B?VDZyMFc1L0I4WTdMMjMzb1lIY3FJQlNsRVoydG5rTFFiazRwS1VNbTZ1N2pP?=
 =?utf-8?B?TEZHc3dMaEFDelNwbzBWd0tpeFdyWWlUM2hERG5KRlZjWUNENERDc1Q0MnZF?=
 =?utf-8?B?d1lralN0M2J3ZHh4aTlOTy9tOTlFNU9ubC9raEdSSWJUNlBPSUdvRWoyYnBx?=
 =?utf-8?B?WWtwSmJWaTRtUGpsdEhnbU5XZUdHd1p2Tm5NbDdNYmM1UDlCaHFWcWZhV0po?=
 =?utf-8?B?SmJ5bW1zbzlCb0l4WUZJTmY2b3Z6SW9YaXNVUXBobitOZUJXbU1LK2pIanFa?=
 =?utf-8?B?MVM3d1pOaW0zMkZCK2tQdnQ1ZHUrZjNZV2NuZTg4Z3dvd1BFSTVuV0JsU2ty?=
 =?utf-8?B?cm1kRmhhNHhtbEkzWWNLTFNMbFRTVVY0NFFiU1dzclR4bkJYNjFWR01KbVRU?=
 =?utf-8?B?Q1d0b0xhc0UyNHdMU3RkSFlyM3NTeE9xUmJwK2xDSjdsdWlRL2t4OGtsSnlp?=
 =?utf-8?B?bHZmdk55TjljR2luL1Q2dEhpTTNQVkhqMHVhdVgySytwMFkwV1NGWncxN3Fq?=
 =?utf-8?B?MzhOdXcwQUhQK3FDWEpXYjVHTExGclF6UGRxWHR4TUI5RjBGVDYzdzROL1ky?=
 =?utf-8?B?Y2JINmRpRU94ZS96SWFaZlMxSklmK3NyNGgrNHB5aDUyWVpkSTAvL1czNkZD?=
 =?utf-8?B?bC9FSmQ1SzU4NzkvTzI1cTNMZk40SFRZVGJZRENPa3ZjcmY5YW9BUGNmc2o3?=
 =?utf-8?B?NksvT0pFSDdSQlYxdXZwNmVVekVoS2ZrVmxtVGpHRG44MUZFY1dFY1JjMTJI?=
 =?utf-8?B?cGxGK3oxT3ZVZzdIbUZFMG1Jc01iRkQ3b0syT0lCa1I3cnZiU3ovOHFENXBQ?=
 =?utf-8?B?UStRQUdFTWg4RHE5VmNyekJPVi85WTRmbWkyQU9MLzh4dU9nT29jQmdqZlpx?=
 =?utf-8?B?STl2SGhkT2p1NE40bGlWUXBRWXJSNDNmMHI3Q3dzRno0V2tIcXZqTHpQcEd4?=
 =?utf-8?B?ZnRvVGtNeW01a3ZsSEh2UmRsN0JPQWJnZkNSYU5MWGY4RWIxcWZKQVBzNTBu?=
 =?utf-8?B?bXBPeE1STE0rRHUrRkllbnluNWJxYWxBOUtHYnBzaUpiS0RveklNQldhR3ho?=
 =?utf-8?B?Vm9nL0pOdCtEaE0xZitYeEtKcmhvdEgySisxa0FEZW5hY2FKYkEyU1QyWld2?=
 =?utf-8?B?QUpVcys5RXZtWjVzUGk3NXY3Z1pEY1NWRFdiN3h6L3haQjBiT0FkV3U0blFT?=
 =?utf-8?B?NDg2MFhWTHcrb0JmUEY2UkR4SzlOWFR1TkZjSVpuR3k4Um5vTXlyVWhLU25X?=
 =?utf-8?B?cFJlZ3g1aHNsSUMwNlBxaW9CekxGU25OcDVvS1UwaklzN1Q5S0JDMmE2SXUv?=
 =?utf-8?B?LzMyZXl0bElRbTdURHhZcm9veDZVRUtGSkNtODl5cDNKbHgra3orMlhFSVNN?=
 =?utf-8?B?L2RLdFRPc2V2MXdLM2ZmTlBJYmpGb1dGUGNPc2tRVXF0UXU2MmtVZ3hPaUts?=
 =?utf-8?B?YUk0MG84REpwelByU09SNFRYSFhGRC8wMXNUb2VESjBlaXBLREtxWTdYWXpz?=
 =?utf-8?B?UzdWUVovOWhBQzdYNlh5SUlNNWRjd1RxOFYvK2svNUNjNEJiS09vcjdXVWJk?=
 =?utf-8?B?Yiswc2ljbUgveFVQMDkyb0R4SDhJUVEvbVNJclI3UURhV3d6blFUK0IxdDEy?=
 =?utf-8?B?TGdFTHZ0blp6amZjSE9YTVkzMy9jN045MldBd2FmTjVTdTlOV3ZaQkljcExy?=
 =?utf-8?Q?E3BM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbed91d-64f7-4303-d5dc-08dbba57b275
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:03:22.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCFVk6OhE8BWvcAP6oBmQjnawsfZJXywseQ4fjtADEnHDtvBTef7vWMhvZRnb1yLxwGAstccu9dHbOfSFeua0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA4OjQ4IEFNDQoNCg0KPiBJJ20gZmluZS4gQnV0IFRE
SVNQIGlzIHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlIGNvbnNpZGVyZWQuIFRoZSBlYXJsaWVy
IHdlDQo+IHJlYWxpemUgdGhlIHBvc3NpYmxlIGlzc3VlIHRoZSBiZXR0ZXIuDQoNClsxXSBoYXMg
Y29uc2lkZXJlZCB0aGlzIGluIHRoZSBkZXNpZ24uDQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy92aXJ0aW8tY29tbWVudC8yMDIzMDkwOTE0MjkxMS41MjQ0MDctNy1wYXJhdkBudmlkaWEu
Y29tL1QvI21kOWZjZmExYmE5OTc0NjNkZThjN2ZiOGM2ZDE3ODZiMjI0YjBiZWFkDQo=

