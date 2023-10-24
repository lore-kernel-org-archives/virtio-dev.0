Return-Path: <virtio-dev-return-14016-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20021C00A8F
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 10:35:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 52FA8780FE
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 10:35:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39BD99869AE
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 10:35:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27EF698699F; Tue, 24 Oct 2023 10:35:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1706D9869A0;
	Tue, 24 Oct 2023 10:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDIkri2f8QsAbZjqHb1NEDUs24MtlIdKu5Dw+OQGujhDSe/9/idiEhDKXJcllpgD2Xw/o0lkjx4pPfS7YRI9jeLTQcEKotuy8jkSkGVNWMBtZlUKzf13LhKYRSryWIoZK2iPgVfjQp0FH66yHB3OnkXnvkXXujfKf/p8FX8e0jCTdK7cpj6MypKwFbtvvU/7v9HjPyNSmpaKWQvrh53KFOw8ieun8Kn0Iafo9CzSGsyvq44Tj+LJcMYN24qGtlT7oWL7hFzhrrWDeBPkEVmSWoiQm3/D0JbNmyiQt542MQtG51Tum2kmZ3SpZ5MNaSRG/3a90+smvedaOHnfhQm7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhoHIe47XEWW3sfTltx5xDgl1jLZh4956KgR8hj9egI=;
 b=kBUKfBfv3SuAd8+nAKKKFxtqtGrFGmTlzytzQKn3JbBJyF1EZMz0pwaO6RDv/UvGy7o8yDnLvv97tuOG3xzVyGyBwXDx3bzKSCSVmRCdctofddpT9BEScrj1oa8n9L1luYCWpx/BfRcTVloH58Y5fqCUW3NmQSU8mpYutVisbHb3IilQRfQ0tiC6TdoTkFTjfRxQ2UtLFpac/zdWcTjj3WjZWJvQSNEVqDBocN81863UxkA2lGwb/I9MY9DEuoSAIDCCrRTaLkOI9Lh222ZDQE8pKavrfjq0ZdwYQuPDaeeaJ+xwMWgZsr8XhcDxmXrbXq4JlLeC3pZia2pKUBk4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index: AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA
