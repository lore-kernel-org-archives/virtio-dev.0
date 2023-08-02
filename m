Return-Path: <virtio-dev-return-13430-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417BBC04E69
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 07:13:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BAEDD78DAD
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 07:13:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F3BE986699
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 07:13:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D8E39865EC; Wed,  2 Aug 2023 07:13:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A6659865F7;
	Wed,  2 Aug 2023 07:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwM1xo+eLp2g/avDe9sVuMhZLJILMei5ivxNmipgCnYF2uX6DQ9YNp6UMgTIXpIq38YxCVxANgS+MgaRAjBubmOvf5wkREFW/VWj8eYf9ag69QVCuNtRS6KZqaS22KLEqiwxgd8beHP/viYUfHhfrlwZQtA6dqZ3IWSUJTKr/Bp3Adv56l03oU3e4sJEKuwpsbFWYzTBW0ELiAq9CazTUu45Me9DMUDwqGmDPge+PdTzBSEwSiAzEyc4RRm5dxp9V+fVYdM7wWVge7I2ZLiyUIqd6IZGBTmGKGcKTpF6dKtRPKsxJkVMz6Ud7/kw/oNgR0knArGpVcwxFrn0TRjv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbL1RnaIiqqvTpzo5q24inM36ISsqNd5E7Huunas1DQ=;
 b=DPjbBKOYAs5v5GokHBYyr3xIRzXsIO+p5d5l1jyeAAE3lZkpvwCpi3WPmNEcoz2RZzyiWbC67Ifp2cS//S/tch70uaqavQRoeHqy/EF/G8YMW6D9UIBgTGoIyYoPMzOxNgSz0ffoYpoHIHkQkW6DdpjYW3Po/xprOc5VbKOLKri8QyJkvns2E5tWKfBXslmA44duHbSvvos8+MkL+u6iHUHX1WFdOdOxKmcBE2i6u+dZoopMaWjoE/RRfcRYMJZLWpo7K/DMAXLCCSJfsmnRtG9dgnIbTmmWoEM6eR/grTc7ZjYPNTtet01X5liz4c3LfL//bG20peubvH3zUpqkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
	<marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZxPBmx6oJ9gLSW0KyczkfJaHsia/WbxOwgAATkoCAABREwA==
Date: Wed, 2 Aug 2023 07:13:50 +0000
Message-ID:
 <PH0PR12MB54819BEBB889ACF23324B69EDC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849A2599DD46405262B8630E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB5849A2599DD46405262B8630E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4088:EE_
