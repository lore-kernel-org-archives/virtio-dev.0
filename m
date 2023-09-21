Return-Path: <virtio-dev-return-13905-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B18CD494B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:29:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9683E66DC8
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:29:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 833CF98667F
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:29:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C598983D6F; Thu, 21 Sep 2023 04:29:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DD3398667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwvUwklgkgh2CPuZ5OVbTyt1XYP9oa8BPymeldZh3IRQmOVv6RKFq6HGEl9olMADsu6vaTvTmAQb78p0g/SlJz2lAaSfUYtuMwfV8Vjh3MO+4mjfM0pxwOjhC9hkJQPluCGDQIslCyq450F4LmejbawxkN5DxMsARFBKlaadMAhjZo0ga6xP/KcMy1/NNWvSuzPCXEy3JXLsv2ws0psW9nREq4My+9WKVqVitUsnJBkkjdqeAjCCK1frmdiNQPhha7WvrHHxmHlAQiZRRIWIp1jJw78lICnqON74UwPh6w6pUVaBu+csTC4HOBkCdYx6PqqvfNyCY9mDAceXmTTzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umt7EdVkkTqra5ajduqObzB7CwyxWCh7mcEBcYuzino=;
 b=Exoq45Rb6f4+INt0oyEyIBX02V5qfFVNHMpwa5cl3D1N83OJSz+hupwZ2RzbQqCJRodfeCmOHJVHFY+5Pdr7R4955WZ6wvZGXY9ARjdQ4MjeULY9R6CnXOyNPoKIHuSe83LsYPNcOU2d35aHJADxw4Zf8ku4z9OtduM2C2OofV2S/BE+iGBQwvGhYimdNJPsl8SKs19WFDgWq/v6mbTb+C63H+sa/BKJz4lWvDiQWGZYuUfKz+HiriKnWRozDcSSNVL0NdDpynOhmPeCmFt5aYcGrH6g7p9WeFmQ5YvJ90aC82ZKUpVfQak1SAoXKSc0tebwPJFSV8SsEw+xaXxqBQ==
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
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAAu6AgAAG2oCAAPQiAIAACZXwgAADzICAAABeUIAABIcAgAAAfVA=
Date: Thu, 21 Sep 2023 04:29:41 +0000
Message-ID:
 <PH0PR12MB5481DBB812423F9B8E7837C4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org>
 <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
 <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEspOB_=Po=q+-SAyXG8TDhLVRg0=nC2hpw=7oFirbCN_w@mail.gmail.com>
 <PH0PR12MB5481E3D047621B4C273AFC2EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEv_FN6x0FwQhx2uBnbOVJpF_j4hBJx1u9QCSfjnOB=J2g@mail.gmail.com>
In-Reply-To:
 <CACGkMEv_FN6x0FwQhx2uBnbOVJpF_j4hBJx1u9QCSfjnOB=J2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6166:EE_
