Return-Path: <virtio-dev-return-13957-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FAFE7D0C5
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:03:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 393081318CA
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:03:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A66A9864CC
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:03:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1F0D7983DE3; Tue, 26 Sep 2023 06:03:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0875C98639D;
	Tue, 26 Sep 2023 06:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmsw1TUjcCq+Ka11EFxze0BCacFfoPzsXSEKn+lwOWaBq2tSE3O4FAZouukoSMoo58GNj3n1aYV0IIQ0wxY0TzGBrR2vYY+E2/7sC4XT2OHyt3iEb6SpbQde7PP0/D63kU825CZz6kmZrRJxGSr73MDm/mop+oL9Lv8FDwI5ChjSWHTp+UoqW8ukF08DUiV2J4Mjl0Hm/BqOL/l0lvSIYxpiPtcNVWWZtdwjWNV/8TVWUwiDCG5m0F7jYMQYXL7RDFlmkzX2EZH2iGw7ARApslNbHFRxIpOYLJu9kS9t4uedeVqkEcanyQOaMdi/r0oKV4ce/Epokzx+6rUscIH0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uHvWpGogyhygUMjNoZ7QY0rZQr3JyflNeVxq7k7pVg=;
 b=VCDfOUoUIZmiUgK5G9VJvTJEj5JiAy/p6+4xaE9kj17usrZfNAsB4fwPjDrWYR1TJeo5UGW1vapemf8kJLv7K1GfH5McS7xjJdF0QR9QufXAI0FRmSj09WyyMSUJF7pvBU6okat1ZrWn8NOjRxusWmwuJZJHddjDxmMXBQE2QFzuVUJe3X22oBeVs53OsybAhzoNWTqMyAwGWI3FyjSTYBQtMjnWW8TRp1cIYUQYmveOiUe7gfalR/VT0wzd3MDlmefsyd2OF60h+p155vDfYX2vyGG+yVcTw9ur8HK58tzEZ082/KN6KXoFBHkfBUJU1EbgnhqKOBhFOZVbal8lYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang
	<jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsIAABJcAgAAA3ECAAYB3gIAFKIMAgAEae4CAAAfOcIAAKAeAgAADn6A=
