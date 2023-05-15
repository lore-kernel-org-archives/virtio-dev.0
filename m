Return-Path: <virtio-dev-return-12692-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A602FC77B75
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:59:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F0FA4120D4B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:59:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7AE99866D7
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:59:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DDD6A9865D6; Mon, 15 May 2023 15:59:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CBC3D986509;
	Mon, 15 May 2023 15:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCXia86F5vhhS9gScedAWxGAwwtdwyq/o/Z1xrS1+Bg2Tpyg8HM+6xXeyScTIzE/jVcoLCALMS7dpNhtjTsNg+bVXUpEETM+eFNa4YnMl+OvZ579Ybvb2qoUXUCkZx6E7m5bBO83ZlD/k54KruDWcGPMgTJauc8GSDzD2WUA9ogommifD9ui5rK51OTazuExlgYUkMvQogrcdiKxIRlzMeNAldkUR0xnyuBB9sdyylag3ul3lxhikaB6+Vvmuy/3u46K5LT/uiKVR894CCZFswXpZB6/fdXocjUv30iDLHryiscxFvPQMJt8kNhJQ8zbxTqZOi00plFqfwt9GMvq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LISDmPYLSAYwYs5mjswwYbk8TqS4zN/ZI1W3mg+fgtg=;
 b=ENUsgtixbk+TZRMkL9bCfCdvJTwCkR/Y+GjxqCWzYjrTHQIZr6jxu95oxkLv6BeSpbVaflTpJzDQO6fkUg417Z9tiEMHOQH4bRpIuGLC53EAm5grXZ/IAYkJ24xbLwnpGypzP9hE1mx1uBf404yD24D8BZpJCYxrSnw27uDe3BRxjXUSZDlxwlklRhxGeGow/IbJuNDPnKndm1JOm11D8pfe8Rxe7pZAOBtxNsmY7ANIMFGzJuCalzvtXozA9z2Fk6817jrgnEDIvGkRTTTusCt8pZ9EczBTHUUtWqpp/3o9ztWcpB57VGCiZy+p8X3Dy3sEw9VIKE/4EWRZUKoNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgACLkzA=
Date: Mon, 15 May 2023 15:59:41 +0000
Message-ID:
 <PH0PR12MB548136C3582B9DE232AEFDE5DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
