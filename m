Return-Path: <virtio-dev-return-14231-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF03C47422
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:55:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A8184C6244
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:55:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BF5298648B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:55:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 89F0098403A; Mon, 15 Jan 2024 07:55:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77D14986367;
	Mon, 15 Jan 2024 07:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyZioa1lwP6qDcb26e5+9ueVX69dr9Lm+sD4KkWDgc0mXDP5079+NL73H0raHNCIlUFdEvqgyxPQK4VyElPcc767LxanPJcW9xSrLEZUfeb6MteAb4T2x2TitiAwkd5ZOxkDGDEVvXQz6YnnFdZ1dDdapQO04rctfH1E1V5vrnmWXidFr2TwqeepKCGEbi17D5MTt5OffgroUt1w9aTnhf56oB5HP2qlHjfMKyZfFfrpv3Ba4BBugm5oJpAiJfpe28p3c6OhHYNiI8WSMTNPMfZWP1SLk8YJ/Tt6l7fHpi0ixhg45Ihm6wBQ34PvYcq78K/lzuI2k9rLcv9tOQHMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PorREWUsDQoA6nO97945fFf8Jm+YSskkzr8TktH+9+I=;
 b=RKXKHETTAPZM8aLmH6S2Y5jws6DJSubVLaHrwRcOh0CMBfN6omxVS4prNW0HIoSuGXQQ5GLpRI8EUDAUQTYuxKX+rzHRkcnHlq5ids6NInL7NK+D3bkm9LvCmW70UZKmYB5D631YBQsdThO9V/7Yj71472b22oEUfkaJXukRC7dHpHoHJYk03ZWM/w4zHD4LQ1zw8chFmrH+E6Qy0VocniKtAHQjI340oihI3busup84I67FiPrVPMdvSf/LrvvzPXdWPUk0kSDlkDOyh53YjKGmSxVWQUUNDJ2at2pcsC2OjL0XFSWeKLx2xRmuGBWM2xMZrliiQfv4sKlFrXk5Pg==
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
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1AgASS9ACAAADIQIAAA3aAgAABUvA=
Date: Mon, 15 Jan 2024 07:55:26 +0000
Message-ID:
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7726:EE_
x-ms-office365-filtering-correlation-id: 4dd0b6c8-fb32-4f89-3f87-08dc159f5618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZXHAhCge2KOcnKCnyjPVgaLFGyQp+y3/JMzcFvTMG+MNFtG0vBkllm6262XRVK33B4WjANPFVnaUGWe9ZJrWnHrmMAcIvyu9cuaVfpt8xZTqVAkq7f3jj7biNUgBtdydfTUnbN0Znck3LojiBZfx7/avFHPBVTYBUWDJZEeyAvun6ZENTGDcVKm63KwKx2Vbzlmp9O2iKfdEuT+OEZVAiETCZ56amoQ0hyOdHF5pmLmWyzczSjW9Kl+DbBDgwh4Mc9Mb/g6b5Wxh1ik87nFbYZfW6K8bfnYXZbRL53XWyaftl1nvyD3Pbs304+yR6xZZPSvTfkHL6pGK2gnHHONAn2woDfSftiw4VuNRHia9IWXn4fUKkKOs/VZ7mcOZnl7rJTpUreVZdapD0155BJDVOK6frvEs6VoOUwLs1PHqBoeRioh2wPfihi+7woruzuYWkQRPs8GnK0TZjpvaEDR7KjCHOEcCH6os9lGBvGddzW5o+1ldOGJhZ3qJwc/FVEECVGSoL89EqHfq4vC8ZcwHLDJ25OS6PlJfGR2VF0LDGzZLxzNKoEmWI5X0o1/HdSepBvD0N+H+AXBQYZWDKWVlRME7UEYvSXxgi+hgto9P/h/zdvHHko2qYIFihbkqynb8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(86362001)(122000001)(2906002)(38070700009)(71200400001)(55236004)(41300700001)(33656002)(26005)(83380400001)(9686003)(7696005)(6506007)(53546011)(478600001)(7416002)(8676002)(4326008)(52536014)(5660300002)(55016003)(316002)(54906003)(76116006)(66946007)(66899024)(66556008)(66446008)(66476007)(64756008)(6916009)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3ZJSEhYVWxRNml5ZmkwdHhIV1V5SUZldGsxOHBhSlNZenc5bkNrelQ0aW5R?=
 =?utf-8?B?eWNiU1E1c0FLVVFOSHJiUUtob0hiM0ZsRC9RcC93U0V3eWpwVkdGZCtiTnNh?=
 =?utf-8?B?MXlXeGxHb1NGOHNKRlJIZkFCTFpvRmM1cjVwdlJFNnViUWtyWmh5YmowVkZ1?=
 =?utf-8?B?dEFOeWtseWp4TXRDMXBIVklBUlVLTklmODBZWUVBOSsydEtqRDk2U2xNaFAy?=
 =?utf-8?B?V3lBUnZ0cmZpMm5nd1lTN28raGRjazloZ3Y4Y0Z2OSszcWxEZ09WUXlaMmoz?=
 =?utf-8?B?Tlp0Zi9qY0VKZDdnYXdMOThsR3F4cXlHcmsvZ1BYYldYUFQxN2NZVVlCeTlJ?=
 =?utf-8?B?TndsZmJySG5iMTNVcDlxeTRyQThGVzNpekRhZ29PR2YrMnh1N0RYMEZmMFVs?=
 =?utf-8?B?OGh2cXk1eDBiTHVKa0VGbm5vdUFaZjBJMGlYK2ZwcHBPcjdZYnB5cGlDNERF?=
 =?utf-8?B?RngrWEJUZDN5cHJBaGNkejVUY21ROVhiR29lb0ttWGVKK2EzTXQzZHkrcnNE?=
 =?utf-8?B?a0pqekRZN3MzMUdYakFjdVkrSTBqYUU5Z2NoMUhFRFdFMzdXNlQ0K0dUdmIv?=
 =?utf-8?B?cTBmeXNKQUpMZmltQy8wejNrM241dTN6TEdjWWtjN2Z6RDRWYVRzYzJEb3pl?=
 =?utf-8?B?ZDR2bUR4YjhEUDJDTEtjeng2S0R2YVJzb01JRkk0N3dCUGxmbjNheXVJWkx5?=
 =?utf-8?B?a0JsZVRtSE9LdkpoMm91S1orazQyZ3VHRVQxcHVic0JidGt0NE4zNGlRUVlF?=
 =?utf-8?B?TnY1QmdzWVRlbEZlTGJzUTd3cml6WjJ5N0xNazYvek92aTVOZ1N0RHVrN2VN?=
 =?utf-8?B?UmVpRTVLZmRGOUVwbUFMTWxYWVBKbjA4NkNMRVFCODl6dnEvaEQzeXJueFVE?=
 =?utf-8?B?bmdYTGFlUTlZQjNPdWtlYWIwNTlFdVYxMGw4QndJM0FNbTV2aFkrVEFBbnRt?=
 =?utf-8?B?ZWJCT3phT0IzSlFIV3VqeVN6Q1ExZlFrOTRtZWM3cDJEZXRqYlQ3cGZ1RnZJ?=
 =?utf-8?B?ZExMVkcySGczeHYxMVptcUlHNW4wVlBkYUY5NUdJQnpIUmVIb3BUMGVaMjVS?=
 =?utf-8?B?RGpxU3NMeEJZTWtUb3U2WEdMK0VhdmRGZS9TSDBSaFRYTlBMaVBNRVQrNW82?=
 =?utf-8?B?QWNhUk5RUUVwelIvbTV3WnMvV3pWc252eVpFOS92ZnpKTk00cGxZd1RFbzJa?=
 =?utf-8?B?NUlnV24ydHRRR0hxUTJtNEp3NHUwejNvWk9SSzFyS0Vua2ZXS2RjYktxeU90?=
 =?utf-8?B?MHhtYUx2RkkzRlZJWVlGZU0vYnUxWkx2a0RLWDZBOEZ0dVFJRWtZZVJnU2tU?=
 =?utf-8?B?dS9mRUFoSTNkeE1rWk1GSDMraHF3RzUwRlF1NlpYMFhFYlFPNUZOcEVkRVA5?=
 =?utf-8?B?a3I0RG5ITzhPQ1pLRytXazdsRFp3QS9sNlFtcHZSTFJCRVhFM3UwNTQra1Vv?=
 =?utf-8?B?WlE1UEdjQkozVFdCMng4ODBLVUxQTHI5aDV5bXVxcXk5SXZzb0RyVFg0K0g2?=
 =?utf-8?B?YWt1Rk5janF1aDVqLzg4TlpKU0FZaFlnUDdVcEhaMkVtRVJsNFRsZzhCYkVX?=
 =?utf-8?B?R2VhdVZ4YUx4bzI4a3FrbEliWlZFL1AyVitOMXN0b1FoODQ1bHgzQXRIUERM?=
 =?utf-8?B?TnVvTGdtaGlDZkl4NjdJL2hkK2tYaXVpZ2pCY0poYXR6WE1VcHhmVnVWMHhO?=
 =?utf-8?B?dXNEVXBHVHlzREJwNlo3Y3BUbVFpN3lFMVBiRk93SG85VDZWd1BjN0tPSVhi?=
 =?utf-8?B?L3pzOXFjbGYwRnFyZDVYL1VyOU5aajNZblhoTHJxeWZmY2Z3NFVXZTA2WVRD?=
 =?utf-8?B?RWRQMWJOb0pXV01la0U2OVBhOVVUMVptSlMxMjV2cmY0Tk9NWHd6N1MrRXF4?=
 =?utf-8?B?NWd1SkdneVgxZER4eW9mSjJsT05LNkRlaEQyZWhIUC9uUHc4bzA2bnBROXd3?=
 =?utf-8?B?YzBCLzVKa3hMUTlrM2I1RmRQQ0hZbEZpK3Zyck9FajRSNTBmc3g0YStHVHFs?=
 =?utf-8?B?bjRqb0REbE1MeXZTbU5pMXF6WDgxU0ZmTU5JUC9sbnlmVVRNZ3p1YXJ5SjZT?=
 =?utf-8?B?aGwzRkt5NHpaemIzTklhTEZ6amtGY3hXNTgvcVdmS1c3a3kwbVpIdzdWeEJh?=
 =?utf-8?Q?C6NA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd0b6c8-fb32-4f89-3f87-08dc159f5618
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:55:26.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaIFVVCGpueZ2wRznHr7vTqten0IaGrPnKcdLxOtP+qEIK59Weu/E+xxARLM/mRzecChW/59AsPhD+qgYAWQ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6MTggUE0NCj4gDQo+IE9uIDIwMjQvMS8xNSAxNTozNywg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFu
LkNoZW5AYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6MDMg
UE0NCj4gPj4NCj4gPj4gT24gMjAyNC8xLzEyIDE3OjQ0LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5j
b20+DQo+ID4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDI6NTUgUE0NCj4gPj4+
Pg0KPiA+Pj4+IE9uIDIwMjQvMS8xMiAxNjo0NywgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+Pj4+
Pg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQu
Y29tPg0KPiA+Pj4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDE6NTUgUE0NCj4g
Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gMjAyNC8xLzEyIDE2OjAyLCBQYXJhdiBQYW5k
aXQgd3JvdGU6DQo+ID4+Pj4+Pj4gSGkgSmlxaWFuLA0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IEZy
b206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gPj4+Pj4+Pj4gU2VudDog
RnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDE6MTEgUE0NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+Pg0K
PiA+Pj4+Pj4+PiBIaSBhbGwsDQo+ID4+Pj4+Pj4+IFNvcnJ5IHRvIHJlcGx5IGxhdGUuDQo+ID4+
Pj4+Pj4+IEkgZG9uJ3Qga25vdyBpZiB5b3Ugc3RpbGwgcmVtZW1iZXIgdGhpcyBwcm9ibGVtLCBs
ZXQgbWUgYnJpZWZseQ0KPiA+Pj4+Pj4+PiBkZXNjcmlwdA0KPiA+Pj4+IGl0Lg0KPiA+Pj4+Pj4+
PiBJIGFtIHdvcmtpbmcgdG8gaW1wbGVtZW50IHZpcnRncHUgUzMgZnVuY3Rpb24gb24gWGVuLg0K
PiA+Pj4+Pj4+PiBDdXJyZW50bHkgb24gWGVuLCBpZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2gg
cWVtdSB3aXRoDQo+ID4+Pj4+Pj4+IGVuYWJsaW5nIHZpcnRncHUsIGFuZCB0aGVuIHN1c3BlbmQg
YW5kIHJlc3VtZSBndWVzdC4gV2UgY2FuDQo+ID4+Pj4+Pj4+IGZpbmQgdGhhdCB0aGUgZ3Vlc3Qg
a2VybmVsIGNvbWVzIGJhY2ssIGJ1dCB0aGUgZGlzcGxheSBkb2Vzbid0Lg0KPiA+Pj4+Pj4+PiBJ
dCBqdXN0IHNob3duIGEgYmxhY2sNCj4gPj4+Pj4+IHNjcmVlbi4NCj4gPj4+Pj4+Pj4gVGhhdCBp
cyBiZWNhdXNlIGR1cmluZyBzdXNwZW5kaW5nLCBndWVzdCBjYWxsZWQgaW50byBxZW11IGFuZA0K
PiA+Pj4+Pj4+PiBxZW11IGRlc3Ryb3llZCBhbGwgZGlzcGxheSByZXNvdXJjZXMgYW5kIHJlc2V0
IHJlbmRlcmVyLiBUaGlzDQo+ID4+Pj4+Pj4+IG1hZGUgdGhlIGRpc3BsYXkgZ29uZSBhZnRlciBn
dWVzdCByZXN1bWVkLg0KPiA+Pj4+Pj4+PiBTbywgSSBhZGQgYSBuZXcgY29tbWFuZCBmb3Igdmly
dGlvLWdwdSB0aGF0IHdoZW4gZ3Vlc3QgaXMNCj4gPj4+Pj4+Pj4gc3VzcGVuZGluZywgaXQgd2ls
bCBub3RpZnkgcWVtdSBhbmQgc2V0DQo+ID4+Pj4+Pj4+IHBhcmFtZXRlcihwcmVzZXJ2ZXJfcmVz
b3VyY2UpIHRvIDEgYW5kIHRoZW4gcWVtdSB3aWxsIHByZXNlcnZlDQo+ID4+Pj4+Pj4+IHJlc291
cmNlcywgYW5kIHdoZW4gcmVzdW1pbmcsIGd1ZXN0IHdpbGwgbm90aWZ5IHFlbXUgdG8gc2V0DQo+
ID4+Pj4+Pj4+IHBhcmFtZXRlciB0byAwLCBhbmQgdGhlbiBxZW11IHdpbGwga2VlcCB0aGUgbm9y
bWFsIGFjdGlvbnMuDQo+ID4+Pj4+Pj4+IFRoYXQgY2FuDQo+ID4+Pj4gaGVscCBndWVzdCdzIGRp
c3BsYXkgY29tZSBiYWNrLg0KPiA+Pj4+Pj4+PiBXaGVuIEkgdXBzdHJlYW0gYWJvdmUgaW1wbGVt
ZW50YXRpb24sIFBhcmF2IGFuZCBNU1Qgc3VnZ2VzdCBtZQ0KPiA+PiB0bw0KPiA+Pj4+Pj4gdXNl
DQo+ID4+Pj4+Pj4+IHRoZSBQTSBjYXBhYmlsaXR5IHRvIGZpeCB0aGlzIHByb2JsZW0gaW5zdGVh
ZCBvZiBhZGRpbmcgYSBuZXcNCj4gPj4+Pj4+Pj4gY29tbWFuZCBvciBzdGF0ZSBiaXQuDQo+ID4+
Pj4+Pj4+IE5vdywgSSBoYXZlIHRyaWVkIHRoZSBQTSBjYXBhYmlsaXR5IG9mIHZpcnRpby1ncHUs
IGl0IGNhbid0IGJlDQo+ID4+Pj4+Pj4+IHVzZWQgdG8gc29sdmUgdGhpcyBwcm9ibGVtLg0KPiA+
Pj4+Pj4+PiBUaGUgcmVhc29uIGlzOg0KPiA+Pj4+Pj4+PiBkdXJpbmcgZ3Vlc3Qgc3VzcGVuZGlu
ZywgaXQgd2lsbCB3cml0ZSBEMyBzdGF0ZSB0aHJvdWdoIFBNIGNhcCwNCj4gPj4+Pj4+Pj4gdGhl
biBJIGNhbiBzYXZlIHRoZSByZXNvdXJjZXMgb2YgdmlydGlvLWdwdSBvbiBRZW11IHNpZGUoc2V0
DQo+ID4+Pj4+Pj4+IHByZXNlcnZlcl9yZXNvdXJjZSB0byAxKSwgYnV0IGR1cmluZyB0aGUgcHJv
Y2VzcyBvZiByZXN1bWluZywNCj4gPj4+Pj4+Pj4gdGhlIHN0YXRlIG9mIFBNIGNhcCB3aWxsIGJl
IGNsZWFyZWQgYnkgcWVtdQ0KPiA+Pj4+Pj4+PiByZXNldHRpbmcocWVtdV9zeXN0ZW1fd2FrZXVw
LT4gcWVtdV9kZXZpY2VzX3Jlc2V0LT4NCj4gPj4+Pj4+Pj4gdmlydGlvX3ZnYV9iYXNlX3Jlc2V0
LT4gdmlydGlvX2dwdV9nbF9yZXNldCksIGl0IGNhdXNlcyB0aGF0DQo+ID4+Pj4+Pj4+IHdoZW4g
Z3Vlc3QgcmVhZHMgc3RhdGUgZnJvbSBQTSBjYXAsIGl0IHdpbGwgZmluZCB0aGUgdmlydGlvLWdw
dQ0KPiA+Pj4+Pj4+PiBoYXMgYWxyZWFkeSBiZWVuIEQwIHN0YXRlLA0KPiA+Pj4+Pj4+IFRoaXMg
YmVoYXZpb3IgbmVlZHMgdG8gYmUgZml4ZWQuIEFzIHRoZSBzcGVjIGxpc3RlZCBvdXQsICIgVGhp
cw0KPiA+Pj4+Pj4+IDItYml0IGZpZWxkIGlzDQo+ID4+Pj4+PiB1c2VkIGJvdGggdG8gZGV0ZXJt
aW5lIHRoZSBjdXJyZW50IHBvd2VyIHN0YXRlIG9mIGEgRnVuY3Rpb24iDQo+ID4+Pj4+PiBEbyB5
b3UgbWVhbiBpdCBpcyB3cm9uZyB0byByZXNldCBQTSBjYXAgd2hlbiB2cml0aW9fZ3B1IHJlc2V0
IGluDQo+ID4+Pj4+PiBjdXJyZW50IHFlbXUgY29kZT8gV2h5Pw0KPiA+Pj4+PiBCZWNhdXNlIFBN
IGlzIGltcGxlbWVudGluZyB0aGUgc3VwcG9ydCBmcm9tIEQzLT5kMCB0cmFuc2l0aW9uIGFuZA0K
PiA+Pj4+PiBpZiBpdA0KPiA+Pj4+IGRldmljZSBpbiBEMywgdGhlIGRldmljZSBuZWVkcyB0byBy
ZXNwb25kIHRoYXQgaXQgaXMgaW4gRDMgdG8gbWF0Y2gNCj4gPj4+PiB0aGUgUENJIHNwZWMuDQo+
ID4+Pj4+DQo+ID4+Pj4+PiBTaG91bGRuJ3QgYWxsIGRldmljZSBzdGF0ZXMsIGluY2x1ZGluZyBQ
TSByZWdpc3RlcnMsIGJlIHJlc2V0DQo+ID4+Pj4+PiBkdXJpbmcgdGhlIHByb2Nlc3Mgb2Ygdmly
dGlvLWdwdSByZXNldD8NCj4gPj4+Pj4gSWYgTm9fU29mdF9SZXNldD09IDAsIG5vIGRldmljZSBj
b250ZXh0IHRvIGJlIHByZXNlcnZlZC4NCj4gPj4+Pj4gSWYgTm9fU29mdF9SZXNldCA9PSAxLCBk
ZXZpY2UgdG8gcHJlc2VydmUgbWluaW1hbCByZWdpc3RlcnMgYW5kDQo+ID4+Pj4+IG90aGVyDQo+
ID4+Pj4gdGhpbmdzIGxpc3RlZCBpbiBwY2kgc3BlYy4NCj4gPj4+Pj4NCj4gPj4+Pj4+DQo+ID4+
Pj4+Pj4NCj4gPj4+Pj4+PiBTbyBkZXZpY2UgbmVlZHMgdG8gcmV0dXJuIEQzIGluIHRoZSBQb3dl
clN0YXRlIGZpZWxkLiAgVGhpcyBpcyBtdXN0Lg0KPiA+Pj4+Pj4gQnV0IGN1cnJlbnQgYmVoYXZp
b3IgaXMgYSBraW5kIG9mIHNvZnQgcmVzZXQsIEkNCj4gPj4+Pj4+IHRoaW5rKCFQQ0lfUE1fQ1RS
TF9OT19TT0ZUX1JFU0VUKS4gVGhlIHBtIGNhcCBpcyByZXNldCBieSBxZW11DQo+IGlzDQo+ID4+
Pj4+PiByZWFzb25hYmxlLg0KPiA+Pj4+PiBXaGF0IHlvdSBkZXNjcmliZWQgaXMsIHlvdSBuZWVk
IHRvIGRvIE5vX1NvZnRfUmVzZXQ9MSwgc28gcGxlYXNlDQo+ID4+Pj4+IHNldCB0aGUNCj4gPj4+
PiBjYXAgYWNjb3JkaW5nbHkgdG8gYWNoaWV2ZSB0aGUgcmVzdG9yZS4NCj4gPj4+Pj4NCj4gPj4+
Pj4gQWxzbyBpbiB5b3VyIGNhc2UgdGhlIGlmIHRoZSBRRU1VIGtub3dzIHRoYXQgaXQgd2lsbCBo
YXZlIHRvDQo+ID4+Pj4+IHJlc3VtZSB0aGUNCj4gPj4+PiBkZXZpY2Ugc29vbi4NCj4gPj4+Pj4g
SGVuY2UsIGl0IGNhbiB3ZWxsIHByZXBhcmUgdGhlIGdwdSBjb250ZXh0IGJlZm9yZSByZXN1bWlu
ZyB0aGUgdmNwdXMuDQo+ID4+Pj4+IEluIHN1Y2ggY2FzZSwgdGhlIGV4dHJhIHJlZ2lzdGVyIHdv
dWxkbuKAmXQgYmUgbmVjZXNzYXJ5Lg0KPiA+Pj4+PiBIYXZpbmcgUE0gY29udHJvbCByZWdpc3Rl
ciBpcyBhbnl3YXkgbmVlZGVkIHRvIGRyaXZlIHRoZSBkZXZpY2UNCj4gcHJvcGVybHkuDQo+ID4+
Pj4gRXZlbiBhcyB5b3Ugc2FpZCwgdGhlIHJlc2V0IGJlaGF2aW9yIG9mIFBNIGluIHRoZSBjdXJy
ZW50IFFFTVUgY29kZQ0KPiA+Pj4+IGlzIGluY29ycmVjdCwgYW5kIGV2ZW4gaWYgaXQgaXMgbW9k
aWZpZWQsIGl0IGFsc28gY2Fubm90IGZpeCB0aGlzIHByb2JsZW0gd2l0aA0KPiBTMy4NCj4gPj4+
IFlvdSBtZWFudCBEMz8NCj4gPj4+DQo+ID4+Pj4gQmVjYXVzZSB0aGVyZSBpcyB0d2ljZSBkZXZp
Y2UgcmVzZXQgZHVyaW5nIHJlc3VtaW5nLg0KPiA+Pj4+IEZpcnN0IGlzIHdoZW4gd2UgdHJpZ2dl
ciBhIHJlc3VtZSBjb21tYW5kIHRvIHFlbXUsIHFlbXUgd2lsbCByZXNldA0KPiA+Pj4+IGRldmlj
ZShxZW11X3N5c3RlbV93YWtldXAtPiBxZW11X2RldmljZXNfcmVzZXQtPg0KPiA+Pj4+IHZpcnRp
b192Z2FfYmFzZV9yZXNldC0+IHZpcnRpb19ncHVfZ2xfcmVzZXQpLg0KPiA+Pj4gQSBkZXZpY2Ug
aW1wbGVtZW50YXRpb24gdGhhdCBzdXBwb3J0cyBQTSBzaG91bGQgbm90IHJlc2V0IHRoZSBkZXZp
Y2UuDQo+ID4+IFBsZWFzZSBmaXggaXQuDQo+ID4+IERvIHlvdSBtZWFuIHRoZSBkZXZpY2VzX3Jl
c2V0IGJlaGF2aW9yIG9mIHFlbXUgc2hvdWxkbid0IGhhcHBlbiB3aGVuDQo+ID4+IGEgZGV2aWNl
IGhhcyBQTSBjYXA/DQo+ID4gUmlnaHQuIERldmljZSByZXNldCBzaG91bGQgbm90IGhhcHBlbiBv
biBQTSBjYXBhYmxlIGRldmljZSB0aGF0IG9mZmVycw0KPiBub19zb2Z0X3Jlc2V0PT0xLg0KPiBC
dXQgY3VycmVudCBxZW11IGNvZGUsIG5vX3NvZnRfcmVzZXQ9PTAuDQo+IA0KU28gcGxlYXNlIGZp
eCB0aGUgcWVtdSB3aGVuIHlvdSBhcmUgYWRkaW5nIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHJlc3Rv
cmluZyB0aGUgZGV2aWNlIGNvbnRleHQgb24gUE0uDQoNCj4gPg0KPiA+PiBPciBqdXN0IHRoZSBz
dGF0ZSBvZiBQTSBjYXAgc2hvdWxkbid0IGJlIHJlc2V0Pw0KPiA+Pg0KPiA+Pj4NCj4gPj4+PiBB
ZnRlciB0aGUgZmlyc3QgdGltZSwgdGhlbiBzZWNvbmQgdGltZSBoYXBwZW5zIGluIGd1ZXN0IGtl
cm5lbCwNCj4gPj4+PiB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUtPiB2aXJ0aW9fcmVzZXRfZGV2aWNl
LiBCdXQgdGhlIFBNIHN0YXRlDQo+ID4+Pj4gY2hhbmdlcw0KPiA+Pj4+IChEMyB0bw0KPiA+Pj4+
IEQwKSBoYXBwZW5zIGJldHdlZW4gdGhvc2UgdHdvLCBzbyB0aGUgZGlzcGxheSByZXNvdXJjZXMg
d2lsbCBiZQ0KPiA+Pj4+IHN0aWxsIGRlc3Ryb3llZCBieSB0aGUgc2Vjb25kIHRpbWUgb2YgZGV2
aWNlIHJlc2V0Lg0KPiA+Pj4gVGhlIGRyaXZlciB0aGF0IHVuZGVyc3RhbmRzIHRoYXQgZGV2aWNl
IHN1cHBvcnRzIFBNLCB3aWxsIHNraXAgdGhlDQo+ID4+PiByZXNldA0KPiA+PiBzdGVwcy4NCj4g
Pj4gQnV0IGl0IGhhcHBlbnMgZm9yIG5vdy4NCj4gPiBUaGlzIHNob3VsZCBiZSBlbmhhbmNlZCBp
biB0aGUgZ3Vlc3QgZHJpdmVyLg0KPiA+DQo+ID4+IEluIGN1cnJlbnQgcWVtdSBjb2RlcywgdGhl
IGJpdCBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUIG9mDQo+ID4+IHZpcnRpby1wY2kgZGV2aWNl
cyBpc24ndCBzZXQsIGlzIGl0IGEgYnVnPyBJdCBtZWFucyB0aGUgbm9fc29mdF9yZXNldD09MC4N
Cj4gPj4NCj4gPiBJdCBzaG91bGQgYmUgc2V0IHdoZW4vaWYgdGhlIGRldmljZSBjYW4gc3RvcmUg
YW5kIHJlc3RvcmUgdGhlIGRldmljZSBjb250ZXh0DQo+IG9uIGQzLT5kMCB0cmFuc2l0aW9uLg0K
PiBJIGRvbid0IGtub3cgd2h5IGl0IGRvZXNuJ3QgYmUgc2V0IGluIGN1cnJlbnQgcWVtdSBjb2Rl
Lg0KTWF5IGJlIGJlY2F1c2UgUUVNVSBpcyBub3QgcmVzdG9yaW5nIHRoZSBjb250ZXh0IG9uIFBN
IGNvbW1hbmRzLg0KDQo+IFdoYXQgZG8geW91IG1lYW4gInRoZSBkZXZpY2UgY2FuIHN0b3JlIGFu
ZCByZXN0b3JlIHRoZSBkZXZpY2UgY29udGV4dCBvbg0KPiBkMy0+ZDAgdHJhbnNpdGlvbiI/IFRo
ZSByZWFsIHBoeXNpY2FsIGRldmljZSBvciB0aGUgc2ltdWxhdGVkIGRldmljZXMgb24gcWVtdQ0K
PiBzaWRlPw0KRG9lcyBub3QgbWF0dGVyLCB3aGljaGV2ZXIgaW1wbGVtZW50YXRpb24gb2YgZGV2
aWNlIGlzIGRvaW5nIHRoZSBQTSBzaG91bGQgc2V0IGl0Lg0KSW4geW91ciBjYXNlIGl0IGlzIHFl
bXUuDQoNCj4gSG93IGRvIEkgY29uZmlybSBpdD8NCklmIHlvdSBtZWFuICJJIiBtZWFucyBndWVz
dCBkcml2ZXIsIGl0IHdpbGwganVzdCB3b3JrIGFzIGxvbmcgYXMgaXQgcmVmZXJzIHRvIHRoZSBQ
TSBjYXBhYmlsaXRpZXMuDQoNCj4gDQo+ID4NCj4gPj4+IEhlbmNlIHRoZSAybmQgcmVzZXQgd2ls
bCBhbHNvIG5vdCBvY2N1ci4NCj4gPj4+IFRoZXJlZm9yZSwgZGV2aWNlIHN0YXRlIHdpbGwgYmUg
cmVzdG9yZWQuDQo+ID4+DQo+ID4+IC0tDQo+ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gSmlxaWFu
IENoZW4uDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IEppcWlhbiBDaGVuLg0K