Date: Tue, 26 Sep 2023 06:03:24 +0000
Message-ID:
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
In-Reply-To: <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB9075:EE_
x-ms-office365-filtering-correlation-id: 68b3603a-6663-4f60-cf04-08dbbe564b5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ucYTIi47G5g2Zukv92q8cV6ljzDFNHIPI3FFhNs5zc2AGw42cH8rKHDUQRgA03a6Qrrr92lFl/q2eZCTTGfBDVaIKLBi95UFF+JJGscSh6W2zVOLDllyxdxvBLWl3m0ElXxEZgaZlFWZqpES9iynQSK/MwJJJM1y7Ay/xlPKWe7SXOA28HcJl69giFoYssRNHIbfAbIum7yRtQoc/S3H7bkZIG9lqi5DOCbzfqvodveuG7F+sIGZZXoHkxpxoIm85RhYZSduFexUgM8OyPpptL15ks68STyOQzqnkRYnziSW27hEqEXhLttAnjgM8dp9ee6qIM+4DpX+vDDb/JGSBfR9xmHaGX7+/O49NhAHNHzb5wLQycU5gp2Zybtc91GQY7sjScgVOEcYZnjPb8cXqP1BpBMWAe7ykxpRglPSdr9/Ashi4eFU4uTfM/6zyoKtTpB1hQiK8TlOyu01Pns8jiFQg9vsOxvZySlACyLberM269xKJe5GuDHtcYEn8VDj+Wk1gaNVLXTElyBfQloffaA/nAHq9k0crNxHg2gDb0v1l5SpRkMPAY6yxZeaskJqxvUMXGoxKa7p/Ki67nwD5A4b4dsgZY7c9TAFBaHtxl3WltFrwfPqVxXOAMFCxDA8E+dTX8Es9bQAew5NjEdg3kpcU4yUD74bgw/CIKNyLSb3hl8J2ZdUdIjGRy6B5Xq1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(86362001)(966005)(2906002)(15650500001)(33656002)(71200400001)(6666004)(5660300002)(83380400001)(52536014)(4326008)(122000001)(8676002)(8936002)(7696005)(55236004)(6506007)(41300700001)(66446008)(66476007)(66556008)(64756008)(66946007)(26005)(38100700002)(478600001)(38070700005)(9686003)(55016003)(316002)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WG10eFg4cUR4aEhiOG1EdjJROUE4VFBzbWx1TExtMjVYYm85ZjBrT2lWK2w0?=
 =?utf-8?B?ZzJOQVQwSlMyNnRJdVJid2NJL2JDQTROMUtUODd6NWFJOHBDRm5uNFhwQnAz?=
 =?utf-8?B?aC9tZzd1NVkyNFhWdjFPY0hFRWpGS24yMDZoZHcxWCtUKzB2c0VxOGhBRXBT?=
 =?utf-8?B?QzA4eWxyNmMyam80TWw5U1BEd25nMllZU09wL2syR3VvblhsRlJuVmpJY2RI?=
 =?utf-8?B?U1haWEpuOUltTG5BQllSUFpYMWVPeGNLQ05pZU8xejZGZTJlUFJSQ05lRXJP?=
 =?utf-8?B?U2hVRmtFaFR2V0lXM1VPcUZ2cUpKd3ptOWx3WktxL0JIRG91Tk40Vkt0U0NN?=
 =?utf-8?B?Nm1PYzZlZFBOUnNONFlzR2VTeTZveXoydUZ5clg0TjBmcEpVK1ZtWjJpdURu?=
 =?utf-8?B?a0lFdGVzejdPc3lyOVNmSnFZdGNwMUlHdzYrT2ZKZUJVQTdvSGYxVGdsVkJG?=
 =?utf-8?B?a0o5My9KL2VXWlg2bnlYNDA1NVltWEQ5VHhiLzhXcStvVGFtYXFqYnpWb3lY?=
 =?utf-8?B?Z1VTMy9OSlZVY0t0Ykl0eVUyZE9YaXpYWVZUazVLUWt1bEZMclg0WjVVS0VG?=
 =?utf-8?B?cGxTditsQXdkT2wxSE5ITXFPVUMzOHVnOUl2T2ZSZU5KTHcrcTM1Y28zWmc1?=
 =?utf-8?B?NS9nb3czb0FuWFE1anlBaVZCMWRkU09jNDcxMFZhS0J1RHM1TmNBNHhkSDNz?=
 =?utf-8?B?bHNQUGdtRUJoZzdxQ20rbHFJWXY5RTVWdnZtMUxJTWp6NzJEN0wvRXJLRld0?=
 =?utf-8?B?TnZDeFRPbUR5UEhXcUFDQlVwLzdLMmxQbjByeHhsWm13YXVFd2xUSWdabXlw?=
 =?utf-8?B?T2hSM1JXbVUwL3NzVk1QY3lUOFdGRWROWnRVUXpWTGhLRDJaUWZoTk84clBH?=
 =?utf-8?B?bkNaQnkxMVMxbmlmaytFcXlMRmhLTUhWeHZ1YXFORzE2bTgzMTR4eFNPUUUy?=
 =?utf-8?B?U3Y5K0Y0SXN5VjVmbXRqd2pYRHdqZEFHQ2tXRVViZ0h6NGN2NFoxMjFBZkxu?=
 =?utf-8?B?eEFYK2xkSUg4MTVoMzhxOHl3Q2NDU2pvS0V1RnpKYmhSakNNOVpaVDRuWUxu?=
 =?utf-8?B?QkFSUnhFNW9JUkErQS9PTC9Jbk9GN3hTSTNjNXhqRGV2eDdkaU5mT2RiTkhY?=
 =?utf-8?B?UVg5MVh5WGRxZDJqdTEybjdVT3RPaXFzakR4NEpXbkU2NjJxc2V2bFFWeTdY?=
 =?utf-8?B?SGlYdGZ0WGpOWGlEUnR4N2ptdnBZREZwOGU1dUpOYkdEMEpZM0FuYkdqc0ll?=
 =?utf-8?B?VWZuKzVzR3M1dEZvazFnZ1YvTEI3K21oTytzVjBnMjMxM1hMb29IbCtCdzBF?=
 =?utf-8?B?YlBKRTBXTHZxeExBa013ZEgvTnFhM1NCYlFLMG1wYnZsZFBLeGlPNHZhckhv?=
 =?utf-8?B?N29mMGlESVdlbHRIK2syZlFhZ1lVMUozTlBPYW1wUGhHbWJya0Z4c3BWcytY?=
 =?utf-8?B?blJtZ01VUG0zaklOWGtCSzdubkdhRTVqOFF4bjVWMUVnNnI3dUJGQktTSUsy?=
 =?utf-8?B?VHRPY1RGUGlFZ29DaGpWNkwyNTJFUlllQ1cxMHdadEZ0a0l1eXlpR3F5VlRa?=
 =?utf-8?B?SEtiUUJZc1A0ODc1OGNZME1aMG9BSUdpNG1sbkhqbXNDZkxoNHZOdjM5SU0v?=
 =?utf-8?B?ejVoNWtCYWlXZklva2hJT1hUN0t6WmxNZ2NhMVl2TzRUbTRXb2xZbHBtSzRH?=
 =?utf-8?B?WG4yOXhGUUlHOXE0K2RwTWl2R3IxRTJtYjBydm1Zdk54MTNBbU1MTkc2cDlU?=
 =?utf-8?B?cElOOVNMelByZEJEYVE3VFFYWERxeWxMRHBpOWxYaWlxVmpKRTgrU2dUbldQ?=
 =?utf-8?B?UENsL3EvOHlxL3pKRnBFVVBqT0V3OE45UGdtdU5uQ0dDVzVTT2RhVEtBZWxl?=
 =?utf-8?B?eUJJdktyUVB1WWUvU2FjSlFrNFBiQzZWUVBTZHoxV3hrY05sRVZ3UmRweDRD?=
 =?utf-8?B?Zm04dGxwZ2s3MnpSOUVIaVMrMklYZFBOb2EyOUJYZ2V6b1VLclppZkp2T1Y1?=
 =?utf-8?B?cXpINk80V0s2LzhGRmhoZ1hDaFBQNlQ4eVh3UVRKdEZiQS9JckFwR2hRdy8x?=
 =?utf-8?B?Tnk2U0syY0hQaXhRWkdCNjVwZnN2aEhSdzhnUjhzMlgwSGlaaWUvaHljdHlQ?=
 =?utf-8?Q?hQv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b3603a-6663-4f60-cf04-08dbbe564b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:03:24.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjkLlKjRK9rmqyjur6Jh0jBVVj3j0dRmnjdN9/a7eWplN8Lz/u9vwMv4MzhcTlIMvPlgJSkAamSJD2XMNv3Sog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDExOjA3IEFNDQoNCj4gPiAxLiBjb3ZlciBs
