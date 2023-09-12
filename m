Return-Path: <virtio-dev-return-13695-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B24ECA0ED3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7AC887B0B2
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0011E9866E1
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:50:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5283598648C; Tue, 12 Sep 2023 06:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57D65986485;
	Tue, 12 Sep 2023 06:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifA/FQSWHgATaWMfKKt4PQOYk1UgMj9StoK1EOiJV7glovLdkRVml0Bxlp0UgQ6Tee/3//MAJINnGoYmEr816LjS4UMGMDlrUODt5whiAsJHE7D/BcL4N/srf4ssiVECbwv/hIqWly6vIwFUAEiBeAgXFTBpINhy8l96i90eP1+QV1LRsf7hhVkWS3/txbcADl/Ycvxn8L+6EDxw5GQmVIe7skvlg5Q48FA51i34TRNly3RwbHF+g5P+VUmxulN8VN3Ypwh+URHxXWMo3cXYLpcfZIhxcEKczEYSbzjA8nk4ZogUCbj5AsIqJFYaHZ0n6HvqDMaE9DfyhciO13Fgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiqbtjqtowaduvRo2zsxStnE6TkMxvnUtdlFsGo77aY=;
 b=Zupsi08oKQo0VQrTN3HSTOGg9PtnZ4zzmW1eQW4xt6WovbRLTvJHn9EzmG1znz5ImgWFEnU0xZ1F/yEpJYsyFAYi1QrMD6/nvT5zUmy7JIs3NWLFODK4lwvj4Xvf2nz0bCelJqbvb/D/FfnV1cbOh5qZ74NqPZ8cDnA78p90hTUFJmIQM0SIeqAIjlBjrTgcvIeeLGl0XGBYxv4veVR/cd7PC8Nca6qJMagvksTTqwXAMUGuzcSdlO5UsP7xslM50kqeafAkzHNyyXS/yJIEsePOcA1NthH1ZBXmvpsM88uQuwV2uiHRYboizcx0ibZaDe6T9wasCAKpUowRChV5ag==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcA==
