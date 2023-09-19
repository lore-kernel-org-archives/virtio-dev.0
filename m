Return-Path: <virtio-dev-return-13817-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02476CD5483
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D3001FF99
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6821A98655A
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58459986503; Tue, 19 Sep 2023 07:33:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FECD98670B;
	Tue, 19 Sep 2023 07:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA38C+fO0Sik/CuwyFjC8qdU/XP2fLivKu14iLwzHgAngaMcPowXddEgTYxJ9AnpkbXW06HciopBjehQc+ywlQ2YuTAXG9ByT6GvzFWTVL4/CpiPLKMHju641PApeMJ6Y/SFNunNCwsB99mvPsOM9rk20U1Tm08ggOm51WAWJoMXIYARKwQLZWkWRPMs5a4hkj/lBN5e6jgoGUHZip37B5qEbB2LitmR/7VogbXa8UwbZ0gd20NbOrRjh6NzNN5PRsRD22mTXHl0wMPhm1WpXOzgFnWIOQ0w4f2pE+JxPlGmRxfOcTgIU2rbSP9pL2uKG65BwpODwnwJlmcSFXeo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSmGHXGySRDfakq+7ZQiLNWXeEpowKgB3m4DsXKsF6E=;
 b=JzKKb8gvKPw05JYATYF9gPbHzE0lJoT33dBDXs89y/wqQYxmjT5/UEUi8U/+5gRmFUhR/pTVBNaxAl9FV8uDFUwYesvSNDOoRtCar1fn42kq090yLpH+RGmdigT/kW+4pa2DtKkcOlkuycSSxfiunf/Sq6EZrbblpUaDU8MRj7TKPTsSq/ujM6tlc16KYv0wjTbL8ag1I4awSG4q//f8rPUe97otApiA2t8WAveUzDMIG7Dc6rdMv2XZrZIZFGPeiHPeNq6q9dFSf5gEV9TJAKL5xrTOiOUhEqNWqbBpF3GmkGUoZe0JXEqmPGKhqGR1C3UvhWQ4TANklAOoh7Hwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bCAAAyxAIABDe5ggAAckgCAAAKaYIAAAoSAgAAEYtCAAXpnAIAE27zwgAMXBoCAACYQoA==
Date: Tue, 19 Sep 2023 07:32:59 +0000
Message-ID:
 <PH0PR12MB54811177D26365E420404115DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
 <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com>
 <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9d9ac82e-8eb9-558e-916a-c327e3c3a996@intel.com>
 <PH0PR12MB54814FAE1D790492C8D660E9DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvo1cc7jnPT1ia8=+eOcgHaOhr77ey4p+_qLwq+cCE2vw@mail.gmail.com>
 <PH0PR12MB5481F53C9B2FFD5FF5BD4E4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvsLnff7shd5RS8zuRQ0rbt+HHhUBDpviQ_=JiKP1mXVQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEvsLnff7shd5RS8zuRQ0rbt+HHhUBDpviQ_=JiKP1mXVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6709:EE_
