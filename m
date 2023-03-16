Return-Path: <virtio-dev-return-11647-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6DDC6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 19:55:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA44077ED
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 19:55:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B25AB986455
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 19:55:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A8501986422; Thu, 16 Mar 2023 19:55:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9511498641F;
	Thu, 16 Mar 2023 19:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsJynZydPPi5z5xZd4Bzr+Mhhse8pcB9rul1h+4fAkQIVQNk1rrLOLD+xfuQproGiUBZe5Cg758zIkPtlpx/hvPlCzELxQIH34crVxLINFrgxe6w6d7lC4u7+gjJuKHKw2TBmI8cFtRA9lBrOZpnklf7BQG7wdUe4R/OEY7I7ChPD5mi/zaDfx2/aK3mSmgLlE8Qk2neZjTBZPOL9xCE33W04j5ZALFUZWAFsacg0fUHZHKdgQCE7kUYd/SQTHkr+CJk27Di6etCMfif+oTB8D2JTnNuArkBmu73wVFwW9yPrb8saqLNGr4xFpw91WH9NGzYFvvc248riz17Yq6P2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiiamSfSzJZIKJseB6jmut7qeRvQ0DUcVM6zWVPcFcs=;
 b=ABiqWpiMNCzlxB447AZjQXdzOcnvQXybj4544kxRjGFPuOxuK9yJGFFma5XjhqDvCQvDo0QDSmWlTUu3qAPQB2edmSnQvHgitpD1DZV9LtXVgAnqEqFXMad/MEjC+KPBj4B5SzPYB8xclgKnOEAC4YohFINoM0KssG2Ax+MtIoSYypsOyOXnc311E7BRSerhb8w/503/WklxOFx/Kkq4DZLk8hZrJnI58ruOYsVhRh5CZePLTU/FoTa3F1DisyVEZuOX5xhbfY1r3NtmvolC3AbNnu31Go9KUKnd0IVih/fRe44Pg0rZeyK8WmIPQU5JsqTPXPnR3q0vAJVxPw7uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [PATCH v10] virtio-net: support inner
 header hash
Thread-Index: AQHZUEMWOg/tmrA5m0KZeJICtD2pUq77Op6AgACmd4CAAKQOgIAA85cAgABWfiA=
Date: Thu, 16 Mar 2023 19:55:22 +0000
Message-ID:
 <PH0PR12MB5481E500DF200DD258C151BFDCBC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
 <9f6286ea-51b2-dcc0-86c9-66509d92d8c2@nvidia.com>
 <20230316133844.GB20524@h68b04307.sqa.eu95>