Date: Tue, 24 Oct 2023 10:35:49 +0000
Message-ID:
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6886.034)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB6582:EE_
x-ms-office365-filtering-correlation-id: ade9ad25-284f-4618-d212-08dbd47cfd1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jR6DRYvTe4y/BS4bCjv8MkVd3+LXePNU/mt/do2XBM6xQuJ/G7JI4Dkc+Qq5sJHBiBe7I+t2JYF8yy/eAf+xSIoZZO5+nWPKVo1SP0wYo645fHmFjIaks1FLW2PIEsAtXf7sw37kgemP2H4mQ8/SoRmBoqOndY06gQ+S1uD08rxARCwMzjwhT1uTX29vYsMFupDQ4VkQElP84vgq+Tl690uFytyL0nmp2TLMG9kc6zO/1nf4NeKnHcJcXgCETlj4WlH/UbFgYjQ9bzvjs+y4owH/6OCSPIhqpY7nkyE2WCNPDu7+HdZ3Otx7ai+GUypqm08pHvgc0H1NpxL+CXmuwMuSX+TAscrKGUyhqzCF/yjH1DQhjbt7KnFllfcfBX/c8KpdtxZzOkCnBnUYWsKsuA2y4DiRzlp8z4WJjp5JttPP2Z7C2TKK4GanHwFplpztukWgOUdWVAMI08pbxOAh9CWWVC2Fi8e7q0NuMh/JsnkomLloSUECuIdp+u3btHjV5aFg2RCcZPTun7GkdXdtVuKJ5d/z3hyBHup3IRdLEbulkbakyU+t88sFJwosWty2JNq4FRZw4hLmTr5oglDVjdgj3HRhLAc9SIVcwTFmv+Ycyy7bLzXOkkZH5+uF/bjk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(83380400001)(66556008)(8936002)(316002)(122000001)(6916009)(66946007)(76116006)(66476007)(478600001)(66446008)(54906003)(64756008)(33656002)(8676002)(41300700001)(52536014)(7416002)(2906002)(4326008)(5660300002)(38100700002)(71200400001)(9686003)(53546011)(26005)(6506007)(7696005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnZRTHZvUC9tSlVCNE1jeFcvVitLUjFTVXZrY25YN1doQVVJcjQ0S1JyODlS?=
 =?utf-8?B?NlZBNEI2MUVraWpOcDJDeklaOU54TTlXTHhnQ1oxV1EzY0RqcDJrWUlJSGU1?=
 =?utf-8?B?bHhERlMrUjdtd2syenozVjZnSlZyY0xHSHhrR1lWaXdLNHZRTTZBQjJtUERZ?=
 =?utf-8?B?V2wzVzhWUlNBYlJHSnJYb1dHcS80N2ZaQWt6NCs3Vkt3Y3UySVBuTmdyc040?=
 =?utf-8?B?UEg3bGFaa3BQQ2g1Snk2QkFOV2lNc00vM05Uak9qaXJScDhkd3BvK0FVWjR4?=
 =?utf-8?B?NXJmWFMwdXhaOG42T3E2NUR5QWdYR3NRaEpDWnlSd1hWd2E0WTU5cU8rWllr?=
 =?utf-8?B?ZGkvTnk0WGt1SkphSnJ6YmNlNXl6Qyt2TmVDM1NhVHp1RW9xVjNVYTkyeTlG?=
 =?utf-8?B?Q1J5SmJRMlhscERZWlVVVk50eUhySXRWSG12cTY2dWhGVmdybUR3b1BEelZM?=
 =?utf-8?B?M1QvZWUyNlpZUVhZUU4rR3lNT1ZZRDF5MTNna3Fxb3RESjlwUG8zODloeWF3?=
 =?utf-8?B?dTQ5VENEdGpWc203ZEw4K29IdytNKzVMaUJIRU8xOHp6clNzOXVPeHV6aGlq?=
 =?utf-8?B?TXdBVFc2MG5VTjdzbG9Tc0c1cWlFdUFXSnJXeTM1YXNEU1FPblM2dTFXNDJ2?=
 =?utf-8?B?aTh4aDFwL1ZSUlg3U3phWTFhcHRYcFowbXlEMlhkQmxHNk5LcjdtOVJGVjN0?=
 =?utf-8?B?Q2dUM1ExMklXTWhOM3BydzNpZ3lINmlqWmFOdGJCZG9KWFVXRzRNdHpqSUU4?=
 =?utf-8?B?cjhDOGVhenZWaGd5RGxzNm9IWkFhWW1GRTVMLzRqKzNFTEtrTzV6MWV0R3BE?=
 =?utf-8?B?QkxQMURETDJ5SmRoYXlWSzdLckZldzJKWUgxVkpMVm4zUGpzWVFrMHlxR0pa?=
 =?utf-8?B?WkR3UVdUMVlJNlcyOS95d281bFRyOGEvclp1KzZtVStTbUhBQXBDNThaK1hC?=
 =?utf-8?B?amtxU0pra2QvNDFIRkFsOE9Ta0Z5Zlk3UmZTVHdhWUFIZ29rZE9KRTFwOGd4?=
 =?utf-8?B?U3gvTE5IMUx1MVZXTjhvM1dKMGZkZDRsb3c5Nmt1NFlmc1ZLc3BJcVBxMnAw?=
 =?utf-8?B?MTJXdTlONmVlYUVXVllWWHlmSlJPTjNjcnEvak5DcUxJeFgwVGhaQmlYemVt?=
 =?utf-8?B?OG1ieUIzT21yUm5VaG5WTnl1UlpwbzRxcmM5Q3E2RlRnYVpNaDY2YS9CcUIr?=
 =?utf-8?B?Ri9EQ0ZYaHhMTm5SaVhuVjdvMTBjQ2VnaWNtQmc5ZHUzZmNCWWY1WFhxeWhL?=
 =?utf-8?B?bjR1cnhEaElSNlh1MnBDMWc2OVNJMEVWTDVFdjd4RXpvWnFKQ3R3NEs1NG5n?=
 =?utf-8?B?R0trYjNHSFdLT0sxMWRjWFBhWHQxajV3Q2FuQjhqWE5yazA4NVB2NEhweUFD?=
 =?utf-8?B?TTlRMmRoMWswTnQ2bFZZbmpxZmE5bUJiOWVaaTBQUytpemhTbk1KeHd3dkF0?=
 =?utf-8?B?OUF3YUV3SkZHZVNtdWN3aHFQVWhXR3hlT1JoejM3anhPaVFOQ28xd1hxNXFS?=
 =?utf-8?B?NVFPMFhQMmJvU0ZDQklaYkxKZGE1NEdQVkI0dDNQeGR6YjVaRy9mOWdpSFc0?=
 =?utf-8?B?ckpRK253YlYwaExOWlk4QVdiWkZ6N2trRU80NXp4RHljNXVveTRmallEbEdi?=
 =?utf-8?B?Uk5kbnJ6dnNUYlFlaU5sVnRBR1BpSC9wOVZreXNuMlE4VFRSYUFSYm90SlA0?=
 =?utf-8?B?ZlcybUV1WTlYZXYvNHFJUDk0eEJFaWVKQWZOQTNoQXJoTGMzcEZRZk5BNElk?=
 =?utf-8?B?UTdaQTRhR2U1NHBqd2E4bHg2U21LRUxVbUlHR1JWdXVJbWVVZ0dTODlLTXlJ?=
 =?utf-8?B?bG9MZGJBbll2ODVQQnF5bk91WG90Y1hWZ0NWS0IxeUF4SlUwS3ZjR2NabnBy?=
 =?utf-8?B?WUdUQTBQTXR4V3dyNzNHd3YzbFZWU0wzZUFqaVBkeDRJNWRTM2pNM3JseHlj?=
 =?utf-8?B?T1I5b09zSjNWODlKZVZCc1JJYUNDTUFCR3JwZEZRUGwzM24xWGNkbGNjSjZD?=
 =?utf-8?B?QmthaXVNQ1FIWTlMU21WZVpuNXR2MlkzQkRVRTNMa2wzcVZDaHg1WFhmYmtV?=
 =?utf-8?B?aHhLTXh2bE14QUJuZXFkYWJiSGZydmxjaERSM21pbHFURXhpb2Ryb1lPZnVo?=
 =?utf-8?Q?lpik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25B682384116AF42AC64BD6B0AE701BC@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade9ad25-284f-4618-d212-08dbd47cfd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:35:49.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/90lUzMOGzN5obnuNP/joHFl1Z347Tuepvcn5ZVbbWPrNBbkAOsiHEW9MjQhtYaspwUZX7P7z4wRaghQnp4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyMy8xMC8yMyAyMTozNSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiANCj4+IEZyb206IENo
ZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IFNlbnQ6IE1vbmRheSwgT2N0b2Jl
ciAyMywgMjAyMyA0OjA5IFBNDQo+IA0KPj4+IEkgdGhpbmsgdGhpcyBjYW4gYmUgZG9uZSB3aXRo
b3V0IGludHJvZHVjaW5nIHRoZSBuZXcgcmVnaXN0ZXIuDQo+Pj4gQ2FuIHlvdSBwbGVhc2UgY2hl
Y2sgaWYgdGhlIFBNIHJlZ2lzdGVyIGl0c2VsZiBjYW4gc2VydmUgdGhlIHB1cnBvc2UgaW5zdGVh
ZA0KPj4gb2YgbmV3IHZpcnRpbyBsZXZlbCByZWdpc3Rlcj8NCj4+IERvIHlvdSBtZWFuIHRoZSBz
eXN0ZW0gUE0gcmVnaXN0ZXI/IA0KPiBObywgdGhlIGRldmljZSdzIFBNIHJlZ2lzdGVyIGF0IHRy
YW5zcG9ydCBsZXZlbC4NCkkgdHJpZWQgdG8gZmluZCB0aGlzIHJlZ2lzdGVyKHBjaSBsZXZlbCBv
ciB2aXJ0aW8gcGNpIGxldmVsIG9yIHZpcnRpbyBkcml2ZXIgbGV2ZWwpLCBidXQgSSBkaWRuJ3Qg
ZmluZCBpdCBpbiBMaW51eCBrZXJuZWwgb3IgUWVtdSBjb2Rlcy4NCk1heSBJIGtub3cgd2hpY2gg
cmVnaXN0ZXIgeW91IGFyZSByZWZlcnJpbmcgdG8gc3BlY2lmaWNhbGx5PyBPciB3aGljaCBQTSBz
dGF0ZSBiaXQgeW91IG1lbnRpb25lZCBiZWxvdz8NCg0KPiANCj4+IEkgdGhpbmsgaXQgaXMgdW5y
ZWFzb25hYmxlIHRvIGxldCB2aXJ0aW8tDQo+PiBkZXZpY2UgbGlzdGVuIHRoZSBQTSBzdGF0ZSBv
ZiBHdWVzdCBzeXN0ZW0uIA0KPiBHdWVzdCBkcml2ZXIgcGVyZm9ybXMgYW55IHdvcmsgb24gdGhl
IGd1ZXN0IHN5c3RlbXMgUE0gY2FsbGJhY2sgZXZlbnRzIGluIHRoZSB2aXJ0aW8gZHJpdmVyLg0K
SSBkaWRuJ3QgZmluZCBhbnkgUE0gc3RhdGUgY2FsbGJhY2sgaW4gdGhlIHZpcnRpbyBkcml2ZXIu
DQoNCj4gDQo+PiBJdCdzIG1vcmUgc3VpdGFibGUgdGhhdCBlYWNoIGRldmljZQ0KPj4gZ2V0cyBu
b3RpZmljYXRpb25zIGZyb20gZHJpdmVyLCBhbmQgdGhlbiBkbyBwcmVzZXJ2aW5nIHJlc291cmNl
cyBvcGVyYXRpb24uDQo+IEkgYWdyZWUgdGhhdCBlYWNoIGRldmljZSBnZXRzIHRoZSBub3RpZmlj
YXRpb24gZnJvbSBkcml2ZXIuDQo+IFRoZSBxdWVzdGlvbiBpcywgc2hvdWxkIGl0IGJlIHZpcnRp
byBkcml2ZXIsIG9yIGV4aXN0aW5nIHBjaSBkcml2ZXIgd2hpY2ggdHJhbnNpdGlvbnMgdGhlIHN0
YXRlIGZyb20gZDAtPmQzIGFuZCBkMy0+ZDAgaXMgZW5vdWdoLg0KSXQgc2VlbXMgdGhlcmUgaXNu
J3QgZXhpc3RpbmcgcGNpIGRyaXZlciB0byB0cmFuc2l0aW9ucyBkMCBvciBkMyBzdGF0ZS4gQ291
bGQgeW91IHBsZWFzZSB0ZWxsIG1lIHdoaWNoIG9uZSBpdCBpcyBzcGVjaWZpY2FsbHk/IEkgYW0g
dmVyeSB3aWxsaW5nIHRvIGdpdmUgYSB0cnkuDQoNCj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgdGhh
dD8NCj4gDQo+Pj4+IC0tLSBhL3RyYW5zcG9ydC1wY2kudGV4DQo+Pj4+ICsrKyBiL3RyYW5zcG9y
dC1wY2kudGV4DQo+Pj4+IEBAIC0zMjUsNiArMzI1LDcgQEAgXHN1YnN1YnNlY3Rpb257Q29tbW9u
IGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlDQo+Pj4+IGxheW91dH1cbGFiZWx7c2VjOlZpcnRpbyBU
cmFuc3BvcnQNCj4+Pj4gICAgICAgICAgLyogQWJvdXQgdGhlIGFkbWluaXN0cmF0aW9uIHZpcnRx
dWV1ZS4gKi8NCj4+Pj4gICAgICAgICAgbGUxNiBhZG1pbl9xdWV1ZV9pbmRleDsgICAgICAgICAv
KiByZWFkLW9ubHkgZm9yIGRyaXZlciAqLw0KPj4+PiAgICAgICAgICBsZTE2IGFkbWluX3F1ZXVl
X251bTsgICAgICAgICAvKiByZWFkLW9ubHkgZm9yIGRyaXZlciAqLw0KPj4+PiArICAgICAgICBs
ZTE2IHByZXNlcnZlX3Jlc291cmNlczsgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8NCj4+PiBQcmVz
ZXJ2aW5nIHRoZXNlIHJlc291cmNlcyBpbiB0aGUgZGV2aWNlIGltcGxlbWVudGF0aW9uIHRha2Vz
IGZpbml0ZSBhbW91bnQNCj4+IG9mIHRpbWUuDQo+Pj4gUG9zc2libHkgbW9yZSB0aGFuIDQwbnNl
YyAodGltZSBvZiBQQ0llIHdyaXRlIFRMUCkuDQo+Pj4gSGVuY2UgdGhpcyByZWdpc3RlciBtdXN0
IGJlIGEgcG9sbGluZyByZWdpc3RlciB0byBpbmRpY2F0ZSB0aGF0DQo+PiBwcmVzZXJ2YXRpb25f
ZG9uZS4NCj4+PiBUaGlzIHdpbGwgdGVsbCB0aGUgZ3Vlc3Qgd2hlbiB0aGUgcHJlc2VydmF0aW9u
IGlzIGRvbmUsIGFuZCB3aGVuIHJlc3RvcmF0aW9uIGlzDQo+PiBkb25lLCBzbyB0aGF0IGl0IGNh
biByZXN1bWUgdXBwZXIgbGF5ZXJzLg0KPj4+DQo+Pj4gUGxlYXNlIHJlZmVyIHRvIHF1ZXVlX3Jl
c2V0IGRlZmluaXRpb24gdG8gbGVhcm4gbW9yZSBhYm91dCBzdWNoIHJlZ2lzdGVyDQo+PiBkZWZp
bml0aW9uLg0KPj4gVGhhbmtzLCBJIHdpbGwgcmVmZXIgdG8gInF1ZXVlX3Jlc2V0Ii4gU28sIEkg
bmVlZCB0aHJlZSB2YWx1ZXMsIGRyaXZlciB3cml0ZSAxIHRvDQo+PiBsZXQgZGV2aWNlIGRvIHBy
ZXNlcnZpbmcgcmVzb3VyY2VzLCBkcml2ZXIgd3JpdGUgMiB0byBsZXQgZGV2aWNlIGRvIHJlc3Rv
cmluZw0KPj4gcmVzb3VyY2VzLCBkZXZpY2Ugd3JpdGUgMCB0byB0ZWxsIGRyaXZlciB0aGF0IHBy
ZXNlcnZpbmcgb3IgcmVzdG9yaW5nIGRvbmUsIGFtIEkNCj4+IHJpZ2h0Pw0KPj4NCj4gUmlnaHQu
DQo+IA0KPiBBbmQgaWYgdGhlIGV4aXN0aW5nIHBjaWUgcG0gc3RhdGUgYml0cyBjYW4gZG8sIHdl
IGNhbiBsZXZlcmFnZSB0aGF0Lg0KPiBJZiBpdCBjYW5ub3QgYmUgdXNlZCwgbGV0cyBhZGQgdGhh
dCByZWFzb25pbmcgaW4gdGhlIGNvbW1pdCBsb2cgdG8gZGVzY3JpYmUgdGhpcyByZWdpc3Rlci4N
Cj4gDQo+Pj4NCj4+PiBMZXRzIHBsZWFzZSBtYWtlIHN1cmUgdGhhdCBQQ0llIFBNIGxldmVsIHJl
Z2lzdGVycyBhcmUgc3VmZmljaWVudC9ub3Qtc3VmZmljaWVudA0KPj4gdG8gZGVjaWRlIHRoZSBh
ZGRpdGlvbiBvZiB0aGlzIHJlZ2lzdGVyLg0KPj4gQnV0IGlmIHRoZSBkZXZpY2UgaXMgbm90IGEg
UENJZSBkZXZpY2UsIGl0IGRvZXNuJ3QgaGF2ZSBQTSBjYXBhYmlsaXR5LCB0aGVuIHRoaXMNCj4+
IHdpbGwgbm90IHdvcmsuIEFjdHVhbGx5IGluIG15IGxvY2FsIGVudmlyb25tZW50LCBwY2lfaXNf
ZXhwcmVzcygpIHJldHVybiBmYWxzZSBpbg0KPj4gUWVtdSwgdGhleSBhcmUgbm90IFBDSWUgZGV2
aWNlLg0KPiBJdCBpcyByZWFzb25hYmxlIHRvIGFzayB0byBwbHVnIGluIGFzIFBDSWUgZGV2aWNl
IGluIDIwMjMgdG8gZ2V0IG5ldyBmdW5jdGlvbmFsaXR5IHRoYXQgdG9vIHlvdSBtZW50aW9uZWQg
YSBncHUgZGV2aWNlLiDwn5iKDQo+IFdoaWNoIGRvZXMgbm90IGhhdmUgdmVyeSBsb25nIGhpc3Rv
cnkgb2YgYW55IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuDQpEbyB5b3Ugc3VnZ2VzdCBtZSB0byBh
ZGQgUE0gY2FwYWJpbGl0eSBmb3IgdmlydGlvLWdwdSBvciBjaGFuZ2UgdmlydGlvLWdwdSB0byBh
IFBDSWUgZGV2aWNlPw0KDQo+IFBsZWFzZSBleHBsb3JlIHRoZSBkMDwtPmQzIFBNIHN0YXRlIGJp
dCBpZiBjYW4gYmUgdXNlZC4NCj4gDQo+IFRoYW5rcyBhIGxvdC4NCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpKaXFpYW4gQ2hlbi4NCg==

