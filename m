Return-Path: <virtio-dev-return-13690-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2171BCA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:11:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 83EC8759D8
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:11:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 770BF986610
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:11:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6AD0C983E27; Tue, 12 Sep 2023 06:11:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57D5F986485;
	Tue, 12 Sep 2023 06:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ4nlngWxhQg1rHYn25Cmt07gZq7VWqXsiZ8qA1MuWQAPRBqBGezx/wOpR4JB9RcMEQ54jOCOX6c+F+0GQgF23nf/yn76geCfygRoQJqrLD9HQaD7F8L/2FkR8/xjhtcy0AqyJOihgyOM+88l/Bfkymg9yDQZdmaZKfWcDhOhnhjV6NwTNIZvA3Mt4a553sqp0ssy7YH03Ui/W3Bz3S2p3TcD+NxndF5AnI7wCZAwXPClduNLzGUOpwdk/SGQqyA4HHlK6GItAGbcOC5qDDRFsH7eaC+0CvN1VGdEY6wnteR8OhDgayEDFUCYGXmn3jlwBViAHK4lijY0rQeIi9ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1woMCeVQUGpNhTm6dS5+oSTWWlNhmPI7/wUGS+R52k=;
 b=ajDlSuib92MfVgulTRceP+EAsN+9xvNw6VkN1cR4s0yePd7zfR0p9ZnDi714856yN5PzZHt+QdlkvjDguCvVQfLCF8WcXz9Oj+bJ2JfExCJjMMrg2LfMa2ifRWD3hqoGhs5yOahSb8CG43sAeF3VaXHRfcRIKyuDjNypgfBAORUtQgdiHZcortDOx3RKH2IWe1bYpRYH07R00P8rCpTAVufFW8ErgYW6USHfYuP1O6eSU8kXrSr+pxfINnu7hAN2fFw7BgxUpWpsJfeQ/0DSpf59RALpo+Wf0VrLkTsG5aRjBt7MKK9Um7efgkpsdOs62YjEPSlhWxqDHbTG+UKagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cA==