In-Reply-To: <20230316133844.GB20524@h68b04307.sqa.eu95>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6948:EE_
x-ms-office365-filtering-correlation-id: bef23a3a-5202-4d3b-ace0-08db265860be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TvTI/YWs9xhuaBvlrsd6Hfn9UNU+rYipz5kAm++drup7LUyam88MX3cuP3SFob9uQDv0YqxdpZCFE5iYbhJquD27Nni3DDTOecMbfEcGnZqmxCp16/x8wOl/laFVN/tKRwBoNdxcP29yUhjLedho21/2mN5kdUr1Z+ZiRLA360VAFDj5rLPjmpopOV5V3EQxvxjXQIQ83Qj8fqjymPkXJRcmq5vP1JVwmuHfp/t4YTOvpqemUOwWrnCIBx7ggLTrqZJAXVlJQL8mKfvKcpiU0oCDACWF7Bl8yHsMhQGApC1ZsOQ1UkN94LF9KTP64M2EoHf3xa3e+XKKEjCassXy1NlSuqqGg7I/oPE3MhJCaU3o+lN0siLw8cwJfN190glL0LtQZpqs5hd7yE2CUyxXgghFeJBJxrAgAnczfQZKtbiqrrcilxm7Hg4S0Q+7khqGBdQ7L1z53d7Blb4riLagiM+5r49VEM61U8GKv8XXzADheBcE8M7ueXXiHcAJl0eFtl4r3LGxMEGiEAs94cpfUZYzczquN0GwfrMHpyUGmaKIBg1BEC51Av0mF0f+DlXhqBaLQI+3kjUgWFUqhxo6kyCF06iP0IVb/XhTGsSBi2IcMExyk3PBZEUWf0VFB8h0YCcuoY4NiuwCW3PW0gp7FkDoGRSIyZO0lEmmL3RI0ZeBkxihFSg2Qq0OLe41JYVDhCQEmf61EFizH/rLfFquWQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199018)(86362001)(478600001)(8676002)(9686003)(71200400001)(186003)(55016003)(33656002)(6506007)(2906002)(7696005)(4744005)(5660300002)(41300700001)(4326008)(122000001)(64756008)(6916009)(66476007)(38100700002)(66946007)(66556008)(66446008)(76116006)(52536014)(38070700005)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MG41MVd6MkZKaC9sc2ZXZkU2aTNnWHRaZUVNc2V5Z01kTWRycHZnYTE1L0FQ?=
 =?utf-8?B?SFNzNy9kRmpBMHV4SXlZYTl5cXRhQW1ybURIcVJROEk3QUh5TW9QUVppQmtP?=
 =?utf-8?B?bjJhblJpUEdoZmxHQnhwazJSYk9PUXh2VzVtWjVTTmpqdS80Uk1ibzI2SEt5?=
 =?utf-8?B?SmJCWmZQMDZiNkpGZVJ5R2Jldi9GMG90K0JjTkN4aTZ6dkZ5V04weXB5SXZs?=
 =?utf-8?B?d3VRNThqWWJReG0wU2ZScC9rL242aGE4V2hoMU9HWG9kY1JQTnJGckhnd011?=
 =?utf-8?B?VHlrbXRXcWsyR0U3S2gxaXI1YkZiVEdHSzRxaFE1T3hDODIzVXdkZXRIekNK?=
 =?utf-8?B?UzU2dk5RNVF1R3o0TkUzUzFnd0dwN2t6bzljNHVlRmZxNnZMQ1MxM0M2YkR2?=
 =?utf-8?B?Yk8vU2lpNmRBaUM1Y0s2OHFmK29FYk1PUVZCL3dxZ09PenljUUNCVEJzbkpq?=
 =?utf-8?B?VkVrZDNsMyswL3p5NDdNQitEQWdqZEFiNzJJT1VvWjV2TjB2MFhpOUVIbTZ1?=
 =?utf-8?B?WVJwTjJLY3JTbEpTZmVrYVBaZFVSaFIyUDNGQ01XMWhUSVFQdDdhTEhOS1BK?=
 =?utf-8?B?RjZBLzUvL3U1RHIwTC9sK0dFTkdZNmhTMXVhQWV6cTFydThHWExCVDN4aXVJ?=
 =?utf-8?B?R3VQNXhoUVE2Wld3Tko4Mk9rNE50YmJsQWV0Qm1kZ1ZyQTRpWEQ1cCtCN1JV?=
 =?utf-8?B?WkZNd09QNG82WTZSOUd2S0kwckNsWWZSZkc3QXI0dkNsRUZicE40ZmNlWUZO?=
 =?utf-8?B?bThUMnhlM0wvMGIvbFB5ZGF3Z1ZLbVVSSGhFRUZWVVVoeUZjeVJmN0grS3M5?=
 =?utf-8?B?OXRkWWgyWjFrSDQyc3BXMG9CTHVCNDNiZWtmMHlRekdCZDhlUUxZYmNwSGo4?=
 =?utf-8?B?RkY1YUtBZGFzanRabXo4dkVVNHI5WFoyYitadTBob0lSZWZwR3JHeEtKMk8v?=
 =?utf-8?B?VkNBdEFIbld0d2psNW5Xam1QNHFBMmwwZkFaZFFDZGJnZVJHS0ZSazBqR013?=
 =?utf-8?B?TGUzaFArUTVzRW9lUkRtYjhhM05mZ1p1bUlhb3pDaTFmMVRJWHBmK1dLb0h6?=
 =?utf-8?B?TmkrS3Bta1lvWU5pb1prTy9ZUkFmOVB4YlBUK0c2SDEzM1N2MkZiN2FzbWVz?=
 =?utf-8?B?Tkxpbkg4UVlkZ29GSzZ2dGFreWlLdmJnakVwdGxnYU13UlpmYUlvNkxabWN4?=
 =?utf-8?B?bUtMRGZuZHo4bXhFTE1CN1p3NzVGY1N1ZEhiQk9CZW1JRTdka2Rpako2aW9O?=
 =?utf-8?B?SzVFTnhPMm5wWjdDbVQydnVIUlVmQW13TVU1bHE1SGRkamZwS3VsbFZYVGxS?=
 =?utf-8?B?TUF5MHZVL0NrVlZZZ0dTSDYrT3pQTlJ6VlBRL3Fnems0S2krU0p3dTJBNEU4?=
 =?utf-8?B?MVNra0w2TURhMk1Mc1h3VmRlZHJJQU0vQjBZeW9jbk5KekU4VHVmTm10Qnlw?=
 =?utf-8?B?TU5yT0ppQTdVL1RsODh1UERIU3REbDRaZnlCRWoyZ1Iwb2ZlQ1hEWEllNjRY?=
 =?utf-8?B?aHFwZ0lvK0k5c2d6aVgyWDFkZ0ZZaEdWK2lmcVBNQ3c2eXlYN1NMb3NJYzBn?=
 =?utf-8?B?Z3diK3d5MFIvWUFHVTQ4RkFuUzBXVEwyY1ZFUGx2ejFxYk1qWnUrLzNyeUMv?=
 =?utf-8?B?bXB3NHdSR1VJS1RTRC8wcnZXRExPRU5YNE16YlkwaWZYNTlyWW5MOFJRd1Ev?=
 =?utf-8?B?WXVRK2s3TWp1QytGaVo5K2NLT085Vlp0QkxabkZyb3ZVbEd4TGhCMlBnZjFV?=
 =?utf-8?B?SnlIZk9jNXZvRmNYeElPanJqM2VBYkxlK2hrOTZQdEUyL3pQSlRvdGR2ZWFC?=
 =?utf-8?B?TENHSVZrOEVuSVNTMlJadzNxSHR5N0dyamg4WTdZR3B2Mkt4UTlwSmZsRkFs?=
 =?utf-8?B?amd1bDBjbngwNzQzVzJUYW1FcFR2K2U2UXhRVVRJYTZIUUhpSVhjc2VZZEhh?=
 =?utf-8?B?eWpCWThkUFpSa0JzSTVQRDRJVjlkL1ZaVlFXTTJ3V3l4ckM2bzZVdGQyeTZw?=
 =?utf-8?B?Qm1TZzVwVDUyQ2lCVFFQM1Y1RXNueTRXZDRleVhtdFp6L2c2R01mbk9aOWhI?=
 =?utf-8?B?Qjc0eE1jdVZJTlpxTk5CeTJuK3o5eE1uaXo5N051bGtFV0p0eG1ST1hzbFUx?=
 =?utf-8?B?eUY4Zm1wSVRXZmFpbkt2eHZHNk1yRGlwTVRidXkzKzhtSmU2Z2NWVlYrSCtH?=
 =?utf-8?Q?oWJ/FoFY/gbr82oFXi+TOuo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef23a3a-5202-4d3b-ace0-08db265860be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 19:55:22.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4b8paYGqliM0v+zrVb4Yq0G/tzIIeRqzHPFcgNp4DioDj37dPMXxSUjiNvizz+wxuLzyYDqggAXfRZwGOdB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v10] virtio-net: support inner header
 hash

