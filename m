Return-Path: <virtio-dev-return-12438-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C6EC7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 15:21:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E0EB929FE2
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 15:21:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA9B9986650
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 15:21:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD66A98663F; Wed, 26 Apr 2023 15:21:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9FAD986640;
	Wed, 26 Apr 2023 15:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua3WbiBdKkpRos9nsvXWuJStDdJmksjwW1sH/2JxGu0Q6vX/W/EL/lnQp1OqZJ8eCMCQAR4asBmWF2oOEiEwep3c/0jV2IcmnD3fsmX87lgDznNUfZ05AqApUHUdsIE68rxFlz+1xh6IImEC2+gbvW5E9RV+jzi5Cc4AVJS/vSNBNIhP3BPASkOYkP4tgot7m5fkFOQb4IzV15fl3e3lJG/+7TRoqW+AD5yYRLWA7Y+Xz8w3dJFj7hiGXra7qPFBk+pRhn0USrP1npAVe6in3r/IBj5WA5g/wDvksQWEziiZHcSqXZzaZbtjrRLoqysFXFHzHMpLaoz7O4LdJqdY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjTIVikBufvpTfKraKJ8HUGd+36hbqQM5fvTmRgKxts=;
 b=bWHNFqUPNpDpPsJvTXzIjTcdRbAHYf7Kl4yhAbneFf3KRHl/lBqxvYZZrwce04S1JLRf1ahw318DCPnE92InEadczpDm/PBwTijNQY4dW4T1wZH0u8Yn48LO8cmxH0PyihbpeLe3wJuBYOo68LaPaMF9BhA1MaU7kNrFgz/3EsdrPc7OY9dXsSO6xmGPKRpoGoBD0ZRmc+wCPSEo5OYTnMzGaU8NwkBQMxRTv/p3/gWruxL+xKc+xle87aP7rDPBXc1yJKXhBBzhOHhwGmIpxicShRWLfgWLo3dxl65/ViGkvBKoMTtKiyxsV5GOvCaf08sV2Q96lM04UFzxl/lgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v13] virtio-net: support inner
 header hash
Thread-Index:
 AQHZdbY0vUbPhs5ETkuums+/PkRABq88fZaAgAEg8YCAAABEcIAABYoAgAAAppCAAA54AIAABLgQ
Date: Wed, 26 Apr 2023 15:20:55 +0000
Message-ID:
 <PH0PR12MB548128BFD5C89A136CD4BDD8DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
 <PH0PR12MB5481EA937633233A9A9E5E30DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1d0adb7d-fcc8-404d-8105-bc1f818bc3a3@linux.alibaba.com>
 <PH0PR12MB54817E0B2B0B232B49320F5CDC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230426104902-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230426104902-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB6583:EE_