x-ms-office365-filtering-correlation-id: 1c8bd5ad-d95f-4407-5fa2-08dbba5b5fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iqXH756Fp51WnVIqQdQSffxU9W6l+Ec+xgXPA7RQ/nlXes4FdZxIH6yXatYh36//yCBxV+3xwRkWPHq+eVe9iQVmvB4QdDzlqZCI75JlcSVGGcv/HWLTITGkcJplqtdK8u8i1jwHoM25Hg0LPVDabIfUwk5B8MrsA7pohfQszwfqBT/8HN8bVmggm6fpgf2anRm387UQJXaKukJb2hhkHBP3izaFsj6kqSvDPzApoPzC6AduS+OOxuXZ+L8qzy9zTseBsDUa9vvKS7HDiPpj/1e7CiAqx/fT4vvUVdQVovJKwGDTcEGXvuy5hERes1YDH0X5tOt2vyrbGsaVx91mr563FnwxfXwF1DxiNulsii5B//mpSHUXYonYwyHl91k2gEIqvJux5YrglfUK4fyiEUGuHz9StbUJIKr3hgA5L7J5FxC7VZ10XKVdjX0EGU1KtA4exexKtcfnaMfrvgEk7R8dw893O4uqnPHu+lChCHypIZi8q+1vVAST3AJTZhkLcVmI3HTKOUoKtmUcK9TM9QD7mGo3ZT16zEGji+CfEb/VBwwQGlH+2uclmtY29Jh9hiK0n9oT/Xkdb0ri9swSzdrSVJ8tWr56cJR3uz5XOTZjFdUj21qA7uKFjra0urKI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199024)(1800799009)(186009)(55236004)(6506007)(7696005)(86362001)(54906003)(9686003)(41300700001)(66446008)(38070700005)(66556008)(66476007)(38100700002)(76116006)(66946007)(64756008)(71200400001)(478600001)(5660300002)(6916009)(316002)(55016003)(8936002)(8676002)(52536014)(26005)(2906002)(122000001)(4326008)(33656002)(83380400001)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ykx5elhHMXI0bndodi9RdkJlenhVbjk4RkRHK0tJZUJsc2JFd0ZPS2Z6Ukc1?=
 =?utf-8?B?OExNam5mcHFnak1zWnhpT3VwWGNLYVdVbVJoY3RXaU94SHJ0cGtReERtMDBW?=
 =?utf-8?B?Q3dKaEhSaUJtNytqeGNDR29acVFYQ3dhZEgycVZwMWlIQ1o2SjBWL0NJUGpG?=
 =?utf-8?B?R3BZZ0dGR0gwTlNlY1RqeFlBU2RDb2xWdk9GcmpyRjdYdjZpWEVNOHMrU3h1?=
 =?utf-8?B?ZXZPcG1PdEhjcU5RRVRZdVUrTHZyYkx0QkxGV3hCcUtlRmV5RTZmRE1UMEJG?=
 =?utf-8?B?SnZTeFFOa1BIMFFzQWN1SC9FcDVtcWZ2TEhEMlY3Q3daU2lkWEpWQmQ4S2Rq?=
 =?utf-8?B?a0FMbmlFMHlDNU5ZTDFVWHM0WElZYTVaMEdDekQyZ3c2L1habHdQZC8xaGl3?=
 =?utf-8?B?d2hQbEVtYVJWL0Nob08wbEpLVlhaazBjaEN2U2pBV3ZzWFo0VytBbXVGczZH?=
 =?utf-8?B?TUIvaGZPVTRDMlJtVTNudFN2cndGRUc1WjVFaWNlcTR4NlY5b0dva1h2RDdj?=
 =?utf-8?B?bXI2Q2wvNVh6emRjZ0QwalcyOVlLUXhZaXJmWDdrYVFYVjh1OTQ5UC9ieitX?=
 =?utf-8?B?d3hRaDNsdk9wWGh6NXdzNmlKQ2xic3pOc0FwazJWRkFmNXNBRVBDR3dTY2hs?=
 =?utf-8?B?UWQ4L0FpV29JcnRMUUlacm55NTNlVVIzWWlWRlAxdG1zTm93RnV5dkNQNlZY?=
 =?utf-8?B?OHhIaTZPVkd5bDYxSHNlRUxLZjFhZVlQV0M5Um9OZWJKVEUrdy8yUk9vNnBr?=
 =?utf-8?B?NGlJWVZrR3ZpazR6N0YxMVZzMEZlWm1YL3VJeHZGVmJ4SU0xZkdla1R2cStP?=
 =?utf-8?B?RkFDaWsvc2tnYUtzVHp5Vm1QVTV2SVVwN2lCSHhzR2RrUSt6YjN2SmU1R0s1?=
 =?utf-8?B?T2hDTTljVnVsWlMwdlU5ZU0rTGpxWENtT0daQVYvS1hKUHhXTllBTEd0OEE3?=
 =?utf-8?B?Nm96dEl6eFRCdThtUFcvV3VLNURGNW5KWGpDQ2ZMSkJYOURaS3Raak1lZDVY?=
 =?utf-8?B?UTVlanRpQ3VjYUd0bjNIU2pwSWx0ZWdhVjBSaGdnTHhXQmY4bWcxWTNSTW1D?=
 =?utf-8?B?QzZZREVrZHB4TW03NTlFODdlcThKNkJ0VWVQQWNTb0x5L0svWkZKVGc4Wlc1?=
 =?utf-8?B?RHlheDloSHdxSXgzeU1Gc1lFd2hveFRpNkhyNlpqZk1PNm8xenA0ZFZ5eWsw?=
 =?utf-8?B?U2k1Yzl6WWUzR3ZFRDB6Ty9VQWh2aGh4RUFqd3BYLzNQOHBUVTlrcDFQVXRU?=
 =?utf-8?B?eXlhV0dEeXhSeUw5dDNxanB2c3BpazhoOVExUnJlSm1FS0dNbjVRbUxMNktO?=
 =?utf-8?B?L2p3TEovK212dlBnNWwrZXgyWGxNZThDZzBDbXlTODRnQkpMOG15eXBTQlVE?=
 =?utf-8?B?cGxIOHRKTWFpZ3dkMFlhQThHVWY3NURweGM4dU81TXp4VmREQ1c2TlY3aE44?=
 =?utf-8?B?NlIxbFJUa2dmbWVMaWNDMllBZ1NQOXdCczRBTSswUGw1M0toZ1J0ZWdCUy9v?=
 =?utf-8?B?dGFqSlMxQ29hd2NIUUtqUXlCcGpCMkQ3TkVReFI2ajAydjREakYvbkVHN2pM?=
 =?utf-8?B?dXZOeGQvUWtvNlVrcTd2cjU2MlgrYWFGcURZVjJPZlFhcDh2dGNaeTEvWVdr?=
 =?utf-8?B?Y0k0TDAwZU50bzMwWUUrTVRXUVhyWkR2WVdHZHdWWndqWlZTVGE4NDZxVHFS?=
 =?utf-8?B?SXNkY2dCVEd6bEc5UEswZ2NlRkNURS8xVC9tWkdHMVZjeVlDWm5mU2pqbkM3?=
 =?utf-8?B?eDI2VW5HVU9pcmhwUTRqYXZkNFF5Snp2SjgvNGJzK1V4Y21lWXEyOEdMVER1?=
 =?utf-8?B?OTZhcXNFTVBhM0xseVVDRUhYdFptWG9BUWRwTC9ZaER2LzQyV3dEV0dJN2dw?=
 =?utf-8?B?Y3daVHM0TllIdmhMV0szQStIMHA1SWZINEl4WktISXlVL0pBYmc2WFM3Q01t?=
 =?utf-8?B?cVV5L0p1Si95TUxVVm5sM3puSmtYeFVyMlNXajVNNHlUd09BT0NtWWxZQ096?=
 =?utf-8?B?NnF6S0xuUEtCazJpTFFqY0kvSmNoRXR1R21sL2hJTGRxU3drY1p1RC9ES1FT?=
 =?utf-8?B?U0MvUk5zcjczMmRwRjRjU1BIZlFUVnpLVUlWaitkc1Z1RUwyVEcxUG5aVVBB?=
 =?utf-8?Q?iBns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8bd5ad-d95f-4407-5fa2-08dbba5b5fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:29:41.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xGMUMTuqeVftm7ZoCt7C9MZQUtc/kn4oGc4G3XDZDEDQ2FhhrYjPN/Z4x1amFCWJ2JTENt7cOqA1TRkJKY8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA5OjUwIEFNDQoNCj4gUGFyYXYsIEkgdGhpbmsgSSd2
