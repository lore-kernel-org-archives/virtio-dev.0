Return-Path: <virtio-dev-return-13942-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DC9CE7A81
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 10:41:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ECB2F2B13A
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 10:41:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFE8D9863D0
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 10:41:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B491B986379; Mon, 25 Sep 2023 10:41:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A27A798637A
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2023 10:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1ye555GKU8I+OKyzZF5sH7GDivJf1EhnESVRNlKuXzFBq0Td1Turgx61KlqA9uKWHDb43rkuCeP+ITsQzxinurlBjIuWhGCLhng6g0//QmTg5AQ7jGL7Nh9jQ2V+/dUA/tPp0XJFKF5iF8csiIIMKKK2+/Oz+v1S5DZK6b6MOmuP1ogocCelxpGZqWmOQo5r7jnbZkkwncuZWbFiesi39yMSl7XjLplTdo0yCNzyWaimh0lHvOXImnYuAtg+l6Ha45iIird/53clHA3h4FVcy16jVGs7CF5b9q/lGHjYP32QX5FttdURFVQE1m8lWicRmC/ud9DVzN18iQpzj1EBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z7SvmMxjv18YRNuhMF+b4AjVj8wzYEtaZe4ADgKs0U=;
 b=VnXHsVBYLpfBce5t8/TaW5ri5BafxEsr2ZEWMWxZLGkLB2uV3XbWc3WwGzqtdK1dh3HPtzcw53LwPmPU4F4DHkHaeqgYqGHrovOlNA7BwreicTsP7qMf+YStioCmzFypHYzAoA+gQoNR2wW0ouh/Hu+NQA3LluPUrXlbHn2KSsk4IWF17zSRdiPAt/OU7KlDefUgffuOf57WyWl/qpXdUt0EeoJRqhWFYpx7/dUCIgdMGXG9Yoz0bJ8fBRtMZlp/8JPB4e+3DaNCn61uZDngudCSrtkmkjxNyF47UYB/tDC6WVP+BAfMTm2u+bvZTYdtz11qXw6lHC21tOVOFKTB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsIAABJcAgAAA3ECAAYB3gIAFKIMA