x-ms-office365-filtering-correlation-id: e90d67d9-35f7-40b3-c9c5-08db4669d4cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X83Tu9kvASpnBlH5jl/fVAtI4ATOtbZD/588XEBBnzNuhhmfbIwU+J+eNgln5fZlO0O7+xUMKbCA6zisZao0RvdodXlI8159vAmG79BWt+P+YpOJLFMv0Zke7UE8uUEJXeB7TAyURccFfC+bASqwC8POnmk73CoaerlFuvYV6rZ4OkQieW44Qsbxe8PW+fR5Rb71v7wZGZNirx2cuvBY5K0ytCGVWjzztJXrLuyAnrCmFtsM73GbtdrWTKbwjvz+bZxxORBAhuAd8JcYA4/w/xFv3tMQx/TdNZ1E5p2Un7iEbqaJ8JI30f6Z2cMEynP810WkYSrmKq+DcP9DL63rug9zTkn4yLOElYzuS2FmDueYxYK1qkK+tMN7mFhtsIpwaiJr5gOMzSEL6EVyPldUfjKtytSzn4HBKjZyl6LA3aVcI2jkknRepDxO3+q6mEJww7dKIRKYtBX3ZuqYrq7VUdQwlX9P89nuWaEcaGOghsa5DkZLLnHRv/Pzb3va3l/IoBwI23gx8jNDsfe9TufUOx/kTqEM7wbclxLf6z8UfJLikYbJY4NYJGkheawEjyoHJwEVdyAr6LB48wUEm+iFMJuFnuNPwuKe7/oERJfUMqMS4f+GN19EhWsv6spAoqvd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(52536014)(38100700002)(122000001)(5660300002)(8936002)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(8676002)(6916009)(41300700001)(86362001)(4326008)(316002)(38070700005)(55016003)(2906002)(26005)(186003)(6506007)(9686003)(7696005)(71200400001)(83380400001)(33656002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnZvMmFFNHRwcGtXRk1pSHNMWTNnaHpKMHV6QzUyaFFIWGhYenIyRDRvakp2?=
 =?utf-8?B?c3RWT3F1SjNsenpmZk5Sb3k0SitlMTR5L0psb05VWnRHVWRKbXcrOFNZVkpE?=
 =?utf-8?B?S1oyZ3k1YVVocWJYQjhGT3FGOEM5aytTQWU4UmtkL0Eyem13WHFoZnlmNjRv?=
 =?utf-8?B?TzhLL2I1UXZVZnI4NDRqdWhxb3FWdUNYK0ZQeTI1TXhOYlR0RkIzMGpKcUdr?=
 =?utf-8?B?K005TVFEOUNMZEVuR2t5c2dQVXkxMmdHWEpUM2dXV0JlSllMclFPRlp1Mmc4?=
 =?utf-8?B?Vm1ta3JlQi83TU5JbXpnZGNieVRtUHl5ckg3c3I2Q3IxNnFzMEh6SlUzQndH?=
 =?utf-8?B?SFY1TUNVTS9uSTBhLzhDQUpubXBZbjQvYUNrNUxsNUtNcGE5azRGSTRESThW?=
 =?utf-8?B?aGx0STFrL1VCbnI2T3owaGRJaHUrQmFCTmxTcUNKNDUyaVFwYzE5Q3NQTFhW?=
 =?utf-8?B?V3ZhZXJnUllTS1lqYmlhaE00L08rRlRSSVd5a1VLNXpBeUZmek5YdVhMQ1Jo?=
 =?utf-8?B?UGRqOG93YTFkYXZTN1BvTllnKzQrcXlzcTdneW1ZQjl6V2VrOFdGNjNYNGlT?=
 =?utf-8?B?dGR2OHlHTFkrZnFBY3hIZWlPYmhDVXMwYkx1eVVTMUZndmRXb0J4Q01rN3o4?=
 =?utf-8?B?cjRoQkxiL1NtWkEzcHlDRkNsbXltT1NUUWkySVk2Mnhoc3czZHhQQy9BOEVC?=
 =?utf-8?B?RGhwU005SFZjVzM2ZVdnZlJqanE4VVcwR0dubytPdkRja29VRCs5UEdTaDUx?=
 =?utf-8?B?cHNycVQ2dkUzRitDbGgwYzVQM01ZVE1GbVJLRDJpVTN6N2tuSktRVFJDa2pt?=
 =?utf-8?B?azlXbzc5VkFZQU51cGRDc2FDbHNsaFhhR2hraEhtdVc3NkJkMnMzeG9LWXNH?=
 =?utf-8?B?OXpVYzI5MGp3bzY3KzdrY2prTlBSelRUSVVlNUNVdVMyMkdnanMxRVlFbXRm?=
 =?utf-8?B?NHYvZ1hyQ2lWZDRhR0hiWTlQOVVRcUxUallMZEZLWnN5SGpGMzFiOEVQYlR4?=
 =?utf-8?B?RGJPdUlFWmJKUVZubzhRbU5Wcnp6a1BhUE1NTTA4TFRxWW0vRWJSeG1vK3Fi?=
 =?utf-8?B?UEhSc3ZEMU5kT2k2bDRtWnp1dThnekd5VzcxNDBTRHpldzh4RTZlelVsQ3dV?=
 =?utf-8?B?VytEbExKdTRGd1paMWt3UUcyZDhpTmZtcjV2aVJmL2VabE1SSk16OGI1bHow?=
 =?utf-8?B?L2ppcjg4VTVZb3hhenNlNGh5Y0cxZWdvVHZFc0tnc3cxTzcvUEExb2FhNEU4?=
 =?utf-8?B?NE04VFpkL2ZkUXRUK0dwY1NpRUswbTR1V3ZWdnhSb3JCeUtjdmJVOUR2WVFV?=
 =?utf-8?B?eHc3aHpwWWViNk16dENmZ2JJYTkxWWZ4QllmRy92NDFYazNWZzZ4c25YZk1F?=
 =?utf-8?B?QTlEN2FjbUpJWjhVZTNWd0JzWDVZVHZBYzU3Y0NVZHE4MDNsb0k1YjI2Ynh4?=
 =?utf-8?B?L2tVYTJUc28xSkpsVUFPSngwemRjeVJ5RXN5MVJGNXZNNWJLYUVBZG4xaWhw?=
 =?utf-8?B?QkRPdnV5WGhxa0swY1hSRVlUWkx4VlZGYitwZm92VXhmblBWM1BQSlNkUHZ5?=
 =?utf-8?B?cTdVdWIvMldOTWRrNGNwVDk0U0NFRGdUdFN6enJQMHBGQ2FhVkZLK3ZyR2N3?=
 =?utf-8?B?WHV0dHhiWUQrbklRYWtvb0dqdE5HQzhSU0Zuc09Xem1DNStoRk9udEo4TDBX?=
 =?utf-8?B?aVJuYmwvU1lWcGlVYmpEOU5SZkozbkN4aUdWZDJsc3pvSkZ4TE82eGxEbVBa?=
 =?utf-8?B?cmF0Q25oS3ZCOUZ1REZjQUpaTGNsMXNwM1hmcnlrY1lNTUdlWTFmVTFWUWlC?=
 =?utf-8?B?d2FvTmw2cE1QZ09UN011VEtpMXI2UEdTOWxPSkFPRUU2R1paNEJXNldwNy9t?=
 =?utf-8?B?RU5yeTlxOWMwTXJXdVJQV2k2OFdSMGd2VU1FRVlkT0RRYWkyamgyNzVzcmhy?=
 =?utf-8?B?cWNjdTNlYXgzTnVPSXpNYUhHUFVPeHNaL1dVSUQxbUZNVm93eFV3andMT25C?=
 =?utf-8?B?N0tNejBXek93bXE4QVh6OFZXeGRySUtDQTZBaGtKTW5wNGp2MUFGYTVkNlhL?=
 =?utf-8?B?N2IrUmFIMjY4OEJ4WGlpTjl2QW1tRG51RzhlK0VacW5yWkNtYVYzT3hpdWJy?=
 =?utf-8?Q?Py7A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90d67d9-35f7-40b3-c9c5-08db4669d4cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 15:20:55.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrF5k68jZaHdK9JtEEdR3gammClEOEWeIvVJ8enLazD0AEBn2sAWzxUeKOGgMeoq0kIpXN9LcLKWcBA/7C1L4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net: support inner header
 hash

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAyNiwgMjAyMyAxMDo1OCBBTQ0KDQo+IEFsbCB0aGVzZSBhcmUgUk9N
IHRob3VnaC4gQ2FuIGJlIHNoYXJlZCBiZXR3ZWVuIGZ1bmN0aW9ucyBvbiBhIHNpbmdsZSBkZXZp
Y2UsDQo+IGJlIGl0IFZGcyBvciBtdWx0aWZ1bmN0aW9uIFBGLiBZZWEgSSBoZWFyZCB5b3UgYWJv
dXQgbWF5YmUgbWFraW5nIHRoZW0NCj4gcHJvZ3JhbW1hYmxlLiBGb3Igc29tZSBjYXNlcyB3aGVy
ZSB0aGVyZSBpcyBhIGhhcmR3YXJlIHJlc291cmNlIGFzc29jaWF0ZWQNCj4gd2l0aCBpdCwgaXQg
bWFrZXMgc2Vuc2UuDQpSaWdodC4gU29tZSBhcmUsIHNvbWUgYXJlIG5vdCBST00uDQpBbmQgaXQg
ZGVtYW5kcyBzcGVjaWFsIGNpcmN1aXRyeSBmb3Igbm9uLWNyaXRpY2FsIHBhdGguDQoNCj4gTm90
IGluIHRoaXMgY2FzZSB0aG91Z2gsIGl0J3MganVzdCBhbm90aGVyIHdheSB0byBjYWxjdWxhdGUg
aGFzaC4NCj4gDQpTdXJlLiBJbnN0ZWFkIG9mIGRvaW5nIGZpZWxkIGJ5IGZpZWxkIGJpLXNlY3Rp
b24gdGhpcyB3YXkgcmVxdWlyZXMgY29uc3RhbnQgZGlzY3Vzc2lvbiBsaWtlIHRoaXMuDQpJbnN0
ZWFkLCBwbGFjZW1lbnQgb2YgdGltZSBjcml0aWNhbCBmaWVsZHMgaW4gTU1JTyBpcyBiZXR0ZXIg
YXBwcm9hY2ggYXMgaXQgaXMgZ2VuZXJpYyBndWlkZWxpbmUgdnMgUk9NL1JBTSBmaWVsZHMuDQog
DQo+IA0KPiA+IERlcGVuZGluZyBvbiB0aGUgY29udGFpbmVyL1ZNIHNpemUgY2VydGFpbiBjYXBh
YmlsaXRpZXMgbWF5IGNoYW5nZSBmcm9tDQo+IGRldmljZSB0byBkZXZpY2UuDQo+ID4gSGVuY2Ug
aXQgaXMgaGFyZCB0byBkZWR1cGxpY2F0ZSB0aGVtIGF0IGRldmljZSBsZXZlbC4NCj4gPg0KPiA+
IFRoZXJlZm9yZSwgYWJpbGl0eSB0byBxdWVyeSB0aGVtIG92ZXIgYSBub25fYWx3YXlzX2F2YWls
YWJsZSB0cmFuc3BvcnQgaXMNCj4gcHJlZmVycmVkIGNob2ljZSBmcm9tIHRoZSBkZXZpY2UuDQo+
ID4NCj4gPiBBIGRyaXZlciBtYXkgY2hvb3NlIHRvIGNhY2hlIGl0IGlmIGl0cyBiZWluZyBmcmVx
dWVudGx5IGFjY2Vzc2VkIG9yIGFzayBkZXZpY2UNCj4gd2hlbiBuZWVkZWQuDQo+ID4gRXZlbiB3
aGVuIGl0J3MgY2FjaGVkIGJ5IGRyaXZlciwgaXQgaXMgY29taW5nIGZyb20gdGhlIGNvbXBvbmVu
dCB0aGF0DQo+IGRvZXNu4oCZdCBoYXZlIHRyYW5zcG9ydCBsZXZlbCB0aW1lb3V0cyBhc3NvY2lh
dGVkIHdpdGggaXQuDQo+IA0KPiB3ZWxsIGNhY2hpbmcgYnkgZHJpdmVyIGlzIHVzaW5nIHVwIHNh
bWUgYW1vdW50IG9mIFJBTSwgb25seSB3aXRoIG5vIGNoYW5jZSB0bw0KPiANCk5vIGNoYW5jZSB0
byBmYXVsdC4gQW5kIGJldHRlciB1dGlsaXppbmcgdGhlIGRldmljZS4NCkFuZCBpdCBpcyBub3Qg
YWx3YXlzIHRoZSBwaW5uZWQgUkFNLCBmdXR1cmUgaXQgY2FuIGJlIHBhZ2VkIG91dCB0b28uIA0K
TWFueSBmaWVsZHMgd29uJ3QgYmUgZXZlbiBjYWNoZWQuDQpTb21lIG1heSBldmVuIGdldCBzZXQg
aW4gdGhlIG5ldF9kZXZpY2Ugb3Igb3RoZXIga2VybmVsIGxldmVsIGRldmljZSBzdHJ1Y3R1cmVz
Lg0K

