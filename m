Return-Path: <virtio-dev-return-12725-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D7BC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4D4F460060
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4590F9866FE
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:29:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A016986549; Tue, 16 May 2023 19:29:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25B49986579;
	Tue, 16 May 2023 19:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl0QkVaZKa0QGYvKcFHiqX4gHA9/N+opFjLueIA/z0nhihEZO1eAs9IIl3vrgXQCuqZWJ9qlRJF9wtqJtV9aOlxBtPH7NflJAFor0MdTAst5pY2NeLxnvJngmb65YFm9urnyAMR4zAiDwXNYyPjqHf5/9NBLobMnUtRcdek0hJGmWUfgqaIunzOvaypgURsYlBIhqQ/u7pqb4wyaNbHDonEJFH+lpHfgidbfIcKdcv7XBSy7+EhNaYIA0fBxwjygc33d3t758ee9VsnWZjbw6tLrAklkdgFPcd9/wE5UvZW1UaYJtJhoDIGlJrjJLPX/1WKahnjoi6lcmNKw0jWIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRR1hvcvwPYAUFcDbtW6n8f7aZYdzvJqEOC52QFysPE=;
 b=b725jXxJw0SCMB3w7X0LiMxzFNpydOK0HlZaOus9qL7qB5zw1G1QLoYVcOGJhGsyhTFZj8AyfHvOxkib5CD4u8DoMfaU6Ox2bF32QtPTIGlutIWRzyEWuoMMngKMhZlSZEMIpuh0BIfAm99FG+4lYZGNZmL6cR8TbTL1vf/SkZH0w2GTW1UO+tBWiv0gzID1DDsABAdEqPIzjD9PlG4OCjgjqciBk65rRUgY0dhkIzvdPPbw9vjxVyWUtogsRJ3Ex7TjjAwg54WUqrcJbnUIL57v75Q8AsMuLQFDJbYqks3tTHQX1IKU3jik0MLRUX9bRCKskZoCkrwYPXE5eyclEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAXjRYCAAIxikIAAx7kAgAAAexCAAArFAIAA/IBw
Date: Tue, 16 May 2023 19:29:44 +0000
Message-ID:
 <PH0PR12MB5481205FAA079FAB1F0E22C2DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
 <PH0PR12MB5481F2BE9C7CB89282E4053DDC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHqD4UUB8PSpSmwYRhvthGzPJ7Up-9xQ+RO8a1N01-rw@mail.gmail.com>
In-Reply-To:
 <CACGkMEsHqD4UUB8PSpSmwYRhvthGzPJ7Up-9xQ+RO8a1N01-rw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB7917:EE_