DQo+IEZyb206IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE1hcmNoIDE2LCAyMDIzIDk6MzkgQU0NCj4gQSByb3VnaCBkZXNjcmlwdGlvbiBvZiB0
aGlzIHNjZW5lIGlzIGFzIGZvbGxvd3M6DQoNCj4gQ2xpZW50MSBzZW5kcyBwYWNrZXRzIHRvIGNs
aWVudDIsIGFuZCBjbGllbnQyIHNlbmRzIHBhY2tldHMgdG8gY2xpZW50MQ0KPiByZXNwZWN0aXZl
bHkuDQo+IFRoaXMgaXMgY2FsbGVkIHR3byBkaXJlY3Rpb25zLCBhbmQgdGhleSBhcmUgaW4gdGhl
IHNhbWUgZmxvdy4NCj4gVGhlIHBhY2tldHMgaW4gdGhlIHR3byBkaXJlY3Rpb25zIG1heSByZWFj
aCB0aGUgcHJvY2Vzc2luZyBob3N0IHRocm91Z2gNCj4gZGlmZmVyZW50IHR1bm5lbHMuIEluIHRo
aXMgc2NlbmFyaW8sIHdlIG5lZWQgdG8gaGFzaCB0aGVzZSBwYWNrZXRzIHRvIHRoZSBzYW1lDQo+
IHF1ZXVlIGZvciB0aGUgc2FtZSBjcHUgdG8gcHJvY2Vzcywgc28gaW5uZXIgc3ltbWV0cmljIGhh
c2hpbmcgaXMgcmVxdWlyZWQuDQo+IA0KPiANCj4gY2xpZW50MSAgICAgICAgICAgICAgICAgICBj
bGllbnQyDQo+ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gICAgIHwgICAgICBf
X19fX19fX19fICAgICAgICAgfA0KPiAgICAgKy0tLS0tPnwgdHVubmVscyB8PC0tLS0tLS0rDQo+
ICAgICAgICAgICAgfC0tLS0tLS0tLXwNCj4gICAgICAgICAgICAgICB8ICB8DQo+ICAgICAgICAg
ICAgICAgfCAgfA0KPiAgICAgICAgICAgICAgIHwgIHwNCj4gICAgICAgICAgICAgICB2ICB2DQo+
ICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tKw0KPiAgICAgICAgIHwgcHJvY2Vzc2luZyBob3N0
IHwNCj4gICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0rDQo+IA0KSSB1bmRlcnN0b29kIG5vdy4g
VGhlIGtleSBwaWVjZSBpcyB0aGUgcHJvY2Vzc2luZyBob3N0IGlzIGRpZmZlcmVudCBmcm9tIGNs
aWVudHMgMSBhbmQgMiwgSSB3YXMgbWlzc2luZyB0aGF0Lg0KVGhlIGtleSBpcyB0aGVyZSBhcmUg
dHdvIHR1bm5lbHMgYW5kIHByb2Nlc3NpbmcgZGF0YSBvbiB0aGUgaW5uZXIgaGVhZGVyIGZvciB0
aGUgZGlmZmVyZW50IHR1bm5lbHMgaXMgeW91ciBwcmltYXJ5IHJlcXVpcmVtZW50Lg0KSGVuY2Ug
aW5uZXIgaGFzaGluZyBoZWxwcyB0byBzZXJpYWxpemUgdGhlbS4NCg==

