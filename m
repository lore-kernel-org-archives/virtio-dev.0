Return-Path: <virtio-dev-return-13689-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E77CA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06A2F21181
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E08B39865CE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CB782983E27; Tue, 12 Sep 2023 06:05:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7AF7986485;
	Tue, 12 Sep 2023 06:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBtVe2++rt9/Nw2g2e5lXqlmI4GEwsKxC81pU7lfrFgQjVx/VA3nftr6dF7YWAzmDlrLJKgXzk7lZQJt1zjCLB/PEvjfNOgbf2Fm0zi+zqwg4VzqSk+gIYkZ0iR4QLf68pCoXu81lfJnKGNn1vnJ+vgIsmgoIlyKQtUHIb1x7eF06knWN/FMCT8bJKIBDQ3yqjYacvK0tGVFaanasqmLrNw5H9/aGjHcDTpNqv4Xmn2oUxF1Q9JuQuiAQ+QutyF0yWRfXRFtwnzP1QdzLcaOympfuovagbKPHcWIkN4LQme6rL7m3m/Xz7CPx34Lj43DGWPDPlntJ5uzuVm1TjOc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbG7iyzIYgjcz9JoG5xCscdWjY52ptJDjkNSHgy7Ti4=;
 b=OrLnLQfW0gIipV1ciQpyyz8PkoS+Ll8lRh+Jct9rTqCAulZjM7b7DnUcP509WiBUO0/tQOgP1XiSEEUYJQbnltg/miCUGzGrNZlJPcFdDmwzsa5fGZicSVx2VvQJ0dhSEOp8c5Zx9aEw3Ky6Q6HPMNT18cdj0FtSuneM3rW5NMOYGac6KzGZHvcZJSPIwPOGqaOoQlHUWxgI8DAtPZI2MxNpF7qybbq8KrI9XiEwiTpZvNCKzpI2HvhWiwc3kRJaiJuH3pGLwMm2+GO5qWV10xZ6D93ET9ua8JNWy4fjz4l0xUiSSIw1LIhYSM/4hyG/1gxKR2Cjn0sBMINZY6IWAA==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAFSQACAAB4lQA==
Date: Tue, 12 Sep 2023 06:05:28 +0000
Message-ID:
 <PH0PR12MB5481E49BFCE50AA8F8373F45DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt6=AC4pYEoxNn2dpbLLEKTLj-SYV2eSUAi1ZA1LWR3qg@mail.gmail.com>
In-Reply-To:
 <CACGkMEt6=AC4pYEoxNn2dpbLLEKTLj-SYV2eSUAi1ZA1LWR3qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN6PR12MB8489:EE_