x-ms-office365-filtering-correlation-id: a03ff7dd-eca3-4dcd-6ece-08db5643e733
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JHgLfj0gbutzDU/Upb2F/K4wc7OZzIPBj3sOo4hrNliFzNQ/ELExVdTHVsQc/iJCjQEiL8nlVCECfcgp08l2s8ZgBG8yr/QJkr7bGUz4a3LoxER6uW02fIhyVExhi1/wzjhAWpARBEnTwRzDrilhMshe+jOug4VtICMQ/mcP+UD+rfjQ990BdW3l+zt2UM0/4qrhXr5cqN7xkizKszgB4yCt14wPRpujZKns/wirSy5/xFSp3oXmiqxoZpR64AkXBomBMRS1eQSjJY9hIHVju9PuhiinXfsIVp+5OE6XckvvP/64PBkHeBFNBhNzHEzgrFcIr/NWWN30lmKKhQ1JF58blsvA2Kvy+dj2jdQyoMtY5BRsxmn7dTRW702GlbKU5KNJJakRyD2INfa8JIY8FSz8F++AcEuqGzhTljZc4gih546euTvoEL0zGkiznvpuzeR83b7Ehs/WErNZdsyEdqFSIHmOtlPJJsZHvZtW+f6QbQMAk7eA7CRAWL+BaUGVcednetGtpBwABPIjE7ibXyht+zIw3O6mBMfI7BlmajTvVLTUXuCYHuAp7rgQbRtwEVOGowNeBBOYmbRxD15/RALzrt6rsRFiYL+a588hbGKqZ297jaB0SnALqFq8Pny7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(186003)(86362001)(33656002)(2906002)(55016003)(107886003)(9686003)(6506007)(26005)(71200400001)(83380400001)(7696005)(66899021)(8676002)(8936002)(478600001)(54906003)(38070700005)(122000001)(5660300002)(52536014)(316002)(76116006)(4326008)(64756008)(41300700001)(6916009)(66946007)(66476007)(66446008)(38100700002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFVNMWw1SWtVUG5ZNjlocEJCY3E1NU5kdHpaUWxCbkNYakZMNE9XbTBOTGx5?=
 =?utf-8?B?Mzh5MndWS2JyeCtoTWhsYzhBdlRGc1NLUG9vZHgvdmk3b1F1dzZoTFMwSXpu?=
 =?utf-8?B?QitEaHJveDdHTjBoYW90VU9sTHlZMG1zK251SlJnS0M4UEUzVzRMRVhLQmsx?=
 =?utf-8?B?Z003TXVUeEMvYWExSkhmL3RWbzlzVXd4RWlmdGIrc1FmY0JWTURpRkFkNmpo?=
 =?utf-8?B?NlkvaEtOb1hQNUdrZi9FeVB4WHZIeDZ3WlhtMTJJS2U5RFlydE9FZnZYWGtQ?=
 =?utf-8?B?U3BiWkxEYkFBWDRidFBiQlhNajVhVHAwcU5IOE1KWWIyRXU3MnEvSjZ0YXdh?=
 =?utf-8?B?RUg1QnFwM1dDUWk0SFB0UHE1R01zWTVrdWtiZkFWUkMvRkdMS0lRaXMwWjZK?=
 =?utf-8?B?cVJ4TUFTVXFPdnRCdkZOdzkyMDZKUGd6TU9vZGdmTGp6VXdYMkl6V0dld3E1?=
 =?utf-8?B?MjdoL1dDdjdTemF5YVFDYVRTeStTTnhVVzdQZkFXUWZHaVBWai81c1lWU2hL?=
 =?utf-8?B?VVd1Y2NvU1JWRW1kOTEyMzRqaFhNbHVzRTNOVjJKVnV1VDE3akN4aG1Pandz?=
 =?utf-8?B?WWFQWXM5VlpMdWlPUlF4QXZMOGdhQmY2QXJxM3A2RFFIMFBjR1EySlFDRUJF?=
 =?utf-8?B?b3EzYnJUaG1XTVdBQk5RWisrS3BOQ0NyeTdBeWFxL1ZEY3V5K2lEKzVSc2cx?=
 =?utf-8?B?Rnk4UE4vSW9UY0t0Wi9GRTJoR1dUejNUck9yclNNN1ZXVUNoVitUeHNJam9v?=
 =?utf-8?B?ZDZqY2ZSSGVzOHBkbStuTnlLYXNzT1AyRXVPMVJ5YlErNWJmTVRIWC9LQWVU?=
 =?utf-8?B?bzRxOW5FYld0MnFORzB6TVd2ZFo0Mkt2T3BMaGt0b3VySnNCNWo0ZndLSXVY?=
 =?utf-8?B?eGg0Qll1UVJIZCtydE1xY0FUSHl2QkFGUVVtM2NwVTJhUGVkYlFQTEh2dGFx?=
 =?utf-8?B?cjBXWXlsSXRLc284dml6SitJZnRzeU5BMHlRNm9RVURWYW9EekIvYk1CdWI3?=
 =?utf-8?B?cGNjdTRGcVNOM2JIMGhsakljOTRGWlpTWjRXSy91UmNTY3phMElPZ0FxckZn?=
 =?utf-8?B?ZGZ0cDNYWEplVUowZVBSbFo1dXJPbGV5dDdJTFNVcGx6bkZrZ09KMVNzWERQ?=
 =?utf-8?B?eFNLNzRNWW16SEpTUXNmNHR2bFpaNzNVczU5a0g1U2l6SDRUQ3d5amlyN2ZD?=
 =?utf-8?B?VjQ5dTF6SEI0V2JOMnhlQUIrY3ltS1FGeUs1bWp6T1hZZmdHdTZPOHpCU2ZN?=
 =?utf-8?B?Z1liUllqaXFqL01KYUUwT1RPY241Wmo1U24yMEVQVEtPS1R5UjdBQjhDZ1Rl?=
 =?utf-8?B?eHErQkRjLzBuMEJ1bkNDMG9YVVc2MzlxaURBbFVNZjAzNXRoVjNJVjJJVVV0?=
 =?utf-8?B?VHJGcGtxU3JkMm15L0ZUOWJqdXVKd3psK0pVMUJ4VEVYTG56SEs3cmhvTkVP?=
 =?utf-8?B?Vkx2cWpjTjFPbUJrWEdkRXlHMmoreVcyanNXQWVqbU9IU2NHMVl4c09kakFv?=
 =?utf-8?B?RU9wc0Fwd3k5Y28ySkkxOS9GaDFJd1hLdHVwNmlBTmloYkRjYUtHS25pNEpJ?=
 =?utf-8?B?WitSMWlVdzJ5WG9OdEZXczJESnJSSk5ISXRJbFpnTjBQNCtpTE9QaSs2N3JS?=
 =?utf-8?B?eWVCQkttMnZJbk1ORlhVbkswTERwS0xlY1hMUTU2akMyNXhrMDRpYkNBWTFT?=
 =?utf-8?B?TVUzMmVhQloraFNSY1QzNWFJWGZNSlNGbGQ0Zit1RjI0RDg0OER3clM1UGxm?=
 =?utf-8?B?QnMyREkyM1JEMVNqUmpqaEFyZ04zQ3dZT1JkUW56OWlmcEtjSUdCVGtabFFG?=
 =?utf-8?B?L01WNit2UnVVZDdqYTJHTmdFY05vTXFNeHBxNjFlOUwyRGRWMWI3dzl4VktU?=
 =?utf-8?B?STBteTB6dUZiSGlzbzN2ZTh6WGhvQ1k5UEVkTFVwNWFSWXAzUTQ3cURqcWlD?=
 =?utf-8?B?WHJWR3phL3hRTnQ3cGxvQm9rQlhNUE9iV3VmOE1zM2EyUHk5QWpLaEFXTXNm?=
 =?utf-8?B?a09iYmZGc0xDV0RIRmEvTjhlTTNzOFVxOTlhRFF4Qlh6M0lPclVjWmhYWG5p?=
 =?utf-8?B?RjNObk94Q0w4NzRnWGQvdm5ZbEJaYjZOdUZHSmRSOGNXbmt1ZG41bnQ1VWRq?=
 =?utf-8?Q?vu+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03ff7dd-eca3-4dcd-6ece-08db5643e733
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 19:29:44.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0+9jLXcUcj/PRKehajnJaSFtdfXh6xlaJW/k51tnmpcM70ZfmLP2O7sY7bPq/D26r3uQfeaDt/OuNbP3PGC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIE1heSAxNiwgMjAyMyAxMjowOCBBTQ0KDQo+ID4gRm9yIGd1ZXN0IGFuZCBieSBndWVzdCBh
cmUgdHdvIGRpZmZlcmVudCB0aGluZ3MuDQo+ID4gSSBhbSBwcm9wb3NpbmcgdGhhdCBhIGNmZ3Ev
Y21kcSBzaG91bGQgYmUgdXNlZCBkaXJlY3RseSBieSB0aGUgZ3Vlc3QgZHJpdmVyIGFzDQo+IGJh
c2UgbGluZSBsaWtlIGFueSBvdGhlciBWUS4NCj4gDQo+IEknbSBmaW5lIHdpdGggdGhpcywgYnV0
IGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIGJ1dCBJIGRvbid0IHNlZSBhbnkgcHJvcG9zYWwg
bGlrZQ0KPiB0aGlzIHRoYXQgaXMgcG9zdGVkIHRvIHRoZSBsaXN0Pw0KPiANCkJlY2F1c2UgaXQg
aXMgb3J0aG9nb25hbCB0byB0aGUgd29yayBoZXJlLCBpdCdzIGhhcmQgdG8gbWFrZSBwcm9ncmVz
cyBieSBtaXhpbmcgZXZlcnl0aGluZy4NCg0KPiA+IEFuZCBpZiB0aGVyZSBpcyBhIG5lZWQgZm9y
IG1lZGlhdGlvbiwgaXQgc2hvdWxkIGJlIHBvc3NpYmxlLg0KPiA+DQo+ID4gPiBJIHRoaW5rIHdl
J3ZlIGRpc2N1c3NlZCBtYW55IHRpbWVzIHRoYXQgbGVnYWN5IGlzIHRyaWNreSBmb3IgaGFyZHdh
cmUuDQo+ID4gQW5kIHdlIHdhbnQgdG8gcHJvY2VlZCBmb3IgdGhlIGRlc2NyaWJlZCB1c2UgY2Fz
ZSBhbmQgcmVxdWlyZW1lbnRzLg0KPiA+DQo+ID4gPiBBbmQgeW91ciBwcm9wb3NhbCBwcm92ZXMg
dGhpcyBmdXJ0aGVyIGJ5IGludHJvZHVjaW5nIG1vZGVybiBhbGlrZQ0KPiA+ID4gbm90aWZpY2F0
aW9uIGFyZWFzLg0KPiA+IE5vdCByZWFsbHkuIEEgbW9kZXJuIGRldmljZSBpcyBvZmZlcmluZyB0
aGUgbm90aWZpY2F0aW9uIGFyZWEgbGlrZSBsZWdhY3kgdG8gdGhlDQo+IGxlZ2FjeSBpbnRlcmZh
Y2UuDQo+ID4gU28gdGhpcyBpcyBqdXN0IGZpbmUuDQo+IA0KPiBJIGRvbid0IHNheSBpdCdzIG5v
dCBmaW5lLCBpdCdzIHByZXR0eSBmaW5lIGFuZCB0cmFuc3BvcnQgdmlydHF1ZXVlIGhhdmUgc2lt
aWxhcg0KPiBjb21tYW5kcy4gQW5kIHRoaXMgYWxzbyBhbnN3ZXIgdGhlIHF1ZXN0aW9uIHRoYXQg
eW91IHRoaW5rIHR1bm5lbCBQQ0kgb3Zlcg0KPiBhZG1pbnEgaXMgbm90IHNjYWxhYmxlLiBXZSBj
YW4ga2VlcCB0aGlzIGNvbW1hbmQgaW4gdGhhdCBjYXNlIGFzIHdlbGwsIG9yDQo+IGludmVudCBu
ZXcgY2FwYWJpbGl0aWVzLg0KPiANCk9rLiBzbyB2aXJ0aW9fYWRtaW5fcV9jbWRfbHFfbm90aWZ5
X3Jlc3VsdCBpcyBmaW5lLg0KDQo+ID4NCj4gPiA+IFdlIHByb2JhYmx5IG5lZWQgdG8gZGVhbCB3
aXRoIG90aGVycyBsaWtlIGVuZGlhbmVzcy4NCj4gPiA+DQo+ID4gTm8gcG9pbnQgaW4gZGlzY3Vz
c2luZyB0aGlzIGFnYWluLiBPbmUgc2l6ZSBkb2VzIG5vdCBmaXQgYWxsLg0KPiA+IEl0IHNvbHZl
cyBsYXJnZSBwYXJ0IG9mIHRoZSB1c2UgY2FzZXMgc28gaXQgaXMgdmFsdWFibGUgYW5kIHdpbGwg
YmUgc3VwcG9ydGVkLg0KPiANCj4gVGhpcyBpcyBkb2FibGUsIHdlIG5lZWQgdG8gbGVhdmUgc29t
ZSBzcGFjZSBmb3IgZnV0dXJlIGRldmVsb3BtZW50LiBPciBpcyBpdA0KPiBqdXN0IGNvbXBsaWNh
dGVkIHRvIGhhdmUgYW4gZW5kaWFuIGNvbW1hbmQ/DQo+IA0KUG9zc2libHkgb25lIGNhbiBzZXQu
IEkgZG9u4oCZdCBrbm93IGlmIGFueSBhY3R1YWwgZGV2aWNlIHJlYWxseSBzdXBwb3J0ZWQgZW5k
aWFubmVzcy4NCk5vIHVzZXJzIGhhdmUgYXNrZWQgZm9yIGl0LCBldmVuIGFza2luZyBleHBsaWNp
dGx5IHRvIHRob3NlIG5vbl9saXR0bGVfZW5kaWFuIHVzZXJzLg0KU28gbWF5IGJlIHdoZW4gdGhl
cmUgaXMvaWYgYSByZWFsIHVzZXIsIGl0IGNhbiBiZSBkb25lIGluIGZ1dHVyZS4NCg0KPiA+DQo+
ID4gPiBGb3IgYW55IGNhc2UsIGhhdmluZyBhIHNpbXBsZSBhbmQgZGV0ZXJtaW5pc3RpYyBkZXZp
Y2UgZGVzaWduIGlzDQo+ID4gPiBhbHdheXMgYmV0dGVyIGFzc3VtaW5nIHdlJ3ZlIGFncmVlZCB0
aGF0IG1lZGlhdGlvbiBpcyBhIG11c3QgZm9yDQo+ID4gPiBsZWdhY3kgZHJpdmVycy4gVXNpbmcg
ZGVkaWNhdGVkIGNvbW1hbmRzIGNhbiBtYWtlIHN1cmUgdGhlDQo+ID4gPiBpbXBsZW1lbnRhdGlv
biB3b24ndCBuZWVkIHRvIGdvIHdpdGggY29ybmVyIGNhc2VzIG9mIGxlZ2FjeS4NCj4gPiA+DQo+
ID4gQ29ybmVyIGNhc2UgaGFuZGxpbmcganVzdCBtb3ZlZCBmcm9tIHRoZSBkZXZpY2UgdG8gaHlw
ZXJ2aXNvci4NCj4gDQo+IFRoYXQncyBub3Qgc2FmZSwgdGhlIGRldmljZSBzaG91bGQgYmUgcmVh
ZHkgZm9yIG1hbGljaW91cyBpbnB1dHMuDQo+IA0KV2l0aCBjdXJyZW50IG9mZnNldCwgcmVnaXN0
ZXIsIGRldmljZSB3aWxsIGJlIGp1c3QgZmluZSBhcyBtb3N0IGltcGxlbWVudGF0aW9ucyBoYXZl
IHRvIHByb2dyYW0gY29udHJvbCBwYXRoIGV0YyBvbiB0aGVzZSByZWdpc3RlcnMgd3JpdGUvcmVh
ZCBldGMuDQpTbywgZGV2aWNlIHdpbGwgYmUgYWJsZSB0byBoYW5kbGUgdGhlbSB3aXRoIHBsYWlu
IDIgY29tbWFuZHMuDQoNCj4gPiBGb3IgU0lPViB0aGVyZSBpcyBubyBiYWNrd2FyZCBjb21wYXRp
YmlsaXR5IHJlcXVpcmVtZW50Lg0KPiANCj4gSXQgaGFzIHNldmVyYWwgd2F5cyB0byBzdXBwb3J0
IGN1cnJlbnQgdmlydGlvLXBjaSBkcml2ZXJzIGluIHRoZSBndWVzdCwgYW5kIHN1Y2gNCj4gY29t
cGF0aWJpbGl0eSBpcyBhbG1vc3QgYSBtdXN0IGZvciB0aGUgcHVibGljIGNsb3VkLg0KPiBXZSBj
YW4ndCBlbmZvcmNlIHRoZSB1c2VyIHRvIHJlaW5zdGFsbC9yZWNvbXBpbGUgdGhlaXIga2VybmVs
cy9hcHBsaWNhdGlvbiBpbg0KPiBvcmRlciB0byB3b3JrIGZvciBTSU9WLg0KU3VyZSwgYW4gU0lP
ViBkZXZpY2UgZW11bGF0aW5nIFBDSSBkZXZpY2UgZm9yIGd1ZXN0IGlzIG9uZSByZXF1aXJlbWVu
dC4NCg0KQW5kIFNJT1YgZGV2aWNlIHdvcmtpbmcgbmF0aXZlbHkgc3Bhd25lZCBmcm9tIHRoZSBw
YXJlbnQgUEYgYW5kIHVzZWQgd2l0aG91dCBndWVzdCBpcyBhbm90aGVyIHJlcXVpcmVtZW50Lg0K
DQpBbmQgc2Vjb25kIGNhbiBiZSBkb25lIGJpdCBlbGVnYW50bHkgaW4gc2VsZi1jb250YWluZWQg
d2F5IHdpdGhvdXQgZGVwZW5kaW5nIG9uIHRoZSBwYXJlbnQgUEYuDQpBbmQgcmVxdWlyZXMgbW9y
ZSB3b3JrIHVucmVsYXRlZCB0byB0aGlzIG9uZS4NCg0KPiBJIHRoaW5rIHdlIGFyZSBkaXNjdXNz
aW5nIHdoYXQgaXQgY2FuIGJlLCBzbyBzZWUgdGhlIGFib3ZlIHJlcGx5IGZvciB0aGUNCj4gbm90
aWZpY2F0aW9uIGFyZWFzLCB3ZSBjYW4gc3RpY2sgdmlydGlvX2FkbWluX2NtZF9scV9ub3RpZnlf
cXVlcnlfcmVzdWx0DQo+IGNvbW1hbmQgZm9yIFBDSSBvdmVyIGFkbWlucSwgb3IgaW52ZW50IG5l
dyBjYXBhYmlsaXRpZXMgdG8gbWFrZSBpdCBmdWxseSBzZWxmDQo+IGNvbnRhaW5lZC4NCj4gDQpB
cyB3ZSBib3RoIHVuZGVyc3RhbmQgd2VsbCB0aGF0IGEgcXVldWUgaXMgbm90IGdvaW5nIHRvIHRy
YW5zcG9ydCBhIGRvb3JiZWxsIGFuZCBhY3R1YWwgSU1TIGludGVycnVwdHMsIHdlIHdpbGwgbW9z
dGx5IGhhdmUgY29tbWFuZHMgdG8gc2VydmljZSBzb21lIG5lZWRzIGZvciBiYWNrd2FyZCBjb21w
YXQuDQpJdCBpcyBhIHNlcGFyYXRlIHdvcmsgd2hlbiB0aGVyZSBhcmUgbm8gUENJIFZGIGRldmlj
ZXMuDQoNCj4gPg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gWW91IG9ubHkgd2FudCB0byBleGNo
YW5nZSBjdXJyZW50bHkgZGVmaW5lZCBjb25maWcgcmVnaXN0ZXJzLA0KPiA+ID4gPiBpbnRlcnJ1
cHRzIGFuZA0KPiA+ID4gbm90aWZpY2F0aW9uIGNvbmZpZ3VyYXRpb24gdXNpbmcgQVEuDQo+ID4g
PiA+DQo+ID4gPiA+IFRyYW5zcG9ydCBWUSBpcyBOT1QgdHJhbnNwb3J0aW5nIGFjdHVhbCBkYXRh
LCBpdCBpcyBub3QNCj4gPiA+ID4gdHJhbnNwb3J0aW5nDQo+ID4gPiBub3RpZmljYXRpb25zIGV0
Yy4NCj4gPiA+ID4gSXQgaXMganVzdCBhIGNvbmZpZyBjaGFubmVsLg0KPiA+ID4gPiBIZW5jZSwg
dGhleSBhcmUganVzdCBjb21tYW5kcyBub3QgYSAiZnVsbCB0cmFuc3BvcnQiLg0KPiA+ID4NCj4g
PiA+DQo+ID4gPiBGb3IgYW55IGNhc2UsIGEgdmlydHF1ZXVlIGNvdWxkIG5vdCBiZSBhIGZ1bGwg
dHJhbnNwb3J0LiBJdCBuZWVkcw0KPiA+ID4gYnVzIGZhY2lsaXRpZXMgdG8gZG8gYm9vdHN0cmFw
L0RNQS9ub3RpZmljYXRpb25zIGF0IGxlYXN0LiBUaGUgaWRlYQ0KPiA+ID4gaXMgdG8gc2F2ZSBm
b3IgdHJhbnNwb3J0IHNwZWNpZmljIHJlc291cmNlcyBhbmQgdXNlIGEgbW9yZSBzY2FsYWJsZQ0K
PiA+ID4gd2F5IHRvIGNvbmZpZyBkZXZpY2VzLg0KPiA+ID4NCj4gPiBIZW5jZSBpdCBuZWVkcyBv
bmx5IG5lZWRzIGEgY2ZncSwgbm90IHRoZSBmdWxsIHRyYW5zcG9ydC4gOikNCj4gPg0KPiANCj4g
V2VsbCwgbm90IGEgbmF0aXZlIHNwZWFrZXIgYnV0IEknbSBmaW5lIGlmIHlvdSB3YW50IHRvIGNh
bGwgaXQgY29uZmlncS4NCk1pY2hhZWwgY2FsbGVkIGl0IGFkbWluIHZxLCBzbyB3aWxsIHN0aWNr
IHRvIGl0IGZvciBub3cuIDopDQo=