x-ms-office365-filtering-correlation-id: 0fa77144-0a12-406d-98f3-08dbb8e2a68b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vkU82mX22/+x+wDiEo4QOafwvtt1Xjkz/WxiwqegyJ7SZvW+E1AC1hWdcbWATnH6lT+MdNrBzjvb4Jj9D+BCQj5YTmcMrc0692nm4d5t64/G0nasjfawVjdRuMPHHcvmzPXqhT0kqJOFWwVBCAeVzHVqHIJmwvHoygY0DpxPG0ZvZEdgRE4m96kQvzzDrnSzAvAl7mm5qQYD2rllywz6JM9DawCleE2ZG/2tS7xQZ22L9VAnMrVTBTI3rGIxKED3YGjzASdbeEREzC8ip2caFpmQDHOiP6r87js/o29hcHN78LGH8RUt+P0rvvVSs5OYcNz5ykHC1hKukgpa3theEzzAS9ljHjCQyI548e2v6xkBzRdkhgkK/AezzQmkqqHPKYxInNJm0OzspXmZ07nn3yObdE6NSeqr09Mk5BR4iTObi1IBbaPqpflo/TqBi67+JSSghAKFmpG5d0Br7FRssbmOQesv28z1VvnRkeFPCbmL7wJJfSw5JiFIR/CWvIrDSlZ384ua3iRzTrQgvVEM8uD4Zk8me6RnmJ+RmcfC93civi8WxuXyqPk5Hhwb/w0n9wWoYoWkuHEdHimp+ciT1Hh92Yt0Cvxe5oxQnfrfKXWh4B0p1S5aBjsXryWxQC/E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199024)(1800799009)(186009)(38100700002)(122000001)(86362001)(55016003)(38070700005)(33656002)(2906002)(55236004)(7696005)(53546011)(478600001)(6506007)(52536014)(66446008)(8936002)(66476007)(54906003)(76116006)(66946007)(4326008)(66556008)(8676002)(64756008)(83380400001)(9686003)(5660300002)(41300700001)(316002)(6916009)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGRZWDdBcjZyNFczRFpYS3pWYWFUb1RjUkV4TjVrbUFMK05kMUhqZjc1empV?=
 =?utf-8?B?bCtHUXhPbkN4T0E4QlNYci9HTU5UNFo3TXByd1pUTzhyTEZZOVNsK2o5Wmdy?=
 =?utf-8?B?TENnMXh5VlV1N2l4WHoya3YxV2xSbDJPNENVcEZNczVNeU8vV3hRTFpzeUtV?=
 =?utf-8?B?dXlOQWJXS0ZlR0psN2Z3NWxIOHo0UGtRdDVrcmpTY21pS0FyK0JXRnFyWmdT?=
 =?utf-8?B?cVMrZERqNkhZVzRDQXQyYmRiVm96Z2gwUG8zRXB3ZTZ5QlF1T0l2OTBkcVZF?=
 =?utf-8?B?a21yR3NMaVltaVpIUERzMnUxUTVWTU9nYlpHV2JlUHZ5M3FrbUJBc2c2Ylc5?=
 =?utf-8?B?RktvMk1ibUp2UElzQ0xkMVZXVVlyWG1KcFBtZ1ZqVTZTUzBPaWdQMWNWdS8y?=
 =?utf-8?B?TG5BQ0Z5OHdmdCtFbklxS3BITHZVVUxkd0labDRLUm56WnBCeGlzNng0eVNG?=
 =?utf-8?B?Ni9QTXJNK2Vuc2ZucnN3VVp3WHVDNzdVdTBSZ3ZJRzRsSXE5bjZ1UUFGUzFN?=
 =?utf-8?B?ZU5zSHZZSjZMMVRSRlQrTnMxOXVjSDlmdnNzUDAvS0ZGeVlLMm9hRnlXUlk0?=
 =?utf-8?B?engwenBqOVoyTnNRSGsrNC9NZ2V0dHlPc0dkZW5UK3JKZlR4cHBkaHUwSlMv?=
 =?utf-8?B?QTh5ZEpzcEFaVFBCcGZKY2NpNTQ1YXpKcGtwbm9aZFNJbU9HN0RPNXQyUXVK?=
 =?utf-8?B?WXdocERSRE5yTjRyVm9Yb3FBRFptWVVaYW9rZXZFeGt5c2ZnT0ViRlBIdk1x?=
 =?utf-8?B?Vk42RHZDQXhDVGYyMDZWYmgwWUN5dlFjOXVVZGlUdy9XVFduQzM3QVlCLzRO?=
 =?utf-8?B?V3hFOU9iWEIrYTM0MzVFK0dsTEZHQVJQUjh5R05wd2pWdDhoSExxaGI2V2JM?=
 =?utf-8?B?U1haUGxSV2ttTVFpYTVMWjlkdXFvaThHaHdTQXJ3bDcrSlpKbm5uMytFQzBw?=
 =?utf-8?B?WXQ0Tk5ndFBkRU5xSnJkNm0yNlFYNkFMZnhuOWZSdTNXL2RFdmh3dVI1N29h?=
 =?utf-8?B?V0xqamlMKzBsSG9DVjE4SnRqRFc3Zjkya3R0M2tlbTlnb0VLcTJBeGJ6dkkw?=
 =?utf-8?B?YTdMeDBGeTFXSG13eVEwUEhwbUx2TG9mVWN3cnBtc0kraGl3R2hCZ3pzSCtJ?=
 =?utf-8?B?K1NwQ3E2MThXcENmMWQxdXFKNjBvMXVpeVB5ZVNndVkwdVBRbm0zQXM5L0dq?=
 =?utf-8?B?L25LYTU2NmgxV3hJMktXSmMrSUk2czNGcVpsQXkwa08xNTlROWFTOXUyYzNw?=
 =?utf-8?B?VVhGZHZtYkkzNXByd1Y3R3hFM1Zaa2YrUzJPZzBDSVpqeXFBWlhQeUpWTjJj?=
 =?utf-8?B?ekNtNENJcnhveXNJak9TMDg3VElUNEtrYkUvU3ozMTY0dko5OU9aOWZENGpG?=
 =?utf-8?B?L3BmR2IxdEd0NFNMbFJ4MFpWS3VtK29ZKzllSmJHSzhhRFdLUXZZQmorbm1j?=
 =?utf-8?B?aDFwZW94Qm8ybXM3cEg3eEl6K1JHVDNCQXd3UkxXdjRsRmZCdmJPb3ZRRWZu?=
 =?utf-8?B?QUw0WWwyOHdVWU5UaTdEMWJFY0R6Z2h1NmkzbzQxOHdUYi95dldva1p1cURz?=
 =?utf-8?B?QkdmUVpoZWZ0QWgzL01aaGUzMllKTmtuR0lPeXgvWE1MSlA0cHZPSkhhQWtr?=
 =?utf-8?B?Y296Q1FrVk5CL3BqZzRTSWRNTElRY1JWUTN3VmhVYURkUHZQamxsUUVTWjV0?=
 =?utf-8?B?Q21JVFBMWWZZR2xCTmlaRzlwYTNmeEFQY0NFd0xLcFNrNlFjODNHNzlRb2ZX?=
 =?utf-8?B?aFZQWXF3VW9BNkliZXpHbXdkNXlpdHBoVHRNK0hhcXlKYUdUQTJiZEhpYWYz?=
 =?utf-8?B?cDVlVWJzZzRacy9DN0ZHdkFmUFo1Mk1lWStwSW9DVHYzT3B6dGlHbFhIcXQr?=
 =?utf-8?B?a015MlZJNHlBK0tLSVY2ODJhQzFzYUJhZEFQanMrMWVhQlprSGJBYjFBQy9u?=
 =?utf-8?B?TWNJQTN2ZWpCM1crNVN4TS85YUVuamdSRGR1M2MxYmNKYWk3RG0zczQ1K3pY?=
 =?utf-8?B?NWVwTVZ5Nm5iVWJQVnlhazA5aDV6eGw1TnQ4TkdOa0R0NllyaE1YbmFDVEFO?=
 =?utf-8?B?RHRZTWlITWtxcFEvQzZMKzNwVk9KM2l5UyszOTBsL1dIbUNaOUhwU2FIK3I2?=
 =?utf-8?Q?a6Bc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa77144-0a12-406d-98f3-08dbb8e2a68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:32:59.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNlj+KAkwkn06q5ZunuzcWnVx+x9qqY00DVW7NwcEfttJG/i3HvRUHOSKAjvd+TVxGKGlGymm1j6n+RxWna9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAxOSwgMjAyMyAxMDowNCBBTQ0KPiANCj4gT24gU3VuLCBTZXAgMTcsIDIw
MjMgYXQgMToyNeKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4g
PiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjMgODo0MSBBTQ0KPiA+ID4NCj4g
PiA+IE9uIFdlZCwgU2VwIDEzLCAyMDIzIGF0IDEyOjM34oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJh
dkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gPiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+ID4g
PiA+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDk6NTEgQU0NCj4gPiA+ID4N
Cj4gPiA+ID4gPiB3ZSBwbGFuIHRvIGltcGxlbWVudCBhIHNlbGYtY29udGFpbiBzb2x1dGlvbg0K
PiA+ID4gPiBNYWtlIHN1cmUgdGhhdCB3b3JrcyB3aXRoIGRldmljZSByZXNldCBhbmQgRkxSLg0K
PiA+ID4NCj4gPiA+IFdlIGRvbid0IG5lZWQgdG8gZG8gdGhhdC4gSXQncyBvdXQgb2YgdGhlIHNw
ZWMuDQo+ID4gPg0KPiA+IEl0IGlzIG5vdC4gRm9yIHRoZSBQQ0kgbWVtYmVyIGRldmljZSwgaXQg
bmVlZHMgdG8gd29yayByZWxpYWJseS4NCj4gDQo+IFdlIG5ldmVyIG1lbnRpb25lZCBGTFIgaW4g
dGhlIFBDSSB0cmFuc3BvcnQgbGF5ZXIgYmVmb3JlIGFuZCB2ZW5kb3JzIGhhdmUNCj4gcHJvZHVj
ZWQgdG9ucyBvZiBoYXJkd2FyZSBQQ0kgZGV2aWNlcyBmb3Igc2V2ZXJhbCB5ZWFycy4NCkl0IGlz
IG5vdCBtZW50aW9uZWQgbGlrZSBtYW55IG90aGVyIFBDSSB0aGluZ3MgYmVjYXVzZSBpdHMgbmF0
aXZlLg0KV2hhdCBJIHdhcyBzYXlpbmcgaXMgdGhhdCBpZiB5b3UgYXJlIGNsYWltaW5nIHRoYXQg
c3VzcGVuZCwgcmVzdW1lIGV0YyBhbGwgYXJlIHNvbWUgYmFzaWMgZmFjaWxpdGllcyB0aGF0IGNh
biB3b3JrIHdpdGggcGFzc3Rocm91Z2ggYWxzbywgcGxlYXNlIHNob3cgaG93IGl0IHdvcmtzIHdp
dGggRkxSIGluIHBsYWNlLg0KDQo+IA0KPiBJZiBpdCdzIGltcG9ydGFudCwgcGxlYXNlIGRlc2Ny
aWJlIGl0IGluIGRldGFpbCBpbiB5b3VyIHNlcmllcyBidXQgaXQgZG9lc24ndC4NCj4gDQpJdCBp
cyBtZW50aW9uZWQuIFBsZWFzZSByZXZpZXcgdGhlcmUuDQoNCj4gPiBOb3QgZG9pbmcgbWVhbnMg
aXQgcmVsaWVzIG9uIHRoZSB0cmFwK2VtdWxhdGlvbiwgaGVuY2UgaXQganVzdCBjYW5ub3QNCj4g
Y29tcGxldGUuDQo+ID4gQW5kIGl0IGlzIG9rIHRvIG1lLg0KPiA+IEkganVzdCB3b250IGNsYWlt
IHRoYXQgdHJhcCtlbXVsYXRpb24gaXMgX2NvbXBsZXRlXyBtZXRob2QuDQo+ID4NCj4gPiA+ID4g
QW5kIGlmIG5vdCwgZXhwbGFpbiB0aGF0IGl0IGlzIGZvciBtZWRpYXRpb24gbW9kZSByZWxhdGVk
IHRyaWNrcy4NCj4gPiA+DQo+ID4gPiBJdCdzIG5vdCB0aGUgdHJpY2tzIGFuZCBhZ2FpbiwgaXQn
cyBub3QgbWVkaWF0aW9uIGJ1dCB0cmFwIGFuZA0KPiA+ID4gZW11bGF0aW9uLiBJdCdzIHRoZSBm
dW5kYW1lbnRhbCBtZXRob2RvbG9neSB1c2VkIGluIHZpcnR1YWxpemF0aW9uLCBzbyBkb2VzDQo+
IHRoZSB2aXJ0aW8gc3BlYy4NCj4gPg0KPiA+IE5vdCB0aGUgdmlydG8gc3BlYyBvZiAyMDIzIGFu
ZCBtb3JlIGZvciBuZXcgZmVhdHVyZXMuDQo+ID4gVGhlIGJhc2UgZm9yIHZpcnRpbyBzcGVjIDEu
eCB3YXMgMC45LjUsIGJ1dCBub3QgdGhlIFFFTVUgb3Igb3RoZXIgbWVkaWF0aW9uDQo+IGJhc2Vk
IHNvZnR3YXJlIEFGQUlLLg0KPiANCj4gQXJlIHlvdSBzYXlpbmcgdGhvc2UgbmV3IGZlYXR1cmVz
IHdpbGwgbm90IGJlIHN1aXRhYmxlIGZvciBzb2Z0d2FyZSBkZXZpY2VzPyBJZg0KPiB5ZXMsIHBs
ZWFzZSBleHBsYWluIHdoeS4NCj4gDQo+IE9yIGFyZSB5b3Ugc2F5aW5nIHRoZSB2aXJ0aW8gc3Bl
YyBpcyBub3QgY2FwYWJsZSBmb3IgaGFyZHdhcmUgZGV2aWNlcz8NCg0KTm8sIHlvdSB3ZXJlIGhp
bnRpbmcgdGhhdCB0cmFwK2VtdWxhdGlvbiBpcyB0aGUgZnVuZGFtZW50YWwgdGVjaG5vbG9neSBv
ZiB2aXJ0dWFsaXphdGlvbiBhbmQgdmlydGlvIHNwZWMuDQoNCkFuZCBJIHJlcGxpZWQgdGhhdCBm
b3IgdmlydGlvIHNwZWMgMS54IG9ubHkgYmFzZSBsaW5lIHdhcyBzcGVjIDAuOS41LCB0cmFwK2Vt
dWxhdGlvbiB3YXMgbm90IHRoZSBiYXNlIGxpbmUgd2hlbiAxLnggc3BlYyBpcyBkcmFmdGVkLg0K
DQpWaXJ0aW8gc3BlYyB3aXRoIGZldyBjYXZlYXRzIGlzIGNhcGFibGUgb2YgaHcgYW5kIG5ldyBz
dywgYW5kIGl0IG5lZWRzIHRvIGNvbnRpbnVlIHRvIGJ1aWxkIG5ldyBmZWF0dXJlcyB0aGF0IGNh
biB3b3JrIHdpdGhvdXQgdHJhcCtlbXVsYXRpb24gbW9kZS4NCg==

