Return-Path: <virtio-dev-return-14239-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB6FC3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 10:52:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6773DF3F46
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 10:52:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D0779865CD
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 10:52:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 510549861D0; Mon, 15 Jan 2024 10:52:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39DF3986367;
	Mon, 15 Jan 2024 10:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJrKNpfbTdsUK1N/pfoobh8YvRdsKZXsL+Xs0bcbiznRYLMhNjQAL5ltiC2F8Hm/6la4kvPvdaUkkL/Yl2s+pSM7R4KjEbBoh/vjt9BwIbYz+XHphOytlASHmnpqXjHX+cpDf6Gaz3dYyXfH55eIaWAhOHo4mTbK5jgeDxNHz7iVLdDuixgiNhyXluJ1WZSbbLTWlLJ+Eolf1vEYZ6UVwMWGFyEraWI9QHAnvEkrA765U2h+4yvRHpPEfaCd3DTP/cTIb5Hm1rwf8QGjceYysZdaK+UQaY/++xooLIU5ukT1pbN4KDGnYAvtdKyeTJtqZqqRBDm/G1RY41hQsgIS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XevWY5rb310xc/SKd4dcLCjQlenzNnPUsEYocOSQ1x0=;
 b=DJqU6rpZNocwdzmhTzIbc7NeL6++uF/th3rQGBin9nkr7ZZGRs4VZBjHZDGqr12tJ08aOyv0qvyrEnU6fyE9Z9zTwR15h6MvtNG/6oWDqr3bdrESszeVy2zxlI7YFqMwnkdTfIXIcMQN1ucKmX7MTZGeQiDOXfVw6UoQXu/zSNlLGJoWTOzRS0/aqhVsMrQ+1aK1+mfNPMxYyR4NPGhZOlNRkhS9OvXnJEY/IDb0DkjWfPKSKykuAHm5ww4kUiywmuHEGDvth3M+izt6/wV+MGRgM7zPVv/8U/ZaV2S8pQeENhyoPr4QW6uoYW3eLU4fgDoXxzrMfBwEeIMV0X2m3Q==
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
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1AgASS9ACAAADIQIAAA3aAgAABUvCAAAfBgIAACCRggAAFhACAAADCcIAAB8gAgAAAqUCAABIUAIAAAJPQ
Date: Mon, 15 Jan 2024 10:52:45 +0000
Message-ID:
 <PH0PR12MB5481FC877410A34DF11CFBFCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
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
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584944D5ECADD4566A8E066CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584944D5ECADD4566A8E066CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8422:EE_
x-ms-office365-filtering-correlation-id: 83967ef4-5fbf-4dfd-0090-08dc15b81b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x15m7mjrAQn+6x2A2N9iC+NrMs3g4jDshGx5CwUE4l04QopI667tL345cQglMVgPDiu0O7zcGXcm1es1shvUUKTif7DANnhbqR3IcMio6mnkaYBYUCnY2QBMkU9G8INv6Ksl60VBtAZtlzQhCPc6It+xx3V6vf30yVcvDBXetAdN33I75+pNQ9cFz0h6QGfxoXQ+dQe1Fzd+sVmLnXwXMIJKClNc5bEqx8qgbig/yTU30dDzJ1revyndyDzKzKOq1itYcEKot8PVXywwYhCT99t8iAm4nHr6xclYYfhpb+mebgRuHfpIX8xFnKz3ugOuKU2+6JgA2NX21cBGBob3wI8YGaqSwKka3zEXOliFQ8F7Pv3pIQfF58ZhC8hyJZWBeHHZGlvU9phTXqdqTPs57cWETmfi/gFL/IGUiEnQUbMUJ9nFh8G3NAeh8BWjcbfbI5rr7zdzGDmNowWVx3dMUbFIMjSSn0KqOTOj/i0a8xvYZTKv+qFvgXxgC6buRFRpZKcwl2OWmtOWtXEsEi7wdaAE72q37ILixDXc1zDikBehuESKLMywDXr9vcH8qFbSZrXgPZxwBCQNJ37FewkgrGo5bPWi2Wltzr8NQJmqFtO/4LLvS2wP2GTSsCJFlN3/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(53546011)(5660300002)(26005)(66476007)(122000001)(9686003)(55236004)(38100700002)(54906003)(478600001)(8676002)(4326008)(7416002)(52536014)(41300700001)(2906002)(7696005)(8936002)(6916009)(66946007)(76116006)(6506007)(316002)(64756008)(66556008)(66446008)(83380400001)(33656002)(86362001)(71200400001)(38070700009)(55016003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0NoZ283ZWNrTFJxRXp5QW1ndTAveWlmdjVUWWw2d2NONXliZ0JkZGxHZ0xo?=
 =?utf-8?B?ZW1Bb0ZmeGp2NWpHV0ZBSGVqMnptL0lIYVJPV1hGOW5RSlVxUUhXdllZL2xN?=
 =?utf-8?B?bFY0bzF0OGpTRnJpZUdYaTBrZmtwT3R4M2FiaTNDYUhVbUNIU1Q2eG5ycnI3?=
 =?utf-8?B?NWdSWGxIZ0RCWUE4T0JmRFBlUzJZUzBZa3ZzZ3FtZ0pqREZMbjlkajlpOXVz?=
 =?utf-8?B?eU9xcE5pTEttdXh1c3FHZEx3V3ZERU4wQm1PV0d5Tm1wa0cxTlpPWlJiQ1Qw?=
 =?utf-8?B?UEtvU0c1V3ZNUWdnUjhOTmlWN1JQc20rNUpYUXRiWVN0M0tDSlNxaXl5c1pB?=
 =?utf-8?B?aGM5RGdzMnlzV29OWjNZVXZFMUhINzdmc2dVSm5RVXp1SkdUVWpldFQ5RjI0?=
 =?utf-8?B?SHc4MENEVEMyanRlV2J0KzcxRTltUmJjQjB6SFRPWGh2T3Q1cnY3cGh6dFY4?=
 =?utf-8?B?cEd0aDc0TGR6bm51TkN2YjBGWjVaazYrTkwrRHZLL0swSWMwaS9JaElGWU92?=
 =?utf-8?B?V1RDWUQ0a0pDOWpKdzlyRE1xKy9OVUd1Yi84VWJKR1hYZldVNmN0Z0pSd05x?=
 =?utf-8?B?eEhXUkZIWW9pbmFVa2F2MmhTdXZidjBKL0FJcWtWTUVvUWZOQnhZU0wycW9B?=
 =?utf-8?B?VGt5K2lSYzBHQS9XUFhvNnhyOHM2L0Q2OFNwZVdDQ1BZYkxJMlhUc2pBZ05P?=
 =?utf-8?B?MU1oRWJrbnpjRHZKd01QRzBBN0NMTzJhRVY5ckJodmhVSWJ3cFV6bWc5RUhp?=
 =?utf-8?B?Wi9ISllMQVFNVDk5ak5TcnpaU1VzNWtRMVBSWkRnWDVRRHBabHV3bG9FYmY2?=
 =?utf-8?B?WDlSMVd0TDJNTXRsYkZCUjBpVUlsaTBzSkUybVB5V3R6Mjl2b1BMVll6cFc1?=
 =?utf-8?B?eUFGQk5lN3MrUHRQZEJ6cUxqOUt6Rk0wQzFMNHpvUkR4dEdVZ3B1TzloTTRx?=
 =?utf-8?B?aC9pVnZncXJRbElVa2NwVDJVT1lQOVhSdUVGL01WNkh5cDZMelpyL05OdGJV?=
 =?utf-8?B?dTFFMFQrK3QyeXdXcStvWUFJMDk3VVdsVm80ZFFSTSt3SFlLVDQ0MU1aRnFE?=
 =?utf-8?B?VU1BU1kyMlp3Z1JrWjBmUFBqenc1UndoM28rZnVSOUJsejRnZTVFTDBKYkNa?=
 =?utf-8?B?QlY5VVFhZGllSGxYMFpsT3Fzc1RZS3BOSlBFVDVMMk83Ti9ZUkI1ck9SbTJB?=
 =?utf-8?B?NWxLMEt2K2labkZZOS8rWERDNHM2OVdtVXdMa01jSXAyMG1oMlZNWWJMVnpN?=
 =?utf-8?B?c3NoNjZoaGJMWERwZ3VHK0xRY3MzNm9Jek9Qdm1IT0taN1l1Q1Y0WGh5UFVR?=
 =?utf-8?B?WGVhOHVFWmVmc0dNZzBKWHZXTDU4aGVFV0FrbjYzNnlMQm51MStSZlpzNklz?=
 =?utf-8?B?ZGNRclZTa3FOeE9FNWZ2SlgxNVdKaTdGNUVkS213OTArRU9JMFZKbFErYkx6?=
 =?utf-8?B?cjhFWmtONFN6VFdUMk5WMUxFWDE2c0xtWDRmTG9OTDE1QUdkUlpMeFp2cTA0?=
 =?utf-8?B?QVBQQ0hHUXBJZ1loeXdSOWFUT2h0MTNQYXBQQ0NxWGVHU0hlQWpieStZWk5U?=
 =?utf-8?B?dnZacll0WXNlMko2WFdwQnZGU05OSVdjdG1BQVJiVm5MaUpPbnJaeUlqUXhR?=
 =?utf-8?B?Ulo2Q016MlVzeFJxZ0hiOUZrQUYyTWVFUFVSemk4ZFdiMUdwMWtwMlE0cjI0?=
 =?utf-8?B?cjlXb1JUNzZZcjBkT0M0Uys1VWNnOXhXMDE2NW5tN2JhRHdDNDRtSEs2aFlE?=
 =?utf-8?B?U1FibU5EbjRLa25xSVg5aWJkazdOd1lraXRSRTNHdXBsWEhyM1IxdkpIZEk1?=
 =?utf-8?B?bytkTC95T0hQMmxXZTM1ZERpK0pLdjRVazJUYnBpVTBVa1ZUZEd1ekFEY2dy?=
 =?utf-8?B?Yyt2ekxCVXpOOE1rWTJmL3FFQ0VwVDVmMkFCaTNTTGJld1VtVEJoYjRYaFR5?=
 =?utf-8?B?eUp1RC8wSktGb0lSZC9TTE9GdzJwS0pzd0tiVmxFSC9JeXA4WXhJZ2J5L0k0?=
 =?utf-8?B?WGt1b1RSTE9Yai9SbDBCSG82dDRKdnVOY29PdGRqc2laSE1PU2hVckVBazhr?=
 =?utf-8?B?b0JYVXBVRkFsWUtGYWtnNGFBdHlDNEVBdjZnU3g2YlZZRCtXOG9xNHN5R2ly?=
 =?utf-8?Q?5rXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83967ef4-5fbf-4dfd-0090-08dc15b81b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 10:52:45.1489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: my08EdDqHvUzDLy6cwueLlSRqUOWXboEZMgVPbWVBeFEON20/kOvpCk6MiJDB73q2EvceIWwk5XRj/tpiYQENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDQ6MTcgUE0NCj4gDQo+IE9uIDIwMjQvMS8xNSAxNzo0Niwg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFu
LkNoZW5AYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDM6MTAg
UE0NCj4gPg0KPiA+Pj4gRGlzcGxheSByZXNvdXJjZXMgc2hvdWxkIGJlIG9ubHkgcmVzdG9yZWQg
d2hlbiBmb2xsb3dpbmcgY29uZGl0aW9ucw0KPiA+Pj4gYXJlDQo+ID4+IG1ldC4NCj4gPj4+IDEu
IFBDSSBQTSBjYXAgaXMgcmVwb3J0ZWQuDQo+ID4+PiAyLiBQQ0kgUE0gY2FwIGhhcyBub25fc29m
dF9yZXNldD0xDQo+ID4+PiAzLiB2aXJ0aW8gZ3Vlc3QgZHJpdmVyIGRvIG5vdCBwZXJmb3JtIHJl
c2V0IHdoZW4gdHJhbnNwb3J0IG9mZmVycyBhDQo+ID4+PiByZXN0b3JlDQo+ID4+IGNhcGFiaWxp
dHkgdXNpbmcgIzEgYW5kICMyLg0KPiA+Pj4NCj4gPj4+IERvIHlvdSBhZ3JlZT8gWWVzPw0KPiA+
PiBZZXMsIEkgdGhpbmsgdGhpcyBwcm9ibGVtIChkaXNwbGF5IHJlc291cmNlcyBhcmUgZGVzdHJv
eWVkIGR1cmluZyBTMykNCj4gPj4gY2FuIGJlIHNvcnRlZCB0byB0d28gc2l0dWF0aW9uczoNCj4g
Pj4gRmlyc3QgaXMgd2hhdCB5b3Ugc2FpZCBhYm92ZSwgaW4gdGhpcyBzaXR1YXRpb24sIHRoZSBk
ZXZpY2VzX3Jlc2V0IG9mDQo+ID4+IHFlbXUgaXMgdW5yZWFzb25hYmxlLCBpZiBhIGRldmljZSBo
YXMgUE0gY2FwIGFuZCBub25fc29mdF9yZXNldD0xLA0KPiA+PiBxZW11IHNob3VsZCBub3QgZG8g
cmVzZXR0aW5nLg0KPiA+DQo+ID4+IFNlY29uZCBpcyB3aXRob3V0ICMxIG9yICMyLCB0aGUgcmVz
ZXQgYmVoYXZpb3IgaXMgZmluZS4gTXkgcGF0Y2ggaXMNCj4gPj4gdG8gZml4IHRoaXMgc2l0dWF0
aW9uLCB0aGF0IHNlbmRpbmcgYSBuZXcgdmlydGlvLWdwdSBjb21tYW5kIHRvDQo+ID4+IG5vdGlm
eSBxZW11IHRvIHByZXZlbnQgZGVzdHJveWluZyBkaXNwbGF5IHJlc291cmNlcyBkdXJpbmcgUzMu
DQo+ID4NCj4gPiBJIHN0aWxsIGhhdmUgaGFyZCB0aW1lIGZvbGxvd2luZyAiTXkgcGF0Y2ggaXMg
dG8gZml4IHRoaXMgc2l0dWF0aW9uLi4uIi4NCj4gPg0KPiA+IFdoZW4gIzEgYW5kICMyIGlzIG5v
dCBkb25lLCB0aGVyZSBpcyBub3RoaW5nIHRvIHJlc3RvcmUuDQo+ID4gRHJpdmVyIHNob3VsZCBu
b3Qgc2VuZCBzb21lIG5ldyB2aXJ0aW8gc3BlY2lmaWMgY29tbWFuZCB3aGVuICMxIGFuZCAjMiBp
cw0KPiBub3QgdGhlcmUuDQo+ID4gSW5zdGVhZCwgaWYgdGhlIGRldmljZSB3YW50cyB0byByZXN0
b3JlIHRoZSBjb250ZXh0LCBhbGwgIzEsICMyIGFuZCAjMyBzaG91bGQNCj4gYmUgZG9uZSB0byBp
bXBsZW1lbnQgdGhlIHJlc3RvcmUgZnVuY3Rpb25hbGl0eS4NCj4gV2hlbiAjMSBhbmQgIzIgaXMg
ZG9uZS4gVGhlICJkZXZpY2UgcmVzZXQgYmVoYXZpb3IiIHNob3VsZCBub3QgaGFwcGVuLiBBbmQN
Cj4gdGhlbiB0aGUgZGlzcGxheSByZXNvdXJjZXMgYXJlIG5vdCBkZXN0cm95ZWQuDQo+IEkgZGlk
buKAmXQgc2F5IHNlbmQgY29tbWFuZCB0byByZXN0b3JlIGNvbnRleHQuDQoNCj4gSSBtZWFuIHdo
ZW4gIzEgYW5kICMyIGlzIG5vdCBkb25lLiBEcml2ZXIgYW5kIHFlbXUgYm90aCByZXNldCBkZXZp
Y2VzIHdoZW4NCj4gcmVzdW1pbmcsIGF0IHRoYXQgdGltZSwgDQpBYm92ZSBiZWhhdmlvciBpcyBh
cyBwZXIgdGhlIHNwZWMgZ3VpZGVsaW5lcy4gSGVuY2UgaXQgaXMgZmluZS4NCg0KPiB3ZSBuZWVk
IGEgbWV0aG9kIHRvIHByZXZlbnQgdGhlIGRpc3BsYXkgcmVzb3VyY2VzIGZyb20gZGVzdHJveWlu
Zy4NCkkgZGlzYWdyZWUgdG8gYWJvdmUgYXMgaXQgaXMgbm90IGFzIHBlciB0aGUgc3BlYyBndWlk
ZWxpbmVzLg0KSnVzdCBmb2xsb3cgIzEsICMyIGFuZCAjMyB0byBub3QgZGVzdHJveSB0aGUgZGlz
cGxheSByZXNvdXJjZSBkZXN0cm95aW5nLg0KTm8gbmVlZCBmb3IgYW55IGNoZWNrIGNvbW1hbmQg
ZXRjLg0KDQo+IEkgZG9uJ3QgbWVhbiBhbnl0aGluZyBlbHNlLCBJIGp1c3QgZmVlbCBsaWtlIHlv
dSBtYXkgbm90IGhhdmUgdW5kZXJzdG9vZCB0aGUNCj4gaXNzdWVzIEkgZW5jb3VudGVyZWQgZHVy
aW5nIHRoZSBTMyBwcm9jZXNzIGFuZCB0aGUgaW1wbGVtZW50YXRpb24gbG9naWMgb2YNCj4gbXkg
cGF0Y2ggZnJvbSB0aGUgYmVnaW5uaW5nLg0KPiBJbiBjdXJyZW50IGtlcm5lbCBhbmQgcWVtdSBj
b2Rlcywgd2hlbiB3ZSBkbyBTMyhzdXNwZW5kIGFuZCByZXN1bWUpIGZvcg0KPiBndWVzdCwgZHVy
aW5nIHRoZSByZXN1bWluZywgcWVtdSBhbmQgZ3Vlc3QgZHJpdmVyIHdpbGwgcmVzZXQgdGhlIHZp
cnRpby0NCj4gZ3B1KGJlY2F1c2UgIzIgaXMgbm90IGRvbmUpLCBidXQgb25jZSB0aGUgcmVzZXR0
aW5nIGhhcHBlbnMsIHRoZSBkaXNwbGF5DQo+IHJlc291cmNlcyB3aWxsIGJlIGRlc3Ryb3llZCBh
bmQgd2UgY2FuJ3QgcmVzdG9yZSwgc28gd2UgbXVzdCBhZGQgYSBtZXRob2QgdG8NCj4gcHJldmVu
dCBkZXN0cm95aW5nIHJlc291cmNlcyBhdCB0aGF0IHNpdHVhdGlvbi4gV2hhdCBteSBwYXRjaCBk
byBpcyB0byBhZGQgYQ0KPiBuZXcgdmlydGlvLWdwdSBjb21tYW5kIHRvIG5vdGlmeSBxZW11IHRv
IGNoZWNrIGlmIHRoZSBkaXNwbGF5IHJlc291cmNlcw0KPiBzaG91bGQgYmUgZGVzdHJveWVkIGR1
cmluZyByZXNldHRpbmcuDQo+IA0KPiA+DQo+ID4gSW4gb3RoZXIgd29yZHMsIGlmIG9uZSB3YW50
cyB0byB1c2UgZGV2aWNlIGNvbnRleHQgcmVzdG9yZSBvbiBQTSBzdGF0ZQ0KPiB0cmFuc2l0aW9u
IGl0IHNob3VsZCBkbyAjMSwgIzIgYW5kICMzLg0KPiA+IChhbmQgYXZvaWQgaW52ZW50aW5nIG5l
dyBpbmZyYXN0cnVjdHVyZSBiZWNhdXNlIFBDSSBQTSBoYXMgbmVjZXNzYXJ5DQo+IHRoaW5ncyku
DQo+IA0KPiANCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBKaXFpYW4gQ2hlbi4NCg==