ZSBjbGFyaWZpZWQgc2V2ZXJhbCB0aW1lczoNCj4gDQo+IG1pZ3JhdGlvbiB1c2luZyB0aGUgYWRt
aW4gY29tbWFuZCBpcyBwcm9iYWJseSBmaW5lIGluIHNvbWUgdXNlIGNhc2VzLg0KPg0KVGhpcyBp
cyBkZWZpbml0ZWx5LCB3YXMgbm90IGNsZWFyIHRvIG1lLg0KSSBhbSAxMDAlIGNsZWFyIG5vdy4N
CiANCj4gV2hhdCdzIG5vdCBmaW5lLCBpczoNCj4gDQo+IE1hbmRhdGUgdGhlIGFkbWluIGNvbW1h
bmQgdG8gYmUgdGhlIG9ubHkgd2F5IGZvciBtaWdyYXRpb24uDQo+DQpGb3Igc3VyZSwgbXkgc2Vy
aWVzIGRpZCBub3QgbWFuZGF0ZSB0aGF0IGVpdGhlci4NCkkga2VwdCBhc2tpbmcgaWYgd2UgYm90
aCBjYW4gY29udmVyZ2UgaXQgd2lsbCBiZSByZWFsbHkgZ29vZCB0byBtZXJnZSB0d28gdXNlIGNh
c2VzLCB3ZSBzaG91bGQuDQpJZiB3ZSBjYW5ub3QgYmVjYXVzZSBvZiB0ZWNobmljYWwgaXNzdWVz
LCB0aGFuIGJvdGggbWV0aG9kcyB0byBleGlzdHMgdG8gYWRkcmVzcyB0d28gZGlmZmVyZW50IHVz
ZSBjYXNlcy4NCg0KPiBBcmUgd2Ugb24gdGhlIHNhbWUgcGFnZSBmb3IgbXkgY29uY2VybiBub3c/
DQo+IA0KWWVzLg0KDQo+ID4gV2hhdCBpcyB0aGUgYWR2YW50YWdlIG9mIGRlc2NyaXB0b3IgcG9z
dGluZyB1c2luZyB2aXJ0cXVldWUuIEl0IGlzIHRoZSB3YXkgb2YNCj4gdmlydGlvIHNwZWMuLi4N
Cj4gPg0KPiA+ID4gPiBXZWxsLCBpdCBpcyBvbmUgd2F5IHRvIGFjaGlldmUgaXQuDQo+ID4gPiA+
IFRoZXJlIG1heSBiZSBkaWZmZXJlbnQgd2F5IHRvIGRvIGFsbCBidWxrIGRhdGEgdHJhbnNmZXIg
d2l0aG91dA0KPiA+ID4gPiBhZG1pbg0KPiA+ID4gY29tbWFuZHMuDQo+ID4gPg0KPiA+ID4gV2h5
IGlzIHZpcnRxdWV1ZSB0aGUgb25seSB3YXkgdG8gZG8gYnVsayBkYXRhIHRyYW5zZmVycmluZz8g
Q2FuJ3QNCj4gPiA+IERNQSBiZSBpbml0aWF0ZWQgYnkgb3RoZXItd2F5Pw0KPiA+ID4NCj4gPg0K
PiA+IFN1cmUsIHdoYXQgaXMgdGhlIGRpc2FkdmFudGFnZSBvZiBleGlzdGluZyBtZWNoYW5pc20g
b2YgdmlydHF1ZXVlIHRoYXQgY2FuIGRvDQo+IGZvbGxvd2luZy4NCj4gPiAxLiBBYmlsaXR5IHRv
IGRvIERNQQ0KPiA+IDIuIGFnbm9zdGljIG9mIHRoZSBETUEgd2hvIGRvIG5vdCB3YW50IHRvIGRv
IERNQQ0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMuDQo+DQpBZG1pbiBjb21tYW5kcyBj
YW4gd29yayB3aXRob3V0IERNQSwgcmlnaHQgYmVjYXVzZSB0aGV5IGFyZSB0cmFuc3BvcnRlZCB1
c2luZyBhZG1pbiBxdWV1ZS4NCiANCj4gPiAzLiBBYmlsaXR5IHRvIG11bHRpcGxlIGNvbW1hbmQg
ZXhlY3V0aW9ucyBpbiBwYXJhbGxlbA0KPiANCj4gRWFjaCBkZXZpY2UgaGFzIHRoZWlyIHNlbGYt
Y29udGFpbmVkIGludGVyZmFjZSwgd2h5IGNhbid0IHRoZSBjb21tYW5kcyBiZQ0KPiBleGVjdXRl
ZCBpbiBwYXJhbGxlbC4NCj4gDQpXaXRoaW4gdGhlIGRldmljZSBpdCBjYW5ub3QgaWYgdGhlIGlu
dGVyZmFjZSBpcyBzeW5jaHJvbm91cy4NCg0KPiA+IDQuIE5vbiBibG9ja2luZyBpbnRlcmZhY2Ug
Zm9yIGRyaXZlciB0aGF0IGRvZXMgbm90IHJlcXVpcmUgYW55IGtpbmQgb2YNCj4gPiBwb2xsaW5n
DQo+IA0KPiBBcmUgeW91IHNheWluZyB0aGUgaW50ZXJydXB0IGNhbiBvbmx5IHdvcmsgZm9yIHZp
cnRxdWV1ZT8NCj4NCk5vLiBJIGFtIHNheWluZyBpZiBvbmUgaGFzIHRvIGludmVudCBhIGludGVy
ZmFjZSB0aGF0IHNhdGlzZnkgYWJvdmUgbmVlZHMsIGl0IHdpbGwgYmVjb21lIGEgdmlydHF1ZXVl
Lg0KQW5kIGlmIGl0IGlzIG5vdCwgb25lIHNob3VsZCBsaXN0IHRob3NlIGRpc2FkdmFudGFnZXMg
YW5kIGNvc3Qgb2YgbmV3IGludGVyZmFjZSwgYW5kIGV4cGxhaW4gaXRzIGJlbmVmaXRzLg0KU3Vj
aCBpbnRlcmZhY2Ugc2hvdWxkIGJlIGdlbmVyaWMgb25lIHRvby4NCiANCj4gPg0KPiA+IFdoeSB0
byBpbnZlbnQgbmV3IERNQSBzY2hlbWUgd2hpY2ggYXQgZG9lcyBhbGwgdGhlIDQgdGFza3M/DQo+
IA0KPiBJdCdzIHNpbXBseSBiZWNhdXNlIGFkbWluIHZpcnRxdWV1ZSBjYW4gbm90IHdvcmsgZm9y
IGFsbCB0aGUgY2FzZXMuIEkgdGhpbmsgeW91J3ZlDQo+IGFncmVlZCBvbiB0aGlzLCBubz8NCj4N
CkkgdGhpbmsgaXQgbWF5IHdvcmsgZm9yIG5lc3RlZCBjYXNlIGFzIHdlbGwgYXQgdGhlIGNvc3Qg
b2YgcmVwbGljYXRpbmcgaXQgb24gZWFjaCBkZXZpY2UgYW5kIGFkZGluZyBzcGVjaWFsIHBsdW1i
aW5nIHRvIGlzb2xhdGUgaXQsIHNvIHRoYXQgZ3Vlc3QgY2Fubm90IGlzc3VlIGRyaXZlciBub3Rp
ZmljYXRpb25zIHRvIGl0Lg0KDQo+ID4gRmlyc3QgcGxlYXNlIGxpc3QgZG93biBkaXNhZHZhbnRh
Z2VzIG9mIGFkbWluIHF1ZXVlICsgc2hvdyBhbGwgNCB0aGluZ3MgYXJlDQo+IGFjaGlldmVkIHVz
aW5nIG5ldyBETUEgaW50ZXJmYWNlLg0KPiA+IFRoYXQgd2lsbCBoZWxwIHRvIHVuZGVyc3RhbmQg
d2h5IG5ldyBkbWEgaW50ZXJmYWNlIGlzIG5lZWRlZC4NCj4gDQo+IEkgY2FuIGdpdmUgeW91IGEg
c2ltcGxlIGV4YW1wbGUuIEZvciBleGFtcGxlLCB3aGF0IGhhcHBlbnMgaWYgd2Ugd2FudCB0bw0K
PiBtaWdyYXRlIHRoZSBvd25lcj8gSGF2aW5nIGFub3RoZXIgb3duZXIgZm9yIHRoaXMgb3duZXIg
aXMgbm90IGEgZ29vZCBhbnN3ZXIuDQoNClRoYXQgaXMgdGhlIG5lc3RpbmcsIGRvbuKAmXQgc2Vl
IGFueSBkaWZmZXJlbmNlIHdpdGggb3RoZXIgbmVzdGluZy4NCg==

