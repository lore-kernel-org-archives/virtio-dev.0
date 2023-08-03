Return-Path: <virtio-dev-return-13433-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB14C04A94
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 02:56:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0951B79085
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 02:56:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 014309866DC
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 02:55:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E4915986699; Thu,  3 Aug 2023 02:55:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB41A9866C1;
	Thu,  3 Aug 2023 02:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa/MVlyBZ9KPMQK7WsOP5ybxMJJC1Y5ncZcLbV8pyjxyQchL6XPGxajnje7bF5hBWC5320W8OAp94LTd7SCgA9CWYG/bhOiSz+GTsC/emv+isbFRQDZvJOt3RbeVJCIPE5x+A79aaHyIROjcw9fAV0w4aM81lhsJGECY1TgiFKxwc7xPrbskCdSm6mPsKniExcy0dIeHMHfcaX8bX7WYz6qV5H0j3zU6U47kfAOtiS2cbhhuF6Gnjw1+HsKBGgAMDqCJINTHm1ZfIF1PwkSdrk/m2i4/e9+sFMZ0/ztZgQ25qTEwMzjELAY9kgK8oggjr4Qq8Jpfpf2htIiOS8Yu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeEuEv2LBreNdHCP5bmwd2KJCm/gCjEiMckwvK7Z9QE=;
 b=k8bdfYLZuyoHURq61pGY+GtBEJc4mnHeKYQKexEeqU4GppDNVzZ+PC2vi6unzNGKwR1+SeGpBDooojd4ztuUket/pPlaq9a7XP2bgh/MC3QOwxYpeSRvXXQGiWx4DXi2krVKIFlbbAT4tNftUUi0MzUD3GvB+1ePvzg7eWtci5eSFwrO9ohAKK01RhN2lxMi8Cg5prc1NJoaY9lWeaiyI0JiI4PxOEhk7naWQkHcdjZmbKZBIhVeqSwOPKdHeu7H5+Jc5HIqUlIsR8qaMR04kUZJ3VbwU7dk5RBAK0EIy/wohyPoQI4WBM5/3AqWloKClz+Lf2pL3ANNxFW25ehBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, Robert
 Beckett <bob.beckett@collabora.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Thread-Topic: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZuwRh6691cWFD3EGobeyAVCVbhK/W7j4A//+VJgCAAI+1gP//mKMAgACymgA=