x-ms-office365-filtering-correlation-id: 79cbed05-37ed-44cf-5861-08dbb35643ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5hYo61c6HRGvJU4T4dKQ/FPL7NoW9TQGLG0P5mDwhlPhaRsvn97bGYOh7qHlvR16URVcWPk535++4VZ8LGXJFmfMStpY1Tk/12yGqbE3G0q/h37taFHuse+nFUOX2zIH7/C6L7eGwOH1LAGMLgTUqzNv62Fe2zmaCzB4QNaqHylYV8bxvjEL8iPUS0fjpS/9ivigMwKMR7O31txTFzXWr3NIO+vTGzkMUHrg3CZLXNig8WuNMhuCLef9vAY2FXS4eWvXHDu+4Lr6828RsBbyiqmJS4BIOOIfR47w8xMQqtwHVlgMqALWWXZkN/iZusyaZwM2fySltwsWXPXx1T263Ck3fe+ZMvlUddJ/nVy5pkzOgz6BuHOMkl8s9sO6L+uNFaSAgZjy1d6vj3aV3SK/5MNuNJd169zNKOiD/dgkhM+jojkecR95w0yEw0CZT1ikb0zrRgPtXmyul4c9iMNRjjotVDSb3ToC5Ba5XLz0c5x1AK1R3xiFIGAwF7dWlpFVZLDcDbnJZd4SO98XCFzqKdirRysIvNvHxJsAKr7psSv10y78WbKwgSDNuw1MjDLcGzDFeeriXO33E0jOlyDUag0olXlau1/LStQOOSLL4tFAvEA9uIuHhShjr/f7xr9Frag907xjEB3LDKAITXdUwgZW3ZCw998Fu08KQWnKZO8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(9686003)(26005)(316002)(6916009)(41300700001)(54906003)(6506007)(66476007)(76116006)(5660300002)(64756008)(66946007)(66446008)(66556008)(8676002)(71200400001)(8936002)(4326008)(52536014)(7696005)(478600001)(2906002)(966005)(55016003)(86362001)(33656002)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHV2K1JMbUUzZlRHUU94L1k3dTFaYUFUd2tMOWNiYUhBTUh5aTVmMEVBYjVH?=
 =?utf-8?B?UHBKRDNKeG92SmczVzE3YkpzSEEzbWxVV3pLZWJUSXRFV1o3RnpHQlNHb3RF?=
 =?utf-8?B?YkFlSkxueUNMaC93Wm5oL21BN0NHV3J2TmJJZTBMeS9RbmJHWUFWZmpIWmxC?=
 =?utf-8?B?aHh5ckEwTmlQdC9JNmZXbEZOUDhMU1FWRFVIa1AraUdUM1RRN0wzckVnNUt0?=
 =?utf-8?B?eHRETTl3SU5vNEw5ZVZjQzNOS0RnTTJ4WlVrdWtQdVFLSVhDdzduWTdTdCtR?=
 =?utf-8?B?Y0FLZDlvSzlxSmplUE9sMUpBMXRNcmZwbStNUldIVVkrd0E5ZUl1MUJYMWIr?=
 =?utf-8?B?RzRHOEg4NHhaYmIvcXBaa1E0UlBsdzNvSDB2eGg4OVdodVBQcDRocTdEblU0?=
 =?utf-8?B?VWV3cEthQW5CYWt5RzRja0tzQTRTbjV4R2tsc1FPejZobG9CS1BwRGRlTjRY?=
 =?utf-8?B?Vjd6dVFzY2tHdis2bFJOZU1GVjErL05VelpDYlhRNFpYVHV6Z3d3Mm51cXlo?=
 =?utf-8?B?OHhEN0JqdFoxd2lzeEdEZ3ZzVEN5K2h6RFN6dE51RDFaaCtSNFdBMzJja1lk?=
 =?utf-8?B?eUttTTFRUGVnZHBLamFjNFhLVDFSTlZ6Y3pWRG1RRUw0MFdBTW5raWpUeVFE?=
 =?utf-8?B?VWlHYm44WnpMd1JGQXdMaTBxM2hub1c5ckptR28vc2N3bnhtSmV1WWVGcXd1?=
 =?utf-8?B?azZ3RzEyV0xuRGZpUngwV09ZL1JzaDFoQ0NFUVhicjhVL2swbVBaaWhjdFNa?=
 =?utf-8?B?aXczYys0Ry9BTktUTnRlcVkyc1J4Q2hDR2o3RytQclFZMlZoY1U0VDdrYnp4?=
 =?utf-8?B?d3ZNaWNya1lDUUgrR09KbDlSNjZYOVFCMlNOYlZNdDNUSjJKdEVnOThuV3o5?=
 =?utf-8?B?RWxyOTRPb3M1V1lQQnFaRzZFbWtYSDFzV1RiMTg4MlpQLzhpalpUVEl3dzY3?=
 =?utf-8?B?bVovdnVLaEpEVDBIR0QweWVUeDNCNjZNaUNMQTdvOU1rQ2dPalNYaVlZQXJY?=
 =?utf-8?B?ZUdmOTQrUlQxVDR4SXlKbEFoZDVIZGpQUHFRRms2WUFqT3ppWmtZbjBXUjhS?=
 =?utf-8?B?L3c2WWJiWjFNZXRNSGNQQUVkMXcvbVJnMWZCaTFZVGpUQzVadVpkTGhxTmxY?=
 =?utf-8?B?SVNVdUpYRGdRME8vRmhRam1qRDlOazhvN0JMRXB2M3ZiRlhLRC80SlJUdzFm?=
 =?utf-8?B?dFVQZy9HaG5CQVlmTTRXeDlzWEFUYTNwTm8wWjEyM0MwbTFOTC9CcmYwc3Nu?=
 =?utf-8?B?Qm4yalFBZE00cjBnQ2VEaHpsYk83UGhySjVhNklnMzFITWlEYkFYeUNTbU5q?=
 =?utf-8?B?SUM5eFRBMlRZV0lkR3hhaWRoT1R5bUZUY1VlOVZjd3RLbmdaOVA0RXBSZW54?=
 =?utf-8?B?ajlzK1FUeGRiN2plenZlak00bTE4UnVIYkF0YloyakN3YnZJZ1FTQzZlL04x?=
 =?utf-8?B?eEcrSjVoUXpxR3NCVUVtQWVadE9JczJTS1lRVTFRRVN2eDhGS0pTTlRCZDdX?=
 =?utf-8?B?UGVXVk5iKzVOa1Z2clc0RUJQVUwwTndzOW1JY29PMmh6dExRZHFWdjU2VWFj?=
 =?utf-8?B?d1NaVTd2aW1QeEoybFNzeEI1eGhWbUx4Y1pScXA4dnliVVMzSWozRGZtMzRt?=
 =?utf-8?B?U1h5bjJDeGppOGVSZnpkdkExdWxXMmdhbEsxNXdjOHpob1BXd3BubEVjUkV6?=
 =?utf-8?B?NTVTWlBnUThac2RuMUFtRDU0bjBkbW5wZEpEdWgrMDRZQ1EzQy8wK2J5ak13?=
 =?utf-8?B?bzdqR0tScGlmTUE0aVNRSkd0cnRvVGIxcTBSRmxCL21KYkd2eXBqUWFha0ZJ?=
 =?utf-8?B?cjlxM0p3YmR0VDd5WC9obUdVOU1oUVRsbDVzeElqb3ZJeGk0bWM5NUJCOWlx?=
 =?utf-8?B?Z3Z3VVdpdnU2dVhBTGdFbTFBVmtGdEsyM0hEeWQvdXdKd2NXb0cwVEtYSEpp?=
 =?utf-8?B?SmFqcTBkVTlSUjJibUJTWHpwMWNlY2Y2bmt4RUx1QTRzNE9zdm1RdktpQjlM?=
 =?utf-8?B?RmpnSVRWbElLOXJkODN6dGs0SjkvOXRzWSs3eDJSeVNMSk1zZkRMVHJNbjlw?=
 =?utf-8?B?dlVZTEV4SjlwNzU3eWJKZFdEK2RZOUU4ZEI3aXI2TEw1cFFkWnBZb1FjazRO?=
 =?utf-8?Q?yTD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cbed05-37ed-44cf-5861-08dbb35643ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:05:28.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddtoWYn4eli3UFASy3ND725BGAmT8YdAaBWaHQoeHXQYI3s9r4zcnScBb7ESF2JversI+BKh5LYc+HYoNlpglw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAxMiwgMjAyMyA5OjQwIEFNDQo+ID4NCj4gPiA+IFdoeSB0aGlzIHNlcmll
