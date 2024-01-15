Return-Path: <virtio-dev-return-14237-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBE8C47258
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:46:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 158BD429AA
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:46:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0ADD598670A
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:46:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED00398403A; Mon, 15 Jan 2024 09:46:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5D2F986367;
	Mon, 15 Jan 2024 09:46:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+dyYFGviqrgcI0e5B+ehc7YqROp6sXMuQa2zbUfoCWSD+gglQ77qcx1oN/jdpxqNp8i9Lv/q8XHbJCROc7rsP2VhsmOyNKp2d5/WTISdiyga655Gg7Ol40yhVTA1Tr+ogcNnweXHpZRFB6kHd7rp+7m6GsjTMHue/BoXvEVlqc/HYvi+yO96gnmzVjX9pb/fVYZNXQzNmha2FhEkmDFeu+mUp/iFqVkvNK03mgamwMbolZaId/VpkdaodqFO/9zAugBvovh/allwqN7RE46GgJZx26wyYcfs6HpyfSPOZ1L7MXHJCPKkeLTVBVP/yHd/XGjOt8sHiz5+IOm+xhElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH602gPO5oi29M0IYtrwygQSi+672kgkl1QWB+dOoHE=;
 b=SIAVzMYWcziR+p6gfIwopVCk8rmvY4dJxpPsaVmelyxb92m5BvLOPuC7ubXwZa7kmczKVlw1UmgE8FfuL1K2Lqzmlhrg5o3ngjMPy9Opk0+yf97Z6yUgcv9r8MeRg1bDUBquUYxD4a5ApD+V97nTaKQ2h9Xt2b5epvaynZGhwWANSa2qMMom5ppJ3Ko4ZLLnOCuiS2Qj3CdO7LZBEdsjByXifI0aimZdSaD4ocPrfZcxGM0AEM6OLz7+v8WmeQphxhvc2nlYzNBd8xBdLnESwmtcZAK0zc+elOulOL6ELAZWqPzahKAGqpYwrCwh4xzcmhUwaE+qGPV8gAvP0g+bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1AgASS9ACAAADIQIAAA3aAgAABUvCAAAfBgIAACCRggAAFhACAAADCcIAAB8gAgAAAqUA=