Date: Mon, 25 Sep 2023 10:41:12 +0000
Message-ID:
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7816:EE_
x-ms-office365-filtering-correlation-id: 4fea722c-9fb8-4129-e860-08dbbdb3efaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d8GLvhCfu/OEIbcq2YY9xOu+yga3jJASU/8BiLyLK9QK7dhaKYtgUcEfl5G1deb/tFfvll7YC38+bYsCnY7rESg/26pnj7AD6Otu6J2GkKYfHwAyZNM8QB5Cso6w9EtXF52Tlexg/ARqhMbfG297R/Ev6MAmRGMhrJitDleGO7JmK8GEyJrkGRu1pwG1o1UWaa9M+Wy+X9HHzbQwUBqGFA/BZUIDGhzOvm9pSwL+1Z4Qb8LW4l3wZ9qTWKBO0iKEPEQwS/vCXUmLB32odjFAB1mYNzMII3Y3M9J0+urzVmCfeka40SI4wUderRBtHDAIhHqkx6xBsbnhN2k4kRpShS1QTrqeJafmy4agsQSl0M1jSGsd5/OW4arRWLwizszRVMHWCwus6vTnPvKI8PRGsl5jMCFyrHjByuWvAR4htQHsTedvAnQ67DXF8jvX0ROUWQqW3KwZP+dFLm6mt+wfTYoMicjDgKGHE7JeMINvhz+nRsdkNZaqQ5oTID2TGzYzzCryrCNAZbQwYflfS6XoghdSsdLMTruGWUxNsuy83yiHIW4DKOs7FVISsGuCQXO9qFmSQj15FxUmKiLGUWxaqXwifnXhHlqXgtTRwPb5zUwDMb18GbXhFkglUe7ZkrLXnlakRWEEa7LK0DIdl2IlVhCNoeVbl9He4J9m6KUswnY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(9686003)(6506007)(7696005)(966005)(478600001)(71200400001)(83380400001)(26005)(2906002)(8936002)(66446008)(66946007)(76116006)(66556008)(66476007)(316002)(6916009)(54906003)(64756008)(52536014)(4326008)(8676002)(5660300002)(41300700001)(33656002)(86362001)(122000001)(55016003)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2xydy9mWGFjMUdYTEMzNTh5Kzg1eVM2L2ZzR2pBMVQvZUl0U25PV0F2S1Mx?=
 =?utf-8?B?NUVVNkppN25VelMvUk8yUFNoNDh1dVIrOWlaVm85L3NFZ2p0Mm1jRWdZU2l0?=
 =?utf-8?B?VXNWalRzbHMzMWpxeHI5c3F3REw4UzVNSnVTWVFUWFlxbmNvKzZ1RmVDc0xx?=
 =?utf-8?B?RjNabDZ1emF6Ym5vL0pqeDR5YnRDcWtIaWNRUVRxbldmRW4vTHpCeXBLL2Ji?=
 =?utf-8?B?ZmltcERYMGFQVXo0RGcvUVA1dU52RDFaN1FxUnJybVVyU2JzYkx5YmpVUDdr?=
 =?utf-8?B?TGZiN1BtWnlaTWR1aVE1bjNyTlM0T2dUYlExUDd6alk2YktoeC9TbTZjUEVQ?=
 =?utf-8?B?ZnJmbkRPcTE0aCtuemRERlVINlA4Y3RLRjI2QzFON3ozUVI2S09VTGhxUjE5?=
 =?utf-8?B?bURndFExVkh3d0tqS2QrR05zRE5tNE5McDREVjVTanpFVU5qZzJEN3BNenh0?=
 =?utf-8?B?Tlh4S1B4SkNWTG4xTXRxYlgybzYxTEYrWXJIR3o3TzVYVkovTTIvOWxZOW11?=
 =?utf-8?B?T3pPVnpkWlZhcFhtUXVBYVNSZFF0SGVJMExTTHJkY2tmWGkrek5PWk55alIw?=
 =?utf-8?B?UTVwZ0RpR2trOG5Reks5ckh3K2tjZkRPZHFFMFVld09ZU2FteGtzY0xGU0gr?=
 =?utf-8?B?SGwyZG9MTHlReHlFWDJBemlTdDA2eURHMHN3dnJCaGtCU3hxQ0FhbG0wU0NX?=
 =?utf-8?B?S0dnbkQvZ1JvVmVKdnFsVUJJLzlSZUw2Z01OTmdCazdrRkJ4ZG5mVEo1ZW1U?=
 =?utf-8?B?TmV5ZnFZMnhJTXlXR2NoelhHcVYxV01reWZINW9Vem16M2xSM1ArWWVUVU1C?=
 =?utf-8?B?R2JENTZlR1hzZFZ1dmJEVW5GVHpzMFV0WElrOU5ERlhtOFdSZFg3bDlJSUFJ?=
 =?utf-8?B?ZVc1Tk9ZU2VGU1V4ZStaOVlRR1NWMklXVXV4QUtuSXNKWWk3NlRXT0dRaEpS?=
 =?utf-8?B?U0MxWmpuVml6T2lKcGl4REpyK201TWEyOVRqUzRoVW1veG1zS0lQUXlSMHdn?=
 =?utf-8?B?Zy9sYnlrNzBtZU9QWlRLQVNzWjNlT2VDL0NSMi9NeS9NcXhQaFdILzRvQk9C?=
 =?utf-8?B?MENJQjVJQ2NGWmZucmxXQ2l3R3BEbXc2Z1ZwRDNSRmhkV1RpcWttVVBmMjVV?=
 =?utf-8?B?dTJHVEhzeCsvTUk1L3ArbkRUWlpDRHZBME5NS1JMeFBFdUhneGwybUdyeTB3?=
 =?utf-8?B?OHNYUEZ6UXVpS0djRnV3RmdKRGs2MVpCaUpubEZaN1JzeFZFUFZzajZ6cC92?=
 =?utf-8?B?a2l5WkJMTVB0VUlQbnRaYVRSUklpeWYrR3h0VW5pUEZzTlJKRTV3enorS25j?=
 =?utf-8?B?SU10aExHNmY1TFpvSCsvbDBRTmExMW1qcis4TFU1Y1pQKzZNaGNTZmwrdXlE?=
 =?utf-8?B?TWF6WURPK1BoeEk1MGdFbllpalV6L2NKVHFNdjN2MkpoZWFjQWwwbXVkZkRR?=
 =?utf-8?B?ZTJjbXNOazZZZWhxQVU0RHhpcnlScWR1ekdCMW1CUlAvK0FkVkN2STRJUTVs?=
 =?utf-8?B?dUt1em1IMmVKYUVvWVZ1dmFnN3BqdDZXUkFPT0ZmZGpMT0ZJOWhSMWlHVlhM?=
 =?utf-8?B?UlQzaUhlZi9mRGE1V0RYVVNwcHlRaHFqY050ZjRMd3hvSkdTT1JHWGo1bmNw?=
 =?utf-8?B?UFEyeFNUZHB1VHdzQzRsUkJQS3VaOFJGUDJkVEtVSGpLUU9FUlE5YldFVHlt?=
 =?utf-8?B?NEgzNFMrWG11ZFRZUlI3cGRMcWZKNUx4MmY4NGNiUnl4Sy8rWVpUMExuUUJu?=
 =?utf-8?B?eDA0dDBsZlVodXBPalplMXhwWXBpVVQvMEZaUWcxS01LeDV3Lys4dTRNVlh5?=
 =?utf-8?B?NXhlTjlzTGR3T1ByQjhVbVp4dGlWRmlCYUdnSTZ6UTdhaHRKQ3l2dVlFempQ?=
 =?utf-8?B?STM0MEhQODNTbERnMVlQSG9jb2dQWVczQ1VHVU5VR3Q4RTdTaEluUTF5bk5t?=
 =?utf-8?B?djdmdklqU0pjOTNxRnF1OFIySVdvRWwxZDhZTGdrb2loaVFlUmlMVURSSy9Z?=
 =?utf-8?B?c1BubE5Ca3VkSlFkYVJvR1dOckdEOTZkRFcrMEJpazlYQjhwdmZHakY0bnUz?=
 =?utf-8?B?anJzS0lzcTBQMEM1OXhjN1lCRSsvUExEL2FDT0dxa1ZuaSt0cnprVE4xYVls?=
 =?utf-8?Q?3FOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea722c-9fb8-4129-e860-08dbbdb3efaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 10:41:12.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBfS1UFNJRTCxGtHPGsx3j8uUcY2TMNgWUcCqiY/lbTpY/rcvT9t4Fs8oEjLaSmrVYWQBgFIi6H2M/NHZU2cKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjMgODozOCBBTQ0KDQo+ID4gRGV2aWNlIGNvbnRleHQgaGFz