cyBjYW4gbm90IHN1cHBvcnQgbmVzdGVkPw0KPiA+IEkgZG9u4oCZdCBzZWUgYWxsIHRoZSBhc3Bl
Y3RzIHRoYXQgSSBjb3ZlcmVkIGluIHNlcmllcyBbMV0gcmFuZ2luZyBmcm9tIGZsciwgZGV2aWNl
DQo+IGNvbnRleHQgbWlncmF0aW9uLCB2aXJ0aW8gbGV2ZWwgcmVzZXQsIGRpcnR5IHBhZ2UgdHJh
Y2tpbmcsIHAycCBzdXBwb3J0LCBldGMuDQo+IGNvdmVyZWQgaW4gc29tZSBkZXZpY2UsIHZxIHN1
c3BlbmQgcmVzdW1lIHBpZWNlLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9saXN0cy5vYXNp
cy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDkvbXNnMDAwNjEuaA0KPiA+
IHRtbA0KPiANCj4gVGhlIHNlcmllcyB3b3JrcyBmb3Igc3RhdGVsZXNzIGRldmljZXMuIEJlZm9y
ZSB3ZSBpbnRyb2R1Y2UgZGV2aWNlIHN0YXRlcyBpbiB0aGUNCj4gc3BlYywgd2UgY2FuJ3QgbWln
cmF0ZSBzdGF0ZWZ1bCBkZXZpY2VzLiBTbyB0aGUgZGV2aWNlIGNvbnRleHQgZG9lc24ndCBtYWtl
DQo+IG11Y2ggc2Vuc2UgcmlnaHQgbm93Lg0KVGhlIHNlcmllcyB3b3JrcyBmb3Igc3RhdGVmdWwg
ZGV2aWNlcyB0b28uIFRoZSBkZXZpY2UgY29udGV4dCBjb3ZlcnMgaXQuDQoNCj4gDQo+IERpcnR5
IHBhZ2UgdHJhY2tpbmcgaW4gdmlydGlvIGlzIG5vdCBhIG11c3QgZm9yIGxpdmUgbWlncmF0aW9u
IHRvIHdvcmsuIEl0IGNhbiBiZQ0KPiBkb25lIHZpYSBwbGF0Zm9ybSBmYWNpbGl0aWVzIG9yIGV2
ZW4gc29mdHdhcmUuIEFuZCB0byBtYWtlIGl0IG1vcmUgZWZmaWNpZW50LCBpdA0KPiBuZWVkcyB0
byB1dGlsaXplIHRyYW5zcG9ydCBmYWNpbGl0aWVzIGluc3RlYWQgb2YgYSBnZW5lcmFsIG9uZS4N
Cj4gDQpJdCBpcyBhbHNvIG9wdGlvbmFsIGluIHRoZSBzcGVjIHByb3Bvc2FsLg0KTW9zdCBwbGF0
Zm9ybXMgY2xhaW1lZCBhcmUgbm90IGFibGUgdG8gZG8gZWZmaWNpZW50bHkgZWl0aGVyLCBoZW5j
ZSB0aGUgdmZpbyBzdWJzeXN0ZW0gYWRkZWQgdGhlIHN1cHBvcnQgZm9yIGl0Lg0KDQo+IFRoZSBG
TFIsIFAyUCBkZW1vbnN0cmF0ZXMgdGhlIGZyYWdpbGl0eSBvZiBhIHNpbXBsZSBwYXNzdGhyb3Vn
aCBtZXRob2QgYW5kDQo+IGhvdyBpdCBjb25mbGljdHMgd2l0aCBsaXZlIG1pZ3JhdGlvbiBhbmQg
Y29tcGxpY2F0ZXMgdGhlIGRldmljZSBpbXBsZW1lbnRhdGlvbi4NCkh1aCwgaXQgc2hvd3MgdGhl
IG9wcG9zaXRlLg0KSXQgc2hvd3MgdGhhdCBib3RoIHdpbGwgc2VhbWxlc3NseSB3b3JrLg0KDQo+
IEFuZCBpdCBtZWFucyB5b3UgbmVlZCB0byBhdWRpdCBhbGwgUENJIGZlYXR1cmVzIGFuZCBkbyB3
b3JrYXJvdW5kIGlmIHRoZXJlJ3JlDQo+IGFueSBwb3NzaWJsZSBpc3N1ZXMgKG9yIHVzaW5nIGEg
d2hpdGVsaXN0KS4NCk5vIG5lZWQgZm9yIGFueSBvZiB0aGlzLg0KDQo+IFRoaXMgaXMgdHJpY2t5
IGFuZCB3ZSBhcmUgbWlncmF0aW5nIHZpcnRpbyBub3QgdmlydGlvLXBjaS4gSWYgd2UgZG9uJ3Qg
dXNlIHNpbXBsZQ0KPiBwYXNzdGhyb3VnaCB3ZSBkb24ndCBuZWVkIHRvIGNhcmUgYWJvdXQgdGhp
cy4NCj4gDQpFeGFjdGx5LCB3ZSBhcmUgbWlncmF0aW5nIHZpcnRpbyBkZXZpY2UgZm9yIHRoZSBQ
Q0kgdHJhbnNwb3J0Lg0KQXMgdXN1YWwsIGlmIHlvdSBoYXZlIHRvIGtlZXAgYXJndWluZyBhYm91
dCBub3QgZG9pbmcgcGFzc2h0aHJvdWdoLCB3ZSBhcmUgc3VyZWx5IHBhc3QgdGhhdCBwb2ludC4N
ClZpcnRpbyBkb2VzIG5vdCBuZWVkIHRvIHN0YXkgaW4gdGhlIHdlaXJkIHVtYnJlbGxhIHRvIGFs
d2F5cyBtZWRpYXRlIGV0Yy4NCg0KU2VyaWVzIFsxXSB3aWxsIGJlIGVuaGFuY2VkIGZ1cnRoZXIg
dG8gc3VwcG9ydCB2aXJ0aW8gcGFzc3Rocm91Z2ggZGV2aWNlIGZvciBkZXZpY2UgY29udGV4dCBh
bmQgbW9yZS4NCkV2ZW4gZnVydGhlciB3ZSBsaWtlIHRvIGV4dGVuZCB0aGUgc3VwcG9ydC4NCg0K
PiBTaW5jZSB0aGUgZnVuY3Rpb25hbGl0eSBwcm9wb3NlZCBpbiB0aGlzIHNlcmllcyBmb2N1cyBv
biB0aGUgbWluaW1hbCBzZXQgb2YgdGhlDQo+IGZ1bmN0aW9uYWxpdHkgZm9yIG1pZ3JhdGlvbiwg
aXQgaXMgdmlydGlvIHNwZWNpZmljIGFuZCBzZWxmIGNvbnRhaW5lZCBzbyBub3RoaW5nDQo+IHNw
ZWNpYWwgaXMgcmVxdWlyZWQgdG8gd29yayBpbiB0aGUgbmVzdC4NCg0KTWF5YmUgaXQgaXMuDQoN
CkFnYWluLCBJIHJlcGVhdCBhbmQgbGlrZSB0byBjb252ZXJnZSB0aGUgYWRtaW4gY29tbWFuZHMg
YmV0d2VlbiBwYXNzdGhyb3VnaCBhbmQgbm9uLXBhc3N0aHJvdWdoIGNhc2VzLg0KSWYgd2UgY2Fu
IGNvbnZlcmdlIGl0IGlzIGdvb2QuDQpJZiBub3QgYm90aCBtb2RlcyBjYW4gZXhwYW5kLg0KSXQg
aXMgbm90IGVpdGhlciBvciBhcyB1c2UgY2FzZXMgYXJlIGRpZmZlcmVudC4NCg==