Date: Tue, 12 Sep 2023 06:11:06 +0000
Message-ID:
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
In-Reply-To:
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4280:EE_
x-ms-office365-filtering-correlation-id: 6c380401-9585-44c4-84fe-08dbb3570ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b9Quibtb9OvPetGMCZvVknyWAahUNntRx+BU0IiGX1fnVXx4VpFsdPDid/qVqsjRKybOPviFeB6XOAA+Ci0y2DFZaqCoRAV+H3n+JKVp/lCm+7OaXBzQhuOhYmd95DRztgnH0TigZ1NroJ76bheFiNdEmn0Q1263AY+eGGOdQQCKaDloR2pSp5OS4ZzwPnpobXdvs8a8JxrqN6q1J2nfcUB7PxhMhMaLv4Wi0IuSfK0JL4V+VNzb5sy+dz+zbhi3+3wvdP7gKJ+U0seoGREQYLazTVmJTlg0i6iSdu1Xm3iGWgnES+KIyNJAnMKwcAJqBcSvFv0uj91eJUNK+xYI6H3GYMK5kwkMB13FAy93wVz5o10Krh+3+U0cT/zj7TxS06TJdCqAgZAQJNc/CElWQ2FFLlUrfbMSnu2F9UrFQJxGr8W4drrnyPNUlJsKL284Frg7x+jZm1Kw3WnoHj0NAUNES3UYb34Y5RH6Cavwg1zNYlcZ/EWtjBkzJ44FAXdGI8K4OFcFKgUjgN55sYqM8oYQm+mSnkqv8WtLnYlbgLfb3xNo3J2738EyfOXKLVgvhIoHm3k5+CQQIu+aISM/iJUIP1lfwTEq92CQRU2FzNZ1ilKLPmgjVhC0VlfVOHzcaro4ntSQG6b//4YfVUdPZ88hV1fIUDxf6HlCi/pvmMk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(55016003)(9686003)(71200400001)(122000001)(53546011)(7696005)(6506007)(26005)(41300700001)(66446008)(54906003)(64756008)(66946007)(6916009)(316002)(5660300002)(8676002)(4326008)(52536014)(66556008)(38100700002)(76116006)(38070700005)(478600001)(966005)(66476007)(8936002)(83380400001)(33656002)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUM4dFZlaCs1dWNDcjNMcll0Mlc1dVArVVFNMjVHNVVTa2MyMG1VUDIraXRG?=
 =?utf-8?B?OEJZL1lLei80azU5MFh2SCs3c2xjcjhSYmFucmQ0aFB1NkxoV2ZqQ0FMcDk0?=
 =?utf-8?B?TkU0akhvNEYxcWxUek5JNFIzSFB5a0VBSVl2OHlFS1pyRmRBSkd5UENqT0Fm?=
 =?utf-8?B?ZHZiVncwWndTcTJLR1BXRHFTZ1IvNzlMbkFnYmJDb2Z0VllOR3FrSi92VlVC?=
 =?utf-8?B?M1hUcU9aM1hhV3FQcEl0ZG03RnNGZmUybFlERDR1UXJGWGNpQ1hLRHF6eDZU?=
 =?utf-8?B?QTFNSkJPUE5aL1VXVTlacCtwOEsxQWJpckdaL3kwNDU4T0gvVm9aZENQNlRa?=
 =?utf-8?B?czBSSWY0bEZ1WTlEMlVmVHJvQXNjaUpncVcweS9OL1lKOXNLTGorRnBCNmVJ?=
 =?utf-8?B?SldNTTIwZkdzbFYvenFiUjRaL2E3R0R2Q2Vvb2JYcS8yUkRYTXU3L3ViWVYr?=
 =?utf-8?B?eDd5VWFja3FGMURsTG1mclRXMVJtcFN3Z1VVYm1MVU56ZEhpTjBKb0p0VEJ6?=
 =?utf-8?B?ZktkRlk1SEl0UlhITTlKTVA0YlFtR1pETFVLL3FkS01EUXpjSHhzOElZUlQ1?=
 =?utf-8?B?WU9qRHQxbGpVT1E3RkozL25MbWV0V2NaS0pDVWMvWnU4dVZkaWtDS0tKMzA2?=
 =?utf-8?B?NnpUdERqZUNCd2RwMXpCYXdqb3d0Y1hRbUxaUGhBMU1wR1hhUHlWTmp6RWtS?=
 =?utf-8?B?SFhvM1hLS3hlUjlTTFIzem1uQWNNcHkzZmZkL1RnbDlUZlBqMUVOY1lRUys0?=
 =?utf-8?B?UHJHRkZJOGFOcmFyYTNMbDVwOTZ4ZmhJOEF0N0NJZ3gwMjVSdzdrSkd4TEJv?=
 =?utf-8?B?RHBtbmRuRXQ0Y1BydVJMcVIvcHJQZ3dHUlJpa2RHTzVJdFgyU0RSbU4wRm9i?=
 =?utf-8?B?MkYzYUNqMUZXcGl2RkRGMWNnNkliRG4ycE04c015bVF0OGRqSUQvL1hMQitm?=
 =?utf-8?B?S29vOWd5TEJLVTVxMkdKYWdzb2VCTmE2TXhxVmV6UDJzU3dWZXAzcXNEdkFU?=
 =?utf-8?B?aDVpbmFkRDBpN0RkMVkxRHpVVkJWd1V3OE9ZZVZpbWtrN01udWs4NXR1ajV0?=
 =?utf-8?B?V2xxTFUzSHpyWVJTdjJ4WUwyYkVzbEJMSllHN2xnTmVQTWlDNjRoSnVqOW5B?=
 =?utf-8?B?enYwNmFVV0hhZ2lvMUxiY2RmVW9TeXY4V2ZnbkFwditYWU5hL3Y4WUd6Wjdn?=
 =?utf-8?B?U3JkVkVhU0xsZXJqRUhneHdDS0ZhZGlkSE5BNFR1a21nMXVQUmpJRzZwMVB2?=
 =?utf-8?B?c1VNQUVIVU5Gc09GRXF6OGpGblJJWWo0TzdhbXVBcVpkenVvYStGekpGZnFy?=
 =?utf-8?B?dkhUSDBHNWQ0STE0TjNyTElMQ0lFKzE5U1lXS3pVM09OZHdRbklnNlRZeFlM?=
 =?utf-8?B?TlNNZXE4dFkxaDlrYkRQVkRFUDA4KytjUm1hUjJES084WTNyaWVHWlpYcTYz?=
 =?utf-8?B?WUhwZlFobExSKzl5azFIZ0dZcUlFWU1ZZkVNMnBraWxRTnc1aGNGUnJaNzEy?=
 =?utf-8?B?anRTUmNRdytjdkJ3aDlvY2U1K3AvTlZXbXA3Q3g1Q0U0MUhWTHNJZFdLRVNr?=
 =?utf-8?B?cFdCRUFmQi9OU2dYVVUzL3RXQlNTbFVTQlprU0dSTW9LMm4vcnNCbjlMcWVh?=
 =?utf-8?B?M21Nb1VjbC9XSE9Za1lsd0NhVkpUcExSSis5U0xrSWF3cjJRSFI5OThqY2JM?=
 =?utf-8?B?cFNGNXUrdmJRMERnTTdlN2tyOXMxYVdJaFJFTGg2a0o0WFNja05tMjZyMFZG?=
 =?utf-8?B?WHpIczg2cTZlZDFoZ3FPQWMzMFhQTm1GZ2duTHlxTG00YWdVdThLOWdFS0l6?=
 =?utf-8?B?Rk5Bek5OVjhINndzZUtJUkZJaVlNek1TeWd1d2pvTnhQbTVlb1UvYWlaTnor?=
 =?utf-8?B?aldYMUFSczA5QlpSZnpvMHNQMm5JMUJoZFZjUkRlSEF6SkhaSjVGVlozQm9l?=
 =?utf-8?B?cTM5cWFxaW95VkxwUGk2dSs5L2lHM0N5ak1tL3psODl0dEpub25GN1krZlg0?=
 =?utf-8?B?bnYwdStkQ0J2eWZaMm03MnF4RUFrYWc1QnhJVm81TnBzZGJTWHM0UWJQb2Y2?=
 =?utf-8?B?VUMyVnpEWGRpYTFhWEh1RytTaEw4NWxqTm9rWkZGcGh5SGNnT1FkdUhScmhB?=
 =?utf-8?Q?SCx8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c380401-9585-44c4-84fe-08dbb3570ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:11:06.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qH3WIVdG1Xm9OK7+Ggm+SI0Z6weQYiUIuc+2b6AqK6y6T5nbv9YRCgCkLYNardbZ57CgPd75rh1Lj4kTLNyvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAxMiwgMjAyMyA5OjQ4IEFNDQo+IA0KPiBPbiBNb24sIFNlcCAxMSwgMjAy