Date: Mon, 15 Jan 2024 09:46:21 +0000
Message-ID:
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4886:EE_
x-ms-office365-filtering-correlation-id: caddbbaa-c870-4d49-8e26-08dc15aed485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YCyuNn6SqKISlF+nDX+vsq+D8VPdF37grOWMpGzuArtvfja9KCfqhN3x/eHMoOmF+WMi9nkZnwOU2vhcG6e+RGArq0J+OySWb47d5LJokVQGXOFR4L8LoaUAwh6Db6dNkoSgzGSw/L886GLjcOaCgWfPls0QMEL139KvRE8nmSyGx60L/fwfCK8COdqVWjnEUuvkQ9cseqvNbhN/ezfay01pcGS3yJPQ2irFj/12vrwUGVIHlFjlSURignzU4I0snKGqm62tWY55XdNm64f6atlNlSGDlOKOkxuiC8NGtuMrXgh4qVwmtMT6djHlFsf33siNiOfTBQ9afmmvtdOeC6nZXt5UrbZYd2/qTUSuASSrLez3wZqe10be01vY2VP23z4QoV7PWkkCrfrDyus960c1AkOTRbxMbjOhMTbyNj3OZJbXTPI1jvga0JmGGLi7XogNxcYtv09tR8nPmIdUVPEV0cofgvc8aB3APEQ/dnZ6hYF7uQ8h219VLVP60WmRLT1rHhLR+YQrn0cICBQt+4OaklJSi3AkBzTaTqJ4nj2/agYqtpxnmPlYotcDBchN0pAy++YdDvhR9OUyH65uBuGK1wkEy71AAocF7aRW9R4n5LJxUt3S6I3nSEc2vr2L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(7416002)(41300700001)(8936002)(52536014)(2906002)(26005)(122000001)(38100700002)(86362001)(83380400001)(9686003)(6506007)(7696005)(71200400001)(478600001)(55236004)(66476007)(8676002)(4326008)(38070700009)(76116006)(33656002)(316002)(6916009)(66446008)(66946007)(54906003)(64756008)(66556008)(55016003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tkw1Z3JLZ0QzY2IzY2xJb0hCZG02Zkd4SHk5N3Ztemw2QzE3eThCQ291ZHNz?=
 =?utf-8?B?bGdGdjdzcGxUUFhCUFNYM3BBanBaWUlCYXRwbjNicUJPeVFmN09KMThTeEU0?=
 =?utf-8?B?SjZQS3ErS3JuRHpnUERpeEtrckpmWEpQV3c2YmQwTEFuWTB5NXF2QUcwMUJB?=
 =?utf-8?B?SDJKVm1Ldk9LSUJjQU5rdFMrazk1SkJvajFBcXZpOTlSaThWY2l3cXYreXJU?=
 =?utf-8?B?ZlFXaTUybENYakpiWUdESVlyR2dWS1grZ0x6b082bWRtTTVGSXNUZFYxVXNX?=
 =?utf-8?B?dXN1RWZHSHBDdmViSG1wODJ5NFAxaE5wbkJKSkYyaDY3U1c4VHhMWlMzYml1?=
 =?utf-8?B?SFJmRVg3OEdUZFdmemoreEhJYnJKMjUrVlpBMXlzVU5KZmViUHBLWi9HTTNM?=
 =?utf-8?B?a1BBWXV3bkd2RnR4bzNmK3JpYU1UUUZJOU84ODRRZ0VYUThpQ3dUb3hnWjJn?=
 =?utf-8?B?TTdTU1BYYXpJWGdpTk9CNUVtOHkxb2NmNjlSRTZkanV1NXFFMmpYMVhQYjY1?=
 =?utf-8?B?RlJqNWUzeG9nRHVCaW1MUDI2TkRuZXJQbXVLMGFzc29Yb2gvMGkyZzZYcjJU?=
 =?utf-8?B?aWlTaUd2ZkVuLzhxZTY2TnQzUkRPeUNFeFd1UDc5MW80NWFCYU83ZHJVRGNF?=
 =?utf-8?B?N1d4MzAybW1TRGZTU28wTngwbkFnK2d0MEZLYTJMamp3TVN5QzcxMGM2T1Ru?=
 =?utf-8?B?Yy84Z2crY1dlUFNnZm5NWGx4b1ZxV0lpRFpVR3h6U1VxU1Y4ZS8xZ0t2NXo1?=
 =?utf-8?B?TklNSjc0SzRZM1hZZ2FwQ043WGUwR2VvZWp3UnhYeFhXOTVmYW4zMVNQS1FM?=
 =?utf-8?B?UGt5bW1TSmp6Q3VyWC8zeDJRRlJBbm5VNDE0M1lZaEVWclU3TUJ2Wkt3M255?=
 =?utf-8?B?NzkrUHdud0t0NkNpMHg3c2VQVkczRlY5VG92K2VNZGh3NllvSWg5VlRtMXFB?=
 =?utf-8?B?cTVsTldOUG9sWVZkN1VMM3lhZnRHYXVQNEZlY2F2OExnQXpEUkJ6MUtsRmRh?=
 =?utf-8?B?eFo0MjlkbGQ2MnVpWXlZdWdHU0t4aEwzMEVUVno0T1lXakc5Q3ZpZXdZOThV?=
 =?utf-8?B?RW93OFZPVnVBRVJUTjloY1M2VjdSV29uYm9CMnVsTS9ncldCWVRUTk5KK09H?=
 =?utf-8?B?dDh5aXBJYmdsbzdndk91c2ZxMktNdGo5MEFXWHhaOFkvOVRybnZHUUc2UzBP?=
 =?utf-8?B?L3NLUks4TDV6SUlaMDZtTVppUTVkSjB6TG1FanBuZ001YndsRW5zMVE3SUkv?=
 =?utf-8?B?OG5KTHNkVjFvcHJNQzRuNUZacXg3MkpOUEJMQ2pMdHFhNE0xS3hxcFFNdlhT?=
 =?utf-8?B?UzVacjBEQ1Y2eXlucnQ1OXpoMFIwNWVBNkJMQkR2bklVbEdER3JpVy9xR0lZ?=
 =?utf-8?B?Rk9VNWZ0MEFkcnJ4WlYxM0ZtNk92Z3FWckxzaXhxaldTR25MTTdQN1dRK2pi?=
 =?utf-8?B?dTlLNFNLLzg3Mjhha2tzS2VKTmxFbDhIL0tUZk5Rbkdlb200M2VFazljYXBj?=
 =?utf-8?B?bHZDR0ZNcUoyRjFDVmYwb2lHbGlmQ2hjbWZyY1pZWVVqRDJkeFRpYkJwQ21o?=
 =?utf-8?B?dGZNaEJNaFE3Rk9JS0JLSzZCK3BCQmkzMVZ3SXRBQ0VoS2JGbHEzNzgwMm40?=
 =?utf-8?B?N21kWUVrMFl0NFZYRmtHMG1vM0xTbEQyUWZOck16dEMxeENONkc5V1pmejlp?=
 =?utf-8?B?TWI2QmcwNTNGNTZvMzhmRFNoWWVWRXRsemRET3k5QmRnZTF5emdNL3hGN0gv?=
 =?utf-8?B?cGYwa3VUTFd0SUd3NHJnclRTenRnZ3FiSFRyeVJFb3JmdzRWbmg4alVndjNm?=
 =?utf-8?B?VHNPeDBGY3gwQTlUblJ0dkFQaUpwMThXekJxL1BKWGhwa3NDU2w3SHdhZG9p?=
 =?utf-8?B?M1NGMlI5Q1JWaHd1T0xZeHRaUTE1UTNkbGpxYWw1VUsrWjdMWUsrQ0t3bWJI?=
 =?utf-8?B?M2NuSlZtaG9PM3h0WExBZzRBTGkxdWhjdXFkKzRFMGYrbkJ2bzJJQlZnSEtP?=
 =?utf-8?B?V3MxN2JyUktHa0hialhOeXZ1MFZkWmNiUE9RbmY5QmREQWtZZmFzQXV5VEVp?=
 =?utf-8?B?b25FU0xqdHFpL1YrRnBnZkdHRmw0eUE3Z2NQb2ZJRk1yN0VZZGE5dTcxUldI?=
 =?utf-8?Q?yM6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caddbbaa-c870-4d49-8e26-08dc15aed485
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 09:46:21.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ad1ZczF6R3FKykL/9/IFpiAIIL52Xie8i1B/4q+NjV4wwdq+TgVajkEfbkzbycfC8WLeKrryhBn0S19giltwjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDM6MTAgUE0NCg0KPiA+IERpc3BsYXkgcmVzb3VyY2VzIHNo
b3VsZCBiZSBvbmx5IHJlc3RvcmVkIHdoZW4gZm9sbG93aW5nIGNvbmRpdGlvbnMgYXJlDQo+IG1l
dC4NCj4gPiAxLiBQQ0kgUE0gY2FwIGlzIHJlcG9ydGVkLg0KPiA+IDIuIFBDSSBQTSBjYXAgaGFz
IG5vbl9zb2Z0X3Jlc2V0PTENCj4gPiAzLiB2aXJ0aW8gZ3Vlc3QgZHJpdmVyIGRvIG5vdCBwZXJm
b3JtIHJlc2V0IHdoZW4gdHJhbnNwb3J0IG9mZmVycyBhIHJlc3RvcmUNCj4gY2FwYWJpbGl0eSB1
c2luZyAjMSBhbmQgIzIuDQo+ID4NCj4gPiBEbyB5b3UgYWdyZWU/IFllcz8NCj4gWWVzLCBJIHRo
aW5rIHRoaXMgcHJvYmxlbSAoZGlzcGxheSByZXNvdXJjZXMgYXJlIGRlc3Ryb3llZCBkdXJpbmcg
UzMpIGNhbiBiZQ0KPiBzb3J0ZWQgdG8gdHdvIHNpdHVhdGlvbnM6DQo+IEZpcnN0IGlzIHdoYXQg
eW91IHNhaWQgYWJvdmUsIGluIHRoaXMgc2l0dWF0aW9uLCB0aGUgZGV2aWNlc19yZXNldCBvZiBx
ZW11IGlzDQo+IHVucmVhc29uYWJsZSwgaWYgYSBkZXZpY2UgaGFzIFBNIGNhcCBhbmQgbm9uX3Nv
ZnRfcmVzZXQ9MSwgcWVtdSBzaG91bGQgbm90DQo+IGRvIHJlc2V0dGluZy4NCg0KPiBTZWNvbmQg
aXMgd2l0aG91dCAjMSBvciAjMiwgdGhlIHJlc2V0IGJlaGF2aW9yIGlzIGZpbmUuIE15IHBhdGNo
IGlzIHRvIGZpeCB0aGlzDQo+IHNpdHVhdGlvbiwgdGhhdCBzZW5kaW5nIGEgbmV3IHZpcnRpby1n
cHUgY29tbWFuZCB0byBub3RpZnkgcWVtdSB0byBwcmV2ZW50DQo+IGRlc3Ryb3lpbmcgZGlzcGxh
eSByZXNvdXJjZXMgZHVyaW5nIFMzLg0KDQpJIHN0aWxsIGhhdmUgaGFyZCB0aW1lIGZvbGxvd2lu
ZyAiTXkgcGF0Y2ggaXMgdG8gZml4IHRoaXMgc2l0dWF0aW9uLi4uIi4NCg0KV2hlbiAjMSBhbmQg
IzIgaXMgbm90IGRvbmUsIHRoZXJlIGlzIG5vdGhpbmcgdG8gcmVzdG9yZS4gDQpEcml2ZXIgc2hv
dWxkIG5vdCBzZW5kIHNvbWUgbmV3IHZpcnRpbyBzcGVjaWZpYyBjb21tYW5kIHdoZW4gIzEgYW5k
ICMyIGlzIG5vdCB0aGVyZS4NCkluc3RlYWQsIGlmIHRoZSBkZXZpY2Ugd2FudHMgdG8gcmVzdG9y
ZSB0aGUgY29udGV4dCwgYWxsICMxLCAjMiBhbmQgIzMgc2hvdWxkIGJlIGRvbmUgdG8gaW1wbGVt
ZW50IHRoZSByZXN0b3JlIGZ1bmN0aW9uYWxpdHkuDQoNCkluIG90aGVyIHdvcmRzLCBpZiBvbmUg
d2FudHMgdG8gdXNlIGRldmljZSBjb250ZXh0IHJlc3RvcmUgb24gUE0gc3RhdGUgdHJhbnNpdGlv
biBpdCBzaG91bGQgZG8gIzEsICMyIGFuZCAjMy4NCihhbmQgYXZvaWQgaW52ZW50aW5nIG5ldyBp
bmZyYXN0cnVjdHVyZSBiZWNhdXNlIFBDSSBQTSBoYXMgbmVjZXNzYXJ5IHRoaW5ncykuDQo=

