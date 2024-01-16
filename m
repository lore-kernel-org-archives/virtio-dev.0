Return-Path: <virtio-dev-return-14251-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAC6C47077
	for <virtio-dev@archiver.kernel.org>; Tue, 16 Jan 2024 06:38:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8470879F2C
	for <virtio-dev@archiver.kernel.org>; Tue, 16 Jan 2024 06:38:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C533986637
	for <virtio-dev@archiver.kernel.org>; Tue, 16 Jan 2024 06:38:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6D75598402B; Tue, 16 Jan 2024 06:38:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BF96986561;
	Tue, 16 Jan 2024 06:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3NGA3A5diDEw1gvya+m8RIBuDuVV9MUYmEpfRihSXxUF1Ja/ZJ5xq6WweIr7fkpXe2Vqx6DCLHcZuftTUm7v+Ds0J3iR8zCaotvFYYeTeO4xFCCqFOk22+794RJiBMMD7TM5EgAhFgkyoa+ffPx+H4rU8P41QiJr0929SKizSWAJFB4vwWOoGHTdbbjpjrp3EveD5iQXzaxoo3Ce7EVXoebBVQVIN0XxshbbvhgaPy45C+RasfRTdcN7hY1K2e9lS+8/Oyf2DYXWiQ1dVAitPEW1RFear4COxTfvQbrYM0PlhG7p/PSq7as/8OQY5EcKWwUoMV7ZPnDvO1xrcVxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKXlbe4hODeM760x6/Cy2mUcQFXjoQusU1tgsEZRLVo=;
 b=ZlAzWjYdGoqTC0qLv1S9Itwdp6CdguO5U+qZVWHIViOsolEEbIKwcwKz5jpnP8LQYBmciKp6zBQtRoK7RgSQ7YtiRF348CltyUSJ3NIOk90mF8XzjiV5XjRFLQeXnTreZnZ1andBLhkrxSHCt80c+Ytub79O2Pckuof45yAm3jpcqMqjoSojPsdPFO0Dxor7dQba9jz5744aY6zVJ64xS8Gzh8Nd9mfZAizzlqWCebqrZeIXChzAwonHAoRg0hPzUL3+J7//rlNTMkKZa+6/XHztrvHQKHLd2Ach77jCEmlQcm0Is7LTzN2CsgW52AMTABp8mO7CnO15wYqAPc1akA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
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
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwAABBKiAAAD6fOAAAuOxQAAEuTxoAApzqngAE9jPcAAorzqoAFA43jgAoXI46AFB1tXwAoSxWigFBeb7SA
Date: Tue, 16 Jan 2024 06:37:59 +0000
Message-ID:
 <BL1PR12MB5849F428DC1BEDEFFFF80AA1E7732@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584944D5ECADD4566A8E066CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481FC877410A34DF11CFBFCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D9B54611E347DA492F0CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481FFD5FEDFD63C75927878DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481FFD5FEDFD63C75927878DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA0PR12MB8748.namprd12.prod.outlook.com
 (15.20.7202.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB8767:EE_
x-ms-office365-filtering-correlation-id: fdc43f1a-a97a-404d-55dd-08dc165dae41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DocLlpFHB82RahVwF17tMEsVpLwxt6SXiOCSGVUpAJx5jjbmmPeiJkeOwMge74AyQusV7/cJsuGspZiGGeXkE5jEbsO0cRzCnjlJ509MvoOFjcr7ZvLL1Nm7vMD+AiSiKznhqcHoj+LPEeS5Hc4pb5KF3UJX+ppqZ7kSJmNGD7GQ+NgEbhDnnsyiTFikYJUvvsO7l6tumvy9+A5Tppic4mA9inxmY7ZqoVpqI9ZxrGR0RiQjWnwkOU9HEeq/iCNtJzxibiFlaAO3rXqP+UXxuFh95cR9BxySTPp42wOXy1xj4Pvf733EzBAnq0JuEJyd5vvcPuCdE6WhMq9+dSDoeYXkABarc/l9S7oM5FKiNBOI9LbusNmGfuTDOB3W5j68xPj610DtDu+XBaBEpfQ8CJUze7tK92gbB0UaFTHqDUo1kyFmzSS6AABFPH+Gk28h1RrPpr4w+ubbJYNHAqoC83kFKwosce4H3JN87rWQk0TCVA/pOgnknap2qlovo8tYY1CxWFCw/w2P5cmPn3cQhudFBDHI4SP7ub2tUopKEFWxi57ecpUUhiMt0yltGNWXNc0AcwC6zOHL+CvVZA3uFUWQAo2XopQZvnapOScd2nJABtw/udXeDIW2QmY3kEIv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(122000001)(38070700009)(26005)(55016003)(33656002)(83380400001)(38100700002)(6506007)(71200400001)(7696005)(9686003)(53546011)(76116006)(66946007)(66446008)(66476007)(66556008)(54906003)(64756008)(316002)(6916009)(5660300002)(52536014)(4326008)(8676002)(8936002)(2906002)(7416002)(478600001)(66899024)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEdFdE95RGJGWEV2UUpvN1RHTlFIV3VmdFRpQk40TEg1NTZIMzFHalBJckRl?=
 =?utf-8?B?TjlLZUNIZzl5b0NQcTNVakxBUE56SkRpL2NBQnF5dzE2WFNLTUxZNFhSeG1B?=
 =?utf-8?B?WmFGQTJSelZ4VHExSmltb0JRa1dpdHJ1RnBDQnpQekFYekpYS1pjQVkxNWRB?=
 =?utf-8?B?M0FtSXhtWHZnT2wyNTBCWWRiNlIzdDlqT05WWnp4bVF5T3J2T2FFbWNDS1Fz?=
 =?utf-8?B?emUrWTVYN1hSUm5ualR6eTA4NjR2WGRoZXB5K25XMkkvMnVWMks5YjZrNXdG?=
 =?utf-8?B?bDQyZmpGL01mZkNuTTh4Uyt1NVo0NStJYWFRVHMwVFR1bHlFZ3J5LzZnckEw?=
 =?utf-8?B?eHV3VGxaMWUzUnNxbW00d3pxeFlBWHliNzFwMzhOZFNmdGFiSkEvY2Urd1V1?=
 =?utf-8?B?OXZjZkFzUmQ1SC9vVXI1d1NKRzBqeVVycWM1WU1wZWVEbWt2T0szSG9zY1lZ?=
 =?utf-8?B?U3hyTG91RktLQk5ZZW5LNThSQ3F5Vm5DeStFbHhVWHlsYk9hVmxYREpKK2gw?=
 =?utf-8?B?RUZvdmRRM0RVOWV0RUpaaXd4c0NPQXhYcTNOdUpLbHFXa3psNlBBaldHKytL?=
 =?utf-8?B?azhKcXUrOXdCOFRjTXBHalNNU3R4b2dPTzJ0ZFdHY21hNFMxWmlNdWYrN2RJ?=
 =?utf-8?B?Z2ROSzgxdmZhMjBvYW14YkRIZG9aWkpkckZJYStBeVVTMlladzVzY1FnVEd2?=
 =?utf-8?B?MGFZZ24wT3B6bEdhbU8vMmhyYkFTSGc0MkRlcm8yZnBFOWNXSE5GN1R5dldM?=
 =?utf-8?B?NWxFMjl1MExlanljNkdGWHhlaEFYOEszbmRuYWtyd3NoblBPdDhxZ2YzVEkz?=
 =?utf-8?B?a0NVZVptS25jQ0QzRkwvc3NMQ0hTNXB0MVF2SGI4ck5DN0w2QkZpWDh1VW5U?=
 =?utf-8?B?bmgyZ1Bla21vdW5zbklDcVRnNGNTWXNpN2YrWE5BTnlLYnJPck1SQzJuaHRU?=
 =?utf-8?B?U3JMYVJVOFZ1NGdmVGp1TE92WkRSbjFySFlPN1NPemFCQk95NWxCUGY3U25p?=
 =?utf-8?B?b3NuMVBhYVU3ZUxuUzhqTDJCWThjMG9pbGxuUFpWcE1PUFBYUDFLendQekFR?=
 =?utf-8?B?NkFOY1Z6RkQrRVd5dHB3ZGNUVEFrSWJqaXh3cmRLeFliTldTMkkySlVXVDhj?=
 =?utf-8?B?SDFRb1pXNDBtR3l1anZmZGQ2L1c3cXltc2xqcGNFbGhEaDZLT29GalNJM2RQ?=
 =?utf-8?B?N3c4eWI4eldxOCtraGVVRGNjdUdwaWl4Q3NuTzZ3cGxGZnFQU1NKazRyU1ZN?=
 =?utf-8?B?R2VUL0lWWjRMazc3RUxLbGZ5MzhmUGtnbGc4aFVBWHNhY0RhZThCTFZoa296?=
 =?utf-8?B?dHVSK0MwNzJDYi9CcWdPT2JrVHVtT2oxb1RYdm5GYVQzQzdXYkhyYW53eER5?=
 =?utf-8?B?elFaVC9xLzE4cFcrczNwNFNzNS93R21wL3UzWWpFOFNPUktwMnFBbjdJSFYv?=
 =?utf-8?B?TUFNdTNlNWdCbWNPcld6bWpkMUFkQUF2Zk1xZEVscUpxQi9ESVlXekFWSm16?=
 =?utf-8?B?OVRLM29iQm53R3JSdlF1TVJZdERJUVdkZXFaOTVnK0lQbGR3aHZQWWlDUTNt?=
 =?utf-8?B?ZFFjdUh3TzdiVG5PZ1hPMXdsZUpySnBtZHZqTDJqNm5yMjlwNXBnb25qVDA3?=
 =?utf-8?B?MU5VcGc4LzB1VDFwYk5aNVV4c1lGMEpGd2lmNUpVUEJENUF3QXlXWXFDM0R0?=
 =?utf-8?B?K2VPeTVma09PS1NzNE5GdkpnOVd2SGdiNTY2dVBiMWkyY2d5YjAvRGpveUw3?=
 =?utf-8?B?T1I2S2xEd0Qzdkt3dHUxS1pZbENENmFvQUN6NUpoaERHY1FxSHI3UHNOREJV?=
 =?utf-8?B?Sy93bEkzRVVyQWwzMHVFc3ZHM1dGS1dUUjZYWWJrc2RmWFVFN05KbVB4VmNh?=
 =?utf-8?B?QURKMTZ5bllqYytBQVQvN25XVFVJcWNxVGxDSkFwZEowNGhjMG9FM1doSlg0?=
 =?utf-8?B?bHZxT3FNQUZuUDUxSVROTkpOckRoZlRzQVdteUJqZStzcjgwcWVtUXFiS2Nu?=
 =?utf-8?B?eElSZU1Eajdac216TjZvMG82eDd6Z1duWU5kU0k1RWlhUkkwV3ZrWkhvdE1T?=
 =?utf-8?B?eFZQMThGWEo3Y29nM1E1Y0h2UGtqRENKNFp5TDc0eE9lMSt1MFNjU0dxWGQ1?=
 =?utf-8?Q?O6Og=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A852A00E623E4947B5B3A0E2AEBACFE0@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc43f1a-a97a-404d-55dd-08dc165dae41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 06:37:59.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZhE03O4qFuO6vOeDG2/BeraWZPJKmZCM9Fk1wHqLCwrONCnIqMOzGuvoes95M4Tl278TBe+Jg92PgjMUTH0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE5OjEwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDQ6MzcgUE0NCj4+DQo+PiBPbiAyMDI0LzEvMTUgMTg6NTIsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5j
b20+DQo+Pj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCA0OjE3IFBNDQo+Pj4+DQo+
Pj4+IE9uIDIwMjQvMS8xNSAxNzo0NiwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+
PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDM6MTAgUE0NCj4+Pj4+DQo+Pj4+Pj4+IERpc3BsYXkg
cmVzb3VyY2VzIHNob3VsZCBiZSBvbmx5IHJlc3RvcmVkIHdoZW4gZm9sbG93aW5nDQo+Pj4+Pj4+
IGNvbmRpdGlvbnMgYXJlDQo+Pj4+Pj4gbWV0Lg0KPj4+Pj4+PiAxLiBQQ0kgUE0gY2FwIGlzIHJl
cG9ydGVkLg0KPj4+Pj4+PiAyLiBQQ0kgUE0gY2FwIGhhcyBub25fc29mdF9yZXNldD0xIDMuIHZp
cnRpbyBndWVzdCBkcml2ZXIgZG8gbm90DQo+Pj4+Pj4+IHBlcmZvcm0gcmVzZXQgd2hlbiB0cmFu
c3BvcnQgb2ZmZXJzIGEgcmVzdG9yZQ0KPj4+Pj4+IGNhcGFiaWxpdHkgdXNpbmcgIzEgYW5kICMy
Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBEbyB5b3UgYWdyZWU/IFllcz8NCj4+Pj4+PiBZZXMsIEkgdGhp
bmsgdGhpcyBwcm9ibGVtIChkaXNwbGF5IHJlc291cmNlcyBhcmUgZGVzdHJveWVkIGR1cmluZw0K
Pj4+Pj4+IFMzKSBjYW4gYmUgc29ydGVkIHRvIHR3byBzaXR1YXRpb25zOg0KPj4+Pj4+IEZpcnN0
IGlzIHdoYXQgeW91IHNhaWQgYWJvdmUsIGluIHRoaXMgc2l0dWF0aW9uLCB0aGUgZGV2aWNlc19y
ZXNldA0KPj4+Pj4+IG9mIHFlbXUgaXMgdW5yZWFzb25hYmxlLCBpZiBhIGRldmljZSBoYXMgUE0g
Y2FwIGFuZA0KPj4+Pj4+IG5vbl9zb2Z0X3Jlc2V0PTEsIHFlbXUgc2hvdWxkIG5vdCBkbyByZXNl
dHRpbmcuDQo+Pj4+Pg0KPj4+Pj4+IFNlY29uZCBpcyB3aXRob3V0ICMxIG9yICMyLCB0aGUgcmVz
ZXQgYmVoYXZpb3IgaXMgZmluZS4gTXkgcGF0Y2ggaXMNCj4+Pj4+PiB0byBmaXggdGhpcyBzaXR1
YXRpb24sIHRoYXQgc2VuZGluZyBhIG5ldyB2aXJ0aW8tZ3B1IGNvbW1hbmQgdG8NCj4+Pj4+PiBu
b3RpZnkgcWVtdSB0byBwcmV2ZW50IGRlc3Ryb3lpbmcgZGlzcGxheSByZXNvdXJjZXMgZHVyaW5n
IFMzLg0KPj4+Pj4NCj4+Pj4+IEkgc3RpbGwgaGF2ZSBoYXJkIHRpbWUgZm9sbG93aW5nICJNeSBw
YXRjaCBpcyB0byBmaXggdGhpcyBzaXR1YXRpb24uLi4iLg0KPj4+Pj4NCj4+Pj4+IFdoZW4gIzEg
YW5kICMyIGlzIG5vdCBkb25lLCB0aGVyZSBpcyBub3RoaW5nIHRvIHJlc3RvcmUuDQo+Pj4+PiBE
cml2ZXIgc2hvdWxkIG5vdCBzZW5kIHNvbWUgbmV3IHZpcnRpbyBzcGVjaWZpYyBjb21tYW5kIHdo
ZW4gIzEgYW5kDQo+Pj4+PiAjMiBpcw0KPj4+PiBub3QgdGhlcmUuDQo+Pj4+PiBJbnN0ZWFkLCBp
ZiB0aGUgZGV2aWNlIHdhbnRzIHRvIHJlc3RvcmUgdGhlIGNvbnRleHQsIGFsbCAjMSwgIzIgYW5k
DQo+Pj4+PiAjMyBzaG91bGQNCj4+Pj4gYmUgZG9uZSB0byBpbXBsZW1lbnQgdGhlIHJlc3RvcmUg
ZnVuY3Rpb25hbGl0eS4NCj4+Pj4gV2hlbiAjMSBhbmQgIzIgaXMgZG9uZS4gVGhlICJkZXZpY2Ug
cmVzZXQgYmVoYXZpb3IiIHNob3VsZCBub3QNCj4+Pj4gaGFwcGVuLiBBbmQgdGhlbiB0aGUgZGlz
cGxheSByZXNvdXJjZXMgYXJlIG5vdCBkZXN0cm95ZWQuDQo+Pj4+IEkgZGlkbuKAmXQgc2F5IHNl
bmQgY29tbWFuZCB0byByZXN0b3JlIGNvbnRleHQuDQo+Pj4NCj4+Pj4gSSBtZWFuIHdoZW4gIzEg
YW5kICMyIGlzIG5vdCBkb25lLiBEcml2ZXIgYW5kIHFlbXUgYm90aCByZXNldCBkZXZpY2VzDQo+
Pj4+IHdoZW4gcmVzdW1pbmcsIGF0IHRoYXQgdGltZSwNCj4+PiBBYm92ZSBiZWhhdmlvciBpcyBh
cyBwZXIgdGhlIHNwZWMgZ3VpZGVsaW5lcy4gSGVuY2UgaXQgaXMgZmluZS4NCj4+Pg0KPj4+PiB3
ZSBuZWVkIGEgbWV0aG9kIHRvIHByZXZlbnQgdGhlIGRpc3BsYXkgcmVzb3VyY2VzIGZyb20gZGVz
dHJveWluZy4NCj4+PiBJIGRpc2FncmVlIHRvIGFib3ZlIGFzIGl0IGlzIG5vdCBhcyBwZXIgdGhl
IHNwZWMgZ3VpZGVsaW5lcy4NCj4+PiBKdXN0IGZvbGxvdyAjMSwgIzIgYW5kICMzIHRvIG5vdCBk
ZXN0cm95IHRoZSBkaXNwbGF5IHJlc291cmNlIGRlc3Ryb3lpbmcuDQo+PiBJIGFncmVlIHRoYXQg
Zm9sbG93ICMxLCAjMiBhbmQgIzMgd2lsbCBub3QgZGVzdHJveSBkaXNwbGF5IHJlc291cmNlLg0K
Pj4gU28gdGhlIHF1ZXN0aW9uIGdvZXMgYmFjazogSWYgdGhlcmUgaXMgbm8gIzIgYW5kIHlvdSBz
YXkgdGhhdCB0aGUgcmVzZXQNCj4+IGJlaGF2aW9yIGNvbXBsaWVzIHdpdGggdGhlIHNwZWMgZ3Vp
ZGVsaW5lcywgaG93IGNhbiBJIG1ha2UgdGhlIHZpcnRpbyBncHUNCj4+IHdvcmsgcHJvcGVybHkg
d2l0aCBkaXNwbGF5IHJlc291cmNlcyBkZXN0cm95ZWQ/DQo+IEltcGxlbWVudCAjMi4gOikNCldl
IGNhbid0IHNpbXBseSBpbXBsZW1lbnQgIzIgaWYgYSBkZXZpY2UgZG9lc24ndCBoYXZlICMyLCBz
ZWUgU2VjdGlvbiA3LjUuMi4yIGluIFBDSSBFeHByZXNzIFNwZWMsIGFib3V0IE5vX1NvZnRfUmVz
ZXQ6DQoiIElmIGEgVkYgaW1wbGVtZW50cyB0aGUgUG93ZXIgTWFuYWdlbWVudCBDYXBhYmlsaXR5
LCB0aGUgVkYncyB2YWx1ZSBvZiB0aGlzIGZpZWxkIG11c3QgYmUgaWRlbnRpY2FsIHRvIHRoZSBh
c3NvY2lhdGVkIFBGJ3MgdmFsdWUuICINCldoYXQncyBtb3JlLCBhIGRldmljZSBkb2Vzbid0IGhh
dmUgIzIgaXMgYWxsb3dlZCwgd2Ugc2hvdWxkIGNvbnNpZGVyIGhvdyB0byBzb2x2ZSB0aGUgdHdv
IHNpdHVhdGlvbnMoTm9fU29mdF9SZXNldD0xIGFuZCBOb19Tb2Z0X1Jlc2V0PTApLCByYXRoZXIg
dGhhbiBzaW1wbHkgY29uc2lkZXJpbmcgaW1wbGVtZW50aW5nICMyIGZvciB0aGUgZGV2aWNlIHdo
ZW4gaXQgZG9lcyBub3QgaGF2ZSAjMi4NCkFsc28gaW4gUENJIEV4cHJlc3MgU3BlYzoNCiIgRnVu
Y3Rpb25hbCBjb250ZXh0IGlzIHJlcXVpcmVkIHRvIGJlIG1haW50YWluZWQgYnkgRnVuY3Rpb25z
IGluIHRoZSBEM0hvdCBzdGF0ZSBpZiB0aGUgTm9fU29mdF9SZXNldCBmaWVsZCBpbiB0aGUgUE1D
U1IgaXMgU2V0LiBJbiB0aGlzIGNhc2UsIFN5c3RlbSBTb2Z0d2FyZSBpcyBub3QgcmVxdWlyZWQg
dG8gcmUtaW5pdGlhbGl6ZSB0aGUgRnVuY3Rpb24gYWZ0ZXIgYSB0cmFuc2l0aW9uIGZyb20gRDNI
b3QgdG8gRDAgKHRoZSBGdW5jdGlvbiB3aWxsIGJlIGluIHRoZSBEMGFjdGl2ZSBzdGF0ZSkuIElm
IHRoZSBOb19Tb2Z0X1Jlc2V0IGJpdCBpcyBDbGVhciwgZnVuY3Rpb25hbCBjb250ZXh0IGlzIG5v
dCByZXF1aXJlZCB0byBiZSBtYWludGFpbmVkIGJ5IHRoZSBGdW5jdGlvbiBpbiB0aGUgRDNIb3Qg
c3RhdGUuIg0KVGhpcyBkZXNjcmlwdGlvbiBjb3JyZXNwb25kcyB0byB0aGUgdHdvIHNpdHVhdGlv
bnMgd2UgYXJlIGRpc2N1c3NpbmcuDQpGaXJzdCBpcyBhIGRldmljZSBoYXMgIzIoTm9fU29mdF9S
ZXNldD0xKSwgdGhlIGRldmljZSByZXNldHRpbmcgd2lsbCBub3QgaGFwcGVuLCB0aGVuIHRoZSBk
aXNwbGF5IHJlc291cmNlcyBvZiB2aXJ0aW8tZ3B1IHByb2JsZW0gd2lsbCBub3QgaGFwcGVuLg0K
QnV0IGluIFNlY29uZCwgYSBkZXZpY2UgZG9lc24ndCBoYXZlICMyKE5vX1NvZnRfUmVzZXQ9MCks
IGl0IGlzIGZpbmUgZm9yIHN5c3RlbSB0byBkbyBkZXZpY2UgcmVzZXR0aW5nLCBhdCB0aGlzIHRp
bWUsIHRoZSBkaXNwbGF5IHJlc291cmNlcyBvZiB2aXJ0aW8tZ3B1IHByb2JsZW0gd2lsbCBoYXBw
ZW4sIHdlIHNob3VsZCBhbHNvIGNvbnNpZGVyIGEgbWV0aG9kIHRvIHNvbHZlIHRoYXQgcHJvYmxl
bSwgYnV0IG5vdCB0byBpbXBsZW1lbnQgIzIuDQoNCj4gDQo+PiBXaGF0IG15IHBhdGNoIGRvIGlz
IG5vdCB0byBwcmV2ZW50IHJlc2V0dGluZywgaXMgdG8gcHJldmVudCBkZXN0cm95aW5nDQo+PiBy
ZXNvdXJjZXMgZHVyaW5nIHJlc2V0dGluZy4gR2VyZCBIb2ZmbWFubiBoYXMgYWdyZWVkIHRvIHRo
aXMgcG9pbnQgaW4gbXkNCj4+IHFlbXUgcGF0Y2ggcmV2aWV3aW5nLg0KPj4gRXZlbiBpZiBJIHVz
ZSBQTSBjYXAsIEkgc3RpbGwgbmVlZCB0byBwcmV2ZW50IGRlc3Ryb3lpbmcgcmVzb3VyY2VzIGR1
cmluZw0KPj4gcmVzZXR0aW5nLg0KPiBEbyB5b3UgbWVhbiB3aGVuIHZpcnRpbyBkZXZpY2UgaXMg
cmVzZXQsIHlvdSB3YW50IHRvIHByZXZlbnQ/DQpJIHdhbnQgdG8gcHJvdGVjdCBkaXNwbGF5IHJl
c291cmNlcywgbm90IHRvIHByZXZlbnQgdGhlIHdob2xlIHByb2Nlc3Mgb2YgZGV2aWNlIHJlc2V0
dGluZy4NCkFsc28gaW4gUENJIEV4cHJlc3MgU3BlYzoNCiJOb3RlIHRoYXQgYSBGdW5jdGlvbidz
IHNvZnR3YXJlIGRyaXZlciBwYXJ0aWNpcGF0ZXMgaW4gdGhlIHByb2Nlc3Mgb2YgdHJhbnNpdGlv
bmluZyB0aGUgRnVuY3Rpb24gZnJvbSBEMCB0byBEM0hvdC4gSXQgY29udHJpYnV0ZXMgdG8gdGhl
IHByb2Nlc3MgYnkgc2F2aW5nIGFueSBmdW5jdGlvbmFsIHN0YXRlIHRoYXQgd291bGQgb3RoZXJ3
aXNlIGJlIGxvc3Qgd2l0aCByZW1vdmFsIG9mIG1haW4gcG93ZXIsIGFuZCBvdGhlcndpc2UgcHJl
cGFyaW5nIHRoZSBGdW5jdGlvbiBmb3IgdGhlIHRyYW5zaXRpb24gdG8gRDNIb3QuIg0KSSBsZXQg
Z3Vlc3QgZHJpdmVyIHRvIG5vdGlmeSBxZW11IHRvIHByb3RlY3QgdGhlIGRpc3BsYXkgcmVzb3Vy
Y2VzIHRoYXQgd2lsbCBiZSBsb3NzIGR1cmluZyBTMywgaXQgaXMgYWxzbyBjb21wbGlhbnQgd2l0
aCBTcGVjLg0KDQo+IElmIHNvLCB0aGF0IGlzIHlldCBhZGRpdGlvbmFsIHZpcnRpbyBzcGVjIGhh
Y2sgdGhhdCBtdXN0IGJlIGF2b2lkZWQgYXMgcmVzZXQgZmxvdyBzaG91bGQgYmUgb25lLg0KPiBQ
bGVhc2UgZG8gIzMgdG8gYXZvaWQgcmVzZXR0aW5nIHRoZSBkZXZpY2UuDQpUaGUgc2FtZSByZWFz
b24gYXMgYWJvdmUuIEFjY29yZGluZyB0byB0aGUgcmVndWxhdGlvbnMgb2YgdGhlIHNwZWMsIHdl
IHNob3VsZCBhbGxvdyBmb3IgdGhlIG9jY3VycmVuY2Ugb2YgdHdvIHNpdHVhdGlvbnMoTm9fU29m
dF9SZXNldD0xIGFuZCBOb19Tb2Z0X1Jlc2V0PTApIGFuZCBwcm92aWRlIHNvbHV0aW9ucyBmb3Ig
ZWFjaCBzaXR1YXRpb24sIHJhdGhlciB0aGFuIHNpbXBseSBjYXRlZ29yaXppbmcgdGhlbSBpbnRv
IG9uZS4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

