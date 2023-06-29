Return-Path: <virtio-dev-return-13163-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBB1EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:27:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7CAF17702B
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:27:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AC13986717
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:27:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5D7959866E7; Thu, 29 Jun 2023 21:27:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4602F986677;
	Thu, 29 Jun 2023 21:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePz8uFmJvsxnnNTD5WuAf5oqHp2xPnNhMoIxklJbff4wYEVdN9xOUpTaI1ynWx/XPG6K5L3Gg8BXztvnTVvYAqq+YXHR9jW4aABK+5yq/C1/ZkVGYBrZs5TqUzu7GZ3VPd5igs3znaVvAnvH/s9b40b06A8pZkoglR3X/bNwJmiMdEp194K7QteOs6cD1sDnVm0spsZX08YF3gPTZoPI5x2nHXKy6jdR2M1tq0cdrhBUW1wQOP3jo+b8YFJkH/szczqkMB7KIMbcqGZUihOAMRl1OlpgF3NHzlPsnSlMXD6epdwXsVeToBF57Juxfv5RV8CUjJyMayKWpmL+V6Bhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mjBnRyQGBC3FXrkuTApSnrZsgtSsTdgWQwIaA345a4=;
 b=KKLbq6mUkxZ1ng7yZP7QaOv2kCwQlcTQ1jkBhbsCDnmu2K34nrfXyhXUxizopU+J8UwyadSMpUnlYoFsw1TBRsTnhGxY0GZ0fR3APm0ZE/9ZbXEUtcgG+aapC6WUOOgocJmxZXplPCz0uutOEg2x6hLKbz5EbNr19+IRH1Q1woZ0HExF+8poGOMVLJ5EF6+rp5cgLyNt+v3oFWi7j8jEznt0jjDngLVzgJGUQV+q42hFhgN5IOMtC61cbUY2OWDM1ESOAtzybDRN5V2LwzxuDh8Swzd/3j50gr1Gg7whJcPid5yo5+I0TTApi5/6gy03pazXQFrynv3WugarpnM/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v7 0/4] admin: Introduce legacy registers access using AQ