In-Reply-To: <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7439:EE_
x-ms-office365-filtering-correlation-id: fa62e453-e45a-41d7-db50-08db555d64fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /3qUCdpGXZxG0COhB5npmWOXLq5qN86uQSXHmpvNR3X8M4TvKF9XBrcUMRzUVs+siKaHKjuoKaYyafQJxPbz0ISRk3LnCBNIF7B32z+cAX6qMPRKM2ewSk0U8ef/hMN4CAKuyaThFu7UMnNh9LucDDNM/fj4vo99cAZf1fPGKFquHaWi/uSk29BnY67e4PWPCdQloZ0H0EDV3LqrysFU9stR8EgomdJ/r//Qv64FuIASMXZztMw6dIPMqmHWCWzUffkOQq/HX7j1tG0Auvm21a+3oySvNjn+q7AnbOjkARpHvoVz0v4gTXiI9dOS8qSFfb2b3bSawifyNr80Ei2X+/ChpixZO72qNrmcvTroEy85fzgCLFYGckzJNX6zR3qu/BYt5ASBaVeDhaJVTIvBm9QEdAFqx/ZdLAmExdBR573apZIvkmjgOLdI+OB6fl9UtR6uY3afGx5VG5hXf2YcOW/0ILt8coWGHhwAFAouPFVkQJoG3t52H8IeYRnwgBCxqkkZv4BWu6r8Zt5Y0scWvbYH/SpN23t4r6WfdS0xjLvrFjOnAJAekO6qdILECZAGl0Qes6Q/olAaRz2N0vUFi/qWQTvsVmoRE88c8pYLnUAJJRew+KB/HdvEvYFcN0Qh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(83380400001)(66476007)(66556008)(64756008)(66446008)(9686003)(66946007)(76116006)(55016003)(7696005)(6506007)(107886003)(478600001)(54906003)(110136005)(71200400001)(186003)(52536014)(86362001)(8676002)(8936002)(5660300002)(2906002)(33656002)(41300700001)(38070700005)(4326008)(316002)(38100700002)(122000001)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emxoeEZMd2xMS0lLNE1uU09hcEUrakFRTE9WSlZHeHdsNmY5VlROK2lIMy83?=
 =?utf-8?B?Qmhmamc3d25ybEtpWjdnWkd6ZWFxWkVsM1B4ZW5odEVmKzVKMWtYWDQyV1ZQ?=
 =?utf-8?B?NDNmS2ZEcmlpZ2RlUDFibThsMWM3dkxpeEUyUUgrRHZjZytWb0xrdTZkKzNL?=
 =?utf-8?B?aDJ2aVhBZWFvVWZrZy95akhSVndPRkxVc1dmbW8vY0NEaFU1UVBlVzJHTUds?=
 =?utf-8?B?Zmc3LzA5amdWaXE3VzhtdTh2V3dtaFJTSmlnUy96TDZxVEgvZ0w3elhpajlv?=
 =?utf-8?B?cFNZbmJyYWkxQmtTMzh0UG1raVpudUx5SGhiWUFNRThrRUFQM2gwb1RLWE91?=
 =?utf-8?B?OG5jVCszWjZubTBiL1czTkQvY21XQVNjbmhzU1FqenlLQTVWSmROZmtQSnNv?=
 =?utf-8?B?UGQzUnRHYzV5M09RdkRtRFRRSkdDSk1iMEpsM3BSOTV4Uzg0MkJSRU1YK2pa?=
 =?utf-8?B?K3JmTFdUU25xQUlVRkdmR0ZsVFl2V1VkS0hUTk9OQmVuOWpsd3U4QnpDRnJU?=
 =?utf-8?B?V3JtVlRHd1Q5RE56SGd4NGxjVVZITHA0MWIrWnErc3RYYjZVMGwva0dnOElE?=
 =?utf-8?B?bHNkY0lDSXZiY3VWK1A5M1M2Y0VBSFRGbVhIVGdPYlFsNHZjMTg3c0pDN1pL?=
 =?utf-8?B?RXdmNmdUc2MwRjQzck94REc4WGs2SUlkNGx0YTROUjdNZ2syN21NQllxbXVS?=
 =?utf-8?B?Q2d5Y0ZPTXdKZUVNamxET0l4aTlMYnpwelh6NVVheG4ydU8wUW9jUm1UZmd4?=
 =?utf-8?B?c2t6SVJDSmU1T2w5UEFORHhXNVVUNlgxamJoZ29NWk41dlpTUzVabHByY2V4?=
 =?utf-8?B?cndkODBXVjVpSkthcmRMVDhoeklUbWpJMVFPWmFkS09HMmdOTVl4VEpYdjlo?=
 =?utf-8?B?NEZjMHR1TXpoZHFJQUhUZzJ3RE1oMUhuWjJTRmtSZVZIcHhsbzhySys2ZEJ5?=
 =?utf-8?B?UjdMYlQxZ21KNExqcVg3RXRtWGJNemZpUytseWtkaVkzWE5DRDBkQU8vMm1S?=
 =?utf-8?B?SGJXUlVNdjluRlpXS1UyQkFiTjNTSk53dlNuV3BKdk5qK01aQnJJUzRhbE5Q?=
 =?utf-8?B?bzZzQTBuZjVadStpQ1JtUXh6RzV3SFFVaFEzRm53RXBXK3VzNkRiOU9vVVBT?=
 =?utf-8?B?cDU2MmdSUk56MUVHTi9zbmU0eUFNQWNjWmcyenJnYWpWcUtab1RaZlN3b3JB?=
 =?utf-8?B?bXpQVGxjbklxTllUdG1sc1cyN0lkeDRRNVdoaHVLdm8xeHV2U2pkSWNBYnVE?=
 =?utf-8?B?S05tM214NXA5d05aUUl5ZVRPOXo5UlVvMVFrSWVDQzc5aVJOaEgzUW1oR3Bq?=
 =?utf-8?B?RUROeVhDYmE2WjhLN3MzY010Ky9oTUc4U05vd1gxek14dlBVMnk1VWVJWjBq?=
 =?utf-8?B?TWl6NnNZaCtkbGYvc0VKQmdONTJZU2ZwbjdNNWRtL2hkWFJhcGJ2ampXcWls?=
 =?utf-8?B?OXFSY2xpeTZBMFF1S3ptV0hlb3NOYkMzOUQxVGNiRitKNnZvQXBxall0MnRo?=
 =?utf-8?B?YzNxZkl5d3VRSmswc2lGWGtHWjBUcndQVkRIZ3VnYVg1K1FMdmxnYlMrcDZr?=
 =?utf-8?B?eU9YaTN1R2ZDUHZlSTFpT3RFRzZrd0I0TWRDUDA2UUdyejFIQVVNRk05aXl4?=
 =?utf-8?B?VWpKU2k5bGtUcUdvTnNXY0trTmxqWjUxQlY0WmErRUJkWWJEMml5c21Idy8w?=
 =?utf-8?B?SjNYSjVkODB0cVhqeEtkRCtEcE1hdXV1dmEzRTFqbHNMM2pRSUZMbDJJRld3?=
 =?utf-8?B?azArdnM2c2NSdmpsQmtYSGIxRE9CVmlzQW5VWFlrWUpIQjc1QWdmbVVQRHFz?=
 =?utf-8?B?YXJiRjVpM3BoOVBzME9oMWw1MVFkdk0zRHNTcE1ibEY2V1NNTktVdThIcUZW?=
 =?utf-8?B?WW42Yy9ua2JGU29tMVhBc2dJMGRrMlpaMW55SEJXYTlvQnU3OS9ZQytaWnlI?=
 =?utf-8?B?T1ZuQnM1UjRBbHVGZmhhRzFQV1FWaVY3UWRYM0s0MHBmTmtZQVBNbWU5OXRu?=
 =?utf-8?B?VU9qVWpwYWlyUy8yMGRCalcwTUtONE9BNjZ2cEJSL080Z3I1YWtqN2ZERVh5?=
 =?utf-8?B?RXhaRDNYcTFGM1FUWW4xU01hZnovK3RSVU9JZmtVNGhxNWtYcncyaEx5TmRC?=
 =?utf-8?B?bXowak8ySDJVNGVvbVFuVmxndW0zRFF4N29VcnJ0UzZ3RGRiU2l0RHRnYWd3?=
 =?utf-8?Q?UfZQJdM5w6bqvVw1pQi0B80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa62e453-e45a-41d7-db50-08db555d64fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:59:41.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfvB93cHXV0NBM5IoFmkdDcpcM9+34JC+gTpfSgpenMZ6BoDbjEkqWpf61gUIRSdxN7ic8tI2chMZ5Fs3RRV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgTWF5IDE1LCAyMDIzIDM6MzEgQU0NCg0KPiA+IFdoYXQgZG8gd2UgZ2FpbiBmcm9tIGJpc2Vj