x-ms-office365-filtering-correlation-id: 757cdc65-ae1e-4904-8034-08db93280596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mnf3ryjTURwsooVycOwA0tRY9juPoe+wy3UeMUrBn0N8krmzT+Skwn1qUZ3SJGS0MiwjZntYvd3eRRYGtzQ5C1C6x5CyXsmm3JkBb8vyPeP7bBlaqHTtRABP1SURdvObUa73PBdPUR8nXFmQjBGD82jUskAL0J9AN7XdxD/w5aEWdXC0Pw56R7RozzRIzms9+DvTqfTaEbjBFoHNS/mct3SgGQHf9TjuQIJjTQGj/XQjsLbDypBGVz6NpTrEg5kl5Bb3e4vta37D3YSJLyB3ww3Z+CcPgpQ5af0Rz4fmz+LVde1EEGrAMbLHnl5GHzR56sc4yDShXKuW+TqDD7IRDaFCAtmWQtNA+/Ekbb4k/8qeUCDtA/D29RNULqooqFBszfqdx8pVgKa8wuY4mXA0xmz/Rqh2qB2pxamTFAgm3P91Maw9KmqHXSq7wP9D7mn/1MMZ1XrlC2l3M06ur2y0p7FssDQw+5PgGkou5hR112OLPc8CTIXtzMxcx9FISZr/Anddmh9labznFM2CIv/WpiSyKbiWlrezEHNryo6DYkslWXO1crRCk1owElIFD3/7Tryq0/B1h5uK4cbDnUpdC6I23RVtCgV02PJlOfUzFEHFrLQrTUR02noAXrGGBA1s8l99C3Corry/R2CTHqY28rjlv739OhQalzClzf0YxK1oQj3Mu3lANYYA4roqTk7wOUvg3fZilamFlIAzMiyYZQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(55016003)(186003)(966005)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(64756008)(7696005)(6916009)(4326008)(6506007)(53546011)(41300700001)(26005)(52536014)(8676002)(5660300002)(8936002)(2906002)(38070700005)(7416002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEFWS3pWa0JpbkVRVVpwSFViTVR6OGVkeG1nSGJKRGROdlMxdlUvN0tydXdV?=
 =?utf-8?B?RS8zc1pySHpYcVR6cVlndEpHTk9iT2M3VGVGSHFRdHNXU003NnhKMDVtQWt5?=
 =?utf-8?B?VjM4ajlySWpSODZwTnZyL2g0ckhWOCt6c3YzT1phb2ZTaExXTllhTUorbDFx?=
 =?utf-8?B?YXpmelBqb2c0SFVoR3ozOThpbGhFSkZzR3dyWWp3K1g2UjU4Mjl0NnJCdkZ0?=
 =?utf-8?B?TjZKcmlhM1VRRUpTdFd5N0o0dW50UzhKREs3Ym05dzJPMm1vY2QvbndodnVw?=
 =?utf-8?B?QnVWcEYrRlFudUR1eWtTZkJVdlFyZnBsa1JIRVh2SXd1NHZxdXlJRDRQOWk1?=
 =?utf-8?B?RkJ4NzRVcnNjZXhtTXVlM2hRZ2g3RXlPNWMxTjZLbU44WnZjd29FVWVDOGVX?=
 =?utf-8?B?eWJEdWZ4WkFMcVU1NHJpa0htQjUwWURDWkt6NHVhb1hUbWoydEpNUjcvUkZD?=
 =?utf-8?B?K1l5Vk5ROUsyaXRFVmMxdjA1d3RXNEUwQU9US09nRGUyL0NhUThtSXFLZkdk?=
 =?utf-8?B?SGQ5WTI4M0ZtMTdkeEkxRGMrNk9pYzV6SGI1VXRoQmFaem53TjNRamU5dnA0?=
 =?utf-8?B?Nkg5aEtVRll0RUxwcS8rS3J6S1Y4dWNWVzZpQmNJdFJKYXZTQVc1SjV1Ym95?=
 =?utf-8?B?cTZTaFZmeWlVMURjRVRIUjE2V1dBOUswNFU3SHh0bGxaL01SMVRPSW1xZkhs?=
 =?utf-8?B?NVBaMG1pRHczR0xiVFhsekU5MDFoalNHN1crcnE2dTEvU0xVNlJrbUhJMmk5?=
 =?utf-8?B?citPenRrbnVxTUpSZTVhMTJHK3VxeTVFOHhUL093V1Vqc013b3VoZHVQeHdD?=
 =?utf-8?B?VHV6eG5QNmswN1U3dTNtbXRDZ1Z6dHVTOUplSXpKL2VucElyUUo3ZTJkUGZO?=
 =?utf-8?B?WjJpYkZMWVRFTi9YVGZQbkNmQ1Qvb29KZ0MxRTBGaUVwM1dPWUZDVE41VnBO?=
 =?utf-8?B?aXFiWjhLYS92ZCtkS3huWnZUMXZOWWlTQTZUQUw5MURvTzBHK1NwRGhhYjVu?=
 =?utf-8?B?WG5JUElNS2drQnlVaEQzNGhKcHorQzRneTQ0aWljNGE5Z21xUXdKenM3cVBi?=
 =?utf-8?B?SjJDaE9EZldoQlV1NW1kRUIyQUErSFYvZ0tuMHE2bFdwbTdpcGdGbzNTald1?=
 =?utf-8?B?Si9YRzNnQU1RT2I4UDcveWdESWZ2aHZla3IyaE9NTllXSE9uL3k5eko1YjZi?=
 =?utf-8?B?UEczbmJaOG90Q3Z1YXJSbWJwajFnQm0rSXNzTXM0b095V0pZdjUzcEIrY0cv?=
 =?utf-8?B?V3NqYnpVT2pqNXFOeTZlS2Y5KzRmQ0tyS3pBRjVvSVJGS3NMY1g2OXdGaXMz?=
 =?utf-8?B?UG0wNlVzdDRMVkEyRWVkcUZQcUhEY3lDV0lZSzZCYTJsQndLTGlYTkRJd21B?=
 =?utf-8?B?THovMUZ2cDZBSkNwdGxBN0hwN2YvUExON2Y5dGVHZ0xTWUVNQVF0L0wyTUM4?=
 =?utf-8?B?ZWxlRzNoOEVVelIwU1duM0tNektucWQ5allkSTRXRHZITWVOckxxazNSVU44?=
 =?utf-8?B?aWduVHFUR0VkbjNvZXN0SysrK1JHR2pGWC9iZURvNFMxSTF6a3RTSTRUc0Rt?=
 =?utf-8?B?b1pJNU1nS3c3NE1OS3dLV2R6a2RGL2loVGVhZ3hBMGM5Q2FLVzEyTnhmWDQ2?=
 =?utf-8?B?OGNCMG1rUk9CVE9NK1ovOVhTRHZnbzFzb1h6V2liN1YrOWxEdFRoNEJtQWQ5?=
 =?utf-8?B?ckZzNms1YlBQdHI0NmVsaU1xK1hIbFRERmI3NVlpbVhVT0hiVHBxL1c0R29l?=
 =?utf-8?B?amVKTk5EcEVOTlkyMXRGMytUQ2tQUEo4V3h0dWpQaVViNTUwSElaa3JWZWtZ?=
 =?utf-8?B?R0FXWmJKTmc5YStSUUd6a2swc1VYbWpuRVk4SkUyY2ZLKzFaUm9NRythd2t0?=
 =?utf-8?B?Y1FPTVVuWFdWT05vajliSlVmZjJuSGpGWGozOXJ2RVV3aVRKamNBOUpxeFNo?=
 =?utf-8?B?OGlHOFphRCtBY0d0djNmT1N5eHFjTENqUm5xWFBjcnEyNER0OGNwQUw0T21x?=
 =?utf-8?B?YmRrb1hsQUZDRlVqd2o2engwZVJBY056dFI5bkkwVDM1dXZJSnZsbE9TSTFC?=
 =?utf-8?B?dCtmVmx2RzlmVHJ6ZXJ1d2prWlI4TmpiUTNGL3Z4ZkxXbFpvMjBmaDk0bGxL?=
 =?utf-8?Q?1NBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757cdc65-ae1e-4904-8034-08db93280596
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:13:50.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fh69dfxVOBDs5P4mPPnuC1k1TSRNC3UTDoceclCuzhLFvfvBeVBAgbhTi32a7Ul7zTpOylilN495fKtVXo8trQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
Subject: [virtio-dev] RE: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBdWd1c3QgMiwgMjAyMyAxMToyOCBBTQ0KPiANCj4gT24gMjAyMy84LzIgMTI6NDks
IFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IEZyb206IHZpcnRpby1kZXZAbGlz
dHMub2FzaXMtb3Blbi5vcmcNCj4gPj4gPHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmc+
IE9uIEJlaGFsZiBPZiBDaGVuLCBKaXFpYW4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3Qg
MiwgMjAyMyA4OjUxIEFNIEhpIGFsbCwNCj4gPj4NCj4gPj4gRG8geW91IGhhdmUgYW55IG90aGVy
IGNvbW1lbnRzIG9uIHRoZSBtb2RpZmljYXRpb24gb2YgdmlydGlvLWdwdSBTMz8NCj4gPj4gTG9v
a2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkgYW5kIGNvbW1lbnRzLg0KPiA+Pg0KPiANCj4gSGkg
UGFyYXYgUGFuZGl0LA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuIExldCBtZSB0cnkgdG8g
YW5zd2VyIHlvdXIgcXVlc3Rpb24uDQo+IA0KPiA+IEkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGhl
IEdQVSwgc28gYSBkdW1iIHF1ZXN0aW9uIGlzLCB3aHkgdGhlIFMzIHN0YXRlIGlzIGdwdQ0KPiBz
cGVjaWZpYz8NCj4gUzMgc3RhdGUgaXMgbm90IGdwdSBzcGVjaWZpYy4gSSB0aGluayBkaWZmZXJl
bnQgdmlydGlvIGRldmljZXMgbWF5IGhhdmUgZGlmZmVyZW50DQo+IGFjdGlvbnMvcHJvYmxlbXMg
d2hlbiBTMy4NCkkgYW0gbWFraW5nIGFzc3VtcHRpb24gdGhhdCB0aGUgZ3B1IGRldmljZSBpcyBw
Y2kuIDopDQpJZiBzbyBjYW4geW91IHBsZWFzZSB1c2UgdGhlIHRyYW5zcG9ydCBzcGVjaWZpYyBu
b3RpZmljYXRpb24gZnJvbSBncHUgZ3Vlc3QgZHJpdmVyIHRvIG5vdGlmeSB0byBxZW11Pw0KDQo+
IFdoZW4gSSBkbyBTMyBvbiBYZW4sIEkgZm91bmQgZ3Vlc3QncyBkaXNwbGF5IGNhbid0IGNvbWUg
YmFjayBhbmQgdGhlIHJvb3QgY2F1c2UNCj4gaXMgaW4gdmlydGlvLWdwdSBiYWNrZW5kIGluIFFF
TVUuDQo+IFNvLCB0byBzb2x2ZSB0aGF0IHByb2JsZW0sIEkgY2hhbmdlIGNvZGVzIHRvIGxldCBn
dWVzdCBub3RpZnkgUUVNVSB2aXJ0aW8tZ3B1J3MNCj4gc3VzcGVuZCBzdGF0ZSwgYW5kIHRoZW4g
UUVNVSB3aWxsIG5vdCBkZXN0cm95IHJlc291cmNlcyB0aGF0IHVzZWQgZm9yIGRpc3BsYXkuDQo+
IFBsZWFzZSBzZWUgYXR0YWNoZWQga2VybmVsIGFuZCBRRU1VIHBhdGNoIGxpbmtzLg0KPiBGb3Ig
YWJvdmUgcmVhc29uLCBHZXJkIHN1Z2dlc3QgbWUgdG8gYWRkIGEgbmV3IGZlYXR1cmUgZmxhZyBz
cGVjaWZpY2FsbHkgZm9yDQo+IHZpcnRpby1ncHUsIHNvIHRoYXQgZ3Vlc3QgYW5kIGhvc3QgY2Fu
IG5lZ290aWF0ZSB3aGVuZXZlciB0byBlbmFibGUgYWJvdmUNCj4gbWVjaGFuaXNtLg0KPiANCj4g
PiBDYW4gYSB0cmFuc3BvcnQgc3BlY2lmaWMgc3VzcGVuZCBzdGF0ZSBiZSB1c2VkIGFuZCBhcHBs
eSB0byBhbGwgdmlydGlvIGRldmljZXM/DQo+IEJhc2VkIG9uIG15IGxpbWl0ZWQga25vd2xlZGdl
LiBEaWZmZXJlbnQgdmlydGlvIGRldmljZXMgaGF2ZSBkaWZmZXJlbnQgdmlydGlvDQo+IHF1ZXVl
cywgbXkgbW9kaWZpY2F0aW9ucyBsZXQgZ3Vlc3QgdG8gbm90aWZ5IFFFTVUgYnkgdXNpbmcgdmly
dGlvLWdwdSdzIGNvbnRyb2wNCj4gcXVldWUuDQo+IE90aGVyIHZpcnRpbyBkZXZpY2VzIGNhbid0
IGdldCB0aGF0IG5vdGlmaWNhdGlvbiB1bmxlc3MgeW91IGNhbiB0cmF2ZXJzZSBhbGwgdmlydGlv
DQo+IGRldmljZXMgYW5kIG5vdGlmeSBvbmUgYnkgb25lLCBvciBvdGhlciBnbG9iYWwgbWV0aG9k
Pw0KPiBCdXQgZm9yIG5vdywgdGhpcyBwYXRjaCBpcyB0byBhZGQgYSBuZXcgZmVhdHVyZSBmbGFn
IGp1c3QgdXNlZCBmb3IgdmlydGlvLWdwdS4NCj4gDQpJZiB0aGlzIGlzIGRvbmUgYXQgdGhlIHBj
aSB0cmFuc3BvcnQgbGV2ZWwsIGFsbCB0aGUgdmlydGlvIGRldmljZSBiZW5lZml0IGZyb20gaXQg
d2l0aG91dCBpbnZlbnRpbmcgaW4gZWFjaCBkZXZpY2UgdHlwZS4NCg0KPiA+IEFuZCBjYW4geW91
IHBsZWFzZSBhZGQgYm90aCB0aGUgcmF0aW9uYWxlIHRvIHRoZSBjb21taXQgbWVzc2FnZT8NCj4g
U3VyZSwgSSB3aWxsIGV4cGFuZCB0aGUgZGVzY3JpcHRpb24gb2YgbXkgY29tbWl0IG1lc3NhZ2Ug
YW5kIGFkZCB0aGVtLg0KPiANCj4gPg0KPiA+PiBPbiAyMDIzLzcvMjAgMjA6MTgsIEppcWlhbiBD
aGVuIHdyb3RlOg0KPiA+Pj4gdjM6DQo+ID4+Pg0KPiA+Pj4gSGkgYWxsLA0KPiA+Pj4gVGhhbmtz
IGZvciBHZXJkIEhvZmZtYW5uJ3MgYWR2aWNlLiBWMyBtYWtlcyBiZWxvdyBjaGFuZ2VzOg0KPiA+
Pj4gKiBVc2UgZW51bSBmb3IgZnJlZXplIG1vZGUsIHNvIHRoaXMgY2FuIGJlIGV4dGVuZGVkIHdp
dGggbW9yZQ0KPiA+Pj4gICBtb2RlcyBpbiB0aGUgZnV0dXJlLg0KPiA+Pj4gKiBSZW5hbWUgZnVu
Y3Rpb25zIGFuZCBwYXJhdGVtZXJzIHdpdGggIl9TMyIgcG9zdGZpeC4NCj4gPj4+ICogRXhwbGFp
biBpbiBtb3JlIGRldGFpbA0KPiA+Pj4NCj4gPj4+IEFuZCBsYXRlc3QgdmVyc2lvbiBvbiBRRU1V
IGFuZCBMaW51eCBrZXJuZWwgc2lkZToNCj4gPj4+IAlRRU1VOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjMwNzIwMTIwODE2Ljg3NTEtMS0NCj4gPj4gSmlxaWFuLkNoZW5A
YW1kLmNvbQ0KPiA+Pj4gCUtlcm5lbDoNCj4gPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyMzA3MjAxMTU4MDUuODIwNi0xLUppcWlhbi5DaGVuQGFtZC5jDQo+ID4+PiBvbQ0KPiA+
Pj4gL1QvI3QNCj4gPj4+DQo+ID4+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+PiBKaXFpYW4gQ2hlbi4N
Cj4gPj4+DQo+ID4+Pg0KPiA+Pj4gdjI6DQo+ID4+PiBsaW5rLA0KPiA+Pj4gaHR0cHM6Ly9saXN0
cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDcvbXNnMDAxNjAN
Cj4gPj4+IC5oDQo+ID4+PiB0bWwNCj4gPj4+DQo+ID4+PiBIaSBhbGwsDQo+ID4+PiBUaGFua3Mg
dG8gR2VyZCBIb2ZmbWFubiBmb3IgaGlzIHN1Z2dlc3Rpb25zLiBWMiBtYWtlcyBiZWxvdyBjaGFu
Z2VzOg0KPiA+Pj4gKiBFbGFib3JhdGUgb24gdGhlIHR5cGVzIG9mIHJlc291cmNlcy4NCj4gPj4+
ICogQWRkIHNvbWUgZGVzY3JpcHRpb25zIGZvciBTMyBhbmQgUzQuDQo+ID4+Pg0KPiA+Pj4NCj4g
Pj4+IHYxOg0KPiA+Pj4gbGluaywNCj4gPj4+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcv
YXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA2L21zZzAwNTk1DQo+ID4+PiAuaA0KPiA+Pj4g
dG1sDQo+ID4+Pg0KPiA+Pj4gSGkgYWxsLA0KPiA+Pj4gSSBhbSB3b3JraW5nIHRvIGltcGxlbWVu
dCB2aXJ0Z3B1IFMzIGZ1bmN0aW9uIG9uIFhlbi4NCj4gPj4+DQo+ID4+PiBDdXJyZW50bHkgb24g
WGVuLCBpZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2ggUWVtdSB3aXRoIGVuYWJsaW5nDQo+ID4+
PiB2aXJ0Z3B1LCBhbmQgdGhlbiBzdXNwZW5kIGFuZCBzM3Jlc3VtZSBndWVzdC4gV2UgY2FuIGZp
bmQgdGhhdCB0aGUNCj4gPj4+IGd1ZXN0IGtlcm5lbCBjb21lcyBiYWNrLCBidXQgdGhlIGRpc3Bs
YXkgZG9lc24ndC4gSXQganVzdCBzaG93biBhIGJsYWNrDQo+IHNjcmVlbi4NCj4gPj4+DQo+ID4+
PiBUaGF0IGlzIGJlY2F1c2Ugd2hlbiBndWVzdCB3YXMgZHVyaW5nIHN1c3BlbmRpbmcsIGl0IGNh
bGxlZCBpbnRvDQo+ID4+PiBRZW11IGFuZCBRZW11IGRlc3Ryb3llZCBhbGwgcmVzb3VyY2VzIGFu
ZCByZXNldCByZW5kZXJlci4gVGhpcyBtYWRlDQo+ID4+PiB0aGUgZGlzcGxheSBnb25lIGFmdGVy
IGd1ZXN0IHJlc3VtZWQuDQo+ID4+Pg0KPiA+Pj4gU28sIEkgYWRkIGEgbWVjaGFuaXNtIHRoYXQg
d2hlbiBndWVzdCBpcyBzdXNwZW5kaW5nLCBpdCB3aWxsIG5vdGlmeQ0KPiA+Pj4gUWVtdSwgYW5k
IHRoZW4gUWVtdSB3aWxsIG5vdCBkZXN0cm95IHJlc291cmNlcy4gVGhhdCBjYW4gaGVscA0KPiA+
Pj4gZ3Vlc3QncyBkaXNwbGF5IGNvbWUgYmFjay4NCj4gPj4+DQo+ID4+PiBBcyBkaXNjdXNzZWQg
YW5kIHN1Z2dlc3RlZCBieSBSb2JlcnQgQmVja2V0dCBhbmQgR2VyZCBIb2ZmbWFubiBvbiB2MQ0K
PiA+Pj4gcWVtdSdzIG1haWxpbmcgbGlzdC4gRHVlIHRvIHRoYXQgbWVjaGFuaXNtIG5lZWRzIGNv
b3BlcmF0aW9uIGJldHdlZW4NCj4gPj4+IGd1ZXN0IGFuZCBob3N0LiBXaGF0J3MgbW9yZSwgYXMg
dmlydGlvIGRyaXZlcnMgYnkgZGVzaWduIHBhcmF2aXJ0DQo+ID4+PiBkcml2ZXJzLCBpdCBpcyBy
ZWFzb25hYmxlIGZvciBndWVzdCB0byBhY2NlcHQgc29tZSBjb29wZXJhdGlvbiB3aXRoDQo+ID4+
PiBob3N0IHRvIG1hbmFnZSBzdXNwZW5kL3Jlc3VtZS4gU28gSSByZXF1ZXN0IHRvIGFkZCBhIG5l
dyBmZWF0dXJlDQo+ID4+PiBmbGFnLCBzbyB0aGF0IGd1ZXN0IGFuZCBob3N0IGNhbiBuZWdvdGlh
dGUgd2hlbmV2ZXIgZnJlZXppbmcgaXMgc3VwcG9ydGVkIG9yDQo+IG5vdC4NCj4gPj4+DQo+ID4+
PiBKaXFpYW4gQ2hlbiAoMSk6DQo+ID4+PiAgIHZpcnRpby1ncHU6IEFkZCBuZXcgZmVhdHVyZSBm
bGFnIFZJUlRJT19HUFVfRl9GUkVFWkVfUzMNCj4gPj4+DQo+ID4+PiAgZGV2aWNlLXR5cGVzL2dw
dS9kZXNjcmlwdGlvbi50ZXggfCA0Mg0KPiA+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4g
Pj4NCj4gPj4gLS0NCj4gPj4gQmVzdCByZWdhcmRzLA0KPiA+PiBKaXFpYW4gQ2hlbi4NCj4gDQo+
IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gSmlxaWFuIENoZW4uDQo=