Thread-Index: AQHZqTvq5aV3SrtNxUKKvKloelKxkq+iMOAAgAAdXnA=
Date: Thu, 29 Jun 2023 21:27:31 +0000
Message-ID:
 <PH0PR12MB54814278D417AD739CA118A2DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230629153826-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629153826-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: 33e61ed1-da24-448e-5aba-08db78e7a59d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 imZ6b7l205f673Z/R5DCSTkBbog7wAhJ+Zn1Ilrhi0KMF/I/o5pqqBRobzYgUfYDn82oTRxJsnDj4gxe0vRhmYNvi4R2JH//YEb/Fct8Jm6LpKPwK442P3omCrN3RFGfNHsEm+SS0fHs7a2Dm9UwySFqaT+H0sVDa/dpoVyeApu5LmT7wra/nHl3c2GQ9gQXJocSVa3xcG25KfKoK1McF/n3xS5Z8wxp956yDLFUzTolk221odOEVXYSWZvSAwu6Tjf3Qi9SE0XDkjd9TiXJY6YiA/1I8Lkd/N9XmFSE/rzYv4FixXxIxV7pipKsbPXhLxvLnhr6D7wtEu9jpl76uaTGuMwxytIxUwTN9IzNh7jP5mtj0WCSQ4cEiHmmMesLk923ZS8B2HfFrzVz5VIpEsuOkOAqpTUTSqJbR0mB1MZk7jSqJrqforu4gzMJ/TLPnUQab3AlUnP1M+85Y3Z376rjm+1xRWvbwrAzKnO1JNSMSlLOp7VS1Uqqetev91IWiEnYUGrs3ddKzctiiCu0dPhoPoCCn7h2/Kl3SZ1hd9h5pzjYQSxJNPr4lniFFEq3Ue1BIzuYJY4Zk+hYgaDxEMKpJLSoEU2ldviRIN+Yea8GjgrnOGKzik7cX2xcpOIq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(4326008)(66476007)(66556008)(38070700005)(107886003)(6506007)(478600001)(7696005)(54906003)(71200400001)(26005)(186003)(9686003)(2906002)(4744005)(66946007)(76116006)(5660300002)(52536014)(8676002)(55016003)(38100700002)(64756008)(33656002)(6916009)(86362001)(122000001)(8936002)(41300700001)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjdYd2ZtQjdlajFoVXVVZUlnMnJIRmt4ZCtnZXhXNk8zNkxuTU5mL3JnTXpQ?=
 =?utf-8?B?T0FMUSswS3JtTDNMbzVHempTdlZmdlFuaERoeEgvdlp0cVNQMjNiWWhST1pk?=
 =?utf-8?B?aEd5RDhzSW9RMXNVc3lFMmtXN3R0cWNpbCtHUkZIUm9Wc2t0Vk1zWEdOT2JF?=
 =?utf-8?B?YUhEMVpMV2dyaGljemFrdVBFcUFDcDIvd21NcElLZ0p3aytnWnIwV3U5aVN5?=
 =?utf-8?B?U2s1aUZESzdHdFJKZUMycDh5cHBqVWJYNmlLR2krSGFZLzhnQ0twZk1YaCsr?=
 =?utf-8?B?ZDZMMHBUbGdVa1lKemVWZzZNdTB6dnNJbnR1aGQwcC94czVnR1VYSTl3YVA4?=
 =?utf-8?B?Nk9HVys4RzYyME14aTlHL24zRW1HOS9POWJyc1dZdEg1UXcxZnRXQnpKRGVN?=
 =?utf-8?B?RTFBU2gwbXdGb0xwSEZKK0lFZXVWQzY5TThzTmdPK0xFemIrRTJZczUyR05z?=
 =?utf-8?B?ZGtiVm5YMzV1SG5pemhlUHgxMUd4ZFJuZkFnQzNCT3ovc3FFMW1WcW1sazJj?=
 =?utf-8?B?QVZDWkoyUHNvV0dkSmVVbngwMDAremxxTDlYTnJVS29zWXFaRXFzbEFpUlFh?=
 =?utf-8?B?alRRVGMwQXY1Q0lTdDRKT0JhSXpQR3NVMFI2dmJtN1E1WXZndnduaWs5YmtG?=
 =?utf-8?B?UUJ2Q1h3emFlSTIxVnFSejZTT3lrVnRicEs1TUxXMlVUMVlOYUsrTFFleTJU?=
 =?utf-8?B?VmNpMUN2bWRSVC82SStLU1k4cTM3eTkyK3FBNyszWWlTQlZ0cVZJc0hleUNE?=
 =?utf-8?B?UG50cmltTWlpOVErTnRhSE1lbGtzbHZLTHFjVjUvclhTWmU0Ukd5SW1UbkJV?=
 =?utf-8?B?ZDkzTldlQURrS2Y5TzBBaTRhWTBzeThIdkZmNXhuY2x2U0IvTnQ3Y0Jqa1Fn?=
 =?utf-8?B?UGowRTJSUnNqSjA0dkF3S00xbWlTRGNLR3hPT2t3SmE4emZaKzROa0c1MlV5?=
 =?utf-8?B?RTFnU2lHVVl3RzVGNUFVaFdlNFVLcnlmZ2MwSTBNMEE2RmhYS0l6eHl4Q3Bn?=
 =?utf-8?B?Mi8zYW85MmJEa3NPUWt3L2tqaDUzT2tDa1V1R1JacFhuUTJ3UW9BOUZmd2xC?=
 =?utf-8?B?TGJESmwzRHBOQlNVVnlVOVZNUFoxQXBtRlVWa2xjeE9FQkJCZEZpeWplN2lu?=
 =?utf-8?B?N0VZcmt0UDRIb3ZLeWZoa3doUnYxYUdVa3ZQUzh0N2tQdnY3MWU1ZSszbWh1?=
 =?utf-8?B?YkFrcjY3RHNRVG5PamsvUEFxVCthUDUxNzFvSG9ML3Y4OTQ3KzFQdVd3MHpB?=
 =?utf-8?B?RSt0aVowaTRyZkFOY2F0TDh4WHdHbWxpbUZhdis5MFRaSWJKRHJlODg1RXoz?=
 =?utf-8?B?ZVZOWlVpaDB0VkRHSVVQdFY2UCtIc1pmZUVqSHJ3RlE2dXFDcUh1TXlWZExJ?=
 =?utf-8?B?d1IwWFA3YXh0ZDZCaENncWZGSmg0ZHJ1QWhpQVE4bVMvUkw2cjFDaTZ3ZmNu?=
 =?utf-8?B?dGltVGY3cm1tekhBVllRRUNMaHIyRnhpZk9qMnNDNTNyU2VBcHBQbVFGQmMv?=
 =?utf-8?B?Y0xMMUlQUVhaaktNNy92VW9CV2RWVGRobVpEVE03SXFDY0dvbDlzRjlYY3lZ?=
 =?utf-8?B?ODdQTWlJTkpHaC9IUjdJRXl1MEg5R1IxdGNGR1hMdnREdFhOSjZwdHY4UVZO?=
 =?utf-8?B?WStMZThZWnprUU8yOTVMbWpZakVrNFFZS3VHbnluTk5xT28wTjVyWG1CRC9i?=
 =?utf-8?B?a0N1Q1RrY1dXSDRLbG1USE9Fa2FZZVI0b1JVVTBoR29vaStmeG82cnU0SFAx?=
 =?utf-8?B?TU1WQklTTDBKY0RIMys0Q3NNMlQxWDBrVEt1ZExwN0s1MFM0djNDQzMrQ2ox?=
 =?utf-8?B?UVg3Q2JDSCtGY0FQVzdiTDFXalB3VncxNjBlS2lQbW9aOVhaK1k4OVdhMjVW?=
 =?utf-8?B?UVpRQkg4YmVDekRtb1VieEVwRkU2Q3daemR4YWtRQ2VlbW5vT1hlWWpRemxD?=
 =?utf-8?B?RXhQWGNIYXF4OXY4dm1CVm5jTTNzTVdhdTZLd1BpbGJCcytRYk5ubUtZMEJl?=
 =?utf-8?B?RWFCY09jU3FBN2lGL056RU1EclFZdzF5eGpOYjNVcFdoYkZtZDRSWEprb3Er?=
 =?utf-8?B?dWVUQUhuaTFUY2xqK2g5UkVFaUl0c3JIeHVzbWJ3VWNHc1IvNTNrL0F6T216?=
 =?utf-8?Q?TD8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e61ed1-da24-448e-5aba-08db78e7a59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:27:31.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvk9RqWhUhOw2sE/1Bhnyl/Pj2NGCe6OKHGH5+76dj9HfNPkwQVrDYO58zQGfemFe96naHx9wORFj1N9XfxlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
Subject: [virtio-dev] RE: [PATCH v7 0/4] admin: Introduce legacy registers access using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdW5lIDI5LCAyMDIzIDM6NDEgUE0NCg0KPiBXZW50IG92ZXIgdGhpcyBxdWlja2x5
IGFuZCBJIHRoaW5rIHRoaXMgaXMgb2sgZnJvbSBmdW5jdGlvbmFsaXR5IHBlcnNwZWN0aXZlLg0K
PiBVbmZvcnR1bmF0ZWx5IG5lZWRzIGEgYml0IG1vcmUgd29yayBvbiBsYW5ndWFnZSBjbGFyaXR5
LCBncmFtbWFyIGV0YyA6KCBNeQ0KPiBlc3RpbWF0ZSB3b3VsZCBiZSBhbm90aGVyIHdlZWsgdG8g
ZmluYWxpemUuDQoNCk9rLiB0aGFua3MgYSBsb3QuDQpJIHdpbGwgZml4IGN1cnJlbnQgYWxyZWFk
eSBwb3N0ZWQgY29tbWVudHMgdG9kYXkgc28gdGhhdCByZXN0IGNhbiBiZSByZWZpbmVkIGluIHY5
Lg0K