Date: Tue, 12 Sep 2023 06:49:51 +0000
Message-ID:
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
In-Reply-To: <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4434:EE_
x-ms-office365-filtering-correlation-id: e3dcc4a2-ba4c-4493-6532-08dbb35c76fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WDtka5hRkp88Xluv2zHPuxIj+MYho0KtVZ86JEVAaPgR43gHLkZ9v588yx1nbtKqoSTavBnLL4+n22cmgs8t2MWLsoMs3lHE19EmT0y0f40G8JL3MAXGneejQxUPZdz34aCeMLyw97AfQNAp0ffI0cizAMTFQfFO+pZdkOKaQpgue4NDxRLtdcQGa3ZBHs4cv8+9Z/qsSB2FuXJxvwrZCm/hkD+2/EzRIG15EPA5lEneaNqmifY7V+Xe4K8S3S1WMsw1wTyfnYTKQ6uPJ314xGLzr77uwuwLFF14xjUSMjKtLYA6JDedLllQKAccxAtCVtbPSB5w6oApZvk38wUCx4Dl2qmAw+pJ4vd+Lxa0fWFfm7BNQHJPPn25vk/6hbjLsfRHxaIGbdfcLyLbm1mQGuaQNXhuRDn5INCvbZckk6FnBw0bM32nn8E0D3mzN02lCLs01DeuVYuK1dMcl56FyjxHbJ5N+/AEXJXi7+WQYvA0kdW0E6vwNGaz7bRj+X1+XyvRRqMhLNVM/2S/KdJjjeyE39d0WzXHmsNJl2VNWXfJvotLj/qwFil4MBFntixXtVBPmtst3wSLIiFsgDAIVjs2xREZC48CRAiuQKJsyglDE8sSlDyRn4262Vurt35xwLlsP7JTrLOXYTG+Cw97aiyKQLmmC4yEzSjbNjrcRjg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(186009)(1800799009)(451199024)(26005)(38070700005)(38100700002)(966005)(122000001)(478600001)(9686003)(6506007)(71200400001)(7696005)(53546011)(41300700001)(110136005)(316002)(66556008)(66946007)(66446008)(64756008)(54906003)(76116006)(66476007)(83380400001)(33656002)(52536014)(5660300002)(4326008)(8936002)(8676002)(2906002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkNlU1NCQnFrSFdsYS96NTQrVGEvbzNnTmtCaXJZLzQxcTFvNmlYKzFJdjJr?=
 =?utf-8?B?SzFkckdzYkJIajlxbGJsQk9oVGhOelZkaTJBLzhDcGdoOXlHV0lJd3Z0MjN5?=
 =?utf-8?B?OVZvVXE2YVN2Yjc0N3pMeVZwbGROZkRHSnB5S0lCTjl0OGFWa1QweDJOK21X?=
 =?utf-8?B?b2hjRVdGcFhaY3VscWJaRFZQT2lObTljaFBSRlhlV1F4UHY2RlcrSHJqZGlj?=
 =?utf-8?B?OC9JTXdpV0RXOUQxNlpwVnBXQVFFNHFjSmt3NXZLaFM1eU8wSnFNNzNoaUVE?=
 =?utf-8?B?MEpMSkorb0RkL09MRmEzMmZoY3ppVkRXQXdzSHVtS0pRS2oydFlmU2Y0V3E1?=
 =?utf-8?B?RE82SFg1MHhYT2UvWDNsM2lsaWNQZ1ZzOVRlaHdnbklBSG9kY25DaHN0NkJJ?=
 =?utf-8?B?aTJsSzJYQzZ6Nml3d1ZwQXozdzVMRGF5REQ1VlBqVnJFeER6bWd2c2RPcDVK?=
 =?utf-8?B?Z3ZJRDBzR3FJcEUwam1Ncm9ReDFaNEZpczlybzFaeUJwa3RxdHR0blJLZ0dX?=
 =?utf-8?B?RWJ1V1psQVUvbHdTOXFBL1ltOTBQTnlxeU5VaTlHR25OODgxb0hzb0dqQXRq?=
 =?utf-8?B?c0RSWE05VjZTQitIU2lyQkVOSjdDVmxQajlJOUpPZ0NvZ2NiMUlGMGZBSk1y?=
 =?utf-8?B?NDl1R3l6ZFdNdlRSTWNhcXg5bjJGY0ppYUsvTVp5SUx0Q3g3Yk9NUzdvbUlG?=
 =?utf-8?B?Zzh1S3ZHR1FUWmNZTzRGOFlZMjFBdWZXc2g2SFBKc3VqdDB6VzU3K29PQkNo?=
 =?utf-8?B?NzhmUmwzQWdYS1BFdGNBZHgwQ04vWXBmZ2ZUdnZDaVgxV2JxbTVxR09iT3hR?=
 =?utf-8?B?Z1dKc2cvZHpRL3JhY20wYWhGQXBGZTNJWmZQZTl4a1dBNU43VGIwejZIeGlq?=
 =?utf-8?B?ZmpmU0xqVWNPR0NNbkVTdCtPYldQemREbG5rc2Y3TkdBcDIzcE94UGpPS1N4?=
 =?utf-8?B?enZjck5qaUlDc3FSWVlWSVBPTVBRL0cyekgvYkJzMmpUMU10K0szMVoxVkl4?=
 =?utf-8?B?SDJlTDlNc2lHYzJOMytxZUdvTnk4aDBkaldVR29UNEJZSmR2WjhnTHJUdWto?=
 =?utf-8?B?VngyY0picThCL1g5N3BJY2VjWEF0cUl4QUZEVWxJWXhjL3dTMk9FK2hqSHdx?=
 =?utf-8?B?ZkV6YUx2OFpqUXNKdk1mb3ZQMVdhWnNQVFZ6MzFpakxJbXk2c2pVMDF6NUVU?=
 =?utf-8?B?UTF0OTZlMlVWbGsxRHhuMmo5OXIxUDc1ZmRtb2ZHQ04zUGMyV2FLREgzL3NP?=
 =?utf-8?B?YmJtL0g2Q3NZSm92U3BTNVZGMWpma0prTW9La1FtT3dacjBYZjg4OGFTd0gr?=
 =?utf-8?B?clBaaTVDekZONHJjdENNUmx2bmUzSWZMV3V5YzZMbEQzeHAwK0RlMVBvS3gx?=
 =?utf-8?B?aUk2djJJaU52SUl0UG8xUHlvNzFENU5mMW43bkI5NDlxZ1hvbis5eVNDYk1E?=
 =?utf-8?B?VGlhUngwQnkzM0ZPWWpaQnFycktJM2pPOHE4TE5hekZzcnBFc1EzU3dmbWNz?=
 =?utf-8?B?dG9UdVNZNXMyRllOMGViWEZ1UXFORFJoTzA4dThEV0xGN09BaDlMWVFNL0Fa?=
 =?utf-8?B?RUUvQWo0dDlnZm5haGVEL1Nwdzd0TldvVlBXUzRyVTNXeGp4VHFkYWNWV2lK?=
 =?utf-8?B?bnF5TW10Y0tOZUJDRi90YVl1U0xUd2tvMUMrdnVGeTU5b1hTN3VlaklQd1dv?=
 =?utf-8?B?VUZ1S2FhOFIyOFRyZWVYcHFtb0drWU9Nc1MyVW1CU1QzQXA4RTQvV0ZFczhL?=
 =?utf-8?B?S2g1eStQeUtMVjFaSnNtQlQrTVdpY093Y1FUaEpya3VROUlDYXBjZmZ4ZFdu?=
 =?utf-8?B?NjJmVTliUys0bW1iM2loTGwxbFRnRnZKTlpna0k3ZDZCc2p3cE5wVGVGdFor?=
 =?utf-8?B?VVRpZFlMbDEvREpuRFo0Y2Rwa3dLSUdMMGRwRWdmanU4UFJDdldIdkp3KzJG?=
 =?utf-8?B?cDUzNTRVWEh0aVVkc2s5Sks0OW14VkM3ZzVuRkJwcEZwOFQrQU9DdHBycXdO?=
 =?utf-8?B?U2xwQzkrL0NreG04TUl0cTd1TU5FUERWb1BSOW5sTEZrNlVZSTNLQUVQbjFo?=
 =?utf-8?B?eGRTd2xWTFZQeFpyZ3lwcjVEdTVSSjdFaGFqdzlnSjlJaURtZ3U4RnhuR3Vu?=
 =?utf-8?Q?t1sk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dcc4a2-ba4c-4493-6532-08dbb35c76fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:49:51.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mk7/s8StTj17/H1AGQ/0KbPfK+zCu6G9gNGKf9Tb1XuJlmmcw7pQnIoa4kDqrynD7zww4oVzNKz5ZTpuV7BEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAxMjowOCBQTQ0KPiANCj4gT24gOS8xMi8yMDIz
IDE6NTEgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEy
LCAyMDIzIDk6MTkgQU0NCj4gPj4NCj4gPj4gT24gOS8xMS8yMDIzIDc6NTAgUE0sIFBhcmF2IFBh
bmRpdCB3cm90ZToNCj4gPj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDExLCAyMDIzIDM6MDMgUE0g
QnkgdGhlIHdheSwgZG8geW91IHNlZQ0KPiA+Pj4+IGFueXRoaW5nIHdlIG5lZWQgdG8gaW1wcm92
ZSBpbiB0aGlzIHNlcmllcz8NCj4gPj4+IEFkbWluIGNvbW1hbmRzIGZvciBwYXNzdGhyb3VnaCBk
ZXZpY2VzIG9mIFsxXSBpcyBjb21wcmVoZW5zaXZlDQo+ID4+PiBwcm9wb3NhbA0KPiA+PiBjb3Zl
cmluZyBhbGwgdGhlIGFzcGVjdHMuDQo+ID4+PiBUbyBtZSBbMV0gaXMgc3VwZXJzZXQgd29yayB0
aGF0IGNvdmVycyBhbGwgbmVlZGVkIGZ1bmN0aW9uYWxpdHkgYW5kDQo+ID4+PiBkb3dudGltZQ0K
PiA+PiBhc3BlY3RzLg0KPiA+Pj4gSSBwbGFuIHRvIGltcHJvdmUgWzFdIHdpdGggdjEgdGhpcyB3
ZWVrIGJ5IGV4dGVuZGluZyBkZXZpY2UgY29udGV4dA0KPiA+Pj4gYW5kDQo+ID4+IGFkZHJlc3Np
bmcgb3RoZXIgcmV2aWV3IGNvbW1lbnRzLg0KPiA+Pj4gWzFdDQo+ID4+PiBodHRwczovL2xpc3Rz
Lm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwOS9tc2cwMDA2MQ0K
PiA+Pj4gLmgNCj4gPj4+IHRtbA0KPiA+PiBJIGFtIG5vdCBzdXJlLCB3ZSBoYXZlIGRpc2N1c3Nl
ZCBhIGxvdCBhYm91dCB0aGUgcG90ZW50aWFsIGlzc3VlcyBpbg0KPiA+PiB0aGUgdHJlYWRzLiBJ
IGd1ZXNzIHdlIHNob3VsZCByZXNvbHZlIHRoZW0gZmlyc3QuIEUuZy4sIG5lc3RlZCB1c2UgY2Fz
ZXMuDQo+ID4gWW91IGFyZSB1c2luZyBuZXN0aW5nIHVzZSBjYXNlIGFzIHRoZSBfb25seV8gdXNl
IGNhc2UgYW5kIGF0dGVtcHQgdG8gc3RlZXINCj4gdXNpbmcgdGhhdC4NCj4gPiBOb3QgcmlnaHQu
DQo+ID4NCj4gPiBJZiB5b3Ugd2FudCB0byBkaXNjdXNzLCB0aGVuIGxldHMgaGF2ZSBib3RoIHRo
ZSB1c2UgY2FzZXMsIGF0dGVtcHQgdG8gY29udmVyZ2UNCj4gYW5kIGlmIHdlIGNhbiBpdHMgcmVh
bGx5IGdvb2QuDQo+ID4gSWYgd2UgY2Fubm90LCBib3RoIHJlcXVpcmVtZW50cyBzaG91bGQgYmUg
aGFuZGxlZCBkaWZmZXJlbnRseS4NCj4gSXNuJ3QgbmVzdGVkIGEgY2xlYXIgdXNlIGNhc2UgdGhh
dCBzaG91bGQgYmUgc3VwcG9ydGVkPw0KDQpNb3N0IHVzZXJzIHdobyBjYXJlIGZvciBydW5uaW5n
IHJlYWwgYXBwbGljYXRpb25zIGFuZCByZWFsIHBlcmZvcm1hbmNlLCBoYXZlIG5vdCBhc2tlZCBm
b3IgbmVzdGluZy4NCkl0IGlzIG5vdCBtYW5kYXRvcnkgY2FzZTsgaXQgbWF5IGJlIHJlcXVpcmVk
IGZvciBzb21lIHVzZXJzLg0KSSBkb27igJl0IGtub3cgd2hvIG5lZWRzIE0gbGV2ZWwgbmVzdGlu
ZyBhbmQgaG93IGNwdSBhbHNvIHN1cHBvcnQgaXRzIGFjY2VsZXJhdGlvbiBldGMgdG8gcnVuIHNv
bWUgcmVhc29uYWJsZSB3b3JrbG9hZC4NCg==