dGluZyBpdD8NCj4gDQo+IA0KPiAxKSBObyBuZWVkIHRvIGRlYWwgd2l0aCB0aGUgb2Zmc2V0IGlu
IHRoZSBoYXJkd2FyZQ0KPiANCkluIGNvbnRleHQgb2YgbGVnYWN5IGlzIGRvZXNu4oCZdCBtYXR0
ZXIgbXVjaCBnaXZlbiB0aGF0IGl0cyBvdmVyIEFRLg0KDQo+IDIpIHRyYW5zcG9ydCBpbmRlcGVu
ZGVudA0KPiANCkFRIGNvbW1hbmRzIGFyZSB0cmFuc3BvcnQgaW5kZXBlbmRlbnQgc28sIGl0IGlz
IGNvdmVyZWQuDQoNCj4gMykgYXZvaWQgZHVwbGljYXRpb24gd2l0aCB0aGUgKGxlZ2FjeSBzdXBw
b3J0IG9mKSB0cmFuc3BvcnQgdmlydHF1ZXVlDQo+IA0KTW9kZXJuIGludGVyZmFjZSBkb2VzIG5v
dCBuZWVkIG1lZGlhdGlvbjsgaGVuY2UgaXQgaXMgbm90IGR1cGxpY2F0aW9uIHdpdGggbGVnYWN5
Lg0KDQo+IA0KPiA+IEV2ZXJ5IG5ldyBhZGRpdGlvbmFsIG5lZWRzIGludm9sdmVtZW50IG9mIHRo
ZSBoeXBlcnZpc29yIGFzIE1pY2hhZWwgbm90ZWQNCj4gYmVsb3cgb24gImVmZm9ydCIgcG9pbnQu
DQo+IA0KPiANCj4gSSdtIG5vdCBzdXJlIEkgZ2V0IHlvdXIgcG9pbnQuDQo+IA0KPiBJZiBhZGRp
dGlvbmFsIGVmZm9ydCBpcyBub3Qgd2FudGVkLCB3ZSBuZWVkIGEgZnVsbCBQQ0kgb3ZlciBhZG1p
bnEsDQo+IHRoYXQncyB3aGF0IEkgc3VnZ2VzdGVkLCB0aGVuIHdlIGRvbid0IG5lZWQgYW55IGV4
dGVuc2lvbiBmb3IgYW55IG5ldw0KPiBmZWF0dXJlcyBwcm9iYWJseS4NCj4gDQpXaGVuIHRoZXJl
IGlzIGFscmVhZHkgYSBQQ0kgVkYsIEkgZG9u4oCZdCBzZWUgd2h5IG9uZSB3b3VsZCBpbXBsZW1l
bnQgIlBDSSBvdmVyIGFkbWlucSIuDQpJdCBpcyBpbXByYWN0aWNhbC4NCkFuZCBTRi9TSU9WIGlz
IGJpdCBzdGlsbCBmYXIgaW4gZnV0dXJlLg0KDQpXaGVuICJQQ0kgb3ZlciBhZG1pbnEiIGhhcHBl
biwgaXQgaXMgcmVhbGx5IGEgdmVyeSBkaWZmZXJlbnQgc2V0IG9mIGNvbW1hbmRzIHRoYXQgZW11
bGF0ZWQgdGhlICJQQ0kgdmlydGlvIiBkZXZpY2UuDQpJIGRvbuKAmXQga25vdyB3aGVuL3doeS4N
Cg0KPiBJZiB3ZSBjaG9vc2UgdG8gaW52ZW50IGRlZGljYXRlZCBhZG1pbnEgY29tbWFuZHM6DQo+
IA0KPiBGb3IgbGVnYWN5LCB3ZSBkb24ndCBuZWVkIGFueSBuZXcgYWRkaXRpb25hbCBlZmZvcnQg
c2luY2UgdGhlIGFib3ZlIDExDQo+IG1hcHMgdG8gdGhlIGxlZ2FjeSB2aXJ0aW8tcGNpIGZhY2ls
aXRpZXMuDQo+IA0KT25seSBmZXcgY29tbWFuZHMgYXJlIG5lZWRlZC4NCk1vZGVybiBpbnRlcmZh
Y2UgY29uZmlnIGRvZXNu4oCZdCB0cmF2ZWwgdGhyb3VnaCBtZWRpYXRpb24uDQoNCj4gRm9yIG1v
ZGVybiwgaWYgdGhlIGZlYXR1cmUgaXMgc29tZXRoaW5nIHJlbGF0ZWQgdG8gdGhlIHRyYW5zcG9y
dCwgd2UNCj4gbmVlZCBuZXcgdHJhbnNwb3J0IGludGVyZmFjZSBmb3Igc3VyZS4NCj4gDQpFdmVy
eXRoaW5nIGlzIHRyYW5zcG9ydCBhcyBpdCBmbG93cyB0by9mcm9tIGRyaXZlciB0byBkZXZpY2Ug
Y292ZXJlZCBpbiB0aGUgcmVzcGVjdGl2ZSB0cmFuc3BvcnQgY2hhcHRlci4g8J+Yig0KDQo+IA0K
PiA+DQo+ID4gVGhlIHJlZ2lzdGVyIG9mZnNldCBhbmQgcmVhZC93cml0ZSBpcyBmYXIgc2ltcGxl
ciBpbnRlcmZhY2UgZm9yIGh5cGVydmlzb3IuDQo+IA0KPiANCj4gSWYgdGhpcyBpcyB0cnVlLCB3
aHkgbm90IGdvIGZ1bGwgUENJIG92ZXIgYWRtaW5xPyBIeXBlcnZpc29yIGluIHRoaXMNCj4gY2Fz
ZSBldmVuIGRvbid0IG5lZWQgdG8gZGVhbCB3aXRoIGNvbmZpZyBzcGFjZS4NCj4gDQpJIGRvbuKA
mXQgc2VlIGEgdXNlIGNhc2Ugbm93IGFuZCBpdHMgZXh0cmVtZWx5IGhlYXZ5IHRvIGRvIHNvIGFu
ZCBpdCBkb2VzbuKAmXQgYXBwbHkgdG8gUENJIFZGcyBhdCBhbGwuDQoNCj4gDQo+ID4NCj4gPiBO
b3QgdG8gZG8gY3Jvc3MgcmVnaXN0ZXIgYWNjZXNzIGlzIHdoYXQgd2UgbmVlZCB0byBkZWZpbmUg
aW4gdGhlIHNwZWMgZm9yIDEueCBvcg0KPiBmdXR1cmUgdGhpbmdzLg0KPiANCj4gDQo+IFlvdSBj
YW4ndCBhc3N1bWUgdGhlIGh5cGVydmlzb3IgYmVoYXZpb3JzLCBzbyB0aGUgZGV2aWNlIG9yIGF0
IGxlYXN0IHRoZQ0KPiBzcGVjIHNob3VsZCBiZSByZWFkeSBmb3IgdGhhdC4NCj4NCk15IGFib3Zl
IGNvbW1lbnQgaXMgZm9yIHRoZSBkcml2ZXIgdG8gZGV2aWNlIGludGVyZmFjZSB0byBhY2Nlc3Mg
cmVnaXN0ZXJzIG9uIGl0cyBuYXR1cmFsIGJvdW5kYXJ5Lg0KV2hpY2ggcGFydCBvZiB0aGUgcHJv
cG9zYWwgYXNzdW1lcyBhIGh5cGVydmlzb3IgYmVoYXZpb3I/DQpOb3RoaW5nIHRvIGRvIHdpdGgg
aHlwZXJ2aXNvci4NCg==