MyBhdCAyOjQ34oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4NCj4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
DQo+ID4gPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyAxMjowMSBQTQ0KPiA+ID4N
Cj4gPiA+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0IDEyOjEy4oCvUE0gUGFyYXYgUGFuZGl0IDxw
YXJhdkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSGkgTWljaGFlbCwN
Cj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiB2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy1vcGVu
Lm9yZw0KPiA+ID4gPiA+IDx2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy0gb3Blbi5vcmc+IE9u
IEJlaGFsZiBPZiBKYXNvbiBXYW5nDQo+ID4gPiA+ID4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MTEsIDIwMjMgODozMSBBTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCBTZXAgNiwgMjAy
MyBhdCA0OjMz4oCvUE0gTWljaGFlbCBTLiBUc2lya2luDQo+ID4gPiA+ID4gPG1zdEByZWRoYXQu
Y29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gV2VkLCBTZXAg
MDYsIDIwMjMgYXQgMDQ6MTY6MzdQTSArMDgwMCwgWmh1IExpbmdzaGFuIHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMgdHdvIG5ldyBsZTE2IGZpZWxkcyB0byBjb21tb24gY29u
ZmlndXJhdGlvbg0KPiA+ID4gPiA+ID4gPiBzdHJ1Y3R1cmUgdG8gc3VwcG9ydCBWSVJUSU9fRl9R
VUVVRV9TVEFURSBpbiBQQ0kgdHJhbnNwb3J0IGxheWVyLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgZG8gbm90IHNlZSB3
aHkgdGhpcyB3b3VsZCBiZSBwY2kgc3BlY2lmaWMgYXQgYWxsLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gVGhpcyBpcyB0aGUgUENJIGludGVyZmFjZSBmb3IgbGl2ZSBtaWdyYXRpb24uIFRoZSBmYWNp
bGl0eSBpcyBub3Qgc3BlY2lmaWMgdG8NCj4gUENJLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQg
Y2FuIGNob29zZSB0byByZXVzZSB0aGUgY29tbW9uIGNvbmZpZ3VyYXRpb24gb3Igbm90LCBidXQg
dGhlDQo+ID4gPiA+ID4gc2VtYW50aWMgaXMgZ2VuZXJhbCBlbm91Z2ggdG8gYmUgdXNlZCBieSBv
dGhlciB0cmFuc3BvcnRzLiBXZQ0KPiA+ID4gPiA+IGNhbiBpbnRyb2R1Y2Ugb25lIGZvciBNTUlP
IGZvciBzdXJlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQnV0IGJlc2lk
ZXMgSSB0aG91Z2h0IHdvcmsgb24gbGl2ZSBtaWdyYXRpb24gd2lsbCB1c2UgYWRtaW4gcXVldWUu
DQo+ID4gPiA+ID4gPiBUaGlzIHdhcyBleHBsaWNpdGx5IG9uZSBvZiB0aGUgbW90aXZhdG9ycy4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiBQbGVhc2UgZmluZCB0aGUgcHJvcG9zYWwgdGhhdCB1c2VzIGFk
bWluaXN0cmF0aW9uIGNvbW1hbmRzIGZvcg0KPiA+ID4gPiBkZXZpY2UNCj4gPiA+IG1pZ3JhdGlv
biBhdCBbMV0gZm9yIHBhc3N0aHJvdWdoIGRldmljZXMuDQo+ID4gPiA+DQo+ID4gPiA+IFsxXQ0K
PiA+ID4gPiBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21t
ZW50LzIwMjMwOS9tc2cwMDANCj4gPiA+ID4gNjEuaA0KPiA+ID4gPiB0bWwNCj4gPiA+DQo+ID4g
PiBUaGlzIHByb3Bvc2FsIGNvdXBsZXMgbGl2ZSBtaWdyYXRpb24gd2l0aCBzZXZlcmFsIHJlcXVp
cmVtZW50cywgYW5kDQo+ID4gPiBzdWZmZXJzIGZyb20gdGhlIGV4YWN0IGlzc3VlcyBJJ3ZlIG1l
bnRpb25lZCBiZWxvdy4NCj4gPiA+DQo+ID4gSXQgZG9lcyBub3QuDQo+ID4gQ2FuIHlvdSBwbGVh
c2UgbGlzdCB3aGljaCBvbmU/DQo+ID4NCj4gPiA+IEluIHNvbWUgY2FzZXMsIGl0J3MgZXZlbiB3
b3JzZSAoY291cGxpbmcgd2l0aCBQQ0kvU1ItSU9WLCBzZWNvbmQNCj4gPiA+IHN0YXRlIG1hY2hp
bmUgb3RoZXIgdGhhbiB0aGUgZGV2aWNlIHN0YXR1cykuDQo+ID4gPg0KPiA+IFRoZXJlIGlzIG5v
IHN0YXRlIG1hY2hpbmUgaW4gWzFdLg0KPiANCj4gSXNuJ3QgdGhlIG1pZ3JhdGlvbiBtb2RlcyBv
ZiAiYWN0aXZlLCBzdG9wLCBmcmVlemUiIGEgc3RhdGUgbWFjaGluZT8NCj4gDQpIdWgsIG5vLiBF
YWNoIG1vZGUgc3RvcHMvc3RhcnRzIHNwZWNpZmljIHRoaW5nLg0KSnVzdCBiZWNhdXNlIG9uZSBz
ZXJpZXMgaXMgbWlzc2luZyB0aGlzIGFuZCBkaWQgb25seSBzdXNwZW5kL3Jlc3VtZSBhbmQgb3Ro
ZXIgc2VyaWVzIGNvdmVyZWQgUDJQIG1vZGUgd2l0aCBtb2RlcywgaXQgZG9lcyBub3QgbWFrZSBp
dCBzdGF0ZSBtYWNoaW5lLg0KSWYgeW91IGNhbGwgc3VzcGVuZCByZXN1bWUgYXMgc3RhdGVzLCBp
dCBpcyBzdGlsbCAyIHN0YXRlIHN0YXRlIG1hY2hpbmVzLiA6KQ0KDQo+ID4gSXQgaXMgbm90IGNv
dXBsZWQgd2l0aCBQQ0kvU1ItSU9WIGVpdGhlci4NCj4gPiBJdCBzdXBwb3J0cyBQQ0kvU1ItSU9W
IHRyYW5zcG9ydCBhbmQgaW4gZnV0dXJlIG90aGVyIHRyYW5zcG9ydHMgdG9vIHdoZW4gdGhleQ0K
PiBldm9sdmUuDQo+ID4NCj4gDQo+IEZvciBleGFtcGxlOg0KPiANCj4gK3N0cnVjdCB2aXJ0aW9f
ZGV2X2N0eF9wY2lfdnFfY2ZnIHsNCj4gKyBsZTE2IHZxX2luZGV4Ow0KPiArICAgICAgICBsZTE2
IHF1ZXVlX3NpemU7DQo+ICsgICAgICAgIGxlMTYgcXVldWVfbXNpeF92ZWN0b3I7DQo+ICsgbGU2
NCBxdWV1ZV9kZXNjw40NCj4gKyAgICAgICAgbGU2NCBxdWV1ZV9kcml2ZXLDjQ0KPiArICAgICAg
ICBsZTY0IHF1ZXVlX2RldmljZcONDQo+ICt9Ow0KPiArXGVuZHtsc3RsaXN0aW5nfQ0KPiANCj4g
QW5kIGRvZXMgdGhpcyBtZWFuIHdlIHdpbGwgaGF2ZSBjb21tYW5kcyBmb3IgTU1JTyBhbmQgb3Ro
ZXIgdHJhbnNwb3J0Pw0KDQpUaGVyZSBhcmUgdHJhbnNwb3J0cyBzbyB5ZXMsIGZpZWxkIHN0cnVj
dHVyZXMgZnJvbSB0aGUgZGV2aWNlIGNvbnRleHQgd2lsbCBoYXZlIFBDSSBzcGVjaWZpYyBpdGVt
cy4NCg0KPiAoTW9zdCBvZiB0aGUgZmllbGRzIGV4Y2VwdCB0aGUgbXNpeCBhcmUgZ2VuZXJhbCBl
bm91Z2gpLiBBbmQgaXQncyBqdXN0IGEgcGFydGlhbA0KPiBpbXBsZW1lbnRhdGlvbiBvZiB0aGUg
cXVldWUgcmVsYXRlZCBmdW5jdGlvbmFsaXR5IG9mIHRoZSBjb21tb24gY2ZnLCBzbyBJDQo+IHdv
bmRlciBob3cgaXQgY2FuIHdvcmsuDQo+IA0KQXMgSSBhbHJlYWR5IGV4cGxhaW5lZCBpbiBjb3Zl
ciBsZXR0ZXIsIGRldmljZSBjb250ZXh0IHdpbGwgZXZvbHZlIGluIHYwLT52MSB0byBjb3ZlciBt
b3JlLg0KVHJ1ZSwgbW9zdCBmaWVsZHMgYXJlIGdlbmVyYWwsIGFuZCBpdCBoYXMgc29tZSBwY2kg
c3BlY2lmaWMgZmllbGRzLCB3aGljaCB3ZXJlIG5vdCB3b3J0aCB0YWtpbmcgb3V0IHRvIGEgZGlm
ZmVyZW50IHN0cnVjdHVyZS4NCkFuZCByZXBsaWNhdGluZyBzbWFsbCBudW1iZXIgb2Ygc3RydWN0
cyBmb3IgTU1JTyBpcyBub3QgYSBwcm9ibGVtIGVpdGhlciBhcyBpdCBpcyBub3QgY29tcGxpY2F0
aW5nIHRoZSB0cmFuc3BvcnQgZWl0aGVyLg0K