Date: Thu, 3 Aug 2023 02:55:50 +0000
Message-ID:
 <BL1PR12MB5849EC8E7EE93D76AEB7030BE708A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849A2599DD46405262B8630E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54819BEBB889ACF23324B69EDC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB54819BEBB889ACF23324B69EDC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN2PR12MB3037.namprd12.prod.outlook.com
 (15.20.6631.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM4PR12MB5181:EE_
x-ms-office365-filtering-correlation-id: 927c568b-7dfa-4675-5ecc-08db93cd2504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RvVkpTYs0J+a4+B+lMTL+7Mh3dKIqOS/8Fy9PZUcFVoCGQbL2qkRHtBcgHuPJOZ3nwAoZK9SBmkQK+YK2Ixd7Zaow8z3qmrzLW87ihjPavSP3bmBfhf3paCrK86Vp6P9SwhFr2th3Gp5MSKRHCs1nzTRbdbXgAe06/cLPUTUgfCV5gTSq4k2Sjfq5wGeQNDx69QNAelMzBNK1JVC+nRVJIFAzAjCRGzVblwXglMT3qhnKz12Il74LF3notl8JcVVwDn0zYnJa/QTaYeCh0p5fuhVzopLjvsMPlmpGDm0aUn1CUUQSbp9NtHy0vr0Vkkmb1aqa1yx/SzOpRQ30gLu3RV17N/5do3z0GMDGLzmyWBwdSS3Jkpp49DY+prf2eHKdvQgktMnOroXr++Szm1/gWv+LjL0jXt46oXaGPIurBqwGHE85MEw9Gv5dLwyk8exYrGUto+XZfJqSSz9ino+E0q3urY03SRneFSqlCiktSaljIMqSUWgAZEZX2//UUVZzDGBdgTybfCRuSOFr3L+txtAXusSZVsPBqzkZGQ+QuhyBgIznPiiSjF54FRREzTcONRKoH8IHMHsl93eQbIlqWGnXMH0u/AU2FOLtrK+YhUv3sMW7AVd6nJ2g18KGTwQk8sVH0rZxE3nSgx+uAqJGw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(55016003)(52536014)(5660300002)(8936002)(8676002)(41300700001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(4326008)(316002)(2906002)(966005)(7696005)(110136005)(54906003)(71200400001)(9686003)(478600001)(122000001)(83380400001)(26005)(38100700002)(33656002)(6506007)(53546011)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVZLSVhyL1NaQWRBLzZ3bmpIaHlSL3RIMnNoQitvMkhRakNpbzRKbW93anpk?=
 =?utf-8?B?ckgwOTE1NkJKeTI5V0l4ZWJKSU85Y0tiVTZFc3lTQ1BsVzdPcUQzOW1tWVFM?=
 =?utf-8?B?Z0lGaDdFUjFXVmY4dlI3SXFJbjNKTzkvUUJxN0d5TmpTRTdhWFFSbUdHNDQ3?=
 =?utf-8?B?bVhGZWZ1NEFjMXBiMlFub3BNVDdicS94N3d2NGJRc0pCelliZzZRMEt2RUR6?=
 =?utf-8?B?N1ZidEd4NjV0OXZZanVHcnA0ZHgxazhPbkFkZFVmdnZuR0hTTmxha1p5cG00?=
 =?utf-8?B?a0xYUWZGZWFLK2FIb1Byb09tbUhpRWpka243SGpkd0hRSEtFU1BZMHRMRkJs?=
 =?utf-8?B?aElORkE2aVU3NEFyRmcxNFA2VUR4VGt0Mm5RdHNBK1NsN2FrblVzbDBnbXc0?=
 =?utf-8?B?anBvcE1UK1FrL1lSMWdiZlFVczVGd3BMb0ExcjVTL1BrTTZmSHl0UkFiem8y?=
 =?utf-8?B?aXNwMFJTZGxmakF3K1hOejZhUy9RdFZsU2RsMURYVHpkZjhSK0lhcnBYQjg2?=
 =?utf-8?B?Z0JZaVpiWlN6YlVEQnRXRExlbzdGVkhWc2hEdmRkT1lqYXRqTlZrSWVRdG9z?=
 =?utf-8?B?Y0l3OGxqZVpZbWZTaENLd1haRmRUR3JTVTEydk1uWUcwL0RsNk9heDZ5bnA0?=
 =?utf-8?B?YnRnTktsOTZRQlpJbEI3SEtRUktzNFNjQTJ2TEdvMXBkT0UzNG0wREFUNyty?=
 =?utf-8?B?OVp5TzFRY3g4Q0hwZ3pGM1J5aitNbHJZc3I5M0hzOHpFRFJoZE1MTTNIRWww?=
 =?utf-8?B?NmZJNzRCOGdFMHdFV2FJcW1lZUs4dlhpczAzbktZMTVjMWxvZ0dIcVBVanVv?=
 =?utf-8?B?LzZqN1VYT0JSbURIMG9tUWRsU1pEYmJyUzhjR0JWWHRSMngyVmJTcGhXNzVj?=
 =?utf-8?B?cWx5dCsvek1TdklHVklwRkxYalE1elNGRHI3QUVzYzNjV0FCelc5bDNTWWtl?=
 =?utf-8?B?eVM0WktzdGcwaENMd2RDdzdicU0yRzFydWhRWDNmRytKekp4UlVwS0l5aVVs?=
 =?utf-8?B?K3ZuQWpVZ3RtdnlqOGhYWnFsVWRaOFlMTzdJRVdVeXorU3pNZVhyS2ZqL2l3?=
 =?utf-8?B?ajdBQTlMWHVjS09vUUllZjlCaEg0Z2Y4UTFscS85S0VqQVFlb2tQZkpwdUtG?=
 =?utf-8?B?OHNEVmNkdnd6UDlUU3lFdGEvRW5LdjlLeXpmT2ozbDMvZjBSZ1NHeFA4dHNp?=
 =?utf-8?B?NE1Rb2pYV2xSZk9kR2MvVzkrOUw2ZnhVY082ZDJ5clhTbzYrUlNZdFFjQ0h2?=
 =?utf-8?B?dXExQm1JejQyUzdsZ0ZQN2NPMHdZOG5VS0t5ZUtZWkZlbmV5ZVY2UFlZUzd3?=
 =?utf-8?B?U09ua3o2YjlTMHBrWEh2UkxWQitkNWFnZ0lxNHBWSzNFaVU1Q0d6MmU2WmJu?=
 =?utf-8?B?NWhGTmJOL2E2cW5FM2ZCSitvR01XeG9oVlB1S1pPVWVQRWgrZ2ZEWVhwbkQv?=
 =?utf-8?B?RjR2WUY1VmtHeU1kT2JzWmdzVnlwMlAyVnhpYjhYazR2YkVrTUhCeVo2UXF5?=
 =?utf-8?B?UkwrVmttSno0bG9CSjBNOEZTK1Jha0h3OSs5VUttRGJqTFpVR2swaE1hTHRv?=
 =?utf-8?B?ZFMrUXdvS2VHNjdweXIyTVR1WDBwalN6d09aSzRnMU1XTVpveWFYRE1uODcx?=
 =?utf-8?B?TE9ONDJHemZ4SzU4WmV6UmQyVW9HSXF6U3lRM3FPYkxwZGk2UUdEb3VnblZt?=
 =?utf-8?B?aVpkQ0hITGgxdUw0M2x5aWNGKzc0akdHZEl2dmM3M0RVSGRKTWEyd1I4Qldh?=
 =?utf-8?B?bncvYVl1Slcvb0lFR0dlS0dpOGV4WWxNc1hoRlQ1V2d0T2NEYm5NbWZoamRU?=
 =?utf-8?B?WHBNeWRON2lrWlgxVDdzbndnWTZNU0xYS0tEL25VaXFFUktDcDRVRGxVTU1E?=
 =?utf-8?B?cldxN21Ua3puYmFoMDByY1lwMm8yVHFkWTJMK0QrT00wK0FhVTB1OWp0OE15?=
 =?utf-8?B?czN2enNKczBVdk9ESzhuYWF1RWdadG5GN0NKQlFCaGs3RUJpTWFwWVU1RUVN?=
 =?utf-8?B?UFdCdG5BaStBSDZuWWpIeVVmU2o4YTE4SWVneG5rQzdaK05XM0N3NnVqRjF0?=
 =?utf-8?B?YlF1Qy9Jck0xYlhEak53bmZSOXNJRzYrcUpWaWQ3WWJDVEVaN2tQQm5rNE15?=
 =?utf-8?Q?f6eU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <367C28B2652C5641A7721A8C537314F4@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927c568b-7dfa-4675-5ecc-08db93cd2504
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 02:55:50.1359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HELM9Gj3PP22XS1/fnbsa4sPnszfIjPgtaBB6gtGutGmBGT4Vd1Rx+mP0QBdkdkIPiNXlzoMiWK0rWxrKccYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
Subject: [virtio-dev] Re: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

SGksDQoNCk9uIDIwMjMvOC8yIDE1OjEzLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJv
bTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgMiwgMjAyMyAxMToyOCBBTQ0KPj4NCj4+IE9uIDIwMjMvOC8yIDEyOjQ5LCBQYXJh
diBQYW5kaXQgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+PiBGcm9tOiB2aXJ0aW8tZGV2QGxpc3RzLm9h
c2lzLW9wZW4ub3JnDQo+Pj4+IDx2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnPiBPbiBC
ZWhhbGYgT2YgQ2hlbiwgSmlxaWFuDQo+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDIsIDIw
MjMgODo1MSBBTSBIaSBhbGwsDQo+Pj4+DQo+Pj4+IERvIHlvdSBoYXZlIGFueSBvdGhlciBjb21t
ZW50cyBvbiB0aGUgbW9kaWZpY2F0aW9uIG9mIHZpcnRpby1ncHUgUzM/DQo+Pj4+IExvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIHJlcGx5IGFuZCBjb21tZW50cy4NCj4+Pj4NCj4+DQo+PiBIaSBQYXJh
diBQYW5kaXQsDQo+PiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuIExldCBtZSB0cnkgdG8gYW5z
d2VyIHlvdXIgcXVlc3Rpb24uDQo+Pg0KPj4+IEkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGhlIEdQ
VSwgc28gYSBkdW1iIHF1ZXN0aW9uIGlzLCB3aHkgdGhlIFMzIHN0YXRlIGlzIGdwdQ0KPj4gc3Bl
Y2lmaWM/DQo+PiBTMyBzdGF0ZSBpcyBub3QgZ3B1IHNwZWNpZmljLiBJIHRoaW5rIGRpZmZlcmVu
dCB2aXJ0aW8gZGV2aWNlcyBtYXkgaGF2ZSBkaWZmZXJlbnQNCj4+IGFjdGlvbnMvcHJvYmxlbXMg
d2hlbiBTMy4NCj4gSSBhbSBtYWtpbmcgYXNzdW1wdGlvbiB0aGF0IHRoZSBncHUgZGV2aWNlIGlz
IHBjaS4gOikNCj4gSWYgc28gY2FuIHlvdSBwbGVhc2UgdXNlIHRoZSB0cmFuc3BvcnQgc3BlY2lm
aWMgbm90aWZpY2F0aW9uIGZyb20gZ3B1IGd1ZXN0IGRyaXZlciB0byBub3RpZnkgdG8gcWVtdT8N
CkluIG15IGV4aXN0aW5nIGltcGxlbWVudGF0aW9uLCBxZW11IGlzIG5vdGlmaWVkIHRocm91Z2gg
aXQoZ3B1IGd1ZXN0IGRyaXZlciBxdWV1ZSkuDQoNCj4gDQo+PiBXaGVuIEkgZG8gUzMgb24gWGVu
LCBJIGZvdW5kIGd1ZXN0J3MgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5kIHRoZSByb290IGNh
dXNlDQo+PiBpcyBpbiB2aXJ0aW8tZ3B1IGJhY2tlbmQgaW4gUUVNVS4NCj4+IFNvLCB0byBzb2x2
ZSB0aGF0IHByb2JsZW0sIEkgY2hhbmdlIGNvZGVzIHRvIGxldCBndWVzdCBub3RpZnkgUUVNVSB2
aXJ0aW8tZ3B1J3MNCj4+IHN1c3BlbmQgc3RhdGUsIGFuZCB0aGVuIFFFTVUgd2lsbCBub3QgZGVz
dHJveSByZXNvdXJjZXMgdGhhdCB1c2VkIGZvciBkaXNwbGF5Lg0KPj4gUGxlYXNlIHNlZSBhdHRh
Y2hlZCBrZXJuZWwgYW5kIFFFTVUgcGF0Y2ggbGlua3MuDQo+PiBGb3IgYWJvdmUgcmVhc29uLCBH
ZXJkIHN1Z2dlc3QgbWUgdG8gYWRkIGEgbmV3IGZlYXR1cmUgZmxhZyBzcGVjaWZpY2FsbHkgZm9y
DQo+PiB2aXJ0aW8tZ3B1LCBzbyB0aGF0IGd1ZXN0IGFuZCBob3N0IGNhbiBuZWdvdGlhdGUgd2hl
bmV2ZXIgdG8gZW5hYmxlIGFib3ZlDQo+PiBtZWNoYW5pc20uDQo+Pg0KPj4+IENhbiBhIHRyYW5z
cG9ydCBzcGVjaWZpYyBzdXNwZW5kIHN0YXRlIGJlIHVzZWQgYW5kIGFwcGx5IHRvIGFsbCB2aXJ0
aW8gZGV2aWNlcz8NCj4+IEJhc2VkIG9uIG15IGxpbWl0ZWQga25vd2xlZGdlLiBEaWZmZXJlbnQg
dmlydGlvIGRldmljZXMgaGF2ZSBkaWZmZXJlbnQgdmlydGlvDQo+PiBxdWV1ZXMsIG15IG1vZGlm
aWNhdGlvbnMgbGV0IGd1ZXN0IHRvIG5vdGlmeSBRRU1VIGJ5IHVzaW5nIHZpcnRpby1ncHUncyBj
b250cm9sDQo+PiBxdWV1ZS4NCj4+IE90aGVyIHZpcnRpbyBkZXZpY2VzIGNhbid0IGdldCB0aGF0
IG5vdGlmaWNhdGlvbiB1bmxlc3MgeW91IGNhbiB0cmF2ZXJzZSBhbGwgdmlydGlvDQo+PiBkZXZp
Y2VzIGFuZCBub3RpZnkgb25lIGJ5IG9uZSwgb3Igb3RoZXIgZ2xvYmFsIG1ldGhvZD8NCj4+IEJ1
dCBmb3Igbm93LCB0aGlzIHBhdGNoIGlzIHRvIGFkZCBhIG5ldyBmZWF0dXJlIGZsYWcganVzdCB1
c2VkIGZvciB2aXJ0aW8tZ3B1Lg0KPj4NCj4gSWYgdGhpcyBpcyBkb25lIGF0IHRoZSBwY2kgdHJh
bnNwb3J0IGxldmVsLCBhbGwgdGhlIHZpcnRpbyBkZXZpY2UgYmVuZWZpdCBmcm9tIGl0IHdpdGhv
dXQgaW52ZW50aW5nIGluIGVhY2ggZGV2aWNlIHR5cGUuDQpJIHRoaW5rIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gaW1wcm92ZSB0byBwY2kgbGV2ZWwuIEJlY2F1c2UgdGhpcyBmZWF0dXJlIGlzIGEgY29t
cHJvbWlzZSBzb2x1dGlvbiwNCmlmIHJlc291cmNlcyBhcmUgZGVzdHJveWVkIG9uIHFlbXUgc2lk
ZSwgZ3Vlc3QgaGFzIG5vdCBlbm91Z2ggZGF0YSB0byByZS1jcmVhdGUgdGhlbSwNCnNvIHdlIGNo
b29zZSB0byBrZWVwIHRoZW0gd2hlbiBzdXNwZW5zaW9uLiBUaGF0IGlzIGEgdmlydGlvLWdwdSBz
cGVjaWZpYyBzY2VuYXJpby4NCg0KV2hhdCdzIHlvdXIgb3BpbmlvbiwgR2VyZCBIb2ZmbWFubiwg
YW5kIFJvYmVydCBCZWNrZXR0PyBBbSBJIHJpZ2h0Pw0KDQo+IA0KPj4+IEFuZCBjYW4geW91IHBs
ZWFzZSBhZGQgYm90aCB0aGUgcmF0aW9uYWxlIHRvIHRoZSBjb21taXQgbWVzc2FnZT8NCj4+IFN1
cmUsIEkgd2lsbCBleHBhbmQgdGhlIGRlc2NyaXB0aW9uIG9mIG15IGNvbW1pdCBtZXNzYWdlIGFu
ZCBhZGQgdGhlbS4NCj4+DQo+Pj4NCj4+Pj4gT24gMjAyMy83LzIwIDIwOjE4LCBKaXFpYW4gQ2hl
biB3cm90ZToNCj4+Pj4+IHYzOg0KPj4+Pj4NCj4+Pj4+IEhpIGFsbCwNCj4+Pj4+IFRoYW5rcyBm
b3IgR2VyZCBIb2ZmbWFubidzIGFkdmljZS4gVjMgbWFrZXMgYmVsb3cgY2hhbmdlczoNCj4+Pj4+
ICogVXNlIGVudW0gZm9yIGZyZWV6ZSBtb2RlLCBzbyB0aGlzIGNhbiBiZSBleHRlbmRlZCB3aXRo
IG1vcmUNCj4+Pj4+ICAgbW9kZXMgaW4gdGhlIGZ1dHVyZS4NCj4+Pj4+ICogUmVuYW1lIGZ1bmN0
aW9ucyBhbmQgcGFyYXRlbWVycyB3aXRoICJfUzMiIHBvc3RmaXguDQo+Pj4+PiAqIEV4cGxhaW4g
aW4gbW9yZSBkZXRhaWwNCj4+Pj4+DQo+Pj4+PiBBbmQgbGF0ZXN0IHZlcnNpb24gb24gUUVNVSBh
bmQgTGludXgga2VybmVsIHNpZGU6DQo+Pj4+PiAJUUVNVTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDIzMDcyMDEyMDgxNi44NzUxLTEtDQo+Pj4+IEppcWlhbi5DaGVuQGFt
ZC5jb20NCj4+Pj4+IAlLZXJuZWw6DQo+Pj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjMwNzIwMTE1ODA1LjgyMDYtMS1KaXFpYW4uQ2hlbkBhbWQuYw0KPj4+Pj4gb20NCj4+Pj4+
IC9ULyN0DQo+Pj4+Pg0KPj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+Pj4gSmlxaWFuIENoZW4uDQo+
Pj4+Pg0KPj4+Pj4NCj4+Pj4+IHYyOg0KPj4+Pj4gbGluaywNCj4+Pj4+IGh0dHBzOi8vbGlzdHMu
b2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA3L21zZzAwMTYwDQo+
Pj4+PiAuaA0KPj4+Pj4gdG1sDQo+Pj4+Pg0KPj4+Pj4gSGkgYWxsLA0KPj4+Pj4gVGhhbmtzIHRv
IEdlcmQgSG9mZm1hbm4gZm9yIGhpcyBzdWdnZXN0aW9ucy4gVjIgbWFrZXMgYmVsb3cgY2hhbmdl
czoNCj4+Pj4+ICogRWxhYm9yYXRlIG9uIHRoZSB0eXBlcyBvZiByZXNvdXJjZXMuDQo+Pj4+PiAq
IEFkZCBzb21lIGRlc2NyaXB0aW9ucyBmb3IgUzMgYW5kIFM0Lg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiB2MToNCj4+Pj4+IGxpbmssDQo+Pj4+PiBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2Fy
Y2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwNi9tc2cwMDU5NQ0KPj4+Pj4gLmgNCj4+Pj4+IHRt
bA0KPj4+Pj4NCj4+Pj4+IEhpIGFsbCwNCj4+Pj4+IEkgYW0gd29ya2luZyB0byBpbXBsZW1lbnQg
dmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4uDQo+Pj4+Pg0KPj4+Pj4gQ3VycmVudGx5IG9uIFhl
biwgaWYgd2Ugc3RhcnQgYSBndWVzdCB0aHJvdWdoIFFlbXUgd2l0aCBlbmFibGluZw0KPj4+Pj4g
dmlydGdwdSwgYW5kIHRoZW4gc3VzcGVuZCBhbmQgczNyZXN1bWUgZ3Vlc3QuIFdlIGNhbiBmaW5k
IHRoYXQgdGhlDQo+Pj4+PiBndWVzdCBrZXJuZWwgY29tZXMgYmFjaywgYnV0IHRoZSBkaXNwbGF5
IGRvZXNuJ3QuIEl0IGp1c3Qgc2hvd24gYSBibGFjaw0KPj4gc2NyZWVuLg0KPj4+Pj4NCj4+Pj4+
IFRoYXQgaXMgYmVjYXVzZSB3aGVuIGd1ZXN0IHdhcyBkdXJpbmcgc3VzcGVuZGluZywgaXQgY2Fs
bGVkIGludG8NCj4+Pj4+IFFlbXUgYW5kIFFlbXUgZGVzdHJveWVkIGFsbCByZXNvdXJjZXMgYW5k
IHJlc2V0IHJlbmRlcmVyLiBUaGlzIG1hZGUNCj4+Pj4+IHRoZSBkaXNwbGF5IGdvbmUgYWZ0ZXIg
Z3Vlc3QgcmVzdW1lZC4NCj4+Pj4+DQo+Pj4+PiBTbywgSSBhZGQgYSBtZWNoYW5pc20gdGhhdCB3
aGVuIGd1ZXN0IGlzIHN1c3BlbmRpbmcsIGl0IHdpbGwgbm90aWZ5DQo+Pj4+PiBRZW11LCBhbmQg
dGhlbiBRZW11IHdpbGwgbm90IGRlc3Ryb3kgcmVzb3VyY2VzLiBUaGF0IGNhbiBoZWxwDQo+Pj4+
PiBndWVzdCdzIGRpc3BsYXkgY29tZSBiYWNrLg0KPj4+Pj4NCj4+Pj4+IEFzIGRpc2N1c3NlZCBh
bmQgc3VnZ2VzdGVkIGJ5IFJvYmVydCBCZWNrZXR0IGFuZCBHZXJkIEhvZmZtYW5uIG9uIHYxDQo+
Pj4+PiBxZW11J3MgbWFpbGluZyBsaXN0LiBEdWUgdG8gdGhhdCBtZWNoYW5pc20gbmVlZHMgY29v
cGVyYXRpb24gYmV0d2Vlbg0KPj4+Pj4gZ3Vlc3QgYW5kIGhvc3QuIFdoYXQncyBtb3JlLCBhcyB2
aXJ0aW8gZHJpdmVycyBieSBkZXNpZ24gcGFyYXZpcnQNCj4+Pj4+IGRyaXZlcnMsIGl0IGlzIHJl
YXNvbmFibGUgZm9yIGd1ZXN0IHRvIGFjY2VwdCBzb21lIGNvb3BlcmF0aW9uIHdpdGgNCj4+Pj4+
IGhvc3QgdG8gbWFuYWdlIHN1c3BlbmQvcmVzdW1lLiBTbyBJIHJlcXVlc3QgdG8gYWRkIGEgbmV3
IGZlYXR1cmUNCj4+Pj4+IGZsYWcsIHNvIHRoYXQgZ3Vlc3QgYW5kIGhvc3QgY2FuIG5lZ290aWF0
ZSB3aGVuZXZlciBmcmVlemluZyBpcyBzdXBwb3J0ZWQgb3INCj4+IG5vdC4NCj4+Pj4+DQo+Pj4+
PiBKaXFpYW4gQ2hlbiAoMSk6DQo+Pj4+PiAgIHZpcnRpby1ncHU6IEFkZCBuZXcgZmVhdHVyZSBm
bGFnIFZJUlRJT19HUFVfRl9GUkVFWkVfUzMNCj4+Pj4+DQo+Pj4+PiAgZGV2aWNlLXR5cGVzL2dw
dS9kZXNjcmlwdGlvbi50ZXggfCA0Mg0KPj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4NCj4+
Pj4NCj4+Pj4gLS0NCj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+PiBKaXFpYW4gQ2hlbi4NCj4+DQo+
PiAtLQ0KPj4gQmVzdCByZWdhcmRzLA0KPj4gSmlxaWFuIENoZW4uDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KSmlxaWFuIENoZW4uDQo=

