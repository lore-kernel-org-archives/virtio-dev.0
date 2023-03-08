Return-Path: <virtio-dev-return-11555-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB46C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 22:30:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B6522A833
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 22:30:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4C939866F9
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 22:30:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D4E42986312; Wed,  8 Mar 2023 22:30:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2DE1986414;
	Wed,  8 Mar 2023 22:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngjn9gQVNhD/KqO+aUGDl6hwJoMEjygl5ClCzMOIzINvvSK45u33iNBADvL2hQ3QflIMMTbnbQRfWXw0E+5UnZLmOUPiUs/TJ59ZiSD+EMUp7gzbDyUKwu9KHUDneLhSeAL8xWqmP9AwCOvglZns47Q+c1w4Qm4kGpToAtZHh0UcGuMF2S41AVHxidoTH4K665MFfrF6j2jJEEkIojOJY+X4hT/hD3Wxo9wXAxDqHAMTu4Onx1j145VdUiDLbz6lVoqII7OjXEv73VvGvCsCYxfri96BUBAjaRjzI8oYNz6DkKnxLWmWolX5bGS77Nfa+8CUJFB85oH7oc0NJuOClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/yFbvmdrMnTWrxI8xbrlEWGvSbungOkPKHjIFTA4ps=;
 b=gFdqjGDro819PSN/F0UFP69X6anTfbPlyYt9N2NgxbAKVS4sFYTmFZ+cUtvIZNzpm1siZBvupCIYmJt4X7oksAznAY+5iOumVxOgITJ6MIDPSdMBSDK5aHyZnw4GnVzfGlq4H4KcWXzSJkquKEtHsjIkMLf3LXFuy9PEHcJyAX+75OG2eF6O06gjeeAiHqe2/5F7fqukdbdAAUVyhba4TDZ1ESS/2RBUm+U4oP1oDXXVvaJvy0b936EPOMcRxvWx2AppvpDFSyrRSylTnrCGBIUBwnUCP9NrGTjjQEu0gPc8+jZ7PB35GJWwV5oGy3h3XHrNK5XvrpMra3MOPZrNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Alvaro Karsz
	<alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] RE: [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation
Thread-Index: AQHZTEeWQwTFVtCRMEet8OSrJT5oDa7niZXwgADdyoCACRMOEA==
Date: Wed, 8 Mar 2023 22:30:50 +0000
Message-ID:
 <PH0PR12MB5481969B2173A3AB7ABDFB19DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <817a8cef-21cf-a010-b21d-050c1328c8a0@linux.alibaba.com>
In-Reply-To: <817a8cef-21cf-a010-b21d-050c1328c8a0@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7551:EE_
x-ms-office365-filtering-correlation-id: 6dc8870f-8b3c-453a-f330-08db2024c523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CjXMhuifLmltKIM16bSbRerdsZtm7fTtT0AYYFMIOsrxSkpxvARzjJ/DRfbBYc8YpJK4jZp4sRgiP8I+dKDj9eb6MYkbPuvvpWupfWQluFnF3AYL62hwRIVKx8ooqDMvdEJQyW7/fcot3txSNcJZXnHFVgVHmoZN0XZCM2i84grS2k6/Cq2qB2WUqpReCWOsfwu/BNsPuTlUWED9uh6SeiMnKAsJHnMSr8RKakNd/qrgt4MWvbpbsYOQYhj7x1vxWnfRPbyS50Ud9f4ApvdxMme84/exv9JKge3kgNBSQk0u+7fVX6I0excBDfzdpihGhEJHZT/mRKEeNZIlLjkw5RDxMdgjQxzI9Rrx1luxv7xQ14Hv8NAbopg/WjrFmyycAnIoZJkRd+VgTSHt1H++TFBjEj67VVvvM6mEtOYKGmX4H7/svnrFNLhZgA9Ls08HKDPLmvOXBTdQNrQ0Ni9LrXQrZ4FInp6mV+2u3Y6be/Pw4DLg4/ZKkNarMSOabP0hXIzYz2SMzfe7E5fNh7Mt4biXCD3O7/SvE7g9yQGeRR+X5UG+GTGnRwzKK05ART/5FFGp7fdGZlUKXmR9OKAEUIMZtIocwM8o3HeKK/+3TteSKiYZkv3R1eUWHVD4GGOk9tDtsxcuP2dpMaHpabwRwlh30QYU7Y6qVwzqKOXXQgVSEkkwsP8HPGSegUiTySQzwAIc2aDHXTZU+iwFtZj1XA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(54906003)(316002)(33656002)(110136005)(186003)(38100700002)(6506007)(122000001)(38070700005)(55016003)(86362001)(83380400001)(9686003)(8936002)(5660300002)(7696005)(71200400001)(52536014)(66476007)(478600001)(4326008)(41300700001)(2906002)(66446008)(66946007)(8676002)(66556008)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHk3SE4za0lNa3BaQ0h6MGtRNFlRZFhSSFJSa3dGOUNFc2VBMUxta3NvbHJL?=
 =?utf-8?B?N1M4TTRCbXlpcUluQlNsSTB5YVU1MFFEV2ZRMWpaQXRaMnR0azRhQzFNdzcz?=
 =?utf-8?B?eTlUZ2lPdnV4TW5VQjhzV3J2TWNuTmlWL2hIK3RzTnN3TU9FeklQQUlBeERr?=
 =?utf-8?B?ZFdBUFdXSlFZSHdPTlZVWmFyRXJkTXZmcjFWL2xnejN0czVRVFZCRWRXUzFi?=
 =?utf-8?B?NER6YVVPekx5OEVRVjhYbzJXa2J1SFBKVFMzZ1VaTGt3dmU2dm5BT09SWnJY?=
 =?utf-8?B?TXdzYmw4aFUycC91UFJQNUlNQngrK09yTGV1YUZwT0g0VFJRL04wZVhheHdZ?=
 =?utf-8?B?N2dTRThXaHY1NjB1bFMrbkZYbDBReFpGL2FMVllWamd1U0s1T0NnUHZDOVE4?=
 =?utf-8?B?UzE5SFc5WlpDcTI5NnJYQzIwR3NZVEYycTlOUWNqSUowWUZBeG0zS3RwL2Er?=
 =?utf-8?B?QTROQXBKUjR3M3NnazVxT0Zsb29aZnl1NzdGdnphSWNvNjdHOURuTTRidDli?=
 =?utf-8?B?c1h5RjV2UUNrdFZCc0RSdHh6SUVVOXFEWWxVUmZETUtuYUc3azBDTStXYWFI?=
 =?utf-8?B?OWd6Qjc4T0dqdndYcEljY2k5My94dklwNVdMd3BWaU0vdVpCMldJNGRNSVFn?=
 =?utf-8?B?NkVWZ2NnQ1c2UHpDM0R0UTg4eEM0eitpUWh0M0pERHpqb3RnTFpJNjhpK1Nh?=
 =?utf-8?B?OEZobWU0djRPMUdqSTNsL1ZLS2dES1lZU203ZTYxSmt4NC96M1IvTkhpR2FT?=
 =?utf-8?B?RzNuODFqOWdnODAxaVRlSFRQUHZ0SFplQnMvQkc5MnB2U3hxNTVDdGFDWVc3?=
 =?utf-8?B?ajcwY2wrcHNodFlZdnhkWmQrR2k3ampmTUNOVE9NWUcvTmFXemxocWlrVFdq?=
 =?utf-8?B?RHZ1R05UK1J6NmkvYVFDNG9yb3ByNGx2VVFQV0J6UzcxejZxMTFpVzZtcTNw?=
 =?utf-8?B?ZnBGRU5mVzdjelgvaFRJQm1QZk1vUit1QjJDdTFFdlo0aFJuZG9HaXlCNFMr?=
 =?utf-8?B?SXFodm1EZWJjSTZHb2pSQmtteDc4K3pNS2ZodkNwejZ5NFVpbmI2VFpNTUl5?=
 =?utf-8?B?YTdJZ1I5a3pFQjlwOXZkaGZ3SzROUjhEanVyMWJCVjh0aDFrZHFUaWdnN2ZW?=
 =?utf-8?B?Y1labUlDbkpIa3VVS1g0OC9rYTZNUkhUK215bERCUUgvVC9xVU5aWUc5d0p5?=
 =?utf-8?B?Nm5WRkwzdFg3UUQ0eFIwVzFjZUxmd1FMcUhWYkhyaFBDMEVlbnBUYkNyTEVL?=
 =?utf-8?B?UjhRaE5OS2lXdGswWVhNM0F6MVdiQktzWEJLYW43aFNyZTBnOS9tYmtmaHFF?=
 =?utf-8?B?S2VxL3BHYWJVUCtIZkJYVEczZDdiSEY2UU9rVGxVWXpMTlJXV1hWQU9wUVo4?=
 =?utf-8?B?ZzFuTUNHRm5Jb3ZrM3BhWGtYSlhlMnVUS09IUXFNNlN6V1ZSalhMZExlK1NZ?=
 =?utf-8?B?RElzREVXVGRWd29lU3IzRlVxWDljbVd6WjZnWkJkeU50REJQSDZDb2x3SFdD?=
 =?utf-8?B?VW9SZzNPaHBuVnQ5SzdBUnVnZFJBYjFENXJ5a3Z4a1ltYnZISDJaTXNWY1Vw?=
 =?utf-8?B?Z21nTFJqcStURkt4YWlja3EwNFltRlFaMS9Za05md1NDV3BFZ29qcFdONWpa?=
 =?utf-8?B?ZnBMZm8vNmtQK3hKMHFGOWcyYmxGRTJzclJadXEzK2FvczA3Mlhldnl1all5?=
 =?utf-8?B?dnlFZFc2WThXUWtYWlc0Nm1sTmJBbkJ2UmZHR1h1L3FUMW5jNDUzNXVUSmRY?=
 =?utf-8?B?WGRvR2IxV0tacEpocHExZmNOejF1MGFKVWIrODIreSs2dWl5Q1RNL09kQVJM?=
 =?utf-8?B?ejZZbVYzYkhBZ1Noem9jUHpPc21LdzlwKzJEYnpqd2I4MTZ5anpHakpRcHpi?=
 =?utf-8?B?dS83eG96RVZubVRXcmZLZ0FLWkNGRzNmeGhqQjhkd2ZIZWZkM21CK0M4Uytt?=
 =?utf-8?B?aDBwS2FwdFNTeW9uOTNrS1pKSytVSkQrRWovalNVU1B5Q081VzhWVTdIWkZ6?=
 =?utf-8?B?ZnpxYnBUNnozenlKRFNzNWFqenRnK3QrMGNmbFFJUlpwblM1M0Q1ZjljYytC?=
 =?utf-8?B?RkJIN1RUNmNJOStaTy9RaFhCQnN3N2R0dW1VZnRUdVFFTjZUVTJoVnhNNHdV?=
 =?utf-8?B?bEtLSVY4TjNib28zQnZDdW5LOFRGcEMxOHBHSEt5TysxTUl2YUpEZnBTRHg1?=
 =?utf-8?Q?nfTS3ShFhQJL8VlEa0NySFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc8870f-8b3c-453a-f330-08db2024c523
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 22:30:50.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/xgXzj5ToScs1UOLez4BJm21d8OigfXt0/6an2ahslJc7XFCR2l/8/8gFGXPO6v4haySlWtuPiHW9uF/de3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
Subject: RE: [virtio-dev] RE: [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation

DQo+IEZyb206IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmcgPHZpcnRpby1kZXZAbGlz
dHMub2FzaXMtb3Blbi5vcmc+IE9uDQo+IEJlaGFsZiBPZiBIZW5nIFFpDQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAyLCAyMDIzIDEwOjI3IFBNDQo+IA0KPiA+IEkgcmVtZW1iZXIgd2UgZGlzY3Vz
c2VkIHRoYXQgaW5zdGVhZCBvZiBtZW50aW9uaW5nIGVhY2ggaW5kaXZpZHVhbCBmaWVsZCwNCj4g
YmV0dGVyIHRvIGRlc2NyaWJlIHRoZSB3aG9sZSBzdHJ1Y3R1cmUgYmVpbmcgcmVhZC1vbmx5IG9y
IHdyaXRlLW9ubHkuDQo+IA0KPiBDb25zaWRlciB0aGUgZm9sbG93aW5nIHNjZW5hcmlvczoNCj4g
MS4gQSByZWFkLW9ubHkgZmllbGQgb2YgdGhlIHN0cnVjdHVyZSB2aXJ0aW9fbmV0X2N0cmxfY29h
bCBpcyBleHRlbmRlZCBmb3INCj4gQ1RSTF9OT1RGX0NPQUxfUlgvVFhfU0VUIHRvIGdldCBzb21l
IGV4dHJhIGluZm9ybWF0aW9uIA0KQSBzZXQgY29tbWFuZCBjYW5ub3QgZXh0ZW5kIHRoZSBzdHJ1
Y3QgdmlydGlvX25ldF9jdHJsX2NvYWwsIHBhcnRpY3VsYXJseSBmb3IgcmVhZC1vbmx5IGFuZCBw
YXJ0aWFsbHkgZm9yIHdyaXRlLW9ubHkuDQpUaGlzIHdvdWxkIG1lYW4gdGhhdCBmb3IgdGhlIHRp
bnkgbnVtYmVyIG9mIGJ5dGVzLCBhbiBhZGRpdGlvbmFsIGRtYSBkZXNjcmlwdG9yIGlzIHRvIGJl
IGFsbG9jYXRlZCB3aXRoIHJlYWQvd3JpdGUtb25seSBwZXJtaXNzaW9ucy4NCkl0IHdvdWxkIGJl
IGluZWZmaWNpZW50IGZvciB0aGUgZHJpdmVyIHRvIGRvIHNvIGZvciB0aGUgU0VUIGNvbW1hbmQg
dG8gaGF2ZSB2cW4gYXMgd3JpdGUtb25seSwgcmVzZXJ2ZWQgYXMgcmVhZC1vbmx5LCByZXN0IGZp
ZWxkcyBhcyB3cml0ZS1vbmx5IGRtYSBhdHRyaWJ1dGVzLg0KDQpBcyBJIHRoaW5rIG1vcmUsIEkg
dGhpbmsgdGhlIHdob2xlIHNldCBjb21tYW5kIGZpZWxkcyBzaG91bGQgYmUgcmVhZC1vbmx5IGZv
ciBkZXZpY2UuIEJldHRlciB0byBkZXNjcmliZSBpdCB0aGlzIHdheSBpbnN0ZWFkIG9mIHNwbGl0
dGluZyBpbmRpdmlkdWFsIGZpZWxkcy4NClRoaXMgd2F5IGRyaXZlciBjYW4ganVzdCBkbyBhIHNp
bmdsZSBETUEgYWxsb2NhdGlvbiB3aXRoIHJlYWQtb25seSBhdHRyaWJ1dGVzIGZvciBzZXQgY21k
Lg0KDQpHZXQgY29tbWFuZCBkb2VzbuKAmXQgaGF2ZSBhbnkgY2hvaWNlIHRvZGF5IHRoZSB3YXkg
Q1ZRIGlzIHN0cnVjdHVyZWQgdG8gaXQgbGl2ZXMgd2l0aCB0aGUgbGltaXRhdGlvbi4NCg0KPiA+
IExvb2tzIGdvb2QsIGhvd2V2ZXIgeW91IGhhdmUgd2VsbCBjb3ZlcmVkIGluIHRoZSBkZXZpY2Ug
bm9ybWF0aXZlDQo+IHN0YXRlbWVudHMuDQo+ID4gU28gcG9zc2libHkgaXQgY2FuIGJlIHJlbW92
ZWQgZnJvbSBoZXJlLg0KPiANCj4gSSB0ZW5kIHRvIGtlZXAgdGhpcywgYXMgd2UgaGF2ZSBkb25l
IGluIHRoZSBwYXN0LCB3ZSBjYW4gaGF2ZSBub3JtYXRpdmUNCj4gZGVzY3JpcHRpb25zIGFuZCB0
aGUgY29ycmVzcG9uZGluZyBub24tbm9ybWF0aXZlIGRlc2NyaXB0aW9ucy4NCj4gDQpPay4gYnV0
IHBsZWFzZSByZXZpc2l0IGlmIHRoZSBkZXNjcmlwdGlvbiBjYW4gYmUgc2ltcGxlciB0ZXh0IHRo
YW4gdGhlIG5vcm1hdGl2ZSBsaW5lcy4NCg==