ZXR0ZXIgaXMgbWlzc2luZyB0aGUgcHJvYmxlbSBzdGF0ZW1lbnQgYW5kIHVzZSBjYXNlDQo+IEkg
b25seSByZXBseSB0byB0aGlzIHNlY3Rpb24gb2YgY29tbWVudHMsIHRoaXMgZG9lcyBub3QgbWVh
biBJIGFncmVlIHdpdGggeW91IG9uDQo+IHlvdXIgb3RoZXIgc3RhdGVtZW50cywgSW5zdGVhZCBJ
IGFncmVlIHdpdGggSmFzb24gb24gaGlzIHJlcGxpZXMgdG8geW91Lg0KPiANCj4gSW4gbXkgY292
ZXIgbGV0dGVyOg0KPiAiVGhlIG1haW4gdXNlY2FzZSBvZiB0aGVzZSBuZXcgZmFjaWxpdGllcyBp
cyBMaXZlIE1pZ3JhdGlvbi4iDQo+DQo6KQ0KVHdvIGxldHRlciB3b3JkIGRvIG5vdCBleHBsYWlu
IHRoZSB1c2UgY2FzZSBvZiB3aHkgaXMgYXNraW5nIHRvIG1lZGlhdGluZyBhIG5hdGl2ZSB2aXJ0
aW8gZGV2aWNlLg0KDQpBbmQgeWV0IHlvdSBjYWxsIGlzIHRoZSBiYXNpYyBmYWNpbGl0aWVzLg0K
QW55d2F5cyB5b3Uga25vdyB0aGUgbWlzYWxpZ25lZCByZXNwb25zZSBpbiBlbWFpbCBhbmQgY292
ZXIgbGV0dGVyIGlzIGV2aWRlbnQuDQoNCj4gRGlkIHlvdSBtaXNzIGl0Pw0KTm8uDQpJdCBtaXNz
ZXMgdGhlIGRldGFpbCBhcyBJIGRlc2NyaWJlZCBpbiB0aGUgdGhlb3J5IG9mIG9wZXJhdGlvbiBk
ZXNjcmliZWQgaW4gWzFdLg0KDQpbMV0gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNo
aXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDkvbXNnMDAwNjEuaHRtbA0KDQo+ID4gMi4gd2h5IHF1
ZXVlIHN1c3BlbmQgYW5kIGJvdGggZGV2aWNlIHN1c3BlbmQgYXJlIGludHJvZHVjZWQsIG9ubHkg
b25lDQo+IHNob3VsZCBiZSB0aGVyZS4gVGhlIGRlc2lnbiBkZXNjcmlwdGlvbiBpcyBtaXNzaW5n
Lg0KPiB0aGVyZSBhcmUgbm8gcXVldWUgc3VzcGVuZCwgdGhleSBhcmUgZGV2aWNlIHN1c3BlbmQg
YW5kIHZxIHN0YXRlIGFjY2Vzc29ycy4NCj4gcGxlYXNlIHJlYWQgdGhlIHBhdGNoIGlmIHlvdSB3
YW50IHRvIGNvbW1lbnQuDQo+ID4gMy4gRXZlbiB0aG91Z2ggaXQgY2xhaW1zIHVuZGVyIHNvbWUg
cmFuZG9tIGJhc2ljIGZhY2lsaXR5LCBjb3ZlciBsZXR0ZXIgY2xlYXJseQ0KPiBzdGF0ZXMgdGhl
IG1haW4gdXNlIGNhc2UgaXMgImxpdmUgbWlncmF0aW9uIi4NCj4gaXQgaXMgbm90IHJhbmRvbSwg
dGhleSBhcmUgcHJlY2lzZWx5IGRlZmluZWQgdmlydGlvIGJhc2ljIGZhY2lsaXRpZXMuDQo+ID4g
NC4gUGF0Y2ggNCBpcyBub3QgbmVlZGVkIGF0IGFsbC4gV2hlbiBkZXZpY2UgaXMgc3VzcGVuZGVk
LCBpdCBpcyBfc3VzcGVuZGVkXy4gSXQNCj4gZG9lcyBub3QgZG8gYW55IGJpZnVyY2F0aW9uLg0K
PiBUaGUgZGV2aWNlIHNob3VsZCBub3QgYWNjZXB0IHZxIHJlc2V0IGFuZCB0aGUgZHJpdmVyIHNo
b3VsZCByZXNldCB2cXMsIHBsZWFzZQ0KPiByZWFkIHByZXZpb3VzIGRpc2N1c3Npb25zIHdpdGgg
TVNUIGFuZCBwbGVhc2UgZG9uJ3QgaWdub3JlIHRoZSBjb25jbHVzaW9ucw0KPiA+IDUuIG9ubHkg
c3VzcGVuZCBiaXQgb2YgcGF0Y2gyIGlzIG5vdCBlbm91Z2ggdG8gY292ZXIgUDJQLiBPbmUgbmVl
ZHMgc3VzcGVuZA0KPiBhbmQgZnJlZXplIGJvdGggY292ZXJlZCBpbiBzZXJpZXMgWzFdLg0KPiB3
ZSBoYXZlIGRpc2N1c3NlZCB0aGlzIGZvciBtYW55IHRpbWVzLCBQMlAgaXMgb3V0IG9mIHZpcnRp
byBzcGVjLCBkbyB5b3Ugd2FudCB0bw0KPiBtZWRpYXRlIGV2ZXJ5IFBDSSBzdGF0ZS9mdW5jdGlv
bmFsaXR5Pw0KPiA+IDYuIEZpbmFsbHkgdGhlIHdob2xlIGRlc2NyaXB0aW9uIG9mIDEgdG8gNCBu
ZWVkIHRvIGJlIHNwbGl0IGluIHRoZSBkZXZpY2UNCj4gb3BlcmF0aW9uLCBzbyB0aGF0IGJvdGgg
cGFzc3Rocm91Z2ggYW5kIG1lZGljYXRpb24gY2FuIHV0aWxpemUgaXQgdXNpbmcgYWRtaW4NCj4g
Y21kIGFuZCBvdGhlcndpc2UuDQo+IERvIHlvdSBzZWUgYW55IHJlYXNvbnMgdGhpcyBzb2x1dGlv
biBjYW4gbm90IGJlIHVzZWQgZm9yIHBhc3N0aHJvdWdoIGFuZA0KPiBtZWRpYXRpb24/DQpSaWdo
dC4gUHJvcG9zZWQgc29sdXRpb24gZG9lcyBub3QgbWVldGluZyBmb2xsb3dpbmcgcmVxdWlyZW1l
bnRzIGFkZHJlc3NlZCBpbiBbMV0uDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0
aW8tY29tbWVudC8yMDIzMDkwNjA4MTYzNy4zMjE4NS0xLWxpbmdzaGFuLnpodUBpbnRlbC5jb20v
VC8jbTdlZmJhYWRiYzczZjAzM2MyNzkzZDllYjFlYjBhZmEyMTBhYWU0YmUNCg0KWzFdIEkgcmVw
bGllZCB0byBKYXNvbiBpbiBwcmV2aW91cyBlbWFpbC4NCkkgd2lsbCByZXBlYXQgaGVyZS4gVGhl
eSBhcmUgY292ZXJlZCBpbiBbMV0uDQoNCjEuIE1pc3NpbmcgUDJQIHN1cHBvcnQNCjIuIE1pc3Np
bmcgZGlydHkgcGFnZSB0cmFja2luZw0KMy4gSW5jcmVtZW50YWwgZGV2aWNlIGNvbnRleHQgZnJh
bWV3b3JrIGZvciBzaG9ydCBkb3dudGltZQ0KMy5hIEFiaWxpdHkgdG8gZG8gaW5mbGlnaHQgZGVz
Y3JpcHRvciB0cmFja2luZw0KNC4gQWJpbGl0eSB0byBkbyB0aGUgd29yayBmb3IgbXVsdGlwbGUg
bWVtYmVyIGRldmljZXMgaW4gcGFyYWxsZWwuDQoNCg0KPiBPciBkb2VzIGZlYXR1cmVzX09LIHdv
cmsgZm9yIHBhc3N0aHJvdWdoIG9yIG1lZGlhdGlvbj8gQW55IGRpZmZlcmVuY2U/DQpJdCBkb2Vz
IG5vdCB3b3JrLiBQYXNzdGhyb3VnaCBkZXZpY2VzIGFyZSBub3QgdHJhcHBlZCBieSB0aGUgaHlw
ZXJ2aXNvci4NCg0KPiA+IFNpbmNlIFpodSwgdG9sZCB0aGF0IGRpcnR5IHRyYWNraW5nIGFuZCBp
bmZsaWdodCBkZXNjcmlwdG9ycyB3aWxsIGJlIGRvbmUsIEkNCj4gcHJlc3VtZSBoZSB3aWxsIHBy
b3Bvc2UgdG8gZG8gb3ZlciBhZG1pbiBxIG9yIGNvbW1hbmQgaW50ZXJmYWNlLg0KPiA+IEFuZCBz
aW5jZSBhbGwgY2FuIHJ1biBvdmVyIHRoZSBhZG1pbiBjb21tYW5kcywgdGhlIHBsdW1iaW5nIGRv
bmUgaW4gMSB0byA0DQo+IGNhbiBiZSBtYWRlIHVzaW5nIGFkbWluIGNvbW1hbmRzLg0KPiBObw0K
U3VjaCBuZWdhdGl2ZSBhc3NlcnRpb24gZG9lcyBub3QgaGVscC4NCkV4cGxhaW4gd2h5IHBhcnQs
IGxpa2UgaG93IEkgZXhwbGFpbmVkIGFib3ZlLg0KDQo+ID4NCj4gPiBVbnRpbCBub3cgd2UgY291
bGQgbm90IGVzdGFibGlzaCBjcmVhdGluZyB5ZXQgYW5vdGhlciBETUEgaW50ZXJmYWNlIHRoYXQg
aXMNCj4gYmV0dGVyIHRoYW4gcSBpbnRlcmZhY2UuDQo+ID4gU28gLi4uDQo+ID4gVG8gbWUgYm90
aCB0aGUgbWV0aG9kcyB3aWxsIHN0YXJ0IGxvb2tpbmcgbW9yZSBjb252ZXJnZWQgdG8gbWUgb3Zl
ciBhZG1pbg0KPiBjb21tYW5kIGFuZCBxdWV1ZXMuDQo+IEkgZG9uJ3QgdGhpbmsgc28sIGFnYWlu
LCB3ZSBhcmUgaW50cm9kdWNpbmcgYmFzaWMgZmFjaWxpdGllcyBhbmQgdGhlc2UgZmFjaWxpdGll
cw0KPiBkb24ndCBkZXBlbmQgb24gb3IgcmVseSBvbiBhZG1pbiB2cS4NCklmIHNvLCBzdG9wIHRo
ZSB3b3JrICJsaXZlIG1pZ3JhdGlvbiIgZnJvbSB0aGUgY292ZXIgbGV0dGVyLg0KUmVsaWFuY2Ug
b2YgYWRtaW4gY29tbWFuZCAoYWdhaW4gbm90IHZxLCBiZSBjYXJlZnVsIHdoYXQgeW91IGNvbnN0
YW50bHkgY2xhaW0pLg0KTm90IHJlbGlhbmNlIG9uIGFkbWluIHF1ZXVlIG9yIGFkbWluIGNvbW1h
bmQgZG9lcy9kb2VzIG5vdCBtYWtlIGl0IGJhc2ljIGZhY2lsaXR5Lg0KDQpBZG1pbiBjb21tYW5k
cyBhbmQgcXVldWVzIGFyZSBhbHJlYWR5IGluIGJhc2ljIGZhY2lsaXRpZXMgc2VjdGlvbiB0b2Rh
eS4NClNvIGNsYWltaW5nIHRoYXQgaGV5IG9uZSBpcyB1c2luZyBhZG1pbiBjb21tYW5kcyB0aGF0
IG1lYW5zIGl0IGlzIG5vbl9iYXNpYyBmYWNpbGl0eSBpcyBub3QgY29ycmVjdC4NCg0KPiA+DQo+
ID4gUGFzc3Rocm91Z2ggd2lsbCB1c2UgdGhlbSBvdmVyIG93bmVyIGRldmljZS4NCj4gPiBNZWRp
YXRpb24gc29tZWhvdyBuZWVkIHRvIGRvIG92ZXIgbWVtYmVyIGRldmljZS4NCj4gPiBNZWRpYXRp
b24gd2lsbCBub3QgdXNlIGFueSBkZXZpY2Ugc3VzcGVuZCBjb21tYW5kIGJlY2F1c2UgaXQgbmVl
ZHMgdG8NCj4ga2VlcCBiaXNlY3RpbmcgZXZlcnl0aGluZy4NCj4gcGxlYXNlIHJlYWQgUUVNVSB2
aG9zdCBsaXZlIG1pZ3JhdGlvbiBzb2x1dGlvbg0KQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIHBv
aW50ZXIgdG8gaXQ/DQoNCkkgYW0gZmFtaWxpYXIgd2l0aCBbMl0gYW5kIGl0IGRvZXMgbm90IHJl
cXVpcmUgZGV2aWNlIHN1c3BlbmQgZmxvdyBhcyB0aGluZ3MgYXJlIGJpc2VjdGVkLg0KDQpbMl0g
aHR0cHM6Ly9xZW11LXByb2plY3QuZ2l0bGFiLmlvL3FlbXUvaW50ZXJvcC92aG9zdC11c2VyLmh0
bWwjaW50cm9kdWN0aW9uDQo=