IG5vIG92ZXJsYXAuDQo+IA0KPiBJIGNhbiBnaXZlIHlvdSBvbmUgZXhhbXBsZSwgZS5nIGRlYnVn
Z2luZy4NCj4NCkFsbW9zdCBldmVyeSBmZWF0dXJlIG5lZWRzIGRlYnVnZ2luZy4gOikNClNvIEkg
YW0gb21pdHRpbmcgaXQgZm9yIHRpbWUgYmVpbmcuDQoNCiANCj4gPg0KPiA+IERpcnR5IHBhZ2Ug
dHJhY2tpbmcgaGFzIG5vIG92ZXJsYXAuIFdoYXQgZG8geW91IHdhbnQgdG8gcHJvZmlsZSBhbmQg
bW9uaXRvcj8NCj4gSW4gY2FzZSBpZiB5b3Ugd2FudCB0byBwcm9maWxlLCBpdCBjYW4gYmUgdXNl
ZCB3aXRob3V0IG1pZ3JhdGlvbiBjb21tYW5kDQo+IGFueXdheT8NCj4gDQo+IEl0IHdvcmtzIGxp
a2UgYSBkaXJ0eSBiaXQgb2YgUFRFLiBXZSBhbGwga25vdyBpdCBoYXMgYSBicm9hZGVyIHVzZSBj
YXNlIHRoYW4NCj4gbG9nZ2luZy4gRm9yIGV4YW1wbGUsIHRyYWNraW5nIHdvcmtpbmcgc2V0IGFu
ZCBkbyBvcHRpbWl6YXRpb24gb24NCj4gSU9NTVUvSU9UTEIgb3IgZXZlbiBkZXZpY2UgSU9UTEIu
DQo+IA0KPiAxKSBUcnkgdG8gcHJvdmUgeW91ciBmYWNpbGl0eSBjYW4gb25seSB3b3JrIGZvciBv
bmUgc3BlY2lmaWMgY2FzZXMNCj4gMikgVHJ5IHRvIHByb3ZlIHlvdXIgZmFjaWxpdHkgY2FuIHdv
cmsgZm9yIG1vcmUgdGhhbiBvbmUgY2FzZXMNCj4gDQo+IFdoaWNoIG9uZSBpcyBlYXNpZXIgYW5k
IG1vcmUgYmVuZWZpY2lhbCB0byB2aXJ0aW8/DQo+IA0KPiANCj4gPiBJZiB5b3UgZGVzY3JpYmUs
IG1heSBiZSB3ZSBJIGNhbiBzcGxpdCAiZGV2aWNlIG1pZ3JhdGlvbiIgY2hhcHRlciB0bw0KPiA+
IHR3byBwaWVjZXMsIERldmljZSBtYW5hZ2VtZW50IGFuZCBkZXZpY2UgbWlncmF0aW9uLg0KPiA+
DQo+ID4gRGV2aWNlIG1pZ3JhdGlvbiB3aWxsIHVzZSB0aGVzZSBiYXNpYyBmYWNpbGl0eS4NCj4g
PiBXb3VsZCB0aGF0IGhlbHAgeW91Pw0KPiANCj4gRGVmaW5pdGVseSwgYnV0IGl0IG5lZWRzIHRv
IGJlIGRvbmUgYnkgbm90IG1ha2luZyBpdCB1bmRlciB0aGUgc3Vic2VjdGlvbiBvZg0KPiBhZG1p
biBjb21tYW5kcywgdGhhdCdzIGl0Lg0KPiANCj4gTGV0IG1lIHJlcGVhdCBvbmNlIGFnYWluIGhl
cmUgZm9yIHRoZSBwb3NzaWJsZSBzdGVwcyB0byBjb2xsYWJvcmF0aW9uOg0KPiANCj4gMSkgZGVm
aW5lIHZpcnRxdWV1ZSBzdGF0ZSwgaW5mbGlnaHQgZGVzY3JpcHRvcnMgaW4gdGhlIHNlY3Rpb24g
b2YgYmFzaWMgZmFjaWxpdHkgYnV0DQo+IG5vdCB1bmRlciB0aGUgYWRtaW4gY29tbWFuZHMNCkl0
IHdpbGwgYmUgcGFydCBvZiB0aGUgZGV2aWNlIGNvbnRleHQgc3VjaCBhIHdheSB0aGF0IHNvIHRo
YXQgb25lIGNhbiBvbmx5IHJlYWQgdGhlIHZxIHN0YXRlIG9ubHkgaW5zdGVhZCBvZiBmdWxsIGRl
dmljZSBjb250ZXh0Lg0KVGhpcyB3aWxsIHdvcmsuDQoNCj4gMikgZGVmaW5lIHRoZSBkaXJ0eSBw
YWdlIHRyYWNraW5nLCBkZXZpY2UgY29udGV4dC9zdGF0ZXMgaW4gdGhlIHNlY3Rpb24gb2YgYmFz
aWMNCj4gZmFjaWxpdHkgYnV0IG5vdCB1bmRlciB0aGUgYWRtaW4gY29tbWFuZHMNCkdyZWF0Lg0K
RGV2aWNlIGNvbnRleHQgaXMgYWxyZWFkeSBkZWZpbmVkIGluIHRoZSBiYXNpYyBmYWNpbGl0eSBv
dXRzaWRlIG9mIHRoZSBhZG1pbiBjb21tYW5kcyBpbiBbMV0uDQpDdXJyZW50IHRleHQgaXMgYXJv
dW5kIGRldmljZSBtaWdyYXRpb24gYW5kIHNwZWMgZXZvbHZlcyBpdCBjYW4gYWRvcHQgbW9yZSBn
ZW5lcmljIHRleHQgd2l0aG91dCBkZXZpY2UgbWlncmF0aW9uLg0KDQpbMV0gaHR0cHM6Ly9saXN0
cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDkvbXNnMDAwNjQu
aHRtbA0KDQo+IDMpIGRlZmluZSB0cmFuc3BvcnQgc3BlY2lmaWMgaW50ZXJmYWNlcyBvciBhZG1p
biBjb21tYW5kcyB0byBhY2Nlc3MgdGhlbQ0KPg0KQXMgeW91IGFsc28gZW52aXNpb25lZCwgaXQg
aXMgZG9uZSB1c2luZyBhZG1pbiBjb21tYW5kcyB0byBhY2Nlc3MgaXQuDQoNCj4gRG9lcyB0aGlz
IHdvcms/IEl0IHNlZW1zIHlvdSByZWZ1c2VkIHN1Y2ggc3RlcHMgaW4gdGhlIHBhc3QuDQo+IA0K
SSBkaWRu4oCZdC4NClRoZXJlIG11c3QgYmUgc29tZSBjb25mdXNpb24gaW4gbWFueSBlbWFpbHMg
d2UgYm90aCBleGNoYW5nZWQsIGJlY2F1c2UgYWxyZWFkeSBwb3N0ZWQgdjAgaGFzIGl0IHNwbGl0
IHN1Y2ggYXMgZGV2aWNlIGNvbnRleHQuDQoNCkZvciBkaXJ0eSBwYWdlIHRyYWNraW5nIEkgY291
bGRu4oCZdCBmaW5kIGEgc29saWQgdXNlIGNhc2Ugd2l0aG91dCBkZXZpY2UgbWlncmF0aW9uLCBz
byBJIGFza2VkIHdoaWNoIHlvdSBhbHJlYWR5IHJlcGxpZWQgYWJvdmUuDQoNCj4gQWN0dWFsbHks
IEkgd291bGQgbGlrZSB0byBsZWF2ZSAyKSBhcyBpdCdzIHZlcnkgY29tcGxpY2F0ZWQgd2hpY2gg
bWlnaHQgbm90DQo+IGNvbnZlcmdlIGVhc2lseS4NCj4NCkkgd2lsbCBzcGxpdCBjdXJyZW50ICJk
ZXZpY2UgbWlncmF0aW9uIiBzZWN0aW9uIHRvIHR3by4NCjEuIGRldmljZSBtYW5hZ2VtZW50DQoy
LiBkZXZpY2UgbWlncmF0aW9uDQoNCkRldmljZSBtYW5hZ2VtZW50IGNvdmVycyBkZXZpY2UgbW9k
ZSwgZGV2aWNlIGNvbnRleHQgYW5kIGRpcnR5IHBhZ2UgdHJhY2tpbmcuDQpEZXZpY2UgbWlncmF0
aW9uIHJlZmVycyB0byBkZXZpY2UgbWFuYWdlbWVudCBzZWN0aW9uLg0KDQpXZSBjYW4gb21pdCB0
aGUgZGlydHkgcGFnZSB0cmFja2luZyBjb21tYW5kcyBmb3IgYSBtb21lbnQgYW5kIGZpcnN0IGNs
b3NlIG9uIHRoZSBkZXZpY2UgbW9kZSBhbmQgZGV2aWNlIGNvbnRleHQgYXMgZmlyc3Qgc3RlcC4N
ClNpbmNlIGl0IGlzIGFscmVhZHkgcGFydCBvZiB2MCBhbmQgaXQgaXMgbmVlZGVkLCBJIHdpbGwg
a2VlcCBpdCBpbiBzdWJzZXF1ZW50IHYxIGJ1dCBtb3ZlZCB0byBkZXZpY2UgbWFuYWdlbWVudCBz
ZWN0aW9uLg0KDQpNaWNoYWVsLA0KQXJlIHlvdSBvayB3aXRoIHRoaXMgYXBwcm9hY2ggdG8gc3Rl
cCBmb3J3YXJkPw0K

